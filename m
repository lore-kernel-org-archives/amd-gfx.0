Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40B6606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Te496twZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 736DB1123FB;
	Thu, 22 Oct 2026 08:33:57 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013059.outbound.protection.outlook.com
 [40.93.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C36E81123FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:33:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYneXPgLU7lua5qQMYxMXt76MtWVeIenlrpnuC9rRSh8IXeGZ7hKUFTnNMTXf36nnU/Wy+V2J9Sp8FnUpinLRB4Yt0s0RT30WZpTU+vBQoMei3pUK+GCKxr6hUjDGEgw76gKL6wq3CQsGD4MJpehyqlNvT5wKRekx/jYqAZT74FJ0APw+Bn8d/dxL1QMOePT03TZp1S1fc2HMSTaZlq9uWsGIQlpJxiim2wrP92NFsJ84GUn52r6FWGMZts7fDE0ovEtLFLy8c4nw0RHBU6TLpu+WwkwxFOaHOzOf6LFw3T6lDArkGn/WIZuDjCTVKO82lGHBuSLpN8ixhLZClZpLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByvvRjuW5hJzpU9tVK+khY8PcaLwCjAByljcaOOgDok=;
 b=jHb17r400fhDAqq8SycmokMViB+G5r/id7EVQFH6F3l2iNxHu9rQXLB37cG+r2gQLtI9SI8/haioJ57Pd5YNLwOXQ2Vpj9X7CFQhFS7m0VQSEShNjYKGvQc/nowTGg4C+/zLYjngViqEyiI3ir6Kezdc/HWn2bzeJz26oDCrMSYwie0pSgXkDlNNw7P+PWIFOuX9IVH8UBh7S2E2R3mVDZVTnKFou/yrNFbO0o5RZsIfzV4BybEsHOJg1tGW/RICJOzmcLajRrEUqWd53dvK5iNI+ugVps1NejXIuRQ8qgEgDX9gCN+n7BtAyZVjl9w17dFttZlXx3POTkfx4gsPzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByvvRjuW5hJzpU9tVK+khY8PcaLwCjAByljcaOOgDok=;
 b=Te496twZSzk7LjDYzgqdk9KTTNq+rU6IKkpaWQZ8+kfOJXNCoZRfWgqxeHfNerWScuoqoDAiA5QGaRcswVAtFabA4Dnwp16NDJwAYACsfQEriQ3663v1v2Jrv7Rwqvk9n4WAK4K2sAVVEtyFSSp2CDiPa1j6gWrwLRaM3MmuV3c=
Received: from CH2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:610:50::29)
 by SA3PR12MB9132.namprd12.prod.outlook.com (2603:10b6:806:394::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:33:46 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::4b) by CH2PR16CA0019.outlook.office365.com
 (2603:10b6:610:50::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 08:33:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:33:45 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:33:43 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH 3/9] drm/amdgpu/mes: skip unmap queue notification during GPU
 reset
