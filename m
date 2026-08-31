Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BC9C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4DDD10EA4D;
	Mon, 31 Aug 2026 18:28:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="giOmC8Fi";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013029.outbound.protection.outlook.com
 [40.93.196.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25FB310E9FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryDfeeEnjfnzwFxk/z9UnvxJc2BunYzd/+8FgfBHFlsqXKnadSN7mvMQGCRQy9nBeIeR18CZB7/ZYKRxJuWd6G5l1WBDJOZtnaUv4ah3pyipx0l+ixwU9Nvt+XYS6yS5/8sfAg0SqgeIzXwKBtH+xRdPto+aA5/FbSdjTO+5pB8sR3K9vn2AVS10kEMAWdrkNbO8cLsHYY172oOxVSfaPupsdN7Hw/zxkEvEZlNb6cAofVYqlr+yj9aoc9k+bWakiaNqXbtK+xb0He+Bv2KjdkiZtFYPcFz2hVMisu1DwQ487mt/cyMPxkFiq/Cg71OVyjsMBjqV6PqbTprimjVmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9GrZ4cx94+386156KxbVzTWWGOSAeiQxpOO31iMWGo=;
 b=aM8itQGmqqXqf07vUt3TGkQ9W9Q5LQ8NT5/hBDq3rw2FIa7Q/hPFb/kvZ5vU5yResSlYyh1rOGxmoCqm97mgzH5IV40oMK4cuADifoNsvCw5ZbbrYWOVZK60WtPwaxZnFH9U7crQBsugQLVmiP45OX2WBuR9q+Lxu0btc8sqAa+R6rRX4yK4U01dFAjS2TIdgm1EpBW1MI2D3mmRQqiM4WWP+YJZvKLSfj38/+oEclv+ttiSkGU8Tol+69dDwcGcNEClOlylSZQJrDIzlHCbdyixRATpsn3j2c5vKaeLb9NCDwFknCvXvPVfo748UNXpJDEzlT905Ry+G+GkoA2kPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9GrZ4cx94+386156KxbVzTWWGOSAeiQxpOO31iMWGo=;
 b=giOmC8FifXB7h4Gp3uhTWsPgn5FMHqzlatAOjIJuOicAGdrsaopYybUlE+PC9TN81zVKPCshRxhoGu1YnCL9lQbh5mp4ABMJHnNiAyi1PjPwO/6Sv7kTgJPHjYrt7ZAqQXDLyOLvBbeMh3hI2YPfJmhvYmvyEpBTJM2gF7nwYwo=
Received: from BN9PR03CA0635.namprd03.prod.outlook.com (2603:10b6:408:13b::10)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:28 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::8d) by BN9PR03CA0635.outlook.office365.com
 (2603:10b6:408:13b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:13 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/95] drm/amdgpu: Set physical pod configuration to PSP
Date: Mon, 31 Aug 2026 14:26:30 -0400
Message-ID: <20260831182754.1089811-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|MW4PR12MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: ef738f51-2a9d-4d7e-eb53-08df078da4d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|10067099003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: a98MxFr4VXteHlxeJkXnb6oa1GWthH58uYwAeRtbydFfV5VWh8EkaUQPRu01P2uwlQzUz4+kBIPmdOD2/ySjTVwGrcYUeyUj6HTXmAPDzgmLLqE5my6d++5vMNHtOCyc4L9RfDgcXACXtn5br3Yw9v9ZcNYVLtvrsFoNTKsJnne5jvTTkWfPzO6te6hrolxuax7wdvLDB6gs9rjAbImqZqlApNHWYqFsDqAH4iENpsj0jTBJHrigBDVU8C/pyw0mmbr1Z08lwsIFIRqLAR3181M0ZTDyltXIezG+HwkcN+HxxJBH3NRAB0kgY5KpQfX7zsJTJ1vvadz0kkzkXEYuCZJ2UkyB1mTugenaNyl8inXUldDVLwwgmM9VH0Mal4Ie7SoduvWoSB/DC9ceBxEJxoPfL8r9RCZBDnjtReosVfFp41rPU5hM2Gju0PxvSf4j6U/OYtVAZv26XWchkGCWFiQpS0dnii0No5CXNBqtIeikDB9mEApdh4jq9AFGV7mLoCuEUnQnX5N9YoO7iyS7ApNlZIBOSxXqVjLU0/Jic26UcjgsB5zt1jV7392BJ5KEP3qBRbgjoGutBpNYM8GwCoP2K/Z+QWtygO2YiqyVqbVR8XNMBOwmzQljxFOxSe1RGgbK1UgNfsaHBgINYHEaluaqBWuKWlDUN5kzuMSX+VLL5VazLCqsITxi3C3LIc3cRSuxC95JgdlVjuO9/rLctA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GKjg8B0jwX1Jf2zaSJU8DQkum4ir3HyZCmzwUf7RjADQ08gsyYuai1Nv/Qj12BNz0q9dWfIyWCIJOXnmiJnchniFcnpH471ijtvAmmrQ6iRb/bxXyIhdnPCHSbZCLDJP/1NchrM2jH7SZIzPN2s2HDYh6pt1/rGJii3QbjrCShTlb+qOYdiPO8Kd9dCNOovYtK/QU4rgzjdmpA6T6/Klm78hruPgtLGRCJ94OaybJaC7sjjtoTXvXVRvJQgzd/R+Wvtf4mZvyu0G+OkTyc1N1joGIPAeks0ST5Gq8OvlKkMwnvmLfQZPbFNk1gklwU3cuRdkqRMowtGKaUnup04mTbqPanc5UsVuSd2bhjFz3deJi6QIjr9rd3SRVCrnlIzag0ZxaE/Ih3ZCFH3yoZLPfCzSGd0SbleWxV5zhGGMtTdawos3ITjdMVAKlhUd69GQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:24.6480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef738f51-2a9d-4d7e-eb53-08df078da4d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334
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

From: Felix Kuehling <felix.kuehling@amd.com>

Set the physical pod configuration to PSP in the commit store callback.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 41d39f828dfec..6fd1238a50691 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -430,13 +430,19 @@ static ssize_t ualink_ppod_setup_commit_store(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(info->kobj.parent);
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	int r;
 
 	if (!sysfs_streq(buf, "true"))
 		return -EINVAL;
 
-	/* TODO: Send configuration to ASP */
+	r = psp_ual_set_ppod_config(&adev->psp, adev->ualink.psp_if_ver,
+				    setup);
+	if (r)
+		return r;
+	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver, info);
+	if (r)
+		return r;
 
-	info->ppod = setup->ppod;
 	info->accel_state = check_ppod_state(adev, setup);
 
 	/* TODO: If accel_state was ACTIVE, reset all connections */
-- 
2.55.0

