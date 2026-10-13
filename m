Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4800CC6B1A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 19:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67A1510EF80;
	Tue, 13 Oct 2026 19:47:45 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B373B10E967
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 19:47:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHUgyLI+xqH8fmGvgkrpmQMWpmlK4KyIkU/GVPx8S8TaH4IRSxzvXTncgdYdo6ptW1SYsfgvMMzzIGed4WnjR44dZCXDLAYefH4YW9zvblLK5D8LwmCX9AyM0oGEFmPCHnjtj330O2ZNWu3m/PD1kQxeC56HaB54dsJO21mrnKOGVLqidC3ApY6qGUlS0umi68VVTrgeCJpdcPgFSMTndUQbaAxxC8te3uNYT0D9L7A8YPYRSoHvhT8t4RD0sbNaqWhctEyUW8r+jVh1vxKo8ao2+Eu1w/S78o0+YJ2Pw07LxlAG5Fd6OUoVQIMMyEH2ZaCzJ3uNHYDyQV0lmFQ5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbO8pJ5Pxo5f11m81oLUHuDBbUcvH9KDoXQJ+KStqTM=;
 b=QCh3XQI+0vgxMuG4yyJ+HRINKIpeKKrgf6GIic85Inltr6Ajh/xb1bIL5xJb83HgH7gLECP+kMnrnCqe2W6GMlCL5SoxceBozjNl3TTftgsf6ktMS3Rkj6MXfWyFKgRFPDmDWNHmDGe1GlbYfWIX84/8DzWXppoiSgv50eZYUm4w0JpSpz9/6Cm+CBByAQi9HO0yOCFprctJFb1M99bqpPkvJAcexeXHkHzqRspnrR4lRpfq2ABopS767lpatVeW1LmXYUC2gpGdco105+vb4hHyikFIrKvN5QZljRanvaqKkm+pwc8kGNFjGmCx3cIQ5BXeN5vuMncVjq3828hn+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbO8pJ5Pxo5f11m81oLUHuDBbUcvH9KDoXQJ+KStqTM=;
 b=g8kY29fVfHOMQppEOGJ1ChqZJ4rWS9I7+GngTbI+VsqnHimzwSV3OZx2VojC1LuKobrKyPK4mPCYd9riKLLe5SJ/rTA/fP9pndAWfMCGAR0WImJ7tJXdanyI0ZeVXs+pEqTeqU041O+65j3eGbV1klq3MdGTqqGgsfup4I38Naw=
