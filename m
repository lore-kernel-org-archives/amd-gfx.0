Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7079DEB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jul 2023 09:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3CAE10E1DA;
	Fri, 14 Jul 2023 09:38:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3EB910E1DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 09:38:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XE2wavIwQtfSlEO5Fc1UsXhWAnXHeaX0Awp5XHobZaFOHdBlLKveOE5HTj0x3EuX03YoNdQBAx92aW3rUVuClH9CKdV6fFsXGyNOpa2j6MB4S03jWsZh63bYawwqCGxsQywpfkpNc/H5A0qLk3ozd+9uZP6CCIY3Tm2Oda+nnAzuchvi7TzAHQdd0i231cGvZGzI8s7wwFx7Y66joscTCUiKoWkzL0HWUlVTqMuLCRnlrzxADzbaW6/s+3Sn6oexsR8TmiJVldKO+RDVhWvy7IeQPdUOw6x9oHyqgUbZVlxGagY/cmqqpk2dPVcPNTccOSt+anbnwFRle7B+MMlhuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tS6uFtcXZknG3u9xyM5b9m5/6JvVNcnypcn6WqkgvA=;
 b=YcpTUN+2yBDT0rJemMoyYgLCFyUF/J41R7KVgsxorhFFJrMQ0D8dw2chE8FXsUQeWiR/pQPL7TbUN3DF17FXvdG7xwO1APsgzmHoMDpBjV0VZ0o3a72IqmCYnOEnOmOYX3FBAjNcgfQ4bxkvV1SubQfd6vx7anh3xFCWN6MC0z007sDuh5zBMAbDU8N5SP76jmCFdxMmg2jhcLvFFMe3gd1SAHRzEVXNAz5cQQMQ6J8IM9RHO2k+56dddehq5edBkvlKCyqfINRqiHcO/N7PRqCpqVAuDnjF8d97gUsrYvCnywl5N3bdsCSXEqxDIC1yL3N/TJTp+igU9ottWOkDGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tS6uFtcXZknG3u9xyM5b9m5/6JvVNcnypcn6WqkgvA=;
 b=ncu5TruHvXcSUoKZgL+oUhkiU1u/U7fuAptkpO61+fYSGV7+L2MJF++70y0cxGqaOT8SLokNUI96xR8acXALDL3ixU7PeOI80+ZiDHHmkbVb4kPeWqxB8Tmu0iPCmEBe78YIOBfuDhJv9uTXhuray3ULyINbQ+m5XdPcDSGQ1Is=
