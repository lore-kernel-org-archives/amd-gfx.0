Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD603C35242
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A0920720
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3JFCPJyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A0920720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BB5E6FD14;
	Fri,  7 Feb 2020 15:50:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 192716FD11
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:50:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZd7peODPuV2vyzqEQ3YeBJIY5KHKunI51kCQjCx08i2rjwy2LWj9vlsNhdHMpTjJXEc+ydUACu7wV8BLkR0t0Owj4E656JJK89B4yJxs2TTRGZ+3HyUPzlwExxH3HSb7grZsxYX3TY7YfC4GkdOtp/tb3/8knDOzax3+WfVxecw7TsoFzoL3kDPpLk5NhpvfLxlQVrCLahTRnrdY1iV2N7i90f0JZ0qx6rJAQ4Qp3T59gX/x3ovYDGnvyuzl5/IkF8XHF/afXMph+vx2oWcQM7glQwFGoGVG3gKchvnWe4SW6D0wJUpvC5fit0nOXcF/pDJ1qBQUBkfy90P8bu5Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7GHlT1ZqHj64wFWqWQYT3bE5bLyqd6l4elbmzhOIzY=;
 b=cFYu6LLRy8C+g00Ik3UJmIuMg074GWW5xI+MftHgVDMmX1Y7UoUrql78fyJ9AINT7/Mztwes2FszTK0XbXjdjsXF1JwZFWl+KzdiyMYbCQIKZH+92J4GEjVBpqy9X8l4QD0DrY8Mue4HmQoQuIP34RKjMCPlwL12PHl3kaMlEKOLcTxQecA9JbgnqdvgAoYIPXWFrHP36N8OFB7ND8U7iN/oyXtkbWkrUbpN2meESDM2jONRSpbB/yQlxWw3CqdDlRU/CVF3kBdX+hGTfC60Kbj1BcqIUP5143NzzE3HzHultqjmBGiqyI0o3TkWtqyfpskZFWhFj6ef5VBTj6dzZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7GHlT1ZqHj64wFWqWQYT3bE5bLyqd6l4elbmzhOIzY=;
 b=3JFCPJykfAN4TYJwCaXDuBzVVmkms5SKGUAxzck9fwFPMxi+P9A3JOW7YTPEwUwgNCJvMe6HdGxdiwrsEEWIrqtA0LYPZyZDrU6I7TKGB9S/oE9TNmaX5KTCe38Rg/SlK420UY34LKi6pcf/6Zg0bBLH1/KGmJBahV0DCi7C3hU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from DM5PR12MB2519.namprd12.prod.outlook.com (52.132.141.150) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.142.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 7 Feb 2020 15:50:52 +0000
Received: from DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43]) by DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 15:50:52 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/17] drm/amd/display: Use fb_base/fb_offset if available for
 translation
Date: Fri,  7 Feb 2020 10:50:09 -0500
Message-Id: <20200207155010.1070737-17-Rodrigo.Siqueira@amd.com>
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
 Transport; Fri, 7 Feb 2020 15:50:51 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: db0ee706-0029-458c-5ace-08d7abe581fd
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:|DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB244045D024E1EDAE13355B08981C0@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(2906002)(66556008)(186003)(6916009)(81156014)(81166006)(8936002)(16526019)(66946007)(66476007)(5660300002)(478600001)(6486002)(1076003)(956004)(2616005)(4326008)(7696005)(26005)(54906003)(316002)(6666004)(52116002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2440;
 H:DM5PR12MB2519.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QUWiLHKPA2ZYJC+80GTRtuYJqlXnHLu9P2zgOp0wcx1ZMbCQLU202GdsqQ0S9r4JlfpATywZ6h5XToWu0zOHpVd/gDgwmSHKhGttTz7LO0+o0nSiX6RgxKHUjrEazAlkBit50HgqbqZ7p9WVxbA07D2Zk2vMQieWcCaIA1JnQiUMS7GivxBM//HULuD1sei9yNmnWfAyWUOPQuUlp4hxW/e9FpS9ABdQz1hkrBMZjbjkD45XWlD0iXjs/XNiiNq26wDfW+R98fppa8F1mx59G89yEUK50hRxG0doLf/ToWtNqQxzlMedTAhbXJOED3bT5erdsCMZ+xS8GlqbJ6+2ymSgfFHUnFPknEHb/f1Put4fL0AXj01uWRaC7PZrj+P+AWiPmRPvfhuE/rwhkr+VQgcRbgnRe8azr4Eo34xXNsPUux+ReYuB2m/JMrGmsXsM
X-MS-Exchange-AntiSpam-MessageData: pQ5u9iqVFAQR8s8lOTv20H6UsQwRxdPCFl/T8VH9BK202FbDU6csOiBMC0o2ni61Y1zJKtZR4CMOd9fBLypl4rVNd4kY+1mLEgWpDv+gWY/sreYn3v+G7yHGh7UH1WBeGK5embUzUKr/uhhndsQZ6w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0ee706-0029-458c-5ace-08d7abe581fd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:50:51.5598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32A2ZRFjqeRDL72zrjiB0LIk2Hk05JqKgdzU6P67TU2VO4A6zpasSMyqFtwnWlYmd6K8UcC0g0jY/hhGpBeDbA==
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
In the case where we do have these passed in then we should be using
these instead of the registers - those are only programmed when booting
the adapter as primary.

[How]
Check if fb_base/fb_offset are non-zero. The value of 0 is invalid
for fb_base but is valid for fb_offset on dGPU.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 479f17bb3800..993e47e99fbe 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -60,6 +60,12 @@ static void dmub_dcn20_get_fb_base_offset(struct dmub_srv *dmub,
 {
 	uint32_t tmp;
 
+	if (dmub->fb_base || dmub->fb_offset) {
+		*fb_base = dmub->fb_base;
+		*fb_offset = dmub->fb_offset;
+		return;
+	}
+
 	REG_GET(DCN_VM_FB_LOCATION_BASE, FB_BASE, &tmp);
 	*fb_base = (uint64_t)tmp << 24;
 
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
