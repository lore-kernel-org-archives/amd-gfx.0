Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72F5C6FD1D
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 02:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D3CB10E0D3;
	Fri, 31 Mar 2023 02:16:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A75F10E0D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 02:16:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0BDOyuNor3yTQSVKxrUYJAvUK+1lHzwBcV0zSAYpgnkp0BvDNXXbN+qd+jy7Wjqbb5IaVMctSECNsd9yqAJSTCooQUpr6q2mjj1tAf8V6PPDlKleRgdNSj85qCcyyQRItliQmIvZ6lf3y3ikgGlsKV/y2PHqfGdgjOb+h3fPm1RLm/5tDcVDZ2aWnRFOK5hmDGk5pQgb8W9yU2AAqPSGw+PgrGW2SeI1+0HtFwfdac6TlSnJQSYtxlDrrgSBofWA2Bn7din+idNDEdF0vRCj8fiuzHhNOncJPwex1LX/OZpYH2fbQd/o9hDGu6aHQWXgIhgtuuzLt9Fe5UXgoF6lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcaZ8CVaSh9kFap5eUkystmRRBtC2ZuJatYkyefnUqE=;
 b=a2mPYyd/YWS3QGRaYCUTZTnN5K5oXTDFRVyWvfMQQbCFqC5UrW38LndaF8AdnRSICINm3i1bkgmJxkntvBBjWFXLWTHYHdRy500gt6OZK+uIdcJ2EMRhhxm9IUF+TOCD8wmMQzsc7uxXrbjUE8h1iyDRwb/wM9MEiyJVKJrbj1DTb3KwL+2VIQfHoJGl2iVWgECHW8hWu/yGNrMRm45x8EzTqS/wElkh4BFLDdCUanbfP0kxpmAkAH0G3jym3z9fa/fvR7slEmvah9rxNUO8fC7Uyoyz2iVVmkti43nV1cm4jhEOGgPowetSnGbDJI39pQaoYNCbukuaDhqSGwKEag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcaZ8CVaSh9kFap5eUkystmRRBtC2ZuJatYkyefnUqE=;
 b=xzdzqZbcLfKgpe4f1Hr1LmJlEsPNh9zNXknEWSOSOdsxzG+kPfChw7t4bbE7s/WpmIcuGkOPSwHgCWwLBcgQ/LMLthSlTDhHziImrSsOFv/j316wJ4CtTHxBOjR09/fIeSYO8dmd1gAAT6h+5ZZ4iiS1Sd9rd0Ko//DzlMHSFoQ=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by SA3PR12MB8440.namprd12.prod.outlook.com (2603:10b6:806:2f8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Fri, 31 Mar
 2023 02:16:07 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::2bd0:2a4:c590:40f2]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::2bd0:2a4:c590:40f2%6]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 02:16:07 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: allow more APUs to do mode2 reset when go to
 S4
Thread-Topic: [PATCH] drm/amdgpu: allow more APUs to do mode2 reset when go to
 S4
Thread-Index: AQHZYrANmwNa1yD7XkG8cvpciA1BU68TQPAAgAACAQCAAOSLIA==
Date: Fri, 31 Mar 2023 02:16:07 +0000
Message-ID: <BY5PR12MB3873040B950D9205462DE20EF68F9@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20230330023302.2466048-1-tim.huang@amd.com>
 <CY5PR12MB6369DDBCCB94A420070C420FC18E9@CY5PR12MB6369.namprd12.prod.outlook.com>
 <MN0PR12MB6101CE23C61978D7BB091B48E28E9@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101CE23C61978D7BB091B48E28E9@MN0PR12MB6101.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5a3fc095-13f7-41bb-81e2-5233fca07594;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-30T12:35:48Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|SA3PR12MB8440:EE_
