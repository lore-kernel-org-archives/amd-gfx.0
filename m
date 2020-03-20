Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D3BC4332E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDF92072C
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LAwILo36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDF92072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55CE06E19B;
	Fri, 20 Mar 2020 15:11:59 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770040.outbound.protection.outlook.com [40.107.77.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 121396E19B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 15:11:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjZ8IWaAwQ2g/tDFH/5CHaPi/FSkprh1QsU8ucKPI4F2QY4DKHjtZZebBd9w5Zpox4FUaYr2+1k8ZleDhjo7zDWbuzEvHYuh2TIo9Rj+yoeFY/xCYX/eETBhejukUq597vqUngV7iZNXW5GOo/oZ89tPHMLvA5MWers49CVMD9WabF9ffJ1L9WR54VXtyXnsy+IhyN9Ipl3ObsD6eexuJio0VUz7JjWdPQ3S+v3dJ9JmgD8GU+Fz1NcEAWeg3JcywnQ3zQLsFXimwA4s/bpxwqJ5W9GNmVhYF04Y48M57sWS0+RSfiF3HoI4zu1BiVmDSS58ZVW+SmlyeTMkCVkA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5lVZR8OLz5OC+vwDcV8ShZ3EpKk0f9NQBQQZhGrqk4=;
 b=YhmFEhpXe5LlSzON5LBvNsH/O1m3LUAIOu8UsvF+XwkjlhxYPISepB7cGYzO8qoSVZ3RL5s960bGYuQuLq3wWnMiuqihm+VXI5E2WRAMT1Htdamt+6k4AAGii1Gzw/uR9b2mh2ZEQTlgQNUeNFr9HclrN8Th6BaXA0NPalP/XGk5AY8oQogYEDSyqblr2RVtq+n8M2+Caf9h/7WiYTp3Easo4euagb4zS1Y5zh60umzk/cBuFqIOSKE6VtAUerO/+oRl7H4RHihl53Dgu9L/mjoCz1nweMKAy+GHDvq1iY+YkOcFyreirdoIgL/W0iJ1K3U3S+k1xGB8x2N8wP3Fdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5lVZR8OLz5OC+vwDcV8ShZ3EpKk0f9NQBQQZhGrqk4=;
 b=LAwILo36n75lNWMpNcr++LJj8ZkxAw6c9000EJDK/ZTHEw3I3+++b8TfvFJUuxvhIE28iSwLcordxEUisCsIjgR69sibeTzmx9dS/9848asCHSRJ6Wy+ehfWNBlmzBw2XrTVB1/umAtlbeOWhIgFfrLZiHbDz/1jRBecSopimfI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 15:11:55 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Fri, 20 Mar 2020
 15:11:55 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/12] drm/amd/display: Move backlight pwm enable function call
Date: Fri, 20 Mar 2020 11:11:26 -0400
Message-Id: <20200320151128.2039940-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
References: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Fri, 20 Mar 2020 15:11:54 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b6e2b666-74df-4dce-4094-08d7cce106ac
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2572AA998DA177A4079E723298F50@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(81156014)(66556008)(6506007)(54906003)(4326008)(16526019)(2906002)(8936002)(186003)(81166006)(52116002)(2616005)(1076003)(8676002)(86362001)(66476007)(316002)(66946007)(6666004)(6486002)(36756003)(5660300002)(6512007)(6916009)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1mUPRdX7mSKytFpcsjVfcm7gduG7O5Y2TfI5IgF2SsuB+Pl+tFa5e/VNyfuCfwNoxE6PqJMoaYHdgko18Fvt3ToQXxQ3n2xqLmpgxLR6ZaMJgFkdNIAwGA8EgmAuTig/i3Dq9HHyDa/Lo2oswPjBvssaJOGTH5owhfhLpECjNNlPBhSSHivWQg9krN9wfb4recsJXCLhqgJOVlgZJdJ8smO+V0264DOkRFxRAVP6v/hV5lsYAhsjRRcPyQvlBZ7CibMi34wLUi2nR4pHZpMHE8aMVK+4wU7414Lh6KBbHaxKAcgfeidZFQK5yTczmKFwtt/AcJrxDbo+W8O1W9WRZPvoQ7Q8Ga36W1uMZjpCeGVxPTQuhmQmvU2RLjRdYcyvd+sz0RhDporelTousHIih0/ILKDpehb7thZ6UtSA+OFDJ3+0O0dYBTyTxZOtq0l
X-MS-Exchange-AntiSpam-MessageData: rlwGLki3w6oJAi1+ubfIuj7OjLDiI3evW9N5umQGj2Qm1Y7MLnd+UNe8EtAiMk9KuQB+Pt2rismclwNZLteJQu2AUBBFSqDCbwNBT0jXUOkrCaagCgXf/WcuCre/EIMGV/p/s07QfXJyTzUnDIOuR8uVM4LsA1SrRYJHrmP2ODU=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e2b666-74df-4dce-4094-08d7cce106ac
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 15:11:54.9603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lDWjfLwSHuj24MGJ0s96EidPxiEcevhZrLLXxnNRbZRjqXc+DfhJ8T9QgGY1gqGPYeZNnfelDN4Ucl86BvsVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Wyatt Wood <wyatt.wood@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Can't call dmub_abm_enable_fractional_pwm from dmub_abm_create as
dmub_srv is still null at this init stage, and therefore can't call to
fw.

