Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7356DC35242
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4539220720
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FTObcAyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4539220720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5950C6FD0A;
	Fri,  7 Feb 2020 15:50:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EB5C6FD05
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:50:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbprqkSPwmptExp0A8hmrrrKbgkDBntEdqIUSwMtC+K1xYY3ptFATcb6l0+2GRY9zkFMkN/PZURLxmutJ3+TK7cGG7xE3wuZjG3LVRDZ/2dlqKDvygrZb3umDjuzWd6W7S5jDRuNxaWwwM5pQ34qMgZShxsCNw8bfeE/tknr95vj5NxCZoDl1L2g28NAWLViL86YThbzw19D4Rgrr541SWxJsyBAlW/ZhcceUJqRlU/4/3xRNR+rVnG4UgfAkXJSxu3Oc8H6PCQytGnemhsZJT5K72ea67+HkzTpZAWqayyeNiRpWIYFRpK1rBPPMVBMI34kTLqqBUH2zFG0UVf6Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tNrlyqd+NZpUQhHbTdjOILjokLaefkE+HoM/QDYE2M=;
 b=IFG1WpIpCZPZQJswtB8TQNPsg1C5BahLd2xp6DABpWdPInRWHbC9Y+7UJ+J9ZpFMPeB+ThumTdxhuC+5EBg4jrYPjtmjW2NBv4Thnaa2neJeKcOvOMx3V6pBTcl4rM271DOe+sB8MrGNMEjewCcuSFE09zdLvlnzDEU9vgy0WAHv2xSaRcbv1BtPfuZ0wv/5GQGqhIGX/hNxAeAF9P6MKlU6EWFQuUd+1d+dO/Kb7HVpdsms3Vu1Mc3V0xscohFDjUa1mtVepigYjbkBqDtEXmo77Wog9C2ZvlEYAPTMV4cPP5K91M6bd8KMLrryGq8HJLV1HlK2nWrL+FLBuO53xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tNrlyqd+NZpUQhHbTdjOILjokLaefkE+HoM/QDYE2M=;
 b=FTObcAylwGSubZWuc/ZUHGLk6SYmbugzVacfsxjEDSl/3PxJybgVA6Ai4sR8GnLY7bKcU+c96pF/YsClgRQGBvTEkzDhj3kK80LaUvFev9lWsNzSCGCOq20vT4pCmvXUPtnRYA3GCsybidal0kUU06O322bsD1slPxSCU700B5U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from DM5PR12MB2519.namprd12.prod.outlook.com (52.132.141.150) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.142.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 7 Feb 2020 15:50:46 +0000
Received: from DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43]) by DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 15:50:46 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/17] drm/amd/display: Add AUX backlight register
Date: Fri,  7 Feb 2020 10:49:59 -0500
Message-Id: <20200207155010.1070737-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
References: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::32) To DM5PR12MB2519.namprd12.prod.outlook.com
 (2603:10b6:4:b5::22)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Fri, 7 Feb 2020 15:50:44 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 16c913de-a1cf-4a2d-350a-08d7abe57e12
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:|DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2440F5C3DF0E1FE6FAB77FB1981C0@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(2906002)(66556008)(186003)(6916009)(81156014)(81166006)(8936002)(16526019)(66946007)(66476007)(5660300002)(478600001)(6486002)(1076003)(956004)(2616005)(4326008)(7696005)(26005)(316002)(6666004)(52116002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2440;
 H:DM5PR12MB2519.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HuJu9QoqvRTT0cyC77Gz+gio46C0CYt4q0oZz9o3AeUGPJQQ4DWClM5iiHar+rKHAJT+BLMUa948UljdZgfuJDJn/wo0EzY3X2eOFg4ctFR5/dArXQIIiJX/eI01a0N3teld++RwByXecpaAM6L/gb0BAdjbh4jcFKp1PeCKhDK7YQ52L+Qd5FgHFhdsKkXYMeQA091f+4M0uSAy5tdBXRp/ePE8KdFMFhR5sw6kooQQVsLessyD1prbAdWeVk/LoA/8FxMH+VCdQrNRA20psiYEJodCMVKO02Lf++TgstJ32O+DOlbRjtu8UDpVYmvnsQbfZydKbLAE4q3fSEPI3S/GIFt1VIWR0OK69mNyHkx8RQ/zdcZVqCksk7p1V1irhwHdJw9Z4/BVrGjrsB1y+OiKekZ4T91mdgpLK4F1lctkz1xvlQ0sYOtoAy0IxE2x
X-MS-Exchange-AntiSpam-MessageData: MmPmXOf1ZBUAqPuIMrgjAWmzcEBSPjh/THtIWb+jXHt25fVxAmKqlKSxt5pASz2FcO9EQgmZuutwcYAlgH0HrKaIXY3EZO9CyBf+mk41IWn6J343bvTrkzPHaxnJgrYs9lpwzKZ9lKBKrqZrehVSkA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c913de-a1cf-4a2d-350a-08d7abe57e12
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:50:45.1574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+gKsqqBjvX+eIbKxtZO8kmsz8EzaR/hUfgf1nBVG07HN4MMnAf7ZxNNEnZD055O9NVB8IjN9Y75YK/yn3X1Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Introduce vendor-specific registers for handling backlight via AUX.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 8 --------
 drivers/gpu/drm/amd/display/include/dpcd_defs.h  | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 3bc05fa93ed5..c0fcee4b5b69 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -20,14 +20,6 @@
 
 #define DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE   0x50
 
-#define DP_SOURCE_TABLE_REVISION	    0x310
-#define DP_SOURCE_PAYLOAD_SIZE		    0x311
-#define DP_SOURCE_SINK_CAP		    0x317
-#define DP_SOURCE_BACKLIGHT_LEVEL	    0x320
-#define DP_SOURCE_BACKLIGHT_CURRENT_PEAK    0x326
-#define DP_SOURCE_BACKLIGHT_CONTROL	    0x32E
-#define DP_SOURCE_BACKLIGHT_ENABLE	    0x32F
-
 /* maximum pre emphasis level allowed for each voltage swing level*/
 static const enum dc_pre_emphasis voltage_swing_to_pre_emphasis[] = {
 		PRE_EMPHASIS_LEVEL3,
diff --git a/drivers/gpu/drm/amd/display/include/dpcd_defs.h b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
index 2c90d1b46c8b..3d29646c7cb4 100644
--- a/drivers/gpu/drm/amd/display/include/dpcd_defs.h
+++ b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
@@ -149,4 +149,12 @@ enum dpcd_psr_sink_states {
 	PSR_SINK_STATE_SINK_INTERNAL_ERROR = 7,
 };
 
+#define DP_SOURCE_TABLE_REVISION	    0x310
+#define DP_SOURCE_PAYLOAD_SIZE		    0x311
+#define DP_SOURCE_SINK_CAP		    0x317
+#define DP_SOURCE_BACKLIGHT_LEVEL	    0x320
+#define DP_SOURCE_BACKLIGHT_CURRENT_PEAK    0x326
+#define DP_SOURCE_BACKLIGHT_CONTROL	    0x32E
+#define DP_SOURCE_BACKLIGHT_ENABLE	    0x32F
+
 #endif /* __DAL_DPCD_DEFS_H__ */
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
