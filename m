Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B32D6C285
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 18:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8C6610E2BE;
	Tue, 19 Nov 2024 18:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ukdSW9ug";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E1CC10E2BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 18:29:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5RVzDyoA/Z4z9Q9UoQO/NtBKQhHgqjMo6jv7fy+HttqzZQ+Pt9FMuxinNrVFXhLOWNUdZ+mqFwVlC6H6KZaHOlrnRpxkxfqDdDUVR9JBiaavK0rBYrOv+2OiwZgymog2kEfBQgQ/7v+Q8Cppy72nfftyTYIbLckcKaWbCd7E8kwpuEFvW7aimVs+TD3Xbr3DQAY/0ojsGY3rksmDX1NcTsM1tKULlTjJod2klJxhajyOPOmCHYgme00hEtkCF9bFIO7WLbC50cULDTEhhOQif5VlsUlWZlXneiyu05gmhX24W+MEJkDzfehAX45we0tSgBR6+iqI0VCtZsrvaJPTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtgbU2Oye8FUJ/+m5J6vxLvcu85DneHkluUTFzazHes=;
 b=IZpwemSTNVgBZfdMGQGzzczUlIJpOdPzGdYmeMyPx1VN6kJ6JmVpRaUohWDiLV4KsvGLYXMP8802/9p/6FgJK7XZL7bLz8J339qAPgCH4za6lA6LmaBve54rE8pAnOgsIkcucFZxkWvFhgjw5PELqxfNr99HwHkheEd6dLbm+lHVwXR/NXrxdtjhRfa5OhtKOpHK7PHmhe6nOCvweS2grWEs2uZu4B5cA9/R681rg4Zf34yBHHUpv/70uzMk1oD4Nyy9OzZEEl5LYXK8fN/zj0tDHmtYqTiWrcvdBJWKnWxPzXKaWNpGANim4clN7YKYLX3/tDMOq+/MwWkLq2s4cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtgbU2Oye8FUJ/+m5J6vxLvcu85DneHkluUTFzazHes=;
 b=ukdSW9ug3qNK9ZeEVEdDgcN7YJEiR3fUd/EvhH1IVcueDYa0CRzR7hiL6w0anJ+RtuQ2dsmHbWW7VekND9WYwpyg41FNvz69zjqwPVbdKoesHBjnMmcWZwpsLja01k+7QhP/rgbwClcA5vrK56mrHeWShMm0zzcE5DQ20qaVnf8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Tue, 19 Nov
 2024 18:29:04 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%5]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 18:29:04 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: reduce the mmio writes in kiq setting
