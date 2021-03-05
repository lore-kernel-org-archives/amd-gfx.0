Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE28C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942CC650A0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942CC650A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ABBF6EC40;
	Fri,  5 Mar 2021 20:04:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B60416EC40
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 20:04:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oh9MqNRmAtWBuzehTCTRMR2yRjjEaZiWAOmlFiCTH8w0v+B5JRiV1LPpD2bdBbzO9F6bcdZ4asw+UOcFtpy4Bfe/1EK4l6e+gjLxOzSTFXKwSjrAIHfb530mlwrM9PywL5tHQA8+R84E+7p3YtgN+EatNY8eQx3MLs9WGhxZTHPFGlCJhVuFKoQnijePiN3Rni/8VPngff3dZk19a31i39/6SdMul0NrFlPROYXLWEq71QZfUCG+hyxI858Lu3LGhic/LO+EC5kemvXQFC1t+tQ/QG8+kd5ktR7gAK6/jqs8vvwTorlcT3R2eKMTJuA1Kq3LeiHbiJ1CdleyFr/wZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mzlfnhw5D7th8fl414CBFMQjhz9pp/MfGs6l9aMt96I=;
 b=Ux/lhCuNr8PI2pSatBODMQ6H2t92EWmm6/yc05ZjYwLlj7buF1kkkqc/HNmUtzdu5vbOV8YrA10pOmiCQdiDz7F+N6h/IOScBEYzxXifzTz6nTbuNeVuUk65a50vIMxLtCMEPpEfAzV/YhpTxGp93rVtcPEd8OoBxyb6vRZzQ8CWCJsJVwXWTXK8mwN8TYQQhlr+8r2/8/PRibOxonDhaUJQGJjvMzrQ9pau+jlhpoWFwr8PcyjF95HPJQjsq7STlqaIOWf59TLjFSNs68Fhwx2UaMHbU4YgDoP2NjchYA1XpP4Eo7sXTb2qOhHlSmKgOxXaxquPmtz7MeigGUoBaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mzlfnhw5D7th8fl414CBFMQjhz9pp/MfGs6l9aMt96I=;
 b=JmIJ3zzul3H7TzY5/D98oW284r4wofdYFM1uiLM3XdXuE84mAylUd1w7le5q/dtl/SnGoEbE5Q0PUgsoiDEhvCSSK9WRp3HJl9KyeAMECQCv7kmUvD6LFhVWwdDrY8kUr22tAA9epVdvI3lWmlMuiVGfjvSOiu73wsg5eOHSI+4=
Received: from MWHPR15CA0056.namprd15.prod.outlook.com (2603:10b6:301:4c::18)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 5 Mar
 2021 20:04:45 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::c5) by MWHPR15CA0056.outlook.office365.com
 (2603:10b6:301:4c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 20:04:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 20:04:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:04:42 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:04:42 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 5 Mar 2021 14:04:36 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/14] drm/amd/display: Fixed read/write pointer issue for get
 dmub trace
Date: Fri, 5 Mar 2021 15:02:56 -0500
Message-ID: <20210305200301.17696-10-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305200301.17696-1-eryk.brol@amd.com>
References: <20210305200301.17696-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5a76ba4-62dd-4cb9-d2f6-08d8e011eb12
X-MS-TrafficTypeDiagnostic: MN2PR12MB4111:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4111160DAD1A53B6EC01EB86E5969@MN2PR12MB4111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: evuAdgz9kcyoByX87n8rMbjsD+FNIa3tvy3gzov/o4LeVELG8X97B3vi0yNFOfSxdAl7JH+JGc8SqiOvmNn9m+Q+SFuB/L8sywzneyjFghfoStxzQb1ukP0/CSuW04VaG0L2FS5pcaXZYLD+PZiRo3YgBi+5GNRoaYSMIg3gNMX/6SnUeL3B+qSwrxTstwKWp2ksT4ibGokOb+70PBhLzklfp6Wx7h5RdoNGiA8LudxqtYxCLd5Z79lA0IeZqNPGl/a7ldY5YaSJnenQOvXmAsr5YbklPOBruM5jA14h1A6FcF6WPu9LAbLvf5HV9e2Q8WxPI+er14NHjNgIE3c4Ff67kg2aQAFPuTB6+34fzKoiQra/5oOWN/3VVywlI453muAEBMW+18T3Purarrg7t6MBi/GOKhP2/1J7kDb9EJrQMkhamJ8aQ4h406RQ6jGioLFFU682wvzKUE8z3fYnI5gd4emUDrnEIpvkrme5hoUt+B1Kd5fT+dW2KnC6vh8HKiTzUnJINplURsFxm5FT2ngrapVh/hjhT0VROresT+nFYzqTAH2M6UuCuG5+Cbe4A4UVujsGjw0tNYO+N1yDl+I0eVDnRK4RQI1aoiyIJ2YiXILEu+ku7kOkgb09NIxp32PCgfhnN29fqMhHAbFez2n9TlCyMFiPDep6UX9RH6nxRQMnvmZiTGeRn/Xbl7he
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(46966006)(36840700001)(356005)(70586007)(36756003)(336012)(86362001)(8936002)(1076003)(5660300002)(426003)(44832011)(478600001)(47076005)(81166007)(6916009)(2906002)(6666004)(70206006)(8676002)(54906003)(82740400003)(82310400003)(186003)(36860700001)(4326008)(316002)(83380400001)(2616005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 20:04:43.4181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a76ba4-62dd-4cb9-d2f6-08d8e011eb12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why]
Driver get wrap around dmub trace data due to read pointer being
increased incorrectly when there are multiple interrupt
queues with very short interval

