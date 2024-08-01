Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F4FC3DA64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 07:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CDC810E89D;
	Thu,  1 Aug 2024 07:04:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rYSeWZVp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BC5210E89D
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 07:04:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPGLegW9V9CxYBtL/kCTAc2OexdTv6nuSQB5eytOXaFF7kxkeGAdz9eqOsGIChBkQ6EeVptqZhrQEkSsEuYbqYEuU8LVo7oP3yKR7VIKuq7JjcRkWF3IQbQcMHajYxERXlXHvtsci0T4MPZp9dzKA1WqCy8krJ3ISMgaKqN+XRbBhscCW1fQ2DvVgUpGyi1v797MhuicNqSh3lLbGNE8J9iLNCRVG5XEvu9uUxAAXPP5t/by/8qmtQOy2NJUEEVO09Qb2Z0kVRG/l7O6ini8muLWMd7+m3I2avZviPstrpR0OBY7aOy2x1xRd15uRI5fxCLOSTdJ9qnk6LfpHTwbsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M87z0F3LGU/52I8sHTFox65I6Vv1lP7JZhaqsfJJbB8=;
 b=wuBj1T8jgU/M/q5nX81zsXnAxXw7SohYm3HsQGFwmDkPwu6YGQ3T8xWEgYoHQc4Ef4KAOzLYl/WpvDQ+H59XlFwQuVqrkGVAkjCmHqSzMWawd+gLacHBa+ckeqr4+2z99UUhoHE7aYQO2dSj5wL2jjDKiQx8w93wVmO5N1NoigtYCRfMFUMyNUwWw4LClBXmLOZ8aZRCWRtBwPl5m49YjakxHTi2/oeI0bEyD/XXtrAmZSdqfmPG/osoa7IuwpuhCP0UNDxKD8vmNycfBB4GKCguNW1QeaeD3GvDABwca1uaiJ15EpKz66kpHiGXJHogGFcf34GLxEsZutnB8a0AjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M87z0F3LGU/52I8sHTFox65I6Vv1lP7JZhaqsfJJbB8=;
 b=rYSeWZVpKXdNQXBX8vshs10cpOFixT4bx5bfIACIjbR/v60wbPpltZtHT29NAgkAUTIKrD+y9fLqn0bemNrHCUysTcHHm8cR0/6u97vfI9Fr+CXo8EdAmNB/RY2Mf7Hn+T5MluKmOE9H/XCeh2DwU6v8BB2JYrYmsYFVjCI6z8w=
