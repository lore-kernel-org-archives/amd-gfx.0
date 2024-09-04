Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6AFCD3431
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 13:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06B5910E7C4;
	Wed,  4 Sep 2024 13:27:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ljamMtP";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B9B10E7C4
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 13:27:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUQ4W1fF8+Xn15kqRKZkKpjfr3ryUKJR6VzioGnuMPEG/CIxYrGw6gPqP7Kq6UvPwMeHKmpWbruMWEb7+JoxzEJa7DnlKak8tO+yEzb50OKlagppflAVdXggmfhxPpY8qiPU3y4JQlI+iLYR4GBfHGUfXBGDYHJHy9C7W6JnJHBjjO9MoKchtvegQx3Yn7Yapt2TgqVAeQlu45636gvQ+LPT7Ujg2QyPKV0jvvGb5Q/MY0/EfoJNzBJTDb2vX2dIO/wpiwetnHI+srg4Pdn163sMR9olvNirZ6V7HUmUCRrW+oBAmtL9YudpK3G6D1IUNlr0rSxDH7gyKwSCeUnlpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkLU1EVpi/kxLCByc13Wx6JQBNMpDtg58388GuelBdk=;
 b=n6YrwY6asoyTAnjRARdh3x4k6yyGjLPHFdiI/rA6wdgqB9H+vootDwdpcaFzvo7XtCXrcWFbT/QAaeIaPDOYc8oRujEqch82AMbAlfLi8Jsyr2Y8fpeTLXg+071uJeHsbExx0JThQliIcQRCRqvtQzsly7+nn3atP+5cAf7MHNJrJgXzZgsekzVJovr5pWM67qB2TWllGmNuILMdE1GdWMVce93qlyeQbAi0M9K6ko5TmIJlKZd6VCFNZDdq3DRqZVqOa2kDF9PDyoyl+aTRZPkZcIyM2KDFweHE9vFa1zCGVkbXzA2YJQUZyjhYFJ2zknz8Vw8r5/Xpyl9o0LQ6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkLU1EVpi/kxLCByc13Wx6JQBNMpDtg58388GuelBdk=;
 b=4ljamMtPhT8TlQqF4XQhUj8vFpbdr5cWrN7KufQwuYmj7yaHype2ZlWJenFFv2m62q+LTlXnUO955UnEERwOOlO7VZg9D6ckWSzFhGPURNcYPsjUrXJW2JHw8oaX7qW2CODnHXFngc6EVuX1JRAYtSh9uqbIRclQR4WIcXerZGQ=
