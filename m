Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E77C4727C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 17:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA512075E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 17:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J0za6ehR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA512075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7436D6E7DC;
	Tue, 29 Sep 2020 17:26:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B28746E7D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 17:26:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cd0JzfP6lIdcD0iObABSUYWPmChHiH6shptjwuh28a405X5uN1o3sTSprZNhQRTqZR4JjWynQSlwkJDZJt1qfcrhSKYS9t0UXYn7p/IF1PNTkjb8lmXsZUxcL7IrRyz1QliueQlJCGa88/k4Q1R+/9T+lBLDKdoUPZqXwxmnmASTurgePh0UjGk3VP8h2vP1rBYifkyu9YJG1ArDWNmXpaSIJqAZkYi77RlW3FfBHLapxPC1qIuk4pFwiZ62g9Gh4C4MkXINz9tIoOBTZX4rkuNBvtMEStgWdty/lObh86prwzu25O1IzjpVJOy2N4JkpRdQX9Ue9BLtw5CRoMi+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdIeMii6gz+WsuHB4nu/0KniUnIzNysJUtngvN1QbtU=;
 b=B0e6dA/C8lGL3m8GATg7WLr/DRPmXVHBBhjjVM6odkCKQH5BCPcws+DqinQoWb64jQpfIKsMj/HxISXMKtvjiJBinYcPKIOPDuD254tN/wCbpY+x+lMjzlZyT9Wbz3cureP9yUJvNsDal5uW7d/iCicIXx2nvVRVYhW6aB6mXjyLJnfXzXSgbxPxzQIcE2eXwiDhEgZsIISc+ZNPGzazhKZVQUkXahu3OLMtRC9klPILXGXLSzZUdLeFOLEcf9zXnsH8ftJ3hYX14wmKIVbepAgg30kw2i8JI2G7qpoK4ql6hLd1K5vIdaG6aElzN+2bpGXVh5qF0WM+Zi9Rwbm+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdIeMii6gz+WsuHB4nu/0KniUnIzNysJUtngvN1QbtU=;
 b=J0za6ehRcZnOKPJLTi8wP7p0cyoAO9cFKoFcWSyCsKaq9puYrMpo3Wer0sHnMbd7SkJKIM1jtzjk+kXwTePyHISxC9ea+rizBkj/e50FY7c/qNezgLzlCI3j1AC2n1KkCUVC6TNxEuwB3R+PSsNZexsStRPND28El+LJbHVzZ1Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SN6PR12MB4752.namprd12.prod.outlook.com (2603:10b6:805:e9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Tue, 29 Sep
 2020 17:26:26 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::3d17:21ac:a0ed:9a82]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::3d17:21ac:a0ed:9a82%5]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 17:26:25 +0000
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amd/amdgpu: Define and implement a function that
 collects number of waves that are in flight.
