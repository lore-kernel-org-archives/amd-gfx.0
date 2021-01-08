Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C1FC433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA61123A9D
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA61123A9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6269B6E8EE;
	Fri,  8 Jan 2021 21:50:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 168A16E8F2
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:50:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fA6X2+EGcSmBeqy3FBErU5HMb7E/DdMGTRMlp/xjAN6OgsWPShLOfuNvVR73++QkCvkS/qQxHU6eWRs51XxrEONpU1+qCtLTFGU70hh2XaKGe9FutZV+RsWHzKrmi+4NJeiCSZ+H8lyP5U+GFG+LD/lwtlZWMyPa24Xf6f2mu6jBqWc7GfqMYjUd5NAWeCzQyanKn1aCk/2zu9WBjS0YY6vH4bpDwXlnMZ+Q/HISh6ufsEWMSgRg69Zo4KjNYmNxS8M+7O1VUM7Wel98SaLLzC5eJOKH0rruf0haVWo3UxlcB4st3lG8lcNkUyVNU3TDExku4fGBUVjSZ8KtT7nstQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6M0+hgWt5YPtYmkPSnHAIzi+4bCB5Ad9tYSM7E/1ZQ=;
 b=gvgYYqVve2SbH32ucm3ZkYrpotoxmNDecL9a7144nHhItlS0H7tjaIa0GZgsXaFjX12FGBfxcQJREObQFf4VFkVgdQ6dJeHViIzw4rhUVkQTcaCDn1U1LC3Z6xh6XClkCLgUpdWmvaLl6wBKo8vV33HKgCIdQfhpNyn0z0MgmxFQssWH1Mua3QeG5izIas3QwwTbVNbFxo8M0RD13qdfH10tW9nGGF+dt1sjREJCjAkqu7vKYtVplsFtVTUKney0/651H57PX5uT8g/HjgHVtK3908xfXwf7fc1KkMI+GvcgQwgiKgZQ7EVMEtqnmY3vCoAHUjfnHP11+5Dp51TRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6M0+hgWt5YPtYmkPSnHAIzi+4bCB5Ad9tYSM7E/1ZQ=;
 b=qAMhO1sn0KSwYLAaBUs4flsLc28JZ4PXUnENW5pbxqcnrh0SqHWcG3qKJdTCftx/q9sJTQ+5wd5ef5IPos0JHniwamvlZ3ih4tHGzzNM94ptOYOBkJGtMi5KlZ3vwv+2OH0PVR3n7QemKTReEY392bc8GnAs1JIbiMZeigQs9xs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:50:47 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:50:47 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/21] drm/amd/display: implement T12 compliance
