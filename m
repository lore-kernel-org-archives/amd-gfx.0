Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62F2C88E50
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 15:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CBC610F696;
	Fri, 11 Sep 2026 15:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j/JDsJ6/";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2785310F693
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 15:42:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHdPqzZag+YFqESEW24ER/Qta6QfMfqBwdvrtpzCdnDnu2gA/tBSfoTZ/OUtdpuqbCOAyqj/b+D9HXBeR/T3A5YCWTrCyu2ygAjXOTb7Wm1p5ChU3vTFlBj1PS9H/jeJDq6rGZQZ1t1a+nWYesJjNBgOAgg5Qtyh3J03da6ufeq1KEz1U0dXongsyWV6LIlEI9+PJ+Iz+GZTztDMstGc5ULoCGS/SpJgsOGJ6PLnYZs0JULCYQNf4Jov2gIoukiTLWVfcw8wPoqM5gKZ08M1Nbs1mqQTiwnZvBL+Sbfpiumhgg0wFlpV5nhTbVgpRfwFvQ7CsHUxdKG5FJq4E0Pyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=km5S3GTDCJkLD2aUQe8hF0a+Bdr33qCdACs26rPA2kM=;
 b=aFfIznfRgnyES7SvJluPz5l3ciAXeLmdhY7TdDBtemgkXKgUkc3AxFAfK9HCLOh9jHWOKmmh98uWwlpU3ZP9RyQAeK9e5X0UayQtu8K9BnNtmoEHw419eQ/Unq30b4SNFNp6HBbeYafBpnlKQo3goQUeNkICWC2xHq7bu9Xu7Tx9rG7fT9drGH4tRkqC0A2Js0n4K5d1LPhjYXdqN3HneP186cmzuN4Ws72/7bVtMjQyBdeXHnFbSNxWhSS1OfWv0SUDJvMmdUwHEhC7qhBMugXdi/LnyYyys6GYvZR/s1AbniJnOnPrFr+79JMDg8ll0LqOsVk03r898a3AxuHcqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=km5S3GTDCJkLD2aUQe8hF0a+Bdr33qCdACs26rPA2kM=;
 b=j/JDsJ6/7FDlbXsYdL6OQGK7u3S12M9k4eyGlHOosNw0lRHUzo+T2FSYMEmvR47JlerLrb2DRbxg0dpEbINePW7+N+TC7K/QWyVbTpkRJWIZbbovD3O74AESXf+Kzm328QuAH5K2pUFufnpi9CdNC1S+0iYxvKi65QnWnmgM+Qs=
Received: from CH2PR07CA0041.namprd07.prod.outlook.com (2603:10b6:610:5b::15)
 by CH3PR12MB9343.namprd12.prod.outlook.com (2603:10b6:610:1c0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:42:26 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::80) by CH2PR07CA0041.outlook.office365.com
 (2603:10b6:610:5b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 15:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:42:26 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 10:42:24 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 4/8] drm/amdgpu: push down runtime pm handling in
 amdgpu_gem_create_ioctl
Date: Fri, 11 Sep 2026 11:42:07 -0400
Message-ID: <20260911154212.591213-5-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911154212.591213-1-shahyan.soltani@amd.com>
References: <20260911154212.591213-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|CH3PR12MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bfdb4d5-bd35-4639-3717-08df101b47d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: BMrvSe5DlgwrxKgrXGlBixem+l80i8TJi2vxeMaTeY0MoW11bxmrevmFC7ih5Mr9G0hJzeF9sDdC7HwJbdfvftro8NhhUXSA+nD74wz89oyLzQjhdyW7yFCf/gSVtzkEaYniUssttaQcaQdyHYR/iRHDxflJWJwaBGADCUUjf0MoGxr1of8O5b7Fa2MtKcYDY482pe4Smeg15wzga62S0MtpoH6Xfwp3Sdv8S+ADiBRSyswpChCZAKhKXM2g9UH3EJdZUk712wDtfHgBtlXqknCgPyfDa70kUMIjblruOEtf9cG1G6mvs9zUF27z6WCQH63657AY4ctwAWZdOoWxJHRqTEL28QK3mvIwOSrjvVvxgdapNc4htdIU77eXvNjOEn9qYx/bseyYUOrzPOJO/7/Br6mzyk6USpTEIQUuX4dAuK12wp8BdFNAu4gwrqDhkjzHOu5ClpegHODwnxPBrwirtm3gnoDD56Aqs7Deaf3b+cdwgcKtxTtq/wcAKzEFWsS0zOFlcBtt7ZhzCICb9NJa8V7Rq0/sutPQnvfnIk1l8RNJmkfmQBqx4Z92fu8uikpJWUgy9oFAK0Zwp1mQ9gSyjqG5UxP/qrOfg0zgAqyPf+Q+bgudCxFiNMN56ZkcUy3rGKYk06UutZUu1kD+wTh2uAE45figtUfrY2NEPhpFu/gdDlyxLXSbqq+BES+8EMlT0wIZ7lDuRtnwDNaN/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yYvr6c4D/etVlg622Mv5v73ChyW+SZHG39z/p6+qlX91YVD8sX6LbBjY7ED0tGYrakrN5DpVo1wLRIXzOw8ggOiKMsEK8QqaxCQyUJrtunAE09zxNm3N1vFyLiozXDi33N/tR2TNW9cnhTgsZRGh/j0CEUiamh2DFgyLwO28ba1CnCyy9SqsMuzS/pkwkPmy5Bny90REDmvmB0wT6wkj80o09AZkuAm0BjSmX0W5wiQLDOIRG0zXpYECv2/8QvXWPVhrqkBOP5DXeG38HWi3npzE44qjdMUw65b8FtGHWg6HhXRPBwZprvYIUGqazON3bx/3oF+FDK0JOwAUeqgA2pPk1t9f9PVmF5fN4wYTRdzTeTUUgd3FcLlXXaag8XpYJkG/5zu/kd60EikAth5Ts1MWxPFy4axjTLNTseESPLPgIszSKqd4jsiwhNyevbkf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:42:26.4580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfdb4d5-bd35-4639-3717-08df101b47d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9343
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

For now use the same logic as the existing one, but it's not 100%
correct since:
1) most operations don't need the GPUs
2) some operations that need it are actually deferred

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 7b92e7b9fbb8..319afa5e724e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -990,6 +990,14 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	if (r)
 		goto error;
 
+	/* FIXME: only PRT operations use the GPU to update mapping, but
+	 * some operations are deferred to fences callbacks so it's not
+	 * trivial to fix.
+	 */
+	r = pm_runtime_resume_and_get(adev->dev);
+	if (r < 0)
+		return r;
+
 	switch (args->operation) {
 	case AMDGPU_VA_OP_MAP:
 		r = amdgpu_vm_bo_map(adev, bo_va, args->va_address,
@@ -1043,6 +1051,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 
 	}
 
+	pm_runtime_put_autosuspend(adev->dev);
+
 error:
 	dma_fence_chain_free(timeline_chain);
 	if (timeline_syncobj)
-- 
2.55.0

