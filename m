Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A326ACC6B19
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 03:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CCC410E1E7;
	Wed, 14 Oct 2026 03:09:40 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5F4610E1E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 03:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+e7bjrJLwH6L22IVycu9Z5YTWzpMddnm/f+WSKK5ErtaxmP6EyLKIJoNwjKUSQHr7Mvim3bVdQhiQzoxQoMVqPy46M/JXdWpB1YKgVftRAkgS8JhzV7iha6HFzcyNEOCgBvCnBt/3FpPaoqUD23NJUVj9duqc4ACHyLN0uQNvn/1TXP9zSeni1u94GQWRbAngzL8XlUki6O1LGd4XK3Wcv6zsTDmxlfH2qXca81UzU/mNalci1IYcEsZRAeWsFbR9wCASmLeF+6X9Fxfo6eW7Ppg9eH0xbWimgMQa6W1fUjV/gd7mq00JWLe8HRFWsyUlayzevSom2+kPa03wWSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jH//XT6/WNXWsDOZhGZHLay/V0MxNbbQ4l6dOkCH7p8=;
 b=c8bmVAlKVXvIPh8SeJeC/c5JrMeIZGrqKwHKMxpg9w733zd2hCXbFSJpRdU7kY2Gbisby/AZaVldtiWBsDo8jxCW/zhKE7vSaZRsbjK7kHdxQ7br0tgjdMJLNe2H8X7pSXcEHF/55s1trW1DR5eIx7zC4dLLhtwNMXCAK3mPq88WT4OvaV8BWecsM2uoOeVfrlCM1SnPecsrCnhpd8Rc176Zak9R8bmjTygdk3v4El6uw/9HmP28A3J8xTUaFst6KKuvCUSEDVMYIddqwNIBg0ZkLalpbERLo5j0txmUu9QR0IdJPeGeXiIqVDlJ0wUzaerTdBuFQOs/njdsi1mzSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jH//XT6/WNXWsDOZhGZHLay/V0MxNbbQ4l6dOkCH7p8=;
 b=z1KAnYwy9HSmRQ0N/6m9gC0CrhjGe5TBuLrTg1rDGRHADJLjU9WS1IUE0gTfz6zvI7aqW78t8LDG7BsoQ4ngSJzF4aeU4/FEjpcsVd7ocHYnyYekq/vVyylP/LtgHFY5omc2PwRxl9A0JlnY+jwvMhvC+ErMkfRWHrkYEeWMLCE=
