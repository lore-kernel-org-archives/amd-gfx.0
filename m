Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E6CC77B7D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 May 2023 02:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDF3010E054;
	Mon, 15 May 2023 02:28:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C2FE10E054
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 02:28:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+ZF58I0AUHm6f0MBpmbzeGRij2H84yCz4SounNW2SPVIxRdKOAU5F6XICCTy+D1pzE8rLGpQpO+a67DXeJyWj0eC0scIlN1RIA90NNltMFjvbAc4LNquUMOHWVqg+AZ7KATL0EHvhG4T0ctCu2JBMPQ65fyaHexXnnjzzcMhb6WObqfDmbaDqHlx+KrPj838EFK7CXcEcySgFVYhp0EwJtz0G3W2Taku43g1nhZ4EC2pWeMmvJs0qGa2mUyux4TFvosIrnKu/sSq2ZS+if9yQp552fEAgq8NwYz0qmOHnwOu5IcZfS1plWM85lpYeGeQRzxfTVGVFJ58aTjsowlaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULmPUFqAady7QjKp2eJTxoUcgASycdDesxqYKqvFt+s=;
 b=S11C2WlthcCA97ft4dmvdEpxHvusfoUrcxxNb7+afgF+yMQyuVIGwUgQLx+pDfO5XdAMCI9zh61/pSxHrpa0yMpGK1nWK018TmDBi+Z6LnNEhgelmr2cCobwxN8GoULpf4MOelZrF8PhaqyMuQBAaqOLBTZmwuFYtUuDKVmm29to0pd1STu3Ma6I6SPXtv4wL7cqUt0WugcSiG+UvGZFuQ6H8LgY99JboA9yaWPxc0vOTrX97tMFDqU6CQ2+8OYK89KbV6WsQVOuaS+gaKcC2dJqWV2xoeTkpyaZ3Opu89uyxLwDn4+bIL8/tuk91U49DYMQw6VOjPLiPkVA4Fwfrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULmPUFqAady7QjKp2eJTxoUcgASycdDesxqYKqvFt+s=;
 b=o86dE4PA6dg3Ccp8qs3vN1jgaD2dLsa6p8mqQrhWfBYDIjoFMwSQMG7nxwN8CPFNvzszijE/fdRgHBIMB6OeVmuod+zcG2AS7XNk45aM9bz14aukpgU/mxgnhr1bHl8z7rwt2dUTCcokC5Uz/82hZ6pwFGySH0uLwHoFCFqFwo0=
