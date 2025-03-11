Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E565EC28B30
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 08:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E48710E535;
	Tue, 11 Mar 2025 08:54:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nxp67WEc";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4499410E537
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 08:54:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWafa3ae9SBs6CVSzgDRFR1u+/kce62EddhyxVHOq5v6jtr40iO8p1JMQhv7IP1OB3lb9H6ee8SncIxQmKPqjz4cMb764tkJ6PRDsS1a4xVfsVLg4boUImTmvxi+UetuRe+WxnPyxHalLaakoGbU9roDsNjrMevMcCsrKBXeDwNe8jc9ibr6CUaQ9m3CKptqMhMByJ7LG/YZbUPTwuSQdSQ+POfA+mGfz0TbcVyHGYTb3VGLaIpzBe1WOytEz5xCrg69fln6dib8mBecFnxA3njAheOqK/q+G2Mz1xxG9WQ2e/TjFaf9TZrqCJ7w2fbPeONKrgGGowPWJRrXoAQiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88f1F/jJrIb/hGSGjpRKly+di+R7WOH0imq0jOp8pYk=;
 b=aOpl1FQjNWkY/Y8cC45uURlMr2xQpcT0nh+PrKwxyVafT6E9WCLqUATCVPeeCpmUYnDEjOuyt7EzuBGC0wOgekKk9sBLRPMEnFzdEpdq5zjPmexmr9Mn/5+CjJ24KPNxdO/YANVmV1Im8I1Ce99d8hEHZtFOal8Q38fHNplbLjQ8Wks42tWIg4QwZv2ibujsI6fyucdqCbmzf/go/fMhLECPndO0xjXmUwBuLevl/k1zMkSVwy4qpiscu6lcaFU7F0Uw6IYPEWdZyMiTf+PrPwRuQ7RLK49bjY+a2iENERSHmdYHY1i2qzohEBK/RoYPAsb2do52uPzp5CCAasjCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88f1F/jJrIb/hGSGjpRKly+di+R7WOH0imq0jOp8pYk=;
 b=Nxp67WEc+ScbBHWwv1/qXICTOUCO/nLAGv5HpXSXUskx/+9ylKWfpSceeAUwe2t82qaKqPW1FIPNptPtIAL6Yk6ZupOFaDzzRiARJcKdMRmvtDbR9eSPEanPLboFBlEk1wTbrFU7e5KLqMqWuoSLXGd05hL+gTZ54RlfkotJKZ0=
