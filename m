Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7104C28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 13:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D54210E1B8;
	Fri, 28 Mar 2025 13:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SToEjTEr";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC3B110E1B8
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 13:09:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHPOQdPEZVYPQeqX39oytBez/A5Zjbm+YQif1LtqkUm3QkHApAr6WHr3dYVkV8zRllZNDCEnKmjLwvzNqTtWcLuuZsWc6Ovd54GZBFXCeDzffgjmUbRIc8mLA57JAZkFo6tVLm5ifuIChkkm/lSxYhcSTRzHJMXjr8WVizEIhnyeRWWw5F3V/Y5kCfRy6drQi4SKcbr9RurA67RKAw2K8gByyZfiyYrkO8Q6gITePvcgfjA1SpNmEcwPd7UD7IAjWyWVydbGwEpPk+P2bn9jP2Y0+OF9THrbrDJpni+yxpGbeb1TenhsNcOEUTsk6OTrUa+emehZ/1YWWQE2EjOD5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJUDWGvqTZT0wARZgzKSJAnJu5mqgwpv00xQDZ+JGhg=;
 b=OtJPeuhcXugWfAgjZ9a4IJqCrzuJLJifd0eBx6kopkDi6hvvfGEjTWZOzgA/PZq6zRB36ppj4TsaAJ1lR8Pw3pZstlKbeNvJUEVIQyPuNNlku5vkVmu9lsERKeALPr+Skb6ZtnLjRa4aEIK7y4KMLGp0X/npu2t6rmU2z2L2mAd1biug31hg8yOsfzJ7gocZYXZBn2WmH8CV8wqoiqmuPmT9xanND26+k9x86VHeEsAUdSl8ToQLt9OYUmGfNDBQv4BfoQUWV47jF3wk6xWiqIjaNBF6rXQEztZSaw/BDnT/tlpOA7PDjFU6eISSnepSuvdXdim1kjqD15UuetDrog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJUDWGvqTZT0wARZgzKSJAnJu5mqgwpv00xQDZ+JGhg=;
 b=SToEjTErE5B++pHju9wpfDTHgNs6esgK0AsdT9LImxKNfKWp73+zWbRT0eTE166hpnUdZEO7/gTjiJrly+2oXJ8funQ4MqB4bxPcWpD+XZOpU69qFVcoVZeapWjPgVqCeaWeTWtqE0UjomNNuEkLFZaqPgMpMbuHPNyta5eal5w=
