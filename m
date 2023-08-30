Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40D1C83F14
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Aug 2023 20:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32FF610E5AB;
	Wed, 30 Aug 2023 20:01:35 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8705910E5AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Aug 2023 20:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2tUJBVpRuBHejX69EgX/2O8P/H/tCJuWP4e4awAjGEmffoLOAMJb9HkyLP6qUr/VeXT/R1PN+TFBeAxNUo07XllMTOQoyPeygQEnC0a7ycpWA4ID0gMQ8YK0nDY21mM/I5kXcyk5oDKOfrU9MphVW+kZVdgp1/Ac074txzPbnxSxVOb6WpAUvVpoD0UXziISebkcrzM/9zuBCzvhAt9C22RG9thuA2QX9B3oRBYLnrIEl3i0Z27/rnFL2W3wPlCf3UtvjfhKsw8yY5XMVWpTmfI/hvks9b51Ig/u3NTfdoI+BtSQytFPS6ncBdGRlDcX9sFlCsH2pp+WmkCQD+1yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3nW/EBxQ8ZRMOVkCoCqQdhv+OX1hiyKE2q9sAnDGOo=;
 b=dZQ8r1XXNoW163Fp6Dqim7A2AX+gKDNDpH5xjjr/NOg9S2i1GgKZo1MwpUmdEGimSDsX9aqD1AODN8MKTovExTHwvOdNwQkOzEVmHO9xHYmFSVA1nJnqeX8VolUL2cnYY1uF6HZMr8PDBuBw61L7dlQUlHz3/yh+4Hi1WjhTptNGNGlqThyPiFlFPM2tByBRy6Pbk0mY0OibCX36ZEFG/QvQ7VqTpVBC9NMkNK+rR1UIV0+kbRYTvO+YoFD297wb/jQIaT7iNLBO6Uem5Hvzhx3lGUqLttIMLPwRRBaiRp1ponHfGPDUfhMi3/a1MN1r3EhMq4prKwZ8cX6kWhQU1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3nW/EBxQ8ZRMOVkCoCqQdhv+OX1hiyKE2q9sAnDGOo=;
 b=ixhH2go/GOZpWN8aQIwEulGy4e7+PK0ELEPU7pZKaGHFhiyxy9VKpGB9BDux/I353s/UgFWWT20iMYb5gooBFnA5wPOAP7K0RrSkwJqGttKCFEUU0ErgR3uBFTxEwkpMRv+2k8GklTFnR3loml/ImlGsawiE8Ez7ExRUWtXb3T4=
Received: from MW4PR03CA0083.namprd03.prod.outlook.com (2603:10b6:303:b6::28)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 20:01:30 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:b6:cafe::71) by MW4PR03CA0083.outlook.office365.com
 (2603:10b6:303:b6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36 via Frontend
 Transport; Wed, 30 Aug 2023 20:01:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.2 via Frontend Transport; Wed, 30 Aug 2023 20:01:30 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 15:01:26 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCHv2] drm/amdkfd: Fix unaligned 64-bit doorbell warning
