Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D788FC71135
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 09:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D6C10E17F;
	Fri, 13 Jun 2025 09:54:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D5xo4e/x";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04FF210E17F
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 09:54:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIKdZ+6IE46km8cN3YNwCGdAM8uVgzqa/PFxdfPWnUjG4rw618t6o+VwtF9uuqCKkKAptTqsG4CwgzGssOnR82j4WRHQArC6NlxVgEtjlmbP1YwzZzZYk7RxW3Oyu/ifnl9zuLyaBzMNYq1LWNuUs/JY9G6l5Yhj3tPz6v5QOI3XnYJHCC0YUXNc3XuvNTkxkbkvXKUTUzJheYzI2c8DtddqLBCMHm64lxgpltoFpNW7tjKKu6IYb4FXHVyuaOXyytP0eQ1fkpr++BhJXc6s2Jz32n09RxL8ttdhk/Y1tfOjjQ5uObePVeKGJlsZFIDZccoHm5uXj8NLVRac6qjggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qG4rIuGdATeLIzWuMTqs7njwul/ZcYTU89f6v4G/02U=;
 b=SWgO6mea7HgfrZWqRHEOJh7LpGir3RqFgXGvdhWMg/xkY6IErqKpHQ1lNdp4F/kVGVv0DugR+3SAGNHugG+RoP1LcOOqxHM1a+T/uKXnjblPA73Hgjx5JEjbu4GW8qui8Fab/sDo91El0SqLJhB2xZOwdIcBmFbBw3qdofpLHgeQrN0/d6OwBJ3TaVdyMBSez2hGdMXI8yYDJ11Y+Dx+YQ+GJahvgPP6QW7pyzYaQg1zCJKXpUxQGNLp8O1eXYICMb4lFnyDQRwyEiZKXPDCyUNq8Dl2AJGb24PyUIfnxem45QFG2k72i3JWx7uj3EqtKjCYk86Kua0ErhcOED0I5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG4rIuGdATeLIzWuMTqs7njwul/ZcYTU89f6v4G/02U=;
 b=D5xo4e/xxY2SQncZrs9D5B0wDITYOIv/rUDlZoimdSpKkjLqr+FeebPFJ+8mGdGeNa4Gg25L1Zk8N4rIIGDcw2Bzi+tcpmtXi5BVK5ew5nTPd0BP8wUPx3BrWsk+Bms+0YUchnZIkLaoKWFdAftnig8AoU/yuxrVn2jvqvyklVI=
