Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5015AEFCE4F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 22:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAB4510EAC9;
	Wed,  4 Mar 2026 22:27:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xP0XLnt8";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4121B10EAC8
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 22:27:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvugXxh9AzqDTRID2D/CmT/U8vdyB0UqlbBI4cl4rqeza2o1tImR9pjSUWZRgm0n46wb7rgcy0/B/9AXkJ0XiBR5Wp6kmnu9fn3oWCpdwlS5l2LmOC6MFespEr0OOknoYhO9tgW9iuViYEurFLYiwp16KtFHuN8vSGKXb6PKjYN8rFM5LncVKbvH30+3SWsheJ48LryopnifNhJ9PsYV4UPLcW8PA301WL4/80tLGoToi7jFEJiCc45kzhQv6ErMdI44Twyoek7A6pzqJ7NIHbi1afRqyshe2/rtsoupEt/W5+yLKwVNdJPSKDgl4XRuTmNtrokT+sB3NtTg7hJ2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eYcHUMH4ovBwPZKygGCbftgIT+ZmdeqNjKJa/c2rWE=;
 b=qc6O8erahd30giA1T8ZbqcUcvNd2PRmmncpJ+eHRWUMj3dhf2HA4GyDqLNjAO2wQsucs5jZBXQS6OF3AefqcDuuS2YeNs9qzc30XseZT9JzC/wKmuxnVlRWZK89Dr6F5Pbqvzx0BhS6o/LUOUUti6E0k2m1NezSwWHpvwZnPG1Uxs8F5APAsMjgJYBX9n96emMgprP2fey9TghHBPJOC6jgj49qqd3tv94Utk1VjR6f6AmhkD3omP/srf9fTUrCCNWk9DODGyiQuR56/mElwINOmeizxd6SgqRDA55OdbP0WEdbD73jSoZ2H1vlMz2RvTcQBrNre6h/uW9PaNw3jKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eYcHUMH4ovBwPZKygGCbftgIT+ZmdeqNjKJa/c2rWE=;
 b=xP0XLnt8NxM/vtVSzQf4vGf4U2siaMl/lHp+b6Zeon2fLi9H5tnh19VvoEH888lK4lqcl05qMGOEEO4Kc21DoV3GJHoBqr/mY1C2COd90SPXpWblWtfGXQ3YE8Ly9S2w1xSDOWlvwBM5dwzbXQAcn23eLPcZvlPoxPy3ZYylw3I=
Received: from MN0P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::28)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Wed, 4 Mar
 2026 22:27:44 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::93) by MN0P221CA0017.outlook.office365.com
 (2603:10b6:208:52a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Wed,
 4 Mar 2026 22:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 22:27:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 16:27:43 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 16:27:43 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 4 Mar 2026 16:27:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/7] drm/amdgpu/mmhub2.3: add bounds checking for cid
Date: Wed, 4 Mar 2026 17:27:27 -0500
Message-ID: <20260304222732.2403409-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304222732.2403409-1-alexander.deucher@amd.com>
References: <20260304222732.2403409-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: d17e52c8-ea77-4a0d-fbb0-08de7a3d415d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016; 
X-Microsoft-Antispam-Message-Info: 3jvv0qIF44UQI3DcN/h/x9saMcip5C48P4GerALfXQWHWvtnQF+uZQI66kiZ6A9FMW6LQAleoYKF6+wu/UtO4OYMbEfs7256T1QK0VEX8OYZ83xYzrUT0XlbBJMKkcpyNk1S7hQlxPDBEWWyaV119cVyDaLnnO6anMTjxWlTBCE8bnTEWBLlZVBrw+2Of3npt4wjhCyjTjKLuDSbVV/FXMQF4DersMu9fD/X55rsnp+1dkMOCFGp1f8Ga//fgqA75at+WFBVyUvNnEbY2+iZScSy5/QMFRcCE6EDvYf3JtkPZ+hhSdjoZlhRiLBKqdv52QxBM3v6hV9652f2c3apAKr58f30Xh9mxs27q6NCWQa697m7xe0oWKoz/8irUkSVmMutLpDQrtWncHl1XumjOscwS8Zh8YuMSvL/pvQQf/jLzFNIUoBIaCEb+XievemVgCgqoHkrKXvHacreZ6EAKmEQRu6d6bhJT/XmqXjdVoiJuFJGinTcKQXYU8ACr4oYSNI52c8QSSPT0SaCvhWq7LoK5ZN/r+Fx0q+XjnKYz5V0UK+YfuGFHiOfYo8rQogakFjiYkpd16LguzdA1kZJnyoB/5raFdhJJEtpPej+CkF2Ti36Xp7eb/WAQUWTx2jevZMsG+0OvUc0uaQxk4GHp3y9a2hJsKzqh9sRiU5eN3uYE3NGnzSaxYJvEiuhwCc1ZzKJLRkKDPTEpXxr68qMA3Y4WW2Diwfs5LsgstxmjcSAO0rEyT+rIwbQxXCpMjc9Jvw5m8cEUJd+qkgLBA9EAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0M1Josf+VfjoE5E+jZ/nUIs4Me8bbuefI4yj+VerHzoKuPqJd/emcaMGLY+0nSHiZjPvhAlHe5z/6Vjjm0hSgx5wStB/CBZNIpFIAJvGc/BY4R37p9m3umfoM2z0BU+lgVn9HbFQzSQSvTPmpMILRL8g4ERDL/9s8wSUWC2esr4eb6Ettd/KU+VkXCujNuIfpGEW3pfDCQw211J5gVX9JLP/YtvlBER+aAZqXgTfMaSabF50d8mcYvQ5UBZomdt4YHdVBURhkf+KBz8RJHORVP+yBASk9QzS+ZQRqqXrfUmQSPp0BvU3JOROLBoKlr9jAOwaLKnfKmTpTu34CoIhK0REFLCLzvl+qSZA4Bizmjh/weRpSs1tQAJalCCP8cQ9Ju4+6V1to5a9NC55nG+OlXj01yoob3BFcqaH4nCuOvvmUFjXxGWKVlRLh9x5GlgV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 22:27:44.1029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d17e52c8-ea77-4a0d-fbb0-08de7a3d415d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
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

The value should never exceed the array size as those
are the only values the hardware is expected to return,
but add checks anyway.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 5a071a788d933..3e0f147edbb9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -96,7 +96,8 @@ mmhub_v2_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	case IP_VERSION(2, 3, 0):
 	case IP_VERSION(2, 4, 0):
 	case IP_VERSION(2, 4, 1):
-		mmhub_cid = mmhub_client_ids_vangogh[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_vangogh) ?
+			mmhub_client_ids_vangogh[cid][rw] : NULL;
 		break;
 	default:
 		mmhub_cid = NULL;
-- 
2.53.0

