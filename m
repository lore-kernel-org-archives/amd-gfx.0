Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D04FD637CA
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 21:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE9410E750;
	Wed, 13 Nov 2024 21:45:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QYvAf4WA";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED85F10E720
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 21:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFSFe+HQIPHAvbsYYC6tLSJVxKxqTDqWpLGDNqpNG3SpJY0atUPycUkdcAuV6vTD/RpDBBwsqmoDKhKEX4WllMSoIOckg61mS99EFfTXSdsOP9lHFPLWeK2x5L7lpUg+nxZLQpguXWsyR+YidbpV96qLEaiLm7yQShnDaeWpo1ta+V5hTleLWkQwjsFb63VSejYznfGofhJNgBPRKRMqNTk5Y7Ml/Uu6UkcZQFdWEJeWVXuu+jH9U7skQoN9hEecnx8TgWNfby/7vQOKXK0WHGiMvnzvPPrbm9+aAeXoUvhOJnCpcKhA1X/7uqfBXEoyatOGTJR4gXEm4uv0XxXkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLidOnwV/MgVv3UjiZyhXN+1LVKoxgPFp9FEZHsWzlg=;
 b=wU8/9PL7P0/UFEXrUrRl4nJE/5k4T5nww77HR/1o6jNiC9mYhV70G6oy5ZLk5U2ChWSD2DeQydPrWrXgSCcyTp6k6NkvcmsHANszXn7xsi3xrlQJY06dJm1tWvQo/Tu6pClJYXA+aRxGlH323x3uOjuQyi0t2jkneUzj/NMJntZbuzKbN3q6XTVlw7XcOLMIDfKEpFZNZyute9MvzJu5r52CHp1H6YhZ1QzXhilTj9NNt4XgNRprVSk5lwmvlbEk/jJHnY7KIv7zF50dQ1dhkNgszMNHjKI+4O51hnMIo9j0ra6sDUx8DlTrf0AGth3WlH7n5bIBYsKF6BfLRR6abA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLidOnwV/MgVv3UjiZyhXN+1LVKoxgPFp9FEZHsWzlg=;
 b=QYvAf4WAleZE0VYXWsiJo6uwRuWdmO8HqlxHuTYdw7VgfK6sN1SmuifX6x98pZ/foVbJZkvJErizrE4uuXE9g8223dA9W8ANUPn+YrQEiaEjpBthw7k9bSm/Wa1K8Cqdonr9KpQdrVA+g+P8FtsxbH1bdWwwX91Bz5hKxkJ6se8=
Received: from SA0PR11CA0139.namprd11.prod.outlook.com (2603:10b6:806:131::24)
 by DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Wed, 13 Nov 2024 21:45:21 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::3e) by SA0PR11CA0139.outlook.office365.com
 (2603:10b6:806:131::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 21:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:45:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:45:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/15] drm/amdgpu/vcn: add new instanced powergating IP
 callback
