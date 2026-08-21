Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FC4C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 382D610E33B;
	Fri, 21 Aug 2026 19:50:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ikeLzLKo";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1108910E33B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:50:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCPLnaPjaSV4k8GNWei+ucexWMMnQFTiukD0IrnqW+xQ3Mn19TD/CTCGPgh9vyIU1tHh98+cK/u1oLhPKY56s154wZrHK1Q57yDmDzjqVLxNnyNrqCZapu0KuWNA+TYtVCSrDwIkR5+tfTGjyfdx6NlWpVzWbmNLluMAHXnLjXv3A2OFj1ocgQVMsLBN0u6mtDduL27hc4RcexkZRE2AtnCP3weapryF9lRb+NredEzq8+H7roYflSNuMEPNcg4pXZlOarrIfBMwiiEeUKld71kQAIVYNOYJteYlc9I/mfQCz+XgWgXEkLY/SURY/+6JzF+TJPOCWZWYPZUl6PmLIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/x2cKsu7RLtYVSCW4nP6VH4I0ztjHj0PpQjAz1PTcXY=;
 b=ILPT/JyfkwUkbxHqxsckW18xY+Q9c8NAOmyDBD5yIPC8R/ONOpCirmQZBPAErSY9T3znpdGBxNqBLbpQiB2dumG93Av1qXdO8+qVei3IucTwj0GUMWA3c25X9ExbH/5guJukeQ/hLlzGTqu8EJuimAm2c+2cM6aYO330JrMPCrYAiewmA2vq33OkDPMn8ROrFXgO1Q4J1NyfQXwJPTtqOWki4hU1hTQsIHHc3MgI/02SlEW8XeW84gA3n37xE9PNW7C1mdT+ZZe/x/bGa69+87ohANAaMSlMR4UUsJNJccQN2uH87hY7+OqAQ5JzbGW5gzDiOoLXnYqNzdBONTM5Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/x2cKsu7RLtYVSCW4nP6VH4I0ztjHj0PpQjAz1PTcXY=;
 b=ikeLzLKotx+S9hWburoVJqXIpwvZnolzbzkMMhbtKpPv0o6ec2aQi+72cGk6MH93WQg2seYE5rfpXLYmerrjjwafaj/5Y7mjToKosH7AXgscRDfTtoJ8D2mxZCB1kCrLBMTha/AlfRl3B/asMQXfRwozamaUZbADwoST2oxi3Jc=
Received: from CH5P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::17)
 by LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:26 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::9b) by CH5P222CA0008.outlook.office365.com
 (2603:10b6:610:1ee::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:18 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/95] drm/amdgpu: Set physical pod configuration to PSP
Date: Fri, 21 Aug 2026 15:33:34 -0400
Message-ID: <20260821193458.808626-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d975bd-853a-480c-7b5d-08deffbb59ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tmis85GejbDsrIUTk6B2F1RfjDu9UYzUDtegSh+9PeF6YsaHnKcR2BCFYtMZxZCbxp6e44WfB9xdLS3Lnz388KYH36bpTmTjZtdP7DJwsmEnDjr1HnfFC21GR+swgRgcnzN6183jC1pmlJ8DBFL2j2DtYNp06s+w4MFURseDMJSru14f0OvBAClH2jS2CvX4QO3GAWWl/h1yaYjSJ3RhUUtJzsj5MlowzV3+8Jje6m+Al6KBtG0XcvCBjogX0yXORNBk5a30FLNfUl2iPrjq2HBeQKmjwh3kUdqFkbDwHUprXhDCZNUs6TJlOiEpGtLhqfZgnOg/UAY8OYN10Y4hl/5bvuRo/9z7kM9zjQETR/pFpne/OEd8GcNLPQrwdLo59Fb/ePg05kFPrMestZw423TgeWNDJI5v+i+4YpJq8tgqcVOrQfXOXJ97zIzDI8WHowz5t1oQumqX/gD/ZYA0oHfyFcQflAYYMV37EAZMmWOx8rG25x+aGWbTmvbMS3xaFz7gkDoRK8QBLdlCg9EjP69PQC2YymOl0fTWkEiDZmsTF/aaABZoVD10kSHUwzCNTrx6ix1s8wOvZJx7Bm5QQKFxaXRwTHiLdU4EW6EhKjg56hAMy1vSVybHJ109eL7ASRy9cyqkxl7KQAx+Qv6GARYOZPKsQPg+Z3CElPFX0DYlrpKfNYZaFelDSW6q8fRWC3/tMypGLzKFIof2CHzcPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NJrffwB7RW1DV55e+Sa9YLSENaG4YabWzuW3+YzW7+z5KnGTdoQg6aofYVq5x71/fzCOplksZkCzBrPuwsN1Zoka8EAJEwjHEKxarG9T+SJzK8yQSU0AcS9nDu49xEUeboqh/JaNnL17vg3/5uQ5e/09Qw3hw55jJJjM4eUU1oKOSMG1lhFgbJj7LDaF2uoxoXYvgZZ4fnzUrjxXn2zDLv6sTbVWzg2NwkAMCAWlsHGxqV0tnLEatvUNb49uPvnz3m1rTvb5BJXBHpm0SGYk6cxYWZTgwpoo7xyPm4hbv+UnNWCS5hPyjh2ewWFbg926cgXjZ8qpTo9o1mEPThg42NZBIAmpbRk7MeP19nX4NYjj8W/5fq2Hk6PlWPSitjVQ7VU96b0ULUhTjJK8qiLuRgPXLtfj2zratMjMU7wbXKFrSo2qeLRZ/rrnwLeSYvNb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:26.1010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d975bd-853a-480c-7b5d-08deffbb59ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402
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
index 69d3f430f1f6a..706e4effb1a8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -408,13 +408,19 @@ static ssize_t ualink_ppod_setup_commit_store(struct kobject *kobj,
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

