Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45708CAC5B5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Sep 2025 08:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E189E10E3B3;
	Mon, 29 Sep 2025 08:10:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p6GADt9x";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E780E10E3B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Sep 2025 08:10:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x45AqWqlYovLFGE2ixE8YUlcT678U2hiVwnTRq/mquI8cmgpgT8edG9yShviRqvcR/dO4uxJxJ6qUTBgUYYYEzkNbYtCSO8LFlrt4iaXL8Ty7Ou1Kr4AZlYerKqNwyT4/5zOGUekYOuzmskG3I4SmwYjmOHDMvnZtxNHZgbJMOUW8gD6imy5vyiIhYteSOgUsCvkhGX8R4Q6A/S6kdKpLmYCkC3x5F8lYSBe8xKOCG1hilQbTtee4ykIVQHkX+6vTJgPkDpq5kYHcGcQ/JJ1tgZI9iZ84g96K9pLECgMdw8IeHkvSl6uwnnnGDNArQV/N0XAhe1PokJ3WxzhqcfSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7J0p6OHS/y55kM31gisqYw8vyzH02t4ANqfnqPqMRU=;
 b=oo2F4uZY3JsvwERy334a0/fLfzjELMCO5Y7eyx00V4avI/NVovcEZRI4Ro9wH2fOlDt1CmqozD71yNznbSHNEN+pgxMo9jSPX15z5mRQLSXoSiGc3Kw5V4SSDVk1VWf54jcWu8dRs4kzM68gEwfDorpj0Pk7kWkr2Rq/NAnwDfa90IMNtORuYBJP+becJhHIkn/FB10cr/I7tbl0D2kVBHtebHyf4XqQ0h7xwvkd0mP37nqzO8GfCX6Ve+kRP8uWNUXL17MH1Gh5h8+hgz+5KZXIPpQE88umbGsoiOu0dPetRcOmWMgylPxyM7ifHsXJZbC/3/9wnTg5xWWJJrcuaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7J0p6OHS/y55kM31gisqYw8vyzH02t4ANqfnqPqMRU=;
 b=p6GADt9xAm81FoSOuYIt5X5/osznR2WHWcKxnxs7QSAV7WzW0hwA1roPO8lxJFvYp2p0kRcoNG4qNMxYiV7T3lf0nz8126edquzBL6AfheHN8w98wQa5+AaVRrFluY+xfIc/1Ctg+GQO2+eQbV/9qE4wHtmV62rCfEQI08i5Rus=
Received: from SJ0PR13CA0177.namprd13.prod.outlook.com (2603:10b6:a03:2c7::32)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 08:10:05 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::b1) by SJ0PR13CA0177.outlook.office365.com
 (2603:10b6:a03:2c7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.10 via Frontend Transport; Mon,
 29 Sep 2025 08:10:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 08:10:04 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 01:10:00 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v5 4/8] drm/amdgpu: keeping waiting userq fence infinitely
