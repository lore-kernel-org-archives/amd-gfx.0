Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F84BC021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 05:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E998310E3F6;
	Wed, 19 Feb 2025 05:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5DQzDddX";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8718F10E1FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 05:46:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzgnIS1j3VPmT6/7N4E7E5ciLVtmg89d7Bbv5TkGh0opfeiL3aYcLVuQP9nJOAevw696eVNJ3pDapy8IVldp5t8LWWE8Uc9Iqa+MW4dXw6Ww+G/0eyw4PW0Y663A81gkJ1AjhD5JneY6rFOQEnXCurq7uNc47NKlRlgKdqEIYpKqIJmZjv2+9CF+Ba02YeoSyCSm4gCtQbbTw4KRoDVHKt07flKYxRFKCSFzsnk61sog4bMsFTNUumiSIteX1XNuHsMhCMJMuJQl2boRQug6fcVvW5+voOnd4/Ml4NcNV0ajsErKITSQChwNcxKr34LJM+10C1qxOZcmtp/gOp/LuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++5++xZslBaS1ZiupQrTy+1bu80LG/HqCwCPExY18wg=;
 b=ONx/TB2Q1VGm7P+oK9r8l57+HbUqeEcO4rALtqQVaabTkrslUIHOmWlaFXaFGffQs0WPWZUAEjLucYtUw4GZOKmUR4+FPiLApah/RwoB0OF2JtgNJrb0LkTF1A+btpUHecrv5HhJZ86DbCMyrko94/pfB2Nj6gmYOkseXB/i9emtVhcAVVgGDBHNT3tvj6xkyYp+LEKzaUcl8SpZHmmVPw+aH97CpZ8wPbIyXqfn/1e63iBRZ0Z3vdMNlrrAQGGsyL/IejhZbaD8VZ5/BOctBwQehNXxGVjdZ9BkhEaDzuOB8GXmD8/KWwDFFcpXm9tyq/q5nzy79gYFJFRW4AX+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++5++xZslBaS1ZiupQrTy+1bu80LG/HqCwCPExY18wg=;
 b=5DQzDddX+OGkx4rM2Ty3WMofJR0S6X+0Gl3YUsL5XIRBQr4sb95llL+8y28McrFOhdem45bQRLgtGwhPrZn6+5u3ezS76Eg0CP+49hcdjsx8dBu022wxjFooToBYrYTCwFDdWZL18b6Ik79BCnw6NX72RGVaf+1vjmqH/4ZSU4s=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 05:46:49 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 05:46:49 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Check aca enabled inside cper init/fini func
