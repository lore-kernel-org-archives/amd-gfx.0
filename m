Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DB9C43381
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1A764ED6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1A764ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCB216EB7B;
	Wed, 24 Feb 2021 22:21:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B732D6EB65
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXULblVMoume3cY9/Wh/nUAmHZNJZcJX0Pcb8X+UhFwYcMcLvpgUE6pgTA2EQOh4cwT03g1M+q3+CC3Pj31dQAgQXj9X0SGrRoLsM3zd/zFuXjqOiYIjsobe5RAroQCbVLGbFpfFapg5nFRMVU8I4cmDErxNSKmTWphbNiy8jsvLmB1Xl04BkYYSp8s3duC+JMJ/zOQX2jOUtfpzycr3qAy3/M1Tin3rlU0p9PTujHbgY/CU4bgVgphoClhTJHQX1ePkWQTrlIuKUXvThOOHAz9pPrKliEfY0LwW2tqK7Q7kyP5XucM7S6NFawxeFkdDS7CIF+Az6t6O9nlTV8YKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2atJl53sZXCerMRYVQTEA7VP/0xY8WIK1e2iRsbv1iM=;
 b=GfxJ9Zps7Lj3QvP6BNNXDnMXS7dPkZ2Lc5t/wPS6YHLD3mYhWaE8d9xYwAmdV+MThrxOE/RA9s5spWIVKhTHaKRitw2z42XHoCwtxfy7CMHtNE8ax71G0hDboA1yxqYxUXK0jGAYG47N9iD0YPWr6Xa2CWUBHBVln9RNskOswrpfpHYc/5vF6Q5AE8xnRuZuOyCXVtbrdTnUoKYHrE+5YHJLOR1iIBOeiH+Y8ldnlJ9rVA1F5YoRmbUO+QA4X1/ZtNbE9TjtDgOrB1PLGzWU/hQoyRY0tMSlnW7gmnrf4yqKBYGsVJ7t3OJ/Mt082eyqLq7qqAHda1FZahXESsBKwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2atJl53sZXCerMRYVQTEA7VP/0xY8WIK1e2iRsbv1iM=;
 b=3RzzSZmR2yXB/EgUH0Wwr3gNzRXRaacv0+GWhkIYOBIRMVkLGiZteoCaFjESal1A0nDfHtobIw0apuW27nVgD2kModpJF4sfZD7R1CCsqkTzQWn/Gh+pwUjCsxyqWgALuuQqyN56Fbhh90n7jUm6JZkkfe4QjBGl5gPmrgM07/0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 22:21:43 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:43 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 102/159] drm/amdgpu: Add support for cached VRAM in A+A
