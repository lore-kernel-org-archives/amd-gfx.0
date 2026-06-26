Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9387C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 17:05:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 494D010E3F0;
	Fri, 26 Jun 2026 17:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f7qSAEqY";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012013.outbound.protection.outlook.com
 [40.93.195.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30D9710E3F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 17:05:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOZ/J23wI3dieqNAPlnDFaZlX8YWZveOcXBvBdOGabV4fNvyawz6rTa/pUGuhEfDd/Dr1FoOdYmNnBQeE/H7Rl66sdoBHMzrVv58vVCvad89FrHX3PecVWZnKT3annZUBieYXHkdIFuRDZD0jd0d5sN7/+znbERlN4PsPsy0z48/ul/KxtMQniGumOtabz3pR70anCbf38vz4H+vsVwdJ1OeHsvKXrh9MRBLL+JldFgfa/uo6VL+aP3wSgfc/kQvBr29R+wDs3JUJz+xRSkBOPvdC5ESNObb6I0MhlhVqOSjgfbjsTPMLdJR/t+XIIAYxHx816aJDhOxwUJNZZO8bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CJZl9W9GgWWmoJp5sCFxHAiYvEXFKJzfqgkmQcjmrI=;
 b=vVnZiE447zlTF4fh5u51qtIzncH/IGRc1Kb1zh5CCq0SfulDwxEYOs1M0YxH0ARAOKBTQaGrUviwaCHgKblAY3YoBxRrTa9PqUR5C0aoaFxw+scnlvnR73RcVBkB4UWVQzYICYbaHoI9RQg5c1rUpvEkQYtSJqZHxrUJtzgvX2LcsfubwVtWouRnlfuVvFu5iEknEgXlQ0vMpJmO29DiYnExdIOHPXwnI5lEOy3nEVPRn/cKG95gerjr/DD5MCVOO0HAOucFJ8iPHr5qMClAXxFMlTEMJpFopjwvCgpNUVDsM9CZVLCHQUmpqgPNd+hUuqaJ6dpakH+qYEJREjBBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CJZl9W9GgWWmoJp5sCFxHAiYvEXFKJzfqgkmQcjmrI=;
 b=f7qSAEqYGbNcRNTTiumSf3LiJiqz3skKRWv1FmOztrbJwyv3tWZZsuKmEu9I/A3WUk46oJxjsS+1gnwvDaMZVKv1c70aqpufpukENO2Bufz5YexAMA6A18mkb0Bn7wuURQcFa5Zy1yY75VmBI3/0JrcBxL6+4WqmGWXieFaO/cI=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Fri, 26 Jun
 2026 17:05:06 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%5]) with mapi id 15.21.0159.018; Fri, 26 Jun 2026
 17:05:05 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix kernel panic during driver load failure