Thread-Topic: [PATCH] drm/amdgpu: reduce the mmio writes in kiq setting
Thread-Index: AQHbNzn0TKw1fcSmdkyKdqrTPd1yrbK+8tIJ
Date: Tue, 19 Nov 2024 18:29:04 +0000
Message-ID: <BL1PR12MB51448295DDBC844F44F4ADB4F7202@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20241115083943.284924-1-Prike.Liang@amd.com>
In-Reply-To: <20241115083943.284924-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-11-19T18:29:04.409Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ2PR12MB7865:EE_
x-ms-office365-filtering-correlation-id: 7c28f934-0f65-4b38-1489-08dd08c80c36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?LhjMb8NG1rKi+73mhZQCuQCT89skLNqD9lD8gqtE1ePNb2c0s5sZuKMYPSFx?=
 =?us-ascii?Q?FWdIU82Mkh26vrH3KOLFjZN1oVyw+zLJZ31M6evk1r5Y/f0zXESkStRnc7Rx?=
 =?us-ascii?Q?xOO2rzhtRzd1+sRN+tEnw+IKke+w9pdW5Lz3UhEjzPy5rJ3p9gQSMy+yeY5x?=
 =?us-ascii?Q?SGJfjSQtBa4PbYKhC9pthBFmypbNQ2t1Erjt7LYegSo1OXBN3g2xz2BFDt9u?=
 =?us-ascii?Q?T/O+HYzuJOzIGP4QRY937JaIDWyF5ZBiZNwnPGBcTeAgYHZ11unOr25R2ioA?=
 =?us-ascii?Q?Eef3/PZpkDnmCYWW4NVL5ggwV3coQ8moO+vlQP2yA/AXXwqSi8X8+QMKAjOq?=
 =?us-ascii?Q?voWTUjs1RKJNCT/j84c3mFbMKdf8aMrni7Er3lOo+wrjWxe9/B/dl2K+zlYN?=
 =?us-ascii?Q?mv3JpmHSh47ROkgnYAE7xxHmG0jZrFVmDNRRCd6BNBsiJ4owEIh/hgSR3hRu?=
 =?us-ascii?Q?97yOjNvr5zPrhn1ESP7V673Phy+65Byi+z5lFkgB9NnJKw+42ye75U2z+xEp?=
 =?us-ascii?Q?8mqS3OCLbG+OOuxSIC9RJdJCLza3NdPYcN2oS3KEHmF8sabTFtMqiIEOiclo?=
 =?us-ascii?Q?WWPnBduPCa6vHRzkZeWIRRQPMSicv9+y1MTqhCbEHDDy9Ylu4vKKLmZBZbqy?=
 =?us-ascii?Q?lRutU5sCizBQ+d+fw0Oq4cB082LV3BhtsafeW84k8p5cmOZhdIwXx0TZs3x1?=
 =?us-ascii?Q?fELEgRamS54pYQ/jLgPE8NFylktt37VmSUgdT2AVFBMtdnVheQLIw2WRex55?=
 =?us-ascii?Q?85bBy9MqnUgoUB0bD1SSsnQnklhYjv17iWqL+SCvnKfyZQOr6H+gJ8rqGRnD?=
 =?us-ascii?Q?WGPaQRCETEdz8r7xDWynL4BJlmEhKM185aKD3OMxbxLKGY1qHkg2jB0K11Ny?=
 =?us-ascii?Q?SCr+nw5eIybPhlx9Yfa7EFmHUa36xwgF88mZ2s2TA9265seXgd4Sd8Btf7em?=
 =?us-ascii?Q?J7ZS9Xec5eVHZHWpHONbXLGAQNIGZbJdMjmYsF2ARuONV7F3q06ComCszkZO?=
 =?us-ascii?Q?GoAfthwPmHhF+i+RvS+/ZIt5xPCitP9FPIH5/ZChakUhYnwmE7rlPNXDOagY?=
 =?us-ascii?Q?soIc5L/7NB9YHXy+kzTgcso44CgIJBLHx0eMq4GCf/lDTBjmPNsFlmh6Zz2F?=
 =?us-ascii?Q?BYA801RxpUPxJk7nR3WrPhl0fiCJkVcbSccFNicIuvDFRmjBKoUXQASACQ3S?=
 =?us-ascii?Q?5O3dG+IefKCjvO5Fmo6SG/quSSIB+hcGVRfgwa6++GMT9Ro2d53VnzdU1yT5?=
 =?us-ascii?Q?9RexJIez17268RUBy/SH1GI2X+n2z+0lVyZ2ypk6HJQUqnGBpoIYPkTR6IB8?=
 =?us-ascii?Q?dvhVNSkX4A58Bef2759IDDTJfKyXpxHok8aS0tBwYqrD+cvg7EZo8YJ5Qj3K?=
 =?us-ascii?Q?Tya4nI8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/PpkLJ6T6eT++1Eu/HQvTmlIh6OA/IP61JCx6TPHGXIAziawCAjamNvX9wAU?=
 =?us-ascii?Q?jgCWvRgcDmDgFVzDENHkhGPWpFB+3NpY87ZikoKUR20UIxAy26iNB1yYa70P?=
 =?us-ascii?Q?c9gTBkdg8yNU478IiD7NpSuAGUt6f1bTBpSXMwpQHDUd4DtQ7bPvP6sU91Vv?=
 =?us-ascii?Q?YcLSwhz7LTQMngJivhZ9Ce/rJalxeD2XpeKzjrjI524I4Y9Vlcpl88c5Eyo3?=
 =?us-ascii?Q?wRCsiv2CQO+2+J0hJ5jls5+7TwjRB34LLmhtw5FrJd6sqedUQRWHLBJp8EnO?=
 =?us-ascii?Q?fkfU6aUgQ7NuhVmWahfdn0LhOWuw0xpnDxIQmCxqTWIotZG88JjchO4FwWGY?=
 =?us-ascii?Q?v0bBn2iSX7V8gIMxElQUyvTXRsp41Yn/Wf5JtvQJnMPg3Tg2nuBEUjmjw+Hg?=
 =?us-ascii?Q?V27ZTHEywyMXTveEDMCvQVpiftDEZ2QoSTYBQb1FAiStbMWiee3jc8ibOdIY?=
 =?us-ascii?Q?HhFrIVLqdYX+kVaD2VHsEfKqI1u+AVC03GLH1PdWj0XnhTN9RsuNWU0Zqszi?=
 =?us-ascii?Q?MNhTLH4yhsPeiQYOSa8RufD0HQ4+heRWJJzwbOLAUtJ6B1lOn1yAgUmqWiMb?=
 =?us-ascii?Q?oaW5VD6+LnVKzHnbTl3jMFXY5g47DrWGL2tOlgLdUZVRb/jZ8iM/IPV35/AQ?=
 =?us-ascii?Q?JPqvFYhEusbj18VrmXP7jXWdbAEEN/pY7T2d3VL78zR71omvXElRIC/Zv0qW?=
 =?us-ascii?Q?EE8nBzAtNOGzzQ/xxl10jEYFZ+LqHa3MDPiR511SeZQZRV4bAFk9KGhvVWaz?=
 =?us-ascii?Q?m4jW/oaWwBRwwtX0q9xXgMC0iomWHEQuCoBE0ItpobRy6/SNW+Pjw1EwDDAw?=
 =?us-ascii?Q?wkPmggdJ1h/zRz3Z9ZPIVCiuf49eM7G+pbaOH46zJHNbdSwBTjfUW9triS0W?=
 =?us-ascii?Q?SmiLvjhwZPIuvQaQkwvIsgdXluHryTmZreH6GCxd0HmSYPuaGwANsMKFKMUn?=
 =?us-ascii?Q?i4e28tFW47KhBuMKMuSV7koVaiU2psPSpeVoZfujrRiOSkns0H21lOb+mOld?=
 =?us-ascii?Q?pzjNSDQ3LqgpapT8MppVP2vR8pLkxx4mwRCQ8IhbUnhph+s2xGBEDnFejP3i?=
 =?us-ascii?Q?dIC6T/mfwk7z3lChcXcNrlt8gTv6dK4ljvPckVRMj+oi0Ru7MOr4OiuovAVt?=
 =?us-ascii?Q?xCds2P2xM9biaIpILpBrvj/BXPx7f4Qe6RG+XauwcHlMhPkxT48B2pcA9YoV?=
 =?us-ascii?Q?pG6Vxs6FQ7XP5aMDERDvYyfvA126AxqGFm2FS0VaPp8cA1EPOoR7v2Qv3QMA?=
 =?us-ascii?Q?Z3K/FXq9zn7hwIuJTPpTKexwixP/larBUzrtgzymDEWu17117JxJwFqjW5IA?=
 =?us-ascii?Q?6wBHwpY8tjP7sX1BLcjaJvhTtPWGs33AZIuVNoy+Ns845wTpgrFJ8tykqu8d?=
 =?us-ascii?Q?91Uf36Y5Q2wTft9fLJ6tJJf8AhqZe0cufUI+cuSKun052mEtbNPyUxs1a50P?=
 =?us-ascii?Q?tYlbJ56H5a2V9R7k3CAkpQnJ7+JzLBoDvMpWPSKihb+7bXUeMZ+sxuT1Xh17?=
 =?us-ascii?Q?zfqUN2OcxD+RngTt7oSgdDBnxqBy3RMW4Df37sJ8Wc64Nkf797KxjJvTMwxH?=
 =?us-ascii?Q?7lhfKEvt7ypZKDtQE4w=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51448295DDBC844F44F4ADB4F7202BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c28f934-0f65-4b38-1489-08dd08c80c36
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 18:29:04.7663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rgW9BVkc5wzF5ZfcUFdcJjdKfHpRI16t6FjERTE+SJVKW4A25TZ/m176Lx1FOg3DWyEX6ZLlzbTcezDEZ70RHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865
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