Date: Wed, 13 Nov 2024 16:44:50 -0500
Message-ID: <20241113214453.17081-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113214453.17081-1-alexander.deucher@amd.com>
References: <20241113214453.17081-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DS7PR12MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: 20cb78dd-91b0-4518-bffc-08dd042c787d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vW0ZTVmDJaraJe05h48ZLjSR84ni6nsieE2Un4V/aGyRb/hhhTH0GQnG4xhr?=
 =?us-ascii?Q?PDwQHreq1PA5RWnwdfPVR1hH33ieC3l96JWrHSNIP8CYxpFbxUktYiALzBMs?=
 =?us-ascii?Q?Ca2+CT9j3kdN9t6CY10zLfJdmI+LaarTNbBieF8pDS2Z6AJUyUxn0Q3VvnwK?=
 =?us-ascii?Q?Dsgf59OxUQQkuf8z792SGz7WrAR14eRyW3rISfXCyKRkP5EwmqP/SIxctyl0?=
 =?us-ascii?Q?K0JMfKKG0JvcWXFTAz7fNXVQSPmXix1ABhF/ajhaahnJumNH0LmoPFn2aM5I?=
 =?us-ascii?Q?REQai41Krvquw0imTAOC8BQ180CyJjywmPf5/T8gYYNijyRajvRVWuqJvrQZ?=
 =?us-ascii?Q?TNmKG2yHWdPAE8sxgp+6qHOYVWDFVB7MPhy/0r9B5zNd1GZcrHLWTJcPBzxS?=
 =?us-ascii?Q?wkwa+Bdr1DBkxMVG0XM6SR06i7ruLYC1G3kcud353OmvV4LZAqb3/jLf5nSu?=
 =?us-ascii?Q?VaGvBRDnlixIjd/LJ0FMgIqdrmAZya1A94S1QgFyc6hfeIOTpSFx7hnpOS0E?=
 =?us-ascii?Q?MFUxPSQWtcGs2Ovr5KFROSzNI2VmG2gKVSncLErnGuncVfyfxVHt34SJqMZD?=
 =?us-ascii?Q?v98rXpViAr6dvJpaCssLkY/kMws0oAdbUtvI3jsLNyJpY2yvRcVqd6iL/reQ?=
 =?us-ascii?Q?9LO3YYLc70bKcU+qYnm2MuOyMB2CKUSdk0G9b2lVAQVANYUAdOwGAuiTSXQO?=
 =?us-ascii?Q?MB/da+Vb6C7g5l+lYcbtE+HYRBVTobQuZorH6Oa0m0fgryM5EjmcMlLMbBDe?=
 =?us-ascii?Q?E0XfwOxN723H8ytxdSwSN9W/6Dtcxa4L9x1r4MvD7pQ+H/u30Q7sgr0XEhtz?=
 =?us-ascii?Q?SVh6C0FSOamEqmlBZz34jYLy7aj5RIVhWInvbHyNb5vO5Ck1Xd8nImK4rra0?=
 =?us-ascii?Q?s9MtGV/PhYbNsetI59wZ/87+eMXqJbITeTQpFVgAILgu9Fjl7kCg8xUvhX2g?=
 =?us-ascii?Q?2lSH1Rq+e1P8V2OKU9z32EVlfW5pKFe6bL19njvq9XJzu2jqzv6G6mZ2EcyB?=
 =?us-ascii?Q?/HLfLT940AL4Tg1zpAhB8c5G81tYtSlFeqpAzsu0j5pfKPtjIugqBXsFai4M?=
 =?us-ascii?Q?i9RN8CxvKPIHLJUZlqHZ71fb63s41GQqaQ423LIwzgjWdMTcDVt33nmTc8KK?=
 =?us-ascii?Q?9Lmv0TaIzjDnciXAawqcTH214/vplZPKP96eptzgTX6XXBAbGgFkX7n76IYz?=
 =?us-ascii?Q?RT2x+WTbdRPsBetlzVLJwvLxpas4ss9L5gnG9VW6v1UeYPKYgAOrDfq2iPe1?=
 =?us-ascii?Q?nlgAVZh6Af4ZJ1BuuGK2b1twwrOQ7NRiFLGZKYSKGogBduBJiHD2Stb8LdzM?=
 =?us-ascii?Q?LFE5L3CWe2YsQ2PoaXKVhCjdyxdGyNcubAehWDEaA+V6JLyz9ZBhGX7mHIOi?=
 =?us-ascii?Q?oyy/jjoQEqNU+L78K+f1mj4y95P0l56EO11OJX8rWIt6zBqYww=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:45:20.0713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cb78dd-91b0-4518-bffc-08dd042c787d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837
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

Add the callback for per instance powergating.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  1 +
 8 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 406886f13566..99120166107c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1826,6 +1826,20 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	return ret;
 }
 
+static int vcn_v1_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i)
+{
+	/* This doesn't actually powergate the VCN block.
+	 * That's done in the dpm code via the SMC.  This
+	 * just re-inits the block as necessary.  The actual
+	 * gating still happens in the dpm code.  We should
+	 * revisit this when there is a cleaner line between
+	 * the smc and the hw blocks
+	 */
+	return vcn_v1_0_set_powergating_state(ip_block, state);
+}
+
 static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_vcn_inst *vcn_inst =
@@ -1999,6 +2013,7 @@ static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
 	.wait_for_idle = vcn_v1_0_wait_for_idle,
 	.set_clockgating_state = vcn_v1_0_set_clockgating_state,
 	.set_powergating_state = vcn_v1_0_set_powergating_state,
+	.set_powergating_state_inst = vcn_v1_0_set_powergating_state_inst,
 	.dump_ip_state = vcn_v1_0_dump_ip_state,
 	.print_ip_state = vcn_v1_0_print_ip_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index f445ae401359..b4464ddba847 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1828,6 +1828,20 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	return ret;
 }
 
