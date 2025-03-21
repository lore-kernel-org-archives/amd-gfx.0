Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35404C36000
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 18:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A593110E819;
	Fri, 21 Mar 2025 18:27:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Km/MoJke";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 943FD10E819
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 18:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yh0Gyu+RPix0/R73eHHYnV/DjOAezYpHbmBwPwky9JQTLfei9npTlVlpTioSMuInYe8Vcef6/ikeZOGKvMBepvcaLPgs4DsMcAa/pCBN+Ggx8kmaFQdLLQT40OCRUaLFCZkhLBRYFBxPTa4z3mFNmlEj1r8TpAJOG4K3j7xojvekRCQaM6fHXbWXTTBeDBMUgpNPguDeQocSQXq4bWiqxmUYSyGn2CB2nueoiXwLdT9a330GN8hu2rhIlgGWqrNoMnRwDu1kXfsQjaDdTEHpA1LaX/C2cXTWBhv4D06JrKON5GhDxJhIEFAaM0OxC2HMSmhbXix2j5hHBHStagx9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0rZ15WmIwlw8NBVhfeB0gURmEmuMaEsY4dO2OdqY4o=;
 b=NgjYWDTyS4FAjdDNckyYGVzPJHPnoJoseyfARjjZDzYbLx2DGk/OsD7kOELoSB+BQRp5n0EJ62gKobSmmo2UhSL25v+Wl6UtrJlwQuB7UCcCfwa+fy2Hk/Vq1v+w62lIOjNfaWLBoJSDUuoHSKuwxdCG8b5cZglsis3pH4vIDG1MaB7WOHmHD4fiBoZDRueDAgDcfBZZuL8OrTtgmhTc6rH2cYNkrlaYGrYRxoenpvjyrhblqLZR8EGJ5CZlw+o6b6wfoLm8lm17huH4m8R9UK+HyWgUPg3+sKijr57ybokHaXnB8f0ri2KFGL4DkufmdDSV1dnmVjb9MoOxW87kng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0rZ15WmIwlw8NBVhfeB0gURmEmuMaEsY4dO2OdqY4o=;
 b=Km/MoJkerCD94xePmx0yu92tJBo9XSGUOoNMNG753hWAwKJqnNbLl6eY0x2yuRy1I23XwrteReFAKE17yCqpkvm6ffFLPngF7ImNRggxNEUILcj96NfzIcpJycZqJIm5rU7/B58CnSAWNeXEj0gliG8lsAiZmTRX0YCLS/X3g6E=