Received: from MN0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:208:52f::9)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 19:47:30 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::65) by MN0PR03CA0025.outlook.office365.com
 (2603:10b6:208:52f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 13 Oct 2026 19:47:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 19:47:29 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 14:47:21 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <William.Palacek@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdkfd: Report only clamped wave state sizes in
 get_wave_state()
Date: Tue, 13 Oct 2026 15:47:04 -0400
Message-ID: <20261013194705.3687960-4-William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013194705.3687960-1-William.Palacek@amd.com>
References: <20261013194705.3687960-1-William.Palacek@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: c22a2449-ecef-4235-a71b-08df2962d0cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|261009223027099003|5023799004|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aUX46JwcHfTtv3KQcIEW7Ow75ysetfO83VODnLjb3sikC7vddVM0q7ZMaB8EMbjhzyBe1TxZE4vrHIeDWycmTqjPl3PsaHkuqbvo/OEhRNjhxNfoPHhm2bHnqm2evuZjlzsRZ7802m1tmIPvnAEOXsQCJhn17AKJRbNhyc/F8QEbwgCGFDOJ70f8q4o0qboXA++9TnZqApF60YttpJzeiR9sUi3C51HhxrkDSIA7PjbG5neiJjRCmpvZErk8a0BISGnGXMgOb0OrRbInJWtsHmxCUsAKXo+w3CauWrDAtYhxfip4dl7EfFMs5Pe3nJ6rPb8QVquDgScgNv7YL1UfbYYdsx4E9AD6eLknDXSV3mToGzK6dF3aoXs9zn9ocnoCe6IXeYq3NvER3JunR8ynkArmFwzeFovaeUsAZUbhMgYxU6dZIbm/Hk57+bs6D1caSfXCgOjBSE801+P3nPSvT6TCKBsrwJifA8DVoaJ6YemqwM2tdF2iamPTgjYpdZ1qlAdGN6zbUWLNy4fZeMJFIVRIBySmnDUh4g5joKYgudBSjLRcoNOmPAEbl/txiaKpWzizj1zVqR5TchINvtdKwRl54ddx1Wtdz2w61s6wF6zM7quBH7vnFnTYRLdB3hCNAeea7I51DbTzMd2ilyHkBc/cjEdnEfd4fsIbEuYkxZK5NFdsWTSuE8Tn012YAfCczicOmi0TMXcETfJh0S+Mfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(261009223027099003)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7vxZfDYXG7YDhWoC7ypkv9r/IUUB65UtV6hTflKDohh3XNHSSWRuVAcEjSe4puc0n2KE5mTIIVhIka+n0ilTrZzaDWN7Em9zjN60kgkRQwXrwmz3Jb9pGv9wKeFBbNFOELB4q0S3CvWMODvrJg0XdMugBKF3PIVGgGUFUP8wEokvKr39az1/3nZ7k9gv1GN81ZL2L0wwJVc9I3+ZDsWx0pjXoHyojYEmo7SFNc4nYHzMlDP13hqQukpucOFCJLIG3Hfp2pFjI0G+Jrhi0RNNM9mPCwzDz6xsEgiGmCoNHmuB5pUJWYzM8ITpVbOCMz2/DcdmJyALTVrzalquLYkN2i9N4td89Rr5hLzHBVJ0COytjPVpHsjx39yrzREub+UNLdEDaXpHwTGVY0k0ftLESoevs5wdtOitO9N3EkTcigJenudSzSoQiw+pa1ShfI3H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 19:47:29.6272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c22a2449-ecef-4235-a71b-08df2962d0cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
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

get_wave_state() on gfx9 clamps the control stack size and offset before
the copy_to_user() of the control stack, but still builds the returned
ctl_stack_used_size, save_area_used_size and the context save area
header from the raw MQD values. The gfx8, gfx10, gfx11, gfx12 and
gfx12.1 versions do the same without any clamp. With an inconsistent MQD
(for example restored from a CRIU image) the header and the returned
sizes do not match what was copied, and either subtraction
(cp_hqd_cntl_stack_size - cp_hqd_cntl_stack_offset,
cp_hqd_wg_state_offset - cp_hqd_cntl_stack_size) can wrap to a value
near 4 GiB. get_wave_state_v9_4_3() and get_wave_state_v12_1() inherit
this since they call it per XCC.

Add kfd_mqd_clamp_wave_state(), which derives the header and both used
sizes from clamped values: offset <= size <= ceiling and
wg_state_offset >= size. gfx9 passes q->ctl_stack_size, the allocated
control stack size, as the ceiling. gfx8, gfx10 and newer pass U32_MAX:
they copy nothing from the MQD buffer, their control stack is part of
the user's save area. Values from a consistent MQD are unchanged, and
the header keeps its layout of four u32 fields.
wg_state_offset has no trusted upper bound: the wave state lives in the
user's save area, which the kernel does not access.

Fixes: 5df099e8bc83 ("drm/amdkfd: Add wavefront context save state retrieval ioctl")
Fixes: 14328aa58ce5 ("drm/amdkfd: Add navi10 support to amdkfd. (v3)")
Fixes: cc009e613de6 ("drm/amdkfd: Add KFD support for soc21 v3")
Fixes: 48f0bdf4e38e ("drm/amdkfd: Added MQD manager files for GFX12.")
Fixes: 01bbc4a4b947 ("drm/amdkfd: Add MQD manager for GFX 12.1.0")
Fixes: 7ef144458f48 ("drm/amdkfd: Fix OOB memory exposure in get_wave_state()")
Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  | 16 ++++++++++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  | 19 ++++--------
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  | 18 ++++-------
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c  | 14 +++------
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    | 14 +++------
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 31 ++++++-------------
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |  9 +++---
 7 files changed, 51 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index 38b46b696243..dc4681328a47 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -163,6 +163,22 @@ struct mqd_user_context_save_area_header {
 	uint32_t wave_state_size;
 };
 
+/*
+ * Fill the user header from raw MQD fields. They come from CP firmware or a
+ * CRIU image, so make them self-consistent: offset <= size <= ceiling and
+ * wg_state_offset >= size, which keeps both used sizes from wrapping.
+ */
+static inline void kfd_mqd_clamp_wave_state(u32 cntl_stack_size, u32 cntl_stack_offset,
+					    u32 wg_state_offset, u32 ceiling,
+					    struct mqd_user_context_save_area_header *hdr)
+{
+	cntl_stack_size = min(cntl_stack_size, ceiling);
+	hdr->control_stack_offset = min(cntl_stack_offset, cntl_stack_size);
+	hdr->wave_state_offset = max(wg_state_offset, cntl_stack_size);
+	hdr->control_stack_size = cntl_stack_size - hdr->control_stack_offset;
+	hdr->wave_state_size = hdr->wave_state_offset - cntl_stack_size;
+}
+
 struct kfd_mem_obj *allocate_hiq_mqd(struct mqd_manager *mm,
 				struct queue_properties *q);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 4f8a8a1a6186..64a97723c083 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -252,7 +252,7 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 			  u32 *save_area_used_size)
 {
 	struct v10_compute_mqd *m;
-	struct kfd_context_save_area_header header;
+	struct mqd_user_context_save_area_header header;
 
 	m = get_mqd(mqd);
 
@@ -261,23 +261,16 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	 * Current position is at m->cp_hqd_cntl_stack_offset and
 	 * m->cp_hqd_wg_state_offset, respectively.
 	 */
-	*ctl_stack_used_size = m->cp_hqd_cntl_stack_size -
-		m->cp_hqd_cntl_stack_offset;
-	*save_area_used_size = m->cp_hqd_wg_state_offset -
-		m->cp_hqd_cntl_stack_size;
+	kfd_mqd_clamp_wave_state(m->cp_hqd_cntl_stack_size, m->cp_hqd_cntl_stack_offset,
+				 m->cp_hqd_wg_state_offset, U32_MAX, &header);
+	*ctl_stack_used_size = header.control_stack_size;
+	*save_area_used_size = header.wave_state_size;
 
 	/* Control stack is not copied to user mode for GFXv10 because
 	 * it's part of the context save area that is already
 	 * accessible to user mode
 	 */
-
-	header.wave_state.control_stack_size = *ctl_stack_used_size;
-	header.wave_state.wave_state_size = *save_area_used_size;
-
-	header.wave_state.wave_state_offset = m->cp_hqd_wg_state_offset;
-	header.wave_state.control_stack_offset = m->cp_hqd_cntl_stack_offset;
-
-	if (copy_to_user(ctl_stack, &header, sizeof(header.wave_state)))
+	if (copy_to_user(ctl_stack, &header, sizeof(header)))
 		return -EFAULT;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index bf015dc5b868..e3d2f50f86c8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -289,7 +289,7 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 			  u32 *save_area_used_size)
 {
 	struct v11_compute_mqd *m;
-	struct kfd_context_save_area_header header;
+	struct mqd_user_context_save_area_header header;
 
 	m = get_mqd(mqd);
 
@@ -298,22 +298,16 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	 * Current position is at m->cp_hqd_cntl_stack_offset and
 	 * m->cp_hqd_wg_state_offset, respectively.
 	 */
-	*ctl_stack_used_size = m->cp_hqd_cntl_stack_size -
-		m->cp_hqd_cntl_stack_offset;
-	*save_area_used_size = m->cp_hqd_wg_state_offset -
-		m->cp_hqd_cntl_stack_size;
+	kfd_mqd_clamp_wave_state(m->cp_hqd_cntl_stack_size, m->cp_hqd_cntl_stack_offset,
+				 m->cp_hqd_wg_state_offset, U32_MAX, &header);
+	*ctl_stack_used_size = header.control_stack_size;
+	*save_area_used_size = header.wave_state_size;
 
 	/* Control stack is not copied to user mode for GFXv11 because
 	 * it's part of the context save area that is already
 	 * accessible to user mode
 	 */
-	header.wave_state.control_stack_size = *ctl_stack_used_size;
-	header.wave_state.wave_state_size = *save_area_used_size;
-
-	header.wave_state.wave_state_offset = m->cp_hqd_wg_state_offset;
-	header.wave_state.control_stack_offset = m->cp_hqd_cntl_stack_offset;
-
-	if (copy_to_user(ctl_stack, &header, sizeof(header.wave_state)))
+	if (copy_to_user(ctl_stack, &header, sizeof(header)))
 		return -EFAULT;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 6ea09b031caf..1068a7629331 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -267,21 +267,15 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	 * Current position is at m->cp_hqd_cntl_stack_offset and
 	 * m->cp_hqd_wg_state_offset, respectively.
 	 */
-	*ctl_stack_used_size = m->cp_hqd_cntl_stack_size -
-		m->cp_hqd_cntl_stack_offset;
-	*save_area_used_size = m->cp_hqd_wg_state_offset -
-		m->cp_hqd_cntl_stack_size;
+	kfd_mqd_clamp_wave_state(m->cp_hqd_cntl_stack_size, m->cp_hqd_cntl_stack_offset,
+				 m->cp_hqd_wg_state_offset, U32_MAX, &header);
+	*ctl_stack_used_size = header.control_stack_size;
+	*save_area_used_size = header.wave_state_size;
 
 	/* Control stack is not copied to user mode for GFXv12 because
 	 * it's part of the context save area that is already
 	 * accessible to user mode
 	 */
-	header.control_stack_size = *ctl_stack_used_size;
-	header.wave_state_size = *save_area_used_size;
-
-	header.wave_state_offset = m->cp_hqd_wg_state_offset;
-	header.control_stack_offset = m->cp_hqd_cntl_stack_offset;
-
 	if (copy_to_user(ctl_stack, &header, sizeof(header)))
 		return -EFAULT;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index d508ac5a18f8..79e0d6250720 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -369,21 +369,15 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	 * Current position is at m->cp_hqd_cntl_stack_offset and
 	 * m->cp_hqd_wg_state_offset, respectively.
 	 */
-	*ctl_stack_used_size = m->cp_hqd_cntl_stack_size -
-		m->cp_hqd_cntl_stack_offset;
-	*save_area_used_size = m->cp_hqd_wg_state_offset -
-		m->cp_hqd_cntl_stack_size;
+	kfd_mqd_clamp_wave_state(m->cp_hqd_cntl_stack_size, m->cp_hqd_cntl_stack_offset,
+				 m->cp_hqd_wg_state_offset, U32_MAX, &header);
+	*ctl_stack_used_size = header.control_stack_size;
+	*save_area_used_size = header.wave_state_size;
 
 	/* Control stack is not copied to user mode for GFXv12 because
 	 * it's part of the context save area that is already
 	 * accessible to user mode
 	 */
-	header.control_stack_size = *ctl_stack_used_size;
-	header.wave_state_size = *save_area_used_size;
-
-	header.wave_state_offset = m->cp_hqd_wg_state_offset;
-	header.control_stack_offset = m->cp_hqd_cntl_stack_offset;
-
 	if (copy_to_user(ctl_stack, &header, sizeof(header)))
 		return -EFAULT;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 35c36b6dc212..948415908551 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -364,35 +364,24 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 			  u32 *save_area_used_size)
 {
 	struct v9_mqd *m;
-	struct kfd_context_save_area_header header;
-	u32 cntl_stack_size;
-	u32 cntl_stack_offset;
+	struct mqd_user_context_save_area_header header;
 
 	/* Control stack is located one page after MQD. */
 	void *mqd_ctl_stack = (void *)((uintptr_t)mqd + AMDGPU_GPU_PAGE_SIZE);
 
 	m = get_mqd(mqd);
-	cntl_stack_size = min_t(u32, m->cp_hqd_cntl_stack_size,   q->ctl_stack_size);
-	cntl_stack_offset = min_t(u32, m->cp_hqd_cntl_stack_offset, cntl_stack_size);
+	/* Only q->ctl_stack_size, the allocation size, is trusted. */
+	kfd_mqd_clamp_wave_state(m->cp_hqd_cntl_stack_size, m->cp_hqd_cntl_stack_offset,
+				 m->cp_hqd_wg_state_offset, q->ctl_stack_size, &header);
+	*ctl_stack_used_size = header.control_stack_size;
+	*save_area_used_size = header.wave_state_size;
 
-	*ctl_stack_used_size = m->cp_hqd_cntl_stack_size -
-		m->cp_hqd_cntl_stack_offset;
-	*save_area_used_size = m->cp_hqd_wg_state_offset -
-		m->cp_hqd_cntl_stack_size;
-
-	header.wave_state.control_stack_size = *ctl_stack_used_size;
-	header.wave_state.wave_state_size = *save_area_used_size;
-
-	header.wave_state.wave_state_offset = m->cp_hqd_wg_state_offset;
-	header.wave_state.control_stack_offset = m->cp_hqd_cntl_stack_offset;
-
-	if (copy_to_user(ctl_stack, &header, sizeof(header.wave_state)))
+	if (copy_to_user(ctl_stack, &header, sizeof(header)))
 		return -EFAULT;
 
-	*ctl_stack_used_size = cntl_stack_size - cntl_stack_offset;
-
-	if (copy_to_user(ctl_stack + cntl_stack_offset, mqd_ctl_stack + cntl_stack_offset,
-					*ctl_stack_used_size))
+	if (copy_to_user(ctl_stack + header.control_stack_offset,
+			 mqd_ctl_stack + header.control_stack_offset,
+			 *ctl_stack_used_size))
 		return -EFAULT;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 029572548c14..a11d01689f8b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -272,13 +272,14 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 			  u32 *save_area_used_size)
 {
 	struct vi_mqd *m;
+	struct mqd_user_context_save_area_header header;
 
 	m = get_mqd(mqd);
 
-	*ctl_stack_used_size = m->cp_hqd_cntl_stack_size -
-		m->cp_hqd_cntl_stack_offset;
-	*save_area_used_size = m->cp_hqd_wg_state_offset -
-		m->cp_hqd_cntl_stack_size;
+	kfd_mqd_clamp_wave_state(m->cp_hqd_cntl_stack_size, m->cp_hqd_cntl_stack_offset,
+				 m->cp_hqd_wg_state_offset, U32_MAX, &header);
+	*ctl_stack_used_size = header.control_stack_size;
+	*save_area_used_size = header.wave_state_size;
 
 	/* Control stack is not copied to user mode for GFXv8 because
 	 * it's part of the context save area that is already
-- 
2.43.0

