Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A08C2BA1E
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C31B820644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mw74XC1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31B820644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 624CA89FE6;
	Sun,  5 Apr 2020 20:42:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACA6789EA6
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGufQnb8qF+P8htqqAZ10hyCeRuy6HjNojekwC177YeYPc725Wc1f7qo7QAm3IGKzLjDiCUQLroZSGuAy1n+fp34m5ZXF5VfmBGBGQ7zELCLp13YdWXqXRCI22L7RYhp2fRPlUOoGZ0wdKODn8hiZLJbekDlMn9aSt3F4Jrb4btZutVPGqYKv+zG56+U5/uWEzlM/b4NBrWRkfmmwU3qfsFnXH9AUixvaetEG53cIET63FmhfHsBGADuLnmxdF7XxRdkiZCH2wPMIrTbc7mv3BfwjjQyvHNAvgYvdTxS5nota8gWSsl5xbNa0+mBf3Y7CbyarBlL7ysTc2cLyUY7IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so2fqKc0tLgx/rMOEX0nd52PKBYyWSko429VBnWKPdo=;
 b=KuXXWwCf/XGTCDaJ2HOTsh50Q6nt9gl3Ne/rxbFwIbcHEJ2/vbAtkGiyVMhuIDQHsZn9QWKM+hRLleBPkrGLX22fXE2j5tlGHbKlmNnCb4ihNwUNo6ZClkDgdqyZSSL3+moAPdAkcqAOzuY/rdfA8jXtw8UF3M4AE9KKqINdH1M1O5ZPFN+kFEOigfEhYieXwUIAsOJdJsTKbnGhA+9gh7O3HaXkzBKJjAENbrktlYG8eEkcLG12M2yYL8EjBuwPbc7NrA0FxYa32cxlZuw2VIYEOiKK1QkdrDD60ZzATdfyzGSV8FvBV1eia5Kr/2JO01MGbQuGB01rxrL7qzfJGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so2fqKc0tLgx/rMOEX0nd52PKBYyWSko429VBnWKPdo=;
 b=mw74XC1+5AL5HF6s1BGp5aTsz//vst6MCyMUsfxEr1IuJBdoQM1/UfWLbwSUSeZdPBZvqJ6m62m2PAW3MMp3kwIHiIZMKSQ80rJIjHtrGISUKNYZKWu1DhETRqGmvrkeVIqw62b8hlX6UcT3ZO5R01l2cEN3xGhxuT5rl/OV/jE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:42:38 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:42:38 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 32/36] drm/amd/display: Acknowledge wm_optimized_required
Date: Sun,  5 Apr 2020 16:41:11 -0400
Message-Id: <20200405204115.683559-33-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:42:09 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b8c4787-0c26-46fd-6067-08d7d9a1d03a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB255507DA5C7EFFF384C96A1398C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(6666004)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ZHbf85qEYVrMQw7g3BJhdvXPr6Wa0TLrj6KJzl6V1ihGdc3xceQqb3aHHcz4pVlwFHKfSK5udddztUHR6hZVoUtcnqGv4hanlNR3KKM7TunaWVFp8bGuu3O3LiSqnc4hcc8EkDL9VeEki9GxiUblLpNy+HPYtH7PhIfwpALHmAsDfctUZytoRUvnS68NyL8aHZgh8a/VFdC6bJfGGxAbwx3V2iI1aNWg3pw9w88Ec2S5mJaBzALjfNV5yjYfv2p6DHXNhspd+yJ79ob9cQShdg/lHoCXzir79JG/m8lQOANx92j/7DpzjxxH13U2cMJbD7dpotd7VmDZogH7xKhowYLyJlUyNCAoHNTY0o0jUuqLuhtUQ1vlruhFUycOIH1Qh1lm5DwZTfoScw9Q+sX+XKDffN+qibT1hzL0jHc5Q3yYdnxlVPgcMcbUHY67GI8
X-MS-Exchange-AntiSpam-MessageData: 8+o/gqp80PwQI0BTDlhSJNagA/Ya+aoUpzpxgirOzhXtJ+YB65DCdmQas0LdlRW6csUW2aAgoCUfyYfN2/A/lRNFVqt/dkwnV7u0QaDkMHQ62i6G6GnIUHzTPpyWYpRigJvBAruVfKYXKaaHueeqtMbcsxWKZYCU58Ve8oOTzAk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8c4787-0c26-46fd-6067-08d7d9a1d03a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:42:10.4881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+MdRL54orvtfFyePEMls4mFlJikBw2ZY3bKlRA7MUBYCW9eN/kQl/EIfspRbs4E13cm5bLm1F+tEnfLURnseg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
If dc->clk_mgr->funcs->are_clock_states_equal is set, then
wm_optimized_required is never checked. In that case, when going from a
higher mode to a lower mode, wm_optimized_required remains true until
the next mode change.

[How]
 - move from else-if to unconditional or

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 512703eeaf82..8489f1e56892 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1861,8 +1861,9 @@ enum surface_update_type dc_check_update_surfaces_for_stream(
 		// Else we fallback to mem compare.
 		} else if (memcmp(&dc->current_state->bw_ctx.bw.dcn.clk, &dc->clk_mgr->clks, offsetof(struct dc_clocks, prev_p_state_change_support)) != 0) {
 			dc->optimized_required = true;
-		} else if (dc->wm_optimized_required)
-			dc->optimized_required = true;
+		}
+
+		dc->optimized_required |= dc->wm_optimized_required;
 	}
 
 	return type;
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
