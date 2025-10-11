Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13505CCD185
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Oct 2025 00:35:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87F5010E18A;
	Sat, 11 Oct 2025 00:35:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MvomgdTs";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E9B210E18A
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Oct 2025 00:35:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoqCrft+PXJYw5EhzPCE1PGSMK9JQ6AyFrLvh+yEwE9PNDcCFjKp3Qg6OnXNRFr6euJqMUBA8FQ7YkoozblMRcF3XtcGZsjJiq3CwuMQQruUHQXlX2jzex0Q2riLz62rDj3n2IUKcVmqhTqdPaCx2gxhoCdGDgJ0dAOvKnovzXFeJgim9roFyGwwTqEd2yKF0nH4JQXTxi3klqx3a86TK9rgZ/ExY4p/nUdATfJ15R8ZvE4A4MvzUtZR0o+tOHi0Z8txq9KO0fMOzVBBlQnRJsq71YDaDJv7z+5eXX50qECHpkn31UkKnvHDk+BOItDNlHVKrmX8ODGbOFFJUeev2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMMe0ORq1MpyR1aQR4kLHleM7xOwLTEqEcz87ZdxERo=;
 b=Sm3V/Nu1FFlhnPmdWDI3+F5mIsoUlJpLTpwKacYjJ9pVttFH8D0zq5QGIMcaZ0U1TcU8mqrigd4xLZzA4wHh6UvHzb+4vZzlGsBUF0VcGuYbH7QB0b6o21zk4t6rXgniDoOIX2JlpXdaOX95DhkoXyo4huh3aB/wraFNVYYIK+d5TXP3PGc5wiRK0U08V1b0SJNASpO79xzlcyMA4jYP87e08r9JVO0xwBy2k9BMCeZRqROoNADwRlnq8EogeU2h//zLo3/nmgKDt06AokhpR67Bn/u6TxaW1Lfm4IJAtFejqBYEEhIfWFcvKfZn2Dg1mkJ2hdAJJMlAHISMdmpThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMMe0ORq1MpyR1aQR4kLHleM7xOwLTEqEcz87ZdxERo=;
 b=MvomgdTssEWgI8Di7uxv83AsU/SeT0L7GjMWJoTk5UBTHeNtKBnuCkD07uApaxh6DwrzemF8S42XbqeMKD374ulFs2t3cd7hEO4J4qfkyqRB/GAXZFodB707cBxro08MTdp2K6CI5joXu1JL9+usc/HbAeQj/7vil0bz+vIbTKc=
Received: from SA9PR13CA0168.namprd13.prod.outlook.com (2603:10b6:806:28::23)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 00:35:26 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::5a) by SA9PR13CA0168.outlook.office365.com
 (2603:10b6:806:28::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.6 via Frontend Transport; Sat,
 11 Oct 2025 00:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Sat, 11 Oct 2025 00:35:25 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 10 Oct 2025 17:35:24 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Peyton.Lee@amd.com>, Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH] drm/amd: Check that VPE has reached DPM0 in idle handler