Date: Tue, 29 Sep 2020 12:26:11 -0500
Message-Id: <20200929172611.24980-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:3:d4::30) To SN6PR12MB2672.namprd12.prod.outlook.com
 (2603:10b6:805:6f::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsacqe51.amd.com (165.204.77.1) by
 DM5PR05CA0020.namprd05.prod.outlook.com (2603:10b6:3:d4::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3433.13 via Frontend Transport; Tue, 29 Sep 2020 17:26:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7318e4ba-81df-410b-df34-08d8649ccaf4
X-MS-TrafficTypeDiagnostic: SN6PR12MB4752:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4752166BA1A8049024173F88E3320@SN6PR12MB4752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Dzq2zPo9oORerCYoz8cr8SDZJykexL8cJS/0OE3nbv3t5WWG2XbS8tnTFVfn9IOpcnA11MChm6k6Tm+zbvGbFcj/HqqDuvG5HzWiCV5a8f8t8lRmoL/ghtQKhzSCMLhOma80I3wc1Dd3uf62piP1oEm0QKVQuS/LmwGpWwI7VhIelE9L1JJX8ONvkflPM6YYt3oJGql0F/jzzRYtfEpiCpp/Gnhuub4pfcMi0nXOSNfV5ZDn/FTuXthNfmuZ/nxl/1Qet5jgbnv5NaNQ74p0rrY3IJi13/NanGZorb9cWwXJGdDf3b9WPT8ZkSFtXBHVF/YicLd6iBskmTM2hr4EbpaPBRQ47zdRQaKtusLBw8t4dtFndugjK2hUIAtQ0Fo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(83380400001)(5660300002)(4326008)(52116002)(7696005)(316002)(66556008)(66946007)(66476007)(1076003)(86362001)(8936002)(36756003)(478600001)(16526019)(956004)(26005)(186003)(2616005)(2906002)(6666004)(6486002)(8676002)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9SwR0fDtoH56Gx4/SsnTvfJT/ummKANPRcGfvvzly+hCtlWCRa5u8K2uHx/PNDzM/ZzzlHscFB096y4VPmacEPJfM2DImlT4Y+bKRJggTqdylnMobjMCuonJQRXxzW1aUSW3fsmxaHdUsUE1/zYMjqLofC5AAM01NbwRKo3qcLFrh3DmzTUYwhlWCLUFfvNPcztefSminrnvYEdibU9r5eVISLhbIzfJdGn/Lc/l1DEFHfOXYfDVtr4jHaJG38j6LjMu65KWeQDZdiaGbjUF3GJXN75bnRuyUlnI/bB0bfKKC+JZBmZEy8oleUQciROa8YH/cUAVmMeaaGuOlRTq7Vu0LTyyzto38RRXGoNafr0qjNEDSjcVtsjRS2Y+yktNQ7PNNA9mwXn5h7g/k58m+drdUSRSrdhTqadlFNyaxzbj6rYsvaPNJ2WId8oyUFymoChUjvUuX07MaSkggxP0GDixzMxrnRMulciSUQRBCG1dYnSnHwzkM/ydKC21vmjqviB0Eq17wHtlxHKvmdd5f2naCDptu+v6AXvaLiU+haw+DapJ7l2jEjQgIL0p9wnf40cJPb5pkk6YWBnCryY7BwbQ3zat0WmxpOjc2mbUY3HgcPWpvejBC7fgr2LqSaipqeRwruxj3V12j+nWLHm0Ww==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7318e4ba-81df-410b-df34-08d8649ccaf4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 17:26:25.8265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YV5x+K5TYGpGnjd4qRm/fjy4OjrT3fVfRj7JAy+DaGUbs01PPXoFG/jP+nq4/4Ij9jra7pa+HdPlL5b5jtfXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4752
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Allow user to know how many compute units (CU) are in use at any given
moment.

[How]
Read registers of SQ that give number of waves that are in flight
of various queues. Use this information to determine number of CU's
in use.

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 176 +++++++++++++++++-
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  12 ++
 2 files changed, 187 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index e6aede725197..14a0f277e53e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -38,7 +38,7 @@
 #include "soc15d.h"
 #include "mmhub_v1_0.h"
 #include "gfxhub_v1_0.h"
-
+#include "gfx_v9_0.h"
 
 enum hqd_dequeue_request_type {
 	NO_ACTION = 0,
@@ -706,6 +706,179 @@ void kgd_gfx_v9_set_vm_context_page_table_base(struct kgd_dev *kgd,
 	gfxhub_v1_0_setup_vm_pt_regs(adev, vmid, page_table_base);
 }
 
+static void lock_spi_csq_mutexes(struct amdgpu_device *adev)
+{
+	mutex_lock(&adev->srbm_mutex);
+	mutex_lock(&adev->grbm_idx_mutex);
+
+}
+
+static void unlock_spi_csq_mutexes(struct amdgpu_device *adev)
+{
+	mutex_unlock(&adev->grbm_idx_mutex);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
+/**
+ * @get_wave_count: Read device registers to get number of waves in flight for
+ * a particular queue. The method also returns the VMID associated with the
+ * queue.
+ *
+ * @adev: Handle of device whose registers are to be read
+ * @queue_idx: Index of queue in the queue-map bit-field
+ * @wave_cnt: Output parameter updated with number of waves in flight
+ * @vmid: Output parameter updated with VMID of queue whose wave count
+ * is being collected
+ */
+static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
+		int *wave_cnt, int *vmid)
+{
+	int pipe_idx;
+	int queue_slot;
+	unsigned int reg_val;
+
+	/*
+	 * Program GRBM with appropriate MEID, PIPEID, QUEUEID and VMID
+	 * parameters to read out waves in flight. Get VMID if there are
+	 * non-zero waves in flight.
+	 */
+	*vmid = 0xFF;
+	*wave_cnt = 0;
+	pipe_idx = queue_idx / adev->gfx.mec.num_queue_per_pipe;
+	queue_slot = queue_idx % adev->gfx.mec.num_queue_per_pipe;
+	soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0);
+	reg_val = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_CSQ_WF_ACTIVE_COUNT_0) +
+			 queue_slot);
+	*wave_cnt = reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
+	if (*wave_cnt != 0)
+		*vmid = (RREG32_SOC15(GC, 0, mmCP_HQD_VMID) &
+			 CP_HQD_VMID__VMID_MASK) >> CP_HQD_VMID__VMID__SHIFT;
+}
+
+/**
+ * @kgd_gfx_v9_get_cu_occupancy: Reads relevant registers associated with each
+ * shader engine and aggregates the number of waves that are in flight for the
+ * process whose pasid is provided as a parameter. The process could have ZERO
+ * or more queues running and submitting waves to compute units.
+ *
+ * @kgd: Handle of device from which to get number of waves in flight
+ * @pasid: Identifies the process for which this query call is invoked
+ * @wave_cnt: Output parameter updated with number of waves in flight that
+ * belong to process with given pasid
+ * @max_waves_per_cu: Output parameter updated with maximum number of waves
+ * possible per Compute Unit
+ *
+ * @note: It's possible that the device has too many queues (oversubscription)
+ * in which case a VMID could be remapped to a different PASID. This could lead
+ * to an iaccurate wave count. Following is a high-level sequence:
+ *    Time T1: vmid = getVmid(); vmid is associated with Pasid P1
+ *    Time T2: passId = getPasId(vmid); vmid is associated with Pasid P2
+ * In the sequence above wave count obtained from time T1 will be incorrectly
+ * lost or added to total wave count.
+ *
+ * The registers that provide the waves in flight are:
+ *
+ *  SPI_CSQ_WF_ACTIVE_STATUS - bit-map of queues per pipe. The bit is ON if a
+ *  queue is slotted, OFF if there is no queue. A process could have ZERO or
+ *  more queues slotted and submitting waves to be run on compute units. Even
+ *  when there is a queue it is possible there could be zero wave fronts, this
+ *  can happen when queue is waiting on top-of-pipe events - e.g. waitRegMem
+ *  command
+ *
+ *  For each bit that is ON from above:
+ *
+ *    Read (SPI_CSQ_WF_ACTIVE_COUNT_0 + queue_idx) register. It provides the
+ *    number of waves that are in flight for the queue at specified index. The
+ *    index ranges from 0 to 7.
+ *
+ *    If non-zero waves are in flight, read CP_HQD_VMID register to obtain VMID
+ *    of the wave(s).
+ *
+ *    Determine if VMID from above step maps to pasid provided as parameter. If
+ *    it matches agrregate the wave count. That the VMID will not match pasid is
+ *    a normal condition i.e. a device is expected to support multiple queues
+ *    from multiple proceses.
+ *
+ *  Reading registers referenced above involves programming GRBM appropriately
+ */
+static void kgd_gfx_v9_get_cu_occupancy(struct kgd_dev *kgd, int pasid,
+		int *pasid_wave_cnt, int *max_waves_per_cu)
+{
+	int qidx;
+	int vmid;
+	int se_idx;
+	int sh_idx;
+	int se_cnt;
+	int sh_cnt;
+	int wave_cnt;
+	int queue_map;
+	int pasid_tmp;
+	int max_queue_cnt;
+	int vmid_wave_cnt = 0;
+	struct amdgpu_device *adev;
+	DECLARE_BITMAP(cp_queue_bitmap, KGD_MAX_QUEUES);
+
+	adev = get_amdgpu_device(kgd);
+	lock_spi_csq_mutexes(adev);
+	soc15_grbm_select(adev, 1, 0, 0, 0);
+
+	/*
+	 * Iterate through the shader engines and arrays of the device
+	 * to get number of waves in flight
+	 */
+	bitmap_complement(cp_queue_bitmap, adev->gfx.mec.queue_bitmap,
+			  KGD_MAX_QUEUES);
+	max_queue_cnt = adev->gfx.mec.num_pipe_per_mec *
+			adev->gfx.mec.num_queue_per_pipe;
+	sh_cnt = adev->gfx.config.max_sh_per_se;
+	se_cnt = adev->gfx.config.max_shader_engines;
+	for (se_idx = 0; se_idx < se_cnt; se_idx++) {
+		for (sh_idx = 0; sh_idx < sh_cnt; sh_idx++) {
+
+			gfx_v9_0_select_se_sh(adev, se_idx, sh_idx, 0xffffffff);
+			queue_map = RREG32(SOC15_REG_OFFSET(GC, 0,
+					   mmSPI_CSQ_WF_ACTIVE_STATUS));
+
+			/*
+			 * Assumption: queue map encodes following schema: four
+			 * pipes per each micro-engine, with each pipe mapping
+			 * eight queues. This schema is true for GFX9 devices
+			 * and must be verified for newer device families
+			 */
+			for (qidx = 0; qidx < max_queue_cnt; qidx++) {
+
+				/* Skip qeueus that are not associated with
+				 * compute functions
+				 */
+				if (!test_bit(qidx, cp_queue_bitmap))
+					continue;
+
+				if (!(queue_map & (1 << qidx)))
+					continue;
+
+				/* Get number of waves in flight and aggregate them */
+				get_wave_count(adev, qidx, &wave_cnt, &vmid);
+				if (wave_cnt != 0) {
+					pasid_tmp =
+					  RREG32(SOC15_REG_OFFSET(OSSSYS, 0,
+						 mmIH_VMID_0_LUT) + vmid);
+					if (pasid_tmp == pasid)
+						vmid_wave_cnt += wave_cnt;
+				}
+			}
+		}
+	}
+
+	gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	soc15_grbm_select(adev, 0, 0, 0, 0);
+	unlock_spi_csq_mutexes(adev);
+
+	/* Update the output parameters and return */
+	*pasid_wave_cnt = vmid_wave_cnt;
+	*max_waves_per_cu = adev->gfx.cu_info.simd_per_cu *
+				adev->gfx.cu_info.max_waves_per_simd;
+}
+
 const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -726,4 +899,5 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.get_atc_vmid_pasid_mapping_info =
 			kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