[How]
Check read/write pointer before copying data from ring buffer

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  8 ++------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 19 +++++++++----------
 4 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index b9d8cfef0a1a..68453c29c617 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -172,14 +172,10 @@ bool dc_dmub_srv_notify_stream_mask(struct dc_dmub_srv *dc_dmub_srv,
 		       stream_mask, timeout) == DMUB_STATUS_OK;
 }
 
-enum dmub_status dc_dmub_srv_get_dmub_outbox0_msg(const struct dc *dc, struct dmcub_trace_buf_entry *entry)
+bool dc_dmub_srv_get_dmub_outbox0_msg(const struct dc *dc, struct dmcub_trace_buf_entry *entry)
 {
 	struct dmub_srv *dmub = dc->ctx->dmub_srv->dmub;
-	enum dmub_status status;
-
-	status = dmub_srv_get_outbox0_msg(dmub, entry);
-
-	return status;
+	return dmub_srv_get_outbox0_msg(dmub, entry);
 }
 
 void dc_dmub_trace_event_control(struct dc *dc, bool enable)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index eefec9cc21a8..338f776990db 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -62,7 +62,7 @@ bool dc_dmub_srv_cmd_with_reply_data(struct dc_dmub_srv *dc_dmub_srv, union dmub
 bool dc_dmub_srv_notify_stream_mask(struct dc_dmub_srv *dc_dmub_srv,
 				    unsigned int stream_mask);
 
-enum dmub_status dc_dmub_srv_get_dmub_outbox0_msg(const struct dc *dc, struct dmcub_trace_buf_entry *entry);
+bool dc_dmub_srv_get_dmub_outbox0_msg(const struct dc *dc, struct dmcub_trace_buf_entry *entry);
 
 void dc_dmub_trace_event_control(struct dc *dc, bool enable);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 16d1976b041f..b4e14960b164 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -667,7 +667,7 @@ enum dmub_status dmub_srv_get_fw_boot_status(struct dmub_srv *dmub,
 enum dmub_status dmub_srv_cmd_with_reply_data(struct dmub_srv *dmub,
 					      union dmub_rb_cmd *cmd);
 
-enum dmub_status dmub_srv_get_outbox0_msg(struct dmub_srv *dmub, struct dmcub_trace_buf_entry *entry);
+bool dmub_srv_get_outbox0_msg(struct dmub_srv *dmub, struct dmcub_trace_buf_entry *entry);
 
 #if defined(__cplusplus)
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 1f1375c49aa5..1ee2000ad099 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -725,27 +725,26 @@ static inline bool dmub_rb_out_trace_buffer_front(struct dmub_rb *rb,
 	const uint64_t *src = (const uint64_t *)(rb->base_address) + rb->rptr / sizeof(uint64_t);
 	uint64_t *dst = (uint64_t *)entry;
 	uint8_t i;
+	uint8_t loop_count;
 
+	if (rb->rptr == rb->wrpt)
+		return false;
+
+	loop_count = sizeof(struct dmcub_trace_buf_entry) / sizeof(uint64_t);
 	// copying data
-	for (i = 0; i < sizeof(struct dmcub_trace_buf_entry) / sizeof(uint64_t); i++)
+	for (i = 0; i < loop_count; i++)
 		*dst++ = *src++;
 
 	rb->rptr += sizeof(struct dmcub_trace_buf_entry);
 
 	rb->rptr %= rb->capacity;
 
-	if (rb->rptr == rb->wrpt)
-		return true;
-
-	return false;
+	return true;
 }
 
-enum dmub_status dmub_srv_get_outbox0_msg(struct dmub_srv *dmub, struct dmcub_trace_buf_entry *entry)
+bool dmub_srv_get_outbox0_msg(struct dmub_srv *dmub, struct dmcub_trace_buf_entry *entry)
 {
 	dmub->outbox0_rb.wrpt = dmub->hw_funcs.get_outbox0_wptr(dmub);
 
-	if (dmub_rb_out_trace_buffer_front(&dmub->outbox0_rb, (void *)entry))
-		return DMUB_STATUS_OK;
-
-	return DMUB_STATUS_QUEUE_FULL;
+	return dmub_rb_out_trace_buffer_front(&dmub->outbox0_rb, (void *)entry);
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
