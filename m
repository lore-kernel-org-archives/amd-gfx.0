Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767B2C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF8D810F156;
	Wed, 23 Sep 2026 19:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="44jHwpfI";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFEA810F156
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2lfBsU5cz+pFRcBoz6OZXofUqQg8zUYL05aMSz/BM5zNBfbfPvrIHVZazJz7c0EgF1cNTVbCrPhD5dEALcZIcAH1EX+O4ZK+7Nd6s0VwGzL/hW4p+jcHhBvqOqDLJc4C+1UN6X/WuovZcy7ox1CGrK/dRytSwG1lf5svbOrnNVsGIehKTUX4qWJgGZeOy5/2upUk99P4rqv9OLeO1NkCVgEZvTLbJlUn67Vx+amGkbPf25qoW2AvF7BpbKsK1uPynzoMutpf2CY09QiB8CBDTPPNfWvwG8g6e8UIvXQMGbeLmemLFm4OVvZPki7tm3VeHD51TjIIy1TwdH+0pvzbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcFmN1ODgs5IK9ovFpn/mjNZWwJMdzCgFqdogymYMGk=;
 b=FJc0Jx2Y6ovLNpD+B0R+JPwYyhJefZRekTk07PAa2BGhhGNjypn1xmNwawEJGMkQyadMa4fBv8BRCZQ3LWixWuNVDjkg8XItGTGZm6q/5qjF3TkWWRwTzt+HUHNZWh/rGZF/sMjlUr0Hsw/s61ye+lhVMtmv4KJi2YiRL3eQ+dQRwB5B40OSvU0P5cXbALQHP4+qLP0v2AszRg0Pofnz5LjQnW+zzthp0EG1+35Q8e5qL9SlC4rKUQNkId8S7/jUPCsVS8L44uWRxEF5DEaabAUY1xAODKKY6cLv04DQBqY+CXRjQOkyVUHRSR4VWD1tuxKbE4d/a1wjqi4TLrreTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcFmN1ODgs5IK9ovFpn/mjNZWwJMdzCgFqdogymYMGk=;
 b=44jHwpfIapMc0FlHLYh7POgatNpnx3ql7j8Iwf7Rinw3LMAueh02q3vdgQUbznSSX11V0W7hwjeiM0nhvXtXRPXe2JnutFdXRy++9SGG58q2pPAcW1wwXaMI+rapcFDnWxsLz+JtWhBmnuK6iDyzHMCsZdcDFiSdz9wPx7PRIX8=
Received: from SA9P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::32)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 19:34:23 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::75) by SA9P223CA0027.outlook.office365.com
 (2603:10b6:806:26::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Wed,
 23 Sep 2026 19:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 19:34:22 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 14:34:20 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kevin.wang@amd.com>
Subject: [PATCH v3 02/10] drm/amdgpu: use pm_runtime_resume_and_get for ctx
 ioctl
Date: Wed, 23 Sep 2026 15:33:38 -0400
Message-ID: <20260923193346.2292597-3-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923193346.2292597-1-shahyan.soltani@amd.com>
References: <20260923193346.2292597-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4cfb00-ae38-4f8b-a3ae-08df19a9aba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AxO9e1smzfkh3jM3CQpaKr7n+rLdM8UeYQA3iPsuqW7CzqbTw5flM6P2fwxRyNRuOFAIOSmKr6idfvEdpMk0feb063a0fHuy9shbqH1TS9H0lem1hu9fv3k3G+erx7pQJRaU4q3CAa3CHXjsNzmE6gYo7/uYt8idExqUIH+WpMzDckaw4L4vtjZXYsdpshEohB1BoLtxlbzvczlMQFHJ45BxBuVxqxnAwnAM5H800Kyg6RSYqdsciJrCYHvd53ykmS3VNQvs2kOiMf4/MQC2Ei+fqMjUl+3WoDBSr2MiObOaC0ACx196EqB4LBW7hmfcFZdCQpY66DzeSldv42Td5qvQwOWOZO1O8lcbyAoNtBSpSELXu7QtvLtfZkKvDyDdb8MXv6OQrijHLO/pM2QVr+GAQmGjvHBAwdJa5sSnlRja7UJIjzdolZyeybFog2s/HrCmR1gzatoC0QhToU4njeiysQXW0yexz/YYmm7TJwlhLUwgQwqGZ2/gcyjPZsJCi9m69okJe/Mu8lKXHFwDrX9ZYGTSTlZFIHJQetYyQKQG2I7B4VtqZoC0nUO4qcctR+Kg27HFG8YHYC4L5dAb0uWRxdrC+uM+JsUZjMtHpcTrMEnKg742g/lEd7ML68lxTc1U6svR/E9EnWagJA/aWfOynpTctClXMzxRnJjARZxBCfMJZ1CrqiIbMocms2//iD4q9EmpA9OIO1XrG+wejg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sgDnR6U1HYcuGqUT9bL+U79Tc0VbjmzY+M4WoMo9/8Got7TmV9QO/zfI8vf1+kgBNFmVgxY07rGA5GbNR69aBWqKtVeCn6U6vkn2xTyCjPGrbNX9nbf9M/aO/EOuF9sFmfBSdjLCLuciyOVYdrqUMbZHBlnulx70vByK4khFxc7P/BjPumjNjS+kwuqV8uInQyGWTHfMk4j6VzNTFLS76yAJCEv+z/N0u6UEePxtRSH80729jMENLlWKwUOYYeupXoJ+C5JH0jtl6TGoujmRTjOrRn5bgfQDP0wlNx0tPXGPpaWqkTvbOHDyzBRKkYaJMNOk7XLAtt7tj9jz/Htv0R2ag5YgZeJ8E5SN2EjRgDYbNhHehHTDJIKqcMaMFyJNSF33vS5l55BVgyRGAjOubLty+CP/V5ITGZg7TaKfI5VT9z3pYjtM2MsNNHitQ+V5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:34:22.8869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4cfb00-ae38-4f8b-a3ae-08df19a9aba0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
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

Only amdgpu_ctx_set_stable_pstate() communicates with the hw.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
v3 (Shahyan): fixxed typo in commit description
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