Date: Fri, 10 Oct 2025 19:35:08 -0500
Message-ID: <20251011003508.208179-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: 30383e19-3e0b-4da1-08f2-08de085e121d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?apNmPscdP5brZhjruflYB1yWrPNuCL/h1f/d4w+ZxLE7NHwvfok3J2mg7VBu?=
 =?us-ascii?Q?yeu3881PRCw9A+qSJrdX6Rg6aqgwBkyj6/ctOZtszP5imBl2emoWzaxV53Yu?=
 =?us-ascii?Q?ct51tFhpTezPJPvSDVmptIN5GSofBsuCDccqdr1Xxe7AUyGNTFWM220RbIoO?=
 =?us-ascii?Q?m1maIryBJQhUeq9nf1A+QKoW8g9emMT0XyNsYaRMhLuZjq824MAhT2jhrI3W?=
 =?us-ascii?Q?ao9aLt70PVbDTEOGAD0QCEx/+0Gc1A3TyvR0hyIXRHFIgmuY0VAcUtWtTjhr?=
 =?us-ascii?Q?i0e7JuhH6cSMLr9/sZ4Ui/7ZApuhl6ubqBrgCQuRCDmoA0SHB0pb+fsMHNYV?=
 =?us-ascii?Q?hAfNqM/KJfrJOxK8P1P62JIFJdudhESQ77MOxGQAmimAVSlf4Zz9dtJm9rwg?=
 =?us-ascii?Q?fTemyS3KI19Ksiptf/x7lb7wlG8VgqghcEmreYr+iUDLEhvnVQ93BcJ1HlDI?=
 =?us-ascii?Q?XQunJm11KFzkUwWSWzobv4hmZ080hRLpOREvhVyFlhu4VQ/rstP4zh4IXkqd?=
 =?us-ascii?Q?02HLuyTaqF+Y4t5eCuD+msJoZWKLQ3+6C9pog6oLKIFCTOvSSMeAoC/5e4w1?=
 =?us-ascii?Q?gQ1ygN77YUpYQ7RuAsSwp9CmseJQ9LbEj2v3QGhQrIOZFKuU0L/kqXFvimpi?=
 =?us-ascii?Q?fwOpx61JCy+TQf8kJMI3syyqzuRnuVy0jmP28+UoXIYzyUix3x6Jhmuz+ZiO?=
 =?us-ascii?Q?d1gaBYo4M2Ro1bctBBBWaDyWbHFQrFXxQElV+DZMOJn+fpOfF/27dfmRxWDE?=
 =?us-ascii?Q?3PUjvBdGGqI3nmjM6o9RkO5TZtt1FBLpj2rJ6cWqYPrA2nwNoNiAG/EBQuj4?=
 =?us-ascii?Q?gFlmz66okkbse9bQj349vrSH+oQaEuB9hknLCEf1Y6EPNkHaEhFWXv0PC6Bp?=
 =?us-ascii?Q?TMZMBBiaC9OyGBsZVuo1aht9woafihCQSzjyfgqGl7WfMgT3Ya22m7h/1b36?=
 =?us-ascii?Q?4uvFXXTxvQVdrnesEW/tiQNJ3Zu0j6WUSGgY64cXUGlt56aT8Z2+Igly7nnn?=
 =?us-ascii?Q?tzJ0CHtw8/AeeUcqF82eXR1e09AcoHvYvbs/9Uo2Ol3veoOqADGU8ne/cq7U?=
 =?us-ascii?Q?2OLsBf+osr86xvGC/x+pdqcpso521OYrlv0JWYmo14bzeG1ouOQC1oDyFZ83?=
 =?us-ascii?Q?dY4twQbzgATt1/lGc7axRD/MwHmQtN17uDdrKrj/yl1loo6umLGcMyhCHHbr?=
 =?us-ascii?Q?FFACb7lvw+PmxYxaCHP3DD1SkgSvcTpdzDUb90f3jHl16cCi90gmchjKZx3R?=
 =?us-ascii?Q?61kYZnhSMgDBq7UfaCroOyFuYwx1Xw6cjxI0Og6Cqyh+azNCWE0vbA/ovhcn?=
 =?us-ascii?Q?n3W3rnI7qMVCht7lcDU23HVlsR/fD+0Z+nxyRFwQ80OnDc4xQ5QzVM0zJoJe?=
 =?us-ascii?Q?O5bSlUMMcPrKXaaTmf14+Eu9wujdZ3Ka2+5/zVPyELUeDlD4FuQSRKxFCsZ/?=
 =?us-ascii?Q?vJbyrwKNMQ9rSTSMpL+aZFneU/kC7HbTY22eqxn707gqSLUAcaNNRQoKq3NS?=
 =?us-ascii?Q?fnq12XY0fP8CcHQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 00:35:25.6282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30383e19-3e0b-4da1-08f2-08de085e121d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760
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

[Why]
Newer VPE microcode has functionality that will decrease DPM level
only when a workload has run for 2 or more seconds.  If VPE is turned
off before this DPM decrease, the SOC can get stuck with a higher
DPM level.

This can happen from amdgpu's ring buffer test because it's a short
quick workload for VPE and VPE is turned off after 1s.

[How]
In idle handler besides checking fences are drained check that VPE DPM
level is really is at DPM0. If not, schedule delayed work again until
it is.

Cc: Peyton.Lee@amd.com
Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4615
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 474bfe36c0c2..9065d799c2c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -326,11 +326,16 @@ static void vpe_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_device *adev =
 		container_of(work, struct amdgpu_device, vpe.idle_work.work);
+	struct amdgpu_vpe *vpe = &adev->vpe;
 	unsigned int fences = 0;
+	uint32_t dpm_level;
 
 	fences += amdgpu_fence_count_emitted(&adev->vpe.ring);
 
-	if (fences == 0)
+	dpm_level = adev->pm.dpm_enabled ?
+		    RREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_request_lv)) : 0;
+
+	if (fences == 0 && dpm_level == 0)
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
 	else
 		schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
index 695da740a97e..f952b8dce1d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
@@ -58,6 +58,7 @@ struct vpe_regs {
 	uint32_t dpm_idle_clamp_threshold;
 	uint32_t dpm_request_lv;
 	uint32_t context_indicator;
+	uint32_t dpm_level;
 };
 
 struct amdgpu_vpe {
-- 
2.51.0