Received: from SJ0PR05CA0090.namprd05.prod.outlook.com (2603:10b6:a03:332::35)
 by CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Fri, 13 Jun
 2025 09:54:43 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:332:cafe::11) by SJ0PR05CA0090.outlook.office365.com
 (2603:10b6:a03:332::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Fri,
 13 Jun 2025 09:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.0 via Frontend Transport; Fri, 13 Jun 2025 09:54:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 04:54:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 04:54:41 -0500
Received: from lcaoubuntu-server.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 13 Jun 2025 04:54:40 -0500
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jingwen.chen2@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Lin.Cao <lincao12@amd.com>
Subject: [PATCH] drm/amdgpu: Disable cleaner shader in sr-iov multi-vf
 environment
Date: Fri, 13 Jun 2025 17:54:28 +0800
Message-ID: <20250613095428.92143-1-lincao12@amd.com>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: lincao12@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e4b8ce-822c-443e-892b-08ddaa605209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?34t+tQaHr6FC0qYuF0eXlvyuDg4AlSECXV/8TMn/NinD4rBuNxwstrKpWmqR?=
 =?us-ascii?Q?KL/K/b8iZjfcMWOrehfF9V8UimrekO6ne0LQlTCI0ijMTDKR+MYugoEe8grB?=
 =?us-ascii?Q?R2Ox9SGukr4/nTX/pe7K81AZfTK1WDmYm7aPfA/lp3Gp0L9j2jgZCTtD5NyD?=
 =?us-ascii?Q?k77102VBRLUaeyqLH6ftlCA+sbzWzlYRcNCUUUprRslONpwzBAgr6p+hP546?=
 =?us-ascii?Q?RoS5yNR9E5itLeRPGI8kdM2mwd4ZUkPXm/ygaq/R8NXOeVWnyDcfNsNkUthQ?=
 =?us-ascii?Q?ZeVdy3dXT4/SX1mJmNirOADoAip6U+0tzaIL6FgeSgA1s8xFVQuV2gS2h76s?=
 =?us-ascii?Q?Ix4uzq3NuAZWp5XCiX9QytGOruWvbgYLaBt0PfYZbcDCNfUH8/2LijN1kkUO?=
 =?us-ascii?Q?Az4AW02dgHT/JaDvjJ6rMlAuJD4d0ufIK+yLlr9mFdt5FYaVZQ7pkq439Xch?=
 =?us-ascii?Q?3cao6DzgLUSWLSz203eKEFZU5AcE3exEgGmAA2Rxu42+BjWvSQz6qZMHwp0W?=
 =?us-ascii?Q?sY3zmhe+lJhPMvjcxlW5NGKDyKPfHjtUmSnpGZ2cvg9JBbcXrzUGHEZPr+rT?=
 =?us-ascii?Q?NXib6ibf+mmg3jvmQw9eXZi6q5OPfznbFm1LbCgSkJBeX5PQbMqXPD9fuaL1?=
 =?us-ascii?Q?f3A38KJofh9H8BLh0YlHs4Z6UDfWPjMjhBXn2iHLJZRliWDxMHxvb5jYOPjS?=
 =?us-ascii?Q?qpkGI9TX7wr+dg7xBJ4SeUBKW+AJ+N++qsmIKZ3WjW3I7omc+8j1Nne4fash?=
 =?us-ascii?Q?tYWT42oJAJbYL57MEkjock0WAhN3U+izXZEm1iTJJRLIzVVEFzfeKPTNAFtc?=
 =?us-ascii?Q?ZFNNyX/moQ/J6qt9DVfT1VHz09IKBivTcKdy7aWxii+gmZONSOv/YmFGZNiL?=
 =?us-ascii?Q?DUfeIPw005FWOJCscKkNfa2vxzReRVh5aDv9JAG9+9v8uo8c7R7khrxfTC2L?=
 =?us-ascii?Q?xoKgtVtILIaTc1cuYO1XwZuqcGFb0WHSnvwtU9/XQ5G7GaFtSIHqqo2+1XBh?=
 =?us-ascii?Q?RNJVLVpowyFZ/ynaN+Rr3rupH35ETHOT7rotNaJxHf2b+9obwPyEcYJbe7EC?=
 =?us-ascii?Q?p+y7T5pdGy/2szwj564tC5DeOaraHYtQLpaRrUwkyBTxun1Xr+edor0Sg7i6?=
 =?us-ascii?Q?k5x+S/GppKSaDwhEIiH8j6qFgxN2zRpyCPGplNUy7vPPIcz74QMbm9kIkNbJ?=
 =?us-ascii?Q?GzaBQNNljiNqy6Z+kcXkQowS+NNeti2rxzmc5O2Ju8l9vggZ4YUsSfFy6MbG?=
 =?us-ascii?Q?ykL53AjI1okw+qcukRXR+D1WKr/ER0r/SmHEwZI5qgKnzZDqP3JWxiea7UUE?=
 =?us-ascii?Q?cTV+w/Y+N/vY7YhuAYkEbfn5alfS5ho1zbiTmArGU//XnSXE3PzOaPZ2JdWx?=
 =?us-ascii?Q?NnYb3d4POQhDCCpaYFzAlZ0gDdyU6R9hhwV7UAo18imrQ+CDCKRhzenf7iTC?=
 =?us-ascii?Q?Onp6TxyP9JeQ/0qob1I1d0MepglJdmyG9UwZTeefwd+CcP+TjjwXGLdojJ9j?=
 =?us-ascii?Q?bliY95IXf0b927FfBlQaRzBHnqWOauhRJZ97?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 09:54:42.5156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e4b8ce-822c-443e-892b-08ddaa605209
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647
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

Cleaner shader will cause function level reset when run compute
benchmark and gfx benchmark at same time in multi vf environment.
Disable cleaner shader in multi vf environment.

Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ec9b84f92d46..c5d747f55c86 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1645,7 +1645,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		if (adev->gfx.me_fw_version  >= 2280 &&
 		    adev->gfx.pfp_fw_version >= 2370 &&
 		    adev->gfx.mec_fw_version >= 2450  &&
-		    adev->mes.fw_version[0] >= 99) {
+		    adev->mes.fw_version[0] >= 99 &&
+			!amdgpu_sriov_multi_vf_mode(adev)) {
 			adev->gfx.enable_cleaner_shader = true;
 			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
 			if (r) {
-- 
2.46.1

