Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB12C25B78
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 14:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E8110E3E4;
	Tue, 28 May 2024 14:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ojo2Z3qw";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4CD810E6F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 14:46:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXYHQJLPIlIQXG2nnthvYzzmwFtbaHA9LAiubkeGb3x42ktHebAD0Cjn527T6Xnl/lMBJ0hIAp5iwq47wzZcMZeVifQpRyjTVUUoAqImypt/Dvz2t6DL+lR8PGvp3N036s4HI34l3h2LWLz6ssaqtvhFlpIK2ZIyhG653YrClVXD7gT+hcrVms9lXhIdNBV/GJQeiksfg9GrIViaxUAFFTTEGYKqjTpXQSLqzdMEcsCisU6htl9ZzbRgDYSEJKCTjMp23jPSFO/0ly1SBhiUgdxSiadENlR0nhNtzCHFR01GjR67TKrENlkiN756GHRfz7LpeIXqCqibvKJOLtPUzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y527QpS7Sc7wyJ0VBA6KaL1RS0g4zope1Syp1r6RFoQ=;
 b=l3EusLhzV435sgtNjNh1ibVRIPQweQge1yqu4Jz2O008PNSa1mbZqTIM6kVfBvtEMCsZruL5pQtO5fxqh/kZABn+LkBRXu9yAFkUpqdB+B64KKpQndwBhQfYplwudGfW2zEbUHv28G5Y2ePMl9PX8578vk31azQLwjUPGS2GNHZ/3baTW2yYuqxt1idzOACwC5W1K/9Nst1bFKuWslyfl9CSYJXMaJ6ep5yJMMmDppgfQIjT1JTjfCPBOCEJPf22YhxiFSSDhe/X7wfDpi1BvnSVfFEYrgLFqs9XRRjk96qr1TMuic6iNhXWXWx40Qce+0eWGH+fD89jFfJ6Yplxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y527QpS7Sc7wyJ0VBA6KaL1RS0g4zope1Syp1r6RFoQ=;
 b=Ojo2Z3qwL9nlRv6BuEqJYOYQRzOFP57FG+Of9ndiZ7kpM9lTBOHQw4qykVm1l2BC+0OMHXrxRDIxThb8mG0+XxBZNk9Br2cqYJ3a5kxwv2zYJgKmG+JOIe2B3suFF3wEPXS7Xg8eZ7fDFGXL5BdmTf7SJF+HWqkQu0r0ow1KmtY=
Received: from DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12)
 by SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Tue, 28 May
 2024 14:46:51 +0000
