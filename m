Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA561C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6519610EA99;
	Thu,  6 Jun 2024 21:01:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="osfGGjL6";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 312D810EA99
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:01:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ce4/XkrZ/48DFVYypBnLVZYdgrFj7Q/TwZ/8/m8RRRdqS2kN3O8drGRn8IM9SYy/vlpvgaBtrfoFqewHSSXWgd8REN0R7unX5CWk+s+mVnlD2QFniLIcw4dHaScWAY4/h8gX3tn3GkVq4uCs7z49NeP+h676GF0RxS7A4Ry9zESx9bUsfy7sDCP7yMkuaUihv9QEwx95GPjOaqh7rbwB541poDXyVWYA8LVh3D/Wly8t/b9MdLElvIERCkBWpRjHgFK+YB4fhnYQOnbqEkSu5xW2NUmZFcXRgOHhdxD+oY6jtUQdIrkXl1I+mhc9hudaTap6u1feMcXYw5Zs4zrgDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJNNubwPauCoahu4MeyDQ50aLdt7Vt+gXYUMwGqzYgc=;
 b=A7AA/BzYQ18AnrAqC1RA3dalEiYvOnb4CTnGtYKrDtY0rCQ/XxY9RHwuYueQSTrmysJWZ1w6vy5Z7pV+ZfyvurFv4gyQ7+hmJtRwxQmJ8D+ivXryRXJwKp6aKL4s1AA2O3O83W7qYthA4AcUCClbtnHVWPNEYyvKaqMzugVhXHnJxUyQYCryFTEoREWSwlP3zc3hFSCjS4QmWVadQkFrDMTpIlsf6c5mgw8b51l51ndRMWSr2s0z6Me6n7ND4NT3KvIXRoErXMcenm+os/+H2ZQ8i1sZ4kndDAJLJIlIW6FkKZrzgP8tOCmebhIhNoslSv/o6vefaVyVzjebrfCUdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJNNubwPauCoahu4MeyDQ50aLdt7Vt+gXYUMwGqzYgc=;
 b=osfGGjL61gNbIxBS6/N/ySeh9jipgnpZpA9mW0kkDYP+n70Q/YvHV+V2d/0q+W3eYUrqlSXxPkZrHEuCuA3gLp6UG9FkXeAY8k4zBUp2k8DiWs+v8KGDSJiQmicVC5HjX+CXgwGQtUCcjocDrda1k3x/+cpvCL40vmFuG2jrnw0=
