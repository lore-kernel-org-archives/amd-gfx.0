Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8458EC61DB9
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 15:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E540810E402;
	Thu, 27 Aug 2026 15:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tkb7lZ9+";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BBD710E402
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 15:54:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAvXbF01hNPFnrIVEcutYLUwt5nrhNg+XOLijspaPmC6vYbKolZfn4sEs6Vf5OEiQm7XcMKkkGEtc4CdDNZFrz8KWnyex1ULeP9RtJs3xu4Ow+kntsievz3AWON9X6w2EHx36RKPEyCfgpFqgu+zNONZ8UncbxwKBbDQ9s76M6McljN4zshsfsrg4FEzB7vBRRbBw6DN/I19XSF2oTq2dtgEmt8JImkp5Ad32u2r2wpRcLaoHu5C1j8CI1OTtgMMsttRUoNqWFNXAr/DWkiTV1e4gMSW5PUnlWjULW6xGmo+QXGpVaXzTVHjlyRv9vdmPE8lGxRD62fY1D09g4d++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtojpD8JCUIoAonh+8hgaerLj6VFBpdmA0nPGV5IxlA=;
 b=PwX8fSJ9DFxXR2M7+P2Z8lzKWPihqStUAmHrKm0spETFSssmaLJdHKmsqqFbvOVQqEbamlLQi6dOM+dXabvfuGNWnPHaQRUIEnT/A6hnZl/Rx+MdXau2ejOOrAQyhwARAb64YJeeC2Jd8L/+P4wCpjtMizDbZsq9Uao+4dOXzaPLIhIOgqTlBaEE3mWGyl/K7LkzW5T7D6rfPVbZZceX+kQ2vBlIqQKPhDPk7IQl7Xw3+2rpVqIMYFEbtKYfnVSNiuxBV67NrguUvb6jOSEMGqnSx76ITBi55MiYB+1o2JT9rROUYerq08wTQAatsKqriYHAlUzLIZP3zfJ7vr4XOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtojpD8JCUIoAonh+8hgaerLj6VFBpdmA0nPGV5IxlA=;
 b=tkb7lZ9+rhjdh85EauWU7O8u5sexiV4y8KCaXZoOxhJcHtnwdgrvguUa20OtWlk2lc2wgKz0HxrDzYgDO9PMLik/r1Tg5B8+zdjs+9VIO+45OLLLJCyGdD85T08MweBN65m69TDdF9w4PQRzbyabUjoHq2JSCz49eVV77pDLDhU=
