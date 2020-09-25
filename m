Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49E4C4741F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76865206CA
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uXEmU/T/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76865206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F686ED10;
	Fri, 25 Sep 2020 14:55:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E71F06ED0B
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 14:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUw8wK6f3yyab8Js8V+JuTczgPRbSnqkUkU+oG52JJv/NbgEJOoSJ0KbrZ0HPUybqBSiVQ6LyT1driLk8eQzHt65Ey0bXlb+IcHGDw25ppwHhuGXJneUcmXdD9UABmKQgxzYpXgjWJVF5vH3C71AP1qsSjbeEiy1VC59cwKIw+HGlIb1je82BZ5VmMr+Zc6oIiiEaz7qiEfqWGESKYdcdhNylfCBzeLv+IuXtuHs+yEkjiMmaCyYcLTXgLIg8z8JhWzoZ8uw4q4L6A/zl1Lr9vUmcgkdGF/a8yYuws/vY+WPowArXcWHTlFXuJf7vS003WBkYyQ8JD0mzMH6yEGabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qd3Rzxl4fMiOSy9E7sXg0sGVm59k5PsNml5YanwTJHU=;
 b=LFfipomv4Z3cyaB5tSqSkGiDYcNF3lNXwLX59FZrncEhHpC+c32H1Q/YsB5kTvbETsGVXrkqRwrGtnfP1H7CsYIcAuIamEW4AdrO1GyPYUt0tp8AazXnd1/1ZEMxmt6zRh55LbJmrpvN9k1/t1n/v/VxxbouLciCcFFC4MzbzfQRxCqUv/WU8lKVQO6stg4pHJj1s+gnDItkVF12BDYG5dqwZiFButt3olhmP4MAXKS9HU5e5JFrdg/ajFhs66hYIBsPd53BSU8qyYtuy5L8zvc2rlDs9L6TGvIwUd9sc73cHaqP0eIYHVweZZUox92+RztGEZgnzxjK4GEC047axg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qd3Rzxl4fMiOSy9E7sXg0sGVm59k5PsNml5YanwTJHU=;
 b=uXEmU/T/BcbCrdmSMU9i8S8N9JhoTOHLiqi+Kx+KbFVHlro9WX59xTfnI3fw8l7+wuSWPj7xb5WEYw7INAnD8JOy6M4srbAs75MxYQGxSmlqmJIHdFySQ2qIHl/y74PnWwGFcLML80smhvL3CKtKu9PP45FcLRGkgbuljBFeAI4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Fri, 25 Sep
 2020 14:55:15 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e%7]) with mapi id 15.20.3412.020; Fri, 25 Sep 2020
 14:55:15 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 9/9] drm/amd/display: disable stream if pixel clock changed
 with link active
Date: Fri, 25 Sep 2020 10:54:55 -0400
Message-Id: <20200925145455.2398170-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925145455.2398170-1-Rodrigo.Siqueira@amd.com>
References: <20200925145455.2398170-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::980e]
X-ClientProxiedBy: YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::980e) by
 YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 14:55:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b8e4f441-94cc-4123-e2e4-08d86163032f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4219C575EF1CF76F1021375898360@DM6PR12MB4219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:327;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0TTf6fvQIXigKeIcdOSiuh8cHFjgfDi8gdSaU+iuu/meOvKMkjscoxbArS6pBVJ3P4QPqVuf1xYaPrwsuSlPksESYHqM96r/R0x+VxQJ0XEHHew97/Q4aaulUsXlwCrESPh9sZn78klHyOMYCbiRfX+6tFJwMqTJYWHz8d7Skn9x29Kb2If4HlsM1VMf54nMMvlJYXT17N/l5nSoUE7eesrkMNYSXURLz8WOvr89+nwmlXud+uDfMLwMWIUpk5pGLrw+RJG78k2fFbtbfDYQq1BQjjxqIX419kjy7/bSTqH29cxDOggPaFYMdY0b9Wx53EIApFCDRzkwf8tuEfhMWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(66946007)(6666004)(36756003)(16526019)(4326008)(6506007)(52116002)(2906002)(86362001)(2616005)(478600001)(6512007)(66556008)(186003)(66476007)(6916009)(1076003)(5660300002)(4744005)(54906003)(316002)(8936002)(83380400001)(6486002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: tLP9CuRR0/2DwmNEi/zxfD2G8sT/6Bw26bK0djY3z5kInUy3N0bLGQ5Nxl34/j0YvyiaeRLHUFis/XMmuKqRzL5FS6OurZT/6NrtGIFBkgRiscv7gE7kaebfzwdazoCWwNMYYl3vFcC63gBNKOe9Qc/X0XiJpZNy3Qer1j3vXOx+sc7t5s86YUQhWHUcvtrrE3HgFMjEgCjuqNb9ER7Nwlq8C5ZRV1UPLnelX6c8rBx2OIx7U+fMA5no7wURavR0KOOl8c6Ru4GtQIGD6+7H1WR2wPv5hQZKsl1QOMesc/xSvpYq95uoB6iF3z5qgS/kfbTueAPwt07EjQflnu2+/xa1QqqoNnFaqRCpoJlxopbUYiVCNKZwVkgPZjncakWDw0KPTQxfHJmu7AKzw+T5QtFzxG/3j7GtSbCQkOPlpWf8yr6wzVFZQwLdwDaoRlv4Rim0SqbUfXYqKzodeCeHASy++2q32eIwwOq9gIQe5vTOiPoB7wsDrh1drHOTKC8/6QOiO2v0Qy229yCEH/+1L51rxsoE8dmmK48Q5M5jPrKct41GFVWa9i45uqOCTWSoZTNwklT02RfK19qKDo1dv/4IoE7kWvtGwoD0E5ly7QgC7Pit2wfcT3fzKO0iNbNLgYNQBQ5cFc8kTublWVWuXarpCrOMehekeRgKH9IU2qz9vNhDZ2lJ80Y/ArWK4B/0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e4f441-94cc-4123-e2e4-08d86163032f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 14:55:15.8062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A78wiMucL2KI2fxTt8JLdsTAM7RC/qMbqNSLkcjLbHAN/Bkw0QgPunRKeefKXVvO/iR0cIwJ/6PjZs8Rp4BCrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Chiawen Huang <chiawen.huang@amd.com>, Aurabindo.Pillai@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chiawen Huang <chiawen.huang@amd.com>

[Why]
Vbios uses preferred timing to turn on edp but OS could use other
timing.  If change pixel clock when link active, there is unexpected
garbage on monitor.

[How]
Once pixel clock changed, the driver needs to disable stream.

Signed-off-by: Chiawen Huang <chiawen.huang@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 76946a7d47ca..2a725a5fba40 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -864,7 +864,6 @@ static void disable_vbios_mode_if_required(
 		if (stream->link->local_sink &&
 			stream->link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
 			link = stream->link;
-			break;
 		}
 
 		if (link != NULL) {
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
