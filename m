Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51597CAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 16:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E37BB10E248;
	Wed, 24 Sep 2025 16:16:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DVInRCBu";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6BE310E244
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 16:16:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvqDRIgPR7x3bChvemIFk55U8t4SMHncfcsTkeg4MH6htIPgXWqUqZWN9avtMmQe9BXxBioOaQob3lqVFGUTN1C1lTqd/v3RGg5t9+7fYjmaaKxT/eFuMq8IpE2455N2IGGqteElsbDRsLOKdi95i5zlVv3xpxewTdYcGSI0ZF5VoSjjYgfH6i/q2gLo1WPq/jRuoHeupLyDT/KXj1MU2GZHaAh8OUJEt0EF7b1wfFmDdNKId9qC7pY/QnFHkoaAdmvbO9O+Cb/Txxssvn7R/Ob3IL/YyTXcjRTNsebt09sUJ0TW/MtUAd5UlY37pHPAK29k6YWPZ+rfPKOYkLRUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWA4A6M5afkKs7rLk6AQAN9NhD9pfxBfhJkrMZ3TnjQ=;
 b=MT7CyiZNO8LybyA+hhBp+/+KwoRwCdfdxRHEXzaM3BQeb3+bR1X+CvsWLvFYTjaMBR3Sf+M3ty5gMI3CoYfjOkp9oJXd1MJlns2XAVg6ZLVqJBhYKbGQnCfAe32IjkNe9g7dsr9Nnm6jaG5tU/3DOytPJDJW9KMZmel/c2xBDvjuKI9Qf2nzcx5fYj1YqZAMJ1PP0SlGPQMgxppojH9pAQvxUmFasAv4K4OrXGG5YsEPrByy1/f94FxE7r3L/zttBO6Cr8mK6G14ncqYAEn8P2j4KaiRoL9lGsz+yzGJe4gC2VwyR+jnCfdwYtS75TAJlmnxgCrhL+8t/H+CVqOe5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWA4A6M5afkKs7rLk6AQAN9NhD9pfxBfhJkrMZ3TnjQ=;
 b=DVInRCBuScZFeQ2SsoOv7V5avtNYNd4CKWPL1hdAzQawe4LSum4bHxOKCiv/ZYr7DvqOWCbq41wqJPqHt20L2xAGZeZO15SVfEfFcOmbpqHmYAc3ylvK5LyCq3waD4i9nPGKR6HT3xUHinhC5Im4NEfbX3jKvXl4uFRiPjPjkwA=
Received: from CYZPR11CA0004.namprd11.prod.outlook.com (2603:10b6:930:8d::15)
 by PH7PR12MB6466.namprd12.prod.outlook.com (2603:10b6:510:1f6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.17; Wed, 24 Sep
 2025 16:16:46 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:8d:cafe::b9) by CYZPR11CA0004.outlook.office365.com
 (2603:10b6:930:8d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 16:16:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 16:16:46 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 09:16:43 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/5] drm/amd: Drop unnecessary check in
 amdgpu_connector_add_common_modes()
