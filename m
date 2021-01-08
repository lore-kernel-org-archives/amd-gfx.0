Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C99CC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D58B623A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58B623A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 663B36E8EF;
	Fri,  8 Jan 2021 21:50:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E63C96E8EE
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:50:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOwFh5pJBIMyNUgsSV/bBtGT4/t8PToKYzBUsT7ukwmHzigB+We+H4wd9XFFNy/251IOgPDNyvzwe6LvRYWJ8T2+WBHJL2KO5SotOmMBBZdJQ5QB+ezQCl3MKuBsz8KOcEEwqV6s7pKmXN2TgS9Vsp3YhpyJltIJF5pIdGGOhSknJDpD2jngv+A2A1GByzPUojAYiyF5LkWHhNTogodnGsai8r51jfoyRC83FRPYQVvMiqmdcbGISnpIP5lrq8A/TDiQlOgDQPa+bKwHJfnsi9pAn5fA8BeUrHVfgXHP8TDp8g94qoXScXYqHbiEGv6HrAz3/VFdH9ojUlilSCb2Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=graCqDKg/6HLDMTQKR9kq1rRe9DUNyB0NO9uLAVr134=;
 b=g0VCy6bFMuMiYkSWPRMMGEN5tVPI3G+Yxez7p+f5u5xQXO86gA6kSYjRjx8OAGFIDc7m9R0jOg7HWYvY9qeDPf1kJbFcOqs7EVDBRDucpX8VNH6yAulW/Wc7zFHPl9u2uXZE+n9riL41QKT5X0ka6aHYr627XY+Psu5gYAppPVwLOfEe/p8PFgglEt89yH/qGSYCGZ/mhvLGcpE/NlVOgy+SVUhNeWjRR1zcBOHOA2mcXAAQejkv1TY5CEFaYH5v+Xk4JgNa3qU8x/9EYCwO1SzlXpXofALJG+29nBwj+ptuW4AfngwFXYVCDtZ/HIdYVkXY5MfHH67SV+0CuXwUsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=graCqDKg/6HLDMTQKR9kq1rRe9DUNyB0NO9uLAVr134=;
 b=JHRGAaG6XDlhXnG2TF8IuObknjYUMQp5lMTHg7kWAkvAgUtlVeWG8qxayeOkBpfMx6/kxsZfwx/mJolLG8a5HuAulbDLK8dKVs0SjmyFUc61qS/ogNRS129P6qhEJoYQUlkBi/KffaZgMMUhQZIydWyl0i03BLEsV58RAAAxDYA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:50:50 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:50:50 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/21] drm/amd/display: Fix assert being hit with GAMCOR
 memory shut down