Date: Wed, 30 Aug 2023 16:01:05 -0400
Message-ID: <20230830200105.117601-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: f26e7941-d844-4bea-0f2a-08dba993e72f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JVsC2p5YOcRaHWVcjDZuW/EB6Yo4GqspxZr7hkYAWTj18EqjmN0wYqnP2sQNOFMINbiFzmS/3blEcv56xkG6yJ/V/Hpcfnjcrhs25ZUtey/+MSBGdepJiUW+t/+xTj+CNfDD68hFuOu6B2THMvF+n2+myb7odd4aoHIRL839j1jvA6A4ADat3mX4nZs2924F48WM/QDXb7AhdkDE9OLPObQ/YxevTjewNk5HTmwRYPcKC7f3SfQfqZ35lhni1lIWE2flqJKio1PmAjbg8pw/IzywFH+KVtCy/Eq6FsRmeoPkuquPcdPqMSdZZrbapo3PQTroliiKLU9dJCsl30bR8q3qQ3b+e21qafAxEsJnTvBWRecfH1xNRRQ1GL1luSXxJCIFZDXOa1UnqfSwp+YYaamdA8BlPeHqkpRWosu79UOP8Uzpuvg9oFpRguofJXh5hXibg5n381YVPRNXscCuZOfYTq2Xm8edM02uxeV8ShsM8aot6tq0f+iWN/BKG3wHq+oIyrUG12rcKeIV0wcfF8fhzttP915cF8im2waP0DghYdNyUzPvFaFNoL6/SXvfdz4CwfK+EG76XHm7FpBSVGXrX1O4+S4fKvN7WIpE/H2FZllUic3eMJZ3aAz9Daxo0UEruqs/CeoTn7c8v/4S4xLVIR9TW6Ic6R15oCaWJZyUXJUghbXvHqPhdCeLlam6cW+gQXvJA3x0J3RndmX/S6IFQVGkX+ecn4Jck+XsDY09EpGD2cETM0su1XChBil2yDGF5yi86XQDwF2Othc1DA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(186009)(82310400011)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(7696005)(6666004)(83380400001)(26005)(336012)(426003)(478600001)(16526019)(6916009)(8676002)(316002)(41300700001)(70586007)(4326008)(8936002)(5660300002)(54906003)(70206006)(2906002)(44832011)(36756003)(40460700003)(47076005)(86362001)(1076003)(40480700001)(2616005)(356005)(81166007)(36860700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 20:01:30.5402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f26e7941-d844-4bea-0f2a-08dba993e72f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch fixes the following unaligned 64-bit doorbell
warning seen when submitting packets on HIQ on GFX v9.4.3
by making the HIQ doorbell 64-bit aligned.
The warning is seen when GPU is loaded in any mode other
than SPX mode.

[  +0.000301] ------------[ cut here ]------------
[  +0.000003] Unaligned 64-bit doorbell
[  +0.000030] WARNING: /amdkfd/kfd_doorbell.c:339 write_kernel_doorbell64+0x72/0x80 [amdgpu]
[  +0.000003] RIP: 0010:write_kernel_doorbell64+0x72/0x80 [amdgpu]
[  +0.000004] RSP: 0018:ffffc90004287730 EFLAGS: 00010246
[  +0.000005] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  +0.000003] RDX: 0000000000000001 RSI: ffffffff82837c71 RDI: 00000000ffffffff
[  +0.000003] RBP: ffffc90004287748 R08: 0000000000000003 R09: 0000000000000001
[  +0.000002] R10: 000000000000001a R11: ffff88a034008198 R12: ffffc900013bd004
[  +0.000003] R13: 0000000000000008 R14: ffffc900042877b0 R15: 000000000000007f
[  +0.000003] FS:  00007fa8c7b62000(0000) GS:ffff889f88400000(0000) knlGS:0000000000000000
[  +0.000004] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000003] CR2: 000056111c45aaf0 CR3: 00000001414f2002 CR4: 0000000000770ee0
[  +0.000003] PKRU: 55555554
[  +0.000002] Call Trace:
[  +0.000004]  <TASK>
[  +0.000006]  kq_submit_packet+0x45/0x50 [amdgpu]
[  +0.000524]  pm_send_set_resources+0x7f/0xc0 [amdgpu]
[  +0.000500]  set_sched_resources+0xe4/0x160 [amdgpu]
[  +0.000503]  start_cpsch+0x1c5/0x2a0 [amdgpu]
[  +0.000497]  kgd2kfd_device_init.cold+0x816/0xb42 [amdgpu]
[  +0.000743]  amdgpu_amdkfd_device_init+0x15f/0x1f0 [amdgpu]
[  +0.000602]  amdgpu_device_init.cold+0x1813/0x2176 [amdgpu]
[  +0.000684]  ? pci_bus_read_config_word+0x4a/0x80
[  +0.000012]  ? do_pci_enable_device+0xdc/0x110
[  +0.000008]  amdgpu_driver_load_kms+0x1a/0x110 [amdgpu]
[  +0.000545]  amdgpu_pci_probe+0x197/0x400 [amdgpu]

Fixes: cfeaeb3c0ce7 ("drm/amdgpu: use doorbell mgr for kfd kernel doorbells")
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2: 
- Update the logic to make it work with both 32 bit
  64 bit doorbells.
- Add the Fixed tag.

 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index c2e0b79dcc6d..e0d44f4af18e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -162,6 +162,7 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
 		return NULL;
 
 	*doorbell_off = amdgpu_doorbell_index_on_bar(kfd->adev, kfd->doorbells, inx);
+	inx *= kfd->device_info.doorbell_size / sizeof(u32);
 
 	pr_debug("Get kernel queue doorbell\n"
 			"     doorbell offset   == 0x%08X\n"
@@ -175,7 +176,8 @@ void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr)
 {
 	unsigned int inx;
 
-	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr);
+	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr)
+		* sizeof(u32) / kfd->device_info.doorbell_size;
 
 	mutex_lock(&kfd->doorbell_mutex);
 	__clear_bit(inx, kfd->doorbell_bitmap);
-- 
2.35.1

