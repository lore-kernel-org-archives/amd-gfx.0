Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D34FCD8C9A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 14:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3361410E393;
	Tue, 10 Oct 2023 14:42:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75C9210E38B
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 14:41:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0cstmY/UwDYsFITl6xSIW0mCwRo0qbOki5voTgj1ALVdCIn81nHg0yYZ+UW//ltsIHSvQzAuv/4UJXTRHrH5yNhweVTTzo2Z9+E7WiVT+LbVXQpu/IdNotokTMH20F1SAiWtZjgYf4ItUx0ZATSAIzu4ud4bLntiTb/9YL13TXo2e1fTQUZ53WWFI02OIVtlpR5QQjCZWZDZQ1JwdwCp9OqW08melKN++pisMfT17hqcZQWqKriuKdyrla5I820XJZwWXRWLGON1nhzCIhYihxicWyHfLU4RtoGHCQ8V6jxudgm+B7kZ9kVWSNO28vouzFkimhjmZndUlEEwlfubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkAJvYb7SWa+KcvFYP6YBDMA3fg0NB8TCKSMI7JSoLw=;
 b=SslfBZWS1Hl5gKWfSmDF20mlIGCBwc5tNzVOzprXy2jVwLZNH0vs2HubGF1u+nq6ZaNZZ1L3FDchFx/B2IhPcXChfGnPGyTkFLrm9qjucrSlV/6Jkh2XFOvv21tvz4UYxhX0DWQaLpWA1zPtwzS9uWXsSbXFiCBRrYT8gfvQTijEclC5bovh4XgH/AYKlsaPm66CQKm3O/i8xY7C5BmBLMSETaLNfEKdKhFszzAInbvrk6MT1a2qOKyePFt1QDdq4fHcHw2w73t66uYI8pq66DrgGpLbUoe4lD0COORRLknATDVbCvT/A/iInBPKBrf/0M/euU5ZzKJu3hs5WPS39A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkAJvYb7SWa+KcvFYP6YBDMA3fg0NB8TCKSMI7JSoLw=;
 b=oFzWIFZWaDCedjnAbfXTzd+38vBlt+VbktD8WRA9l9jGb99+WH0l3U42K0nCYGa5c5U8QUlz8EIT7+EPlPawNmB74+x6hqrCbpHVpuNorMB/MjyvWyExjFpYbovhkLCoN3oVx34774ug0rOygJJFK6zX+nAV0QdIQYBIWB5TaVg=
Received: from MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::6)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.40; Tue, 10 Oct
 2023 14:41:48 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::bc) by MW4P222CA0001.outlook.office365.com
 (2603:10b6:303:114::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Tue, 10 Oct 2023 14:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 14:41:48 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 09:41:47 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/7] drm/amdkfd: Add helper function
 svm_range_need_access_gpus
