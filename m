Return-Path: <SRS0=DbcS=A4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CF4C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC6420737
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PlR3lYde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC6420737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 544DD6EE19;
	Fri, 17 Jul 2020 17:38:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 618E76EE15
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2020 17:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V23T0u87xX2GiIyz7sc95HRECDruBMVrtMOYkL/VZLYOflfSsu3RtZvXPaHNsce9reS1AcOoynSIbcWoZo0BKhria5ZpgGHf3oIr/97xh60+ixWmwZyk4RNGHcSlLOqAy1NZ4tTg8ohvCnYT+Oj2xkDi5BjfAF/5qQZCAwvdDc8s7bknARlGhYw/fSYlo8aYTEk6idF2D3W4Wrvp6FWTmflPu+zqoHGmZa0WT5R+lG29HXi07Z6HLcZgrodqe0tTRTraUsX+JMehj/bE4Pr2vya2vVVMfPIJr+2bvOtqIEJZPPvhb7Sr7e2catrWO8dyZk0lPe9FnQp4hhSTmBvS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN4kQd1bX2Kl/29tC3aBXnmOvuOTVoenpSF7pkzyxyM=;
 b=Y70+bLWwsuJsADqgMIMLP76bnS/HBoL0DwM7rsgCWzll7+ZPJgtHJbghCJoW85EA2og4fgpCnc1tvxd/o23MlDhgEqzidVLjN7yl81KBGLWdQLDo24hsLPJ8GzcBtAP3v0tOXCsrP5tuA3Y8yuUDFfGtnKRDGVXHMaYa2KBMiDksTsBXOF/xuXqcX1Eb/GA0oTkBw6ADRXRoRFjWxnM0ehro1FK3AzfeH9IYT3yy/FgihU7BI1e67e/o7I9/jLzSFMFIpdzpUDZOWI/iYB/JoCiCGP8TMu1SJafKimbIxYd0jL94l4dU2wPHGYb8XOQX+y9alnuwD+ZHlc/ybh2UyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN4kQd1bX2Kl/29tC3aBXnmOvuOTVoenpSF7pkzyxyM=;
 b=PlR3lYde++wbJ+tJ4hvc4CwQPHOR9NNM8tpsvOobpCd4rakAu2bvP9MO/XQr7R8E3m9hv2NFvvD9QIq4lX4U8pLGVbc51TLPpVlxSyVz9YaK1bY/yXnNtxxHJW7A/VEd5U1C785fJ9C9cvBMrvAmuv6g48KZWGI/M9Mr7Ptcq70=
Received: from CO2PR05CA0102.namprd05.prod.outlook.com (2603:10b6:104:1::28)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 17 Jul
 2020 17:38:22 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::e0) by CO2PR05CA0102.outlook.office365.com
 (2603:10b6:104:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.14 via Frontend
 Transport; Fri, 17 Jul 2020 17:38:21 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 17:38:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:20 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:20 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 17 Jul 2020 12:38:14 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/12] drm/amd/display: Add DSC parameters logging to debugfs
