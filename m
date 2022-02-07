Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77C8C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 07:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E6010E96C;
	Mon,  7 Feb 2022 07:28:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6455810EFE0
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 07:28:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OACCVieWIdlAbU5FTd/5oRckjxtoecMN9iay5r3TfcNf35HyMltNZ1o31/5BgRYRlUFcEKSIt3inNMC3jejxFmLTZgefyXOgs4uscv1V/GdviAR3oFvNUBycVL4BfKU8FlE8p6nrR+GjlMCANEpMtWpww7Xf2UI46El3rPDlEoG9VG1nn/6sYiN5mA7xSCj8NKINoibv/jKFkZ+U2lpFEDCIESvfzKMt4SqI4OWL1Ao+Jkj7HvZhVZ4ymm/SMkFXwYgGJxZWwpu7XKb2o60CIYz/J8Fn8U+GLshfxiszAbtx/YCeL0mqCjaYu3wB0JT/yAAxkQlMrIT2LKkHln3TaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeo48DdiVjkifKXTKJ8xnU51MpWXmOma/NLtPaoQ+BE=;
 b=XzhdIvxEHt7NURL7qgm6jRca/o1mzv40pCr71gCx6vez/0xFlulN0bq+6Z94+iLEFLomb1oP6Px/KbmPN2+fZeuxMw6Triue32tCmf1zclvnmYXaYpEVcCrIF4cNy6obTX507L817W3xCjSaY8kdmRA61ueT/ZfSjt+KBb0A0Ia2wjad3lUnH9GddT+8MVcxTJaSHeoWv/WJdwT+gQD+JY7Zds/86AfgzeylGSMzWMtniH31d2lVBwW+Ul3eLim0UKqMZxk9EJ8BVjxOiGyZ+f9BWUrMduftrmW+3X8iQ48BwwaawN/J4DwmTeNwZP6yKBBn0SQtXuNXTcUT+nyvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeo48DdiVjkifKXTKJ8xnU51MpWXmOma/NLtPaoQ+BE=;
 b=s/0DmIXRvrti6iQ3fw6QO62pIMIm/zgnlvenigQvClbxH9rSHqGn0Dwo3Iv87ft+Gow8UzYAJVzhiGfARgqVj3FwFRIiK2TAGec/B2LdtwtAmDdxkjVA47TS/r+2PeH8CtkrFLEMf0aFDi5VnM6FQ4l6frUMk51DMWhlqN2I728=
Received: from MW4PR03CA0326.namprd03.prod.outlook.com (2603:10b6:303:dd::31)
 by BY5PR12MB4020.namprd12.prod.outlook.com (2603:10b6:a03:196::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Mon, 7 Feb
 2022 07:27:59 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::f1) by MW4PR03CA0326.outlook.office365.com
 (2603:10b6:303:dd::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Mon, 7 Feb 2022 07:27:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 07:27:58 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Feb
 2022 01:27:55 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <hawking.zhang@amd.com>, <stanley.yang@amd.com>, <yipeng.chai@amd.com>,
 <john.clements@amd.com>, <Jay.Cornwall@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: rename kfd_process_vm_fault to
 kfd_dqm_evict_pasid
Date: Mon, 7 Feb 2022 15:27:41 +0800
Message-ID: <20220207072742.5476-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9e2bc53-aa5f-414e-3a36-08d9ea0b5df6
X-MS-TrafficTypeDiagnostic: BY5PR12MB4020:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4020FCB1F59B442C6FCF5D77B02C9@BY5PR12MB4020.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hU22gPHBCJ1hbfx6PtfbHDwQHN2rECJ/sM9AskAh9lUKGOT0ny/g5j0px3vmNp1sJIIbcfCAu8IF1I8ThMKVq4r4frEP5KKvy+y2MT8lSJZHiPwVhhh6CoAjaO0wdc4riI1gqrQ3sbTpn8X4T2I23OaxHdYec9ZQk32WMhrgZiq0I+yCOsIIAmmiScmzKET7ZTJW8sCRQvPreQlQZmviG9O6aT+Md7RakIlZHO27FEV9g/6HEjU1KAxZQBdJqtc6G6Ux7KB44DHKtgEfiV01aRabykXY0LjrVhzJGzejzft4OZXt4b0GpZUITRRb+8fL6J4GKu6gSJ18e9MQuYofXX5Bzn9/xuS+hbu88FL3FkqLTjSRBnx4ec3SvOxboaytEp6o8TyHMJnO6LrGpMd6Rujq1ciJ/E70qjp/bRyrTyXzPCTIxPy8KZJCgThOjdZNjsJ89Dz88+qsmwkP/rw/gtgHzEcbR2yd/S9a4zKOA2sRGtnUnEg7s0ji4BjBDrU3zBAjPTgWP6X7YKU2lrakacZoXRgCAbxd/qXCxrkqBGOvqR0qy928MuLIZ0PibZYQh/be9vIMXpgIhaHdwhiyF7vK+NMGn02iWhWJSXLrFACN5rkQpfsb+wbci38ZJijPFVDuheCSXYdSBEmHSzEyz2+f8jXwLBd2TiZcqQQUKiw3cDP43bnIPrbCFNfjzKbr7kbWzdzoiQBSLk/N6LPOUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(70206006)(336012)(508600001)(40460700003)(86362001)(6666004)(8936002)(4326008)(8676002)(6636002)(316002)(426003)(7696005)(110136005)(5660300002)(36756003)(356005)(81166007)(2616005)(82310400004)(36860700001)(26005)(2906002)(186003)(16526019)(1076003)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 07:27:58.9718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e2bc53-aa5f-414e-3a36-08d9ea0b5df6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4020
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As the function is used in more different cases, use a more general
name.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c      | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c       | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
index d60576ce10cd..5c8023cba196 100644
--- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
@@ -110,7 +110,7 @@ static void cik_event_interrupt_wq(struct kfd_dev *dev,
 		struct kfd_vm_fault_info info;
 
 		kfd_smi_event_update_vmfault(dev, pasid);
-		kfd_process_vm_fault(dev->dqm, pasid);
+		kfd_dqm_evict_pasid(dev->dqm, pasid);
 
 		memset(&info, 0, sizeof(info));
 		amdgpu_amdkfd_gpuvm_get_vm_fault_info(dev->adev, &info);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 63b3c7af681b..219acc818eb4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2120,7 +2120,7 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm)
 	kfree(dqm);
 }
 
-int kfd_process_vm_fault(struct device_queue_manager *dqm, u32 pasid)
+int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid)
 {
 	struct kfd_process_device *pdd;
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index e8bc28009c22..7a2b6342a8f2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -308,7 +308,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 		info.prot_write = ring_id & 0x20;
 
 		kfd_smi_event_update_vmfault(dev, pasid);
-		kfd_process_vm_fault(dev->dqm, pasid);
+		kfd_dqm_evict_pasid(dev->dqm, pasid);
 		kfd_signal_vm_fault_event(dev, pasid, &info);
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 74ff4132a163..74fb4762c66e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1174,7 +1174,7 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm);
 struct kernel_queue *kernel_queue_init(struct kfd_dev *dev,
 					enum kfd_queue_type type);
 void kernel_queue_uninit(struct kernel_queue *kq, bool hanging);
-int kfd_process_vm_fault(struct device_queue_manager *dqm, u32 pasid);
+int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid);
 
 /* Process Queue Manager */
 struct process_queue_node {
-- 
2.17.1

