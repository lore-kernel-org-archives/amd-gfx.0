Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F18C54EBE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 21:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D703410E088;
	Thu, 12 Jan 2023 21:19:10 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BFD010E088
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 21:19:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZicYi0NA7pfK6YOho1FOwo9M7fCrEPphWZhj+4HFWPV4VLqXqurfL3mg01OhmXzwA1amgVnS17734Y0jSyDq7jequ3RJI7cbnvMdlTDISMtxuUYYlCcOJmTmADMt3SDQMk4R68O4uJL/EzbspEtXRjoS8pQIZssvRCLDK7yZSlP2VNiwWCZBEl7R14/W/C67SHkEqIs+mHv6i2XQUf7x+i9S8jBEgOtAFBz6vJ72WXLTlBfwyysoib0YPbjYsoSSqjB3Rbx6S7pTK1uRnQ6S0GdXVIlP+lzIF/E7mEuh7p2zOiDS0Wpmp79Fwq29ndDyId+/xBUzWSi/lGLbpMNGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQbyFL36OS46Y4XNAUaPIM+j5+00/tu7pMgTv8Eq87Q=;
 b=dXO/mt7Wro3trcog7Ha8997J7qREZkvujaAytNOT2rXMnprjsh0w7FvTcj7K2MBoIpPyID/r/hsRUr67vukdl/O1BkG2Kvg69tR/lr0y5GQJF65S52Am0aWaYjrhgwUJ+0Q6F3hGd9+Ndw8V9BisOn/CUDr1QSj1LlrT8wsx1mRA5JOOehfVjHbR76E9trxaAen17r5+XTHq/c6md5bMgEEPYhapmpRXJQLH9S2A3wg9IgCstTBj24BWUSnztezh9WymSAodhcLnBz1d0APDojPAz405TIDgmmoj6sJhUBSNJ8W8a4Lsk+5Z39f7fFGYkS9inkCeRJAQWyY2xj9VpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQbyFL36OS46Y4XNAUaPIM+j5+00/tu7pMgTv8Eq87Q=;
 b=dmkiONg9fjMGWaNXdKe+Mjcr5nExtLcNFPQ/EQVbQEL9McKA5BMNKs9VraWsFya16zVq8MByr/9q4RCdCi/3yCdRlmzmyhhuhIVm4GN7Z5sYd50GeaU0X/LLXIjn7eTUZV9BuJEbA4yfD9iSiHJSkJz7cliHIGLtunvvwavDPwY=
