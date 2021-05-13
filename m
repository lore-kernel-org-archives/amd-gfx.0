Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08BDC43460
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 05:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8348D6142E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 05:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8348D6142E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 799F26E821;
	Thu, 13 May 2021 05:32:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 308FB6E821
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 05:32:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTbZ/jalwy8dg1E2bjPUhjh005OfcWhzl6dxQbCF5Vw2f8IcR8XLN8bUOvN7TTDRyhOYJrU338n/vONgG8hzAluvRiNrYoiJ5C7yw76uoHjL2KKU+EX+tc/nsbhb5EG1qM5LdQUNbp2gZp63bTGC1Tfr8DWmrf1VixpOgpFu3z5u7s4VEtrYZaNTTCk/1yXzmPgNLOpqeROhY+aA6Xxs+6+SOpBzLtXpcBb1wkbh/nA3rA/y9cDXAfLz8pQ4RWzSAt3+40pvDfbD0RrIY9i/scFAL1J2MLhnfLwfeObRrPQPzRDtEDgVnWSZxQeGNPzsTh4buWT6sYAhGQCdbggPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/K5BAn6m5haiJTI8t847dLLnRBDI/26QVU3jRzSx55k=;
 b=TRWzW6HJBKOjbSvegVU4BqIAnbUQ/ROlkvtsxktY7f1Tl3Ko67SzDw1XMbIevj1HqytxOqAY9ZOLeK5c4hYXA8Ar1geLnoVqVOp4IKIv2wK4BAi6Z/3JNKDOrBb/9ERMZGVQwv0tlqXJiUcYILqxNspk6wx8AKANGB4/2WNfQ4E33dznc5oDJBkAn7O3h3T0rUs47iNaKE/ZVVa8J/n4lEeYApgyGSKYMx3i/pdVsy/HRIzJT3bizrdoUWi2Pu5k5WbtK/3Eq1IZsrgXts5Vr0RmXxqTbnti8NxL6tGetkdMxgoJ9yykCgybluHsRd17AlU9rnV2dzGswyMD8Coy8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/K5BAn6m5haiJTI8t847dLLnRBDI/26QVU3jRzSx55k=;
 b=tWKMb0kMPkD0HvF/ML31NDiMZzMK6ApXFdyDmCsg0acILSf2PQpeobD67L8RN3bfV7ENNSxIg5IuNa6+8gR5IKD8q9XL/zhwda+BtetaeA5DBub8WR6wPTwfcIjUjhcs1m2EvBkuRU5rTswh3bz5ynpRVnKWszTxHtGXlyg31p4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 05:32:50 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 05:32:50 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: Poll of RAS errors asynchronously
