Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A56C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 08:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BABAA64F0A
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 08:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABAA64F0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C48B6EA05;
	Thu,  4 Mar 2021 08:41:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 642FA6EA05
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 08:41:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeyD3BIIYp4QSUWp6Y1KWqKpCGXxWqR9eTvLjxJ9z/Z3EaJ0XYr5DzsOIFDQ6adGs/i5u3CjWqvRc50bspsFpGPHPUDBRBjYThp21tMC64i0sffLeWRtAb/nS6EZrvdTwZWR8JbqEfBg1FLQnBLjj8MkkD54igOvIR6Nc2uBuTtwRMTJdG5fyZPSpCAS2TsEUSEj5GQVitHRYNNG4QRrFPoYQssdP9D0ACw4y23A+8CH/0hVQif8sSHi6mM/JuXm6B/t+M1W7fuWD8fylBOfEOBeIwH3jzpOdlk3aepFa0IFtgfInkAEzx1pEcBafSKmAynEuwQLQLoXFcpGw+EXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75QwgUw1LORzJd9C4zOgXAO4OAntT6ScD+aSPmhNdxw=;
 b=OKyGGW3kqGxkd2WgHC63NVpd/GKkfAsGqYQYO4a2DHNFe06hYGL/ztp6gtq3HVb1sViQpbQsYBajqX/UKXGKQetIAbejhwkHdsht/V4RmzFOyibZAwx6XgRmLfsxM2G7UF4PfhqykE6W7y+MHVIfhOXMcfwpBqQadWnJmStEYvOzInBzfl5MxoyUedaPQtqNlPt0w85E5W0Ygva40LT+F+GSo74JH6ecxI/8VKdBw/gAQrvXsJD+m9bxf/PH3jNTykWzSEmb1VqvnxN+AaYX/cZ9ZC2UT3kUoWU2NcCxzaUlIsLuflBm0v0FPqQ/qdaWalMDTd6L8PySwYg0wGzw2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75QwgUw1LORzJd9C4zOgXAO4OAntT6ScD+aSPmhNdxw=;
 b=pi7ca5SUvg/aba7QrJi+X2kTVkSfjqA62F7xTRzq+pJhVbX1V2oHRt5e/cO+YMRLszz5sEG3K9mtRlop7J+NXp/WjJobaZmAOrvnUpc4k3IHh5SNuNsTFgQvLcKv1S60CBYTC9+gz3bzmcTrUgqsX4T1w5UomPvsq8oVTvHGjjM=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26; Thu, 4 Mar
 2021 08:41:13 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70%6]) with mapi id 15.20.3890.028; Thu, 4 Mar 2021
 08:41:13 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>, 
 Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: soc15 pcie gen4 support
Thread-Topic: [PATCH] drm/amdgpu: soc15 pcie gen4 support
Thread-Index: AQHXEKkGRdqVwrKjB0yzOlBQfWwLDKpzM8GAgAA81gCAAACmgIAAEJLA
Date: Thu, 4 Mar 2021 08:41:13 +0000
Message-ID: <DM6PR12MB46032411467875C427C11A45FE979@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <20210304034644.37610-1-Feifei.Xu@amd.com>
 <CADnq5_PaR5pwTHFoOO_2-wKjWPLX=+LS0z34ns3axA1ZP2RUFw@mail.gmail.com>
 <CY4PR12MB1287AB27465A9332D7838355F1979@CY4PR12MB1287.namprd12.prod.outlook.com>
 <MN2PR12MB4549B081A7E302B799AD828C97979@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4549B081A7E302B799AD828C97979@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-04T07:37:48Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=17cec9eb-19fd-4334-8c57-c409772459d3;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1de9623-6c49-4f46-a24b-08d8dee944ee
