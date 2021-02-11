Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1464C43381
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB2764DA1
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB2764DA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B9B46EE6A;
	Thu, 11 Feb 2021 21:45:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C64406EB9C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 21:45:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDOcWyU83GSsvdCaVhOvD8NFoQbce7hUqXfxD/zKIR9DFnZYKG9L/JR2ivnKcF+9gICrOPZe4vV2gzeafkwkrgpOzFG0nzKW9uyZKra8EVOlpMDwPA9LsUXTo97m7U75dMHpiOo6Rbz63h9ubEqrIwiq0WqXAToF3lnPCGTWBjwQAlD/0ljeinNH+WiggFLBvflYRXQzqlESmlRQV9musjEQ1Q1vnmEuawSFB3YxGpdKSHESw/96zgWsGclx3klacLhEMBaa2jf/P3D4x3JHbLzbt1zgUARwGayJJIZqEkLY0dnEQdx9AC9I8173B3sUd9FwyXQqmh0hLyy1UMmzBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqRDFq40N3P+87bAZ9bH/SJMUGL4RqpXsp/NXPmDZkU=;
 b=a16VxRHVrN54MeU/X9qoW3p3F7Bj+FBuyGe0iGoKCViFDPfVGuUNZ/xbLLG5eRD/iKAwv4VencTjHi0J4Ke5Hv7x7tx6yovgaBCL3oP24khYWfrCPJix1phEKtNWHsA6W/ysunWype3YSJBYQRegYcals1QfiGkr/4sMOXVUR3KPMGFq0odpzwtE+OZX0ix//qhJoJyH0SmajRIWkhi6NCGXQ5S4Dl6+yr7yVW2H5aYhKem6JUJi0dtLKHMauejQsy8nKZ3j1JY6ReFT/9kG7ja5bh7b6bjAvv2n4AmlHd5mCn18+CB5a3nvS/wqH/IBivfPqoxp0ZLBWOhvGtpfWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqRDFq40N3P+87bAZ9bH/SJMUGL4RqpXsp/NXPmDZkU=;
 b=R6z/fwtLCqiYHW2pnCG4/Z7visT44/Watlq0uMWKcuCN+ElIyD7yI1Vx27bpCw0Q8eXFQ6mV78LTwcmceWSwkXYlLVIh7NMJ4/wIpinfN9/n6j3Ra/XLQQSdp+OPGWEPcu/TKco9jZlDvLnsquevQWLl03JhATz3nJXPCCVTFOM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 11 Feb
 2021 21:45:02 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf%2]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 21:45:02 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/14] drm/amd/display: changing sr exit latency
