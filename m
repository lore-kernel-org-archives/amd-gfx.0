Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BE0C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 09:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5117F10F50F;
	Mon, 22 Apr 2024 09:49:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I0x0WhyY";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1F4A10F4EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 09:49:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TC3Zbw/8xbEUcv/vZaSlYgsT/s1g1HPZzkqvOQLkeFt91XTmu9oHBRvajikipp/A5yUo5x6qXHmZLBcLhOE/EwtNr8gW2fcKHrxfVUk0fFWkfOazeE8LcKtFbYCSrnFs1tpdjzW5j2YRr+udZRjLm2FFu4DIT/Hb31NlwxXKx+LTInv3oxx/RJFg7j4YNaMB5v8j/+vIA/ViEEkcX5e0GkeLPcdtGdtaYFXDCnhWInqvmksPssDXqH+ZznFxP2fgHy1yNaPw84nav9YXV9zokh2Yi4TZdhVmcf3aeDbqH79wXaIqY5uWozvr54rmrSuodFmX7hGmHN73KqaboaCXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dc71HOJoyKz4qWA8puG3KNQwD49TX/irDFIC7idJxb0=;
 b=evVs1njHgnnJKJUpXPlY1Tz5tX5m1Q9LAADAq/QNZNWk4Rk3N7Regrs4XCTgXYKQ8j0JzDi5OIc6YQjTr+H/D2ZmKE+az/6fl0R5MxXLXDyLlAp6X58GKjkdSEbtNiqdTxGSGIVTEYXbv3qAGpwtCEzRvI2gzGOQo2yimjRaDU9LGOhHhH5t6NBarFLGsV5IKLw4AnmYwtWEYpRVHKdC/8n2housr7XG6xMNDdp2WmyeJGM98Ti+ec3p7EE+ccTWN816Ue7kyX3of3dr2A9QVVqO9w66Vv0FhPm5BeXoVrDMRXtR697TmK096UU4YmnHkKmpVPn3XnlBPU9Z9bBq8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dc71HOJoyKz4qWA8puG3KNQwD49TX/irDFIC7idJxb0=;
 b=I0x0WhyY/vTot7xZ9SDI9QTBDpVA0Rtcq09UKsxwbsVnXasxx2CWd2GIOAZXSv4RXJAq1nDnc5VuW6OJ+4GO07uUlfqtIHFjZUher9HQ3DntJxmfECC+lrU1Sn1DMVgvG96wfzGydyRUAchE1jV74dnrvxbf4TBViawTsLtWByo=