Received: from BN9PR03CA0582.namprd03.prod.outlook.com (2603:10b6:408:10d::17)
 by MW4PR12MB7437.namprd12.prod.outlook.com (2603:10b6:303:21a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 02:28:22 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::96) by BN9PR03CA0582.outlook.office365.com
 (2603:10b6:408:10d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 02:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.14 via Frontend Transport; Mon, 15 May 2023 02:28:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 14 May
 2023 21:28:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 14 May
 2023 21:28:20 -0500
Received: from hongkzha-test-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Sun, 14 May 2023 21:28:12 -0500
From: Horatio Zhang <Hongkun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amdgpu: separate ras irq from jpeg instance irq
 for UVD_POISON
Date: Sun, 14 May 2023 22:28:03 -0400
Message-ID: <20230515022803.9482-2-Hongkun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515022803.9482-1-Hongkun.Zhang@amd.com>
References: <20230515022803.9482-1-Hongkun.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT040:EE_|MW4PR12MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: f689bc98-277b-4892-9a8c-08db54ec0d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mERu8Yhcn5AncmOG1UsxDOY+YnM/jpzuDhWXE3rEHUc5F7y1dfU+udI5DjD90yonxha+80tzCqZqlZcbB+XR/XHACEjbOtKPAKj2CcpxI/MIglvhTQ6SE4I/CqExspWcWObolwskwHVe/8niZA9DavRcxijDmC5AVVpo+71ghXGeKxJZWheiS5RlVss8Kwp3Ye2qCA7t1Ykn1YNNdz21dJjwFzdtGfH2ih88ZmIscXa1GSGlUkaLwPTCaOWdIjAIR9vjBSuEPAWIdT7lpK778qByg72c7lkF6AZsQj2T3FkjBJizUFTx+Zk277dWPDfjvdFlZtXQqJixQNZeruC0VLYbGOE1P3z8KHjfvChxCOqx9i1uDYOjzTajkwseqslEzvXXK5bIKJnQqF0v4Kxvj2WHkMuIFKZ+iSymTRUIUBkYP19QxQY+JAvtxxEgbg0mZ4TqoAZrIRhSWXwknlLmI9h97uOuxKQwneHfm1rKiZTkGOt0mY7ZfdKSMN7ZdjBvcQDDWMbjjz+l5lomYmWeT/D7T2/f+TbQWhjIju8nON8KIKr77y3R98OKtbhZTh5xm7+kt13yUcCsUSZ0b5APK7ul+xUrgu0uxR+EwzCVAflQxlBsPzfJ96riiWkdWflYmMdDF7SGIWo6MIcW+yYwLqrjog7YWEwBTvL2ZHTyfyIn87QGtbmN4bR+POAsDS49Ot2ibHsnTugvhKYZ8ry1N1n9bKeNa1cZlnPRaTO9Obvc7oBwn9/fEX1QD5JYJHtYYWNLorcMu0PObg5xAKasLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(54906003)(478600001)(6916009)(4326008)(70206006)(70586007)(6666004)(7696005)(316002)(82310400005)(40480700001)(2906002)(8936002)(8676002)(41300700001)(5660300002)(26005)(1076003)(82740400003)(81166007)(356005)(86362001)(36756003)(426003)(336012)(2616005)(83380400001)(40460700003)(186003)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 02:28:21.8684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f689bc98-277b-4892-9a8c-08db54ec0d86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7437
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
Cc: HaoPing.Liu@amd.com, bob.zhou@amd.com,
 Horatio Zhang <Hongkun.Zhang@amd.com>, feifei.xu@amd.com, tao.zhou1@amd.com,
 Sonny.Jiang@amd.com, Mario.Limonciello@amd.com, Leo.Liu@amd.com,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Separate RAS poison consumption handling from the instance irq, and
register dedicated ras_poison_irq src and funcs for UVD_POISON. Fix
the amdgpu_irq_put call trace in vcn_v4_0_hw_fini.

[   50.497562] RIP: 0010:amdgpu_irq_put+0xa4/0xc0 [amdgpu]
[   50.497619] RSP: 0018:ffffaa2400fcfcb0 EFLAGS: 00010246
[   50.497620] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[   50.497621] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   50.497621] RBP: ffffaa2400fcfcd0 R08: 0000000000000000 R09: 0000000000000000
[   50.497622] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99b2105242d8
[   50.497622] R13: 0000000000000000 R14: ffff99b210500000 R15: ffff99b210500000
[   50.497623] FS:  0000000000000000(0000) GS:ffff99b518480000(0000) knlGS:0000000000000000
[   50.497623] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   50.497624] CR2: 00007f9d32aa91e8 CR3: 00000001ba210000 CR4: 0000000000750ee0
[   50.497624] PKRU: 55555554
[   50.497625] Call Trace:
[   50.497625]  <TASK>
[   50.497627]  jpeg_v4_0_hw_fini+0x43/0xc0 [amdgpu]
[   50.497693]  jpeg_v4_0_suspend+0x13/0x30 [amdgpu]
[   50.497751]  amdgpu_device_ip_suspend_phase2+0x240/0x470 [amdgpu]
[   50.497802]  amdgpu_device_ip_suspend+0x41/0x80 [amdgpu]
[   50.497854]  amdgpu_device_pre_asic_reset+0xd9/0x4a0 [amdgpu]
[   50.497905]  amdgpu_device_gpu_recover.cold+0x548/0xcf1 [amdgpu]
[   50.498005]  amdgpu_debugfs_reset_work+0x4c/0x80 [amdgpu]
[   50.498060]  process_one_work+0x21f/0x400
[   50.498063]  worker_thread+0x200/0x3f0
[   50.498064]  ? process_one_work+0x400/0x400
[   50.498065]  kthread+0xee/0x120
[   50.498067]  ? kthread_complete_and_exit+0x20/0x20
[   50.498068]  ret_from_fork+0x22/0x30


Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 27 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 27 ++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   | 27 ++++++++++++++++++------
 4 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index b07c000fc8ba..f27078fc67c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -241,6 +241,31 @@ int amdgpu_jpeg_process_poison_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_jpeg_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
