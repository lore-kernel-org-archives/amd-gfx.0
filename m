Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B4FC54E67
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 19:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79C3A1124A9;
	Fri, 15 Mar 2024 19:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bpad0D2H";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F2981124A7
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 19:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtIAUW3NhkkTidS8dVgH9GZSjzGdpeuOnJtVhcPOZHd2cZwvYjriEa/RD1T+IoqYe8WlVdkY5N6dD6GjqudO8LYJ1zR4C0AyyOhqCZQnSoqFXmYPDoM6iVsGFfXhG5iHbenfo/ekFv3tOT09YLu7qBXeodi7yIDchxZRrKbVpU+FTrr7m9BqqHv9hEQUyYl+9+JsTJBWY4RZakGFBCWZtjyG7ErbHv+PE5AIgvNC7hq4OqYsKzzwHInzclgVoj9RRMVzPP4Nh89/qbpNtNk0k2viVLm8Ivsjonn2Jfb1K7XZrJEfD1XUqVAf7Tli0+W0mLuuf1r5hFQDZXIwkVi+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cxVQxSOu9hzIoE/wAJilzjUP4pN4Z7yI1U+t5eIu9E=;
 b=AMapCSJM7HnSR9RLAF665OjPRlM5xrCBTCBCs2numxzt2s4qnukWtSnW+X+Tmh0ELlyzPd0/xsTqZG+P3KUDoWePH1jibpqK+12uCqbbv+DnY2aSxQsiRxML0GcytYuyn4AM7cVWlUt7lbctIN87z6HRNwsp8ubYO+kpN8XUahj/sNuS2kUfHK+MW7S8Uad91+XxfG60Wpvmbw456cho5D97qMg5g45Yp2RAu2kKVlNgMzU5uNnPXuCif+2oi1H95oqz+/6jLcWx12g1TSr2mhU0735gnQXrjrg1tFZ7H32OKDiRpJG1pILgrA38zX6ARUBtUroUufd3A6HxDH0SKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cxVQxSOu9hzIoE/wAJilzjUP4pN4Z7yI1U+t5eIu9E=;
 b=bpad0D2HtIoqPCUYR9PCp3Q8a+qrIM3864BB9ON5YvPVX4M8lo87RmEbFxFLuJYfU0dq6QHh76nKr9NUYmCvy6MjuZ1/YgGHH/yRJaWa8MToE0dd8HqPgKO38v8PjenwWiL8m3lIB6MoSJ/QBgbv6IFdSJy4MqY233TYHaXRgwA=
Received: from SJ0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:a03:33e::31)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Fri, 15 Mar
 2024 19:51:21 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::ee) by SJ0PR03CA0056.outlook.office365.com
 (2603:10b6:a03:33e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21 via Frontend
 Transport; Fri, 15 Mar 2024 19:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 19:51:20 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 14:51:19 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <samir.dhume@amd.com>, <lijo.lazar@amd.com>, <gavin.wan@amd.com>,
 <leo.liu@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu: function to read physical xcc_id
Date: Fri, 15 Mar 2024 15:50:57 -0400
Message-ID: <20240315195059.862846-1-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|MN2PR12MB4048:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc08d32-b095-4459-4568-08dc4529498f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVqn1Q0dIgcoRS0wL5JQQH/W5V/YnMn3KPPOpKr90N/U/IwMWnp3xaSL9gkMDLL5AJRcKvE2z60SvEWg3R3+DsphbIDKG5sNu5GeOT4d9ItmEKhr2BDCimieN4AndHkHocIbqF2nFjBoupP5Zy3P/cJOHP9uUNpRm7riwCv939xPRdetp2co1tA9x0Q0+sfGbua5OYJx1VDVvnLLu7eBKR3+gQak/MtyfBVjQ9wIhyqdPgT5q+J6GEDO6xeyzwvXU1xOZNr7mu1D/od3KIOaLqWsVr4a6RqPchg0lkt1/mkRJVUJr1X7YKZA2KqyXxios6eiJMWN0iRAQa3NtU7whhroU+vkJgSTvHbbqf+NqbcCfKWbYTyuGToOmQVh/TzoRpoSa8wUu8JVSsHStpS/GvCrL1q1N7dxtHTkAdtA/OiSlD1cs9QcNlZwSjCJ39yb9xH89hbLJ3wG9i7Udo0dlm4OLa+g+We3eTTJS//17bAYTb0JRw0Gkwg3Yfw6u1CxBHNUICqFR1SFhiorggdFXid+Q1wdnN7vsZO0JmI2ZIgulDtzKoJfsp3XQPfhef4g+n+YxVokq/dyhVjV8ryLCfKnA7oDZIJb0R6bznSOOav3ND4ZmqdxCVlR6s8R7T03DKUS/BsliqxhjAtBZCi/8+PlnjGbchM8Tf++kNume5FKvCYrmwo18aqAXpAuUirxYSSsMV/3WNnvh6lRSOhoSfbUaOUIMljjmW7N4Tan0onHumAkJOzFf0Ech5UPpEIm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 19:51:20.8619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc08d32-b095-4459-4568-08dc4529498f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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

For SRIOV CPX mode, the assignments of jpeg doorbells depends on
whether the VF is even/odd numbered. Physical xcc_id provides
info whether the VF is even/odd.

regCP_PSP_XCP_CTL is RO for VF through rlcg.

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 04a86dff71e6..451192403c24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -297,6 +297,7 @@ struct amdgpu_gfx_funcs {
 	int (*switch_partition_mode)(struct amdgpu_device *adev,
 				     int num_xccs_per_xcp);
 	int (*ih_node_to_logical_xcc)(struct amdgpu_device *adev, int ih_node);
+	int (*get_xcc_id)(struct amdgpu_device *adev, int inst);
 };
 
 struct sq_work {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index b53c8fd4e8cf..68508c19a9b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -669,6 +669,11 @@ static int gfx_v9_4_3_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
 	return xcc - 1;
 }
 
+static int gfx_v9_4_3_get_xcc_id(struct amdgpu_device *adev, int inst)
+{
+	return RREG32_SOC15(GC, GET_INST(GC, inst), regCP_PSP_XCP_CTL);
+}
+
 static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v9_4_3_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v9_4_3_xcc_select_se_sh,
@@ -678,6 +683,7 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
 	.select_me_pipe_q = &gfx_v9_4_3_select_me_pipe_q,
 	.switch_partition_mode = &gfx_v9_4_3_switch_compute_partition,
 	.ih_node_to_logical_xcc = &gfx_v9_4_3_ih_to_xcc_inst,
+	.get_xcc_id = &gfx_v9_4_3_get_xcc_id,
 };
 
 static int gfx_v9_4_3_aca_bank_generate_report(struct aca_handle *handle,
-- 
2.34.1

