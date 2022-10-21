Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00033C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 04:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4886A10E584;
	Fri, 21 Oct 2022 04:15:27 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B6F510E584
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 04:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cbog/frH0aiLX7KuilvEXQNSQckp5w6QhNeDLvdL/2v0brRjOvxG45Klzw03MhIrLD10+vhs3PZBWA67ujNUvKtcVY7Q6u7CLZ5YBF5CkNnFEGwn0jh3lSbyoxmGChrQJJCzuRbj1Ut/R7hYCSh/vE9hotIhG3dPfLg6Toylh+7wDDOC6oJeuufnZMmKa7o4RCtITiX4XR5N6YfUsTekFvCnYxQaYMmCxpadhBv5VnvDNc93CE7fppMYsbCzG+36TJpnx/vaRYuKoeA7RPXl3Q3lM+EI+2xayJH6tGzOe4SXWbUFk310ii/4flmt3n4F9zFeYmN6NEyu/yVKm4HbAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMEyBgHog3h6e77au9qkZnYA2qjF7ZapNDBLAuKZAx4=;
 b=ZloIJZ5CewDMeTRK+VE5+VgenCg9vzhhedZeDFgp26Wpd9M6uJ2Cc3AJV9rBl2nVmAAJ02QcMC8CMsjsb85DqIYmrUdWgD7Gb4uIoWqFXeX8HmwRN9j2EwtUSgKw7Qbwfe2Yt2OcXrfmfBTF0+0wrMAaPljqqJKza06u/gyaTwtplyu0pyuJSV22NXZXpGxbhnIlsqSSM0rxeVC+vwirZhknqCbLUT9jc7Lhc6CDilcjtOHyczMnWmca/6n2QI+IwM3lSq9cwvu2DlXhAFeCZQH1NF4qFYd2agW+9Ob3zDjGQrsFy882j4JARBeA1kxeCnE+tMlhE9/WuuC8m4qt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMEyBgHog3h6e77au9qkZnYA2qjF7ZapNDBLAuKZAx4=;
 b=VVHZ3lBmqGFss15wU0o7Amgj3fR4KUqm/lycqiWlUuzjQl7P+oHZQrXQys1tBrTG+fQ/bJCxBQ9BnenuxTIUT5DX0Kl41i3krgvcLmTBhQA2CCF8wAz0AmNcV91XuvfVWcMdz6K7GwZfILFQ45R8I+cHUEC9rakN3zI+bKRI8q4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 21 Oct
 2022 04:15:19 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b%7]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 04:15:19 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions for MCA
Thread-Topic: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions for MCA
Thread-Index: AQHY45KJoZXNP2qgnkmS8JxqkkhKgq4W+OoAgAEwmoCAABIEoA==
Date: Fri, 21 Oct 2022 04:15:19 +0000
Message-ID: <BN9PR12MB52571316758A4051ECED576DFC2D9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221019081150.31773-1-tao.zhou1@amd.com>
 <BN9PR12MB5257D39D5568891CABB09B62FC2A9@BN9PR12MB5257.namprd12.prod.outlook.com>
 <DM5PR12MB17701A7904F390C4A3E02760B02D9@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB17701A7904F390C4A3E02760B02D9@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-21T04:15:14Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7f91dd3d-e8a5-41ea-b651-e89e88c8c2c5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB6640:EE_
