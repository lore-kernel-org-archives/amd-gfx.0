Return-Path: <SRS0=NjTA=G7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C78C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 14:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDAE664DDC
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 14:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAE664DDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 806946E981;
	Thu, 28 Jan 2021 14:36:12 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750083.outbound.protection.outlook.com [40.107.75.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C84FF6E983
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jan 2021 14:36:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFmKSv5W6STtckREEt5MsupNAt/QVk9bpZVqD9bDtQ7t0HUg9ZH6gKj/+4Xmmu4JeFXBzhgdSxg7iBwXbyTEnBKEvXGLkm3qkarzrl7N/1SCz9c1keQ7OOOJJzbmmSN/w/8lK/v6hRMJQzCTvrO5rYCRE69iKopwNuPvHHV6ush3hi4PJ+zpBsJ1E2IvTYDCF6az3Gmn2K6x52kQtITyQigkm1L7V0AtpX2Jb8Q/EF4ADOd8xfYBQWMEqsmAfFPuvKIN/WNaSqoqo08YWrRAdcY6xBRrOyDWyaf7aZG9dH/L4rNy3CwECGaP9h99pXHvRe4kSoGBSerKmw4+mijrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3ro1JqyJ+dZz00hh7XW/1EAbfRfXIQXE7FvoIkV6rQ=;
 b=fw6LbNgUUa9KjQ5LjVh/9e1elZRV4pLKZLgSPNR4ul1+eOqQuXG777ZcI5JI4HLpAAx4E8paClCd+UOkBSAr2RMDLHnQnGQBQr7czJmA9vk5ehyAv52yLpDh0/SJ9pb2CQMiLCuyN4YQGlnZOj8rF4JXgw8ephVIUSEmoCKemnM9Lhzg8QaKvXpPEYs0jYGXyxrJpuY7/2sg1QXVnt9fJaPPZ2y/DZdyiKeBnKq/rtF/ylj1tmZSp5v5e5uoKZy3TtOE9UdVt9hUgYx86jv7IpoP8uwEaQGooY4RrYrA9Owp5lFmmb1j7CR2B9iiRCwVF0Y7TQbHAbX+tzdSMFPbkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3ro1JqyJ+dZz00hh7XW/1EAbfRfXIQXE7FvoIkV6rQ=;
 b=SzT+oL0tGZoPKp5cAog4t+t7h9CDh+jkmsmhXs4+qId3ldpgNp/AHe8VZ7DkSuG3tm+NTcxV+spvbcSvVH2cCPMqn3P6YmUT32JKOMyZN3fMiDTRxwc+W0lt2+kFVPBCiug8s1jF+l5hmlbJUAYuB65Wa38+kd0Jxx5YfB7AbUU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Thu, 28 Jan
 2021 14:36:09 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 14:36:09 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 2/2] drm/amdgpu: enable gfx wave limiting for high
 priority compute jobs