Received: from MW4PR03CA0134.namprd03.prod.outlook.com (2603:10b6:303:8c::19)
 by LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 09:38:13 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::20) by MW4PR03CA0134.outlook.office365.com
 (2603:10b6:303:8c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27 via Frontend
 Transport; Fri, 14 Jul 2023 09:38:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.26 via Frontend Transport; Fri, 14 Jul 2023 09:38:12 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 14 Jul
 2023 04:38:11 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: fix trap handling work around for debugging
Date: Fri, 14 Jul 2023 05:37:58 -0400
Message-ID: <20230714093759.3246343-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT011:EE_|LV3PR12MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4833ea-d8b0-42ab-63f1-08db844e0a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvtbvktorNQwwtXkuohOEmojnuQMu95oY0uCfQuDV/11XLP9LwSycG2dmVKrhtvY7pbBvb7z+J4cBM8Blqb0O3bsphQ6fFxUqvSzPpDUzCSg3BGiyx+NV1QalVYsg8dFx/i9lASfWFUa7pUAx6HTtB2jK8un7gSclKd4bQRS8GnpAlwlN8WKR/p626TGH0yo6/hQg/v5nj9QhYATOHGUWU4J2gsRmXxj3+UpvuIw7LdbVkDkfP8BpYkDOoih6VIX+/6X4iVi+lC8I//8roeuEQEi/ZVdU7gQr10oqAfmWdAZvI/7we7zk4AlDrDQUSCAP1XpNHkYQ3vKr6eIQKvFKLt18SMmchYhOYZ/++r20SBs1w79i3uUuC8Mk6LQaf/NQggrwz9EF+TsOOlRdWNM3XF9lg9WsOGKebG2tWMNbgHdbS/BMpvvUN7Et/V7agBNbFnWcKwmS2faIWEyc2KSWqKC1Ta5YYMg1xoaY5K7cfFUmT55Px88WzH31S/idnZ84LH7RviWH172dk2U/7ZL5w1HwaobbTdT2tfKU73EkSBCShkhfugv1EikvgH1Sx6+9TVTy5mfLFtcHykKm3RRtoOlnMGa5jeLisifXojdq4sE4wv5vf779Lc3TgdpTudfadDCyOSMhgGACtpz4SMxhJtfuk45C+imK+pnXjZ2iO1Zy0gshCuom44l7zicpPgEKcCIOHzDjv8GD0T1YT7KkZYHThevLikZXA8pkaXSflpcJpsX4t7GY9omMzDTmTCmsJ1qaPWig5QVblIlWz4LyN6WL8GpSu6fZLIeq90PXcg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(2906002)(41300700001)(54906003)(478600001)(6666004)(7696005)(8676002)(8936002)(44832011)(36756003)(70206006)(4326008)(70586007)(6916009)(316002)(83380400001)(426003)(47076005)(81166007)(82740400003)(356005)(5660300002)(40460700003)(186003)(2616005)(336012)(36860700001)(86362001)(16526019)(40480700001)(1076003)(26005)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 09:38:12.1045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4833ea-d8b0-42ab-63f1-08db844e0a90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9265
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the list of devices that require the cwsr trap handling
workaround for debugging use cases.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c                | 5 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h                | 6 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 ++----
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 190b03efe5ff..ccfc81f085ce 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -302,8 +302,7 @@ static int kfd_dbg_set_queue_workaround(struct queue *q, bool enable)
 	if (!q)
 		return 0;
 
-	if (KFD_GC_VERSION(q->device) < IP_VERSION(11, 0, 0) ||
-	    KFD_GC_VERSION(q->device) >= IP_VERSION(12, 0, 0))
+	if (!kfd_dbg_has_cwsr_workaround(q->device))
 		return 0;
 
 	if (enable && q->properties.is_user_cu_masked)
@@ -349,7 +348,7 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd)
 {
 	uint32_t spi_dbg_cntl = pdd->spi_dbg_override | pdd->spi_dbg_launch_mode;
 	uint32_t flags = pdd->process->dbg_flags;
-	bool sq_trap_en = !!spi_dbg_cntl;
+	bool sq_trap_en = !!spi_dbg_cntl || !kfd_dbg_has_cwsr_workaround(pdd->dev);
 
 	if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index ba616ed17dee..586d7f886712 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -101,6 +101,12 @@ static inline bool kfd_dbg_is_rlc_restore_supported(struct kfd_node *dev)
 		 KFD_GC_VERSION(dev) == IP_VERSION(10, 1, 1));
 }
 
+static inline bool kfd_dbg_has_cwsr_workaround(struct kfd_node *dev)
+{
+	return KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0) &&
+	       KFD_GC_VERSION(dev) <= IP_VERSION(11, 0, 3);
+}
+
 static inline bool kfd_dbg_has_gws_support(struct kfd_node *dev)
 {
 	if ((KFD_GC_VERSION(dev) == IP_VERSION(9, 0, 1)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 31cac1fd0d58..761963ad6154 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -226,8 +226,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	queue_input.paging = false;
 	queue_input.tba_addr = qpd->tba_addr;
 	queue_input.tma_addr = qpd->tma_addr;
-	queue_input.trap_en = KFD_GC_VERSION(q->device) < IP_VERSION(11, 0, 0) ||
-			      KFD_GC_VERSION(q->device) > IP_VERSION(11, 0, 3);
+	queue_input.trap_en = !kfd_dbg_has_cwsr_workaround(q->device);
 	queue_input.skip_process_ctx_clear = qpd->pqm->process->debug_trap_enabled;
 
 	queue_type = convert_to_mes_queue_type(q->properties.type);
@@ -1827,8 +1826,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	 */
 	q->properties.is_evicted = !!qpd->evicted;
 	q->properties.is_dbg_wa = qpd->pqm->process->debug_trap_enabled &&
-			KFD_GC_VERSION(q->device) >= IP_VERSION(11, 0, 0) &&
-			KFD_GC_VERSION(q->device) <= IP_VERSION(11, 0, 3);
+				  kfd_dbg_has_cwsr_workaround(q->device);
 
 	if (qd)
 		mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, &q->gart_mqd_addr,
-- 
2.25.1

