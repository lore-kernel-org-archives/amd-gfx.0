Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA209C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 771BD64EDB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771BD64EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E2A46EB92;
	Wed, 24 Feb 2021 22:22:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A756EB94
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8hkGcCwMhp9jhE35B2QL8dnBs2HZ4gwNY66Pb8BoRuID6kIaLIirA1UMIhzwxYbYDdEfHJm9sf5BrfT7Fc4H/Fh4bzDJwJBaguRpDmp4sVFGhl5ooUuVTROQ8UwknLCsRFLZ4y96YsE69huqaWJoUf8frRGMbr80I8yFSd2Qf28OyuvtzdDI96Fb9bkWFyDHPeH8GmTuKKAPgFrgSMFxxDmI0Y/KC/HY2I6s+R+N9N5tu7wyu4Xyn8EpvD/zDkgS5eDmlpRgdzpLrcETXYOkgF6wYI16kWd3botPcYoBEmIEYu/f1RgVDd5PbHFVJzhmhTI3TxpG5xzKfJqqWxJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ja4QhjqrKSndAYxkir4qogWANryxyQLsO6sH757ybxo=;
 b=YHSDQRrxiUkn0i2i4oQ3hNNniLXcvdyvwgE53qbjcTahXFyaCLhE+hysd/KuNTfGxUOx0vUE3bZEui0f1Wr49oPOknoHEySGPoytDRLK8svQsjEV55ZxM9Cy9bp05lKiRKzhVQVC4pmizfV3s4fCnMaXrZhpHFyV/VEYhGCvgncXa/pI2SFVcjudCueQ7L9mN2qCtPX1LA7c7xf6SMnlOL02M2tRjUqW1lh55k/ZJDaf73UjHyn89WQbptRcbaIoW1LuRH9ZjLUQ1c7xgZPypq2oNnq4i8mKjD/4GcNoblxfzofqaOZKBIOVxQZGqanASFrwnMUQrWnt/wP7yTbSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ja4QhjqrKSndAYxkir4qogWANryxyQLsO6sH757ybxo=;
 b=j/30gRov+z0kkVHLb4IYqQ470tEwmTsdbxAkixfxmGgQuIxYsMKGeUIVMbTFwmd0FaktnuRpxMNMx+MGB90YN/zif3z5QMCV42VrFt/gwy7pNV+D3CE+vOPF588jIR/ocIPjr3KkNyQox3zZK68DYtmQKbkB8rwxzRtwCBTQxtA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Wed, 24 Feb
 2021 22:22:25 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:25 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 130/159] drm/amdgpu: Placement of gart and vram in sysvm
 aperture
