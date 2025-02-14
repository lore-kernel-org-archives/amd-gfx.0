Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B6FC021A6
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A00A210ECCD;
	Fri, 14 Feb 2025 15:01:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LEhv5VAV";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E85B10ECCE
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:01:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmlRkoc0IJQleoLHyoWjiDAOjzRjY6ILQ+VRlvBUYWOwLzSQuvvr4w7LN9iJtQ4VttD8KW4sEdhEMNj1PBqyQTyK/6F3ylfTBabIjCzguHNiilLJBFQsNBGwjKhV7xs/qkFe3Iiut9OwWXPe1G7UQ8y7qiXmeLckpXVRM+lcOJdWkAWsA7UgV4aSS6bQE/J92rRhA2z4f9xCpsAZm9rSUdiKTyWUiuObUcEPMYJXRKcO7j28OFdEuT+vtbtJDigOXR0qrFXFGXYW2T1osanC4Vu5v15kSiqMO3uNtw7d5HZiQsseLrS81FP6g5pACquSeHVskBI+o97I76420wwRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsYc5fUFb4/ys+w3bDyuXk7uUfibZFlT9HljwT20niw=;
 b=sy57j2+sFqqwyuYGPtOzp9XMLEko4ISvbzESU+2yneJYGO1E47aj0sTAmWG3G+qqOaArZ0XiLMd1mznW+HNvcx1gUMivC/wTQ79gLuEtzSPmymYKWwSCIxYawwOO3T0N+w8sMu7TUlAAHtFZs7Rk1TcK20TL2GBM+81wI2Fx7gV+1WAKM6WIN5sFHeVx0BGhyuscEuOAhfzH4ugY5KXNWqUZjPgwlqmepNK1jwymViao7DYRxNHZwUmNdjb5LZY8zJSKKIU2wh5Laq/PlmBp7a8zRDJT+0RVrC9OyBSNPhcHy2J0F5+RqpXpI89aOqhx23lqbskxSiNVxWIDfCJQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsYc5fUFb4/ys+w3bDyuXk7uUfibZFlT9HljwT20niw=;
 b=LEhv5VAVpxiK495myGqqYGoOyL5QCfJ+DZG4thegDF8h4p6sdGabepORhlWuuGoSGRcMO6c5ArMV8jzqH8p31Gan1nN1VrW9Ypaox5LkTUoUVh2qUfD5HBCZD1uk+J+WzYjbkCzbLOoL4msFFsdWkZEnQKllwRlVC/t74w9Db1Y=
