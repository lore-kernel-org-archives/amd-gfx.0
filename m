Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5A2C02194
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA6B10E3DC;
	Fri, 31 Jan 2025 16:58:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uTLG7Hgx";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25DF710E3DD
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnr+5GlA3LYkwVwgwtKJZVEEi8ViT5I2oHITqIc3U+TvA4g/5oW2wAuS0c0hOIsaRc0Sb2AOnvfyNSO0yEwblJ+XHTSqFgMml/MPgxlDZA9txnGoQbram9b5L3hkZpoIjT8EtOM/UKaQv6wpp6ZphoXm0UDVqPtXkN264uaEHOpyeSt70CmDp8yr4bi+8OMiJZLjDNBqcYgWCmUD6jKIQHhZSn77r10k2/i/FNc1mu7pnBKG4LfWYBkw+hKwE3ANauoePHK9stmfCt1h2MLgTR3TumGC54/ke0PYUGkim5b8Lqtp5E8awUfS0R2q+a0m6Su28nTnd+qIbxADp9zjMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+ToBPL6WZIjCnycTqxRiXp4XQZJ7FYefCxb3rIoMS8=;
 b=ASvv1mPUiNQ0hUsMLi3H2gmZFYz4HFsrsA7+08icG7AMH9kVgkFy7/c92ogtkoDsoboxvpPiZOeA5xA2EImL43zPUIhSFMc6Uk5LGoqKmKdrEHnjeIC3iUDmrPGMgNIe5MY5LiAah0h1E/qE4V0Fkc2/ljS8b6SIKF7lpKEdX7JCcxKl21XG4+fcJweXtBd/nR2F72omXUcSg07NKQHzxBYoVUagjX9flB4DMRivAGLSnVgo8HkbLeIZVmBGyr6L0kEoTZTfDBb6mcIOGB1/kGknlpOQgRkqlCW5eqmdjjVWDNUTqk0hSFOCdWoMUEyPk0VdpfLrTJCyZ4BNjCtFww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+ToBPL6WZIjCnycTqxRiXp4XQZJ7FYefCxb3rIoMS8=;
 b=uTLG7Hgx3A4l6naDTD6L8pCytovQGnsIBh8Qh0pw6wO7n0toXvKR7S3c5oLFuHxgWUDS7naogVX2MULTzJh+qZgsWS5YJI9e3yDxSZcDFCzhDtqSg33zEgtC4IuqJUfh3/v9shA40Yyfh7tM0MKgJw/5Ak8C15efp4gM9IoUvbw=
Received: from CH5P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::10)
 by MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 16:58:24 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::52) by CH5P220CA0002.outlook.office365.com
 (2603:10b6:610:1ef::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:20 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 34/44] drm/amdgpu/vcn1.0: use generic set_power_gating_state
 helper