Date: Fri, 17 Jul 2020 13:38:03 -0400
Message-ID: <20200717173813.11674-3-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717173813.11674-1-qingqing.zhuo@amd.com>
References: <20200717173813.11674-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966005)(54906003)(2906002)(6666004)(8936002)(316002)(8676002)(36756003)(5660300002)(426003)(1076003)(81166007)(82310400002)(44832011)(2616005)(336012)(356005)(70206006)(478600001)(70586007)(86362001)(4326008)(6916009)(83380400001)(82740400003)(186003)(30864003)(47076004)(26005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a12fe54-8e96-4001-359f-08d82a783336
X-MS-TrafficTypeDiagnostic: CH2PR12MB4326:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4326F3641552A62D3F7348DEFB7C0@CH2PR12MB4326.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:113;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umyzN16yo33lFpD9e378OXRDTbPyF4r5v3s2aBXGr13+fAlrmamF0hN/3RFCGRS89Gad3z1t1zvvl0z/9eVtszG/1tsKIMD9zvehYmgTaps7LKwC6Y/0TVnL2CbiWu3e5TGSLi2AUEQnBdt9VniR32HsBG4ClXGN0WD/trSMu2Zt5J+iAR8EmBu6lJ2Vb/jWy2zIywWVj1kI8KLq0PPdbvYZ+9tXjufLr8JDq1fJDKVe/ELF7ZkGGp7rfAXm9ATylM7Ca5pTfs62QioNVo/6vwbMBL41xjMYCGEx4teR+uKlstdijIG24xyAHWQquyV/FNSVB/kBc2UKMs3GJJiJ3W1R2aybgKvZyYi7kPsx9JMrxi0iJIzE4efU14prBxlrI/m8MC8zxd+0VIOEUQTvhQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 17:38:21.4968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a12fe54-8e96-4001-359f-08d82a783336
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eryk Brol <eryk.brol@amd.com>

[why]
Need to add new parameters to debugfs logging so
we will know what parameters DSC is using for
debug purposes. So we are adding a read function
in debugfs to read DSC status registers

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 516 +++++++++++++++++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c  |   5 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h   |   5 +
 3 files changed, 525 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index caf3beaf4b7b..8bbf54ffe01b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -33,6 +33,8 @@
 #include "amdgpu_dm_debugfs.h"
 #include "dm_helpers.h"
 #include "dmub/dmub_srv.h"
+#include "resource.h"
+#include "dsc.h"
 
 struct dmub_debugfs_trace_header {
 	uint32_t entry_count;
@@ -995,6 +997,462 @@ static ssize_t dp_dpcd_data_read(struct file *f, char __user *buf,
 	return read_size - r;
 }
 
+static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
+				    size_t size, loff_t *pos)
+{
+	char *rd_buf = NULL;
+	char *rd_buf_ptr = NULL;
+	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	struct display_stream_compressor *dsc;
+	struct dcn_dsc_state dsc_state = {0};
+	const uint32_t rd_buf_size = 10;
+	struct pipe_ctx *pipe_ctx;
+	ssize_t result = 0;
+	int i, r, str_len = 30;
+
+	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
+
+	if (!rd_buf)
+		return -ENOMEM;
+
+	rd_buf_ptr = rd_buf;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+			if (pipe_ctx && pipe_ctx->stream &&
+			    pipe_ctx->stream->link == aconnector->dc_link)
+				break;
+	}
+
+	if (!pipe_ctx)
+		return -ENXIO;
+
+	dsc = pipe_ctx->stream_res.dsc;
+	if (dsc)
+		dsc->funcs->dsc_read_state(dsc, &dsc_state);
+
+	snprintf(rd_buf_ptr, str_len,
+		"%d\n",
+		dsc_state.dsc_clock_en);
+	rd_buf_ptr += str_len;
+
+	while (size) {
+		if (*pos >= rd_buf_size)
+			break;
+
+		r = put_user(*(rd_buf + result), buf);
+		if (r)
+			return r; /* r = -EFAULT */
+
+		buf += 1;
+		size -= 1;
+		*pos += 1;
+		result += 1;
+	}
+
+	kfree(rd_buf);
+	return result;
+}
+
+static ssize_t dp_dsc_slice_width_read(struct file *f, char __user *buf,
+				    size_t size, loff_t *pos)
+{
+	char *rd_buf = NULL;
+	char *rd_buf_ptr = NULL;
+	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	struct display_stream_compressor *dsc;
+	struct dcn_dsc_state dsc_state = {0};
+	const uint32_t rd_buf_size = 100;
+	struct pipe_ctx *pipe_ctx;
+	ssize_t result = 0;
+	int i, r, str_len = 30;
+
+	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
+
+	if (!rd_buf)
+		return -ENOMEM;
+
+	rd_buf_ptr = rd_buf;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+			if (pipe_ctx && pipe_ctx->stream &&
+			    pipe_ctx->stream->link == aconnector->dc_link)
+				break;
+	}
+
+	if (!pipe_ctx)
+		return -ENXIO;
+
+	dsc = pipe_ctx->stream_res.dsc;
+	if (dsc)
+		dsc->funcs->dsc_read_state(dsc, &dsc_state);
+
+	snprintf(rd_buf_ptr, str_len,
+		"%d\n",
+		dsc_state.dsc_slice_width);
+	rd_buf_ptr += str_len;
+
+	while (size) {
+		if (*pos >= rd_buf_size)
+			break;
+
+		r = put_user(*(rd_buf + result), buf);
+		if (r)
+			return r; /* r = -EFAULT */
+
+		buf += 1;
+		size -= 1;
+		*pos += 1;
+		result += 1;
+	}
+
+	kfree(rd_buf);
+	return result;
+}
+
+static ssize_t dp_dsc_slice_height_read(struct file *f, char __user *buf,
+				    size_t size, loff_t *pos)
+{
+	char *rd_buf = NULL;
+	char *rd_buf_ptr = NULL;
+	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	struct display_stream_compressor *dsc;
+	struct dcn_dsc_state dsc_state = {0};
+	const uint32_t rd_buf_size = 100;
+	struct pipe_ctx *pipe_ctx;
+	ssize_t result = 0;
+	int i, r, str_len = 30;
+
+	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
+
+	if (!rd_buf)
+		return -ENOMEM;
+
+	rd_buf_ptr = rd_buf;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+			if (pipe_ctx && pipe_ctx->stream &&
+			    pipe_ctx->stream->link == aconnector->dc_link)
+				break;
+	}
+
+	if (!pipe_ctx)
+		return -ENXIO;
+
+	dsc = pipe_ctx->stream_res.dsc;
+	if (dsc)
+		dsc->funcs->dsc_read_state(dsc, &dsc_state);
+
+	snprintf(rd_buf_ptr, str_len,
+		"%d\n",
+		dsc_state.dsc_slice_height);
+	rd_buf_ptr += str_len;
+
+	while (size) {
+		if (*pos >= rd_buf_size)
+			break;
+
+		r = put_user(*(rd_buf + result), buf);
+		if (r)
+			return r; /* r = -EFAULT */
+
+		buf += 1;
+		size -= 1;
+		*pos += 1;
+		result += 1;
+	}
+
+	kfree(rd_buf);
+	return result;
+}
+
+static ssize_t dp_dsc_bytes_per_pixel_read(struct file *f, char __user *buf,
+				    size_t size, loff_t *pos)
+{
+	char *rd_buf = NULL;
+	char *rd_buf_ptr = NULL;
+	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	struct display_stream_compressor *dsc;
+	struct dcn_dsc_state dsc_state = {0};
+	const uint32_t rd_buf_size = 100;
+	struct pipe_ctx *pipe_ctx;
+	ssize_t result = 0;
+	int i, r, str_len = 30;
+
+	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
+
+	if (!rd_buf)
+		return -ENOMEM;
+
+	rd_buf_ptr = rd_buf;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+			if (pipe_ctx && pipe_ctx->stream &&
+			    pipe_ctx->stream->link == aconnector->dc_link)
+				break;
+	}
+
+	if (!pipe_ctx)
+		return -ENXIO;
+
+	dsc = pipe_ctx->stream_res.dsc;
+	if (dsc)
+		dsc->funcs->dsc_read_state(dsc, &dsc_state);
+
+	snprintf(rd_buf_ptr, str_len,
+		"%d\n",
+		dsc_state.dsc_bytes_per_pixel);
+	rd_buf_ptr += str_len;
+
+	while (size) {
+		if (*pos >= rd_buf_size)
+			break;
+
+		r = put_user(*(rd_buf + result), buf);
+		if (r)
+			return r; /* r = -EFAULT */
+
+		buf += 1;
+		size -= 1;
+		*pos += 1;
+		result += 1;
+	}
+
+	kfree(rd_buf);
+	return result;
+}
+
+static ssize_t dp_dsc_pic_width_read(struct file *f, char __user *buf,
+				    size_t size, loff_t *pos)
+{
+	char *rd_buf = NULL;
+	char *rd_buf_ptr = NULL;
+	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	struct display_stream_compressor *dsc;
+	struct dcn_dsc_state dsc_state = {0};
+	const uint32_t rd_buf_size = 100;
+	struct pipe_ctx *pipe_ctx;
+	ssize_t result = 0;
+	int i, r, str_len = 30;
+
+	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
+
+	if (!rd_buf)
+		return -ENOMEM;
+
+	rd_buf_ptr = rd_buf;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+			if (pipe_ctx && pipe_ctx->stream &&
+			    pipe_ctx->stream->link == aconnector->dc_link)
+				break;
+	}
+
+	if (!pipe_ctx)
+		return -ENXIO;
+
+	dsc = pipe_ctx->stream_res.dsc;
+	if (dsc)
+		dsc->funcs->dsc_read_state(dsc, &dsc_state);
+
+	snprintf(rd_buf_ptr, str_len,
+		"%d\n",
+		dsc_state.dsc_pic_width);
+	rd_buf_ptr += str_len;
+
+	while (size) {
+		if (*pos >= rd_buf_size)
+			break;
+
+		r = put_user(*(rd_buf + result), buf);
+		if (r)
+			return r; /* r = -EFAULT */
+
+		buf += 1;
+		size -= 1;
+		*pos += 1;
+		result += 1;
+	}
+
+	kfree(rd_buf);
+	return result;
+}
+
+static ssize_t dp_dsc_pic_height_read(struct file *f, char __user *buf,
+				    size_t size, loff_t *pos)
+{
+	char *rd_buf = NULL;
+	char *rd_buf_ptr = NULL;
+	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	struct display_stream_compressor *dsc;
+	struct dcn_dsc_state dsc_state = {0};
+	const uint32_t rd_buf_size = 100;
+	struct pipe_ctx *pipe_ctx;
+	ssize_t result = 0;
+	int i, r, str_len = 30;
+
+	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
+
+	if (!rd_buf)
+		return -ENOMEM;
+
+	rd_buf_ptr = rd_buf;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+			if (pipe_ctx && pipe_ctx->stream &&
+			    pipe_ctx->stream->link == aconnector->dc_link)
+				break;
+	}
+
+	if (!pipe_ctx)
+		return -ENXIO;
+
+	dsc = pipe_ctx->stream_res.dsc;
+	if (dsc)
+		dsc->funcs->dsc_read_state(dsc, &dsc_state);
+
+	snprintf(rd_buf_ptr, str_len,
+		"%d\n",
+		dsc_state.dsc_pic_height);
+	rd_buf_ptr += str_len;
+
+	while (size) {
+		if (*pos >= rd_buf_size)
+			break;
+
+		r = put_user(*(rd_buf + result), buf);
+		if (r)
+			return r; /* r = -EFAULT */
+
+		buf += 1;
+		size -= 1;
+		*pos += 1;
+		result += 1;
+	}
+
+	kfree(rd_buf);
+	return result;
+}
+
+static ssize_t dp_dsc_chunk_size_read(struct file *f, char __user *buf,
+				    size_t size, loff_t *pos)
+{
+	char *rd_buf = NULL;
+	char *rd_buf_ptr = NULL;
+	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	struct display_stream_compressor *dsc;
+	struct dcn_dsc_state dsc_state = {0};
+	const uint32_t rd_buf_size = 100;
+	struct pipe_ctx *pipe_ctx;
+	ssize_t result = 0;
+	int i, r, str_len = 30;
+
+	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
+
+	if (!rd_buf)
+		return -ENOMEM;
+
+	rd_buf_ptr = rd_buf;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+			if (pipe_ctx && pipe_ctx->stream &&
+			    pipe_ctx->stream->link == aconnector->dc_link)
+				break;
+	}
+
+	if (!pipe_ctx)
+		return -ENXIO;
+
+	dsc = pipe_ctx->stream_res.dsc;
+	if (dsc)
+		dsc->funcs->dsc_read_state(dsc, &dsc_state);
+
+	snprintf(rd_buf_ptr, str_len,
+		"%d\n",
+		dsc_state.dsc_chunk_size);
+	rd_buf_ptr += str_len;
+
+	while (size) {
+		if (*pos >= rd_buf_size)
+			break;
+
+		r = put_user(*(rd_buf + result), buf);
+		if (r)
+			return r; /* r = -EFAULT */
+
+		buf += 1;
+		size -= 1;
+		*pos += 1;
+		result += 1;
+	}
+
+	kfree(rd_buf);
+	return result;
+}
+
+static ssize_t dp_dsc_slice_bpg_offset_read(struct file *f, char __user *buf,
+				    size_t size, loff_t *pos)
+{
+	char *rd_buf = NULL;
+	char *rd_buf_ptr = NULL;
+	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	struct display_stream_compressor *dsc;
+	struct dcn_dsc_state dsc_state = {0};
+	const uint32_t rd_buf_size = 100;
+	struct pipe_ctx *pipe_ctx;
+	ssize_t result = 0;
+	int i, r, str_len = 30;
+
+	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
+
+	if (!rd_buf)
+		return -ENOMEM;
+
+	rd_buf_ptr = rd_buf;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+			if (pipe_ctx && pipe_ctx->stream &&
+			    pipe_ctx->stream->link == aconnector->dc_link)
+				break;
+	}
+
+	if (!pipe_ctx)
+		return -ENXIO;
+
+	dsc = pipe_ctx->stream_res.dsc;
+	if (dsc)
+		dsc->funcs->dsc_read_state(dsc, &dsc_state);
+
+	snprintf(rd_buf_ptr, str_len,
+		"%d\n",
+		dsc_state.dsc_slice_bpg_offset);
+	rd_buf_ptr += str_len;
+
+	while (size) {
+		if (*pos >= rd_buf_size)
+			break;
+
+		r = put_user(*(rd_buf + result), buf);
+		if (r)
+			return r; /* r = -EFAULT */
+
+		buf += 1;
+		size -= 1;
+		*pos += 1;
+		result += 1;
+	}
+
+	kfree(rd_buf);
+	return result;
+}
+
 DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
 DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
 DEFINE_SHOW_ATTRIBUTE(output_bpc);
