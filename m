Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7CCC2BA1B
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 20:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78AF410E68F;
	Tue, 11 Mar 2025 20:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="446vw4lx";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DDB210E071
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 20:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyDyn/cLdJUlj809lothHQ47QVGGC0lczh1X0UGMeOpzBackhRYG2VpJZHITjzm/HRSQEqKwWb8GKfNCdF+5rpCXrSWBzP4viRGIiWBQtRXMp045OdJNGBIebTZvuZLR8iha8iNveX/ecsyHb7t8tXBbWmhvd85h5l426Tdo2631mI+XRGsTbE0udXL3pmAG7kDPKbXDFZ53oMpzqnYWFKvA/R5PDbh1DHO65dSbPhXQ3ujMhdtAGJtG0E68eaNglXZT8vrf56ZhUsN97udP11bwtYWx3CQ/oTPSH9d8uOSFWbFgMZupZK8c1LR5gtpOcucGWUKOjp7ViO279Btq3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgTcxB3CAZJ7bvpYjY+y0rKnuIkHU5XwYgo7XIDZNbg=;
 b=zPuNU2rhNO/xUi5o9cLQVm+C7x90H5WVLqnE4eK4qOeJ6jFeN8QkFy+eppw5s7hUtFSY8W8XolZ4zBi6gA2LbLOT29rEyEQsWq2vRPaQIRFCPQSR/neLNOjLrqCtlQcDatleCqUut+NSutxdR/bga8myg0C/p2L5DEKZf9PT6063LtBvKGMkHo0JPZq8zeHInxexgEDey/12TNN6dTsMYdRvAKaRu5+nI5/iHQWwMld84bOCbe9grihpfu6kfw0SiMbT7aUq1ZO2qMoU4Git+X5qb2R1MIlKlmumw+FFdYWvDFJOc5o9FUKsQIIMDXWeUYXtF7z5yuDnIsNBZcZoEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgTcxB3CAZJ7bvpYjY+y0rKnuIkHU5XwYgo7XIDZNbg=;
 b=446vw4lx43wfMnZBqYNU09eLTPA/+Ks+t9rxReYRilronjSdu9thbp+wR+SW/E1rFXikdy1HWBW9Uzj4hLkOMBh3OYxgwzPD0+dLBHh+VXpkG5jJaC3UR5Lh73YxGJ8z0s5Dx14t7EGPJdbA2EgSMvtD3zrwWq/OONgWT6IbVyM=
Received: from SN6PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:805:106::23) by DS2PR12MB9565.namprd12.prod.outlook.com
 (2603:10b6:8:279::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:45:15 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::89) by SN6PR2101CA0013.outlook.office365.com
 (2603:10b6:805:106::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.3 via Frontend Transport; Tue,
 11 Mar 2025 20:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:45:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:45:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/6] drm/amdgpu/pm: enable vcn busy sysfs for GC 9.3.0
