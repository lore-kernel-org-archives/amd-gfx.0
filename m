Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A31606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZVnxqwyF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3192810E7C9;
	Thu, 29 Oct 2026 07:04:20 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9613C10E7C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 07:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxTHEN4lzTeTp4zmm89WAREk4VZNs58PYo5qiuqufkls7voeApVcwCTVtUuJakZZJ/BXNK3eGYkPgYVJDS5MfGLF76VuVjjse/k6BfSlkqobONOSAppkDA37UhbD8beV1ZBV0AO1uFDUnEn/Y8HClNHQjOxmP+uycrUlt1HGaKwXs7M5L2twiP8D0CqzPr7HY4dHc0mIzXGpM8WfCSVIK4fkjqKlhBI0U/JIw6VF6m/EfkNPyWCGrr/9UNzmYqJVusuHfMn+AeIPgiIh7n6ybslLMq4ZMXVWzyWRL7nd0b9fZSkxNccxvwOrfsG1+M0nk6Zp6LpI1SkXJdte2wI+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoaJFeLrKaOAv9p1X1kg7okd0q6qMpgZvaeIUNTtw4c=;
 b=prZtPtTnr3gLxU674tCTzCbtBB5d75EFx4aZFMo8OS6L+71UyERQJGIWSEHHPGVE/+DgXysGlB0QUZDr+GbbMHzcT7ryIl41eeOwvn4alyOL2eVTdCyvkDoNksZiWLoHuT6NEKopcQc374ne6kNJ/gr96LufHeTYbja8nzfhVAaRDp76ZoXyjwgmQ5yViV2j89/LD/DQQ1g8NGZkLuyfyyIlUdoqW0aV+cf0j/PNJQpplMSiRSg0gLuNrNW7EFvPC9lXUzkfyWZFSfCTVeUcOpxT2oCw+kgePtFYkAldSe13+PIRYErFNTf4/tkrILrI2JigGAktFPVP02pF/TGROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoaJFeLrKaOAv9p1X1kg7okd0q6qMpgZvaeIUNTtw4c=;
 b=ZVnxqwyFsOFrvAamKRDkEYtQ42SKKTcN/vfcfpIpRDcfZpJpuxfAZv85VXk0jEJ6R/Gb5KNFz//6QY+miPlHsed/gtlUaoIklHIi1jNdhjOyVf4Sv44VoEtHcus2+oGX2J8wKra+wsMIBlEYkADne64s8oay5a4GPimDeZ6doMQ=
