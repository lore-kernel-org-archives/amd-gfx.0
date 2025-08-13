Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EE7C87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 19:37:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8697A10E7B6;
	Wed, 13 Aug 2025 19:37:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EC8DmKhU";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF2A510E7B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 19:37:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyM/3Chzp/1C9/6mbsjeGfDw4nHhCCnUEyVSMDCuihFLQ0BadcHuQWUHsf/z4oA4EEnJpRLvel7/0IGDWBbGNv7qJO9R6cNDNfjBViODWMOW7bGy6uc5GC6ZGfH/iOmEMiXz3ByTQdvK1a20Ng5PU4V9Ol8ODJdzc3op3W4JHEZh6uhqvEtxQxXCes+4u5mh0b7u88oI6p7mHk0lCfaulwydtdd0BJCsjwGQbusoDCQpNtqXUcMEzqC1G+dWd2afhAleRtdEZm7ZvSC3y7eDUwI9bvCXCbWRftIe7PwF6vNlZtzwrTmvOZ/Llsyg5xLF5XVU5mqmP8F3Gjb7enlYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yA2BnkM2xVFbQkCLuRBSJbAzb41lZQrPkhUHd91kRbQ=;
 b=FjLrSMFdMSjEmlKuq0q9Q5rSLjRx0kaMU3F+8o6Pj+V8xu+UHRhdFURjaJTpFcfC/FiDg+lMbI46PBKlVpkM8hj3Qm1TaQ8PYA4qdHvPUVAICsBZyO4Ifu92JY/pkHc6KLaQ7jzfOnH8toJhqLrKr5YtCiWi0gyME3JKCefIFXdbn0ShuhpLFXf/yGz6Ts4UF6rqjdgejE14Ex3PE5at0LHZ5HDuTbx048FAtIP+a9FilPpyO6U3P/Hc6aUArjQsq9aiz0dUZrfSI5uzVYf+7SgyMJJVeYfcNWwWV8/n359y00Qy313OyaY9/+eITX1OMjACRvRmpvXgUw1KIyuFig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yA2BnkM2xVFbQkCLuRBSJbAzb41lZQrPkhUHd91kRbQ=;
 b=EC8DmKhU365L/Nq9Pj30+K455qTFsKmwkrD3JjF299ZoZSNIGlGwR1kLcNeVibJde/TaFNQuAS5jxpKqEtWgEzT8oz1pGBmM80M5x9DhGk6AAWHR2gKUUG+558w17VH5Jo2ZfxrYbQl4+u2ZF9RmjdhoK1gNyzeUFv3/gFSUjCM=