[How]
Move call to dmub_abm_init_backlight. This should be the first call from
the driver for ABM.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index 1d9100f8c0ba..81c967917c5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -257,11 +257,28 @@ static bool dmub_abm_immediate_disable(struct abm *abm)
 	return true;
 }
 
+static void dmub_abm_enable_fractional_pwm(struct dc_context *dc)
+{
+	union dmub_rb_cmd cmd;
+	uint32_t fractional_pwm = (dc->dc->config.disable_fractional_pwm == false) ? 1 : 0;
+
+	cmd.abm_set_pwm_frac.header.type = DMUB_CMD__ABM;
+	cmd.abm_set_pwm_frac.header.sub_type = DMUB_CMD__ABM_SET_PWM_FRAC;
+	cmd.abm_set_pwm_frac.abm_set_pwm_frac_data.fractional_pwm = fractional_pwm;
+	cmd.abm_set_pwm_frac.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_pwm_frac_data);
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd.abm_set_pwm_frac.header);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+}
+
 static bool dmub_abm_init_backlight(struct abm *abm)
 {
 	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
 	uint32_t value;
 
+	dmub_abm_enable_fractional_pwm(abm->ctx);
+
 	/* It must not be 0, so we have to restore them
 	 * Bios bug w/a - period resets to zero,
 	 * restoring to cache values which is always correct
@@ -331,21 +348,6 @@ static bool dmub_abm_set_backlight_level_pwm(
 	return true;
 }
 
-static void dmub_abm_enable_fractional_pwm(struct dc_context *dc)
-{
-	union dmub_rb_cmd cmd;
-	uint32_t fractional_pwm = (dc->dc->config.disable_fractional_pwm == false) ? 1 : 0;
-
-	cmd.abm_set_pwm_frac.header.type = DMUB_CMD__ABM;
-	cmd.abm_set_pwm_frac.header.sub_type = DMUB_CMD__ABM_SET_PWM_FRAC;
-	cmd.abm_set_pwm_frac.abm_set_pwm_frac_data.fractional_pwm = fractional_pwm;
-	cmd.abm_set_pwm_frac.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_pwm_frac_data);
-
-	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd.abm_set_pwm_frac.header);
-	dc_dmub_srv_cmd_execute(dc->dmub_srv);
-	dc_dmub_srv_wait_idle(dc->dmub_srv);
-}
-
 static bool dmub_abm_load_config(struct abm *abm,
 	unsigned int start_offset,
 	const char *src,
@@ -386,8 +388,6 @@ static void dmub_abm_construct(
 	abm_dce->regs = regs;
 	abm_dce->abm_shift = abm_shift;
 	abm_dce->abm_mask = abm_mask;
-
-	dmub_abm_enable_fractional_pwm(ctx);
 }
 
 struct abm *dmub_abm_create(
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