Date: Thu, 13 May 2021 01:32:33 -0400
Message-Id: <20210513053233.116683-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.1.527.g2d677e5b15
In-Reply-To: <20210513053233.116683-1-luben.tuikov@amd.com>
References: <MN2PR12MB448837F2FFA7B74AD3345C10F7529@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20210513053233.116683-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTOPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::36) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTOPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31 via Frontend
 Transport; Thu, 13 May 2021 05:32:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d3591e8-8032-46e8-afbf-08d915d08c1b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB474861D9B5F1AA767AAD849E99519@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qh4oUsNZw6pmJeycUOjGRJum/pSVGl57sluvwZaxo6gEq+6sStB0tw6tCEQIiyOpMmTJ2BBDgYJkg6YsFp5/zQQilUKQxlZoDkMukGyNDX3xCVCg7K+rQfme1hQ+uoUQljQYMcIEO1sodj+/eUrWeZNysVeYxG4oURuysXwMyq7MA7C/v4Y6tXbIcMuD0CQ4tOvAz7Qkh7UdGY1ykrP31cLN0j5GePMMjoyfyee0I5ApLheM1n4tBdftaBzooak1IMmxzvMaXF2ppy9XqS3I6mqBPwmNme70VUmTIZL6RHSSgYEwnS+ZUzsSh05+s2S/VbKoHfxUuu5aw/VedN+dXeIllDKlIpZWfjDZnRIKRNplxGwGRXXpL6H5+tMt4Wh8yJujOlAlsfXoGtIOjo9Lgf1i7OpffpWs6RVV5Z5VIsbXlaae2pmSrxvtWZ9N75aExr0/bT2msglyatvey5VnOVgTYyeyPjb3e8pzjMvkzblxs4BnCzRTTC4RDB/FGETxnzY3Yiw9X71HL8Ogu4MQOKIeGAEh57CBoG7dxeRN8ROdcchuXVvSaEm89KB/EISdx+VWpU+qMbeT7Vi+cCIw5Jvu9Qncddp3piqgE0WVkePtxwABOcCRPABShlK4Te1FttS072UOrctzdk2KzZtTgt28o9cqK6kZ8W95VMya4YzccG3p1B6E6kbj9d/MEU0C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(2906002)(44832011)(8676002)(54906003)(5660300002)(316002)(36756003)(16526019)(956004)(86362001)(38100700002)(2616005)(4326008)(38350700002)(8936002)(186003)(6666004)(66476007)(6512007)(83380400001)(6486002)(6916009)(478600001)(1076003)(52116002)(66556008)(66946007)(55236004)(26005)(6506007)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/EOtngoQ8a12ImvnQd0oVI5obFxv++523/Rfatsv41zZ44fa2rj+XUXmMpd0?=
 =?us-ascii?Q?zu3YyEBcwfgfqZrBAJwp2vlVG3yBjvbqaSn60e2LXC0q6g/+HJJzNewV7WIT?=
 =?us-ascii?Q?8wbQrbrQqy2AVD/KaQvNwYXYWiEgnEWIYkUc/AhvpYLk4qY0Zr+87iOW0jo1?=
 =?us-ascii?Q?5CySZEKt/p1DfjBda8f++X0RGsTBcmv7lX1M6EECZHmQtxAkysEgeZr2jrmj?=
 =?us-ascii?Q?BcvWes9aU3fRMGc/QtP+qPXoOIBC4g64ReCt0ZAime3AR8e6SnKThRjZLHbF?=
 =?us-ascii?Q?aGI23Ib6wUHpEg20DFsGli3YIJugKUpOL3jjt71To4wxHbFVfzdX+PUthQLp?=
 =?us-ascii?Q?yKvADfAQr1BFUVHty5VriRVeKogZ+9nNCEUeToEeFipGJvKYEy7Okggx80TK?=
 =?us-ascii?Q?03NT1Ztyyfgv76qOuFWcLKeSGjox56E8LTEPZys7JVzmL8RGJ7kNZR1G2P/0?=
 =?us-ascii?Q?qFUIEIhiJH64tvQ0yQ+Ef1nmp2Q3sGZB+Bpq0At4D/UqUK3oxyMLnqStBhMR?=
 =?us-ascii?Q?c1EMUb6V9FpgB3cROr66LNZPxMkznPcwQlT7p9krPH+6ycMILZjI7WavZiGZ?=
 =?us-ascii?Q?zaYT6PnoaxLj6hmwwmY7WT8fSd3Xn/nqtH6syfCVqtJpC/hzHlSwh9FFX3bK?=
 =?us-ascii?Q?ANVFGyKFghbGCOSvHuuPNLWslX7wgppqx02yA/Pvm3M3h86UAoH3Zp1tCWCx?=
 =?us-ascii?Q?XqInLEoha8QS1QtIWA0+4fko9g86wSvZ65T2Ti62ip7OO+n2u8rfr4rr95d4?=
 =?us-ascii?Q?IxW6kbcEIIUDvptpJi2bTF83PsovYvBP9tcDOPg5v/5iQGo7dIa8qzilyF1D?=
 =?us-ascii?Q?1OrBBFb3ztbHXprN5CQsf6X2ifo8WHmZb6prRJRzXmbdnTEyhiUog+8si9I+?=
 =?us-ascii?Q?2yoAI2i6DTuoh4QhQdjEicolPk2vJsFOzsyv9QDyXyzc8qysmkHIeeMELA4A?=
 =?us-ascii?Q?9yukB30BUkr+S6soy2Al0kz6GW1B/Lfbimn5CvHcVdbLptLvReis4EojezpQ?=
 =?us-ascii?Q?Dl0jPBnNMALlRWxTNaboGtqI3wiRzwm8bgitGbG2zQ5zUTPQD/HQQ4ePFY7j?=
 =?us-ascii?Q?iRtFpOaUfpRGRyfYbKDGQOJkQRcx+PdD458FUM/RV7yZclE4rvCM1NeNOp2M?=
 =?us-ascii?Q?ZIg9JlCnAmcDtsRiuvxkd+2RbO5C2CdDmc/ancL5g1rOD/NkPpaPz7/a9Gtn?=
 =?us-ascii?Q?NxgDeN1qR5wj1oi7v1guxWXx8u85LTWN3dCyrS/EeTFDOtmkPScBo2LkPwFv?=
 =?us-ascii?Q?Tk58el8qhWGYqRCluhnN9CJekPvdV70yqSebUHCafLN0Rn1q7zIwkg4PrA/E?=
 =?us-ascii?Q?0Fw15EXovvuRw6zFXicsb1TA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3591e8-8032-46e8-afbf-08d915d08c1b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 05:32:49.9650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqg3v0JjAGmIBTXBsQ/q9Fe5gyJEeElShKZ/pKP0fNDaqTJngCI+OR090Lcyvm6W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4748
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When using Vega 20 with RAS support and RAS is
enabled, the system interactivity is extremely
slow, to the point of being unusable. After
debugging, it was determined that this is due to
the polling loop performed for
AMDGPU_CTX_OP_QUERY_STATE2 under
amdgpu_ctx_ioctl(), which seems to be executed on
every ioctl from X/Mesa.

