Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A29C10ED66E
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:56:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1526B10E390;
	Fri, 27 Mar 2026 12:56:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GZYPLUK0";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE9F210E1F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 12:56:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppbh2JHkx3knIgq54x0QAvE5GGGw7VQ2NHaeM4/N1NA+Z7oCm5jM2D0fOMBRl9L37QgW4Ckk1znJPg8XGOoHXt+7L0vON4gsSDFL18FeXBi4TIVIOkrlQ+IOyBGw3tpkCrrjJenE5rSEHv5iR5qGpBw/cy7GXNCTiw/p3YD8w0dOUHsUvRkTV3AYrSQWVuJ7DXMGgk+KRd+Jrnq2G4eWo8LyH/srJaGAd5OWD2x76pUlo5UvIc2xVReSqZ+F5LqnOztI8kIbhvUrhcFUq/1jwfMaZ0HaV5JAvEI5G3SPzbj857BBCnx9x6/givbqLsQK4AoCkUb+KMZ+1CnM2p0bnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2vc3+ovt9At1IdErIup87DWZqTs1MYY9nNmd77iN2o=;
 b=EFBPYQqtUZ1GCf/io3evyFIEimAA7iNlpnzV9QwTQH/1mVdfTC4h/w0aSnIqM+XKsI9vWCESbrGMwd4nDnY0kGb9lX9u3p1jiSq/s+XK7qTsHCcSKfUNdQZMWVa7ArbSsH8BuUl3rs8qvz35H5MJP8axiSFZrJoTDJeymf7Lex/OV/U1mGgEr4j2Akk1VMAbsAitCLNZEzxkTiS2ya59adagTcLP4YSboapcsdnSxuywJVrxW0wBvXXfeXs1X+ixbQrYPLRIwIf2y0NEOyVKfZFp8v2Rl19zxed++7Yf/KBBLXwfXKrujJ4OyRaRdn+T6Uk8H7Hx8rtOcR+mD1G63A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2vc3+ovt9At1IdErIup87DWZqTs1MYY9nNmd77iN2o=;
 b=GZYPLUK0YoY/jodRy9WRtX2jDeGES8/wcgL+uE0U/a63M7ZBNWtt6y16wBicTIUzdLUibBtJT2HH46dphHx0mSbR9cCZxQA5oaQoOu8PYNRahyY07uMdsp3Wc2kD3jVEfxOL+7wyChZw6nk+V+hP5sdqQ7UYCN8CXMbjmgkW0Ng=
