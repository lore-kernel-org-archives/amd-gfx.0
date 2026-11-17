Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9D5606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Z7aqMDG5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 518B110E62D;
	Tue, 17 Nov 2026 18:19:56 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC20E10E496
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 18:19:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFNhYAxpRM0Cl7IEOS6btYqp+kCGGbLK75ThYzRUS9JgXjVoVVj8wzh736OS2wx1FFs1azjBF8lX/RdDly0GXslsccauL2QpzYjonLw7PoXS2hkkAKGJPM+7+3NdlnYymbljdF9iI8FBeiMG0HDz0PYzlOq9IOFMOCqeQdwV7BSwl8964OtECRB7MS/gDWjJ6FxGalX6JC3iNjtCrztzRTvVGjGqhFlF6W1qxYOZzdQBZqzaNv2zp+jUgVUSuIhkCDWy4NNMB4V+DCX+eGkUFiczgxdtGshxEHI+T8AHguupSbhdVtAfhFN5bIM8VuL9H1lPeuQu77oAhnpHYmPhuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbzndWGm48jJN4XfdkKHRqHpRHWeQMU/VsoX0C18FKU=;
 b=UkMcuiFZyEXslFupvVbIC0RhQHrhNV0Bz6zZRm3he4yPYI5oyGUwNUoegzkP8OK5B8a10vA0U7+7YwDlMUrhUmYro6oOhRyBy+oAYQoWhJbpZx8Y+cpwM0jmsVQ7GpjuYkg12oaH3BygcKGlhpPtt9KJEkTMbxqLNuNi6fJpR5ec6ueGBD35mf7V66u5qoFEuf8E71swEfO19Ssm6ko0U5qBaMTvhw8qzM6J8IaWlKMKrH+Ewu+ep5vCrMBsP71CBRNvwTY71F8iTvVeVa/emjgR8/uhiAc1mosV+/8af6hwTRb52fj1fcIb3ffdEvWbj9QjSfHJeIrGaXMWCO7KjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbzndWGm48jJN4XfdkKHRqHpRHWeQMU/VsoX0C18FKU=;
 b=Z7aqMDG5QyK6Ni0HP4GbS8042843iOIEraChPlKzWJtkFRbzijRkrHlLrKXEX46mYsB5NW7y6cZ+syVqtVxXLcPzoGGr/g79p5F7A8uQENoqjkRDLsN3gmLAeT6Vi2EyUlr1N+n1L1B1/AjW3Ggv2FKvKChGbCvffk+MPj1Ym6c=
