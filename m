Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA018E77188
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 19:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E93C10E07D;
	Tue, 14 Jan 2025 19:37:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P2Al15vG";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8336F10E07D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 19:37:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0DZrpKAGIULGdbRLWpZiZFYz3rMyqAtHjOWv3XcVpd0tTNX1itGOLXBKm7dgGRU9KJz01P712zzIdWX2TWJtiH3HKs1S/Q5+SBTyxmGBI0N1Pkfom/Ky1UkbxmqBUfnE6qFx01RnM0+tpEOujx7F8A3WWY+5ZRIPqD7jg/PKf3r74mhRuV4VugwQIYOW7L/ONVFvGIRwI/oHYJUxy/qlMXD5o6fr1GZ6ceywzPCBCKkJgNhG8LMTpCrHFBLKbHXSti8FjCa7eew8a+bTuEGrP2p7hCW1SqbOtSoubSibd0fiZVm9jdrMZwr/0c3Xhn3FjtQS7ydSWCWj6EXnEL+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3Lv8ZBbnc3Wuae5NQrOVfiFoxlW+WIS55r8FJsnr3A=;
 b=CxLAHrZqyoNiX/sViByRaZscWS50CjAcN7YAhklsJPF2Q/9h5g2/gvycLHr1Jv1AKxJMr7J8hYlGS94HEgayUXPpM973ARy492YmfIgkcjbwECXktciWDS26voilvBTYmce7UnWJZeJBKW4T+fDbxL5zK4+XZH2Ej3Id+dtzBZbgprtK5ZDO2Oy89eEIvszH2zWeAhU74wwofaU6trTbLeJX1j5/Za9jQalx9487TY3cqWfQOydgQ1IWITka79oUxmpB5ABk3eW5o25w1zpDtpCpLQGtNwSJbhf25T0OyQUb4E+/hVhM+K+RcpGhp/b3L1+DQ9DFgu8GernUWN5BbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3Lv8ZBbnc3Wuae5NQrOVfiFoxlW+WIS55r8FJsnr3A=;
 b=P2Al15vG21oeW+yZayCMVIakCKEZ1wb4ZrU5HcKtmLiyuZ3ILpORPozuAZzD8jg/TpDQSdpqhkvD/zC5RzGddP8RUT50fqFdsbZCIXjqATWcTS4vKUfgv1UfhkWN6sZnB5vaZHuH4n5/oy5ryNMPakpIyvCU12a2dOVMusEqS78=