+static int vcn_v2_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i)
+{
+	/* This doesn't actually powergate the VCN block.
+	 * That's done in the dpm code via the SMC.  This
+	 * just re-inits the block as necessary.  The actual
+	 * gating still happens in the dpm code.  We should
+	 * revisit this when there is a cleaner line between
+	 * the smc and the hw blocks
+	 */
+	return vcn_v2_0_set_powergating_state(ip_block, state);
+}
+
 static int vcn_v2_0_start_mmsch(struct amdgpu_device *adev,
 				struct amdgpu_mm_table *table)
 {
@@ -2106,6 +2120,7 @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
 	.wait_for_idle = vcn_v2_0_wait_for_idle,
 	.set_clockgating_state = vcn_v2_0_set_clockgating_state,
 	.set_powergating_state = vcn_v2_0_set_powergating_state,
+	.set_powergating_state_inst = vcn_v2_0_set_powergating_state_inst,
 	.dump_ip_state = vcn_v2_0_dump_ip_state,
 	.print_ip_state = vcn_v2_0_print_ip_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 1d3780a2d851..6eff8be031bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1998,6 +1998,7 @@ static const struct amd_ip_funcs vcn_v2_5_ip_funcs = {
 	.wait_for_idle = vcn_v2_5_wait_for_idle,
 	.set_clockgating_state = vcn_v2_5_set_clockgating_state,
 	.set_powergating_state = vcn_v2_5_set_powergating_state,
+	.set_powergating_state_inst = vcn_v2_5_set_powergating_state_inst,
 	.dump_ip_state = vcn_v2_5_dump_ip_state,
 	.print_ip_state = vcn_v2_5_print_ip_state,
 };
@@ -2015,6 +2016,7 @@ static const struct amd_ip_funcs vcn_v2_6_ip_funcs = {
         .wait_for_idle = vcn_v2_5_wait_for_idle,
         .set_clockgating_state = vcn_v2_5_set_clockgating_state,
         .set_powergating_state = vcn_v2_5_set_powergating_state,
+	.set_powergating_state_inst = vcn_v2_5_set_powergating_state_inst,
 	.dump_ip_state = vcn_v2_5_dump_ip_state,
 	.print_ip_state = vcn_v2_5_print_ip_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 13b9ed96cccd..e74b36625d2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -2334,6 +2334,7 @@ static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
 	.wait_for_idle = vcn_v3_0_wait_for_idle,
 	.set_clockgating_state = vcn_v3_0_set_clockgating_state,
 	.set_powergating_state = vcn_v3_0_set_powergating_state,
+	.set_powergating_state_inst = vcn_v3_0_set_powergating_state_inst,
 	.dump_ip_state = vcn_v3_0_dump_ip_state,
 	.print_ip_state = vcn_v3_0_print_ip_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 9b7fc7ee4188..3c5f8523cf5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -2261,6 +2261,7 @@ static const struct amd_ip_funcs vcn_v4_0_ip_funcs = {
 	.wait_for_idle = vcn_v4_0_wait_for_idle,
 	.set_clockgating_state = vcn_v4_0_set_clockgating_state,
 	.set_powergating_state = vcn_v4_0_set_powergating_state,
+	.set_powergating_state_inst = vcn_v4_0_set_powergating_state_inst,
 	.dump_ip_state = vcn_v4_0_dump_ip_state,
 	.print_ip_state = vcn_v4_0_print_ip_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 60b6cece499a..ba13390d9d53 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1845,6 +1845,7 @@ static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
 	.wait_for_idle = vcn_v4_0_3_wait_for_idle,
 	.set_clockgating_state = vcn_v4_0_3_set_clockgating_state,
 	.set_powergating_state = vcn_v4_0_3_set_powergating_state,
+	.set_powergating_state_inst = vcn_v4_0_3_set_powergating_state_inst,
 	.dump_ip_state = vcn_v4_0_3_dump_ip_state,
 	.print_ip_state = vcn_v4_0_3_print_ip_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 422f90c3d2b3..d2248ab655aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1703,6 +1703,7 @@ static const struct amd_ip_funcs vcn_v4_0_5_ip_funcs = {
 	.wait_for_idle = vcn_v4_0_5_wait_for_idle,
 	.set_clockgating_state = vcn_v4_0_5_set_clockgating_state,
 	.set_powergating_state = vcn_v4_0_5_set_powergating_state,
+	.set_powergating_state_inst = vcn_v4_0_5_set_powergating_state_inst,
 	.dump_ip_state = vcn_v4_0_5_dump_ip_state,
 	.print_ip_state = vcn_v4_0_5_print_ip_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 8c953cd1f95a..35b54efd33c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1439,6 +1439,7 @@ static const struct amd_ip_funcs vcn_v5_0_0_ip_funcs = {
 	.wait_for_idle = vcn_v5_0_0_wait_for_idle,
 	.set_clockgating_state = vcn_v5_0_0_set_clockgating_state,
 	.set_powergating_state = vcn_v5_0_0_set_powergating_state,
+	.set_powergating_state_inst = vcn_v5_0_0_set_powergating_state_inst,
 	.dump_ip_state = vcn_v5_0_dump_ip_state,
 	.print_ip_state = vcn_v5_0_print_ip_state,
 };
-- 
2.47.0

