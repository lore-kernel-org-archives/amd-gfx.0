Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D637C07E95
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 15:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5AD561370
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 15:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5AD561370
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AA7F89198;
	Mon, 19 Jul 2021 15:48:19 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21A6089198
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 15:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNT1p57gJAGqrn1b3NrDr3ga+h791VnTyWtYl5Ql5rAFGGHKWYv2TTweoeoYotvYJL29qCoFFhc6z7XGK8M+/zj6FCykgWWP+om3JWnqiQrFW1nzR0LVrHxKadrhoQDkdh4Iu7YmqB96tXob0Ck30bvIbBcINaUpvmkfzrzNyI/kco53xPZTVlop3nXbfmLujbCSlfq174oYuDsC2ZlGy6u+eEqVveWPeHpj0lHH5HoKMDS7Pn7HKvkVVdx3iHRSfQ+ogel0mdzIq5QF6fw0o2ZehWXt1MzdReiloK3DP96Lv3y34+byYD7Qx+R0jryTEHYqbeFGQ6+gs12vDuywXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWhKDxrhjMWcr68LAZflrcTh3VgKfSOoFGT7AKT6Ekc=;
 b=S1PPbQWwuP36wYa6Q3FN0blTuaK2i9rjDCisEdKvT4fCyrQisrRQzN3sGcM6VO+0e36UAB9DDyG6AfFeK91mrt5sW+pEGWY6aavGbrkp4fApAS7E4iw7cf/9d7m+5zFtynPoxPkIKOdy2jrgwaO0UnMUMu85DaHY7sCK5RIOEFQTkgZkQma4dkxrBqI1gKJAcM544e+1Q2rHwg0l8dwv07NY06jR9uoSRBbGFvn0DBCbduESRySgzAgGrtEhZ/i8AU5YDYXXVZbz5Knyx7VEuTRUWTqoSswYCLl7IHZHOgQFJVo9lbtsYx9FJiK6IqXM4gxCI87EGbb502SqWckgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWhKDxrhjMWcr68LAZflrcTh3VgKfSOoFGT7AKT6Ekc=;
 b=UTSwMQGYf3cVW78ZuuKuDowaWufz5xZCgykyiT8ISXM+m/wj99EcjQQVqpDplUprrJpvMgjqDAxrVXSUuUL/hJDGLj2hlZoKLTCrSfA5w3ZehRHkdy6N1q2i7h8XS6Kkklb8o2l46qV7LvJ09DocCqofyyi01B8kHUHmFcHPsCM=
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.26; Mon, 19 Jul 2021 15:48:16 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::1d06:dcde:55f9:3eb7]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::1d06:dcde:55f9:3eb7%7]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 15:48:16 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdkfd: report pcie bandwidth to the kfd
Thread-Topic: [PATCH 3/3] drm/amdkfd: report pcie bandwidth to the kfd
Thread-Index: AQHXemGzeTVUENNxH0iHkpf4plOXxKtGpsMAgAPOglA=
Date: Mon, 19 Jul 2021 15:48:16 +0000
Message-ID: <DM5PR12MB4680555CB22D897DB6F66D6085E19@DM5PR12MB4680.namprd12.prod.outlook.com>
References: <20210716164312.896939-1-jonathan.kim@amd.com>
 <20210716164312.896939-3-jonathan.kim@amd.com>
 <5c495819-ee12-9267-13d3-4b07e8a27e11@amd.com>