Date: Thu, 22 Oct 2026 16:33:25 +0800
Message-ID: <20261022083331.3019779-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022083331.3019779-1-Prike.Liang@amd.com>
References: <20261022083331.3019779-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|SA3PR12MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c91d5b-3cd6-45d0-b058-08df3017300e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|22082099003|18002099003|261021121427099003|261021123027099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: NxgNMtNhdMl4tZVDkvNAQ+7cR/Y18KE7fOf/kNMwziwOhfDMk2rVVTS3BBI1i3LERnoi5KsFX/b3kXPW+oLiv6476Qs4E+JmQf0CNaMG+oBQR861aFz9ixOwxSCO6eVpILdwpkuBHXftAie4JWzFWlpaOBvhHdKHPMTMJubqCnracB3GklWe2i6cgmDD3UoHylsZJVEoPaB6+w3y0JOwyeaiy3taQ1mXWs3Xbh4vhJ19SSxnO6Q/2AMTgGxy/qFk55l6pudvzTPovdBRz+hfmDrSDeJ1cfiEA0oPsCQMd9GJuoikVF0Yw/6PWPZZ8QQZvG6I+OjqBcjeUaZ68nbhBk+h7DWGwcbDUJGN2mGcrApum80tDvekdpRnKsqTRC/l+TMPlj2jXFOKwbhhFVuOzaZeKBbPDcBE81IvPgEHG/7qIj3hw2bZUgLDrAXNAARtsa/rHniGFYBeF+18l0kJA5qeu1x97WvZAnP8kbPmh7qAERxHIrVmvIc2CBzBUyzheEwOVg0ZPVgZXRrUilEsP5xAAm3gbsFXxcvN/anbTNhMHQjm3yTvKFgUmLNK1p7wHtQ2edsVvwRm3n2X/0VkZ38plBWi8UfDbYR7enroSSXhrJ1I8SihqacZNGtUD4Vz9yzWDBoJHyaJAQPtu8tdxvHmdVALzEz5CEtWqNpeFlwjFf6El+LELFbSCkxvwZJ0MTKY4PJ8SYWYYkVN26dKZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(261021121427099003)(261021123027099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: enecwKOa0pAUn7Yc+CYoKp3VII3ZFqX0g0rHcr7qecWEe0KLa6tviWsqUJFr7Tj/cMgmVAb+p7WhYkEFQQSi/UzJSJP6TEt+odCL4o5mMBzuVPn8T30voZ/yegERYB3vvsY7HExVsTzxDRqmMFviQK2xQ7we/d04tzoiNKjIUeuRsN7Z2rmwgbk7C4wXM/p5cNIXvPDKYjs9ru7jJYh52uSO7p7jbqGlKrKfkWNb6zKvo7xhnJTen9V8St9xhlHfiNdXWVzXXRLWvuZaCaMDfL1Mp9QFf4s54UE63JyjtTYl2/gbz2NS3yrIIStZZUIYIG9TISynnhCWyFllAxveGRoKGX61Ffn7c6nkM7qmVJDGSd/TiyZoY+ak3+/3wSr4ng9B0kSQ5eJUy5eqtyipUQehtKBh9S+2kne9eMS/UN2+eJb0p1/YfHTdeCo4r8r5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:33:45.7999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c91d5b-3cd6-45d0-b058-08df3017300e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9132
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_mes_userq_notify_unmap_work_handler() submits a MES misc op
without holding reset_domain->sem, so it can ring the MES doorbell while
the GPU is being reset:

  WARNING: amdgpu_device.c:928 at amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
  Workqueue: events amdgpu_mes_userq_notify_unmap_work_handler [amdgpu]
  Call Trace:
   amdgpu_mm_wdoorbell64+0x20/0x70 [amdgpu]
   mes_v11_0_ring_set_wptr+0x71/0x80 [amdgpu]
   amdgpu_ring_commit+0x5b/0xa0 [amdgpu]
   mes_v11_0_submit_pkt_and_poll_completion.constprop.0+0x207/0x520 [amdgpu]
   mes_v11_0_misc_op+0x8b/0x240 [amdgpu]
   amdgpu_mes_notify_unmap_queue+0xa3/0x110 [amdgpu]
   amdgpu_mes_userq_notify_unmap_work_handler+0x24/0x70 [amdgpu]

Only send the notification when reset_domain->sem can be trylocked. The
work re-arms itself while the HW queues are oversubscribed, so the
notification is retried once the reset has finished.

Fixes: a3e112968588 ("drm/amdgpu/userq: create the same workaround of oversubscription timer")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Cc: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 05bbbd1afb63..f573453415bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1191,7 +1191,11 @@ static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work)
 					       userq_notify_unmap_work.work);
 	struct amdgpu_device *adev = mes->adev;
 
-	amdgpu_mes_notify_unmap_queue(adev);
+	/* MES is unusable during GPU recovery; the re-arm below retries later */
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		amdgpu_mes_notify_unmap_queue(adev);
+		up_read(&adev->reset_domain->sem);
+	}
 
 	/* Re-arm if still oversubscribed */
 	if (atomic_read(&mes->userq_hw_queue_count) >
-- 
2.34.1