Received: from PH7P221CA0047.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::19)
 by CYYPR12MB8963.namprd12.prod.outlook.com (2603:10b6:930:c3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 18:19:44 +0000
Received: from CY8PEPF0000005E.namprd21.prod.outlook.com
 (2603:10b6:510:33c:cafe::af) by PH7P221CA0047.outlook.office365.com
 (2603:10b6:510:33c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Tue,
 17 Nov 2026 18:19:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY8PEPF0000005E.mail.protection.outlook.com (10.167.247.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Tue, 17 Nov 2026 18:19:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 12:19:42 -0600
Received: from work-495456.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 12:19:42 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Sunil
 Khatri" <sunil.khatri@amd.com>, James Zhu <James.Zhu@amd.com>
Subject: [RFC PATCH v2 2/3] drm/amdgpu: reserve and bind the SPM VMID on every
 GFXHUB instance
Date: Tue, 17 Nov 2026 13:19:40 -0500
Message-ID: <20261117181941.3968996-3-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117181941.3968996-1-James.Zhu@amd.com>
References: <20261117165952.3558762-1-James.Zhu@amd.com>
 <20261117181941.3968996-1-James.Zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005E:EE_|CYYPR12MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9abe73-9fd7-4e49-f171-08df44d75aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|10067099003|5023799004|4143699003|56012099006|11063799006|261022075727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|261028144727099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YhDxPGeTm2iOFAmkqd4GGA5GBqYtxc5K0b9MtJlhPkQNTjkoKHoUJ2JA7jrAWiSN27GbjSyKROxO4PQyTREWuvb8d03IdhnA3r42J8IYLRAe+3+u/rmHIBC43zPZwlIwYtQS/pxda336uXxyteTRgrV6WMs8jtZ7L+kQ+ILSk31NtG75fAsDhdaSCTlhHJrnyCHRAQgKJ9hf5Q1LOxAXqqqbDRlB3hjOJHLrwt8yhlqU5ki/HbkQ33hBLUjEhX8c3U5qK/F8zguPirvH/e84Bi6c3rW6t9zS4iY9K0i+abXduDpXbGS7c4Y3GxvTfDkR3EPxfs3utpHZOX77s2os7R3hjw5TUUlxfDFCfSNcHcKVo43z3ERLfQ3uIn9nUpwuS1anTLFAwnIegdpzOavdirt2dRZWUwq2n5oWqEmw9ar79J9h5Pq+gMqEDY2XayDgzhgm351IBCFXW79nXIzpTLOwyBgkMBEFr83O/0EYl+jlMMCuNv2EJ+Vm8/PI73feNo1Vh/9jfz26s/qTtGW2PFqsfWHEFDYUonoopO5S5FzgPoH0TW0tmS0vxGZ/1a38m6OfOoZIfBdgll6SN/dka3xhTqpuTpU8HgaHU1jtY48sZnJFWglKtkZOeSfIhNePcMS4BoX/idDNrW+esdc9gWaJMeogZGBZs4qGJ1r0qdOdINq2oig+Btni3xvsxjEBfELEsB2fSY8u9z9nyPTpbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(10067099003)(5023799004)(4143699003)(56012099006)(11063799006)(261022075727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wSbccdgkrXuIHrAAfRr2TlJRW9ZHhccL3C5kKUxc9t4fTpH4M5FJ37hIvqIocH9VRgywYJV+8XJsKuUYynIyXBcKHTovOLHsOFMI2Y6NrH7oUhB3LCrTPmtdoSzKoTVCiNplbpDNprLpRGXsJUVECo13+ysqNC+QMAzRWArXectJo1W8NRCwSmE0NFgTF/Q2I7PWvo3SQFl0DctN/Jop7SsiVxmwS2iEtuLoyvfPSIFgFVC/dbedhyfcrftizWba6LTfLzctZkGG4O/42moNeo0OFKA6G4rAPrqVmbEUXEM5L1rKWXhtq3VzOEQoZ7hdjeyabqLSB5/b+1cOY5yJ8awExXQrA/flsp06dv55MLKXdqLrWojXwvhnyqZtGJqAGgvwrDhAAuka8t5taECS1USFTBf+0k7/1flQBGlTYTW/V0O1CaJov1PVhwOEauMO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 18:19:43.9009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9abe73-9fd7-4e49-f171-08df44d75aac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF0000005E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8963
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

The SPM VMID reservation made through AMDGPU_VM_OP_RESERVE_VMID is
recorded on AMDGPU_GFXHUB(0) only, while gfxhub v1.2's
setup_vm_pt_regs broadcasts the page table base to every XCC. On
multi-XCC parts the two disagree, in both directions:

- the reservation only takes effect for jobs running on XCC 0, since
  the VMID grab path checks vm->reserved_vmid[ring->vm_hub] and the
  rings of XCC i use AMDGPU_GFXHUB(i);
- the page table base is physically programmed on all XCCs anyway,
  and conflicting reservations are only detected on hub 0's id_mgr.

Make the hub argument real end to end: amdgpu_gmc_bind_vmid() programs
only the given hub, through the XCC-masked gfxhub callback where one
exists, and amdgpu_vmid_free_spm() unbinds the hub it frees instead of
hub 0. amdgpu_vm_spm_update() binds every GFXHUB on which @vm holds
the reservation. The VM ioctl reserves the VMID on every GFXHUB
instance through the new amdgpu_vmid_alloc_spm_gfxhubs() helper, so
the reservation now takes effect, is bound and is flushed on every XCC
the VM's jobs can run on, and a conflicting reservation shows up on
whichever hub two VMs share.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Assisted-by: Claude:claude-fable-5
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 68 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 56 +++++++++++++-------
 4 files changed, 114 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 08d3ff61edcc..704a30ad388a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -797,6 +797,7 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
  *
  * For VMIDs that are bound directly to a VM's page table outside the
  * normal per-job VM flush path, e.g. a dedicated out-of-pool VMID.
+ * Only @vmhub is programmed and flushed, other hubs keep their binding.
  */
 void amdgpu_gmc_bind_vmid(struct amdgpu_device *adev, unsigned int vmhub,
 			  unsigned int vmid, uint64_t pd_addr)
@@ -805,6 +806,9 @@ void amdgpu_gmc_bind_vmid(struct amdgpu_device *adev, unsigned int vmhub,
 
 	if (is_mmhub)
 		adev->mmhub.funcs->setup_vm_pt_regs(adev, vmid, pd_addr);
+	else if (adev->gfxhub.funcs->setup_vm_pt_regs_xcc)
+		adev->gfxhub.funcs->setup_vm_pt_regs_xcc(adev, vmid, pd_addr,
+				BIT(vmhub - AMDGPU_GFXHUB_START));
 	else
 		adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, pd_addr);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 9c879ac68352..a4403e5cc344 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -651,12 +651,78 @@ void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		id_mgr->reserved_vmid = false;
 
 		if (adev->vm_manager.spm_vmid && adev->gfxhub.funcs)
-			amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0),
+			amdgpu_gmc_bind_vmid(adev, vmhub,
 					     adev->vm_manager.spm_vmid, 0);
 	}
 	mutex_unlock(&id_mgr->lock);
 }
 
+/*
+ * amdgpu_vmid_alloc_spm_gfxhubs - reserve the SPM VMID on a set of GFXHUBs
+ * @adev: amdgpu device structure
+ * @vm: the VM to reserve the ID for
+ * @xcc_mask: XCC instances on whose GFXHUBs to reserve
+ *
+ * Reserve the SPM VMID on the GFXHUB of every XCC in @xcc_mask, so that
+ * the reservation covers every hub the VM's jobs can run on.
+ *
+ * Returns: 0 for success, the first per-hub error otherwise. On an error
+ * only the hubs this call reserved are released again, after waiting for
+ * the jobs which might have grabbed the reserved VMID in the meantime;
+ * hubs @vm already held before the call stay reserved.
+ */
+int amdgpu_vmid_alloc_spm_gfxhubs(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm, uint32_t xcc_mask)
+{
+	uint32_t allocated = 0;
+	int i, r;
+
+	for_each_inst(i, xcc_mask) {
+		bool held = amdgpu_vmid_uses_reserved(vm, AMDGPU_GFXHUB(i));
+
+		r = amdgpu_vmid_alloc_spm(adev, vm, AMDGPU_GFXHUB(i));
+		if (r)
+			goto error_free;
+		if (!held)
+			allocated |= BIT(i);
+	}
+
+	return 0;
+
+error_free:
+	/*
+	 * A job may already have grabbed a freshly reserved VMID, give it
+	 * the wait amdgpu_vmid_free_spm() demands before the rollback
+	 * unbinds the VMID again.
+	 */
+	if (allocated) {
+		dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
+				      DMA_RESV_USAGE_READ, false,
+				      MAX_SCHEDULE_TIMEOUT);
+		amdgpu_vmid_free_spm_gfxhubs(adev, vm, allocated);
+	}
+	return r;
+}
+
+/*
+ * amdgpu_vmid_free_spm_gfxhubs - undo amdgpu_vmid_alloc_spm_gfxhubs
+ * @adev: amdgpu device structure
+ * @vm: the VM with the reserved ID
+ * @xcc_mask: XCC instances on whose GFXHUBs to free the reservation
+ *
+ * Free the SPM VMID on every GFXHUB in @xcc_mask @vm holds it on, hubs
+ * without a reservation are skipped. The same wait requirement as for
+ * amdgpu_vmid_free_spm() applies.
+ */
+void amdgpu_vmid_free_spm_gfxhubs(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm, uint32_t xcc_mask)
+{
+	int i;
+
+	for_each_inst(i, xcc_mask)
+		amdgpu_vmid_free_spm(adev, vm, AMDGPU_GFXHUB(i));
+}
+
 /**
  * amdgpu_vmid_reset - reset VMID to zero
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index c134000eecfd..d2b225d0aa38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -129,6 +129,10 @@ int amdgpu_vmid_alloc_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			       unsigned vmhub);
 void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			       unsigned vmhub);
+int amdgpu_vmid_alloc_spm_gfxhubs(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm, uint32_t xcc_mask);
+void amdgpu_vmid_free_spm_gfxhubs(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm, uint32_t xcc_mask);
 int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 		     struct amdgpu_job *job, struct dma_fence **fence);
 void amdgpu_vmid_reset(struct amdgpu_device *adev, unsigned vmhub,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6b4dc0276e27..a9c23759d058 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -589,30 +589,38 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
  * The SPM VMID is fixed (adev->vm_manager.spm_vmid), so its page-table-base
  * register must track whichever VM currently holds the reservation instead
  * of being set per-job like a normal VMID. Bind it to @vm's real root PD
- * address if @vm holds the reservation; otherwise do nothing, since @vm is
- * not the one that could legitimately change the current binding.
+ * address on every GFXHUB @vm holds the reservation on; hubs reserved by
+ * other VMs or not reserved at all are left alone, since @vm is not the
+ * one that could legitimately change their binding.
  *
  * @vm's root PD must be locked by the caller.
  */
 void amdgpu_vm_spm_update(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	struct amdgpu_kq_vmid_mgr *id_mgr =
-		&adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)];
+	/* the GFXHUBs are indexed by logical XCC, adev->gfx.xcc_mask is physical */
+	uint32_t gfxhub_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
 	uint64_t pd_addr;
