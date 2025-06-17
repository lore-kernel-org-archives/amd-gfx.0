Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD170C7115C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B07810E49A;
	Tue, 17 Jun 2025 03:09:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sDlXAP53";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D44F410E495
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OImC1eSVus4x0OVyTDBUdr7+g2RFOcKCZl1BK7xDPF/UyMtYyOoup432Q7f569fd3NQmFhKFjECs2VdfYo+XGcnY/UoCDBtxImytSKHaH1mxgILiKSLeHK+aHYXXnUCFCBkz4Ghj7aDZlC1KJtLcyTH3pWOG/3PxiHIrxdjyt2YXH2J6bZgNGFrYFHFGp81L8qdUPjgWqq1Ae8dxzF74V0pIVPg2DGOPAFsxImEoYWFr9t6eQQLJ4TPxu3AsiJR31de4ybjWPy4KCc/S5BhvLkvVSLUljmuBA1N1vkeh4kXrFieFvZz3WcjB2xtm2yBRsKHU4+hBcbQGsZQqVahgDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/RxfIyPnja15DudMxr5H4tMdZM0Z7O4tAyjVCDptP0=;
 b=qFTVk+pCaz+M8yhQ1Dec4KGLVZnLjegJB7EzfRc55BZOv1P1qOPyd7nuNRfw1X6bS8zadkPmUjUuqviza1UaS8S3Q1eOC1bvU7q6CC+s4LDrm4i8A5PAzmQ1GoRwakSaEWUu/07YflCn0YCZEj/CLDgANhL3gacf4fXDCAVCiJFiERYdiINEEXxvFENAh7gsMTBTIO28RsH0HdcyvO7McWKeUEz/S1U6pr5kxqvms8AN7VT7aQhNRzWRtG8boZKYZFpjtQ46zD9HIN4omQ/24ypH5RhvdwEOI1GGXOz8qTuPn/wYa8yjWQaMHl87VxKx8B5ykC19nnWO14hVBVxUnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/RxfIyPnja15DudMxr5H4tMdZM0Z7O4tAyjVCDptP0=;
 b=sDlXAP53L9o/cRI+0i6rokx+m3MmUN3ljxUPfbF6HQPIokOLXVXTreuZMNdERRaBRqWo+9gOpdDHej0gab5OrQ+Urrf7CLdeguMbet4+Qxr/WuVHli9DGNgufj7e0/JKzyhWdhLCseRkdbp1tU1riByz8X1qPTdSf/Anuu9XIkA=
Received: from MW4PR03CA0172.namprd03.prod.outlook.com (2603:10b6:303:8d::27)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 03:08:55 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::7d) by MW4PR03CA0172.outlook.office365.com
 (2603:10b6:303:8d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.32 via Frontend Transport; Tue,
 17 Jun 2025 03:08:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 34/36] drm/amdgpu/vcn2: implement ring reset
