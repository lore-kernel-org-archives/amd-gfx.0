Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9A9C52D6D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B8DF10E91B;
	Thu, 18 Jul 2024 14:08:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s1+pRsWJ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E5010E8E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbDrwmsjrEbtm8i7B3rxILVbgkRuoF1FGE5kuteHIdj5l4lvh15yv1DPxD/8tcDnwOE8ZxBpX4I2vEXqxev5+fg15BfL0xrW73wUULijSw7wN8FpSca3nwaBKNU9SoWopuMj9H6o0HbYYRuOwJAoxy0QwvxnJ/DstBonAP18aCJClOn0heoqrjLQGqwsHqmczsr0vOonDCjqqX1OM9PuaavFmbqFLctQ2hwrvOvo/g1IP76+ZdlBnZ005/xa8+AR7ZcZJfwMJE0yjNYso4KzL1e+3Tk9i/6dYnLiV8jFKin3wQxAeiOHuN/3d7VZ539uvf3ihYhxOvEb9iRuALCVFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0xVt2zJ1mT9GWobOwARc4rS8lC4nBm9wzD9VYEwy8g=;
 b=wMKdAWBjqgJ3Z96cxnI5JGXTAPsXJ0bhtQS1lcByTu7LKW6qHPGxNnxCDIdVkXIrxBm8KCNe7cWCgMoKbi3Q9zK7cwAyI4cgqy6FFOODyN6zA4fjcdfjFbDomfSyRD/1qOJUxJ1N9t+6mP8alASyRsfv9EyCrPC3zrwPCMFp70zp8GnS086MtL6KES41hfRn00oFg4Nizv74DjJgz+csI3EZ3CI5FPt50j5VSDgZ3zNINXDiBxUMpBaphQ3+/UyVL5FNMCXghXeQ2RzqJ7mMwWRVo7gyNbJAEfcclLR8UHRSkFq8NDMGIXHVskMmKCBvvMlu7z2EsMv4Muk+1InQ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0xVt2zJ1mT9GWobOwARc4rS8lC4nBm9wzD9VYEwy8g=;
 b=s1+pRsWJ63KdezKw4NMBr2hcZaGVGvztF9Z9sl1dYZyZYiL9muD47Qaz72cCH1CK2MPmX7Fvwk5JbuF/cYlrH2IYrJuY79KDrkFh7cGJEb3Adah0vNbkKnYVzZ7Uv29RX7ou10kEXq9uW51RYar2kw0Qqlfxa96L3CSvnv4X2QE=
Received: from BL1PR13CA0071.namprd13.prod.outlook.com (2603:10b6:208:2b8::16)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 14:08:09 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::64) by BL1PR13CA0071.outlook.office365.com
 (2603:10b6:208:2b8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:08:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 31/34] drm/amdgpu/gfx11: enter safe mode before touching
 CP_INT_CNTL
