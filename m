Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13B9C83F1D
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 06:53:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F56510E525;
	Tue, 15 Jul 2025 06:53:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h+XTIo48";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CFEA10E525
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 06:53:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFseC064ahCGrkXVQPcXyqKFBo+GV1/EdKtcC/b9nfNLLuoJ+EEqmd3TdCSnNhMgr1gxn+3aGIYgWmcUd99lZJUHWg3MQTEeUBPPdvup7479fO3V3F5v8mjxFbIXX0ZU7YFpx0xCa5g6h34YSHTwhg6YnRNzwAdbcl3etbLrXsbtgsVXiCrxHM9Jrulovh1I8/MIWycz1NgDxGFFnZ2hiJkgeRtuPrSNz9GURdElbBXclQcf5Vv+htLMp+zeMjISy1FfLRLiVecuNSdDi+vFCkftFDMJ7IN2csWcIqhPJC8qnt1OJsgp5TaaDuNi91Mz5HxcPp9LufMzbJ6/+5yZ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7EaNyQjigTGuNbGzYOWaMSkr00AuYnC2eUEys+auiE=;
 b=V81BLG2eyqddDLHGAXPEX4cE5ExG1tWOwcDe1B1hwz95uWcBF4JtSZGxoE+hRZ5KlYhTw83WwEPeNomZw/brDzp7ovrzS/TQXJFQ3F5opcUkialsCduQ3xLmr/60qBQpUeXaVbmZLBZiWzqvPHbn4c8Z5SWPCo8zuX4r/3E03OK9JM+BYA6tfSJfGDY07fRVcdw37r1mbCcf67/f+FQKn8rPIIC6xoB/TmazVzhxI8sxybUIgO09puVskt1EK088+nUdL/nCNkUy3D2nc35iQLlF30m3tXthwPA38aLcaJ/Bn5eor68IXv1vriUGyXGZcUk/Au0M8cf+7VtP2CZhCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7EaNyQjigTGuNbGzYOWaMSkr00AuYnC2eUEys+auiE=;
 b=h+XTIo48dzQmJlsz5FCN/Yef+RlTiYxN47ktPEkhQVIA0GPn2dbv3CV0SMyw8Q2QT8ciwY9OAH5ZNprTG4aW7W2a8pC5yuX/QG8kBTVx4TW7xgRWy5273IfoqV73CQHrS8IBI7JRxynMlsQMJ0JLxEi5NAulyZ2L2MhmY7MY4Vk=