Received: from CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 03:09:29 +0000
Received: from CH2PR12MB4168.namprd12.prod.outlook.com
 ([fe80::762:c8d0:c9ed:ebcd]) by CH2PR12MB4168.namprd12.prod.outlook.com
 ([fe80::762:c8d0:c9ed:ebcd%5]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 03:09:29 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Russell, Kent" <Kent.Russell@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add log when register access is blocked in PTL
Thread-Topic: [PATCH] drm/amdgpu: Add log when register access is blocked in
 PTL
Thread-Index: AQHdWyPcwgq5Ez5g40+2WPR/H5CC87b8U/FA
Date: Wed, 14 Oct 2026 03:09:28 +0000
Message-ID: <CH2PR12MB4168A20F20C38E9732F2E57C9C9D2@CH2PR12MB4168.namprd12.prod.outlook.com>
References: <20261013150147.2896846-1-kent.russell@amd.com>
In-Reply-To: <20261013150147.2896846-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-14T02:38:35.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4168:EE_|DM6PR12MB4371:EE_
x-ms-office365-filtering-correlation-id: 0492b46d-bd5c-4964-2598-08df29a08f92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|10067099003|18002099003|22082099003|11063799006|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: Ofcj4xnjz4yBNqd6iiO9LTkyhb9nUV9rNlKgn5wNMp0FO16q+5utG0ePJKwtkJv4h+nmhJfreAfeYPeHSjfEtsGqbME2u6qVCAOfTsB46Ct05irrXFq12ooUMLYxoPXXJDQikIZKIc3ez/9LjdTMA0Ptjhj0UyCNJIECFjpz8QI49xRAV2fdlBwDsdlkIvnGDEifB/AA1LmO+StUZ/uCqnCI+HDtZxx/wGGGUjutziGGGEDz2zdsP8f2hiSUMd0LgN9A9kjY9a5Qstl9M+Xr5AUbvJfL3cVYnF/Tt9muPO587wjQ3Ul7/FLAR0OscEkjMjDNH3GMV79s7cpQf2gBtLmb0C5e49j1Zt+72i+16IGPg0ygpmRQZffREUzy9zvx5X0rb2Q4rSsjjlmSYwB9U5+KfxKPQwSLxRGVPJ4m9Ph8k+uDAKTeo5FINHW1luQaF3jEX04hPmritwIzf65t5zIxjy3LDWyDKlXm+xHGFV518gbFvsAJy4duRVyG/lW+3qN5/z0kTrdAuYhUI8SC5L+lYvXGFcYj7wDD89j0CyY+ybtqFH5tC92HLwxr8o7g62qXP/Uc/mghWruQ51BlYJzjolykhf/+G4ch+nvBVhyyYmIRXABRUl6Nj3rT6htyz3IPjDnCjwMD8lQI6vjWnlx9D6qQ7/mPr8bjyNZ1QyOlrdzOAOpQ2PXv36soLxttCqbWHureEeccAaGlQ1Lb6qwDdGNpS6cqaBCfEG8ck8U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4168.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M5pEgdQ3Z2++ZRVuM7L2CAFU24pKMs8In4drS8lFyoFr3rYVGaimghMdXrF0?=
 =?us-ascii?Q?uO3LcF5N27BA/7BYbbA/0+60XeKnoy5qFlB4m+/P70UnAX2HlwzhPRo9kJSG?=
 =?us-ascii?Q?xiH3acBRB/sSy+kHXbNwPK6vPh5eNIxo0aqvL0rm9AW1FDn9I+5HyA0+Swpx?=
 =?us-ascii?Q?/wTyS0et0yfvjokGIg7fq1tPdEpYKKNA23xnxEx+vExRsF98CAInvbG6mH4B?=
 =?us-ascii?Q?+9kizfkIraQW8gSKlTze22E8VqFi8WSUvxjTNFMlABJy1lw3VWmLBFjamB9I?=
 =?us-ascii?Q?agOqsTygAamX/xbe1yl6p3VIutGHnsNdOxOxI6c2yZVx5ftvfKUzUyHXy5td?=
 =?us-ascii?Q?1BVaQvfTCpAYVsWbgmHmbH4hfvz4sbP9tLeIYBHcGh2xFUXgYE4agOgyL2hl?=
 =?us-ascii?Q?FA3javKpCfcw9V1Jkm8J2FT45hiolW8Pl0RrXJZeHknGqptngVvadNy4gDZW?=
 =?us-ascii?Q?9q1RxXcZfNHGi/f7KWIGCsPC/A7eMomDP0NUPI64m41+r1wrQrcZj6g1bFog?=
 =?us-ascii?Q?kR4YcYI9iCN+Az3OXQn8PiviCNIjMeDusxr+KjU89woJvPGM+AH7LJh1b+oq?=
 =?us-ascii?Q?InReAd89UNEv17iYh9XsSi0aXPqrVTJpjrGvI2rl/CMVnlNQfq0HNj9EANPF?=
 =?us-ascii?Q?BXxLplQ6aDamWddg6XHj2G18VprVd/zCvRsGbXkcomlwBeIowGpeKhOEtzfm?=
 =?us-ascii?Q?XLbQQTHAcSnnAhG/jzePnHJF4GeD6JcECAA4YTtBsYgHPuSjN1LOdnQZkhCq?=
 =?us-ascii?Q?jbH1tK3uXwknhmRUY+QstBGyJJr1wyV20BgyRNwnkhmsso/t6TrjixKZhg0y?=
 =?us-ascii?Q?VFNIDcniODMLDGoDB592706p6Oc060wziB9ZyD3yetYRvcK+Lc/2JfVDHXqa?=
 =?us-ascii?Q?VMcjjzTvnEskwmE9P9pGekgJdyVUocQuvRAkzW/M3u4UgutjzdBKuaxZ8iO/?=
 =?us-ascii?Q?E9bTn4s9TW6ZCmInrtZqiCD1BsdH3crU4QICi749Yz2h8f0h3yuSEiAZg9yE?=
 =?us-ascii?Q?wLyLl2dXHoh30EWDoSWFJqdIbPWrLBtE42kE5owsbxMdZ17uKyrJJSEaqonp?=
 =?us-ascii?Q?iJ2+ID4385P77SggDk7aQurgpHPXkvS3rgi8eKZYYzMAQHtTYLAWGhrbHQ34?=
 =?us-ascii?Q?8VlP9I/VggpqQNleVNakGQICMWS9D9SeK7t48wG8eYfXHd41qRsUj4NTilIr?=
 =?us-ascii?Q?icLJ3s29OgyKzK5XZkzFWzevDs9c6hl1C8rNc1QBy27mNZ6v4k2+32ccl69U?=
 =?us-ascii?Q?Yhcz1/6vHcwlyDjbkItjg9qQvIrhPAbfG4habv6mASqVZhvGUm/dE2AZMEUX?=
 =?us-ascii?Q?vkUoBlGAW5JXUVf2j2KTgNujesAzHkWSDcehPZTQYBNYdul3vCGvdy8/YVQa?=
 =?us-ascii?Q?qF5O4Y09Nf1uigG8upMuCeqs4DVvzKQnlUAAM20oj96RIEKM0sFFwiWnOSsD?=
 =?us-ascii?Q?lYJWOzTVV6GWJb5P9HUOMDZSgZtrNwTL6zMSKHLxAhyTL8NqRQH4YRV68tpk?=
 =?us-ascii?Q?5OHwks2x83UEt7DH6ATO5u+3v4OzIKZ1ORwz3LChnSQeTeO06fXrsBq+JDrs?=
 =?us-ascii?Q?g8betp6CBqmqTfsXBTMth641DbM47de0qFbfdy4VPlNJbKX1KDyXhvBtOQzh?=
 =?us-ascii?Q?v3xpdbhEgV5xMxtPyQAufRmWBE63w7S8/VtzY1kjvPE8F5fA5b2yPGIDJvUo?=
 =?us-ascii?Q?Q44kMavgQHyFUZHfmiNZx5snBaC38Kci69Z46YEyC2Ew5sI4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0492b46d-bd5c-4964-2598-08df29a08f92
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 03:09:28.9709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YKshj8TQDHwmn9uuvsrhKNh7VKuWZ4rEsm7TT5eh1ypxUGY4dHzY9nVas2auy2R1+d8aanZihsdhR0+lNVblSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371
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

AMD General

Hi Kent,

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent
> Russell
> Sent: Tuesday, October 13, 2026 11:02 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: [PATCH] drm/amdgpu: Add log when register access is blocked in P=
TL
>
> PTL will limit access to specific registers. Instead of silently dropping=
 these attempts,
> log them in dmesg for reference. Also add a dev_debug option to show what
> pasid/addr/packet type failed.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 34 +++++++++
>  .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 76 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/soc15_int.h        |  1 +
>  3 files changed, 111 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 3572eb9b5758..1ce8313e3c26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -171,6 +171,7 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_devic=
e
> *adev,
>                               struct amdgpu_cu_info *cu_info);
>  static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int
> xcc_id);  static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device
> *adev, int xcc_id);
> +static void gfx_v9_4_3_enable_ptl_skip_interrupt(struct amdgpu_device
> +*adev);
>
>  static void gfx_v9_4_3_kiq_set_resources(struct amdgpu_ring *kiq_ring,
>                               uint64_t queue_mask)
> @@ -2661,6 +2662,7 @@ static int gfx_v9_4_3_early_init(struct amdgpu_ip_b=
lock
> *ip_block)  static int gfx_v9_4_3_late_init(struct amdgpu_ip_block *ip_bl=
ock)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
> +     struct amdgpu_ptl *ptl =3D &adev->psp.ptl;
>
>       if (adev->gfx.ras &&
>           adev->gfx.ras->enable_watchdog_timer)
> @@ -2668,6 +2670,10 @@ static int gfx_v9_4_3_late_init(struct amdgpu_ip_b=
lock
> *ip_block)
>
>       gfx_v9_4_3_ptl_hw_init(adev);