Received: from BY5PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:1e0::38)
 by IA0PR12MB8982.namprd12.prod.outlook.com (2603:10b6:208:481::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 1 Aug
 2024 07:04:47 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::67) by BY5PR03CA0028.outlook.office365.com
 (2603:10b6:a03:1e0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Thu, 1 Aug 2024 07:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 07:04:46 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 02:04:42 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <jesse.zhang@amd.com>, <bob.zhou@amd.com>, Tim Huang <tim.huang@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: fix unchecked return value warning for
 amdgpu_gfx
Date: Thu, 1 Aug 2024 15:03:31 +0800
Message-ID: <20240801070333.423881-2-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801070333.423881-1-tim.huang@amd.com>
References: <20240801070333.423881-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|IA0PR12MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e37286-bc60-4f1e-3bcc-08dcb1f83a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+aEireVOcdiZ4KKWn2wJmZgjk46AZBhi0qhghYY/ni06smf8Jwvh4ZoV1vJG?=
 =?us-ascii?Q?IJr2OlKMSVPEFufYH3P+dewRxZzI0EqdU6an+K9gr08ciYmqXLTHTHX5qijU?=
 =?us-ascii?Q?UxP31RCV9jn7KyrxgHHqZ6DvQak84eBNBNujj0n7eyrs1eIldq3sRcsCFiQZ?=
 =?us-ascii?Q?OgWiBIdBtJUNcn5tJSB1lugrl8/lzVx3baBQjZ3Oe+eMABff0z5U382I5sUm?=
 =?us-ascii?Q?zgVkEb66GJzqQw0Clelhsxb4RMVbSRXJUa6/cg/+8S8ruZF2ywUYLdWkzTEO?=
 =?us-ascii?Q?I6bL7dr6kpoAv4u3gI6sNstPIIHa7chaP878rFlRH0NNuSNmgZQl5Bky5/MD?=
 =?us-ascii?Q?AuJq8ootMwoUS+rD+2HWHxtjaUBdJXIajTZKo0LoPP29jxnftn7QU3Ujrseh?=
 =?us-ascii?Q?u5mEAdF+fz2mzLRIJAfYI4z6ZG910l1cukuu+ffwrXr+4cWVNhTY0Op5kwGX?=
 =?us-ascii?Q?4YN/8CKSeTtSgQTvOWGu8Y4lB4GerINhcauuWRoBMCt34f+d598KK4Dit+61?=
 =?us-ascii?Q?10Cq9h11d+H3ologyuKEAZoacP6FEin8G80x2xyounbjkq5itPP0bxWO+YPD?=
 =?us-ascii?Q?CB/n89YTTSG81u2SxuUEsZSGkOeyRn9dcQ5FdpNrNbLaaY/9UvtLzX0fWzjU?=
 =?us-ascii?Q?OfmeikuZOCNSyCLdpVQ5uVas1NP5qa9Q38BRB8xWAxvZ94QJ2Q3yRrA2wXv+?=
 =?us-ascii?Q?GeMUbblFio8IWFWPfQtWGi7Nk4ebr9rhwsncenBA9YDkfilsXxHttZXxZRK0?=
 =?us-ascii?Q?fPr+57jMd2y7nRInEl5aVwMQ3XS+GIHFi4iXbWHZZRXUaC4QO2P/V+hbB1mP?=
 =?us-ascii?Q?M3wieMbWfGh/EkFfq4vOC6LmbIGI2jBRuVb9FJWrSxywDkesg+E58V2Cs3L8?=
 =?us-ascii?Q?M4ZTV61PT1Po9eDoUJkQLxnhuYQpa6TBCoEirxDv9qNV0PmQYxj9YfoAfoi5?=
 =?us-ascii?Q?WEI9mwyKZmsv6QLyCWCKXe4Cg2XsPfsWW9ykxDvohpcGv+/pOmyg7WTMvhrt?=
 =?us-ascii?Q?N13PA+BeJdrj0jhoWNQv4+804V/AKZbP0x0L+gqwhH15coknL/+c9SHAXqxC?=
 =?us-ascii?Q?MbB+MAohtwqUtoKzKNzyIYnYz57Z3Ul9T4oWd42pkxxXVIhYMbvG6c+jl2Ze?=
 =?us-ascii?Q?wxQtTqcBFVZwTUMjxv420pQ8SRBEywawk+JKLYDk91hsPQVj/Mg3nlZVdF90?=
 =?us-ascii?Q?zl2T+vO6DcHOpQnwmNSL5n5qfclDcdh6x5HVCxjPrrs05Bjyvc60avqcV/jC?=
 =?us-ascii?Q?FMnyfKQ4W4IuejZsEWyLKXXTfFXKB/RHu+FC+RfMzyt+U8My4LKuDNAom9l6?=
 =?us-ascii?Q?6Eh98R2zLkCxsxrpGHdiEh8GgD8LUGdwaCw+PUY8K+s0ya+oEnYpaZ5wISFu?=
 =?us-ascii?Q?aSMtw3swtIftLMvsSfqzoLAy5Onc7lcfovQ23aZ8PWcUF375s0AWJxFN2npO?=
 =?us-ascii?Q?/a7x90si3rr/awTolzXbsVI8jGtDziNZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 07:04:46.5564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e37286-bc60-4f1e-3bcc-08dcb1f83a41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8982
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

This resolves the unchecded return value warning reported by Coverity.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 82452606ae6c..5c9f36f01db0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -860,8 +860,11 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 	int r;
 
 	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
-		if (!amdgpu_persistent_edc_harvesting_supported(adev))
-			amdgpu_ras_reset_error_status(adev, AMDGPU_RAS_BLOCK__GFX);
+		if (!amdgpu_persistent_edc_harvesting_supported(adev)) {
+			r = amdgpu_ras_reset_error_status(adev, AMDGPU_RAS_BLOCK__GFX);
+			if (r)
+				return r;
+		}
 
 		r = amdgpu_ras_block_late_init(adev, ras_block);
 		if (r)
@@ -1005,7 +1008,10 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
 		pr_err("critical bug! too many kiq readers\n");
 		goto failed_unlock;
 	}
-	amdgpu_ring_alloc(ring, 32);
+	r = amdgpu_ring_alloc(ring, 32);
+	if (r)
+		goto failed_unlock;
+
 	amdgpu_ring_emit_rreg(ring, reg, reg_val_offs);
 	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
 	if (r)
@@ -1071,7 +1077,10 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 	}
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
-	amdgpu_ring_alloc(ring, 32);
+	r = amdgpu_ring_alloc(ring, 32);
+	if (r)
+		goto failed_unlock;
+
 	amdgpu_ring_emit_wreg(ring, reg, v);
 	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
 	if (r)
@@ -1107,6 +1116,7 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 
 failed_undo:
 	amdgpu_ring_undo(ring);
+failed_unlock:
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq_write:
 	dev_err(adev->dev, "failed to write reg:%x\n", reg);
-- 
2.43.0