Received: from MN0P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::31)
 by IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 08:54:53 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::7d) by MN0P221CA0015.outlook.office365.com
 (2603:10b6:208:52a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 08:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 08:54:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 03:54:50 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Tue, 11 Mar 2025 03:54:49 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, <alexander.deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: prevent skipping the workload setting back to
 bootup default
Date: Tue, 11 Mar 2025 16:54:36 +0800
Message-ID: <20250311085436.628620-2-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311085436.628620-1-kenneth.feng@amd.com>
References: <20250311085436.628620-1-kenneth.feng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|IA1PR12MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: bc19af92-01b1-42fc-0b18-08dd607a6302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7KzalhzKtYyKgAQgzFtdqZYa41p+h/SNoNUWhaU2UbpoT6ROrgrvLj2JEoAT?=
 =?us-ascii?Q?2elHUCLYow6zLj7jN6zU123JYVC9sS/PZ6c1UkRdbg7T8kxr8Y+7cijsMpRu?=
 =?us-ascii?Q?nlbbnQc9hlutFmfcqt5Er59x+tegVt8JaCdn4mF4NWHoB3N+HvFK0BlbFrYb?=
 =?us-ascii?Q?YVVy+hlYtXwSGc8iyqSlz38eIYi8RMXWQY0/DMtvg1Nl72Ro/zuiwlEHlXfd?=
 =?us-ascii?Q?MkD6r1pC6PrIeVRdUxn4uldRRarFKflDdWSSP/XNStIei/cQ2u+lRkIUmors?=
 =?us-ascii?Q?wCyJzDmXccfz12Ijtvlc0JP6JQTc2yUjHLykICpICoTIXiMCG7AA2IXEJ56n?=
 =?us-ascii?Q?pY94blQ1WM/rs6Y1GmtKhqJsKcawuEGgHsPe097ukvP8GkWQu9d2PlxOy8gu?=
 =?us-ascii?Q?PROurFaCsGwFyASivNM5SgxEoQmB/a1scFwvs8AX3x8WYeXrBHVi1ccP6jxd?=
 =?us-ascii?Q?vZNtfJhxp0OxvAMnTEtdKzxf+VFmSV/nemg2rqMy4L5iE+eQsj9umAu7VH8T?=
 =?us-ascii?Q?ThU2ID/YmXaDyfDA8FCOkuwlHpw750SSblJXvDIEjX6hNJsGoooNONjz/Xqg?=
 =?us-ascii?Q?3eQ0o0hb7e2bF2XhbX37YPaAJf+ENkRzVApHjoh9rypBplFYHiYFL9tm+T0P?=
 =?us-ascii?Q?YetqFR8oNehRm8tsyjYAWcFoOq02y2e63p2nCnR9wn5CDe87vLOGxEXUEpQA?=
 =?us-ascii?Q?G7+KsO5I5mRJlcy9iEYCvbWtSmZvn5jSvjiVy9lAP0iup7q7eZcUoD1gmCSy?=
 =?us-ascii?Q?vW+8a/khry6sKJroU6ZFQovYpubAllbOMgiInip/WfZeV/3fEoQTXKy3snpy?=
 =?us-ascii?Q?jL8gA/Pz501m8iZv/BTVzh2mvRlCNFTruG+H69ErNoKQrAoxoyZew716pMAB?=
 =?us-ascii?Q?0QGWjbmqXgX1AVt0IRZtUU00a1wYj5scqqVviRqxh5IVYAACLLesx3IKtL7p?=
 =?us-ascii?Q?tMIBnVwG8yO35JmWxYPzxKEzILRYB4+phlcVc10iqiGP9GuliV9zfD6qXWC5?=
 =?us-ascii?Q?gav8oIWkk8fle76Vo0+FtD0xnruG24MNrG4JLa55XuasskjGTyYz7LF0FGyz?=
 =?us-ascii?Q?YtRFbODgSsgOcKWJO2IPysdkXhObkS2MS2HSjmLBrVCKdo2SRIyY+BI9lbHl?=
 =?us-ascii?Q?i6KUkBxz8ZvbxBgQkv501YLfoDWBgA04qgWcVjEYPm441jiDn49GsZj7LJSZ?=
 =?us-ascii?Q?k62ubyV5rweKkux/HbcAXCI9atnfFlZwcTzw0gx3a889txi35gNtCAZD85N8?=
 =?us-ascii?Q?Zdh1h5EezKolhvNBs/1HYiC7Vr24ypji9sNoJl2MqQ4mJA1Wuxzy+DBp0D22?=
 =?us-ascii?Q?PVF0GxHGZe+wNM4J2tecdqBtI/6Lq51OHTzy2JzlzXn5qcGLI6uJpmA0B9o7?=
 =?us-ascii?Q?rUmUsIYqMUjoHORW0ZpJ7kvxQraYWUs04R//Dt2XUlwOg+xY5HzwLDOvhVNH?=
 =?us-ascii?Q?raz8U+Z/rKGSdieVb5dCj1J/obFRIydiwIxEqEBUEu4eJgLFZVIm9CVgrr57?=
 =?us-ascii?Q?wPIfj0yfOum2Lk4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 08:54:51.9364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc19af92-01b1-42fc-0b18-08dd607a6302
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405
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

This is a bug fix. The scenario is that the same client can add the certain
workload type refcount multiple times. Then the same client can not remove
this setting when it wants to get back to the default bootup workload.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8cfb07549f54..592bf54015c6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2273,7 +2273,8 @@ static int smu_bump_power_profile_mode(struct smu_context *smu,
 static void smu_power_profile_mode_get(struct smu_context *smu,
 				       enum PP_SMC_POWER_PROFILE profile_mode)
 {
-	smu->workload_refcount[profile_mode]++;
+	if (!smu->workload_refcount[profile_mode])
+		smu->workload_refcount[profile_mode]++;
 }
 
 static void smu_power_profile_mode_put(struct smu_context *smu,
-- 
2.34.1

