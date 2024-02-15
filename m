Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA81C48BF0
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 20:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0BDF10E0C2;
	Thu, 15 Feb 2024 20:40:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HmhQuvV2";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C08C810E89C
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 20:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJeHbWicsv75VtV0+/J49UegzHorRS5XWyHctN+oN0XszlT3IGn2V8zMZK3jtbI6Iozn0H0cRDEQN61RUeN4O2xwrvFmMaxygv/RAl2AMmuxEvi6pizyJc9PgWFBaUGc9lZpUQKe9PeTEjJ4iL+XmxjUED/re/tfsBbgmJquXVCe2bKoasFkUKjB+PgGInSNrnwyHJPmgLMR/fwxTvN5gg6h2sP1kP/CdR0EdMIbDJAXDGfpqFwSMp6IYLUagINCQhQ0CgU1UoZ0zE+Zviewi4Am82EUoFbZsdVtC6dvaOrv7xOaH05nlguqKFfoQu+2pxLbqJR3b8OkL6EE2ajNGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlQ0fkGj8qvzEtett4XptiPBwpwlJNcM7uYG8vJZgG8=;
 b=QdElhEtYGd7Qt9hEJjkeHWcTX+C/017ReHso9d3cg6bW+d10gjp6NvAgHkATV1BIcIepd/9oslvQLfv2a3s/85X6mSF8EITPdrWLwC0/iycCI+HHerFH0dbH1LtcBFxMfaT6yv0XsYoKtnk7yZSYukvZuYb5z0nOR8zvIs8ECAU7M3IHGaAXxyP43xJ8WrvqoVhVYfLS8vsBiNrr08IHVW+xPkRqc89kcacT/dFlPLs1iVVs6ZVlDnWnzk13lowFafA/HI3U5TUeSkSSNygEQlgv3XKISG/TP/5yDNbjhCi4qNMk7ahG+CJYeqiEZMzoVx+hYB5MVNK4emmjfbAlPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlQ0fkGj8qvzEtett4XptiPBwpwlJNcM7uYG8vJZgG8=;
 b=HmhQuvV2pwRh4vaO5HOjrBlRrZUR2E5Heeh+QVb3WBDYkkBhjWLazFg9CAVUS4wz2PjpaE5OqjX2CqaY75ixxqXS1eF7xGHCNXcFjlCKxcrz8+weaqatQnHcOeKUzC344aepcumKiPF3JzJOZRoel0twlOW/Qgkn7Sc9KMr4N5M=
Received: from DS7PR06CA0013.namprd06.prod.outlook.com (2603:10b6:8:2a::13) by
 CH0PR12MB5386.namprd12.prod.outlook.com (2603:10b6:610:d5::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.12; Thu, 15 Feb 2024 20:40:25 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::e) by DS7PR06CA0013.outlook.office365.com
 (2603:10b6:8:2a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 20:40:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 20:40:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 14:40:20 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 8/9] drm/amdgpu: add GC 11.5.1 discovery support
Date: Thu, 15 Feb 2024 15:39:54 -0500
Message-ID: <20240215203955.415314-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240215203955.415314-1-alexander.deucher@amd.com>
References: <20240215203955.415314-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|CH0PR12MB5386:EE_
X-MS-Office365-Filtering-Correlation-Id: c8624903-3376-45ae-4a22-08dc2e665660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N6paK8vjfoUEeDGG+87x+m9d/1LhVjOseXvzWN+j0EDJitJrWhEO5GJK1h4yYx8eq3Hm3QSGXz8SnrF8nU12olwtujDWUgEDPu/oZhcQyR9NjhYx2wdl3grNQ4WeVclgYg8CYacGe2jxZP5Ze/OessD7dOMfGUa3HPI1TqW+HMHhTxH6pEgQQ6NJwEsiSDBv2nVomscIP0Ut202SjGCDa8AO7O11FGmcj2YJ2upYiLMywq1+fvvB/qbc7jieTfI3HUk01L3EA2YPlRfJ5PZNuVvGDOF8R0T+FheGz4oE4qEOcvcLeHzO3XVukUDmEQJXGItLX2EreBvSEbEZZKIZVVrr9Truk7j+A7eRxam+KIY/EOaxCsVLbp71e1bEm31dFD+K9woA3e2SCeUkMHS3ZyispvFDYa4HarhYhxQz0UnuZ6h2dUYiS9V2w3OdQmIZqCn+djDau+JUTuIUMMZ4jZaokLeeEo2W1xJyD/7BZUqSb+59j/NnjEWM7FSstsPCLuz/woN9gwywVcq9wWHsxEHTkGOKvqGteWvNUKC20v4Oy+BQLmhVbjksWAXfqOaCsTFQB2218GUJrnKzKymc24+wdPA2oUTE7Lg567trU3HNyWKSzKKcIEcNlcoHxQFKLn4R5tr//ZnOoNJoK3GnLjl8Ys1zfbaLzg+r+QL6ml8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(36860700004)(46966006)(40470700004)(4744005)(81166007)(86362001)(2906002)(8676002)(82740400003)(70586007)(356005)(8936002)(70206006)(4326008)(6916009)(5660300002)(41300700001)(83380400001)(2616005)(1076003)(16526019)(26005)(336012)(426003)(6666004)(36756003)(316002)(54906003)(478600001)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:40:24.8116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8624903-3376-45ae-4a22-08dc2e665660
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5386
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

This patch to add GC 11.5.1 support

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 71dbf7a83e42..70aeb56bfd53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2005,6 +2005,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 3):
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 1):
 		amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
 		break;
 	default:
-- 
2.42.0