Received: from SA9PR13CA0019.namprd13.prod.outlook.com (2603:10b6:806:21::24)
 by PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 21:01:54 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::8c) by SA9PR13CA0019.outlook.office365.com
 (2603:10b6:806:21::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.12 via Frontend
 Transport; Thu, 6 Jun 2024 21:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:01:54 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:01:52 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, pochchan <pochchan@amd.com>
Subject: [PATCH 01/67] drm/amd/display: Use TPS3 for ALPM on Specific Panel
Date: Thu, 6 Jun 2024 16:58:22 -0400
Message-ID: <20240606205928.4050859-2-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|PH7PR12MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: df7ebd0f-6f8e-48af-d045-08dc866be562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wtn1GvU4r4kbFEp17n45f7UG9k6FFj2efeF5+W6MkZ2OOCMPmFgvvUf9dfcQ?=
 =?us-ascii?Q?G5Wavh+uI7dxu5NKh34RMzADEjJHtXUZKrW19xEIgjEhy0NTvsKy7CuKp0iZ?=
 =?us-ascii?Q?ydAFRkWnHXvbR0AVB4MegjEVYX1eWypc9+Eb7C9wdVRcISNG6bWJBt/iQAJQ?=
 =?us-ascii?Q?r7zjNjxskS8qQbp6sgAPBYStgD2VePRjQd78dyI0AceSZRW7t1NPLiQQkxQU?=
 =?us-ascii?Q?LqvNt9fvW5OPnhko7GWhkz2RxHnjd8wEDurhKh/iSIE0ugZtUQ0+MUpq5Bji?=
 =?us-ascii?Q?OlaUkmbCUUTI5sBWW4TH2mbIDE40XkhbkC7lLh+R4KfEHf5YgXoE4m0nqde2?=
 =?us-ascii?Q?dey2MP79L+z0/yKE5DvQTf02vrwW8XU1oinFVAhSiVDY8Tya9O77T2y4P0df?=
 =?us-ascii?Q?cSdy7INZNqNFbZX77rDzHHFJ5UaecBc1929Rl7o4718C4IGiOvY+WFOAbcgG?=
 =?us-ascii?Q?PS+2Zc2v0YUwMmBYI9OGjvTIAd1Y/151upivHnx0WrypPjd3R7eq/LtxE3+4?=
 =?us-ascii?Q?f5nBIKB5dsLGtoTJL8eYTMrb1o3j2aXYdn4K74CTXIMYhO6BkB0AI2P5ej2n?=
 =?us-ascii?Q?1FKsqDeHI9jY2O7o9wxHheC7UWZa1imhozzxmKoIKsUPEZnzMIrKXQU4nAXi?=
 =?us-ascii?Q?7Qx1/pofPx28uz2Zk+HgrukPdGNy0kTGa83EWG2aTLfZ7QCgQ1B4VxJRWaIK?=
 =?us-ascii?Q?m7k7hyLdo6S1oXiH/Ckp2Q9QIG1xT/FHqSSmfXK+G9vIGPakLOby/oYvzSTT?=
 =?us-ascii?Q?iZitWJPa1U8ON6fCnf72p6kk/oNZUawTh3Ar/L3b+6Po0DFMSJaGdyWaPQ8c?=
 =?us-ascii?Q?y8A0e33W5y3JJc5EA37+xWXGY41tc72GEoEQdFBL3pcaf2ecAw/VenT3hMo8?=
 =?us-ascii?Q?HIPTDOAphkTu6dS5jsLATFd09a8fTB9LGWy4agEKIHfW6cipuP0eCbJ6jbdI?=
 =?us-ascii?Q?0M8f9ssIfeftQusGUlZTQlu9PU5J6jHLTYrgENhiForG7QOL1EyEIfcbrzrY?=
 =?us-ascii?Q?XTxLWbvRxkk4bsTA/3xpE4awvSucyLUXR/yHNZDM9iyDTtnGG9actJaDwqJm?=
 =?us-ascii?Q?xUrdzxEKeDYFf0u1J/dMNfZXKpwkAvOLsLLZAgZx4cQuh12fpDUO3PZgG6lX?=
 =?us-ascii?Q?eC8GIbKbZsJQj7Eb0X1jpWf1qyfCBx3bngXSbeX4YC/ldtprzRtEqPKzw+Ii?=
 =?us-ascii?Q?AWvWA4WUP3fceXyWN9yXMNdS057I/i+NnfRtisapa+TExoO+qLSHblPg9uj0?=
 =?us-ascii?Q?hqRo84BN1dztxyO62XiywcixggAoMraw1iydGRF6IJJNyUNw9sFstl4xChws?=
 =?us-ascii?Q?UpvXfyxpegsVNTuAhN1u8iclAjM/EZBe7C5EM1mf8DAq1PiOxwQHpfVr9c7D?=
 =?us-ascii?Q?rQFYzJbYOMa5QuRS9I80BImNzRLzVk8X9BkA+ou4qSR0z5XQnQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:01:54.7067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df7ebd0f-6f8e-48af-d045-08dc866be562
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7820
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

From: pochchan <pochchan@amd.com>

For some specific panel, it need to use TPS3 rather than use TP2 in ALPM
when DSC is enabled.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: pochchan <pochchan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index 318d0dc113e6..b9769181269d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -33,6 +33,9 @@
 
 #define MAX_PIPES 6
 
+static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3};
+static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5};
+
 /*
  * Get Replay state from firmware.
  */
@@ -194,11 +197,11 @@ static bool dmub_replay_copy_settings(struct dmub_replay *dmub,
 		(link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT &&
 		!link->panel_config.dsc.disable_dsc_edp &&
 		link->dc->caps.edp_dsc_support)) &&
-		link->dpcd_caps.sink_dev_id == DP_DEVICE_ID_38EC11 /*&&
+		link->dpcd_caps.sink_dev_id == DP_DEVICE_ID_38EC11 &&
 		(!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_1,
 			sizeof(DP_SINK_DEVICE_STR_ID_1)) ||
 		!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_2,
-			sizeof(DP_SINK_DEVICE_STR_ID_2)))*/)
+			sizeof(DP_SINK_DEVICE_STR_ID_2))))
 		copy_settings_data->flags.bitfields.force_wakeup_by_tps3 = 1;
 	else
 		copy_settings_data->flags.bitfields.force_wakeup_by_tps3 = 0;
-- 
2.34.1

