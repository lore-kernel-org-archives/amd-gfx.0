Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D3AC282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08A820838
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4DzcIKYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08A820838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2EFA6EA35;
	Fri, 10 Jan 2020 14:47:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 721D36EA2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFj3ko49lAgnoZf/loUVJ61YzdvUZGdWYmxpCXJrWCw6E5Y4Pb6ZVetMLwl/7yJP19ZU+XxuEfjb7naEM8vyah4qZtIyIfO8B6QWVF81+rpX+UdgZOoTC9r+/jRUneLuCMbjJ1lgN+IsFcN5OP6jtAbBA35812rMXTcLpQ7sEfcnjNYxXIcMqQaLAwBIAOgC1Og9AQj8t1RYkouSHY0lDxM54p4Eo0e9jvVfMGNdLk5BU/hikQliDENV2AMmc5Lyp/WtkjS8Tg+7nR3qWxMXrZ9LXggnMB4SO7U6fa8bVpFoXcpnL8eUIudqIznNdBkpoYEfdo+VPf8E/1/MOrGGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPuqx7IB6lV+rLIDtrmyx5qBGju0wbNiIWGgxODOCM4=;
 b=UFktxXVa07/GCGBAXKTRlUMQXxENWPWtxUHtnFugm5BtYUjLBiz00ktX3QkiM1I+m/HDGtzB90Tfoz9iLh/RK2NgI+zPGPyHiVgDbUVTHyD5lwz/EWxAnj8EFRRPU6ZQJjtb+t0k0Cwn/tk8SKQwJPaBHtbuj3dzQgekwi3t/ozHw6ZLPwKhLgCczuOXZEboCFwu4TtHvBiVksWIVPjTfU6d0EInJVZDXDpVn27KE+rETC0OZ4OD376L0gF+2ylItEeVFHfpdYcxrnwVAszZuHKehJecW0BLIr2bxuOBQdspcPa2c2/x91D3ngeUQZ/hReE6d8o8eDbZlJPWmjQCPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPuqx7IB6lV+rLIDtrmyx5qBGju0wbNiIWGgxODOCM4=;
 b=4DzcIKYSJ/kmBdAGrvg2ihtpmBbq/+m2lazm++nsda5Xc39DpTbBqu9evGBqsyM0888G49+77XcQfKY/xI06Ahe4JiX4jIKqicM49kADz/DQnXsJpGV6d92WyecCqddFT5UojojyZZjX5C6EIXLiSglCHsKJAWhdLh6y2BeK9zw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:26 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:25 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/43] drm/amd/display: Disable secondary link for certain
 monitors
Date: Fri, 10 Jan 2020 09:46:18 -0500
Message-Id: <20200110144655.55845-7-Rodrigo.Siqueira@amd.com>
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
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:25 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a22d9c8-7a0f-49a5-617b-08d795dc021c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2524CA58244EAC339EF94F4598380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
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
X-Microsoft-Antispam-Message-Info: mUIbnyND7Wr5vEz8YkvQg+TNZb5SYnY5lo/zIYvPZorr/Z/WwZvPiYlMgBDPxKptBQP6qY3qsjB2yz7d7TnQ97CjzqYFL+nyIEF8IlbYnl3KhtCI8DxTGnmXoYEeQU1cbvMb5PsG/rRxV7Ncj4UnRik1RCNKmJPO8ilDVMUKjvpUnZjMtoASMrJ1DTwev6ILpQKUoBAh/9JAaYjUvOOucXT1L3Zf3OZ/cmrxzdnOpAWeDkJDWJzaZUPBj8ylI4y6FSXUv46i38jd3gm7TqWrGM4i0+eleeGzQVf8zgm4t/hu1hNjifumsE0jLSvXpeucjh7CUnX4kRqz29/JzHnvsZ6uuemSMjPOg6VUBoS+z/Z6aTatbWP7DRcMYaQmE6khyk0PrjZHME+mv0Gz2O8HN7hxxkMzZ1/LaXHZV0v/K/ZYN9Fe1IFuEupnx9r08nAQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a22d9c8-7a0f-49a5-617b-08d795dc021c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:25.8861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3Wja3NJsneEP/nrtFaoy1C56ivPQlOrVIPMylZnwohuzZjrCQ1Cz8EMI70VfDxJ0Aeji7BM9V5omkAkdsGieg==
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
 Joshua Aberback <Joshua.Aberback@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Nikola Cornij <nikola.cornij@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nikola Cornij <nikola.cornij@amd.com>

[why]
If the specific monitor supports DSC, the secondary link should be
disabled, and the other way around, too: if either that monitor or
our ASIC doesn't support DSC, the secodary link should be enabled.

[how]
Add a monitor patch and disable secondary link if that monitor
is detected and if ASIC supports DSC, or otherwise enable secondary
link.

Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
Reviewed-by: Joshua Aberback <Joshua.Aberback@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 10 +++++++---
 drivers/gpu/drm/amd/display/dc/dc.h               |  2 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h         |  1 +
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 64a0e08fd019..a0eb9e533a61 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2066,6 +2066,13 @@ void dc_resource_state_construct(
 	dst_ctx->clk_mgr = dc->clk_mgr;
 }
 
+
+bool dc_resource_is_dsc_encoding_supported(const struct dc *dc)
+{
+	return dc->res_pool->res_cap->num_dsc > 0;
+}
+
+
 /**
  * dc_validate_global_state() - Determine if HW can support a given state
  * Checks HW resource availability and bandwidth requirement.
@@ -2897,6 +2904,3 @@ void get_audio_check(struct audio_info *aud_modes,
 	}
 }
 
-
-
-
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c4e6c696f06f..29762b0531fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -910,6 +910,8 @@ void dc_resource_state_copy_construct_current(
 
 void dc_resource_state_destruct(struct dc_state *context);
 
+bool dc_resource_is_dsc_encoding_supported(const struct dc *dc);
+
 /*
  * TODO update to make it about validation sets
  * Set up streams and links associated to drive sinks
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index b1a372c8df83..4b5b97520733 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -229,6 +229,7 @@ struct dc_panel_patch {
 	unsigned int extra_t12_ms;
 	unsigned int extra_delay_backlight_off;
 	unsigned int extra_t7_ms;
+	unsigned int manage_secondary_link;
 };
 
 struct dc_edid_caps {
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
