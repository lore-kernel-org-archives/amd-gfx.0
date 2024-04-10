Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90BECD11C2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 20:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB0B10E833;
	Wed, 10 Apr 2024 20:05:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LEAMUKdE";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1802D10E833
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 20:05:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLDgdOOHWW93EEUQ1fBjWxEfDKJEyT+b/7D4QAlRpxlnIebDIvjgBsfbOcxGXa98srnLOoy/S1Rk2+LKIxQndtHhfhtVVE80HIF7iChxiBB/t03BHYQklbqk3z7j8LSoZ4dtUKFWqqqzONFt8rL4hfxxr4+dSZjSr61fBuXnaB6pw2ysAEZpndqMlX5g0GaAobYr0OmYTjc1XzliRgEZq3ZJWCaBHgYzwEgGDUr5WwjvwCVoZmyFgBeOr0DoQ1hwGSwfK5/yVRF872O3NdNres7Y9+cyc7B7NG7op+Xb28wvaDl5ewy+Iv1Ub7UoIwI6ZHAouTZE8BRfMwLqh01ulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zs07ntRRANy7F9+1uDH6dQrLGWEzM+qT6jG42Mr3+c=;
 b=mL3qBirvJUxYfKS9HEM2nX0MajTGGWIPW1++L3BiyGuEMW2ZsVnVpEBp4YwZn0kcVludRRf6jDl8MuQgqA3zKXBzAsXnsGSfJQQydLG6kh4v+gZ2ma7AG+X3CnqnzjOiDWWD+DGyQ9zwdlYXlOt8bmn4xzzjpq4nP8Q+fnz/WNhKPdMTcqPpwCxGP1xlHAyZvQTKUxIIXzsnMvg1s5tsWI/nq2AEUHsgE63H+kCjXBkAL3tD6iPTd/QoZZ7Y5cCp+2mt9QJeG8uOftmKofSEi36+dfJT3AvS4m5z4B5VMulksUkCpU60CB4/qXkB+rvaHZ7y8+/rwd6+k+dWUQkBgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zs07ntRRANy7F9+1uDH6dQrLGWEzM+qT6jG42Mr3+c=;
 b=LEAMUKdEY6evwoB8f9k3UsZuM4djmYfio7hnFsUDTjMKucX+YDjqje0OGXvcKXdG2Pj9O4fKZ2J9wVo7BHmXq1RPxBceDcq36QvWfKsnrVclu1MKKqDeBFZKX6OxTOwjnJenzqlPUZ1nRiduM0Le6ipZ87J+KY3/SnNGIXMxE2U=
Received: from SJ0PR05CA0060.namprd05.prod.outlook.com (2603:10b6:a03:33f::35)
 by CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 20:05:20 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::5f) by SJ0PR05CA0060.outlook.office365.com
 (2603:10b6:a03:33f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 20:05:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 20:05:19 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 15:05:19 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH] drm/amdkfd: Fix memory leak in create_process failure
Date: Wed, 10 Apr 2024 16:04:32 -0400
Message-ID: <20240410200432.1578125-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|CY5PR12MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: 433997b6-19ea-4817-e1ea-08dc59998c39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYx+Jft/ZljXQNeAH3wjKbW0PPiB0dqAKgqbTSxZRlJ7fLsr/1Qx0EtChFAd0WNQW3J13rMWtQFTrYzG93njRYn1UwiJGtnUTslIYtPTZDlPrez9y2hdZf/y5ZXWtKCxAUhKY9A9R/QPawiCo7nIU1++MecoObG1UIzaweP94MJ1rQ/T+IMj4Sgyo9NjvuJRlspj/vhTTXDsoQUFGtNq/NiBYLNfyh4UqxIXOGXSiFg4xfteqRbNthjEfV1wZ1+V1FPDF3BhI3X5IsWibF/G+qC+TmtyHSKoJbcPtVFnX/ShgfiH4h0Oc606IC6ekuwBZjhAvyUjuSXLgqURI88akMPtaj2d8d2gU+kUmbXj77Yhd8mVT0kUJfgscQuRMqjBz/C8up0EWy2zUuHsU7jkqoYPcrhjlQFy0HD3hA98/ckjp7e5kFbeAbF/YAe/cJiRgwBnCaQ99KB5CA4B9Mx7ZSytvaJLATIdxXAGVkt3XLWXppfQjm0MW9rfsHvR8p8wWViob8ph2lZEgfD/dfR4UMDgt/uzCY876eHsAjRD2M3cBqFFpDpLOEKgBRrlPV0V1Pa2Al4By5iIteor4rR5Cm5XBDE7Nj7OMTxvBQBbNQ7sSDEriQGzImorKqfCy2Cmzao6nXsr/7+LCza2Aw257/nLcS0BYAfIEZ7zl+vGQJQ95FVAAF4fGVqTgwz51SkuJ60FKhObaApCF1zWwwWjb01l6H8E1staajSqyVg1WwgenZKaZ+tGdBFO0FCU7rfL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 20:05:19.6146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 433997b6-19ea-4817-e1ea-08dc59998c39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105
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

Fix memory leak due to a leaked mmget reference on an error handling
code path that is triggered when attempting to create KFD processes
while a GPU reset is in progress.

Fixes: 0ab2d7532b05 ("drm/amdkfd: prepare per-process debug enable and disable")
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 717a60d7a4ea..b79986412cd8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -819,9 +819,9 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 	mutex_lock(&kfd_processes_mutex);
 
 	if (kfd_is_locked()) {
-		mutex_unlock(&kfd_processes_mutex);
 		pr_debug("KFD is locked! Cannot create process");
-		return ERR_PTR(-EINVAL);
+		process = ERR_PTR(-EINVAL);
+		goto out;
 	}
 
 	/* A prior open of /dev/kfd could have already created the process. */
-- 
2.34.1