Received: from PH7P220CA0031.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::32)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 13:27:50 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:510:32b:cafe::c) by PH7P220CA0031.outlook.office365.com
 (2603:10b6:510:32b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Wed, 4 Sep 2024 13:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 13:27:49 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 08:27:46 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/gfx9: Refactor cleaner shader initialization
 for GFX9.4.3
Date: Wed, 4 Sep 2024 18:57:29 +0530
Message-ID: <20240904132729.1948224-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904132729.1948224-1-srinivasan.shanmugam@amd.com>
References: <20240904132729.1948224-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: 828920b1-20a2-4060-2335-08dccce55f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0d5bFFwZXB2M1F3MGtFTlhkQ04xYjVOSzF2Y1loLzdEejFIQXJTWjJPWW1l?=
 =?utf-8?B?aHQyRGw1eE1aRFZNSkpjTi8xOXUzSHI0eDM3Z0RGcEhiT3JDSFYvVytOVWor?=
 =?utf-8?B?OXgyT1FnU0NXRE42SXpnSjBRekQwQ3JaOE9uRWZrcUdVWE5WSEN1SVd0Q3p4?=
 =?utf-8?B?RDFuLy9OWkV5bGsyTGdkU1F0c3Q0TFNiZndPVEJTb0ZtSzY2cjZmdHdyb2lW?=
 =?utf-8?B?ZG1UdWdQcXpZUjllcUlIaXZmQ1VxNVpYeDRvTjZvaWxvUmNxYzJRR2dJRUZs?=
 =?utf-8?B?SDNFYTdaOERmUHExTzU3QjlHbzJjQ0RlZW1sTHk1SkN3bENuYmdrWTAwL2pr?=
 =?utf-8?B?Nkl6ZzV3eWJZVnVucEVIaEs1YnMxbDhNOU1Pa0w5S1ZnRnZ5SWxSa0g3cmIv?=
 =?utf-8?B?V2hPb1d5c2ZHVXdDcUtWWGp6WHU1ZjJxVE9aSFRaSXR5bnBYd2pBQTd3V0Y5?=
 =?utf-8?B?T0ZrREdJVFpkS3k0bTdaM3FzdC9ZNjFaLzR5SHdNYktZVjl4VHVPTCs2bWEy?=
 =?utf-8?B?TENjendmV29kWGtwZHpuKzNHL21BSmo1RTdWSlM5cUpUWlhRVS91OGNzeElM?=
 =?utf-8?B?S2JzZGpSNGpDOStFUW1JREN4MGZYZy9FcE1UKysrWmo3SkpxczlMVTN4SDJz?=
 =?utf-8?B?MmN3cU1POXM3Y2ZEb25IR25hL2NNbnNFV01zQ2g3M3p2d3M0Tm11V0JhWHA4?=
 =?utf-8?B?UnFFTzQ4dVZ6dUwzTmkwNFVVdWNnNitRV09uWElEMTRUcFU2eUJ4aCtuV2VT?=
 =?utf-8?B?MDNPYldxRHovaWorSUhSRmduWkJhTVlScEdQZlFIYUxkUzY2S3RUeiswdEZW?=
 =?utf-8?B?RWN3dVlqNnR1TlcwZ0xWeUdEMEFnVlp5VWZBNXNreXQzRXhYQWtCeHp6cXp0?=
 =?utf-8?B?MCtxU2grWm8rOHhaYTRFSlZ6UFp3QUlaSmp0cVJvK05DMFJNL1hGQVRMc3NZ?=
 =?utf-8?B?M0swanQ0L1Qra3NyM2VLZWtlM0RWVnJUeW1nTEFMaWpxZHhnUkJQeHRnVm9E?=
 =?utf-8?B?Q3IwbVZrWCtiV1ZFdDFJUnJacHJpYU9jQkFiMk91bzhTakpJdFBERjQwVHNu?=
 =?utf-8?B?Z2NZUldmN2ZKUThFMm9LVUJEV1gwbTV0Q3JGOEJzUWZvZkpHb3U2dzI3eTlP?=
 =?utf-8?B?cTNhaGhEdEVUZU9kMVNzVUhUNmRTdlNwMWdyQmEzVC92bkIvZXVmTFV6NzV6?=
 =?utf-8?B?QitGSmNZNDRDM2oyZ3lMRXlmVmpjdk1mdWZIQ0EvcmNCamp3OGJlc3lrQU5V?=
 =?utf-8?B?TnU5cjRGQmhkbFdhN3ltbzR6c25iL3RFRVpEaythOXhjV1pQN3JxWkI3bER1?=
 =?utf-8?B?TjdyTjArVnJjNjhrU1VZSTBySkplem5YNVFEZ2Zjb3BaQ1dtallZR2ZiMVA5?=
 =?utf-8?B?OVBFcjJpR0pPTkhVdFp0eVdDWDlJaTlXWFBYWjdwVmx3c1AxdGFqdUk0blpV?=
 =?utf-8?B?YnVyOXdxYThueWx0WitneHZxTHgrMXZWcStETjhWV3FJaTJoT0pXTDBxNkRV?=
 =?utf-8?B?QTNuTlFNNzBCZVZsL1JhM0VWdnpya0RNOTF1YmRUNmNyRTJBcjlibFlMUXhG?=
 =?utf-8?B?SUxCaUZOeXA0eWZoZzNseVNUREhaRFkzcGdwbkFGTFdNYmhwRUwxSEdhZm1C?=
 =?utf-8?B?OUFoRlZXaTBTaTRLcndLL1ZwMUEvKy9ESmt2RVorOWV6M1pLVUVQK1BpQjFI?=
 =?utf-8?B?M3FsV0FlNDB2NS9Wc0JEcit6bnFRYTVmRHBuc2orcXdBcXFzYysxeHd4Nld4?=
 =?utf-8?B?a3lBd2pNcnUxRko3dndUeHlSUGZLeHRreE1UNnE5dUxjcW1pcmtKOGVpc3V1?=
 =?utf-8?B?QmVmMHJ3d0JWcVA3Ym8vek04WFdsNFN1SW5zY3ltUExjdE1NWk1VK1hpYzd4?=
 =?utf-8?B?ZTRnNFN4R0kvRXJ5UFEvTVJPU01ONThJOUhvOGdZVjBmZ3BqWDRyUXBiZ21j?=
 =?utf-8?Q?sKwwVQv+sZnlus4l36WlkWAEIXC7NurU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 13:27:49.9808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 828920b1-20a2-4060-2335-08dccce55f84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169
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

This commit modifies the initialization only if the cleaner shader
object has been allocated. This is done by adding checks for
adev->gfx.cleaner_shader_obj before calling
amdgpu_gfx_cleaner_shader_init

The changes are made in the gfx_v9_4_3_sw_init, gfx_v9_4_3_sw_fini, and
gfx_v9_4_3_hw_init functions. These functions are responsible for
initializing software components of the GFX v9.4.3 engines.

This change prevents unnecessary function calls and makes the control
flow of the program clearer. It also ensures that the cleaner shader is
only initialized when it has been properly allocated.

Fixes: 1b66421d29b7 ("drm/amdgpu/gfx9: Implement cleaner shader support for GFX9.4.3 hardware")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 408e5600bb61..abf934863421 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1061,10 +1061,12 @@ static int gfx_v9_4_3_sw_init(void *handle)
 		adev->gfx.cleaner_shader_size = sizeof(gfx_9_4_3_cleaner_shader_hex);
 		if (adev->gfx.mec_fw_version >= 153) {
 			adev->gfx.enable_cleaner_shader = true;
-			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
-			if (r) {
-				adev->gfx.enable_cleaner_shader = false;
-				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+			if (adev->gfx.cleaner_shader_obj) {
+				r = amdgpu_gfx_cleaner_shader_sw_init(adev);
+				if (r) {
+					adev->gfx.enable_cleaner_shader = false;
+					dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+				}
 			}
 		}
 		break;
@@ -1196,7 +1198,8 @@ static int gfx_v9_4_3_sw_fini(void *handle)
 		amdgpu_gfx_kiq_fini(adev, i);
 	}
 
-	amdgpu_gfx_cleaner_shader_sw_fini(adev);
+	if (adev->gfx.cleaner_shader_obj)
+		amdgpu_gfx_cleaner_shader_sw_fini(adev);
 
 	gfx_v9_4_3_mec_fini(adev);
 	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
@@ -2344,8 +2347,8 @@ static int gfx_v9_4_3_hw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_gfx_cleaner_shader_init(adev, adev->gfx.cleaner_shader_size,
-				       adev->gfx.cleaner_shader_ptr);
+	if (adev->gfx.cleaner_shader_obj)
+		amdgpu_gfx_cleaner_shader_init(adev);
 
 	if (!amdgpu_sriov_vf(adev))
 		gfx_v9_4_3_init_golden_registers(adev);
-- 
2.34.1

