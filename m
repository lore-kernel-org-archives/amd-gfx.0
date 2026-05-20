Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36574CD4F3C
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 08:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C370E10EF7E;
	Wed, 20 May 2026 08:35:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EmW4HBHS";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010063.outbound.protection.outlook.com
 [52.101.193.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8560E10EF7E
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 08:35:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwnBoZdZeAc0JFyZosh/ZBCcS4bdSDjV1pIT0ONH0R6wsDP3jPP5gS6R+7LYE/tb5xzw6+faSMltrW7rdOOOFb6HPFdvUgDJh70uGHyp3Dh/kvksde9GG9Yy+mHNp8Cz8BQitKSIe4yUDFMbXF4ElmeKybxPyxRWAn7UksU+s5o5FrOwSGKYmZNSqgX4HgwBeWcbK5/1ycxWAENMPoB4Dj0FC8CGbnq97fQTrvokefTAuEtRLaHNJYjez7kQXsPQA0SdwzmgYOznChG/eqLp5Xpp/ameOd15D6MaChOmTbfGBMfHnvkW+k3dfl82ypRo+19BNZuDzOMnjgkVBMLpBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAuGvz1PWK73PaZWdRfLhz/9ZtgDck6nQYJOce7RThU=;
 b=jVV12rYH+03ad2PcSd2tvjKDmyZjndh2Hzd2pc1JRZqNxaFtp9tdClFYnUKZZAUY/RSc4tOo9j4XEpdEA5zbRvLLEOQNSD9LJb1giydtnvLGeqgqWAji7wkcu3hOHbVgwN2NyblAf7Auihg/MjVyUv9YRJvjJ74QKPvN9sd9VkJQuCe/X6aFGcYE5hpmzE5l7+jp1q1lyl6LKx7RHx5DcBiOf5Ma8EkY6cRrkRzPcp8eBMeap03zngXZpqaG6u+i7enNx5I8TklXC9TAGicFNJ1gKhqq6IgugKLp6x/o6P6HhI0MTgc4QJtDzgdR8R3DeZZBNgYZyuHpp1oEWZiHSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAuGvz1PWK73PaZWdRfLhz/9ZtgDck6nQYJOce7RThU=;
 b=EmW4HBHSNmW4poZQIfmJRoJarS5EgVZ1nmHMi1KzNswbpt5a6n+WUJu/FnSoTrv5A/yTtrF6CUXO8pq/YuVqfvJtcej3KPl7lznm23U5mu3Dlb/y2l+G3HE5WWn5qp6HGVTSD2Ttp6rTbEq0AvHn7Fy7Ai9JwnQhneT1VLF+SXM=
Received: from PH5P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::15)
 by CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 08:35:36 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:510:34a:cafe::37) by PH5P220CA0005.outlook.office365.com
 (2603:10b6:510:34a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 08:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 08:35:35 +0000
Received: from codemachine.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 03:35:34 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: fix the ww_mutex and GEM reference leaks
Date: Wed, 20 May 2026 16:34:49 +0800
Message-ID: <20260520083518.191863-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 750f56b3-6e5a-464d-996f-08deb64ac350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: ynhvj8vXviwh6qTGUwrhHfBepC9deb8aISTAnaeW8Ga0iS5kZztRo6n6gk66UFcNixbpRkpTMGqOpeWwikaUUBDaH1eOEdzfuZSkdjij1ky6ollwcbN/a2C0L2RPLwELCsrK3KkQJO1rjcG5cCtRPxzgrlz49/Z+i5ZD5cwh92Na05RYAz+tEYSUF2kMmXuL+Lo/c2zA8BjxyjsgK8fHvUlWmuAnhvQqRS44I9hADph5DBksleqQJ7q7Vw6btujqfbTP5WSaaUShvuYGPxq6H6gDnsXZCT6gVpl0Tl3RbOSQn6T/mAlVFbWB77nv9ysAKYlXy8dixGqIxFkIGm7udRDDJeurrWtF5tI3XQxh0tkAsF2DK/bQoiYa67IMMMutER54ofmFfjfa7N8xw6cxJR5Mqa9sFhm9cMS4Q9yGm22EXFQOVJCErme9wUcP8aoD2bqwL103b9X2QByRBMjzTanZPdztwCoqanh1WmgP7q5eX7tEkRsEWJkUKj5uneSvNqLia1uaFqyZo7rP08HAnvqlfQdhOnwQF4k5xWiMGsfOKccAKCyG/gHs2ahu5gBfUGg5YPUIuIl+d5PeC39U6/YrzwJsiWzysRWNIakPUM2Ocrvqt/U6WnaAHPgI+R+o9XFLLNmHk7tL2AQvhO7vAQQo/EmcSK4Kwl/LeKXLAVg9Usr2ow/9kzjDW/rsSdfD0M8ytxBz4Ab75QS0t/XeYqh6FKJYXzP6dBS6+Zcpe2s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p1PwNc0rD608JDIWKO2gmrg1f7lRdxar+LEy6B6i/8NmwIaspjBriEdmDnRSsm0YFtVdh/7n/lTGt2Ds7UMzJBZcbFg4zen0jIEDdwX+C46E6ehEa9JtYji04n1LCBhtTIfkf4b/v+aO+qdYnLNMgYrZZ5LbLXxTUofgqSI0WJyQ94WEks43hmURk6OwBOe3c8bxgnKCsn8PzIu7kAieKJUO7zDY7X7mh9Z/UtwaJ9wc5GAfbklrujNfKYTaK8rvTJ47huwUi0kfpFGVo7E/1zIgtKYoUFlvmU4eejO4/+YJ9YFsAXaj7Jw5UIIr7IcEVxN26r6ExCbgJU5rinVdEC6B04hqNDVEEoRZmchprCcf6nKaL7Oadzeb7Zx3nEir1F9jDQO/5VuL6qVhAbj0Dn2e4dEFJf21Z+ic5GTtZnnKAn/ji5/WfJuzbZA2OS4C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:35:35.3206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 750f56b3-6e5a-464d-996f-08deb64ac350
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909
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

In case of kvcalloc failure, ww_mutex should be released
and BO's GEM reference should be dropped as well.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index a93c64732bf4..b5fa4b0affc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1261,8 +1261,10 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 		 * be retried.
 		 */
 		vm_entries = kvcalloc(args->num_entries, sizeof(*vm_entries), GFP_KERNEL);
-		if (!vm_entries)
-			return -ENOMEM;
+		if (!vm_entries) {
+			r = -ENOMEM;
+			goto out_exec;
+		}
 
 		amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
 			if (num_mappings < args->num_entries) {
-- 
2.43.0

