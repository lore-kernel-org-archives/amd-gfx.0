Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A04C2BA2B
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F17EF20644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ye9lhrd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17EF20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20FCE6E210;
	Sun,  5 Apr 2020 20:41:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB886E218
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:41:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+MCWZ/9LLxAAVMbvJXVQVYiPCo0OUeqRaajYXDwwkGAK2RUpl1Eh0CZD+QGTqJ/x9GSCl709evRRxY86z5g0ORrU3rSFv8sFVRXPyq9pxKRzhBH+LDgHIaa8MH1EXO4wOjLOf70GdvoRXO+ZlAk8OFy0rWuBoi5PmGMiCojSNoaotFPVuFQyThoZM15A4elnBywDaDGLvEWdXRp+NAYUMALiUyRRgwUc9Tei30M7ZnsXNQzKVH6dzCGR4cM0JsDpf8b0qW5sD44nvzbUASocynXr6sMZ5u1xJy6/HKnH384U6p2cfw2fv3vQnAbMXRYagIz4Cr4oU3gAV9qWxSh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16i64AOdFecm0BoEUBtZ10mYilRdddos6pqLzsvZcKU=;
 b=BhP2+Q5EZjikd3S5ZbDMeo6s7HaH5duGAv2v9T+GISx/PcsleTzujmrBL8hdxeiGUmFubzOofl1/BnGGGuSgpBtHab4fn8ErZ3SQ/aephCEEYf3ZEHMEUth59l0PcWc5TCpTiKtcaGMT/m5TZaBsTWmFzhPOFsHaftu0BI0+o+ANc26ADDv97Cg1vLHszeCGIbPwcpWbgR9TgreSlSvA8WDZ8d0Sd6tCCgK3C7n7W0R7wh6icdWzRd3+mJfnrLD6/Si4UMHzX09uK0pz/3HWq5dxPPdHsB3klYSefpU+VsCn0eDLe7sZpKj7uUUuQ3fRmzhlkCxvqfmMmK5IrG9Fzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16i64AOdFecm0BoEUBtZ10mYilRdddos6pqLzsvZcKU=;
 b=Ye9lhrd9BPOthSG7hVCGQrfv6f/ZQzf2Yg92/84Pg3WaFsUxgwaoexjtlannSsP2XoTiHnFyT27wUbVfk2yAXceawS26V4aHONfMh1xOQpOGGafFmiTRaa9AtPRX2qRvnobWP7DxvgbwLwJYXubD2YdKSbBjphMezo9rIgaossA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:47 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:47 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/36] drm/amd/display: Check power_down functions exist
 before calling
Date: Sun,  5 Apr 2020 16:40:48 -0400
Message-Id: <20200405204115.683559-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:41:46 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 66c66bc4-a35a-42a6-e89a-08d7d9a1c294
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2555CECC731A1BFC370EFBAD98C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOT1G3uI7StfelHtbwYTIZv55Jj7o15CB9uyqH/Vu3O9tjIpY7Ax7V/b1OnfHvC4pmvQRz7hcMMgD5aEQLN/TD/riqfjj2G296zkUzFOXY8tVe9uYDiNlcHzwyUCQBh5t7ItRmfeIYqXO/mlfohIb2/SfwtHouwJQ82WonuKTvDXGXcAAekEBEX5AS3wQR3wtfIeEchDZJG8zH2+xD4KTNmConAcirAXiO0qV4ME5iymgR1Cjh+oHLJikZ/lQ8LRanzaJrJWjyszXdlIiLeOmItTwEpDYY7ghvYvKfGFxaKrksEl4UWB5MTsG02WKhOahUsFdZh9v+izDxqncsMMJSK6kANVfqWY1Bu6Nthixe4zpKIHznVlS9sEKvp3kmZarvMJx7VRWaxHf9G/pHlhZ9KFT8GsuFJ2hsLKCH1OZ2Zas4SymQLOnl3kc43mD+Eg
X-MS-Exchange-AntiSpam-MessageData: +1hNkf4vFurkeWKOpp7SOyWpa6YK3Gg3Lya558Xble+TbJsnZ/O1+OCnJn/XwkjZOW5IiN3vj5HAL0uba2L85MJFlihRBX8mcgYpvv8+F1+L4pto45QR6+I9XT1e+Z2tY1rZZJB3ewsV7GOF4UJ24qrW4g93lFCUL4puJRtOKyo=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c66bc4-a35a-42a6-e89a-08d7d9a1c294
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:47.5624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DB7sp5FDQfoFuzib0O7+Wh9cfL83ofb3UwoAbUg4zCSREj4Ua88UjUX43TfhC3ENZpFuboubKT+3p5YSyOxknA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Sung Lee <sung.lee@amd.com>,
 Yongqiang Sun <yongqiang.sun@amd.com>, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
The power_down() function was only defined for specific asics and will
crash the system if it is called by an asic with eDP connected that does
not have it defined.

[HOW]
Add a check for the function's existence before calling it.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 079a33a96f90..6086bbec94fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1378,8 +1378,11 @@ void dcn10_init_hw(struct dc *dc)
 		struct dc_link *edp_link = get_edp_link(dc);
 
 		if (edp_link &&
-			edp_link->link_enc->funcs->is_dig_enabled &&
-			edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc)) {
+				edp_link->link_enc->funcs->is_dig_enabled &&
+				edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
+				dc->hwss.edp_backlight_control &&
+				dc->hwss.power_down &&
+				dc->hwss.edp_power_control) {
 			dc->hwss.edp_backlight_control(edp_link, false);
 			dc->hwss.power_down(dc);
 			dc->hwss.edp_power_control(edp_link, false);
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
