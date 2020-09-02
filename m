Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CA9C433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 10:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D334C20829
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 10:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CGRJqsMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D334C20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87A916E2C4;
	Wed,  2 Sep 2020 10:04:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE1F36E2C4
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 10:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnoS8S8HwlkU4+Ifm7tasFoKUaMwesbZpUainqN6Qe7Mc9IiCR+hfcjQ6GtMHYl2nwdl+nE03QkLHPqsMBPCc7M+iZ/q5tbS6TEEeEDK/TeohElRHUpbkmBsZsJZ06RfL25pxbRBpZPT6M3ytlsJHVfSQAndLWdS2xDqaFGiq1mF7me+bdnrMUhyoZgJhDca58mLI0flxd/XLcmLkqW+N1Z9zoprSR2UHqcbh52oo7hY9sv5tjtEmsxQFk7BwMwhNvT+zZwb/92YhxWzzM6FP9ZtMWoGKIo8xcBXoOGKp4eQlpcP2M6vYIa0htasKKDBBgKCJz8ZN7imtJLULc2/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN0dYfBqgncSbv8fS6GG/Xsro14J5q7Z9CG2uZl5RsU=;
 b=oHnhT8V51GEZd04r3chbirnlmfAPQC/cqvkXcyKr2cZoGxlzBma5YUYcu5yTYFJ704oX5Hbpz3zur2qMAZg8ChXm2rCw4eFSgvwyKS7PTGyZuIWWpm+O+9VnIfGOyzXMJuLhQaqxyxJZ9QFC2Lr1vyFZGaupPhu3PuLcvmh6nVJHamhhET5jShzibe+41INCmGev1qOKkpR7bFeLlXxangEpGaMtjFNc1+hgbKd3IiEy555AN8BpOq7iyhXBheX+Yj3Cbcm6teye2AaGbZPu2soIguHeq76mpzqTZ3Co1Q2SNICSLwZBxmPK9grnNXfDbh55QQd794+c3glFVg+J2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN0dYfBqgncSbv8fS6GG/Xsro14J5q7Z9CG2uZl5RsU=;
 b=CGRJqsMI+pEb2gswc8PiodmpXAmbs2MfO95lV4UvO1/iy7wdBE+R3stYXXSSdRU1PL1kldq+6U6NIJKWg8BHETaUFXQz4xu/zRdXHDaaogpcoJTa78bUv+npxoFoADyKcyT6+lZY4IE10pULqq6O/edwshSIFdBmAnuO1ZFrCps=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1193.namprd12.prod.outlook.com (2603:10b6:3:70::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.21; Wed, 2 Sep 2020 10:04:31 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 10:04:31 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: disable gpu-sched load balance for uvd_enc
Date: Wed,  2 Sep 2020 12:08:37 +0200
Message-Id: <20200902100837.43353-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.5 via Frontend Transport; Wed, 2 Sep 2020 10:04:29 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [217.86.127.14]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c88a2436-7f02-43ca-66f0-08d84f2795e0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1193:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB119358D75598E371E47BF8CE8B2F0@DM5PR12MB1193.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A7PhpBzqGEdU94z7JBZy/mQIEpi9WP6Eh2I985qH5pDQ64c7Z7PbliLcAKt5WxNMv9xaycX3BGoDxaMrZE3wxkCGg2W1HpiLdZnpa910wNujJAeMtpn9b44IecJ5yDuhGLVeJbmTM/5CqKhSYQMDRpoRP09VsLGuQxfu/8kKLm+d/VaJetAX2sOrxmbbsOwUpK3DbKYd6v+um6RPMy6D4ia5fzvRgKUgmyQWYEvgvYXwtCDJ1eC9LWpRTr4wPmjKznszCvuT3C/9tV62XGYHV46wIJ4GWXNHdWyRpFVFav3MuYBYoJPBZN8z9ReqtdJjp6JgTim2cLOOVMQJUU6SOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(478600001)(16576012)(6486002)(2906002)(8936002)(1076003)(66476007)(66946007)(44832011)(6666004)(5660300002)(66556008)(8676002)(316002)(26005)(186003)(956004)(36756003)(86362001)(52116002)(2616005)(6916009)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2L7a9D2QPCmY/rFw3snxKwL9OcVM1Y19SpwP6oKYX3LnANuemGjGi5H3AMcXawiugi8z9VLUCR0FgO579n9TMbwQgNd+T8x2WXGkESTyWgywikbR/tqRrlvKJcjU7wKEOcNY1ieYHOiFQPYZksHfDqgZ7FhtPXZ8f9mDg/VDFLM2A8uugCu3IVwL3ErsxHJFPIJdla0kA3YtMLEAsOxW+k7pvzL4QzAeBDPuXxQD2eWfDWVIqXTXVMDxVmaYQPmfi3bSCJxN5tLyD7Mc+rjoOemYchLQlnCC6MEra/ZAp4lt3vicZAPA/0uVGII+2tL1n7qvIxg8cYW9OC2QvRhF0/D/+t9UXnTE4yzOFmagaeIQQNaKtpou4M8CjJR/bquXriJShJ8hKtGviDzmoxpT7HrFfZH/y5E6RjrJEUhZD6k35aRg4hPtaPlRv9iWOOIstjP+cYTY/S5/UGQeewiw8WXtc7jy3a7+GO95A1jVuznmDVqnEh1wML3XWGDBKDJ2Mn9swn/nlUMa3NXPDxMIgaiFA5NBZ3i+pBHkSiImRxVgbp0euQH6Z//tkiuoDDDANXNEYXf1987n0/tsetmhs4a0lHnq1a7rHasa/w+Xd+JU/4rHYDXTvOiQDu9QPRz8MorNZTR9ctp2mnQnVzuv6A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88a2436-7f02-43ca-66f0-08d84f2795e0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 10:04:31.3053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Brn3t2+Ol168z/IgybN9ZdKZRXUhf6E/P02WJY5fdA/M+BwD3Cw17qx1wQdoJnWb0mXlvLyMlHX9mCzzbuMkuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1193
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
Cc: Tianci.Yin@amd.com, pmenzel+amd-gfx@molgen.mpg.de,
 Nirmoy Das <nirmoy.das@amd.com>, alexander.deucher@amd.com, Leo.Liu@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On hardware with multiple uvd instances, dependent uvd_enc jobs
may get scheduled to different uvd instances. Because uvd_enc
jobs retain hw context, dependent jobs should always run on the
same uvd instance. This patch disables GPU scheduler's load balancer
for a context that binds jobs from same the context to a uvd
instance.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 7cd398d25498..c80d8339f58c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -114,8 +114,10 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
 	num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;

+	/* disable load balance if the hw engine retains context among dependent jobs */
 	if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
 	    hw_ip == AMDGPU_HW_IP_VCN_DEC ||
+	    hw_ip == AMDGPU_HW_IP_UVD_ENC ||
 	    hw_ip == AMDGPU_HW_IP_UVD) {
 		sched = drm_sched_pick_best(scheds, num_scheds);
 		scheds = &sched;
--
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
