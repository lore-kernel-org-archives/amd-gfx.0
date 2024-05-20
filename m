Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D331C25B7A
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 16:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A46A410E511;
	Mon, 20 May 2024 16:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ySvlzEQl";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 662CB10E264
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 16:08:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELSMynVtWiyImK5DAQbbeL7bVJa3XRQFwLtQS4LJOo2/cjw37OOq3TVdwyppSZjtAGXrOTZwGZRGvlkmLy5u7wzgQKMpMHIh5Rn1qrum0tjcwrCE0qwdADWpgupO+4P51EQjeLaqDh91WiVPJpiE4hF4zXuZuMQlV+dZ0wP4EVQY8Skv33NTJNI3qhzMcFugm1HUiPke2/sthmZvzoiy8M1jdotPOGoOJoWdfQlMHKe52af3xgvZ6ET7Wmm8aPPNfEMuJN3gzGA92Ps2qKkReBeussZSnIfGyUVX0f6iUENsIjO79RiGw0bYM/v3XBeHNPtQ0hK9I4fq0ZIsdu0bNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcReIZcqC+BFpnyi8oYfaieqsTAs3HedrwLVqLSkO1k=;
 b=AH8RiNttXsvewIbxCIcFb8MBO8ElHuJJQ5Mu+jDa2LzJEf7u9W0meYmav+ZsLKEZas+MgF1jw7Zdr1Zi6S5sAd9Y4qeqTGHHh37j6/RD6pCMc8WQz+UoDxdkwLjBA8JSYj2hYtnQdZyyYmDQnQEtY/F03QLTudG3DYe4Od2lwgAKuuO9+DtY/ws/bhFLhgEsxc2kp1NMWeRTNZUl/PuRWswQeqTtw0l7JlJ/ANBwN+IOQDtsT/jltiTDHoFx1SDSObmCmpxnltLpslucmckzmL/GRoBsfGd+F5j2p8Hz4Haea4xs+YrgjIiFVBZGuoD1RZQ2JEQAhur3WqCIdrrZkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcReIZcqC+BFpnyi8oYfaieqsTAs3HedrwLVqLSkO1k=;
 b=ySvlzEQlLBPQaT9K0QEjmPKdsuOOuSgZcyJYoHw3rJ1KbLK2ac9fjkVPyOnO+niWeXLcOSfnwCKJT2JFAglwvE+mfqN/0VBgTzT57fvfZ9sPl2IxFwGJiyjxDja9kiP7QZRtvCrBA6g4iEXleO8JLfmf0/AyoCPmEoSoUO+sgnw=
