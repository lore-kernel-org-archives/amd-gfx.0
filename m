Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B765C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 13:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28D2710E339;
	Fri, 21 Feb 2025 13:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vr09mDqv";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C4A710E339
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 13:52:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAUYsD9PPPycszT82fblAPWZkkIF7MiRcoXkFEVHOSExUSSNnjrg03bVP5PX6pZsnPne9M4QgyGerGnTYNT9pwJkIX5knSXzsX340BTLuyRLwqejWkiJrEDWNYnFmusjdxTUhQJ0dyNdxzZIQmwYYpdNpO9eo89i+JDsGUsDJAmNw7mD9JlLJCkpeWIllR7SPaycejmtXOLH4xrZp71UEIs35dqMiTdUehvgpSzaDgo6up3wrn3P+1Iupu5tCuWalROFz7QKPninx8PegQ5wG1r37vzCO4janQXhw1OrNRrdNRXFnyV+x9zur4kEn3vUaWVJ/9kFQSYR29pzuSlJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJ90gSY+UxzMVN8U3ZTQd+ArIW5Pnpb0asfGzOXSXp4=;
 b=qOwDB1M3gu/Cee5XSFcnuWeamHtsRmmVBku7H6fYXpSIlzUrfeeNokcxTeCrR3FKMwewfeEKcN2+iemHkeYpeXmQ8HMvEGFzvnEPfUwOFOZuCPTGUNoNuNRR83pYhelcqPu60sBmWa2dq6/0rbn3NANu8gPFM1wbLL3sGdsbpWXL2otpyL2xWD/K6Um8gsMPtPLDqQoXzve1QUiNU6YlY8jHZL8qcVTb1adoIifOtXHSNcTAV6pezIGoQ2o13IDBLElvhb0iL9oND0FVQJ/fcxIgCwbmh+ckYr362LmxWC2DJJYnwvR+3uU0rLRhIAS8VO/0RQSCNvyn9LMxSU/agg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJ90gSY+UxzMVN8U3ZTQd+ArIW5Pnpb0asfGzOXSXp4=;
 b=vr09mDqvvhc3y+iED9X10BU7kbuWdUPK4QXxI0oPqDrzFn3QmzFBZ4bW5kWF6niq2IAodn0TvUhvrl4d8qL97L0Djmy8DUm9t3+4DmXKe2+WT2s5+U/M3u+/yVrr4XbPe6OCefkO3FVS6I9887/j1vqYXPHPXwRyva4IscI3ZwM=
