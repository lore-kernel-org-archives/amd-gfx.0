Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4496FA3746
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 16:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95D2310E307;
	Mon, 31 Oct 2022 16:25:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A8810E2EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 16:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayXSEj7El2CxTx0I8l+kkiLs/7yIlrSjrTYxHp9m+A46FySQZs1K284bbXkaKw9zp8l5PsDU3Dki+5ynMPSvJQm5MfSwUbW7wX3qux+At5wMx8aHJYAagvoGNZsNifu56yeUExvAVt14QKyk8RoR/EYPiiWYsXOi98wZvcBNnLMSt6LNChXHrMoIU3Je0vPA98DJFMGOYajAfdOl6sALnsbZ3JRR/H9xWHJmlcKpBPj/PnBHLkEeSSf0p1Hm+Q086pQOPBIunkmQrd6F7t83YaOp10QML2ZHs0N8mbfhe0bfvrRSvnWHFFBD6Kq7mRXVUfeqLSYlzl2RT8tu73H49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRzgNi3uu+6cR8U0sfYGIkZ+IZ8BcREdiLaWe2jMke4=;
 b=MwdqTAEWkXsYZldxNJzOW0RWD8V2NryOzgVpBL2UgmJZzLZGtxdv4MkAEuywHDvjvUPzelFKxxtBbPz5ihqkGvbFLKLSIrFkn1LRCd9UH2TSLKWgmk65WH5BMic10LrUYjrdgNVZag5uEGCEwribNsere2uJ88q/J+eFCPBfnxg2qJQyli5i1t+L9mv6raLh6fhDRwxwl3qdUFvk7EdwrMKBpPyR2IfTx4CluU8YA3NLj8KTtQ2D2HB7G0rTXTEYRMrv7G+bToF+iE8GfXxiYaXLP50t3Jtmv6Xlm8FKbiYYcLM3FbYRCLhjN52ZNXkUJWdeZ8N9wZzvUEX7HcqRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRzgNi3uu+6cR8U0sfYGIkZ+IZ8BcREdiLaWe2jMke4=;
 b=oIkqVs26kdWZ5bQVvTnCy2jDMftayn33DSlSpkAGTSHn0xSbW2gxsnjTqiDLHQdmCw2RNZJH7h+on2ffLVhdE30ili/RlZO4jq5sGLVCMckp3vPNM+cAVvyErUjwQu9EnDunQNYxttwJr144bFFcuFWKmRFeVSzqVzgNT8BN1DY=
Received: from MW4PR04CA0165.namprd04.prod.outlook.com (2603:10b6:303:85::20)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Mon, 31 Oct
 2022 16:24:31 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::a0) by MW4PR04CA0165.outlook.office365.com
 (2603:10b6:303:85::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16 via Frontend
 Transport; Mon, 31 Oct 2022 16:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.21 via Frontend Transport; Mon, 31 Oct 2022 16:24:31 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 11:24:27 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/29] drm/amdkfd: Add debug trap enabled flag to TMA
