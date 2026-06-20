Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8CECD4F26
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Jun 2026 15:38:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FDD610E208;
	Sat, 20 Jun 2026 15:38:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Do3nieC";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45BAE10E208
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Jun 2026 15:38:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzA2HlTp33efakgdSnvt3hsMIyV6ZMIiDd1Smls4rOyBEnwUpjPAS4gHWsOpFepEHEvOBEfOJbAucTyPKRonkWKHIKEthivit8U7JS0Hyz1KAlkvhOSOWr3pAtLfDl5bK+OQ8iigpsmxd0vm4cz7DY6ZKS7QTNIYOIvSNmcfCYXDyMUuJ4w0t93lURZtYxt2QUWDj5YyAU1r1Nuwtnt3rEnW5afYeSjENn6tNUHOGCOA/mse4gBbsoJPTibmQgb61Ua6wwmN/BY57FuZ+EcqYpLwUA8EbWD2xr6fSGBzw6N0ioNjddQY1Yv39cP49CAHsCrVGjUKiD0I82IB8112xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73Pqw3Of6ogzdOex8WcMhYcHgw0Z9cdE7bg37ZDWgr0=;
 b=cemJ819vkul++RYRhb9sMXcP/o79hVHfrw+hsZAFFNe/HrpT6RNSNtElGQ2WpuUs0OQK8SmckC6yLybS7lcEOMorGmM5GHsgilWqIghIfNy6UpLGCe5fX/8E9DTg7GnXf9ow74/nRSCxlEHaLtvYB3gdlJ/f6AhyPlXAy780zXIQgiFvOvmrAcr/jwTsEdrEh2koWLnCj64kTFC7nDSoOB9doOEzzdVnUpRsrrZ3r2NC0S82UXy8+MXPTPgDhlpVdgh9GqH1LTM4AWSPQrOfEgEPNbaYlWjISpocf1UFeQWmUmlGSs1Ss1vAAvQYDdWrXtbCvkrUSk7S3LX0XorkBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73Pqw3Of6ogzdOex8WcMhYcHgw0Z9cdE7bg37ZDWgr0=;
 b=1Do3nieCIVYBuWys9KUTdx+/xDORo0jZ4ACESCR0tb5WDXP/9qwm9vDtOCi4J1nBaoFmnqb++7Xi2tsYSyXBjXeblNbQNjBcewNL86AfDzywlxx17kvrgKQBulogkA5NR5SoWWBlB6rXs8q9CfRzXQjdzF3YadkxkJ1Q+SwyYlU=
Received: from DS7P220CA0078.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::12) by
 MW4PR12MB5641.namprd12.prod.outlook.com (2603:10b6:303:186::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.13; Sat, 20 Jun 2026 15:37:57 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:8:259:cafe::57) by DS7P220CA0078.outlook.office365.com
 (2603:10b6:8:259::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.16 via Frontend Transport; Sat,
 20 Jun 2026 15:37:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Sat, 20 Jun 2026 15:37:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 20 Jun
 2026 10:37:55 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 20 Jun 2026 10:37:54 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Shaoyun Liu <shaoyun.liu@amd.com>, Amber Lin <Amber.Lin@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/mes12: drop queue state on RESET_QUEUES unmap
Date: Sat, 20 Jun 2026 23:37:33 +0800
Message-ID: <20260620153753.3061314-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|MW4PR12MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: a438f74e-9d0b-4d1a-fde2-08decee1e67c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 3jdrc6Pih6WgRQt3AJVi664uLTw+tzSgPR1y4HCuA5gTkdVIgpdMGk44XjDeGJQDVSOG1Lof+dPnPxhqld7B7Hi4chvaMtGmrtfst6jrE0sSdlLouz40aKpQTJriUcnQ7Rc7FDXSvmgeaSdaoQuXmmL5quz0l4YmgPuGqvO2RbU7EIG4QUN9KDw/7ciyyCMhW5vjtau/Mdrtgccgnjh+zXJTw2CHOeLGWQMUR+NgU751+j+IqeJDzaAo1I4DlmhCNkaYDpij2U4BaYiuFO5BBPp46Wa/oxxgo0n0EifWHe/g+71ualuNraN3PR+4aeq2EL+SOavTSVloT2olXen82K89gIADK1B/BmE7V4S1WwRRXXqtBBiM0igePqFTa2V3in2eZGT7HhwKd8hnPmGE+X9CtNlKVkwGo/yTdmgag+XIEUmPoosE6mqW5V6sqEzhYYRlv+crD9VTXfi/blzZHLEqp8YC7zfajd2WGx2fDWPcenZTsE/nMkbJS8hfpjbDSr+2Z4HjuqOEdVCQBP+cLcXdKiU5o+mlQcf1DB0XR3/m9U1Tzldc0P4jp/eJRDi7ql7Iz8Q7ocBPb2jb8YNZ/GWUVinAJWr+7oqSHC9d28eVvxN/qrkRNjvXb4pzRI5ff0KOPecLMQFBtG+tj7KxSCO+v4oJJDNA1/fs34ziVxILRZTSZ5gucr+PbEnuQEcOOKsMDKJu4iQQgBCGzL4pHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o/xttodN/+zvaB898ViTuk7MRnB4zk/OhunL0UPB+LfI90CnbubwNkpPqLjeCTosVLi7E9NMx/Q9A73iYug8KNUo2GF4gcbXpTlO/X1QC5zZFF3Wc5JoZVO0g63nG11kEcL/K8Hl8FLTyfAQtppEXZH/XLI1ijXHFLrJJIRipQYyPUdcfr6WnRPuUUef5yW0E9h0wu5CbfrZZL3+mZt9Ojdnemzmqfu2IDmHYmrgXTSG9s+md+pCKU+SoolVBTgX8+z21MPjP7u8mTAGXBqsDwd+Xjcpbg/uHW6Qg1WpzIlblwvMdAMGVvGX9wSm9C7LGjHlrlvmlMME8RRs/uHkqGqO/DOoomaZASDbzhxoe15zYiSQUDs2Kr0cVTy4fGPDE8Kr4pXJOjUfhFgW47ZcTU2enAOh6gbxqxEUeXnTbCIvGqr6ISYyKhdDjyfpUpI3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 15:37:56.2698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a438f74e-9d0b-4d1a-fde2-08decee1e67c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5641
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set remove_queue_after_reset=1 (MES >= 0x5a) so MES drops its internal
state instead of re-unmapping an already MMIO-reset queue, which can
timeout into a GPU reset.

Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index d80a983b1b6c..20f4fd57b1da 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -749,6 +749,17 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 		mes_remove_queue_pkt.unmap_legacy_queue = 1;
 		mes_remove_queue_pkt.queue_type =
 			convert_to_mes_queue_type(input->queue_type);
+		/*
+		 * A reset-time unmap: the queue was already reset via MMIO while
+		 * gangs are suspended and it is on the MES hung/fail list. Tell
+		 * MES to just drop its internal state for it. Without this flag
+		 * MES asks CP to unmap the already-reset (still wedged) queue
+		 * again, which times out and forces a GPU reset.
+		 */
+		if (input->action == RESET_QUEUES &&
+		    (mes->sched_version & AMDGPU_MES_VERSION_MASK) >= 0x5a)
+			mes_remove_queue_pkt.remove_queue_after_reset = 1;
+
 	}
 
 	if (mes->adev->enable_uni_mes) {
-- 
2.49.0

