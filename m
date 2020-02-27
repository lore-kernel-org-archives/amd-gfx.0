Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55938C4BA24
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 12:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2022124695
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 12:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eX54IbnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2022124695
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA5A6EC97;
	Thu, 27 Feb 2020 12:46:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A73C36EC97
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 12:46:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYK4hgy0lo9d/L80EGoycn0NV9b8gkpb/3NMgk1q0+xs4du6/dJjoCUeLHqskFrX+5ihYC6bPvqjk+5WKbTXRrrOQFgXya2mOOwa6ua1SSByktq74E050hoPRpWUJP0mma3FnlC7NztDgPjb9GwQ5edp0AfDSMpgifYFDcCc5fBcQ81dMo+ALC97PuINjqknqmLz+vnqqpnoBLfB/1HI0AKjZrd6+FMA5dB40Okq1P9drNjCi0NhFMymQ6uoP1FTWrQGE6U/xGOhruUbCZh0Zs1xMVHxCJAX4u0IAHuQySDQAYWrcO28tVvLZZDq82CFwTq8BHnMS7Fh4Lkxwzupbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzRVsqB4414JK6A1G5RP8IxrzsWZO21lG2QK3vqULjE=;
 b=ZZqGFtOVrIVZ8tFDB9fcMw9DB036kGR8L4cN1UY5Ws/dGOrIDUxI4BRAH4we3ervt+H5fXfj/+w0ZF3sHlufCissrzHWprZTg4ExNJLRBVHbZ8KBIO63NmRjTImLBsfXY+2sKbfkTYVTNPMn4Xf8HuzYu+kZ5TlcGiEdTlprsykPE97H2JI7FC4p8XlmKfEwjckVvao3SC8K/DZ1mF+ryj6xKxON+xmvM+V/6r5vbOjGb2yiSJ1/3lafqX8CMXri1exVbaYDBBm0buYwpqvA2AANp61nXKLXD2zS47gGTpedNVBmOLJkebOAZ0ZpWCOY5Ej4gGAMU6dNAPl5kVk5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzRVsqB4414JK6A1G5RP8IxrzsWZO21lG2QK3vqULjE=;
 b=eX54IbnE3cpGOfLTulXJ0Sm6xJEuI8+8Z1UXAm6xFyDYWSJFqS3QxnyxLjxg5llUbUGjlamAE7u4BvVZ7ZPaLna1/QUEwWohDA2rNu5RQEqVYFKZcilPV9JSLOy6ajQnHqokEJ78Ptms3QspvNSiXMLkq9U0WaKkl8nosyXaPXs=
Received: from DM3PR08CA0024.namprd08.prod.outlook.com (2603:10b6:0:52::34) by
 DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 27 Feb 2020 12:46:45 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::7) by DM3PR08CA0024.outlook.office365.com
 (2603:10b6:0:52::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Thu, 27 Feb 2020 12:46:45 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 12:46:44 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 27 Feb
 2020 06:46:44 -0600
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 27 Feb 2020 06:46:42 -0600
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: no need to clean debugfs at amdgpu
Date: Thu, 27 Feb 2020 20:46:41 +0800
Message-ID: <20200227124641.1412-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(428003)(199004)(189003)(7696005)(426003)(6636002)(54906003)(2616005)(70586007)(70206006)(356004)(1076003)(2906002)(5660300002)(110136005)(36756003)(4326008)(478600001)(186003)(8676002)(26005)(336012)(316002)(81156014)(8936002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3865; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fda77b9-6cdb-4f37-d223-08d7bb831a18
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3865400FF43AB91BFCE1CD2AE5EB0@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 03264AEA72
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oIJEg+ze3lwyB8OuW3m/aOfUQvo1f35WcZhcn6jroQu7H/ISjlahCaoz+8LX9xC376oTFiz3b1cwB1rBoyH0eHF0ezkdLzYsRFuCBa/WxKk8y7JfbXhOBlsKru/j9ZjEmeyuvapQbWRHwKUcqDAnRWgwaXFoJFurDI3y5Py0I/CgXMoCvYv2rKUm7c2UKk4iWwMa2JGhoScDdmgE+1s4jW8UVpYW0majVSWjUDpqXpcEnCrO10JPkY0n4ffBNjJP6No33xFJ4t4s4HCv4+z8wI6sXuIrFxzU+U6Tzc1AWBixm7yNd11n4gyblisX8OGSszFcGU7F1ikbhzMHh+mJrGjQIURHeWPTZdFe0DtClWSvT9e+CMHjfrZnf5NSC05WkOZgJ1PxQNxkNFCUWOW2f9KD84N/gTtzUPQewaK3qAs+KlmEuYTrZoFGvuxBOk0i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 12:46:44.8299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fda77b9-6cdb-4f37-d223-08d7bb831a18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3865
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

drm_minor_unregister will invoke drm_debugfs_cleanup
to clean all the child node under primary minor node.
We don't need to invoke amdgpu_debugfs_fini and
amdgpu_debugfs_regs_cleanup to clean agian.
Otherwise, it will raise the NULL pointer like below.
[   45.046029] BUG: unable to handle kernel NULL pointer dereference at 00000000000000a8
[   45.047256] PGD 0 P4D 0
[   45.047713] Oops: 0002 [#1] SMP PTI
[   45.048198] CPU: 0 PID: 2796 Comm: modprobe Tainted: G        W  OE     4.18.0-15-generic #16~18.04.1-Ubuntu
[   45.049538] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   45.050651] RIP: 0010:down_write+0x1f/0x40
[   45.051194] Code: 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 53 48 89 fb e8 ce d9 ff ff 48 ba 01 00 00 00 ff ff ff ff 48 89 d8 <f0> 48 0f c1 10 85 d2 74 05 e8 53 1c ff ff 65 48 8b 04 25 00 5c 01
[   45.053702] RSP: 0018:ffffad8f4133fd40 EFLAGS: 00010246
[   45.054384] RAX: 00000000000000a8 RBX: 00000000000000a8 RCX: ffffa011327dd814
[   45.055349] RDX: ffffffff00000001 RSI: 0000000000000001 RDI: 00000000000000a8
[   45.056346] RBP: ffffad8f4133fd48 R08: 0000000000000000 R09: ffffffffc0690a00
[   45.057326] R10: ffffad8f4133fd58 R11: 0000000000000001 R12: ffffa0113cff0300
[   45.058266] R13: ffffa0113c0a0000 R14: ffffffffc0c02a10 R15: ffffa0113e5c7860
[   45.059221] FS:  00007f60d46f9540(0000) GS:ffffa0113fc00000(0000) knlGS:0000000000000000
[   45.060809] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   45.061826] CR2: 00000000000000a8 CR3: 0000000136250004 CR4: 00000000003606f0
[   45.062913] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   45.064404] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   45.065897] Call Trace:
[   45.066426]  debugfs_remove+0x36/0xa0
[   45.067131]  amdgpu_debugfs_ring_fini+0x15/0x20 [amdgpu]
[   45.068019]  amdgpu_debugfs_fini+0x2c/0x50 [amdgpu]
[   45.068756]  amdgpu_pci_remove+0x49/0x70 [amdgpu]
[   45.069439]  pci_device_remove+0x3e/0xc0
[   45.070037]  device_release_driver_internal+0x18a/0x260
[   45.070842]  driver_detach+0x3f/0x80
[   45.071325]  bus_remove_driver+0x59/0xd0
[   45.071850]  driver_unregister+0x2c/0x40
[   45.072377]  pci_unregister_driver+0x22/0xa0
[   45.073043]  amdgpu_exit+0x15/0x57c [amdgpu]
[   45.073683]  __x64_sys_delete_module+0x146/0x280
[   45.074369]  do_syscall_64+0x5a/0x120
[   45.074916]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

