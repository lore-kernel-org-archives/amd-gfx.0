Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06844C71159
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D87810E4A0;
	Tue, 17 Jun 2025 03:09:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pWCYPhkj";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CA7F10E496
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouXbr2xQbDYDH+p7rSXxIZP8GNHCahkg967uXLiGH5t1ryDWpT5Hw3Jsyg/OKCOaluKNySc3S2eO8a4lYiRAFCkuQE9kCe5SEFIGS1hfrMS6YEfm9LiputmhOAswGNFh3IfUyThBMsTn4K6quTLot9/4KsZJ1rhdpl8gSWzF0boHUd1OAhADHHjp2a3TOspbwTicBb6h6XpGvJOMbCL3F1Qx+N5rFsAxfTSjUWxQMz/Tc6y+2dMAzZBnFiT0p1Zj0QwgN4vLof2nDz+BhQYsmVDB11edUva+irWAFrih4ApJSwXKq9UZW2c8xJLTm1kzcvYvGxfQNKZ5EHitlPaysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCnaSBWbjsb976MIetG0NHGKa5mouyJUwrpa4M9R/yA=;
 b=s82fhunJ8qFyKh2cYIkhLO3CI5qUj5BCVpVPHcN6rDl0Agih9JcXMJnL6QENeYQ9yjSAZrjeTAd2ZVeFSsCq6a2eoxHKhdFC14Qi2f7pfSDn145n1wm0dY2mfTfM1OkJnx4JVWXaGpqBOjB0ZOIurm6zHDXmUZla4O7EHRvw8nBl6HZYhhY8797NF2VgpBvG4pEPMNkocAYq6HVBzP+WdG68JDALTzL+UpaZnt+ZdOjsNCuxgnAoDIzjLwRsYSkWKgAFAsJscDvl+Q7ln8MUXKaViBrTclpexKFxlGkGSXa1LN4tE1dBu37w8AuJ6JTS9lRenKVc53aO9/tgbl7njA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCnaSBWbjsb976MIetG0NHGKa5mouyJUwrpa4M9R/yA=;
 b=pWCYPhkji701Jwt1/VjXWkXtkG8VXQpVTgQoNNwVL97doXyo8CvsPScu2jusYV6EbR7tqb1Wp1xSqW0ZDTVlDI9Vig12mzKfwORg5XZc4iiUJMFZu48xKx6sWJjhGv/AZoXW7a/ulIsAkgwaAGkNvQmApSalmC8XdK8FWN4z9MY=
Received: from MW4PR03CA0171.namprd03.prod.outlook.com (2603:10b6:303:8d::26)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.40; Tue, 17 Jun
 2025 03:08:49 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::fb) by MW4PR03CA0171.outlook.office365.com
 (2603:10b6:303:8d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 17 Jun 2025 03:08:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 27/36] drm/amdgpu/jpeg5: add queue reset