Date: Fri, 31 Jan 2025 11:57:30 -0500
Message-ID: <20250131165741.1798488-35-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|MW4PR12MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: fc105856-aa90-4382-fb92-08dd42187989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?00SyICMs+sJO4kgx/pDAstq6icOdbJBX5wiMYHcphIeu1O5p8/uxP5NyHoRv?=
 =?us-ascii?Q?FZl7Cy8jV4dGlzZKHBneUwL9n2+91ec1Xnt5OdEIqk6Xk/JpvWvONfryeIN4?=
 =?us-ascii?Q?Xi+MSrsuNTzr+lP4vIVdZtG3Yux7yC6U63ZqMBWg6/bdImK2rQeeLKxfuYIk?=
 =?us-ascii?Q?wlW1AyAjfy91qIoYvlUKoKyAXZ8QnaD6M4Arp7597aPaJ9RzBiXsacj53ClQ?=
 =?us-ascii?Q?u10CFhjrb4eyXznr4kswteN4a6CyzYd0ONJIkqjNWgkxLtw2AbuTGl2JVl0y?=
 =?us-ascii?Q?z09hE7+VWRZTWoKEy5RfajB3DZ3lD8hAYQ0y/WbI3+TrPq2yHgfVf7YhQaLq?=
 =?us-ascii?Q?X5dSvr0q8SgQ7VrUZ5XjKDruqmIqigCrxYu41/np4vtpnBF/+KDdoJBNgF7L?=
 =?us-ascii?Q?wBsmj7+STXwO9fbYXi4M1Lhql0e9K88sbPorsYmtILfOA6v2IrMcVN8c6YQ5?=
 =?us-ascii?Q?zjIV+bs4EXt2Y+GxTnUTjAE+sHFHShw56HTDn3qwrouD318WID3YI30bwTq3?=
 =?us-ascii?Q?LH3u684s6EVYEMnZYIeOX9eU2BlNanIW5M4vYGmfGLGlN3YfZoV2L/qzBWDi?=
 =?us-ascii?Q?fe56hYTqsXr2thZxTnpkhdFO0xdr3FVuftgu3uObjChlI2UcYuGYjroaHL/x?=
 =?us-ascii?Q?nXxTpQzA8Ms/NBjSCHnUzm1l3ToYDnC/dVhgF5fWswsFts/sNw+fzS3j7HP7?=
 =?us-ascii?Q?iHOVpaqsa7TdJlQgJIJroTFtgEyE3N5wPyOtLZ/40GDdibvtBwddMjxcxoSm?=
 =?us-ascii?Q?Nq0pwnbg6zna8XxAJERHzHxjZCCw3Wq4TV+F7+3cnbAZuHwZxT1bQdHyKyBs?=
 =?us-ascii?Q?k6E4M1UhScQuEwqxdD+9XOm8nY4SMblw1xOfa2c7USkFfxMwMuKMhl0HIcsj?=
 =?us-ascii?Q?GaiqbU/HQR4y9Co6G7ONY+wW7NSAKD3pJBXt8K5LJ0o/4nE5nfv06/dItEZy?=
 =?us-ascii?Q?svyMNRs87JrWBHmopqfTicqYapQ2D1kSgs1jIZH3gay/xFKGheGhsERjuJpe?=
 =?us-ascii?Q?YlBaS+s7ENZ3u7lN3y9k/BTwT0bQtszqrIFDh81npb4PB+z93cj03UaAKcbu?=
 =?us-ascii?Q?7v1O287QfssM81hSiBpEtaUlLmyGKBzrLP8ieli8bq1ZWdKplI7sidhiW+eq?=
 =?us-ascii?Q?8nvf0ppER/BhWSbPzL8HdXdEVOlGWBG2Om4rBWJZ4rNxQq27rRqR2UiJnRmq?=
 =?us-ascii?Q?ItTRegtj8Hl3u6xlDo436V5jXTieEqwJdz5vYPfb4+VEBYKSkJ62eiJ1csrj?=
 =?us-ascii?Q?+riVTHnMUDOFP43LVP5q894wu3S5n/KZ72/8F2YR4dvJlTD2jwOVsGJ/2v9x?=
 =?us-ascii?Q?un/doOEt6bpHCyX9A9jzVWxTe8EPwH4kd92bsZWAWj5+AORYgOysuwyzt2TK?=
 =?us-ascii?Q?QsGi3XQZLZEf3DaFrjQQBRCCUlFOog/zUy6STRZ/p3jvvQV8Q+v2oZPIWfpS?=
 =?us-ascii?Q?R40BxKNL3Op+b8viGcQ7BU2l4ebExHpbjpjs4vCdx59Li7dKWWYAjQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:24.1275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc105856-aa90-4382-fb92-08dd42187989
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7309
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

No need for an IP specific version.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index fdb954c7377eb..f3d41ddd0a2bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -87,8 +87,6 @@ static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v1_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				 enum amd_powergating_state state);
-static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-				enum amd_powergating_state state);
 static int vcn_v1_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
 
@@ -1848,15 +1846,6 @@ static int vcn_v1_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 	return ret;
 }
 
-static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
-
-	return vinst->set_pg_state(vinst, state);
-}
-
 static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_vcn_inst *vcn_inst =
@@ -2029,7 +2018,7 @@ static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
 	.is_idle = vcn_v1_0_is_idle,
 	.wait_for_idle = vcn_v1_0_wait_for_idle,
 	.set_clockgating_state = vcn_v1_0_set_clockgating_state,
-	.set_powergating_state = vcn_v1_0_set_powergating_state,
+	.set_powergating_state = vcn_set_powergating_state,
 	.dump_ip_state = vcn_v1_0_dump_ip_state,
 	.print_ip_state = vcn_v1_0_print_ip_state,
 };
-- 
2.48.1