Received: from MW4PR02CA0001.namprd02.prod.outlook.com (2603:10b6:303:16d::21)
 by PH7PR12MB6696.namprd12.prod.outlook.com (2603:10b6:510:1b3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 21:19:04 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::d9) by MW4PR02CA0001.outlook.office365.com
 (2603:10b6:303:16d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Thu, 12 Jan 2023 21:19:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 12 Jan 2023 21:19:02 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 15:19:01 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Support process XNACK mode dynamic change
Date: Thu, 12 Jan 2023 16:18:29 -0500
Message-ID: <20230112211829.20095-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT068:EE_|PH7PR12MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 00215d9a-d89c-4c16-a8bf-08daf4e2a13e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXkKwyaVmvVDY1jDTcSU9+55iXPF6BJS/h2XBKJZyKbzeJFfl/JFmmdxhA/2TM9Rs0/2Ao37oEnM8WnMKeICS9VmtDRuDzni2MZ1diBv3cR2bZNbXXLPP3aFZLi72+qnA1k6MtstdlvuFB6p+ljwNMP8bwbunMX0sfgA4fq8Ok+O4FYXxMmlKxjSW5au148NL3rj2kIpjisatRdmA6XLeWUe4VZuY2wY3JyrE4kGb59MACHwHIzPRD32ljpsFhZupI+AOS4F7nlobsl+NY8zIxBDLKQe2N/sCML9sQiLMOL3x//zK/Lipo6UgiyHYGQyNYfsmRsQaqvK+gxM0JkZWJ9Vv6sthdQ7/V8vz8vTt6B2XsG2401qswaPdn/QuPnp/C2tAkJb2Pid77ijx4yhisScEimCDT2fMrItTv67/pRXupdBe835BaQANRf5R6ZRQfPXv4eZXDaLzAVBft6ttPAaUFWvlEsQ5Bs4W3bCty8wO66fSxCrktiQo2Dm+fcBmpIDFMg5kKGl3+PqA02FCGrhkX7Aq1lAEJV/KVxJ4KXlngdrAH6FsIQcxRGamMteTDV/Mmsy3wTQqxmxEHX8c826atIDxvZFfoe3CimTJ+0wPSZptSIk4y5Wrhf/8CQ9osrKvDYjA/TEIkODYa9Aj81DqF1rZAcrmLHD3weNtyqlM+/FqMg0CYY7v/tBLDPGys6jNHgwcEOqtcemkLYdVbPWG6HzI2ZKZiF44hS8v6I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(40470700004)(36840700001)(46966006)(82740400003)(356005)(81166007)(7696005)(70206006)(8676002)(54906003)(36860700001)(86362001)(40460700003)(83380400001)(4326008)(41300700001)(6916009)(70586007)(1076003)(5660300002)(426003)(2906002)(316002)(8936002)(2616005)(40480700001)(336012)(82310400005)(16526019)(26005)(478600001)(186003)(6666004)(47076005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 21:19:02.9652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00215d9a-d89c-4c16-a8bf-08daf4e2a13e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6696
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update queue qpd is done for the first queue creation of the process,
if the device support XNACK mode per process, update qpd setup
sh_mem_config based on the process XNACK mode, to support the process
destory all queues, change XNACK mode, and then create queues.

Add helper macro KFD_SUPPORT_XNACK_PER_PROCESS to remove duplicate code
and add new ASICs support in future.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 .../amd/amdkfd/kfd_device_queue_manager_v9.c  | 27 +++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  2 +-
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index d119070956fb..8b2dd2670ab7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -59,30 +59,27 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
 
 	/* check if sh_mem_config register already configured */
 	if (qpd->sh_mem_config == 0) {
-		qpd->sh_mem_config =
-				SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
+		qpd->sh_mem_config = SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
 					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 
-		if (KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 2)) {
-			/* Aldebaran can safely support different XNACK modes
-			 * per process
-			 */
-			if (!pdd->process->xnack_enabled)
-				qpd->sh_mem_config |=
-					1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
-		} else if (dqm->dev->noretry &&
-			   !dqm->dev->use_iommu_v2) {
-			qpd->sh_mem_config |=
-				1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
-		}
+		if (dqm->dev->noretry && !dqm->dev->use_iommu_v2)
+			qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
 
 		qpd->sh_mem_ape1_limit = 0;
 		qpd->sh_mem_ape1_base = 0;
 	}
 
+	if (KFD_SUPPORT_XNACK_PER_PROCESS(dqm->dev)) {
+		if (!pdd->process->xnack_enabled)
+			qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
+		else
+			qpd->sh_mem_config &= ~(1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT);
+	}
+
 	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(pdd);
 
-	pr_debug("sh_mem_bases 0x%X\n", qpd->sh_mem_bases);
+	pr_debug("sh_mem_bases 0x%X sh_mem_config 0x%X\n", qpd->sh_mem_bases,
+		 qpd->sh_mem_config);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 552c3ac85a13..bfa30d12406b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -206,6 +206,8 @@ enum cache_policy {
 
 #define KFD_GC_VERSION(dev) ((dev)->adev->ip_versions[GC_HWIP][0])
 #define KFD_IS_SOC15(dev)   ((KFD_GC_VERSION(dev)) >= (IP_VERSION(9, 0, 1)))
+#define KFD_SUPPORT_XNACK_PER_PROCESS(dev)\
+		(KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2))
 
 struct kfd_event_interrupt_class {
 	bool (*interrupt_isr)(struct kfd_dev *dev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 71db24fefe05..72df6286e240 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1330,7 +1330,7 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
 		 * per-process XNACK mode selection. But let the dev->noretry
 		 * setting still influence the default XNACK mode.
 		 */
-		if (supported && KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2))
+		if (supported && KFD_SUPPORT_XNACK_PER_PROCESS(dev))
 			continue;
 
 		/* GFXv10 and later GPUs do not support shader preemption
-- 
2.35.1