+	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
 };
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index fc592f60e6a0..e37b4b9f626d 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -212,6 +212,15 @@ struct tile_config {
  * IH ring entry. This function allows the KFD ISR to get the VMID
  * from the fault status register as early as possible.
  *
+ * @get_cu_occupancy: Function pointer that returns to caller the number
+ * of wave fronts that are in flight for all of the queues of a process
+ * as identified by its pasid. It is important to note that the value
+ * returned by this function is a snapshot of current moment and cannot
+ * guarantee any minimum for the number of waves in-flight. This function
+ * is defined for devices that belong to GFX9 and later GFX families. Care
+ * must be taken in calling this function as it is not defined for devices
+ * that belong to GFX8 and below GFX families.
+ *
  * This structure contains function pointers to services that the kgd driver
  * provides to amdkfd driver.
  *
@@ -286,6 +295,9 @@ struct kfd2kgd_calls {
 	void (*set_vm_context_page_table_base)(struct kgd_dev *kgd,
 			uint32_t vmid, uint64_t page_table_base);
 	uint32_t (*read_vmid_from_vmfault_reg)(struct kgd_dev *kgd);
+
+	void (*get_cu_occupancy)(struct kgd_dev *kgd, int pasid, int *wave_cnt,
+			int *max_waves_per_cu);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
