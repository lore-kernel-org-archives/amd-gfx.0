Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658F0C83F26
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01AC410EAE9;
	Fri, 11 Jul 2025 22:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VR3emFth";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A452010EAE3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5F+A2sfSIdr8niD/b4Y5ho35p1kbiIezobTipommUf84luMXzKN953oNkBfUw6issxeJsbS17koBk+4RTSnpwhQ37RSXUTSUn40bGTzxtHT49I1AAdNpDnUBgJS3bwcSKT355Cw8AAMNwnkU28NFpz+0C4mqsfBtINq9Fmw/vrxoc70tXGEyLJ9j0kbcKClMOAUNCz+6Sz7Ae/8MsG4QZ9ein0D0Cgoi5HZZCeasFa5DBXsUaAkVc9Rk/Xg4nrpHY/BMGhIz5Maele3lcRkUAm9MAGWqxJ20jckMPPWvVC49tOT/Tgum3qa8E4R+0qrc9B7nlicpnKS+/EoA/4j4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoeJTA2Nn+LhbnjSgKI04CaE2hJYXNgp4dgXZtMcmko=;
 b=SgFJS6cN/n+lQqh6IL2cp58URcqXbv22GxlhEA+7EFz9M1uVAM7DpfG97OldLEBQPBj4lDusYdWhFX/Qcg3wtCeYzc967tCxCJJHNvBY1GfARG9ZaHaWgthyr6wgGFvrGJPdYhiQxkpSoUK/RgGIQGpJYfa/RArLCF1d5atVacyV+mNFvcl8NPw3/p/CxxtnYj9WyMpqOHQDGzsjBiK6mdPCuiRIDfw9iCVTHVFyy+PmlimCEefXKwN33n5bWxDxjE8DfBhnQqjDJkPYgmaYa5ZBnXi/dRw859eiCETq0X0b6PgWkLHv4AWvrpL9ijDcy1fs3gDytN0So/cpXk7kRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoeJTA2Nn+LhbnjSgKI04CaE2hJYXNgp4dgXZtMcmko=;
 b=VR3emFthkIFPuX4HMnawcx0UZFVEHJHmdXnBkHFRxloViecCZZ+PNEUzCmkc/Udae5EIylpBwk8mv1CnR3NnDsMZpzrITRwAHRodcsIAUW3QJ6zfuv8S91o4BBaukY5BJ5iblJk5oAfupGqw+CXIeAMgCTOlFbNarpb86iWjAKA=
Received: from SJ0PR03CA0212.namprd03.prod.outlook.com (2603:10b6:a03:39f::7)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 22:40:47 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::1b) by SJ0PR03CA0212.outlook.office365.com
 (2603:10b6:a03:39f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.27 via Frontend Transport; Fri,
 11 Jul 2025 22:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 13/33] drm/amdgpu/gfx12: re-emit unprocessed state on ring
 reset