Date: Mon, 16 Jun 2025 23:08:13 -0400
Message-ID: <20250617030815.5785-35-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e6a7c8-b65a-4584-dd5f-08ddad4c4b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x4gMHohRcO84gTzzHA529Q1F1znMLrNwELYG/gcVYTlHXcoOaCgHXqY5qPcP?=
 =?us-ascii?Q?3QO+eAg8qLrGSagaRs0+x1PuAT209DT79yfNpr89syf5cev6rrNjEumKioiZ?=
 =?us-ascii?Q?00RQy21VnNVcz0xiU1UZHGbmc7LBJCPWodncSyAeB6AITAS9UqJpWoEfstwl?=
 =?us-ascii?Q?YPAXEVMISAkygQHHF5vOtf3YZQXAhmYbsXi+lrSC4jYbXDoNxcZCiIZS6fmw?=
 =?us-ascii?Q?q1oTq1ojM41niKnNajPqpVm20v1MVOZE91bAIwzb2v9kyng7onzdM8upaKsZ?=
 =?us-ascii?Q?ZahP6WwW6/9ZAgTdLRKROgQyLKMDGXVF/qQeWzvffXxu+2P8H7GlCM4Lrmph?=
 =?us-ascii?Q?7o9aRJ0HJtq+xLFf57FnutDbRtWXRz6lsCGaTEEyEX0pOcxiMjt1DCGCHoq3?=
 =?us-ascii?Q?FuLmmyVitqx7WBSikj8x8q9i+qrQKN6zM9j0VQmkOwE+xqjbGB9MB1dZa2i/?=
 =?us-ascii?Q?IVrCwcgvLqw20EqWLE3YHOO3B3uWwDZ60Vke7C5LfG6ArZQ2ErjtmxX6I/1Z?=
 =?us-ascii?Q?teLmF8WfNnRSM8tkBCJUO/ods/6miMbAKCGYJzXX3I3oJineH6EVEwcTZFCr?=
 =?us-ascii?Q?kquuf/hib2Fe9bJsNmvGz//y6JmwwCPTAgwIq1xTNAT0RZxlS/MSg68ud+RK?=
 =?us-ascii?Q?wjjrkP/euErilwfgAPuTh0a3YHxu63LXXzSSubmWsHn6+a0l447sLmcD7iH3?=
 =?us-ascii?Q?r8WCyMDHj0/EheOObu1il0pLAv5jWK0BuBam/ohob+TDwbqA4FAb04deQrn4?=
 =?us-ascii?Q?hGEApJq+k/aYAaUBfHogjbRytQKEb23QLBL4TcDxfshmlEVsAGSXVxmy6nS1?=
 =?us-ascii?Q?W7+ejo+FzWQpSjkvYw4sHnxgQwtMEe2LFzDgYprKZNcB9nqPma8MlY6msTM3?=
 =?us-ascii?Q?ikzr3UQ2dA23H0iXaSVi2ICjQTzCdhZC75CHha973wSSqzY8b/UIfMq+jYpj?=
 =?us-ascii?Q?ArNeTUK2sN9431xd2jrx+AW5nsfIQrMOpL2rjxnUxMTu0bJi9cJ/r6An/QDM?=
 =?us-ascii?Q?eDzbpjBVIN0vD95xSar/Y2kK6By+6y0DmN/C0nzcBxq3oYkiIJwjP+R42VtD?=
 =?us-ascii?Q?E/G65yRJQv2C2N2ZE7XRdYOuMybdNXvgjhZsUqzF/0WXZXVQl5FKcvNbRCIn?=
 =?us-ascii?Q?18d4wscgu7NAHZSMm9e4ZsNeFMtSirMKTdv61MxO7opXmFqENBBITDI7F+Mz?=
 =?us-ascii?Q?qQej2KgdwRbDXg0i4urNX7tbv3WiSuavvRLb5Xf5Iz/cUrfm5PLlSsBC+k3c?=
 =?us-ascii?Q?Hld+8Au+Pd7sBSAH35A97eTYL51c92KOCM1wbBRLFXesf9SpjOSgNtZtGeWM?=
 =?us-ascii?Q?KNPcSId2AfTWbvKh4ey+oDXQ+kEO9dv0O5bwg8sNb8bGhBUXRfIF96nuOKp8?=
 =?us-ascii?Q?p87QOeLIDgk/cmY15eGhUkhK7+pMySNZxfD8feaLFeFViS2YFFKi7n66Lplw?=
 =?us-ascii?Q?OmrmifusWQWDlOvAmSnLOrZ7PdvYiUKoHpA7HBa8c7AgKpu5HfkLgoo4ZhZf?=
 =?us-ascii?Q?/05NBGc+UY70MSQgJyYLQ0v90Qm2jFaPWUub?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:55.0020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e6a7c8-b65a-4584-dd5f-08ddad4c4b71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960
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

Use the new helpers to handle engine resets for VCN.

Untested.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 148b651be7ca7..4ab02533f2fa0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -98,6 +98,8 @@ static int vcn_v2_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
 static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
+static int vcn_v2_0_reset(struct amdgpu_vcn_inst *vinst);
+
 /**
  * vcn_v2_0_early_init - set function pointers and load microcode
  *
@@ -213,6 +215,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	adev->vcn.inst[0].pause_dpg_mode = vcn_v2_0_pause_dpg_mode;
+	adev->vcn.inst[0].reset = vcn_v2_0_reset;
 
 	r = amdgpu_virt_alloc_mm_table(adev);
 	if (r)
@@ -1355,6 +1358,26 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	return 0;
 }
 
+static int vcn_v2_0_reset(struct amdgpu_vcn_inst *vinst)
+{
+	int i, r;
+
+	vcn_v2_0_stop(vinst);
+	vcn_v2_0_start(vinst);
+	r = amdgpu_ring_test_ring(&vinst->ring_dec);
+	if (r)
+		return r;
+	for (i = 0; i < vinst->num_enc_rings; i++) {
+		r = amdgpu_ring_test_ring(&vinst->ring_enc[i]);
+		if (r)
+			return r;
+	}
+	amdgpu_fence_driver_force_completion(&vinst->ring_dec);
+	for (i = 0; i < vinst->num_enc_rings; i++)
+		amdgpu_fence_driver_force_completion(&vinst->ring_enc[i]);
+	return 0;
+}
+
 static bool vcn_v2_0_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -2176,6 +2199,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
@@ -2205,6 +2229,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static void vcn_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.49.0