In-Reply-To: <5c495819-ee12-9267-13d3-4b07e8a27e11@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=75cc8936-9c40-419a-b4e4-68486dba8792;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-19T15:44:53Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a5c2296-72f4-4f59-fc04-08d94acc9ffb
x-ms-traffictypediagnostic: DM6PR12MB4043:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB40439C0DD4B5E2DDF3C625C885E19@DM6PR12MB4043.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GwLk75+3W7QOth6xkcTmnDls0JKtpTt5kmOlA1y/1VmHE33/Vj92PrbqAd5PoGwjULRlUoReAXYJcg0sfVokCpNhgqPfI3aZyyv3z7HDMXfKHH03Sjqout4DHbs5YdsXBGTOnewG/VqZfel0sgJvWRjZ0OqFwP7inYQXu4qPSFC3JgS208zvtCqIpL5nZuKofgTLw8w3CwIiz1LBK8QnBQkdaktODwX4qQvRWm/1jiJJESEymOyKOItJ5ldXChxoZ7/1GooJV3X4KIc4fACPIXU52T2ap4cs0WEOIi8HWxbvtXt41pKlj1sp1qugt5mj56XC754/fuPaXuI7R7sK9AXGxRRpyC+TxFxr1sb7jNeERdbMoUu3LMp8g9YmTE31k5nX8axbGhXD/A/NcAhZoR00F19p0VCF8RgqBaCF25K/8npnEDgNSFH2mGX9dWR8IQj1qAwJpvQ0VEKNt7eWcezLSQdJ4QXFbbSD08vrtEZhg9ZrMCBOlJqmeee0HKaRpkZCF7h8tZNeH8vuJCaSuTnN38+riViNOwGoWy2IIHKLGtU7VnfYO2+Q5tXhBXr2KoLgb8EzN9ljr5W4hXeOuRMRq8EhDQk42/+LhyEaIEGkckVkbp3sGIy0RgE3FPWtithmYl07KKlXW0c4SvxwAvJH3l+wUBLoTU4WnSPJ8hClwguLR3FoDntrX59JDu0lI3rYEbCSg7uK8o3daniSpg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(33656002)(53546011)(6506007)(38100700002)(316002)(55016002)(83380400001)(9686003)(86362001)(186003)(122000001)(7696005)(64756008)(5660300002)(66556008)(66446008)(8936002)(478600001)(76116006)(8676002)(66476007)(2906002)(52536014)(110136005)(66946007)(71200400001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2ZLb3RDYUFrL0RLLzRaSG5Yd2NFT3pXNGVLSUFvV1hNODd6QXVKUkNkZElQ?=
 =?utf-8?B?bExLc3UzSC9OMVU3THZENVpvZ3VMM1RZd2R0RTBMeENpOHlVMEZHeG5ESnlm?=
 =?utf-8?B?aG9CRFgyTjl6cnRUYThBOGNldWhpVjhKNVlLSVA3MEVYUW4vclpGVGVzZ3V5?=
 =?utf-8?B?eWE1WnRURjEwWFY4Rm1DTHZRaW84TFZFTjF3R3F6V2d6V0drZlR4NStHYUJM?=
 =?utf-8?B?QVVjaGE0SXBaSkJDZXh2ejhrOU90U1VjS1djZTNmL2RLa1lHTWNvdXY0WTdz?=
 =?utf-8?B?SUFXbWpuM2JKck5pKytvY3BHbnpVUTRWOHorWG8rNWVBNXRLVmx0S0l1cUFC?=
 =?utf-8?B?NUp5UTcySk5GT2VUcXpLS1YvMXhLbmZhZ3h1d09qZTIwUDE0cXd2R2ZjaWpB?=
 =?utf-8?B?MVZZYWt3UEpQblo2YjhhMitGUTMwckpoSFZuRkNqWTNVd2tGeXR4VHRNSE1X?=
 =?utf-8?B?UEgzYnAwRnBvNTl3a2luWVNyTUV4UVV1SXova1ZhN1FNZk1YY3kxeDVCY2Ja?=
 =?utf-8?B?RGF3Sy9yUy9ET1hVQlY5TC80R2ErTENHYmh5VktuSTBRRVFJR3hFTStieXhK?=
 =?utf-8?B?ODhSUWRibWpNZU80VmpsNGhXaFowZjQvVTU2MXhVOUpvTlUwUHdqNVhkL3Fj?=
 =?utf-8?B?YzFSSEI5MmpGOFFPRHZuMUxmTDlOYXpYbVlqMUJkT3JQTjllbC9QeTNqN3RP?=
 =?utf-8?B?S1VZOTN0cWVnWVBVaVNmRzFJSHpiUk1aSFQ1ejdCdEZ6QnlBcHJGU0FMT1hs?=
 =?utf-8?B?Rjkya0tkWVFoalg0dmZVckpsbjZMYUx4MGhWR1JCMEFoaElWMGw5MFNTT0VK?=
 =?utf-8?B?V1c5SEtPaHhOK0RXdVM0OUtDZTMzZExzZmNrZmlmWjgraHVNN0d5WnloZCt4?=
 =?utf-8?B?WE9pQXgwclN4RkZ6eUY2SDJSM2t4OHpORHNqZzdzUXNpNDVTYys3NDhTbVFB?=
 =?utf-8?B?YjNsbG54clBZM1FTZy9RQTRUYUlzQUNIdzV2YXV3MUdrQW9NR0FkTkN5TWQ4?=
 =?utf-8?B?aGd0RUhUcUlzY2M4bm1lMmNuVXRCZVR6UU9GRjRzbkRFb01xVlJzRW16Z3lC?=
 =?utf-8?B?QUJ3NEdtd0grbFI0NFBpMWJvbHp3bGNXNmJLZHlVNDl0YXlIUWhlTjJBVFRr?=
 =?utf-8?B?VndmN1RUVDEzenlxNFNTR1l1UTRyN2hwUGs1MjVZNWRxbjFsNEdRbFJEeFc4?=
 =?utf-8?B?cjVHWDFBWFpNYVpTVjlWVmJ0V0tyY0pFNDdXd1J3TzVwTXhBcENBVE5EQ3Mr?=
 =?utf-8?B?ZzdZVHdTS2lGZE1RWnBPbzhudnhQTWlyTDZLY20zY2ZHUEkyNGh4NzlZY0gw?=
 =?utf-8?B?eUJONVQ2cWNmVnRBMDRmRDhiYmNsUkNidjFoMTFUUkRNM3NYeGJ5MTFOaGdm?=
 =?utf-8?B?bjB1eFhJMXUrb01DZ2Y1MzNsZkRjWlRoeWx0a3pncE5Eb0htYU92czd0MG01?=
 =?utf-8?B?dFJUNHE2SzFzVUNYbERuUCt3ck4zVnBsUWdMUjEvSlE0VmR3TUJBV0dVSWxU?=
 =?utf-8?B?b0lnQVplV3djRzc3QlNGTUFWTEc2bFVOd3N0bzVzeUgzYjcwellKUTFPOEZz?=
 =?utf-8?B?ckE0M3gzYUJWeUdIbkhXQUcwOXphSVVLQ2hQMjdrR2NFaTM3dk81VDloc3BR?=
 =?utf-8?B?eDRLZWxHckRJTmtOd2FrQUdaVVJ5alhjNVZCaUNZeGpLWUFyVFZ0dGc1ajRK?=
 =?utf-8?B?WnVIRUY4UjVLOVJueUhWc1pPcjc3RkxOZXR1dWdyc2JIV1RQREFEaGhQVGgr?=
 =?utf-8?B?Ukd6QTJjeVU4d2V5eWtjR3dzRXdQTDBCNE5QZGh4d283K0NwZFJGRHU2d0hX?=
 =?utf-8?B?MkJCQ3hNUVhCZXg3OHV1eDlqRDI1NHM2ZzExbUhDTW5aNE5obnpNNlRIMVZJ?=
 =?utf-8?Q?Nx/ZbndyrRELU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5c2296-72f4-4f59-fc04-08d94acc9ffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 15:48:16.6431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HfnuuHvRSbxNBCv4f4KYANbK96Ubo/n8knElHzW85aSbUJKDNE0dinAAx20X4/9w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Saturday, July 17, 2021 1:37 AM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: Re: [PATCH 3/3] drm/amdkfd: report pcie bandwidth to the kfd
>
> Am 2021-07-16 um 12:43 p.m. schrieb Jonathan Kim:
> > Similar to xGMI reporting the min/max bandwidth between direct peers,
> > PCIe will report the min/max bandwidth to the KFD.
> >
> > v2: change to bandwidth
> >
> > Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 61
> > ++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
> >  drivers/gpu/drm/amd/amdkfd/kfd_crat.c      |  4 ++
> >  3 files changed, 66 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > index 3978578a1c49..b7db52f1a9d1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > @@ -21,6 +21,7 @@
> >   */
> >
> >  #include "amdgpu_amdkfd.h"
> > +#include "amd_pcie.h"
> >  #include "amd_shared.h"
> >
> >  #include "amdgpu.h"
> > @@ -576,6 +577,66 @@ int
> amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst, struct
> kgd_dev
> >     return (num_links * 16 * 25000)/BITS_PER_BYTE;  }
> >
> > +int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct kgd_dev *dev,
> bool
> > +is_min) {
> > +   struct amdgpu_device *adev = (struct amdgpu_device *)dev;
> > +   int num_lanes_shift = is_min ? ffs(adev->pm.pcie_mlw_mask >>
> > +
>       CAIL_PCIE_LINK_WIDTH_SUPPORT_SHIFT) - 1 :
> > +                           fls(adev->pm.pcie_mlw_mask >>
> > +
>       CAIL_PCIE_LINK_WIDTH_SUPPORT_SHIFT) - 1;
> > +   int gen_speed_shift = is_min ? ffs(adev->pm.pcie_gen_mask >>
> > +
>       CAIL_PCIE_LINK_SPEED_SUPPORT_SHIFT) - 1 :
> > +                           fls(adev->pm.pcie_gen_mask >>
> > +
>       CAIL_PCIE_LINK_SPEED_SUPPORT_SHIFT) - 1;
>
> The shifting is not necessary because you undo it below. I think this would
> do the trick and be more readable:
>
>       int num_lanes_shift = (is_min ? ffs(adev->pm.pcie_mlw_mask) :
>                                       fls(adev->pm.pcie_mlw_mask)) - 1;
>       int gen_speed_shift = (is_min ? ffs(adev->pm.pcie_gen_mask) :
>                                       fls(adev->pm.pcie_gen_mask)) - 1;

Ok thanks for the review and suggestion.  I've adjusted your suggestion by masking pcie_gen_mask with CAIL_PCIE_LINK_SPEED_SUPPORT_MASK as the mask sets some non-speed related lower bits.

Thanks,

Jon

>       uint32_t num_lanes_mask = 1 << num_lanes_shift;
>       uint32_t gen_speed_mask = 1 << gen_speed_shift;
>
> With that fixed, this patch is
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
> > +   uint32_t num_lanes_mask = (1UL << num_lanes_shift) <<
> CAIL_PCIE_LINK_WIDTH_SUPPORT_SHIFT;
> > +   uint32_t gen_speed_mask = (1UL << gen_speed_shift) <<
> CAIL_PCIE_LINK_SPEED_SUPPORT_SHIFT;
> > +   int num_lanes_factor = 0, gen_speed_mbits_factor = 0;
> > +
> > +   switch (num_lanes_mask) {
> > +   case CAIL_PCIE_LINK_WIDTH_SUPPORT_X1:
> > +           num_lanes_factor = 1;
> > +           break;
> > +   case CAIL_PCIE_LINK_WIDTH_SUPPORT_X2:
> > +           num_lanes_factor = 2;
> > +           break;
> > +   case CAIL_PCIE_LINK_WIDTH_SUPPORT_X4:
> > +           num_lanes_factor = 4;
> > +           break;
> > +   case CAIL_PCIE_LINK_WIDTH_SUPPORT_X8:
> > +           num_lanes_factor = 8;
> > +           break;
> > +   case CAIL_PCIE_LINK_WIDTH_SUPPORT_X12:
> > +           num_lanes_factor = 12;
> > +           break;
> > +   case CAIL_PCIE_LINK_WIDTH_SUPPORT_X16:
> > +           num_lanes_factor = 16;
> > +           break;
> > +   case CAIL_PCIE_LINK_WIDTH_SUPPORT_X32:
> > +           num_lanes_factor = 32;
> > +           break;
> > +   }
> > +
> > +   switch (gen_speed_mask) {
> > +   case CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1:
> > +           gen_speed_mbits_factor = 2500;
> > +           break;
> > +   case CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2:
> > +           gen_speed_mbits_factor = 5000;
> > +           break;
> > +   case CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3:
> > +           gen_speed_mbits_factor = 8000;
> > +           break;
> > +   case CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4:
> > +           gen_speed_mbits_factor = 16000;
> > +           break;
> > +   case CAIL_PCIE_LINK_SPEED_SUPPORT_GEN5:
> > +           gen_speed_mbits_factor = 32000;
> > +           break;
> > +   }
> > +
> > +   return (num_lanes_factor *
> gen_speed_mbits_factor)/BITS_PER_BYTE;
> > +}
> > +
> >  uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct kgd_dev
> *kgd)
> > {
> >     struct amdgpu_device *adev = (struct amdgpu_device *)kgd; diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > index e12fccb2d2c4..5d73f3108d13 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > @@ -227,6 +227,7 @@ uint32_t amdgpu_amdkfd_get_asic_rev_id(struct
> > kgd_dev *kgd);  int amdgpu_amdkfd_get_noretry(struct kgd_dev *kgd);
> > uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct
> > kgd_dev *src);  int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct
> > kgd_dev *dst, struct kgd_dev *src, bool is_min);
> > +int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct kgd_dev *dev,
> bool
> > +is_min);
> >
> >  /* Read user wptr from a specified user address space with page fault
> >   * disabled. The memory must be pinned and mapped to the hardware
> > when diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > index 40ce6239c813..eada22b9ea69 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > @@ -1998,6 +1998,10 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int
> *avail_size,
> >             }
> >     } else {
> >             sub_type_hdr->io_interface_type =
> CRAT_IOLINK_TYPE_PCIEXPRESS;
> > +           sub_type_hdr->minimum_bandwidth_mbs =
> > +
>       amdgpu_amdkfd_get_pcie_bandwidth_mbytes(kdev->kgd, true);
> > +           sub_type_hdr->maximum_bandwidth_mbs =
> > +
>       amdgpu_amdkfd_get_pcie_bandwidth_mbytes(kdev->kgd, false);
> >     }
> >
> >     sub_type_hdr->proximity_domain_from = proximity_domain;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
