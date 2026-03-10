Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68041EB1060
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 15:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C43FD10E74F;
	Tue, 10 Mar 2026 15:32:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zdiXnHRo";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011011.outbound.protection.outlook.com [52.101.57.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83FB410E724
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 15:32:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUrK2CdsQitvbU9au/N2AxzDPpWcP8mUcx8hpD1qeb39AvMFBxPOpWDwzj2GjcGkEbVRJd4vS5WN9skkTNZVt+9PgoFRiBBZ03GYZJ05WmXOW/Mryk3B+8CXr47nCRynK47O0zEJhfn/Fw5CWCuIxgo7Em7FOrbeerlXwtee0qRgRGn/KsXZTPk3PJPtWOJihcA60WRmLup8mp21tqPwleLf+pP7rrwH89VpriMws2yiKzcIWVvjDy/nsz9vEAQ1yWn61q2s9qAuxYUyjZqoOaf9M6WqKGuDXGfBHVHGfQL7PQzB1KrQxXTHn09GcSXYFAAPeJT1kl6YyT0aTmQZmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D355aRzMXTaSDez9Dv7rGq1kGpUTsFCVnJd0EzJdY84=;
 b=RG1lTmO8K99cQa+Fora4XajlA4qCKNFv8q1zY8rNYL/e0T19ZqPhIA/d1ovJCqi6Bf6yEqVZwNM//r6gsF/m7+DIlMlvxszBAn5ltsc4KOWj8vr17j78I0IQAaSSt5Y+TR+IoEBZrYfQMkdhJ9s0vbdo8pSSY0cG98cr9wKFsoNAjOoagZsRlYaX8cbnJ/4flSrLI4+F+TS9Slha4KCo2pZMsYipz5UJHfAYjK+GN2ztBp4cMx07G5uv5ZfOA2oUkA1bwCqggoqljZcIzYoHkgO/TA8JDc8acoTwto6ITMdhsy7gvSQeasXCj7B/HKAvmnx98WVn/Y0fLiJkKPU5qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D355aRzMXTaSDez9Dv7rGq1kGpUTsFCVnJd0EzJdY84=;
 b=zdiXnHRo82792RlgKPM/thiLDAVi2XXbnp79X33SjWuRjIiKyF2uVDfzD2mCveuhF076EzzM1z0KqcaUIYE3RgJMBZzqv+G18KEZ1zHro9DBcx01O3U+m/g87IFxVHMq4OBcIAYF3FDN0tsWEDdF6NeLtGPsZ6m3fwxks0EJ7hM=
Received: from PH7PR17CA0011.namprd17.prod.outlook.com (2603:10b6:510:324::20)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 15:32:13 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::f3) by PH7PR17CA0011.outlook.office365.com
 (2603:10b6:510:324::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 15:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 15:32:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 10:32:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 08:32:12 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 10:32:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonjiang@amd.com>, Leo Liu <leo.liu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Set VCN_5_0_2 DPG mode
Date: Tue, 10 Mar 2026 11:32:02 -0400
Message-ID: <20260310153203.2883286-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310153203.2883286-1-alexander.deucher@amd.com>
References: <20260310153203.2883286-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: c9dca158-ab57-4938-065c-08de7eba33da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: aX4q/7tjq1j+tMHgpNtAoqz4k+3PvMlF+shkw/gr0i94YazkKg8PdfMR2t+zl279cdVa/9OR6iKNBe+GTdi98jUVbGf/XqJnGc1DYf0Kq5B/OI0oW/cfh8aRG+9tnYK1oeCIfSIfw2f6Ys2HPfxT2urIvr1e4EACb8ulwNPEmKnU70b8sYyWWdEEIW3m9LnpPFIVm1MxvSlct3WHND1eLRQNy2QTYD84On/++ZNIEzDz9xeH0QV870vWfwFfFavFYWWBl1WiRvWGwRYeZN6k/sVqc37ZMnZ8kuPDfVjFqp1g8+1F1yI9RWe+ocLp5HM7KGWadh7v9QO28fdzvV5yCkbpOCk/4rASb/S4A73X6noK+6vbmwrlYs1MofyMR59PkWAbsAH1myS9DNNgOQV3qwmFMzD5Sl/zhG0ZraJY18LnWLqqYyHWZlh/zy4NPCDINF31OF6Ace6E1LHqTn3vllXj15EYKJdGDvyMHHyyGV2NGdn3oYXipa63FjQR00Os545mtRQAGBZZuaz/yro1keCtCAtoqW/iA8AatLbwBx67Qb++YEo8KqJDHcWMGsvqHtvBhftsGruzjFzLPohRdZVbosm5WaseKH/wD6w4r+xLdl4P+b2Pal4AwTEXhUUsGKmKjzILt0v2o5EdA4WeyV+bI7IV1Ix95OSPaIxIdHu6HeCG1Ouzg2OZZ4IlUkvI6T+yhUXb4Q+O/0wAoGydCLFtwRmHPM1hU9v+VkEV2pjQbnKJ4I4K/Tk1I6awYOmzOuyUWNKKGi+71lIJr4bQAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VDvpVKgAF6Hrm/uEGlvJ13GH6OowMH/YIZhbyVVisylDI/Q27wy8NBAtErEQRKKvd8jOog0BbBwwYaME89DuGRH3V4ohTj2XICC6AkT4SDJ+I5fhodSEgiV4kcB06sREwKemTMi6q9RZM2U6S+zLo6yjdXG/mfBu7t15CErKIB+sLzsdPaNKMuHCo59o+On18TVSsgIQ/exjhm3ZxofB7rNi0PdM0LaIZ7XKpizmf8T7zK4fBT/0gqfyMFzNbQ/xRGu8P0Z1GJ3qKftocoTWSpkG7kktmO8lvMXZNtkudQ0gR++fMoGt/OsGyUsnZJY2MD03FMO9mHiA2vi1zgoKTWmaivSsqyFnAgh183pJDr6Jlk/hUk1HIH4RKjYJEPW+5QGAmjW0k+aNrgxV+YPbC8ISStJ9zusmFHrNW725rA7uwU1w/EDD1YLGmD+Fs4AE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 15:32:13.1454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dca158-ab57-4938-065c-08de7eba33da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480
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

From: Sonny Jiang <sonjiang@amd.com>

Set DPG flag for VCN_5_0_2

Signed-off-by: Sonny Jiang <sonjiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 3952181c077e6..709b1669b07bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -322,7 +322,7 @@ static int soc_v1_0_common_early_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(12, 1, 0):
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS;
-		adev->pg_flags = 0;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG;
 		adev->external_rev_id = adev->rev_id + 0x50;
 		break;
 	default:
-- 
2.53.0