x-ms-traffictypediagnostic: DM6PR12MB4748:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB474816DD7DA5A0177F7BB76CFE979@DM6PR12MB4748.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4XXcSImW4PUMdExXTvSalDM8M25r562YuFgywETkA1xXZw/4b56F8EfA4qPh5BhiAibOqZoMPB62hH+uoJzqKxFspYShmlTZJHMKTBGPD0wT+schTxQEWIfbhD7aUviuN9nSkYtgnsZoMh4KM3E4ZxZi5WEZ9MoeD135gIyoY1Xts/5OAwNPr5QNCjS2RF8smLOR8kIb6AF1jVZw+/ZrsPewYnIzk/cKo1ASZa50nr+Q2KR4ZMvU2u1mx1lW3rp8oxfCdPQX8LCammIdmpa6bWJ0zp0StB2haNrFV0eVj/TBX8FBrGjuWMSMjkjDQT/wOO1v9RxqT5uQQRpjz72nwrt5BlFAHeVPWoli547EJqcksBgSPsJ3DMoD7SuvZddiCIvJTcafT6HisNk7ZiRu607q5QlyEeYJa1ds/2zKTGfoRcina8jJ5kSYENJXQtFh/3zk8KH+FjIDXaAYBQNqPlbm1As6VBkuZTL9pca6bJYiHBWk4BdsP1h8JFTIBUDsETxV0g2qhgI4/zPwCu8O4ZgXT9B2n0kCs4e4QIYkJQMhvKsBGxqmAh/YyccHsLcZH2LN6A57I2RCBAQJiOOT7RPsVLoHW6JHQiTvB+12vYc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(316002)(66446008)(4326008)(53546011)(71200400001)(64756008)(54906003)(66946007)(66556008)(66476007)(5660300002)(7696005)(6506007)(33656002)(110136005)(186003)(45080400002)(2906002)(55016002)(9686003)(52536014)(478600001)(966005)(26005)(86362001)(76116006)(83380400001)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BArepOpMztGOWRi5Bx37yEo5u4CJHqBUZ+ztvdTa+bUPxEipT+q/Ku7x4wVn?=
 =?us-ascii?Q?HmnJML5ryB2tdGdpXeTMSynP9pNVfxUVvYvyHvqCrSTEZq/XSzWNkAV3Mm7z?=
 =?us-ascii?Q?KVFPQoZ3rUB078bF+Yw32I8ksJpW0Q9Hr81s9yurS3Dai12mIwwFyqFV2e0D?=
 =?us-ascii?Q?Pt1sq2Kse3Y3N9YjJlhWpUwvsd4x7P4xHIUl6Ll6tt25leLMX6wwiQ2cV6XL?=
 =?us-ascii?Q?amrED0+nOhgWHZD20zhriDlfm5obi35NdxIWdoi2jdGXqf28Drw23lFpkdrm?=
 =?us-ascii?Q?KwwMT9/LHigVqeNE8skcNSrvKgOgq8uZ+QFnI/X5wiAFDuU6a0IxSLRIUIQ6?=
 =?us-ascii?Q?kp3NrYn5iEq3dpJYeg2oRSSF7pVQ+/f8neZ6C9J+hafaIbcPVpmocJ5XpxWa?=
 =?us-ascii?Q?aNAmSEfBPBP8FE76EUyD4GlNY5WX78w1J21FGC92xomHURg9sVcqccYjJk0z?=
 =?us-ascii?Q?QJc188C1bMaThb7lFsxCRPDM1YlmuSzTAZfNQT/t5UR3BChZ4rweRoZq4Rcq?=
 =?us-ascii?Q?gp2v1uxFzV4pRQZf7T8Jd5D2bitYZiO5uemb8CCsHhZOAVFBUB95pvKsoj6m?=
 =?us-ascii?Q?Pe3eFOh4+J7FQ/A6knDOW0IB0fMO1xqG3G8POBrZTHq75sRWcAyW6xUltdFB?=
 =?us-ascii?Q?RuMsC01N6cA+4R6qbnFM6ikfnBK2xPpQETu/BZZRsEC7PyJghBcjiOkuW77x?=
 =?us-ascii?Q?GvETni9K5a9CAajCsQ+f04fW80+zVXN434MrEu1WVVcLJKlA5oh+aI1zk4xz?=
 =?us-ascii?Q?j1EOijgyyCPQsfoTQSzP6P43z2EvhUIZIAf4bowta5hherGA1shcMP+wChDs?=
 =?us-ascii?Q?pgb/VILcsa9e/0dK1aR7o2rTaYwFDkhW4f9YACKm2HqsOUuSHcfefXYb9B/2?=
 =?us-ascii?Q?GkhF6fdiy6f8x4iDPNEz8/rzi2UVNo8JpufmDusJTO5z6NOeF6IbxPgZM61o?=
 =?us-ascii?Q?GhDfNTIz+meGq4Frqfkjjxe33krvvKID8uwDhw7WKLPa/qUXTLIQDSmeZAos?=
 =?us-ascii?Q?PwD+u+sQYi/quSsKssti9axBDOGTQ6/SIKRGB5sCQ8ps2BTSLH7WdV5hDo1B?=
 =?us-ascii?Q?dj9CN7fX6V8O/ar3wPS6Kp2ixwmm82E4HzCqAlw3TCvskIXlOe66EXvR6Jly?=
 =?us-ascii?Q?fl4eRHb5Fbd0E6JKMwANIAoGNH+N/Ya+PpGqKJHcn6FWceS5uVRCHgWMAJ2w?=
 =?us-ascii?Q?2X7OPXoRsu15QbBoHiLr+qy1+UbKN71QJnodPGjaQVb+xfFa1drrcMEiRWx8?=
 =?us-ascii?Q?9B0khFbDB1MR+/6MPoJqh2N2yElvkYul8Sq0pVvPhyFEYz/gwLF5HLW+bl5H?=
 =?us-ascii?Q?wivQM1FOoVvQy2TRCVEejNc6?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1de9623-6c49-4f46-a24b-08d8dee944ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 08:41:13.7461 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F9zL/rDSxMUZunlYD+voaQb8hl14aRDpSD+ZwhCgD+gHSZqiZZVeDqnNDv5B9IT8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4748
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yes, seems un-necessary in current implementation.
 
