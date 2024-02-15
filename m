Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CD2C48BEC
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 20:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E21D10E4A1;
	Thu, 15 Feb 2024 20:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2ApAOQhY";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF9E010E4A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 20:40:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7dk7GxPRiyatkzjEVkyRfqmowH1oTotL1d7ihg0owCEc84aJBzETOqAG3ZqxK3WkoyQnhjJ+4DCiLj1Yf6Eot+8xuA/euL6N76KZzVg8CPpWzt9akSXCqEEUPR/A9qvWZnRAiEQIrIjbFbI0+peezANoVAL6cAKgPbQJdayDoF8SKhXGFQXYgfdOnip2ExRZj8YhCAl5WfhRCDHOlsbL6o1eDjPxf2hWgVQNCPwIYYYrEXHZtRTw7/4IYKtaUFbEE14EO1nIYU4M9ffaID49EV/FAAF8Q+fvV2uneFQ1+BCtPc/80ko8VVIA++V4Po5BUrD6FCY77Hrst4nNaJGYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBtUvtUjgsw87zfLo8VZ0pLfxsJbpOn3ad+EQdxJSus=;
 b=VA0WoFfqOumkG2QxaneOTBkjLJW0v1svq0tGY+F0o0bgrVXAWvBWs7rzGTvmNNIbUDR6YZaMeplL3VKSvdbxfwsNUFdQy5N5SlHMeVZJdE0aP29j3IU4aW9foraWuLvLX1tbsRlqm75uxB2zS480C81FQdnS8052YHguUyi9tc+NTQPxq5zLXEHTGKLcIEDoS8lzNWi027DsnNzvIb0kol/EtslVGn3UyIxKZb20sH8Tp5Z43I4hwBJqbs93+4qs9MRuBsI6KtHyLaohN6/rELKuBlDYtrRdib1UdkvjWOa3tIxWRwEdcStzvLaNpcRjjxNQNJwv1lkhVvCKb33XNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBtUvtUjgsw87zfLo8VZ0pLfxsJbpOn3ad+EQdxJSus=;
 b=2ApAOQhYx0R8BxfGFk8CYdbUFeI5KAi3920Qdm4Wf3YUJvxfGpWXIJ+FUCBXmFZpEmxrrlUqQCvR3+R5WiKzWYB3nz3bL27+nvV/uEAZ0haaXrPxEdPLtTV35jfB1d8W8PamSqNSh0csR4JjuEqrTZD69xpDNNXsEO+TeZkpu20=
Received: from DS7PR06CA0005.namprd06.prod.outlook.com (2603:10b6:8:2a::20) by
 CY8PR12MB7681.namprd12.prod.outlook.com (2603:10b6:930:84::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.26; Thu, 15 Feb 2024 20:40:18 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::15) by DS7PR06CA0005.outlook.office365.com
 (2603:10b6:8:2a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 20:40:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 20:40:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 14:40:17 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/9] drm/amdgpu: add GC 11.5.1 to GC 11.5.0 family
Date: Thu, 15 Feb 2024 15:39:47 -0500
Message-ID: <20240215203955.415314-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|CY8PR12MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 517342c1-3705-4c30-62ce-08dc2e66528c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: olgVY6UZUhlU+A7Bvrf+c2PIUBAsTeTCDYUpGqIyj1LYITu+McA6zuyvM4T+0i2eZB7f3EGauEK6n6N2CsSVe9ZXIY1zjs9kggQAfTvdfKr0Ld2alIX4DQsPOW2cf3FO1FM1Ow+kNyF5ZQn/W7deiUi7I4oIdNcD3xy8P2mimjSXt83fPnaNAsTxzU5+iUwVspTZdvKhL/lfeVDy8GDPwXsQG3oFSydRKuamwxdgr+Rvqvw1tu6OC8vTEP9/iLyeGKxDyiVJj2HVSewKkoKJBuizCQvJKYsRCi+yQ8EmibT0GtwG0TXRm3ihGRf//+QIEw8gWAdbcuxDNzQ5TC/ZGTULIGhdgePgbBw8v36Q73k/zcXxjyKF/lgzJOms1WlrPfWJlWD74T6OXr75+ic2bw/5fIptJpMzm43pyVQ5fgWp6AX7Ix0wy9n4JvxLc126VM5SqbgzNBaLOfkusYzUzVJHfevxNw8vsvqbcMURbwpVOOC3MLlHP4F1kJ1Cm/sP2AzCv99XubIqhc6vJzefE6DdakQTgaoY+dQK/yM22fmycHtVghXAYvthXvm/CmNqiulSw6BNvhBxL6OLHmrIqH+V5R+ln+uvZzdjTx+Pt/gOxR5HMZ/1nCNEjgPQHQgpMegJQuss4Ri2vcT1ry/uV8WjD6R007iT3h4HN3/Qy00=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(36860700004)(64100799003)(46966006)(40470700004)(86362001)(5660300002)(8676002)(8936002)(70206006)(82740400003)(4326008)(6916009)(478600001)(2906002)(336012)(2616005)(7696005)(426003)(16526019)(26005)(356005)(83380400001)(81166007)(70586007)(1076003)(36756003)(316002)(41300700001)(6666004)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:40:18.4210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 517342c1-3705-4c30-62ce-08dc2e66528c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7681
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

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch to add GC 11.5.1 to GC 11.5.0 family.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 6a63145beaf2..71dbf7a83e42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2462,6 +2462,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->family = AMDGPU_FAMILY_GC_11_0_1;
 		break;
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 1):
 		adev->family = AMDGPU_FAMILY_GC_11_5_0;
 		break;
 	default:
@@ -2481,6 +2482,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 1):
 		adev->flags |= AMD_IS_APU;
 		break;
 	default:
-- 
2.42.0

