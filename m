Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DE1C88E72
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 19:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C5910F09F;
	Thu, 17 Sep 2026 19:58:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HaQzPvvn";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013042.outbound.protection.outlook.com
 [40.107.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C28C410F09F
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 19:58:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3RlTynSXELj5XgdYo3VUx9LPpurC7Rm1mWbRvVUPAsTcpk8Q4zeamEVRn3FIJ/WyVPz5RFJnilX2uHUkRVs0W0vLPFd01Ee5JTJU5FqMLGHAzvLUJDDfexpN8/kyYnH+fkrc7LnqhvZ+TLPU9GE3BFbIz5KsPvNFq6Xl3MBT5RCuheNyICGoKgv1Co3zzPmZkwjZOD+njnGJCEjYD1/jwGzjjoH+lHkBXZDmo1yvfjRY+X+dQ71m6M4Lx91J4vHSJwsIu4NzGLOF+x0cEbNO/2BfhhH6PnCeo5akHE5UGM8kIeav29ODJAofTeiE57mPzjJ5HVYY8t47o3+4glbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwkPD65ZZJmwZQ04dVkiodPee8Hpu5Z4gY04o4Z6uX0=;
 b=xx0Rcpvz5zxmlZlc5R65d5j/HDFwUF+JG8KesBgovrilwTJGBOXquAFV4K2Xe6jJHIIRPuQERuqc265FtspV605mD9393zJMYmZjLCukZCPGVt9x/rmlNSTPEYOcP8aaHCnIcNszHKcAaI0tsigKLbbVlBXzOwuYw25zUienh7vaGRkCL+e0Y/yJBiw8+5QJNWD5G7K+ID34IMR7LleM3VV/tpCbVbsUIwAuahVVdwrq+09R/KiP89fZwGwmdgmDHaWUTi6thImzprfJYvkHZRjf7KnEPnBpOxhHLN1J87SE5Fv130TvCX2JlLWO0udoK6cK5wr198lzMAf9ch9f8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwkPD65ZZJmwZQ04dVkiodPee8Hpu5Z4gY04o4Z6uX0=;
 b=HaQzPvvnjMoGzFwmVym0ADOnAhRT7znkp82cICiZi0tiYpcEOuZDhSz6iM4xP2XeulP4Yb/bzSJ76mxkD6nHfEMqaTcgpxW4pRhdh3oJh05eNK+iecBQB0afWTEpI27u2RGnWunZijyWfQK5pW3CFyNh/nn6Oc8uI/f0rJzt8yk=
Received: from MN0PR04CA0021.namprd04.prod.outlook.com (2603:10b6:208:52d::32)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 19:58:26 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::5b) by MN0PR04CA0021.outlook.office365.com
 (2603:10b6:208:52d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 19:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 19:58:26 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 14:58:23 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kevin.wang@amd.com>
Subject: [PATCH v2 2/8] drm/amdgpu: use pm_runtime_resume_and_get for ctx ioctl
Date: Thu, 17 Sep 2026 15:58:03 -0400
Message-ID: <20260917195812.72917-3-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917195812.72917-1-shahyan.soltani@amd.com>
References: <20260917195812.72917-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: 4009a6d5-8397-4a2d-ff03-08df14f60971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: N6c9kLhy0uwhcPq3Q6vXUPVndaBl3RIsp/iniDdUrdlY7S5G5KH7DWa1l4v73hWiOidtcBJaPcawzqCibwFRw9P1T0fa21xvPyRXIvFtpyd2N9kDj5+spZXed5ISdIFEZmjMgAkKW0o8EpW3/mN1AiO/U3q4bAQC9wdrKqvMlWanTES4XJKz6jP1qbnsO0yPYg8u5Rc4Oy6KFPs4TptttedNYx+vC+cC0qDSnJZskELJFebhALRg4MvIdQKR7N5WN7k85OliH7iw9JD1aMXWFkR52usw0P06nIBNAFcf7YGj2bV0/yMQHSBO42Ux3o9qZRZQpwfckUbfd07DsvQKL6bvLpNtYD/8lA9Uqn9f/pVcTJaCabEJMCnKqcbH/bJ7XLlaIWwNADKfI6Fqtd9SOXZnNlCfA/qyT+eFjfpyApmqJBurhx+vvoPNiFxgZzERqoc/FH4BFnjC+z2RtafJDmkSfSErDXjUSl4/Kib515Qtx3of5NkK7+DZAsWeb3eFky0phGCdPdsm808xAq25yKVuE6Ucv9nO/h5PdSjRWX5RwPouerpJsbplAPXuAR/OPlxraufvvd8n0TNIJFzt2vcoY4Pj9lxKGdW84FXFvvAJnXGiJqFDLJvlxpRs9yO6eBFFTp4h/PJ9PP5l6GcITd6Z5OlMeSQfSJSY6HVhj/1MWWocNRvHFJCLb81eDkbPBb3rxHE31lHIY9ldTbuIkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HuKkb+PVKN2OqN0ASu2rb/zMdFUsuMazAhM7adSP/SkHVpupph9WmDeRZzr3wNgNt3jofZDa1ZnlEnRFWa9ePF2fjK9DdWzlgdLcaY2cLQbQI4nAF5Bjm7xuD924uR6Q4mJxWgvEiHLIsOB5sCkVDThyDdYGJ2AZOkMXAiaJutn+xLrmJEexHtIbkghgjRfyhpyg8bjJcy3YM3sf9ykceluhkxe57mTzr7RQ47zqQUAM/m0qIearFlGrvxMq/Z5Id0N1oVX7kslpeukixyuAqP/PMlw2NJvWrakip7qVKAPJbSY8GPmT+TmupnS2LUfzIsFm/sNrmCXXX4JJblQEREfeq6fInkBelX6FcvUHANAmxj+wZCZ4QfRSkY2f1smwKel2wIL2y0dhnv1oSFpGMtn8qdbQBOpb8Z3RHN+rSubTerSc35ZH20mI0NIOIUHD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 19:58:26.1614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4009a6d5-8397-4a2d-ff03-08df14f60971
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123
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

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Only amdgpu_ctx_stable_pstate communicates with the hw.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index b15ed4a534f1..a87f26139496 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -28,6 +28,7 @@
 #include "amdgpu_sched.h"
 #include "amdgpu_ras.h"
 #include <linux/nospec.h>
+#include <linux/pm_runtime.h>
 
 #define to_amdgpu_ctx_entity(e)	\
 	container_of((e), struct amdgpu_ctx_entity, entity)
@@ -643,10 +644,15 @@ static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
 	 * context id.
 	 */
 
-	if (set)
+	if (set) {
+		r = pm_runtime_resume_and_get(adev->dev);
+		if (r < 0)
+			return r;
 		r = amdgpu_ctx_set_stable_pstate(ctx, *stable_pstate);
-	else
+		pm_runtime_put_autosuspend(adev->dev);
+	} else {
 		*stable_pstate = amdgpu_get_stable_pstate(adev);
+	}
 
 	amdgpu_ctx_put(ctx);
 	return r;
-- 
2.55.0

