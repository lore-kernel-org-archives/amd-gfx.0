Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8637D262BD
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 03:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 728E610E686;
	Wed, 21 Jan 2026 03:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vNhp5azD";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D87810E686
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 03:14:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toQp+Y6n2BhDD7y3TpekF8Dbq0ODnK+KEuK2a+zXMf9C+Et4Cu+IPtc3LhZMF1tDbKgSW1kqNvWA8y269tAWY3pRPxhQoIXk1BwhEFbRMMjsAXuaObxxdCLgWAXLjIsFmpgn2h/vEEn84zpo/7gw4sKD+jBMC+8a30djPKsCA+J93vOtSGQwBLUm6uldQn6WwHtmiTcHh0zeONn0oMdMrjeEz9Uk/CfRk8p5tfjbrwtxMn0uBmu4Xu42O2b9wcCRKryoJHTPpiZSRQVf4ght11DqYgeCxUS9APf+kjfixGuz86yBqZG8JDQdBG8AeBEXwVgI/WFmsE7L73Ej89rhyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMMKTp/buAeqb0T9VTbAJGbL9J2xbfdBDwpF2U+hfFo=;
 b=p4jkG7Yl97fwzm9yzEOm2a9yY9vNGznRfzGJfdou1bb0j3peUAzjCAppJbCKVL4Syfp7NYiPA+8yHnv0MKgBmvrTRFk8KTIUEkQ7dizHZ5axkV5P8MzmbInov7dCheaMPp7XZ4oIjgMO303qm2moMv/sbG6jM7ddte0jmruGg/HajUEMOMHYucQr/xTrBkHwJFMLU6XAG1jD7fJNqHIbqGfwpYuA0OhdORrjAJV3llH9V3PMiy6yUu9aKWhQ81P7vp9GxZASw1XpfKwMiOiijub+ijIH1XedV6avckJyVCESsijiVz9e5mbL+Q/r84gzznQbXgtiwoeRbqoHprqv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMMKTp/buAeqb0T9VTbAJGbL9J2xbfdBDwpF2U+hfFo=;
 b=vNhp5azDFR6Le6dZMOyoNwKU4jtkJpZRkfZQdmq4tscbQM6LR5yYWwSsB+C4hAf50pT9xIHbaEMzycH+MHcJzoUK4mj29DzZmvQbCriKrwz0xk3d/4vjOX3MCtFeowk8tPnGv4KGRlNaxqEcpWaEXUAcWHLnTKw/3Qd1LazwUg8=
