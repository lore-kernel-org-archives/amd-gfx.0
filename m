Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F63C6787B
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 19:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1A0A10E6C0;
	Fri, 25 Aug 2023 19:14:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20BCE10E6C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 19:14:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gN2bAI8fmW/SowQnud90IoiU09d9ZX15GaZD1u/RY0TibdDUwJQA35Q2FFF3mM9lLN5/9mkKHVTrs50hB2q11Imf2KsvuCPtGVrnKEa/sLFypzmnn1pg6lYubfdkIHbYi/hjC8vwaqR9eaQgexCoi+bRbYgRoryLRmyuUIGV1bJZFNXPPGDT3qAhyU2kwPNQimhN7zadQ0zNHniNfU/hEr/KJqTP56py0V4hzIQwb3ZJiaxgIqx0YuXdb73ZFUxX4cDMB3p2MpWBlElPnMY3FhPx+MzaLGGdAmF3T8/S7nK8DX0mBd9e2B1dwRlaY/ZHDTXbEIJorA6mN7S3D7uuSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siCEaSrKC5Ru8H4fDjPi718wufh1QF6Z+aJsAUPVtEU=;
 b=ihiBtlWx9R+hZOKxqB3EBf1bXYISOuAgD/40Ca7JANy1CGxu5fyGjcQ6TOH+DFkJaL5yewE9uInrG8/DtEXD8BzuTF1OlebnCfqOgBfjQ+HMl0DixxhrMrfRsrSEpfw05G0DArLNCj9V20M9iAV3TGubNuEoY6BWdYzS+xkIVWXq+r1IlNC679Hl4eQM7s0ZX8NDSPV1t2vb6HFq3hrDP7+FwFa9LDmZReevJDserMVF5L7ffSzgeHMOC8YnJZKvTGfPKj4uzjW4c0D2/l8+VogVYYR0UD38lJz/8rS4HxAk5D+bBKHxSyp9MZ/WYDEsNPbX4oFupmtuhGR7/6/g3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siCEaSrKC5Ru8H4fDjPi718wufh1QF6Z+aJsAUPVtEU=;
 b=Q1+W02cNLn+M7166HJYnBDHYJIL564RrR0P3dGojXUaOhZPXa9R0mFlm6eI55vIDXJnrGdonUYlXOD2S8zeRbQ5n9B/wJoDtE32bA16jYpJBeeY9rU+ufPASXT96YBmk3O+OFwS29F9U+TXsXSxL7QX7hWTRoR9R9NKc1UWJ7PA=
Received: from MW4PR04CA0252.namprd04.prod.outlook.com (2603:10b6:303:88::17)
 by SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 19:14:31 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::ad) by MW4PR04CA0252.outlook.office365.com
 (2603:10b6:303:88::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 19:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 19:14:31 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 14:14:30 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Checkpoint and restore queues on GFX11
Date: Fri, 25 Aug 2023 15:14:11 -0400
Message-ID: <20230825191411.3276216-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SJ1PR12MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d7f1d4-7841-4295-daa5-08dba59f82b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GDSnUNPuLp5XIUnN/w5u03PnVSoS1G7Bx3vZ6/WaTwX9kxehheYvuVrNuKn7MUA+CUEwT7b43z6lXvwoOko9nmDxltp0UVH+hUX7x4Uepe8fby2SLW3SWLnfCb0ZMGUZ2T5YnZivy6kfPRfnSnHRHFRUgWjqLZ2I98DN9VOtdQYDp04DZXXj1+8X9CtgpbA/GeyQhqadh7m09u0df/YI3joT1F0EJffEAvXLD//36rt1BWcERyDfQDENGq9yu8LSjCbpyDBvLQeITrvI4vO8n2K3ktQni2D23uqjVd9fTG55ri4O2fFAMFwpWP7dS8EAAC+S7LCnVxp5NstJfYPXjkej1p9mjAT3SjxhISEpohW8Gz2okl5Py1GgbwqHfqn0JEAcNwKtIoWHtEXm8VWtIZ96beTxeF9uYCsf9JzIOpni8KCdXrOHuC+dVI9ZUCSGF7xM/sXAYiSLhBE69hd1zhSo0SuUAwaG0ghRxqAhlq7TN1WY87eu2r25lkxITjRwN2G8VWYvsRY9Dm+Ly/2YWguf3LdbpHIq+z0/b2Eo9Fs/ul0Gv6xK8+SEVlX5gHyQdpw8z/lF+sVTDGUHyXx3S3xCAwfjplCP3T/TPH7WcTAmp8DhnZFIjPlCNgbWeEQczI+aLIWZ3d59Z0kocelBpQb2WRqydRHoYai8Jhyr2Rc/jdp5v2/gkjpcj1rmbYe0+gHLfAn23pmoPDYu+VobxZkNqafZJQbwRAYfDc2aXEDEG0tDkpW82Mh8H+G32W7C+hXLSf9n9n+viU7rrsI2dUOp+I85sBNK1gPruqYs5o5OTBJHfA3+1j+100G4T0PY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(7696005)(54906003)(70586007)(6916009)(316002)(70206006)(81166007)(478600001)(26005)(36860700001)(356005)(6666004)(16526019)(40480700001)(82740400003)(41300700001)(86362001)(2906002)(4326008)(8676002)(8936002)(1076003)(40460700003)(2616005)(5660300002)(83380400001)(36756003)(336012)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 19:14:31.2899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d7f1d4-7841-4295-daa5-08dba59f82b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363
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
Cc: David Francis <David.Francis@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The code in kfd_mqd_manager_v11.c to support criu dump and
restore of queue state was missing.

Added it; should be equivalent to kfd_mqd_manager_v10.c.

CC: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: David Francis <David.Francis@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 2319467d2d95..2a79d37da95d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -321,6 +321,43 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	return 0;
 }
 
+static void checkpoint_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
+{
+	struct v11_compute_mqd *m;
+
+	m = get_mqd(mqd);
+
+	memcpy(mqd_dst, m, sizeof(struct v11_compute_mqd));
+}
+
+static void restore_mqd(struct mqd_manager *mm, void **mqd,
+			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			struct queue_properties *qp,
+			const void *mqd_src,
+			const void *ctl_stack_src, const u32 ctl_stack_size)
+{
+	uint64_t addr;
+	struct v11_compute_mqd *m;
+
+	m = (struct v11_compute_mqd *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memcpy(m, mqd_src, sizeof(*m));
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+
+	m->cp_hqd_pq_doorbell_control =
+		qp->doorbell_off <<
+			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+	pr_debug("cp_hqd_pq_doorbell_control 0x%x\n",
+			m->cp_hqd_pq_doorbell_control);
+
+	qp->is_active = 0;
+}
+
+
 static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			struct queue_properties *q)
@@ -457,6 +494,8 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct v11_compute_mqd);
 		mqd->get_wave_state = get_wave_state;
+		mqd->checkpoint_mqd = checkpoint_mqd;
+		mqd->restore_mqd = restore_mqd;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
@@ -500,6 +539,8 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
 		mqd->update_mqd = update_mqd_sdma;
 		mqd->destroy_mqd = kfd_destroy_mqd_sdma;
 		mqd->is_occupied = kfd_is_occupied_sdma;
+		mqd->checkpoint_mqd = checkpoint_mqd;
+		mqd->restore_mqd = restore_mqd;
 		mqd->mqd_size = sizeof(struct v11_sdma_mqd);
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
-- 
2.34.1

