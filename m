Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F85FF8861
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 07:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9141110E5D0;
	Mon, 27 Apr 2026 07:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3/ugS1D3";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C124E10E5D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 07:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQE0KC/5N0WjOwr5mkepPQ0d0Qu7qFzqskmYIjLgKyMnpJNcubWq8EhEFmsr5YTIrbcsv0O/DDGGe02HAohCKqCadCY3qsC/FuMYj/1VG9rsrbbzs+9j51ZqwSXvNo6B01QhDgC7LcB6fiK1lgkH1uuIwosvYlA4kPOKehn3QleSlz7qlmSIL2pUh8iC9WyKd6UnsOFHkXjD9VKhbERDldeVL/YMI4o4PVEl8Ecgq1CMcm3EN+HSq890NOIbwzT4bNE/KwMNQv9DRczHvF1k1dl5KquCIc7fHP2Vp1C+hhxZnmoe3W5Mkg8lZKkDBheSGfaIWT+QN1CjLugqgNV8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKpxn2w/8jd/z4c0io1vpMc0DEjzA91mMqCwLHHdKJY=;
 b=Ny2EGr7269qt54H4CAZBwGfErdUckHX+4I9xobzqWPYw8CE0k68dD5EbfukEVBtnCs/jxqg3VV84Y0VBFxdgVKkzkQx95h1nM3HqB6TlimUkDggeTTSwUMK/kqmuCGQagfiBVMJnE/yfRBg71h7tBsyKklCIkHrWNBT5UTuBJFzvhvo65qG6lw1S4MKXBuKpMrNWLw0dDFpya1CBphi8gMGSuRRQVn6Fr4dsdzAtqozYMMbZVjmX1RDhynhqp2xyPyJtRJY3iiRcmm5qrMgNm5uVJeNv9tkQuw8FnzQldxqu2dMEbl2+w6dV1b9l0n3GWYua7ifDOL0VzpkrAkeacg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKpxn2w/8jd/z4c0io1vpMc0DEjzA91mMqCwLHHdKJY=;
 b=3/ugS1D31sAUNBQ1gRwJzdft+prtuZauBqimtz4/icqju8mFud/s8M1HvUuYxWjVH+o+qWdv8zjBbnlRRgpIae5Wu0IgdFWzC0TDHVCbmU/iTr1fJFzo/Vrtv7apyrjeMXOHjKlXMdynutQH8UDr8mOINNkVU9A1mISk6fcQmcE=
Received: from PH7PR03CA0017.namprd03.prod.outlook.com (2603:10b6:510:339::32)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 07:34:23 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::ae) by PH7PR03CA0017.outlook.office365.com
 (2603:10b6:510:339::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 07:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 07:34:22 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 02:34:20 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 4/4] drm/amd/pm: use the SMU multi-msgs helper in smu_v15_0_8
Date: Mon, 27 Apr 2026 15:33:55 +0800
Message-ID: <20260427073355.3363500-5-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427073355.3363500-1-kevinyang.wang@amd.com>
References: <20260427073355.3363500-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f9d8ac-c03e-434d-fc5a-08dea42f6682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RRBbFXFpeFdgioeFSFaxiVgslid6ngsL3NVbdg4mgEgw+Uo0wxuRMUX9G0GVf/zCDHe4YDcrqI7Tx6f9KjbWTMuY2ywv3lfeDWOeFxZmF15WxXIRJjqZrfy1yj9OjlyWUbjEe0lJBeNB4IxCKAAukZYUlMBtrv+iAL8oqCq6oqcfI1BGOVa6bl8vX8HhifJm1mLXDZV1y/EDGADMmL2+8kQQj2qmUYIyoaylwOr4khajT4zDZA9XAbZ5eRcwGrKdBdU/vVCFzpSdnzBlEu/V/DimzhQgZ1ma5igZIYVtp26j5TNEYqy/ko+cYHuRdVbHgj5mIrPPr20GUE0jopvtX0IFRhtWpzJKRPX0t+JvL9Es8bOOyzekcO1ROQVOCQesp60vr2KQR/0c6cmhh2oIrGfrmBjM8gZf3UIKlhFW6n313hp5zryIXwzkP5J3Lzn9veQEpZIVEEXH4UlNvl9eG9qUTclMIa2mKHsgoCKkmiaOJYLnNexyPmaM4iJWXmSqYdI+Jj5NoTPtxRj94YBsLXzEmxYCuAJq3E6IpSJQLuh4768drYee66mKgleaQav91HiAqDhzs4Sn3CDCgtIMlA4fV9v8sghvbsg4sYJFjiGwgVDfAEz2xvcdtPxlAdVk5ffq3xPEtMDAF27DUhcNjB6Vw946lWXghkuS7sEJzvZ3XQJfBcWzrcv9YgNj/JIw9/sVsqGIxpYdqDnYmxMHK3IC4Yj7IfO381liiHr0Kve1bkdmHLS16Y/Q+4yDQPcFn6advdOJ0jYp7Pnwqa5pvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SFWf60sOrb7hILW22K42DDz2nGj5vWssXf29XZspimJRZA7X19nHs82FTtriHBuWTIYKcGMMBXHsDacK3MJIOu4I+GZqTFR4ijtZfyZKqlrMAj6zIpa2tD2jCW5fkCvhAAm5XXbhszFE8OasBeGtNbdnvGKAvtTCC0pn5W9iVWKvaZerQuGmfzOSrIs+FUnytHVivkttGjIuwxsg3zZQk8bwI6zOFeIJdek2AOthqDu695nKHk0MCHJ0nQgrAAdt4iNb3MHrTNExdh7KSZvexd/znNcjplOiBBST36t6kBagtmRZFqY8Sk0vtFWltdzH9t02TUATs0fNMKmF1NWzLtkDFh3zR007EpmNMcD5Hr138hlGNYEL1zGI37fLn3IhCeL7Rzcb5zT7Ct189mehoVvTo20LMaEulNKe/tRNaNzGjnHBbhFwe7+G19FIPJ03
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 07:34:22.2461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f9d8ac-c03e-434d-fc5a-08dea42f6682
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079
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

Convert the SMU15.0.8 enabled-feature query to
smu_cmn_send_smc_msg_with_params() so it uses the common SMU
multi-msgs helper.

No functional change intended.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 977590377021..2105a1d7bb34 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1313,23 +1313,21 @@ static int smu_v15_0_8_system_features_control(struct smu_context *smu,
 static int smu_v15_0_8_get_enabled_mask(struct smu_context *smu,
 					struct smu_feature_bits *feature_mask)
 {
-	struct smu_msg_args args = {
-		.msg = SMU_MSG_GetEnabledSmuFeatures,
-		.num_args = 0,
-		.num_out_args = 2,
-	};
+	uint32_t out[2];
 	int ret;
 
 	if (!feature_mask)
 		return -EINVAL;
 
-	ret = smu->msg_ctl.ops->send_msg(&smu->msg_ctl, &args);
+	ret = smu_cmn_send_smc_msg_with_params(smu,
+					       SMU_MSG_GetEnabledSmuFeatures,
+					       NULL, 0,
+					       out, ARRAY_SIZE(out));
 
 	if (ret)
 		return ret;
 
-	smu_feature_bits_from_arr32(feature_mask, args.out_args,
-				    SMU_FEATURE_NUM_DEFAULT);
+	smu_feature_bits_from_arr32(feature_mask, out, SMU_FEATURE_NUM_DEFAULT);
 
 	return 0;
 }
-- 
2.47.3

