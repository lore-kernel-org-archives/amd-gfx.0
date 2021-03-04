Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C664DC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 07:35:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73BAE64EF9
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 07:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BAE64EF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE6416E972;
	Thu,  4 Mar 2021 07:35:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E22386E972
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 07:35:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4TXIT0730t0pqsOr9K5H5YyAiryGcKgNpfVPn/n9op+tqtoJ64ma0LnKjil+pKx31JjUxo6eKRj4xZykIiC0z00ewXJVOTHzt/eEX/vgcUAaSiv5xv1GQh3vY3vUJS1GtSFx7C7Oxj4VgGEW9Mt5QA5GsEumtEwaTZdo1DpxtAyShcwZxfLlxXw82cQ6jtZRsbt+WBjdKAgJqpkRP6sNrKT8dnACCnFgaUeXfDH7hioHu+yqSATX2mWVkZ1KQ5XfeSW+rHJ6He2o6PfmaxjK1qj/lyYv4EsIl5NrZpn513vg4wEOyjW91CGr35r6BkYlxwfOSpBJ7L68Qlp8rgVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAS4vUgk2IPWeuhftsjv09ndmNAMjgU3/5MmPcjcf1c=;
 b=SNh83od6ez7fB2gnB8IIacHC8QPYsqyuQzdzELVU0M71yX/j9KkuaLdEGFo/NaSvFlyb5OqKi5oO1er9uwb81rgYLCjDu8I6fyjIiDOb71EDQlcNJuu84irfiFxYUj/Upv6lM8iJs3SikUlCUPoa3E2PpctxSxoDp2oTemOF5Wqrwu9e/pcp/Us6ZqEVZbLNDTwHQUTwvd2Fp9OQYoMz9UqlLFC5QLE6f6Z8r6bvq5WKL2TSvhVQUiQFhBeF4OQs7WqDA7Cg3XQkgCoMv1trFU9jLEPf2F0IGkNA9pRZU3BZgpj6Kn80EvJlU64qjWolNqyNln5HUSlHaUb1GSM8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAS4vUgk2IPWeuhftsjv09ndmNAMjgU3/5MmPcjcf1c=;
 b=431BldEp4FWLkN17NU1y1omU2vh1YSkX7vf8rG1Varx/xkzPLoUyo9wX91sN27d88wWWER5zwDGtfvVmY3C7ixm0qDq5MbW6GTn4+s8G7WNiiShzj5zlT+8quHUr4UN1/Mc2trMhBaf9/o5WV6zW7Zg4XawvlhQHo73sSw4yw3Y=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1653.namprd12.prod.outlook.com (2603:10b6:910:f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Thu, 4 Mar
 2021 07:35:33 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3890.031; Thu, 4 Mar 2021
 07:35:32 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Xu, Feifei" <Feifei.Xu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: soc15 pcie gen4 support
Thread-Topic: [PATCH] drm/amdgpu: soc15 pcie gen4 support
Thread-Index: AQHXEKkH6hBNY8ZQok2bT4b8xtegS6pzM8GAgAA8JLA=
Date: Thu, 4 Mar 2021 07:35:32 +0000
Message-ID: <CY4PR12MB1287AB27465A9332D7838355F1979@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210304034644.37610-1-Feifei.Xu@amd.com>
 <CADnq5_PaR5pwTHFoOO_2-wKjWPLX=+LS0z34ns3axA1ZP2RUFw@mail.gmail.com>
In-Reply-To: <CADnq5_PaR5pwTHFoOO_2-wKjWPLX=+LS0z34ns3axA1ZP2RUFw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-04T07:35:30Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=17cec9eb-19fd-4334-8c57-c409772459d3;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a271aee1-07fa-4f4f-09ce-08d8dee017f3
x-ms-traffictypediagnostic: CY4PR12MB1653:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB16530045ADEFFA966D81F0E8F1979@CY4PR12MB1653.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ls/TKzGuHbaCbIU0f1y9S5rvNBVCNfWtDyNAS8Cfc5xPtQG8AB7warkRi5OB/x5IQIkr/KKdXEFjfvovl/PDCtEU+hXY3rwDdWr9vvS/7OUVV++WLBUqWu8Ft2oCkomCO3NVUzAp5DN//yBCNRvTOQCameaQ7AqQ4DEm/j3sPGl1ra5LKgGoqChEaJDOVq0GSeu7tqWm0UC46ZJH2ksFK2Cb+zZIXKQYPUUUQR3YOI1kxTpiljMZRRamIx1lwRtvju+7qVQ7pMXjaAyl22ppU3djZjyUSFfvLkJ2kSn8ArUS+ZUHD8/mQeBKaov0vrhSACR7Vah/Xvq2i8NQjzdMZ55N0wn7Y9G6BtsvKsFQmT6VEgcbPIoIkqlrgIoct0xtUOjolSiGFuJfTf/xVy8DqcQJ0ECzUkdA7KzIh18U5v2A23Jph7NzTJSpCoylmAKu+ZKOxngeu6jjKXwmr7feNYM6ixIexVuD7lffdmGhdzhWyfYCBjnuylwBSVWEZyepqJBRCRx4WgIHOYJG5a9nXwy1b6lOaq0V4I4R2eu8qs7gKi2um2bAWtJR1obTjELadLt3p57m1+ZtlgUMxC9hxK3AqNVu5ZvTDYImf4oJEHM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(53546011)(7696005)(5660300002)(71200400001)(8676002)(76116006)(83380400001)(9686003)(6506007)(54906003)(110136005)(86362001)(66556008)(2906002)(316002)(66446008)(66476007)(64756008)(66946007)(966005)(33656002)(4326008)(8936002)(26005)(52536014)(186003)(6636002)(55016002)(45080400002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BvODrwigelFZeBp1ydUqw5xLR5ydQ5u4aHlVRliOUN3EnzYgz0JwPULt7Klb?=
 =?us-ascii?Q?IytvB6+3JoRE2/bD/agE1XHtmYDi8zEH69oQro2hfqiV1ZhY1Rd0DpWoNEy8?=
 =?us-ascii?Q?UnANhoXL9J3tQ3kirM4nMDyf8AvJhX8VKAx0IqgZTtYh8HJnkOgBcEPEZN3O?=
 =?us-ascii?Q?aC3BUU8oBLt+QWIV9W0Dei3KPmRjBn/KYlkfbvv3YrWgmsHyt7eg73f88Dsh?=
 =?us-ascii?Q?zam/dvOh+Dj8r4+uII6zPulDLHMQ5rQ8bJPv8PZPGUtO9FCvKCn37FYB2ioE?=
 =?us-ascii?Q?ecGe7EB19cPF/dL5OMFZkMloht0qndmPFIsMfMfhMX7fLuD9v/86jQMFW9h4?=
 =?us-ascii?Q?k/hHe/S3upUnKZrHeyKznk4L3ufA7lTyBQZtA8T1dDuMH2kq2vviVDap2E/p?=
 =?us-ascii?Q?eRfcE9n4MJ6kjsnY7J9peOGUU0N4QLDHb1L65hiy6aKI7TXSHYNexXJ6TXz4?=
 =?us-ascii?Q?kNGlNhbkOaLRuy0y7Z3uxG1rtfdgZDIwIQw/TJX4iY/+10dlrt/VaES2HUo3?=
 =?us-ascii?Q?Ysh7U8DZEjMJnaN7MnLOkgCBXE3SHGtNAdAvS/FkmUkiwMl8Cb9Y0le16yJS?=
 =?us-ascii?Q?NTirLpYuJmNOvPFOKiLGpVrJdFeUfGti8U2DiBzf1tj+vHSRBCz+gx3bV934?=
 =?us-ascii?Q?v303q/E98VEgtbYfraehLPmPO4K8SVOgKnYHve8dXpCGSzK7zDRQhpaq1obc?=
 =?us-ascii?Q?MmN1NW+PnkWF2EbLquwHuCOt8nxyc3DmMQ8QVhuJJwPrSBMaqYxNBvf1/eQK?=
 =?us-ascii?Q?HAxt1yiPZWdV1+R/PXhq2s3sCr3HWyjtAe1yKkaqzf8k+K2xu2be4Ino2vQz?=
 =?us-ascii?Q?knWId+nVi0jdz8vtziIhkQReU+MxYzZoFXh5bI7vIuWFvaK8jABmBI0mmJjQ?=
 =?us-ascii?Q?kutX+eIsLiKF/uZGn69wVtH1FETgdYwj1uSxu0i2hI1eInaNHahkzj387ogH?=
 =?us-ascii?Q?N6UFGVHjNOmd154vUxjAKSx9jxWzcumn/nvpZXmBlwAYkHa6TBRT9KV7k5+7?=
 =?us-ascii?Q?6D0QDtn+HF8IPgFezsPXXii0T/uhihCw0KEBtz67DUSbLvrJZXp8jEt/DbYl?=
 =?us-ascii?Q?tY5WFaNN9TG+LlBcn0HEBCEOo/KMxfoW3k0xhMOcDaHtwFp4Lm/Zq+sN0i41?=
 =?us-ascii?Q?/jOITm5cGee6f65YfFAlFx6ahyTZ/+RyzStKkRvFIDsW5sy8mrTdTnisdwez?=
 =?us-ascii?Q?HGE09binV8a0c8o1EARU8qSioI0f4VnSwYMzCK4d2PWzgJuSH6V+rjejWxOn?=
 =?us-ascii?Q?IuuMiWX6ColB2ODOwsXrqElDolBCgHiC1uyeFZ+gM9oK5/ytJ638CoLG5TWt?=
 =?us-ascii?Q?gMV7Ux7VoFPi12Z7/dNBPRf5?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a271aee1-07fa-4f4f-09ce-08d8dee017f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 07:35:32.7440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/JaG68bsPHwIgIumuscyRc/xCed78wH2XxQjVlcfAIOUXVQroIlxpgpgXcFWeswadHMYOZ517+5MjkKR1g09A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1653
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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Ca2af451ebb4b43bcc27b08d8dec1b4b5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637504270832366776%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=jaNGe06yp8RXKQxMm%2F%2FdR%2F6DMC4h8viG3KUW3Sz2s7Y%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
