Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0B4C282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F9F2080D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cVaUWBAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F9F2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C786EA4F;
	Fri, 10 Jan 2020 14:48:24 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770049.outbound.protection.outlook.com [40.107.77.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 398626EA50
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/LFsgTRfC5JMq6KXPAZLzUjcdXHY5lqMTBgtQe3Ub4uuhwLL6HT5ilRXlGCdCM8Pn8IC1ncHs2Mo+/YM/tcC8LJ0t3TYinyWG6rarp7jX3yMUzMoCJQIhvovCa9nwPRngYOFQvpi5La1k6LlqadgejRdNakMyWwuwsyOaoE+avjdnKGXRg5Ig3DVsdFtpIkhCc+uGGwQJzKy6PEHNB+NdwISIJFM39zqPITfe+5RKG0wUld9oLvP6xwyAy+jFtp49ug2vvPPsUT4zUP09e9loft17E97/y4NaNMUCCSAUDJlWbaeH9wZhKyRDGmY4D0gR03rYbSXwrti3j2575RKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hImSDvnAnkObvbRYEBYF2kTf5xa3S/jy6AuaNPO/vOQ=;
 b=F4b01RyAAfZ0uMtJ3+vz4QGnG/V16OtvRDSTTB/HX/dgnsdVKYI2yHqkyLHzdhw1Rf3wAhHg7LXHhvaRN0eE3kK1LuX0HXb67SLYRVgkqW+h2jKR/60GGueki0Atu2j2av6OzOWrvd1tjNEua2S8yx1iL7lofnmsJe4Qmm1CQ90zUYRpc7sZEVK2RcDBjsxKFiX3YEKwq5ZR5QpJNyFiBacMJIvsb1v1J5Stv/6scCM46KjKkkC/gkwvpYwRPG1tgUIxjdLj3xcxlWbxX6d79uSNdRuPfYVsYH3snmykZlYMKhBpZJP+zYPe2hiYqhO26FcVuSD1nHd5VnwLsSjLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hImSDvnAnkObvbRYEBYF2kTf5xa3S/jy6AuaNPO/vOQ=;
 b=cVaUWBAVhlcXhU/vzK9sjUkZP0PQD5FP/llft+EPYiU0824HjYeaxRjAz7W9bGirGgbfHI2BRCcySHSGNViLi+xztbfeZ4tptOzTOmxY4GaVNgnhzSZLIhfOCnGNNqKU0fmdmMwOB04Oe1ckyDw+8HCPOkzUN88gqSzPD/r9HK8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2378.namprd12.prod.outlook.com (52.132.183.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 14:48:22 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:48:22 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 40/43] drm/amd/display: fixup DML dependencies
Date: Fri, 10 Jan 2020 09:46:52 -0500
Message-Id: <20200110144655.55845-41-Rodrigo.Siqueira@amd.com>
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
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:55 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f7141c85-29d8-420b-02f6-08d795dc1463
X-MS-TrafficTypeDiagnostic: MW2PR12MB2378:|MW2PR12MB2378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2378335DF881CEBF64C1B34E98380@MW2PR12MB2378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(54906003)(52116002)(8676002)(81166006)(81156014)(86362001)(478600001)(7696005)(6916009)(26005)(2906002)(316002)(8936002)(16526019)(186003)(66556008)(4326008)(6666004)(6486002)(36756003)(66476007)(5660300002)(956004)(2616005)(66946007)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2378;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zlb/h+oPhfM70djFohd11lnmIR5w7v/Knk6uQNXaNnPdRo7ZktyL5vn908pm6YRHmmOS5I73U2ecWUCpAK8zUEcKstTr1WruJ6nesrhZcqt66oh3e1tMsfqHNqyF7RyCD4biIIduj1GHkRYCkknxzTMtggXtrOB9iTUf/K9+N96FwbUD2MeasVdci70Nm91YjzPq5QFLB5cl5NGCRFPr4bDYhsBKEhmy1PQbJkFKMEAE6DrJjd1l1bADaYIRA8gnl6inW+qY3nNQKFhLkr4GWWq3qbFnXHh8kB7GmAsEeeoLiAgdkufabw0RWjKOU2rJJAJ8t6gzk8y0hj2riYXvC/GMLhgEzcD2oQvdFACFtghRrfliGvtutYE34GhK+Y+thYo+pi5+DOMYY8SXQw2cMi/AEBTu+3lvZLcTPhFdlzwVbqbiRx1kZN7Vnh0QztGO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7141c85-29d8-420b-02f6-08d795dc1463
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:56.4940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxZx8wYLKBJ7Xhp9dbF36PPwImi8uunP7dXgOKAitBXem8FiDAl/gonD50kETOTZLZx+7ol0qZWxHffZLr5yZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2378
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jun Lei <Jun.Lei@amd.com>

[why]
Need to fix DML portability issues to enable SW unit testing around DML

[how]
Move calcs into dc include folder since multiple components reference it
Remove relative paths to external dependencies

Signed-off-by: Jun Lei <Jun.Lei@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.c          | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h          | 2 +-
 drivers/gpu/drm/amd/display/dc/{calcs => inc}/dcn_calc_math.h | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{calcs => inc}/dcn_calc_math.h (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.c b/drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.c
index b953b02a1512..723af0b2dda0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.c
@@ -24,7 +24,7 @@
  */
 
 #include "dml_common_defs.h"
-#include "../calcs/dcn_calc_math.h"
+#include "dcn_calc_math.h"
 
 #include "dml_inline_defs.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h b/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
index eca140da13d8..ded71ea82413 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
@@ -27,7 +27,7 @@
 #define __DML_INLINE_DEFS_H__
 
 #include "dml_common_defs.h"
-#include "../calcs/dcn_calc_math.h"
+#include "dcn_calc_math.h"
 #include "dml_logger.h"
 
 static inline double dml_min(double a, double b)
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.h b/drivers/gpu/drm/amd/display/dc/inc/dcn_calc_math.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.h
rename to drivers/gpu/drm/amd/display/dc/inc/dcn_calc_math.h
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
