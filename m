Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB29C55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBFB510ED18;
	Wed,  5 Aug 2026 06:42:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gBC9bJmI";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010039.outbound.protection.outlook.com
 [52.101.193.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86AF910ED18
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:42:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRFTNZnQABfANDXeFU00G5Ezcw554+5xLW72uTckrbLBwe8phrg4sDknYwy3ugxVT4eQpMwfnd4JuLnBgW49acPMmiBdZHXZTfIILLG/T+5zJAGqWMaiVbHfUR0YpukDuo/wLucWWU73EbCm8HANrsUD1sQRCbMHxso1YGUTJCAfyqeMw3dnGCh8qrzYbyerHaULJHc/yW2Fl17fX6KAw8aHkCQLlvi4rgFoNFkgDFxSvuvVNpYYAeb839HQMYH7V4SqQE3Dv561XkGrywXRbuOorimR9coVh2Weneg3ucAJAOitm7BWO6PRTY3jZKpdeVbJMwt09WcuYZlRcuvVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VpGds8EdJVnpFIfwNZzXUVVgEuR/uq3r8I/1sZ4JHs=;
 b=SAGsJO2eV7izxF4pRlWGEJOimGcPyVA3Yms8CT6Lem/wrS/miMpLXUe2Tom9tvYT0lk1JIRj8QcGuI/nP1iWKacc5qt8RrSHPydxe2JvxrHZ8hYbQFRuCWkN5hYDnpW5UTLtycio3FxXm7kK0zc5Po4xDUrmi09oUWSV0efkRqfFf6J6Q0t1expnPkepWEhvNY1onXnHUR/PBMrB8SI0W2nAED6I3/3hDXlFAmehLNsGRfKjpqzyufPxIgsRPoP6j+Cr2J+6eOo1jNXyL0WHAUYQLKiv6t2lSLV5y8o8g/umMfQXlHQw7z/2JWQXspq9y6uHYWGNDx95YCDwJdrUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VpGds8EdJVnpFIfwNZzXUVVgEuR/uq3r8I/1sZ4JHs=;
 b=gBC9bJmInA1znWKW3g0CGOohP5mEX589v1IODAzJ98dTrcqDYpa9PwqC0BnetHobJyRvJlJzU2s/SbuV71zZe+lPBdhvLK5G0xrUyengpfMSHv7K9YajYss5qBCmFl6NBJgOtnO5VaovLg6V/BidHdTZrA+ff4OZsosp1f2UJ9g=
Received: from BL1PR13CA0091.namprd13.prod.outlook.com (2603:10b6:208:2b9::6)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 06:42:12 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2b9:cafe::4f) by BL1PR13CA0091.outlook.office365.com
 (2603:10b6:208:2b9::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 06:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:42:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:42:11 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:42:08 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 34/34] drm/amd/display: Promote DC to 3.2.393
Date: Wed, 5 Aug 2026 14:36:46 +0800
Message-ID: <20260805063937.2145774-35-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: f187496e-760b-4c15-418a-08def2bcae39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|11063799006|22082099003|56012099006|3023799007|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: zNswrmackDZpFDgRuYAFuScPUOrawjQqMF8MoGMoITC2F2VyIHVLB2NrmZq1GYRMiKVHX2izNcu5gBkhdQO7ylytDZ6J2JipYO33c9IsZ190NZ1mnnTD8kaodPUyRKs4yCI2z+5IsAwuofe2masMHRlPV1d2uXx4hvR/41dTM7lyyZDUY6Oi1g9DOug0SE88a5cU1RM7mdfR6XzIQvbhgHGNo70j2xhG3NGVXcumBuxKejOC+3t83QXukiygKwxhcPzqXvMvK/GFwUVlcoBH676V/gXM9Tc29AsDM845uGZeSdAeqicdhHbPzT3sBCkWvizKbwG8jpM6V7CRcxR5n3/3mxkxeyN6vJdZ5BUGEo1c0lYrbrUVczUWOuSlPNCVXDaYeznUd7Mi9gWMeCsjjc0o8QRkW7M13GKp7451qmPeSmw4AqA4Sb1pL4VzIsg07vb5U6+8lbvc2jX6AYF6j7p8GeILZzhWbqdo+Xs9LCD6zagP54opJUiSHfatu66SHZTBZJNboQk5U+cHYqSMzNPJPm/mhRyUC8kElfEcw2Jd+Z9v5NHop06P7ER0SV+D4pPcRt3kb/5JfJH4JBo6gXAMuN/2Rx4voMRwKTlrMxFFvGKioXqNug6FPy+7GLRVbp6/KL04atg30FelAScc2atkm9dOBDbxrTXk3JJcnJKfuenX1ldk/AjD5ru3c00e9gIHFLR+/vRQzkES4Fackw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(11063799006)(22082099003)(56012099006)(3023799007)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zAT+0xvsgrVUzpL3klqs24q7mk/jz4X4NsEu4X8F0d9aQp/FsjVuvsRzMMQxdGBRQMJrcd4emClHFDesNy+32RddeJ7lGvI7Uki0wL3lsafTwktjOEFuwXP3Z2r8TBj2ZJ4Y4lkUyzNx+3OpFsGTiPO+79B5Jp+e0xJSsFesoWNqOTFlcrm1nXf0J/k3RAJYdrWJCZNtVU8UrAINMFEewdPArcxmAa4kV2Hq5jP0+J/ztp5K0YrOG6X+VJ+eNlMOUz7schEvihS2c50hp1UeRh9RGCBjMhWdBHIM3uilxVFOvAM+t2O1IliFITcynYurSmPSRCQTMOH1Uns/Kn7SijJK876jcz/dkGYuYZiffiEmbyPLzlZqPe3lG7R8n122mzh6ceZKJFwpVdjbV6b00jrG12A1sF/9HPmNx5d5YgU0L+wQyiOq14BlFPcx+WfX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:42:12.3512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f187496e-760b-4c15-418a-08def2bcae39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
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

This DC patchset brings improvements in multiple areas. In summary, we have:

* DCN6 fixes on GPUVM calculations, HostVM and SOCBB VM config,
  clkmgr interfaces, and peak bandwidth measurement
* Unified fast update classification paths and inbox0 HW lock on DCN35
* HDMI FRL fixes on LT timeout behaviour and cap restore during
  non-destructive link verify
* Greatly enhanced KUnit coverage across CRTC, VRR, and cursor paths
* eDP panel polarity control, FreeSync range quirk, and Z8-based
  zstate support
* DCE ASIC code gated behind CONFIG_DRM_AMD_DC_DCE for DCN-only builds
* Fixes on HPD filter programming, DMUB DIG PHY wait, dcn42b
  force_min_dcfclk clamp, audio tests, and UTM client QC profile override

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 71d3604b020c..a2f598859a2d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -66,7 +66,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.392"
+#define DC_VER "3.2.393"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

