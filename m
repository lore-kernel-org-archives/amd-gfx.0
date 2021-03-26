Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CACC433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E925261A28
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E925261A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE2E6F4AA;
	Fri, 26 Mar 2021 22:05:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4EE36F4A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:05:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iATr/iATHn1mRNHN3t/cI1URnP55QoH9yofVAhWHSs4FnTV12JfMtzSWdFmw4Nu0iEZ0wCFw5tdPRiilTuqi2JkPZJtzVc3O1z33TUDx6P93YX8BGKw34ILZqLxUHLk9Hl0+Y1R2iiMizr03D398zlmtdWGjvTuYeXeTX3GnwdBivoarGdwhnKbG6rbN0Ve9Pzm/+MJIxV9uw232MkZA/xQtTxK+KOjzFJs9t/Ts9kikJEBR0vswd21qYnUBPJQKTGQEhiQI395dxszy+aSZQwZyQvBEWZIdIRPpTgFndRe4vYkqJvpaC8gq5HxBXu6AB30+j+wowZ74dl5sGoJl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8ulkN9S4oupc6ubrR5ysf7hqD3u67j9N7XU94QEgKo=;
 b=T8aHfn0zQhZt+3qR4ldHe3zChhnsGSBRLxJ7eDYV3s6YlrVFt1ZEmeE1QX5XQyzZlNTowq2a95PyuZ6t1KFUJoSCjGTSxt0VxpJVE1RlFLu/nOCVNrA6Nj9uRKAvKfMP9O38BIAAWbxFJMp59Sxh5Yes7RAxQp1uJfJivWXFwyq9EwSLi7E/jczaXamC1qcD7XpcuF14hFMcTxh6YrFlZF8DCZff1u+8EFiFWCgFtTMT0VB1dFV9xN5BEs5NaDwCs2CmM5j0u5lELqV9s3l55FK1jWvMcu9nOjpdgEVx+mytAS6yT9pcTtdL52ZosHF0Y+Ll+EyYfR6iEcwMNbHUxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8ulkN9S4oupc6ubrR5ysf7hqD3u67j9N7XU94QEgKo=;
 b=ysT9GMti2XL2CMru7uWClF/VI9c88dqq3IgQi1fW6/7p81ancoRH6Fq+qBAAmx9cyq1fW4wem68KdWLbIUyLzvsDvF4IHXdwVICdT3hKEVMq5Sebo4UC55EBnl+6ZqcgZIJtmRLoXh/hqx5IJsoj/OxKPnkyx2xREA2rM+7cbWk=
Received: from DM6PR03CA0090.namprd03.prod.outlook.com (2603:10b6:5:333::23)
 by BYAPR12MB3463.namprd12.prod.outlook.com (2603:10b6:a03:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Fri, 26 Mar
 2021 22:05:43 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::21) by DM6PR03CA0090.outlook.office365.com
 (2603:10b6:5:333::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Fri, 26 Mar 2021 22:05:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:05:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:05:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:05:42 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:05:41 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/21] drm/amd/display: Add refresh rate trace
