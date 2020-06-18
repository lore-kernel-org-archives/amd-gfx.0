Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B92C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 19:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27289207DD
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 19:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FIpNyy3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27289207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB9676E444;
	Thu, 18 Jun 2020 19:49:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE22F6E444
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 19:49:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIpxmdsKekIrQ949jrttfGPyvz6bT747GI/NM2nk6g2wNyVNJE3mqhp1aEB0VrEb6CGBJDkrEalSnQwsiGf3gbGXdrSh6Q0w7NwHVMJnA3wUKBHBND2n7Lq+xF04Ajui3AICgu52gBiSAn8GksAZFE536vLFhdpAh7pXY4lcTWylUVV1pwlGcG+2FTf3hjNaPVvjkb1QLNKUIGxgc82u6j4T7BxFbUkQDLl9yN+N301gFBiS/BJhIva9AKbECOTI6R+6hId5SItvo38VGxLtoNegSDRgUX3ss6cGWNBuykPp3l8YiPqweqsNI5+6KS9+XBH/EHwhFg0OSiiPu4jGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FO1gXUSxWR6grOAe3qImYHk8253C9kmy9jjwOta3EVc=;
 b=U0HzoYhK1XtSJ8xtHCx5sQygO6g8ZPbQ81248CD6g2O+fiH1UwXjjcjPz1oKZFmh0UnZkmUgP8cgVQc9ZtE7rxVEd5DSbjFSYL/dewuEweHfKrfa1pG3G3QAVWWifjButvo+9wlzIUqLaSEJfLUb7NjW5rIG8RF5CXwUp894k/TI4eplY0ZbpvoMyRMXVMOp8PYRv7IGz6r0nHj0iM3qZbL0gVH4AiMd2WkIUxqFQMTpPlqC3SPV/2jV0+0st8ai7+Yk6oRU3r7g9Kl1z44JV3zmbv0XtHl2BXLiJRqsF2P3/kd0vKBaQpQsvnBPhgp2YNDA1rzK5/2FWe7BzCZW7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FO1gXUSxWR6grOAe3qImYHk8253C9kmy9jjwOta3EVc=;
 b=FIpNyy3q3/NRAn0pEYAlYbtAAuZOcsxYKWLBdAXegOIOGE3YsGrPfS1BXOCkB+ZH0w8oeXv4gxo+vHy93XziJEqiZWaL51KhD21yQG+b3HUVy3dzgtncxS0/1EFx3Ce/RC9V9koTWOG5na86CPM4hOsG82Ak1U3ZP+EgbLwrxJs=
Received: from MWHPR04CA0031.namprd04.prod.outlook.com (2603:10b6:300:ee::17)
 by DM6PR12MB3738.namprd12.prod.outlook.com (2603:10b6:5:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Thu, 18 Jun
 2020 19:49:37 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::f3) by MWHPR04CA0031.outlook.office365.com
 (2603:10b6:300:ee::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Thu, 18 Jun 2020 19:49:37 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 19:49:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 18 Jun
 2020 14:49:37 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 18 Jun
 2020 14:49:36 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 18 Jun 2020 14:49:36 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/1] DC PATCH fix
Date: Thu, 18 Jun 2020 15:49:35 -0400
Message-ID: <20200618194936.9158-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966005)(82310400002)(70206006)(70586007)(86362001)(5660300002)(81166007)(44832011)(356005)(2616005)(4326008)(336012)(6916009)(36756003)(426003)(82740400003)(478600001)(4744005)(47076004)(2906002)(26005)(316002)(186003)(1076003)(8676002)(8936002)(83380400001)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1fdb2f6-a138-48be-1bcf-08d813c0bbb4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3738:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3738A86775206B057C2CA6D7FB9B0@DM6PR12MB3738.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y8Mc1QaVCJUuycx2RTMo1H48wG0kPttqGdOlS5ogi53CHaHqS6xglpeITXdjgsDLdzYVbLyL1zOPRui9ne31O6MMKAMrJbW4Zx2qSYydg7nrwHdEL/fUAJ0lgb4xbRaWN3lXHOnGcVvf1nnKO00mh57R1etnRG+3RtXjAOlg2urYELSUFVJADc65g3V+x4y10rKphfuf3Y93AEq/sdQ4tGE4bwERU1dbFCWRhqlpWktgkqU9B196ovRCmCPJh5mmaOXw8Dm9ioK15XeiunYkTFqoktvnbUt769NH0Yloenm5Wgxl/u9YV5yR1fZaeFyjpAuFryOJdDpus809Xy/YxBWED1gaGSEkOCQtIZYWLqnlqucDDmzFArfHtJIx+XTdg2STn4MfvkijchjLrnXxdw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 19:49:37.5097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fdb2f6-a138-48be-1bcf-08d813c0bbb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3738
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
Cc: Lewis.Huang@amd.com, Aric.Cyr@amd.com, sfr@canb.auug.org.au,
 Harry.Wentland@amd.com, Alexander.Deucher@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas.Kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

An issue is reported regarding compilation errors 
on upstream branch. The corresponding fix has been 
attached below for review.

Qingqing Zhuo (1):
  drm/amd/display: fix compilation error on allmodconfig

 drivers/gpu/drm/amd/display/modules/color/Makefile | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