Thread-Topic: [PATCH] drm/amdgpu: Check aca enabled inside cper init/fini func
Thread-Index: AQHbgob9GwRU1/KgNUG/u31L9v/CabNOHjNw
Date: Wed, 19 Feb 2025 05:46:49 +0000
Message-ID: <PH7PR12MB8796F2707AE3A689A049C2A9B0C52@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250219042859.716845-1-xiang.liu@amd.com>
In-Reply-To: <20250219042859.716845-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3d5563a5-d9c5-4557-b9bd-eb978cc906b6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-19T05:46:31Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA1PR12MB7544:EE_
x-ms-office365-filtering-correlation-id: 4fa40885-1a09-4776-2cd1-08dd50a8cdaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0agXZxeFEwXXMNtetI2WnWKOEvUVh4IxOm0nqyO/YT88mSKiHMBoda2WCba7?=
 =?us-ascii?Q?zsSPGEq4RL/cSygUoyW9fdRUqghrkuYTMGpAA00jcYZDdzkvchvKOjg/IqCY?=
 =?us-ascii?Q?jnT5Nugxd3rsFpp6EL7TTQySxb/9cg2u6YOc+voLhKFIt75zHBnlXCnIOxBz?=
 =?us-ascii?Q?8FV3KjSm9ECIli0x+zvQNSNNWv0Q+eosY+MQiNFdHje39DjZA6wjeX8i6otF?=
 =?us-ascii?Q?tDRss1LBSbXArydwnRLxM/mu5sWGfrORvLXlOXQvw2iNXvNp7SM8PnYQNoX0?=
 =?us-ascii?Q?h+Y8GZ87rklgwqS5/T+J5KmyORXA367Qg2o+Qe/Kz+23jy6GCpVVgLs6s0pi?=
 =?us-ascii?Q?WHGHCrSXIrcx92DdQCJHY0F0EPB6mVSzuxfsnvDwRP9hYvsAQsaWAw8aaHeV?=
 =?us-ascii?Q?QUHszlfP4t14WCJl7aQFE/U8E1JRddYZytTf+/eLycXMqn5Zjxp+c5GJ1+rg?=
 =?us-ascii?Q?TyF2yQUaUv9U1rLvFfoQH+TbBPPzx7W822IpWzrMVWLQV+xp25z5WynzTvHT?=
 =?us-ascii?Q?6i/NVvc+VRNtjoOc7OKr0f+ybTwqiYx4EvE8mpxQ50JfeMGrUyJJb2dZA2w+?=
 =?us-ascii?Q?AI0iG/lc72bgXux30Ess99u9wPz01BCHiN8aV+uOaR/VBl/aswDDpWNfbjfo?=
 =?us-ascii?Q?9gRhED4MHT1ysxjr1OPTUnz5XNm+zFyLCyhDHJ9al1hV3GA+MLZX2AEAG9nd?=
 =?us-ascii?Q?aNGY/kzz2ckZllHdlZDIDK3ivIhL2K5KcFBTyI+XoF7kRCC+h5jcfWwMn1a8?=
 =?us-ascii?Q?/HWzs6XPK5KbVnORMsHDJsyiY/eIL0IOZvG0Zg9lHButLwQtCpaQD8NKskPy?=
 =?us-ascii?Q?3TaF+U3ZIU6uD/4LsYI0nOGF/XvdwGKEris+vMFaygbIZ0oeGiflwM1gIYHP?=
 =?us-ascii?Q?P87Z/WI4u16UnqND7pyi1zCWiO7EdCTRAHkbmRLO/FXFQU0VP9coPEmIjtsa?=
 =?us-ascii?Q?gQrTOiPFUeDVgDOrV1ynw8rryNJ7nWwI1+v/g+6h0LOhFJuN8Mo8LyxCfKwV?=
 =?us-ascii?Q?SaTDU1u0HxkZlommiaTNQShhSrD7s5c2FueiUyPcM8Jx9JdEN6Uo+2G7bZ1t?=
 =?us-ascii?Q?sXMkeFGvlOIQAVQO29ulXcnRsWr3Fa+mpFncxw3qahoz4OolHbvVXOmacbj7?=
 =?us-ascii?Q?dsb2cvIRjyHRxtM1QBoE/brBxwqwySBbjF/XzlqJA7IpudxiqONfOWZ/t/hF?=
 =?us-ascii?Q?W1RAzRbcItWyMIlTfuJihHauZB+iX8ImOvrT+mpFCkdPcxTF5JGORjzWQcCA?=
 =?us-ascii?Q?mMMxCJjW9bn0beEKkSTc4bTSdy4KEifpvtIZrHiG9JXePTh+ZyEOAuyKIxvP?=
 =?us-ascii?Q?OFVJVx0Mmuyf90bySNbOgZiNj8uVASjgNaSCRQg4wxuog3BjyCg5JnMtGY4D?=
 =?us-ascii?Q?ZgvqxGNLBWlE5uMfKglPRzRuxuodTHlEbiNQR/kXTwxWf3CNz0zelgPZNaok?=
 =?us-ascii?Q?dxQj02kf5v9wTCwbdK6+Hiz6wMwBDUXX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BZdr6h87I5J5FqBsbhA39daIILw5Sx4iuj6iUytt5szQVnyRc+2HWQsYBvb+?=
 =?us-ascii?Q?2g4ybJRKavuceaKk2qSzjyk6AXNHWYUm778tU0qKVD+lktOcOzSHflDFysf7?=
 =?us-ascii?Q?oL4laAtNqUmg/wCAnPmYqgAPcTWaWgq+QlS6tP0KPgmoHoYk6918njeuP96J?=
 =?us-ascii?Q?CeWR+2L6g61dNSCUGXf8W52ejuQPlkCPNdGUn7uvxXsQceiInZXoGg7BKtju?=
 =?us-ascii?Q?qtVwLYLaVBvKpIFItpWaa1k2I2wURpPrERzZb0Aa0+q4MNPL6KBo2n9DznkK?=
 =?us-ascii?Q?Pa56iLjIw0+g7t+QH8AfXX7DYdbMS6hPWC/DQFv2vKmIL4JbFnQAEU11VlQV?=
 =?us-ascii?Q?OQ91/dkmcndpp7oVIFuUhtSH6RTmHfdAjuiys6mPWDRUljo3zOELWp6WvGjr?=
 =?us-ascii?Q?RYwwyz4l2OMq3apxaIpEDIptdHMzMBA6SmIv6292Uh5o24cnBna2aUSSC5JK?=
 =?us-ascii?Q?kgptO3uiGR2URrVMgho2jDGJTMzjHz467riADVO5SsFO3sr7zQ3hWKLuIPnt?=
 =?us-ascii?Q?OeyzsGcSsYQUecfLJGPiwZXgffn7Vx3YAsEoLttSLj0tV7hLOXCcXQk4RcH3?=
 =?us-ascii?Q?/EgGxlLzthtwcy0sDu6UhmVyE7VpTdmXH+dmvFKSZVcS4DLE8DDcsONHM94t?=
 =?us-ascii?Q?dxZYFwrxmqFkt64CSA9nFTrwm/QW5BPlFxWgdKTRxFQnD9aJRn4/6ZdQlQ8v?=
 =?us-ascii?Q?OAAnEFkndadh2F+scXS42QDe46UaiBoOMrvCaSH0HMY3sXzWqtq5wMiVu0Jy?=
 =?us-ascii?Q?VO/KrfLCw8CcTt7qvlqq5h4HrE9AANzqI23HMgubH1WhtXmSQUjYSFoWFQwG?=
 =?us-ascii?Q?t26ALEpp0ah1Djab6Lblb0feR3lM9em4X2cnd/y5chSyrdX7sN1EFtTzSWxY?=
 =?us-ascii?Q?eFy0YSlLI5MnuGDTaSkbDSeT8F0bMvPZyAtVedyrKeuwUKrXTeaxhjqzWxSu?=
 =?us-ascii?Q?RaIlGvi62Nf+5iqdrlsOi5DCBKCe1d8DQUzCwgI4SAirZNvvgaHtfxIAJ3mX?=
 =?us-ascii?Q?5LL7unOEQQYZhdfdRaZqZ77WR7825O226o6OnmeSeLLwz5F6BU7n/Y7OV3wp?=
 =?us-ascii?Q?cF8ENBgTlPqs5PA6MaMuyLaWGJN56vXlLpuCfJ0+JUpz/efUp2YutsCYauGM?=
 =?us-ascii?Q?91mNRC4C80lrkZaxlCmIe05LmutZ1wAm9YCd1UkR1XyfLIGjf0c54tnQ9xYH?=
 =?us-ascii?Q?VHFEkHyuksm/5UE+1S8N9ePm6CtVuKtitGvsf16ndbZrYB048MWITEKJU+nI?=
 =?us-ascii?Q?WvYUt7QYvSfZNTAWLSRCTVxRLaC4dJ/MCkzZPowqhdhtkpy2dg0ckkZYdGZE?=
 =?us-ascii?Q?M8fA1iizn6LDl/SdOjgxvX4gzgYDbyAN5Qf4Ly35R3zdOoi4VlrOHQSXE0eA?=
 =?us-ascii?Q?Vp5cSdeWwDGaZq6loT0mpdHQRwctsrDrrumpC5oH63gSTdS0UcC6v2Ud71JH?=
 =?us-ascii?Q?v5HQ+IekflBOTsyK7VY34Zm7Mm2jrSVEWOBlrVFEMuPv7On9JHfwghCc4RSO?=
 =?us-ascii?Q?i/b0RgmTW/nA82Negi/1DKiq8j93raTonWR23L5oE4i3AGEonNviFF2bVvLS?=
 =?us-ascii?Q?E6cvqor2bStxX+j53Is=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa40885-1a09-4776-2cd1-08dd50a8cdaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 05:46:49.1119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZyrWzfCq8DR9fcjRQ7tYdqcn3BTvo4yFGqmZnUZ6+UBJpAH1TMg34EFZ5mFMuSZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Sent: Wednesday, February 19, 2025 12:29 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: [PATCH] drm/amdgpu: Check aca enabled inside cper init/fini func
