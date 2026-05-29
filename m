Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811C4CD4F54
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 15:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2A2511218B;
	Fri, 29 May 2026 15:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lQSXHqhG";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38EF411218B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 15:55:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/+PfRlpzz4UkUJ5sCrPApmcA1v/FkBMRtkdhSrQscv+877uklb/Z5Ime3xC/3r59XQhwhKmH4tjn2nqYQLfo6X7SptlhwgsudvoAoj/YNKQBCo58dtL2JgoBQnA+w1urRXKKiWMsgen6I6UKYQ7VNW2v2vC/0mHUhkS3zjWq5I3YxtX63WLaPFwiWv7yyNr1dE+IrjXNbyvRlZSXszFWO68FomAd5tPZz7THVjuBnoIkK9dVVShyS1I+i2Pvf2VbOxmYVUJQ+7D8OA4e3+wGhQuRlc5UksDYQFrUO8fwRT3XrMSgvLJLPv5s6zxH3Ps1xcAMcXzD+vAlner9YEmlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xmF1NZvlGwg6anEmmM4Q//IpFR1xvsjcsD5oVhr718=;
 b=JJVRNeagvLfqOmQs8XRACRz+ZCZBsTRVOj4cydaJf2y9RB9L6nJr9euhUquM0cz3QqbkH3YJv36Pw6y3nMspdSKrHSYwKXVMl5itNAKayRo6NlzzNRTL5xKGDBZdqSdxhXHgwIRUyNnu5CuAdGNm5npY7Aa4rkuXKBzqDfrq7hgMZyt2E08UTA1V/uS8sNM8OEAgehhUNDZyI+GssvaoyX03tuhy9zVqpBsl+Y5xmTxmaIzwUN7e0gp7rjUNhAw9ExHfAtDtHfUEh1madSpuCglOZ6ldJO7JC2eRswSCuShuXVXVDM4Y6I/RdMq/y4Zihf1zng9VKbKPcWUIRHxeTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xmF1NZvlGwg6anEmmM4Q//IpFR1xvsjcsD5oVhr718=;
 b=lQSXHqhGZ916r3/dNcCsgFJrtUgdkC6BpcjFTzXWnNh+npF+ToWIx65sfGpzyIaF29ZY1YgEtZy04BKe/DKEDs1fJf/0oPqZo/TSnBekP6xjhZeaxhqFTqjd39C6IUSfQIjKro2jVC3od+K6IxDqWy4h0DBfgdBCsXuVF2ZLXi4=
Received: from SJ0PR05CA0115.namprd05.prod.outlook.com (2603:10b6:a03:334::30)
 by DS0PR12MB9348.namprd12.prod.outlook.com (2603:10b6:8:1a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 15:55:01 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:334:cafe::77) by SJ0PR05CA0115.outlook.office365.com
 (2603:10b6:a03:334::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.3 via Frontend Transport; Fri, 29
 May 2026 15:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 15:55:00 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 10:54:57 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH v2] drm/amd/pm: Stop pp_od_clk_voltage emit at PAGE_SIZE