Date: Tue, 10 Oct 2023 10:40:19 -0400
Message-ID: <20231010144024.3016-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231010144024.3016-1-Philip.Yang@amd.com>
References: <20231010144024.3016-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|MN2PR12MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf734d4-0e71-4ccc-ce6c-08dbc99f08b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVZae0yQcrR9HGrwNNO7GF/cNXHDyTq7Y8THBOnHYB4RiKWjANAYQnW8G1JxmmHV92Q+WWl3b3CQ/UdHdrCVe+/13vC+19bORbw0bD8ZZPV+qkgkgAvWXGPuw6R8h+TxvdmmmP+ZiW3iM+/llv6L0dvRKqC3xOnUdrJhTAigJ8aKuk1GHyZ610f0zmSujzm6mvGp80PzOY5+gYdMxfd1rbJv8X/hQ9ri2ml7qQFgC7U0o0Apx2sS8k8uKtBNJSAdDqtjSPdIGbRHRm2ZjocNYrxy3e+xqV6mJsS9KbIeTnf3FjlP3CGrMec7SPeVLm/M6dOgFaY/ueI0a7qR7T9VFnTcm5Su4RKVQvMYNiuEY7Og65s3ytOacVf8FJHPv0KCjGzMrwF0KNjICpJMtXSRgn4308LWeGLyrd/wjrnHHQNTuY15nohMFu3/H+QWzte7VvZaRAyTnyzn8Hx0yA+83FxAdgZEPQ0j4OOJzZFaL0lMvAP26Kma+OsNfgtnxxXutTz+4l/NWUgn/Q3sEb3q5/6P9E1/zOodsl4x8nvptZnUxS4CYE6zpFcH9n/t6FMCPIpv0wVxBRaCg9AgQ0kAD7qTq5thW1ugb03lxHRC5qGo+DiRxU29QlPSVQA/KzWEFJGbx6TcD2jPqnBz/zkA6Qm+FRnp3jIhBJ5Iryc1cv8c1xtnqkknfo2T1HVngyXwRDdg+USrY/b5aF5OxW1cCMp6vGD0v0pOfqmt5dXZNDGM2rVP5f+CXk51fRG4nel64LVbhnfdI4xRjH/lwiC7AQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(82310400011)(1800799009)(64100799003)(451199024)(186009)(46966006)(36840700001)(40470700004)(36860700001)(83380400001)(47076005)(40460700003)(40480700001)(4326008)(8936002)(70586007)(70206006)(316002)(6916009)(8676002)(41300700001)(54906003)(5660300002)(478600001)(2906002)(86362001)(6666004)(7696005)(81166007)(2616005)(356005)(336012)(36756003)(426003)(1076003)(82740400003)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:41:48.4635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf734d4-0e71-4ccc-ce6c-08dbc99f08b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Refactor svm_range_validate_and_map to add and use the helper function
to get all GPUs bitmap that need access the svm range. No functional
change. This helper will be used in the following patch.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 55 +++++++++++++++++-----------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index e195106a77cb..fb22b857adbc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1191,6 +1191,34 @@ svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
 	}
 	return 0;
 }
+
+static int
+svm_range_need_access_gpus(unsigned long *bitmap, struct svm_range *prange)
+{
+	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
+	uint32_t gpuidx;
+
+	if (p->xnack_enabled) {
+		bitmap_copy(bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
+
+		/* If prefetch range to GPU, or GPU retry fault migrate range to
+		 * GPU, which has ACCESS attribute to the range, create mapping
+		 * on that GPU.
+		 */
+		if (prange->actual_loc) {
+			gpuidx = kfd_process_gpuidx_from_gpuid(p, prange->actual_loc);
+			if (gpuidx < 0)
+				return -EINVAL;
+			if (test_bit(gpuidx, prange->bitmap_access))
+				bitmap_set(bitmap, gpuidx, 1);
+		}
+	} else {
+		bitmap_or(bitmap, prange->bitmap_access, prange->bitmap_aip,
+			  MAX_GPU_INSTANCE);
+	}
+	return 0;
+}
+
 static bool
 svm_nodes_in_same_hive(struct kfd_node *node_a, struct kfd_node *node_b)
 {
@@ -1631,28 +1659,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	if (gpuidx < MAX_GPU_INSTANCE) {
 		bitmap_zero(ctx->bitmap, MAX_GPU_INSTANCE);
 		bitmap_set(ctx->bitmap, gpuidx, 1);
-	} else if (ctx->process->xnack_enabled) {
-		bitmap_copy(ctx->bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
-
-		/* If prefetch range to GPU, or GPU retry fault migrate range to
-		 * GPU, which has ACCESS attribute to the range, create mapping
-		 * on that GPU.
-		 */
-		if (prange->actual_loc) {
-			gpuidx = kfd_process_gpuidx_from_gpuid(ctx->process,
-							prange->actual_loc);
-			if (gpuidx < 0) {
-				WARN_ONCE(1, "failed get device by id 0x%x\n",
-					 prange->actual_loc);
-				r = -EINVAL;
-				goto free_ctx;
-			}
-			if (test_bit(gpuidx, prange->bitmap_access))
-				bitmap_set(ctx->bitmap, gpuidx, 1);
-		}
 	} else {
-		bitmap_or(ctx->bitmap, prange->bitmap_access,
-			  prange->bitmap_aip, MAX_GPU_INSTANCE);
+		r = svm_range_need_access_gpus(ctx->bitmap, prange);
+		if (r) {
+			WARN_ONCE(1, "failed get device by id 0x%x\n",
+				 prange->actual_loc);
+			goto free_ctx;
+		}
 	}
 
 	if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
-- 
2.35.1

