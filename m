Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AC7C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD3242071C
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tcxMpXWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3242071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A462C89BF1;
	Mon, 25 May 2020 18:13:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED1F289BC2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 18:13:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1mWCYf7VssMavIoqcbvOX/S48vDFbfJkEP0i0hjjkCq69+xtyjm6mm3UPmHuX0cgthzlYLc/hYXWRmgbrmMNO3orM+EeQsVG44XnG4+RIVA+WzyKnIY/wRNf4B3qo4Hdsx6Xswz3oLnC/sSFbhtrMlswm556ug1zcB9TktVdWJb/p8CRnr8UYTEcPIZMPSRGoh2J6Y+YML5HzKHArND8/Sljw64qM51IKFrO3vTFjzq2rfKxbg9ifU9tXPRN7sK5NEjKgCVHL8iA0vuInit6Cxjn27wCfCWio046tcEVdtkcFw7wnkCKMXmmuz2tMNfLIC+mmm5idQPI0eZgJXgsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XMJafdPeQ/cZqjrCqYh3/NHMWixD9WGkhs3B0db1xU=;
 b=T7rFsWgz3hJIBnxzjZSRiZzRQ6lAF5ZBjNjaFVWQSjNw8DtGiqY/sfaHcVdNpwDzkavcDUWtWNmlsGqUxKZsxsev+cdHfZ7fjcrqWK0YzyQ+9iYonZfE49TApCi1/ic4UrO5ZSkiGohbN44shxbqPPyzU8fBQz0XqcpYQxA7Wu9ZKNx+dS/o2LNoUiVxVvvN4kvwKsWtAKBO6iZSLu7112yIhmXpiB318Cor4I7mDerWrpr1sN4+f/shzABUNmVMJR1mr6G/qUXDq+UJzy6+Qo8GUVlWhIg5uC1EJICwRdlj4P2RkvGRTAPQpivPLkmPUknc5n1+e+i70Nh7/wn7Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XMJafdPeQ/cZqjrCqYh3/NHMWixD9WGkhs3B0db1xU=;
 b=tcxMpXWNN/mq/Jbnshc7YNTOXWctQC4SLujNH2UxIlSCb90rl7oQhOrIvWh7J+vigVi1/5eENrWLrrnpI6/HwzXwH4G1t57X/apbKEPUQFbNHvcbj+AMIF9MMiQ947WRCmbD/tAPdQ7HdxRJQsC7eyQ2SPjMiz8DPbhng7IqSO8=
Received: from DM6PR02CA0055.namprd02.prod.outlook.com (2603:10b6:5:177::32)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Mon, 25 May
 2020 18:13:11 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::59) by DM6PR02CA0055.outlook.office365.com
 (2603:10b6:5:177::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26 via Frontend
 Transport; Mon, 25 May 2020 18:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 18:13:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:09 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:09 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 25 May 2020 13:13:08 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/16] drm/amd/display: Fix incorrect HDCP caps for dongle