Received: from DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::a585:5723:a993:b9c0]) by DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::a585:5723:a993:b9c0%6]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 14:46:51 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add lock around VF RLCG interface
Thread-Topic: [PATCH] drm/amdgpu: Add lock around VF RLCG interface
Thread-Index: AQHasHMykZqZj+iEWUKcYgEurCgBILGsuk+A
Date: Tue, 28 May 2024 14:46:50 +0000
Message-ID: <DM4PR12MB5328739B3EB9E8B408ADCD43F1F12@DM4PR12MB5328.namprd12.prod.outlook.com>
References: <20240527201907.470066-1-victor.skvortsov@amd.com>
In-Reply-To: <20240527201907.470066-1-victor.skvortsov@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=de8c7a89-d5c2-4b99-a0a6-f3814bba7bd3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-28T14:44:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5328:EE_|SA1PR12MB6845:EE_
x-ms-office365-filtering-correlation-id: 834b3eb7-41f5-4022-931a-08dc7f250249
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?GHsIPt6Q2RaM6dMMG1m4XKvmFKFsmYpEPaicbHK1ind+HOppMvaSNFT7hCw/?=
 =?us-ascii?Q?W8R8Xsx9FfvzAJ3Ye8XObQ6ClAi8VUDaH3HMlh+h7RAVw814J2k9zHEhs15K?=
 =?us-ascii?Q?p7FDEdWwpcCgz+EQ4iRziQEa7Liqa97wZqyJEtNNJ/dx8lqqF964wiR6BR+7?=
 =?us-ascii?Q?GdtuB7+NWem92FsktaF3ngOhUePKp/wV6hgO7nugWl/M79LX5Esfqv7KGm9c?=
 =?us-ascii?Q?qcDuqxOrnFmFypurct2nfCe41f3vAgxtAnJeCb0+SmvXR5ZWHFiWyg1sK6U1?=
 =?us-ascii?Q?d20k9COYysj5aVOoFTzO6UwJQtB3YzIMxjihlwFm90iTLCVWm1eViGNTCP3J?=
 =?us-ascii?Q?LrBGee+APlae+t+DkuhYbVXDWrq90qucvXm+nhUmHmjGVwciHSk6JaPdNMOW?=
 =?us-ascii?Q?+BejPlIRIaRvwXjRba49XsZ7oyBzBIce4qf3VGVoPUQLjMdR8p9pCssJkdQ3?=
 =?us-ascii?Q?4D/A5qf3Qs98vZ/nLLM2hqXeXpcrarmWfB/CjTAx7weqwnm8DWtezWAupvX0?=
 =?us-ascii?Q?DcSPTTTrp1Y2fCkXRJt5UWkQugkTV6yFpW5GA65pbX375ZUE1d0/n4z36zFn?=
 =?us-ascii?Q?xiAPBTBUuZTj/xVoK0i/EuqgTaJyEBPhidUBDCZw2qiIU77c8obznl6Y5luI?=
 =?us-ascii?Q?Yog1LVZ8Xq7t4P3sk1f6QH7NnVO0+Md8Kfw/A4gahKBbGlsuytxMB/dv5Zg6?=
 =?us-ascii?Q?Jl2sx2ssuXyuh9HmZ9bewaJpR8Z4xJaoFTgzQBm5TGL1ClQVyVUXr58Zd9J4?=
 =?us-ascii?Q?XeI+tMDB5RONVhZzQ4g1S3diPJCyItjBcxsXzqtHYHfiohy3h022MdN7UEnG?=
 =?us-ascii?Q?2DiB2n8+ZcNzadeOK/IFe8kurbcA11Q/CQcyr/dgLtKtIEIz3AYHImKwdcS2?=
 =?us-ascii?Q?57oUMbeVhm7RMtunXLbzNQrygVL+FMZ/zrwOOh5pLZjubLrmP5oOIC5Hx2OE?=
 =?us-ascii?Q?sr6qb2N8hd3PtQwF8SEHpBzROOfw8rKAY3+g8TwlcRBGK4wXFra627MQPnyX?=
 =?us-ascii?Q?vwxyd0O66XKVLZjACPtZagIbA7/UGLyA4eVINNbRwAI4K7BnGuNzy1OKd3A+?=
 =?us-ascii?Q?XVZgaMPOIAjSa+WGh4ivBO0tuGMmA0NKfmAUEa+XmfJVqW36wGrsWKb2H7yi?=
 =?us-ascii?Q?G7yUSM/grgRlUi2FHNipXSOSolWKVi44VnF07EGUBlhye2xowQ2SdklHdvSD?=
 =?us-ascii?Q?guFWplrkngyVzQMNbc9XNN/k+P7DpUBYbqfUUoN2fUo+jz1D/7nqeVkd96eR?=
 =?us-ascii?Q?xQZOOD4LxRXq7trgX5jxvUjZNsAPzUgnt+J1yQ1cggDjAzLwfHqlOcNlXAly?=
 =?us-ascii?Q?wZ0rpiFpW8fFWUgQ3kcXVw7pFTo1PyyqE8X+dbvnrqNGIA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5328.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sv+YqXTFSdAO4w3LIzKXE0qildPj17H7ChYbcauUmF61hSGVPYJB/TaPuhHF?=
 =?us-ascii?Q?5r4RDIS2eOwURFuuBJHFCWG5q1v0Xk0ubj73qLGiZimJT3Mc4Dv9G3vxevaF?=
 =?us-ascii?Q?28THnoFmlV98bvAXz8KjyDNsjL1IZTxBDe8wRofmsIXpMkn9ZwYJwjQ11jNu?=
 =?us-ascii?Q?99xTR+qZO8AiFBEIUdkIkJiohkm1Ha01x99NWqDM1tnQo749aLv7eWUt5PlD?=
 =?us-ascii?Q?fRKziNh6TJgMQPkSXObC/J2MdxCcHhkCWgKQTavPkHW5cPxcPf+E8BsHcBsk?=
 =?us-ascii?Q?mgcb73Va5Nx+TZIqtgryiUGDj63q1s9KdAMVpW7Gcw4PwSAn7oXz63zvW+oh?=
 =?us-ascii?Q?UP6fuBIvdsnVm1rdjFjPGDKHsANQJOmFCkz2+Z4HEqbqGSTQf1j/TuEv2Ejo?=
 =?us-ascii?Q?Nl3IRVlD4V5ilcQQZOLbUSYznr6yjKwEZyuTFDdB9nhJfMCMqHuGXaXTRQwb?=
 =?us-ascii?Q?Ylbefyp+B0F0DEL2mCsDj7UHmqq0bUxIrwiaHAisWZoUaLxwi04uPcW0Kjh7?=
 =?us-ascii?Q?jAtO5GvWWoFzXRMkLub+QZvWFvQt1PuMGBhFFk6n6MSHt8lNl3937YiCxyFE?=
 =?us-ascii?Q?SMZVy5MjdC3NTUDka9RhWd6Kewy4f/dd3+4UZODa6u/KIYuE4ounc+0Py95m?=
 =?us-ascii?Q?vkqItymnmOoEwLXljDZf2cQBjudUT4GeYWhlcA0UQdW2XXzzD8u/vkNgU03K?=
 =?us-ascii?Q?tKywBf+WkcKHlFnSOUuSJ7FUQHhoEgs9M6+pv0MbcQnKwnm+8N3noRchxAZx?=
 =?us-ascii?Q?KcbwXu0MkKbwmeTKs/nGuR1emIOFWzjemhZFpbKC4wH+ydFunlhezBGgDwo8?=
 =?us-ascii?Q?F4eIsmwJkr40nE9BOWKerVxecr6tjBkb0LA0cnNzT4vFVBzINN44yvWepSr3?=
 =?us-ascii?Q?oQ+1/5dJ63as+CzGjc4k9SBlmVTyd/s2xvINI90HlKZOxfumXkogO6wNgQpq?=
 =?us-ascii?Q?r1yEek4IapSqajlbwx4r1DB23uoimnhTn3KE2chQVl1SjKLnPucYw2Nw3IcI?=
 =?us-ascii?Q?n4JndKuSuSlZzrtFWBm7yIcZs7Wg40luXuJUqMCSw35qFiMkNjaFLMC7iiwl?=
 =?us-ascii?Q?65gmP/pnSs6g/mgWnCPHeh/yM+3dtnNCWVLX0ll7MZs4ccf3xBHci9FMMXVP?=
 =?us-ascii?Q?1usnNQtN1/IrTuwhjb1J9kN+wdUmlvIG1TE6lO5sKdw0bifgc8c3rbTqn/yw?=
 =?us-ascii?Q?zd23v9onsrULbIlnKiCkNBV8BjSmZZ/l7HCAhpXl32DwMVNZKlsMyTpCPSZ8?=
 =?us-ascii?Q?T5RlCVNmOPqU/pkAP3qWuorBmidDZcgxe4F5MToq1h7bKi62PrvdVTmTaJZE?=
 =?us-ascii?Q?102A0zWTWpfSycFQRL3BlyDr/BnQ0Y2MiWO6zt/BkHUG9SVTF2jbPqOuduKL?=
 =?us-ascii?Q?xmfUWezgIJQXxZ6dxhOrKzLxBmOeMgNwhgN/PbFnIYFFW7w5KvO2X0+M4HMK?=
 =?us-ascii?Q?cdUyvEgZNHlfAb5oIV88h/0/As0dB5fRXQJC2gKZhW6OIM70G6FEGD7WsZJN?=
 =?us-ascii?Q?gwO9UEG//XXkXYRqxWPvtTW6NT6jjQxhIDUJpxqgqRz5ki204LiaBRhMG/qq?=
 =?us-ascii?Q?ow9vOhQKA0+0+ZPXOfg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834b3eb7-41f5-4022-931a-08dc7f250249
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 14:46:50.8216 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dL3kyZMeLKGM839ifOGmffnY8d0Q7Bk/34pMsInmnGaZtaWDZrp+9PsqRA6q0evD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845
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

