Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B6BECE587
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EFE210E6A9;
	Mon,  9 Sep 2024 20:31:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NN2sqfDH";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4012710E6AA
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:31:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJdFixmFAYsW+/7DYOWxnARxMm3MsmDF95blpvi4KMLNTqW3SDGvC8c71U3z9vS+R+8SdfCeKQNLZD0kl1PscuU0sEsFDIUt7pt5eNBD5S7Pbs1xUsi0LZ8f/hUouzwvhZ9g9NGOv8/nubTDdRNHnStB0R50/ixxQY+0rAWO+2hHfLTfQ1vhwNrPCwTeA21dTEyrZL5D9sIC9LQhZ7YsPUZRcprjtv8kG8wjycLLq8Aqg5sPAgk1lezoRm9GhGcWDAq1nbiG3Hy37PuvfAeSOidbZO7nM3uaSV0cZY7HIJs8Qkrmon3WoA1v+ZPeyXiJt4I7SADrlo0fTBhyxlwjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISG3vKdNktSX3+CFZ5vQfyHMV6OBHHKCyGTQ3LQF3/E=;
 b=PYfxeM3L4LxO4g/MYUbev2JNdvCEltu7YovpjTS0JovWwkR+jMlo/t9Pi+6L3yhlLc5n+Bp7RAcdoRCXKuNgKCyn2lr+5nYqHJRfc3WDJ3srpBHrZc1WBdgh1FmmxMf47GVR4Fut8GN7rD73cpfeASZt5yaB+kL7G1ElZcy38Fv0jAcYWsvJTWnX/0FymZtXHruImT5AOeWBA9jSV87+uuzt1KApOczaXNxYepNlP1GeFdeCa+QCLqcPymqNBJx0aTNeFxwU8f47EFxS1jt/LZdC1QGRxB3rkDT1VgrjcXIJL8w6b//wZKr9Hwztwqm147aeELb8+rHY4tbEKuxphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISG3vKdNktSX3+CFZ5vQfyHMV6OBHHKCyGTQ3LQF3/E=;
 b=NN2sqfDHA70X6QHm98VW2XGUEt6x9apWBAVxS2nwIrJ6sq7IyDKFKR5U4OSG1Wz/KcMdvyZX4ji/1bwi7JSDPKNibyFzIoFb0QfEwOg7ML8D85AlfgJvgkZ5yt6GysCr7XCbMrwUvL5fiakQZtWMC9TpQGPK2vW2ze4bEV42xxc=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.32; Mon, 9 Sep 2024 20:31:02 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%7]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 20:31:02 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Jian, Jane" <Jane.Jian@amd.com>, "Lu, Victor
 Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix JPEG v4.0.3 register write