Thread-Topic: [PATCH] drm/amdgpu: Fix kernel panic during driver load failure
Thread-Index: AQHdBYrGdpw2Sx6QZ02j5XoQBKKuebZREJMC
Date: Fri, 26 Jun 2026 17:05:04 +0000
Message-ID: <BL1PR12MB5898F4D1825C42D22B39B15B85EB2@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260626164211.2394095-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20260626164211.2394095-1-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-26T17:04:20.3034537Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|IA1PR12MB6236:EE_
x-ms-office365-filtering-correlation-id: 0a5f0974-7c70-4a17-4eb0-08ded3a5117a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|18002099003|22082099003|11063799006|8096899003|56012099006|38070700021;
x-microsoft-antispam-message-info: +lIBVhV4vUmdIvutOoAgXGNhBjXGIusKl4LQJgczI8Q4soSHa7aQ/RJKmm4wphtrvQVtitXR/Ug+nHidc9NCIx0Ly9WczMC/Q3pRLgxw4Xt4aC6wdjWhkkggzJtZipWyEbwWYhxfx/Oz1RTmVbejJe6NBypG/oSEVOmRRqH3HJmGWm8z83VlN9KodzugYGsTcJUOSx92xtacTjo+ZThq8c7TNus4UQ68Dv3f3kttfobPiBVdmP/1zv7EIDYEY4aos9+cQ2eIwA0PMOUhHXcMyFkFsTZLN40+BrWElgc71AiIHhVTuIwSe2Jin2cBBsaNiRfgL0cd3n2TjBXXIAbd1/EADl+8cGmaVAANGArm+qSbnW9AeaDhpQ9fgAkkbhB7Mcj6KxAKB7/Ztfv8zHuUH4QIxK41gyt39NwQNVgG/HYN4c2T2nuURh/REMWOIxpic8S3TU4lsVwhyoujn1ikqGXbReIf2PVYg/4tYA4sRfVsRGFEH9PeAQyRpLihbt3+3c0BmQJJSuawWsxNHOanLaEkMAGWVqoxiBjMG9BLcM5gpXn3RK3tYN/fj/k+KeY4CFzyS95LnHIbcUTibZWTCiSM2New6LaIr+vTNxYqZl67zJBqen/2GTbVxxagvzLSL+MeaYgmJjWaI68zkZKuE33KbgLzKbrpAkEkc2ZnpZFeoNg+U9AWq9+w/ZWhv4WIkdtNZicdM3SMdBYOCLgAIQNMTA+LuJre5uVPuT/PfZA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(11063799006)(8096899003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LBAAGvg9FrJdDlpSQOgkxWwtoRrmHLOEe+2r7hjFM8DVDEkhVoMwaALur8Bu?=
 =?us-ascii?Q?zf/7c8yHm4JZPIsaCHKxibOSmWuoRflaamFV7C//iWALRjupK9k3ZHVYMByc?=
 =?us-ascii?Q?ZJw0ok7ERw6jId+yx9w2jPmOGXzIisTCy7VRLTwV1jtyt9KQleZbJe3Z09Fv?=
 =?us-ascii?Q?hfyEheZb8SeTxft7L3ZLq8l52vxdPvFB9OORS4xFpYt1fW4LoK3i8YxWItbN?=
 =?us-ascii?Q?VRV142JuBaHQNhvxRGnq7A5s5q7QQESjUB7TKB/448FS8By4Myj++Cf/vnH6?=
 =?us-ascii?Q?G0eY+snofRQA2usp/uvUznVzvF+Bg8BeY7vSb5iiV2wJwaahGnwEicbOluBx?=
 =?us-ascii?Q?3G1OxgPl7xyDJ1ryAGpq64HTvhy7c37bLGDOSzI8iBsqjR2UMFdpKKl6LfBN?=
 =?us-ascii?Q?KCSZnEzphOXh1aRyvevzHdA0crzt+S24qZqdei8EIFCRxwfurPt5D9pAZgF6?=
 =?us-ascii?Q?Kk80CVGr4RYstlSbnA4+SuCfpDtd/sAxEIrGU+kKhLfvjc5eyCTaXoo+ooU+?=
 =?us-ascii?Q?6ch0xKQ1c9K8XujhGOrxXFNFf+rdeaUAOGIs3yTis4q+dnHZvv2igx6rxYJ3?=
 =?us-ascii?Q?I+uvKMjpP2M/Entn3WujcMnb3cCEKm8tbhXUzw09A6gS0uiPQfeo7Arab/xw?=
 =?us-ascii?Q?firWxNpKPeH3IZLJjOM1AdNS1K67LEV3iB1Mi9NK7nfCVvZb9nDTOeB4YhcG?=
 =?us-ascii?Q?ZSkQ/w2/ZT+i5ZYAkjtiMV5G64Wtr3g+H+ojMFYahioOB+aZ8WsXGLEc4ytM?=
 =?us-ascii?Q?4sG+dZBnebRTKeeYs/zcNnzCQuC8jafvS1beWZV6E6253qw8dGAFlCZGM+jg?=
 =?us-ascii?Q?3596xkOKqtmsb2UxBYRXjYk73C4OLEceq0u7BliaiJX6ACNVgu0hEol/JQbv?=
 =?us-ascii?Q?1ddEO4ePOZuVBpETHONzwiywS91I3cjiiUt0ymAyn1JpmjYKwBbEjT1Opbpm?=
 =?us-ascii?Q?X7QjEVh6CVzETQsc8uT9QLlwvCKZ+j4x1MS9Xl/xX8YCOajZe4xzoYZzaN15?=
 =?us-ascii?Q?wB5m0oPH7tBonOitmp9GJMGnF7a3DzCRhanEmgBRfm9LT/2zUwhUgwI8lgSH?=
 =?us-ascii?Q?aVt0oF3emFsbNY4S47Gf++C0grpoyoXJJJTlSqy8izv0498SF5Guh5+/dV2v?=
 =?us-ascii?Q?ku89C9FblAGuKh3gemWLFKE60gh3QhHc/QU8Wi633O68nowQIo0QNxny9i4o?=
 =?us-ascii?Q?RspWb6ruD3DV7Fn1IqMdNxA/kzbu6OghejARPHmRn9h08fR4EOPLLz5LzGsW?=
 =?us-ascii?Q?3vnRgA0p/qNF2M9opxPC90AgX7BQ4QQIr0vdReQmW+Ozq0KDChowqSWYrmNG?=
 =?us-ascii?Q?lIUOXxbtQhxef0aUMXuBQK+bfU2R3LxBaI8KVj00m8prOoVwqMwH/7lP6kwg?=
 =?us-ascii?Q?Q9KdhK0aLnx46yGkQIHi+pgaN2DP2kSqcSimx74v4R+IeCFMjHl7dtQWqcnF?=
 =?us-ascii?Q?bh4SEoSLI2tJL9JWTKK9avxEv/x2euGI8Q123oYSZMgSq/e6ThWJphbNdqVH?=
 =?us-ascii?Q?jCs1zUZ7lZ8fF9FX5VOJ0Cx35m76eMjzKCE/WtFCg9f8V1aC3KpMCOHm1UAq?=
 =?us-ascii?Q?XdjyW8qjhEzNO2ccax1ocqWhPx7c4wWs9pzL1cfBudDDdbhKimxJudBGeBeI?=
 =?us-ascii?Q?TjLYL8rNmdLmsg2BbTD+Ot8S2HbTa4a8j65nd0MYYeLF5AGEHTd9eU+OcT0c?=
 =?us-ascii?Q?80yDCPfl+DLM3qsOo8xiDDBGM5B6SYey21zJc0PQM+lkfS24MzupR0Fm9y4V?=
 =?us-ascii?Q?gZyJf1j6Tw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5898F4D1825C42D22B39B15B85EB2BL1PR12MB5898namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5f0974-7c70-4a17-4eb0-08ded3a5117a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 17:05:04.9157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LD+l5i+WBgiSo82B+f5K0WgoUwvRH9R3lynu9YyvAzwcMZkd/avsT97OP34Utgy89O/x0hV4NYOBS/vSclZgTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236
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

--_000_BL1PR12MB5898F4D1825C42D22B39B15B85EB2BL1PR12MB5898namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Reviewed-by: Kent Russell <kent.russell@amd.com>
________________________________
From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
Sent: Friday, 26 June 2026 12:42:11
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Russell,=
 Kent <Kent.Russell@amd.com>
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdgpu: Fix kernel panic during driver load failure

Avoid kernel panic if MES init fails during driver load. The KIQ ring is
falsely marked as ready as ASICs that use MES, KIQ is owned by MES.

BUG: kernel NULL pointer dereference, address: 0000000000000000
RIP: 0010:gfx_v12_1_wait_reg_mem+0x5a/0x1f0 [amdgpu]
Call Trace:
 gfx_v12_1_ring_emit_reg_write_reg_wait+0x1f/0x30 [amdgpu]
 amdgpu_gmc_fw_reg_write_reg_wait+0xb2/0x190 [amdgpu]
 amdgpu_gmc_flush_gpu_tlb+0x1cc/0x230 [amdgpu]
 amdgpu_gart_invalidate_tlb+0x81/0xa0 [amdgpu]
 amdgpu_gart_unbind+0x72/0x90 [amdgpu]
 amdgpu_ttm_backend_unbind+0xa4/0xb0 [amdgpu]
 amdgpu_ttm_tt_unpopulate+0x13/0xd0 [amdgpu]
 amdttm_tt_unpopulate+0x29/0x70 [amdttm]
 ttm_bo_put+0x1eb/0x360 [amdttm]
 amdgpu_bo_free_kernel+0xf9/0x1f0 [amdgpu]
 amdgpu_ih_ring_fini+0x5a/0x90 [amdgpu]
 amdgpu_irq_fini_hw+0x58/0x80 [amdgpu]
 amdgpu_device_fini_hw+0x4e0/0x5b0 [amdgpu]
 amdgpu_driver_load_kms+0x60/0xa0 [amdgpu]
 amdgpu_pci_probe+0x28e/0x6d0 [amdgpu]
 pci_device_probe+0x19f/0x220
 really_probe+0x1ed/0x340
 driver_probe_device+0x1e/0x80
 __driver_attach+0xd3/0x1a0
 bus_for_each_dev+0x68/0xa0
 bus_add_driver+0x19f/0x270
 driver_register+0x5d/0xf0
 do_one_initcall+0xac/0x200
 do_init_module+0x1ec/0x280
 __se_sys_finit_module+0x2de/0x310
 do_syscall_64+0x6a/0x250
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 13 +++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 13 +++++++++++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c
index cd6c1b6f8894..c765af54669c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3524,10 +3524,19 @@ static int gfx_v12_0_cp_resume(struct amdgpu_device=
 *adev)
                 gfx_v12_0_cp_gfx_enable(adev, true);
         }

