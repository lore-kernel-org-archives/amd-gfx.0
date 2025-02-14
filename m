Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27ADAC021A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6DB710ECCA;
	Fri, 14 Feb 2025 15:01:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rc/FqlPP";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF96410ECCE
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:01:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuYTZRjFFVShtf0yrnn5g4VMvIOmUBJRXfBjZDKYADeum/nfSROpRexPF64E48oqW5/NlnadI3b3+DgRUhG/P1oVp7P08tO78svhXuNDmDrCnpYTggbfcqmlVD5zde90wkMEOquuhWdsu9TedYjHzEPMtvASN6eLt6sPVRXrFvxxGP6V7NI6Y1JED1dG/5hUFWt3dynHqLSFIq4WMuSUa/GTtizEhbDLlP1jcffe0rjpKAseipL4h1JDHii/oiU2o1rqKdyg2ozRIIPtcr4BQFQ2G4Ts5JUVWVv+vZ7cuoX2+3xtW9uhswWfu3srNcWyRM58s82X58k7vAyJBAId9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7w9YEqAln/ycRmfjSFTsxE+EDA7LbPA0XuwA7bsA48=;
 b=hH7uCxsVXdLlFUrifACqeeDMGBPjjkFk8aNBkkjPk07vcg+Ui7xB3fBEH4T4vNav9hDhMX8CV7wVd4spPA0RUOXWedIiBV3bN0rwtdUHFKqBVAzO+qp2iGBG6gNVA6osh1hUSa92/uBhnBecDCh164vuSLQRSs5pbBu1qY2NdOMTIivaLG5vim1IlVaYyFZvyAaqIbgfKvHl5KIDzt6qzicQ1B/C38HREmr4yo2/qYkDlcHzC4k3+VsydclEZ1uDmHtaobRJG1OEWNYQ/63Y03Guyn1jlxsYGYtUmcEqrEWZLEEzo4hSULplPOAy8Vb16H1AIcWNsJe8Tai7a6F+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7w9YEqAln/ycRmfjSFTsxE+EDA7LbPA0XuwA7bsA48=;
 b=Rc/FqlPP/JV9LQK6UBS6xi/EHO9P75iSOyjr0MBJqmkC4sXtpOsO6im7eKssH+HBpg8iTruEkq4TW7qpJC7II3vTFdGEl47NgKp4G3s6h7lMJXxOi0AUfq2zl6KgIvsdv3mJzjeT5XlFpiiXuyj544Slk6S4RdAkeQ8HXzgTttg=
