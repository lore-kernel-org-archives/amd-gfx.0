Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB837CD6E40
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BD0710E677;
	Tue, 26 May 2026 14:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kubfJsic";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013013.outbound.protection.outlook.com
 [40.93.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D73510E689
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:12:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLMtqlmSOGdbr3d+FolZoep0egCcA6DEo2Sp7UBsjYy25xQluWzOKUnXMaoXnrEHRhKAY+43utw0sTGqjS8eYQNhDt7FHAgkq3WL8VIKGE6vDQv8wYB1gxhNW2Hm8gTtD4rp55TVQlTva/rUq2JVug22uQYCCsT13+qFUQidJA2WrxTropmo1cB+YBwRv5w3z+I2JxPY1VC3bbUGojpkCLkM+psw4YAgwNsFVbplTuiSTFyBIkcAWJVw6zoOrvdNF41JpK8ntJKzs6vbpCx9er/kNY1Ei9lJUMIyxcyvt+To1JIb0Gv1Rp2cdxViQZefE6scdpPumWUdn6lhExaLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crcRrY2+g+2vO5zJQ/GjRDAg+EgQLv+LVNh+LA8KHh0=;
 b=c1RZVDkUUoeuyTm4iA/zfD0x9qkHrZ/CeZHFPtfFqatU6nY4HjGKpPxJyiPi7lEfKEsrTdYtTK3OAjizbv0P20fIdmW64iT19pettDYmorf/Qm1chMkXwDkIXeRlF+bZTaeDJ0YHHynRYyEpCMPnX2Kw6EbyUwMhxEyYREnDLeMWrVoXr6pET9ozguXfCxg4utIOD+IXD9VN7gfCfFMTV2KO1tNRoMR32zR//hYLnCnyr3RQgjqg2OKUhNx6xPbl/6loZSzu8Bq6rRfuQLgEnrNmLwsNVZaU6UjfIA8yrkGZVhuqCSQKnwBjlSs4R9FlOhAJT8zvFhGNxQ3QCzGvdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crcRrY2+g+2vO5zJQ/GjRDAg+EgQLv+LVNh+LA8KHh0=;
 b=kubfJsic7Jtx2OxqdtBrl5DCA683EMU+b0qZGCN64GdnYHsiIWbjn+v0zn1+cPh31B2z3AaO59jlMNUtwuRjaEERCWzC+yoxXF6vd7mki6jkGjuXTmoi6HDmaxsA6j0w4mPl6jHke3ClwP6Cdmw89Ft5Lks8lkKC+S8APYxQ9AY=
Received: from BN9PR03CA0673.namprd03.prod.outlook.com (2603:10b6:408:10e::18)
 by DS7PR12MB5983.namprd12.prod.outlook.com (2603:10b6:8:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 14:11:59 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::27) by BN9PR03CA0673.outlook.office365.com
 (2603:10b6:408:10e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 14:11:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 14:11:58 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 09:11:53 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 10/17] drm/amdgpu: add profiler/spm operation
 AMDGPU_SPM_OP_ACQUIRE
Date: Tue, 26 May 2026 10:11:22 -0400
Message-ID: <20260526141129.592886-10-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526141129.592886-1-James.Zhu@amd.com>
References: <20260526141129.592886-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|DS7PR12MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 532299b5-8ec9-40c1-44ec-08debb30bff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|11063799006|6133799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 9n9pML/QmNiR4YwQsUlczXm08GrwaedCIiafqFju925y3qQWVexekA18wK7y6KJgBfqRKWJ5VjPC3Elxab/54MjGT51JY6bFfXRFJsAYBP5Zil+uXx2f0kU49uI8KpUTv5t8W5Y++EKjSoEzvbwn+HcmNBUdFVI0VPA9YsZ3RoMRVkAqlOsay7nWGP3p5c1zbPMzJUxPDUnSvBOT6ppKK7iG+gD+2GqONJdJnofSUYd7xPIDcGU9+89us6Bcacv8fT6sAw+GCeC023cmEQt180096VehAQL5YaKtIUC5vsFHJpHd+fPVe29PNGlTOnwLzg2IL0RYyYDaQjugdDhUFQP2dWnqdnvCRtGVgQ2zGeDh1jBv/txBB4w+Nh+St52igU/IGGHkcCwyIcbowRsrZYsG3H23AL0gsRU43u5miCQFCS8XHeVV7VfLJspOux6KPQh2MPP1jFIwh2jY8Ca8UjL0UKdlx0O+pOyfW+RpBaNcMJV+i22NQjjQVbc0Npk6S7yN1hLU7MEBva83zDwolvd7EWdRxn3b9di0i4Ihtx2v6vBHyBG9bzd7mvtuRmp0nkErYoXKR4IpjlYO+f2LE7Mi1pgFuCAU47K3MHQeWFxvuLeUoYndTuFSMZ/Ra7Qmgln30Cqj57FROM9NJmQhQLyJjgxkql4QxC6zEbiHwYwcxfCbUjyRqdSFfIqTDN8hNFik7WLcLPRT2539izuIF9/ZtYKQntQ1RQ/3bxpE3VE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(6133799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m3j01xknOonC7n3P3af80KeHrkZtDaWZXlWVF6dxY4D0BbqnGCcAEkEcqUBfvvMCRTHGpE8JFWPUj0PY+aF/GcJtWIbd0esDnA7Ho7GAFSotQJYAp/3xSlywuA3dvTQV1u5Zz0qniJRdOfJkVbbielmmCAGxf98CtjZq2iszOivFaELg6KV8ZkcfrLdSq36IkdsHcn6aTMF7UVgRPon5r02T0zkqxBtgJJ7Jv9ctVe6GHxl8Nyyb0V9iN5b5zFVst04SQsd2mSqECPKP97tdI8fPf0FKUS0bLzZXsxaGGqZ5/OKHZmgPW8IrKVn7N7HDEjCobky3OTZBIQ7Cdtmpr6mF4hbMwWARhNlVblaFikFS3y//Q1cE7tl9SBvJ+4HCEU/L+OX4InsFFuTY1WHiDpEkWnQDDyUeJ2O0oTUm71VFsJV19WAxtkdmIY3mwzKg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:11:58.5985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 532299b5-8ec9-40c1-44ec-08debb30bff3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5983
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

to implement AMDGPU_SPM_OP_ACQUIRE, which grants a process exclusive
access to the SPM hardware on its XCP partition and allocates the
per-XCC ring buffers used for streaming performance counter data.

Data structures:
  struct amdgpu_spm_base (amdgpu_spm.h):
    Holds the per-XCC ring buffer state: GTT BO handle (spm_obj),
    GPU virtual address (gpu_addr), kernel virtual address (cpu_addr),
    and effective ring size (ring_size).

  struct amdgpu_spm_cntr (amdgpu_spm.h):
    Contains an array of amdgpu_spm_base[MAX_XCP] (one per XCC) and a
    spm_worker_mutex to serialize worker operations. Allocated on first
    ACQUIRE and freed on RELEASE.

  struct amdgpu_spm_mgr (amdgpu_spm.h):
    Extended with lead_thread (the acquiring process's thread group
    leader), spm_cntr pointer, and spm_work work_struct for the deferred
    ring buffer drain worker.

ACQUIRE flow (amdgpu_spm_acquire):
  1. Takes the per-XCP prof_xcp_mgr->mutex to serialize concurrent
     ACQUIRE attempts.
  2. Returns -EBUSY if spm_cntr is already allocated (another process
     holds SPM).
  3. Allocates spm_cntr via kzalloc and records current->group_leader
     as lead_thread.
  4. For each XCC in AMDGPU_XCC_MASK(adev), calls _amdgpu_spm_acquire():
     - Allocates a 4 MiB GTT ring buffer via amdgpu_bo_alloc_gtt_mem().
     - Programs the ring buffer into the RLC hardware via
       amdgpu_rlc_spm_acquire(), which also reserves a VMID for the
       caller's VM.
     - Subtracts 0x20 bytes (8 DWORDs) from ring_size to exclude the
       hardware-defined metadata area at the end of the buffer.
     - On failure, frees the GTT BO and clears the spm_base entry.
  5. Initializes spm_worker_mutex and INIT_WORK for amdgpu_spm_work.
  6. Records the drm_file pointer in spm_mgr->file.
  7. On any per-XCC failure, rolls back all already-acquired XCCs via
     _amdgpu_spm_release() (stub, TODO) and frees spm_cntr.

amdgpu_spm_work (work_struct handler):
  Attaches the lead_thread's mm_struct via kthread_use_mm() to enable
  user-space copy operations, then detaches and releases the mm. The
  actual ring buffer drain to user space is a TODO for a later patch.

Three new navigation macros are added in amdgpu_profiler.h:
  - to_prof_xcp_mgr(x, y): container_of from a member y to
    amdgpu_profiler_xcp_mgr.
  - xcp_to_prof_mgr(x, y): container_of from prof_xcp_mgr[] element to
    amdgpu_profiler_mgr.
  - mgr_to_adev(x, y): compound statement combining the two above to
    reach amdgpu_device from any embedded manager pointer.

AMDGPU_XCC_MASK(adev) is added using GENMASK() to safely produce a
bitmask of active XCC instances from NUM_XCC(adev->gfx.xcc_mask).

In amdgpu_spm_ioctl(), the per-XCP spm_mgr is now resolved from fpriv
using AMDGPU_XCP_ID() before dispatching to sub-operation handlers.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <Bing.Ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  13 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c      | 114 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h      |  17 +++
 3 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
index 35ad16b0ead5..b4abf5b71f95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -27,6 +27,7 @@
 
 #include "amdgpu_spm.h"
 
+#define AMDGPU_XCC_MASK(adev) GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0)
 #define AMDGPU_XCP_ID(x) (x == AMDGPU_XCP_NO_PARTITION ? 0 : x)
 #define fpriv_to_prof_mgr(fpriv) (&(fpriv)->userq_mgr.adev->prof_mgr)
 #define fpriv_to_adev(fpriv) ((fpriv)->userq_mgr.adev)
@@ -34,6 +35,18 @@
 #define prof_mgr_to_adev(x) \
 	container_of(x, struct amdgpu_device, prof_mgr)
 
+#define to_prof_xcp_mgr(x, y) \
+	container_of(x, struct amdgpu_profiler_xcp_mgr, y)
+
+#define xcp_to_prof_mgr(x, y) \
+	container_of(x, struct amdgpu_profiler_mgr, y)
+
+#define mgr_to_adev(x, y) \
+({	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr = to_prof_xcp_mgr(x, y); \
+	struct amdgpu_profiler_mgr *prof_mgr = \
+		xcp_to_prof_mgr(prof_xcp_mgr, prof_xcp_mgr[prof_xcp_mgr->xcp_id]);\
+	prof_mgr_to_adev(prof_mgr); })
+
 struct amdgpu_profiler_xcp_mgr {
 	struct mutex                   mutex;
 	uint32_t                       xcp_id;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index 6ff88dfabf1c..e58b89ccd83f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -30,10 +30,28 @@
  */
 
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp);
+static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp);
+
+static void amdgpu_spm_work(struct work_struct *work)
+{
+	struct amdgpu_spm_mgr *spm_mgr = container_of(work, struct amdgpu_spm_mgr, spm_work);
+	struct mm_struct *mm = NULL;
+
+	mm = get_task_mm(spm_mgr->lead_thread);
+	if (mm) {
+		kthread_use_mm(mm);
+		{ /* attach mm */
+			/* TODO: dump spm ring buffer to user buffer */
+		} /* detach mm */
+		kthread_unuse_mm(mm);
+		/* release the mm structure */
+		mmput(mm);
+	}
+}
 
 static void amdgpu_spm_init_device(struct amdgpu_spm_mgr *spm_mgr)
 {
-	/* TODO */
+	spm_mgr->spm_cntr = NULL;
 }
 
 static void amdgpu_spm_release_device(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
@@ -41,6 +59,94 @@ static void amdgpu_spm_release_device(struct amdgpu_spm_mgr *spm_mgr, struct drm
 	amdgpu_spm_release(spm_mgr, filp);
 }
 
+static int _amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp)
+{
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+	struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
+	int ret = 0;
+
+	/* allocate 4M spm ring buffer */
+	spm->ring_size = 4 * 1024 * 1024;
+
+	ret = amdgpu_bo_alloc_gtt_mem(adev,
+			spm->ring_size, &spm->spm_obj,
+			&spm->gpu_addr, (void *)&spm->cpu_addr,
+			false, false);
+
+	if (ret)
+		goto out;
+
+	ret = amdgpu_rlc_spm_acquire(adev, inst, drm_priv_to_vm(filp),
+			spm->gpu_addr, spm->ring_size);
+	if (ret)
+		goto rlc_spm_acquire_failure;
+
+	/*
+	 * By definition, the last 8 DWs of the buffer are not part of the rings
+	 *  and are instead part of the Meta data area.
+	 */
+	spm->ring_size -= 0x20;
+
+	goto out;
+
+rlc_spm_acquire_failure:
+	amdgpu_bo_free_gtt_mem(adev, &spm->spm_obj);
+	memset(spm, 0, sizeof(*spm));
+out:
+	return ret;
+}
+
+static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
+{
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+	int ret = 0;
+	int inst;
+
+	mutex_lock(&(to_prof_xcp_mgr(spm_mgr, spm_mgr)->mutex));
+
+	if (spm_mgr->spm_cntr) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	spm_mgr->spm_cntr = kzalloc(sizeof(struct amdgpu_spm_cntr), GFP_KERNEL);
+	if (!spm_mgr->spm_cntr) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	spm_mgr->lead_thread = current->group_leader;
+
+	for_each_inst(inst, AMDGPU_XCC_MASK(adev)) {
+		ret = _amdgpu_spm_acquire(spm_mgr, inst, filp);
+		if (ret)
+			goto acquire_spm_failure;
+	}
+
+	mutex_init(&spm_mgr->spm_cntr->spm_worker_mutex);
+
+	INIT_WORK(&spm_mgr->spm_work, amdgpu_spm_work);
+
+	spm_mgr->file = filp;
+
+	goto out;
+
+acquire_spm_failure:
+	for_each_inst(inst, AMDGPU_XCC_MASK(adev))
+		_amdgpu_spm_release(spm_mgr, inst, filp);
+	kfree(spm_mgr->spm_cntr);
+	spm_mgr->spm_cntr = NULL;
+
+out:
+	mutex_unlock(&(to_prof_xcp_mgr(spm_mgr, spm_mgr)->mutex));
+	return ret;
+}
+
+static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp)
+{
+	/* TODO: */
+
+}
+
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
 {
 	/* TODO */
@@ -52,9 +158,15 @@ int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
 {
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_device *adev = fpriv_to_adev(fpriv);
+	struct amdgpu_profiler_mgr *prof_mgr = fpriv_to_prof_mgr(fpriv);
 	struct drm_amdgpu_spm_args *args = data;
+	struct amdgpu_spm_mgr *spm_mgr =
+		&(prof_mgr->prof_xcp_mgr[AMDGPU_XCP_ID(fpriv->xcp_id)].spm_mgr);
 
 	switch (args->op) {
+	case AMDGPU_SPM_OP_ACQUIRE:
+		return amdgpu_spm_acquire(spm_mgr, filp);
+
 	default:
 		dev_dbg(adev->dev, "Invalid option: %i\n", args->op);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index dc55d2a8f016..9db89fd6154d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -24,8 +24,25 @@
 #ifndef AMDGPU_SPM_H_
 #define AMDGPU_SPM_H_
 
+struct amdgpu_spm_base {
+	u64    gpu_addr;
+	u32    ring_size;
+	u32    *cpu_addr;
+	void   *spm_obj;
+};
+struct amdgpu_spm_cntr {
+	struct amdgpu_spm_base spm[MAX_XCP];
+	struct mutex spm_worker_mutex;
+};
+
 struct amdgpu_spm_mgr {
 	struct drm_file *file;
+
+	struct task_struct *lead_thread;
+
+	/* spm data */
+	struct amdgpu_spm_cntr *spm_cntr;
+	struct work_struct spm_work;
 };
 
 int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
-- 
2.34.1

