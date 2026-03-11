Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE09FD88F3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 04:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E33F810E2FE;
	Wed, 11 Mar 2026 04:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V5TyonO/";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010058.outbound.protection.outlook.com
 [52.101.193.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4213710E2FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 04:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKMMxaASi5ohrjyDXY8s+asdOisYMFCGHQJGotutV/FNxKmr9laOq63klRBra23/3+fEGQ/dzN4WA9bgwisJcvgeu0kqWd7f4ah5edbMcAFn5MgNCxvuupTnsvdK2IV/3T3Z4SdKnXG/s0D0uCxaaL35/siPrXiuVBUmHrYZGduTX0qpzl7j4JWyddqNOJKJM1K7O1bf87bT6yApXhdZIEt58//LuUZp5Xlm1+HcwCdk556jIgbyHyGteG6qdaKZL+dykrIf74NLjLg9Y27fc/kNSeCTJTtasghl6BqAp+QGo79qmjeNUmhhRf7uyN4YQ2/uQHr889JzYvCMswZhhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkoFOUx/HUhFvnlBAM10/P0MOwGxP9j43+RdFOSGD5c=;
 b=TJV52ZtkSQHYhFOA7jPiSPnjTkSzzQjdk5gSK1csKcsW2O2ruQ2YRkR7yMrL7Yb/luiD979fHcFrEp8hqCbMDJepc49w2fPfhJcI2IFbe8Vpn3phWGTA7DxvcxUJ+YCs4gkDhHET9R5n8a7GB9dSf4PG28yYXznchTiFNZ2I1RX6BVqtE+uSwoHWq4x4oecqdGcvTsJQkdDkyapIfOQKpBU1nmkGKigm03MJATha2/dCihi7IYcvMWXgOZMHSFy3aISuBVAuICAlb5FlkGb//gBhCNMwSDINVb+rKyADw7Nnzi2gMVXm0m+PKFGTvsjhWJEVWlg5spHO5HbiVqoMRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkoFOUx/HUhFvnlBAM10/P0MOwGxP9j43+RdFOSGD5c=;
 b=V5TyonO/T44wchhrJS1h1dIzGfzqDta1FKitS43iSjoGeNuYBncE5RYv02SdmNWkojW64IxcJ67QTLhswQ3UX640dGa5idLCF4T8XbPtSnZfKZRP77lZR2R84MC7HeOj9pnu9KskYHLxOtucLpb+/JnC/bERwZVSwDn3bl1Pf5k=
Received: from SJ2PR07CA0007.namprd07.prod.outlook.com (2603:10b6:a03:505::12)
 by MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 04:04:10 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::52) by SJ2PR07CA0007.outlook.office365.com
 (2603:10b6:a03:505::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 04:04:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 04:04:10 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 23:04:05 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Chuanyu Tseng
 <chuanyu.tseng@amd.com>
Subject: [PATCH v2 9/9] drm/amd/display: Promote DC to 3.2.374
Date: Wed, 11 Mar 2026 11:33:04 +0800
Message-ID: <20260311040501.2693643-10-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311040501.2693643-1-ChuanYu.Tseng@amd.com>
References: <20260311040501.2693643-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: c2daeb6a-c1b0-4b55-60c1-08de7f233fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: pjIOVhhcoaLbeE5QhydaPLYfMqSodDwlGR0wuRKT3NdE6/6GKBF1riusJuwvce/d7VMkQ96tg4Rh6DIc48WfvsxNNMEK4I5PSuTA2c3A49ErdJ7xWVTB84suZkBaRL94CUI7vdgly2y/GaNyj+8wZ4I2hxf74eXPC67CR3NEtNf8P4MiTC/Hze881IClsHIwKG6lAs6Q9BwX1rg5q9pXkhhFw1p+Y0Eqkc8XOhGaIVaL2SdlrU3xqduqWjR9pKfXFKPcjr2brqONdeEzzcx8UEK6p+xCxnIRQgKImrQlPAv/nypS451SwLMWpGalPGJJSjBWaYxS6e2JAih6tlN55qxb4aE28bTtYrVKBb3rJcSqjqLc/kTDlG+tyUbT3nqvQ4h2Yq853foQGk+hrOek6dpfolWk5gG3WitdB0tUrznRUHx3u1ayhs5ZOHhO5CNmROGX1vpWxgLjKyQG0bhuFdW+KtNSdkQYaWW2ebkJ+zK9EzlY/lkZyaB21xt2R8SXTQyFcfqm4ynsEJAq02foR6x4VDWYFT5zkYEKogxDHesBOvdy9wrccLuTsMfbNsroW5sGUNu50qLUDLHf+UgpKTkK7Pq21xJ88w4AMmofqA3khP1UrGKYbUddldAuk7ZIWnuqn8jFmbmD070xYUzDB19WlxoeCHpVK7F+NhtfwuixPkSTzE0bp5w/eGnW+Js39aqnup7TmX+8bq7TZzfJZiazqE7w45FoBXc4HbKUYJ7i2SHfl4CBckJrDnah7P25TCDt64wwFaIU1jFQfnD2Mg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9VcvwiCUsX7LvHkA7lU0vbjGF4ucTgmw+0xOM0zPKEnyAx0h1D2dqeyxFDcIhaIMDWovinocd2rltETOHeX7lKz+J0+dqQTjuTNg/ZhsFMfmt8+n+OtUqjmDECaUI+SOWIY6g20+d5/0eOBH2VrFBaq7qcFkhdP+Ox88KNS3nG32/R+XXdb3r7Z7WERJwshctPFm/QCwV8SBayDm/5ykH7WFY18XyeFxn+iDV3r+dEm1/gUhWCGTD0aKDlPXdv4tl5bom02zPRgKSTO7MZWJyTZ7UrfDdmB4t/aFnmCDMlsUMZTLvWePI2q9TsskQtxVjRODxO909hEzXcnjwpRhGqsjDo3TtY1fjSL1mlRTvLwtTye4B7QjqdvvEiHfBa2rjPujuSacqv+v23FJOW2oBAHnNagJR/kR+1HtySdpn0hnlCpsIajFDY3LXkDF8R2E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 04:04:10.0121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2daeb6a-c1b0-4b55-60c1-08de7f233fa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884
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

- Clamp dc_cursor_position x_hotspot to prevent integer overflow
- Query DC for gfx handling when setting linear tiling
- Add a buffer for boot time crc
- Silence C6001 warnings
- Plumb MRQ programming out of DML for dml2_1
- Add dcn_mrq_present Field
- Fix number of opp
- Add debugfs to disallow eDP Replay entry

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b232de04a797..02db1a197d83 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.373"
+#define DC_VER "3.2.374"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

