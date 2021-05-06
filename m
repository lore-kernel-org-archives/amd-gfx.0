Return-Path: <SRS0=uqaI=KB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47526C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 00:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B664761077
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 00:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B664761077
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49CD16EC84;
	Thu,  6 May 2021 00:11:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 150646EC84
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 May 2021 00:11:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eP8gxRtT8/4eQ+Aq4rQ6f+svPMBqxL5p9IFLA8fOpKRmWR6O9dcvK9svPqfVQF5Yi4WdGCQOFZtgItvsYmXviuQVW2EhV1YXcxZgJpM266TVRMyj2AUk5JQTNdShCQwR7D5yNqGgsu9xrJ5GTtbuA/RNDQPU3lDs93PYCk67UvD1C1pUxPjNuZzMI3yUfdVqUmAA4vQCzGLhWrTJ9zZsWccEieFnT80tw6I9uAxrLtaErJ/qjUvUJjY+BQfLp27paNeqYp91Qj9vKoDJ8as971OJrqs0dm5Nf2AIZ9Ku8+Gz63TlGHintUeijiuxalcA2VUcjjWAp4CV/WupRQIA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nD+8HIKWlRWx6y9Bq4Rlh5n0nKqwZ4JuyxT5w4PZsu0=;
 b=mhkQRzhExUNZjiOcpPblqhLHI3ohIa0K5Z0xO5vx3vBfCBrqGamokaV13n5P30enNyXElErJQhv1+rOncw6QCXtprgRJmrAE//3jUJljDBT9pKsNPMCfNkoPAFRQ6fy2xKURgz6TNsVhEF95WCqd5tCBNnSVIuOIXdXe5ii+EJG1TofG1klaosenCkbegKnNFLQI8eWjOMdZPRHsnAQ77IjrtP/5TtLFQx9ieFDB97zC/FidBqEtsIw5SUtRPlngvLTHplVa+q3mRSG87aIksf+IL3JqQNsBa/uJ9u4SU1hA1ZqabM/VLJ3EpN3sSjVcvQlg7eP/1/0sl8uDP9PPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nD+8HIKWlRWx6y9Bq4Rlh5n0nKqwZ4JuyxT5w4PZsu0=;
 b=B9Pj+YpLSRjG8zEH+zCHQX3EFvQJ577uBHyorR16qd6csG6Yve+g91DMPnTKWvt3ka6m+XVI/k0d7fVDMWc12UVNBImBSQqD256O+ZRtQnib2j2Gy9gxPovm5tw7s6wSFcOY9od1XyiY80JG+X0XVu10b7/+f68cIkBMNe3BWd8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.43; Thu, 6 May
 2021 00:10:58 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 00:10:58 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: Poll of RAS errors asynchronously