Date: Thu, 11 Feb 2021 16:44:35 -0500
Message-Id: <20210211214444.8348-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211214444.8348-1-qingqing.zhuo@amd.com>
References: <20210211214444.8348-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17 via Frontend Transport; Thu, 11 Feb 2021 21:45:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bfabe728-566d-4c4d-3f8d-08d8ced64942
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42353DDD7F761CC38770B42FFB8C9@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2pbYMjz85LVYsIkkFoDOT9+YiLOY6KoTz3CaqI1hLADASB/+zn6nWRqE7zwtShm3Sfqem8xGOf0AfTa1sU7E7M9NDlLGFmtvJKVyJ8+aCnk/N0wCT+8iaQco1v+1T/LPpNn+BrI9sQQNdIhwGmrJ0p65Qe0yYei3qjRSWDyu7mUz0Spce8g2ZrLkHpKXzQyOzjDppHYgeLMff3oexIu0P4pQgtI7iF40mUmB5xKfb7wAZrg7g22yGlkZSm+T308cgyyQ65o8hVEZ4NAYiippVr8iRRNEBcEeaAwsTAsCbIhGf1G9+qK9cFiiX501P/imqmzkbynaKNIgi115aZQCIPpENf/xqkdYmRt7jJexcS23uGpzXcjDoP6Gp5MjmHore9o0mx2RCLxzASKHeqWeLHpzRCa/zVH93aOE94xVfw0QXK1VjOXLk8GJ7xyRE24usNbD9JDKLIa/PLdL8smA1b/A71+C0wIXhPBDxQ6UeneAgTjH8LBh5qhblw1nyIz/7tRrjoWl3swwP8k68WtoPwaxXID4UdV8iaMZFClfy3EWv8RsRVH0cHFJAZHakAG7Ju3gn7ggk0KnehL7qSk9YA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(83380400001)(16526019)(8936002)(8676002)(478600001)(86362001)(6916009)(6506007)(66946007)(6486002)(6666004)(1076003)(52116002)(186003)(36756003)(4326008)(956004)(44832011)(69590400011)(6512007)(5660300002)(66556008)(2906002)(316002)(66476007)(2616005)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+xataz7/8zlDSwGdo8HwWfv+zb9xum1EeFr+YjmuBU7wJ+mFE/NJcqhSIGAC?=
 =?us-ascii?Q?yYQvsBQ/+PGrlQ0WoBe5dmnapa6uI7GNJBUAz03HrtUy04polOQTM+dsftEZ?=
 =?us-ascii?Q?nWoci1fknP714qSwwmkzw32k041E4c64OTWhE8udGxwpqnVcxldHTXSAuGgg?=
 =?us-ascii?Q?Hwbj5f6e+tR/PK4BE/OkhsTOFrFc7kg6M66pVc0XUf1VfgzwUfvO/ZybnCKW?=
 =?us-ascii?Q?8qWhchi6Vvlq8eAimPCpk285GR2Ly3DiyPFGdTSpXrWhJNh1CJODZTkwTuoo?=
 =?us-ascii?Q?lnhybqjb74a7JezTZ4cw1OlaouMVPBw1IO3n5wU3P7LFfGvcVKm2PBV4VI9M?=
 =?us-ascii?Q?Pc8XlqDpJgobnGZtVUS9KYKcUQwlYiWApN6ZQwcqURtJ1pXcVx7uc5S3NMBA?=
 =?us-ascii?Q?Q3Wh+h9py/Jr9BprS5AQVzYcNOAn9/37ZFemcTUBHW/gmkVdZr0oT8EodCF6?=
 =?us-ascii?Q?6fb6sa7+RnfiM/Er/DFNN8ZMmiUmnry0JbzDKU9k1z2Y669b/fU1tpd8xR1h?=
 =?us-ascii?Q?s/42/2ods+LoH7CN+7l27P0dxRXXEcVBg+ZuGm9e5E440Bcr6/h04/rIMrKi?=
 =?us-ascii?Q?uUKVYIHiCvbxAJtIgxsdOYmJ6PDbJ9tv949hXqWRBOaL3P3XN2hjTbLuXW1T?=
 =?us-ascii?Q?eEA5Ej9fUQr1JHZkjMAlTCD5FGmeGGAOxvn7sQHj7Na7oUxPfx/C51fD8nMo?=
 =?us-ascii?Q?uILp9oYlqd9zf+kTUxxL6zll7P7eU5ofUZgsbMbKRqnTGOJZs9m3s3tr8dtL?=
 =?us-ascii?Q?UfvMJynAbX60e1PuUIl3X3dSXKaO5fn3z3e/qcI1OgIOCm32vGYbPMWWDQwr?=
 =?us-ascii?Q?JabCjjCZNXnt6CfC9TyD42SgQzSVuqfY+DMv/S82AD5yR2kjBzLCElkjf1nu?=
 =?us-ascii?Q?nR7iwTwwdEn3fi7YnPJZTb4PLs9OOAlLxmuwS+WAYQFoZETV0f2s4ox5rjO1?=
 =?us-ascii?Q?3XjgNcT1eiwNelO/mVxSobE9YpcnxU3MAIPrD5WkcMGAJXieCaksUqTfJ2yR?=
 =?us-ascii?Q?4uX4zfapBjm9QpH3kA4kkpjbBK+i3fEogRFvX7BQ8XTXEOyzxevvp2aotiOJ?=
 =?us-ascii?Q?/Tz2qKFAeO5Gp4XiwHeErR//0kL40bwC8q0/cPb3j/boLSeatsXWyJ35HBmC?=
 =?us-ascii?Q?s2xrLolY4WR+F87ECzoyFp7mW6IzhCi8QWBGwtZRLFyDFAgt01qfQfbwsjeT?=
 =?us-ascii?Q?QxDZUk+rrCfYCYRoKKOHn/L58CM7VQI3/kD19G4Oq3Ec5DGEqKe8xbh1xOY9?=
 =?us-ascii?Q?aSSjEieLXiJ+qpYCRgfUvxTeCu5Zl3rvZY3SBqhaoEkL78+UYU+XAP9Q1hXe?=
 =?us-ascii?Q?IjZ2KduLCTMp2yqkA0gQXqOf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfabe728-566d-4c4d-3f8d-08d8ced64942
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 21:45:02.2905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vprqE2ruueEHks2kpZ15KD0k4ybz3GLCfFu3PHpe8oLQ91O9zFfAlACw6q96z3U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Martin Leung <martin.leung@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

[Why]
Hardware team remeasured, need to update timings
to increase latency slightly and avoid intermittent
underflows.

[How]
sr exit latency update.

Signed-off-by: Martin Leung <martin.leung@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 8d0f663489ac..f85765cc73f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -181,7 +181,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_0_soc = {
 		},
 	.min_dcfclk = 500.0, /* TODO: set this to actual min DCFCLK */
 	.num_states = 1,
-	.sr_exit_time_us = 12,
+	.sr_exit_time_us = 15.5,
 	.sr_enter_plus_exit_time_us = 20,
 	.urgent_latency_us = 4.0,
 	.urgent_latency_pixel_data_only_us = 4.0,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
