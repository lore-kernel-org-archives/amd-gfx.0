Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D7DCD5BD5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 07:10:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63CE610ECDB;
	Thu, 28 May 2026 07:10:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dg/zdbBN";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013029.outbound.protection.outlook.com
 [40.107.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 632FA10ECDB
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 07:10:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyiXZMg2bAyqTln0OPD2IontVHvhfzUHLci5vNng7Bmvnh5jYkRV6TjsIKxY8wuvSHI4XlPkxSj431AN0Q8ZXSJnNYK5Lp3NT+EPm4XYlqRYHMZoO+DgAV7B3+yRMrV8C5poJM4moX9SVyG2IapsG+wZJUwMPnfh2EprpVrdbc2Wcu/3yZIaZH5/cOmorEOWAgIo0Fu88ZPqDkIBe58GDLDm89ZJr6DhIdeHSar3+g1dvktRQ8L9lvPkmEslKfXnNiPOTNee6FAUHwG0lxB8m7/ToawtFvzV5d45D02iB2tWXASCjaaP6CfDrDs9Rka2DAtA1MhwIFc4DBZUWZLQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKHb0BVilqFeUjJXVsFbuWYrN3+ThcF7JPhYAPlY2UY=;
 b=DdMWvhHMqjt9rSMHGaj2bJKdzN5j8OJHA+KPp4h98NEkz72+Fw/TRiuOfocTGTu/Ql3Z6KHOEM6qJs59ddwP5ZUlR4+Xfta5ovE5Ufy9gN/NxxtXi6BfAAAIiowX+XNyuEhKVR1TUlxVUdqoY//5AAZqhfTTZxZTACg23TiWY46zPwYi7msQiyRsN0DyxEXU/aAE1UVLU2yXr06Sr2hgSpOXAF2QO184qGVpiFtluc+JbS3lYEDwfQ3QG8hgze5vpXLk9A/fQPokBNOz9KIteRNazGMjmlHYuOgDMv9rUqpIOgti/P4xwYfsAaS2mGWcn2u3GcE4hDO7Ez9eXkpCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKHb0BVilqFeUjJXVsFbuWYrN3+ThcF7JPhYAPlY2UY=;
 b=Dg/zdbBN5lLtOdRULJmzRHSppf5Gqu34mwqFZT2b/diMhznq53uOQE6NUP680/7NVI9YcdUfiyfURAYAhxNNpz3zUENvH5KProbs2setxru6zdsQQe+wKAcojJBr4EVJHGYJCBYrrZB+4SrCYihHqFqW9VZhQ/9CYGVT9SCtE6k=
Received: from BY3PR04CA0017.namprd04.prod.outlook.com (2603:10b6:a03:217::22)
 by LV3PR12MB9439.namprd12.prod.outlook.com (2603:10b6:408:20e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 07:10:13 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::3) by BY3PR04CA0017.outlook.office365.com
 (2603:10b6:a03:217::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 07:10:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 07:10:12 +0000
Received: from codemachine.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 02:10:11 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: block the register writing if security lockdown
Date: Thu, 28 May 2026 15:09:49 +0800
Message-ID: <20260528070957.1081827-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|LV3PR12MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: a07c68bc-75fa-4c5d-3237-08debc882917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 0GORTrGw7aQVTfjtN0zmpVr1swPD4CQYZHvRgUbuWY3fJBdYUkmO48A5au7oMJlgnC8u6XFuUeacs3wsKGvGCQng2E+UukNhnEj4JIc/q/RD5zaqngiVfGHzCYm90WJ88/vdG4R2bTrT0+AsN5hCuLGupxgl+59/4goF+DkICO3uNDJ2sP5kFbf06GOxX4Gvi7Xy7FgheT4qaxCtSc85m1IBWDR79jE/cusIF+wE0nmKKWtegbAvU9cI8hFKGuWWIqVLJ71oWadTAuQ/UwzuL+QszZjhIZZLfFDLG5N4ayoNN3Hy9eOZCBmjGHp1QEQX44AsuPqZhOjpQx0gnFhHMdKfrKqfKQoznMozn9tP9AMvQKkAfyP2r+oFcYhtG88HkbZ0zzcpq298n6K2sqILNpyRaj07LahSL4y3puefY436zgfTRk40s6c/LiJZoYBbKOZNafMtozpLAPnFpn8Ex+9q36RVVERLbFlLzq/TGwry9QtHAf7hCwqDeWE5oKsf9MujJVh1eSedIM75XA0pIEBzAF4r7N4yXQaOFMwcz619ZO66/bAW3QEFCxoH3ivyP300PIi535GBEYw+GEAAnUvhR9PvZvQtbVEXngEEFbtaUbQeHzBH3HBaRC4U5K7igtTkQrbg68V+O7lBNHv9/ocRJ1Q9k4ThSQVf9Zauc4leXpzUUItul86e5UZl1IgYIWgCMAXXeWlPohhBldq0TaDjymyMBcByHHqh8BAIDnE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X/Oj4/5ViZyY3cE7LHlro6hvRTTQTu8GKwCXxKN+tVSMl4vWKgvqOm81dezZxH1bdm4n5kOqBdZSVzHqRGXPREyLwx8riY2LRNjYK1np3HGVhu8a0i4GPTl2MvZ0ihrwIgoEuWUspgi1SR5w/G+vBcx3XN1JJvqLtWiLsvydupkxllEvt1ksaviIiRYydpH6mrPMNYm0DxfBdKTityrcVcJWqicF7+QJwUHYeh1/0B3s+qn1pNFiy7mvNKpi2jGcMw+XT8VtgMPMYmFsHX++ToxAQjdW9umJ/KKaUJp8HfSPSzxSaz07BL4qOwuEZVDtxYOclOAYxcDumRlckI5hbG2I3A72B0QYzQ9Nu5+2nyBHI/IztoYC36gWrPFC09fSNGIQWJ9oghT6lG2abbylmvi1wuKnXo18vjlIbJnRVovewZF7YdnBAsek+EKFBD97
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 07:10:12.2813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a07c68bc-75fa-4c5d-3237-08debc882917
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9439
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

In case of security lockdown with integrity, prevent the root from
changing kernel/firmware state by register writing to comply with
the LSM security requirement.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 0ce6e2e4342c..3f9e5020722e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -27,6 +27,7 @@
 #include <linux/pci.h>
 #include <linux/uaccess.h>
 #include <linux/pm_runtime.h>
+#include <linux/security.h>
 
 #include "amdgpu.h"
 #include "amdgpu_pm.h"
@@ -200,6 +201,9 @@ static ssize_t amdgpu_debugfs_regs_read(struct file *f, char __user *buf,
 static ssize_t amdgpu_debugfs_regs_write(struct file *f, const char __user *buf,
 					 size_t size, loff_t *pos)
 {
+	if (security_locked_down(LOCKDOWN_DEBUGFS))
+		return -EPERM;
+
 	return amdgpu_debugfs_process_reg_op(false, f, (char __user *)buf, size, pos);
 }
 
@@ -365,6 +369,9 @@ static ssize_t amdgpu_debugfs_regs2_read(struct file *f, char __user *buf, size_
 
 static ssize_t amdgpu_debugfs_regs2_write(struct file *f, const char __user *buf, size_t size, loff_t *pos)
 {
+	if (security_locked_down(LOCKDOWN_DEBUGFS))
+		return -EPERM;
+
 	return amdgpu_debugfs_regs2_op(f, (char __user *)buf, *pos, size, 1);
 }
 
@@ -577,6 +584,9 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
 	ssize_t result = 0;
 	int r;
 
+	if (security_locked_down(LOCKDOWN_DEBUGFS))
+		return -EPERM;
+
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
@@ -684,6 +694,9 @@ static ssize_t amdgpu_debugfs_regs_pcie64_write(struct file *f, const char __use
 	ssize_t result = 0;
 	int r;
 
+	if (security_locked_down(LOCKDOWN_DEBUGFS))
+		return -EPERM;
+
 	if (size & 0x7 || *pos & 0x7)
 		return -EINVAL;
 
@@ -798,6 +811,9 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
 	ssize_t result = 0;
 	int r;
 
+	if (security_locked_down(LOCKDOWN_DEBUGFS))
+		return -EPERM;
+
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
@@ -915,6 +931,9 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 	ssize_t result = 0;
 	int r;
 
+	if (security_locked_down(LOCKDOWN_DEBUGFS))
+		return -EPERM;
+
 	if (!adev->reg.smc.wreg)
 		return -EOPNOTSUPP;
 
-- 
2.43.0