Received: from CH0PR03CA0181.namprd03.prod.outlook.com (2603:10b6:610:e4::6)
 by SJ0PR12MB6944.namprd12.prod.outlook.com (2603:10b6:a03:47b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 27 Aug
 2026 15:54:24 +0000
Received: from DM2PEPF00003FC5.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::6a) by CH0PR03CA0181.outlook.office365.com
 (2603:10b6:610:e4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 15:54:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC5.mail.protection.outlook.com (10.167.23.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 15:54:21 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 10:54:13 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>
Subject: [PATCH v2] drm/amd/display: Enable HDMI FRL by default
Date: Thu, 27 Aug 2026 11:54:09 -0400
Message-ID: <20260827155409.1426730-1-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC5:EE_|SJ0PR12MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: fe05df2a-6d01-4506-deb0-08df045375e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|5023799004|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 4meLnRVXtqoVU7nc4SFS1CkPWbsLE5Slrh8giQcRzzJSnThvYrCgsdb09mHG0V8ARuXuDRlJEpuvqZtief6ZfGWO+EIsMZlvrvTLuOX5RX7MnJjrzP9pxSWC/jrRg1aN9y/OGgpy0hoqNRKR9D58NjwiORIvavqlArHQx7uBUyqQpJJ4dgQraWgah/WypfEz8TsH2gspLkgaHLIPqlFDHLoX4l6tB0o6/x9ZTjiuO2mCfSrN5/058SQZNdn8YzofmyW8SXA2AVqH2SJyQjj13WAsMvf73ITVIcdI9hZsozy4kXMBRSwgi34ek5UnvRhingOGPzy2LRWNPep4nbRfomUyV5d20JA6SV5c1iT/5vookOwvFBdhBPbvBdNEhR434oaHotGwsuL/kPNbBtTQdlkg8iNCUFStxS7g1L7cTLsoAii9efpa1NYVb3K70/tEyppMpbQNn4KKn1oWRoOIsvRqhgl9pc3zQteUdCl6wt12ml+zwgw/TS+H0kibAcoyGicFffG4oStPHVN8GIAHltpBPBUKzQyvOwnfWJqabcYS5up3lKDbCjpTQHr3Kjqt+pTliwwBuHq0Zy6Nnxfn8NLkI/ZKwNes8TzgUUjoBaudtYVweyO+XjRDuC6lNNxpMv13oHyS6TWavPFayGS4iLv14r09fqHjXw+dUDjmBKh1qb+aEoZN1skR+2tjgBN4ZX3NWgSXMOFm5nGWo4jvcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(5023799004)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RES98f00CRTDVIPIcv6IDyRnmSpSvXVsRdjoCnkev+3YDa0l+uBybqjxs3HNqWPKipXHOajKf9GnEcV69yNrtIDmHxJjtJ3XCmWfSSQFxpO+YqerBO1lNu+imUrMyRfYQUOodfKH1rDT25d6MfEb6OQaKnKcH3DyNRx/m0puFIt+wGKD1YaoKNsQv9pRgjE+Sj54xiuLuyISmSJnC83M8J/6tDmlQXSC95gQAEj8W8qKZeREp/RRLcBneTd1ZPQsk0Khz2OdzYnGMsKAU7JY2jb8Mxf+J4BX+tZ3P2yjVh8TkADcX8VEbLFhsLcsiF/aJMzCeAQ+Z2/u5y7++1DaaIliE+Qmsw7THxLqCkVijXBm756unNbDo4//6HwLLR+Kux0Yzi+a4tkhKRupGlJpFm7hpZliXY+U6u13wPWePaG6Qz4qVVwr9n4uxe/3GTLQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 15:54:21.6030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe05df2a-6d01-4506-deb0-08df045375e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6944
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

FRL (Fixed Rate Link) is required to drive HDMI 2.1 high-bandwidth
modes and is broadly supported on capable sinks, but it was left
disabled unless a user explicitly opted in via the
amdgpu.dcfeaturemask module parameter.

Enable it by default by adding DC_FRL_MASK to the default
amdgpu_dc_feature_mask value, keeping the mask semantics unchanged.

Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 3 ++-
 drivers/gpu/drm/amd/include/amd_shared.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 53738b40c97f..9c2ff3e147d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -218,8 +218,9 @@ int amdgpu_smu_pptable_id = -1;
  * DISABLE_FRACTIONAL_PWM (bit 2) disabled by default
  * PSR (bit 3) disabled by default
  * EDP NO POWER SEQUENCING (bit 4) disabled by default
+ * FRL (bit 10) enabled by default
  */
-uint amdgpu_dc_feature_mask = 2;
+uint amdgpu_dc_feature_mask = DC_MULTI_MON_PP_MCLK_SWITCH_MASK | DC_FRL_MASK;
 uint amdgpu_dc_debug_mask;
 uint amdgpu_dc_visual_confirm;
 int amdgpu_async_gfx_ring = 1;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index e3baef809cd1..7e29fe312ac6 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -287,7 +287,7 @@ enum DC_FEATURE_MASK {
 	 */
 	DC_REPLAY_MASK = (1 << 9),
 	/**
-	 * @DC_FRL_MASK: (0x400) disabled by default
+	 * @DC_FRL_MASK: (0x400) enabled by default
 	 */
 	DC_FRL_MASK = (1 << 10),
 };
-- 
2.53.0

