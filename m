Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F2AC35656
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B1142067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GJTjf7Ps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1142067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCEA36F49E;
	Fri, 21 Feb 2020 16:03:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAEB86F49D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7bPAGKA5p70tjAIllmKmPIBRXfJpc3rbpr/eqvoqxS1b4H6+hrHNK9NBKLgHJBF2Spfrw08CjOsyGORrUqzTgcT8UkdhpO298Mh2PnKepa+ENIOKb3UvWEA5noZKOB9UKqEShMzmPYLNL7zM1bcIKcR4+gw7ZTpl0lUSEtl/y9OqQHNW3fWb9pH+zGa8iTqdE4oL5Fy6I+5JJ4C2Ffn8QQcI/0WzAtAHXGCAKfv1nqLosQG+V0SntDDjJgaXqrsO4S/+r5vNIkr3i9f9sxBMftoe1SRY5A37ow4OxmQU+ddOsLvjhypTRGswp0SKwSFACAbDlR2JHWjX2pBlEbD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N40b6kR2X9+TIyBj+wk0qjffd76fqLVVtTVpP1F3pz8=;
 b=c4hQZzKWbT7pt/L88Y0oT0zAN9NeNAlS9SezBpsptu0RaYH7ZGiycxi/pp7iAAlDX9Nhr9te13+ewd8aHnjAWhxaIdFuAYXYEi0b+kktQJRExgqHOtbL8rQ6Jvci+Z8HhTY8odmV9/Dwo6jBD3LzC0pdxaXFhX3sUAkE0Rs8zKJmIsEXFgyY9mQvWhAE5VzNqia0HgkicBisdCHvjy+L5Jz1eShbBPcRjpztaaayuvY7rSn0r6Gjg/taHWR2BygqhaE6cBBARvTBQKBS+Kw5fg8q+WaHrIOQoiH6KhPScNn1KKMB0TN/tsyvcg4l1by3ycpOWxs/ebl28S1k7dqROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N40b6kR2X9+TIyBj+wk0qjffd76fqLVVtTVpP1F3pz8=;
 b=GJTjf7PssOjPjFaH3Cr3yu8T24Y/2UoigxKcRnLy13FSdB399hTL5drblsA0UnpCCphuRQDJveZzXusI8OhlISH2J015ha8ScovWzlLnTpyj4APEJ34bRcSv2NI0OqGeENhB0U31uPKqUPRmpGnng7OSjQJMlYYEJp4P/JTIm68=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:03:52 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:03:52 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/35] drm/amd/display: Wait for DMCUB to finish loading
 before executing commands
Date: Fri, 21 Feb 2020 11:02:56 -0500
Message-Id: <20200221160324.2969975-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:03:48 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0125ed8e-50df-401f-5f8a-08d7b6e7a388
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB257212DA1108502732F4922E98120@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(5660300002)(36756003)(2906002)(8936002)(86362001)(8676002)(6486002)(81156014)(81166006)(7696005)(52116002)(4326008)(6666004)(316002)(186003)(26005)(6916009)(16526019)(54906003)(2616005)(66476007)(66556008)(66946007)(956004)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jKkdONRHQYW18BGyi7me+TcsolL++LL3YM/3ELP6umGHOznyFzi4Aq7VQIA5/vd+w5yU/e1czG3q3sKWtATH9ssono8NDCe3BAd5cY4lu7sngo1DOS2uFVYwRNwVc/Um+8taXIkz4R4R9agr8NXLqzyZ5+e3agOTLyz8bXGEFkHt9R5G8wYsS4H+eMUQ4zXmSBFRNRzXDgAcqfemF21B8DZuPU8XvelVR2GJYcjbgm/hoAz6Oy7MaLeb2WFwsznTxEurWaTXB2ARa+oSiq81afZWQoTqnUvWQxiDXw/DcyPsC0VW0wkya34/F9R12U0lhMgaHH5T5ARJ+3GwYE6XiYDaZjuwb7oqRA/2nrxXpoji3yzMZXmzsK1njP7uiLE+rWNyP88uk98XTSXOtEJJegbUENkPFm+6nZgSZRbaCNYjqjcDoISKwTPLJ0gWAdGH
X-MS-Exchange-AntiSpam-MessageData: kC1vgJ57eTCqjtJGkkfz+EzWCU1YZPBKvWP/fixB/BZ7iex8dlvw6yZ6gkqrlnWwuxFMPKpfPgsESsq2EDryBaa2WpWxtaGyK3vWWQAFzbyzn2+8XpE+k+ZiO0pIt1pP1JQXT1iiNhQceHuU5Z2xOg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0125ed8e-50df-401f-5f8a-08d7b6e7a388
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:03:49.5297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: at7dbgdRzsG3h9BNKs6rm0OflFuUcXHWlvbxZY/qcelmsmk6CkK0cZgMkkxflnAiCZfLtl/8oQHuiSLPuSJzNA==
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
Cc: Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
When we execute the first command for ASIC_INIT for command table
offloading we can hit a timing scenario such that the interrupts
for the inbox wptr haven't been enabled yet and the first command
is ignored until the second command is sent.

[How]
This happens when either the SCRATCH0 is already the correct status
code or autoload check is unsupported.

Clear SCRATCH0 during reset.

Also ensure that we don't accidentally reset the ASIC again in case
of a hang by clearing GPINT while we're at it.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 993e47e99fbe..63bb9e2c81de 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -116,6 +116,10 @@ void dmub_dcn20_reset(struct dmub_srv *dmub)
 				break;
 		}
 
+		/* Clear the GPINT command manually so we don't reset again. */
+		cmd.all = 0;
+		dmub->hw_funcs.set_gpint(dmub, cmd);
+
 		/* Force reset in case we timed out, DMCUB is likely hung. */
 	}
 
@@ -124,6 +128,7 @@ void dmub_dcn20_reset(struct dmub_srv *dmub)
 	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
 	REG_WRITE(DMCUB_INBOX1_RPTR, 0);
 	REG_WRITE(DMCUB_INBOX1_WPTR, 0);
+	REG_WRITE(DMCUB_SCRATCH0, 0);
 }
 
 void dmub_dcn20_reset_release(struct dmub_srv *dmub)
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