Received: from CH0PR03CA0210.namprd03.prod.outlook.com (2603:10b6:610:e4::35)
 by PH7PR12MB6906.namprd12.prod.outlook.com (2603:10b6:510:1b8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 09:49:26 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::55) by CH0PR03CA0210.outlook.office365.com
 (2603:10b6:610:e4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Mon, 22 Apr 2024 09:49:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 09:49:25 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 04:49:23 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Fix Uninitialized scalar variable warning
Date: Mon, 22 Apr 2024 17:49:08 +0800
Message-ID: <20240422094908.537208-3-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422094908.537208-1-Jun.Ma2@amd.com>
References: <20240422094908.537208-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|PH7PR12MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: c5fa48c6-e89b-49ba-630a-08dc62b17eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9zu57QBG8b7x8eWgLfBQfY6BK5u/GgEg3JxZy+ypGkSv+dHFFcs9ey/lf3We?=
 =?us-ascii?Q?f+FMAFVvX3RKCEGYW6pAoqOUSuv5jORY9HNHCIMGgfbGoH7pBLV/RlwHSCC5?=
 =?us-ascii?Q?8LrXIfPNOPQmmqF9VVSUcNolGOuycKferntYvDKj6qPgHyVeWx2XazXmrTZc?=
 =?us-ascii?Q?54k92iNzQKa49ITmpg2Ck63oMUb45OrgnD4wq3ufG0G03HCl+y9S+/kaV0GV?=
 =?us-ascii?Q?exoKmSDcgC5pIr+nUBw/rJvW9WceJkDQ3UpXhl04C9gCr3PlI4KS41GR3wK5?=
 =?us-ascii?Q?YbbAXQ+oJjimVf7plZQescV6SRNZJgQ8wceayP0GTTVBqSU+6MFTycuNNdUv?=
 =?us-ascii?Q?7n8cWr57ihwHUMFBrnMGPFO4cit6aJVdtxbE9Z+2YzQ1wxLkfm09ldqm3Gl4?=
 =?us-ascii?Q?Cr+tsMY2SwtmrpAHYUBU2U4VH6SE735b7J9nS0j3U5OuFZDaq+VQRUQEpuzy?=
 =?us-ascii?Q?xPt4y97dZkB+oVZS/qUzPojrnhY9MuQSXAs7/vtFPGUv0E70Byuc710n3Hq0?=
 =?us-ascii?Q?aUvPJJDiIdLWV0UoDGiNcKDHBdytEqougPHsgeLL5Zq8u1S4a4yM/I9EZtYZ?=
 =?us-ascii?Q?5eY4yiEp9Qx4BPY6oFeibGvLVUt8Q0i63h6+BgXVbLLrBFMwRLlvWrMiGmZx?=
 =?us-ascii?Q?Uk8HY6HrpaiX7GcyxkgM5f6IB52TsYwzOX9WtR05USafGaNL5BRL+84gLK/r?=
 =?us-ascii?Q?F5BrlXoEcmYwiIe3GRmgi8YNKeoWh1mm99+yFC7+bTwILWpRWzv14LWilohw?=
 =?us-ascii?Q?FHEY4O6T6aCT16/ao9nOyl5rfr9b4Mtd7DmHRDjch18EuD1LzqE2VH+VZBCo?=
 =?us-ascii?Q?nuztE2jZueNwqZDBpHmQSPQcB62nm5b9O7Zb76VnlNYXATyNg8pwnfFn98gg?=
 =?us-ascii?Q?itqwtftLouxOdB6EYcbIqEEbabro6z3xoXeACv2T3Rdg35U3Wv8FmON6gSXQ?=
 =?us-ascii?Q?2HneqArNovK6T0pNEbJpXmwvbcLNHA5LUTep+mg6x3zc2j3iCe1ul9yZmonk?=
 =?us-ascii?Q?LPj/NFUYtPJsJViStLrqokJC2d7kA25tD4PZiZlw11hGUJEbA9yyGLMSOOzO?=
 =?us-ascii?Q?CnRV6xF4bmvnnIrEwC0V/JbATdXG9qVPC7maWot3t4klyCKjjG6ztb8Shk30?=
 =?us-ascii?Q?oOfT/OIMa7Korxb5JkVeWJQJquaVAJz50P6jfvlP5JdbboU2SK1WCkWLlZKa?=
 =?us-ascii?Q?PWh4uvBSc9mWlccBZks/TsKMdBi/P96c+BB43ltASioJWme+wjsUa8CKg4uK?=
 =?us-ascii?Q?6piDKaeaeMRsTS54PNe0O+ufdvE0hhJYyGEcsbj8+lRYQ23UL7zqHi4HwY8M?=
 =?us-ascii?Q?WaS0xnDxMbLgG5DO3nqgOR/OfX8HsMdEikkbsX4q9WHGlSAltN+U/x8ptShp?=
 =?us-ascii?Q?dK/FuJ7QIxw3Wy+GV4MmiHmtUPs7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 09:49:25.7272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fa48c6-e89b-49ba-630a-08dc62b17eee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6906
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

Initialize the variables which were not initialized
to fix the coverity issue "Uninitialized scalar variable"

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 7e6d09730e6d..7b28b6b8982b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -437,7 +437,7 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
 			 struct amdgpu_ih_ring *ih)
 {
 	u32 ring_index = ih->rptr >> 2;
-	struct amdgpu_iv_entry entry;
+	struct amdgpu_iv_entry entry = {0};
 	unsigned int client_id, src_id;
 	struct amdgpu_irq_src *src;
 	bool handled = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 924baf58e322..f0a63d084b4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1559,7 +1559,7 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 {
 	struct amdgpu_device *adev = m->private;
 	struct drm_amdgpu_info_firmware fw_info;
-	struct drm_amdgpu_query_fw query_fw;
+	struct drm_amdgpu_query_fw query_fw = {0};
 	struct atom_context *ctx = adev->mode_info.atom_context;
 	uint8_t smu_program, smu_major, smu_minor, smu_debug;
 	int ret, i;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 2b99eed5ba19..41ac3319108b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -120,7 +120,7 @@ static void __amdgpu_xcp_add_block(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
 int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
 {
 	struct amdgpu_device *adev = xcp_mgr->adev;
-	struct amdgpu_xcp_ip ip;
+	struct amdgpu_xcp_ip ip = {0};
 	uint8_t mem_id;
 	int i, j, ret;
 
-- 
2.34.1

