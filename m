Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77558C28B2E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 08:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04DD710E80F;
	Thu, 13 Mar 2025 08:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gOnfpGvh";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0052D10E80C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 08:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vsx/PKj/WIVUxF0Mqf+P4sBHooYtenAoYiiRvHlTIqoaUMGQ4ErpSk1IuHLKlQgKlqXyQJ9/6SZV2RND6aJu4u+lZEUkS/1NtigtS4I4vuQwp2O8II62rgYpF+pDi9YYdYawYWM2I6dAmjDY+LYeKOFcfGZT2KGllYZXVmYE/Wn9u9Bs2rCfS2jcX+Vv2+tvIW4vzSuo4vNVmzbGimHsedWNKiJ35PB3MQQdGjPJuVBeO/JgZDV3itq9wM9BeTWQLXLdhQPcI2JAy8jbdcnEoImg8dv0/U6Nz0jWhEvEXsFfohazoql1vyWWqR1NIDIEPv9Uq9ccTlgsBt0NdGUfZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBiRJL6EthlmpvppKxy3y2gKBaoSFFBFRI+wI/1ofZE=;
 b=NxWxykIxFg7oO+4+WohbIz5HDzUDZ7B/cVx3HfQwc2NWUyYE0lYS+xXJXKRfudm9p2Mjxc5iOP+vroTYYEQo/5b1G01xGkmaBDhtC19D8uFamvlwYTSENT/LRbNzWNFFi3cC1as9gA86o/2qEAkF90HLAfBV/UfOKS75devKGhKyQUuinpo3lpkl8+R4HUKaRomGWvHRZT/o0DLvBypCF6fJ3JSQv71wRG7KjBwsEhKzBpS9X3KSJajgAIhNulyt3VLvjrHoAmPejOijjIoNfAXu3RwHr1AZ3gBqqSTL6h6VUzWjX6A/soenw0zh9H/ver7zYBAo/1mv56LUDyzFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBiRJL6EthlmpvppKxy3y2gKBaoSFFBFRI+wI/1ofZE=;
 b=gOnfpGvhiTdtl3PypGdZLGD/gjlODxyzNJ/FFQhZ/IQ/Mz/IaA349tbkPQHl/xLF73tyPHN+g3wAynEw5hCMSi86nDw4v3oQT0wlkyG+Q5gIDCri70NSryHNGw+NwMxzyuyVI3BLKahxoAY5lDUa9W9aMs7KTE/vu1706Ex0bwo=