>
> Move code about checking aca enabled to the cper init/fini function to ma=
ke code
> clean.
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c   | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++----
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> index 8805381e19b9..20c474a32852 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> @@ -538,6 +538,9 @@ static int amdgpu_cper_ring_init(struct amdgpu_device
> *adev)
>
>  int amdgpu_cper_init(struct amdgpu_device *adev)  {
> +     if (!amdgpu_aca_is_enabled(adev))
> +             return 0;
> +
>       mutex_init(&adev->cper.cper_lock);
>
>       adev->cper.enabled =3D true;
> @@ -548,6 +551,9 @@ int amdgpu_cper_init(struct amdgpu_device *adev)
>
>  int amdgpu_cper_fini(struct amdgpu_device *adev)  {
> +     if (!amdgpu_aca_is_enabled(adev))
> +             return 0;
> +
>       adev->cper.enabled =3D false;
>
>       amdgpu_ring_fini(&(adev->cper.ring_buf));
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 79dc38c88304..b85e3624a943 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3091,8 +3091,7 @@ static int amdgpu_device_ip_init(struct amdgpu_devi=
ce
> *adev)
>
>       amdgpu_fru_get_product_info(adev);
>
> -     if (amdgpu_aca_is_enabled(adev))
> -             r =3D amdgpu_cper_init(adev);
> +     r =3D amdgpu_cper_init(adev);
>
>  init_failed:
>
> @@ -3454,8 +3453,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_devi=
ce
> *adev)  {
>       int i, r;
>
> -     if (amdgpu_aca_is_enabled(adev))
> -             amdgpu_cper_fini(adev);
> +     amdgpu_cper_fini(adev);
>
>       if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
>               amdgpu_virt_release_ras_err_handler_data(adev);
> --
> 2.34.1

