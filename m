Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA19C2BA1A
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 01:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3482110E1C5;
	Thu, 20 Jun 2024 01:24:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zk0rw7ed";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DABF410E1C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 01:24:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vufs5Z7XT2HLZvP45/R1RFH8vfJKSGVR9TFJKYvgO8sL9VGy4Dq0I47xp9s4jmTMsUMh2dq0GCN/IRES/YA/9gKhRD6JIQCqbxHa5Cqm+nQ/500LQ2ftWeXuU2TOES7eF+orKFRa704/igKfE5dtPe92QvpyLB81JGb2Y6y3FCeWf4GFwIKAZKJHbakUdMhzIcBDtwIZ0kaH9LHRhxMr95XyyPhSgRFlD3xun0QUtV9zXOvR7zQ2GEB1XsrhHjihLt8EuAczJMTyxvICT7aA+3YL4Da8oIQd2oPnLzC4lVN+uhmMz3OBUNBrcjG7c+BNKof47mDnv/13sJ/fQRs8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46WxdIK/eNVmJoBcDidKLLFZCZnTYp2inLt5ouf+WM0=;
 b=EE9/ayNg69TXvz3HSUcWSMhW2lS6b29XOlz8CNEEJeHQfI/ltD2G2dZCcveHgTox6U1rsOgsPHq9vzhkzfEPWzcVeENiWLN5z+EsrwTB5uUSjJGsvAHrrqzWxHEDAIgflL17SQC77BkEvUBq25hr2Shv86Qz0/5ZVzidMafbxIkrK0egwmTQShVmPb1eDLxud8w9LA05UcfT7/3g0GGuXGXOBOVjOulXti49/rzrkQau3SaIq++Q+Y9B2e5ZyWbiwKBqC6knk/6Pw3pJHkp2Lsfc/UaNgq3qabyZxQZzdH14pQIahInylc5Rtj0/Y5H/fHSKuCYCS09JAl20jBQ6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46WxdIK/eNVmJoBcDidKLLFZCZnTYp2inLt5ouf+WM0=;
 b=Zk0rw7ed3GJ0fs8FhlLO20LKeXLgusCT8dAUEIctdvtVxIYJLQMxv+S8inEl2/9SIJ9MrvcgXg6A0+/S6wevPPTFfsNGBsKCQclL67Puahb1BWU0o2tHgyp9puZJTMEQXqd636zpBq+OdJI7lFD3w3M2UDYgwxAf4/SMHg4vR38=
Received: from SA0PR11CA0128.namprd11.prod.outlook.com (2603:10b6:806:131::13)
 by DM4PR12MB7504.namprd12.prod.outlook.com (2603:10b6:8:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 01:24:43 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:131:cafe::23) by SA0PR11CA0128.outlook.office365.com
 (2603:10b6:806:131::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 01:24:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 01:24:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 20:24:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 20:24:41 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 19 Jun 2024 20:24:40 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sonny.jiang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH 2/2] Revert "drm/amd/amdgpu: add module parameter for jpeg"
