Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F33CF9C6F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Sep 2024 17:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA2310E435;
	Mon, 23 Sep 2024 17:41:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5kc2/cqD";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86A3310E28A
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Sep 2024 17:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHQ+7SdXcZUiQ5pft2yn5RVCBGjE9abv1fiEWP3kBfABIrJBE1rFqiqzM/xYL9lwDGZgwMhuKWCMA4LTHNF1Unmt/GwlVnuRxohB8Oq+iY8Inb+H7p8BT5kkBgqsatiM27OlnrcyVUD6MQJC2kHqQ3cg5WWB30m5yjKrgFYEhqy/xDPIRKhFtEbrXslXRbYCbhP+2zCRazUpwkVW4pQU5ztmY4SCbQ8/ADGtsczzO74VChdbdFdvsW8wkHpx5eTxdkrF/F0Ozu3nnda1ZHBMTNJXG2ay0sVeMrUEADvW0/i8Lx3Mo783D67ANSli3eiPEUOW+FAVwF3xJ5ltP5WF6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JMBz6ETQ8z+s2B2JSflzBHllizQQZ9SUvNtlfyIjRw=;
 b=q7Ux9RhJ19qsSrHWZEnmiwz9msohIH5qPg3FSKck865tyRMQuQaVHAOskL2N2RHL/3/DnAi/NzpMKiluaE+qcXyryFTkg8nlr0QD78DCdIlTrMuZtIowXVQYByhmE3db2kjgEuCd0To9uqvl9a549k5ARDdg6+veZK6oKdFbnl/2e+ZEde/5M3z+DcQo5uFpwFbKqXR5F6+HnEHdJZtXdCCl0pSnx92k+/78KnxrzPOEGptpnYgUzTs21Q+xysuojwwVREXUKM2QAfbZ6Gzp2CIhsAbWjHJ+ft4tSAz+v3YpKMV8PA+mqd7rFr0i8HnOKAkvFGG4xutMhZRis+dVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JMBz6ETQ8z+s2B2JSflzBHllizQQZ9SUvNtlfyIjRw=;
 b=5kc2/cqDs4rxj5NPJx1lQ2ohucZ+Xd6u57ILQQoH5Rfnu2eBO8UJ4PIUtEWwS0YitlNPeq2AYp+DnpQ7qk79mwUwKFxyIgYX66X0jep59x/0LcGaf4ao0jHJfnLg2OrDIXcT0xbGLImMiqeHYTRo3PTnUl8AMmee4soAqoHs+eA=
Received: from SN6PR05CA0014.namprd05.prod.outlook.com (2603:10b6:805:de::27)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 17:41:00 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::4a) by SN6PR05CA0014.outlook.office365.com
 (2603:10b6:805:de::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 23 Sep 2024 17:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Mon, 23 Sep 2024 17:41:00 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Sep
 2024 12:40:59 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harish.kasiviswanathan@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCHv3 2/2] drm/amdkfd: Fix CU occupancy for GFX 9.4.3
