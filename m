Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DD11073C85
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 09:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EAEE10E5C8;
	Wed,  8 Apr 2026 09:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eYkJM2nm";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B8F210E5C6
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 09:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3JzcCoPohCJ31hlinYOPlWfJSzPpM4MYxGFWIVHAGQbzTtx/9pJA+7oyQqyKNDXW+01AsvDddEyNlm+7HY5XQHUeiE9Broig+MGUsgYJdptyV1kuWdgR2cSDvuWmIKWF/uEtfP3zhiGgWHymG1vxhYlyLzFEU8RYwxtW26gdRB1leDWQZgk9kRYJvceYVhfsyOrCr2e7OuTFFM5mAy5BblGIa/PnaZWTgHBrXwbZNx0BiAX62DsXAHDK0E+mRKD6oHT1q5/QlHBxAaBbi4cvO1bV18ZnjXWxlsbKz1nAjzNT597HWE4TUn+Kai7PvFdUZf0l+wF4ORHQDjci509nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sUmnJn2LEGmgnPx/U18u2Rzq4o76mSHsvJhUjvkyJI=;
 b=Rg75I8cMoM+Ko03xIr9nUjNRFTuko/lxr8zgwR8QtPJEiajEvfyIt64k+J6hDwQstieQ1GqXBRys2AGIucyulQLiAPOYe1hxK9P+RN9EwmJG70GlR42YNaBrSVp+U7KmQo9IyWsfE1fBk58rgnypx0VYlKu9MsEtNU/Wtx9iMkKyn8bzyp0oq3QPVqt2448cQ6Y8RpWIP0vboHOEiVQsehPk/Dosa9X9fLTktgF3d0vXK5BVOMtYPvqqZ5QUv1aWeVHGS7xJFKGLLe3sFwppM8iR37H+chirtj/5sbGuk63oxzl7fyRJdAXxgFK7u094qx7cIpTHnEqyIu5oVrAtGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sUmnJn2LEGmgnPx/U18u2Rzq4o76mSHsvJhUjvkyJI=;
 b=eYkJM2nmTNfUH/hA5iHeDzNPKZ5zvfH5UzZdJvQNbU4Hg3jp0hCG4biJzWBKW1BJGI6nyOgOiQK1UDlAhua9FDnqHguPgfxMr1JUDgojgZFPzz5WZ7kmpgWJqHsTUVRoT11dENvTwXvCVAmKN0ymTLEaNBjfuAEiWh0NjSkZ9ZI=
Received: from MW4PR03CA0079.namprd03.prod.outlook.com (2603:10b6:303:b6::24)
 by MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 09:57:57 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::1a) by MW4PR03CA0079.outlook.office365.com
 (2603:10b6:303:b6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Wed,
 8 Apr 2026 09:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 09:57:55 +0000
Received: from mao-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 04:57:54 -0500
From: YuanShang <YuanShang.Mao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YuanShang <YuanShang.Mao@amd.com>
Subject: [PATCH] drm/amd/pm: Fix inverted VF one-VF mode permission check
Date: Wed, 8 Apr 2026 17:57:39 +0800
Message-ID: <20260408095739.59807-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c89e2b-09a3-474c-f220-08de95554ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: YhN89MlKZMQr9IB38N3QloIwNWBGteijLBWcvec1+6hspQFho6Lm4YrNZZQJbpm7pVeUsiChoSJwMUaUDXcCVHGlomzSNLWWz+8XNbJQKtJwXDLEDANKgdw3As6DdL/3SjqZmkES5DcZyszs10n9/CIG2xoJ3YwilPz1tXWQOHKpiPKYgeqKUAxVHyFswv3IfmBeKJ0NIMKGLwlimzuGbiSo/hFatOpxOkvG2E2zm36X4ffNbioh0N0b0xsomgBd9cpB2mpJ88el3gBSlRNg/QGFBAVdofT6GV1+0+7N8xPRF7aM+F5riqfrTjJgkUV+ZC68f2FjkNhzrSGNrvNgGTWsCrBkrPMv4yxAo/RWBqwxgp9qhfr1fui4ZS1oarl0iX6b1H8ZBEdFR/pZC1wU0858ech8nJ5BT7HDj9fkZz865jeVkwvFRiHBTFxsRYZ5X76zNQESnc2WVWKSRsuXgMdHZhrdT0exUrug9pcyAoAfNXNcSXNgA4AST1GcsEI5CFffN78GVCsvW6OQMDPtNGuILj+V9DwoYkafLdx+iS8K7ivfLSXS1pCE/VF5e7jsjCWEh6Vek39kITmae3mSsV2N1yPlhCD3FlTi97Tx13Sf2e4VT7WVJFm32qi7OSYI4Tel5tbL+2+xOmNSvmDO77kyuNWCC/uKwgaaouPmZYQtEuZPjqcPwSyKWHZtzvseEDO7XlU8jPmkfOyMYn0mvqzJBX6zOj2ITuCA6uhtjJvDNhx5QArcMAh58P0U+4lpOpmDQdS10CdmGzRWY3HR+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BStAXbc7z3LHQmIiHDVvdOFZ7vGkqvSNS7fv1Dljldfx3XCf6BBUGknt92ur44rXZs2Fc1f2u1464wGUxuBm3wf1lnD0ddjAo6Vdmo2Ubp2RkBc0tq8wTJz6Nwgj6C2czWfoBWGmdadQyUzzjjJC4j5zgnkeDSm4eQVWpAti//drmfoN+sXDX7GXh9zgPhAucvH1BWy72TZE/C8ioJtX8jlmXJDLP+BpUUk96azVzUeOxSz4emHOlu7RCsHzSh+YEnW+rdbiyXKVbE1gDWSYZ+MiuI5X4TlGVJw7olPEMgBEEjyxAFatwWuaB2262VlHnMfSdsPHnBC/StegUw8ps7iE9DtfIQHeULYutYT7CqLWsZb4iPbI8tLx/vLTOfCGd5D/2KHLfjhUWPxIlPmgonahd30C3VudF8tcjgCi1h1SrSmqe3sc7MSEg2zQqbtN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 09:57:55.9461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c89e2b-09a3-474c-f220-08de95554ed8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735
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

The condition was checking if VF is in one-VF mode to disable writes,
but should check if VF is NOT in one-VF mode. Add the missing negation.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 938361ecae05..17fea9a2aa28 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2057,7 +2057,7 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 	}
 
 	/* setting should not be allowed from VF if not in one VF mode */
-	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_is_pp_one_vf(adev)) {
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
 		dev_attr->attr.mode &= ~S_IWUGO;
 		dev_attr->store = NULL;
 	}
-- 
2.25.1

