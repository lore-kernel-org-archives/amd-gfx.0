Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0A8C4332D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31D42072D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vl7RuaBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31D42072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A111F6E195;
	Fri, 20 Mar 2020 15:11:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770051.outbound.protection.outlook.com [40.107.77.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 794796E181
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 15:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhiX9j41xnUKH104SztLGilJIVouQHbMZDgUlskUDA4Ni9MP+DRE4UcALp9gUfj0IPa5sOuJvemFvQ/0n/3iIh+/bBbaUjphBqWf5Ul9eVpgr47zNJ9Y+QC6knc2w5ZSdTTC//h0Uv8YDu6rMYSpFWLn6IhSA77NiGaa+u1PHqAzy+lGOZhayt1zHLedWkTDmPhzCstcZkO7V5J6S6MDLeSmQ9OuK6SH/KrIrESGNH1RyLoo1YN+Yybij3NRWgVzbd61UfjerZ/2ibMsv72J3AiIWd3ZFh0c3cStSTS/hU4ixNCBD0fLSZKXJ1JC3gfKxwe6JYKPD4mWKpP2Z+n6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqh8ghtr0y2SzKNHgDzzH2GebNnAgK22rBadSH1fhuQ=;
 b=B5gyShFjXV+w3AHA+3CyCHmCEC3ulzWHyGo/M6b6kOfuR7CuBiJXvpXNW/NspGdv3R9NhdZKyrloiWgg9QUfjp512x7cwf7pvPvAPD5rGOrNL1q3AcUUNrlWu4jEj1r/7g6Y76kY1BoQxLfKEIccba/iLbMYONz0Kv6mPC0ekkI1+F6p2t7E0xvHq+VzlQJstIOqfgj3Jm+fKMuSsfEAOJkCYcZ6J9ebpkDDkg+wNOcD4XCIyj6dhjnDNMw2E1bI38ZIZJfLMc+Xh/thjzhY2v9HTdj6YCYyBK5dUiUwGRgZWLYv3CPish4L6Mn1Lwu+8p2bKzojDQbZ5OhViUgFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqh8ghtr0y2SzKNHgDzzH2GebNnAgK22rBadSH1fhuQ=;
 b=vl7RuaBV5eEdLrIXhp4HZHkZFs6Q/wHrzSUtXNwkthpOgnPELvaEsW5G/Z6HHb/CTxXydfvBfxYBTgWQ8vvtVlNWXMH0+nTbSJS3KPfG00JMxdBvYH4bbXdxYlZkCHdftaJE9bUwtyUf74S0y2b55CXLhsExsOKY+60q4NmVJ1o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 15:11:50 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Fri, 20 Mar 2020
 15:11:50 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/12] drm/amd/display: Use double buffered DRR timing update
 by default
Date: Fri, 20 Mar 2020 11:11:21 -0400
Message-Id: <20200320151128.2039940-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
References: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Fri, 20 Mar 2020 15:11:49 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c0820a1f-bb2e-46a4-caa0-08d7cce1040c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2572A570B64F358D290676B598F50@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(81156014)(66556008)(6506007)(54906003)(4326008)(16526019)(2906002)(8936002)(186003)(81166006)(52116002)(2616005)(1076003)(8676002)(86362001)(66476007)(316002)(66946007)(6666004)(15650500001)(6486002)(36756003)(5660300002)(6512007)(6916009)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXnvUzmRh2EfC8Vx5UApTQkF7KU34RY+MLJIfCKYVp9bwOgVjzgYw3RuVN9k5Afkc06foE2eqgy1kUaHYZ74bLITBQ7xwr89S4mS5nHGIS8/SZHBdhWvacPValO7z+HT+CM8B8asgbMzNSmZp0PhgMFbCsDeblcDOAM68X906U0zz+OZSj2bpaEx6I76LA7T5tObsn1M4XQbi4jSQtDuDvN3korqQ38Fw6fz2z22J5ZHXwT/7xQLXQrAcPVBW2STMv5DEdeCamm7oe3VXpCo5b7YLIqcxVM050Ebc9zQBngot+NMhvHLzCYlDx0lHTC47pRe17qhBSncAtSRfs22Y8mwQxOpKvGEAYb+99rl2ZivVZBaGYkAnNT2WmxhWgOXeiuNOHQYbEiAgEGCc3rsDfpf6Y3y1mUvyHLEWTHmn5fifk4uzYlD+3is+fo5FTpW
X-MS-Exchange-AntiSpam-MessageData: htSmb8CNZrEwz1ASSmuwNWNT6m0fBnxOvlhQOtvm2VOxo6AC8Xm844FHNFI3qpThAHTY926VNSYvXqto6dM0mDy1egbIE9PZDN9n8AbPzqfVZy47A+H/SJUadpe+jgmr2QFsqIeCmQeCUgCKojMK3eWSTMghM5kzmaEhnC6zhdA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0820a1f-bb2e-46a4-caa0-08d7cce1040c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 15:11:50.6368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUiEtW3Xa+Y6/6tfEuAKiK+pZieTS5Nd/a9nBZEVj08Jun1o2DcgnxYBDgTXgd6qxvueJ/NoOwoDAuxlMRNyMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
For some monitors extreme flickering can occur while using LFC for if
we're not doing the DRR timing update for V_TOTAL_MIN / V_TOTAL_MAX at
the DP start of frame.