--_000_BL1PR12MB51448295DDBC844F44F4ADB4F7202BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

As long as there is no hw programming sequence requirement to do it as two =
separate writes this looks fine to me.
Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Friday, November 15, 2024 3:39 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike <Prike.Lia=
ng@amd.com>
Subject: [PATCH] drm/amdgpu: reduce the mmio writes in kiq setting

There's no need to perform the two MMIO writes in the KIQ
Setting registers programmed period, and reducing the MMIO
writes will save the driver loading time.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 8 ++------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 4 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 4 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 4 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 4 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 +---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 4 +---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 4 +---
 8 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 9da95b25e158..ffd3c45b4ccd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6593,17 +6593,13 @@ static void gfx_v10_0_kiq_setting(struct amdgpu_rin=
g *ring)
                 tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cic=
hlid);
                 tmp &=3D 0xffffff00;
                 tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->queu=
e);
-               WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp=
);
-               tmp |=3D 0x80;
-               WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp=
);
+               WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp=
 | 0x80);
                 break;
         default:
                 tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
                 tmp &=3D 0xffffff00;
                 tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->queu=
e);
-               WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
-               tmp |=3D 0x80;
-               WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+               WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp | 0x80);
                 break;
         }
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 5aff8f72de9c..a2aedcabae65 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3890,9 +3890,7 @@ static void gfx_v11_0_kiq_setting(struct amdgpu_ring =
*ring)
         tmp =3D RREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS);
         tmp &=3D 0xffffff00;
         tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
