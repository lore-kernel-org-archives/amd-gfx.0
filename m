Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558FAC00454
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 18:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C513206DA
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 18:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RuXwj4Na"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C513206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D21AD6E0D5;
	Thu, 12 Dec 2019 18:40:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB346E0D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 18:40:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2nUDe15n5PGVVfBybS4njIpEV7Hd44QuoVTspKcYurT6mIzp71Dsu9UeTnVwm7j+0JNfh2Kpf7TNpGQH3F6cF/0g+j59XDfwB0Ssx2V4hEBwXMZerXYiTWWr2vLZrC4EoFgX5CupMpZY63eUUHyCAPHQkz7l9eq6t+9HJDCcgCFTSf+0QgBN6ybaXejfHcvweZZ5lyjx7TvHZaHjMuD5XgsU73Nlx3VhR3acP9HdBX1Gtk5Li12Wdv6lGYITjxN2CUSvL9f0S/XXFacQGuNRZpxPH56+cZ5YeUravxtqYOXTbM0BZoKiF4ZvAyt/LYS2HlqXnud68Z5tpCEnEkp+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jSF2+PJ0CiA/0U+32U05ou8ojPmh+tFH0GBP3bvBps=;
 b=MTSj1v6Wv8kMciLzZqph4XnuZbqhvnbYmbS0waQhwmDBAUUKm99zlryEdWrpif8OY+lvG9VPmGDdkLnnoTondPAFo0OPKzfU/oncOorV1gjDD9gFCuhUAAmQnm4xXscOaeuKej/SQti576dbocQ8Hn3ok68DzxmtYy0WRb33WZ5Of5n1u8yeKSU99eG++otz0JElgRRmHJkPuEYv3PUPy8NnGn6VS977Ci6woMVsxRekpAAWnIfVPTTK6pxmhKjlFaeS+tjyilYxTSmoD7XJeQG/VY/NuK/5Os5jHsO7y94MQeL9NeXXYd1XIKcSiE29XepqSm/iitPmo1j1j7rmbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jSF2+PJ0CiA/0U+32U05ou8ojPmh+tFH0GBP3bvBps=;
 b=RuXwj4NapDZYlerkkji8Hl/NHj71rZIhw73VEUIF3amMCp80tsEg8fkmWZrRRuibKPxRlze0JBjKTrjEmi9CQj/lRqg2sTcUinp/QTOm0UY3iq3j+/9wyxW86smpG/ykiDfLmqK0XkONmEm6blBXV4t9lnFXX4lSkS80FVwO+jM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Philip.Yang@amd.com; 
Received: from MN2PR12MB4030.namprd12.prod.outlook.com (10.255.86.25) by
 MN2PR12MB3120.namprd12.prod.outlook.com (20.178.243.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Thu, 12 Dec 2019 18:40:53 +0000
Received: from MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::65a4:15fa:629f:149e]) by MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::65a4:15fa:629f:149e%7]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 18:40:53 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: queue kfd interrupt work to different CPU
Date: Thu, 12 Dec 2019 13:40:41 -0500
Message-Id: <20191212184041.9001-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::30) To MN2PR12MB4030.namprd12.prod.outlook.com
 (2603:10b6:208:159::25)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b9ef3b21-213e-4191-5381-08d77f32d109
X-MS-TrafficTypeDiagnostic: MN2PR12MB3120:|MN2PR12MB3120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB31200F508FDDD5720356574BE6550@MN2PR12MB3120.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0249EFCB0B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(189003)(199004)(2616005)(8936002)(186003)(36756003)(478600001)(5660300002)(6486002)(4326008)(1076003)(81166006)(81156014)(86362001)(8676002)(26005)(66476007)(6506007)(66946007)(6916009)(316002)(66556008)(2906002)(52116002)(6666004)(6512007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3120;
 H:MN2PR12MB4030.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMbU/pKbUesH80WPTXRjLTJfOwVntgzg4J+4eNryyHqy53aVopjRCzZLEWhkhwDcNSw2mUruqRiIHFJMPpd0w3rgQoKxQ3yA9VWeUvKaiG7Yu27S+boUDxoVt2vmnEXLzwYu4lAZutCu2TrO1tDTFeGcOCoiqQVEE2jks54xF0oj6+OmoHJ9iok+qGz3mSKMLAaURjO9KmRxRAB2AUlsfKoEmBAFbV5oqQCmDfnEFuTxA0VcE8lC+N2mvPaav51pRjo89UrvTfFFuwF1XQdgFdd64da5Mc3EAT87IIYNGeA3U6v/VHrPrtsDwyOclMeJexQK/IXlYXJzpAJ73B7WZVHSQgUilTXhxUp5GxvIlt6w1Cqhh7jIv+a+U/eGp3JQtJDeP5scFkgapO82qY1PazURiM/SpTbOwhouwBfgjxxefU1uK5uIGbX9i/330lj1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ef3b21-213e-4191-5381-08d77f32d109
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 18:40:53.0325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmwCNapf6MjbbAg6mDibXHmNzdibSReUuxQ+7/iYksHk8QyXpWe02Aakto7tXinn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3120
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

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Eric Huang <JinhuiEric.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 209bfc849352..1dad76a3f3c8 100644
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
+		new_cpu = cpumask_next(new_cpu, cpu_online_mask);
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