Date: Fri,  8 Jan 2021 16:49:58 -0500
Message-Id: <20210108215007.851249-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
References: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:691c:c3e7:a457:38d0]
X-ClientProxiedBy: BN6PR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:404:e3::25) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:691c:c3e7:a457:38d0)
 by BN6PR19CA0063.namprd19.prod.outlook.com (2603:10b6:404:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Fri, 8 Jan 2021 21:50:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 869fa1f6-a9a0-4f3d-8030-08d8b41f74e1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882B964C92288D9BBB7887C98AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1q6No+jBDC0zMzJTIbAWpL/2nbFB9QodYYGbT/UeIXjd8kOopkY1d/EqDkirZBEyEwdwioawanOnA5jwCaB2Ya3vb0g6OxHBP+2Lu4RlMy0ZtZMpB8TWAuDjEJui/qVBmB49BhzSU+SDGoeDA1QHcxyS6nQoTA6hdBtToqU4dZn3Xn3fytgHwriuUZ6UvQvX6/SZ1ZI+gQHqOH2w6YDE+QFRzBGp4Xj1Oy682/+BMNA48rFarBAYUIEUHa1lhMTK5ClMY8lvvypwwKrs44jZjStyuAJjKJ2N20oDL8uuhUdXf445LDV7PoZo6vixf2OMpK8xGtrIAMOIltEiI1nuzWc9yUiCRs2pNJ4m0KlQYPOK2bCuBga9mZYMqvJQx3+RI9Hf/kjaok7SCgldrxJag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(66476007)(6486002)(4326008)(52116002)(83380400001)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(54906003)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LpgPkYq5Lk3vETMX1jcCSbjp8Qqy/L9tbi1tFuQLlqmxNhUQuBZLmxRp3am8?=
 =?us-ascii?Q?VyMZlI0W8dS2z3/DtGJknZjPwzLRsjXlwB6d4ZnhSLdrRHJVPPHDx8iIHUyb?=
 =?us-ascii?Q?tD6cIEic4fzlOr5c6mMfYnGr+YLCuTT1xSy9k2f+2Wh0907Cj7i+xDNgq+KY?=
 =?us-ascii?Q?jzzASYj1T0pbVUdcByhkDSfFmEtPA14oYIHpkLkG7Phcpzpw/V6E1mLhCtFJ?=
 =?us-ascii?Q?ADDvKHhEm2x1PwUq976DA/YLNVGERzMlheQhohV6iwqXHdHavmVSGXkxBW8f?=
 =?us-ascii?Q?t0zSCkquEhVoUPHYW6pNHlTmyoBbxQ0AjLzz4FO/iKlTtfD5oUEhcWYHagZH?=
 =?us-ascii?Q?kIVPV1oqjI9dCMIPl6rgE5pIPPE6aJsXgZj1Y0NYSMtcsQuko2vOFi9qc9+F?=
 =?us-ascii?Q?g9ugGXts2N0VE4G/ZnlHmjwkWtClGN6ahzO/VdkSIYChGjH5K0kC1bApRHih?=
 =?us-ascii?Q?ZB1Xv3NeaNgOdgFpvq3cB8l594lR3I3HibuYJ0N9AuDQg3hzY71GNTGXMaP+?=
 =?us-ascii?Q?X79l+l/ZV3uEum0tGrS7pjKEGwnnytRsnvWXlLRbNADtWLAfW0H7ImfFhL7J?=
 =?us-ascii?Q?CPsnSgBGHC6IZ/RZcptMvJUVpAtoSinTWb8WH3Rr/viaV1YQAIG5TgFDqkpg?=
 =?us-ascii?Q?Lv69vQrzKs/zkK7r1XNQLZzFAr2wQ4G46EeCQfZjryiVpWPP/SzfTQFHmb4F?=
 =?us-ascii?Q?YTY24p/pdqV2+Lq1J0120OlirdcdMDNTsGHnYW26pcDKOOg+tXBrFLU0SdO6?=
 =?us-ascii?Q?0r5TLGaHF5vHCtBRaR7UY/UlpRGQobIAgf1Rbg0cYGrY/hoWZMtgajausk7G?=
 =?us-ascii?Q?9cInvtXVRJ5iDgdNrNSlZx07P1VH5X/niFcYXRNbzvR7ny7Yl7juGaJhNbSi?=
 =?us-ascii?Q?GVCoXoifY7GWXiKHQAsNiwWg5flehTm1Eqbc4x4h/iaG/IYn2nUlaMEF9t67?=
 =?us-ascii?Q?JMVkV7EqGory3wvVuQkXZKePlhxDhGkXq7jH5RFDmv5J3hWaTT/Rda2T+rgN?=
 =?us-ascii?Q?ssdUds9N7tiQfneja1do+qPNej9U+WQtF2P76ELH5aUjFRsUR1pZN1lSxaaR?=
 =?us-ascii?Q?DAotJWRR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:50:46.9497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 869fa1f6-a9a0-4f3d-8030-08d8b41f74e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9LgdPM279nRrecG8IIiPb0FM1PNPZ9fDjpD7gBl5D2BPVOLDi3UHZwhHuA7h96U8kz0OcS4VZM1aJOdorPqBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Aurabindo.Pillai@amd.com, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jun Lei <jun.lei@amd.com>

[why]
When OS reboots, and panel is turned off, T12 may not be maintained.
T12 is defined as the interval between VDDC off (occurs at shutdown) and
the next VDDC on (occurs when eDP is POST-ed)

[how]
DC already tracks panel power off time.  Add a DC interface which DM can
call during shutdown.  Ideally this should be as late as possible during
the shutdown sequence so the extra delay is minimal.

Signed-off-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 11 +++++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  7 +++++
 .../display/dc/dce110/dce110_hw_sequencer.c   | 31 +++++++++++++++++++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  2 ++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  1 +
 6 files changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 59ef1eacc6e1..4f58a5c43548 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -203,6 +203,17 @@ static bool program_hpd_filter(const struct dc_link *link)
 	return result;
 }
 
