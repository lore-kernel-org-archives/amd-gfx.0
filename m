Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F636CCD199
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 13:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDC3D10EC17;
	Fri, 17 Oct 2025 13:42:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qeJVSrTO";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3143D10EC17
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 13:41:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TeWi6IbIFUWQyWAyJ1SEpNt9nFarp0toRlj2mzfP/zLqwA7MCijUAAvflmoD7QQQ+BRAlAkJ6XYsKs19ZaylSl/pCgXHJiUVGvUwnkkjUftCHrAEXILdeCoEFRi/zEstOL3vssNUVXKBkTqb/B/O745PFca50Z/jrCgEMHOKS/qqeI71tJlFVFLEQ4IcMKcEb1VRlRsjl7zTSdPVVpEd0DJT+SMNeK2e4CurCBU90DApvUQlXnU8yWAvpxd5Oo7PgG7tnmRlakUQIdDnKiSyokahuyuJr8ryUC+G60ERzaY9r3JvOS793HnssvRjHNneYH0PiUJOX2KkpmQT8B1ESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTY9TfG+skYBQuzCT1Q4Pls+COJks0OezCVHP+25Gi4=;
 b=x7HY/a/Lr1BhDikhKqzmSJMkRmMv43Fy8A0g8e34+F5mpQszSBTQS5yb/vn2H2j31qbb/+N9eyPV4dBxiQYDc4+LuAXzsUXeNwcUVRUUhmoCjOZXLoSNJ3PyJL0rbPUflC0qC3q8J6s+VQLixebZxgM3ZKbF+az1aubtWyxKK2WXxh7VYVVYXKzRu0b4afOq6wmg/VimV3g/tm6Ef6Y3/0j8jq0MLFsgrzPVLWGxxVv/5BL9zzjBMweyWmGS0Mf2YRlwNH3153qneoRy+fxyBJtc8YUFWtHmEBX/nq3ux/rK8qjkYeNQIqmdSZUM/lgeTIRWBL8ikAdVzBqTi0+SPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTY9TfG+skYBQuzCT1Q4Pls+COJks0OezCVHP+25Gi4=;
 b=qeJVSrTOvHaOyOsUqPEqNlDA56YbI90+kQY2SXvVIXxoD1Wpz+hdbZgR39ERDyigmsfptpr8cTJFuyDnexUrFack5mry/do0hBu+jFiW2W2Zo1zlxPylK7IWEfaPh5NxDBG/FzI8940fQBCAEMjSoCJoemIBnUx3USDVmmkZZXQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MW4PR12MB7287.namprd12.prod.outlook.com (2603:10b6:303:22c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 13:41:51 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.9228.009; Fri, 17 Oct 2025
 13:41:51 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/display: pause the workload setting in dm
Thread-Topic: [PATCH] drm/amd/display: pause the workload setting in dm
Thread-Index: AQHcP2aKn5F8/QfZwkGiR0YEeaA5ZrTGWBuA
Date: Fri, 17 Oct 2025 13:41:50 +0000
Message-ID: <BL1PR12MB51442956BC5EA7E1562269A9F7F6A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20251017130401.3196276-1-kevinyang.wang@amd.com>
In-Reply-To: <20251017130401.3196276-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-17T13:39:34.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MW4PR12MB7287:EE_
x-ms-office365-filtering-correlation-id: 0e11b851-a3cb-4263-1aff-08de0d82ed3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?RU5Nge8QlkOkspG0Mulkk3Cftyt17v8DTWt9tJQFpfTRx/L2lEOyKZSSsjBC?=
 =?us-ascii?Q?SMAgs/k0to9GkRxl7tQKyN46NbhCsh2eIlIsE6Lsgk5k76CF77SE0z3QeXjW?=
 =?us-ascii?Q?lnadkOtdIbfywy5aGyeAqjWjV5GPByLwiA0yZ8j15hAh1BQbdnTRclr5eMbs?=
 =?us-ascii?Q?rPZD1bF0y0zMsqhgwTheKtlQ+sO4lU/Y5PnTgUc092+EPIJ/DhXSHgOJEEfH?=
 =?us-ascii?Q?8qYFYSiqwwycu1y06svhBDbZJ+G4qZ3DfJws8xJWyMsw7uSLWDdmZB7QihUZ?=
 =?us-ascii?Q?xoaHb4+uW45EAUa0jv7RUqWmzTMKzfAsObnJMpQlPUtflbpZ+LN76gnJvxEa?=
 =?us-ascii?Q?3+mrS1mwmW0Du9avgbPRGfx2X/JrKrI4dppCMqGXDP4AbCPyAIIZaT0+97k9?=
 =?us-ascii?Q?K/VjwYxzVowsrMrEF1gl/ZA3km+KvN043CbPkZ97/wjbOQNjlKaATSKteW5Q?=
 =?us-ascii?Q?gZaLctwB3/vwSOoYoKB4CPBDJIzsm9tDHbVT60+puSePlUejnR0h6pvceF03?=
 =?us-ascii?Q?V88y15tp6V5sabepIvZyNEuT65MTbe83lEEj/wBFsuggeLiTDD+XR56bXWnu?=
 =?us-ascii?Q?vchr+Xfyjf2s/Zs+w8z7/ApvHmtYa+qFplXMrQSFiH4xnyPS0XhNLHy6Pq2J?=
 =?us-ascii?Q?EFcPhw64DbehJ0jMb0WTpQGPj2VVzPbhD+0iqeM4v4/AGyyBDaKuNQwrGsT8?=
 =?us-ascii?Q?5+4r69wzCut6L4YP5VYwek6iIvJ99fPxoX/rMBM1LRUfkZW6EJl63HF4ogha?=
 =?us-ascii?Q?N1tu9mFgq6aJZCfacawhOXbL/SSllflb6MvXv/c2egrXaVylW43XNnDrJ4/y?=
 =?us-ascii?Q?rbeYjXz3BLg9yCMOHzVp/KcbYZ3S2do9vr0P14iMkswi/1TfugYvLOLAcp9M?=
 =?us-ascii?Q?ZenM/THrCQ4Cf92nAJqDZFbWAMZD2royDiaTwpQRQppGFgInwNmPla2icwOQ?=
 =?us-ascii?Q?GavCVehVJqzplDEhpX6gUh1DIX5UtS4gZxk19oUwT4/ClZkNsHKeI9Bgv6lc?=
 =?us-ascii?Q?cQJMjvjBq6Dtyf6xa89ty8uas8ZUFFNuI/hkwEGwCaLw4NAHUFsFxI/vM6DB?=
 =?us-ascii?Q?ztNwfifeT+kn7UHv/Gj1PpmmWNJiqdBY3oTYQtXSFVIG1mwhMJ0BLnxf1i7f?=
 =?us-ascii?Q?jIJLeAEVVyXx3o6m5LOUJX2/8+lHdcQu8+syUQaIAy330UYGHuLmrH91AcYc?=
 =?us-ascii?Q?VwWt36gAJQxvHbXpMTKV11x2qD6CwswWyEzUENy/6ow/01BkAKHJN6Fu/DLa?=
 =?us-ascii?Q?QdOiqgmupl922ZcAzjUnM7dsRBAnqPsvo+pWzYqbdG6LutRNJbYTTKWl6XRr?=
 =?us-ascii?Q?HbM++eLuIrgm5iK0blr6vutJ2GTSIa/16lnSCVlCXtUjDLk+FmfLADnSPCUs?=
 =?us-ascii?Q?5t6UWtJGE+jEfK5xTG2BEN66oeVZ2mE4/qEQJdEF5Y+VZuOJSBzaQhnxOo/G?=
 =?us-ascii?Q?/Z6SOl6X0fOtNTYXR3nHVGVaHd7C+UYc1k7q8lsOJVkyc8WcfbZu1ZrPbiWT?=
 =?us-ascii?Q?LbYebm8vNOnBKWS4fhnSt1DTX8G0CKzLhw0f?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JjDhhqJ6BhNDdr7Z6nQiRs79lw2pLrIYnyUCuq/rTFuaDsYUBDG6yoxAmPAS?=
 =?us-ascii?Q?s8DwDdmBqlrOP4ycowecazHOWOtdYLbuhboRbGT4WcYt5+yXv0DY+2Cg+ekY?=
 =?us-ascii?Q?A8XpaiLPoac/24f9bGkdDZ5rsmbXaQcUKMnITLtB/ewv7+oJ40XIRYMjSCp9?=
 =?us-ascii?Q?/2m4Pgxl6qNwcTkH8ExHlS9BEgNmQYNEphSVGHLKXdu+42htpJcTm2D/gcGR?=
 =?us-ascii?Q?lNnb2tNUu+QDnLOgH0yepQ6o5mpiJ4aejfKTHvf0KjqzUD5diZhNW0sWwGe/?=
 =?us-ascii?Q?u7JGUOWiWzicEqfDN2S7ZJQICa/6Fv0z51PN4oSMaWyhZEUU8yZ1MSA3HjQI?=
 =?us-ascii?Q?vjkjSLTHajEvzA343NcQB38xXyHHBqLdhp/s6AmCVWLGWLXQneiAgKgnxaRd?=
 =?us-ascii?Q?GveIy6CKXx/LPUtgcVZtBpmr7CYwlOO5lL4p4ZrXq2GXFWPmFXqwVXlOIg7L?=
 =?us-ascii?Q?3fQN3OzyQBMIaB2bf6w3nUgk8jwGMHd2rvBvQGHI0a7jHvTlaUH9uMe61VVM?=
 =?us-ascii?Q?XGq0i/zeKO+BHC+1bVkin0FeFCD0INoJHHoOCzmyBpch4/8MeaU5MY0XJz47?=
 =?us-ascii?Q?wVuBfoYgTHMSAVMAUsyNOWlV3WvOFS3YhHnoUWk+O1b4UhFjnrgAoGZoAyxq?=
 =?us-ascii?Q?rNcvixcEAETPB6pv70HEt03swLnNaH2PExq9jwQ/8DZEUoUNZnT0sY47OtWe?=
 =?us-ascii?Q?ExpnYdqLEBme6mAPiIp0eqguEbgYsC2+HKUKIGpTpiCWIXofag3096Ah/jyt?=
 =?us-ascii?Q?UR74x+h1iDzpy3W9RW1rPCyLGsdUZqg6uouL6CuZ0T7XHq0h1cqykytWs9jX?=
 =?us-ascii?Q?LRdP81Fi+Iy0PwU1eFUuVRqsSDXQqtzoxsrlbuffVOkhizvhP07r1j2ZEAoN?=
 =?us-ascii?Q?YKEJjohOaryff3YjGY0XWRWFvgKH1yiDWvujyoqdhFuwma9wnZBj8l91rPUM?=
 =?us-ascii?Q?cv0giSU06ZgEWUaMR43+xkFTcUW+zTks3lzGegbHqA88GbLcTMXWujRJW1GW?=
 =?us-ascii?Q?0+ZjbcIZf/Fjh/48elCo3jHYA1YDkJqla6yrOE+LeOUDU0kq594PmqvOH98b?=
 =?us-ascii?Q?92II9zfgixnGqzH6Ek2hQiRVn27ZVTHutHyl1+6uv4MB+WtpmE2JHzyGBD/3?=
 =?us-ascii?Q?lVwlsI6BEtvqXktqSI8IIQaY+T1r297WGFtKZtHn/l/wwiYR26y/4AFg/dLi?=
 =?us-ascii?Q?9V86A8XWptotBMlovJScBPwwx/VeKaDcPZpoq7ocO1L5Xg9cnP1HtWjmiVte?=
 =?us-ascii?Q?LpR/WfW1WPzzQKVh+kqduCFKkbczArARxR+pGQiUPMHQi6RhcYTx+dPfLDBJ?=
 =?us-ascii?Q?Cl5gFc3c+aKF7kIJ10NYayRxvrpR9eng/pFuz6+iodtzQFEG5DxXMvW8Ehxn?=
 =?us-ascii?Q?W79A5WOtz9lA7Px8GHfHrFjtytJwX3CJAHgqpuREE6a3nVCr1Gr5GCMJuHhp?=
 =?us-ascii?Q?5RsF7dq6EELym3kCPgSK8pdLqzCMcQBqP8B/6gzCnL3+vgA0UiAxq/lghSUF?=
 =?us-ascii?Q?OMA12I+GiAcHxaHqNWKOfCFKkvPAAiWuhs2rLncp0GmIITHLTbfj5AW+gRat?=
 =?us-ascii?Q?wImHljTNx4JiBWpA7R8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e11b851-a3cb-4263-1aff-08de0d82ed3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 13:41:51.0008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2PdgGgYYKTU4BhZeCGFIqp9yzBUMcdpuB+Rqai05KadK/pieu1Tsfv++Y75s+9HAI088OsOEV14W301oU8cG0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7287
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

[Public]

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Friday, October 17, 2025 9:04 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amd/display: pause the workload setting in dm
>
> From: Kenneth Feng <kenneth.feng@amd.com>
>
> v1:
> Pause the workload setting in dm when doinn idle optimization
>
> v2:
> Rebase patch to latest kernel code base (kernel 6.16)
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Is the issue with that particular monitor resolved?  Do we know what caused=
 it?

Alex

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 1ec9d03ad747..f08121a2b838 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -248,6 +248,8 @@ static void amdgpu_dm_crtc_vblank_control_worker(stru=
ct
> work_struct *work)
>       struct vblank_control_work *vblank_work =3D
>               container_of(work, struct vblank_control_work, work);
>       struct amdgpu_display_manager *dm =3D vblank_work->dm;
> +     struct amdgpu_device *adev =3D drm_to_adev(dm->ddev);
> +     int r;
>
>       mutex_lock(&dm->dc_lock);
>
> @@ -277,7 +279,16 @@ static void
> amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
>
>       if (dm->active_vblank_irq_count =3D=3D 0) {
>               dc_post_update_surfaces_to_stream(dm->dc);
> +
> +             r =3D amdgpu_dpm_pause_power_profile(adev, true);
> +             if (r)
> +                     dev_warn(adev->dev, "failed to set default power pr=
ofile
> mode\n");
> +
>               dc_allow_idle_optimizations(dm->dc, true);
> +
> +             r =3D amdgpu_dpm_pause_power_profile(adev, false);
> +             if (r)
> +                     dev_warn(adev->dev, "failed to restore the power pr=
ofile
> mode\n");
>       }
>
>       mutex_unlock(&dm->dc_lock);
> --
> 2.34.1