Date: Wed, 24 Feb 2021 17:18:02 -0500
Message-Id: <20210224221859.3068810-95-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0a93ff38-9e40-4bcb-db65-08d8d9126729
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB479876CC751FD8EC22E7EDE6F79F9@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:222;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 04CFoVk7JCfeFQunJMizc1iAvx41OhvDiha4s9zRxKfTbsY1FgAaCep460sJdZrr0r2xV/kCYHlpf8LNwbIh+ikJAsp7RkIbCnHI+7T40bM7rEH0uhcfDyS6gjYTDSujIkSjnPNfb3YYxcdky1p0R5o/fjVOo7jVpzverEt5GlXzk2I3fP1I9fCm7GzfzwctA+nHlPjR4O4rs0POzq0C+HA4fi/nAMwNKj9xQHBNHS8K+w/Aah5YBOOIMEWY8GCGRjWTUf/FJcoOTK72/kv10ro0WTeeoCaz0j0QDhlo8AYyyHA9njU/1XFNqUofrkG3zvUKv66k0SXG0P427fc4g7qVqf5LGuFTu5AdsaY409v+yXvLbpM4hvUjhv89O2JP+2ec0odFRXjP8EhvhFsz6U38rgr9uEgdTFwfhlDWcGpA7DmaLr6Xtj8yC44EHJLreGUa3cMkFV+qabpmD77wpZvTT0T1wKaRgWaCzBJW9FxaSbR3TTUQ6vY39M/0fpKjFnILYh7LV04LrH1nAkVOVRrLJj1QbiNaDCn6A9zEzKcu/ADf+2gIZpIyonHa3VKmXcsnjewc2NrITfrpkLag3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(1076003)(83380400001)(8676002)(8936002)(186003)(16526019)(6486002)(69590400012)(66476007)(66946007)(6506007)(2906002)(54906003)(86362001)(316002)(6916009)(66556008)(6512007)(26005)(2616005)(6666004)(956004)(4326008)(36756003)(52116002)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8Gc3dkjqdcG12IUVnk1eAYkOE9mcbGBRCs6ytSJAl0pb9W+TeY/Xg+qh/tIg?=
 =?us-ascii?Q?bGSAxmExFn/2FsB7s36kRKO+dn2DSG/1szzY/1ZXGMRprbd0BwAV5y5P418U?=
 =?us-ascii?Q?k96SH4cyIC4LLMi94WLqgunrLZWFDcywGK1rQz2/B26uf29yHVeW1JdLVKUZ?=
 =?us-ascii?Q?WGdBz449DvwZlIkheRUD45BHEablfhkxDX/DeUdg3ugoImresJxx7WLaS1WE?=
 =?us-ascii?Q?MAcWrTllQb0KCiogFAK4x8jnMW2Pr+NeMJX9unDUWMuwJ7eNm2vWVGZqm2LW?=
 =?us-ascii?Q?Dq3b7X5mp/4oLEjgnlirFmUJ4XOQMakmVSqxQjRw366kfu01+m/gW0rrJ1EE?=
 =?us-ascii?Q?GoY0uOAjBBTZKtXJpHS2fYELgciHpgVMkSTMn/RdstDMQ7+y1Ib4n4897jgy?=
 =?us-ascii?Q?uogfMJQmykTSnnI6dvG8Fm5EsE/8QyoFADrDG16DikNwqu3CHOFrfZwf+ouE?=
 =?us-ascii?Q?opHCP1hYPhQlsmFikhU0kgCpL/CIVASHdKNXbz+/BN0FtYv/7FbXnF5LpEn4?=
 =?us-ascii?Q?8orPF74t5cDQj/DaqU5Z82sBDvPCa0fKFr74t2aoQRjyv38xkLy5Dapp5CL3?=
 =?us-ascii?Q?G8zOnNMfeocE4FKF/mee9XdKSyqBkEsr/sHz7De7CwbqGPb9Kpy/xMPdlfT7?=
 =?us-ascii?Q?R+iaEWZF2eaE3CeOwvoCEx4811hkBD6XO4ByXm+G8jQE5jYBzbn0TJZQBiR5?=
 =?us-ascii?Q?Jm75rJrtwlapNSIg2p8BzHbZkBNKtrbIt5gxcgDYjuwuoLzB+oarcmhWrZgJ?=
 =?us-ascii?Q?3FWQaFf4kwDbzFj+9s5YHiPyK3AL3HGHCFkQB36YI4VImS4l4jmOz3zw9Hjg?=
 =?us-ascii?Q?Md82X8CyP0bHOmj+w6mI1JfJoFiAiqhTjXwhg9HXvAIsleFq/r5gMqkMwctO?=
 =?us-ascii?Q?d4IEAvacNErxawd/qBSKGdd+6JkF3yC10fBa/ohbl4ZJiPSv91rhJU0g4DN8?=
 =?us-ascii?Q?tH+mtk7RpaJq73oqa61hNG8TQqL9P2awTOae9+/YJtZQUG+f0jp4FlhJYLvp?=
 =?us-ascii?Q?6sSWJhQm9yypVpPGgIiRuyvJbk8tsOr7GXLQVDZu5R/0Fy+kblSuPYaMd1sj?=
 =?us-ascii?Q?lmTtUzn4AV2LR3+wBEUUhimA+QGW5oxOobyAmBAg4sjtIU05It9tH0AQXRox?=
 =?us-ascii?Q?8e2C1cedd26w8eRu8mnLdE8riYX3C8tOhdUBcpCtXhX7clKj6Ssw2TzAIjLI?=
 =?us-ascii?Q?X4tDQaEpIvkOcnXiDBjleZ/8r5VMUfSp6R/5btWgGzVsawiSgZXGTbo9N57Y?=
 =?us-ascii?Q?w35JS8QZtEYSTn9VeWvs9si51Ea5eNIhnUM45/dZgJYKQkqzZlJ+iQIlwveK?=
 =?us-ascii?Q?7MViskkN+zlIo8QbasdU1/3N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a93ff38-9e40-4bcb-db65-08d8d9126729
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:33.8301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAEX8eZW43oyU+FdzY7h9IotjzR6xT0QTEgQCbFvdV7POSrpGcyAJemnwGmh9PT+KCJMNM1YXOcELBA0VP/Bzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
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
Cc: Eric Huang <jinhuieric.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

This change was lost in last merge. The upstream commit 672242be560
removed init_mem_type

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Reviewed-by:  Eric Huang <jinhuieric.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index b325b067926b..d6bc08fb5b42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -181,8 +181,13 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 	struct ttm_resource_manager *man = &mgr->manager;
 	int ret;
 
-	man->available_caching = TTM_PL_FLAG_UNCACHED | TTM_PL_FLAG_WC;
-	man->default_caching = TTM_PL_FLAG_WC;
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		man->available_caching = TTM_PL_FLAG_CACHED;
+		man->default_caching = TTM_PL_FLAG_CACHED;
+	} else {
+		man->available_caching = TTM_PL_FLAG_UNCACHED | TTM_PL_FLAG_WC;
+		man->default_caching = TTM_PL_FLAG_WC;
+	}
 
 	ttm_resource_manager_init(man, adev->gmc.real_vram_size >> PAGE_SHIFT);
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
