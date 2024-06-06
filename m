Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700F6C27C55
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A073210EAD7;
	Thu,  6 Jun 2024 21:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vgUoFMIv";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B85410EAD6
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5cLdQNkwz5TWWwpCvuK7XhrEHsu12cM7FqjZ+Wy6xXJEKPRKsubTYv9Uu/XzF0oxSlnmjL+X48WaX7QjEMJT8g1jSrX2zDV40x7ToxhY3WcNX5pOnoh2xIXYzSWBznJJqUaKkpNxMD/lEO0oBkNYZAhNF49jERXBQMNeiiOxMqLJwsCP2KV+B44QFAmm0J7wBqW/GeSLP/4PVh8KoJ9wOHJvpC3PScZTdPjgkgWQb6ShZHP1edFiasMtU1zy3FEHLSdClTfSlSdqs1/13tR/vOlNshcbnO2J5aYMoo/r3dcYwigOAIJbpsJRVujnH6t0ACee+DROQu67swRmVm+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMcQuuxLpVSzh1+xmQ2brPx3xjYtLTJeDLtfq+Bz8ZE=;
 b=hPtME9W72J7CgRwBZbhE9WeF0goNEVNqe5UtD2tILWMJs635j6rcmPIA9qv8UewsehrFamTN4+qX8bS68B8wGTI8gngxO29Qd4N3c24hbX0ioTnaqIMmfFblDybCFhdAvLlgNN8Apd1d/6bnWTDnandeS+xmBmWdKUpjbtJftU4IfHpQt7mRv5mXdF9GBq7MdtfWBWW/F4w0R6nEfeweug3+R9V4biqGWwoEArulbpk4hqgtuD+nrYh/9NozFcCmgwLCVGyO9mL97bcw4eihvvnMseQ8+7zp1zVATNFBGB8e/06e9KzY3dZL85Cu+JdbKyynctkuYgaLNDLiFxtVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMcQuuxLpVSzh1+xmQ2brPx3xjYtLTJeDLtfq+Bz8ZE=;
 b=vgUoFMIveIto1z6mn3opK4iijQXV50Q8NJYQz3yJctEnfU5oTnKpLlC/T1K0lW7ah3KgTh8dh3Nd62WDoKAiMx3aufd67gO2fSG6ZWhgU3oVWXrFhn0QQ0Hz/eVRVbBKpLXLO39OikQAlfLEPkKcqpjtwMU7NhchcTCf2fLsoJQ=
Received: from MN2PR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:23a::10)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:57:09 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::3c) by MN2PR03CA0005.outlook.office365.com
 (2603:10b6:208:23a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:09 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:06 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Chris Park <chris.park@amd.com>, Leo Ma
 <hanghong.ma@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 13/67] drm/amd/display: Change AVI Info Frame version to 4 for
 OVT