Date: Mon, 31 Oct 2022 12:23:47 -0400
Message-ID: <20221031162359.445805-17-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031162359.445805-1-jonathan.kim@amd.com>
References: <20221031162359.445805-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d5e0df-2bbe-4165-4c35-08dabb5c63f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8A72iTIwx6jc04pTAiiD8T9UlR+N1pgcIDR1xKboX12c+FnYMSYGOmoFxKPuo9KQHFK3GwhDV+JrkwGIAoSZ2d2cv2JWFeHVn4rD0UZEWGFP3o0x4L+cZNXwVScV3GwZP2bDNWCsxgy1RkuaBDRghZ4Gohj9uQB7ZXangyFw9pVygnVZAdAHpa/jqQRzPTCNalOEmEx6nf40QMeAYgx4ewSpN3z/BEK37epFRUdVnrqmauwgg6NUpIlkjQGpVsMiFhug6FnP7COUyErcq0W1EmNcppxA0KiQq4R1jMWky8EiWh5F+nkHL2KAMvQkGvsZHUuxDYLixTto6ItagxKEoLLFE+KSFYS/ogvg4zODRjTpN+YJn2pqkQ9tyFvSEFKufBYYcVNgrFFxFz38/LEJZabeihF/upio6bOmqPUrgL2uc1O2XseI8hfv23NBdaRJ+95bqCiE06ErXe0XKGh6sA7ToDSwigmxpIGSXC3sUivOMPpEzUNUZsjFoa83r7ffdX7I7ZOKpun71s9t2Yt1/L05lROmMQqNeMf3Ev+L+DRehavEpV92qqiN93/hcN19yVeouyjkLt1vZqlP/A4eVABhG/FPUmIpvLGk41o12pK7/WGVRwZ8Y3MFR+3c2UJndRmu6yIDtCUl9BZSRnZvdVVFhcHhi9PAY1hAKwOAgGUAuYKrdaBuYLKS+I/UiydCKmTYCCW8/Q9ddxsHs3dmTTwy9YjYYWKvw7WbZjb/guuWVcwsLtDQyXW7evfS9OT0/a032DN7fWbth6u3OEBKR2OazIsND2z01+3a6PMc0it7j8jgTdzUU11Q0+X79F3E
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(41300700001)(6916009)(5660300002)(478600001)(7696005)(6666004)(36756003)(70586007)(8676002)(316002)(70206006)(36860700001)(40460700003)(2616005)(47076005)(4326008)(40480700001)(356005)(86362001)(82310400005)(82740400003)(81166007)(26005)(426003)(83380400001)(16526019)(186003)(1076003)(336012)(44832011)(2906002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:24:31.3149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d5e0df-2bbe-4165-4c35-08dabb5c63f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jay Cornwall <jay.cornwall@amd.com>

Trap handler behavior will differ when a debugger is attached.

Make the debug trap flag available in the trap handler TMA.
Update it when the debug trap ioctl is invoked.

v3: Rebase for upstream

v2:
Add missing debug flag setup on APUs

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   |  4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 16 ++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index ae6e701a2656..d4f87f2adada 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -193,6 +193,8 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
 		if (unwind && count == unwind_count)
 			break;
 
+		kfd_process_set_trap_debug_flag(&pdd->qpd, false);
+
 		/* GFX off is already disabled by debug activate if not RLC restore supported. */
 		if (kfd_dbg_is_rlc_restore_supported(pdd->dev))
 			amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
@@ -278,6 +280,8 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
 		if (kfd_dbg_is_rlc_restore_supported(pdd->dev))
 			amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
+		kfd_process_set_trap_debug_flag(&pdd->qpd, true);
+		
 		r = debug_refresh_runlist(pdd->dev->dqm);
 		if (r) {
 			target->runtime_info.runtime_state =
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 9690a2adb9ed..82b28588ab72 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1101,6 +1101,8 @@ int kfd_init_apertures(struct kfd_process *process);
 void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
 				  uint64_t tba_addr,
 				  uint64_t tma_addr);
+void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
+				     bool enabled);
 
 /* CWSR initialization */
 int kfd_process_init_cwsr_apu(struct kfd_process *process, struct file *filep);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 59c4c38833b6..d62e0c62df76 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1252,6 +1252,8 @@ int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep)
 
 		memcpy(qpd->cwsr_kaddr, dev->cwsr_isa, dev->cwsr_isa_size);
 
+		kfd_process_set_trap_debug_flag(qpd, p->debug_trap_enabled);
+
 		qpd->tma_addr = qpd->tba_addr + KFD_CWSR_TMA_OFFSET;
 		pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%p for pqm.\n",
 			qpd->tba_addr, qpd->tma_addr, qpd->cwsr_kaddr);
@@ -1288,6 +1290,9 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 
 	memcpy(qpd->cwsr_kaddr, dev->cwsr_isa, dev->cwsr_isa_size);
 
+	kfd_process_set_trap_debug_flag(&pdd->qpd,
+					pdd->process->debug_trap_enabled);
+
 	qpd->tma_addr = qpd->tba_addr + KFD_CWSR_TMA_OFFSET;
 	pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%p for pqm.\n",
 		 qpd->tba_addr, qpd->tma_addr, qpd->cwsr_kaddr);
@@ -1374,6 +1379,17 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
 	return true;
 }
 
+void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
+				     bool enabled)
+{
+	/* If TMA doesn't exist then flag will be set during allocation. */
+	if (qpd->cwsr_kaddr) {
+		uint64_t *tma =
+			(uint64_t *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
+		tma[2] = enabled;
+	}
+}
+
 /*
  * On return the kfd_process is fully operational and will be freed when the
  * mm is released
-- 
2.25.1