Thread-Topic: [PATCH] drm/amdgpu: Fix JPEG v4.0.3 register write
Thread-Index: AQHbADlKLVD0ioqSlUGwCX5l3NdwZbJP7dTg
Date: Mon, 9 Sep 2024 20:31:02 +0000
Message-ID: <DM8PR12MB53997CCFF42E05359F0F9796E5992@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20240906084618.2068168-1-lijo.lazar@amd.com>
In-Reply-To: <20240906084618.2068168-1-lijo.lazar@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b0491db5-7943-4f14-9752-f7784457dbe3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-09T20:30:41Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|DS0PR12MB6485:EE_
x-ms-office365-filtering-correlation-id: f109e466-8603-4dab-27e6-08dcd10e5272
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2/2BFZsxJD6Im0b/ZLRvzlwc0eKUi6o0zM5UU9EQabLuBLuJL8KKjGUX8jnf?=
 =?us-ascii?Q?93NevsgDmNQuCNeRvktSuv5lEjFEyS9W+53zvIMrfTh+1G5dGJqYKXvUb3y6?=
 =?us-ascii?Q?eJXaJePkmHUuL61GGyaGHUr2DD/Ul1OJGcHL+3xKSJmOnxNBqqsxrDNFX7Hy?=
 =?us-ascii?Q?yKErRCMjl2gVbu89boZUUW6u3EkxjmQUi9psbFKquCbkyP/UL2ljvRFY+oNH?=
 =?us-ascii?Q?ivuVdMM6u4ZgBuzUgh/dc6+6qpEOL3BnDPIJSm3xJJ8TMhlPE/VVf7hPpalS?=
 =?us-ascii?Q?jd06OZppIP2JlePcfjpsezJUBkTmdezq7D7xNLaGGWHbEBbRwbWRc9kH2P0I?=
 =?us-ascii?Q?w3UocF4rAMJbN+fKcx37YSJ7cWMDidJt95XlpmcZcFEnD6aLGqV0eU2Z4LBO?=
 =?us-ascii?Q?4R5X3/uzbfhKslG0aAVJeLI+6/kkVWOigjNacJvko+uLvI1WRsg5VWxZ8Z2m?=
 =?us-ascii?Q?LjvQxGExvu57evdS85Fjf1Hh0jLai0TQTDq/+BFTFaB799n0LI/+5JmEPoe2?=
 =?us-ascii?Q?LPYkieMxXGMWLK6fGjWdweCOe3PN6uQWrE4Y20sCtcAiHbB+05tNIbDoLakY?=
 =?us-ascii?Q?z3o/g9Xsg1zXuA9GpGKJsSrPC272JGAovn7tM5AjF7K1PRPtzA0QoCE3u+Wd?=
 =?us-ascii?Q?7KRXlqymurDQDX8VpTU8Ut7Tl5da1Qm1+k0VKMvDuzC70RiBlmQsYTYMoly0?=
 =?us-ascii?Q?XClL/rKxy4p6EW9cgYUWdwGAAKSHpI5sIJgImpFOfMmbY5m6oQskUVzr2pUM?=
 =?us-ascii?Q?GdWeH5r+Z+//ab02YpYHr0qD5yypjpxyiAZVH0Wslkw0Y+RmJDfr2Q/xL/Ly?=
 =?us-ascii?Q?LhMutg6Cl/x4y+HRjNV4UBdRaQ4WhaIDo0QEg9vSUbBgITg/SYZBOj4ZVfNX?=
 =?us-ascii?Q?L8pqTfM40uaw8BwkuxNdLdXsnsk6vo2mvh5DlbpiYcrdBiRNtEXVUix2xsC0?=
 =?us-ascii?Q?CKkujktfuJsJJqtK4Q4xUeSF0Kp463LRXPCofkHHSq2IcaqF/95JKRi3GLGx?=
 =?us-ascii?Q?BF1sIxT2+kMcBu5BeDFhq5ra14fHuW6j5VYWkuFRUxaxXWYqp550CjfmA4mM?=
 =?us-ascii?Q?XnWpDupHsxrKOCOhNOsLYmsdFitYHm57PnQTDkGYnV3/OCNlrZ/CekOOOFzC?=
 =?us-ascii?Q?v4DE0O55wARj+Nsfqod1S0UN5s68cXjC1l8yc2e6WDD14MZAUj2tEXf2yc7b?=
 =?us-ascii?Q?B2vJEybTeEPT9R4ukfg8olOvyL2EJgK0Pxg49H/quxkz3asoiXMKLcqvHsji?=
 =?us-ascii?Q?Pa+XEmU4cfSUFf2m1PMXCIlPrd/U6FApstTMKof+jcEyhbjX8yayxeUBh0aN?=
 =?us-ascii?Q?LRRtdiVP9N1hlyeq7dQMEVMAF/HcN4qogDTJCh3iAmMcI2IgmV+bFpuYIJnK?=
 =?us-ascii?Q?7aswz9rVXpJNrG9EriBFy0cL/LfDsvsOtRH/TEBHisHwAcCmOQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0yZCUlKvN2Z7ssFD1Tc1XVRZSNF6oFkMTV6uhG279ugpMxlNJRket35LKMLT?=
 =?us-ascii?Q?V/pFhg8+mYyXbq6PB803qmsQidBKjopo5xGpFDosM9Zn2pie2ov6hA/a4E7v?=
 =?us-ascii?Q?w4+H1GFiDIvaj3XkZOYuddsw31+8BuWVMHr+dZ2vRkUt9wXGldDEB9jA9Zak?=
 =?us-ascii?Q?NFpDFpMIKLooeQDIfIUGMI3JRu88erIQEv1T4nZfLc3qgr9vXM8QK6MRseRr?=
 =?us-ascii?Q?1T3+PCMyiEnqW640gUtk1JYO/egwWHFm/YjwyqvhT8saHiJvvztVU0SkG1hE?=
 =?us-ascii?Q?Ma0QMkQRhfWM/eYBWdTC02aRIt4nJvJbJcA39Nd34+/nrvAERwRbSTplosCT?=
 =?us-ascii?Q?7XuYBs1IkssCaIamNOvunBcz2vYkzUtDmIJSNfKdyKr9Jv0pATCdxb/zPuXP?=
 =?us-ascii?Q?xq4kzJAWChJfZgIYF70onFf6+8ZUzYEaKgv37St7dAaWVpsdYZlfdihaDzP6?=
 =?us-ascii?Q?I9TiXY8xYyQ92a9jwPb8jDmn5UpRD8bw6b9WJPFpBKl9t/W0GcPfLmvxYqby?=
 =?us-ascii?Q?nviPkwjCoR3KF00J8H6O/4XWtGaZRXnxs7k5/Omi5wdjeqErqHFPAo30Yi4f?=
 =?us-ascii?Q?jOKrD7PX3qD0sDe/nIsdAbcV5PsTaseNGkhfJHPL0Q5VeDQap279c22ioXZf?=
 =?us-ascii?Q?gSYsA1jBRFXgpNB2j+g6PH2UbpJ33hBw4vUnxnDNlVyqNQdVA+1Bnq5stOmd?=
 =?us-ascii?Q?A25j1Bzw5zIuqiP+9jfIlsOK/+LWhgMD7XXOilQQdhG+2IztNZpXehN7wCdJ?=
 =?us-ascii?Q?3GDVvxmeJPdR72sAqhUqGpJgEtRBzmhUuoEbXjahlFWqNKrjBuevCG33hBWz?=
 =?us-ascii?Q?Ii4iMEE0sqpil4WObPvqFOac8t60aXow14DZLj3b57RQlWBTn2Oy/sERevlZ?=
 =?us-ascii?Q?YP2OZfmNGQ/S1DOxWoJpg5tY+YuTCXLKby/Gctl2Tbx0lZwjJXe5AUMnOGb4?=
 =?us-ascii?Q?C4axVrG0gqrPrBX72B0sdHidznKqvLTVFa7252I35sajyzF91JZEhsEeFsyQ?=
 =?us-ascii?Q?XqfjTpqj1A+gpYi4PIr+oCG6qUgxQILGaSEYYpzxfZcZBuGVCMoVbKnuDY45?=
 =?us-ascii?Q?PscaWXZkCBE9Q07Q2qLrE6rxdT7MJaUNi/QcQIc+ctecTWqSlaPRKJ4UDebR?=
 =?us-ascii?Q?M5FkSDJHcqfGuldKp39JZibg/xl/MJ+UQM7ppyq0bM8htR76qQ6ksk/Lzfw6?=
 =?us-ascii?Q?kfE6cWPIfx7p5+ySXYTObHqTNp7FBENeq3byIYB47RI7Y3QRTTvqBBMOjwVG?=
 =?us-ascii?Q?0FXTPpxf3ovPDGGVyT6STX6NMXTqKwX95AdGKhtdGZEjDK9Kj+IPZ7DaghOu?=
 =?us-ascii?Q?1tH1qXx6X0HIfVRN9jmzasAE72RxclXF3blAu4WZsdqBXg2oOvjSNw8AA3uL?=
 =?us-ascii?Q?sTc3Fo8SKF8YunavhKQRGsgwKY8H0ZCL/kVTfPlbLINk9WuBLtOKQDPTiHqS?=
 =?us-ascii?Q?s69+7tegDV+K5yem7I1RHMscUgxQ428ueTlBrIkNGkzUgLzF6pi/Ov0SDtJ2?=
 =?us-ascii?Q?RMah6VNqbt9yNuagRZgAry5oa7DLm/532kSFoyWZDmUILyoNn0SAdzSi8N2R?=
 =?us-ascii?Q?mNCpMt01V+cghkEEIDA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f109e466-8603-4dab-27e6-08dcd10e5272
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 20:31:02.2628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JInnxhzBzz0WxZuFEAeaAEQtTTAN+6ldZyt/z7utXV0+nGo+WJuQkiXKNxb1h9qN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485
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