Date: Mon, 25 May 2020 14:12:53 -0400
Message-ID: <20200525181306.3749-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525181306.3749-1-qingqing.zhuo@amd.com>
References: <20200525181306.3749-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966005)(316002)(26005)(4326008)(186003)(8936002)(86362001)(44832011)(70586007)(70206006)(8676002)(1076003)(5660300002)(47076004)(6666004)(54906003)(356005)(478600001)(6916009)(36756003)(82310400002)(336012)(81166007)(82740400003)(426003)(2616005)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb2a3811-40f2-48fc-5638-08d800d74881
X-MS-TrafficTypeDiagnostic: MN2PR12MB4301:
X-Microsoft-Antispam-PRVS: <MN2PR12MB430144C14EC2924BB52F9A71FBB30@MN2PR12MB4301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: soZcZaAw47O1sf+Em3XkrDZfvLPuxYAxfMXXHETkspceNLrHoo3MFoSFro+MEnRSpPEBdsGs71QYvTjjStZa/I/zby7zE9VIQmuDmpHehcuzDhHzRulfUx/NgIrg/zuT4t+bwWDYasR/6X0O8TbGc+CpgNrRmmOhQ+Z6wdrNoI5PdY97SqKk1s7BritUnUD5gRGJDznudbsz4cY+DkmhTjVqAcEhmZNkz1IT1XLVEAEo13uujD2EWG2TQZjjyCjeUVfRuyacJRL1JZ9C35Xi7SJHj/sTk41258jzFk+A3SNMMN/b5uFaTQBepdQP6kt0Z8b9GWuup8BB66bIrr64rt7Mo/P5z7z7dGUJYtgS9x/jP0q91BS8woM3l8K9/yK5N3NIVtQzhXqATEKbEP0Qwg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 18:13:10.6340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2a3811-40f2-48fc-5638-08d800d74881
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com, Aurabindo.Pillai@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

[Why]
Previously we used link signal type to get the caps. We should use the
sink signal type

[How]
Use sink signal type instead of link signal type

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c             | 8 ++++----
 drivers/gpu/drm/amd/display/dc/dc_link.h                  | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 076af267b488..7b8968baaeb9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -859,8 +859,8 @@ static int hdcp_sink_capability_show(struct seq_file *m, void *data)
 
 	seq_printf(m, "%s:%d HDCP version: ", connector->name, connector->base.id);
 
-	hdcp_cap = dc_link_is_hdcp14(aconnector->dc_link);
-	hdcp2_cap = dc_link_is_hdcp22(aconnector->dc_link);
+	hdcp_cap = dc_link_is_hdcp14(aconnector->dc_link, aconnector->dc_sink->sink_signal);
+	hdcp2_cap = dc_link_is_hdcp22(aconnector->dc_link, aconnector->dc_sink->sink_signal);
 
 
 	if (hdcp_cap)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index d80b2de3ee82..c00f656e22ff 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -521,11 +521,11 @@ static void link_disconnect_remap(struct dc_sink *prev_sink, struct dc_link *lin
 }
 
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
-bool dc_link_is_hdcp14(struct dc_link *link)
+bool dc_link_is_hdcp14(struct dc_link *link, enum signal_type signal)
 {
 	bool ret = false;
 
-	switch (link->connector_signal)	{
+	switch (signal)	{
 	case SIGNAL_TYPE_DISPLAY_PORT:
 	case SIGNAL_TYPE_DISPLAY_PORT_MST:
 		ret = link->hdcp_caps.bcaps.bits.HDCP_CAPABLE;
@@ -545,11 +545,11 @@ bool dc_link_is_hdcp14(struct dc_link *link)
 	return ret;
 }
 
-bool dc_link_is_hdcp22(struct dc_link *link)
+bool dc_link_is_hdcp22(struct dc_link *link, enum signal_type signal)
 {
 	bool ret = false;
 
-	switch (link->connector_signal)	{
+	switch (signal)	{
 	case SIGNAL_TYPE_DISPLAY_PORT:
 	case SIGNAL_TYPE_DISPLAY_PORT_MST:
 		ret = (link->hdcp_caps.bcaps.bits.HDCP_CAPABLE &&
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 5c60c2f9779a..aec514e52e4d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -312,8 +312,8 @@ bool dc_link_detect_sink(struct dc_link *link, enum dc_connection_type *type);
  */
 
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-bool dc_link_is_hdcp14(struct dc_link *link);
-bool dc_link_is_hdcp22(struct dc_link *link);
+bool dc_link_is_hdcp14(struct dc_link *link, enum signal_type signal);
+bool dc_link_is_hdcp22(struct dc_link *link, enum signal_type signal);
 #endif
 void dc_link_set_drive_settings(struct dc *dc,
 				struct link_training_settings *lt_settings,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