Received: from LV3P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::21)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 12:56:39 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::ea) by LV3P220CA0028.outlook.office365.com
 (2603:10b6:408:234::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.24 via Frontend Transport; Fri,
 27 Mar 2026 12:56:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 12:56:39 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 27 Mar 2026 07:56:37 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Muhammad Adam <muhammad.adam@amd.com>, "Mario
 Sopena-Novales" <mario.novales@amd.com>, Tom Wu <Tom.Wu@amd.com>
Subject: [PATCH] drm/amdgpu/gfx11: Add Cleaner Shader Support for GFX11.5.4
Date: Fri, 27 Mar 2026 18:26:23 +0530
Message-ID: <20260327125623.2114029-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2ec024-5178-4808-bb71-08de8c004990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ztOsxIfAWUzz2tSylcXp1LaXPGvfWmqkjwATk8Ej44+l6Yqo+vX1ZQ6X9EEtzuG9RV2GY/m3xQ18mjIJ7S04h6s2cAzvXD2vIsbGdJMAvs2Rn5sNKrf/kzyjo+ALeLufThX0Ku4QtcTOhjVZ7Odx2IjNJLPNOEB1Kw4l3hjHYYBQU2aCD1VTwJJEIabtdCp82fvFbysO7qPSsfgwdYWD8kSw4bes/siSzU+eBKRe1i/kTAAwCXelQgzUG2g3zjR++7QdB0CdqT3JL5FhhXjbfs2wE606zCknVfyfE1IfoI2jf9KrWS9VNeKC39wCPF9FgcgpGYP2Ay50LKISdOtzK7cvz1gxNfs7txri1mhyxUPF7amak+PmDlavRQwHC7BY1E/4sJC50Kl4gf82qxWKj+tCe4X2Vjqt4Jq6iqUUJyEWO6cmbCyfCiN1gvjieDoTTPo7xnMQOo0dy/oncVf3qhGGZjpSERDdk11fJbjN7LIDLCrj+TAtsZ13rCxWrxDuh3HWHv2NPfJgwi/g3HtrAMR/BiiXdkX63f15zyke+IjsvkjaxeS2EaZo7MidAk2fGim6hbesRIiWy1qI5jzOx0cdZFP6yjHIkdpqfwoCh4Zt1v+RY1ynw7jnVYk5CQ7cprR0Cpw+7pJQuhpIeXb7STGIbfjjEU/yAd2quFiQEz7VTVOOLbFLOF6YzAUK7ulzGBhM0JMORipNCqahz90gnnUmmrKyT4Y0zADHaV70MbCkRLcaOdRMpy0ER/Y+281MPixAAR+m/XC3OD23Nap50g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ySmQiFjk0pVByvA8h8gctrtO1a8U8VB+hRqvsn2LlGu5433ic59MCKIfwor4GKF7ry6KY1o6jzp4Zp2ig2Q8XxXDC8pHHBSRPxpFuP+WyVhR7C0igDKEGn7ds5Bx97N148tz11OAqya3QPoOUy8W4+jFSgS9lkekcoi1ohtxlzISmy+UPAEdWJuYfmHVpx8/dKfUkgubUR11memAGafJUXjy3rMJLyMMbBsHTHjy13xuXcTs39PE9gqC6otnV9P3WUpPSxGa+IDjUexCM1Y6v50YkwOgGyGdQaq2SfgCPWpZsEf2D2rhgKGkeQ9tlxGx1O5cRaiMDf43ODBVa5X5fp4Eb5WT57VVr76BdQ1BABbdywdMPRTzPf4xaFqGg5TH0vIsaHwuEfLtgLT3uh7Y575ucf96zDbOj3fYKJCbTVfada0MxlLMAz2eu7s/dw3+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 12:56:39.4872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2ec024-5178-4808-bb71-08de8c004990
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336
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

The Cleaner Shader is responsible for clearing LDS, VGPRs and SGPRs
between GPU workloads to enforce process isolation and avoid data
leakage.

The cleaner shader clears per-wave GPU state (LDS, VGPRs and SGPRs)
between workloads, improving process isolation and preventing stale data
from being observed by subsequent tasks.

This reuses the existing cleaner shader used on GFX11.0.3 and enables it
for GFX11.5.4 GPUs when firmware requirements are met.

Cc: Muhammad Adam <muhammad.adam@amd.com>
Cc: Mario Sopena-Novales <mario.novales@amd.com>
Cc: Tom Wu <Tom.Wu@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 78d1f3eb522e..ae39b9e1f7d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1722,6 +1722,20 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 			}
 		}
 		break;
+	case IP_VERSION(11, 5, 4):
+		adev->gfx.cleaner_shader_ptr = gfx_11_0_3_cleaner_shader_hex;
+		adev->gfx.cleaner_shader_size = sizeof(gfx_11_0_3_cleaner_shader_hex);
+		if (adev->gfx.me_fw_version  >= 4 &&
+		    adev->gfx.pfp_fw_version >= 7 &&
+		    adev->gfx.mec_fw_version >= 5) {
+			adev->gfx.enable_cleaner_shader = true;
+			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
+			if (r) {
+				adev->gfx.enable_cleaner_shader = false;
+				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+			}
+		}
+		break;
 	default:
 		adev->gfx.enable_cleaner_shader = false;
 		break;
-- 
2.34.1