Date: Thu, 20 Jun 2024 09:24:34 +0800
Message-ID: <20240620012434.1742537-2-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620012434.1742537-1-kenneth.feng@amd.com>
References: <20240620012434.1742537-1-kenneth.feng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DM4PR12MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: fd160069-6bc5-4109-2ea1-08dc90c7c33e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|376011|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cTNr5L+9gZlh6R0sd3kaydTmexPI8/IbU+OIbmvEyhaR8i9t6lo0a98+5wgA?=
 =?us-ascii?Q?FNQKU/vUf+/TW87OuQVzSFQGPc3ySeUSSB8dHq8dbLMQmRbD3sOexGq/yCdm?=
 =?us-ascii?Q?TWQBL3UEx9JnaML9qTU+tT4whRA2yL7E3C6A0LGC+bQXTpzMqy2pGCbG7Oej?=
 =?us-ascii?Q?TdgPTDGN3jZuFGUXUHonPTWpF+qkKgeFsTNYYmNZKa/3YH0m9SEN4uvzqUKw?=
 =?us-ascii?Q?T43xoIWZpHi4+F0TV0vqxrTefOnvCS090uVwizlg1G1YmVv4qSMtvcMz7CW9?=
 =?us-ascii?Q?p/+vyIrPYlDlI0rKN9KaIGVsslWL0Gscveni4m0omIsJUICs+7cBZvNW94oC?=
 =?us-ascii?Q?eLucAM52Z9GU3EkEhlnR2I4krBGNUwM1wndNdvoOfgYPSqc1TGqJ0+0KANAq?=
 =?us-ascii?Q?0JjusoaZQQs0+R8QBnhoqGUuvS4jt2w7YD7j2qsXwGh9gqDIIp8M56ZTcsnu?=
 =?us-ascii?Q?Dw6X4dHAiX4E+K2kYLdhrtrpb4FY8bIVzkpbKJDcr/I752oKWyn+pB2BJSuu?=
 =?us-ascii?Q?3sTRD2yyqNd4K+GI3tP1C95i/Mh32SqD0d8trMCTdLZS0JzbXnGn04nkpdK6?=
 =?us-ascii?Q?YhOpxPwVISkKBGTklRGf2/BzPi5xTV5Ltq7DhUwXcyyDMDR2FvxL4t5y1V1U?=
 =?us-ascii?Q?HiaMpUJmvia7xCDPs0ZmRUSH7FQr66LWUEAfiu/1MDtKBMyC1Z6eRUnrxcYI?=
 =?us-ascii?Q?Q8G9whuY7l4dJl4q1Z48d/H9jlshEhtB5U/Is6aIljv46UeuU+RZIILPsAC+?=
 =?us-ascii?Q?C24RtjTcJb95W776Qff7DtvmlIoO2LYSaZIu821aMk/FJF3iI8Nb6CR57N7X?=
 =?us-ascii?Q?RQj6KON9qwDDEFcIMRKtOkOBTS2WR/9LdAOVE+UjlHLBu3wM5vupq0a4eLbb?=
 =?us-ascii?Q?48hFA39dBWdBWg0O1RnndPZw7OcKOCuH2k9MwtT4vD2Sb12+SXygQErUtnM6?=
 =?us-ascii?Q?Vi73+dnOUgm7tAL16wUYqIhVfO6dj22/SZT9Y6T5AGSHZhFqeRE8RvId80N/?=
 =?us-ascii?Q?7FgtQErSK0IVgPHMw+pM8Z7l0J/7xr0tG60KpkYQafscKouOw6mO0S96RqRN?=
 =?us-ascii?Q?Pb+gJcsh3MjQhBA7e3tYt4jqgedF41eiNBmkxEcQ3VgjjIEUcFwQO/FZUaV1?=
 =?us-ascii?Q?el/VCIU4+W8NM3i5d7hOnPoGAU05k+U8R5Z6MCudRJggQPDn6KJ7LPb+PLca?=
 =?us-ascii?Q?j11rUGgY7ySxfFmmS2sYjn7BICyTKEvoCrTwhvi+9NFVBG6w3kSdzoqQAMPx?=
 =?us-ascii?Q?2wZvXioOujqi3bQf1YSjDD0riaSENvxtP8BG7R7sh/NnzAWk8oTHa11HsAh+?=
 =?us-ascii?Q?UtJUhjHTKY3i1KMpjGU4EkSjorn2u2kJg/XLmPclpZDIPRPBsf7n787fjgoF?=
 =?us-ascii?Q?hGgNqMzgU2FnRNttR8Y/2k7TGN3ywCuA+WWN7xZGWGuiV3tmjg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 01:24:42.7510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd160069-6bc5-4109-2ea1-08dc90c7c33e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7504
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

This reverts commit 63400bcf5cb23b6a9b674eb3f2d733d826860065.
Revert this due to a final solution in amdgu vcn:
commit eef47ed5f703377781ce89eae4b9140325049873
Author: Sonny Jiang <sonjiang@amd.com>
Date:   Tue Jun 18 11:11:11 2024 -0400

drm/amdgpu/jpeg5: reprogram doorbell setting after power up for each playback

Doorbell needs to be configured after power up during each playback

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 4 ----
 3 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6129f9f7a577..137a88b8de45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -224,7 +224,6 @@ extern int amdgpu_mes;
 extern int amdgpu_mes_log_enable;
 extern int amdgpu_mes_kiq;
 extern int amdgpu_uni_mes;
-extern int amdgpu_jpeg_test;
 extern int amdgpu_noretry;
 extern int amdgpu_force_asic_type;
 extern int amdgpu_smartshift_bias;
@@ -1022,7 +1021,6 @@ struct amdgpu_device {
 
 	/* jpeg */
 	struct amdgpu_jpeg		jpeg;
-	bool enable_jpeg_test;
 
 	/* vpe */
 	struct amdgpu_vpe		vpe;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4edcbd272fa4..df753ebfd109 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2302,8 +2302,6 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(5, 0, 0):
 			amdgpu_device_ip_block_add(adev, &vcn_v5_0_0_ip_block);
 			amdgpu_device_ip_block_add(adev, &jpeg_v5_0_0_ip_block);
-			if (amdgpu_jpeg_test)
-				adev->enable_jpeg_test = true;
 			break;
 		default:
 			dev_err(adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 60d5758939ae..802debd8d9f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -205,7 +205,6 @@ int amdgpu_force_asic_type = -1;
 int amdgpu_tmz = -1; /* auto */
 uint amdgpu_freesync_vid_mode;
 int amdgpu_reset_method = -1; /* auto */
-int amdgpu_jpeg_test;
 int amdgpu_num_kcq = -1;
 int amdgpu_smartshift_bias;
 int amdgpu_use_xgmi_p2p = 1;
@@ -941,9 +940,6 @@ module_param_named(freesync_video, amdgpu_freesync_vid_mode, uint, 0444);
 MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco/bamaco)");
 module_param_named(reset_method, amdgpu_reset_method, int, 0644);
 
-MODULE_PARM_DESC(jpeg_test, "jpeg test(0 = disable (default), 1 = enable)");
-module_param_named(jpeg_test, amdgpu_jpeg_test, int, 0444);
-
 /**
  * DOC: bad_page_threshold (int) Bad page threshold is specifies the
  * threshold value of faulty pages detected by RAS ECC, which may
-- 
2.34.1

