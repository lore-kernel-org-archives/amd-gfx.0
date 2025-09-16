Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89383CAC592
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2832E10E7AA;
	Tue, 16 Sep 2025 19:12:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IQ50lFLs";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A0DE10E7AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1iZp7ZQ7zCvjFWQ8Erh8lA7Gyfc5NAbT+TgnJF1zkID1uDvuZYEX2GxHMvjtcAU/wwauceF+S8Od8kQKxijxi98R0rCrv7/UOSWXTufnDmYPsmVWrAR7JR7zdV14lToyVypNhPfPoXUnEFn60Xn8JdyC14kEXE28kFdSSVAk68nIUD0wiKoFSIwVpwavPy2TOlHoSikizTMVAS2XTPPBW25PejpvcRXrq7mc9YTj1zttbe/R5zwiYw8W6zt5jNTf3OsrxgItWMxLhCfFZPAeXzrM3oGYn0JEDkB5cq//6zk8h7zlia/RgBBQoJPu7oH6Ny+32nffD/KP2NSQnCD/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RiTi9yu0AgTjgU1s9uhPmv0qUjZVYMx7UFGCkBZ0ms=;
 b=qCCVaXoPS62lgJbXMfoOVhh5EH9q+xbmpGjxSGUriALHfAp3VR8iPNhTA9ikHMIwULpQRvWIDjr+AIkdL1GFvTVB4qjb20u+dk9XKwYjFgwYdAHLXmPJJN/8+R7wn+VMzywjmavVfGtg3z8FBH63okuEYbt6+fE8PL04fht8G6/QflbcGu/mBPltDSvNN0mLu612zoWy9zyBbCZKA/r2rEAttvGrYxnuDdECu2i6pKl+owrnTXEaYWdbqdZ6h2NjDcQx7cPQ7l2gR+8BHxXhK2TbwQj8accgymYtqmlMMoe14UfjdcDyIhVPJ90d/aoM/JcWMnLApzuCa/p4QAOEKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RiTi9yu0AgTjgU1s9uhPmv0qUjZVYMx7UFGCkBZ0ms=;
 b=IQ50lFLspyTEAh7XY3fR1evBFXYlUuHmROjKqjZKCDIzenKILq1Uxmx8chv5jQnXh5KcVuHRBZ/ukMaZaxtIeoiQyVqhgBJDXR3RyHGsi0QOI7kkwUJgdU+26JHf6k8wLoBN6mpYdV1jUAmc9BIGy5w0Pg9inOv/v0VW0AqD+wE=
Received: from DSZP220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::6) by
 BN7PPF02710D35B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 19:12:30 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::f2) by DSZP220CA0002.outlook.office365.com
 (2603:10b6:5:280::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 19:12:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:23 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:23 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 19/20] drm/amd/display: [FW Promotion] Release 0.1.28.0