+bool dc_link_wait_for_t12(struct dc_link *link)
+{
+	if (link->connector_signal == SIGNAL_TYPE_EDP && link->dc->hwss.edp_wait_for_T12) {
+		link->dc->hwss.edp_wait_for_T12(link);
+
+		return true;
+	}
+
+	return false;
+}
+
 /**
  * dc_link_detect_sink() - Determine if there is a sink connected
  *
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index d8d659b2bc34..d5d8f0ad9233 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -259,6 +259,13 @@ enum dc_status dc_link_reallocate_mst_payload(struct dc_link *link);
 bool dc_link_handle_hpd_rx_irq(struct dc_link *dc_link,
 		union hpd_irq_data *hpd_irq_dpcd_data, bool *out_link_loss);
 
+/*
+ * On eDP links this function call will stall until T12 has elapsed.
+ * If the panel is not in power off state, this function will return
+ * immediately.
+ */
+bool dc_link_wait_for_t12(struct dc_link *link);
+
 enum dc_status read_hpd_rx_irq_data(
 	struct dc_link *link,
 	union hpd_irq_data *irq_data);
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 4c230f1de9a3..3e9abb1b8e14 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -921,6 +921,37 @@ void dce110_edp_power_control(
 	}
 }
 
+void dce110_edp_wait_for_T12(
+		struct dc_link *link)
+{
+	struct dc_context *ctx = link->ctx;
+
+	if (dal_graphics_object_id_get_connector_id(link->link_enc->connector)
+			!= CONNECTOR_ID_EDP) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+
+	if (!link->panel_cntl)
+		return;
+
+	if (!link->panel_cntl->funcs->is_panel_powered_on(link->panel_cntl) &&
+			link->link_trace.time_stamp.edp_poweroff != 0) {
+		unsigned int t12_duration = 500; // Default T12 as per spec
+		unsigned long long current_ts = dm_get_timestamp(ctx);
+		unsigned long long time_since_edp_poweroff_ms =
+				div64_u64(dm_get_elapse_time_in_ns(
+						ctx,
+						current_ts,
+						link->link_trace.time_stamp.edp_poweroff), 1000000);
+
+		t12_duration += link->local_sink->edid_caps.panel_patch.extra_t12_ms; // Add extra T12
+
+		if (time_since_edp_poweroff_ms < t12_duration)
+			msleep(t12_duration - time_since_edp_poweroff_ms);
+	}
+}
+
 /*todo: cloned in stream enc, fix*/
 /*
  * @brief
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index e5691e499023..dee8ad1ebaa4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -163,6 +163,8 @@ void dcn10_wait_for_mpcc_disconnect(
 void dce110_edp_backlight_control(
 		struct dc_link *link,
 		bool enable);
+void dce110_edp_wait_for_T12(
+		struct dc_link *link);
 void dce110_edp_power_control(
 		struct dc_link *link,
 		bool power_up);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index 87c74aa84406..c4c14e9c1309 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -71,6 +71,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.edp_backlight_control = dce110_edp_backlight_control,
 	.edp_power_control = dce110_edp_power_control,
 	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
+	.edp_wait_for_T12 = dce110_edp_wait_for_T12,
 	.set_cursor_position = dcn10_set_cursor_position,
 	.set_cursor_attribute = dcn10_set_cursor_attribute,
 	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 7b12ffcdd4ec..7a19ff5d4214 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -54,6 +54,7 @@ struct hw_sequencer_funcs {
 	/* Embedded Display Related */
 	void (*edp_power_control)(struct dc_link *link, bool enable);
 	void (*edp_wait_for_hpd_ready)(struct dc_link *link, bool power_up);
+	void (*edp_wait_for_T12)(struct dc_link *link);
 
 	/* Pipe Programming Related */
 	void (*init_hw)(struct dc *dc);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