Received: from CH2PR17CA0002.namprd17.prod.outlook.com (2603:10b6:610:53::12)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Fri, 14 Feb
 2025 15:01:43 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::ed) by CH2PR17CA0002.outlook.office365.com
 (2603:10b6:610:53::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Fri,
 14 Feb 2025 15:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 15:01:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:42 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:41 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Feb 2025 09:01:41 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Taimur
 Hassan" <Syed.Hassan@amd.com>
Subject: [PATCH 16/16] drm/amd/display: 3.2.321
Date: Fri, 14 Feb 2025 10:00:33 -0500
Message-ID: <20250214150033.767978-17-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214150033.767978-1-Roman.Li@amd.com>
References: <20250214150033.767978-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|CH2PR12MB4309:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a60b719-4d85-459a-9401-08dd4d087e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LHJtG8wpXJH1DoN5zFvj1dEIaNfdzUB4YPCjoAohr1uLscPxKsBYqYg3gFIF?=
 =?us-ascii?Q?TvKyPyFKhwuz/X2aZo5+C/3qpq5xUlPa1XjQhQy5gymIyDcipK0wFFDxM84q?=
 =?us-ascii?Q?dfX+otcimKFTxZsR5E01K2u8QpFF9tv79D7X2FpZq6Db6Eg6uOD6EPRocPVQ?=
 =?us-ascii?Q?4MrKbsPKYz1r6rm4JxFtWgkJ2SVk1kDqswuKKjIWA8yoe7wgdfMZgfRB0a6F?=
 =?us-ascii?Q?QMAZJToeOvQePMx9RtUPgvcNnju/RmuY4KHRSscykQWhc2DwGmbKIpiTlwJ6?=
 =?us-ascii?Q?K3kAx7wGGF7d7bub6IWu0UaRoCC0GxC6sc+oDAOt5bpIMOSo/lCeEktjb2bV?=
 =?us-ascii?Q?pUsuy6ekNqSQbmrnN7kogedcCEMdoPJsa0eKsgehtldbsbG53RPE9/pnajmq?=
 =?us-ascii?Q?Kgh+wJMaJvtWf7649OaiWTuB/+0A3BVX7xoJYZKs7IZVx/IGTX8whEO+GJw0?=
 =?us-ascii?Q?Xzcoo2gbt2qfaHP8VUrAw4H+nwd+H681PHZRoXCpe2WBKjRuFARt9epQTjRC?=
 =?us-ascii?Q?s9or1CAQn7SwJ9VO71B9bHiS/6nJg2CFZzu9X+w/xVRR0/v43dLjYQi5LinW?=
 =?us-ascii?Q?fTACTsE0zDTWwTIE2SaLsQtNofJVgzB0+HLA/G7BXXEby6leZP7deXIt5KOZ?=
 =?us-ascii?Q?jK7r0g11ZfjfxaxwsjXb49kxaesQsdtLEdcqd7B8qdRh6gLasBG4A+eGid/8?=
 =?us-ascii?Q?kilcIFiJ9pHs3PvQy55Adz4qWU5tc/EsPm8X3d/VpXwPK+tFeN6+2p3hqgHN?=
 =?us-ascii?Q?FrBrxnNcDgy+MWiL+rrh9+cfTw/zyCC0O38A2rnewUSqQyJKVqGZlp7dWEbF?=
 =?us-ascii?Q?JworoLp0wEHfSFgYAIg2zj0db8Vn3+WjAVxCFZEyokoiFLM7SJ3BvS/VsQNm?=
 =?us-ascii?Q?eScObNgBbdap/UCuvXOGgkLf52knNfW5oIC3t/mDtKFUfo48ND0zIG4VlzAp?=
 =?us-ascii?Q?qXCB2re97WYufmS3njHPFhIF1P1DO3Ndz50YLEKdpdU8CQi2boD+gPLBHuWC?=
 =?us-ascii?Q?9S3EOs1XdIzDm6HbpR8m/3NNFOsN4IemPhvJP9b0OfxGy+/nwS6xRhcg9YW9?=
 =?us-ascii?Q?T/g/RlcwDCOKhxRVGZ/AlJJO0yyFJRBY4mvrV7vpfVXMaXTkZwFVHDJGYEs2?=
 =?us-ascii?Q?XHF33N7l8vHa0UuU1eXLhwrhxCBBh+hoEB6VH3xVoUnsuC8pUxtF1odGg2rX?=
 =?us-ascii?Q?keSaFh2ETUB8qovYwfu36Kc4a4CpNz57F51bZ+6pg2h037yJ+1dIXbiwmKvm?=
 =?us-ascii?Q?NmhIKy7ntXN2gDE8ilMbl2r6vpjns0xwDECZYv3GaSGpgc//jcRRNOlt1fhq?=
 =?us-ascii?Q?F6ErbEMFMYZSr5iqxHg9fEHihfjf8buOMjCdZiGGpcUh9WhYXoPHgxELzDId?=
 =?us-ascii?Q?M3RH68ia7dr+7Xi907L0wmV3jJqn3BjZyV34wY+0zCSqQuBxezqVjiEDbK+9?=
 =?us-ascii?Q?P2UQCECj3R9Y6WvcbI6UKYA9i9OG1GzNJBAQinBqSDbV4MHf7G/m2WoGCqW2?=
 =?us-ascii?Q?G6hzu99lJAtSBBQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:01:42.8887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a60b719-4d85-459a-9401-08dd4d087e44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309
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

Summary:

* Add support for disconnected eDP streams
* Add log for MALL entry on DCN32x
* Add DCC/Tiling reset helper for DCN and DCE
* Guard against setting dispclk low when active
* Other minor fixes

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ab88ce02893e..5e96913bcab1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -53,7 +53,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.320"
+#define DC_VER "3.2.321"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.34.1