Received: from CH0P221CA0044.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::27)
 by MW6PR12MB8999.namprd12.prod.outlook.com (2603:10b6:303:247::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 13:09:10 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::5c) by CH0P221CA0044.outlook.office365.com
 (2603:10b6:610:11d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.44 via Frontend Transport; Fri,
 28 Mar 2025 13:09:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 28 Mar 2025 13:09:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 08:09:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/mes11: optimize MES pipe FW version fetching
Date: Fri, 28 Mar 2025 09:08:56 -0400
Message-ID: <20250328130857.4071486-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|MW6PR12MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: e989c6ff-ba80-4736-8347-08dd6df9ba60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|34020700016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7BlHRHV8+hmht1PTbAiDT9ydJHTJqLtp2jj4vijRBisu6PVSNujQnlTQM2Ph?=
 =?us-ascii?Q?cTWM0FJ5bIyijSE9AtvWg7sTD8TnvhX+8CQlbWZ0ev0zgYESFugxSJjC7yln?=
 =?us-ascii?Q?gv5iiN2/CQXk6a/c/oeaGC3J2I8ohlL6ckjjN2pvh0jTIlqRYWDcwlHTh9oc?=
 =?us-ascii?Q?2DgLy0r9ITdq6xIW96Zrenc/bAFDnOdBIUXdZ/fbpHMxUKS1dvqpSTzASDV3?=
 =?us-ascii?Q?6ip/0pqy8vWOFM/R19BKB5yuQxezLspnD0gU1KUeQqv6XC76oq8qJrVkdBmN?=
 =?us-ascii?Q?BUS7joBOhUOTvL3rPDHNLYkUdVUTybfg/WTHs1X/vtpwCH9u/eKW7UID4YW5?=
 =?us-ascii?Q?mNh69+aTjsmQSjqAnwmAurgjCahvJ3K2VkteUJm7YUY5ftrBCvjI4uCbfqDU?=
 =?us-ascii?Q?Ofxx3A1jisNzLoBeaw2ysukZcd9wZh1zSPKu4MXPfisNerSOexq+H0kSHO7k?=
 =?us-ascii?Q?8buqvg+nQw7VDt04sMOcFykMe5cc6JMu5GqJxBV1lIBqXJ/uBfrWKTE7QSnn?=
 =?us-ascii?Q?c2FtD6tttxkxgMM8LIoPXCawnv630V5LyxKt+KtnyfjdI0OSdHGctNbyF227?=
 =?us-ascii?Q?d8swW4OI5bl+bsszEif27ozmibmPxMEG79SqQ5vMz4NQxP+vf5ujCpI8/uHT?=
 =?us-ascii?Q?fNb8j1E0MN8Ngv4KZ3c4C9kLS4YnCczfpRTUV9eIh0ugFLv8wZWAbyOHoOqY?=
 =?us-ascii?Q?HKLLgf0QcJkzGEEI4seEeK7K/FOuNeBAyj/FJHf13Dg1+JUs/R1fKyYzrvbj?=
 =?us-ascii?Q?OCBPgEHXerQa/BMIfM0URMBCLGXEiiD4RaouGFgDcFj7Wt27bFSoxQOZI6lS?=
 =?us-ascii?Q?NGOehfKMCPb4XUKel7utQT8IOCE/HD/HSHEwH1OqQysDoKKtQYtZs1RDqCRK?=
 =?us-ascii?Q?uAuT4RLkUgYNxkNCa8oFPRphmApCQJQCvSkmE+29ekUTvU1lXi+tTFnXReu/?=
 =?us-ascii?Q?Qmpu2oaAtOckkb/kMZjHYkMzPlWFL655e/QPja5nlkBnx7BzLzleO6D1YubH?=
 =?us-ascii?Q?SrPtRgUzpw0bpWXVvGEPQGxhx3eQHsqblo724G4SQXL9eQo9tvNA7ZeEimwG?=
 =?us-ascii?Q?Ti4Tr5Xxm00BmwXTIRSLWCulE+nSjefsLRs6fZKrscTpnC9+FHi4BnyK/gbG?=
 =?us-ascii?Q?LlKjEXjQLNiDLVkMByFwuQ6T246pJ3rggSH6Ffzv60x/Ad5/eMLnt0XiLQg6?=
 =?us-ascii?Q?dZyAz6agd7P+0KMvMfxL0Kir6nR1Qw9dVqrQEf5//ZVL7ftTTVQxMbBqj/Ms?=
 =?us-ascii?Q?icVJ6psCDuyePinN25VDdB4QCgchon053M3mqwYP2dnCKevt+AH8N607vc9U?=
 =?us-ascii?Q?ciov/T7oKmY3daB0jwC5wJAx9iGcYreVYGaK+PH7gNnR2Ou8tgY/83G8pFEu?=
 =?us-ascii?Q?MRjwmA/2abtAaJhtELpC3wdXVxeF0ZPAGgE8jzWa/lEQ84fOY9zRbt8qDqV6?=
 =?us-ascii?Q?uJii/oibx7k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 13:09:09.6712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e989c6ff-ba80-4736-8347-08dd6df9ba60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8999
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

Don't fetch it again if we already have it.  It seems the
registers don't reliably have the value at resume in some
cases.

Fixes: 028c3fb37e70 ("drm/amdgpu/mes11: initiate mes v11 support")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4083
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 16f8bc36afa07..06b51867c9aac 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -895,6 +895,10 @@ static void mes_v11_0_get_fw_version(struct amdgpu_device *adev)
 {
 	int pipe;
 
+	/* return early if we have already fetched these */
+	if (adev->mes.sched_version && adev->mes.kiq_version)
+		return;
+
 	/* get MES scheduler/KIQ versions */
 	mutex_lock(&adev->srbm_mutex);
 
-- 
2.49.0

