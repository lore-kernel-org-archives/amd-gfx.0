Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B48C2BA83
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A8020720
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qxzv9zTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A8020720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F9E36FD1A;
	Fri,  7 Feb 2020 15:50:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96D906FD11
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:50:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU+xVdf/eJgXZOh4pWbdIEGpqADwrQ30wtP0PQhTBLV0SZIZz3ORGRUFdUTaK5/qTgk6hT6V4A8y5qpXkBzWv+i+ldJJ9tsD4hP7t09Xy/qc/9vYTLp29MBC+PgJ1hkjUnj+b4QC+G8rsoBGCIvm8ZGxM8WL5VirTu79UZZBybM7i9PQbMoOMnziyoNacwTnlARg5e2Mf36kY/n7pIknmc9E0b8XKR8ZNpiKEZ3AwPsZS8tIdEgvrUPt80Uai+aFRT4+VGwAep09bb7AYqeJ0cDIWHyL1Elv2cOPOabR6MIrBpxDRArmfyttOTeeLNMRAYFkoYtAFWlPg1d/5rf9Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9kww5HQguhUW3bRrZh59gn+t1IVzWz2pi/j5jlws+E=;
 b=WqYqPfrm4emPFTpUZJH3ARf4vCMr+kQotoakAtpEwmKbMA9vdZPv9LYOJmPtD9lq0etpJ8zww+sG3HAIhUBBB2aYZ6MZL0sSENIssJppvAEdat4mckxzpezT4/7NE6HodiWIohueCx1i8WAsM/N/T2+hO40IjF2AD6Ho/kk7LfnM7DQYZIsStmVHGAZHRbwrctwq+tRPQxfQU7wIkckPqlNPXwEQg4dSfcKxy0X/rgvTJZLDWbJcd5TzlRWiyB31mPnf1S7c1G99E2PoqvNmT6PVeeHs8J24pZc79FQo5aPu8dPNkiHDIBYh2oxdXDHNPoxvYx9T+zyRdWWnfHnaMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9kww5HQguhUW3bRrZh59gn+t1IVzWz2pi/j5jlws+E=;
 b=qxzv9zToj2enc0roktlor5w/avgiCoDs/hhtxI8lZPf1g1tUCuT9QtS3jkp+bK9HHI/7HDosrKKa+nmRImvWPqRbi5+7rFLzjTpjH8Ef6wQPm3u++O6xwaaTP8T0rr4LG0ENlbFnU5BavM+3+mM0B+oW3MENjEjAyrNmFFSKPRg=
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
Subject: [PATCH 17/17] drm/amd/display: DCN2.x Do not program DPPCLK if same
 value
Date: Fri,  7 Feb 2020 10:50:10 -0500
Message-Id: <20200207155010.1070737-18-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 226774a5-4923-47e1-c999-08d7abe58257
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:|DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24405FFE53387CFB07F23DDA981C0@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
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
X-Microsoft-Antispam-Message-Info: bzHHk3kLF/DatlEd6rL24Fc3oH45znrN39s0LkZaO4/6w0Su6+uRcPqf0zE915klWe/lsFocJkSKtx428mx2hBw3qCc4rrOYc9IlyMyKtGhJaSrhCIKOIC6qVBrGwltkhXijOa64EUhR83Gh3va7iXkDdDz52m9VLu+sDzR2UKB/0txOThIR3kuIRLHbUo5F2s1O1A6X8UKEgaUL3M9NEJpYr1RB3uMmkiD+xTTtkJw7ht9saFTw+/W1oSxpqYpif/lHbrQC+/pZYapatfZKSH+gYBhb0XxeJ10mqW1Ur4F5upf7iUVecF8ePrM6gKIVX1U06uShTehJZGk7L6+MwdJ3y9qcvYxE0xavlAFQgLLyUzrAalEHYgf9G5WS3/mLyVcnvksp63kL3xEj4KxodgoxXOPVRUubqUoa+zz6D1fcF22aucoaCjLgttz31cT6
X-MS-Exchange-AntiSpam-MessageData: vI3q3kZV2ViE4m8vomL59jLcydm0qzk15JCBxLNtU6OEpsbxhqoMayd/BYVOxUEKUNWShYTpsW+QzwVr4pvpZESI1m7ppq/ombZjKaa3CslVvb8EvuVSFQZ57o1YSiATAn9x1MH41cC24qiIBp/+Qw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226774a5-4923-47e1-c999-08d7abe58257
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:50:52.2004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sfz9ydyFZP+QyI8Wjfsx4rumrLRP+Cvuhca1f/MToypPj5r87HQWdQzxWSYmxEZs0RAqMWSEfy+zSLtZAOpwA==
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Sung Lee <sung.lee@amd.com>,
 Yongqiang Sun <yongqiang.sun@amd.com>, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
Programming DPPCLK to the same value currently set may cause
underflow while playing video in certain conditions.

[HOW]
Only program DPPCLK if clock is not the same as the
previous value programmed.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index 495f01e9f2ca..49ce46b543ea 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -117,7 +117,7 @@ void dcn20_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 
 		prev_dppclk_khz = clk_mgr->base.ctx->dc->current_state->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz;
 
-		if (safe_to_lower || prev_dppclk_khz < dppclk_khz) {
+		if ((prev_dppclk_khz > dppclk_khz && safe_to_lower) || prev_dppclk_khz < dppclk_khz) {
 			clk_mgr->dccg->funcs->update_dpp_dto(
 							clk_mgr->dccg, dpp_inst, dppclk_khz);
 		}
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
