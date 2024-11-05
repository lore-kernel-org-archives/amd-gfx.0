Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2A7D36107
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 19:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D1210E601;
	Tue,  5 Nov 2024 19:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xm7ih9XQ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E389410E5FE
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 19:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVy5rjnXxuH+MAUXerag+DQ3r/Ad+iKT5sYGoUrs0L6SoO5qUKNSrJDKH1w1gdG7Gko9IW2DkxViXiWscGoz//i8+O4xAB16ueE4G3Q549MMcUnkEjV8EFmwLGkqJ7W738wUrDeKDDa0K7CinAEI97QpX8FOKbKt6WlHGJkOlu4gwblPIUjQX57YkynIfnf9nL5VcbsyqtqJbpYY98h54xjR9kRdYwqXJCWwTb3neFjmOrweF/gpmVjwmJkW3vkM/ZWJcS1w9M0P5xREoHfCW+ZEEGwDGQc96kGm/LebyFo4OHCfqOe+92UK6Vus0KHXISzZ5mWXYJD5eNAmacYGig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSWAX6W/bmk1GcbcP5rZdejuCwPfYaDydKC8VQWRWHE=;
 b=AooX0gVWwtuboCIOkOi83ATvTA5y9xUVZNg27xcROmw9FJismuXtMpvJug+chx915IVPCpB6N3rNw2SiVxOdCqZMo8ls57aWiRD9PlqQH+iIcO9eqNLKzqZIo5h1GgiMvLK6pn8KYlex7DZVDCKcH3smMhb7mTd6DOY8GGUmigeQUr9aKWGw/7sM6WilnFiANh1eV8GJy6OM5V6U5s68OtDUcKhxNF4D8p58lS2uumIJnSCTlcQSXoAa+yf5jxh6hM7iWfDkeEy3H9wwj/Zdoh9hP0hRnlwGLvotvLC+XLyLp18ZyHeh1138dSWds0LBcEPYLz9C1VTZpGUUcZEmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSWAX6W/bmk1GcbcP5rZdejuCwPfYaDydKC8VQWRWHE=;
 b=Xm7ih9XQt36nCv4uNYf+CCXgyj0zLvlCI6pmH0a7s5mffHd48YI4xuliu4Texyv0q7a78Tv1eGnlbl2aOr+ugTAUY0uZ/FIvtkWBpQOJ6YnI54s9F8l15wAw1XpK19yksrhQ8b9SwhO3pYEpIIc29PFwjFvXHKFRmu6eMRyUrXg=