Received: from SJ2PR07CA0017.namprd07.prod.outlook.com (2603:10b6:a03:505::17)
 by CH1PR12MB9574.namprd12.prod.outlook.com (2603:10b6:610:2ae::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 08:52:34 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::3f) by SJ2PR07CA0017.outlook.office365.com
 (2603:10b6:a03:505::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.23 via Frontend Transport; Thu,
 13 Mar 2025 08:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 08:52:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 03:52:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 03:52:32 -0500
Received: from POL-D1-DKASZEWS-WSL.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 13 Mar 2025 03:52:32 -0500
From: Dominik Kaszewski <dominik.kaszewski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amdgpu: Add debug masks for HDCP LC FW testing
Date: Thu, 13 Mar 2025 09:52:31 +0100
Message-ID: <20250313085231.5042-1-dominik.kaszewski@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: dominik.kaszewski@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|CH1PR12MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: 89877b9f-233d-4f65-05ed-08dd620c6563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nqMJ5sTUF5iVBAvPaPF0hv8qW4MT4xFUFJ9OJ9oz9Yul0V5KsJ4bE2+E0Hg1?=
 =?us-ascii?Q?tX29k71jzwhIUQoJ04MOH3xMkzFOnysbqO1oCUdoolA1EDCKCJhwjudpD0xs?=
 =?us-ascii?Q?5PkamYPlxXSuDRcsQnc2RAl0z29Fkh8SAKLc+J+0x4xUxijB6+Fihs3yF3A8?=
 =?us-ascii?Q?wf2yz5newDmkAXqIvhjHBmAqojpYwA8NVWGqwmzlLHE5gx4mEIat/3BrJyGr?=
 =?us-ascii?Q?p0StCycLvEcFPcut6jm7fFM2j9ErepSUSRtiMWZW5vTNelg7LbH1UqLEFUR0?=
 =?us-ascii?Q?3jgUC6Cfo7oMk/wVV8dSm/5UWI0AVTwjsViUl4sG5gGLeeB3/7BBSN0UVVtY?=
 =?us-ascii?Q?PMJ68y0giDEioh8NxE42orn5TuDUZmYEEkZagorsdVwEuhy2zq8+h/XDuPeA?=
 =?us-ascii?Q?xROTOIKSeJbMmYPHLIyuwzM6REVgCuVdYVzUQYdv15d1Pes8v+MZS7DdpKta?=
 =?us-ascii?Q?7LOuCmHzXdss+N2ucbdmCeplzFSoJXU45vQuRpky7w9d09IP0YqNPU+rp/78?=
 =?us-ascii?Q?jrHQxo2hbwf5sW1slVqR26FcwUCtl4f+lrwM603saxGCevF7hzsbOIWdKuRq?=
 =?us-ascii?Q?uCjprKtDxgoUg+FtZmFIh5Pez9QHosB8yyXRRKgGStQsJTMsBwA7KoPB0FI7?=
 =?us-ascii?Q?tzlgbFqWIAYuPq7CFByL5G6u8eHnt/gNVo/BN/nz954iMRuVr4HSqJykxZ21?=
 =?us-ascii?Q?/gZ31CvfgLNhPTLzRg9OxVzz5hHSyIKwLSoXNlmdAZzI7V1UJhKWpeSkeoER?=
 =?us-ascii?Q?uSlKSkFR9Ys08selPD1blcK+fBNSXH+UsGCvv6ABQlwkRgSCNQ8AdVLdRhGB?=
 =?us-ascii?Q?BqKExXF1nZ4xsxmHuZEDz34RCjfZZuMN4WsensAoN5bkrTBQihaxi3Bf1Owv?=
 =?us-ascii?Q?rJuG2CbXFtkwqw2/3Ej/FMgJ7he/DdlLwaIF0chm3auPBFpje2VYHiRwG4+w?=
 =?us-ascii?Q?US/XvL4a0D8aFr70MvALLN+CuyBtKFmFD5wcAH4O1RlHgXQpD7dvaLE0sXE2?=
 =?us-ascii?Q?kZNLApI8+aEPiUwYjHMD2KKuCwdwMi6kawcjs66Cz2jNrST9dfA6adjNOI1f?=
 =?us-ascii?Q?2IbqqjZnzfthxart/KxJoIQXaww+llDgD4ZshjUB07kSQxZAv9pDLWwmlQzM?=
 =?us-ascii?Q?OwimNo0ZKJ78xEi4A/xYHr1NF+tBfjxEQwYNtivGFAkmEIP+u0OmXmyqSsVS?=
 =?us-ascii?Q?QNML6tXTF7f0EYGoPD5z9s2xJ29o3dEyvwzc3MIdJSdBtx//iAEr35p5vqFW?=
 =?us-ascii?Q?jtAQm2lxANg4f9pHGoqz0Su6NHKcGk5vkAOHzp4ELu+UiR1B1E4d1dD8nzeK?=
 =?us-ascii?Q?GIp7yg1BWzgnHG2E0f3sJYkMZD3o0OCn7gZ05bD10O8evnQDdvBaJY171IUx?=
 =?us-ascii?Q?W+0kfBfYQGIjPN/2enBC6YZjg46BG4hXo3utyWgRRhak1w97VU8ruG0/wfFk?=
 =?us-ascii?Q?6To/7DCr2VQLiAYQr7E75Y3Kxd0Q7PR3J/e13KapVWILKWJqMr0lEA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 08:52:33.5190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89877b9f-233d-4f65-05ed-08dd620c6563
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9574
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

HDCP Locality Check is being moved to FW, add debug flags to control
its behavior in existing hardware for validation purposes.

Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 485b713cfad0..4c95b885d1d0 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -358,6 +358,18 @@ enum DC_DEBUG_MASK {
 	 * @DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE: If set, disable support for custom brightness curves
 	 */
 	DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE = 0x40000,
+
+	/**
+	 * @DC_HDCP_LC_FORCE_FW_ENABLE: If set, use HDCP Locality Check FW
+	 * path regardless of reported HW capabilities.
+	 */
+	DC_HDCP_LC_FORCE_FW_ENABLE = 0x80000,
+
+	/**
+	 * @DC_HDCP_LC_ENABLE_SW_FALLBACK If set, upon HDCP Locality Check FW
+	 * path failure, retry using legacy SW path.
+	 */
+	DC_HDCP_LC_ENABLE_SW_FALLBACK = 0x100000,
 };
 
 enum amd_dpm_forced_level;
-- 
2.43.0

