Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBA6C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 08:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959D5205C9
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 08:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="O/+PaRky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959D5205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AC856E8DE;
	Tue, 21 Apr 2020 08:20:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E60FF6E8DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 08:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZENEmbMdgLp0wGFNSc5oGiJnaLy6uEmvK5FOg6MMpkpt5GpGVt/d1kd7mpaeBjyynFgxYq5LzRaYR32wfTIf9l7YrQcuK+mDIT6IlHWaxIWlev2aykiySBrLBP098kgCe6WYdmqrjylb1hUCFeD1sFR3w2yxXaZbgHFckV7a73FPDt7usYQAGEAGfgur8AE3FzHcawvWJcPGeKGcsnbDikYMHqWoHip5x5JGxYbO6Z57CsOWED9Sn6WPPldWzM9+yDLkUSaFE07iqMSG9Rr1jDrWpGwjzJgQvU6efo8OE8fXTVhilecugJcjUj6Bw+tmpPy1/hp93m/Y1Zovw76rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAsVjvGGBykPRJzjmibTDk0XYFI1kpoAue+qbq+dz5A=;
 b=ARaOwIHskKX4pvVWT66q/kLozMQHFSNtxWGB162QkyMjkP0H8HZHi2P8s6hhnN36VvCvcmYfuahnJ6D3o2P0TmqL/4FCXnvhUklFCmwwNeTtPbbBPde0LNbq3HFT+tMgLWaQ94pBiZKMhRGTup14TA/5rm2uge3JoApq9KaeVip4HCbN0xTRurrEc8+FC0QLHAPFKT3etraA/6D7LTiGNy/PEnTXEs/+lCpYiAqSkhOQyFa0/WnQdBPm6DCIkdEc3IHAq8CBbVuc6nJmBBgugas2gjhWzlC2O9ARdD3MaRWQKFoqzptPRh0AsHWPrT7JkomEHydE6xJmx5H8eG9bNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAsVjvGGBykPRJzjmibTDk0XYFI1kpoAue+qbq+dz5A=;
 b=O/+PaRkyj0Qj/bRB/iPJ2KseGzAwscDYrP99O3bw3MEnwl5Rr7sB8QdMJ3RQiY19oCe04HxqfGJLsfO1h/7ZEdw6tKzj2x1ytJDz1LQC5rLumLIgHvhJfmC+pVFeaM30tbyYC0Vbx0bAz0I89lR0OGUjcWzuwx5DFUWXW+PUp6k=
Received: from BN6PR11CA0027.namprd11.prod.outlook.com (2603:10b6:404:4b::13)
 by DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 08:20:23 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:4b:cafe::ea) by BN6PR11CA0027.outlook.office365.com
 (2603:10b6:404:4b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29 via Frontend
 Transport; Tue, 21 Apr 2020 08:20:23 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2921.25 via Frontend Transport; Tue, 21 Apr 2020 08:20:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 21 Apr
 2020 03:20:22 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 21 Apr
 2020 03:20:21 -0500
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 21 Apr 2020 03:20:20 -0500
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <monk.liu@amd.com>
Subject: [PATCH] drm/amdgpu: only update spm vmid at first time
Date: Tue, 21 Apr 2020 16:20:18 +0800
Message-ID: <20200421082018.6972-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(428003)(46966005)(81166007)(4326008)(356005)(54906003)(7696005)(1076003)(70586007)(70206006)(36756003)(82740400003)(47076004)(6636002)(8676002)(2616005)(81156014)(26005)(316002)(2906002)(186003)(5660300002)(336012)(478600001)(426003)(8936002)(15650500001)(110136005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 533975e8-ceed-4f5a-d1ef-08d7e5ccd654
X-MS-TrafficTypeDiagnostic: DM6PR12MB4515:
X-Microsoft-Antispam-PRVS: <DM6PR12MB451550F36125AD9CBE1D84D5E5D50@DM6PR12MB4515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-Forefront-PRVS: 038002787A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MYH7+rgkup86OqQ8eNWLKh7juMdqkH1uA/glm7CUjbKLc40G6ideJWjvY5o/o5JkiT4cfDL7c1g2p/YfML670Ufeg4nDoXgZheEA7QTTmTPI2YpDGH/cdWr8TUyIW4kZLNQJntlTHD0ghOfVMgGLQz/jZx4cuteS7Gqhk8FiKbGBh09AKZZ0uCdjlg2X0JqFgXAaNWepiRMQocHiL0aa/l5h+N1Fbiw+uDlvIR4rUeMmDmlywNqBRhKnA4oamA02oBuJuNFunEzwqkYIRXMWSAJeVYvXB+fiUDWd+sTuK1Jbsduv9BkN4+rLA1bh4x9XtStXpQutcibJAuH7CKU9olFEgo1PXiTimyPmdcFYUNwh80e78iJw4h2UVWRY27q48Dyt3rTCZIYZwxoVgaSkvIg5V6bIYfspQIPhpr0an4ZDzbJjUkY88iwluTxpMZMfv+XAKZ0gjoxr9x5VF5ba44enG5KRPr6fL8fT7ZJoH4QuZoeQRCbEd2f00cGnUpaCF668lvRTvFuQfDuPe0uEQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 08:20:22.7756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 533975e8-ceed-4f5a-d1ef-08d7e5ccd654
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515
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
Cc: amd-gfx@lists.freedesktop.org, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Original idea is from Monk which only update spm vmid
at first time which can release the frequent r/w register
burden under virtualization.

v2: set spm_vmid_updated to false when job timedout

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 35c381ec0423..3bf59dfef05d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -50,6 +50,9 @@ static void amdgpu_job_timedout(struct drm_sched_job *s_job)
 	DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
 		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
 
+	if (job->vm)
+		job->vm->spm_vmid_updated = false;
+
 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
 		amdgpu_device_gpu_recover(ring->adev, job);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index accbb34ea670..636a6d23fd96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1080,11 +1080,14 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	struct dma_fence *fence = NULL;
 	bool pasid_mapping_needed = false;
 	unsigned patch_offset = 0;
-	bool update_spm_vmid_needed = (job->vm && (job->vm->reserved_vmid[vmhub] != NULL));
+	bool update_spm_vmid_needed = (job->vm && (job->vm->reserved_vmid[vmhub] != NULL) &&
+				       !job->vm->spm_vmid_updated);
 	int r;
 
-	if (update_spm_vmid_needed && adev->gfx.rlc.funcs->update_spm_vmid)
+	if (update_spm_vmid_needed && adev->gfx.rlc.funcs->update_spm_vmid) {
 		adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
+		job->vm->spm_vmid_updated = true;
+	}
 
 	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
 		gds_switch_needed = true;
@@ -2797,6 +2800,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	int r, i;
 
 	vm->va = RB_ROOT_CACHED;
+	vm->spm_vmid_updated = false;
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		vm->reserved_vmid[i] = NULL;
 	INIT_LIST_HEAD(&vm->evicted);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ea771d84bf2b..02409e0ecf2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -319,6 +319,8 @@ struct amdgpu_vm {
 	bool			bulk_moveable;
 	/* Flag to indicate if VM is used for compute */
 	bool			is_compute_context;
+	/* flag to represent whether spm vmid has been updated */
+	bool			spm_vmid_updated;
 };
 
 struct amdgpu_vm_manager {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