+{
+	int r, i;
+
+	r = amdgpu_ras_block_late_init(adev, ras_block);
+	if (r)
+		return r;
+
+	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
+		for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+			if (adev->jpeg.harvest_config & (1 << i))
+				continue;
+
+			r = amdgpu_irq_get(adev, &adev->jpeg.inst[i].ras_poison_irq, 0);
+			if (r)
+				goto late_fini;
+		}
+	}
+	return 0;
+
+late_fini:
+	amdgpu_ras_block_late_fini(adev, ras_block);
+	return r;
+}
+
 int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev)
 {
 	int err;
@@ -262,7 +287,7 @@ int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev)
 	adev->jpeg.ras_if = &ras->ras_block.ras_comm;
 
 	if (!ras->ras_block.ras_late_init)
-		ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+		ras->ras_block.ras_late_init = amdgpu_jpeg_ras_late_init;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index 0ca76f0f23e9..172296e9f40c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -38,6 +38,7 @@ struct amdgpu_jpeg_reg{
 struct amdgpu_jpeg_inst {
 	struct amdgpu_ring ring_dec;
 	struct amdgpu_irq_src irq;
+	struct amdgpu_irq_src ras_poison_irq;
 	struct amdgpu_jpeg_reg external;
 };
 
@@ -72,6 +73,8 @@ int amdgpu_jpeg_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 int amdgpu_jpeg_process_poison_irq(struct amdgpu_device *adev,
 				struct amdgpu_irq_src *source,
 				struct amdgpu_iv_entry *entry);
+int amdgpu_jpeg_ras_late_init(struct amdgpu_device *adev,
+				struct ras_common_if *ras_block);
 int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev);
 
 #endif /*__AMDGPU_JPEG_H__*/
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index b040f51d9aa9..5ee7bc6a9360 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -102,13 +102,13 @@ static int jpeg_v2_5_sw_init(void *handle)
 
 		/* JPEG DJPEG POISON EVENT */
 		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_jpeg[i],
-			VCN_2_6__SRCID_DJPEG0_POISON, &adev->jpeg.inst[i].irq);
+			VCN_2_6__SRCID_DJPEG0_POISON, &adev->jpeg.inst[i].ras_poison_irq);
 		if (r)
 			return r;
 
 		/* JPEG EJPEG POISON EVENT */
 		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_jpeg[i],
-			VCN_2_6__SRCID_EJPEG0_POISON, &adev->jpeg.inst[i].irq);
+			VCN_2_6__SRCID_EJPEG0_POISON, &adev->jpeg.inst[i].ras_poison_irq);
 		if (r)
 			return r;
 	}
@@ -221,6 +221,9 @@ static int jpeg_v2_5_hw_fini(void *handle)
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 		      RREG32_SOC15(JPEG, i, mmUVD_JRBC_STATUS))
 			jpeg_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
+
+		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG))
+			amdgpu_irq_put(adev, &adev->jpeg.inst[i].ras_poison_irq, 0);
 	}
 
 	return 0;
@@ -569,6 +572,14 @@ static int jpeg_v2_5_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v2_6_set_ras_interrupt_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int type,
+					enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
 static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
@@ -593,10 +604,6 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
 	case VCN_2_0__SRCID__JPEG_DECODE:
 		amdgpu_fence_process(&adev->jpeg.inst[ip_instance].ring_dec);
 		break;