-       tmp |=3D 0x80;
-       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
+       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp | 0x80);
 }

 static void gfx_v11_0_cp_set_doorbell_range(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c
index 9fec28d8a5fc..c61d383c45c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2826,9 +2826,7 @@ static void gfx_v12_0_kiq_setting(struct amdgpu_ring =
*ring)
         tmp =3D RREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS);
         tmp &=3D 0xffffff00;
         tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
-       tmp |=3D 0x80;
-       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
+       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp | 0x80);
 }

 static void gfx_v12_0_cp_set_doorbell_range(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index 480c41ee947e..d465c3ea6e6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4304,9 +4304,7 @@ static void gfx_v8_0_kiq_setting(struct amdgpu_ring *=
ring)
         tmp =3D RREG32(mmRLC_CP_SCHEDULERS);
         tmp &=3D 0xffffff00;
         tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-       WREG32(mmRLC_CP_SCHEDULERS, tmp);
-       tmp |=3D 0x80;
-       WREG32(mmRLC_CP_SCHEDULERS, tmp);
+       WREG32(mmRLC_CP_SCHEDULERS, tmp | 0x80);
 }

 static int gfx_v8_0_kiq_kcq_enable(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index e9248a855ba7..a6cb30558f2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3482,9 +3482,7 @@ static void gfx_v9_0_kiq_setting(struct amdgpu_ring *=
ring)
         tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
         tmp &=3D 0xffffff00;
         tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-       WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
-       tmp |=3D 0x80;
-       WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+       WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp | 0x80);
 }

 static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ring, struct v9_=
mqd *mqd)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 016290f00592..ae3c8645633b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1771,9 +1771,7 @@ static void gfx_v9_4_3_xcc_kiq_setting(struct amdgpu_=
ring *ring, int xcc_id)
         tmp =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULER=
S);
         tmp &=3D 0xffffff00;
         tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-       WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS, tm=
p);
-       tmp |=3D 0x80;
-       WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS, tm=
p);
+       WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS, tm=
p | 0x80);
 }

 static void gfx_v9_4_3_mqd_set_priority(struct amdgpu_ring *ring, struct v=
9_mqd *mqd)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 8ca137313961..3b818441c7ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1491,9 +1491,7 @@ static void mes_v11_0_kiq_setting(struct amdgpu_ring =
*ring)
         tmp =3D RREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS);
         tmp &=3D 0xffffff00;
         tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
-       tmp |=3D 0x80;
-       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
+       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp | 0x80);
 }

 static void mes_v11_0_kiq_clear(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index 9d0e342a2f81..44b0d0f76944 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1453,9 +1453,7 @@ static void mes_v12_0_kiq_setting(struct amdgpu_ring =
*ring)
         tmp =3D RREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS);
         tmp &=3D 0xffffff00;
         tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
-       tmp |=3D 0x80;
-       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
+       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp | 0x80);
 }

 static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
--
2.34.1