+	int i;
 
 	if (!adev->vm_manager.spm_vmid || !adev->gfxhub.funcs)
 		return;
 
-	mutex_lock(&id_mgr->lock);
-	if (vm->reserved_vmid[AMDGPU_GFXHUB(0)] !=
-	    &id_mgr->ids[adev->vm_manager.spm_vmid] || !amdgpu_vm_ready(vm)) {
-		mutex_unlock(&id_mgr->lock);
+	if (!amdgpu_vm_ready(vm))
 		return;
-	}
 
 	pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
-	amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0), adev->vm_manager.spm_vmid, pd_addr);
-	mutex_unlock(&id_mgr->lock);
+	for_each_inst(i, gfxhub_mask) {
+		struct amdgpu_kq_vmid_mgr *id_mgr =
+			&adev->vm_manager.id_mgr[AMDGPU_GFXHUB(i)];
+
+		mutex_lock(&id_mgr->lock);
+		if (vm->reserved_vmid[AMDGPU_GFXHUB(i)] ==
+		    &id_mgr->ids[adev->vm_manager.spm_vmid])
+			amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(i),
+					     adev->vm_manager.spm_vmid,
+					     pd_addr);
+		mutex_unlock(&id_mgr->lock);
+	}
 }
 
 /**
@@ -2871,9 +2879,14 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
 	/* Wait for the jobs which might still use the reserved VMID */
