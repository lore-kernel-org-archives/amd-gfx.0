Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01152C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 18:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BCD661361
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 18:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BCD661361
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DE056EAB4;
	Tue, 11 May 2021 18:28:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DCD76EAB2
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 18:28:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyptClI59c6GHm2+unmIGh2J8hsaJNid7QfcdgMAX5vKrbHrD36YWKQ7dH1ryPZbrAvag3E0xbUP5z5qj1lLGpEMrqdaE5m5tw0KNVK0zwnqdxwqxgLHfYgp9HtK6Nu9PlbdBHvyD6Wc7x76+QJEgrLsdMs5M6iR8Ny6dvL9a8EGW7fgchtHuetRkHaaFr/TUdft9iZI+qo1aNDX3tnkegF0dbPwwheioqRTj5sscdoM1WJVuLDwVNoOJleIstAnnRJ/TcBV8ofJL9EZOdZrVxBcBF0jslUJ9NVk5VSjquKuWyvkLxuhFbTOWGjVBwTbv18dX5hujQWhmlIemhg03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdExbGzZTjG/uT2Mc81K/dKnZKiwi2P6dSUwrMjpPrE=;
 b=bagLt55A9Z20CxluSsisWkGy/thk7XZXBxGSkUJn2Ulu6gTjOPUPOvr79EM8k1n/FrB2UANlVl0in6Kk2oV79ReXtYJrgHhdS1j8FNNcK8BFg83DREsYtf0mdPiMpX6eRrrBovDCAabH41yko86wv37Cl5ZHd89PS4pXA7BuULrrVDmJu5iF4npKvUPF+uWvPhoAuW+zVAzWnW4tliHjTKSew3YmBQvjgZLFwnHmGvv2PuMugw6TKrXHcRKaZr47mEv3jGMA8tyW6KLshghGgwxFK0s21UxN5R2CuF2iZHmBgfY6em8NeFOojeKHRcDF5p9ZhfNmjyN5M7dlsFOAuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdExbGzZTjG/uT2Mc81K/dKnZKiwi2P6dSUwrMjpPrE=;
 b=j+UyMmWnoef+rDq6t3xRtFSXbdnhj+GJHQ0K2uQogRevjUJ9z4XMOD/TEUC0NmT7YwHQgsDOEBivLru7gaWWameFZ5a3/G4lYoqQmwZh7TlH/B8J82A4tKicafX/NcFyewb5kaCrlXept3FS16HvodIN1MFLqv1+lQS7RhQiMcw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB2839.namprd12.prod.outlook.com (2603:10b6:a03:72::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31; Tue, 11 May
 2021 18:28:00 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 18:28:00 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: fix fence calculation
Date: Tue, 11 May 2021 11:27:47 -0700
Message-Id: <20210511182747.13367-2-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210511182747.13367-1-david.nieto@amd.com>
References: <579fa92-ad25-323a-0c41-ac07ac47fa42@gmail.com>
 <20210511182747.13367-1-david.nieto@amd.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::9) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR13CA0124.namprd13.prod.outlook.com (2603:10b6:a03:2c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.12 via Frontend Transport; Tue, 11 May 2021 18:28:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0adc7143-f21a-453c-56b1-08d914aa819f
X-MS-TrafficTypeDiagnostic: BYAPR12MB2839:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB28391F95CEC2D26529CF8A91F4539@BYAPR12MB2839.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndPIKoiUlocNrwVHA/2S/ljcT5Ivb6T4z/hCkjutkhaotBgN/ihFftbgObtad1Hw9GyB8FQomDMR7E246dUXJel9D7AjbSOzF83jih7ILbuHGsCg6O0PxOPAxV1WBtzYhUA7QE4twhM9dESL7HMXDVUOlF/LaKaoHWeUmJ7EFacxsUilRsXTxkD+R/Gfn6wVtcsnNam1KUdWRtZ8BmxRXni1Y0SqRXns5QaOwNsaAfnH+90DHO+ILbX8CgdoFacvWyGVUz6xHXSSZqxC6Nkc85Z3/ZP/iFBd+EsTSHPA/Tbm3uLwEuJedPfQu1F/xrNYAVg0Tz6+RgaSa7HFZVIvwJdb7N0DNVSnFlVxw8pWiX8/+LcpZWLkJqR7LuoY89LZabvs8/RECiBkS48rmwEgZdNK/GPKnebCjt/aFDbDTfTha+aX4yVYGKnlB/dbeXOmEB+KXZuB9pYwi+wKXvA9Zug09kmVYJk2O7QjS6XtjnODnloVY7wtkYeudFbbfe9saCamZoUS6/1OZPhJv0LBld8o1bxY9t9DHZarSwaLZYSXheuHihHNimmbzbnTFuejXH2q6im6p4Dh+nOA5mpbonSW5bss28TLF0wp7O5aFIGspXeydxQ9W7e5pNqiic7XaJqpUyGH/3op6XFYGc9hG/cGrKVWTiaRlsMpguMqySY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(6666004)(86362001)(4326008)(956004)(8676002)(52116002)(7696005)(26005)(2616005)(6916009)(6486002)(186003)(316002)(66946007)(66556008)(478600001)(36756003)(66476007)(1076003)(2906002)(38350700002)(38100700002)(16526019)(5660300002)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ij+gtyVUqMG6CgJMH9RiD6qSVzepFJZepKL0+2gtgC5GpJESyAY/D1sPFGtS?=
 =?us-ascii?Q?C1pOwkTAxIfkQNP+GwCJwZ6Mx+TjvTqj4KUluyIfy0Df7i+LiJ0lHhuN3hG2?=
 =?us-ascii?Q?l4EnwWwVZmMjaVKdjgQBu32QcLT+6G99iSIiQ0KQ3cqLdl3+0+JHQlLQ+FQ6?=
 =?us-ascii?Q?Wa9xZF93e2E4gMDlieb9ecOxJEBefFVKHjhuHktI1xlbmi0JxIAc0exDBc/A?=
 =?us-ascii?Q?qtH0kR1thzmwjuPHZ9Cv5p0tOFDN2ZAOhoJCXkIAdh+mq5p4CboTs/ps6tkO?=
 =?us-ascii?Q?QmclGjWkXAY/AYmgvQiwpxOJaHGwm5u3qTgZLD2Dns0NMQqJ6zClugBzXsqq?=
 =?us-ascii?Q?X7TPc3XYdqS62YkeYAeqI5CRiRyEJ67tvFvqfcDMOf+O+ymwryVWX9+tAX9f?=
 =?us-ascii?Q?BhNWyVLNzVdLUJGsPgvsrpcy/Jz4LPyaw55oXUnBQLEmESP5HCF5ZqjEso+Y?=
 =?us-ascii?Q?2vJp1ae5kDNs7wZL0b19p4Kvf0dfbmIXb4FNuc+/+Lqf1PkaUkI7Ohia4GyS?=
 =?us-ascii?Q?NsGryocwzDmPKPxEMGkvMVWYYXsVh7iz9YD5MZVM2kzOy84NXVZmdi69HEm8?=
 =?us-ascii?Q?187IgbNoiJXvYbH4n6H4zV5r3w0SbL4Ij1dkrKd35FUq47r7z3dSHJn/JePN?=
 =?us-ascii?Q?ziVv/rWPPtAjiXpK/Xv7wzpqVDLuifJ+ICXfxNf6jt1YbcnZankSbLl8HYdG?=
 =?us-ascii?Q?CxlqYEukqqrt4u6R4xACEidYpePpyX63kBqBz6Pr8Be6Iraeycm25T1wosav?=
 =?us-ascii?Q?CChOtkDGzf6Ri8+KGA/9xMEwOGspkbX1PzkXWF9hinfwTy2JSfIEaTYqCJSe?=
 =?us-ascii?Q?Dg8iUTIjm8qIg5WG94+f+dzaxp+W9qs0mM+KTI47Z3DPXTBiWCgU8bGMypJ6?=
 =?us-ascii?Q?ae0KTwq4tYvStXL8N/DwZjgFCUoYYXF/yjPMFwuEtd81vrFRjXIoLZzPVndx?=
 =?us-ascii?Q?Nu3QwMK0qGeUodTcJPSPMndNEqp+db6pH1xBQDB5atpDr/4cbh8hyHEbc9fL?=
 =?us-ascii?Q?llfJiZMWyMmIp2JGX9QYNK99Lk8gDkH0S5DiO4W64bOzz3+XT1ZYVLNwHP9T?=
 =?us-ascii?Q?c/xtd8Aq+EYOareurqYaIhgG/ztAith9GADBPIUXi57vZsRhs0fiVwWgLl8F?=
 =?us-ascii?Q?VUPoBjKtihvPkp+miPoSkNYlvAb7VS6AbPwd+PJeTOCmdx4LCo6tfWwfkpN+?=
 =?us-ascii?Q?owqXnT3f+xw0ptZ7DlRC7J1ta0RbK7zGwuSJPn4dyrTI7O7pNevscZlMQzNQ?=
 =?us-ascii?Q?urV5SnKBlir/+pBavNeQUOKHTg5Esqc2t/u0VB+EQdJiajJEsax64qYlj3UZ?=
 =?us-ascii?Q?RaUS3BsT77Nw9v4TmCimvmyL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0adc7143-f21a-453c-56b1-08d914aa819f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 18:28:00.2454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXKm1IEBNH6H/dFZXXPjvETEywC86k6dZHgg1TTzba9AJot0aSPKmXzrjF/FxpMK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2839
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
Cc: David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The proper metric for fence utilization over several
contexts is an harmonic mean, but such calculation is
prohibitive in kernel space, so the code approximates it.

Because the approximation diverges when one context has a
very small ratio compared with the other context, this change
filter out ratios smaller that 0.01%

Signed-off-by: David M Nieto <david.nieto@amd.com>
Change-Id: I5b6e0ce5f489a5f55855d35354a6a3653e9d613b
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 9036c93b4a0c..78579ad03e93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -703,11 +703,22 @@ ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
 	idp = &mgr->ctx_handles;
 	mutex_lock(&mgr->lock);
 	idr_for_each_entry(idp, ctx, id) {
+		ktime_t ttotal = 0, tmax = 0;
+
 		if (!ctx->entities[hwip][idx])
 			continue;
 
 		centity = ctx->entities[hwip][idx];
-		amdgpu_ctx_fence_time(ctx, centity, &total, &max);
+		amdgpu_ctx_fence_time(ctx, centity, &ttotal, &tmax);
+
+		/* Harmonic mean approximation diverges for very small
+		 * values. If ratio < 0.01% ignore
+		 */
+		if (AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(tmax, ttotal))
+			continue;
+
+		total = ktime_add(total, ttotal);
+		max = ktime_after(tmax, max) ? tmax : max;
 	}
 
 	mutex_unlock(&mgr->lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index 10dcf59a5c6b..3541dfb059ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -30,6 +30,7 @@ struct drm_file;
 struct amdgpu_fpriv;
 
 #define AMDGPU_MAX_ENTITY_NUM 4
+#define AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(max, total) (max > 16384ULL*total)
 
 struct amdgpu_ctx_entity {
 	uint64_t		sequence;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
