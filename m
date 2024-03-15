Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03682C54E58
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 07:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7E010F385;
	Fri, 15 Mar 2024 07:44:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LAzdqQD1";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D86E110FCCD
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 07:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGYEE+kQD90s3xd71LFIT1xuT9HvuebhIhvzMXxbut74GrjefoFd48YX9achdcaEc/8gWksVdeRqVmPtLso5eSpBg6aeDH0A0DP4oRiTRt8TAOZvGtyv9hV49X6FZjcXOtVv63THCeesjl+PnGLHCkaIKnpskLecI13oOgNIRJ6GikXBoBsM7AzKA2xNIHMjTDc61XNQMkdEcSh+5xSwz0ViBB4HWVL8jIGz7617x/4Vi2qYVx71fvkQGPcdOFbum7gp4fUPOqK06jNHtRvOcgQCrmg2ryCzIB/zLYj5wpazaqQNxZ3VOzxhWXTkdo97OaSKL3LGW3YZya0rFiA7GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaHbCNYy7oCcmr+zDokg41fK4XfsO6LwMdWzOQJJOLA=;
 b=e/TRvl1OxF+/XH2FpUt3ZijiMSlU5acCF4pD1e7oF+A1DXwCc5xT/XmLunRhtCkvATpjAWrQYHHuIMN+SgITHrTrd2hm4wwLwgGTAX1CC4OkI1nhdi+5p3H+Wdp6W5R1btwF7ZQjwNpRleBLJKNgVw/ECqK83dPD7wImmhii9W7TruW1OjTMo3npMD6wLd92Pc36CbbZq2+Q+lgvYgEvqlBhRqfGZFFz9iYRHEtQnzpWPTRnxkvQDB+iKnOi60s8/GRF+CRJr8vCFKPKw+3NUYkeKgj1jDiAC5ijsqTxz8tEPmQBSNeF4rvxmP+lhb1GwmKArDA3D6sHqOXTqiYFdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaHbCNYy7oCcmr+zDokg41fK4XfsO6LwMdWzOQJJOLA=;
 b=LAzdqQD17BHG8Mihu7mCY/a6loOIRYav0FbrQ5kQanJ8zW2A6uAu8l0XRyHaQDrrk7Fp6lpHi8Nn/mvI680K9Q5Ywkoad25xYNJuH5xuS7OgQxgqOVWmTU0ZGzfR0QODHsEEf1VIDcKcVDHaDMiyUEm1tDZx/PAlE8/VS7tE3vE=
Received: from CH2PR05CA0065.namprd05.prod.outlook.com (2603:10b6:610:38::42)
 by DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.20; Fri, 15 Mar 2024 07:44:11 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::b4) by CH2PR05CA0065.outlook.office365.com
 (2603:10b6:610:38::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.26 via Frontend
 Transport; Fri, 15 Mar 2024 07:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 07:44:11 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 02:44:08 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <asad.kamal@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>, <charis.poag@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: Update SMUv13.0.6 PMFW headers
Date: Fri, 15 Mar 2024 15:43:54 +0800
Message-ID: <20240315074355.3297281-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|DS7PR12MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea92c76-edc1-4d75-6b95-08dc44c3b427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z1FoAdtRiT9SPa6iY79ZN6mJh7LbqSwpYE+WzDahnqBaSK/V/3NQJ+iHnzr2i/fLh6xJha/1P4gNaE2aipwEThxlGeNl3wl11ShTa6NHYOJLBVW09eDTZ0UNFWQhUUbRhiVPnyrzxF5VfNxj+I2Fr6waThDiTF87l1yHI34F/ukHSQ4wNsZgGOVz8UfF+LCRs5dwWrVzLmAA+PmUnzBm+cpy3St/lMTcKYVNrjxPjV5XDIs4gOqhCvenZU18PBPf9s4Lozhy3+LHTmHpM92NILMHV9gppSOeV8SYiDVV7ySUFJmWaJbueIKGwJtaRCn2mqfFHjpJ3pS89A+UjgZ5LKbhnrn/iFqnWQNy9aA0L9ELhAEkj4nA17C1V5XBfEC9rbkoq75TEYUG+airk/TEFf7B0HCg5V6zQxIZE+1RfWZL/QGH84+n6j5GuAZgvE/03Gw9EBcOa5TlAtydDhA4tKvZSQsd95hpAGDeHp5Z1mgaNoGcIV1M6goNQIx+yHOuWR2CBKTVwcTVzWT61fopqumxXFCMEk6vG7EEIpg+on3Wkl9xcoxQN6ueIrLxQf78NV54/wNyYgljfGjcwEvZI+qNZo9eQQKdAIBiRdEntkM/hCK2qaAl9/yEWfVAwgiHRLqfCDv8ZoyGocu4agC5Ga5UPIw3v2X212kWuuoVdGH6DGCEbUtWvz3ajy9+7YvxRzEFVj3iap9rvsz0Z+nQNKujKtkrQ9OhPTqxU1lJLd/8XZfmu4XNfR8930OvH57E
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 07:44:11.0936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea92c76-edc1-4d75-6b95-08dc44c3b427
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262
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

Update PMFW interface headers for updated metrics table
with pcie link speed and pcie link width

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index 7b812b9994d7..0b3c2f54a343 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -123,7 +123,7 @@ typedef enum {
   VOLTAGE_GUARDBAND_COUNT
 } GFX_GUARDBAND_e;
 
-#define SMU_METRICS_TABLE_VERSION 0xB
+#define SMU_METRICS_TABLE_VERSION 0xC
 
 typedef struct __attribute__((packed, aligned(4))) {
   uint32_t AccumulationCounter;
@@ -223,6 +223,10 @@ typedef struct __attribute__((packed, aligned(4))) {
   // VCN/JPEG ACTIVITY
   uint32_t VcnBusy[4];
   uint32_t JpegBusy[32];
+
+  // PCIE LINK Speed and width
+  uint32_t PCIeLinkSpeed;
+  uint32_t PCIeLinkWidth;
 } MetricsTableX_t;
 
 typedef struct __attribute__((packed, aligned(4))) {
-- 
2.42.0

