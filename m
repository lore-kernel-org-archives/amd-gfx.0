Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434F0C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 17:11:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 999CB206CA
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 17:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B9xpaIWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999CB206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 220A16EC0E;
	Thu, 17 Sep 2020 17:11:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DF486EC0E
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 17:11:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyX0GUoU0cZjiwS9jlJfgApfb7JN2fQ6HvP3eUEK28B3IQUWAy8tmtu97lqlvaQP9NrXJlOjm0Y1wVmwyaRsKTgOKp0KceAnCdmwmIjWvdXdiK0UoXQBlljs1mfeOXius1JM8bB6A+Yih2D3kyuFpKnoJta1IzOFrnzpnmaNsknTQTGAQ+Wo1yl+PT/cApdozrzhYPUcytBc4H4VXJZ8a74wuA6ODf2SNrU4nJd+9L7BzlGhWdSkV3JbHDQH7CkRqR8zJD2h+qiEg6RMq7IT9m1QBcqpbjrsN6mUEDpwhLzEA61W+H/9zgD+lcc0acckO6byjQiE1o5mI5OydvcnSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6/ebhn/fLC83ECyLiFvz5BAzQpDqTc2eRr2mfBbAao=;
 b=cmZ3bUr0pfo2rJM3yvRcEEEcHbL5kB6rWzapOjRTUE5Tqrp8D8g8cKrOwQdfylY2kDU58HUpXuQOugB99B026Tp2xlCI0d1jqdL4+y7wf8wFojio+UtGWjabZBy7u/AGXyCWygE9T7lKXANDLw8Ip5KfPZTDueBG8lAvGZRTnM40IitV8nrZEjAHIGyF705pAc7V+URlT3rbo7PBtC+1iZ0yYKByney56emXgBzebAM29QnIuns1s1vxBqGoq3fCRzSNPbCT1yH8Q5izQsPsIW9VFe5t5/gPvZOp4fCfStwiKn3StfF8R9KoK42ppxAReSPep4Y4RxhlK+IdND8/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6/ebhn/fLC83ECyLiFvz5BAzQpDqTc2eRr2mfBbAao=;
 b=B9xpaIWvKgyGc99WxX5TBqpCXcApPXaodkqYnqPMcDA4M7iqXyVt8YZryWw7gC0isaBsDga+L4naWVcQ3EVEwZD2NdUf1KVyt812ybbxH7cqHYJFF+i1AegZUwNgYv+s/h/vr7XSfHFeJtKYO7MT3Ue8dmgJo9WA6+6IET5yKA8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SN6PR12MB2736.namprd12.prod.outlook.com (2603:10b6:805:75::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 17:11:07 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::3d17:21ac:a0ed:9a82]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::3d17:21ac:a0ed:9a82%5]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 17:11:07 +0000
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amd/amdgpu: Define and implement a function that
 collects number of waves that are in flight.