-	if (vm->reserved_vmid[AMDGPU_GFXHUB(0)])
-		dma_resv_wait_timeout(root->tbo.base.resv, DMA_RESV_USAGE_READ,
-				      false, MAX_SCHEDULE_TIMEOUT);
+	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
+		if (vm->reserved_vmid[i]) {
+			dma_resv_wait_timeout(root->tbo.base.resv,
+					      DMA_RESV_USAGE_READ,
+					      false, MAX_SCHEDULE_TIMEOUT);
+			break;
+		}
+	}
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
 	dma_fence_wait(vm->last_seq_flush, false);
@@ -3015,10 +3028,12 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 	switch (args->in.op) {
 	case AMDGPU_VM_OP_RESERVE_VMID: {
+		/* logical XCCs, the GFXHUB index space; xcc_mask is physical */
+		uint32_t gfxhub_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
 		int r;
 
 		/* We only have requirement to reserve vmid from gfxhub */
-		r = amdgpu_vmid_alloc_spm(adev, vm, AMDGPU_GFXHUB(0));
+		r = amdgpu_vmid_alloc_spm_gfxhubs(adev, vm, gfxhub_mask);
 		if (!r && !amdgpu_bo_reserve(vm->root.bo, true)) {
 			amdgpu_vm_spm_update(adev, vm);
 			amdgpu_bo_unreserve(vm->root.bo);
@@ -3026,15 +3041,22 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		return r;
 	}
 	case AMDGPU_VM_OP_UNRESERVE_VMID: {
+		/* logical XCCs, the GFXHUB index space; xcc_mask is physical */
+		uint32_t gfxhub_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
 		struct amdgpu_bo *root = vm->root.bo;
+		bool reserved = false;
+		int i;
 
 		amdgpu_bo_reserve(root, true);
+		for_each_inst(i, gfxhub_mask)
+			reserved |= amdgpu_vmid_uses_reserved(vm,
+							AMDGPU_GFXHUB(i));
 		/* Wait for the jobs which might still use the reserved VMID */
-		if (vm->reserved_vmid[AMDGPU_GFXHUB(0)])
+		if (reserved)
 			dma_resv_wait_timeout(root->tbo.base.resv,
 					      DMA_RESV_USAGE_READ, false,
 					      MAX_SCHEDULE_TIMEOUT);
-		amdgpu_vmid_free_spm(adev, vm, AMDGPU_GFXHUB(0));
+		amdgpu_vmid_free_spm_gfxhubs(adev, vm, gfxhub_mask);
 		amdgpu_bo_unreserve(root);
 		break;
 	}
-- 
2.34.1