Received: from SJ0PR03CA0356.namprd03.prod.outlook.com (2603:10b6:a03:39c::31)
 by DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 15:01:43 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::35) by SJ0PR03CA0356.outlook.office365.com
 (2603:10b6:a03:39c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.17 via Frontend Transport; Fri,
 14 Feb 2025 15:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 15:01:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:41 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:41 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Feb 2025 09:01:40 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Harry
 VanZyllDeJong" <hvanzyll@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 15/16] drm/amd/display: Add support for disconnected eDP
 streams
Date: Fri, 14 Feb 2025 10:00:32 -0500
Message-ID: <20250214150033.767978-16-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214150033.767978-1-Roman.Li@amd.com>
References: <20250214150033.767978-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DS7PR12MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de23c99-51d8-43c2-e89b-08dd4d087e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Srm9Cnnx8vDrbJZF9gcXjYxrfg0Gg4GGloG3MqWNpyLX71948bebPU8Cpkiq?=
 =?us-ascii?Q?6xHTkFN0aYgukIgf6a6CEf3srv6PE+UFiyDmZbau0mzUmldlrT7ohmEuLqPX?=
 =?us-ascii?Q?R8vHjaH9Lw8M9ra1tDzOnF4Tp5hNLGnSmjJnHcsCuK3L0/RXngW4nDzCW2zI?=
 =?us-ascii?Q?U9WL2NSsf5fgCXt3Kk8+yAdSZz/hlRK5h0fEPB6G9VkEY+WZ9dc/wRZMv3pG?=
 =?us-ascii?Q?0tLfaYEo+LJ1O50i9BLDfnVrso5SnwNFAosHDCjhOnkFPgz95bryZFC5hMf9?=
 =?us-ascii?Q?0iXeZl1fSED1NOWXouZzPTc9eKJZHz7akFpxiqDTOfaJ1jgczNQrF+M1gPjm?=
 =?us-ascii?Q?Za7Z4yS+qacK3kHMA3JBQlOzBiQWQLQ+6rV8NKbvMIys8JkalW4mphqpTduG?=
 =?us-ascii?Q?5xnp/K8IgOthFgiu80wdifN4yTpD/fknsQbgbghcPiHYspaQ8vBtL9v/4UWh?=
 =?us-ascii?Q?M8lhHyNCibxJLcKFz/cKbvQ7kzct8DYQo97lJnq6jbh28blksQGEsk961WdJ?=
 =?us-ascii?Q?eJmUDrTrSD71eYw0hY6REhxtuf48kZPOpKWqOGEp4Tsp18dZaJN3DPcUjtZF?=
 =?us-ascii?Q?FprJbN7fiyaIKk3xNRpDXF2xKGzXKJOswJ3bWtIbasdA34GclcR/sCh0+qW5?=
 =?us-ascii?Q?rfApyrc7H54Yf8Jkd79Q+3T5utev3AIUtpMW2cCxuacjigvp9BD2mDA4/OLb?=
 =?us-ascii?Q?ND0JquKMuW3Lyp1xGkXJZY1HQtlQxNpCht61/IFddY5GnN1Eg8rh4Z3/e2Ex?=
 =?us-ascii?Q?K8UsBxpEia/liv2RYFSU70YAKExOOQudZXDx/YJpRc70cZ8EgWAmu0IizwZs?=
 =?us-ascii?Q?B1/e5+EFQpc+AwXRvmHRfBY33cjIZZiKz4klyJ8gloeXJMQKJWq0lchMMHnn?=
 =?us-ascii?Q?DpNdaw1QNysc8SiHrqusHU1AsxvRQiZu5/I4WfHf87k6c7NoE7gOET+MU1O7?=
 =?us-ascii?Q?b/wUXLniiC2WPSBwmDtJT4B7vkjeTs3O0co7UOzPImAqCSBQrc8VxRN0BfHt?=
 =?us-ascii?Q?U6DbU4OuTP7UZsr3jSUWK5tmfPtJXwrOVHXlM+63qI71fKIaqw/TYuhJIdsC?=
 =?us-ascii?Q?Q/jnKFHXuflqm641gzox99NmZoMSdYtdt5meqbW1E6cCjn9fTIdTV2P8jmgW?=
 =?us-ascii?Q?NDdNreXrDz4GM9+S47jurYI0np4zQaSsgfSjtTMXvRyYXJzDc0ViIP2VYEd9?=
 =?us-ascii?Q?RdCeqy5tD0n/4pQS+cVC+xRQ3/I20JS59cgtVWz+Y4eE+9IcOWG97scEAoSI?=
 =?us-ascii?Q?Mm0OXZpODJygpg3w8DSVm4kW/g6zjf0bYXwnj6rDVMc4bHMtpyx9aegHdLo7?=
 =?us-ascii?Q?ohV1XF2z9iEwq4XdNDED45+ApCo4eu4sSp94WyZ/9fi4UxZBS3/+YCzHz9hA?=
 =?us-ascii?Q?RYYSxeC32e1utI3uN4dDbToAG8eZnbDv49acKah/9b26rqQQbd7JGKZqAhWe?=
 =?us-ascii?Q?xwA2xILK0Ocr+7QrFEAlZLWazYHrKver9bD/g3n0oYlj12Ffp464uEsoKzWd?=
 =?us-ascii?Q?CNjJwnxOhuOJ2ms=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:01:42.8105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de23c99-51d8-43c2-e89b-08dd4d087e33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473
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

From: Harry VanZyllDeJong <hvanzyll@amd.com>

[Why]
eDP may not be connected to the GPU on driver start causing
fail enumeration.

[How]
Move the virtual signal type check before the eDP connector
signal check.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Harry VanZyllDeJong <hvanzyll@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c  | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 80439224acca..e3e7fcb07f19 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -945,6 +945,9 @@ bool link_decide_link_settings(struct dc_stream_state *stream,
 		 * TODO: add MST specific link training routine
 		 */
 		decide_mst_link_settings(link, link_setting);
+	} else if (stream->signal == SIGNAL_TYPE_VIRTUAL) {
+		link_setting->lane_count = LANE_COUNT_FOUR;
+		link_setting->link_rate = LINK_RATE_HIGH3;
 	} else if (link->connector_signal == SIGNAL_TYPE_EDP) {
 		/* enable edp link optimization for DSC eDP case */
 		if (stream->timing.flags.DSC) {
@@ -967,9 +970,6 @@ bool link_decide_link_settings(struct dc_stream_state *stream,
 		} else {
 			edp_decide_link_settings(link, link_setting, req_bw);
 		}
-	} else if (stream->signal == SIGNAL_TYPE_VIRTUAL) {
-		link_setting->lane_count = LANE_COUNT_FOUR;
-		link_setting->link_rate = LINK_RATE_HIGH3;
 	} else {
 		decide_dp_link_settings(link, link_setting, req_bw);
 	}
-- 
2.34.1

