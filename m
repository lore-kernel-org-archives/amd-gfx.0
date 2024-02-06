Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A44C48297
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 20:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85523112DF7;
	Tue,  6 Feb 2024 20:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Is2QlOpZ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3A2B112DF6
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 20:28:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5ADgQFLr8i+2bvOky+U6KjOZrivTHcjzctUUvBdNMrbeYAcBXgHUvP61/JMV8nYY7H/ceYssR3txKD75VScUdDGFmNA5mkyA8i0TgjsbkL75LyLxfN8he5r5dTBaRko4rQ+fjWSq2XaIT0Crs7Al6P+jycZNqHcV5tsDyo1p03K3dVgHebfM1hjXMa8QCe+Gywfl4iFS9xUEZR8ha5192yQ7OXOXcpMEsMQLr4gzTcQYj8/d02Z8tRweQCvJO7QPar1EUvlS4sFRb4ljIFDKJf8iGkqbvRgpZIBtf9dsJQcjUgJOYV+Q6TTeyTeP1ZtL+PRhq0LK05cAMfsCf1Xhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VD0mkmePrBbFBewHnccncReS2K5cwPFOLaSyXQFBGXU=;
 b=G3ZTrc/Uy/tre5aMNxsBOLk2ioGuoqYy40KqT0UPROrk3Z+5FYOe17z8Opk/S+CjKvpmzpq8kOoqUrrBS4eJQ6dJOQ2R/O581A6IICLMvjqCmR5DsM7zHfnnTqmTsJvHrGFMIUOfoTnoPjlRJfIG3e81jyaPm8LM7bt1nnxPo8aBakqsO5Caf/aJc6aH4CsYoOjFSh6OY1LPJPAUBftWdmphxHO3FdHSWVcN9NPI73PQPwnADP2l3X6kJY14TIjEdxKR/zKfntUL5Bs2ulkhYRUSWEc+uhwVz1mb2MAzPeHluB7ER2fc+xmOEwnMHcKsA3hfUEO9CKo2jJZyicz/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VD0mkmePrBbFBewHnccncReS2K5cwPFOLaSyXQFBGXU=;
 b=Is2QlOpZBOomcf0GCJIieCJa4WpAyPw0pZfHO/Fj2I3HGxLaldpDZHbydZ7oY4qdF+dCS0gFi1olr5W85IH0L0stq/3V5zdhonFH6TCKlZEajWwxVo0PQUcU0JQaPjsQ5Lxd6bm4sXypi+Qu7ACL2LUhOjwn9Zk++NphuJ2ohJw=
Received: from BL0PR0102CA0053.prod.exchangelabs.com (2603:10b6:208:25::30) by
 DM4PR12MB5389.namprd12.prod.outlook.com (2603:10b6:5:39e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.14; Tue, 6 Feb 2024 20:28:02 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::f6) by BL0PR0102CA0053.outlook.office365.com
 (2603:10b6:208:25::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 20:28:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 20:28:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 14:28:00 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/discovery: Add hdp v7_0 ip block
Date: Tue, 6 Feb 2024 15:27:43 -0500
Message-ID: <20240206202743.1671739-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240206202743.1671739-1-alexander.deucher@amd.com>
References: <20240206202743.1671739-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|DM4PR12MB5389:EE_
X-MS-Office365-Filtering-Correlation-Id: f23855ec-6851-41ff-4f10-08dc27521e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GQHlLDvnD6Arz50Dg5r0W/hmm9Z2VhKI8/+zMaXLbmNCHIsV0aRHMeTm/Y4KHgSb+zP5kdgfQIA2C8FbKw0xhj7EgsY4HqP0n1VtUyqBYogP/XBatEOBySnWUMbQ6pgnsIPiWRlkHR3uVh4BHMfKyaDt0A6UOp1f3M6KOearQkchMw9bdMZW7SXnj4gymqiJTbWaF+rkGMonU5OweJ/FdKIeheu3W2Wl+V0iRZ3ygfmDxii2+WN92spJ7sxjHqlx+NtzA3VG71IVnppnEbEUkWYZoeGTrQHpsyu1av0c/PCa3k6WEnnLGZKSEAZ4ToTSy32TYTsBotMgpfXoWmyAaMjlsRwb6JvsHvCRF4TOMIwZqnLvLNyQ15V1yGTman1xpR+ku0yX2lHI+t4NzqRLR5ujil0erJnOyNTH3G0WBxvEtkAQ5w3Imu87wBLLmg/Kj7AFA1KKI0xpcP3a5re8KuWhSshhnpq7a2PIPAdyK3PlryluLtzyMW5SwAvSx/j7rBPDtWMq6RrDVVsV+d5hCEWNg/EjZm3MUj5yhXCbf5tDVrGYNIB0jh+J/hjxs3iWM0kj/OnT5j7TiBQrkVcvg7p7WhwmClZYp1y+NYInJ5HvUxCiP8DS2i+8tarKyhEyfupuP2Q/SSgiGKNDsCSR4rtYIFfgO6FJ19rFrrmv8J78tzwD/r6EdHjW8MsyNmxry5ez6dGFgZOdWw/wLKHnrFD56TuOp6vQWZRsHmyIRE8NGjcF9Xu40RkgP4TtwTw+P7gWp6823KO+eMpv0DqjMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(41300700001)(36860700001)(70206006)(336012)(6666004)(26005)(7696005)(2616005)(4326008)(478600001)(1076003)(8676002)(70586007)(4744005)(86362001)(426003)(16526019)(2906002)(5660300002)(47076005)(81166007)(54906003)(83380400001)(316002)(82740400003)(6916009)(356005)(8936002)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 20:28:02.4289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f23855ec-6851-41ff-4f10-08dc27521e0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5389
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

From: Likun Gao <Likun.Gao@amd.com>

Add hdp v7_0 ip block

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index c4370f154e8b..59530fe36b6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -64,6 +64,7 @@
 #include "hdp_v5_0.h"
 #include "hdp_v5_2.h"
 #include "hdp_v6_0.h"
+#include "hdp_v7_0.h"
 #include "nv.h"
 #include "soc21.h"
 #include "navi10_ih.h"
@@ -2569,6 +2570,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(6, 1, 0):
 		adev->hdp.funcs = &hdp_v6_0_funcs;
 		break;
+	case IP_VERSION(7, 0, 0):
+		adev->hdp.funcs = &hdp_v7_0_funcs;
+		break;
 	default:
 		break;
 	}
-- 
2.42.0