Received: from CH2PR19CA0002.namprd19.prod.outlook.com (2603:10b6:610:4d::12)
 by CY5PR12MB6035.namprd12.prod.outlook.com (2603:10b6:930:2d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 06:53:42 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::7d) by CH2PR19CA0002.outlook.office365.com
 (2603:10b6:610:4d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 06:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 06:53:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 01:53:41 -0500
Received: from 172.93.31.172.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 15 Jul 2025 01:53:37 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Taimur Hassan
 <Syed.Hassan@amd.com>
Subject: [PATCH 10/10] drm/amd/display: Promote DAL to 3.2.342
Date: Tue, 15 Jul 2025 14:49:34 +0800
Message-ID: <20250715065233.160043-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715065233.160043-1-Wayne.Lin@amd.com>
References: <20250715065233.160043-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|CY5PR12MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a0601d-ccb5-43c0-8408-08ddc36c5629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xp08YS4EHcaVaaIdKnoimttLvz6Kh65m5g0D244+beoRJQaIhX+xvEF0cnOI?=
 =?us-ascii?Q?Q6jUHGO4zhpbKEsNiTLwtd7UFojUIPaY2CQv6K67vdWRpO5zu42kpw00Xm0p?=
 =?us-ascii?Q?M4Vb6YDUkL3gpQI+8Kd2UFuQJmvGeXw5Oo68d+FR6t/JkI/IVyTaAMFITN3s?=
 =?us-ascii?Q?Q6Ydqky8MmmAwgGgE1txCelSDCqzPbybgnzcpCUpy4DABpVsLaR+AseSh1Y2?=
 =?us-ascii?Q?WcHZ4KERhT0txP2+i2lbx1x1Vz/HXAv95iPYolTrwskHIqsRBxYzwZWjhaD4?=
 =?us-ascii?Q?UzeOvohDvZpmQr/743UySKWkWBo5QqnUs7e2I6emNtMIJn4f6xjOeX2JsqJm?=
 =?us-ascii?Q?UQJ3I6nWNck1dCiHkU2jJF+dSrcwKblmA9MYCBwHnLYVsg0lDIJCmYhI0CL3?=
 =?us-ascii?Q?KBC7YENfWvrmhO9djsrJ+uWDC4FVTIjXz9tMlBJDXWfDvFZpQndZUqfW19IA?=
 =?us-ascii?Q?20YclTwadbX1s3vTputUveDayC3hApU9jU7VDqqeUot9fCgZDYfatbAS3b5s?=
 =?us-ascii?Q?+48LySssBkaH/eQBjrewX9yVMZvHTyGcrTUSjtoFuGHLiZ5IWo4hrydNSfg7?=
 =?us-ascii?Q?D7t34PDdBriJ/ch+km0VorFCFZCe4KiX8fyH5k6CP7TiML48lnNXk9edl5fA?=
 =?us-ascii?Q?jN1dJjEBJu72OXKqBl1UpWU4zpEl4iil3VFgnNVFJ0G45CZhpaHU7c//MHxc?=
 =?us-ascii?Q?4X4uP3Rc+LzH8J0xJO4N4kzzxcLwfT0BcineCIxt4ULpeabiEuPx7P39NM8u?=
 =?us-ascii?Q?uyVsTvRuOGhbPaJavs9jEM2l6t39uBjcNfku5CUxyP2fZM9OMEDmGrxIQoyN?=
 =?us-ascii?Q?UbNiSPcCmofWLMkHaGvsTOCldBHsn1GMcac90RfkNmo6qhAdbxW6OUKgkuWG?=
 =?us-ascii?Q?jL3BpdZA7MD1GTcCK6HwiDrSE19ZSlXsUdziHTkHk3sPnIuetygflS1bo+Uw?=
 =?us-ascii?Q?3CHARe+/y9cI9402+FnCnDEiVx2HRRkzvn6KCRUDSK5shZAXth5/N/CNqNhb?=
 =?us-ascii?Q?C9+xB7YBYg3DI7WPkT+yeT4MufyIpsf68Wb14sxX4l7wOO6TQWCAj3LV4bXi?=
 =?us-ascii?Q?Qft4Yt256PtesSkiVZmmFU7odGl46i6GIzmGOY8jhHdM+dtWIvjVQlsXOxe/?=
 =?us-ascii?Q?RKdO8X20T3rIN5tkxA7DdZ0XtPjkLRiUyDMYz5s9Iear9tPvIBsBL8I8/cJK?=
 =?us-ascii?Q?5owg+QjheItG60qs1fQciIS9wWkxD4PmYd/zvY6v2IbCnx8HH7GWd4/QXSpm?=
 =?us-ascii?Q?jef+bynHn/9cjmHSQ1TNiTB57aYRk7MNspKQQn9wXk2X/Qw1xGYzItzADV+h?=
 =?us-ascii?Q?GvnY56xMdFho39EqDMzwRWWs/rb/yPFe+Vm5cF+vciQhDWuXKSK/wUje/LoN?=
 =?us-ascii?Q?2KlnaVH5njblO5gjDhyEy23u3uT2XB30BGTzKHxdgBtiXp4+vnQXiQxD9TWC?=
 =?us-ascii?Q?hOFtF9mmKlojqnXTVwQpCVHj/bru0b2Dp2cn47DUNwqws6ILcVkeg8XJP263?=
 =?us-ascii?Q?W+HmaiiH0cTRIFevrPPZykvYvHxnro3huD4/YQ+5OoHxz0dyLwO2U1N0fg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:53:42.5288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a0601d-ccb5-43c0-8408-08ddc36c5629
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6035
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

This version brings along following fixes:
- Fix divide by zero when calculating min ODM factor
- Ensure committing streams is seamless when transitioning between
  topologies
- Fix condition for setting timing_adjust_pending
- Update DMUB tiled to tiled copy command

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d0c78f94a7a3..779b39e33443 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.341"
+#define DC_VER "3.2.342"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

