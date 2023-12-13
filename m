Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0150C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 06:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3807110E6D9;
	Wed, 13 Dec 2023 06:13:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE94110E6D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:13:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAuGRbljkdETtB1eiVqMLX1cOgmWS9QaKW53/MExnrIweULGF3ScyJcQtQbaM9BUGLyqmHBqa5SR4P4SKwxmGztcPC/FlC7QFQOeD1dnlIhX5wNj5xuwYpSVTOrr7hQ3zqkgJk4XW6x9U7SaIhTMEAF0vPtRp5v5fsMidhPz6lUcwnbQUvzXlMN41boiWAniXFvWcqvE4yH7F3gx6GeOsN9Vd3HkdR810tJZsvf8qmarVtZyfI1SOjf/UiJ8hnYt2PgQfdSsE7Z4h60I54nsOUM55MGqucuh/sW1gr+4zPoDX188EuS96L9QY4EUObh3E9vFUljVHSUPdBhjOtBBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1m5Wnnpghdl0FgEWnLAYwUYCN5guSxLSDbn7GHIJauI=;
 b=ArbZKSS38p2j90qgulofhozOr9cOfP1we4wBjWg5XdrUSV7ex9uFb4ap3HTG2oIjc7/0fuBywsyd3EVV0IoCo6+R/xz+SKAtkEmPG2/0aPz/23J/WXSN0EB8d86BiLl/X7nyNBfJNjnRiybNyIF859lo+QS3hpFPsWDvNklVwc3Wrw68vNcDKHXA7QIJxt9wLuF8fz3Uayu62SeQy7VYbZ2drmzu0R1teXY+fW0tq3ZJ2+SB+uV7vTAERsOQsu7984lR8/gTdjGjQZ2HcYoyDux8wtl21dHn2+csgsEbag0I+LUyNANB3TEBDwlCc/fGdGaJBoQgTSwiQBXzV1/31Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m5Wnnpghdl0FgEWnLAYwUYCN5guSxLSDbn7GHIJauI=;
 b=RXNOdUwkVhtGfC/eufaBzjEgVvpha3xdYFQoJwE7H2OwXtPslamxGpLegfIBE22Mm8pcPlBzdByssrhf1bjI4hQmLkifpkfwyfNTDjYgWsNG87Q3p4cs5SS30CwQ1RXq27ldxT/r4/52V7krYwNTVxwFnSigrHPy+faP9eZgG3Y=
Received: from SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::6)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 06:13:28 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::4c) by SJ0P220CA0030.outlook.office365.com
 (2603:10b6:a03:41b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 06:13:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 06:13:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:13:27 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:13:26 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:13:22 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/25] drm/amd/display: Add case for dcn35 to support usb4
 dmub hpd event
Date: Wed, 13 Dec 2023 14:12:08 +0800
Message-ID: <20231213061227.1750663-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ccf2dc5-041b-4bd9-5178-08dbfba29f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QZuFwgAZ42upVPeqbeZVU2SztzIBFZbjRBPoIyJLiIuSdOT5nayy19Bd3iTUIjEQGQSCUUqbD/rwIUynjwgwzW6GvKBQae1YOmzcIFlcLnDJ4APqBJ90Yk/t3qPdJBefIFUt59C+R/H8xLiFdBdc2X3xKJPd/gOUvXK+lWVa1SyRsEV1M+Rhr97WZCLUfojMZDKH4S3/dECORQ/TecZYW6rDZ4AvcJGFKQy2qmgexkj59rV1b59/vrDj64HBUi3ZDfgEMrNpMzyUzUGofEvlBF9CLsz77eV2+kPY5Mx8BkTWCmJigoFMz68bal9b0PXRSyMeI6LsGoDIeAd+17F/U0LiEmkBVxACkYlAfNSomeAdsHp28zsps+KHGKrAZlxcSZJHH9xF2eXL/p5aR2SbsGY6yFBlHbwd3WltrtS6CP4BiH+JfNsr3wY6a9DTzdUgmz2sCMrVgUtW9Dq/yKabbIBLTsZo4br53+p2XWuufQ/Ig5zgNaAbkfbn1arrvO8U9PkhjndAfbILuafnRVApE2A6vNj/YkYNu7pYSsGf/lLs/IpFz1v4/zrEGSzEkm8W4D0JBy2Bf6KFHj8RwsC46fqeauDPNwQTZ7295CRRrRSsse3cGQ5lVm7xw2uIsMZOzoEeMmd8m2Qm3dPLzmmfCCh+MJ2k5OhxDW2emw9x3Rd+l0wgaASffsVv86I3JGecepXQy4FGGEwNY7pktd79sRJ5VSStytsAwzIHLtiyImuwdgyxpp1udQVjx6Fu26hFWjJ65ocRQgkVOQL52Ob3eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(186009)(82310400011)(451199024)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(70586007)(70206006)(82740400003)(356005)(81166007)(36756003)(86362001)(36860700001)(47076005)(26005)(336012)(83380400001)(426003)(1076003)(7696005)(2616005)(2906002)(54906003)(6916009)(316002)(478600001)(6666004)(5660300002)(8936002)(8676002)(4326008)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:13:28.2811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccf2dc5-041b-4bd9-5178-08dbfba29f9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com, Jun
 Lei <jun.lei@amd.com>, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <wayne.lin@amd.com>

[Why & how]
Refactor dc_is_dmub_outbox_supported() a bit and add case for dcn35 to
register dmub outbox notification irq to handle usb4 relevant hpd event.

Reviewed-by: Roman Li <roman.li@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 26 ++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0d42074f33a6..445f87fa0eac 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5089,18 +5089,28 @@ void dc_mclk_switch_using_fw_based_vblank_stretch_shut_down(struct dc *dc)
  */
 bool dc_is_dmub_outbox_supported(struct dc *dc)
 {
-	/* DCN31 B0 USB4 DPIA needs dmub notifications for interrupts */
-	if (dc->ctx->asic_id.chip_family == FAMILY_YELLOW_CARP &&
-	    dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0 &&
-	    !dc->debug.dpia_debug.bits.disable_dpia)
-		return true;
+	switch (dc->ctx->asic_id.chip_family) {
 
-	if (dc->ctx->asic_id.chip_family == AMDGPU_FAMILY_GC_11_0_1 &&
-	    !dc->debug.dpia_debug.bits.disable_dpia)
-		return true;
+	case FAMILY_YELLOW_CARP:
+		/* DCN31 B0 USB4 DPIA needs dmub notifications for interrupts */
+		if (dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0 &&
+		    !dc->debug.dpia_debug.bits.disable_dpia)
+			return true;
+	break;
+
+	case AMDGPU_FAMILY_GC_11_0_1:
+	case AMDGPU_FAMILY_GC_11_5_0:
+		if (!dc->debug.dpia_debug.bits.disable_dpia)
+			return true;
+	break;
+
+	default:
+		break;
+	}
 
 	/* dmub aux needs dmub notifications to be enabled */
 	return dc->debug.enable_dmub_aux_for_legacy_ddc;
+
 }
 
 /**
-- 
2.37.3

