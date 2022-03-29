Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1F4C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 15:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4C9D10E8C8;
	Tue, 29 Mar 2022 15:10:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7786510E8C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 15:10:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzpqR4bUKaXjEsMUGQanVz52ZQ/wrZSPhXgKecrD8dmzrF1YfZ/rapOkWmLMLS1je5NmSAA9tVGKA38qkY0nVaxarU3AmGbgVBDrLo5EhKdH5F+vCcSHyEHcCgIIIyOs6hD8g7+IWfouTscZxFPCrztTTksW0nUhvy1DIwYfDTiLLoQoniGURCqLtIMnFMZsTKKNnXcWOPOTOV87jmKFNed3Pjt2qUwYO1cxDYClgHp2K5qEHxDAAIBhIZGHqMJa1tkosCiWQNudvVR6S9TZffhc02BRFtmDF33cnMyfNZmGrssoxMmgjQo1/UfrWl35AYiyJvjz2/vAnpec4h6zJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JH3Cwq6+c87nI3edAiAhZBbr1HxRseM1PBcn7p6116c=;
 b=dAXqO/vWE4vGNp+YO9zNdnja5BszGm++Uk3LC6CS8GuAWj8muZu7Y8PIz4TwAFF9OAwF3qduVWfo/nVkIy2RwaRkip3nesZfyhZyzjGHVHFrSzIvpJxZlrnxmPkO2SHfUHImxDHCy3jKJ9mDNSIB+TJWyCChNv53s2Ng3oKOvPlpPbwkwEQmpdgEG1S0f8cLG5T8qBDBgMcxfYd2tVXjCbisEOj3UzRP7gRMmSgM+PqNcvmwEdTsHkl/wu8urHP3h3s/iNQ8qHgVU00nJtT1h9wlRibhsCFugViZzFUYLp437sjSy7OX3i26VtA1d00C44NU+1N5NUlNdcxAdfEINw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JH3Cwq6+c87nI3edAiAhZBbr1HxRseM1PBcn7p6116c=;
 b=dNk0fNv1Btk94HUZcX8ClmtyXySbfN9ZXs0zthbZm5V9JAbtaghkKzElxhnkMUzgBNP4eL+1af6QLEV2p2FauDmwtVBxHZu0VrXKWVindr91O18Wt9lqDZjrkokyOUGowggJBUKHVh/Wy1//lcY1rd+NISBJl9A9COpZQKEtYKU=
Received: from BN8PR04CA0019.namprd04.prod.outlook.com (2603:10b6:408:70::32)
 by DM5PR12MB1145.namprd12.prod.outlook.com (2603:10b6:3:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 15:10:06 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::cd) by BN8PR04CA0019.outlook.office365.com
 (2603:10b6:408:70::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Tue, 29 Mar 2022 15:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 15:10:06 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 29 Mar
 2022 10:10:05 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: Use metrics data function to get unique_id
 for Aldebaran
Date: Tue, 29 Mar 2022 11:09:50 -0400
Message-ID: <20220329150951.1311452-3-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329150951.1311452-1-kent.russell@amd.com>
References: <20220329150951.1311452-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f282cd9-4b77-4f2f-599b-08da1196356a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1145:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB114512405AB3165283B31D10851E9@DM5PR12MB1145.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnv/BC8GoM1lpBtAhnb3MqyXAoxJ08nYrJjZ1C/L8dq44mmEECrSn+LnSAVLlPvFmWQUEUTRFjaNhNz1ECDehS3+GELF8MpqDn1SQIRZ25qzpNJiCQBpkBPfxGOyER7UHU9ZcajpyTGCLbUeLoIgLzBU+M+/oIHUqD/ggMXj6GBYwHPZEyOmo3ps1itDoKvWGHAmcy4blvlKDU7aSLl8ZLVx0zHB++VF/6v8K36WryXcFyiCW5ZpnVdu06ttWAH+kHuvZG9GIkRHQZVg8douBk1PlVs9pibiMS5txTeVqH2sCAZcjRpSYGh4v+z8SrAXPh549kMWuqCPLRbe2Bb4Ko1gRLLp4OwvhBcCSAtlJo+ON+BIvnBL4bZa+8x0yLEEG2g7Nlihgrn6euEhObb973gSxrzPPh5qWh1v73G8pkHDpY1fbd10Wxj/zEmZR8ukfcwX9eRFoxwVJIa530/13823uQxd5KEgJ7+kW+Yw1JI85iA2ZDDv103zj13p9xmeibVjVYpedxlsFRZkKtHwzoA5eQL9dg1JaibdM3y6D8xQwyDCwcjqxZ8oVgyunDZGca1oUuq4KELQOC77G8/5zhhxiQELx7hkvAV8CHPZfMc2fgFJxvA4/Yv4DoZqM/xWUu7ltqGbHvX8dYpku/1uhlUOKZsVhtueKNgL0PgxfhlWHunQKRiiGGlQEeQ0jNuod1RpE7mm4WYb92D/wQ9QqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(426003)(5660300002)(16526019)(186003)(26005)(82310400004)(83380400001)(40460700003)(81166007)(8936002)(508600001)(356005)(336012)(44832011)(47076005)(86362001)(2906002)(1076003)(70206006)(316002)(36860700001)(6916009)(36756003)(8676002)(2616005)(6666004)(7696005)(4326008)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 15:10:06.4650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f282cd9-4b77-4f2f-599b-08da1196356a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
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
Cc: Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is abstracted well enough in the get_metrics_data function, so use
the function

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index cd81f848d45a..38af648cb857 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -650,6 +650,12 @@ static int aldebaran_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_THROTTLER_STATUS:
 		*value = metrics->ThrottlerStatus;
 		break;
+	case METRICS_UNIQUE_ID_UPPER32:
+		*value = metrics->PublicSerialNumUpper32;
+		break;
+	case METRICS_UNIQUE_ID_LOWER32:
+		*value = metrics->PublicSerialNumLower32;
+		break;
 	default:
 		*value = UINT_MAX;
 		break;
@@ -1614,16 +1620,12 @@ static void aldebaran_i2c_control_fini(struct smu_context *smu)
 static void aldebaran_get_unique_id(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	SmuMetrics_t *metrics = smu->smu_table.metrics_table;
 	uint32_t upper32 = 0, lower32 = 0;
-	int ret;
 
-	ret = smu_cmn_get_metrics_table(smu, NULL, false);
-	if (ret)
+	if (aldebaran_get_smu_metrics_data(smu, METRICS_UNIQUE_ID_UPPER32, &upper32))
+		goto out;
+	if (aldebaran_get_smu_metrics_data(smu, METRICS_UNIQUE_ID_LOWER32, &lower32))
 		goto out;
-
-	upper32 = metrics->PublicSerialNumUpper32;
-	lower32 = metrics->PublicSerialNumLower32;
 
 out:
 	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
-- 
2.25.1

