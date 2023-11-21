Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED8EC61D90
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Nov 2023 15:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7F8310E4D5;
	Tue, 21 Nov 2023 15:06:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C805B10E4D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 15:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvCPlH2xUOsFb0PwJO9lZ90YmDgC/BwB3y1fdqOsG+4uQeZsbsH2s4h1nBoPbh9p43Hu3CChmkwlUKy8Ab1QQKXmjr9c9oQXzFjz9trqErk5+rPwZsQl/H9vYWDpxjdDL2Q97mxDKqpCjy+uHaOVVVX9uf00dQ9TsXSDG6JV5zC4krLBqxTaBQHmANCVtfNlrrxMMm1Sf130v4MZ3MOo56JaRFa7pHUnJoSvoQ4zM/fe91ryAjsVL+6mjDwb4YoIM/AtQZpCVjLAwxRSVb68i3LWpDCcjqn6H78c+sHk8EFhHuCsa1KgYgVOau7Q+6gA/oXREDhlQvjp2oY+QZ7U3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SC+zK+bSMMlJrIkGYsfzhkdnZzqlOVduQbmrup56YEw=;
 b=GEFUcZQ6nAFkDl5Hb5IThwFVQ12nOHtHrM03Moo3NwPCYOHZY+7NJP5yf+GA3e5GH5MXiz5AnTrXtQlQlkS3S1zsWk6tzGxpomXv6pLuan/MGDzPF945+1UpaQBEDrVNe91rGgYm5iHuIsVs3cifaRWRoJKJOR0TBz/Chg4rWP2ZJHLMXAx6CBBmERZQpli/VS9RqQrphVSOsulyry1/L97JlrVDHGNZ2y8pjWuqyPQbOX7o7XVWTbtZRP9EGfEGVdOdrAc8xdQEpD5gZCZEi8vTr30FdwNGUHFVR3HC9b+qS3PTgwAHCc+JIi34HbwkcttgNLkkHBO7ffKYj1HhNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SC+zK+bSMMlJrIkGYsfzhkdnZzqlOVduQbmrup56YEw=;
 b=pidAR4jGzMPzdmTcTaeqpgMy+dKzYlTXxjdw6RvGqUWXdeyKP2sveB2b255r6cCtEOeHwq0IXp5X/k5eRqB/hbki75kIYoShmmiJhUg5Yueqq2dU8I3tzS/Zp6VK0Lem2h1VLZCAUXqoVQr3/+YqZ5OvWxOmx8II2/esll2RBMQ=
