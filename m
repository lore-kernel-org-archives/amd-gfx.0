Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97284C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 14:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACAFC10E05B;
	Fri, 18 Apr 2025 14:07:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dQAWiAvj";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C93410E142
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 14:06:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0ojedWvEyfu5jEdRt73ZkWjGwd7n4r3DypGz7pywkgKpIwV4u4Y44IaQi39zYkRmpdRyIY2Dphl8h+OXy0J8d1rPyd+DQ3oifAPJF4/E9FkayaxQJkkCMWotBZdwgJsmUd8PPaEnYKnG456dGvPjX9Pmtl2SRnLbXOmRmhRUBzwRj0YC7DLF0ZERMJr2JwwgxLsB321opnmQgexBlp8+zFnhlWMnlAjOB6ucrsewCg+pyvA49di42Px0XtZGeHWE+w9PqeJUyBErmPm+rXqWse6tH7TiA5DZXqqr0FTSUvYHt0PBQ6c2OcwA5RvkVKUmqgiHpoyq7/ib06rJyLgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Zrv0Weq7AKWJ3nfC3LA29HFS4h3wScCR+cWkTsGJ0Y=;
 b=obG7yTBEj2JxLt6PCu+tUsKuEDXsiZpXUZRGBtFMt4CUCka72SEdtdzRVA6ZcAKnUZ6bbWTZ+szRXBf+NUIIHU58H5ZuQzPUgqB1snbC/fV5niQwoYRn3WG1/ksqbmzNJap0SW585oWYDOn0VsBVNgf/s9xk/6NwhX/6SA8GTx3fhAi/6rwaObjtQvEwpyZ00KUVBUbx4HdNvOpiv4RVGHHMLeJS1xfkIPHM6/srafTHSERqDyyKUlhE4eTxQUKyiN6WoI2ULDtxPAsGfxnKUSUITsEQ3GSpo3wFl6bmFjAZo1rTLQirMUAr8/eG6YXjABVdl+TXJPbDMtjggc4MiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Zrv0Weq7AKWJ3nfC3LA29HFS4h3wScCR+cWkTsGJ0Y=;
 b=dQAWiAvjD/eRVlYM9EtX8ANRUK2mQTfjDCcM+rShiCHeEziffsfPkhISBM6Pb/2gB0tfFL6e45hQ6USlBZqeVrLwHhssnehOKlbq16tZxK/VxASp93pFFm4Vq3jIpD9jY0sUUZadsEOUwm8uHnNRLKyKBIxvdEbZF2BfOKmTnuc=
Received: from BYAPR11CA0095.namprd11.prod.outlook.com (2603:10b6:a03:f4::36)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Fri, 18 Apr
 2025 14:06:51 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::c1) by BYAPR11CA0095.outlook.office365.com
 (2603:10b6:a03:f4::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Fri,
 18 Apr 2025 14:06:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 14:06:50 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Apr
 2025 09:06:47 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v3 2/7] drm/amd/pm: Update pmfw headers for smu_v_13_0_6