Date: Wed, 24 Sep 2025 11:16:21 -0500
Message-ID: <20250924161624.1975819-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924161624.1975819-1-mario.limonciello@amd.com>
References: <20250924161624.1975819-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|PH7PR12MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: dadf7cc8-feb2-4b87-632b-08ddfb85c23a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2g2VzFWQ3J3eERKVEhqS2ttR3hSb1UxMTBlaURGMHlrb1g0YzRoUEV6VU5S?=
 =?utf-8?B?ZUxMdUFtd1JOZXdERGkybEkwWVJMMFVQSmZQRUQ0NE0wMnZsa3BVYWNJNmdw?=
 =?utf-8?B?Q2IvSDA2NkhZTHlBTVAybFB4eEtUMjVjR09yUEYyT2QvM1RLcnFEZXlZSEVH?=
 =?utf-8?B?bFpObHlUSi9ocGJsdENUOGxBQm5tN1hoUlFoVmVNMUpHd0xTb0thL2VMOHdu?=
 =?utf-8?B?VDVDbjl5MGxISzRzZGVuRnNmK1BYNzFialJOOGxEcEVKdUdyeUppUGNNc3Ez?=
 =?utf-8?B?TTB0WGc0U3prUWhJdnB3d3FsQkdPWDYvRE82L05GVUt5R09ibmg0NlVtdDRC?=
 =?utf-8?B?cjQ1aE12dUJoSXZkdUNva0FITVU2ZTl1VGp6eksySUpXNThuSlp4QVQwaU5H?=
 =?utf-8?B?Y2xoNUI5SWM3S1hjeUx3RjMrUzJ0Q21xQlYwOFpoaGVOTWRmSGt6UlhZc3Vo?=
 =?utf-8?B?NUFJMHZPSnVqWUI4eCtadDRkT0ZtWHhiS212ZHJlWTcyeTVFTzZwcGFPWXpl?=
 =?utf-8?B?ZEcwS1FtODZmWURTY3RFMTdPOFJvSDA1R2pNZ1lYUWpLWXB5ZnpDS2R2ZzlZ?=
 =?utf-8?B?QXpaYmRpRjJjWmFoaGl6TGE5b1pTYlI4aGNLd1hGWXVGT2RSVUtycnFMd0Nq?=
 =?utf-8?B?cUpzTkQzQ3liZjBKYS9mUktxTUJtbDZxMGcwbmdYVVczcnhWZ0Rlb205RVB2?=
 =?utf-8?B?OXNpblFGT3VBbllzeEFQTmkxL2xCSDlvYStLaTQ5Yk14ZnBtdlkxZUNodWtE?=
 =?utf-8?B?V29zajUwMnNqUmhZcm5HYTBmTFJrcEQzMFFNL2RUalRVWHdKUXVGV1c1Wmtj?=
 =?utf-8?B?cmV5cm9KZmp3RHBNZzZJbVk1OUgra2ZuSUozc1poMjM2QUoxWGxHbW9tc05F?=
 =?utf-8?B?TlFNR2VnbTVmQzhJa256WE1Mb0pTN1Iya3BkRjcxRUFFNkwzNTVIS1U1dW1L?=
 =?utf-8?B?Vit2ZHVqdHhucU4wVkFpNjFwVVB2NnphVXF2cGxXTjIxRENGUVZHckU5WmVv?=
 =?utf-8?B?YXBEQTFUczRzTElFUDV0MGNsRGhGcVVPb3JTYWY0WG1lS09GTTR5QS96b2Yz?=
 =?utf-8?B?THNsVmJpVWJTT0gvNWh2L1N0NE52OXpEWUF2Zy9aZEZGbm5ENjlOS1VzdjJ5?=
 =?utf-8?B?R0I5aC9hWjViUWVYbWVyQ2dwVER2d0ovY000alpEOUJwdnVHeVprWXdJLzgv?=
 =?utf-8?B?cVZGbC94QTI1SC9oSkRUd3gvaTFyNEtzRDNsUEF3emRzQklYSEd4cG5JeUlD?=
 =?utf-8?B?akt1N21maDROOXFwVk1wNGE0Q2tIQ1lrSXVrWjBkZ1g3Rzc2OEJkVklwMlZN?=
 =?utf-8?B?cmZnY0RyMTZ5dDlKclNkbTA1WW5zTXV5QWFRb0tYanNGRUVtWXhRREpYVjBv?=
 =?utf-8?B?SjVuUGVNTW5BMTM0K3FrN0M1bHN4SWVTVnk3VHFLOHp4YWxmRjdBTUhuU3Zh?=
 =?utf-8?B?SzFTd2F1Z1dFUitNQTByVnVralBadlZUSE8xYzJQOUxSTGxuWmdxbTczdWw1?=
 =?utf-8?B?RTFZdDZaTWNJK0sydTFPdUR0N1RvZzJkNDNkck5VWis0RUlMbGtTRkFndVli?=
 =?utf-8?B?bTN4RUtMZE5QUFNid3Vhcyt1eW1Vb3RoQ3FoOTVxK0svVnl4a2NaVnluZ2hm?=
 =?utf-8?B?bFRvZjRQaGdRaDhZQ1FEOGRlTlk3RGtzYzlFWElsaDArbmFtem12b3R1c1NT?=
 =?utf-8?B?QktDQzJSRWJJK01wYkdIS1hnNVkyQnJ5UzBkeHNBL0QweHIwSmg5dnNJZmtV?=
 =?utf-8?B?b01kWVVCQnZRLy9RMXNmRVB3bXZscDFRdHNyeitxQ3o5c3JMc1RML3FnNE5q?=
 =?utf-8?B?NFE0a3RCdjU0bjlzRFJvUDVHOUkrZVdSZ3ZEOVp6bXUySXFidS9ScEJqUlNM?=
 =?utf-8?B?SG0rckxGTXhJUXRoTnUvTXJ5ZU81OE9nS0ViWHo2anZPUzhwSVEybi9QTmlE?=
 =?utf-8?B?eVczdlA3YnNpNWFPeFFZempvaHBEYVh3VDFReVFEc0R0WUYyMHU5T28ram9F?=
 =?utf-8?B?NEZCTVlrOXRSYW95L2dZUjdoVEFBbWhlblcrTExuekxreGRwT0dhN3Q1MXk2?=
 =?utf-8?Q?1YDbPB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 16:16:46.3434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dadf7cc8-feb2-4b87-632b-08ddfb85c23a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6466
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

[Why]
amdgpu_connector_add_common_modes() has a check for the width and height
of common modes being too small, but the array of common_modes[] has fixed
values.  The check is dead code.

[How]
Drop unnecessary check.

Cc: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 5e375e9c4f5d..84a8af961531 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -434,8 +434,6 @@ static void amdgpu_connector_add_common_modes(struct drm_encoder *encoder,
 			     common_modes[i].h == native_mode->vdisplay))
 				continue;
 		}
-		if (common_modes[i].w < 320 || common_modes[i].h < 200)
-			continue;
 
 		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
 		if (!mode)
-- 
2.51.0