--_000_BL1PR12MB51448295DDBC844F44F4ADB4F7202BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
As long as there is no hw programming sequence requirement to do it as two =
separate writes this looks fine to me.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liang, Prike &lt;Prik=
e.Liang@amd.com&gt;<br>
<b>Sent:</b> Friday, November 15, 2024 3:39 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Liang, Pri=
ke &lt;Prike.Liang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: reduce the mmio writes in kiq setting</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">There's no need to perform the two MMIO writes in =
the KIQ<br>
Setting registers programmed period, and reducing the MMIO<br>
writes will save the driver loading time.<br>
<br>
Signed-off-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp; | 8 ++------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c&nbsp; | 4 +---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c&nbsp; | 4 +---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp; | 4 +---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp; | 4 +---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 +---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v11_0.c&nbsp; | 4 +---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v12_0.c&nbsp; | 4 +---<br>
&nbsp;8 files changed, 9 insertions(+), 27 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 9da95b25e158..ffd3c45b4ccd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -6593,17 +6593,13 @@ static void gfx_v10_0_kiq_setting(struct amdgpu_rin=
g *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienn=
a_Cichlid);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xffffff00;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp |=3D (ring-&gt;me &lt;&lt; 5) | (ring-&gt;pipe &l=
t;&lt; 3) | (ring-&gt;queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp |=3D 0x80;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp | 0x=
80);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xffffff00;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp |=3D (ring-&gt;me &lt;&lt; 5) | (ring-&gt;pipe &l=
t;&lt; 3) | (ring-&gt;queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp |=3D 0x80;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp | 0x80);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c<br>
index 5aff8f72de9c..a2aedcabae65 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
@@ -3890,9 +3890,7 @@ static void gfx_v11_0_kiq_setting(struct amdgpu_ring =
*ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0=
, regRLC_CP_SCHEDULERS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xffffff00;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D (ring-&gt;me &lt;=
&lt; 5) | (ring-&gt;pipe &lt;&lt; 3) | (ring-&gt;queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D 0x80;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp | 0x80);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v11_0_cp_set_doorbell_range(struct amdgpu_device *ade=
v)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c<br>
index 9fec28d8a5fc..c61d383c45c4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
@@ -2826,9 +2826,7 @@ static void gfx_v12_0_kiq_setting(struct amdgpu_ring =
*ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0=
, regRLC_CP_SCHEDULERS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xffffff00;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D (ring-&gt;me &lt;=
&lt; 5) | (ring-&gt;pipe &lt;&lt; 3) | (ring-&gt;queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D 0x80;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp | 0x80);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v12_0_cp_set_doorbell_range(struct amdgpu_device *ade=
v)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c<br>
index 480c41ee947e..d465c3ea6e6c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
@@ -4304,9 +4304,7 @@ static void gfx_v8_0_kiq_setting(struct amdgpu_ring *=
ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32(mmRLC_CP_SC=
HEDULERS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xffffff00;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D (ring-&gt;me &lt;=
&lt; 5) | (ring-&gt;pipe &lt;&lt; 3) | (ring-&gt;queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmRLC_CP_SCHEDULERS, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D 0x80;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmRLC_CP_SCHEDULERS, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmRLC_CP_SCHEDULERS, tmp | 0x8=
0);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int gfx_v8_0_kiq_kcq_enable(struct amdgpu_device *adev)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index e9248a855ba7..a6cb30558f2f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -3482,9 +3482,7 @@ static void gfx_v9_0_kiq_setting(struct amdgpu_ring *=
ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0=
, mmRLC_CP_SCHEDULERS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xffffff00;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D (ring-&gt;me &lt;=
&lt; 5) | (ring-&gt;pipe &lt;&lt; 3) | (ring-&gt;queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHE=
DULERS, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D 0x80;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHE=
DULERS, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHE=
DULERS, tmp | 0x80);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ring, struc=
t v9_mqd *mqd)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c<br>
index 016290f00592..ae3c8645633b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
@@ -1771,9 +1771,7 @@ static void gfx_v9_4_3_xcc_kiq_setting(struct amdgpu_=
ring *ring, int xcc_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, G=
ET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xffffff00;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D (ring-&gt;me &lt;=
&lt; 5) | (ring-&gt;pipe &lt;&lt; 3) | (ring-&gt;queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, GET_INST(GC, xcc=
_id), regRLC_CP_SCHEDULERS, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D 0x80;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, GET_INST(GC, xcc=
_id), regRLC_CP_SCHEDULERS, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, GET_INST(GC, xcc=
_id), regRLC_CP_SCHEDULERS, tmp | 0x80);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v9_4_3_mqd_set_priority(struct amdgpu_ring *ring, str=
uct v9_mqd *mqd)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c<br>
index 8ca137313961..3b818441c7ba 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
@@ -1491,9 +1491,7 @@ static void mes_v11_0_kiq_setting(struct amdgpu_ring =
*ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0=
, regRLC_CP_SCHEDULERS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xffffff00;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D (ring-&gt;me &lt;=
&lt; 5) | (ring-&gt;pipe &lt;&lt; 3) | (ring-&gt;queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D 0x80;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp | 0x80);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void mes_v11_0_kiq_clear(struct amdgpu_device *adev)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c<br>
index 9d0e342a2f81..44b0d0f76944 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
@@ -1453,9 +1453,7 @@ static void mes_v12_0_kiq_setting(struct amdgpu_ring =
*ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0=
, regRLC_CP_SCHEDULERS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xffffff00;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D (ring-&gt;me &lt;=
&lt; 5) | (ring-&gt;pipe &lt;&lt; 3) | (ring-&gt;queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D 0x80;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CP_SCHEDUL=
ERS, tmp | 0x80);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51448295DDBC844F44F4ADB4F7202BL1PR12MB5144namp_--
