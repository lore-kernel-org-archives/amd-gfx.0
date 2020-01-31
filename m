Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553C6C2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2232620CC7
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lX/C8qxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2232620CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7FEF6FC32;
	Fri, 31 Jan 2020 22:17:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F7676FC32
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBc4T1B2l41qURf0c8W4SOObMaewU6hxc8+RrbM+XtYWc8/GXAb2bVAXbDtAER17qE9tS+4OGb7rcDE3SyxWJZ4U7krWaqp6Dxn6Uzdt33N8O2H9iIxCweWVptMlJ+26TFQZnGyJNq+bus4dIRqwo2NDwaWKAwga/y/LSGJKNg38x33bccwdJPbOVCdBRP2JtrBqu4fiNczXHfiCNChmbwxRRNYRUULJ7FUUF0phlBfZMAKtn+PzOSjPtJJunMwlQEqlBMnqQryyDgEKPAbhkWKrWXHXQg8K/MMf82ByUj1tkGJkL2j/8FLrZyznpmAljDRMQxfsGefwFb8cw0JeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DsiV5E851HhppDIIF2+4GF6SmTQW+z7jusGNZWj5Sw=;
 b=oNpyLKEy9MDwcvOSr3NWS6BvqqXT0bEq/LxnpoZNIU/FLysp8NtjphRWV+PBYeaHTicHOEfy1+kbkrLjUxiX2Y99IISF5fKzPTxZfCBX0lzHOQRpmOwRMp+3689x9In6lDj+a49RRPAL1V7fCjXCSd7H7TY50B1GZtBkNruFRrlupGkminP2bbOjdn9SMbwcuA0/DtvdnW2VW5PXx/Yy4Yz61SV7xwEoEQgSWBo54h8MzVj73G0fLeep9d82lvSWe0R+02C/5mHsmRk94Mgb5qnbYpnsbO6wB82GIsMGV88HFg4n7l20YR8kgwa7K0TMKROD6gToaamGwcnBQPTkrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DsiV5E851HhppDIIF2+4GF6SmTQW+z7jusGNZWj5Sw=;
 b=lX/C8qxxTcA5NHIwFP3JeEJH7qGkDYAvsCJFz9bSUQzi+9meWmgYFGRj9chhypSuMWj5tIa34I2GluoH4r2+GPGQsysgn5F6G6Qd8lmDyzt8L8+yf6whLfHGoMgzBcX/KByvdCoOvvdbR1ia+j7lrGAWY9l/9ux0F4IJhtsZnjk=
Received: from BN6PR1201CA0012.namprd12.prod.outlook.com
 (2603:10b6:405:4c::22) by MWHPR12MB1197.namprd12.prod.outlook.com
 (2603:10b6:300:f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.28; Fri, 31 Jan
 2020 22:17:04 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::207) by BN6PR1201CA0012.outlook.office365.com
 (2603:10b6:405:4c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:04 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:03 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:03 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:02 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/33] drm/amd/display: Indicate dsc updates explicitly
Date: Fri, 31 Jan 2020 17:16:17 -0500
Message-ID: <20200131221643.10035-8-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(428003)(189003)(199004)(7696005)(356004)(8936002)(86362001)(36756003)(15650500001)(316002)(2616005)(54906003)(5660300002)(81166006)(81156014)(4326008)(2906002)(6916009)(6666004)(26005)(70586007)(478600001)(8676002)(336012)(426003)(1076003)(186003)(70206006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1197; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caf00a10-68e7-49b0-ed78-08d7a69b4d5a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1197:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1197A5F3EA0F2710ACC76897F9070@MWHPR12MB1197.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:343;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oKDUar16dOewriuxfLW8D9MS8rwoubYZjW+JAYVGy0EJF55ah/gQAQTxe56lI9FzQCW3S9HtS5k4degSfBCxPhThrC07s+ayfLF8keg6KEmC9clmAUJXJCLpXbaGVOY2xy++ySYykXFj/2ioZ9rMBSLX2IMXWFNrmIN8g6hgf0V4hS5Ph8GdBQziL/j9bBF8xcn0Dy0E7pBWnWTOfdvnRy4Bpmutk96056SiEDZkP0AnLZhdXCd9hI2juov/0QImTw8DYYEX5pQuqu4dtRMBV2s5zd65q0BpUIbIj6nT3oo77OA6z0wwluPQ1Gc3/pv6qH2UdEPwN5D1ItIeNgafC6KjrLZjx3r7n+4SHOyV3vADcMyx8Rn+uKCQ0nf+oftgff+axAuB2RlZi+eRg8gPBP+O1wUVfy8eQx1rOFLmOu5/hzRF8Qmy/XWnP6+Xf2+E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:04.3739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caf00a10-68e7-49b0-ed78-08d7a69b4d5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1197
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why]
DSC updates only set type to FULL UPDATE, but doesn't
flag the change

[How]
Add DSC flag update flag

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c   | 19 ++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dc_stream.h |  1 +
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 738ba91220df..c9c7cf00976f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1738,14 +1738,15 @@ static enum surface_update_type check_update_surfaces_for_stream(
 
 		if (stream_update->wb_update)
 			su_flags->bits.wb_update = 1;
+
+		if (stream_update->dsc_config)
+			su_flags->bits.dsc_changed = 1;
+
 		if (su_flags->raw != 0)
 			overall_type = UPDATE_TYPE_FULL;
 
 		if (stream_update->output_csc_transform || stream_update->output_color_space)
 			su_flags->bits.out_csc = 1;
-
-		if (stream_update->dsc_config)
-			overall_type = UPDATE_TYPE_FULL;
 	}
 
 	for (i = 0 ; i < surface_count; i++) {
@@ -1780,8 +1781,11 @@ enum surface_update_type dc_check_update_surfaces_for_stream(
 
 	type = check_update_surfaces_for_stream(dc, updates, surface_count, stream_update, stream_status);
 	if (type == UPDATE_TYPE_FULL) {
-		if (stream_update)
+		if (stream_update) {
+			uint32_t dsc_changed = stream_update->stream->update_flags.bits.dsc_changed;
 			stream_update->stream->update_flags.raw = 0xFFFFFFFF;
+			stream_update->stream->update_flags.bits.dsc_changed = dsc_changed;
+		}
 		for (i = 0; i < surface_count; i++)
 			updates[i].surface->update_flags.raw = 0xFFFFFFFF;
 	}
@@ -2097,14 +2101,15 @@ static void commit_planes_do_stream_update(struct dc *dc,
 				}
 			}
 
+			/* Full fe update*/
+			if (update_type == UPDATE_TYPE_FAST)
+				continue;
+
 			if (stream_update->dsc_config && dc->hwss.pipe_control_lock_global) {
 				dc->hwss.pipe_control_lock_global(dc, pipe_ctx, true);
 				dp_update_dsc_config(pipe_ctx);
 				dc->hwss.pipe_control_lock_global(dc, pipe_ctx, false);
 			}
-			/* Full fe update*/
-			if (update_type == UPDATE_TYPE_FAST)
-				continue;
 
 			if (stream_update->dpms_off) {
 				dc->hwss.pipe_control_lock(dc, pipe_ctx, true);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 92096de79dec..a5c7ef47b8d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -118,6 +118,7 @@ union stream_update_flags {
 		uint32_t dpms_off:1;
 		uint32_t gamut_remap:1;
 		uint32_t wb_update:1;
+		uint32_t dsc_changed : 1;
 	} bits;
 
 	uint32_t raw;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