Date: Mon, 16 Jun 2025 23:08:06 -0400
Message-ID: <20250617030815.5785-28-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d4e001-be86-439f-ee02-08ddad4c4838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Uy/53VsuipiumzOogLsR4jsYvyYN8THUMv0atBLC9hDQ49lfMtXUoVQIEk3C?=
 =?us-ascii?Q?/YmP+XQCPywwPMn3Xh4azgZja8LUm7VIMu0rYripYXBAnnzLJJTb4EK4OOKI?=
 =?us-ascii?Q?5QO57vtNW+YxP7l5yHqkEO0RZ+fGF5MESy9l9G0zuxjRljT3sB/XBiYe6j4h?=
 =?us-ascii?Q?SU3v0uij0v+4NHi5uA6fYW2HYXuB9AXKUEv8tJxY649657lARbETeGkUa1qx?=
 =?us-ascii?Q?DSJ/TCV7CLGdzoMRyF69GPjxKI6VO8Zg/5mVFkS16jCIME5H8AIy++fM8OR4?=
 =?us-ascii?Q?F/4M8oS/dGb7OQ4wlx8ar+u/faq5SYQup3T365+cwlXhngxnaF4m74nESTfy?=
 =?us-ascii?Q?84cTmt/5ZjNalH502i4j2RooFmMvqYDffQ0C5cLTl9VQNO8b9zpqlog4Daml?=
 =?us-ascii?Q?KBxh44f9fUBN6QlcfwyWYtOxBVUHJ1RzIyZ9usxlqT13lJ7rNjJ6b8bF04G/?=
 =?us-ascii?Q?/jFTCrJ0GzOlgrGo4ZDFyksB8Cz0T3MojNUbtzkZ5GEen8BPVIrFDgbdJmWc?=
 =?us-ascii?Q?pGf+g0YAAG5sjMLruLSNtTl3JN9HGWVuZWqkDCxHEUmzPQtO5bJaveOoilH8?=
 =?us-ascii?Q?Ej5Mng+PnxLL/Q5PhF0hvLegf8kVsNva6U6iftVdmTtpwZ6QBqGSiho/gkDH?=
 =?us-ascii?Q?8a5j7Dt0vC3g928HezpZZYQwRtTdmup4k287uE49yH6Y/amki+NAUuYB5a27?=
 =?us-ascii?Q?Sy/T8PvJo+gUQEkajmDcl/iJE1cAL/rFSKNI168bjH6hUNXifa1TWaI2+f5q?=
 =?us-ascii?Q?eYB9dIpEA2TvVY/Z0dP3ZIy8rfShP6M0KPKmdAD7OOwGp3xbNSrrFWsFFA1j?=
 =?us-ascii?Q?Hm/CMgi276U6xvFaq48P85GLVIekFsDIhZKknCwwlNwNqoiT6hgpyeFUKnec?=
 =?us-ascii?Q?Fy9BGxsHdPAKdMhNi/PBE6GTyMu2IPbQKtKJEN6NA+S2TXVJln5Eh/j3pwgx?=
 =?us-ascii?Q?gZcfix4W0oYotw08m6xYnHzczUYVY3xBdjXpWoGJ2rE4F6XguYjfalSVlI84?=
 =?us-ascii?Q?h0pIxIKJAdHRzgMcLZ9tqJKTgDoiDAv8jzywDi6IdpJD18CrWAcIbuU7vl6C?=
 =?us-ascii?Q?IQ4ZF35QkYert34M7OHp1IPhbf8joO9qGr2BHzlZtsvQO1F83FNHju9dMw/0?=
 =?us-ascii?Q?UJwCY4Wm/IeeSl5Y9VdtZQXwm3UMLlv+W1FgWSAeYFFysiYB5FkvpdKa0SPX?=
 =?us-ascii?Q?U/lEc1D4MoNpk3qZQZsVoZl2HIeCwArTwkFdsaNb9RszCsVmhrdys/7MeR7/?=
 =?us-ascii?Q?GNmIWsa4WTzFTQVsi1c6AJRHkcJy8Xcya2r+rjRMUxF3Z77/GTv6jR8svnNu?=
 =?us-ascii?Q?nlNDWqxKV04RibZfmVnTxVtZMiWHnC4t1yUO961KF1PBSO034EDqfhsyHLnN?=
 =?us-ascii?Q?CUfBD1R+VFuJKbGznnsrjLgujlpd5kb01O/FRf21gQ2j+ajXfTYiQkNv1G0p?=
 =?us-ascii?Q?6u3Xu0t2jMdkEBqBBlkQvI15X70DaGipTipXakTDX/N5YfZvlx2MklAKG2zY?=
 =?us-ascii?Q?UwJE69iEPLMAEeA4KxbNtT7kx8S2J0ZmcbBv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:49.5957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d4e001-be86-439f-ee02-08ddad4c4838
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793
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

Add queue reset support for jpeg 5.0.0.
Use the new helpers to re-emit the unprocessed state
after resetting the queue.

Untested.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 31d213ccbe0a8..339cf3a033a2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -644,6 +644,19 @@ static int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v5_0_0_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *guilty_fence)
+{
+	if (amdgpu_sriov_vf(ring->adev))
+		return -EINVAL;
+
+	amdgpu_ring_reset_helper_begin(ring, guilty_fence);
+	jpeg_v5_0_0_stop(ring->adev);
+	jpeg_v5_0_0_start(ring->adev);
+	return amdgpu_ring_reset_helper_end(ring, guilty_fence);
+}
+
 static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs = {
 	.name = "jpeg_v5_0_0",
 	.early_init = jpeg_v5_0_0_early_init,
@@ -689,6 +702,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v5_0_0_ring_reset,
 };
 
 static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.49.0

