Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FF8D6A230
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2024 21:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB25310E37F;
	Thu, 14 Nov 2024 21:26:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ISE7uq6M";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 497BF10E37F
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2024 21:26:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbEXc9BOKxFGPUNBUO0QIEY2vfzj5DlHB+NeGE50RIhIRpRyOHgwbkP8cfnwMXqYwPvdossCxlZyDVms+aXpY8Ib2SLqJnLyEKSGk0uluk8Z6Qnt03nOyWy7wH/x5n+ofpwhZha58NjEH9jhvmHNx/Pom5V/9p40EVJRgmLuQYcHl0on63swlZelRmFV81KIrW96sui4a2R7qVnluHTogCsen5/WdgS9IuFc0dtk8qzUTBw3A5V2XrUc5V46Y6gpzB77uQfKrUBe+c77//v6roVtaU0/ipPbLKxiqbC0B8dMDl6g5Xii87XmUiLzb6CR/zW45MINY/CN2U7vGAPl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjNikG9jOAqBaELbyMeLKojwiDQs7eYciezgBStaS8o=;
 b=xMrg9hJMLiFElboWsYF6U87f2+oqgAd19dCdpdk8i/JS9je0veElIwn/nk/8rY9unIClQiwemSd+Wy2QzeBzLqgMHvZgfA+vjitSheMYLWo7oUP4BrD0hyZELjb3iP7kXz+9uZL/LX2ayjpJPbn2mcnFkm9UgNHQchqoQGRZX9XfhtCvkQ6iJHqr+v0yt4Ul28Z3ASNUWjqMMVydECfz22kuXdkf4mCLRsmQA/EoirC53oXGyXEWjEBrivLWhxXyvx85RW6S0IguiFcIqYh2JOSJPQPg9FnvYMApWKdeGGFSE/1v0FSx5hmjocel9WgcOII46ngqRIhoSfXCqnQ7MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjNikG9jOAqBaELbyMeLKojwiDQs7eYciezgBStaS8o=;
 b=ISE7uq6M5PEStWfbAw5F5YpxUiRgek+SKj/TqTjtRBYDfOrRnKNHA9vrbbOjL6nFbfJSIQGlyLFlAbspuFX5ikYDHI0hF/+fysY0+z8saHJTQOa/3DKT9Bqsfkkham7ZTGhINoEiy//EvjAAgkZlsCAUQGr6hesNQR1VcAC1/8Y=
