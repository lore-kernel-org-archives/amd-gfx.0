Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9CFC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A3322AED
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A3322AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EF376EC7B;
	Fri,  4 Dec 2020 21:30:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9946C6EC7B
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 21:30:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0tZDDbW0/jL1p1ThuQ0IBHn2ciqV9bcF8kWM/linY5IWoQMSx+lIEKUsuDboG1zA/HBIDBExaaa0QnJx/JQ0wwfYf3HD4yO7gsVV12iP/QBCACfV7XVuDqPAGsPzHI1edSdL8kHnMOtLPP/eq5CVi4/o/C4U2G8ZJ/cWtGNvA12j29Zf9z/7yyytQASMepX7g4B/uag7GeGziXok8/NzLjFqhUg3GuRr5C3yrpA7vHXLyxUQQ0M8Be1E5hBbrnciCBgtG9PahjyY3RIiHYWCxo/72S7f45bR1lLGjtqQRJEoBdP3C9m7JWzQOO1Jc7HVz4VwcHUmSS5RClXtJsgYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnQjUatgOLsSWyaW0VmHYYJtA23uQnD4Ywr++u/ODS4=;
 b=ec1ouhTGzwc7/OE9zC8cdIr4T9XkAHI2lpJes4pu6IStS0iKWIMm1gh1FmHjeaHv782+a7Kta5szqs9TQhMdr/pUoMThYZptK60LCoC16Jw1zn7IWDAROCx8/32vYLiS7Cg3AFdtoHVX+jowNr2n98XaMPXJ9d1NJZR2DYpvPv/wjkbQ673nAeIZrmObvj/I9Y/1a7Dqi3TqdiKAjQBZIzoXYoXBlr/kA2quM7eFFKpL4YaI6rzEQ/qiTGwvhNrgd2JHgirBz+TP5ODwx+2G8c3qg1hfefRLPU0J1tynKG2Lo/tSIajIbX0wIeFz12ZPZHXjMCPBZGV7NF5jIwkl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnQjUatgOLsSWyaW0VmHYYJtA23uQnD4Ywr++u/ODS4=;
 b=RrmRyoAPX1tgDGAfz6i9WxqVUeJ/hTO7hTqQ2dv4HpyNDd2Lq1i898RFYorw5244X/9R/EvxLnFZy0A35vwp6oFXaDDZyEGMnv4nkmEADh7Xcwoq6w7UgLhcXyWzow7DbNeOLBGdE8Um+oS3zWkhX6nZFaC5LoZZ+DgxbupkUy0=
Received: from BN0PR03CA0043.namprd03.prod.outlook.com (2603:10b6:408:e7::18)
 by DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:10::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.25; Fri, 4 Dec
 2020 21:30:14 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::28) by BN0PR03CA0043.outlook.office365.com
 (2603:10b6:408:e7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18 via Frontend
 Transport; Fri, 4 Dec 2020 21:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 21:30:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:30:13 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:30:13 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Dec 2020 15:30:07 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/17] drm/amd/display: Add support for runtime feature
 detection command
Date: Fri, 4 Dec 2020 16:28:38 -0500
Message-ID: <20201204212850.224596-6-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204212850.224596-1-eryk.brol@amd.com>
References: <20201204212850.224596-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45f20f86-c966-4991-e611-08d8989bc978
X-MS-TrafficTypeDiagnostic: DM5PR12MB1449:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1449D6178AC5D4E756FAA899E5F10@DM5PR12MB1449.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23+pri2cmYaXCjiRv48SczWR9HnujuxZHcU0Zoluzp9xl7eyih2vdqRxm+DvOTQoDq1U+/JKAvC2m9Uht2YujNbsZmuL9NtiJBbI0mZjlYO0D9qKq8FQVnz57HDrto/oWNPB+T6G45XHIfYs257Lx/t9yAUVJhZeja60looclAfNlkmInOEBgKMwVCbCMsvJvuKfl63xSbXxIx3zvgn/KWVoJ65vLSRPb6RY/D9tSbQ+pi+Yc0B4oPt7UvFhu2igBKMyFsdzCQxMJKyoaPUe2Zppj8LJcWIkI1lGAshVhkseWK5hpAmnvI++q3bPVP5UZ5sY51IrnSRfv7hVk/qROGk7t42d/16PsBe7nFprhiA8cHUGEr8rmZBxEHFqzpYqcGRUbZdX0yTtTJa5IkYk9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966005)(44832011)(336012)(426003)(83380400001)(5660300002)(86362001)(8936002)(8676002)(54906003)(6916009)(70206006)(70586007)(26005)(2616005)(82740400003)(36756003)(478600001)(81166007)(82310400003)(186003)(4326008)(316002)(6666004)(1076003)(356005)(2906002)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 21:30:13.9991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f20f86-c966-4991-e611-08d8989bc978
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Wyatt Wood <wyatt.wood@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Add support for new fw command for runtime feature detection.

[How]
Driver sends command through ring buffer, and fw returns data back
through this command.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  6 ++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 29 +++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index b82a46890846..863cd9cc93ff 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -345,6 +345,9 @@ struct dmub_srv {
 	uint64_t fb_base;
 	uint64_t fb_offset;
 	uint32_t psp_version;
+
+	/* Feature capabilities reported by fw */
+	struct dmub_feature_caps feature_caps;
 };
 
 /**
@@ -608,6 +611,9 @@ void dmub_flush_buffer_mem(const struct dmub_fb *fb);
 enum dmub_status dmub_srv_get_fw_boot_status(struct dmub_srv *dmub,
 					     union dmub_fw_boot_status *status);
 
+enum dmub_status dmub_srv_cmd_with_reply_data(struct dmub_srv *dmub,
+					      union dmub_rb_cmd *cmd);
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index ba8494cf005f..f388d36af0b6 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -648,3 +648,32 @@ enum dmub_status dmub_srv_get_fw_boot_status(struct dmub_srv *dmub,
 
 	return DMUB_STATUS_OK;
 }
+
+enum dmub_status dmub_srv_cmd_with_reply_data(struct dmub_srv *dmub,
+					      union dmub_rb_cmd *cmd)
+{
+	enum dmub_status status = DMUB_STATUS_OK;
+
+	// Queue command
+	status = dmub_srv_cmd_queue(dmub, cmd);
+
+	if (status != DMUB_STATUS_OK)
+		return status;
+
+	// Execute command
+	status = dmub_srv_cmd_execute(dmub);
+
+	if (status != DMUB_STATUS_OK)
+		return status;
+
+	// Wait for DMUB to process command
+	status = dmub_srv_wait_for_idle(dmub, 100000);
+
+	if (status != DMUB_STATUS_OK)
+		return status;
+
+	// Copy data back from ring buffer into command
+	dmub_rb_get_return_data(&dmub->inbox1_rb, cmd);
+
+	return status;
+}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