Could this be moved into gfx_v9_4_3_ptl_hw_init()? That function already
owns the PTL control flow, so the interrupt enable would sit with the
rest of the PTL setup and follow the same PTL state checks.

>
> +     /* Enable PTL register skip notifications if PTL is supported */
> +     if (ptl->hw_supported_state =3D=3D AMDGPU_PTL_HW_SUPPORTED)
> +             gfx_v9_4_3_enable_ptl_skip_interrupt(adev);
> +

Also, older MEC firmware doesn't support the PTL register-skip
notification. Please gate the enable on a minimum MEC firmware version
(e.g. adev->gfx.mec_fw_version), so we don't turn on GENERIC1 or decode
src_id 177 as a PTL event on firmware that doesn't send it.

Thanks.

Perry.

>       return 0;
>  }
>
> @@ -3327,6 +3333,34 @@ static int gfx_v9_4_3_set_bad_op_fault_state(struc=
t
> amdgpu_device *adev,
>       return 0;
>  }
>
> +/*
> + * Enable GENERIC1 interrupt (bit 30) for PTL register skip notification=
s.
> + * When FW skips a privileged register access due to PTL, it signals
> +via
> + * GENERIC1 and KFD receives interrupt source 177 with skip details.
> + */
> +static void gfx_v9_4_3_enable_ptl_skip_interrupt(struct amdgpu_device
> +*adev) {
> +     u32 mec_int_cntl_reg, mec_int_cntl;
> +     int i, j, k, num_xcc;
> +
> +     num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> +     for (i =3D 0; i < num_xcc; i++) {
> +             for (j =3D 0; j < adev->gfx.mec.num_mec; j++) {
> +                     for (k =3D 0; k < adev->gfx.mec.num_pipe_per_mec; k=
++) {
> +                             mec_int_cntl_reg =3D
> gfx_v9_4_3_get_cpc_int_cntl(adev, i, j + 1, k);
> +
> +                             if (mec_int_cntl_reg) {
> +                                     mec_int_cntl =3D
> RREG32_XCC(mec_int_cntl_reg, i);
> +                                     mec_int_cntl =3D
> REG_SET_FIELD(mec_int_cntl,
> +                                                     CP_ME1_PIPE0_INT_CN=
TL,
> +                                                     GENERIC1_INT_ENABLE=
, 1);
> +                                     WREG32_XCC(mec_int_cntl_reg,
> mec_int_cntl, i);
> +                             }
> +                     }
> +             }
> +     }
> +}
> +
>  static int gfx_v9_4_3_set_priv_inst_fault_state(struct amdgpu_device *ad=
ev,
>                                             struct amdgpu_irq_src *source=
,
>                                             unsigned type,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index e241ad7d55df..8dee8c43824d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -123,6 +123,28 @@ enum SQ_INTERRUPT_ERROR_TYPE {  #define
> KFD_SQ_INT_DATA__ERR_TYPE_MASK 0xF00000  #define
> KFD_SQ_INT_DATA__ERR_TYPE__SHIFT 20
>
> +/*
> + * PTL (Peak TOPS Limiter) register skip notification.
> + * When FW skips a privileged register access, it sends interrupt 177
> + * with GENERIC1 and provides packet type info in CPC_INT_CNTX_ID[31:28]=
.
> + */
> +#define CPC_PTL_PACKET_TYPE_SET_UCONFIG_REG  1
> +#define CPC_PTL_PACKET_TYPE_SET_SH_REG               2
> +#define CPC_PTL_PACKET_TYPE_COPY_DATA_READ   3
> +#define CPC_PTL_PACKET_TYPE_COPY_DATA_WRITE  4
> +#define CPC_PTL_PACKET_TYPE_WRITE_DATA               5
> +#define CPC_PTL_PACKET_TYPE_COND_WRITE               6
> +#define CPC_PTL_PACKET_TYPE_WAIT_REG_MEM     7
> +#define CPC_PTL_PACKET_TYPE_WAIT_REG_MEM64   8
> +
> +/* CPC_INT_CNTX_ID[31:28]: packet type that was skipped */
> +#define CPC_INT_CNTX_ID__PACKET_TYPE__SHIFT  28
> +#define CPC_INT_CNTX_ID__PACKET_TYPE_MASK    0xF0000000
> +
> +/* CPC_INT_INFO[30:28]: queue ID */
> +#define CPC_INT_INFO__QUEUE_ID__SHIFT                28
> +#define CPC_INT_INFO__QUEUE_ID_MASK          0x70000000
> +
>  /*
>   * The debugger will send user data(m0) with PRIV=3D1 to indicate it req=
uires
>   * notification from the KFD with the following queue id (DOORBELL_ID) a=
nd @@ -
> 142,6 +164,30 @@ enum SQ_INTERRUPT_ERROR_TYPE {
>                               KFD_DEBUG_CP_BAD_OP_ECODE_MASK)
>       \
>                               >> KFD_DEBUG_CP_BAD_OP_ECODE_SHIFT)
>
> +static const char *cpc_packet_type_name(uint32_t packet_type) {
> +     switch (packet_type) {
> +     case CPC_PTL_PACKET_TYPE_SET_UCONFIG_REG:
> +             return "SET_UCONFIG_REG";
> +     case CPC_PTL_PACKET_TYPE_SET_SH_REG:
> +             return "SET_SH_REG";
> +     case CPC_PTL_PACKET_TYPE_COPY_DATA_READ:
> +             return "COPY_DATA_READ";
> +     case CPC_PTL_PACKET_TYPE_COPY_DATA_WRITE:
> +             return "COPY_DATA_WRITE";
> +     case CPC_PTL_PACKET_TYPE_WRITE_DATA:
> +             return "WRITE_DATA";
> +     case CPC_PTL_PACKET_TYPE_COND_WRITE:
> +             return "COND_WRITE";
> +     case CPC_PTL_PACKET_TYPE_WAIT_REG_MEM:
> +             return "WAIT_REG_MEM";
> +     case CPC_PTL_PACKET_TYPE_WAIT_REG_MEM64:
> +             return "WAIT_REG_MEM64";
> +     default:
> +             return "UNKNOWN";
> +     }
> +}
> +
>  static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>                               uint16_t pasid, uint16_t client_id)  { @@ -=
352,6 +398,8
> @@ static bool event_interrupt_isr_v9(struct kfd_node *dev,
>               source_id =3D=3D SOC15_INTSRC_SDMA_ECC ||
>               source_id =3D=3D SOC15_INTSRC_SQ_INTERRUPT_MSG ||
>               source_id =3D=3D SOC15_INTSRC_CP_BAD_OPCODE ||
> +             (client_id =3D=3D SOC15_IH_CLIENTID_GRBM_CP &&
> +              source_id =3D=3D SOC15_INTSRC_CP_PTL_REG_SKIP) ||
>               KFD_IRQ_IS_FENCE(client_id, source_id) ||
>               ((client_id =3D=3D SOC15_IH_CLIENTID_VMC ||
>               client_id =3D=3D SOC15_IH_CLIENTID_VMC1 || @@ -538,6 +586,3=
4
> @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
>                               KFD_DEBUG_DOORBELL_ID(context_id0),
>
>       KFD_EC_MASK(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0)),
>                               NULL, 0);
> +             } else if (source_id =3D=3D SOC15_INTSRC_CP_PTL_REG_SKIP) {
> +                     uint32_t packet_type, queue_id;
> +                     uint32_t skipped_addr;
> +
> +                     /*
> +                      * PTL (Peak TOPS Limiter) register skip notificati=
on.
> +                      * FW skipped a privileged register access and is n=
otifying
> KFD.
> +                      * Data from IH entry (not registers):
> +                      * - context_id0 contains CPC_INT_CNTX_ID with pack=
et
> type in [31:28]
> +                      * - context_id1 contains CPC_INT_INFO with queue I=
D in
> [30:28]
> +                      * - context_id2 contains CPC_INT_ADDR (skipped reg=
ister
> address)
> +                      * - PASID comes from CPC_INT_PASID (already extrac=
ted
> from IH entry)
> +                      */
> +                     skipped_addr =3D
> SOC15_CONTEXT_ID2_FROM_IH_ENTRY(ih_ring_entry);
> +
> +                     /* Extract packet type from CPC_INT_CNTX_ID[31:28] =
*/
> +                     packet_type =3D (context_id0 &
> CPC_INT_CNTX_ID__PACKET_TYPE_MASK) >>
> +
>       CPC_INT_CNTX_ID__PACKET_TYPE__SHIFT;
> +
> +                     /* Extract queue ID from CPC_INT_INFO[30:28] */
> +                     queue_id =3D (context_id1 &
> CPC_INT_INFO__QUEUE_ID_MASK) >>
> +                                     CPC_INT_INFO__QUEUE_ID__SHIFT;
> +
> +                     dev_info_ratelimited(dev->adev->dev,
> +                             "PTL: AQL request was rejected due to incom=
patible
> user input; please verify your PTL configuration.");
> +                     dev_dbg_ratelimited(dev->adev->dev,
> +                             "PTL: register access skipped - pasid 0x%x,
> queue %u, packet %s, addr 0x%x\n",
> +                             pasid, queue_id,
> cpc_packet_type_name(packet_type), skipped_addr);
>               }
>       } else if (client_id =3D=3D SOC15_IH_CLIENTID_SDMA0 ||
>                  client_id =3D=3D SOC15_IH_CLIENTID_SDMA1 || diff --git
> a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> index e5c0205f2618..736b02ccdefb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> +++ b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> @@ -25,6 +25,7 @@
>
>  #include "soc15_ih_clientid.h"
>
> +#define SOC15_INTSRC_CP_PTL_REG_SKIP 177
>  #define SOC15_INTSRC_CP_END_OF_PIPE  181
>  #define SOC15_INTSRC_CP_BAD_OPCODE   183
>  #define SOC15_INTSRC_SQ_INTERRUPT_MSG        239
> --
> 2.43.0