Acked-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: September 6, 2024 4:46 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Jian, Jane
> <Jane.Jian@amd.com>; Lu, Victor Cheng Chi (Victor)
> <VictorChengChi.Lu@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix JPEG v4.0.3 register write
>
> EXTERNAL_REG_INTERNAL_OFFSET/EXTERNAL_REG_WRITE_ADDR should be
> used in pairs. If an external register shoudln't be written, both packets
> shouldn't be sent.
>
> Fixes: a78b48146972 ("drm/amdgpu: Skip PCTL0_MMHUB_DEEPSLEEP_IB
> write in
> jpegv4.0.3 under SRIOV")
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index a4ebceaaa09c..8d6a8c66da18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -674,11 +674,12 @@ void jpeg_v4_0_3_dec_ring_insert_start(struct
> amdgpu_ring *ring)
>               amdgpu_ring_write(ring,
> PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
>                       0, 0, PACKETJ_TYPE0));
>               amdgpu_ring_write(ring, 0x62a04); /*
> PCTL0_MMHUB_DEEPSLEEP_IB */
> -     }
>
> -     amdgpu_ring_write(ring,
> PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
> -             0, 0, PACKETJ_TYPE0));
> -     amdgpu_ring_write(ring, 0x80004000);
> +             amdgpu_ring_write(ring,
> +
> PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR, 0,
> +                                       0, PACKETJ_TYPE0));
> +             amdgpu_ring_write(ring, 0x80004000);
> +     }
>  }
>
>  /**
> @@ -694,11 +695,12 @@ void jpeg_v4_0_3_dec_ring_insert_end(struct
> amdgpu_ring *ring)
>               amdgpu_ring_write(ring,
> PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
>                       0, 0, PACKETJ_TYPE0));
>               amdgpu_ring_write(ring, 0x62a04);
> -     }
>
> -     amdgpu_ring_write(ring,
> PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
> -             0, 0, PACKETJ_TYPE0));
> -     amdgpu_ring_write(ring, 0x00004000);
> +             amdgpu_ring_write(ring,
> +
> PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR, 0,
> +                                       0, PACKETJ_TYPE0));
> +             amdgpu_ring_write(ring, 0x00004000);
> +     }
>  }
>
>  /**
> --
> 2.25.1