Hardware can default to any time in the frame which isn't the behavior
we want.

[How]
Add a new function for setting the double buffering mode for DRR timing.

Default to DP start of frame double buffering on timing generator init.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c  | 18 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h  |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 63acb8ff7462..17d96ec6acd8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -342,6 +342,23 @@ void optc1_set_blank_data_double_buffer(struct timing_generator *optc, bool enab
 			OTG_BLANK_DATA_DOUBLE_BUFFER_EN, blank_data_double_buffer_enable);
 }
 
+/**
+ * optc1_set_timing_double_buffer() - DRR double buffering control
+ *
+ * Sets double buffer point for V_TOTAL, H_TOTAL, VTOTAL_MIN,
+ * VTOTAL_MAX, VTOTAL_MIN_SEL and VTOTAL_MAX_SEL registers.
+ *
+ * Options: any time,  start of frame, dp start of frame (range timing)
+ */
+void optc1_set_timing_double_buffer(struct timing_generator *optc, bool enable)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	uint32_t mode = enable ? 2 : 0;
+
+	REG_UPDATE(OTG_DOUBLE_BUFFER_CONTROL,
+		   OTG_RANGE_TIMING_DBUF_UPDATE_MODE, mode);
+}
+
 /**
  * unblank_crtc
  * Call ASIC Control Object to UnBlank CRTC.
@@ -1353,6 +1370,7 @@ void optc1_clear_optc_underflow(struct timing_generator *optc)
 void optc1_tg_init(struct timing_generator *optc)
 {
 	optc1_set_blank_data_double_buffer(optc, true);
+	optc1_set_timing_double_buffer(optc, true);
 	optc1_clear_optc_underflow(optc);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
index f277656d5464..9a459a8fe8a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
@@ -185,6 +185,7 @@ struct dcn_optc_registers {
 	SF(OTG0_OTG_GLOBAL_CONTROL0, OTG_MASTER_UPDATE_LOCK_SEL, mask_sh),\
 	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_UPDATE_PENDING, mask_sh),\
 	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_BLANK_DATA_DOUBLE_BUFFER_EN, mask_sh),\
+	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_RANGE_TIMING_DBUF_UPDATE_MODE, mask_sh),\
 	SF(OTG0_OTG_H_TOTAL, OTG_H_TOTAL, mask_sh),\
 	SF(OTG0_OTG_H_BLANK_START_END, OTG_H_BLANK_START, mask_sh),\
 	SF(OTG0_OTG_H_BLANK_START_END, OTG_H_BLANK_END, mask_sh),\
@@ -643,6 +644,8 @@ bool optc1_is_optc_underflow_occurred(struct timing_generator *optc);
 
 void optc1_set_blank_data_double_buffer(struct timing_generator *optc, bool enable);
 
+void optc1_set_timing_double_buffer(struct timing_generator *optc, bool enable);
+
 bool optc1_get_otg_active_size(struct timing_generator *optc,
 		uint32_t *otg_active_width,
 		uint32_t *otg_active_height);
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