The latter seems to call amdgpu_ctx_query2() which
calls amdgpu_ras_query_error_count() twice, once
for each of ue_count and ce_count. This is
unnecessarily wasteful since
amdgpu_ras_query_error_count() calculates both,
but with the current interface it returns one or
the other, depending on its Boolean input, when it
can in fact return both, in a single invocation,
if it had a better interface.

Further down, the query_ras_error_count() callback
is called, which could be quite a large polling
loop, and very time consuming. For instance,
gfx_v9_0_query_ras_error_count() is at least
O(n^3). A similar situation is seen with
umc_v6_1_query_ras_error_count().

This commit implements asynchronous RAS error
count polling to that of the ioctl. A kernel
thread polls the RAS error counters once in a
while. The ioctl reads the values
asynchronously. The poll frequency is a module
parameter, with range [500, 10000] milliseconds,
default 3000.

v2: Enable setting the polling interval to 0,
    which disables the thread.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: John Clements <john.clements@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 22 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 66 ++++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  8 +--
 5 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3147c1c935c8..a269f778194f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -197,6 +197,7 @@ extern struct amdgpu_mgpu_info mgpu_info;
 extern int amdgpu_ras_enable;
 extern uint amdgpu_ras_mask;
 extern int amdgpu_bad_page_threshold;
