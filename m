Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627FBC982D2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 19:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C827510F0BF;
	Thu, 17 Sep 2026 19:58:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PIRZ0ZZb";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2132510F0BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 19:58:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGGXYFaM3aZqr0Saj5deQKri6xTADeelkWBUVnf1uMzBIWqwmtgv9Dvu5oDT0V9BdzcMUYqk5ASgp/CEAXLvgkNaMyiWkZxhIiOAAPAE4Spl7G8Z5FeYIQ7IeZzcuH6rNor5TXe0AMbTpi6jztuDw1ktROjlpSEC/gVJMya6USTx0rHslCGIgKYoZlFS3AXtqAcwJrnux3QTN93z9E3InTInLqPb3oa97+FNR86V8/mEq7GK7OsGCa5IgTr6T9mpZst+mk2s2yDRW9m408LSRQy9nIZocq9FySP3oUiA8KAEnuqNqj55Pevp3T4To4yY1TyKCAplhWNkug99yex5pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juM2NCRFnQpiisMqWgyiUqDT9nxuBzxX9Kn6fYAloYY=;
 b=uEu5xXSIK5RcjxRdOycRsnHtPVYzBnWo1J1rTm7jV74322JsNwaJBmnO1RdtY1NzdAZF4vuTb+Yy9Sm7Hpfwq83+WbR88VpjzwTem9oD+ccZy7MbsYiELICxxnlvF5vRwFTTSYPkobzjNlW/vFQOW5kh+hHeOaF4rwg9HBjNcF1Xk9+u6D0Cu5ZJb752H7YOtUJ2grp6yh2uD+4ctVAc9OLM5qR2XIpA4p8qhtOpas7oXwJLbQMxwbjQKrkFUVy9JZ+5KHNzwc+stiy6z4Zwr5jarnnoch2JT51AgAcMMI3Gw0JWDp4lkwL6YgGiVUb0tfk2DEIPzrwMSidgGfAjNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juM2NCRFnQpiisMqWgyiUqDT9nxuBzxX9Kn6fYAloYY=;
 b=PIRZ0ZZbCG7rDnu6HSu9X1m81nmMZchWE8bcxffbm12d53i49aYxmg69TfebmGhpUszU8UX3pxd6nhKtLYnY74WjKBBq+/WzYokHIYwJoYFH6OJgUxWD3JB8Ew0xcVttNu6F6ROlPprR62OZ9fu5qltw9tZx4ghRJgHDWY1i+eo=
Received: from MN0PR04CA0009.namprd04.prod.outlook.com (2603:10b6:208:52d::30)
 by PH9PR12MB252631.namprd12.prod.outlook.com (2603:10b6:510:42d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Thu, 17 Sep
 2026 19:58:29 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::a) by MN0PR04CA0009.outlook.office365.com
 (2603:10b6:208:52d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 19:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 19:58:28 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 14:58:24 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kevin.wang@amd.com>
Subject: [PATCH v2 4/8] drm/amdgpu: push down runtime pm handling in
 amdgpu_gem_create_ioctl
Date: Thu, 17 Sep 2026 15:58:05 -0400
Message-ID: <20260917195812.72917-5-shahyan.soltani@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|PH9PR12MB252631:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e4a31d-8819-4bc1-24d9-08df14f60ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|18002099003|11063799006|10067099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: oiYs4GwGIXIRbhWYTMBBGC5VvKIhpt4FzgAvmKe2kMM7tVECgtYA3GDp1yO1vNZeK8hLm4Db9XOeGapIhW9vvuZd4uoZOlSJelDUMEzePDXdcv5dGUlWciU1MzsWxkA/tSk1a5oGwi9QYveMznFHT0w7PkqBnoccrLKQ2NFWxaf9/7+E9gK/1foqNcMWn57Y1OxLRnidubYgJ5wq0EUIZffwJy8RIRPtI5qb+5IeBTyY3i+9aVeJwz8mrYxcluXXrMwL/4vZ6g9NqHl/bnEAN4pSUJC3jE0gUOusMmSxUGegKoBO2cMm/rSTAaLXqTu9BOSfjqJH9WiP7nJaGR8CS2zogjp6QcACdPzDGasWDEbV9MtMfXyJ+MR99sivU8LXDYePlGtwI+ifZR1Z5sLMIokwiEQ/V3xDvmumkIJ1UqrCm8HFXTurmLFjQ/OFeB0J1KZeY4g8K2nQ9UxLr9LFzRnhCo3Ro6b0dsS5wLfc4cITW2FCZBWg2fh71VmTOnwfqJlqiltZ7NN0XgoLjQU3FzysUczoJ4T43sAsG5ZFdxQjQiIwgUv1NT6Vrev1keRN2PDvzEtijbQup00htL4GtIEVn92T/pqbLCShkdBzgaC21JY7CZQjViGpUAn4jS4XzarnOZhbsEncO30rnMhaOrAw/Di8rUKY6q/jISYZXtEQQbX96Eeoj631f9O8BgqwgSBjSiwWWkVR7nBmAoYWIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(18002099003)(11063799006)(10067099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7Db5+ZT4OBJuXTozTm43dESxcTW7hA/VYAAM3kslrDyf7o/rU0qne0FsaQTqT9pQcBV45yfbXv73TNWB/e7Itqtkc9H8IqkvzKXGGFngJGEjQ9H2MMPKoXC1isId1/qUnDfj4EICwtzqlqjQacJJ/SOP+OUQ9adamuZh5+j1cR771IH8jIFThMy9rzpr7d4nXeYAPeuF4tJOPLnqz+TNWiPnPpS0gM//aqgovKWl7SC4s9ZruOfOUxJgEF2PG+gpV+NF/lkBevIRPFsNZI0VlPpJrzlTx0TfNGCESzrM2+jN8KWNUkBbS4M7rAAcyCUPHoZWLbG0yIVIICocm0fKlfZGQBBWUb500CaZqXNjDBCdcYlmJ619G1p6zZAkhaa6q/x3CId5bSkcHA1hNPZ2VSr4uJ4RT2ymGUDtTII4pfZUiKH+Wk5fxFyCHuHave7J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 19:58:28.5666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e4a31d-8819-4bc1-24d9-08df14f60ae1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB252631
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
index 4e4814caf61a..6edd03647c2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -978,6 +978,14 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
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
@@ -1031,6 +1039,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 
 	}
 
+	pm_runtime_put_autosuspend(adev->dev);
+
 error:
 	dma_fence_chain_free(timeline_chain);
 	if (timeline_syncobj)
-- 
2.55.0