v2: remove all debugfs cleanup/fini code at amdgpu

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 30 ---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  7 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 10 -------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 -
 7 files changed, 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 3bb74056b9d2..abc148280ba5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -992,18 +992,6 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-void amdgpu_debugfs_regs_cleanup(struct amdgpu_device *adev)
-{
-	unsigned i;
-
-	for (i = 0; i < ARRAY_SIZE(debugfs_regs); i++) {
-		if (adev->debugfs_regs[i]) {
-			debugfs_remove(adev->debugfs_regs[i]);
-			adev->debugfs_regs[i] = NULL;
-		}
-	}
-}
-
 static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 {
 	struct drm_info_node *node = (struct drm_info_node *) m->private;
@@ -1339,31 +1327,13 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 					ARRAY_SIZE(amdgpu_debugfs_list));
 }
 
-void amdgpu_debugfs_fini(struct amdgpu_device *adev)
-{
-	int i;
-
-	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
-		struct amdgpu_ring *ring = adev->rings[i];
-
-		if (!ring)
-			continue;
-
-		amdgpu_debugfs_ring_fini(ring);
-	}
-	amdgpu_ttm_debugfs_fini(adev);
-	debugfs_remove(adev->debugfs_preempt);
-}
-
 #else
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
 	return 0;
 }
-void amdgpu_debugfs_fini(struct amdgpu_device *adev) { }
 int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
 {
 	return 0;
 }
-void amdgpu_debugfs_regs_cleanup(struct amdgpu_device *adev) { }
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
index b382527e359a..de12d1101526 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
@@ -32,7 +32,6 @@ struct amdgpu_debugfs {
 };
 
 int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
-void amdgpu_debugfs_regs_cleanup(struct amdgpu_device *adev);
 int amdgpu_debugfs_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_fini(struct amdgpu_device *adev);
 int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8ef8a49b9255..351096ab4301 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3237,7 +3237,6 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 	adev->rmmio = NULL;
 	amdgpu_device_doorbell_fini(adev);
 
-	amdgpu_debugfs_regs_cleanup(adev);
 	device_remove_file(adev->dev, &dev_attr_pcie_replay_count);
 	if (adev->ucode_sysfs_en)
 		amdgpu_ucode_sysfs_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7cf5f597b90a..02d80b9dbfe1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1139,7 +1139,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 		DRM_ERROR("Hotplug removal is not supported\n");
 	drm_dev_unplug(dev);
 	drm_dev_put(dev);
-	amdgpu_debugfs_fini(adev);
 	amdgpu_driver_unload_kms(dev);
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 18e11b0fdc3e..ca6b52054b4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -499,13 +499,6 @@ int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 	return 0;
 }
 
-void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring)
-{
-#if defined(CONFIG_DEBUG_FS)
-	debugfs_remove(ring->ent);
-#endif
-}
-
 /**
  * amdgpu_ring_test_helper - tests ring and set sched readiness status
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 660867cf2597..1947a326de57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2571,13 +2571,3 @@ int amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
 	return 0;
 #endif
 }
-
-void amdgpu_ttm_debugfs_fini(struct amdgpu_device *adev)
-{
-#if defined(CONFIG_DEBUG_FS)
-	unsigned i;
-
-	for (i = 0; i < ARRAY_SIZE(ttm_debugfs_entries); i++)
-		debugfs_remove(adev->mman.debugfs_entries[i]);
-#endif
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 2c4ad5b589d0..dc6502d1060b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -134,6 +134,5 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
 				 struct ttm_mem_reg *mem);
 
 int amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
-void amdgpu_ttm_debugfs_fini(struct amdgpu_device *adev);
 
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
