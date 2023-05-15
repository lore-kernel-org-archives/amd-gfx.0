Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3C2C77B7D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 May 2023 02:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3994589518;
	Mon, 15 May 2023 02:28:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4034910E054
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 02:28:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=couj/CzZT8CITJAJW/4rc8N3+Ts7LF3hZ9AsHcQVBMEvy/LCTKAdzTMq7S9R+2WcP71sgCbwZWcHbqy5URnJW9jAQsikkp9X21682iVp0pX7IKiyo5yqjzm/QHotEx57au52HvQ61QW4lWQ8MvP8+PjjCu46JWFlbd9oEFINZmoQndn01GEQSXA5BAGc6+s5kypCWxbAuVyIV6CyIQhQ0iRDGCeq8HhGR28EIfqoD/OeAv/ixJ02utHEngWT16wA/kgfFs3j9GwFMM/rpsNt5uJWBNs2Kx9xxJINo5Jhz+apPJrnxShrlWCpbTFbcBY3SqmsvY48UciINocwE8aeHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGkFWy+7Whc9P24aG4xXX0A1Jsb9YoK7izZNIqEWrlc=;
 b=gqF0FVOwx/4yUmvXB6IhxYr4cgDNzJ451ByBeC5O206ZJRCP4Q4wo+VxpWlxFW1LCEM6cZqC8yJCaTiFBBiEsJxg+BkzStnEWtumUMkFdCrF5Vu1cTUUD9msZ8XZOJki9wT5BkVluYcvr3gjCohCtzR3E6bhaFvjm8tOkP5/KRwAm4WmPAb9n7k7rgVBzAO6O0VvropwX/b1h3vJyULlVILOTfuRmBndaxnhqYzA5sZLHbHzuCtIslz1JYq3NRAy8U3kHdS4a8MkwkV+mbsSfStQAHIW+/tFFNG+r9m17VevpTkWbjPrnmUYmoUidexuH8v2WaTRoLTlP/tNb94i0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGkFWy+7Whc9P24aG4xXX0A1Jsb9YoK7izZNIqEWrlc=;
 b=bymQfb0H1HDZmW9NGSy0h5U+TkbDaiZudiqifpyysEn2Qj0nQFMAWnYC4aFcniaLiMxtYvO5rq8ihf1v9GWMhS0clj203j6FPcgbmWlzLljVC76dGwFmjjyYP54Nh9tJc4tDelUzMmLY6cGsI6T4JcAsJD9gh2xcH7CG4ZXKQ8w=
