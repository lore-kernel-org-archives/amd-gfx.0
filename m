Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BE4C43460
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 17:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CF8B61435
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 17:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF8B61435
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 499A06E0D8;
	Thu, 13 May 2021 17:45:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EFBC6E0D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 17:45:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAno+dyQvcsFc/ck9eqIBR/KtpYZTP+CV67VvCT2eqLv1/haiWmNpR88oaVMNQ7X9msvjE9HEpyNbQOKCGtYAu9xKkdYFOAgIuTrOKpz8Dr5oABPfI59hcFUi/ftZh3N1TWDV4+Xh5511lpu3dKd0rvAHXZsAblbZGU+0f9FC1BkfvO6NjNko1D8OVjjF7NqRY3Ir8GW99zEPjmvbdY5X34WG9Qf3AdnVHI2LT/a1kn2n1HGL5qfVaX079hVeI+e9Jlz/Z4rKsUDSQz8U3u1un3CkLq6tfFzKokDP3QNvQLhr9XkZbKmNcGdji2FE8xzS9dHFVJfkGolTSGFOmpnUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Phi/wZdUdqxinfHki0UybN9ulualovdVo0RJtF03ZbM=;
 b=UT8VkCUMmx4w9Qs25e1KT079Yi4oSXkgZs1zaJzH+uchYwAXT9eWvYcP9Kv5P2bc67gN0jiVxm4wXzmlcpfot8OMYLbIOtXg2OE4FCtm0lxpWOgiuBYvyJIzKTKaUKJR+2dZu5N/Mh1/hczmw9j4qVdXU5YjrWfqVEQt7uR2oTqZHEOm7I7C6c10j3+7HYEWxnjAQwFIr6iqfNXK9QAp06Uq4K6rWWDFD/poQbzVysl/J1aR4jgCxLOeX75/ZVdyAwqoMBEyohOmkMyek4+r5E7mO5kPi9Sq2qV9rh0gbo6KbTi3sfuiqy/jw2JUm22RSqMYt9gl5PcCDpMgkeGd5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Phi/wZdUdqxinfHki0UybN9ulualovdVo0RJtF03ZbM=;
 b=vIR2LHu/hhWjhepbUC5/t9RV35WHg1eDL9IpJi0wBEWxgV6iXVqi70rqCdaO6w27Xk1PZgzhdCOuJBDCwRTVYXiD74M3DZtZf7wKYDuhByjgj4yEskWBKLG6yaupxwB4M9CF3CXQflQIc1WinAyVB5qLgdvAYaooAYimMTirsMw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB3062.namprd12.prod.outlook.com (2603:10b6:a03:aa::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Thu, 13 May
 2021 17:45:52 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4108.031; Thu, 13 May 2021
 17:45:52 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: free resources on fence usage query
Date: Thu, 13 May 2021 10:45:38 -0700
Message-Id: <20210513174539.27409-1-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <a5c987b3-e2bf-7c80-3362-fe3e6cb1d44c@gmail.com>
References: <a5c987b3-e2bf-7c80-3362-fe3e6cb1d44c@gmail.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::10) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR05CA0035.namprd05.prod.outlook.com (2603:10b6:a03:33f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Thu, 13 May 2021 17:45:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8b594c1-4141-4486-1f80-08d91636f35e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3062:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3062AECDCD918524E2A8C1BCF4519@BYAPR12MB3062.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:241;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXf4iDT8/7kY63QsfUhFrfzEhVS9rjhF1vaSxcQ1F0Z+PI7qC3IV7ifyI0fAOfM2SMx8ew8zhL0o0FsH5yDCxdSmhipWV8yzTa3Is5ImFs4CE7U7q58kDJAdGv/UX9cHDvLLmfUHXkV3BS+Ilu0YI8GCAiz1VTd4kQSL/Tly8maSifmDcIj2GaGg7+Efed0TpH2D9ZePn2qDH78FD0RS7KzwygLAMUu6ZpCVwe9i6VbkZEi28W/zHAckniOQBeVcK+dD3sdxhS0nY93178V+KPtRlCl1X+cHqjdw8obdvZVc8IMw6shCOgTvroz9S/Fthd+BimCeXm2dYuO6Ow7VJABi+iCw4GHilWC3ctpUNlP5Jx25Rfm7oIYA9vo8cENkmyi+j1ZWeFYC9V7Pde3XVBbq1qfWuhug5ZvU6FmKPKqHB8ItucDrTRO0pdwPp33B346SPxum4HbIDOLHFujVfGkXFb47KnnyMDnxVmRVVUjjvI9HZJ0doB6OkvjXNeLRNg6mytCOulfZ3sEKhNDzkfeFicxyYzFpnGsymnYFoHD+2MWyoZJZ75eWU74IZlvz4LN0ygw2WHqbogIsRnqz3x7OidEHXzzA1sE13n80h9ighn46JJfheMLoY8A1sCKuJLChtP5nt06cQQYSnPg4yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(956004)(8676002)(4326008)(2616005)(36756003)(6666004)(478600001)(52116002)(7696005)(83380400001)(38100700002)(26005)(6486002)(38350700002)(186003)(66946007)(1076003)(16526019)(86362001)(316002)(66476007)(6916009)(8936002)(66556008)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3un8NRnMWR61HNIK9/Cg6xiQmbs+vmhumjK8pKYOSczXzAzCcU55O63e9Pti?=
 =?us-ascii?Q?SMBa3lzMkgUl6KM3P2367AgH3KzOtLmu9fonCBMekctmwq78UOjbx09Rq4rX?=
 =?us-ascii?Q?6QSPvfNEJOo60kWBKcFw7Liedes1gyv557VafBSJbSZYUorh1gZ+ivtj7m61?=
 =?us-ascii?Q?CKt3CP030ad8rI8MTw4N7Bxx+71mmTLnVFcUGzzIOrkRnCN7CbkbKfiLixpu?=
 =?us-ascii?Q?88+MSYBgdZb0jU/H1849gohRUyyIdrfyaA9ywhpDrgJNQza3NFjNoWwlGhRN?=
 =?us-ascii?Q?b64jceTz+/EcL+GTJ3FJdrqooJkEEK/zUA+btStmKTJWwmNprQMpCtJSA19n?=
 =?us-ascii?Q?XCJ5EQ9ynM9UNXxXc83PssRChFSzAYUzhqCfe0jJxQcBr+SsO9c31QDbOTdN?=
 =?us-ascii?Q?hiU+ke/qEYOJb0M80hWcD+6cy1rY7tCcUM+gY5AjXCYuUCXGT542Zt1aDD7y?=
 =?us-ascii?Q?SBJWe7E2tWvGpeSXF+p3rs5FgKMfLNeWqczC56hNPI677sff/DlN7UgPG9w7?=
 =?us-ascii?Q?7IuVsEBEfDlDWL25U/wdxF6WAeYa1R7iIJGYrX4FEpkYzxdgvoRMXWFCK6j1?=
 =?us-ascii?Q?wG0VWAlO40/RtYrnjQlUuDWfnd38ODcvpdie25nc9uVXiPi/JaQJh6mk3oKy?=
 =?us-ascii?Q?dr2+GP6xpL4NAYB7XSwv+RUx62EwP6dEKE/atRlWUlZnITATa5l5JoWP9si5?=
 =?us-ascii?Q?LaF+6vNxQA4nMqGzVFOf/LcsE774RzrJhkseHaLelRj9wQClwySeatUd7mcD?=
 =?us-ascii?Q?qRcPxM9PrDDwng/FoDmlE56p2rhWk+HpeWrMfG9mTSvex7aGt7th6f4N8XkA?=
 =?us-ascii?Q?sv54HgFpgyYz+tP+4W47iYV5i9RQiEI0QQXIa36e6y5vrGDak70aQdE9X6cA?=
 =?us-ascii?Q?5SLkPiypcRYyW4rBaZB7RZQgP5HbynoAVR+pSbRtIBMHZkxvh3nDrbFxWEQC?=
 =?us-ascii?Q?rhH62jrbTE3ONczWXf0uq42l+ni6sH7grqD2ywkfSgfZ1+pcM0uaCX0pfNXt?=
 =?us-ascii?Q?gLvZu4hBs3cpyjAWEcJGjX5M5xpWtm7wtj8AC9nAlQJBWGLqypT0kPrnGUpG?=
 =?us-ascii?Q?l0lVsAz3v6yH3coBMNMwMyLg9GenOlaZCiCHD/mcI7l8OuTVIACTeRXrRJT8?=
 =?us-ascii?Q?IPH9Gqj1hsU4qyRiw8A0GveQS88kb2wqh8xWYdHPStAB5WIavVyy17fqErIw?=
 =?us-ascii?Q?sHz6aH4EG4XerW6+X9TKJ3KPynXgRoEtcywQYFAQEO+ApM1L75ncqSOrtowd?=
 =?us-ascii?Q?dd9f6zoiGJqBRcJVLOuhdg7PSG3QPmk8xYfIOGmtngbDJiGUeF4q9gUeJ6vH?=
 =?us-ascii?Q?MkScYDs/4ZJblLMfOFPikp2x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b594c1-4141-4486-1f80-08d91636f35e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 17:45:51.9061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDpCLSmYprBG1A4FLsA/4V5gNdO8CqXdPg1YY2T/C0vPKJp8s0AX2gEF0wwjXouC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3062
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

Free the resources if the fence needs to be ignored
during the ratio calculation

Signed-off-by: David M Nieto <david.nieto@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 01fe60fedcbe..9036c93b4a0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -669,11 +669,15 @@ void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entity *cen
 		if (!fence)
 			continue;
 		s_fence = to_drm_sched_fence(fence);
-		if (!dma_fence_is_signaled(&s_fence->scheduled))
+		if (!dma_fence_is_signaled(&s_fence->scheduled)) {
+			dma_fence_put(fence);
 			continue;
+		}
 		t1 = s_fence->scheduled.timestamp;
-		if (t1 >= now)
+		if (!ktime_before(t1, now)) {
+			dma_fence_put(fence);
 			continue;
+		}
 		if (dma_fence_is_signaled(&s_fence->finished) &&
 			s_fence->finished.timestamp < now)
 			*total += ktime_sub(s_fence->finished.timestamp, t1);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
