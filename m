Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC15C55173
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEE2D10F40E;
	Fri, 31 Jul 2026 21:16:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T2HFicuk";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012000.outbound.protection.outlook.com
 [40.107.200.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CCEB10F40E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaB5oXVAQ+1rdDNqC6Pi2ca2l+67pUZg/oFlO8sYXK0oDu5pqNGmR3DWtzTffJo+Biyxv7hTOkZRS5smjZE9XeHo8eUXRbiIGlAJIrkvFHe3pnuWeZ6qGxLxroQYBo6xrGYSMk+c68Xhjy3qvc7DtfvAWItSB9JeMOU3/ZtsjuuSr8HzJcSnXFVPFqTCH5lKAGaoXeR7I9kUICbs/AP2XcLqTJc9AAQeaR9Bh1n0BKUeq+syRhkn8O3M52ow/AwWv1w6qw1G223Xdu4jjaoLUpPrjwZoz0sm23BGvlPIjxVesIfq2eh9CBpznBa2bnFEahlJMrujTI22zmyq8+TTvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxlcWQP/gWTpgIEKSU84Ks/41iBoSYCWIBFafqzCQC0=;
 b=vIYMAZ+XJNOp1mIoM/j+iP3kAMm4RD5zcZnE+AKli5mFsoCLgDi8zXx7ybbpwz5mjIheMS6Ne9PS+PjDYnPZenfe/t3DAdKV4SHycEQEP/kXSzmvxRwW+EpZtI8oo/vzctnIEUSwlTgozFbH1lnWb//GtZhtXgw89ryFgHnx4C9M6WqxjVRsNJzni+r3UToTrdZ3T13jTursyvKGF+fLdbhDLK+Cy2rM+XHNHWmiyHfIYdnnMzR7rkljEi1HJN9C6gWMPbscs0cGuaVP75ISQ5M5n7sPyq3L1YG/NZZfgCH1MTFcilIPsZtq2VE7ipxm+XOWKdwralUPO9gm+yfLHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxlcWQP/gWTpgIEKSU84Ks/41iBoSYCWIBFafqzCQC0=;
 b=T2HFicukz4Z5f3ZBHiyfY5knHpxYecGTwI+HOGlU19GPPufGSmRIaG53BWfERrcfB2TnZH42eBpQKZShx7LEKPSr/SFtA6C46oE1PdTawB7ItaBd0e19SuAyqMHZUb7WlhogGq8yK+W3tSexXob6Bf447Fi5i4JKjtHWs/4cBPQ=
Received: from BN9PR03CA0912.namprd03.prod.outlook.com (2603:10b6:408:107::17)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 21:16:25 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::a9) by BN9PR03CA0912.outlook.office365.com
 (2603:10b6:408:107::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 21:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:16:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:16:24 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:16:24 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:16:23 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 41/41] drm/amd/display: Promote DC to 3.2.392
Date: Fri, 31 Jul 2026 17:13:02 -0400
Message-ID: <20260731211302.3040343-42-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 17dbde00-9763-43c3-870f-08deef48fa44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|18002099003|22082099003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: RVf7EdHWBZneeS6SPKth53iRVvue65NUuYZWY9jBkW6w4Di912QROWaF9+PD1lc2b+OZoXkcCKwviy/OXHJgrCf6NaVTk3tJTPOTPO5PlMIvrfdKU3UMpCDBwaGWFwU7pbHoxQlj3uLSjSWSZ3m9GgEhmVPA+IDkWmxEENiItSzoMbQkXrFACMDZjtu1/wpOX/qdLe+5CiC6vzTJSRQIulRTHJ/ysRDFIhVkq0jMVaKU2wB2toi4ej7MiWPawq+B+tM8NYnuNmox4zosHhMI/CtB2ARIEJnom0ww1w3uC8niitHYu47Gc4jhodL9DbGhHXF3tQSVBNV0Eo7D4buCmmtUV6xI+YugF2ye87nbxrFfWEEbOHYtAohQJbskIJdUs1jz2XtF7wscGEK6bDIMloactMbot7jcup+WhyqUFg/FtM/xoussLC5m7H+XtVt3iNi34zq9Mr3vFkYOkysewpU822oiPJbpYTCAvnQBJPgHSI2A8kQ5n7nFcVFFg7gGAqFxc+DxrVU3+O21Oz7LNSw8fAY0pQBN/91Ct/0TEJII7aRfrW4sHAQNJaWiWqysr3PhFAM3WI+X8q9jR3b6KwsNZ//bbEzFLowR6O0DYpNtpf6UyXE+Hc/1sC8clGJiNDRfDiVyBjvq1ARxbFcWlBzpXirBQqIZg1b+6iq8kVAgC2aTs/f9/f3rICjjYxtHCXR2amFOGhGTW0XNFMyiJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Awkd7yky25i8vCUDHGiaiXZ9U/8GIvAihudUXc7CgJ7f/REMFQM0hf3bXcdO6H/Chi239OTE10fo0K3aW0N7lp1lDSvnCJ7jpJ1L72nKjY7zmtZyYSTmQd7WwfLfznOrWEky17qJTLFaeL0nnPMCOHWscqBG/Xhq8PXKsMKL8v93tVDoRSJiYaOYE0kSodcc3NQPpev4MtcnsHyPcBNMLeYiEXbpZ0hDiQrO60s3/CdPIYcxPH2nQVa4fUe6xhksE16xHSt4Wg1XjMAf7LBILtjLEx0NpT4AK45CV/QhVhrqVWZU1ne4aP5UJlQO5/BL2xPa9uKd3d7Z+Sr+FqfzEcaccvIKKes6NQNwb1MrJrBm9Lb7hbPA5OEglLaF8/6tP+vwALDcbp4YOyrlJhi2oDfCkPX+U8GriHUnD6JkTRLtqCuEm4ZIabFmw1A6jQua
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:16:24.8224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17dbde00-9763-43c3-870f-08deef48fa44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
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

 - Add KUnit tests for crtc functions.
 - Add KUnit tests for crtc functions.
 - Add support for dynamic FFE levels.
 - Configure all CRC engines in pipe CRC source path.
 - Enable DCN6 compilation.
 - Fix ABM over VABC.
 - Fix CRC engine 1 enable/disable on DCN3.1.2+.
 - Fix MCM blend LUT issues.
 - Fix seamless mode switch not triggering for HDR to SDR transition.
 - Fix wb_info leak and NULL deref in writeback.
 - Increase fclk change latency on dcn351.
 - Refactor stream validation.
 - Resize MST HDCP per-connector arrays to 32.
 - Unify force_yuv debugfs into force_yuv_pixel_format.
 - Update VRR info packet to support 12-bit refresh rates.

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b2fd3a94f067..705c500ad711 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -66,7 +66,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.391"
+#define DC_VER "3.2.392"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.34.1