Date: Mon, 29 Sep 2025 16:09:40 +0800
Message-ID: <20250929080944.2892809-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929080944.2892809-1-Prike.Liang@amd.com>
References: <20250929080944.2892809-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: bd5f12e6-cc91-44da-f4b0-08ddff2f98a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NiA74zuXzFY3CsTSckqjEvNscEl5++96e/kL32uIjb1saaPusOK3pRxb8UIW?=
 =?us-ascii?Q?8+W3fRTypqA2zNPjSpCJo4hTvQ5dKec/nmgdqoIAUGxCra8Yvx+ylC3D+VNu?=
 =?us-ascii?Q?3Rveh8/uS9vK1rXjKWrHe1L9EPaaodLSw/n4RU55rqz9EF6LJC1joKvgB3la?=
 =?us-ascii?Q?Pz3z/ctQOBz8ZwoaLmif2MOk3zrRBOI9OKaTu36RH2R2UZdwCKc7G5TYc6o8?=
 =?us-ascii?Q?QpRQKksg/ZB2dV473Ju4Mmsk1vsRixmWh9hGJyeobqMtD0Ck5EOuRiTlGUD5?=
 =?us-ascii?Q?6OvTXBtrSlBQ6Fsoy3WRufZn6ZRQ82qeLuUMqNXihRp0mah+awdSjQOu1InE?=
 =?us-ascii?Q?UaAvAecD8F5SgPgV8VnqTfiMVbv1/5oQAur1Yaj9TdKrm270ByF8muMA+6K5?=
 =?us-ascii?Q?xMtN3LP2lzvTLu+mjSJStqSv4Bczi+SmJIt0LD744u895CyG4yJDZrHD7sZx?=
 =?us-ascii?Q?1ZMyyfXeeHUfdJ6XJPpBLZv6jVprtIz0jcPPWMcnq0hHZYXX/YTgSoAR7T3p?=
 =?us-ascii?Q?+Nw4kD9qZ2sRMheNqxED0jOdp2onQsQVYljeskOiXKFkhWHKrD/2KcWUQKpo?=
 =?us-ascii?Q?vWRUk7339QZdf0+rsHZxfrz/vzsgvxa7UXNMTZnuu2Q4152YC3ErpOt1KGR6?=
 =?us-ascii?Q?jI1erIYC2kVUTfJ+Av6wj9GiNo4bFyZ8zczPnauAgil1iIgJqSzLS7uiUOh8?=
 =?us-ascii?Q?HvC9//8jNlmmLiE8BztUwYKde7yTLSirL0HepMGeqYs1rN0dTUtZwLGLDjeQ?=
 =?us-ascii?Q?NPtSUlV4P6MdVpEzxz7NxDyB6il+Uy71/6/TK/AKFcoblt83QH1p+JXNBFWL?=
 =?us-ascii?Q?FJ6h7vCDvGAb/8b+hkwzwrLQrVYH/eGEzG1EFFCTM2K0QVcHm9SikYAeDg7C?=
 =?us-ascii?Q?xLLbRvmrUW0MxkRjPp0ojr5IvLQxer7uJxKFROjuBDJRH8f31rh1R99fFfM9?=
 =?us-ascii?Q?jZOH2dVwEvO+3BV/+RcgIAeHUvIHszCdXuhFE1DtDP1iBaviY5X39ClacCQf?=
 =?us-ascii?Q?mo31sZcgEHZ9h/o11quuYBBdjap8oca4deLAIbE2dOFui4leNG375g7QBuzC?=
 =?us-ascii?Q?VdwJw2oy0xLI23tA+QKthiZ50ZDrWmxx6e8H9mvqSCCeuizWOBuIE5FoYN2j?=
 =?us-ascii?Q?MocoEAVhI5mmV+GIQGqvPXf/6KxQxxevzI/Npf5ZaiiVuNigGWbMSaVklZH/?=
 =?us-ascii?Q?qi3R549Aht+QFlz+f1Z7gTIMBJAp+6VlUVYNUDGnKw5vxaOgSbcqfzY4dCwu?=
 =?us-ascii?Q?cFGNlGJk2dwSYCAW5DmyloUMV7GUwm+MYj5EVwcEk+2HDPFezXKF/IGXilkF?=
 =?us-ascii?Q?iMCP18q1YzeEwGAaxM+9HQLjAhD7fPqHzROMLvqvSKvInNB4eg3XY745MJJP?=
 =?us-ascii?Q?pWSwmZSQycjzoPsPjbrrh1FWYiT9mAJw++41Edyj2eYI74jEu4evMSCvMx//?=
 =?us-ascii?Q?b3QFCLA+gH2xa8sDwz08iFuQUal8ZdvhurlU76o9Ax/1tOOZkTOZdgWEXake?=
 =?us-ascii?Q?q8hotNrpHlgYGaMv1y2Hz6Ql5SqEamkx57ROmZp54LvvmoVbmdqeXj5QYlrS?=
 =?us-ascii?Q?yTAZtyjjCJm/QFXrX2A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 08:10:04.4496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5f12e6-cc91-44da-f4b0-08ddff2f98a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360
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

Keeping waiting the userq fence infinitely until
hang detection, and then suspend the hang queue and
set the fence error.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a82b8d30228d..93d92b6ea86c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -232,7 +232,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static void
+static int
 amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_usermode_queue *queue)
 {
@@ -240,11 +240,16 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 	int ret;
 
 	if (f && !dma_fence_is_signaled(f)) {
-		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
-		if (ret <= 0)
+		ret = dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIMEOUT);
+		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			return -ETIME;
+		}
 	}
+
+	return ret;
 }
 
 static void
-- 
2.34.1

