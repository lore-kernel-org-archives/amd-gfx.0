Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F43AC369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 15:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00DD810E312;
	Wed, 30 Apr 2025 15:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VrpLg9fU";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04C2910E2FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 15:48:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPygBJXz6FQe1SpScH0uoX4ZcnEukrxteqddOxyQFIXonzMhiuIh0chVt4V14j29VG/GibxxwVhesb+GbAu5w531km4GHCyaKdUlRvDXxByiEaGkmKmQ/Pvell/wMZ8tFjZpg7sAjtfbC6lcTxxJVA2/ZH4UsWNqsB7WRKQWRjAnyARNs3mROZpo2Pi1EoSWgexyNjazt/j9eEyz7YIJwLZstoiamxMtLR+bAy+6K5SMlgT2G5sIB45souZMbRCfoNnJRggYSEYy5Al0qNYduFvY7fymOuCUhTfUw+t+RuKWSVCtk/BGcSJLhFoam472cG+LDF0o6kjPaPfB8KcXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DC03n1c0FtZJ/rQ62ozDvq+vvEVgP0EWydFDdqIsApU=;
 b=FxL6NoxNrc513YpcQJkh9O0Jym0S0AMej9t+ZgesUOERXdYtB9cI1TQ3ZU97Ur2skn0CcyGxnwy8wcclICxXRUcwlHpXG6OOwJn/YNizl5Q1Hv7L2IqaZO9+18fJLh6w37OUhBclSnaGBR0pOyZlxTRHZhnM0QNxp5MIyEgyrbOHy0h+dqcf+iuL8rzKJUlx4qqKMPUs8N/BZS5ua2zNUFGxTx35HtYuP5YOZNBZQ5ijpg94Ew/HuKoZPwTkAlX6UCVmO1uElFPAbo38DmGGWaRYj1ucvDZjwyAx1hNaUIrMbRNbYabEWg8t2nk72Da8BAfZYLZsGfFjufwNbmJONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DC03n1c0FtZJ/rQ62ozDvq+vvEVgP0EWydFDdqIsApU=;
 b=VrpLg9fUOXurNEbKUZdzbQ8Y1+sHtLVatvZ9SNxjqTNoRzSgaXd/6yUtYeWkeSPvO0Bb6gny9+idQpUhAjGCE8B5a/OtRxRnD0jSn/3ffDLxUxLZBxEfo3+i/UmBW5XDy4iB8eichXp+DcSJHNtMR6S1gm2HvMpLvCTfnjAFAsg=
Received: from MN2PR20CA0026.namprd20.prod.outlook.com (2603:10b6:208:e8::39)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Wed, 30 Apr
 2025 15:48:24 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::19) by MN2PR20CA0026.outlook.office365.com
 (2603:10b6:208:e8::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.34 via Frontend Transport; Wed,
 30 Apr 2025 15:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 15:48:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 10:48:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 1/7] drm/amdgpu: add user queue reset source