@@ -1003,6 +1461,54 @@ DEFINE_SHOW_ATTRIBUTE(vrr_range);
 DEFINE_SHOW_ATTRIBUTE(hdcp_sink_capability);
 #endif
 
+static const struct file_operations dp_dsc_clock_en_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.read = dp_dsc_clock_en_read,
+	.llseek = default_llseek
+};
+
+static const struct file_operations dp_dsc_slice_width_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.read = dp_dsc_slice_width_read,
+	.llseek = default_llseek
+};
+
+static const struct file_operations dp_dsc_slice_height_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.read = dp_dsc_slice_height_read,
+	.llseek = default_llseek
+};
+
+static const struct file_operations dp_dsc_bytes_per_pixel_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.read = dp_dsc_bytes_per_pixel_read,
+	.llseek = default_llseek
+};
+
+static const struct file_operations dp_dsc_pic_width_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.read = dp_dsc_pic_width_read,
+	.llseek = default_llseek
+};
+
+static const struct file_operations dp_dsc_pic_height_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.read = dp_dsc_pic_height_read,
+	.llseek = default_llseek
+};
+
+static const struct file_operations dp_dsc_chunk_size_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.read = dp_dsc_chunk_size_read,
+	.llseek = default_llseek
+};
+
+static const struct file_operations dp_dsc_slice_bpg_offset_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.read = dp_dsc_slice_bpg_offset_read,
+	.llseek = default_llseek
+};
+
 static const struct file_operations dp_link_settings_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.read = dp_link_settings_read,