Date: Fri, 26 Mar 2021 18:05:15 -0400
Message-ID: <20210326220534.918023-3-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a19f4bc-84ee-40fa-4b00-08d8f0a34cb8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3463:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3463E409D60EF20AAC8553A3EB619@BYAPR12MB3463.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ns7uHUI6DX2+g3vYrbZRbZhMG3AFw1iNsyO0XiXvfkKie9sLd3zxn2HYLzS5iWvcBqkLJ8tuXg02/AvXYt2pLf6Czn719vXmDhjtG0VmNn0QzIoU/w5ZBmtaeYMZQVJgsCnOVIp4xKm6K0WM1nDGEk9aA/AVpGQPu41nvkfeAG+1EBOsMloEdDD/t/iGDNmP4js1mnQZkRM7AhyNxuAMKMtKG+0YtYwldQQN0FSjTsa5VdPUeDZccE9dlCUHzJTDhG6ppFFoSFgLz5wxZvOkGNcrvkV0m07hVNV1zxpFWN+6RPIyE7wSkKgI4lg553L2RAUtR3QP3mrLzbao5G6TkXxGqyehQR8MS1i7JA0pkD2JL4Xl7pLUXb9Cm8Ias6eo1zRYgsaUKwphIyD8ZLu2SDiACEUAW8ia6Tooq08QFEG4jb5lIIQJoSNzBMNXKofHLSNaGoDVUHzZGGh7fBibflDxZrr1GWFefguVtCfLvCRgjF2Qn1woCKvvbJ9g5q9Ez26Gk3JWiACDl4NKv2uNAYgqaEHAey14LD0U3WP/lH3RI30CnSOkOIM0Y+PFjQSZOtMP3oNuUsh3Psc/Lkfm93tChig8pIP7+sqdUwwj8L/ZVRolMyBK6j5MAcKMm126Sm8Zhbic1X9z3RZl5lTOYbRciFe75nN3Fhv9FD8APjlwvocxYNYAa8p5OLyP94hR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(46966006)(36840700001)(4326008)(47076005)(316002)(6666004)(82740400003)(1076003)(83380400001)(81166007)(478600001)(54906003)(2906002)(82310400003)(36860700001)(36756003)(356005)(70206006)(5660300002)(336012)(70586007)(26005)(426003)(2616005)(186003)(86362001)(8936002)(6916009)(7696005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:05:42.9387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a19f4bc-84ee-40fa-4b00-08d8f0a34cb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3463
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

When we have to debug VRR issues, we usually want to know the current
refresh rate; for this reason, it is handy to have a way to check in
real-time the refresh rate value. This commit introduces a kernel trace
that can provide such information.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   | 19 +++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4c02373a707a..29313d71155e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -459,6 +459,9 @@ static void dm_vupdate_high_irq(void *interrupt_params)
 	struct common_irq_params *irq_params = interrupt_params;
 	struct amdgpu_device *adev = irq_params->adev;
 	struct amdgpu_crtc *acrtc;
+	struct drm_device *drm_dev;
+	struct drm_vblank_crtc *vblank;
+	ktime_t frame_duration_ns, previous_timestamp;
 	unsigned long flags;
 	int vrr_active;
 
@@ -466,6 +469,17 @@ static void dm_vupdate_high_irq(void *interrupt_params)
 
 	if (acrtc) {
 		vrr_active = amdgpu_dm_vrr_active_irq(acrtc);
+		drm_dev = acrtc->base.dev;
+		vblank = &drm_dev->vblank[acrtc->base.index];
+		previous_timestamp = atomic64_read(&irq_params->previous_timestamp);
+		frame_duration_ns = vblank->time - previous_timestamp;
+
+		if (frame_duration_ns > 0) {
+			trace_amdgpu_refresh_rate_track(acrtc->base.index,
+						frame_duration_ns,
+						ktime_divns(NSEC_PER_SEC, frame_duration_ns));
+			atomic64_set(&irq_params->previous_timestamp, vblank->time);
+		}
 
 		DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d\n",
 			      acrtc->crtc_id,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 1b8988dc0daf..c5f5f62cf591 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -66,6 +66,7 @@ struct dc_plane_state;
 struct common_irq_params {
 	struct amdgpu_device *adev;
 	enum dc_irq_source irq_src;
+	atomic64_t previous_timestamp;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index ac8bcd171b57..46a33f64cf8e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -618,6 +618,25 @@ TRACE_EVENT(amdgpu_dmub_trace_high_irq,
 		  __entry->param0, __entry->param1)
 );
 
+TRACE_EVENT(amdgpu_refresh_rate_track,
+	TP_PROTO(int crtc_index, ktime_t refresh_rate_ns, uint32_t refresh_rate_hz),
+	TP_ARGS(crtc_index, refresh_rate_ns, refresh_rate_hz),
+	TP_STRUCT__entry(
+		__field(int, crtc_index)
+		__field(ktime_t, refresh_rate_ns)
+		__field(uint32_t, refresh_rate_hz)
+		),
+	TP_fast_assign(
+		__entry->crtc_index = crtc_index;
+		__entry->refresh_rate_ns = refresh_rate_ns;
+		__entry->refresh_rate_hz = refresh_rate_hz;
+	),
+	TP_printk("crtc_index=%d refresh_rate=%dHz (%lld)",
+		  __entry->crtc_index,
+		  __entry->refresh_rate_hz,
+		  __entry->refresh_rate_ns)
+);
+
 #endif /* _AMDGPU_DM_TRACE_H_ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