Received: from DS7PR03CA0109.namprd03.prod.outlook.com (2603:10b6:5:3b7::24)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 19:37:36 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::b4) by DS7PR03CA0109.outlook.office365.com
 (2603:10b6:5:3b7::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Tue,
 14 Jan 2025 19:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 19:37:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 13:37:33 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, Kun Liu <Kun.Liu2@amd.com>
Subject: [PATCH] drm/amd/display: fix CEC DC_DEBUG_MASK documentation
Date: Tue, 14 Jan 2025 14:37:15 -0500
Message-ID: <20250114193715.3662180-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: de4ad69f-0d51-45fc-0f27-08dd34d2e5b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?91cYiXAme0p/yK28xFdggw2LrgJ/xJ/Sk6qAy8ktcKTs2Fvm30Q1bbQBmppy?=
 =?us-ascii?Q?k9J62fonYDgA2a2SS9wkequuQFJRYhdOHZWg8iNOZJCXCH2WMIjMJA2nzqt/?=
 =?us-ascii?Q?F4BAdPvlHX/ZPrgemv2LJOPo16kkGLlS/c50H1MMHI56Y23tqM1kc4GDliqh?=
 =?us-ascii?Q?f4KeOGoDjCCZv7jmX0qtMvU+S4Bu4P5MuW5op43lkj81QghLT+yYGoe7MFuE?=
 =?us-ascii?Q?FoHbExSqKOUweIQ0STkCKvfPAsm9RDFgg4eu30pRvYfkvUB16Q7FUopeVzWI?=
 =?us-ascii?Q?0mKEgmld4zq3rzFPoilRBqpsqA6NAfWqnYcWWLpQcAw19AQruRBCiP0XHRQj?=
 =?us-ascii?Q?Q7HesBfHbgo8GKlJ/wucVusszBfNsBdCCBkiGW/XtQjiXmZqc1kO5XyLypx8?=
 =?us-ascii?Q?tmxkId0L9ud7uS65VVN+IgvtX16CLIkSDMjmO0uNYe4J6HlC8EER+YtVkHDS?=
 =?us-ascii?Q?0tiwHXNFfOf5+5/RHUn0Uv581t27nkKBnQ0MSv77POECh0naG7ITtUWoaDuo?=
 =?us-ascii?Q?65+89dOrJSuz9dwWXRaa2HpAIK7fld/N9n5Z5+Rg3hfvF3x9ho2V8VA2C82H?=
 =?us-ascii?Q?gGiquKsJh51+UsxCMtDFneow8WO74yhHGkxP3TKDO9HnfF7lm/2z351tBQzC?=
 =?us-ascii?Q?vxT/ug/9EPKGwSIi3gJuYUbtlqDqW9XPzdCSfZC84y4kQ3NX/3G0JXWwHBKO?=
 =?us-ascii?Q?F8pAIX/QOJkoYfANojWz6aIb+YfEz/OKXuKYfxkH17N69ASdzATPNBAQMs/Y?=
 =?us-ascii?Q?Us4uqsvMnCAz7FQiGHy5ExDBg758eUU2NYcFZ70BjZczv42ZWo+N4kAr8mY0?=
 =?us-ascii?Q?XJr1uD/BNQy7vl8H9M6FXzAhu82YvE6Y9KyEejK1t9E6OYAhcza9n44bA7LS?=
 =?us-ascii?Q?hdMvr9Cni+PsjEV6tDCP+hTil2Zn/9ESW3kyndbn6RYpv5DvdkeqVWC4oFnO?=
 =?us-ascii?Q?bMGl8h82qzu23i7sDFe/Pwk94upHPi0NQHwFgQ3P5pIee+LWAUslajTXwBPx?=
 =?us-ascii?Q?bNGKp2yVEeOjdQrrKgZoyZu5WasCkrXyPin0UFeMvpE8w7+szmQR2tRkw+ue?=
 =?us-ascii?Q?DoWD/lpmee9gH3A/GgG4IdNvpG7D77q7KxQi820bzZCKLKQGxkEJWtaH64VX?=
 =?us-ascii?Q?PxOfq3knq1tf8HSA8snViyLPtFcf18U2spDdzHkURfYd0f+UI7SHDVpKfbF0?=
 =?us-ascii?Q?gGJQjMWIVhLnJc3p+irktP+LOJqAHF1PGGKkf8J4sDEkPm6vUOAAmVRHa3We?=
 =?us-ascii?Q?GqZxMQlU4KsxPzITTCo2vnjiTnirwvbaCN54hwyG+fMNo31AmUGNFu/sHueV?=
 =?us-ascii?Q?ZmEeu1gSzKuxyU5YIVX1am2Iy2HJwRTj2PaNX197KU+2X9vrG4gfFxomym0z?=
 =?us-ascii?Q?O/z1R7ujNO/n7oJpBrmP//HQS8y0mrSaIfLu+8yrKuKXsPnAvQFY7pc5XCYp?=
 =?us-ascii?Q?ehgm//JAe3Bzt3RTRbwpAXHMjExr1lNj/t4LvshqgPzBVo+7S2I5asmv3iju?=
 =?us-ascii?Q?VUgLKd0pFhCMAEk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 19:37:35.6581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de4ad69f-0d51-45fc-0f27-08dd34d2e5b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836
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

This needs to be kerneldoc formatted.

Fixes: 7594874227e1 ("drm/amd/display: add CEC notifier to amdgpu driver")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Kun Liu <Kun.Liu2@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 05bdb4e020ae3..030d99a873a71 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -345,7 +345,7 @@ enum DC_DEBUG_MASK {
 	 */
 	DC_DISABLE_ACPI_EDID = 0x8000,
 
-	/*
+	/**
 	 * @DC_DISABLE_HDMI_CEC: If set, disable HDMI-CEC feature in amdgpu driver.
 	 */
 	DC_DISABLE_HDMI_CEC = 0x10000,
-- 
2.47.1