Received: from BN9PR03CA0050.namprd03.prod.outlook.com (2603:10b6:408:fb::25)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 19:04:48 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::ef) by BN9PR03CA0050.outlook.office365.com
 (2603:10b6:408:fb::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 19:04:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 19:04:48 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 13:04:47 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <victor.skvortsov@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <zhigang.luo@amd.com>, <tao.zhou1@amd.com>, <hawking.zhang@amd.com>
Subject: [PATCH v2 2/4] drm/amdgpu: Add msg handlers for SRIOV RAS Telemetry
Date: Tue, 5 Nov 2024 14:04:27 -0500
Message-ID: <20241105190429.323478-2-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105190429.323478-1-victor.skvortsov@amd.com>
References: <20241105190429.323478-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: eb586792-f31f-4adc-9862-08dcfdccb805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1cNuZ3AOyUFk1ANiO7WiTl+gX2XRkKFB3LHqNffZMiXVoJfctktrESrqxThY?=
 =?us-ascii?Q?z2tHTbPCPq8VjsTvoifukQ0LYENuGeHZWxJRwP+cZvcbuVJuD00/V+bxmOHs?=
 =?us-ascii?Q?EBlnvpzdPggoctBMrEQS4/K72nKNXqPMyTHlq/vMMXbW8TMfovZA/CKUh42T?=
 =?us-ascii?Q?BzUIR6M9kRjaspJQNKwmqx19OKUsPRlIyn3vBq/RTfhMhz9Pd6vPmZ9zMRho?=
 =?us-ascii?Q?H3XoEE2RafSNadMqNkgpuWQMFNfBtKwfFlwkk4K1/cIs1UofBK7BZxmd8BxU?=
 =?us-ascii?Q?xhmHW5aYvqrTWr4w8p777GEo8n38N57Q3Bwp/rJoyLmWJmSR55bCASRISJXN?=
 =?us-ascii?Q?LNteF2X4HlQ2n+lpwcvjzbX2hKg0d4QX1vc15GuDvJLaYBDl9/k31SKTlKFC?=
 =?us-ascii?Q?SQgPs7+OIs7q9wc1hDzzTiXh7L5m+9cbn7IJEoinHfLxT9ASrmn0+HuVgmjM?=
 =?us-ascii?Q?ZC7eaDtFxXzHLqmCzIKgSbLETh9/SuWAQWpJezIFb4Dhf5wejTtXbF4jbQqJ?=
 =?us-ascii?Q?RQiEsQE5szAY1zHh62Mun8p5bMEFL03gWDKqknOA55PhDSeArN/Cbnqxnqwl?=
 =?us-ascii?Q?r0NZrfgX9ZFTcjf2o13sKc/3aT7pvb0aRPaHZWTwO5kcV/Ea1ezXxiNnNAuD?=
 =?us-ascii?Q?yDUhEwpkgmBQgY0HHCQ7KYPRQjLs/dce1rWxN6L6VG8xvi55VUT4Xf1a5+4+?=
 =?us-ascii?Q?yK/pDb9V9kOe6frSbBUgEvyaSwCQIGJVDXUGNb8r8As35C1C0ysouq6fj8gW?=
 =?us-ascii?Q?ndMbxQhLfCN7C9D3TwX/pFIUcyy4DqwZToFAwpKRJgiF5QUnbURh489RNWjo?=
 =?us-ascii?Q?Hc9EzvuNJoPLoFflKRELWnvN8jGdL5KfVrGgrSTBvhmgBYaXL6/4Tm0JrZiQ?=
 =?us-ascii?Q?4PvCCHPv4Y5eeMFC4n2varchJnx4o9fbkYqjaB6R2tYxa6cLsZFSkutdflXE?=
 =?us-ascii?Q?lgEODt7Qi6HO2OIPV09q6fRuQYW9mgQuPMKBRdponGcqH5gATLn8Hk2rknrt?=
 =?us-ascii?Q?pkhB870U8vH3zMqcYQlikgoSiRFM3O7F0waqRMrZrhX/sLQBMUiCmNJAeah5?=
 =?us-ascii?Q?JnC+CKjxbxNKC5y37iBakO0kHgMJb51s4pdsLFppwJVTYoZ6uBaikF0NsbdA?=
 =?us-ascii?Q?n0wXzcGdP/ijeBx4WybRkDk1sHdbvWp51KKFuwwH5uoNc1EkOBBne0Q2wy6g?=
 =?us-ascii?Q?BxGMYLK/yB3T/vqjyLQenxwofZA+b8xLbT+X9tgLslqQT1VCPhMsLi1AAgq6?=
 =?us-ascii?Q?PF4B1O8TgUlHybC1epZU9NO+DJHwSXq76DTEdA8UyLhuT7x/kDkqGFdgFSzY?=
 =?us-ascii?Q?PCRpOWH1L/G77IOY6y4HlXKO+wr4tIbMeuJmJ9tZf7UznsCnNl2patPDXgcM?=
 =?us-ascii?Q?A8sPru1iQy7LKwtq/+jIusiH+hsfRi0bkQecsl8bsb2DQqCJAA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 19:04:48.1360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb586792-f31f-4adc-9862-08dcfdccb805
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875
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

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c    | 16 ++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h    |  2 ++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index b650a2032c42..f6eee57338df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -95,6 +95,7 @@ struct amdgpu_virt_ops {
 	void (*ras_poison_handler)(struct amdgpu_device *adev,
 					enum amdgpu_ras_block block);
 	bool (*rcvd_ras_intr)(struct amdgpu_device *adev);
+	int (*req_ras_err_count)(struct amdgpu_device *adev);
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index f47bd7ada4d7..843dcd112b01 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -61,15 +61,18 @@ static enum idh_event xgpu_nv_mailbox_peek_msg(struct amdgpu_device *adev)
 static int xgpu_nv_mailbox_rcv_msg(struct amdgpu_device *adev,
 				   enum idh_event event)
 {
+	int r = 0;
 	u32 reg;
 
 	reg = RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW0);
-	if (reg != event)
+	if (reg == IDH_FAIL)
+		r = -EINVAL;
+	else if (reg != event)
 		return -ENOENT;
 
 	xgpu_nv_mailbox_send_ack(adev);
 
-	return 0;
+	return r;
 }
 
 static uint8_t xgpu_nv_peek_ack(struct amdgpu_device *adev)
@@ -178,6 +181,9 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 		if (data1 != 0)
 			event = IDH_RAS_POISON_READY;
 		break;
+	case MB_REQ_RAS_ERROR_COUNT:
+		event = IDH_RAS_ERROR_COUNT_READY;
+		break;
 	default:
 		break;
 	}
@@ -456,6 +462,11 @@ static bool xgpu_nv_rcvd_ras_intr(struct amdgpu_device *adev)
 	return (msg == IDH_RAS_ERROR_DETECTED || msg == 0xFFFFFFFF);
 }
 
+static int xgpu_nv_req_ras_err_count(struct amdgpu_device *adev)
+{
+	return xgpu_nv_send_access_requests(adev, MB_REQ_RAS_ERROR_COUNT);
+}
+
 const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.req_full_gpu	= xgpu_nv_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_nv_release_full_gpu_access,
@@ -466,4 +477,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.trans_msg = xgpu_nv_mailbox_trans_msg,
 	.ras_poison_handler = xgpu_nv_ras_poison_handler,
 	.rcvd_ras_intr = xgpu_nv_rcvd_ras_intr,
+	.req_ras_err_count = xgpu_nv_req_ras_err_count,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index 74e213e1e937..33d56e5f12ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -56,6 +56,8 @@ enum idh_event {
 	IDH_RAS_POISON_READY,
 	IDH_PF_SOFT_FLR_NOTIFICATION,
 	IDH_RAS_ERROR_DETECTED,
+	IDH_RAS_ERROR_COUNT_READY = 11,
+
 	IDH_TEXT_MESSAGE = 255,
 };
 
-- 
2.34.1