Received: from SJ0PR03CA0212.namprd03.prod.outlook.com (2603:10b6:a03:39f::7)
 by DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 21:26:27 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::e0) by SJ0PR03CA0212.outlook.office365.com
 (2603:10b6:a03:39f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Thu, 14 Nov 2024 21:26:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 21:26:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 15:26:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Shixiong Ou
 <oushixiong@kylinos.cn>
Subject: [PATCH] Revert "drm/radeon: Delay Connector detecting when HPD
 singals is unstable"
Date: Thu, 14 Nov 2024 16:26:09 -0500
Message-ID: <20241114212609.36939-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 530c1a5f-a037-49cf-1d6a-08dd04f2ff15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3wqmiHz9e1HhnzH8PSbLQiPDsK6Z5q1+ICFoxQvostEdEqd6SUbKVEI+K5e0?=
 =?us-ascii?Q?YiQSmvsJRYVji5cWBTIvz8zT9ihM1DMHEIk6vD+pWt+Nqco9x8SZ+XT8AkMy?=
 =?us-ascii?Q?hgJOj1hDDP4Xxg9ChsReQ2Yr0nx4cHHFAH+96hPjpU/pfiwEvqZz3n3ILn6Y?=
 =?us-ascii?Q?GtLZVcYWJqGlfEofLDtgUubayf3H1TZxpbK3R9FJSWrIPyUzwUW9hWmtDZIw?=
 =?us-ascii?Q?qIWWvK9isPH6CNpmIbyJuEoOVBvT0TznitpRb6Ys8jV1L7dfTdLp7w/FiMfD?=
 =?us-ascii?Q?LS/Qn+InZDjCvm0R0vTlCaIKHr1mMXhtMohxkMQqZyCuE/W1hl/gdlIfKiNL?=
 =?us-ascii?Q?imBkkgejmSXhcue+G0mMPDEW0suHpAqoGLuPNuIusViQrdsR32W/50yPctMR?=
 =?us-ascii?Q?QD7x8ZP3+wi4do8f6sG+G1hZo8EYv949Aew/ES5U3LFMSQGLm9oanZlVyhv1?=
 =?us-ascii?Q?bhxQCDM9qKc5PNIerKFVoFtNn5Sf1XMVF9uXruLmdvKNMsyPK3CmjzSTskij?=
 =?us-ascii?Q?r4hjPnpwpcYssI86Jdm3Lz9dQnyr/uRM08iBeD783xGfzUVdni8q8qfXzKhk?=
 =?us-ascii?Q?GNk6aq7qGysxkixUXwXuUeRMrbbM3NRb+wjXwgE5gFzqtV9HRv9LFdR3x9PW?=
 =?us-ascii?Q?CyY6wQGkxxHxc915Rph1XdRZ5eTLD9aFIjZZOb9AalzssdG7ziQPOgvYqxbr?=
 =?us-ascii?Q?d9V7etubkaej0Q/CyPvbWcC3uTVUVvNAb8XWIXYa+Zx5ll6lhcEwofw9uDZ6?=
 =?us-ascii?Q?85MPTvAkUNE/mUROupfQ3lruJ98xCuI9q4dJAOKVotgiPb9d62qdRCcDxtpO?=
 =?us-ascii?Q?5BpeFyTxQFSx43QW20089uiIOYqCuoCC4uN2GuiXIZtiNYsdqNQ4aYjnjGIf?=
 =?us-ascii?Q?YxTm/oC0E5E6aXlQDN/QwVMkqLLg11oeXvl8gpy6HsR1NdAQd5KFTQsu1Cd9?=
 =?us-ascii?Q?RyWbsi801ME5fJ23AJAQ940PUmfRsj18Cs2mdRGk5DKMVhf1EtneqZATeHv/?=
 =?us-ascii?Q?AhXrhpMm09eJFqZmYjzzG2p+JIlk9+6ENkw0dcVhNLyGgZkML5cYSpVGBLNx?=
 =?us-ascii?Q?N1JPG2rziM6Iy70nD8hMVfzrzbxV4tUrIZnJ81GD8kgP3vFhKF1uwSryAa1b?=
 =?us-ascii?Q?9fFMz6gTvS9LHBzkbqgYlM0VpUVM6fkXMcx4M05FirMn6mK9ERtcSYg+QZz3?=
 =?us-ascii?Q?KeH3gHSGeEKTJ52QJIe+26GluLnEsTCgIJJr+L8cMy5TPI5mn6p+j710vsE+?=
 =?us-ascii?Q?bctHkOaflSMVy/w3v8xoKkCBKkMXTbVsvRy0cq/8vRd1LYL8YFuLQrtnRF0m?=
 =?us-ascii?Q?Ts46vzjIV+GM6fEFx2/3pWvWOyRqmTNN5AmzR1rJx683OFln7bNw8hfkhP5c?=
 =?us-ascii?Q?m25BVZ8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 21:26:26.3086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 530c1a5f-a037-49cf-1d6a-08dd04f2ff15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875
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

This reverts commit 949658cb9b69ab9d22a42a662b2fdc7085689ed8.

This causes a blank screen on boot.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3696
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index f9c73c55f04f..f9996304d943 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -1255,16 +1255,6 @@ radeon_dvi_detect(struct drm_connector *connector, bool force)
 			goto exit;
 		}
 	}
-
-	if (dret && radeon_connector->hpd.hpd != RADEON_HPD_NONE &&
-	    !radeon_hpd_sense(rdev, radeon_connector->hpd.hpd) &&
-	    connector->connector_type == DRM_MODE_CONNECTOR_HDMIA) {
-		DRM_DEBUG_KMS("EDID is readable when HPD disconnected\n");
-		schedule_delayed_work(&rdev->hotplug_work, msecs_to_jiffies(1000));
-		ret = connector_status_disconnected;
-		goto exit;
-	}
-
 	if (dret) {
 		radeon_connector->detected_by_load = false;
 		radeon_connector_free_edid(connector);
-- 
2.47.0