Date: Fri, 29 May 2026 23:54:25 +0800
Message-ID: <20260529155425.418803-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|DS0PR12MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: 41760438-bc94-484e-b00a-08debd9aa404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099006|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: eLa7QwwRLdmx3AIcLTgWpt1SFvxjMRTAIwrbJxUa+h7nDTfspb9fCxeEWA9IyFTxOx+JqzBCDMT1tNSeRQVff8chCCO2AWMqbCYH+hfzS0IWFt+c2p1xy0X60cAHB0XoBog8u2pZytDUk3CJ2iqvrrIwi9OSB/LvKv99Y4eundUFZVnYlv/Pf2UHX+S/24VVpf6guYwg/nLqyviIyPFPffLkQoDmh62crYjmx18OrYnxmdEp4+9yT2Pcet0JX67RNBqTRLEGG9oTJ2uLNnvPGFDiEEG/eXiqVctokpRebYiGA3OeWLyMEwShfQyIqY/ueAsMYTPtwp1nhaJLd2JrFiSc1i+RdMvms7iRAI/yQ/m+SjRwUZrB6U9WhLI/SNpOBrdMYnmGC7C+U5RlFsJeXJzs7EVPuqvqJ5wgl0waX4icgwxIXvphX4Y0Fo12gQslfM3anoD6gPmeO4lM9zk1NP/Wa+oNSq2+b2zoJ2PfsKNF7B6vd6jsDjJvJuPOIOWpsYBcqhewtpQ4tk/TJ04bZHrPkeThHX5KDEkYWXazUsiyj/64n5MFPwddzxpe6kQ79wNIN3OpU1gXFLeU8vQ5SvVRg0eHdQiHtkuYgCy7qpwAl5yHQPmH94BL5OsF6Nwd8MHB6FBUbV9pbChsIJAQm2pf2KhE9Q44VsSLI2JgtF2c5bQWyeFAW87q8uDwsv4Zyn4nINWQGZUG8WmUfbcvNkXwaTJEusvRNS15qn4laSw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: thnJcZaFt2rJN0VStEoejVOHXUGEBQHeXKdgKYVKbtve7mUMKyPe6KAi+cCtTG7j2M7VpfnwW6neFr7Ud+Tr+knT61+pexniKUSe4o8EFlXeQ5zASOwMC7HKPbBsXClx9OAXChuKhCekBYRAOkmpS7R6lpDv8XEFVQjJwkzZSCLVNveC+HROBZEvHg33tiJ7yv3+TGu+Ny2RWzeDG0qf2TiGQKR4iRhamKk03baZCaAzUj4xpI2t/n34TR2dzmdx/m8VIFvfF5Cmi97qhHIgjOYKfZb8zbLT83pozgTVP6sxTY8Jy9MyMPpA3lFrs4s4op9sO8ZXgj1A7mXmpYp8ER8Kn9f7uhXRhw643YRugUMD7xV6qWS7Q/f2xcy7KrL2xeWxxbFNa0Esw0/vztnZnI7/QS904oZbY4/1QteglPs0RkSL5ZpyW98FeN27oLQS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 15:55:00.6300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41760438-bc94-484e-b00a-08debd9aa404
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9348
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

Stop appending OD sections in amdgpu_get_pp_od_clk_voltage()
once the sysfs page is full, instead of checking every
sysfs_emit_at() in SMU helpers

v2: Drop the prior series that checked sysfs_emit_at() return
values in every SMU *_emit_clk_levels() helper and smu_cmn_print_*().
(Kevin)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 60db9b66d08c..03c95621fe2c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -866,11 +866,15 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	if (ret)
 		return ret;
 
-	for (clk_index = 0 ; clk_index < ARRAY_SIZE(od_clocks) ; clk_index++) {
+	for (clk_index = 0; clk_index < ARRAY_SIZE(od_clocks); clk_index++) {
+		if (size >= PAGE_SIZE)
+			break;
 		amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
 	}
 
-	if (size == 0)
+	if (size >= PAGE_SIZE)
+		size = PAGE_SIZE;
+	else if (size == 0)
 		size = sysfs_emit(buf, "\n");
 
 	amdgpu_pm_put_access(adev);
@@ -3915,12 +3919,17 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
 	if (ret)
 		return ret;
 
+	if (size >= PAGE_SIZE)
+		goto out_pm_put;
+
 	ret = amdgpu_dpm_emit_clock_levels(adev, od_type, buf, &size);
 	if (ret) {
 		size = ret;
 		goto out_pm_put;
 	}
-	if (size == 0)
+	if (size >= PAGE_SIZE)
+		size = PAGE_SIZE;
+	else if (size == 0)
 		size = sysfs_emit(buf, "\n");
 
 out_pm_put:
-- 
2.46.0