Received: from PA7P264CA0144.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:377::12)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 15:06:17 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10a6:102:377:cafe::f3) by PA7P264CA0144.outlook.office365.com
 (2603:10a6:102:377::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Tue, 21 Nov 2023 15:06:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 15:06:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 09:06:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: fix AGP addressing when GART is not at 0
Date: Tue, 21 Nov 2023 10:05:56 -0500
Message-ID: <20231121150556.84900-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121150556.84900-1-alexander.deucher@amd.com>
References: <20231121150556.84900-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: d106a6cb-2833-4f43-d20e-08dbeaa36862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kedicT+3LDO93FTU0Kcdj5DDFPFVZKnAGysIV2e9qZ0NYiJ84QYkpICluRLMpEfJ1eweqlVuKTueEZc0vCunO0V9RCh2HA1WQZzAY7weplQWlQuUGXX0lz5Ojj4Ziebhu7Cag1XVaYqVTE6g+NlHBwEEEAabadyoRe5TVTLH7uDnx4kFFAhnk/rYctTafGqQWUFCCBzraX0H1P+TWj9VEi3szGrKmDyN6dANreBdM7zul2HnIZsG//9z2hc8EmzQhkJOfGPacFJQ/j8/uycP4HF/6VUdFsTlcpkzquf2VakJnwc3bVOLOLG0ilfOcEAcuzS4ttXuaq0VD1Vma3nRGoY/u4yYuE2ImX0ShhqH41HlJKw6H5fLujguFxiZoy8eA0Qvw7/mJdPLRwaQ7XWbxG4DqwGX+4nmJzY/RNgNZzfZ/cVFw3YtzSaNDrLgh8GzBFUsq7aX47U+H3itF1oAzkjBAPbWK1J2Mb5FYAw+85SvUGxXKvkegwFpdgIufZLRmNOr7sHUzfebbvm+Ut4MNz8yhY0B86VLpoIpDJSEKnOq8USuMDdgrY8Ndogo82oZg1PExdB0N8/NbnMHYX4clcb1At/xn0/94xgjh7RF0gAqF+x7FM/V69BpHXiJtPsExckWd5M/OZx5NH/OQ0GanvLT3YNq0EegeVhK2glp02U4hsOctQMRqmrNK2SMVF2MIQyGST0JUhOSRc7Fs2s3yANcvbX6VU3XdXazCEszFR2Zak+iqV7tAIoTPZhFnkxGPdXUd2vSsx7rznuubi7hsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(83380400001)(356005)(81166007)(478600001)(7696005)(16526019)(26005)(6666004)(82740400003)(54906003)(316002)(6916009)(70206006)(70586007)(36860700001)(47076005)(2616005)(426003)(336012)(1076003)(8936002)(4326008)(8676002)(2906002)(5660300002)(41300700001)(86362001)(36756003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 15:06:15.4151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d106a6cb-2833-4f43-d20e-08dbeaa36862
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This worked by luck if the GART aperture ended up at 0.  When
we ended up moving GART on some chips, the GART aperture ended
up offsetting the the AGP address since the resource->start is
a GART offset, not an MC address.  Fix this by moving the AGP
address setup into amdgpu_bo_gpu_offset_no_check().

v2: check mem_type before checking agp
v3: check if the ttm bo has a ttm_tt allocated yet

Fixes: 67318cb84341 ("drm/amdgpu/gmc11: set gart placement GC11")
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Reported-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reported-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: christian.koenig@amd.com
Cc: mario.limonciello@amd.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  4 +---
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 0f85f906791b..a0dda572e490 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -184,6 +184,9 @@ uint64_t amdgpu_gmc_agp_addr(struct ttm_buffer_object *bo)
 	if (!adev->gmc.agp_size)
 		return AMDGPU_BO_INVALID_OFFSET;
 
+	if (!bo->ttm)
+		return AMDGPU_BO_INVALID_OFFSET;
+
 	if (bo->ttm->num_pages != 1 || bo->ttm->caching == ttm_cached)
 		return AMDGPU_BO_INVALID_OFFSET;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index c938648de853..c24f7b2c04c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1538,10 +1538,14 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
 u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	uint64_t offset;
+	uint64_t offset = AMDGPU_BO_INVALID_OFFSET;
 
-	offset = (bo->tbo.resource->start << PAGE_SHIFT) +
-		 amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
+	if (bo->tbo.resource->mem_type == TTM_PL_TT)
+		offset = amdgpu_gmc_agp_addr(&bo->tbo);
+
+	if (offset == AMDGPU_BO_INVALID_OFFSET)
+		offset = (bo->tbo.resource->start << PAGE_SHIFT) +
+			amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
 
 	return amdgpu_gmc_sign_extend(offset);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 05991c5c8ddb..ab4a762aed5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -959,10 +959,8 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
 		return 0;
 
 	addr = amdgpu_gmc_agp_addr(bo);
-	if (addr != AMDGPU_BO_INVALID_OFFSET) {
-		bo->resource->start = addr >> PAGE_SHIFT;
+	if (addr != AMDGPU_BO_INVALID_OFFSET)
 		return 0;
-	}
 
 	/* allocate GART space */
 	placement.num_placement = 1;
-- 
2.42.0