@@ -1062,7 +1568,15 @@ static const struct {
 		{"sdp_message", &sdp_message_fops},
 		{"aux_dpcd_address", &dp_dpcd_address_debugfs_fops},
 		{"aux_dpcd_size", &dp_dpcd_size_debugfs_fops},
-		{"aux_dpcd_data", &dp_dpcd_data_debugfs_fops}
+		{"aux_dpcd_data", &dp_dpcd_data_debugfs_fops},
+		{"dsc_clock_en", &dp_dsc_clock_en_debugfs_fops},
+		{"dsc_slice_width", &dp_dsc_slice_width_debugfs_fops},
+		{"dsc_slice_height", &dp_dsc_slice_height_debugfs_fops},
+		{"dsc_bytes_per_pixel", &dp_dsc_bytes_per_pixel_debugfs_fops},
+		{"dsc_pic_width", &dp_dsc_pic_width_debugfs_fops},
+		{"dsc_pic_height", &dp_dsc_pic_height_debugfs_fops},
+		{"dsc_chunk_size", &dp_dsc_chunk_size_debugfs_fops},
+		{"dsc_slice_bpg", &dp_dsc_slice_bpg_offset_debugfs_fops}
 };
 
 #ifdef CONFIG_DRM_AMD_DC_HDCP
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
index 3c6ecfe141bb..ba50214d6c32 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
@@ -157,6 +157,11 @@ static void dsc2_read_state(struct display_stream_compressor *dsc, struct dcn_ds
 	REG_GET(DSC_TOP_CONTROL, DSC_CLOCK_EN, &s->dsc_clock_en);
 	REG_GET(DSCC_PPS_CONFIG3, SLICE_WIDTH, &s->dsc_slice_width);
 	REG_GET(DSCC_PPS_CONFIG1, BITS_PER_PIXEL, &s->dsc_bytes_per_pixel);
+	REG_GET(DSCC_PPS_CONFIG3, SLICE_HEIGHT, &s->dsc_slice_height);
+	REG_GET(DSCC_PPS_CONFIG1, CHUNK_SIZE, &s->dsc_chunk_size);
+	REG_GET(DSCC_PPS_CONFIG2, PIC_WIDTH, &s->dsc_pic_width);
+	REG_GET(DSCC_PPS_CONFIG2, PIC_HEIGHT, &s->dsc_pic_height);
+	REG_GET(DSCC_PPS_CONFIG7, SLICE_BPG_OFFSET, &s->dsc_slice_bpg_offset);
 }
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
index 7c2a3328b208..5915994f9eb8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
@@ -56,6 +56,11 @@ struct dcn_dsc_state {
 	uint32_t dsc_clock_en;
 	uint32_t dsc_slice_width;
 	uint32_t dsc_bytes_per_pixel;
+	uint32_t dsc_slice_height;
+	uint32_t dsc_pic_width;
+	uint32_t dsc_pic_height;
+	uint32_t dsc_slice_bpg_offset;
+	uint32_t dsc_chunk_size;
 };
 
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
