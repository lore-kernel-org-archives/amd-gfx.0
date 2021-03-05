Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458ECC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0829D6509A
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0829D6509A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C05126EC3F;
	Fri,  5 Mar 2021 20:04:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8118D6EC3F
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 20:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kk1Ql6ALsVRtuOXRGOP/lmUAtMlbitomimSsKwhMvg0HMXo98GO+kFG1cpvCD3uhnHA/8dPFoXG5CpvvYPQpoqJK+rEm7zt6jTi9NTo9sp/va5DE3++BW+vR0tf60HjSa3xYt2qLhKeLbHDzuR5p4IFjtPDYUKiSRyS8URwibaMqOwkMnQucRrdLoFM2Hb4MlSyXr5yWzFko+Zv2tnHV/4DfrEXj7yZQ4praow9wbYZk+Sc51laS1b3eM3edPv+wgXp5WfLPCKq+UHW94aCCNrNvALsWpjj1sixNHg/ROgBrzGztVnV3pwQAOKDjazB/rQDo0PMtGyjgzF+JOuaagg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lgUD4R8rpQQMwTDchmH+gK0TqXr/H0v5PFhE8zDKAI=;
 b=LyTzyiw0uyPShVcLxtGkaDjZ7zS63RkabM6WhEVpyT+Gb1HB7141ix8ohWCOPo3H67TY4nsJH43Pm4fDZdwRYGkhBsf1uRVx44yZf/CbibcaZr3+BjaZP5pZBei9MyU7e1pDkA7elbzGlDvR3kVbTdvVg5BuXWNyv1LhJ/bTPNkYZYdH53x+ec6oyNkntX7wfgep5vujEBKyV1iRhMwRzrYsMRsyen3zO0G+uvoylCZUE27FMstOLAP2q2cd060nBLzuc/0Nlo5bT+yxtJvZ2ICx2BpdUi3jShCuvQso2jBypKpJGjmy5UOtv3+D+nI2O36Qre6EB6eV7W4vUtea+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lgUD4R8rpQQMwTDchmH+gK0TqXr/H0v5PFhE8zDKAI=;
 b=jc2B7NiY/pN594eBLDdTWgENAfBn2XoeL5E5XfxYh1o7/0/g0WoiO9zPMvoMUOwGXUf0QhfogCPt2043SWVxjvOr5ENQNbsxh7TYs0XOIosR6cXMJ+IDGCBR3Fxx9QJT5RI3g1N1sK8K51iZoxpnacYoq6ozhg7D3F9fvXxULvk=
Received: from DM5PR13CA0064.namprd13.prod.outlook.com (2603:10b6:3:117::26)
 by MWHPR12MB1279.namprd12.prod.outlook.com (2603:10b6:300:d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 20:04:26 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::80) by DM5PR13CA0064.outlook.office365.com
 (2603:10b6:3:117::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.16 via Frontend
 Transport; Fri, 5 Mar 2021 20:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 20:04:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:04:25 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:04:25 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 5 Mar 2021 14:04:19 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/14] drm/amd/display: Read all the trace entry if it is not
 empty