Received: from CH2PR11CA0002.namprd11.prod.outlook.com (2603:10b6:610:54::12)
 by SN7PR12MB7106.namprd12.prod.outlook.com (2603:10b6:806:2a1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 03:14:39 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::d2) by CH2PR11CA0002.outlook.office365.com
 (2603:10b6:610:54::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 03:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 03:14:39 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 21:14:37 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: fix smu v13 soft clock frequency setting issue
Date: Wed, 21 Jan 2026 11:14:21 +0800
Message-ID: <20260121031422.3431903-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|SN7PR12MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c61c61d-e17e-4cbc-6c90-08de589b369f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uMh8pxCdUvvPNLQxGZgAhqA5FlLMYDzupsS+H9F0G4LMQJZP/IcGwHvIFXyc?=
 =?us-ascii?Q?O5E3Q7+hKSzfm3npDKjgHH2IWEnReGuXxq+XkyH/xId5qDXJIsR8bdmc0ylZ?=
 =?us-ascii?Q?VLouBPFzOnyDQKgCgDZWZ84uqctYwVnfJ7qBrALwjZcCAvRCQBG3vOCY3hvz?=
 =?us-ascii?Q?rndw1Qd4DMQFZeiX3x7PxkOHi5CJAMnp0eBJj5Ebd8uSey/yRnOzbZ7YJvy/?=
 =?us-ascii?Q?JarNHl046TXfNkX59hiPSmPQJRbaIX7ke0bUo2MgzDbdZUtg/eDEBf6++fEv?=
 =?us-ascii?Q?llwAgkuOXOoe63faJGC9AOvpS0y2YPsjr1tSmjM9ljMcucY610Y+EwqUAWIc?=
 =?us-ascii?Q?6gF5Nq0/ti24poJwXYaAA1mBOipnRrMiiiqwTofn7/WCi+S6+uG1s3wVj6TM?=
 =?us-ascii?Q?6DowuAKD9hcWfnGJ6RaFyUvbuFhpUsxoyzdDk7dV2XGc3+AXAtdMx8jSeOpG?=
 =?us-ascii?Q?t9W3NemT/9ORCVrV4t6VlAI8CvD2soZd5k0oFEmYSrJuLCTYQrJEd+nvRSat?=
 =?us-ascii?Q?7DisMZOVpM7fvvCr4QX0igduolDFt3oi/5TmhVQkE49opq9shQCh7k9MU051?=
 =?us-ascii?Q?sckc9f3HkAQSNCWAB8UYiOG97uq3h/J6rgrCdxJXpBEHW4ehQf/fp7HVdB6a?=
 =?us-ascii?Q?wLRqKlAHj7JOABcgogZh32QA+fUp5tNsoZyA0qP9/Bbl/tX2ENDgHfCLz45h?=
 =?us-ascii?Q?+/FftZt8DJVVg9pU4y/A8eNnzfQcETWgdt8j8CSCFVWHJqWfgq4E29Xj2Trv?=
 =?us-ascii?Q?ZDvxdkb7hZbhiHb6OqgVfL741FMUJIKlL/hVK05E3qIrHqfLnly0c39uy73F?=
 =?us-ascii?Q?9hmtNGNrzUmrzvu7dezkYKDjrf7dg2/n/agnEgV0psh8Y1CvalJHAsvW8+7C?=
 =?us-ascii?Q?6W6TMHHhvERcSmPLLswoSW3TBUyUTj6q7IOhUxAgcCHIMSNEnkCOV/AHotjv?=
 =?us-ascii?Q?+dzQOyhnl4y2kLaSYgN62KF/VE17HWixwEtSETVle7VzcYDWm93nb+fDsY28?=
 =?us-ascii?Q?RaURkaqTf0WBvfRJK93y6ef3/EkVn3FIFrfo18b1qbD3l84jTswI/w2ki6AL?=
 =?us-ascii?Q?g+T9kutovI7PFuQ4yArvu3iYN2TLbBn+OAPGVbDEpBv/JQNTJkUa5DhXJhw1?=
 =?us-ascii?Q?ojDy0Jns16fef5BQ9jZDyTYCYENx69ZvtO4FmYSK1CRMvcxeen53hyIzwcn7?=
 =?us-ascii?Q?doII77Q6XPYondqfGbidbk3Pm2U5CL9nNGF3TCq4vc3ZEOElzJcXLDumZ3QG?=
 =?us-ascii?Q?a/FIg7qAV8kJXBPBEQ36y2vlhlhzWlGZCY0hd1MiQrSEjENAQQrNzueLEeph?=
 =?us-ascii?Q?3xVaPjkvJwOMEjZMg4cA+NaNVaKb0VTmMcHqrnYF+hy9RyHTuwpOyajzEZI2?=
 =?us-ascii?Q?Av0aq8DP3H4BlsE2aX008P0BhtW0wKEKPDqFvlXyATBkjyccJz7DYvWSqDrd?=
 =?us-ascii?Q?OtLfsFlwn3v97t0X8+hiVcOavwQWr6JqUwwqJR49OHIBv980NqEKE+gUwaPh?=
 =?us-ascii?Q?iFcHScDwe5hAdP3X6zcMdXnyNkFXkX3Ys6RGma+FsjswxChxvlH7RdwaSOgY?=
 =?us-ascii?Q?1FDCPBPwjgqAqj/0D4jnZ0Uad6SUfiHOFtcSXHiPJNMz4ssZXadEf/JbZdkT?=
 =?us-ascii?Q?F8rPyk5emfmNQHpgj8ksGaVklsDR7fpWd6cKf3r/dTQBgl3n8cyEZqZxUyep?=
 =?us-ascii?Q?WiVwAw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:14:39.2467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c61c61d-e17e-4cbc-6c90-08de589b369f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7106
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

resolve the issue where some freq frequencies cannot be set correctly
due to insufficient floating-point precision.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h   | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index efeaa3d57712..b0d6b7b0946d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -55,6 +55,7 @@
 #define SMUQ10_TO_UINT(x) ((x) >> 10)
 #define SMUQ10_FRAC(x) ((x) & 0x3ff)
 #define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >= 0x200))
+#define SMU_V13_SOFT_FREQ_ROUND(x)	((x) + 1)
 
 extern const int pmfw_decoded_link_speed[5];
 extern const int pmfw_decoded_link_width[7];
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 51f96fdcec24..e27ea0879429 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1554,6 +1554,7 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu,
 		return clk_id;
 
 	if (max > 0) {
+		max = SMU_V13_SOFT_FREQ_ROUND(max);
 		if (automatic)
 			param = (uint32_t)((clk_id << 16) | 0xffff);
 		else
@@ -1565,6 +1566,7 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu,
 	}
 
 	if (min > 0) {
+		min = SMU_V13_SOFT_FREQ_ROUND(min);
 		if (automatic)
 			param = (uint32_t)((clk_id << 16) | 0);
 		else
-- 
2.34.1