Date: Mon, 23 Sep 2024 13:40:46 -0400
Message-ID: <20240923174046.284250-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240923174046.284250-1-mukul.joshi@amd.com>
References: <20240923174046.284250-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c7af2d-1b34-45a9-d049-08dcdbf6e363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CCiZOM8SCdqIdDMOTFmGHU59WllGj6JKL8dWsgUOH8C/TOEX4Dev9fe2C25G?=
 =?us-ascii?Q?HqZ8t0OqbccBlwQPhBMvGFFWDoOR0xHigclRDRU3lPcR7CtuXv66nh22SG5P?=
 =?us-ascii?Q?5ax0/hrKZUa2PnI2rw6eLHg4mq/V2JI19YLLfUvWtCtGanWIRDdU2HaP1cqC?=
 =?us-ascii?Q?obJ4xTEqtsETg2ylgCh2gHzJwJC6LWkE1PLJ9Nqxh/OHU2IVecoh8wTugmtX?=
 =?us-ascii?Q?NGw1i6+fUC4uOmaDQ9zQVGVDmc45mybvfb/BOJ+YpKw45UbqPqMgEh6ItLZX?=
 =?us-ascii?Q?B0hImt8Uz/8uJAN0FNb4unSUEBWUvPfse0pWCUmINHAVFEFNINpnQYeEd/77?=
 =?us-ascii?Q?relG1znF2yW4z7o4Ao7VhrIXwYDT+n2WL9ibJESDfIovUZxp7Dw5huxLyACX?=
 =?us-ascii?Q?v0Y81Xu0SZe6kWjtRt+rM1h6dXnCwJVox0Gtt8r5/8xNIHfqqnrY74iPavlV?=
 =?us-ascii?Q?6Gv6hDQsT+3h8L1dFf4k0Fxbz1iLo52uNijeAejQIrRkPvwzCWzMsnl8Zzl5?=
 =?us-ascii?Q?zZq4X+xmhLSX/2UsgsGHeReCYQqyUJLpDBZpAFx31b6KorYdFDl+ivt8pVPA?=
 =?us-ascii?Q?eRHaNneRh8nwba6Nbq2JEiXcNCxb1r806Uz0DbDr3TQeUxKdsIvRb14kFL/W?=
 =?us-ascii?Q?KI1pA1K6gxGKvWqQJi42uMDI0rwC41PrKUlr9+hTlGD+6iqIsL8yKD6sGq0K?=
 =?us-ascii?Q?O1mFSeI1AIaogz4NEDJCqQG4/2YGbrvRCacrfxyEqTe1tups4vJ/IyUaB7C/?=
 =?us-ascii?Q?brjpjKvxeDOXsw4x1pzglqkLktIdPcRIbE6/SzcSP7lPIRJ6XRkr/8h8NGKm?=
 =?us-ascii?Q?UavuwpsvkiqCWi1whqRSg8tFar8FCNErtuUFs6/vkKQl8vd+hDgw2T3CcAsl?=
 =?us-ascii?Q?ccrxER9P9ol8K+T1S3mU0rq6PYzLTQ+E8ucm/4zHuZEton4JWgUC/37UOLcG?=
 =?us-ascii?Q?6vaHRxmzBOPfqqwpLi/VQJDJLwo1vIRExjxD067jhtXWx9BIkxaPtBoWdl+N?=
 =?us-ascii?Q?x28wdjhVTp3rbN964x0wx81cAq2TaY9eXa4h7E08S9PzsIaiCBAQ3gAgmn4p?=
 =?us-ascii?Q?iHw7Lkyi4klAwHH6ZAi9SluazLdkrhV/YZqNV1vsfzObg3fm87af8OE8KlGD?=
 =?us-ascii?Q?2SP1VTlpMBw7ChUwlM6l1o0XEzgzJ/xdxExYv2jwvbzou1RNtolienM07pTw?=
 =?us-ascii?Q?Kzy8kIPMI3siFQkPX1pNhW2eA9eUGMSfVWYRZj7m0suLpsyajvgLwPQQtpQF?=
 =?us-ascii?Q?UAvxdmqdsBtHOiCGpMerhr08/74hjiRTNRrLVE5a+QmvrOOeC+udhmJDH7bY?=
 =?us-ascii?Q?HxoKtJWJjvFoPC0pV3ae0GQifAEHNanXlZysiqWUYpslaVpueoBMd5SWhJJ7?=
 =?us-ascii?Q?Jq6abek=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 17:41:00.2393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c7af2d-1b34-45a9-d049-08dcdbf6e363
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958
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

Make CU occupancy calculations work on GFX 9.4.3 by
updating the logic to handle multiple XCCs correctly.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com> (v2)
---
v1->v2:
- Break into 2 patches, one for the generic change
  and the other for GFX v9.4.3.
- Incorporate Harish's comments.

v2->v3:
- Update code to handle both PM4 and AQL queues.

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 12 +++++------
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 20 ++++++++++++++++---
 4 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 26b1f37c316e..3bc0cbf45bc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -963,14 +963,14 @@ static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
 	 */
 	pipe_idx = queue_idx / adev->gfx.mec.num_queue_per_pipe;
 	queue_slot = queue_idx % adev->gfx.mec.num_queue_per_pipe;
-	soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0, inst);
-	reg_val = RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, inst,
+	soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0, GET_INST(GC, inst));
+	reg_val = RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
 				  mmSPI_CSQ_WF_ACTIVE_COUNT_0) + queue_slot);
 	wave_cnt = reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
 	if (wave_cnt != 0) {
 		queue_cnt->wave_cnt += wave_cnt;
 		queue_cnt->doorbell_off =
-			(RREG32_SOC15(GC, inst, mmCP_HQD_PQ_DOORBELL_CONTROL) &
+			(RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_PQ_DOORBELL_CONTROL) &
 			 CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
 			 CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
 	}
@@ -1033,7 +1033,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
 	DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);
 
 	lock_spi_csq_mutexes(adev);
