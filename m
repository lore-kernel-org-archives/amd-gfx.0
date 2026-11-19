Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D151606A320
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sTMTIVoI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC25110E217;
	Thu, 19 Nov 2026 19:36:42 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010003.outbound.protection.outlook.com
 [40.93.198.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43BF610E217
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 19:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q16Pr+r/cX6fBeo35jI38FLzGo2lLNSvNIeh5CNLoIuGPBpk/ubhPKQiA2BONWH1JvwJnjEYF4aHnx2GIGeVVyMw63HtnEV1qZbT42A9Li/89QnQBcLpxhYEaHWJg+enI+Ilh+37KkyXRo6rFJzF8TZp46tXfUeCwElkqvFeG8dzrhMX3a9Y0W2THjQyeYyyo+aFAIonIERXTS7k0iZxxtcOq9zPJMLh6LWdZNH628MacBt2byS8c6AG+Cg72fZalUHj1Wydb/wGFKebUU5rsPUEZfRHjEcSHF7mJVPLTpBrSMGmDydLZlpfOMRqCm8wnekGkoCk5n/BxwvIOP9HwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuBaFc8viqNEinPTTAnHXlGzh8N4pscbodp+mq5fbhY=;
 b=GoaTCHWyP6/9LDo2NYklCFyN533QYYRhto4nfJum3ZnsAcaTeMq1hT128KFsMkkt8rj7DcPNJlT4vt1tRzNpa5h8NUwBhOiXPof/2ef+vRSUnszQi+LmeUA8P3w/G6RbrCVN70TzMjBZJH/l2ZFpb0hyR5llSgcuu9PvDe74wxGrRKWJjd5ifkl6qYKgriy7pGpDuOocdzdKnpJP68Cfrf0a9T9+XHtapeyjafcvrHZn2qprUWsF2o+zxgGkTl/1CFp/0HQW8K8JKDZzsd2+UIXic0LYEGxkhwpsHqnp3e8jMdbj+NyJQZah0i83y6KwFi5Lmad19QQsF59pc2BIiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuBaFc8viqNEinPTTAnHXlGzh8N4pscbodp+mq5fbhY=;
 b=sTMTIVoIRt1xKjLQXsCdr680TbRuMnq68Lye2Lbw5ght0f/BkklPrBoEUE6lNBbF8gBTrBkzSR38qSLVj+QLJhf5AS8UUrS76N0ArIUhgQYw/eYgpFGpjukOiYJYifzn29cmFOHUkFtPJxQq38/Q+tSxqb8KyK6yMq2+4L8+CKw=
Received: from CH2PR14CA0010.namprd14.prod.outlook.com (2603:10b6:610:60::20)
 by SN7PR12MB7249.namprd12.prod.outlook.com (2603:10b6:806:2a9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 19:36:29 +0000
Received: from BN7PEPF0000009F.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::3) by CH2PR14CA0010.outlook.office365.com
 (2603:10b6:610:60::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 19:36:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN7PEPF0000009F.mail.protection.outlook.com (10.167.248.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 19:36:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:36:28 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 13:36:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/gfx11: don't enable gfx on pipe1 with tmz
Date: Thu, 19 Nov 2026 14:36:20 -0500
Message-ID: <20261119193620.217718-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119193620.217718-1-alexander.deucher@amd.com>
References: <20261119193620.217718-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009F:EE_|SN7PR12MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e4c806-4946-4d47-4a32-08df46746801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|261102123227099003|56012099006|11063799006|261026121527099003|10067099003|261021121427099003|261021123027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: H9t22DodbJJk5nfK51LUauVFoVQaENr56wf37c9WYvtLGfYavjnSuwmoPSzrEjfuedDPRXsleKM/eKaREDQJCvfiIKnnF91oYtY/C1/GGCreaP5LHuY+d4oxkviguzvr+5l59qXgIHXpMv9MMJDDEVAY/WkIEUgFhC1Uu0a5w/kM33GZAdyB85+ROntTszwzQiIQQzfpqvvXil7h7LtgOE6ftKOWFfATgZjYyV7IoVl2xX7xg4GcSJ4/VJf6Y0d+QfmnZXWgQp6oYsTVOEclPJ25Y97q6XEIwXfciTupUdwZSyX/tm+haB2Tgvq/Gg0VX/onih6l9BUuMXeuwMu0BSEtMywK3potABG1URF1ob+XP7U+QUjMEpcJLOQQYSzXW7IGKDfqkN1NlBoe0YxmMupXmpJ9xD+bD9U0A3HfqDx3db4V91UHozIambD/GjdKoWJxhiqS2m3tSh321R5MxnwC15u0PJCJSnw3fI6c7yGUFPCN80gPmJ9JTrBAyz585AmtHabKwl7U+7c50S74oxE/yxZhX+NUd5KoirEgESHwoDaKzk9l2ciEYVPvzH5US48/gzByjMXCAQ2zQAL7FkgfTG+ehjgqwyvq1oiGhustYWJQerFHyoqF/KatNUcipYv+qlMY9rRaN7VyhxsHSIGEetoQ97rzZJVy8Vcxjy3Vji+XcKVaZ/veHzEMFNkZYDWuJdhnzFHtfQ8DTgTLBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(261102123227099003)(56012099006)(11063799006)(261026121527099003)(10067099003)(261021121427099003)(261021123027099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ePUz3axQbxaVWGBlqRuTcgAhw8VEbaA3iipqfWQ3sp+hEOB03RXrtzxH55PL+K8tDilYVOruaUTAdC66+I8AcPS318sb8OJ81vWYX7I287ZSofPkZEiozKjws/WuDmMX8IGdo2oOXcTnzbFO4ogS/DO2qiPdoTZzK3byEvkNWA/uAWp5xWyJWKIkyVthu+1irb1KqX34mCVD+SAqHU2DzUKedIx6v8N4m9SnkdHyr3Bqu5vL1qrjJnSRRPjP5ENG8pNIJWt2ZZbgfeqcr2mpLuh8jg1uSh1AkX69emHiUFO5VmcqoMbqAn5yQ8eNrnexEJQGFCN+1bDk5w4q3BhnNriTEwe8pDvMXvmytfOiECJPiJBf+FxJYLDI8NdiCLsoyFVWL/PPbwYgv4XAcwxvL2EMXXCVxPVOaj9SUB/H0owOMmDXhZeSZUqAtJEC8c5/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 19:36:28.4452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e4c806-4946-4d47-4a32-08df46746801
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7249
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

FW doesn't support tmz on pipe one.  Only use pipe 0 if
tmz is enabled.

v2: add check for num_pipe as well

Fixes: fec62b5e1425 ("drm/amdgpu/gfx11: enable gfx pipe1 hardware support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 6283adec811a3..ab55789b51059 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1692,7 +1692,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 7, 0):
 	case IP_VERSION(11, 7, 1):
 		adev->gfx.me.num_me = 1;
-		if (adev->gfx.rs64_enable)
+		if (adev->gfx.rs64_enable ||
+		    adev->gmc.tmz_enabled)
 			adev->gfx.me.num_pipe_per_me = 1;
 		else
 			adev->gfx.me.num_pipe_per_me = 2;
@@ -5334,10 +5335,15 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.num_compute_rings = 0;
 	} else {
 		/* rs64 only supports one gfx pipe */
-		if (adev->gfx.rs64_enable)
+		if (adev->gfx.rs64_enable) {
 			adev->gfx.num_gfx_rings = 1;
-		else
-			adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
+		} else {
+			/* FW doesn't support TMZ on gfx pipe1 */
+			if (adev->gmc.tmz_enabled)
+				adev->gfx.num_gfx_rings = 1;
+			else
+				adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
+		}
 		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 						  AMDGPU_MAX_COMPUTE_RINGS);
 	}
-- 
2.56.1