-	case VCN_2_6__SRCID_DJPEG0_POISON:
-	case VCN_2_6__SRCID_EJPEG0_POISON:
-		amdgpu_jpeg_process_poison_irq(adev, source, entry);
-		break;
 	default:
 		DRM_ERROR("Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
@@ -725,6 +732,11 @@ static const struct amdgpu_irq_src_funcs jpeg_v2_5_irq_funcs = {
 	.process = jpeg_v2_5_process_interrupt,
 };
 
+static const struct amdgpu_irq_src_funcs jpeg_v2_6_ras_irq_funcs = {
+	.set = jpeg_v2_6_set_ras_interrupt_state,
+	.process = amdgpu_jpeg_process_poison_irq,
+};
+
 static void jpeg_v2_5_set_irq_funcs(struct amdgpu_device *adev)
 {
 	int i;
@@ -735,6 +747,9 @@ static void jpeg_v2_5_set_irq_funcs(struct amdgpu_device *adev)
 
 		adev->jpeg.inst[i].irq.num_types = 1;
 		adev->jpeg.inst[i].irq.funcs = &jpeg_v2_5_irq_funcs;
+
+		adev->jpeg.inst[i].ras_poison_irq.num_types = 1;
+		adev->jpeg.inst[i].ras_poison_irq.funcs = &jpeg_v2_6_ras_irq_funcs;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 77e1e64aa1d1..60b9362fcebc 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -87,13 +87,13 @@ static int jpeg_v4_0_sw_init(void *handle)
 
 	/* JPEG DJPEG POISON EVENT */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
-			VCN_4_0__SRCID_DJPEG0_POISON, &adev->jpeg.inst->irq);
+			VCN_4_0__SRCID_DJPEG0_POISON, &adev->jpeg.inst->ras_poison_irq);
 	if (r)
 		return r;
 
 	/* JPEG EJPEG POISON EVENT */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
-			VCN_4_0__SRCID_EJPEG0_POISON, &adev->jpeg.inst->irq);
+			VCN_4_0__SRCID_EJPEG0_POISON, &adev->jpeg.inst->ras_poison_irq);
 	if (r)
 		return r;
 
@@ -202,7 +202,8 @@ static int jpeg_v4_0_hw_fini(void *handle)
 			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
 			jpeg_v4_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
 	}
-	amdgpu_irq_put(adev, &adev->jpeg.inst->irq, 0);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG))
+		amdgpu_irq_put(adev, &adev->jpeg.inst->ras_poison_irq, 0);
 
 	return 0;
 }
@@ -670,6 +671,14 @@ static int jpeg_v4_0_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v4_0_set_ras_interrupt_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int type,
+					enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
 static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
@@ -680,10 +689,6 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
 	case VCN_4_0__SRCID__JPEG_DECODE:
 		amdgpu_fence_process(&adev->jpeg.inst->ring_dec);
 		break;
-	case VCN_4_0__SRCID_DJPEG0_POISON:
-	case VCN_4_0__SRCID_EJPEG0_POISON:
-		amdgpu_jpeg_process_poison_irq(adev, source, entry);
-		break;
 	default:
 		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
@@ -753,10 +758,18 @@ static const struct amdgpu_irq_src_funcs jpeg_v4_0_irq_funcs = {
 	.process = jpeg_v4_0_process_interrupt,
 };
 
+static const struct amdgpu_irq_src_funcs jpeg_v4_0_ras_irq_funcs = {
+	.set = jpeg_v4_0_set_ras_interrupt_state,
+	.process = amdgpu_jpeg_process_poison_irq,
+};
+
 static void jpeg_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev->jpeg.inst->irq.num_types = 1;
 	adev->jpeg.inst->irq.funcs = &jpeg_v4_0_irq_funcs;
+
+	adev->jpeg.inst->ras_poison_irq.num_types = 1;
+	adev->jpeg.inst->ras_poison_irq.funcs = &jpeg_v4_0_ras_irq_funcs;
 }
 
 const struct amdgpu_ip_block_version jpeg_v4_0_ip_block = {
-- 
2.34.1