Received: from BL0PR01CA0012.prod.exchangelabs.com (2603:10b6:208:71::25) by
 PH8PR12MB6796.namprd12.prod.outlook.com (2603:10b6:510:1c7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.34; Fri, 21 Mar 2025 18:27:17 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::8d) by BL0PR01CA0012.outlook.office365.com
 (2603:10b6:208:71::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.35 via Frontend Transport; Fri,
 21 Mar 2025 18:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 18:27:16 +0000
Received: from jc-d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 13:27:16 -0500
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: Increase KIQ invalidate_tlbs timeout
Date: Fri, 21 Mar 2025 13:26:58 -0500
Message-ID: <20250321182658.22436-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|PH8PR12MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 4793b727-eef7-402f-5ac2-08dd68a60242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yvzT/m33LizFJ9HpglBYADLwS7PshazQVeSDogXWEpP4eEgyPYdsX7go5OXS?=
 =?us-ascii?Q?OcsKbsXC5iFNt4qKkeSvOgm23tY71wPLYfHstSuWqFkU8R6daZWUJpoguUrh?=
 =?us-ascii?Q?ZYeQ9nD5hAfx7moisaHHGmrXYgO2pr3a1mTIqZXTi1NfAVc98190NYQLjtZ4?=
 =?us-ascii?Q?FQmucvzLv9Zy5CjCVMUBRQ+MGnZPcqPNRWMvgz3cfdjr5byj2NDMd7c5Pux3?=
 =?us-ascii?Q?APo0LP7RpZPJYlB1rVPiQnznFgLJ20R6szTLINEUkmWU3aX0kVncQ7TLTJdY?=
 =?us-ascii?Q?3rdLW/wXHWhv094JFrW+CxSDwxhxLXpvjWAjqyvVfdKzDP6q79oIAhDFAiHL?=
 =?us-ascii?Q?YgsPMxrF47DTaUqqmRCSVzVyf7rSXSvzLsCqJZtR+3rflom1YCbiiNe4j5Wa?=
 =?us-ascii?Q?f/3a6ZHMq+Tdi4OVpILLLr5CajdlqyHwN7a0miCdlNaSdImdaevJNv1c8Ddi?=
 =?us-ascii?Q?EZnymFgPY8PlxZhOqP6BPgIOqLaWZmBp4H+Gw0svBEvfS7HjUOqoUMoCKm+m?=
 =?us-ascii?Q?CytRrqAyj43fCaSddaDo3Lt5rRE4c7du7po7E4UyjHJvlbFoHVTRzs45XMsq?=
 =?us-ascii?Q?4CIvFfO87kAzN5zi+3KwgsmdlfuP40inm3XJcJaaEiVWcxqXnA1vjmuUhcQb?=
 =?us-ascii?Q?r/L2KN/FTU9uZsHN8vo8nSJEquM6NepXGYczd3qijIt0dvZLLM5oX9ZBWexv?=
 =?us-ascii?Q?+feQA3hEvXgqZqqqbB+SaHhdpql1QX3Nr8WS2XN/Ck/Nm1cmA48S+GXzBz8b?=
 =?us-ascii?Q?YLMQYVQOhKNAy1BkhuOaDqG8hpgomnbWHjZqfTXqiK9SFgs+nCpRY5JoZUor?=
 =?us-ascii?Q?JBNrx02GYJqS0EaUGBmIHfFiS0/gMiOLeK3Iw3wR6M09urixJBj7xfSxdJxV?=
 =?us-ascii?Q?uYydEBJsIfW4c/mnODCpBQm6mtEstAuwJAg2llpeweHDssk3C3D8LfLdviji?=
 =?us-ascii?Q?tmiaz2xE6Kett5UZDd+xMoE3DxvATFt/F46/+J2ltJATaJdCzbuFpfg6ZevS?=
 =?us-ascii?Q?MmFxd7IgmmetWRw23sRiCVb5BfAwnc32MATi1zn7Yfbw0BR9q12q6oLenSTB?=
 =?us-ascii?Q?6S0y3vCiNrKR6ZdoG+5R4Ofgwa4ehIUDcK+aCyP+K3EPswnNhX88EfT7jlrW?=
 =?us-ascii?Q?3JMk/VAXH5F3a87nfU0cnKMDydZ4a2QGGMo7o7qdoJv0IETvvYQV+8IWlZ4Y?=
 =?us-ascii?Q?El7pGTOee47XN7nG1+CJzc7OHRxPC23yCnOIhMMeqQTuiTeYGva8qX7zagRv?=
 =?us-ascii?Q?M2JT2t3ai9BdByK9iHM2sA5BaZ9OBjfg41nbqEXSx5loHFI9wFexlzsROnOj?=
 =?us-ascii?Q?hEqm6HoVsCArNTkgi5++uvwrLb4sd4Dp14mt0vyPmD8mLJAEQYmqLeEGmkIO?=
 =?us-ascii?Q?xVSPvIF/WshA3eFnTajUghffL40pfhe5sHz6fHfDGpaCGaWWgtqki+FHgt2F?=
 =?us-ascii?Q?cqYCEByDZROCoE+10gKvKK5Ujpc+29UxqDo3KM7e61czGKGTC11YaM3OgQzG?=
 =?us-ascii?Q?+jHo4aLFBNpSmrs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 18:27:16.7928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4793b727-eef7-402f-5ac2-08dd68a60242
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6796
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

KIQ invalidate_tlbs request has been seen to marginally exceed the
configured 100 ms timeout on systems under load.

All other KIQ requests in the driver use a 10 second timeout. Use a
similar timeout implementation on the invalidate_tlbs path.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 15 +++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f68a348dcec9..54bf8780f0b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -355,7 +355,6 @@ enum amdgpu_kiq_irq {
 	AMDGPU_CP_KIQ_IRQ_DRIVER0 = 0,
 	AMDGPU_CP_KIQ_IRQ_LAST
 };
-#define SRIOV_USEC_TIMEOUT  1200000 /* wait 12 * 100ms for SRIOV */
 #define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
 #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
 #define MAX_KIQ_REG_TRY 1000
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 464625282872..047437f625c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -699,12 +699,10 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 				   uint32_t flush_type, bool all_hub,
 				   uint32_t inst)
 {
-	u32 usec_timeout = amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT :
-		adev->usec_timeout;
 	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
 	unsigned int ndw;
-	int r;
+	int r, cnt = 0;
 	uint32_t seq;
 
 	/*
@@ -761,7 +759,16 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 
 		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-		if (amdgpu_fence_wait_polling(ring, seq, usec_timeout) < 1) {
+
+		might_sleep();
+		while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
+		       !amdgpu_reset_pending(adev->reset_domain)) {
+
+			msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+			r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+		}
+
+		if (cnt > MAX_KIQ_REG_TRY) {
 			dev_err(adev->dev, "timeout waiting for kiq fence\n");
 			r = -ETIME;
 		}
-- 
2.34.1

