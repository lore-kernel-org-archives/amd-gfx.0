Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAF5C5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA9AC10F36D;
	Fri, 21 Aug 2026 16:12:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MCgYVAXM";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011065.outbound.protection.outlook.com [52.101.57.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57F5310F36D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POpwPIge+avU2GpDMrxl239aFzAxsegxrwoZup+3t4MeFgGO5DOiHgQzbfszaZ3dqM44mMB24vVFP2jebr4Xg+9Zzb5Ivzu6PI9Cy+AiNZhLJx5E41BkJUohTKCz8RCqWZshWPLg28GXAF5Pc3HrMrgzroYJ6ZdzRJrDWFlLBepu8KZc/T2A0C/gmJXTmUwByJ4ehj19BbiD50EAAgTAGSkcf1HqDP0kRaTCdJEJuMcQezcrz+ODsqLOWQEU5b1wCL1o/NFg+zYwYtcIP0Yuyny4/Yp+eeAtdH8JUw1SEupMJZqj7ejI/4pD++h9eyZVyvWGVzhvCNwYUUjyIs1TLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plyrDTaZNYK9PcHAFwMXdpffxYNtW8HBqnjodKHxQaE=;
 b=Y8ZovUhUPhPqeDsuycfql/uhhyOb51/G1WXOll2LqYYAIAMRKQp0yFHBRg/kvgWtnxq4YVDdwRc0T7gdZWNY7pP7F29geLhWZ5NzEmf+mBgjtEEIKv7vXGesVg0w34/3MJOk3IKlehSz52VT2CbYR4B7/Rk2WA+mpx5fM/gyCEy/ptYkoPyNcrMtelwkM7Gi9lzoDsMXffNSmR3sVC+TuMM0BFew21H8bejsln3X57l5xYojWEtAvk3cIZMUB75d3x0t+rQ0A8KPzSv5HqWW8XA51AdDeH4wJhASQK1G9fQjguancic0OlEWe0yVrgo9LstnKgCJbdL5tcYURRA2fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plyrDTaZNYK9PcHAFwMXdpffxYNtW8HBqnjodKHxQaE=;
 b=MCgYVAXMCT+/yQ8hFZQil6GJ7TCJGy/IchfzkbO2grVOBK9WhNSe9EA6Kx02mUMWvxbBKgeyjRfDd6wqgqMBssL/Q0CzhKTooflTYGkHtrSMVS4YhT0XX9RkK+05XBCoEPClGA05EvnRfpY6mawa+o/UB3G2MmdNubnRv5zfaMo=
Received: from CY5PR19CA0026.namprd19.prod.outlook.com (2603:10b6:930:15::30)
 by PH8PR12MB7183.namprd12.prod.outlook.com (2603:10b6:510:228::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:11:59 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:15:cafe::85) by CY5PR19CA0026.outlook.office365.com
 (2603:10b6:930:15::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:11:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:11:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:11:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:11:56 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:11:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amd/amdgpu: Allow reset init for smu_v15_0_8
Date: Fri, 21 Aug 2026 12:11:47 -0400
Message-ID: <20260821161147.753435-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161147.753435-1-alexander.deucher@amd.com>
References: <20260821161147.753435-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|PH8PR12MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8cf52a-1493-4efc-c563-08deff9eedf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|22082099003|18002099003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: s/kZ/azVFNJtlOXj7SzhwfBwkw/X5gIem03uYGZcFyEePQPoqoPdI0tUeEE+dRKkgyPw2rdUwqVB+YgONzQAGb/mU+2eTPDlo+tuPaB44578GrObFnAd2WHRKYu/QGtNgSy2IsPwYjTirQEHNU4/cJvbWp38DD6BIZ94lCjfnaziQOx0/XhYOya6lSgAyNksfI39pwjlTVDMYCXl4It4gqa8DmQmXQRtLL7HPhzo79ona8XelVjubfH4xO1jCGUawAXOXgFu4x+tE/PSTmo+qpWsE7+Cqy+GWotOQ04tzXgmpEoO2ulSH9ASsebAraUSVy9+SgjZcih79u9tFa7p0e+3noLU3qYEeEQSc8HiEaBq/fJRaSPo7KV4a30BwLRXWFjMeLkWZWPzEECfQTbSVAwql0V/UOo0MfhJ/TEY9QpxaUmkv0bMr29SBiO3AVow+1iThQUuHUz8I6g5omlXUhPeRIhkK3mO3m/BndhnRg9MS8ReUcdNnlqqFZ7siPHtfqf694hvBrsLpp3C4MRrU41+f02L9Z3x+vqF98vB1cEz+cWTzYilDxf0Tjy1Eie2BBzgsTXe1D1rolpspmSNe0TVMjmIBTmsAHKtnXAcEO82WnbDasSItcPl6gEDetmwz9B0swXa63Zl4H4PclSdEAZtGgmztkm8/4pAemWyvfoPQ/5Ak0sigEAIbfvpPialFWjYRLU6JLJaxOdkPDpQDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sKq4FyeIrwfYlI/eFlQOhM8ipkyLbreHFk1Ip2rfnB0+nLYBbSq1zi+0BFB7MjG/kUWFUpLcXTVLrXNsS7WnFRtyNYsYyA5+nf0EnJ+H3ARYc4D0PSl8z+icnRG5bEig4rP8eLOFijJyYGJy6CgdiIH9VaZhsk1AXdahAtPOSVG7WU4GP+MuCdIBuy0D3JOG7wz8In5xzOb41zk7M+/VJyuxzU5fd6Rm88N5+Xncg3bQo/9bbOkHBOwlgvPxq3qHFlyVY9TebDMjag0+RDAZ9cLvg1Wo/th57YT/lXHei22aVco1Ch6ck90jrssspjI4Zh7ofkpbox7BgjBTP7pvt6PLC8AxUb+rvgZb8SjV5Mu+u/z1x6cnXdS5fk1Q742jQkl0SbDsRknlAtvA2QoZ/jR5TITKcWKOEGRn98bK0Y0JNf9hUomVsp5eMGpqTsPL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:11:58.9389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8cf52a-1493-4efc-c563-08deff9eedf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7183
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

From: Asad Kamal <asad.kamal@amd.com>

Trigger reset init and fini for smu_v15_0_8

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 428c3cbc4a401..c8016fa55a92f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -25,6 +25,7 @@
 #include "aldebaran.h"
 #include "sienna_cichlid.h"
 #include "smu_v13_0_10.h"
+#include "soc_v1_0.h"
 
 static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
 {
@@ -194,6 +195,9 @@ int amdgpu_reset_init(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 10):
 		ret = smu_v13_0_10_reset_init(adev);
 		break;
+	case IP_VERSION(15, 0, 8):
+		ret = soc_v1_0_reset_init(adev);
+		break;
 	default:
 		break;
 	}
@@ -218,6 +222,9 @@ int amdgpu_reset_fini(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 10):
 		ret = smu_v13_0_10_reset_fini(adev);
 		break;
+	case IP_VERSION(15, 0, 8):
+		ret = soc_v1_0_reset_fini(adev);
+		break;
 	default:
 		break;
 	}
-- 
2.55.0