Date: Wed, 24 Feb 2021 17:18:30 -0500
Message-Id: <20210224221859.3068810-123-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd5e0757-9df2-42e5-adb9-08d8d91271ac
X-MS-TrafficTypeDiagnostic: MN2PR12MB4503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4503DDF6756E13146387C285F79F9@MN2PR12MB4503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hk+lPFPgNn+3DoDl2jpeBvs2d410HQusiqO/z3eBoR9mMbE/lDv37l2/Ler+2BjykQbIFloF91GcjZrkxZprMSE0W3HTxAD7wQXmHi53jf+dX9uwTxPvur8d3WyUJC74BxBZZuuaNLK4AelBlD7ev68mtflQymaTYA39yDK+6bnWOoxvkxOK4ACTcLWyKFKG3UQNhMYTgx4xXyy60KtmB7Yne2zdBTc2mfQ2MpsLhHJyXK//tj3SK5v8H7Kld52mLRYkll3oZGcmDUX0+4jsl2TE6pVCY5j8gp17xegZ9e4wEIgaSS59DXZ68tVUKk73MwEqyZr5zRHG9trVRXyXhxlpZvjQ0uY3FB/w3CZ/nxXLlZ3qNjCxxtTBmi+llo7O29q4/MWqzLXlP0m1Qow6Ucbp5uv9NH9SoywTyTfEoauxHS6v6eNV095Ttwb40hhrhUhI3o2stDk+pn6GRKalWWlnWB1qrsvfVBufdVOY+H6Giut8nz7JYWFrsQEO12fKXIyEubgOEPhqHSj/NNrfnAdTmhO0gmrItr4WBLuIAlkLUlD6q13+mlei4KYi6qTRgtigmKoqPuu+wIivj1S5Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(6916009)(52116002)(478600001)(5660300002)(1076003)(4326008)(36756003)(54906003)(6506007)(6486002)(6512007)(66556008)(6666004)(83380400001)(186003)(26005)(66476007)(8676002)(8936002)(2616005)(316002)(956004)(2906002)(86362001)(66946007)(69590400012)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gVS6Ix2RJXlIq2uVtZ4jSM3Ozy43as1x6yzgKrePh4+wwe6Xr8asxXSmzY14?=
 =?us-ascii?Q?wRJogtJO62CLNxFA4DIBkvBzZtW/lqQmLbbo9sTjgjYXKYfvLgCg2ihLRi8l?=
 =?us-ascii?Q?ngjN74437jE95eP0H1CuDlTNn2Vy26TJ2sUFut6ezRtPLzE7C8jPJ7xgPNTx?=
 =?us-ascii?Q?0dwRgM+PvNtfHJUicKp2PxHlLgxrksWM2MKK0W16h0c6+6eawwGP0v0RE5A5?=
 =?us-ascii?Q?2nMI3THOTYXZvyYvCIiKgKAo1lemmeXebxOboYWJhhdN/eFs3vYTB+wKnk6k?=
 =?us-ascii?Q?x1E33/9ezDhJvkppaX8eLJNnVdoIJS7bZLVhNbhlvwNmQsnymEUX0DmcgTLr?=
 =?us-ascii?Q?HoH8J28mkDuIiEHo14UcgZMCmvOFhbpnL5jOABJCM4y/3zD+dCRMUAaPHjN7?=
 =?us-ascii?Q?uAL1lLgXCC6nBw2cBdTPdGACaNa1ptY7dokkvu/72Wp9mvyoUerPUHfxqIrX?=
 =?us-ascii?Q?npItCPcO3W9g5qEbAIeCJhMk/RsQ9uUmydzSBrVbIiR16zsxDjomIa2CY0oB?=
 =?us-ascii?Q?7yw5ttuNDXs4gjgCrzQC9fYY6BffCxFqkgReixNYi2Xw4HDNqpBW0P+0x0Yh?=
 =?us-ascii?Q?maHMZ9qaI1FdebutNeR0Fb/Ldgg8Z8Z3U79bysrdwSR4mGM2mWVMSOyyNWE9?=
 =?us-ascii?Q?wRGlFDvAWEhl0Y39mI2zfRRzHlDl2gKo+3+7/JCF3DvgQTm5Y4FYhDVyBjHZ?=
 =?us-ascii?Q?mDrzuBiscKyh0/5t58RHZlayBFoJPrGHmozvUXAIOEZJU/PedhjyKxdfHvbc?=
 =?us-ascii?Q?1Q+iDlKFmB6IE+AUH5aSj7X6kAqoGxL0XM/3vw82t8dpR7oZK1FjC3mNjyzP?=
 =?us-ascii?Q?6DaQg9sFYBY9O5lRjWw0M+DQChJihgbWBriH+UKktkkWE2diHDLze2pORGVH?=
 =?us-ascii?Q?7gffa/JQD142q4Sc1j5AUtL9hzVS92Ew3TreJflu/xgZYyj9ZxiZG05+PuG/?=
 =?us-ascii?Q?HVm82zJpjZITTTMNuXpwO9oJx2lvokCYYLSkSA0fIxb40TDuWsb7FGhwHfVB?=
 =?us-ascii?Q?mLXu85x4KfMUlC1l/AVTIGulnGRQSVTFOFLUiB7Yd4Ht7OgRi17FLcjtT1Fh?=
 =?us-ascii?Q?pzcOQaxjdgRNILSbl3kJUqfvPjXSF8mDdBraQ8r45hl0jjNUV1mztu5G8WBA?=
 =?us-ascii?Q?BOguborDoipxuIGXno18dWVpcPYf1ZfOhsgfaOzrU6lL1cEkF0VNMRYyjVcz?=
 =?us-ascii?Q?MOKEyjdZhSdfekHVRvStQn4zWhiRNhAf/9pHyuTGiizToeXSbBiziHrmtcMs?=
 =?us-ascii?Q?9vGNdF6b69xP4XL1kLWYx4Mrc5a5a9MnzqhJmDPSGn3puPEup4Tkdu9dBUlA?=
 =?us-ascii?Q?LumMSH9z5Ajwih3cIiAXmPJv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5e0757-9df2-42e5-adb9-08d8d91271ac
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:51.4547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uc+kxjPnnbFkrBdz8lvph+FBRZfxkOhMine8mqRNHXUijNOhOwCaWw/wH56VdBM8y7jEdvQ/AyUOZvB1GzO86w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Christian Konig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