Date: Thu, 17 Sep 2020 12:10:53 -0500
Message-Id: <20200917171053.2513-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: SN1PR12CA0061.namprd12.prod.outlook.com
 (2603:10b6:802:20::32) To SN6PR12MB2672.namprd12.prod.outlook.com
 (2603:10b6:805:6f::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsacqe51.amd.com (165.204.77.1) by
 SN1PR12CA0061.namprd12.prod.outlook.com (2603:10b6:802:20::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3348.15 via Frontend Transport; Thu, 17 Sep 2020 17:11:07 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c69c8619-2356-4fe1-fa9e-08d85b2caab0
X-MS-TrafficTypeDiagnostic: SN6PR12MB2736:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27363EA6B862DD851DA70068E33E0@SN6PR12MB2736.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXht7jgyrxB1a4rBj0djGUxqk/hd8SrhqN/HBHo7PzYbs+heT5uVYVjwXdBxzaIdgG+yTUtylQITHklx6z9ZCH7PP0EXGtxwU7gWaoyazS7tGaVTzll3Ph8QzCuUQRvm+Lx6H7oW2NkTcI5+6Sag1UlRn33Ztq2hnBbxHO9kasQXHu+ZikVotci2uF2XVKb7qj9tm2nImdL1UUYmrY2etJl3DhuDg804fDeHRYBo92ronkik3t1S29fwMMB3PmUcTJki2Bdkga3w5XID02c+jOPnCAiKcJlvNosPlk+DwYcjsdhGCCRPfZ+uxNzZlzOHKnMdxuYnWuUFvV9ItKv/LmNKXMuU4PlhKUdWXxSkc+F7zDMCSbLVuHZaTk4xZmKc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(316002)(478600001)(66476007)(6486002)(6666004)(86362001)(5660300002)(2906002)(1076003)(66946007)(66556008)(36756003)(26005)(2616005)(16526019)(8676002)(8936002)(186003)(83380400001)(4326008)(6916009)(956004)(7696005)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +oFkVsVeqwvMGf6/yn8MvBvJsY6Kvh3/0w0t/twZU7rwFA4R2yAq4bM6as+uIsheGMa6Cn+nIA+WnStiEELPcCFnFFQI1GT6inp3tP9l6PG7b7E37oqtsmFTK3sdZmlMIP+67vJ3P/pZj7XjGAQJZ8NQvOUeUnEZ435w+Q1uOJydo4WlpZfJyL0KBTT0tQQFa9+tgXc3L+R9zJiAdT7UlFfvEBJLHuM1MS6W15Rb6ahclVgil0D+00ky46h7VKD24CKypcIriRKsBkfdUKhzS3b4JeN5qEiqsv24IAN4YsAgIWqpG4UP9MANxqFdfFtJi6575jBPztk2c4EJ/dDFk1SE/m/NCad3TBIOOgZPF1LifPbERS6ljMuMw+6u70HGTfABfUmJOchpVgUgLo4ForqlGGFi+5SRfEj9p9RxbLv3FuQ3facjoaQ6U/eirnvaODIududIGfsAVMe3qWWdWPGWbPJadslLOSIAnbc4g3MiamF5rFO+nVz0RBxIwVZflAeUcVpaGkNlkoDkVK0/u4OHDxLLMupFBjUZRzfQ+Cd7hArR4i6YDXxlMz/9LdvpLMzt+ToMYBcHHGqOQhO4b0pFRrOUr6jNMl0fBDEL7/SstdPPUe4EYMarV8I26shFMA29s5XrOMdTWEaklE1IeQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69c8619-2356-4fe1-fa9e-08d85b2caab0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 17:11:07.5168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2d0pMrsjuFJNBOD6CUqUYWuKfeBtju9RlHJk3VU1NdcWL7xIMSOYBb/f7XunNrWUcKU/iJk5e5URxjLZQC7pGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2736
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
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 206 ++++++++++++++++++
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  11 +
 2 files changed, 217 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index e6aede725197..2f8c8140734e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -38,7 +38,9 @@
 #include "soc15d.h"
 #include "mmhub_v1_0.h"
 #include "gfxhub_v1_0.h"
+#include "gfx_v9_0.h"
 
+struct kfd_dev;
 
 enum hqd_dequeue_request_type {
 	NO_ACTION = 0,
@@ -706,6 +708,209 @@ void kgd_gfx_v9_set_vm_context_page_table_base(struct kgd_dev *kgd,
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
+ * a particulare queue. The method also returns the VMID associated with the
+ * queue.
+ *
+ * @adev: Handle of device whose registers are to be read
+ *
+ * @queue_idx: Index of queue in the queue-map bit-field
+ *
+ * @wave_cnt: Output parameter updated with number of waves in flight
+ *
+ * @vmid: Output parameter updated with VMID of queue whose wave count
+ * is being collected
+ */
+static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
+			   int *wave_cnt, int *vmid)
+{
+	int pipe_idx;
+	int queue_slot;
+	unsigned int reg_val;
+
+	/*
+	 * By policy queues at slots 0 and 1 are reserved for non-compute
+	 * queues i.e. those managed for graphic functions.
+	 */
+	if ((queue_idx % adev->gfx.mec.num_queue_per_pipe) < 2)
+		return;
+
+	/*
+	 * Queue belongs to a compute workload. Determine the PIPE index
+	 * associated wit queue and program GRBM accordingly:
+	 * MEID = 1, PIPEID = pipe_idx, QUEUEID = queue_idx, VMID = 0
+	 */
+	pipe_idx = queue_idx / adev->gfx.mec.num_queue_per_pipe;
+	queue_slot = queue_idx % adev->gfx.mec.num_queue_per_pipe;
+	soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0);
+
+	/*
+	 * Read from register number of waves in flight. If non-zero get the
+	 * VMID associated with queue
+	 */
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
+ * shader engine and aggregates the number of waves that are in fight for the
+ * process whose pasid is provided as a parameter. The process could have ZERO
+ * or more queues running and submitting waves to compute units.
+ *
+ * @note: It's possible that the device has too many queues (oversubscription)
+ * in which case a VMID could be remapped to a different PASID. This could lead
+ * to in accurate wave count. Following is a high-level sequence:
+ *    Time T1: vmid = getVmid(); vmid is associated with Pasid P1
+ *    Time T2: passId = getPasId(vmid); vmid is associated with Pasid P2
+ * In the sequence above wave count obtained from time T1 will be incorrectly
+ * lost or added to total wave count.
+ *
+ * @kgd: Handle of device from which to get number of waves in flight
+ *
+ * @pasid: Identifies the process for which this query call is invoked
+ *
+ * @wave_cnt: Output parameter updated with number of waves in flight that
+ * belong to process with given pasid
+ *
+ * The registers that provide the waves in flight are:
+ *
+ *  SPI_CSQ_WF_ACTIVE_STATUS - bit-map of queues per pipe. At any moment there
+ *  can be a max of 32 queues that could submit wave fronts to be run by compute
+ *  units. The bit is ON if a queue is slotted, OFF if there is no queue. The
+ *  process could have ZERO or more queues slotted and submitting waves to be
+ *  run compute units. Even when there is a queue it is possible there could
+ *  be zero wave fronts, this can happen when queue is waiting on top-of-pipe
+ *  events - e.g. waitRegMem command
+ *
+ *  For each bit that is ON from above:
+ *
+ *    Read (SPI_CSQ_WF_ACTIVE_COUNT_0 + queue_idx) register. It provides the
+ *    number of waves that are in flight for the queue at specified index. The
+ *    index ranges from 0 to 7.
+ *
+ *    If non-zero waves are in fligth, read CP_HQD_VMID register to obtain VMID
+ *    of the wave(s).
+ *
+ *    Determine if VMID from above step maps to pasid provided as parameter. If
+ *    it matches agrregate the wave count. That the VMID will not match pasid is
+ *    a normal condition i.e. a device is expected to support multiple queues
+ *    from multiple proceses.
+ *
+ *  @note: Reading the registers mentioned above requires programming GRBM
+ *  appropriately.
+ */
+static void kgd_gfx_v9_get_cu_occupancy(struct kgd_dev *kgd, int pasid,
+					int *pasid_wave_cnt)
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
+	int vmid_wave_cnt = 0;
+	struct amdgpu_device *adev;
+	DECLARE_BITMAP(cp_queue_bitmap, KGD_MAX_QUEUES);
+
+	/*
+	 * Acquire  SRBM/GRBM locks before programming them to read registers.
+	 * By policy compute workloads are submitted on MEC1 (Micro-Engine)
+	 * Program GRBM to allow reading registers from MEC1. This constitutes
+	 * base programming. Programming of bit-fields for PIPE, QUEUE, etc will
+	 * be done later
+	 */
+	adev = get_amdgpu_device(kgd);
+	lock_spi_csq_mutexes(adev);
+	soc15_grbm_select(adev, 1, 0, 0, 0);
+
+	/*
+	 * Iterate through the shader engines and arrays of the device
+	 * to read registers that provide number of waves in flight
+	 */
+	bitmap_complement(cp_queue_bitmap, adev->gfx.mec.queue_bitmap,
+			  KGD_MAX_QUEUES);
+	sh_cnt = adev->gfx.config.max_sh_per_se;
+	se_cnt = adev->gfx.config.max_shader_engines;
+	for (se_idx = 0; se_idx < se_cnt; se_idx++) {
+		for (sh_idx = 0; sh_idx < sh_cnt; sh_idx++) {
+
+			/*
+			 * Program GRBM to read queue map register that is
+			 * associated with specified shader engine and array
+			 */
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
+			for (qidx = 0; qidx < 32; qidx++) {
+				if (!test_bit(qidx, cp_queue_bitmap))
+					continue;
+				if (!(queue_map & (1 << qidx)))
+					continue;
+
+				/*
+				 * For the specified queue index read number of
+				 * waves in flight and the VMID of the waves
+				 */
+				vmid = 0xFF;
+				wave_cnt = 0;
+				get_wave_count(adev, qidx, &wave_cnt, &vmid);
+
+				/*
+				 * Get PASID that is associated with VMID and
+				 * update the waves-in-flight aggregate
+				 */
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
+	/*
+	 * Reset GRBM to default state before releasing locks
+	 * associated with GRBM/SRBM resources
+	 */
+	gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	soc15_grbm_select(adev, 0, 0, 0, 0);
+	unlock_spi_csq_mutexes(adev);
+
+	/* Update the output parameter and return */
+	*pasid_wave_cnt = vmid_wave_cnt;
+}
+
 const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -726,4 +931,5 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.get_atc_vmid_pasid_mapping_info =
 			kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
+	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
 };
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index fc592f60e6a0..19e885cd0853 100644
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
@@ -286,6 +295,8 @@ struct kfd2kgd_calls {
 	void (*set_vm_context_page_table_base)(struct kgd_dev *kgd,
 			uint32_t vmid, uint64_t page_table_base);
 	uint32_t (*read_vmid_from_vmfault_reg)(struct kgd_dev *kgd);
+
+	void (*get_cu_occupancy)(struct kgd_dev *kgd, int pasid, int *wave_cnt);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