Received: from PH8P220CA0050.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::24)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 07:04:07 +0000
Received: from BY1PEPF000264AF.namprd02.prod.outlook.com
 (2603:10b6:510:2d9:cafe::11) by PH8P220CA0050.outlook.office365.com
 (2603:10b6:510:2d9::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 29 Oct 2026 07:04:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264AF.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 07:04:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 02:04:05 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 02:04:05 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 29 Oct 2026 02:04:04 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: program the SPM VMID for jobs on the reserved
 VMID again
Date: Thu, 29 Oct 2026 15:03:24 +0800
Message-ID: <20261029070403.22012-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264AF:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: f9da6ce8-17eb-44aa-8d49-08df358ad26d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|18002099003|56012099006|11063799006|261028144727099003|261022075727099003|261022105027099003|10067099003|261021121427099003|261021123027099003|261009223027099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: n2Ip0oVaNb0vdycZIQwMlYFXS5t+AtvnMsLe0f3mzAunztXMqFsv8U6Lz+TgmwmnFlG3U85QwNjKgIP0nXq3cibLiT28bHZfNHCZU0QzhoOu+Z+2Ep5CSZ/9T+OEow2I00DT6FLsDBKVn/WmyeblMVObJudsFuigL437fg3iVtZPDBR94e7qNHujZVwZBEDauX6jjo3JhWTyh4Pv1unUWwbuwx1riaO/sVauJUR6pLyex1Yl7nXuoBGx8Z0AG959i5SPE2wtbeMuS1peCiR1zRZCmxHI7MfxQAHQiRy5K9qKWp/23UeUiSbwaIWoqfes/j9X5TZFW8i6ltpUKqIb3wFhvqVUJYVWa/Lwdqp0gMDiKkYAL0gNLdHXKs4pp32h6rDDfwha1OzO2CPu1F/CCTdOAEWxOKhDtSnM7QjmW+GP5yLQPyvqGkwCQeymK4QxidBhBBiS5t38Jtr3ntcm1iqO669r+x9ffrVTzy5xcaeOKz+URNGUvLXae2e8NnTehpDkhEOnp5YAShfG6mDCR/AOu5d+i2c/MLhS3bg2+V1PMw+OVOljq/mL8NOrHDJAOwmvT54i06TsCmpVR9InYcSD4Y1QVD8L7OYc7NXsD4UI1bBAS3LW4dXdjCc7TEMBeDcvl02i5l6JzUaSoIxXi14ulGPhIx11CYOkWgwSaf75cuxI+p5+HHCL+CcSzxNaJ45MEynJyorVWdO3sTGnsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(56012099006)(11063799006)(261028144727099003)(261022075727099003)(261022105027099003)(10067099003)(261021121427099003)(261021123027099003)(261009223027099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dsO6C3CBLEdzObvv6NMAxeaZu2AgagfCNZbzKKXITWzJAhh3heZLNTUW1VdcCjvXHvvQDZvDcchbNtdfFRT85vdhI/6SCWOOArZRHvtV048UG0mTMOD9b8IPVoQGs62pdfjIUxNF7kTUndS6KRN/mk3j8Z2Z2TFhQVxjotQhIZqAJjO1iUOkokQQDf+oiVW0QkWr5g3TcshJUJVu2+KCFvrrJ34dRzbmBNN3RvV77VJx0Gob6EseuB/lZqwCCA1ZapUTTIvj7FVFwV2BIXadNvjY2UyTRmV+ecm0uC4PDdV7FY08I7AT90qGHSY3KtP7g1MzuQ1JThhAklVj+l/j481X7R7nlGKa2PwMndKCQAi1v6DpkKRb4N0ZasnkfESbSDce6TDmDtutxokxeoljBBG4g1X8+wp8nfPC+6Ua48QvgPSXuMG86Lg0L1+iM/pi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 07:04:06.1352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9da6ce8-17eb-44aa-8d49-08df358ad26d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 38e07c072833 ("drm/amdgpu: remove the now-redundant runtime SPM
VMID update") dropped the RLC_SPM_VMID update on submission, as the SPM
VMID is fixed and programmed once at init. RLC_SPM_MC_CNTL doesn't keep
its value over GFXOFF though, the RLC brings it back as 0 when it powers
GFX up again. So once the GPU idled, the job of a process which reserved
the VMID for SPM runs with the SPM writing through VMID 0.

On navi48 RLC_SPM_MC_CNTL reads 0xf right after hw_init, 0 once GFXOFF
was entered, and stays 0xf with GFXOFF disabled. A COPY_DATA of the
register from the IB of a process with a reserved VMID gives 0 instead of
the reserved VMID 15:

  $ umr -i 0 -go 0; umr -i 0 -r '*.*.regRLC_SPM_MC_CNTL'
  gfx1201.regRLC_SPM_MC_CNTL => 0x00000000
  $ amd_spm --run-subtest reserved-vmid-spm-vmid
  RLC_SPM_MC_CNTL in the job: 0x00000000

Update it on submission again, but only for the jobs on the reserved VMID
and with the fixed SPM VMID. Unlike before that commit, a GPU reset must
not force the update for every job: RLC_SPM_MC_CNTL is shared, and a job
of another VM would retarget the SPM of the profiled process to its own
VMID. The reserved path requests the update on every submission anyway.
With that it's back to 15 inside the job.

Fixes: 38e07c072833 ("drm/amdgpu: remove the now-redundant runtime SPM VMID update")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 15 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  3 ++-
 5 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index f98a7c6797b3..ec0883df91b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -126,6 +126,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	struct amdgpu_fence *af;
 	struct amdgpu_fence *vm_af;
 	bool need_ctx_switch;
+	bool emit_spm_needed = false;
 	bool emit_gds_needed = false;
 	uint64_t fence_ctx;
 	uint32_t status = 0, alloc_size;
@@ -194,7 +195,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 
 	/* VM sequence */
 	vm_af->ib_wptr = ring->wptr;
-	amdgpu_vm_flush(ring, job, &need_pipe_sync, &emit_gds_needed);
+	amdgpu_vm_flush(ring, job, &need_pipe_sync, &emit_spm_needed,
+			&emit_gds_needed);
 	vm_af->ib_dw_size =
 		amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr, ring->wptr);
 
@@ -209,6 +211,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (need_pipe_sync)
 		amdgpu_ring_emit_pipeline_sync(ring);
 
+	if (emit_spm_needed)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id,
+						     adev->vm_manager.spm_vmid);
+
 	if (emit_gds_needed)
 		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
 					    job->gds_size, job->gws_base,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 9c879ac68352..124fb875c651 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -434,6 +434,7 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 		return r;
 
 	job->vm_needs_flush = needs_flush;
+	job->spm_update_needed = true;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index f6577f82e6b9..ae569b4497f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -75,6 +75,7 @@ struct amdgpu_job {
 	uint32_t                preemption_status;
 	bool                    vm_needs_flush;
 	bool			gds_switch_needed;
+	bool			spm_update_needed;
 	uint64_t		vm_pd_addr;
 	unsigned		vmid;
 	unsigned		pasid;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 000c982816a7..7a8e363449a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -809,12 +809,14 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
  * @ring: ring to use for flush
  * @job:  related job
  * @need_pipe_sync: is pipe sync needed
+ * @emit_spm_needed: does the caller need to emit spm
  * @emit_gds_needed: does the caller need to emit gds
  *
  * Emit a VM flush when it is necessary.
  */
 void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
-		     bool *need_pipe_sync, bool *emit_gds_needed)
+		     bool *need_pipe_sync, bool *emit_spm_needed,
+		     bool *emit_gds_needed)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_isolation *isolation =
@@ -823,6 +825,8 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	unsigned vmhub = ring->vm_hub;
 	struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
