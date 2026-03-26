Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8A5109E542
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C2FC10E948;
	Thu, 26 Mar 2026 03:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2vEpeW/f";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE7910E948
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:03:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlu4eUdwixskLAXy8iGdiG5ud5nL3to8u9LMpeRVONdkoU+ksQgrq0WB1bau5thAxeYqGtBgcVB9O0Tf+xl5GWtMsvo7nZh4dhyvhmVzUc7aBkDgJm+XsjaY2rs538PpEXkBO6AapSOxtFzsXBVMtrHrulhJkcKlDskPtoclNY8LRyrzjyPOWlotsyuSDc5Rx/6MD2PVSeUqph1VtaFb616EocWIXPzV9O16kYxkJFWLQnMn2Bhf4n1XEZogbIRXewTlEcNTvLBGRHKJpoyL187IBLVui9hRV7Jm5BDoRnLNQc1QGx8pJ5LNniWZiVqAPjmx41vfD5va5tiwd5SKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZF+WRRrP4WOs5AY3dPAONNW9PM5H+pJNVvplbUrhg1M=;
 b=IxY9GNSwq1Z1ZIVWp38wST5uvMJRaI7aa7j6ujCFh3gEnnseEHeP/eSLBktz8Ji7pD97BZAhnFsKWsIBG0iBdFj34Vpl9ONfiX8CUxfBbZW86rG3Gj+7yndDMO6MNH2hGxb+TaV7QYsVbTG7taMavuDBTzlAESWdfsbQzV5q/9tdvVzXkOA9ThuRAVzMMxrg9rqK3LAb/gBcQDfquK5Ap+KMZkbqGeazxFHQwsUE6KJDuF0RmterzvttDuNufTs39JyT22Of+7tQ9TBMyBDFkZo/IRQeIGxN703T+IUEleR46ZYhX71zKrE+hPV6ip83qOLJSgJeKOgdGp5d5WBsvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZF+WRRrP4WOs5AY3dPAONNW9PM5H+pJNVvplbUrhg1M=;
 b=2vEpeW/ftEooqXGnPzF1s93rc4A9uaYne/QoOKRxcRGZSrkoyGTa4AxOLfgi02lij5x+tvIco6Lxtb3XJYMEMuhuQERqAmDn33tMkRiCLvkI/rWzTguL7A+lvFZh4vcO0AM4DQqNgPWzt744qnZYJGDJeMK8hIWtGII+kCVsrP8=
Received: from MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) by
 CY3PR12MB9677.namprd12.prod.outlook.com (2603:10b6:930:101::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.7; Thu, 26 Mar 2026 03:03:01 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::c1) by MN2PR01CA0024.outlook.office365.com
 (2603:10b6:208:10c::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 03:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:03:01 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:02:57 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 30/30] drm/amd/display: Promote DC to 3.2.376
Date: Thu, 26 Mar 2026 10:57:21 +0800
Message-ID: <20260326030153.406612-31-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CY3PR12MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: fd16ede0-7ef7-4082-4d64-08de8ae4312d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Ow5SkXw1RrK29DZZ67UTY6EepRUpyUbQSxbF8JzHBVavKTVS/4G1oPCb4zpe/fGzSZAmFG8PRwmsOSehmneurw5BTZ7acDLpJbTRKu3D6AE/y6Hj4cnC9Pd3WW3OJc7LvBeQ+4UWafQQ6MEXei8cyMs5YgbioZSYH9xdgHin5qq0KTC3FXwBg9EI2imMIzwYxaKl+Mczn8VXlPuiHQhkpxsUkxeC59x+VwccejLDBK7T45W1jQFqUrsEME5O81lWqBoalA42VcsUgy6jaF2TjmXlqM2+0HMeBllEU1iZiCzyPiCdrMsOQZxOLi2NiPna2p1JuglBnRr5Qqa+YiCOpxnrv82Km8SsIxxitH4TQl4tE/PnWNuQTVuw95I3EXYzk566C32WYUqdRWMq60U5/5mifSawFm1JoI2s7F1frDn74x6X5WtCYlDcXiJTFoGz2RlD24cLUefx8bOQ/MVFoAn607J9nzQojZwo0V2PfW89ySBsLUx9AY+hp4wOvsDtfTbaIOEDXzbJhr2l5VQVQsWQQrUHIpU3o4QTPjZ3tu6NzoNz9RV/qgpKjbIpHSJO+WrOHxCcOc0KBJSMfbrW4V643ok2DSbbqiQa0o14oe3KkCOQRo8Qeb41c7JM47rBK4jMUy8JrqR12lPTbk5r7kMFdbnmjy/a539Dl66gpmaes8ZK/aB0/dPwAEJ8HELo1AbeoGc5RLKXfsQZSQ7W23QI8DKPh7+at3INWdMFG7vB8uldB91To/q35fcl7fR01FgLzvSrXfnvcEqgBUb64w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6VzQOiWYqpSf0aEWT9a6pZy7aBPrF4jh7s25DG0YSvAeaZHPoyUgDj3cn7VCdnPVs1s3lK7LvaUP6oTyKZlSEQ2dctHUDKmBxfcS2AOvNwXY5ib2EAF/ZAyTtRYczNEdvSBXJ5mlw6+vZ8KBMhN8d8LOlbDQELkuISkApzGa99wdgtHlejprSeYj8GRWujyJU2c1tgG06d4eIRFrKgmlfxRyDRoj2veKoqpEOUp6l1H1PnLas0NSbJkfb6sPQugwNkaYJMSDOJ73PaiOJ7hZYtjipi8xniX6jPMubtcJdHpZrlObKHF/4pr7flFCtDl7PX3tUN0TfjGSdXHp0OY183ciAkQGPxrvybo13/70J0ym6HQYKyo9+HOuKOJ1RBsYnfLnrASmwIz+jTZkyqmXrDPozwfFQ7pVXGzehxlJb7By/fhAQGi28XmTHE/xSkHY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:03:01.5049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd16ede0-7ef7-4082-4d64-08de8ae4312d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9677
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

This version brings along following fixes:

- correct unknown plane state patch
- Revert "Refactor DC update checks"
- Revert "Add 3DLUT DMA broadcast support"
- Remove invalid DPSTREAMCLK mask usage
- enable eDP DSC seamless boot support
- Revert "Rework HDMI link training and YCbCr422 with DSC policy"
- Disable PSR & Replay CRTC disable by default
- Fix Silence Compiler Warnings
- Add link output control for DPIA
- eliminate clock manager code duplication
- Don't set 4to1MPC config dynamically
- Merge pipes for validate
- Fix bounds checking in dml2_0 clock table array
- Avoid turning off the PHY when OTG is running for DVI
- Should support p-state under dcn21
- Enable Replay support for dcn42
- Remove check for DC_DMCUB_ENABLE on DCN42

Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index afc06dfc161f..55ec281db3b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.375"
+#define DC_VER "3.2.376"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