Date: Fri, 5 Mar 2021 15:02:54 -0500
Message-ID: <20210305200301.17696-8-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305200301.17696-1-eryk.brol@amd.com>
References: <20210305200301.17696-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecc5f574-8cd0-411d-fc5c-08d8e011e0b2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1279:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1279DF3D88F7787DAD315712E5969@MWHPR12MB1279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NrHtgI8ppp9syu//XMFHrl0a45EFAw9dV/+pBTGs5LcsIE++ONfB3abLF/VDXFZfflXibHasyoWQcDF4o+gafNOLyjMnhTz/tFBzxVkoxESmtBwzfXFSIQBCaWJcQxhKCUGg5sENPmBlSrhq3GAFXQT0Ih55zxE2+YO6xMNHcsbWur5Rexmbijwi5rpvCJ6uwdmwsNKRMR7kxD/1yKJvIDhzHYy1edz20gExbU6UOX4GBQBu3k8x89oFoVql+HJaz4mVwY8/7btJz5gclbdBKK66C5bz6a1E/8PXFJrrreRMcIilzNjZWFgjF1aVkDnWNvV7fpApzppvosIfC1LH56qJ/643rBvDufblBPecOIaqYUj9WnyLV0fFvZh2wb4JZL9NlLvhiz0/py9BlkryEaLLCdAUGvCrtKL2z46YHn8aJNBKcP+Sdn0g1i0C+20f3EAw3aVevCTUa9tu9uAHcj2qmLbQHzCkVK1VO0irdLiB8K8LanfjH1oaHz+TIel1OdYGEagX8EU0YIHisAX03N7PZMYuWaGs0lqXIhcZ5gScVZ23Wf7xNVHfo+e6ZXSCE2csmq47sV87vjEq7lFmd6Ey6BguUrYlxkopphlHoNqGbB2f1dvT17YOjndWO326KamN8fDNdTB5cFJUTI0s8bbJQUu1vDTrkl9GzhSejr/t/hZQ49oDupKiGzc/Tn2d
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(36840700001)(46966006)(47076005)(44832011)(5660300002)(83380400001)(336012)(6666004)(426003)(316002)(2906002)(86362001)(1076003)(81166007)(26005)(82740400003)(356005)(2616005)(70206006)(186003)(70586007)(82310400003)(4326008)(36860700001)(6916009)(36756003)(54906003)(8936002)(8676002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 20:04:26.0857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc5f574-8cd0-411d-fc5c-08d8e011e0b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1279
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
If interval of two interrupt from dmub outbox0 is too short,
some event might be skipped

[How]
Compare read pointer and write pointer until all the event
entry is processed

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 2522492dcd42..1f1375c49aa5 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -517,7 +517,7 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	dmub_memset(&outbox0_rb_params, 0, sizeof(outbox0_rb_params));
 	outbox0_rb_params.ctx = dmub;
 	outbox0_rb_params.base_address = (void *)((uint64_t)(tracebuff_fb->cpu_addr) + TRACE_BUFFER_ENTRY_OFFSET);
-	outbox0_rb_params.capacity = tracebuff_fb->size - TRACE_BUFFER_ENTRY_OFFSET;
+	outbox0_rb_params.capacity = tracebuff_fb->size - dmub_align(TRACE_BUFFER_ENTRY_OFFSET, 64);
 	dmub_rb_init(&dmub->outbox0_rb, &outbox0_rb_params);
 
 	if (dmub->hw_funcs.reset_release)
@@ -719,10 +719,10 @@ enum dmub_status dmub_srv_cmd_with_reply_data(struct dmub_srv *dmub,
 	return status;
 }
 
-static inline void dmub_rb_out_trace_buffer_front(struct dmub_rb *rb,
+static inline bool dmub_rb_out_trace_buffer_front(struct dmub_rb *rb,
 				 void *entry)
 {
-	const uint64_t *src = (const uint64_t *)(rb->base_address) + rb->wrpt / sizeof(uint64_t);
+	const uint64_t *src = (const uint64_t *)(rb->base_address) + rb->rptr / sizeof(uint64_t);
 	uint64_t *dst = (uint64_t *)entry;
 	uint8_t i;
 
@@ -730,13 +730,22 @@ static inline void dmub_rb_out_trace_buffer_front(struct dmub_rb *rb,
 	for (i = 0; i < sizeof(struct dmcub_trace_buf_entry) / sizeof(uint64_t); i++)
 		*dst++ = *src++;
 
+	rb->rptr += sizeof(struct dmcub_trace_buf_entry);
+
+	rb->rptr %= rb->capacity;
+
+	if (rb->rptr == rb->wrpt)
+		return true;
+
+	return false;
 }
 
 enum dmub_status dmub_srv_get_outbox0_msg(struct dmub_srv *dmub, struct dmcub_trace_buf_entry *entry)
 {
 	dmub->outbox0_rb.wrpt = dmub->hw_funcs.get_outbox0_wptr(dmub);
 
-	dmub_rb_out_trace_buffer_front(&dmub->outbox0_rb, (void *)entry);
+	if (dmub_rb_out_trace_buffer_front(&dmub->outbox0_rb, (void *)entry))
+		return DMUB_STATUS_OK;
 
-	return DMUB_STATUS_OK;
+	return DMUB_STATUS_QUEUE_FULL;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