Date: Wed,  5 May 2021 20:10:38 -0400
Message-Id: <20210506001038.15150-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.0.97.g1424303384
In-Reply-To: <20210506001038.15150-1-luben.tuikov@amd.com>
References: <20210506001038.15150-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::49) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.39 via Frontend Transport; Thu, 6 May 2021 00:10:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d0e5146-ed3a-4910-7eec-08d910236c26
X-MS-TrafficTypeDiagnostic: DM6PR12MB2892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2892671D853BE50EAF9BE99A99589@DM6PR12MB2892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3893Egm/9JKVGWDAm9sIw3RN0e9Y7UY2zwIZK0yJRq9NViItb7OQe1YN5Dmze7OXVMWsvLNnu23xLsLQVxTnHIe6awHyIz6iNgADpBmmuv5MV9ii1ws4shxvYEg2DlAN8mDtJKBRDHm1ADQnkV1w9s8L+tOBVLCsLqdo1myhZ/H7Ho8pjOiG1Ahb6MlNVC6J27JAy0qDJE4b+jD2biR1AKHZm62UKx1HZ5R5LNBwN6LcNKVADiJcdMNhLMaffAc8wBUZWY/JhjMY6ZSen1+hKWE8w62SHs3IUaVbMOFMU+oR0lXppcZV/NT4PEPgaXCFVAiOOuGa3PZdbDzwksksV6YwLrCPRMSbK3hHM90nwT2Jy0HQjcATTXqq26oH1Pkjb4WiF4LKJO0vDJ/ZzQ/UEHFJXMEGU+IFVk5IbUvaeraW5HsuuNydZ3ncQVXKFFyMYhpsH0xYadA4hPpGpXQ4gv/rMFR3rjGhTlZsIvPZYPktjy5X7ipYXwKtJgyHMDq30WNseLlyln4Jc3+TmSSj/Gk8qk2r169Kbif6sC0RwX0MaZ+IwhFZFrZ/mNElMbXjXKkTVaS7THJ3p5296iHSVgi9UznxytyMUTZLUbVtXXs6i5V3/YuADb8ZwV0O+OKtwiEljGfjjGDKk8bSUUP7OKe0h+Cx07RiROWS2s0CA6wD8l6+6AKVqnTNmO1Q5AVL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(66556008)(66476007)(26005)(38100700002)(6486002)(83380400001)(8936002)(5660300002)(6506007)(66946007)(186003)(2616005)(16526019)(55236004)(52116002)(956004)(8676002)(38350700002)(86362001)(4326008)(1076003)(2906002)(44832011)(36756003)(6512007)(6916009)(6666004)(316002)(54906003)(478600001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?v38Fo9bKHAc86oSmEnlEWNxdeSsE/X+hVpEvkdgadBp6hl86X00S9hM5ipNP?=
 =?us-ascii?Q?Jv6bVZwg+S/0oTRYOW5Uw+PPXQvTvsrb1trfyJG5iRpNSQgaHGUHkSuA6jFf?=
 =?us-ascii?Q?66Ko+YJQCpbywtpC9Q9tYVh5rJleqjfEOCGDL0VdFOTrO4WM87xs//pudXbq?=
 =?us-ascii?Q?EROpkkwwwtvqgVCxkAyLXnNMkD+iSDefMr0d6RVIaXSScV+zEm4rW0qwoR87?=
 =?us-ascii?Q?0NWmp04+gqpHgiIRVoPqbRbD7PpAAgxMgQR/mLdll3xeqWtMMnVusZqt2RYi?=
 =?us-ascii?Q?0luOvcRrV94W6QnjbYvv1B3SDG0H29aMG8e0hSgAYbFZwnKNDZ0Z27CGBTNT?=
 =?us-ascii?Q?oJN7ZN/Nk2F5J5dh0uKh4mFtjQRgqganN0Fnpnow/Vc9umKnfQ5fTkF69wsT?=
 =?us-ascii?Q?xMW0qDsR+ZZlkQwDty2NZliI0/cAEdL7LQ74vPblVu4e/D2PSr1kh5mks2DZ?=
 =?us-ascii?Q?mdz0s22rvyEIuk8XXv0Wb7vzHp2BSRPKeHDXt/0inazj0HgHCcM4sRhSbaAc?=
 =?us-ascii?Q?0WCwYQqWzcwt0R+uTy/jGG+7C8V1AnWnMaC514Lg5uT0jQFwELvBbrXat2QV?=
 =?us-ascii?Q?8r4JpDs80ml9utIexGlQaQEmF1tPgv5I0VBLsmUM7WxKzuYXxJv7GmrzQSVo?=
 =?us-ascii?Q?f5YqqF9NIGYJ0B+QzNk3xIGBwWSaKDz9zz+/BufsfakD3L9OtaWcQ8lnBbX/?=
 =?us-ascii?Q?Ibfpnw0BuILaeVjR0jGa9+YytxMDxkn3nuWq5fjuXDK9RdzyHateydbyWjek?=
 =?us-ascii?Q?/iSlYN75T8/XuE7ONnLJgLjU4TqiHlBcI+Nskn6jYW/SaDNmXNNdY+npYCkm?=
 =?us-ascii?Q?YH/rFnA7YLuHU5ao8zMpMBlxuFh9rG3Bx4kKvn6GDG1tzDMsOpQw2uHu+wBg?=
 =?us-ascii?Q?QKhtPX6FiKw3xjPNZdar3UxUAAXtdlOEncXO8r7oDIEWpku+9ykrXOZdqVqZ?=
 =?us-ascii?Q?5B2IQ8xycqlEXDCZHm1Q4ph0nzSKQenTL8XKW4At4rWyt110yoDs3V0wyR8K?=
 =?us-ascii?Q?ZCC++4F3WnrQCC7zYrqbhEsu2GrNebYJKlsmHQEnoxrSoqgtLBc+MAGEJrp/?=
 =?us-ascii?Q?XZgBJiDf2Vsf7ylWXnKwiKkWRC250HxKE1VlsyZFMv02sXA0HMYYMVznCWbi?=
 =?us-ascii?Q?xGxsusSCBV37mVmIzIk02NIGpwW6uqoB1RRgyWp6muYzS09zTU4h0sJCiVJB?=
 =?us-ascii?Q?6mqAKjSoT3mWJfrjVQBD5gd63irTOKw++3ndTr8KlZEP6NeyXLzCKxtG8pAN?=
 =?us-ascii?Q?n0SeDbH7sULYpIwL/q0zjP/TLwAOr6eZhHV8JlW0+w8d9Oq/uRqvJf4R6oqA?=
 =?us-ascii?Q?Dm8H+3IgxSJb9fgLEVyxk7MQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0e5146-ed3a-4910-7eec-08d910236c26
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 00:10:57.7495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2CyFd478rDB0f1NBEJVlQeBIwhwo6AAfS6jtctzxcBt+qN/9l8K3dMowNFzTJtn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
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

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 32 +++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  9 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 61 +++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  8 ++--
 5 files changed, 85 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b292c1e3abc5..c29f1a24296b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -196,6 +196,7 @@ extern struct amdgpu_mgpu_info mgpu_info;
 extern int amdgpu_ras_enable;
 extern uint amdgpu_ras_mask;
 extern int amdgpu_bad_page_threshold;
+extern uint amdgpu_ras_thread_poll_ms;
 extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
 extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 0350205c4897..6b2f29ae032c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -332,12 +332,12 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
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
-	unsigned long ras_counter;
 
 	if (!fpriv)
 		return -EINVAL;
@@ -362,19 +362,21 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
 	if (atomic_read(&ctx->guilty))
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_GUILTY;
 
-	/*query ue count*/
-	ras_counter = amdgpu_ras_query_error_count(adev, false);
-	/*ras counter is monotonic increasing*/
-	if (ras_counter != ctx->ras_counter_ue) {
-		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RAS_UE;
-		ctx->ras_counter_ue = ras_counter;
-	}
+	if (con) {
+		int ce_count, ue_count;
+
+		ce_count = atomic_read(&con->ras_ce_count);
+		ue_count = atomic_read(&con->ras_ue_count);
 
-	/*query ce count*/
-	ras_counter = amdgpu_ras_query_error_count(adev, true);
-	if (ras_counter != ctx->ras_counter_ce) {
-		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RAS_CE;
-		ctx->ras_counter_ce = ras_counter;
+		if (ce_count != ctx->ras_counter_ce) {
+			out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RAS_CE;
+			ctx->ras_counter_ce = ce_count;
+		}
+
+		if (ue_count != ctx->ras_counter_ue) {
+			out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RAS_UE;
+			ctx->ras_counter_ue = ue_count;
+		}
 	}
 
 	mutex_unlock(&mgr->lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 27153ac384f1..44fc5827e6e5 100644
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
@@ -534,6 +535,14 @@ module_param_named(emu_mode, amdgpu_emu_mode, int, 0444);
 MODULE_PARM_DESC(ras_enable, "Enable RAS features on the GPU (0 = disable, 1 = enable, -1 = auto (default))");
 module_param_named(ras_enable, amdgpu_ras_enable, int, 0444);
 
+/**
+ * DOC: ras_thread_poll (uint)
+ * Number of milliseconds between RAS poll for errors. Valid range [500,10000].
+ * Default: 3000.
+ */
+MODULE_PARM_DESC(ras_thread_poll, "Number of milliseconds between RAS poll for errors. Valid range [500,10000]. Default: 3000.");
+module_param_named(ras_thread_poll, amdgpu_ras_thread_poll_ms, uint, 0444);
+
 /**
  * DOC: ras_mask (uint)
  * Mask of RAS features to enable (default 0xffffffff), only valid when ras_enable == 1
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 609530c4a599..05cac55297d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1065,15 +1065,17 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
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
@@ -1081,13 +1083,14 @@ unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
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
 
@@ -2131,6 +2134,44 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 		adev->ras_hw_enabled & amdgpu_ras_mask;
 }
 
+static int amdgpu_ras_thread(void *data)
+{
+	struct amdgpu_device *adev = data;
+	struct amdgpu_ras    *con  = amdgpu_ras_get_context(adev);
+
+	con->ras_thread_poll_ms = amdgpu_ras_thread_poll_ms;
+	if (con->ras_thread_poll_ms < 500 ||
+	    con->ras_thread_poll_ms > 10000)
+		con->ras_thread_poll_ms = 3000;
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
@@ -2204,6 +2245,10 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
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
2.31.0.97.g1424303384

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