Date: Wed, 30 Apr 2025 11:48:03 -0400
Message-ID: <20250430154809.2665473-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: b4532584-ffe6-4455-b751-08dd87fe7016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aPb8NSwhbZwKBbNLsitEVzGUKXBFxE+UP/RDJz8dD4eEu5AOTWyQhZvh2MQK?=
 =?us-ascii?Q?k7fnIe6rsiWVwc68S36nciaT+LiealQX41CvZl6rVQPHaQ5D/8fFynEX7SdP?=
 =?us-ascii?Q?T2PvUOiHkpoVxtNFzda9EoI3gU8JPKfdTN6T1fq/GIIkHR07MOSvfaWillYq?=
 =?us-ascii?Q?q1m4uGNq/AgsYEAjnVytN31ncYZn+xf0rNcMjhUXch6UPaklCA+lCTRl7ybn?=
 =?us-ascii?Q?q1TAyQM6D/GFnw5kpdZKSKDbpSq/kXozrcMgmJ0eOjMGZcJh5dwrLUjpv49j?=
 =?us-ascii?Q?0Tt1FN0lBht/I87r6SyK1WomNLFJvXtlbs1VQYU4zSywyDVR/5DeqN4L12mo?=
 =?us-ascii?Q?NHpLF5/zPX2TPvDHheldjEmARek/2YB1rl+gnpXErNVLKWqghb9OCOxsQCuU?=
 =?us-ascii?Q?XmySQ6kDq8z+qNmOBU36w7CCYn2Rdm6YZ92pmI20mfnRCILoqPp4fPWVsagf?=
 =?us-ascii?Q?VHlinFBvwbDvyxXhbkm4+tgxoLeNEhSGqc1cZO4Q9OtGi7REp3PKUeJBriPF?=
 =?us-ascii?Q?oqBxK2PKLOTAVRP4D9LtZLO+UZ8FmZ0q55Uno16RiYTSHBcgu1iMytlHGKf6?=
 =?us-ascii?Q?mXEINYz7Z+f4RwLZw/AzY+gg0wodiEg7jjypIFjDtp3uK7Vmejs2JKIUFUzq?=
 =?us-ascii?Q?a5kLZ1jCGzkwVRimu5GUwnhmhEA4+VGwNHjDN9TVJxrJv88fjZLp+aQhK1bf?=
 =?us-ascii?Q?GI0ZYA/GmfZD1ng6ReS268j7zqUnNiU9un0c5RUpNAEMMgGfO/GzM+Ry8Etf?=
 =?us-ascii?Q?eNR3c3rxMXT/mJMPARCpkgoekcr5JL5wNZaSkqThNdLV1GRZJnp2TtPM0Hpr?=
 =?us-ascii?Q?Gm0SK2I3NcLO20UeheEFlHhpno2VxMc1zFH0Ense+m4/GXN11LP0J+iT7os2?=
 =?us-ascii?Q?l8FfI+dfCTb2M+NOfcJYxa0vC4Tt9MpSxJtivG5cGqYFIPw/XnXaVOV0LOY2?=
 =?us-ascii?Q?ckz0Vtv09ICN3Zl6dk4PBrbSok2oMGDcicysxI5JZvdSNW0BevY9/kslTE8P?=
 =?us-ascii?Q?NgQNvTiwb6isnowR3MkLOLF8GEt1QkT8R6+AEJtsB+bU4+JYoG5PHwh/eTRd?=
 =?us-ascii?Q?G9fLrdzkyzNO5Bq3g4/PxKvVUeNqdDVh5Ww1Egk+TySl9jsPtYN3F4m7q9AU?=
 =?us-ascii?Q?DgO4+/RiVx35XhBzZTBSBpFd2enuVJoug+9EIOoLOOmGZLDjcN0oGFZOhqP/?=
 =?us-ascii?Q?JAzl/J4RtX6Mu1U4ZSWDsGxX1+74OQnCjmrJVKY1pP14zgI5Wje0suO+WJDQ?=
 =?us-ascii?Q?HqyhWH0ghmmWZasLKdBmZbTHTl6mMXViR4OT0mUtEd1DUCwL9ApcjzaJv0WV?=
 =?us-ascii?Q?aFMZ6u09jTWPUStBGjKtftaD/ezc5f6iT617NGH7jbdg8j8SVVE1iiEldeue?=
 =?us-ascii?Q?XpvqhiSWbEn2IhB58ZAAolMCHJBwgbv84W7h89vaUCF1LgHuA5oPdJZ0lnbl?=
 =?us-ascii?Q?uXhmF9VeDbWAHxc66MtSq5PDxqddw04E5nlJlrGc2G7DSe/pY4t3gJ0KV1ku?=
 =?us-ascii?Q?FTGOhcLiNH/NZTGxSChbGtY5hFc1x53rmrmu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 15:48:22.8020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4532584-ffe6-4455-b751-08dd87fe7016
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582
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

Track resets from user queues.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index dabfbdf6f1ce6..28c4ad62f50e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -340,6 +340,9 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
 	case AMDGPU_RESET_SRC_USER:
 		strscpy(buf, "user trigger", len);
 		break;
+	case AMDGPU_RESET_SRC_USERQ:
+		strscpy(buf, "user queue trigger", len);
+		break;
 	default:
 		strscpy(buf, "unknown", len);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 4d9b9701139be..ebcea44dd7437 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -43,6 +43,7 @@ enum AMDGPU_RESET_SRCS {
 	AMDGPU_RESET_SRC_MES,
 	AMDGPU_RESET_SRC_HWS,
 	AMDGPU_RESET_SRC_USER,
+	AMDGPU_RESET_SRC_USERQ,
 };
 
 struct amdgpu_reset_context {
-- 
2.49.0

