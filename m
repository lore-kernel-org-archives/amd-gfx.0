Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F1AC2BA83
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D973A20720
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N0/V6i4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D973A20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E778C6FD0C;
	Fri,  7 Feb 2020 15:50:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C911B6FD0B
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5ZgOmFQXNSY8Vfl009FLmaSSGdJMiN4KknAt0irugO1obMeA1UbKJEaxyHeXi4w22RPrEUVz0MBczGsmg7VBigs2oH6EKEP0RkanHTP5QrrLZKY10MJf+mVUpVNh8HFo7KzDpJN1TxkVzfmt3HsaXCIO5nLrzSGSgvhbndeYCqoy9vELZOPxGzjZf6aKyBKS99rZQ1YOLVD+kqVsBfg7mtvUqnAwuOJrgnG4qDW87i1bvLY+nQ/iIMmHiN6LOx3w74oK1PjBbyNq48kSMDdtBYGqFMSBkGor3rz+Sx+DetzIAmdQDimqLPAnPbOn48C+Zjnso5bPWffVctCWjPRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETHOufaHiLB/zuassx/sYk+eqYcuf/RubnJf6caLGjI=;
 b=Me4hjX3N7EAIPaOgEra+q+TOjkM0+YesvqzgzuJMCPu5qHnlY22PGLwwRAuh2knb1zuqa4SxnxwJ/bo7xoJyxNjN8SHQh1eU57hB8Sd4ybkMXlJH0fJYS3hjXa6B8cWcGjVqJg9WCOFNfmiHX93LUo/DSJDF6EXP0DUBQZd9ad41RUiF+MuQglgRpdSGjIMplSzeWj5lB7tW3ArgQiEouc1S06Qbrh7JBs24lMz/rzBKKubMrkK3w6qfVuAsWIZLdPxF2PDAgfFaVfGSg8gJespKbGJFIlKhF9TuWH4JLp7FSTtQCfKmqYkPeVij0qY0ra1etO1uJiQezRBDK52bXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETHOufaHiLB/zuassx/sYk+eqYcuf/RubnJf6caLGjI=;
 b=N0/V6i4aBQp240zYF9HnoC++TZXhxBsUZ2VAic1XRAyquczNccrW7n1jWLthlTj4gyCG0+NxCPizA36dDo9MgptN6Xt1nhaEBFy0eJ0tvZrQfnYXP3QDqvotUccK5QxNpGJj+OQg57JQcBBH2I1OQiOD1fUialLzel1aSTo+4Vk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from DM5PR12MB2519.namprd12.prod.outlook.com (52.132.141.150) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.142.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 7 Feb 2020 15:50:48 +0000
Received: from DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43]) by DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 15:50:48 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/17] drm/amd/display: Drop unused field from dc_panel_patch
Date: Fri,  7 Feb 2020 10:50:03 -0500
Message-Id: <20200207155010.1070737-11-Rodrigo.Siqueira@amd.com>
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
 Transport; Fri, 7 Feb 2020 15:50:47 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9cccc9b6-bca7-4cde-554d-08d7abe57fa6
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:|DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2440F461CE5EC4C0B430353F981C0@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:192;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(2906002)(66556008)(186003)(6916009)(81156014)(81166006)(8936002)(16526019)(66946007)(66476007)(5660300002)(478600001)(6486002)(4744005)(1076003)(956004)(2616005)(4326008)(7696005)(26005)(54906003)(316002)(6666004)(52116002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2440;
 H:DM5PR12MB2519.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5MhnccpGrifQ11XB11AKSXxrXkcjQCikTDJWndxnRIJtk+ibCGYPq9zJKwjN3+nvBWP5AhE3GcpY9cND0CThEekDiT+Q3asITORyMyeOABGZIzjCfqA5ZJUgGkmUDxczxgYCKkJg0FDaPClFknzsbdVhxZe+p8UuJ/QrGfrO6K6XYYiIsTSB1KDXSkTRmygZln1p/EerBDwauEFmnn3F+OhL6cHcXEBRRAz0osH0FgYP3Q8cFkZ8soptDs5ECMOQWkI+8am1sDblN8ve8gtYkhArzouo7qwvA9PNv0FNq+0DHu3Lwurt4GQyoHwO6ncKe+5CXTWY9lLA4lsgwGDVoMoWvPU5QkjxW2QRZ5LfWvCO99bsRlJWa7E44hSiDqI/RhKm6MRT3cfGc6XYbPWCLY45a7KRCi8G7gKKNJMOaPT8U5/E8K7dzci7gqCHY5Fz
X-MS-Exchange-AntiSpam-MessageData: MMhj3Yz0MC3ltIaYcEDjJ9D/httVE9/FIhiGJRCWzIpEsaoepRthICElM+S9Jp5dTBtChWOJ8FDqeVFxYHATYTRLWJrjyFcDYsS07ub9Atfn6JskXlTDL3j9DN5h6zH5TzpdEtNr3FDBkgA3kC2CIg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cccc9b6-bca7-4cde-554d-08d7abe57fa6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:50:47.6130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: neNcbRCixmeIGtzTmGGM8uxcYNoQG3674YzwjDUOxsq6MaFFVcKsTzFhu9BSuWwSTy+UrD4TCz17XCIW+IeNRA==
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Joshua Aberback <Joshua.Aberback@amd.com>, Harry.Wentland@amd.com,
 Nikola Cornij <nikola.cornij@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nikola Cornij <nikola.cornij@amd.com>

In the struct dc_panel_patch, we have a field named
manage_secondary_link which is not used by any part of the code. This
commit drops the unused field.

Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
Reviewed-by: Joshua Aberback <Joshua.Aberback@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index e59532d98cb4..122c96455792 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -229,7 +229,6 @@ struct dc_panel_patch {
 	unsigned int extra_t12_ms;
 	unsigned int extra_delay_backlight_off;
 	unsigned int extra_t7_ms;
-	unsigned int manage_secondary_link;
 };
 
 struct dc_edid_caps {
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