Received: from BN0PR04CA0129.namprd04.prod.outlook.com (2603:10b6:408:ed::14)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 02:28:13 +0000
Received: from BL02EPF0000EE3C.namprd05.prod.outlook.com
 (2603:10b6:408:ed:cafe::83) by BN0PR04CA0129.outlook.office365.com
 (2603:10b6:408:ed::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 02:28:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0000EE3C.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.11 via Frontend Transport; Mon, 15 May 2023 02:28:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 14 May
 2023 21:28:12 -0500
Received: from hongkzha-test-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Sun, 14 May 2023 21:28:04 -0500
From: Horatio Zhang <Hongkun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amdgpu: separate ras irq from vcn instance irq for
 UVD_POISON
Date: Sun, 14 May 2023 22:28:02 -0400
Message-ID: <20230515022803.9482-1-Hongkun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3C:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e68f44f-8262-41a9-a058-08db54ec082a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SYddOtSi3F+bFV4bzaHL1xFyW4vij8dUFcNbdSn/97ehEjsCN02wfhNMVCeStn/nnvoozobNonNkw3oPPKXU9Yfc8BnHpkAEnn7MfNV7YPJZEe27u/lbwE+f1EblExUoK/fF18fdttR/m9fpMjBXxrTzYri5//KzyGQRi9WLRlOVcVYcvLW/KENHah/s2zFYQ7OudLNe01x9R95RKFlQKgf0dWv15gtT+Gul0LnQ/f7qM3xDMPg7YXS5jqfrc5V7xyNbKoKkYHFuTLM12nX4uT51u/IjFWlDWBdC/8V+ntwuT6A+aDbY7xsV2d2IVJpvHAXdm+jENGKrl4Wid3EZ8W+90zEvODUmlCquHXN1lPPE4l4fMTn7C1acDNhBtczwu3cQVhIewhESxUy4Z08BWiRzPA/aSpfZsECu4p7Y6KSkLqs2O9287c5JJJGwF3JbiobZ9D14W9fM/VYam3fEuDjwVhjiAIsWtl/dyxT9y4e6l6hZC1J1opMY4Xnxx+pRgis0VvqH9h5fjwbxSzZn1glJzVo1zrqfYopFhpRX9dP5aYVxY+HkaPDKefcWsYBHI1Vvcv9/qM3Mq+djcDUHzOAb2zBb+HL5Zt5FWe4pBERHrwhJ58HskRcr3Kk1T0+Lhqlf+LdNtUMbXfp7nJHw9J5d0CvuurzVDbbiCCm1ZOQszVDhKQwliwg1FhtNOgWjbEQUuCjlSzHWIsM1iuO4/Dku68aQwVjwuQX9SqtMcIT6f09D1peuYXIc2cHzWmQDRf1QVeqs4FKW82JH8CR7Jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(336012)(47076005)(36860700001)(83380400001)(426003)(70206006)(70586007)(2616005)(7696005)(26005)(1076003)(40480700001)(478600001)(54906003)(86362001)(186003)(2906002)(8676002)(8936002)(5660300002)(40460700003)(36756003)(356005)(82740400003)(4326008)(6916009)(41300700001)(81166007)(316002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 02:28:12.8615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e68f44f-8262-41a9-a058-08db54ec082a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031
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

[   44.563572] RIP: 0010:amdgpu_irq_put+0xa4/0xc0 [amdgpu]
[   44.563629] RSP: 0018:ffffb36740edfc90 EFLAGS: 00010246
[   44.563630] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[   44.563630] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   44.563631] RBP: ffffb36740edfcb0 R08: 0000000000000000 R09: 0000000000000000
[   44.563631] R10: 0000000000000000 R11: 0000000000000000 R12: ffff954c568e2ea8
[   44.563631] R13: 0000000000000000 R14: ffff954c568c0000 R15: ffff954c568e2ea8
[   44.563632] FS:  0000000000000000(0000) GS:ffff954f584c0000(0000) knlGS:0000000000000000
[   44.563632] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.563633] CR2: 00007f028741ba70 CR3: 000000026ca10000 CR4: 0000000000750ee0
[   44.563633] PKRU: 55555554
[   44.563633] Call Trace:
[   44.563634]  <TASK>
[   44.563634]  vcn_v4_0_hw_fini+0x62/0x160 [amdgpu]
[   44.563700]  vcn_v4_0_suspend+0x13/0x30 [amdgpu]
[   44.563755]  amdgpu_device_ip_suspend_phase2+0x240/0x470 [amdgpu]
[   44.563806]  amdgpu_device_ip_suspend+0x41/0x80 [amdgpu]
[   44.563858]  amdgpu_device_pre_asic_reset+0xd9/0x4a0 [amdgpu]
[   44.563909]  amdgpu_device_gpu_recover.cold+0x548/0xcf1 [amdgpu]
[   44.564006]  amdgpu_debugfs_reset_work+0x4c/0x80 [amdgpu]
[   44.564061]  process_one_work+0x21f/0x400
[   44.564062]  worker_thread+0x200/0x3f0
[   44.564063]  ? process_one_work+0x400/0x400
[   44.564064]  kthread+0xee/0x120
[   44.564065]  ? kthread_complete_and_exit+0x20/0x20
[   44.564066]  ret_from_fork+0x22/0x30

Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 27 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 24 ++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 35 ++++++++++++++++++++-----
 4 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index e63fcc58e8e0..f53c22db8d25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1181,6 +1181,31 @@ int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
+{
+	int r, i;
+
+	r = amdgpu_ras_block_late_init(adev, ras_block);
+	if (r)
+		return r;
+
+	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			if (adev->vcn.harvest_config & (1 << i))
+				continue;
+
+			r = amdgpu_irq_get(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
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
 int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)
 {
 	int err;
@@ -1202,7 +1227,7 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)
 	adev->vcn.ras_if = &ras->ras_block.ras_comm;
 
 	if (!ras->ras_block.ras_late_init)
-		ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+		ras->ras_block.ras_late_init = amdgpu_vcn_ras_late_init;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index c730949ece7d..802d4c2edb41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -234,6 +234,7 @@ struct amdgpu_vcn_inst {
 	struct amdgpu_ring	ring_enc[AMDGPU_VCN_MAX_ENC_RINGS];
 	atomic_t		sched_score;
 	struct amdgpu_irq_src	irq;
+	struct amdgpu_irq_src	ras_poison_irq;
 	struct amdgpu_vcn_reg	external;
 	struct amdgpu_bo	*dpg_sram_bo;
 	struct dpg_pause_state	pause_state;
@@ -400,6 +401,8 @@ void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev,
 int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
 			struct amdgpu_irq_src *source,
 			struct amdgpu_iv_entry *entry);
+int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev,
+			struct ras_common_if *ras_block);
 int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index ab0b45d0ead1..44262d67b3ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -143,7 +143,7 @@ static int vcn_v2_5_sw_init(void *handle)
 
 		/* VCN POISON TRAP */
 		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