Date: Thu, 6 Jun 2024 17:55:38 -0400
Message-ID: <20240606215632.4061204-14-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2d4d3b-df22-4d42-44d3-08dc86739d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l3lubuAHaFu2BKf30H8lljcmuxi6hjbNxHPNosI9c6Z1NC/TNpdF2aafATqF?=
 =?us-ascii?Q?0KAE8bLMxcqF+Iw9++0Z7qQmedFPZt7V1jvFsv+z+pAUDmNivzPPq4D0RjQJ?=
 =?us-ascii?Q?wga0TSbyIVKxUlDSzoOin4I2gdj2XqsWTqbkkMgVYqn+pEo3P4kUV6dp4sBp?=
 =?us-ascii?Q?Mv5vxPTsnrxTxIvAJHsVeB04V07TJaAZl8iCHEpMyZR4fHEQqIerrtHjTyLG?=
 =?us-ascii?Q?SuJj0DiCIQuc64pPIh8Q93H2fv3UIDzXrFKIrykoVsPJ3Lv8z8T9bxib21aN?=
 =?us-ascii?Q?1IZAgZwR3hkDdZEeSuQzzcqoaagX8gCzPNjOrGcKEOpJcJadspbwXrs/RjN2?=
 =?us-ascii?Q?tU2vHBunpqsrIXqhZ/bBzjw9ZGhvg2YPYuTJbkyjK+5ZRPEsu8jkzRuh4Q4c?=
 =?us-ascii?Q?Rg5t+4GSMVVQElY/LwS4uKKwivPf06iG5dGPMcmvo3zgD9nyWVcySIC59OfN?=
 =?us-ascii?Q?qsycBRpBFgHPQjI9XTS8olNnFqGrsmZwjjNHYR0XS3sbVHF8EkATX99h4ZkP?=
 =?us-ascii?Q?ZrteHNm+Y0SveyXnmlcrGS1a0eJurCIGlIIjMEnnABnRFixe1eIAld1qvkOe?=
 =?us-ascii?Q?5QD8FdYcvtcjxldDSABvjbb5hEjxd0Osd5/A6h2krLN7CNxXXxN3t72m4f1C?=
 =?us-ascii?Q?m9ZIAm47zoDesm4z7+ZPJB4CDr61QisVQIJcB49Lbar+MxGCzQJTm8KlsF6r?=
 =?us-ascii?Q?xxYzz/zOeTco2ucTSkfEVGczu6okbB7HpRZfmZXncA5XVn5h3vs4L2zSQ0xu?=
 =?us-ascii?Q?HUK8As1DXAGn+k4UIicpvJrvqjXToCfQVIKEGYEADHNpdJCSREQvVKh3VA6g?=
 =?us-ascii?Q?2rMry1qiMCS9cIPigPipuY42SrExgo5zZJ5iNuHoQjOWtgV9hCZTznfZ7FP0?=
 =?us-ascii?Q?/zH3bnR5RGpoavhWN/eInfypwDJzfQ2enBl8jqHo6CgLmvsAGoICgzkKBSxz?=
 =?us-ascii?Q?uEAg4hBmhK9dOlm1wzHX3SQF7S2FiNtvE9aR+Rcc2M2gdX2gIMjSnnkR8Ko6?=
 =?us-ascii?Q?fui3qkINENRz58/6eCeCIsZEJpCC258m8DIRE2bU+nnUrDx0XVgSQEsqUGmq?=
 =?us-ascii?Q?hGq5sxFglwjqe0ZfqvcbqFK7DS8IZ62JY9vKh1fSpaYjkYp+0upG6s/CRFKl?=
 =?us-ascii?Q?4tn/I4ZpLTI3ZhtI4e07mWgQih08/bkFYViSUZQ6rhXAMsDSxHUA5k/HKeao?=
 =?us-ascii?Q?RAfycJHRhucqJxrs/6BbWj8kvUiCY0FUDTP7iWxX/BngT8e0xrGbeON40H3S?=
 =?us-ascii?Q?dpeVnFleeXnbLcZ5jelX12cV2KokVfwZ188e2EWKwEs2sz77PXXDeu7Ywfu6?=
 =?us-ascii?Q?4o4tU6UQkWtZfD6++YoBKO9USTlT7/d8Zat6f5BiM/xp61s8VrjYsh53d6Gk?=
 =?us-ascii?Q?bK4EnOXGXN9TeCEC9eIufjnsYL6aTiynEM42d2fqNAgMLqpwow=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:09.3724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2d4d3b-df22-4d42-44d3-08dc86739d12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045
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

From: Chris Park <chris.park@amd.com>

[Why]
Official Release CTA specification reverted the change and
no longer uses version 5 to indicate OVT timing.

[How]
Change the version used for AVI info Frame for OVT to 4.

Reviewed-by: Leo Ma <hanghong.ma@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 234236c43d21..61d6b5b21571 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4287,7 +4287,7 @@ static void set_avi_info_frame(
 	}
 
 	if (rid != 0 && fr_ind != 0) {
-		hdmi_info.bits.header.version = 5;
+		hdmi_info.bits.header.version = 4;
 		hdmi_info.bits.header.length = 15;
 
 		hdmi_info.bits.FR0_FR3 = fr_ind & 0xF;
-- 
2.34.1