Date: Tue, 16 Sep 2025 15:09:39 -0400
Message-ID: <20250916191142.3504643-20-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|BN7PPF02710D35B:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e91575-6497-486a-cc1b-08ddf554fb8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KnzuCG8R8wNNEXeVv8SoUWaBhmDnpwTyvsSnrPk2StUWvcnFoUq+ZLFkIORQ?=
 =?us-ascii?Q?A3eNIrO0Csf8429lyulx2lmGOwhXmpG2vj5fT/jBQsNoBpeV5oQwwipGfp6k?=
 =?us-ascii?Q?JVplfqXOz0IMTDBpuYKkN2QATftXR6+ElfBD/tc3jj2CYRPasYWIZg3x9Mkj?=
 =?us-ascii?Q?SG/bXCF/7MMFL2hVljv44PiIqWK0rwAQKXG5rhb6IaA5aMKe9HUMZoGqmjwh?=
 =?us-ascii?Q?OqswYkTRDVPhwtFdEKticDCkqhx/h6EmbnYTJmZUnRjCnIYsRFzawDHmZAgg?=
 =?us-ascii?Q?yo8c3cZn8CvjFQg8bKoTcEmsjBz7U6laNhdelOTEZ6ybH2q7CELbLhFa3KgP?=
 =?us-ascii?Q?7VAJmUSbdRFwBtkexZE54uMS81gtv/bSDhsdA4h0V+1y08FeIvMqmpHiuCKU?=
 =?us-ascii?Q?Defb8Cyre29iOtlbO6wU7v1i0PLShHAG0MwjsFN2b6L6FgWuJS5qUUhcckhJ?=
 =?us-ascii?Q?92gpFEFZH25e9YqmDMkl7hYaWP0s9qNf7ZHi8Aq4XSiTO/+U6jJVKeNgUFfc?=
 =?us-ascii?Q?kBH5SCY2gMe/1dumtjWxK2mABMSHANJckkVWuTKK4YhYU1EsWAMNwTIfwJMy?=
 =?us-ascii?Q?+nYGdjPUrzEMoSk4nzxeu/SKjqG2EBaT2Pz6V3kZe7NjnYn4XmavaiBLAMZr?=
 =?us-ascii?Q?o8jgOEp3xBwNL07k0iSXQhZXe4i83gdj/G4saZR9sRbaLPRkpfZX2V+qYlTn?=
 =?us-ascii?Q?QuWcav+RxhOuD7T7Z4sRD+6UBEltR1l90uBgnA601ys5ffwEgA26dpd9ORK7?=
 =?us-ascii?Q?RlkaQsnh+8QZnzXnUUNcK0He4Kf4sjsY0fHGmI2a8ImTJSbmq2GWi1TVePAo?=
 =?us-ascii?Q?V1XoVRe3AheooNoWcXcD3SdlPITwrTR/ohgeVZXtEZn61CJgh0p594115IqZ?=
 =?us-ascii?Q?VERLmidgyFSHjxHoEM6VQ0vMbCgp1z8nt8k8VulPg0lXuIO8ppkNAtwYOSvm?=
 =?us-ascii?Q?ClHlszBBqcsIcA6kNYjRExmL40ng49VJ9a4cs8WLy25oPIvrrrHUlD5E6Tqk?=
 =?us-ascii?Q?kUqiDIJnNKP9buYSpIw98YtKU3eNXwBSzsdo86hnuYaA76MzPtVKRfiAtqKc?=
 =?us-ascii?Q?XZ5gRqbm4O+vXFQsADXvhOX2ObHDnGJpSxGPLcEGz0KaekL3E2rZE3Cw6WzW?=
 =?us-ascii?Q?hH06mjR+GUw+1o1Ql2/l2ivt+hG/4TpCB9brPZPc4ydLlSALBpgeX9XOa+Y4?=
 =?us-ascii?Q?cVF8bGLeWU64uQpEu5ofaaf5p/sv+iKZ3flJ9p/dzcv3J7PRSM4N6WqdPfzG?=
 =?us-ascii?Q?naQlb6pyB4wwsWDN2eAyYbcd/xZsAvNvBJWFd27Z3BlftP0umToGIsAflxgp?=
 =?us-ascii?Q?4sAIAj7/Y5JV0UcVeNalrIbt2WvbnbWJGWBicT5LU6ODqd7a2tN7i++tTEo2?=
 =?us-ascii?Q?dkD30cbwlZS/AkJAjbCXIk1Xrl33hYmjBW2dORIa1v25EurdtP+yCa4u5cto?=
 =?us-ascii?Q?/TH8G/QXRCQJfhnPAMQJjnw/S1Yi3/ZTmxp6RNJj24Iu7gmdtL4oVMK9jIr3?=
 =?us-ascii?Q?Wgxq+rApm823TuJbreIfmgAmdE1njQm7nV/I?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:30.1963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e91575-6497-486a-cc1b-08ddf554fb8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF02710D35B
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index ef8510bab32c..4e6290f19fe7 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -4143,7 +4143,7 @@ struct dmub_cmd_replay_copy_settings_data {
 	 */
 	uint8_t hpo_link_enc_inst;
 	/**
-	 * Determines if fast sync in ultra sleep mode is enabled/disabled.
+	 * Determines if fast resync in ultra sleep mode is enabled/disabled.
 	 */
 	uint8_t replay_support_fast_resync_in_ultra_sleep_mode;
 	/**
-- 
2.43.0