Date: Thu, 18 Jul 2024 10:07:30 -0400
Message-ID: <20240718140733.1731004-32-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 71fb8c0f-4066-48a5-b331-08dca7330d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qGL8BDwQUl+Yqm6Ro/u7ekh6Vyuq9O6O1u79Ui6BRJvUXkZ4NFDw//9NmCab?=
 =?us-ascii?Q?lTx03/S5yoK8fNeL9AYfoyhy4K6/zBnpUqqA10TwKlxHBnLZsTujS1BSeBag?=
 =?us-ascii?Q?jDvP+uwghqREbMFueuiAMmv6auLSM2kJExKDF/zGHNrKykCVEPiRhjH5bcXx?=
 =?us-ascii?Q?RTm6WF53Sp68W3qICCPY8Ix98w9aF/ZnHBuerPc1XFBnNoHAx143IiFdFUgK?=
 =?us-ascii?Q?rmsraksJjoO43XTiHqGTZsNuFHkQo2mKSBf7DMwQextrGte+n9IXAUGpRN4P?=
 =?us-ascii?Q?Y1N4Lqt2Whbe6Z8eBgETYjy/ll+DMsjRUVIhy3uIybAO6ryswNgl0lBEXYL2?=
 =?us-ascii?Q?1cWlfqJRZ/DLPRo/+FL6yBliJhl6zxhyDbGjw5TgQA5ZN8WUvfQylRsNpMNw?=
 =?us-ascii?Q?WGv+Re6Lu0bNRfaayDNcDRzJeY+h10NF/E64RHwQ+FgtnVXQmPfD8xCVwtIX?=
 =?us-ascii?Q?NAeLZ0FxEOd/rVjldIVHCsoY+MasBoiGpb5EjYpAkmSemMX6kmOzasUbBbxc?=
 =?us-ascii?Q?DPqHLYU023FcB1ZYGU0bUp3e2Hze95s7gbLLqRzxEw2jefl2dJw4N1Uxddrt?=
 =?us-ascii?Q?bmBs7HtXlxrQV8tG5ciC70vu74KSQmOUcLS96Mx+NhemrgAwQwsM+YWtnRI7?=
 =?us-ascii?Q?Kqh2UDq0AoTmjhwVvAXtox0pN2enD5NzWInYhZPU/DD8Mnj6ELHFxMoG0Y/z?=
 =?us-ascii?Q?G3DUH1c7pXwooWn1tZWcA5BLyA8GWXWqTpXJ5NYBX7u64xefVx4ydkM82OUn?=
 =?us-ascii?Q?ALhtF5c0W20nCOBR3SvaAbmlVN+5EhgKkC6UTQbvSLX2WfteVUP729QI5z0t?=
 =?us-ascii?Q?QeiXZV8Hv8DrpNPI6JazE/aoTN9DDpYQEqiwCaSTTFuAwIkgJqoWyyVc++oQ?=
 =?us-ascii?Q?Ycp7wTYFmWowW7zOOoSkOghHc8hTGfPzL5dByQDB5nvswRtqtjdTpjMMDUr3?=
 =?us-ascii?Q?Yh6UWRoeDgEydcRMG0z7If1aAVZVPDyBqzh3J3sioD/QSnFQ3iJxbrzhIV5O?=
 =?us-ascii?Q?INDHpc9rtid7yvIITEC2MbqmgVKdLVGyDppbEG+X8Nkfku7JKG158Ymi1F5J?=
 =?us-ascii?Q?JYCXJilOoUm/9LDCg74VcBr4VTVBSJauAndv7r01dIdr4qt7OcPuKYviitH5?=
 =?us-ascii?Q?qo+BkfiGlbIlirXU5OxsYFD4RWDPcpMHqrJthwS/7Nj/6SHthxaqQPXlrXaI?=
 =?us-ascii?Q?BoATjbMTlWuCYgpQkW2kkKrURjCCdEiiy4y/wv7BXyl+Xfm47CtBue/kUfy9?=
 =?us-ascii?Q?JmapHo5AvyR8rTgw0hwBghY6U4Q/QLEgUwlyB5P/coDITkQVJXYSn+sT+j4G?=
 =?us-ascii?Q?uDYCxzjn6Lti7o4hbQWvolUBhE2nTerivpdhyYxEyW5tM8rbRQPlOTU1iPsh?=
 =?us-ascii?Q?7os1wEiDVmtG/HKo5B1n8MYGrXtAStBBiACEwcRQfFmS7frsa1bBqyF+bGZL?=
 =?us-ascii?Q?Oc0X/25cjFH1jfuAinQYJZWXiLJLCDxa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:09.0630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71fb8c0f-4066-48a5-b331-08dca7330d7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583
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

Need to enter safe mode before touching GC MMIO.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 348bc1b1784a..9bd42533ce61 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4763,6 +4763,8 @@ static int gfx_v11_0_soft_reset(void *handle)
 	int r, i, j, k;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	gfx_v11_0_set_safe_mode(adev, 0);
+
 	tmp = RREG32_SOC15(GC, 0, regCP_INT_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL, CMP_BUSY_INT_ENABLE, 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL, CNTX_BUSY_INT_ENABLE, 0);
@@ -4770,8 +4772,6 @@ static int gfx_v11_0_soft_reset(void *handle)
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL, GFX_IDLE_INT_ENABLE, 0);
 	WREG32_SOC15(GC, 0, regCP_INT_CNTL, tmp);
 
-	gfx_v11_0_set_safe_mode(adev, 0);
-
 	mutex_lock(&adev->srbm_mutex);
 	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
 		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
-- 
2.45.2