Thanks,
Feifei

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com> 
Sent: Thursday, March 4, 2021 3:38 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Xu, Feifei <Feifei.Xu@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: soc15 pcie gen4 support

[AMD Public Use]

This function is doing nothing, is it necessary to maintain it? Not sure, if pcie gen support needs to be enabled specifically in driver.

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen, Guchun
Sent: Thursday, March 4, 2021 1:06 PM
To: Alex Deucher <alexdeucher@gmail.com>; Xu, Feifei <Feifei.Xu@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: soc15 pcie gen4 support

[AMD Public Use]

How about module parameter check amdgpu_pcie_gen2 in soc15_pcie_gen4_enable? Is it necessary to modify it as well?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, March 4, 2021 11:58 AM
To: Xu, Feifei <Feifei.Xu@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: soc15 pcie gen4 support

On Wed, Mar 3, 2021 at 10:46 PM Feifei Xu <Feifei.Xu@amd.com> wrote:
>
> Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c 
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 28b991904eaa..437cdc56bdc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -569,7 +569,7 @@ static int soc15_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
>         return 0;
>  }
>
> -static void soc15_pcie_gen3_enable(struct amdgpu_device *adev)
> +static void soc15_pcie_gen4_enable(struct amdgpu_device *adev)
>  {
>         if (pci_is_root_bus(adev->pdev->bus))
>                 return;
> @@ -581,7 +581,8 @@ static void soc15_pcie_gen3_enable(struct amdgpu_device *adev)
>                 return;
>
>         if (!(adev->pm.pcie_gen_mask & (CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2 |
> -                                       CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)))
> +                                       CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3 |
> +                                       
> + CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)))
>                 return;
>
>         /* todo */
> @@ -1374,8 +1375,8 @@ static int soc15_common_hw_init(void *handle)  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
> -       /* enable pcie gen2/3 link */
> -       soc15_pcie_gen3_enable(adev);
> +       /* enable pcie gen2/3/4 link */
> +       soc15_pcie_gen4_enable(adev);
>         /* enable aspm */
>         soc15_program_aspm(adev);
>         /* setup nbio registers */
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cgu
> chun.chen%40amd.com%7Ca2af451ebb4b43bcc27b08d8dec1b4b5%7C3dd8961fe4884
> e608e11a82d994e183d%7C0%7C0%7C637504270832366776%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C1000&amp;sdata=jaNGe06yp8RXKQxMm%2F%2FdR%2F6DMC4h8viG3KUW3Sz2s7Y%3D&
> amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C8f330aec736c4dfe8b3d08d8dee01c35%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637504401425290833%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=9r5B6ckebE7FSvUHnZPKplh5c7fDMiK57U2RPnYSeM0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C8f330aec736c4dfe8b3d08d8dee01c35%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637504401425290833%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=9r5B6ckebE7FSvUHnZPKplh5c7fDMiK57U2RPnYSeM0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
