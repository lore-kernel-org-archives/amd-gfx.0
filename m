Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DE3C54E66
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 05:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E7CB10F580;
	Fri, 15 Mar 2024 05:42:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EM3f5XY6";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F2C610F580
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 05:42:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EViu1mRjDK5C9PPRfmIKkEvg1YsxB9s9ngrDXHDIJ+ewOEM5p68jZRNMFGj+Cgrlqfl6b+BDE7Ypqki8cUJ70PpaHgUaw/JWQ4kz5YFT7+FyTqo2rDBkOl4I5muWlJf1Brk2/dMVgDloTgwCALtfci9Gcpsd9l9DdjsZHJzQj8nwxhowKJ8aajVNJSNC8qiS8imlpv64z5BwZUacerCPEei8821wmsAGdDsleQILXdFV5vj6Q1Mi/peXVn28luNnkXeo1GfNnzly6wZNk7wCO8wtl5VWrmjmion2jNFf3ndT4DCS8KL3awPSJC0+jJ+pSjE/2z4C/mIb6jirSt8hoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=du3612mO2x4dqWRM8Gu2TCVTwPuPV2V4/pekS/VjHbI=;
 b=EBvbuAysEl1RdSOgS5MEXUt9JiElp5B7NRT44vNGbTMQFYvO8wUQF+1BMkvMOip/Vxox7D/TiQmsg5/xMKYQSQa6yvyjfoW6UvV1rff95cvIWQX63N11aO/VUXmoPUXpfxo3xG+geqR9JVnE6JDq7YbMRwNMJAskznHuvsOtvq2qb87dm6+4iBpADAe4brbv1PX9mU8D1MNHW4ANxD8imvp2eS7y7KpOnu+0J6gOfsmODMNGU8QpNhxZ9xZ48iNXVCQIWOXC972suRbf4oyOSF8KriWr3PYnJvih9NDR/HEHO635TGu/uj2KVe0YbiolAozI5d7WuMDKK91+2MnGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=du3612mO2x4dqWRM8Gu2TCVTwPuPV2V4/pekS/VjHbI=;
 b=EM3f5XY6//5gsN9MGA+G3N8poCbAp48gHaonJQkHPqanmWhcKsrZ9sIIgYsh19y19BDkHUiFAlUlnQIkkFGQuYg6gCUfRDRaanlhLFqWFAKC6b4QvLnqeQnotvw0zNEsG4lcRoconObTr3jq/7yEmONfgIp07I/Z6JYYD3RFCyA=
Received: from BL0PR02CA0123.namprd02.prod.outlook.com (2603:10b6:208:35::28)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Fri, 15 Mar
 2024 05:42:09 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::52) by BL0PR02CA0123.outlook.office365.com
 (2603:10b6:208:35::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Fri, 15 Mar 2024 05:42:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 05:42:08 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 00:42:02 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <asad.kamal@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>, <charis.poag@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Update SMUv13.0.6 PMFW headers
Date: Fri, 15 Mar 2024 13:41:48 +0800
Message-ID: <20240315054149.3259906-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: b78686a6-1ed5-43ec-4e32-08dc44b2a769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IWr7NEIJgcOxTsiidMQEd9unFvikf56phjs+mRj1sQ2SU2gf0+FkicqFdNYakYg9jdxat2UVUQe2ztCly2sd+sh6vWtMWk62Or4wbMU/ubxmya32a6lS8kgU2Sjg9aRlEZFZV+OLCCT0hHEivm6xg/ZgTz9M+LEJYp21zYMAPPZ5qs3jQhsCS9qIcnpipLmw5HtBVc8FYxQ2z5PiT/PZ33Cx1CCkYXC3F3RqKxUin0QD3GBWtqBYKQnAj2qPJH9mLau8zjN+GuC05IJJBQqjs9KozR5FnJoq4aeC8ISw+znlCV5XvjBytpnq6nJBkOz66GfpmT3u/2RfWcesOyewg6VxOPYx8ODODqXhKm3ADpD1fpC+OR1AZuONGDGRMdXQzpHr4F3nfPnmYc8c9ieNQ9+OEjMOvFYIs31CpXuhLAiqqGL16J3jIqeOy5CJju1Dn28WNWIggXgXYaSOpEE6mx2i/6+c3JVMOJhe9mMjGr5toT8pTwAP8CkB3u7CwLctkJnr4DdIY9PZsqofey2DrvBrU4ImZoGuUMAGhbwkaaVJwTEj2k/oq6zQzJonLWffH5wnhb4osJl3SaGONKLrbhub4Bu/KWxqzx10rTCpyD4sjLTfurlC9xCAwuUxlcdqs7e+bCZU/TSx0heK2dOL+giGI7YgOBNRjbnAmJRJKOKwY8n9OQL4B6QFKNVBM1ChnuG6vAz+MRZPkgdXGvuvjhOXDO6cNqW7cXQ/y/cTb6NgAQuUyQBZrQmk7ltyS4AS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 05:42:08.3019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b78686a6-1ed5-43ec-4e32-08dc44b2a769
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
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
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index 7b812b9994d7..2a7c58186907 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -123,7 +123,7 @@ typedef enum {
   VOLTAGE_GUARDBAND_COUNT
 } GFX_GUARDBAND_e;
 
-#define SMU_METRICS_TABLE_VERSION 0xB
+#define SMU_METRICS_TABLE_VERSION 0xC
 
 typedef struct __attribute__((packed, aligned(4))) {
   uint32_t AccumulationCounter;
@@ -223,6 +223,9 @@ typedef struct __attribute__((packed, aligned(4))) {
   // VCN/JPEG ACTIVITY
   uint32_t VcnBusy[4];
   uint32_t JpegBusy[32];
+
+  uint32_t PCIeLinkSpeed;
+  uint32_t PCIeLinkWidth;
 } MetricsTableX_t;
 
 typedef struct __attribute__((packed, aligned(4))) {
-- 
2.42.0