-	soc15_grbm_select(adev, 1, 0, 0, 0, inst);
+	soc15_grbm_select(adev, 1, 0, 0, 0, GET_INST(GC, inst));
 
 	/*
 	 * Iterate through the shader engines and arrays of the device
@@ -1046,7 +1046,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
 	se_cnt = adev->gfx.config.max_shader_engines;
 	for (se_idx = 0; se_idx < se_cnt; se_idx++) {
 		amdgpu_gfx_select_se_sh(adev, se_idx, 0, 0xffffffff, inst);
-		queue_map = RREG32_SOC15(GC, inst, mmSPI_CSQ_WF_ACTIVE_STATUS);
+		queue_map = RREG32_SOC15(GC, GET_INST(GC, inst), mmSPI_CSQ_WF_ACTIVE_STATUS);
 
 		/*
 		 * Assumption: queue map encodes following schema: four
@@ -1071,7 +1071,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
 	}
 
 	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, inst);
-	soc15_grbm_select(adev, 0, 0, 0, 0, inst);
+	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, inst));
 	unlock_spi_csq_mutexes(adev);
 
 	/* Update the output parameters and return */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 29578550b478..648f40091aa3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3542,15 +3542,19 @@ int debug_refresh_runlist(struct device_queue_manager *dqm)
 
 bool kfd_dqm_is_queue_in_process(struct device_queue_manager *dqm,
 				 struct qcm_process_device *qpd,
-				 int doorbell_off)
+				 int doorbell_off, u32 *queue_format)
 {
 	struct queue *q;
 	bool r = false;
 
+	if (!queue_format)
+		return r;
+
 	dqm_lock(dqm);
 
 	list_for_each_entry(q, &qpd->queues_list, list) {
 		if (q->properties.doorbell_off == doorbell_off) {
+			*queue_format = q->properties.format;
 			r = true;
 			goto out;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 80be2036abea..09ab36f8e8c6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -326,7 +326,7 @@ int debug_map_and_unlock(struct device_queue_manager *dqm);
 int debug_refresh_runlist(struct device_queue_manager *dqm);
 bool kfd_dqm_is_queue_in_process(struct device_queue_manager *dqm,
 				 struct qcm_process_device *qpd,
-				 int doorbell_off);
+				 int doorbell_off, u32 *queue_format);
 
 static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device *pdd)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d73841268c9b..d07acf1b2f93 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -272,6 +272,7 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 	struct kfd_process_device *pdd = NULL;
 	int i;
 	struct kfd_cu_occupancy cu_occupancy[AMDGPU_MAX_QUEUES];
+	u32 queue_format;
 
 	memset(cu_occupancy, 0x0, sizeof(cu_occupancy));
 
@@ -292,14 +293,27 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 	wave_cnt = 0;
 	max_waves_per_cu = 0;
 
+	/*
+	 * For GFX 9.4.3, fetch the CU occupancy from the first XCC in the partition.
+	 * For AQL queues, because of cooperative dispatch we multiply the wave count
+	 * by number of XCCs in the partition to get the total wave counts across all
+	 * XCCs in the partition.
+	 * For PM4 queues, there is no cooperative dispatch so wave_cnt stay as it is.
+	 */
 	dev->kfd2kgd->get_cu_occupancy(dev->adev, cu_occupancy,
-			&max_waves_per_cu, 0);
+			&max_waves_per_cu, ffs(dev->xcc_mask) - 1);
 
 	for (i = 0; i < AMDGPU_MAX_QUEUES; i++) {
 		if (cu_occupancy[i].wave_cnt != 0 &&
 		    kfd_dqm_is_queue_in_process(dev->dqm, &pdd->qpd,
-						cu_occupancy[i].doorbell_off))
-			wave_cnt += cu_occupancy[i].wave_cnt;
+						cu_occupancy[i].doorbell_off,
+						&queue_format)) {
+			if (unlikely(queue_format == KFD_QUEUE_FORMAT_PM4))
+				wave_cnt += cu_occupancy[i].wave_cnt;
+			else
+				wave_cnt += (NUM_XCC(dev->xcc_mask) *
+						cu_occupancy[i].wave_cnt);
+		}
 	}
 
 	/* Translate wave count to number of compute units */
-- 
2.35.1