x-ms-office365-filtering-correlation-id: 36341802-fec0-4fa1-1fff-08db318de30b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UP1ZazJqaOhnJqJQDbKQXgeIk47ntO/iDJ4TPqAxDC4jesJptfFDuotpEZ3U1d+bDy73p+cxj08bfArik7u12rfXEtsNk7Rf98ynC5xUkKAf/IuJIfdT77bUQVr+Pa4N7T8kV9wm8sdZOuuP5g/BcOcJhvuPFVtr/LVJFhz+mccisp5IejK6q01O4tVK0FM22MvOunStveQNr0896hk8osYva1Tn5vlJ1iW0jXUoZFF64ObkcUFukTs52xEqZEJagJxrqqyZYjxwwL7JhLgm6bCzswt4Jvt8VIezEaN9iSp+dsq5EkDgXmpSg7RpEaw8+ZVikM1gisGBcHd3nwrVXJyg+VhGCmb3UkByUtwhwjjDHaDAudyfibLQ4EPpzwo/LAoav5F0WpmGpelQRwhqD3BODDxF/rPijm7fb8HrvZvu4WsBp4daWhhWoSoWQqHcYOfsz4vd9QJc/z7jTgsr/pCCnaSPDphmAJirKEgesA2R/nuXGsq74BM9tsJtoVvd9N40pbXK9OFONq+1/uq5svlSAYFo6vR1uK3xhcOm4OsslXyYk7mCBPW/kO13X9lO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(316002)(86362001)(122000001)(52536014)(5660300002)(110136005)(8936002)(54906003)(9686003)(66476007)(41300700001)(4326008)(66556008)(76116006)(66446008)(8676002)(66946007)(64756008)(186003)(53546011)(26005)(55016003)(33656002)(2906002)(38070700005)(478600001)(71200400001)(6506007)(83380400001)(966005)(7696005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?45CatWG3PrusT48epFIX4aM3GtmUfYdmOPrqe5FUS4ChmhrigUz+jECwM2pM?=
 =?us-ascii?Q?sSuFRUFJsLVIz3eNVNywYlw9Ebkm1G0chPuezh5pxXAfbnrbxn6naF5EltNt?=
 =?us-ascii?Q?4nwGHlBKWloWZMdyyiV53pNgveGVXs20+I0GHYJ8EtgRNpxs6tw+UDkwGXbw?=
 =?us-ascii?Q?0/zwCoMAyKrkqEShhY0w1AMfQKi1Xc7B4AlElLKAAmR9h8fiNaqu8bvMa6om?=
 =?us-ascii?Q?RILv4i61KR9nUYDsWpk3FMeY6aiEtnI/4DcE4lYzQ0ZpKd1kQpd1EQFu6+im?=
 =?us-ascii?Q?DA+UtmKUoqPqSUgEzbWS/7odYjz3/CMCBAI3b3MAH6435Dy3j4NSSn8bwH8K?=
 =?us-ascii?Q?KKfgEZ9Cn72ZgmaooIEs8NXPe4CGK94X4L1qd8JV+RonXXfkgrrgeSj0pHn+?=
 =?us-ascii?Q?i1v7e7r+u1Dkb6qP+VFan7MFBA+mAULoybMdzAuXtO0wbG96cDZkNQP/S1LV?=
 =?us-ascii?Q?JHc9MrK/EnNTylazCqryYsXf/6RGm9zjvS0gCsD364WFV6JMpO5JE9SKucPu?=
 =?us-ascii?Q?2T51P5B5PB4SGwzOXfAE2Hs3UPKEmKYWjhcIQmaHrJUrRoRrLMaqdMT81hVC?=
 =?us-ascii?Q?kpZS8nTNH2RbYKycKINWNEuInYDmqzr8ZfCKjTEEQTMk9MpIeTWxmwFpsUBL?=
 =?us-ascii?Q?D271CNPJdaG3Ot/ehrr6xg5HtVoni6r50XQujWCseCrmauEYivjuSYONKngb?=
 =?us-ascii?Q?tKcUP6QMrfb1mClG/Qy2SqTC30eH3jldmozv5uaBZ6IKRRHaKcHydmrZZ2rg?=
 =?us-ascii?Q?bVAakL5X1j/5zSbzvJh0I10yXmhJ3x99ki62IVe2+oVU02hDvjt0Iu41I56I?=
 =?us-ascii?Q?s7EqB6toVt5yvlafthOQHb+epdan4fk+Z89ft3GMrp112st9d1qwqzj6UY0t?=
 =?us-ascii?Q?yKMt1qqydArPlAFw+dBA4PYobeqeQf3oeIBTObTQwEWMx8LHNR5nAhrPWNKU?=
 =?us-ascii?Q?AW3ibBkL4Mh9G6AcPqcMUZaB7eNE7rZsl6o3bT00/akHLA8GPwjhi1yUhiDA?=
 =?us-ascii?Q?s8jGchgPg7mE7AkM4g+h3ve8gHch0qIMOXxumImcBJPiQWlD9PhLRuQiNFt0?=
 =?us-ascii?Q?YhMrqswoXwysY2HULWpONbZf8Vk4j5sgAyqJB6uKyHYc4XVHg509bo75H4gk?=
 =?us-ascii?Q?+G+JY2bq9uwgjOjDiLUk74/5q8ioKByBv8u9IikybliYDyxXoI1GBhz8Do+p?=
 =?us-ascii?Q?KU6EeSDJGUKU62qzcbT6vmNNdmE6/716Oc2n3SMIyvq41hnNBNiUv6obLU76?=
 =?us-ascii?Q?HBfuikCSw2d3MVCbIKYdP6h9KsOUe4N8JWsgx6iR5Xtmwc4/D4qrp/d1I1DD?=
 =?us-ascii?Q?f5p/qI5/wfvKkbqLy9YDZ0XfFKyuLcHPmRH3XktUCecefvWgZyhh8W8vFozt?=
 =?us-ascii?Q?wPwqIym+9ioOG6DO473e4ztKSn3Z237tikHLS3O7nNsxqz9PgHmSKfM5FyJR?=
 =?us-ascii?Q?foz7w6Xx2TMszIdK171C/7auoLFKpgRjfy2p1GKTHpSnxJLIk8NyAjYPW3rb?=
 =?us-ascii?Q?/GGlMDWueuz/FFInfRuUiZp3DMUqQ5hQeMxaoOghPEaeE8mrY9ncL+Uid29I?=
 =?us-ascii?Q?QdnRY6zR7pJzEPOrXcE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36341802-fec0-4fa1-1fff-08db318de30b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 02:16:07.1773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbBUjHb6SxiQIpeHaokOo8McOIJwO6z7cHnfZrCg7cI8Pd/gDivYn2ZuNS6WCIrQ2vv/KUoyv34OCytm3Dhm8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8440
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yuan,
 Perry" <Perry.Yuan@amd.com>, "Ma, Li" <Li.Ma@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Yes, will use the Fixes and Link tags, thanks so much.

Best Regards,
Tim Huang

-----Original Message-----
From: Limonciello, Mario <Mario.Limonciello@amd.com>
Sent: Thursday, March 30, 2023 8:36 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; am=
d-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Yuan, Perry <Perry.Yuan=
@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Ma, Li <Li.Ma@amd.com>
Subject: RE: [PATCH] drm/amdgpu: allow more APUs to do mode2 reset when go =
to S4

[AMD Official Use Only - General]

Also in commit message move the issue into Link tag.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2483

> -----Original Message-----
> From: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Sent: Thursday, March 30, 2023 07:29
> To: Huang, Tim <Tim.Huang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Du,
> Xiaojian <Xiaojian.Du@amd.com>; Ma, Li <Li.Ma@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: allow more APUs to do mode2 reset
> when go to S4
>
> [AMD Official Use Only - General]
>
> Please add a Fixes tag:
>
> Fixes: 2bedd3f21b30 drm/amdgpu: skip ASIC reset for APUs when go to S4
>
> in your patch.
>
>
> -----Original Message-----
> From: Huang, Tim <Tim.Huang@amd.com>
> Sent: Thursday, March 30, 2023 10:33 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>;
> Yuan, Perry <Perry.Yuan@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>;
> Ma, Li <Li.Ma@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> Subject: [PATCH] drm/amdgpu: allow more APUs to do mode2 reset when go
> to S4
>
> Skip mode2 reset only for IMU enabled APUs when do S4.
>
> This patch is to fix the regression issue
> https://gitlab.freedesktop.org/drm/amd/-/issues/2483
> It is generated by patch "2bedd3f21b30 drm/amdgpu: skip ASIC reset for
> APUs when go to S4".
>
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 0f7cd3e8e00b..edaf3ded4a04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -981,7 +981,12 @@ static bool amdgpu_atcs_pci_probe_handle(struct
> pci_dev *pdev)
>   */
>  bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)  {
> -     if (adev->flags & AMD_IS_APU)
> +     if ((adev->flags & AMD_IS_APU) &&
> +         adev->gfx.imu.funcs) /* Not need to do mode2 reset for IMU
> enabled APUs */
> +             return false;
> +
> +     if ((adev->flags & AMD_IS_APU) &&
> +         amdgpu_acpi_is_s3_active(adev))
>               return false;
>
>       if (amdgpu_sriov_vf(adev))
> --
> 2.25.1