Date: Fri, 11 Jul 2025 18:40:04 -0400
Message-ID: <20250711224024.410506-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: d973b2a9-47c9-47af-1541-08ddc0cbfac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jgvqpgixcVvjDe6mXyu+xXO45kYyv17MNDsKhZhO5A8hJKaqsV/StCDTKYJv?=
 =?us-ascii?Q?gcX7OmnWP7xrknNdHYp7ohqQf7mFC9vJoRfPmyB2rwSXtwAtWnTXpO7rAjes?=
 =?us-ascii?Q?U53IPGeuAWLarm+mM+2JxwZ+eu50EC/+igHzYcqrRjHvcuyquYVMFPntW7NW?=
 =?us-ascii?Q?oqXV8KzTBQNLIk/sgRzdMV11uCUa0wBJ5iuu0RZCschSNcmDi6HYpuJ032q2?=
 =?us-ascii?Q?ZuFYHGv9KIP+rCtAmDheAZvZci7aXbCMup1RDUCjlTNq3SDQAFwoNdnkVU7t?=
 =?us-ascii?Q?qcKcojYNYinWDPjX5iMLEFJ/HJtWBVQTyH1IsPSrulRrqSNBGL+MTMOqQQaZ?=
 =?us-ascii?Q?1iGi/xKkrhHJD+akeTfJ/ljuglTsb+1s7eXVZ2f/Qe6v6nCUDxrtLaMQMX1S?=
 =?us-ascii?Q?xksX5QKXhYklVXIVLLhZJu34wPr4bnTe6fH+5uB4uYyJg9Avpy2jxLX/M14U?=
 =?us-ascii?Q?1WXiJo7T41pRx7w4dPydFwLos9+J+GdX2zJ8KduFrppjPvHTmtrIUox6CI+v?=
 =?us-ascii?Q?2XN5FElFO0MmIEG18UsTSYDMODigfGHAgIDIMuiNUmyj2SOq6DqD45+IL4M7?=
 =?us-ascii?Q?VHF1Gr6TVB0g7QbQqfjbcB/4A75ReciEPst52BXRa1pkpE8lMKPTnap/h5RZ?=
 =?us-ascii?Q?Fjnq6I+kM7aw4p/+84D0ie6Y2WuAgsGhigAGZdYmu37P5Yadd9GfeVdOJod8?=
 =?us-ascii?Q?tEieWVY6dYGnQYRPKcAm764J/GoGtOYly+XueBsuZBhYyTIWNPgE1rv0q6tI?=
 =?us-ascii?Q?Plpz5Mu7Twr317GI0XbPDDLXCs0Hyq9wlT8j8pWE430IAt05BfOZgz25wEvg?=
 =?us-ascii?Q?0YMbtbqcec2lxZeSCsfqkoFa9ZI6uMZHj25kPmoUF050RJLDs2D8WcbpZfoa?=
 =?us-ascii?Q?u0P8NigJYG7/02ueSV6hdasIAn81b1VQ7Xnlk3ueR9yUeWzZ24eOoyKYyV/w?=
 =?us-ascii?Q?pWbDcjjCDhSiWUi7WJsOvXQ9qprYNH3Q0xkg/qH/hDIuITJublTRz4l4HtVr?=
 =?us-ascii?Q?/dntzQikZWNoSB7gHlqUUkA8dkxaxfkY7AayTRsj3uzinmXbkmheWsna1oY0?=
 =?us-ascii?Q?70gVUMOFVzrD97o/kJ5viCUQjAR3iSwey/Gq1WCH+E9G6RTAtDt81GBlXI3G?=
 =?us-ascii?Q?M99aAPPgWKEts/kD4BHH34+oUIPcpXXq8t8c/SoG/fDbWeH15ZcJzeyrJ0By?=
 =?us-ascii?Q?5IPTiucyEUeyK2RCcp9iB9L8T8yqfq4l/WSzyRyID0mUijtf0ArxBDz+7E1u?=
 =?us-ascii?Q?30L3Fdus2yRDhgUFYVQAU5aV+aSJIBGf6D+BSiKWcuf3nW6WodVsnDA1XHKH?=
 =?us-ascii?Q?4wx0xNMPweNMxmXZXEi09E58HNmhGuc1r4qK9sIihU+jDtR1zHL7HQ1XXTVv?=
 =?us-ascii?Q?0HQD+3Zm4GVA83hCeAdLqkJivjgB5M9SB3nAeaLUF/CKr6GqEtTjZ95AdOdS?=
 =?us-ascii?Q?Ym45V8T3ZTzOfiL/deexMjV3awUzTplv2CnZ+hSjYvSW5oHhY/zltla8SFkT?=
 =?us-ascii?Q?RvvZXN7R3htRMQF7d66Atbi7IKEqQeso5Ses?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:47.3576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d973b2a9-47c9-47af-1541-08ddc0cbfac3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
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

Re-emit the unprocessed state after resetting the queue.
Drop the soft_recovery callbacks as the queue reset replaces
it.

Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 35 +++-----------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 7220ed2fa2a33..5d32ae4b1a4c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4694,21 +4694,6 @@ static void gfx_v12_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 			       ref, mask, 0x20);
 }
 
-static void gfx_v12_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, regSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v12_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -5321,7 +5306,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	if (!(adev->gfx.gfx_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
@@ -5343,12 +5328,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -5444,7 +5424,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
@@ -5465,12 +5445,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
@@ -5548,7 +5523,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
@@ -5587,7 +5561,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
-- 
2.50.0