Date: Fri,  8 Jan 2021 16:50:00 -0500
Message-Id: <20210108215007.851249-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
References: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:691c:c3e7:a457:38d0]
X-ClientProxiedBy: BN6PR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:404:e3::25) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:691c:c3e7:a457:38d0)
 by BN6PR19CA0063.namprd19.prod.outlook.com (2603:10b6:404:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Fri, 8 Jan 2021 21:50:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f67ade44-b706-437d-424b-08d8b41f76a5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18823F57D2E7C014C9B1B9F598AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFtTaGzYzQtzxk3FLNXY7oyvDEALgmUv74I6b3O/ZMJ+Ry21Zu/fz+jmBnsKGyYJzfOdW2xzJDBUufgvkhh2ooDeeyrLae6UhqRMCn08Zhm0YuxQ7T8NdI3Ho1riX+KyAr8bYka1heGCyhAb6RKBDQAeDAFhgC54/IKRycIm4cHeiUx5BpoT9sIaT4NvE4j8cQlhs/LYnnXWUWmcZ4wzTb0Rfm7KuBy8ujB+WHCl/NE2Nkb3mn7AoShkN055TbnhsZvi3Nt9lC1We02RawOdY+GUUkIgJckcmyliqWIOKJT484ClgDiVFAHOzLjeGyPReF9p5nFBPsrxo4EtNznXPaR4GiafSw5U/PGV8DREaWYPakpaykcjUPeah7AChj7l8rUW0fForlqaEGFlRQ2Bdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(66476007)(6486002)(4326008)(52116002)(83380400001)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(54906003)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zqu2tqDG703sJOsiFE7shz+QnhcQXrzQxLdiMlJXhgpIEWOFx7syMOqaug3w?=
 =?us-ascii?Q?cPknvQjvtJ1m5uIL0uZDBd3vJZsCQ5aPRuEXXZdSdMwvi44501sAph6iu+P+?=
 =?us-ascii?Q?oozrBtixqSUQTETkHGzrPdqc9FApeCagUOrJ+vxYA/MSKsEBLflQydOLyG8l?=
 =?us-ascii?Q?zVnKxk9r7jZm6oSNaLUbkrD2xkbUk7q3RLUXzoqJsG4ueI02sClLcOpGZR+2?=
 =?us-ascii?Q?V7IBgdO/hIXM3SbOZC95R+TMr5zujdANJdaBRr1BlbYlQ0TAzdbb/aiO8fM+?=
 =?us-ascii?Q?SVtrz2E72wnxh+IRUoba0ztdSiJGZFnHhVfESV/EYfRKALTqOZ+mt3atTp4/?=
 =?us-ascii?Q?VYoUQoqhP437Z7c5/q09s0Lw0fdwa3DrZGHzI3oAPNYEth+hNz0021BRwx4p?=
 =?us-ascii?Q?iA5/f68Zw5T+sTQvdo7cIct2E1UXixDqKU4yM2ZpS9xKIbSR9idG7YphGWtU?=
 =?us-ascii?Q?94fcgtkbvj0MWLIVT/EUZrLTFbTAqmbDCIq6t3iJ6yv7SeU6qs8KonYDjB+O?=
 =?us-ascii?Q?+mZZA6NWWX7Niz2+9zQXujKRd8l+I7MJFdL9/D5u2cRbBK31L5WTdvVA0IOK?=
 =?us-ascii?Q?+EYZhW3e5AM0M4REzGzLK7RneHzTmqunYmULp9mgUpRrk+P8pj6/Tt7HSYbp?=
 =?us-ascii?Q?DNo8Deb9F6L45d4NIDi5Cx8JTBI7JjvlcWcmVypTxnfcHfgQ1DpS5iGjIBMj?=
 =?us-ascii?Q?czqC5ctulKopTWcGAMkgs6xuq5JkSmFe9m9X1pR7n8Wj74co4gnq4InN+TRe?=
 =?us-ascii?Q?qxKi5GyxStxArboUErFdvvILjvDvtD6zVwwdmIxsPIHRmxN3trCfKTlDtpEd?=
 =?us-ascii?Q?HY7bShyOcbolAlHLvKSNZk+9RdeoXksyy4AoUOBDF50dbPcIG/fN1kzvhUFV?=
 =?us-ascii?Q?7Sva8h1l1XhATmfFZBXUs4t/eFhpUXWoY4mFmMdIBtSgXBHkkF9oT6j1jUC2?=
 =?us-ascii?Q?qAxOUuSJFCvbpgQ6PzzJ0NH3hmFYkhKM1IlZ5u58wEg+Fp94IRVvLqwXrgz9?=
 =?us-ascii?Q?paBTFQ4ThtWbqV1oZOl2qWfhMY8TZJwdP+zD+HP0wOeKNJMuwczGm08ERxk9?=
 =?us-ascii?Q?947ITOMy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:50:49.8963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: f67ade44-b706-437d-424b-08d8b41f76a5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZ+hCG96VdLvg5LDuuv2qYDxgHdw6pwRiM8CUvfglhX/EbFSAum3NR76fNsH3IRukY9cWmtCcwAe9zuqMchb9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
 Aurabindo.Pillai@amd.com, Jacky Liao <ziyu.liao@amd.com>,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jacky Liao <ziyu.liao@amd.com>

[Why]
A call to BREAK_TO_DEBUGGER is triggered when powering down memory

[How]
Remove the check for GAMCOR_MEM_PWR_STATE when powering off the memory

Signed-off-by: Jacky Liao <ziyu.liao@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
index 9da66e491116..33985401f25c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
@@ -133,7 +133,6 @@ static void dpp3_power_on_gamcor_lut(
 		struct dpp *dpp_base,
 	bool power_on)
 {
-	uint32_t power_status;
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
 
 	if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm) {
@@ -143,12 +142,6 @@ static void dpp3_power_on_gamcor_lut(
 	} else
 		REG_SET(CM_MEM_PWR_CTRL, 0,
 				GAMCOR_MEM_PWR_DIS, power_on == true ? 0:1);
-
-	REG_GET(CM_MEM_PWR_STATUS, GAMCOR_MEM_PWR_STATE, &power_status);
-	if (power_status != 0)
-		BREAK_TO_DEBUGGER();
-
-
 }
 
 void dpp3_program_cm_dealpha(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