-			VCN_2_6__SRCID_UVD_POISON, &adev->vcn.inst[j].irq);
+			VCN_2_6__SRCID_UVD_POISON, &adev->vcn.inst[j].ras_poison_irq);
 		if (r)
 			return r;
 	}
@@ -354,6 +354,9 @@ static int vcn_v2_5_hw_fini(void *handle)
 		    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
 		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
 			vcn_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
+
+		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
+			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
 	}
 
 	return 0;
@@ -1807,6 +1810,14 @@ static int vcn_v2_5_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int vcn_v2_6_set_ras_interrupt_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int type,
+					enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
 static int vcn_v2_5_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
@@ -1837,9 +1848,6 @@ static int vcn_v2_5_process_interrupt(struct amdgpu_device *adev,
 	case VCN_2_0__SRCID__UVD_ENC_LOW_LATENCY:
 		amdgpu_fence_process(&adev->vcn.inst[ip_instance].ring_enc[1]);
 		break;
-	case VCN_2_6__SRCID_UVD_POISON:
-		amdgpu_vcn_process_poison_irq(adev, source, entry);
-		break;
 	default:
 		DRM_ERROR("Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
@@ -1854,6 +1862,11 @@ static const struct amdgpu_irq_src_funcs vcn_v2_5_irq_funcs = {
 	.process = vcn_v2_5_process_interrupt,
 };
 
+static const struct amdgpu_irq_src_funcs vcn_v2_6_ras_irq_funcs = {
+	.set = vcn_v2_6_set_ras_interrupt_state,
+	.process = amdgpu_vcn_process_poison_irq,
+};
+
 static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev)
 {
 	int i;
@@ -1863,6 +1876,9 @@ static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev)
 			continue;
 		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
 		adev->vcn.inst[i].irq.funcs = &vcn_v2_5_irq_funcs;
+
+		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
+		adev->vcn.inst[i].ras_poison_irq.funcs = &vcn_v2_6_ras_irq_funcs;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index bf0674039598..1dfc7cee6d59 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -139,7 +139,7 @@ static int vcn_v4_0_sw_init(void *handle)
 
 		/* VCN POISON TRAP */
 		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
-				VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[i].irq);
+				VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[i].ras_poison_irq);
 		if (r)
 			return r;
 
@@ -305,8 +305,8 @@ static int vcn_v4_0_hw_fini(void *handle)
                         vcn_v4_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
 			}
 		}
-
-		amdgpu_irq_put(adev, &adev->vcn.inst[i].irq, 0);
+		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
+			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
 	}
 
 	return 0;
@@ -1975,6 +1975,24 @@ static int vcn_v4_0_set_interrupt_state(struct amdgpu_device *adev, struct amdgp
 	return 0;
 }
 
+/**
+ * vcn_v4_0_set_ras_interrupt_state - set VCN block RAS interrupt state
+ *
+ * @adev: amdgpu_device pointer
+ * @source: interrupt sources
+ * @type: interrupt types
+ * @state: interrupt states
+ *
+ * Set VCN block RAS interrupt state
+ */
+static int vcn_v4_0_set_ras_interrupt_state(struct amdgpu_device *adev,
+	struct amdgpu_irq_src *source,
+	unsigned int type,
+	enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
 /**
  * vcn_v4_0_process_interrupt - process VCN block interrupt
  *
@@ -2007,9 +2025,6 @@ static int vcn_v4_0_process_interrupt(struct amdgpu_device *adev, struct amdgpu_
 	case VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE:
 		amdgpu_fence_process(&adev->vcn.inst[ip_instance].ring_enc[0]);
 		break;
-	case VCN_4_0__SRCID_UVD_POISON:
-		amdgpu_vcn_process_poison_irq(adev, source, entry);
-		break;
 	default:
 		DRM_ERROR("Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
@@ -2024,6 +2039,11 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_irq_funcs = {
 	.process = vcn_v4_0_process_interrupt,
 };
 
+static const struct amdgpu_irq_src_funcs vcn_v4_0_ras_irq_funcs = {
+	.set = vcn_v4_0_set_ras_interrupt_state,
+	.process = amdgpu_vcn_process_poison_irq,
+};
+
 /**
  * vcn_v4_0_set_irq_funcs - set VCN block interrupt irq functions
  *
@@ -2041,6 +2061,9 @@ static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 
 		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
 		adev->vcn.inst[i].irq.funcs = &vcn_v4_0_irq_funcs;
+
+		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
+		adev->vcn.inst[i].ras_poison_irq.funcs = &vcn_v4_0_ras_irq_funcs;
 	}
 }
 
-- 
2.34.1

