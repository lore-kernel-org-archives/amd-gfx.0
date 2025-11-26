Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C541DD111B6
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 23:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6627310E740;
	Wed, 26 Nov 2025 23:06:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q9D63GZd";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013034.outbound.protection.outlook.com
 [40.107.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B55110E73F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 23:06:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAQ64HCps67LmtZG9cb1D4GORpSI3ki3gaghBkFXtDXFZFnxvfoDnATYqlgIKMWAiNNpqy0qqavW/Cg3ckXlyW8tqOg40K45drOGyuDn8uBPOhUDHiM5w/AEteiCUjkTgeOr8SihdloXjyIqiPxSScNQn/myeppSn/gspCoonCBwD427osJVo8MKb/ZzWHRBGIAHfh1wLH/h0Wcd986GMo3LIHuLdP+Y88oyARyUjhWPzzROOPHvQXxtr64dEwRWF3SNgLjo0Iehgq/dzom6pNL5MXTp8H9cQzv9P4MXwGn/wDw965qu1Rof8GCK4SoLkgG9sqA4Y4KSQFcmyUNhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8/BoJBT7Ei2fRckwB02k1AIXp1s0SMYuzQ75kqUnCo=;
 b=r/f484R9ISGNknRRtvepD2OFPhGvP3QCBtXb/QIOESonQBQ7QMJvAWGxC23xYL4UAAjT7poBedYA5DmT3WrnkL/aGu0u2aWtxBNYaoG1i2A9uZPCVm20ayXfReNNXJPDEDeyf+aDG5l+T/uhxyTp5ZrpKjsLBGHn//p5ET4lSYAy/JEjYdJVuxsipxIp+C+38M58foKwsCmFnnxoczwArgBmQH+I2NGMQbA/6uTz+Lv0ulqzog/EFh329grCa+UJZfModPhnfEDDx2Ks83ZK2lIuvVUyqdvDnixf11OCz9iJQepitdS7KjhcGnxm6D3XdTnPH3V10yADnDvIoT+NxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8/BoJBT7Ei2fRckwB02k1AIXp1s0SMYuzQ75kqUnCo=;
 b=Q9D63GZd6UMM7N7STPX9221L72sSbEuhoACJuMu4g4g2uJsIrBUJITmRVpmvS1ZSsZi6wDD6uPlqymJ84INKgAI/nc0fEDR9TZoGT4ETgE6I1whK2VagXwk5NdaFi+xXhCC+oHfOPXl5vnr640dezkqu2QE7WDJhLdhH/SrfiZo=
Received: from SN7PR04CA0151.namprd04.prod.outlook.com (2603:10b6:806:125::6)
 by MN6PR12MB8515.namprd12.prod.outlook.com (2603:10b6:208:470::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 23:06:47 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:125:cafe::c2) by SN7PR04CA0151.outlook.office365.com
 (2603:10b6:806:125::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 23:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 23:06:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 26 Nov
 2025 17:06:42 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Nov
 2025 17:06:42 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 15:06:42 -0800
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 14/14] drm/amd/display: Promote DC to 3.2.361
Date: Wed, 26 Nov 2025 18:06:14 -0500
Message-ID: <20251126230614.13409-15-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126230614.13409-1-Roman.Li@amd.com>
References: <20251126230614.13409-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|MN6PR12MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d595ec7-38c4-4841-4658-08de2d4079b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mwcOtRdOxfZlp6LNwGC85daSgNWt4aPas13/DJUxxc5dV78dgOnrwmpkwxy0?=
 =?us-ascii?Q?oVe/thCr0IYMsyH21BrhmkgsqrF9/R+vEA98FLoNBmsZIJqV3q0YyzIvejtC?=
 =?us-ascii?Q?eMXFVzsrX7GZ7jjSQzyiaOCLz9YUQi6uzBlS9Q1mAISlV/37EAYdl9k+l4kE?=
 =?us-ascii?Q?sSaSc07cq/+/rwyZEpAJa/djuqqhZnTx3i/rFZkK9dx8MqyiUfIPnfHH0XcP?=
 =?us-ascii?Q?uY2qX8Oty9qNiMoh7DNob1IjHkYBQesKDFzYS2i2oypSjZOVLk5QQ1ztKPgo?=
 =?us-ascii?Q?hm6KOn88vCEH6MQgxCFL7T6SItCgJUCYjH92gjQfSaStqB486YrcGsSlFjXd?=
 =?us-ascii?Q?IQGjXo+3HvlTAMHKQnUjO+SlrvwxN/mHj/C0aULXnuHL/hZmcj510luIrscb?=
 =?us-ascii?Q?j57Y9D/z/dkVCSM5EOLyI79okCkixZnfwxJFNGVN/Byl95vWX/0HLCT1glRv?=
 =?us-ascii?Q?Gpg9dtE5WzvDQBDCsl4zEJAR6efFWQ58X29/gFDC79ACILcBnbJIZV8X87HI?=
 =?us-ascii?Q?xxaKqIzFTzkmohVRy5YV2TTmgML6+0Aur5z4dNs5+SvOKdQiDNBKCWHtZLRb?=
 =?us-ascii?Q?uHZcl3syE2O6gbYwuoXyBwzPH1+11Z40O/uRH3gtlVlHPBtMSsU2oScWfI3v?=
 =?us-ascii?Q?0ojaItnu/xWPsKJuzesaxcwTB/h4KUKwoGuf3vrHz/s2Y8FcrcpXjPhK9WyN?=
 =?us-ascii?Q?df+uFcHTXgZK4VLVFylYDIIzErjicGJoDEvUw91yMF1gtm8hv9L3Ao1QVEWs?=
 =?us-ascii?Q?G2E5JTbWkJMnbGp9jJFk+0ZpAjwnU2CGG+uiiG8SY00zq1+Usgvum7e7nfAV?=
 =?us-ascii?Q?BA88TMuIKzD5gm4QyGmmBVUSDZILeb0GpDdFWirr+GEPJA3243t8kUo8i2yt?=
 =?us-ascii?Q?q7R0EyX/SOtggSxneg83RGjxAPvA0RXO5mF4DTpRiPOFkM2VRfH6y6tfypzs?=
 =?us-ascii?Q?c0BU4vAPRzJkcrVFw7NJc7ntDcS6Tb4jDkBwC+OtFM8V3vkSUsAR4zHf/s8f?=
 =?us-ascii?Q?BpRoAfo54FV/F3NOX6EXphK8MXuxuY69B9Y+zRCd/kBcfTglCDuBXyji2Aae?=
 =?us-ascii?Q?qYKHZfji/ow7zCkrYbek4eT3Y/4iKWVuh9+pFJD+3iQurxDqlmUhzn5QfYtn?=
 =?us-ascii?Q?Zc34kYx2lq43yGuVK2uXfg+9+SSl/7bG/GIYqDovTcDKzzARIjglAnc1Avw8?=
 =?us-ascii?Q?3c8iInODMgXnDDXu7rs/UIBTPGj3tg9ViDYp3rezaN6S0CG3F+Vk8m5yL/xM?=
 =?us-ascii?Q?CoBDUze16FfXaFyXNYyseVg1PQXdFWwB4+GfiD9OlnHgg227mNv4eL7kmlOA?=
 =?us-ascii?Q?6A2O+nlZAfDD/lFRAsucfAPse0nv8agBrTQCvwtbyQyfY8Ato0kfW0WWtHlB?=
 =?us-ascii?Q?yxjqqqQyJXH32q5rtwYLJz+fCKnQdhfvJV/b2wJSkQNMuvhq/9Q0bsrP0AVw?=
 =?us-ascii?Q?2XusP5MaVPSRbElN8Epg6gxIzsH625rQoVsfbMA2afi+xUBIgnkwJLXEgxxy?=
 =?us-ascii?Q?b0Tgdi1Zx/2qdGmNlyV/VRvgMDWqmvYP1bYvfg+8BpTkoy0FDwCd25Wfu7DL?=
 =?us-ascii?Q?aOJvB9h0w6kWLpd2cK4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 23:06:47.5700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d595ec7-38c4-4841-4658-08de2d4079b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8515
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:

 - Fix wrong x_pos and y_pos for cursor offload.
 - Fix Smart Power OLED not working after S4.
 - Fix double cursor when switching between hw and sw cursor.
 - Add configurable SPL namespace prefix.
 - Add register definitions in dcn_hubbub_registers.
 - Add additional info from DML.
 - Add dc interface for query QoS information.
 - Refactor HPD to increase flexibility.
 - Remove unused encoder types.

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 827e0008c31d..167cfb1b01dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.360"
+#define DC_VER "3.2.361"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.34.1

