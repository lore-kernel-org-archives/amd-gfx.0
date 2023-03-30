Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B040C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 08:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A29010ED4A;
	Thu, 30 Mar 2023 08:59:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CE2310ED4A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 08:59:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8jUGrIuLqu2r9RYjomn9lbigzdOzZROTq7yo4udPM0Yk4i5KKEhOkPMBt+IayU5nGi80WhG+gVGFME2ZFRuSgzOyLppRmhggh+rVYdVD9HCZHuK9OiAAoE4RMig5jALsrq8jdCdiPzKMjlQa9wTORFTC1e8rv9XuGME1Dc1eoOfzTatB8Uzubj52JbnpBHU3nOI2pyuqhddhQOqVPu/ItY1FgSwmKzUjVwgL+R1enfaPfQo/PPVquMsUL3qs/D4kLjSzG4BVrDq7L4xsFdiRHXDpY2L3aDb7GHbygQZ15CS79F6Ucrbc9vX0IbuhcoZn69IR7/YvFLTxbXbQx90LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q34t9Rb0DvnTDy0RvTHNRFE6iMfwtcIqVV/5Jirc/ds=;
 b=TJPodMODiQOl+X2xMO++LSh+8FAEWamhIJn5k6kPYehjHLbA6vGTmUJHp/He7zE8ZSbzSdr2bpAniogP24tXMvrSoo/yNXi62aVJ74wJ9NupV/zjUJzvbwTxLHzxSyJEffBKZxrIBcGJR3Rck5PN/xvV/sGh5RmiyAQwIckrAsyji9SIb30ZiRrXtEHChRLkaM4wApaXermEsGrJ1vdXCfXK+zHi7YwUrv+0FohsivpHSDRmv/0SiZn5QZXb1eVAZDNERgWEFBj3jsjpLGl+ullgQuYbkDcRdKnm72gMTejhqufRsVN06Sh3jUe9kYU5hGUa4ZuBEqOUKAuYU8Q9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q34t9Rb0DvnTDy0RvTHNRFE6iMfwtcIqVV/5Jirc/ds=;
 b=iGdfsPxRPD/B5Hl4FPwAMcOvTH3iigSKTv4rs+4HxmNLC7zuivri02sg9UpFW4YQKyl2NgMfLueUpwi3p/UEXnCIwK/TxMvARoZzF0kMxrF3eJ3BFeEY9IOJgYLld8RpvfkEH+iuVCmm6OBs8/8kzQiYXyfcm36XbK0ZxiTJpEA=
Received: from MW4PR04CA0334.namprd04.prod.outlook.com (2603:10b6:303:8a::9)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 08:58:56 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::c5) by MW4PR04CA0334.outlook.office365.com
 (2603:10b6:303:8a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 08:58:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 08:58:55 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 03:58:51 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/10] drm/amd/display: add scaler control for dcn32
Date: Thu, 30 Mar 2023 04:57:12 -0400
Message-ID: <20230330085720.3863-3-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
References: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 7780efd1-9d6c-48cf-2ff3-08db30fcfe64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BfEcmgCbiACBk6jqOXZbTqcVyDaeuANM7RGv3HVuZ0/AKpDbfCI6TK3uRABygaLnteMGFf5T/y+GyUfc0cRRrKRcVPvWU+/4nvqtZ0lFBtMcd0h+DwEseQtpB7ZJue8BBSYJgYENslPSfwFxQBsRdJJtXnqbOGc44eI4P/LwkQGasleEoW+pBghVgAmOAUMgR1BMD3eejiBeJotRzASWVWasHo2npi6BP6j7YmCmZorewrKT2bUT/g2VnlAcqK+rgYpSaVzwOpMTeORWftmIkUxPWP35sgyXVF8mb5mDoqqVB+oJwVnHB/W4gXn1666CehysklSRqzFY05J95a2TuzkI6G4sXxXzzCnx6YdBRLt2LF443J0BLVIri5fhbrnCDVbFhsfqKTPshGPrL3EW74ShQ+SXrDeg1zaVbolbi7AnzxGhmrnGPNOH+zHuyjPfwT3ECKKBDV2VpLEsloPo+F5amh6p3RR0o71j2XdqfTDs7Ydp9iLTDxdj8ZiVOgrhQz6NKEyw1Cr/tQd1B/N7VP9JZ/ompz3wMLxlazbmjUa2wB14gdKTe5z3okZdnTfpXYdR/dxuVaSy6ih5GZyIjEYQHHPrzhA17p/5Rp/b3AKZQ5Cq9LE/0v2hMtxKhFCHCihh734TKMJkao+mLzmTNSqJvcy1wkvrb/qTMhXlV6cZPZiTDpiowyn146Uv7KfpNgj4VJmNIQBZBy3lhO7hbINHiAT18WeW7hLsFC0dLh8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(2616005)(40480700001)(6666004)(316002)(54906003)(47076005)(426003)(83380400001)(336012)(186003)(16526019)(1076003)(40460700003)(26005)(82310400005)(36756003)(86362001)(478600001)(8936002)(5660300002)(81166007)(70586007)(6916009)(70206006)(8676002)(82740400003)(4326008)(41300700001)(2906002)(36860700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 08:58:55.9365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7780efd1-9d6c-48cf-2ff3-08db30fcfe64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Zhikai Zhai <zhikai.zhai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhikai Zhai <zhikai.zhai@amd.com>

[WHY]
It will introduce the extra warnning log on some asic
that doesn't register

[HOW]
Add the register on dcn32

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Zhikai Zhai <zhikai.zhai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 10a3350376e4..3f5e92ef0c99 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -472,6 +472,7 @@ double dcn32_determine_max_vratio_prefetch(struct dc *dc, struct dc_state *conte
       SRI_ARR(OTG_H_BLANK, DSCL, id), SRI_ARR(OTG_V_BLANK, DSCL, id),          \
       SRI_ARR(SCL_MODE, DSCL, id), SRI_ARR(LB_DATA_FORMAT, DSCL, id),          \
       SRI_ARR(LB_MEMORY_CTRL, DSCL, id), SRI_ARR(DSCL_AUTOCAL, DSCL, id),      \
+      SRI_ARR(DSCL_CONTROL, DSCL, id),                                         \
       SRI_ARR(SCL_TAP_CONTROL, DSCL, id),                                      \
       SRI_ARR(SCL_COEF_RAM_TAP_SELECT, DSCL, id),                              \
       SRI_ARR(SCL_COEF_RAM_TAP_DATA, DSCL, id),                                \
-- 
2.34.1