Reviewed-by: Zhigang Luo <zhigang.luo@amd.com>

-----Original Message-----
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Sent: Monday, May 27, 2024 4:19 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Lazar, Lijo <Lijo.Lazar@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com>
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Add lock around VF RLCG interface

flush_gpu_tlb may be called from another thread while device_gpu_recover is=
 running.

Both of these threads access registers through the VF RLCG interface during=
 VF Full Access. Add a lock around this interface to prevent race condition=
s between these threads.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index f5168b4c3b03..6711836054f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4049,6 +4049,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        mutex_init(&adev->grbm_idx_mutex);
        mutex_init(&adev->mn_lock);
        mutex_init(&adev->virt.vf_errors.lock);
+       mutex_init(&adev->virt.rlcg_reg_lock);
        hash_init(adev->mn_hash);
        mutex_init(&adev->psp.mutex);
        mutex_init(&adev->notifier_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 3d5f58e76f2d..a72683f83390 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -982,6 +982,9 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev,=
 u32 offset, u32 v, u32 f
        scratch_reg1 =3D (void __iomem *)adev->rmmio + 4 * reg_access_ctrl-=
>scratch_reg1;
        scratch_reg2 =3D (void __iomem *)adev->rmmio + 4 * reg_access_ctrl-=
>scratch_reg2;
        scratch_reg3 =3D (void __iomem *)adev->rmmio + 4 * reg_access_ctrl-=
>scratch_reg3;
+
+       mutex_lock(&adev->virt.rlcg_reg_lock);
+
        if (reg_access_ctrl->spare_int)
                spare_int =3D (void __iomem *)adev->rmmio + 4 * reg_access_=
ctrl->spare_int;

@@ -1038,6 +1041,9 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *ade=
v, u32 offset, u32 v, u32 f
        }

        ret =3D readl(scratch_reg0);
+
+       mutex_unlock(&adev->virt.rlcg_reg_lock);
+
        return ret;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 642f1fd287d8..0ec246c74570 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -272,6 +272,8 @@ struct amdgpu_virt {

        /* the ucode id to signal the autoload */
        uint32_t autoload_ucode_id;
+
+       struct mutex rlcg_reg_lock;
 };

 struct amdgpu_video_codec_info;
--
2.34.1