Received: from CH0PR03CA0054.namprd03.prod.outlook.com (2603:10b6:610:b3::29)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 13:52:28 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::4e) by CH0PR03CA0054.outlook.office365.com
 (2603:10b6:610:b3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 13:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 13:52:27 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 07:52:25 -0600
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>
CC: Mangesh Gadre <Mangesh.Gadre@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amd/pm: handling of set performance level
Date: Fri, 21 Feb 2025 21:51:58 +0800
Message-ID: <20250221135158.2582632-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|CH3PR12MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: cede4bc4-44b2-4c05-4c79-08dd527efa9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b8ctWPiILEoVFQgqV2tBAzEYCbwGo7khTZWxOXj4MRvlI2XT5OSNMartaB5U?=
 =?us-ascii?Q?2nWMpB2yGAEF219LuHguOs5sWJ5k8vb9yxayjMdv7isSLrK5bsFX2YRpul4M?=
 =?us-ascii?Q?lNui3fo8mtCvmt9A4F02mikFQ8sO5qbLh3sllkBe6USB47/EyiSAzc0hmX5j?=
 =?us-ascii?Q?5w952X8+B7BKeebXqrGN5B+Sp2BgsSc0zMG1gT8gr442YxtOl5imZ2rEVfQ7?=
 =?us-ascii?Q?kYK0YQacxKqSKQGWJWVgz1LzVC0fqKfQGSc5cIuDS6UwI2SkK4ukf1Z7HKiV?=
 =?us-ascii?Q?6jrBM9b0E0IH42MgyAuq6ezdxKlBKcBUd17ZSAySjH0x2Az4aNdrsAZqNZt0?=
 =?us-ascii?Q?wQMBrZcwe2fJhgQl/6BCw2+fpJBhUP05ltRwp8VqCuLIT1SJcHN2Mwz9LH/D?=
 =?us-ascii?Q?4jxxcwrp9u6z5bvSvgyVisa0zEUFXhV0BlryX4eg6+Uk7bGj2p9ucudJIWk+?=
 =?us-ascii?Q?xhc2XiETra7JTB0pqdd9Bu94Fcc48V70+GrGnEGfzWE806PwzwSu2Wwve1p9?=
 =?us-ascii?Q?3y2i+tIFSSLCny/oRYZ1W2al46OYdptBH6JZj3hJf9Gu5tc6SI5EdzsumK2w?=
 =?us-ascii?Q?32BxCyS/QvIxKiGjcdRrCt4SgdniIythTPyhIpT0WWPt1mazYhblJsW2z485?=
 =?us-ascii?Q?rPI9ZUnXWjn4HJg6IcAEV/MCTY6LX6D8n/rAlp/ZTsBTP9G44wQvSgFjNlUM?=
 =?us-ascii?Q?8qO+ZcOI7v6I4ppGIlaQiJhMkSQdjSndafSXfbdV6PC6lN4oKNnNWzXxIWW8?=
 =?us-ascii?Q?SmQef9rlPq4no8W62bUwEYNQbdVAxkNDshYrGOovRZySoXEONqkiSHSbmW0J?=
 =?us-ascii?Q?eNUc81ONiWv8qTyZaKU7yK/QuRXBvwrroR0cDB+MP3mhZV3NPEbxJMeaxKcx?=
 =?us-ascii?Q?QWjHgbxdZ/wNs5iayxyvNB/Fvj6xoYRfRS5ZDYw4ylaJkQ+vYrom7Vhz+U2X?=
 =?us-ascii?Q?0yO0WqcpGk7KqiA4L1oEGtxqpFmVXXaS70FtS/ma2piu3h7xi9ceSGOD89QH?=
 =?us-ascii?Q?cpZNZA8uHTJPB0rzq+zS9fxbZ4+xLyyFHCOCQmduCEH7Yw695eJNRl03P4h/?=
 =?us-ascii?Q?KUOj3xqhuAEXKmpe0Hh/saGC23Bv5KPyrwcGCiKumQAOZQ6Q9URPNIhxkInd?=
 =?us-ascii?Q?08vuiHh8nexDodbpRwueYyw+uWux6IYEdMx0tAoyuyjYzLbRbMW1XwELD9QD?=
 =?us-ascii?Q?QZjTRm6YA9RzueKJDt0tmx6xCR9im9R6h1aNW29kO41DcqpTg4UT7i7MlZ27?=
 =?us-ascii?Q?25mVOEsEvuxK3oAJWcgYdM0e0iRhBB2Q5gMPNYSWYE7+TlPtwuMlrd2Ym+Gi?=
 =?us-ascii?Q?onqMXBmpE5BT8VDUEVvs4c7TuDsv4bMJDj6FTBrblk+ef3lFJh2XQT4GF7uh?=
 =?us-ascii?Q?EpxTMVh7PFt96K/9hxNrj5VZk+44hW61h6iQdAperM+dlQ5brTTqGetZhGzQ?=
 =?us-ascii?Q?IFAkXTl313yXexHylELvLu1FyowJiz6MM65ljO14I8v8elaWvNmvk/XHkmLa?=
 =?us-ascii?Q?/wlmoP2iMJq6Pb0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 13:52:27.9797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cede4bc4-44b2-4c05-4c79-08dd527efa9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121
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

display performance level when set not supported

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d71c8c58caa4..c3552e0cb35e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2315,7 +2315,10 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 	if (smu_dpm_ctx->dpm_level != level) {
 		ret = smu_asic_set_performance_level(smu, level);
 		if (ret) {
-			dev_err(smu->adev->dev, "Failed to set performance level!");
+			if (ret == -EOPNOTSUPP)
+				dev_info(smu->adev->dev, "set performance level %d not supported", level);
+			else
+				dev_err(smu->adev->dev, "Failed to set performance level %d", level);
 			return ret;
 		}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9f276f393b81..7fff57900a58 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1947,7 +1947,7 @@ static int smu_v13_0_6_set_performance_level(struct smu_context *smu,
 		break;
 	}
 
-	return -EINVAL;
+	return -EOPNOTSUPP;
 }
 
 static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
-- 
2.34.1