Date: Thu, 28 Jan 2021 15:35:54 +0100
Message-Id: <20210128143554.61100-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210128143554.61100-1-nirmoy.das@amd.com>
References: <20210128143554.61100-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.126.145]
X-ClientProxiedBy: AM0PR02CA0167.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::34) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.126.145) by
 AM0PR02CA0167.eurprd02.prod.outlook.com (2603:10a6:20b:28d::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Thu, 28 Jan 2021 14:36:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b42d3612-397e-423e-5afa-08d8c39a0d74
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4202D7FFF5820C8401E299318BBA9@DM6PR12MB4202.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:48;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Tpi1gitxyihT/L8sYQM03A584TIzfuCLTecc+BaxfSATWvqiUdikB/jW7vRE7vzX4s44InjLoVX2CAGzSuh+27OenIQ96QVKSYkKLLdpYRKNrzbRMsnp9+hhLnbP2vQreeu44qnCgs2vyqjt/v/0VoAFPVgNOT2jCJLMgt62ArQ8r+0L2ibMxM79s3jOA79E3h0h9Iqo3WIATDVeDJgDtIeavEI/GTOlQ/ZjVYONmvGLFgpzOE0bofJaDcNf4qeLq5gTCK09HzFSK6JeVIAQvam/u1Q3ZhGft7c1K2BEUYo1as0BpTXFlzrD5YVqnt48v6sI09dlm2AIV6k2XiJp/stlsHUDxTd54nyNo5AQXfDlaBgpVWSHDZC3m71K0IantmR+wEvc8Qab07kxtcY/hgV2HXh7i1vrU4dL8pdmIFvhZkzAPFawCtA0vWhsolfc6yB1Z+THtbY2A2plmFRGANnHCi3opQNWE6I4nNuwlyg7pDijUcF0qHmkd2prCt2F+T2qYgwCzBi1FohWFBUZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(66476007)(2906002)(52116002)(2616005)(66556008)(83380400001)(26005)(66946007)(86362001)(36756003)(1076003)(5660300002)(6506007)(6666004)(44832011)(186003)(316002)(6916009)(16526019)(6512007)(8936002)(8676002)(478600001)(956004)(4326008)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?joMU7qtjefQyL6WJ4i6F2py028gxx1Oi5KWO+obz8gwmI+rI3qAD13NcHikS?=
 =?us-ascii?Q?sCLkTjrlYkt5PUvU+h60uae3rlYLd6fOjqd7Km6EbwVUgMsB9k7aHeMXiyJL?=
 =?us-ascii?Q?C8YvcLk1+2ktNdqPzohnnsF1nu4TcVi8jstA5WFZ+DeereGpRhXqIPXVKo8F?=
 =?us-ascii?Q?5+a1Sh1p7xZflwOr17959Cmh2ne4vrRc07Eho+dDtMgfKc8QDf+ZRpZpPCuo?=
 =?us-ascii?Q?FgfHlog2+jh6dH9I8fidlfOqXrElkX7tl0a+mqjydlQubnDWJF7c8lAqtcmF?=
 =?us-ascii?Q?cFms6WwjiT+TaMZFTuHppqem+mQl4YQlk8LIWo+KE+VvvcJHJojLWR0YAj4P?=
 =?us-ascii?Q?31QwCEieA+lB0Z/Lws7g4+Xc7+6XlwAwNSI+UkRJImVmq1fP6+XajdXymM62?=
 =?us-ascii?Q?r2q6KYdwPLZc5m4vEse55tOlCkSnBNHXybmM4AIws/+43Ngn11GxLQDnkoVY?=
 =?us-ascii?Q?IGjKctXMiJy1+IpCiwFzJACxMmt4i7edWwRWxtbRqlXn1eEGVqI0fJDV0eF1?=
 =?us-ascii?Q?nn2Q2UNQ+LhfjrEM7KJemQhmqbBB4YF3UtjJi/k6bXE8SQ68LNE71nTy8ujL?=
 =?us-ascii?Q?a8xHAlT0CrtHZnTI1eHj6qV/GoaYi7AaJ5cCaoXdtzkddTYcH5GusFTImG0D?=
 =?us-ascii?Q?7U1/wgn0DgvJarJ7ADmZ9rPOq5WQB7IGdmnqFx5ZtPiKwBzOhrQ62jHDzIDe?=
 =?us-ascii?Q?Lpq8EiGE06N0+mVQOuZe6xcfEScsFAntxxl0YIAw8n632RI4btB13Z+93JWd?=
 =?us-ascii?Q?ZSDB7iNkK3a8rjKfFW71cpowwHDZZ0PSz6xcUMQ4NQ++h5ROCk9dGzxprekY?=
 =?us-ascii?Q?aqR7sihFBCc34K0o7m1L1f6IqpgmQmQ7aZuFp2Q/DTuHRuL3xvjWFGAj7h+Y?=
 =?us-ascii?Q?X45SZX2XLFZzKsE07WVKOQ+8GFacwzKZ2wZYoVv9Rlwm4OZJbKW+ZRBuEiHK?=
 =?us-ascii?Q?gZpxA1JFSl1e+9FSEU6kDGx0Yv6tm3R+qH+ePG4PsnKYO3dyMpKwG8VpvmmB?=
 =?us-ascii?Q?V6nth1MALcTE+WxstX4tIzaI3ShiI21NURelM9Vl+T4iAwPHCaOZaTnhbbMv?=
 =?us-ascii?Q?5iTcXFLn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42d3612-397e-423e-5afa-08d8c39a0d74
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 14:36:09.4172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mv30q0QXXp+kqhrk3w1enfukoss4XreWwim1APK11aZAR8hD1s3ep8BTywBASOLFC7cr/5R7qEcQZlfJ8uh4pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
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
Cc: Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 Nirmoy Das <nirmoy.das@amd.com>, ray.huang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable gfx wave limiting for gfx jobs before pushing high priority
compute jobs so that high priority compute jobs gets more resources
to finish early.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 024d0a563a65..ee48989dfb4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -195,6 +195,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
 		ring->funcs->emit_mem_sync(ring);
 
+	if (ring->funcs->emit_wave_limit && job &&
+	    job->base.s_priority >= DRM_SCHED_PRIORITY_HIGH)
+		ring->funcs->emit_wave_limit(ring, true);
+
 	if (ring->funcs->insert_start)
 		ring->funcs->insert_start(ring);
 
@@ -295,6 +299,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	ring->current_ctx = fence_ctx;
 	if (vm && ring->funcs->emit_switch_buffer)
 		amdgpu_ring_emit_switch_buffer(ring);
+
+	if (ring->funcs->emit_wave_limit && job &&
+	    job->base.s_priority >= DRM_SCHED_PRIORITY_HIGH)
+		ring->funcs->emit_wave_limit(ring, false);
+
 	amdgpu_ring_commit(ring);
 	return 0;
 }
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