x-ms-office365-filtering-correlation-id: 79f00344-4b42-4ba7-ff6c-08dab31add61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eeJQu8b+3tFvLSypRyYWchs75zFIRCdP6Y9sZdk/BKgPwtYSIid6xBfSy8YIa+s2dP08H7mOLlLzjZFbaA15BaFssIIbyVvAAuKyETEIXlBxUgakVL4HvAao1lCPjcpIK2jzzf9PjVI8gxySRMxybQ8mUdRqs+QXhl0D0Odt0YT4NpPWZ/eJmWq6ES2IzWRjKVScFVIlEzWJA10szbOcJxEPhpq9dqGSsRnVyzqz7CQeraCmCDl1V6HDUrD4VxnG5T8WeT2qvsqws4nJ1SZp+Zs+c1guYGCZH3e/4SNIT8rBtk6yxrsH8TBjdJtAtiswQ9sAHZK72cvtKWKrSf3PBeN+whyOXImOdsWGmpCUjJYs/miFOllTM/rc5mHAs30jNORgD+yy4x+mcpUKm/vjtbCLZwXuhjggIaa1IagMLjrsLe1o+oXdHz0F1LF0MhhtBz5qTTSl6YOJQyRHx/zjGRKACcevYdHYFBRAreRf71a1ri02XVQ3/xYmJSCkLucKh+mmRfo0mwEB2i1dawqG2/fCRqmTotD6cXvqcdT8vR8/HPTRXBwEpUDXVn2WCa9PZbL28D9bQFTcbltZSLTx5Tksp7kgdFvbZWlj7n/TyBIpmwlwIh14nJHhcIr/rGRTWJP9J61VXyqR1eZjcV+Rn96VVWx80+nentnSIw64ztGMsCKrcx0hK+0cHLO21VHyKkx9z4twq+laHFky2eP0JtPZ1hEY7R8ZTPEsxvKzhmBn7e5BDJHkDN4XShEjVXHAYliMYdvcW+b9G1euUr/ikA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199015)(478600001)(9686003)(66476007)(122000001)(55016003)(7696005)(186003)(53546011)(26005)(5660300002)(83380400001)(6506007)(33656002)(52536014)(71200400001)(38070700005)(86362001)(66556008)(110136005)(8676002)(38100700002)(2906002)(76116006)(8936002)(6636002)(66446008)(41300700001)(64756008)(316002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NHKiIr6o8QjFhIyePN5qWTGIoLW5HIuumF+K9+hX4YgKciRE3310gjYTKuHm?=
 =?us-ascii?Q?6BSBsFbPnZIOpXPeGC8IjK//GvzizzoJOobhIF3mgXoVeoyp35aStkOCG6Kh?=
 =?us-ascii?Q?+fz/Al3sgjjTr9u2eRwm4UCb370M3uQxUdpycdswnhKGGe4DYIbAbnmV84qH?=
 =?us-ascii?Q?h7s/Q3XcPAG6V5iWsisPUmnBEptzOmwAZlgRGz7ZtdPMNKiw0h95n8ZS9+MG?=
 =?us-ascii?Q?Cvo6me+wPDiy61lTr9gZdf2Dk6uFhhFIOqS+Yy4Toucj+oMGohXLKjWBhSQw?=
 =?us-ascii?Q?I3LD5GeYaZmmYBw69jCWBjnAuC2Nr4WTmhFI8TeiuqmXWsVeUKhm2vbRv3f+?=
 =?us-ascii?Q?yhPULZt8ppCFgOiO+Aa8SKlQ0V4fo904qZMITHaYmrYySvPXksydxd8pzG/U?=
 =?us-ascii?Q?4ADdwBC8DZS/vQ/ua0XfpMUMKNHuxcozmVyjxjYSc6OiMC8uV9XxjaPuRlGl?=
 =?us-ascii?Q?AfKqa4y5nfS5GdZvF6PVp7iOVbZkeAhFd5qfduo1/EGwRhq6veUKAGPAbV4T?=
 =?us-ascii?Q?NZ9BlOKi84Kgm68mODheNKenzbXQAWeSagrzf1klBF08iB8Mjofer0HTUxSo?=
 =?us-ascii?Q?Ch6syAfUkEyXM3kusfdZA+FdY4WsieNqxuDqyepsQpDVsmpMyngLGa7Deikn?=
 =?us-ascii?Q?F9rrn9tdsY5thXZQ08BPrQXX2zg/shsrDKNKaFQig3X4dCd8uR4UeA5t0ND9?=
 =?us-ascii?Q?19zkRQdRufwO8v0qYtcYWB7NAvmWmHIwp+cwQF3JPfYg4VbroLQHoLFTmD15?=
 =?us-ascii?Q?VU3gCmP52SimwTqh+bA5o4nyqtIW4kopSBjkTwa8hie55Qs2oaziHlPaKFht?=
 =?us-ascii?Q?HDcWXJ14xP2HPLgEU0aLa5ZhiLmAqhFTElskcgZFjmSwH5oWRo7EiV9qan5E?=
 =?us-ascii?Q?nQLJ7dBTKwSzhMhN1YinwTNF6xjM7HbHvvcfeliqZFc/Z2GRvJbSN+hPxvuL?=
 =?us-ascii?Q?CMBdoXwsBEZ9rU9K8OH4PUui0y2+S57prW0jquzKyDWz0NQ+wQ9dGp69wgen?=
 =?us-ascii?Q?XE4ltRwH8MppDz0/36osiZuGLPmRz2H86tfs1+UAW4Xp2FNBxb11AMWO6HpG?=
 =?us-ascii?Q?UsMBTYLLXOtNuvINZSipknJAkg8GVGaELrSQnGiLW9HOKZbaQMkvxugbJFyG?=
 =?us-ascii?Q?0+druUw+goo2iN8hJkMNm8TpAKYrpc0p1QpPxDQlHhwrq/n+XJpMiPuX506M?=
 =?us-ascii?Q?oV3gj3ydWRvO/POekweroTuqfzwaBRXbjhsY1647p4n465YPKR3sXgRTy1lY?=
 =?us-ascii?Q?MDac9NsAxvejdZ3MbR3jtaPGZC7mmgv6myMJ0IfkwWCPbXHiOYe2vhhycZWY?=
 =?us-ascii?Q?pphQdsZ6LufHT7Qnuwz97Uw42zMjNFvPjOaz23MMyYnardL21ZKTCnqyPPUT?=
 =?us-ascii?Q?z4HS0uJvDAM2m5TiC9mGcL2oCf0S0BH9qs5kBftM5qeI0mrF+E1GinszkXGg?=
 =?us-ascii?Q?/hjjh7ppYOOisd7kJHdCiYvX0+FG0MRvcV0wKirZTZPRsJ77xC5apQvAxfhS?=
 =?us-ascii?Q?mfcffPH7eQ2sR6aGdX3r6Dpj6bMMBTCJZiK4ThZf3ZOj7YPhRb9vba9lux/I?=
 =?us-ascii?Q?PX+X5Ir7nhWb1pesh04lCSuKSwkpqiJ3VSzkih1u?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f00344-4b42-4ba7-ff6c-08dab31add61
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 04:15:19.0742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dKymuCIc3Wzx2Gu8IV4124Xo+ZZyyu1ZBzJr9TqeFSdSVHWLEOfzyeNf/dAXV/k+Vi85wJUreOWg2GqhAcFv1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Re - whether need to do gpu reset is determined by unmap queue status, so r=
eset parameter can't be dropped

+	if (adev->gmc.xgmi.connected_to_cpu) {
+		ret =3D amdgpu_umc_poison_handler_mca(adev, ras_error_status, reset);

I think amdgpu_umc_poison_handler_mca is fallback handler specific for MCA =
platform, right?=20

I noticed there is platform check already in amdgpu_umc_poison_handler with=
 the reset flag. so driver already knows whether the reset is needed, right=
.
That's why I think "ras_error_status", "reset" are all not necessary. You c=
an either call the followings directly by checking connected_to_cpu && rese=
t,

+		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+		amdgpu_ras_reset_gpu(adev);

Or still provide a wrapper like amdgpu_umc_poison_handler_mca for above two=
 calls.

The latter seems redundant as well. I mean, we don't need to maintain a spe=
cific API for poison handling fallback on MCA platform - Aldebaran is
the last SOC that supports this A + A RAS design. I can confirm we'll move =
to a new design going forward.

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Friday, October 21, 2022 10:54
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; =
Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; L=
i, Candice <Candice.Li@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions for =
MCA

[AMD Official Use Only - General]


> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Thursday, October 20, 2022 5:13 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org;=20
> Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas=20
> <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> Subject: RE: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions=20
> for MCA
>=20
> [AMD Official Use Only - General]
>=20
> +static int amdgpu_umc_poison_handler_mca(struct amdgpu_device *adev,
> +		struct ras_err_data *err_data, bool reset)
>=20
>=20
> +	if (adev->gmc.xgmi.connected_to_cpu) {
> +		ret =3D amdgpu_umc_poison_handler_mca(adev,
> ras_error_status, reset);
>=20
> The input parameters "reset" and "err_data" can be dropped since=20
> amdgpu_umc_poison_handler_mca is dedicated to MCA platform

[Tao] whether need to do gpu reset is determined by unmap queue status, so =
reset parameter can't be dropped.
For "err_data", it can be removed currently, but I'm afraid we may need it =
on other ASICs in the future.

>=20
> Regards,
> Hawking
>=20
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Wednesday, October 19, 2022 16:12
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking=20
> <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,=20
> Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions for=20
> MCA
>=20
> Define page retirement functions for MCA platform.
>=20
> v2: remove page retirement handling from MCA poison handler,
>     let MCA notifier do page retirement.
>=20
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 67
> +++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> |  2 +
>  2 files changed, 69 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index aad3c8b4c810..9494fa14db9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -22,6 +22,73 @@
>   */
>=20
>  #include "amdgpu.h"
> +#include "umc_v6_7.h"
> +
> +static int amdgpu_umc_convert_error_address(struct amdgpu_device *adev,
> +				    struct ras_err_data *err_data, uint64_t
> err_addr,
> +				    uint32_t ch_inst, uint32_t umc_inst) {
> +	switch (adev->ip_versions[UMC_HWIP][0]) {
> +	case IP_VERSION(6, 7, 0):
> +		umc_v6_7_convert_error_address(adev,
> +				err_data, err_addr, ch_inst, umc_inst);
> +		break;
> +	default:
> +		dev_warn(adev->dev,
> +			 "UMC address to Physical address translation is not
> supported\n");
> +		return AMDGPU_RAS_FAIL;
> +	}
> +
> +	return AMDGPU_RAS_SUCCESS;
> +}
> +
> +int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
> +			uint64_t err_addr, uint32_t ch_inst, uint32_t umc_inst)
> {
> +	struct ras_err_data err_data =3D {0, 0, 0, NULL};
> +	int ret =3D AMDGPU_RAS_FAIL;
> +
> +	err_data.err_addr =3D
> +		kcalloc(adev->umc.max_ras_err_cnt_per_query,
> +			sizeof(struct eeprom_table_record), GFP_KERNEL);
> +	if (!err_data.err_addr) {
> +		dev_warn(adev->dev,
> +			"Failed to alloc memory for umc error record in MCA
> notifier!\n");
> +		return AMDGPU_RAS_FAIL;
> +	}
> +
> +	/*
> +	 * Translate UMC channel address to Physical address
> +	 */
> +	ret =3D amdgpu_umc_convert_error_address(adev, &err_data, err_addr,
> +					ch_inst, umc_inst);
> +	if (ret)
> +		goto out;
> +
> +	if (amdgpu_bad_page_threshold !=3D 0) {
> +		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
> +						err_data.err_addr_cnt);
> +		amdgpu_ras_save_bad_pages(adev);
> +	}
> +
> +out:
> +	kfree(err_data.err_addr);
> +	return ret;
> +}
> +
> +static int amdgpu_umc_poison_handler_mca(struct amdgpu_device *adev,
> +		struct ras_err_data *err_data, bool reset) {
> +	/* MCA poison handler is only responsible for GPU reset,
> +	 * let MCA notifier do page retirement.
> +	 */
> +	if (reset) {
> +		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
> +		amdgpu_ras_reset_gpu(adev);
> +	}
> +
> +	return AMDGPU_RAS_SUCCESS;
> +}
>=20
>  static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
>  		void *ras_error_status,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> index 3629d8f292ef..659a10de29c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> @@ -98,4 +98,6 @@ void amdgpu_umc_fill_error_record(struct=20
> ras_err_data *err_data,  int amdgpu_umc_process_ras_data_cb(struct amdgpu=
_device *adev,
>  		void *ras_error_status,
>  		struct amdgpu_iv_entry *entry);
> +int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
> +			uint64_t err_addr, uint32_t ch_inst, uint32_t umc_inst);
>  #endif
> --
> 2.35.1=