If use GART for FB translation, place both vram and gart to sysvm
aperture. AGP aperture is not set up in this case because it
is not used

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Christian Konig <christian.koenig@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 34 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 10 +++++---
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index ab1c2b85695d..f492ff8facd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -162,6 +162,39 @@ void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 			mc->vram_end, mc->real_vram_size >> 20);
 }
 
+/** amdgpu_gmc_sysvm_location - place vram and gart in sysvm aperture
+ *
+ * @adev: amdgpu device structure holding all necessary information
+ * @mc: memory controller structure holding memory information
+ *
+ * This function is only used if use GART for FB translation. In such
+ * case, we use sysvm aperture (vmid0 page tables) for both vram
+ * and gart (aka system memory) access.
+ *
+ * GPUVM (and our organization of vmid0 page tables) require sysvm
+ * aperture to be placed at a location aligned with 8 times of native
+ * page size. For example, if vm_context0_cntl.page_table_block_size
+ * is 12, then native page size is 8G (2M*2^12), sysvm should start
+ * with a 64G aligned address. For simplicity, we just put sysvm at
+ * address 0. So vram start at address 0 and gart is right after vram.
+ */
+void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
+{
+	u64 hive_vram_start = 0;
+	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
+	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
+	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
+	mc->gart_start = hive_vram_end + 1;
+	mc->gart_end = mc->gart_start + mc->gart_size - 1;
+	mc->fb_start = hive_vram_start;
+	mc->fb_end = hive_vram_end;
+	dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
+			mc->mc_vram_size >> 20, mc->vram_start,
+			mc->vram_end, mc->real_vram_size >> 20);
+	dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
+			mc->gart_size >> 20, mc->gart_start, mc->gart_end);
+}
+
 /**
  * amdgpu_gmc_gart_location - try to find GART location
  *
@@ -169,7 +202,6 @@ void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
  * @mc: memory controller structure holding memory information
  *
  * Function will place try to place GART before or after VRAM.
- *
  * If GART size is bigger than space left then we ajust GART size.
  * Thus function will never fails.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index f1a21e110610..a061a5632445 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -292,6 +292,7 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
 				uint64_t flags);
 uint64_t amdgpu_gmc_pd_addr(struct amdgpu_bo *bo);
 uint64_t amdgpu_gmc_agp_addr(struct ttm_buffer_object *bo);
+void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc);
 void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 			      u64 base);
 void amdgpu_gmc_gart_location(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 563a8bc478c9..0fce8506fc0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1257,9 +1257,13 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	/* add the xgmi offset of the physical node */
 	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
-	amdgpu_gmc_vram_location(adev, mc, base);
-	amdgpu_gmc_gart_location(adev, mc);
-	amdgpu_gmc_agp_location(adev, mc);
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		amdgpu_gmc_sysvm_location(adev, mc);
+	} else {
+		amdgpu_gmc_vram_location(adev, mc, base);
+		amdgpu_gmc_gart_location(adev, mc);
+		amdgpu_gmc_agp_location(adev, mc);
+	}
 	/* base offset of vram pages */
 	adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
