Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E9CC4BA3B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 11:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFD5024692
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 11:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OXm3A8v3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD5024692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB34D6E85D;
	Thu, 27 Feb 2020 11:58:15 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680048.outbound.protection.outlook.com [40.107.68.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64CF86E859
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 11:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2xvKFXeCozWpXUsnMrCwX/d8mo8efz6eRwOccFhcQR3aezd+MJFUQsg8TNncM7WH9rWARQKHRlz4yZqI0VO+W90vP670x9UuQnL7taPreh3SQANTzMClV1f30DJvinbpaL29HHk+IsonhLAVSTIOLqJrV1Z3jbeh3fnCvhdx0Sg+Vb2yAmWG/Nall6hBXiewc7j691JOiyc8QzTIO9R0+APtJ0FgbWjTxYMHpbgyKL2wHZnTJ5s4UYpOZQaNoqVEbwUpx7GyAiMbslM7TTq08rEeN5Du68WKrbcVp9c5BlLlc79342UcSELX5XnQTO5QXSi8EzdZ53fxrgFmh8GKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ir2eYZC5JSAV3jhLO0DsBu5gRf61hw3jHD866wnNS0=;
 b=ngEovuoPhUXdzFV0ur5prkmWifflq9fRs0bOTRybAVzj8nWU2HY0+fahtSqniBcM9pF61YyTCTefcsITvp3nwFe2vMdyY8GzAHQGSMhDFbvt+YRLZz/MSJKkRsfpkJAqs6hKVzi/8kCvvGLFd1icyXga+eK7plalmQhxnanH1Q66yHD6jNkBwt1ersVO9bozkBDB2SERUmK6YxXm7B3AliSEMWK5+ajv2HHgE9kx+QsZ/IIYpNeOk5HqhY5cjMpXstX+zlFTUxRPKIb8ECgpjkywlhCenv+wPNqbB4kAeESLIb6YUXuKnjXiiU5PPjO5oIbHSxVd+A9RMRU/i7xYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ir2eYZC5JSAV3jhLO0DsBu5gRf61hw3jHD866wnNS0=;
 b=OXm3A8v3Yz9VESdRFs3BiEr/A9ujisrZ9Cwvfe/nCIBvAXaPSzTv5z/AMY1GHp7mE/bDf5Roh8Hvsp+H6kk/JMZPOnsfZEdwVvzQs4MXiRg7t51VWez8aTFYPW2jmTnG32cZQQ6c2pNhQY20l9Vbj0aP6ezwD05z8Fbb2ePqLjU=
Received: from BN6PR16CA0002.namprd16.prod.outlook.com (2603:10b6:404:f5::12)
 by BY5PR12MB3906.namprd12.prod.outlook.com (2603:10b6:a03:1a9::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Thu, 27 Feb
 2020 11:58:11 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::d9) by BN6PR16CA0002.outlook.office365.com
 (2603:10b6:404:f5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Thu, 27 Feb 2020 11:58:10 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 11:58:10 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 27 Feb
 2020 05:58:10 -0600
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 27 Feb 2020 05:58:08 -0600
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: release drm_device after amdgpu_driver_unload_kms
Date: Thu, 27 Feb 2020 19:58:07 +0800
Message-ID: <20200227115807.32698-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(428003)(199004)(189003)(5660300002)(4326008)(70206006)(7696005)(70586007)(45080400002)(1076003)(478600001)(36756003)(2616005)(426003)(26005)(336012)(186003)(356004)(2906002)(8676002)(54906003)(316002)(81156014)(110136005)(8936002)(6636002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3906; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9711e557-19d5-4aaa-16e7-08d7bb7c510f
X-MS-TrafficTypeDiagnostic: BY5PR12MB3906:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3906D69D1768C27DE68E97D8E5EB0@BY5PR12MB3906.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 03264AEA72
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjTUtATAk4HwSTj02+oJymlh999o4vhMY1D0sK/HifesVJ6QEl0Fo/YbjDu0j81eUEChukk5otQjOz7IJuCifXk4SYvTWxFuMiU28GFfF8Wke2HK7RAGlwWwIAaTCkQqKmv+a4NXVPRyJrBNmbekBmdypwSgJrtG8RGuHEyZ2mn00F/+Lr3VlS34maDm4lenMjTEUZMQxsdVWaeeMWj+h8oC9KCngf/cmJbddPdA8rR4gyn2tujmuGroQzR2TnYMNhef2OSATvrFguc43UP66Sx+zPlwCsiVYoKZp3CSv6cD7ROk8WD5pItDZgPd1QTxNE805Cv8ygU9wLjWLBrmw+3iWLjX2hzuFhQON6ofK6qQK6CyuLDdF+jqHl+MJanboFBDDk/Y7rFCvCmGmakiq5hNqTyfWIKgwUytMNzpj1LI6a3yeS4Tf8dU862svSsh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 11:58:10.6066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9711e557-19d5-4aaa-16e7-08d7bb7c510f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3906
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

If we release drm_device before amdgpu_driver_unload_kms,
then it will raise the error below. Therefore, we need to
place it before amdgpu_driver_unload_kms.
[   43.055736] Memory manager not clean during takedown.
[   43.055777] WARNING: CPU: 1 PID: 2807 at /build/linux-hwe-9KJ07q/linux-hwe-4.18.0/drivers/gpu/drm/drm_mm.c:913 drm_mm_takedown+0x24/0x30 [drm]
[   43.055778] Modules linked in: amdgpu(OE-) amd_sched(OE) amdttm(OE) amdkcl(OE) amd_iommu_v2 drm_kms_helper drm i2c_algo_bit fb_sys_fops syscopyarea sysfillrect sysimgblt snd_hda_codec_generic nfit kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep snd_pcm ghash_clmulni_intel snd_seq_midi snd_seq_midi_event pcbc snd_rawmidi snd_seq snd_seq_device aesni_intel snd_timer joydev aes_x86_64 crypto_simd cryptd glue_helper snd soundcore input_leds mac_hid serio_raw qemu_fw_cfg binfmt_misc sch_fq_codel nfsd auth_rpcgss nfs_acl lockd grace sunrpc parport_pc ppdev lp parport ip_tables x_tables autofs4 hid_generic floppy usbhid psmouse hid i2c_piix4 e1000 pata_acpi
[   43.055819] CPU: 1 PID: 2807 Comm: modprobe Tainted: G           OE     4.18.0-15-generic #16~18.04.1-Ubuntu
[   43.055820] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   43.055830] RIP: 0010:drm_mm_takedown+0x24/0x30 [drm]
[   43.055831] Code: 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 47 38 48 83 c7 38 48 39 c7 75 02 f3 c3 55 48 c7 c7 38 33 80 c0 48 89 e5 e8 1c 41 ec d0 <0f> 0b 5d c3 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41
[   43.055857] RSP: 0018:ffffae33c1393d28 EFLAGS: 00010286
[   43.055859] RAX: 0000000000000000 RBX: ffff9651b4a29800 RCX: 0000000000000006
[   43.055860] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff9651bfc964b0
[   43.055861] RBP: ffffae33c1393d28 R08: 00000000000002a6 R09: 0000000000000004
[   43.055861] R10: ffffae33c1393d20 R11: 0000000000000001 R12: ffff9651ba6cb000
[   43.055863] R13: ffff9651b7f40000 R14: ffffffffc0de3a10 R15: ffff9651ba5c6460
[   43.055864] FS:  00007f1d3c08d540(0000) GS:ffff9651bfc80000(0000) knlGS:0000000000000000
[   43.055865] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.055866] CR2: 00005630a5831640 CR3: 000000012e274004 CR4: 00000000003606e0
[   43.055870] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   43.055871] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   43.055871] Call Trace:
[   43.055885]  drm_vma_offset_manager_destroy+0x1b/0x30 [drm]
[   43.055894]  drm_gem_destroy+0x19/0x40 [drm]
[   43.055903]  drm_dev_fini+0x7f/0x90 [drm]
[   43.055911]  drm_dev_release+0x2b/0x40 [drm]
[   43.055919]  drm_dev_unplug+0x64/0x80 [drm]
[   43.055994]  amdgpu_pci_remove+0x39/0x70 [amdgpu]
[   43.055998]  pci_device_remove+0x3e/0xc0
[   43.056001]  device_release_driver_internal+0x18a/0x260
[   43.056003]  driver_detach+0x3f/0x80
[   43.056004]  bus_remove_driver+0x59/0xd0
[   43.056006]  driver_unregister+0x2c/0x40
[   43.056008]  pci_unregister_driver+0x22/0xa0
[   43.056087]  amdgpu_exit+0x15/0x57c [amdgpu]
[   43.056090]  __x64_sys_delete_module+0x146/0x280
[   43.056094]  do_syscall_64+0x5a/0x120

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 02d80b9dbfe1..01a1082b5cab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1138,8 +1138,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 #endif
 		DRM_ERROR("Hotplug removal is not supported\n");
 	drm_dev_unplug(dev);
-	drm_dev_put(dev);
 	amdgpu_driver_unload_kms(dev);
+	drm_dev_put(dev);
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