Received: from SA9PR13CA0126.namprd13.prod.outlook.com (2603:10b6:806:27::11)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 16:08:17 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:27:cafe::4b) by SA9PR13CA0126.outlook.office365.com
 (2603:10b6:806:27::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.17 via Frontend
 Transport; Mon, 20 May 2024 16:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Mon, 20 May 2024 16:08:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 11:08:11 -0500
Received: from victor-x86-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 20 May 2024 11:08:10 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Victor Zhao <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amd/amdgpu: fix the inst passed to amdgpu_virt_rlcg_reg_rw
Date: Tue, 21 May 2024 00:07:57 +0800
Message-ID: <20240520160757.2557051-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Victor.Zhao@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4f91ee-cae5-4eeb-555d-08dc78e70f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a+52NRK128cPSZuJbu1sGsX1eYJlUOChucZ0FxEWCoSGMYLADlshvA0/qLd3?=
 =?us-ascii?Q?WQOfn1Zc1q3HZwxdTVkpKUf+7t4R6Vir5qOj4Rs1GcRt83+sWAv0MAp62gGd?=
 =?us-ascii?Q?Tn7+d+ckkF+1swgCKKSZQ9WcIYSlnuhMaiVwGC2NyrkSezPKNFhhlvGaQdWY?=
 =?us-ascii?Q?vCxtxAfBqAPhfZjiXV1HGgGpGQpTimQM7iJOnS2oClTWxWvNy6mZAf/qcPwx?=
 =?us-ascii?Q?JyxkWUU5wwBm0yhrny4aWDh2q0Wf3jlwrRLBaw9bgRx13DkktGMRIhF0kmmQ?=
 =?us-ascii?Q?LczXCogJPwn/zBTaNpPVzxmgenN3YjErZlLZYLAPGCTJaf/0st9COalpPgfN?=
 =?us-ascii?Q?/szOAdWJyOrpTZ3iu1H6Qi7gahUj9dHW8LdCLZ9mrJhZB+5P6jiz41ZSzmC6?=
 =?us-ascii?Q?+nU0sbh5ABDURLRx8Ij0ksQXPZLlKsLB4xkO83oiluZlQd5IRam7hc39I7cw?=
 =?us-ascii?Q?kCUt3tESp42iPZcPjwPav7fRFb+ObWFUzmsUe52KnZPlFGpAGlKcmdpaCJ2f?=
 =?us-ascii?Q?dQ1idSmXkUFZcJdF67A/Z+Ezcpaj9q2afbhNEprdb9LaGhcUZ0sRtqX7L48x?=
 =?us-ascii?Q?YWaEhzJYvdkuS12c9HR/Qooox/t8DkmGM+3EgFjRIUc0NLY/5WYPEgGfDmjo?=
 =?us-ascii?Q?dITjqhTFXHxetaeDRup9sJxZejNK9RBFuQEWT0ku+XQPXmvlY4F2wz0nJtmJ?=
 =?us-ascii?Q?imwpRdACyxnXxHIL7QpKu5UhCwjyzWXHzaXQl3jj/C14pibPj/0F8rzgL/PK?=
 =?us-ascii?Q?//GMEPhlton0dFOu1BQY2TQj/8261TsUGGWkM7gnza4mJ4/FnUJALCVIR3bg?=
 =?us-ascii?Q?GUPlaGzXXLFlO31+u/35lid9OQJX8qZnDEpF9u6CAshq2Ec8js42NZ5pyuMd?=
 =?us-ascii?Q?ShXmbR/n80OQLgGv5jytIBL6zbKoL/5Dk0C/GTi+d2lPzebf82Jwb/OBpYcd?=
 =?us-ascii?Q?E3iaEaUGe4ABSTaT4otMAyAemNACeV1+9Mg8BqU7xCGKfQgmRUdVnLxLbXFk?=
 =?us-ascii?Q?HvC66KG6/xsUh4vZnWLGPYetrS1cXiaVZJSXjrwQEg9i7mAGWi4NwsV/m7d4?=
 =?us-ascii?Q?HFtXdRDyneuxuwN2FGhRFMIXaTdRD4EfV+YIMEiuYFviBRADV4wZ/oD+QzaD?=
 =?us-ascii?Q?sNXFg+ddqaZaCoowpNFtMB2YjrKemEkvJz20+GUyFZUgdUuJy5hEq9SA2t8e?=
 =?us-ascii?Q?uOoovi9pNcXoQwUgbj+ZgH1OnUEkJrCBUWbDfmhOijlFhX+UKkbbtRDULnso?=
 =?us-ascii?Q?OWaAbFW32J+v3RpJcW5BM6oRjZ1iqg2msiqoKiSBbzEF8r1wfl3PXXkxfjiE?=
 =?us-ascii?Q?FWL4NkdPeDoT0aY43Xxau7o95MQMeayngHOYR6R28PPZOwk1aEnJwNfwWk+1?=
 =?us-ascii?Q?wrjage2ynOjewj8yB0sI4o7j36yH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 16:08:16.9958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4f91ee-cae5-4eeb-555d-08dc78e70f61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315
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

the inst passed to amdgpu_virt_rlcg_reg_rw should be physical instance.
Fix the miss matched code.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e72e774d17e6..e74789691070 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -679,7 +679,7 @@ uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev,
 		    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags,
 							 GC_HWIP, false,
 							 &rlcg_flag)) {
-			ret = amdgpu_virt_rlcg_reg_rw(adev, reg, 0, rlcg_flag, xcc_id);
+			ret = amdgpu_virt_rlcg_reg_rw(adev, reg, 0, rlcg_flag, GET_INST(GC, xcc_id));
 		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
 		    amdgpu_sriov_runtime(adev) &&
 		    down_read_trylock(&adev->reset_domain->sem)) {
@@ -810,7 +810,7 @@ void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
 		    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags,
 							 GC_HWIP, true,
 							 &rlcg_flag)) {
-			amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag, xcc_id);
+			amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag, GET_INST(GC, xcc_id));
 		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
 		    amdgpu_sriov_runtime(adev) &&
 		    down_read_trylock(&adev->reset_domain->sem)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 094c08cb98e7..350f6b6676f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -844,7 +844,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
 	if (vmhub >= AMDGPU_MMHUB0(0))
-		inst = GET_INST(GC, 0);
+		inst = 0;
 	else
 		inst = vmhub;
 
@@ -876,9 +876,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		for (j = 0; j < adev->usec_timeout; j++) {
 			/* a read return value of 1 means semaphore acquire */
 			if (vmhub >= AMDGPU_MMHUB0(0))
-				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, inst);
+				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, GET_INST(GC, inst));
 			else
-				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem, inst);
+				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem, GET_INST(GC, inst));
 			if (tmp & 0x1)
 				break;
 			udelay(1);
@@ -889,9 +889,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	if (vmhub >= AMDGPU_MMHUB0(0))
-		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, inst);
+		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, GET_INST(GC, inst));
 	else
-		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, inst);
+		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, GET_INST(GC, inst));
 
 	/*
 	 * Issue a dummy read to wait for the ACK register to
@@ -904,9 +904,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	for (j = 0; j < adev->usec_timeout; j++) {
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, inst);
+			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, GET_INST(GC, inst));
 		else
-			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack, inst);
+			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack, GET_INST(GC, inst));
 		if (tmp & (1 << vmid))
 			break;
 		udelay(1);
@@ -919,9 +919,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 * write with 0 means semaphore release
 		 */
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, inst);
+			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, GET_INST(GC, inst));
 		else
-			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, inst);
+			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, GET_INST(GC, inst));
 	}
 
 	spin_unlock(&adev->gmc.invalidate_lock);
-- 
2.34.1

