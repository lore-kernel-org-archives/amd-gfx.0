Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17351C4741F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74B520867
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NNRjZxgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74B520867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 403346EB58;
	Fri,  6 Nov 2020 23:19:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 041CB6EB58
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 23:19:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4DMMDoe6yL2V8Q3dpJVmpWToiEUW7bxJM3vSvpwS40pmuj0HztHtZ6FdisJFCHdIGuPihwyQfvUo9t4+CJSMEpEeU7m8BS2zPHqnhQGx+6Skm/yYR7xF7SRXOVt73NEpQKg6TFh1B6tINnn2HH+MAwwUnaSVfb/zXCGKIlwyTW2NC0e++yO4Nyl15MnfLPR6llm+Y2UXdrNNBBONXRO++3OC5RWnRcKGscpAdOEAqsyEIowcIqNC6RLKgwm0ix99bXni1NSMRUUGYSmCDxWtDP6L7h+eZ6yx+KcAzCzPIz8KzLCnMhVJJ2axrKngEnMrMyeIQ8PGr89ybf9o6gH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uygNz62LdiNJvNICkKFVF1yMQX/ErtS9R6RNyvnOBwE=;
 b=BuMGM8wUDaFwoaPVbuMqh2lNs6xneuosVuz/kgsAL47+woPukeOmqEOE8eCoZ+XB+hP/2veVjZGomXilGtfNAcM6zJe1YWH//jKWBX4Gd2eYDqKf7RuXVoNUI0uUsEqpbELYagZboif0vt381zH0tCMTcx3b2pzYX8JeudygLH5GxhETiQyd7A9FVHqK0qfvW/YqK0261R8wTofsTo5tcJBUHvUhJygPeWvYVk5LPBpArVbx2JQGuTtGhFpNtxfKFZTQ8zyQJ4YAsZPc3i3RBP6CFzJTCBEnfzX/KMdnoJE2dV24b+8TviZsSw25Xacf98o6fQTbA+v6PtGe5J8B+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uygNz62LdiNJvNICkKFVF1yMQX/ErtS9R6RNyvnOBwE=;
 b=NNRjZxgGWPcOqjr+bhdGJdLR483A9sXhkprOKzZlKz2RIrHqA0eZRPvV2NY4uxrg+hoBozr4yFBtHMgx+i4gSnSEJhfglCyoN3bNp8aMqTJWB/ZP6aRI6rBbVaTnitByP+nmHFxIYKNPUl05dCjrQu1TwrORd8nGCKgtU1O7/Pc=
Received: from CO2PR05CA0005.namprd05.prod.outlook.com (2603:10b6:102:2::15)
 by BYAPR12MB3000.namprd12.prod.outlook.com (2603:10b6:a03:d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 6 Nov
 2020 23:19:34 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::f5) by CO2PR05CA0005.outlook.office365.com
 (2603:10b6:102:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend
 Transport; Fri, 6 Nov 2020 23:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 6 Nov 2020 23:19:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:31 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:31 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 6 Nov 2020 17:19:30 -0600
From: Bindu R <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/14] drm/amd/display: Check other planes for iflip only if
 GSL already enabled
Date: Fri, 6 Nov 2020 18:17:06 -0500
Message-ID: <20201106231710.1290392-11-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106231710.1290392-1-bindu.r@amd.com>
References: <20201106231710.1290392-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29aa43e1-5496-40a6-50bf-08d882aa6b8c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB30003AA185CD2DF7546C18B3F5ED0@BYAPR12MB3000.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7JwzQoEYUK7aQJOsCcGilSMiTkpEZSdAbU4yVOiLLDq8RmyfIO9lgoGVh95NmaDpCGYHOyBYB1SAoKz7x2OmaUOPAd1RdhD5UTScivKzqEIYLsK5YbfPpcrR+M5zBk7NKjptvvvO4l6WRCUMu1hTIUzT9phMSADfplZZZfsjYDCP3O4XQcr2OULQg/lCIfYv00gNvL/ufvVrFmykR9GlkOdSb4wLfu46rBc4djaXZDi8gHSKX8ISMiMF56i46hjiRtQzByo+KFEKcDgl0aw93NaMfF7YNQGIqIC6yFPgmwTwv2rnS49ts7dO+nNpGsB4vkIS0W97b8hL/EV5yVk1wpvS6n5Sp2iv+qp6r5umeLPLsbdljxjDZku9WCMQBQShNBY/uCnBdHCb4suD4090ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966005)(83380400001)(426003)(6916009)(5660300002)(36756003)(8676002)(7696005)(2616005)(70586007)(336012)(478600001)(70206006)(6666004)(81166007)(316002)(8936002)(82740400003)(54906003)(82310400003)(4326008)(2906002)(47076004)(356005)(1076003)(86362001)(26005)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 23:19:33.1655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29aa43e1-5496-40a6-50bf-08d882aa6b8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3000
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, Bhawanpreet.Lakha@amd.com,
 Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
We don't want GSL to be enabled when only updating
plane address

[How]
Only check other pipes for immediate flip if GSL is
already enabled

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index da776de1dd1d..38bf6bfdbc44 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1170,11 +1170,13 @@ void dcn20_pipe_control_lock(
 	if (pipe->plane_state != NULL)
 		flip_immediate = pipe->plane_state->flip_immediate;
 
-	temp_pipe = pipe->bottom_pipe;
-	while (!flip_immediate && temp_pipe) {
-		if (temp_pipe->plane_state != NULL)
-			flip_immediate = temp_pipe->plane_state->flip_immediate;
-		temp_pipe = temp_pipe->bottom_pipe;
+	if  (pipe->stream_res.gsl_group > 0) {
+	    temp_pipe = pipe->bottom_pipe;
+	    while (!flip_immediate && temp_pipe) {
+		    if (temp_pipe->plane_state != NULL)
+			    flip_immediate = temp_pipe->plane_state->flip_immediate;
+		    temp_pipe = temp_pipe->bottom_pipe;
+	    }
 	}
 
 	if (flip_immediate && lock) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
