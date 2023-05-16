Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE50C77B75
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 05:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D81B10E132;
	Tue, 16 May 2023 05:04:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D9710E093
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 05:04:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6+RVx13pYKw6vlvxrqvvcX3cPBcYRErJ3s05Q1wm5ewVW8ctTQ+Rfg1Cv+o73LDj9Gu/y8l6/Sr1Nv2sPRMry3lEA2LCWu6OTh8WTv6M/4SAtHdITYtcI6QIa3tOn7KtKjHmyTv2ZW4XS0f0ZBK2rNUasOHds5BYxpqvBlwGJAtPhhR0WirAuGoAhILKQRte3vfHp9+8A3a9riSHVVmzWxXvtcG2wHQ6Zqyf+RGruDCKCU67pSGZIp7Z7RaWoSDgKtXQ8gN1CLlZBAqLx6LNvA9XyV/SCJg/Qq8Nn/jwp9gwVh2MZ+a65J7jPmANTf6l1DWZsygnSXGx0VydF+ODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GITfCOtvekmMDXffbWWRQzDXE5C72hlXECD2BzUdB3M=;
 b=l4OOvsxLJzeX+jmsiwPi8rNALpnK+Tzuf6wHpgFZy0BiNkF3mPIz3cMlmf2JgbWVCBXl/iuKx1FlYYrvcrAQkuYdVQ421VgNR723/CspoRi0XAfdRIM0mWoGVz0uhYa2AP4QlYJ7pC+JT/KZYnUqh7rYdKfPz6i4Cx5rd61jL0bQTNHoKb2RXJhNmmRDv/9uZ1Zkhxj1Nw0xbTMrolNNlxAWPSnPG8QUtI0wh+uUqaba83bxBtg2xPL7ON004Yd7d8ZTA0gDFZ7Z4OUbWJImORPvXtcZt/OIE2Lcu8KuMb3I4l1kMu6YB9ZW/p3AvjHrFw+5sTE+lyAij3WkxpK0HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GITfCOtvekmMDXffbWWRQzDXE5C72hlXECD2BzUdB3M=;
 b=cWfkZv2hJa3QkJB4OGbjBnQIelQz8Ntp2z2jDJvp7tuuhqTcIKrdplFjzb6ihVXQO4S2JjSoHVtPS5YJIjoyz8b6nMNV3FJuD5d38YiqVtfDLV3h3ySyQk+8txUWNlWiHL0DFF057WEdKytD/uUGy041mmVR+RhGUb5gD4DEeaw=
Received: from MW4PR03CA0175.namprd03.prod.outlook.com (2603:10b6:303:8d::30)
 by BN9PR12MB5051.namprd12.prod.outlook.com (2603:10b6:408:134::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 05:04:28 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::d7) by MW4PR03CA0175.outlook.office365.com
 (2603:10b6:303:8d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Tue, 16 May 2023 05:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 05:04:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 00:04:25 -0500
Received: from hongkzha-test-pc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Tue, 16 May 2023 00:04:04 -0500
From: Horatio Zhang <Hongkun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/6] drm/amdgpu: add RAS POISON interrupt funcs for vcn_v4_0
Date: Tue, 16 May 2023 01:03:55 -0400
Message-ID: <20230516050358.13095-3-Hongkun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516050358.13095-1-Hongkun.Zhang@amd.com>
References: <20230516050358.13095-1-Hongkun.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|BN9PR12MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: fd7e1948-cec3-4d58-101c-08db55cb06b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MW00TEQCwm8iXY1Vw5TUwI4pXMdaJgJjq6o2sfqjSRGVNV5gj4UBM4TDL47+8NXzw1EC1OwHTXyakZDkaiuF/GLdNrg+SDJr9hop+jJ+6ed+pWd0N8FnS4Boqr+WRL/7Ht+XW4K9wE+8KwwEYGacpluTrXXMI8jPyNWOfTetwbc/KMBwtS2o1Zvc38Fj0esBILWoAdG6a0EP/T1BR/ZzWLvrdJ8o0qhQou93agJTXe8PHJY42n60PUUU17fz1w/MqHGDUztH5zDwKqmSjmZ6Xdd0Uszetk6Ua6BSmFauTQm9rZeAHKgt+Cvkrn9RW0RydDSDsMOmx02eTkCAFlLyD4pPNNxjgskxeKXkTNek2TDRprKCGsaAof+Pip2NuINlitvj0ePxfwq5SEGXPChqxOuqIsICEVyMcucBS38Ln7PT/oh1tKUhnOQBSeDO1vrZUmuBYNcN7nr12YEqggaXOD/+3dGu2iuyvJKVhI7om//gfgqFc1NKl2I1ywSZwths0ZUMpnOSCVgZ4cL2ADh5KftWwa5KDFXVOKNzWB9CLwMOOUFrj9s4Ut9ahp20C2ILld7gJnn9tkVyRTNUDprFOunN2JzdS6b2MPSa+7mEOIAudk1OTq1vQZxK0bBKByxohqCJM+XCIoy7Hpt6zZdenn9D/yyWzOk79nvJKoz95jYiPXaw9cHRvMXaQHeE9CHO7cIi2tehvQu7YdyhgTQty7Dyi+NI9nUunTmISeEopEyAq9Cwlaju5Q51F6kuNBDjLfTSr+cYkstis2/CMJxWLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(83380400001)(36860700001)(336012)(47076005)(426003)(82740400003)(70586007)(70206006)(2616005)(316002)(478600001)(7696005)(40480700001)(26005)(1076003)(54906003)(2906002)(6666004)(186003)(8936002)(5660300002)(8676002)(86362001)(40460700003)(36756003)(356005)(4326008)(6916009)(41300700001)(81166007)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 05:04:28.0393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7e1948-cec3-4d58-101c-08db55cb06b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5051
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

Add ras_poison_irq and functions. And fix the amdgpu_irq_put
call trace in vcn_v4_0_hw_fini.

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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 35 ++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 81446e6996df..b607122ab26b 100644
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