Date: Tue, 11 Mar 2025 16:44:59 -0400
Message-ID: <20250311204459.23864-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311204459.23864-1-alexander.deucher@amd.com>
References: <20250311204459.23864-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|DS2PR12MB9565:EE_
X-MS-Office365-Filtering-Correlation-Id: 8086f3f1-b6bb-4685-144d-08dd60dda06a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?54Rm4cfcu6624vjv73Q4FnhaYAnMbzaOmt0TGqqvvpjSKOIqYoOElTHATGgz?=
 =?us-ascii?Q?8i6gZNKUKHYZjA8HcfdpWdZq/G2XuW3h4NNHJVYds+DEFsbnqpbTIO1wQPoz?=
 =?us-ascii?Q?1MvMtaifQvSGjCG1H1P3LnDKr7c5/2vTYJZhGu5NB8vJ8+odF9GkvcN0gDmv?=
 =?us-ascii?Q?1mmMc/dsWYSrEffsRR5Uw8K5EGKq1czAwo1orn8/lGW/QouDw2u4WEyX4ItT?=
 =?us-ascii?Q?zoPZ/wQtjjIrtkR1S6xIPotVczDVl8p8ZJyj8zukMkRdJwFXAXT9lSp1oBjf?=
 =?us-ascii?Q?Vv8u2/2tFJXetnYTEjBprU/MrzgOsY0kvV+9mbI8ADaE4yEIQyRYHzp/h6Xh?=
 =?us-ascii?Q?OeycpQdpsoQZY2nydLyCVGbT/FwKjTcI2Ce8jDPnBJ8WwDQkiXarOWvOhcj/?=
 =?us-ascii?Q?hXBwDvWBpj57i0fIUfWlvKTnUOS2F1mY1NsWbTE1e2/kdtVT1Qd6JAdjCUNM?=
 =?us-ascii?Q?J7Qehz169nnGyA6mImLPDf+nmW5OX+ZmafF+p+BOfW75qvicoN7comFtJet5?=
 =?us-ascii?Q?+Ltmf6GysPAXYND+FyW1SgXHYAzFeC8EvblWNC6Om84Wb4GKkchmiVn11suD?=
 =?us-ascii?Q?zmqaK5NyLfofd8RhSUF1dU0jGxuo2shbTvdDrFZKQbx07bQw11ViLj84jDsG?=
 =?us-ascii?Q?olEEh3YCcrFgGzuko96ouW+LctMgaLrZk1Xr9inSDD6E/Oz2covoabKtcmb4?=
 =?us-ascii?Q?dBcHmmuGMJKbSqAvJJwuIYWX28R/DBRIwNLpEFV/LUVc5FuYi2eBN43xdXfo?=
 =?us-ascii?Q?jFFZeQn76iwpcgXbMlY4jJrLfCeyJame7oEbfMnwfbMiKl9/+uTIB0PiczzV?=
 =?us-ascii?Q?DdSkrPFJliEMppqkcwm+KLhDihcnZzaoA95LxFDFTfGCfRtgV6qzK7+2uC2G?=
 =?us-ascii?Q?44TyjPORHFmVMHdEEGTyt4jOjx6NovLz2+ocDJkopNR92/8O4F38aG9h8mYp?=
 =?us-ascii?Q?PatLVkzboyfnBD2UtC6bBF/0GayX2qIqie3Ou3oXZmkAmPD5iSir5jsrRtkB?=
 =?us-ascii?Q?yTqgI56tYpi4Oo+k22EDdCFatC+4izdGayo0xiWCvP+rw1R4slLn3BjmT3/m?=
 =?us-ascii?Q?mDz4v2C3o/wd15N/D7PZvdQbIAdQ2pDV0bJJzh0B3FP7M3o8hZ28b17QaMzM?=
 =?us-ascii?Q?sEZU/9riMALfPE47SlczmDDn7MHW1k4qkJLKsYMpQGEm8tgEX3lHmpFLyR9u?=
 =?us-ascii?Q?Bx6xluCy5kh6aGMHjwYxppyv1KRdvfJDxzaWUInZF5XOj3qUEz1BewKn9d8q?=
 =?us-ascii?Q?XAJ8QZlbrVxeBMobq54LASCniDR+ToWcF6tHHN5kVkMwVZUZ3QLC088FNQHI?=
 =?us-ascii?Q?GKUXyLYOy/tPHcC3QBcgjgd6vSPf0fOtDZcsU6pPzUOyWTXVEtiAAOu/IaJ5?=
 =?us-ascii?Q?dDrwNP4MRhqcyduuQgSlTUh06lp6mdyLIaDZE7EZfoG+YJuLod3BQj/1800r?=
 =?us-ascii?Q?kQ3S0qmzEIGb5TwLp+vUXEQqTpITdg1y8asTim5MKbnKMT389V2aHg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:45:15.1042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8086f3f1-b6bb-4685-144d-08dd60dda06a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9565
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

Make it visible for the all GC 9.3.0 chips that support it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index c5abf4eacbfcd..3ff9750baa0c3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2314,7 +2314,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		    gc_ver == IP_VERSION(9, 0, 1))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(vcn_busy_percent)) {
-		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
+		if (!(gc_ver == IP_VERSION(9, 3, 0) ||
+		      gc_ver == IP_VERSION(10, 3, 1) ||
 		      gc_ver == IP_VERSION(10, 3, 3) ||
 		      gc_ver == IP_VERSION(10, 3, 6) ||
 		      gc_ver == IP_VERSION(10, 3, 7) ||
-- 
2.48.1

