Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E30C388F9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1022D2225C
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MvSalVbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1022D2225C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEE8F6EB41;
	Tue, 27 Oct 2020 09:42:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE8A76EB41
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 09:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hp/Uur7ipDEm1HFL3eJPNBV1pAWy/rW0IGccIKc4hqB+NwTeU1eLuxZomdyYKL3FJQk9HAq9r9+d/knIh5JuDpmMlF3k43PmWV6/5Gj0DDte91C3BwqXd7UEs3F0wNyYTlNJdEULolseGdKkK5yAHoLie2pp7k+QBarNAM/ALbKrjtYeDt1MWSIusLtNkZDoBppaPmYkYFKZGMs+gXCAVbldWjB2pdwqsojaLRyX3VnfKzaLR8B5b0qPWqzJMqY9KZHz89U8ddrZV/SMjDHrNhTFyI8Q6eW/F5Ic8MSpFMGs9MEuwqscVUniro3oWhfDWU8wePHY97LcFdTxPNzAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAm05J//CkaDpqy4ZcbWzBmCf9OYiCx8X8uL6ez6E+Y=;
 b=CEc/w+zeuTR5mfs7+eIm9VP+bdHPCVrAqNbtQV7sLTSk0wCZEG/ZtGRVTmH1UgVvWVDv+WZX3JogFLzFSSJMQL7Y5GpcOXjFh98CjxPNUcOtbx7AVEU79DFXh3vGN5EL5DKvjfM2WW2TD0LgU2+Iu96BnlpNVNlAEZUA2+7J0swNtG4gLrUYD51XdTXqRYXbc/xpIKGJvHrRWJbLD/kiMWFcB0nqZGcLBjHRVs0hAvpj/mVpkn+gWyTgtBsDST5vIWCwT2CZ0ksH5fl6lOVRjDtFGvs53in1lxu5aCyc9fWpzOzUiK1wiMDJzbDevOdXzC1O3Lo19DV773fzoVor0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAm05J//CkaDpqy4ZcbWzBmCf9OYiCx8X8uL6ez6E+Y=;
 b=MvSalVbt4c0EKLtIStcnTwxCaExgdyeyhK1VBM8S8QD9vzRa2x8l5WRz3eCSdRt3s3ULwH3ST46LmVUBJK+cyWkrWbeme3DJUagvVkE+THr+gAoC1556mNZ+5bOs2Rr2U4PNP26oMIVQLBMNQGH3RmaKonWEBfqZcJrMdGpLZQo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21)
 by CY4PR12MB1845.namprd12.prod.outlook.com (2603:10b6:903:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 09:42:08 +0000
Received: from CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624]) by CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624%7]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 09:42:08 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org, ray.huang@amd.com, evan.quan@amd.com,
 Alexander.Deucher@amd.com, kevin1.wang@amd.com
Subject: [PATCH 04/10] drm/amd/pm: add UMD Pstate Msg Parameters for vangogh
 temporarily
Date: Tue, 27 Oct 2020 17:41:27 +0800
Message-Id: <20201027094133.21881-4-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027094133.21881-1-Xiaojian.Du@amd.com>
References: <20201027094133.21881-1-Xiaojian.Du@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:202:2::20) To CY4PR12MB1639.namprd12.prod.outlook.com
 (2603:10b6:910:f::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR0401CA0010.apcprd04.prod.outlook.com (2603:1096:202:2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 27 Oct 2020 09:42:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e804ac77-12ce-4ccb-64e3-08d87a5c91bd
X-MS-TrafficTypeDiagnostic: CY4PR12MB1845:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB18457DB3D540C194978E0865F1160@CY4PR12MB1845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wxAxpLy21tO1qumPWQgm7spgGhQynsqIZ3K7RZF57DD3ANfckH0T4LukeG2myKzz/1PUd8y5Ezjp2Xyyc4GEt2ss2ISzfE/haGQAxRnsmmDc5r9fGUhXplGJ9MmML6CvSGvDR0NLMee1yzcJf/GYZa94zpn86mT6UdPYN31PbvtMjEG0EwJLLJzoYvAiuGcomHJVVyoI6WcrxCfagl5X3/Wzf9PA37eSp7GnV96Ee2ZNB5BX83jO8DfZJ9ZVvO0O15hESmxwcHZxS4ur9ZKFZ0eDXbbERom2YlT01IKSn2fpAOMj5ZKEnzRuarmwmHmAUfCV0bUI9b7fPgI7lhxPMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1639.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(7696005)(16526019)(1076003)(52116002)(6486002)(8936002)(66476007)(4326008)(186003)(86362001)(8676002)(478600001)(316002)(4744005)(6636002)(66946007)(2906002)(66556008)(2616005)(36756003)(26005)(6666004)(956004)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: avqi4VlBO1lMFkiUsp2e1CIqox6TL82yfEK+NKBwR7R4fuIiNsQF9zHbsbdtJMVnxaduEI/kfkMu6WHsqySlKnnVIL787oKWOa4tcH37FCZQFaYWXDApwtynm+x2NZFmOjlGbF/ta5aO7jlQiMZ0zRxmCSrPsccX6RHTyHjClk9KSSsqE5xB2JSrfXQbtJJjd39s92pDfkUZB7LPyuovj6/7ntkjKeNFS5Tj6OFKCyRKew0bpwY6Qm6g48fdYWJtf66ARXZ5ml//a+zkHBNhIMLqvw+YjE7HnR8TuapQ2QzmX4yrOOvYGqptqdDw0kXR+1pMhR791Rc3+o99lJmLspXoLAnn6FsI52pmw/L9CPsYtbqLDi20RIfuIDSJZ4YysgxSvqC7YoTR2DEocgH/yb6loUURLE6rwfrqVeqYwgOhTaGXockJiAb3Q68EAAa347hhD/GqqeGFaNAii4VZdnpVsxCtK4xrszTnnVyFFmzeYMRZPH6HJ//BttxTkR/N8P7HR2MzxkF5LZOHCck7Yy39RCuDWUFSQMpgFUlTZzOzk9lM9EV/NBdRxifHSKfwPBfiiJg6dUTWLUHCKdPydBH5VXg5DzzGKkPBObDRz+6d2FTwKIWoymZJEHehzplELNq+Uitz5ZQTKIoqmhtZbw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e804ac77-12ce-4ccb-64e3-08d87a5c91bd
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1639.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 09:42:07.9231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpxeMPt6MKJAnPKv76ssGQDzS3f2cHD6VUuqh5rJ2RjUYP/V9Xwy/xugrCfE3JN7g3Qs8W9DHq0rmByCTbpKAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1845
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
Cc: Xiaojian Du <Xiaojian.Du@amd.com>, xinmei.huang@amd.com,
 prike.liang@amd.com, changfeng.zhu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to add UMD Pstate Msg Parameters for vangogh temporarily,
     the values refer to renoir.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
index d8696e2274c4..8756766296cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
@@ -27,4 +27,9 @@
 
 extern void vangogh_set_ppt_funcs(struct smu_context *smu);
 
+/* UMD PState Vangogh Msg Parameters in MHz */
+#define VANGOGH_UMD_PSTATE_GFXCLK       700
+#define VANGOGH_UMD_PSTATE_SOCCLK       678
+#define VANGOGH_UMD_PSTATE_FCLK         800
+
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