+extern uint amdgpu_ras_thread_poll_ms;
 extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
 extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index e1557020c49d..558e887e99b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -332,9 +332,10 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
 }
 
 static int amdgpu_ctx_query2(struct amdgpu_device *adev,
-	struct amdgpu_fpriv *fpriv, uint32_t id,
-	union drm_amdgpu_ctx_out *out)
+			     struct amdgpu_fpriv *fpriv, uint32_t id,
+			     union drm_amdgpu_ctx_out *out)
 {
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct amdgpu_ctx *ctx;
 	struct amdgpu_ctx_mgr *mgr;
 
@@ -361,6 +362,23 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
 	if (atomic_read(&ctx->guilty))
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_GUILTY;
 
+	if (con) {
+		int ce_count, ue_count;
+
+		ce_count = atomic_read(&con->ras_ce_count);
+		ue_count = atomic_read(&con->ras_ue_count);
+
+		if (ce_count != ctx->ras_counter_ce) {
+			out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RAS_CE;
+			ctx->ras_counter_ce = ce_count;
+		}
+
+		if (ue_count != ctx->ras_counter_ue) {
+			out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RAS_UE;
+			ctx->ras_counter_ue = ue_count;
+		}
+	}
+
 	mutex_unlock(&mgr->lock);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 877469d288f8..641c374b8525 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -183,6 +183,7 @@ struct amdgpu_mgpu_info mgpu_info = {
 int amdgpu_ras_enable = -1;
 uint amdgpu_ras_mask = 0xffffffff;
 int amdgpu_bad_page_threshold = -1;
+uint amdgpu_ras_thread_poll_ms = 3000;
 struct amdgpu_watchdog_timer amdgpu_watchdog_timer = {
 	.timeout_fatal_disable = false,
 	.period = 0x0, /* default to 0x0 (timeout disable) */
@@ -534,6 +535,15 @@ module_param_named(emu_mode, amdgpu_emu_mode, int, 0444);
 MODULE_PARM_DESC(ras_enable, "Enable RAS features on the GPU (0 = disable, 1 = enable, -1 = auto (default))");
 module_param_named(ras_enable, amdgpu_ras_enable, int, 0444);
 
+/**
+ * DOC: ras_thread_poll (uint)
+ * Number of milliseconds between RAS poll for errors.
+ * Valid range 0 and [500,10000]. Set to 0 to disable the thread.
+ * Default: 3000.
+ */
+MODULE_PARM_DESC(ras_thread_poll, "Number of milliseconds between RAS poll for errors. Valid range 0 and [500,10000]. Set to 0 to disable the thread. Default: 3000.");
+module_param_named(ras_thread_poll, amdgpu_ras_thread_poll_ms, uint, 0444);
+
 /**
  * DOC: ras_mask (uint)
  * Mask of RAS features to enable (default 0xffffffff), only valid when ras_enable == 1
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b1c57a5b6e89..30bec289e9ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1043,15 +1043,17 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 }
 
 /* get the total error counts on all IPs */
-unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
-		bool is_ce)
+static void amdgpu_ras_query_error_count(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
-	struct ras_err_data data = {0, 0};
+	int ce_count, ue_count;
 
 	if (!adev->ras_enabled || !con)
-		return 0;
+		return;
+
+	ce_count = 0;
+	ue_count = 0;
 
 	list_for_each_entry(obj, &con->head, node) {
 		struct ras_query_if info = {
@@ -1059,13 +1061,14 @@ unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 		};
 
 		if (amdgpu_ras_query_error_status(adev, &info))
-			return 0;
+			return;
 
-		data.ce_count += info.ce_count;
-		data.ue_count += info.ue_count;
+		ce_count += info.ce_count;
+		ue_count += info.ue_count;
 	}
 
-	return is_ce ? data.ce_count : data.ue_count;
+	atomic_set(&con->ras_ce_count, ce_count);
+	atomic_set(&con->ras_ue_count, ue_count);
 }
 /* query/inject/cure end */
 
@@ -2109,6 +2112,49 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 		adev->ras_hw_enabled & amdgpu_ras_mask;
 }
 
+static int amdgpu_ras_thread(void *data)
+{
+	struct amdgpu_device *adev = data;
+	struct amdgpu_ras    *con  = amdgpu_ras_get_context(adev);
+
+	con->ras_thread_poll_ms = amdgpu_ras_thread_poll_ms;
+	if (con->ras_thread_poll_ms == 0) {
+		atomic_set(&con->ras_ce_count, 0);
+		atomic_set(&con->ras_ue_count, 0);
+		return 0;
+	} else if (con->ras_thread_poll_ms < 500 ||
+		   con->ras_thread_poll_ms > 10000) {
+		con->ras_thread_poll_ms = 3000;
+	}
+
+	while (1) {
+		if (kthread_should_stop())
+			break;
+		if (kthread_should_park())
+			kthread_parkme();
+
+		amdgpu_ras_query_error_count(adev);
+		msleep_interruptible(con->ras_thread_poll_ms);
+	}
+
+	return 0;
+}
+
+static int amdgpu_ras_thread_start(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct task_struct *kt;
+
+	kt = kthread_run(amdgpu_ras_thread, adev,
+			 "amdras:%s", pci_name(adev->pdev));
+	if (IS_ERR(kt))
+		return PTR_ERR(kt);
+
+	con->ras_thread = kt;
+
+	return 0;
+}
+
 int amdgpu_ras_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -2182,6 +2228,10 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 		goto release_con;
 	}
 
+	r = amdgpu_ras_thread_start(adev);
+	if (r)
+		goto release_con;
+
 	dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
 		 "hardware ability[%x] ras_mask[%x]\n",
 		 adev->ras_hw_enabled, adev->ras_enabled);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 201fbdee1d09..fb9e4c7ab054 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -340,6 +340,11 @@ struct amdgpu_ras {
 
 	/* disable ras error count harvest in recovery */
 	bool disable_ras_err_cnt_harvest;
+
+	struct task_struct *ras_thread;
+	unsigned int        ras_thread_poll_ms;
+	atomic_t            ras_ue_count;
+	atomic_t            ras_ce_count;
 };
 
 struct ras_fs_data {
@@ -485,9 +490,6 @@ int amdgpu_ras_request_reset_on_boot(struct amdgpu_device *adev,
 void amdgpu_ras_resume(struct amdgpu_device *adev);
 void amdgpu_ras_suspend(struct amdgpu_device *adev);
 
-unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
-		bool is_ce);
-
 /* error handling functions */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		struct eeprom_table_record *bps, int pages);
-- 
2.31.1.527.g2d677e5b15

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
