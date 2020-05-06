Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3C0C28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 09:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B3C2082E
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 09:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZFu69pJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B3C2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 115A989BB0;
	Wed,  6 May 2020 09:36:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 163AF89BB0
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 09:36:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JytjEzFBScf5z51zlvtu0uVQHQQg6fUJvIYlk+C5iyFFANSwU0vQTfyR63LmSYLAD0EmvM/QZO/lR9Z2/KMBHQvd8vCPEopK5DQP2i38CrBYLB34odxCTgXhHnESw2KGo9UGVt+XACiEBvmCyxhYB7n4D6nqj7MS1Ye4aXgdSd5LV7RHgFT/MFji6R7Xf8vyXFvKlsAgZ1sLuXStKk3L0vSv92QrcPiFAzz4FmexspCC5EEkHkxi/2xSFHq4qz6VNsleRfuprvDOmrP7Bhe8h00O7Mv06DD2g+Xxg/Kn9DEVj2Jdw7w4ORNe1iYdnTEu+kO0Fu28BXKXgz9qWSDSqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZWKJh8QdCHP7EIWHuiN5J6WlQdEZoabU0gbK4b7CC0=;
 b=QLpYdLZ9/kOSS4z3UzJgGUimCTqjGuBKHGSBZnAl9mO95GK4T95IYnXwdh5CZdvIrMV3NiRHfoO9Rw9yO5b8GBf4fUq2OUDqGmt3yenyRNq6eSCO8V4TInJ7C2rd/NK9yJTQ2COZ3DQmMS9RFZBIffqvoYuVovaA+vsODHXSPw/BGgtxm0Bpy49SCKZCqAAxhK9MhVPuefh02g312xC7NNYvWbGUkgTrJEqJVnLyd1qgTEJvkRDxLaO1ucT0i1zGRWfpagaOs5YTaIgeq54NCCm9c+FSvViUrVZAjmgE+bTaeoFTlixqsKMoY60rFQBtobR1oFW9ngz2sLl5JfmFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZWKJh8QdCHP7EIWHuiN5J6WlQdEZoabU0gbK4b7CC0=;
 b=ZFu69pJ5eSNLUwRMZt1reVgELJxSjAFWiMO3V2yAq/euYSkVBlSsEJsVySopgmQAF4uwOK7OjxE60n3sP1rwv++mOWGNQ24sX76CkJjfPIegR3DqDpYfIbL/3u1Uoc4+ZHg4SF/PszHhqLA2n2NvO2WvgTYhX8pyKeyT46Fz1RE=