Date: Fri, 18 Apr 2025 22:06:28 +0800
Message-ID: <20250418140633.420887-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250418140633.420887-1-asad.kamal@amd.com>
References: <20250418140633.420887-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 007070f8-7ac5-4153-fd0a-08dd7e8243e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yGevA3CZ2gkSyqW3eNrwR5TZD7lpfKoAyDFPEbZwgi0RwANKigfB/N6UerRS?=
 =?us-ascii?Q?FQdXrdBDJQIt7lTKBYK9j/P7+AziGqPE1+l5yBU7QQGqg0CB0d0sEP1V8eas?=
 =?us-ascii?Q?GzuHNFn3QEbPQCIcm0DTO8L/dOWA9zW+mtCc9PzY3I8ZwSTa35wCKn7T0kAL?=
 =?us-ascii?Q?PbLJtPSc6KXBP8MFZ57kCVUcL8Ug8pwUNgedatamRTC4o3GD6CCPjkoFB97K?=
 =?us-ascii?Q?UKo722YOtiZMtwTI+E2pBiJLfEBQW5SZ0HHo+mhLmToPUzQ6/HIwjkCt9Bwp?=
 =?us-ascii?Q?kB7Zqi89De5/57zc4FLkOf4MgpCDQ/0oV+T8K3IrDisyLvn3cv1xuyyYdrnf?=
 =?us-ascii?Q?nE29g7WlGmdlvwK//OU8CnX0HGqrgdQ3sgkWid79e1e9f8SabSQx/9x/vWX4?=
 =?us-ascii?Q?SjLqgJbSnZqrjTAg314fTLSHiqh5F3fOfHB+5/bIr2VOjZ+EL7DAPvuDXWLH?=
 =?us-ascii?Q?WCPr6crbRFqtgBRGCXg4OvbeCrpfwvXTNdhwnRZHcPNz9Pd9DSoXCR1NxWDh?=
 =?us-ascii?Q?uvi5jIviNozOfOBB9ydW/MsgZpHnpgcysc65IbF+Xb7TtpTyRiQ2pEeG7AqO?=
 =?us-ascii?Q?F/EVAq1+8qh+OLrkJtQlO+szr2QbqWG7kipNBLCO4BE2zZOLkMOi38g19SWY?=
 =?us-ascii?Q?YCj5NR3sgbuNTZP0wg9GojvQzVDMwjp/YJFwiHt3MJJ69gGSQilim0/cHz2a?=
 =?us-ascii?Q?0Lbs7sBZw5UHMWGdxbftj15RCorZy4CWTSOOKVvPJk1JXck7ogZdqC4lCg4E?=
 =?us-ascii?Q?pbAX04D1NJhhF37hMx/0ApWHOp4yoTs3DyXz4ysNgS6pOolWDfRW4zl36Ke5?=
 =?us-ascii?Q?Am4hra3vdS7rfyJpEeTstIPWGxngy5BIo0qRT1TPjmx7TahYCPKT9gkHDN5W?=
 =?us-ascii?Q?l30Okr1U6fQc5zwRgm55j2z2SshXeyds3ZInrX1v5ujEpc30wuHhmezEEPyv?=
 =?us-ascii?Q?CdcOy4LUFhPQvauuzJGvMiJ+hmqDGm/nu0ObYc12QTBUmsLsjCsNBm1VEFdE?=
 =?us-ascii?Q?jhsFoKDxzO+5Ribqx1nHvpqjXVKt3JVIfGuJVra10XtB/gYQyUXI4zmD87Q+?=
 =?us-ascii?Q?5CMT0ZtyZDtmGyGc+Qx2w1NFLEgXiyCzlb3jdupUBn3npTy/BC2E+UF83xbp?=
 =?us-ascii?Q?VOgbMfMPRk9uTCTaV9PbR2mfHlhoJMyK5iykXuBdIviRC5ysVzwBOvoJ2cCt?=
 =?us-ascii?Q?SUHrF1u/ultWeebs/dS97KeM8668twh2AzRBZ/09bbCVJbzMRFHyCTu8r0r1?=
 =?us-ascii?Q?GCpyyMQeSghoWTmGz7WnMWEfRxrC4+6wBgouwORYL9OYcB8TcmtA8wuCfG0+?=
 =?us-ascii?Q?rpGkCSwi3aqFBiOoxloHnUZ2WA263kWdOdQf1JOiczrKQqPUnwBlty9CNSpm?=
 =?us-ascii?Q?aGEku3FEcaIvWvqWIPaZiosk4q4C3Lm2lL/JhBQk44M5mUrmxab7aicPYsuW?=
 =?us-ascii?Q?KvJg2LK/IbUVa0Gxl6HtfC7O/XuIUok6nxHswgeGWzTlX5OBS9wMygt9AGFB?=
 =?us-ascii?Q?w1p+jkFVKnJb20fzLob4ujKQVcnBEDcDKVmo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 14:06:50.5066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 007070f8-7ac5-4153-fd0a-08dd7e8243e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
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

Update pmfw headers for smu_v_13_0_6 to include static metrics table

v3: Update header as per new fw to report voltage in volt

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h    | 7 +++++++
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h   | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index d26f35119a12..e6760aac8ca2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -459,4 +459,11 @@ typedef struct __attribute__((packed, aligned(4))) {
   uint64_t AccGfxclkBelowHostLimit;
 } VfMetricsTable_t;
 
+#pragma pack(push, 4)
+typedef struct {
+  // Telemetry
+  uint32_t InputTelemetryVoltageInV;
+} StaticMetricsTable_t;
+#pragma pack(pop)
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 348d06a3200c..41f268313613 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -95,7 +95,8 @@
 #define PPSMC_MSG_SetThrottlingPolicy               0x44
 #define PPSMC_MSG_ResetSDMA                         0x4D
 #define PPSMC_MSG_ResetVCN                          0x4E
-#define PPSMC_Message_Count                         0x4F
+#define PPSMC_MSG_GetStaticMetricsTable             0x59
+#define PPSMC_Message_Count                         0x5A
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
-- 
2.46.0