-       if (adev->enable_mes_kiq && adev->mes.kiq_hw_init)
+       if (adev->enable_mes_kiq && adev->mes.kiq_hw_init) {
                 r =3D amdgpu_mes_kiq_hw_init(adev, 0);
-       else
+               /*
+                * With MES, GFX KIQ ring is owned by the MES and is never
+                * initialized/used directly by the driver, so it must
+                * not be left flagged as ready. mes_v12_0_hw_init() clears
+                * but clear here if MES init fails
+               */
+               if (r)
+                       adev->gfx.kiq[0].ring.sched.ready =3D false;
+       } else {
                 r =3D gfx_v12_0_kiq_resume(adev);
+       }
         if (r)
                 return r;

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_1.c
index aaa8f4212a15..e87f1baf5cb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2549,10 +2549,19 @@ static int gfx_v12_1_xcc_cp_resume(struct amdgpu_de=
vice *adev, uint16_t xcc_mask

                 gfx_v12_1_xcc_cp_compute_enable(adev, true, xcc_id);

-               if (adev->enable_mes_kiq && adev->mes.kiq_hw_init)
+               if (adev->enable_mes_kiq && adev->mes.kiq_hw_init) {
                         r =3D amdgpu_mes_kiq_hw_init(adev, xcc_id);
-               else
+                       /*
+                        * With MES, GFX KIQ ring is owned by the MES and i=
s never
+                        * initialized/used directly by the driver, so it m=
ust
+                        * not be left flagged as ready. mes_v12_0_hw_init(=
) clears
+                        * but clear here if MES init fails
+                        */
+                       if (r)
+                               adev->gfx.kiq[xcc_id].ring.sched.ready =3D =
false;
+               } else {
                         r =3D gfx_v12_1_xcc_kiq_resume(adev, xcc_id);
+               }
                 if (r)
                         return r;

--
2.43.0


--_000_BL1PR12MB5898F4D1825C42D22B39B15B85EB2BL1PR12MB5898namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(33, 33, 33);" =
dir=3D"auto">
Reviewed-by: Kent Russell &lt;kent.russell@amd.com&gt;</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kasiviswanathan, Hari=
sh &lt;Harish.Kasiviswanathan@amd.com&gt;<br>
<b>Sent:</b> Friday, 26 June 2026 12:42:11<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Russell, Kent &lt;Kent.Russell@amd.com&gt;<br>
<b>Cc:</b> Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;<b=
r>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix kernel panic during driver load fai=
lure</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Avoid kernel panic if MES init fails during driver=
 load. The KIQ ring is<br>
falsely marked as ready as ASICs that use MES, KIQ is owned by MES.<br>
<br>
BUG: kernel NULL pointer dereference, address: 0000000000000000<br>
RIP: 0010:gfx_v12_1_wait_reg_mem+0x5a/0x1f0 [amdgpu]<br>
Call Trace:<br>
&nbsp;gfx_v12_1_ring_emit_reg_write_reg_wait+0x1f/0x30 [amdgpu]<br>
&nbsp;amdgpu_gmc_fw_reg_write_reg_wait+0xb2/0x190 [amdgpu]<br>
&nbsp;amdgpu_gmc_flush_gpu_tlb+0x1cc/0x230 [amdgpu]<br>
&nbsp;amdgpu_gart_invalidate_tlb+0x81/0xa0 [amdgpu]<br>
&nbsp;amdgpu_gart_unbind+0x72/0x90 [amdgpu]<br>
&nbsp;amdgpu_ttm_backend_unbind+0xa4/0xb0 [amdgpu]<br>
&nbsp;amdgpu_ttm_tt_unpopulate+0x13/0xd0 [amdgpu]<br>
&nbsp;amdttm_tt_unpopulate+0x29/0x70 [amdttm]<br>
&nbsp;ttm_bo_put+0x1eb/0x360 [amdttm]<br>
&nbsp;amdgpu_bo_free_kernel+0xf9/0x1f0 [amdgpu]<br>
&nbsp;amdgpu_ih_ring_fini+0x5a/0x90 [amdgpu]<br>
&nbsp;amdgpu_irq_fini_hw+0x58/0x80 [amdgpu]<br>
&nbsp;amdgpu_device_fini_hw+0x4e0/0x5b0 [amdgpu]<br>
&nbsp;amdgpu_driver_load_kms+0x60/0xa0 [amdgpu]<br>
&nbsp;amdgpu_pci_probe+0x28e/0x6d0 [amdgpu]<br>
&nbsp;pci_device_probe+0x19f/0x220<br>
&nbsp;really_probe+0x1ed/0x340<br>
&nbsp;driver_probe_device+0x1e/0x80<br>
&nbsp;__driver_attach+0xd3/0x1a0<br>
&nbsp;bus_for_each_dev+0x68/0xa0<br>
&nbsp;bus_add_driver+0x19f/0x270<br>
&nbsp;driver_register+0x5d/0xf0<br>
&nbsp;do_one_initcall+0xac/0x200<br>
&nbsp;do_init_module+0x1ec/0x280<br>
&nbsp;__se_sys_finit_module+0x2de/0x310<br>
&nbsp;do_syscall_64+0x6a/0x250<br>
&nbsp;entry_SYSCALL_64_after_hwframe+0x4b/0x53<br>
<br>
Signed-off-by: Harish Kasiviswanathan &lt;Harish.Kasiviswanathan@amd.com&gt=
;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 13 +++++++++++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 13 +++++++++++--<br>
&nbsp;2 files changed, 22 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c<br>
index cd6c1b6f8894..c765af54669c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
@@ -3524,10 +3524,19 @@ static int gfx_v12_0_cp_resume(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gfx_v12_0_cp_gfx_enable(adev, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_mes_kiq &amp;&amp=
; adev-&gt;mes.kiq_hw_init)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_mes_kiq &amp;&amp=
; adev-&gt;mes.kiq_hw_init) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_mes_kiq_hw_init(adev, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * With MES, GFX KIQ ring is owned by the MES and is never<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * initialized/used directly by the driver, so it must<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * not be left flagged as ready. mes_v12_0_hw_init() clears=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * but clear here if MES init fails<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.kiq=
[0].ring.sched.ready =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D gfx_v12_0_kiq_resume(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_1.c<br>
index aaa8f4212a15..e87f1baf5cb6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c<br>
@@ -2549,10 +2549,19 @@ static int gfx_v12_1_xcc_cp_resume(struct amdgpu_de=
vice *adev, uint16_t xcc_mask<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gfx_v12_1_xcc_cp_compute_enable(adev, true, xcc_id);<=
br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;enable_mes_kiq &amp;&amp; adev-&gt;mes.kiq_hw_init)=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;enable_mes_kiq &amp;&amp; adev-&gt;mes.kiq_hw_init)=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D=
 amdgpu_mes_kiq_hw_init(adev, xcc_id);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * With MES=
, GFX KIQ ring is owned by the MES and is never<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * initiali=
zed/used directly by the driver, so it must<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * not be l=
eft flagged as ready. mes_v12_0_hw_init() clears<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * but clea=
r here if MES init fails<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.kiq[xcc_id].ring.sched.ready =
=3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D=
 gfx_v12_1_xcc_kiq_resume(adev, xcc_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
&nbsp;<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5898F4D1825C42D22B39B15B85EB2BL1PR12MB5898namp_--