Received: from BL0PR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:91::20)
 by IA4PR12MB9810.namprd12.prod.outlook.com (2603:10b6:208:551::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 19:37:18 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::82) by BL0PR05CA0010.outlook.office365.com
 (2603:10b6:208:91::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 19:37:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 19:37:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 14:37:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: drop extra cancel_delayed_work_sync()
Date: Wed, 13 Aug 2025 15:36:58 -0400
Message-ID: <20250813193658.2444953-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|IA4PR12MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: 34092a18-78bf-4547-5ca7-08dddaa0d05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I53PXaxcpnbMq3Mt9ZBHPNeaI+k0R21TZjSZwUS0hpZzRYEn+WI7GboxYInm?=
 =?us-ascii?Q?yPjFgVMQSRouvUd66T6ZCoslVMHslrjaF7K4EFgCowBR14paJOKZFXUUd44C?=
 =?us-ascii?Q?sSBlnvp/5/nh5HxncIft9CKQ0gxenAkKIwhDnZ70vEjmA6hsuGZA3nN9FAo5?=
 =?us-ascii?Q?GYUTrEPWkVrKB6EQ1z1aDI+uf89Rafx98T+4mjMBeQfxe7Xy813dDX96z7GN?=
 =?us-ascii?Q?Gd3WNkx1eLu/yruP4k3hB6VZkg+grw2Te73v+JehCBxOf/QX1g2G2d2Vu3Vt?=
 =?us-ascii?Q?0K4jbzJGs4U6SFME/hoHj0YVyZA9eg/vUgeffvp58VM21HwXBa+3Gl9N6iCh?=
 =?us-ascii?Q?ddIFzAuUFPZC1ngEPq48l93hxsoPZyBLcl9Qm6TaiSEfrqOGo2yPdwX6evRX?=
 =?us-ascii?Q?Np+Zwr2glpeWN/NHgibBWUSV38dE2T+6WuUgMvGbxHe9RZcn6ZKqDaFtbWo9?=
 =?us-ascii?Q?P09nsSQWB2kARwWV+ufcXg9rHW4EHOMam6AePJA9rI8LzDL3229Hr7w6nWJB?=
 =?us-ascii?Q?g4zbmUalXm5Q2q3NIYz6jcYs+Enbz2WBk4wzE062GNEZFvQScO3nXc5Jh5Kf?=
 =?us-ascii?Q?elgu3tCXywj62z7xc2tX7PZjRMsSgWtwGHPt+FGpD0vG7WPpZD1nqxxIdf4x?=
 =?us-ascii?Q?AMTEBbuX+6uJnjoCevrb0J8nSMVP1DQ0Fjo7PwTQQoOtykPoQSODRR+jvHcY?=
 =?us-ascii?Q?YOFuZ+iEPFCs+BmE+n24P+xuDc8FuV8XZGm1VF0Hn+eodZsT567nqerxAa/c?=
 =?us-ascii?Q?AyA9usFRFBqZKUvDhDyCM78oSXSefyQYZG+vXrB/uU/efqN8DXqAd5sjxSo+?=
 =?us-ascii?Q?Ng/wlHgDn9+SNBxWCt42tgdWmzhg4zSjOckHFmLbhcEkOB9Fh8CHKnHGs/Sw?=
 =?us-ascii?Q?F3BR3oPUcIfwQEJ6s+APoJ9uE2jRCG2Jt8fnENEEyslVxbGMf2zWKRjNCeUb?=
 =?us-ascii?Q?l3w5tZLxQI41nF9PduwHkRk7e7foJQ8IoGw3WtofL1O8O8AiksnOxr6HAEYI?=
 =?us-ascii?Q?5It6SQKauHQG90FvXDT5LVE+QcDO8GPAbVWgQ8SFbSbqzBJTGRoDsMrIHfpv?=
 =?us-ascii?Q?i3bvcRrcRyvgHARlf0i/PTotZ/d7LjQEUYa9AAYh8qb+TexZMEsCcM9vWjoa?=
 =?us-ascii?Q?gWMEMFfvoMrGLDyS3/Z0lDNO+fAXI1IOcChIIEmt2d1I1FqzXzFuF8oKO61Q?=
 =?us-ascii?Q?eJ3wPhFs9g5kGd1t5azJwtrho23zyZ7LKfPiRrxnUyjjF+0vwYuDjvnTJ+NV?=
 =?us-ascii?Q?q+ZaSQ9ecQoX+OkS937pLHxLzefrA5wNEbwyfhtUExKl9PIYglp8BkE1XgbK?=
 =?us-ascii?Q?Bpb/eYHyed2lylbAJtVTVnO26joNQzYsJyg0Z4qEXBFywQej5zr2jUNuNuDf?=
 =?us-ascii?Q?ZEwVCDpGk5uleexYpYh84xM7+LqxwxQYlrGhEI4aO7LNz053TMXzmu/okX55?=
 =?us-ascii?Q?7MwunGW9FkCqNK4D8KMPVws7aqt7uNG0HxBYO3lTMSDbP3+JvXAjRpUCgSw0?=
 =?us-ascii?Q?gnRdkhIcsO9j9okqkvFzUyaO339oNPTDySC8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 19:37:18.1513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34092a18-78bf-4547-5ca7-08dddaa0d05e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9810
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

We already call this in the hw_fini() methods for all
VCN instances, so no need to call it again in
amdgpu_vcn_suspend().

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 9a76e11d1c184..fd8ebf4b5a824 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -357,8 +357,6 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i)
 	if (adev->vcn.harvest_config & (1 << i))
 		return 0;
 
-	cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
-
 	/* err_event_athub and dpc recovery will corrupt VCPU buffer, so we need to
 	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
 	if (in_ras_intr || adev->pcie_reset_ctx.in_link_reset)
-- 
2.50.1