Received: from DM5PR22CA0004.namprd22.prod.outlook.com (2603:10b6:3:101::14)
 by CY4PR1201MB0070.namprd12.prod.outlook.com (2603:10b6:910:18::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Wed, 6 May
 2020 09:36:31 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::77) by DM5PR22CA0004.outlook.office365.com
 (2603:10b6:3:101::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Wed, 6 May 2020 09:36:31 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2979.27 via Frontend Transport; Wed, 6 May 2020 09:36:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 May 2020
 04:36:29 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 May 2020
 04:36:29 -0500
Received: from gamma.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 6 May 2020 04:36:27 -0500
From: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: avoid clearing freed bo with sdma in gpu reset
Date: Wed, 6 May 2020 17:36:26 +0800
Message-ID: <20200506093626.13501-1-Tiecheng.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39850400004)(396003)(346002)(136003)(46966005)(33430700001)(426003)(478600001)(4326008)(8936002)(36756003)(86362001)(2906002)(8676002)(6916009)(70206006)(26005)(316002)(70586007)(336012)(82310400002)(81166007)(356005)(33440700001)(7696005)(82740400003)(1076003)(186003)(5660300002)(47076004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 632106e3-fca3-429e-94a8-08d7f1a0f522
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0070:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0070859E768772C3FFC93FBCE4A40@CY4PR1201MB0070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2rL3lmpNK9KJZDCmMC60vYJ6HIjvH/qkUrLLL03l6MlshPmdvltoTcTX4Ma4j9koD93ZJ7+3dXpogNINVWv1ks7PpPj3MPDGJiTGvWz03Vl6V2RjYmu4ju8F4gywwMWZLV6WYWcOLqXgZDYXru4uo9FmB9xfXYhpuhsTr4mzLXr7WACCSbZFyxqFBS2+6NcC/zVAS66VM8vv/DGLw7JQn2jnhI2ACzRrzo/l29pQ6VRhrKTXiwEmvXtElINE2dR9BExhEmnEXQpZiL8nZGOpRo6Ghi3GhIwOcabPOA6HcW3MVIBogcrOCqYybGui/oMB47pGQc1vPy7l4LbFhDv7WEsSEaDirdJwAaLb+I9NRH4lxdFnj7a3YUmxJiq+iUX3mH52mK3kv1XePEhFIUxCeDOJzzORJopFBGSloHGIIPITZMhnzgsX7BtkeTTsrdi96LoHQS67gv7aJTw7Q0wLiHu2fZ7r8zUTZQNnm6n2kThM3DjdnCpg5tsRLSsKz8MnZy6/ml8/6EXIMNpwHjg88+dbgoxJ/Li8Tbrwb8GbjvJVvJ3VD/LbLuOELhcAMxc4a6ZPruCrOH20gsIefNBAGw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 09:36:30.5060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 632106e3-fca3-429e-94a8-08d7f1a0f522
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0070
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
Cc: Tiecheng.Zhou@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WHY:
For V320 passthrough and "modprobe amdgpu lockup_timeout=500", there will be
kernel NULL pointer when using quark ~ BACO reset, for instance:
  hang_vm_compute0_bad_cs_dispatch.lua
  hang_vm_dma0_corrupted_header.lua
  etc.
-----------------------------
[  884.792885] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring comp_1.0.0 timeout, signaled seq=3, emitted seq=4
[  884.793772] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process quark pid 16939 thread quark pid 16940
[  884.859979] amdgpu: [powerplay] set virtualization GFX DPM policy success
[  884.861003] amdgpu: [powerplay] activate virtualization GFX DPM policy success
[  884.861065] amdgpu: [powerplay] set virtualization VCE DPM policy success
[  885.693554] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
[  885.694682] [drm] schedpage0 is not ready, skipping
[  885.694682] [drm] schedpage1 is not ready, skipping
[  885.694720] [drm:amdgpu_gem_va_ioctl [amdgpu]] *ERROR* Couldn't update BO_VA (-2)
[  885.695328] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
[  885.695909] PGD 0 P4D 0
[  885.696104] Oops: 0000 [#1] SMP PTI
[  885.696368] CPU: 2 PID: 16940 Comm: quark Tainted: G           OE     4.19.52+ #6
[  885.696945] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  885.697593] RIP: 0010:amdgpu_vm_sdma_commit+0x59/0x130 [amdgpu]
...
[  885.705042] Call Trace:
[  885.705251]  ? amdgpu_vm_bo_update_mapping+0xdf/0xf0 [amdgpu]
[  885.705696]  ? amdgpu_vm_clear_freed+0xcc/0x1b0 [amdgpu]
[  885.706112]  ? amdgpu_gem_va_ioctl+0x4a1/0x510 [amdgpu]
[  885.706493]  ? __radix_tree_delete+0x7e/0xa0
[  885.706822]  ? amdgpu_gem_va_map_flags+0x70/0x70 [amdgpu]
[  885.707220]  ? drm_ioctl_kernel+0xaa/0xf0 [drm]
[  885.707568]  ? amdgpu_gem_va_map_flags+0x70/0x70 [amdgpu]
[  885.707962]  ? drm_ioctl_kernel+0xaa/0xf0 [drm]
[  885.708294]  ? drm_ioctl+0x3a7/0x3f0 [drm]
[  885.708632]  ? amdgpu_gem_va_map_flags+0x70/0x70 [amdgpu]
[  885.709032]  ? unmap_region+0xd9/0x120
[  885.709328]  ? amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
[  885.709684]  ? do_vfs_ioctl+0xa1/0x620
[  885.709971]  ? do_munmap+0x32e/0x430
[  885.710232]  ? ksys_ioctl+0x66/0x70
[  885.710513]  ? __x64_sys_ioctl+0x16/0x20
[  885.710806]  ? do_syscall_64+0x55/0x100
[  885.711092]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
...
[  885.719408] ---[ end trace 7ee3180f42e9f572 ]---
[  885.719766] RIP: 0010:amdgpu_vm_sdma_commit+0x59/0x130 [amdgpu]
...
-----------------------------

the NULL pointer (entity->rq == NULL in amdgpu_vm_sdma_commit()) as follows:
1. quark sends bad job that triggers job timeout;
2. guest KMD detects the job timeout and goes to gpu recovery, and it goes to
   ip_suspend for SDMA, and it sets sdma[].sched.ready to false;
3. quark sends UNMAP operation through amdgpu_gem_va_ioctl, and guest KMD goes
   through amdgpu_gem_va_update_vm and finally goes to amdgpu_vm_sdma_commit,
   it goes to amdgpu_job_submit to drm_sched_job_init
4. drm_sched_job_init fails at drm_sched_pick_best() since
   sdma[].sched.ready is set to false; in the meanwhile entity->rq becomes NULL;
5. quark sends other UNMAP operations through amdgpu_gem_va_ioctl, while this time
   there will be NULL pointer because entity->rq is NULL;

the above sequence occurs only when "modprobe amdgpu lockup_timeout=500".
it does not occur when lockup_timeout=10000 (default) because step 2. KMD detects
job timeout will be sometime after quark sends UNMAP operations; i.e. quark UNMAP
opeartions are finished before sdma ip suspend.

HOW:
here is to add mutex_lock to wait to avoid using sdma during gpu reset.

Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index e205ecc75a21..018b88f3b6da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2047,6 +2047,8 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 	struct dma_fence *f = NULL;
 	int r;
 
+	mutex_lock(&adev->lock_reset);
+
 	while (!list_empty(&vm->freed)) {
 		mapping = list_first_entry(&vm->freed,
 			struct amdgpu_bo_va_mapping, list);
@@ -2062,6 +2064,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
+			mutex_unlock(&adev->lock_reset);
 			return r;
 		}
 	}
@@ -2073,6 +2076,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		dma_fence_put(f);
 	}
 
+	mutex_unlock(&adev->lock_reset);
 	return 0;
 
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
