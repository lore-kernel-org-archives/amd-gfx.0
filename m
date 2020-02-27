Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E01C4BA3B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 11:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2950A24693
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 11:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TIus5X6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2950A24693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C522189E2A;
	Thu, 27 Feb 2020 11:50:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E052E89E2A
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 11:50:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZ7ZPD/GWJEi6VD1VHgRAqx2q8l63xGh2X5bpV9cmfQPxX/I9mt3Yj+Av0nZhJLsMKnSpWtmwbU2zxUx0HgsO9LV212CfLMN1QGzfoX9tlGV4Af4WevUFWr7MzvFgjm8YOUztITQLpfCF/Y1tXooNWOuYcBQiC4kTT+cYKeduC5tgHc6b6xydDsehB0s03i0z0BRaCriMIzgxXuZiIJV3KABMES93oAaNpHRk/w54SlS9V/Ky6tvkQVufXdqXt+2Qw5sBKjFYJsyftKDHK+tyltHdovVF81oyHwc1KWEJXpEMK5lO/kGjSOPST+jgmYT0+n2XDV13MPD9umhQdAKVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVpLQ3kRJaKicqOgv4ECBfHW0DAn/62fCiONoMfgNGo=;
 b=ZIRoh6dZ6oRlgeUaOUaRiWhvoKP3ugcr6U0Waknm0XYadAEm/+acRIAwgaVOXishCPQ8UkfR2pRmuowGP+tq8rXNDCbfGs6ytnjRifPK5DpFVNyjVIobaJ3rZVtk4SYa9j3qC/IZEP57+Uuh1dwl2Fi8Wkue3VHezl7UhywimJ6EUTcgj3CqfxWanx6uZf7fJzyr+CDwAkJBRdC/Lf7Af/PPuLHeK+CB5/psZ77l7QvAMVa6bQMP6HIh3Tx3LxIPvhkCE1OjvhA7R08WH2BlCeaKEYd3dkakCwPJ+Wy2QIz15Fsjssw3TZVXcg9tftOz59jgFl/Q7Y+fMmvrONwPlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVpLQ3kRJaKicqOgv4ECBfHW0DAn/62fCiONoMfgNGo=;
 b=TIus5X6KnmETC/O2bxle1nLYwaoyj/TeYJYkEMyqUwGme65A5T/d8Ig/VLVt+sL19eT6gQKIQHQq1bpVg7DTSaKOvKtBGmzOnXb3mmGSxjmu97Dc4oRx0TwdCI2tj+gYNRCjWmh53rar1UFJnZT74QIN6TzyRs6dzXJjQK0LETg=
Received: from MWHPR20CA0011.namprd20.prod.outlook.com (2603:10b6:300:13d::21)
 by BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 11:50:45 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::45) by MWHPR20CA0011.outlook.office365.com
 (2603:10b6:300:13d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Thu, 27 Feb 2020 11:50:44 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 11:50:44 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 27 Feb
 2020 05:50:43 -0600
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 27 Feb 2020 05:50:42 -0600
From: Yintian Tao <yttao@amd.com>
To: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: no need to clean debugfs at amdgpu
Date: Thu, 27 Feb 2020 19:50:40 +0800
Message-ID: <20200227115040.32447-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(396003)(428003)(199004)(189003)(478600001)(1076003)(8936002)(316002)(5660300002)(2616005)(426003)(336012)(70586007)(70206006)(4326008)(7696005)(186003)(81166006)(356004)(81156014)(6636002)(36756003)(110136005)(54906003)(2906002)(8676002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3827; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 658681ad-af29-42fb-19b1-08d7bb7b4749
X-MS-TrafficTypeDiagnostic: BY5PR12MB3827:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3827AEC9EDA09714893D4408E5EB0@BY5PR12MB3827.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 03264AEA72
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVlPmvlVwK6rbgD/cxWiheePWSd3TDpyVB4zeP3MhmcIbguPL0nWRIHq5QT1GttlWTSImAHmTSk+xsyJBQOMoenXYUdq39nS47hxTn1rtTJLurQ2b/TzLOIec6h8pm7OTA1unLLWvm9YEDP75npI6CRowetlX2MEfVJkPesJHofVbijK94x3+lWWP+EHTfqU009sUbcWJDLma+JFRp0dBDl6xVxR6QuzSKsxaH8Z5nQwBTkl9q17fdRFq3xrihE+1yjx6/TjFY344dPFAmdf8bQ53bzBuIpcIqfjMs7qhQD3uH1q2yhqMSaO3QGDZh9nKn266kOcsxC95iJOcXqy4sCX8aRSOyRS+QwMEmpvSW2wlkJ2dX8UsWXwnaxmPinsDnfNRfPAQIGfBXTt6ueUzCHYZoNrH2AMKHyteXYfNOueQ1n5ubc9/z/N6gVj7ndY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 11:50:44.5960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 658681ad-af29-42fb-19b1-08d7bb7b4749
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3827
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

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 1 -
 2 files changed, 2 deletions(-)

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
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