+	bool spm_update_needed = adev->gfx.rlc.funcs->update_spm_vmid &&
+		job->spm_update_needed;
 	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
 		job->gds_switch_needed;
 	bool vm_flush_needed = job->vm_needs_flush;
@@ -845,6 +849,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	mutex_unlock(&id_mgr->lock);
 
 	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
+	spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
 	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
 			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
 	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
@@ -858,6 +863,10 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	emit_fence = vm_flush_needed || pasid_mapping_needed ||
 		cleaner_shader_needed;
 
+	*emit_spm_needed = spm_update_needed;
+	if (spm_update_needed && emit_fence)
+		*emit_spm_needed = false;
+
 	*emit_gds_needed = gds_switch_needed;
 	if (gds_switch_needed && emit_fence)
 		*emit_gds_needed = false;
@@ -897,6 +906,10 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (pasid_mapping_needed)
 		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
 
+	if (spm_update_needed)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id,
+						     adev->vm_manager.spm_vmid);
+
 	if (gds_switch_needed)
 		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
 						    job->gds_size, job->gws_base,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 06e0ddd60c7b..973ad7576d9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -449,7 +449,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       int (*callback)(void *p, struct amdgpu_bo *bo),
 		       void *param);
 void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
-		     bool *need_pipe_sync, bool *emit_gds_needed);
+		     bool *need_pipe_sync, bool *emit_spm_needed,
+		     bool *emit_gds_needed);
 int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate);
 int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
-- 
2.50.1

