Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C95C33CA3
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4B12082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yMQGjiPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4B12082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AFED6EA2E;
	Fri, 10 Jan 2020 14:47:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53F656EA3D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFfRTfYBYKxa3TrCmGo9Y/P8IqjSeGfAjy+IW+SA7VcnOzO6phksr1o8l4FSFOUiWEi4hQwO/cknB0IaCYZe7noZVwIB4X+8UWSojL6R5reWev3agrxuuFARXP07xP8AuTpiY+DnarCrD6JrveeRFfmqre6P/4XO0ZJ/DcB8vDvYHfNB67+oOj+jMOR6HTEbkfzRbgEs27SCR9/SjpCp1YHX9zA8as+MxLjvoaSB/WPjQYlqnhlMt+aBwVqmK+h0jz+wXXvLEEl4qa7QLoe3gY9G8oahrIlkGN1jFg02xSQeD/aJyBQDcWFNKt+uaW7ZYGGAYohE08PKSiKNfW/HWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vmz6oBhm13vFc1oMg0rJII9XbLr+4glGb210cMKJRy0=;
 b=YG3MQw2PR2fsExHCVFXSKUE5ltASrv1V9ZJ/VBPnVDxTaXAEzsgwrn6hvBCCC3p8rGB0zIjirbjQ62zWWJwDqkOo6VTbeWUraxCnT8ZSZvFqsHiqBxAvyf3R7qac1JxsDT9ZzwowkpoXyLhHGjUPrk/rTSK6V0JURsYrQ07D78nu3oaYa+s62iMzcWlLZCIocJ/Z6GRv93x1j5STOg4w2J8yNuRB86PX69wv1+19BFrwF71ye15kWGHRS8T0INDmYet4H+qqx/co8RcP8BzRoNk0xYR6clrQyEv9DILhE1MBZWXhT7FCiNoxACrbXSAifsrjqNm5ans2+ZBgSQfjMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vmz6oBhm13vFc1oMg0rJII9XbLr+4glGb210cMKJRy0=;
 b=yMQGjiPRA1ZJNmmJVcQSdc6E8PyjpdjG6ANH+Y5x0iYey/CG/tzf9GYXbItnZPx0dK7tnhaWajvONwCA86KwiXoeknorKeaDRYhXeY2zJcfzklX4yBNS3hNK19gx6p1W6Diw5th87S57SW0jl3UJyjrn3U4ek4daw0tEGs/jURg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:34 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:34 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/43] drm/amd/display: stop doing unnecessary detection when
 going to D3
Date: Fri, 10 Jan 2020 09:46:28 -0500
Message-Id: <20200110144655.55845-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:34 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa797c91-148e-4ab6-65fd-08d795dc0775
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2524A08795227FDEFE1B8B7A98380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:199;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(5660300002)(6916009)(54906003)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(956004)(7696005)(52116002)(478600001)(186003)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbXzmn59zOv7yslKnTOuwJzjpwTtN/+eP60Ua1tE+QCFh5IVK0oHdTsX/hd8h0pSk4L6FLT595WH2gM5hbGwxzHzFuFrPXSGyPjNsU3tOPJ9CB/Pf5liCfRrKrf2VOtTKgTE0pl72ZmjXUa214tT7RlxacDwGQim2S4ueQ//wT60QolASLcd7xiQZn2mRrfzrn418U5YdASOeU/gFaqYXyTElQVYbR5Rvfe3fsd7LzQ3peg8bFGmZ2Yafq579EmDztkPUnkS0y8C9AWI4aPexqCxQ+jkMVubs+bsAgcUfFC5SQKnJ+7sd2xUxmKfJ82ZDI6tYQZo8tfem42MnjyrfF0l1AWf/tz1Zy4NAtZmqpWiwSbwxwPZgyPB5pP2I6KzW6S5/gUZLS6RQj91pzTHrnFteFD7jEUwIuulangXlg9x5t3PdkrZ9SNDvQrCnvMK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa797c91-148e-4ab6-65fd-08d795dc0775
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:34.8111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5MkT3AjQGsfgjSZH00fwVPHLAhy1DmD3v4koqjM/0QHGdgibM5+rbqPWvMYHgN2r4RLE6/CcRFMuHygLp/evA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Harry Wentland <harry.wentland@amd.com>, Eric Yang <eric.yang2@amd.com>,
 Joseph Gravenor <joseph.gravenor@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joseph Gravenor <joseph.gravenor@amd.com>

[Why]
Don't want to start HW discovery unless we have lost power,
as doing rediscovery otherwise is both unnecessary and time consuming.
Before this change it takes 40 seconds to go in to suspend, after it
takes 27 seconds

[How]
Accelerated mode gets cleared if we lose power. Only do detection if
this register is cleared

Signed-off-by: Joseph Gravenor <joseph.gravenor@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dc.h      | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 46f2b54c3526..c918a0cd8c60 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1318,6 +1318,12 @@ bool dc_commit_state(struct dc *dc, struct dc_state *context)
 	return (result == DC_OK);
 }
 
+bool dc_is_hw_initialized(struct dc *dc)
+{
+	struct dc_bios *dcb = dc->ctx->dc_bios;
+	return dcb->funcs->is_accelerated_mode(dcb);
+}
+
 bool dc_post_update_surfaces_to_stream(struct dc *dc)
 {
 	int i;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 29762b0531fc..d1d57432bc7e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1069,6 +1069,7 @@ unsigned int dc_get_current_backlight_pwm(struct dc *dc);
 unsigned int dc_get_target_backlight_pwm(struct dc *dc);
 
 bool dc_is_dmcu_initialized(struct dc *dc);
+bool dc_is_hw_initialized(struct dc *dc);
 
 enum dc_status dc_set_clock(struct dc *dc, enum dc_clock_type clock_type, uint32_t clk_khz, uint32_t stepping);
 void dc_get_clock(struct dc *dc, enum dc_clock_type clock_type, struct dc_clock_config *clock_cfg);
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
