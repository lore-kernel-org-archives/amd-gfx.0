Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD820C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 19:13:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC8A121556
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 19:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sKVNlOZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8A121556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381286E194;
	Thu, 12 Dec 2019 19:13:33 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750050.outbound.protection.outlook.com [40.107.75.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 204836E194
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 19:13:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCw8UpDkEwBu9xWCAIGloJZGS3qzl+TumGFWu0oBeRv9yfcL5IbzuOdoX8+70tV9CrGGUM/depyTsgX6OOQTALJHBjcJHLiNUbDa41ZWeoqSZpUJ9LH9LGwAvNOaFxoavUYaDl2hOrYFd0tB8MKAYnMns3JQT6kydQVEeXDtV5DwzgTqknnyHplt4xsJKyYR6VACZM1RSUlV8/S0ZRWqEZZRtxltVanKGwQTno91QzhNRb+ECGqJIEv84UjeFZylBWlHgoJLhTbUZK7bFwRe4qpQPNtqFR2AZQUoPWrQwr0CjJpbtAgNsvCyeTcj2LqcN0h1Ko2BFqy28iA0cZ+wTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PC418rPL0LaoYeCwbFYgJQNS3dz4AzrchRiC4U5wTkw=;
 b=aqbKh3Qjvi4mAtJNuXRyn+pjbTr2Uov0+tvh83k76zCQD/vOVFQcWMP31e+Awv4+LtmFwpSKp+mJtFlMk+7nAREq/5Oj0oLZZ9nXWLuRRDFydROr52cULtCi/WQO0xOXjYaK4oaF8ZB964k/Zs90rva5k3x523ml3ogo0cMGSFBHxX6LWWAT3NNMh54sRRkEyNztv+8nAtC1BNV+jOlwB9kWHhp/d+OaUZdGt+eTrump3aWHB0n5Q+JvEwzh3HRgyQvmMDJxzlyOAOxKkaRSUf9UNkpaVA9hxrP4163s8u5SdoLRMZf3Ev2kFwa7vj5Clw+bcbe1WKYdF7Pcj9X4Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PC418rPL0LaoYeCwbFYgJQNS3dz4AzrchRiC4U5wTkw=;
 b=sKVNlOZ8J/+1TN0sgH0SbScSkgXDANdrpnIulQI7EMNv/uL9pXzPvaBr93S6FuBAmFRjvwsu9SceF7CopCKqg0umtU7+ftTdYwjGegQ9OymcFqpWC7CFuZgV9F1ws9H5pHuIjRNlO0lnOTAV6e2+5cv/tm03voFCaOiC2oWejGE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Philip.Yang@amd.com; 
Received: from MN2PR12MB4030.namprd12.prod.outlook.com (10.255.86.25) by
 MN2PR12MB3487.namprd12.prod.outlook.com (20.178.241.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.14; Thu, 12 Dec 2019 19:13:28 +0000
Received: from MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::65a4:15fa:629f:149e]) by MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::65a4:15fa:629f:149e%7]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 19:13:28 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: queue kfd interrupt work to different CPU
Date: Thu, 12 Dec 2019 14:13:15 -0500
Message-Id: <20191212191315.26000-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::47) To MN2PR12MB4030.namprd12.prod.outlook.com
 (2603:10b6:208:159::25)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 33a42f00-3611-47db-2997-08d77f375e53
X-MS-TrafficTypeDiagnostic: MN2PR12MB3487:|MN2PR12MB3487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB34879A406DFFA8CA13375EDAE6550@MN2PR12MB3487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0249EFCB0B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(189003)(199004)(6512007)(4326008)(66476007)(478600001)(6916009)(66946007)(6486002)(6506007)(186003)(8936002)(66556008)(8676002)(81166006)(81156014)(316002)(26005)(52116002)(86362001)(2906002)(5660300002)(1076003)(2616005)(36756003)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3487;
 H:MN2PR12MB4030.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMnBY4CNpOTyHt1C3Z7Vmg43f6Wsaz8ciox9AtX3+AteQwthxmdcz8g6P1YJ+2Y4852+ay9gHkh+7O69AFexK/B3N2eGQ1VMLvPTzwnx7JQYX3LzAFtWC43zgpyj+R6Q7QifVDkEYm+5hl0YTppUXa6H4v0Z2lqa3t7RzsmS4kjQ+7INX+0BPQweoEOj+FQ1rRx/QFKT+RgL5hTu94zwQFlVpgw7lzHHCPQF8qdivpLZCH63XHCdM9Dfzh7BzXf3pw5UdTz+Q3TKpiuIyhV4wB0vf6KSaF2rC8c0y4A/oSmBCs7wKKhewN6zH8Ar3Ntk7ww85C0dNfO0znSK/e8ai2Qv9qpmKPvukd8Zz2yrh3P/cq4cyv14YMBbsI39US1YTyFRRUmnutuZ2Zsi8/Bz1bcXTWG9DT+1zGDa817PlpCoHfPoCyazFok4ZpqFjvkC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a42f00-3611-47db-2997-08d77f375e53
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 19:13:28.0520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDodwltWEzm0eOTZZM+TJyqpJ7dff2XSbGtIHXCWNZLzEbvRo2opVyVepb7U7soU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3487
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Because queue_work schedule the work on the same CPU the interrupt
handler is running, if there are many interrupts pending, it takes
longer time for work queue to start, or even worse system will hang.

v2: queue work to same NUMA node for better cache locality
v3: handle cpumask_next wraparound case

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Eric Huang <JinhuiEric.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 209bfc849352..c6b6901bbda3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -822,6 +822,21 @@ static int kfd_resume(struct kfd_dev *kfd)
 	return err;
 }
 
+static inline void kfd_queue_work(struct workqueue_struct *wq,
+				  struct work_struct *work)
+{
+	int cpu, new_cpu;
+
+	cpu = new_cpu = smp_processor_id();
+	do {
+		new_cpu = cpumask_next(new_cpu, cpu_online_mask) % nr_cpu_ids;
+		if (cpu_to_node(new_cpu) == numa_node_id())
+			break;
+	} while (cpu != new_cpu);
+
+	queue_work_on(new_cpu, wq, work);
+}
+
 /* This is called directly from KGD at ISR. */
 void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 {
@@ -844,7 +859,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 				   patched_ihre, &is_patched)
 	    && enqueue_ih_ring_entry(kfd,
 				     is_patched ? patched_ihre : ih_ring_entry))
-		queue_work(kfd->ih_wq, &kfd->interrupt_work);
+		kfd_queue_work(kfd->ih_wq, &kfd->interrupt_work);
 
 	spin_unlock_irqrestore(&kfd->interrupt_lock, flags);
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
