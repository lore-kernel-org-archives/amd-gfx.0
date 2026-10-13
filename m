Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543F4CC6B10
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 08:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E665F10F615;
	Tue, 13 Oct 2026 08:25:37 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010009.outbound.protection.outlook.com
 [52.101.193.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C6E310F600
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 08:25:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fm23JNW1D/OpNkWC8zvvHveVECYq7f4lM/IQK8Zocr13OehdeQGhEI1QzgkL/lOtjn9I4Iilf4W71vD7ji4mhOeA1NJFdm4YyM5lIzUbXQn3+bhtUFrzExb3+vAWzgzq1rPD+2+OrLYF99UZrAHrlmv/xnkuSyl8Yt8SVMn+7QNmfmoo6UURfSSditpQbmZw7mo1mNpSEUwcOg7/hbmUe1SR4JYvCXOipXOom0VuVc8iNueEEFKCmNQwHmfFDJnw85kPMenIBj8nw9Nq+xcZNMj9rte7eKrOW9YjdW6UicVlYDkGyBnSYDBU2wNEHREdHpYSJxN9IdXYjVdHYk7G3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bf0NGpy/XPl4GF9eGEO5LieP/u7OHkgzmOrn27lZDC4=;
 b=k3ecjtig0Wgf7dTETTi+6mYv+kZ9ngUl/AiFfPLw2bcLx5j+KhpOnpHK8kkYpyAY73Y6FADGbQqmlxXkbeqHvYwXikNkT58IcdsOGTcT7Q7v9rMAob6tZLRG3eI4MjLj24AiDVBJcD+QaRSBBSIRBSd9WqMDaiOm93HBEx2kmwNwyx/w2eoYPYZ0AGn/PNgjP+tzc0EkcgIwGsatg2BunwuIRUWcxcd2SCNEV2s6t0SHHyAoh527OwNy4sYpnkFJnwYKw/KJtrH+2C+8AbfNVsuL8kLSs5EJaMREu2PshwNC90qkaiGcCSkkm9S+VihV9JCJINXjsPdKi64/krqkPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf0NGpy/XPl4GF9eGEO5LieP/u7OHkgzmOrn27lZDC4=;
 b=0ffC4AH8HSiyTBs+6X2o99DT3C/QW4lB4LBpH73TpY0HtvQg7pTcYa7QEMNpBZWyslnb2D7Ai3gJzUhohhga+FWlNiE3uZ6MPbOslPMBy9gPY6ttPPttbbeXbnmS7M2zOsyxTDGcobxufAQ8JnprY9Cu8hh0DEa5hlcJlzx9zeI=
Received: from DS1P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::13) by
 DS4PR12MB9682.namprd12.prod.outlook.com (2603:10b6:8:27f::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.12; Tue, 13 Oct 2026 08:25:28 +0000
Received: from DS1PEPF00053453.namprd04.prod.outlook.com
 (2603:10b6:8:455:cafe::3e) by DS1P220CA0007.outlook.office365.com
 (2603:10b6:8:455::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 08:25:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00053453.mail.protection.outlook.com (10.167.23.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 08:25:26 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 03:25:18 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 9/9] drm/amdgpu/mes: skip unmap queue notification during GPU
 reset
Date: Tue, 13 Oct 2026 16:24:57 +0800
Message-ID: <20261013082457.2492273-9-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013082457.2492273-1-Prike.Liang@amd.com>
References: <20261013082457.2492273-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00053453:EE_|DS4PR12MB9682:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7f08fc-a5ab-4727-0581-08df290388e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qEkALxnUp/Pw7jZMa+GZYmaucuIiF2yVzouY0uRSLMMe3IVNkHMr3uU5lGsulQqZJlcrBDNqnXHushwY6Msw6tI9aE80dpyKF8+cBN7KqjfPZAzIQOKQfSySc0A7qfmwryWF/4mQTHlLlBQW85pXB+i6TZ8WXMpGkb0mygtKJ4SdCCJPvkzfgGujpkPH0GH1dNXIW73/KszJvaAMaYzm4xMQYvm+C9xMA303EfQNO+JamYin/ZGXF5j0hzw/cHnEz5HiMoJmfSVfvlw1W+1xSsz51TNilWqfW2HUKxq8qzxL9OLHC+DsoyY0nbC6/xZLmUe3YtfVaI8zly6gWAU0a6827U1CdQPf8uqQ4T44b1aZ8Zb5vBEqFNSwERDTWQEhmfdgwPkOIGFKzVp3vKCdyo/7CRY9NgKsRywWz+iQaaFK3582PlOz3hjzjDJNszj1zki/E93iH5gxmJEL9VZnViMledT2w4N850Wyvu3eNoxgVSewSwY04j5IGL4OTySWB3yAIxlOb9RaJuK/qHFyhr0/9BGtAHw85BLMSUx7T4dZCES1wfd9Yg0pZjBVsjDtHdJGEemjZ3xkdKNN0FzsakvI9RjZWhlHAQ2LWEtER8oiAMBzJAn+RuhZAaqIesHL6G4/gfh6rU7L9RaPHAdHTti0yAH+axkgKI7ARaRzpQS1KW/YpIZy+3v368+xhMoR5fhfsjBh+XHdZtiHit4CCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PmZKQ8h3L2I7JK3VAuJg8/4HiwwAvwMsXEBVuLPMoAA8QhAeuuHuPrkNYVwXaTB0oJj0djGcsxXoOTcFa7//6IOTzZ3JRuaXD9P2kound60nkBi05PxSOxeyfKdSZSvFBn9KQ9X6fxroeciMkYh7pC7U+thTp0utd7HWJ+eFHR+EEFTY2wBzW+Ey6aNkWqqvlOcsFcDuy2cwYMKQuqyVKX5BydpwtuaIJGRBM+6UlcsDc+MYqGNFm/zRvehOb+Z9meyMPtNGoubssuTg3kX0jymhTaaOGRqFaRCySrus/NCaZnnzwTksnWtTflWCEs7hJtYL2buYf8H8SJ4SQ9cVDd6LMOodfDpPFRcaKEelo2LdUBA9qbX9ztnp12JFq6UreXm7mXPc4oXhEcP3neloq8xO2toSqPT2lHk5wuAqpJ/FJTuoXkv5TIw3XMC2U8HK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:25:26.7691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7f08fc-a5ab-4727-0581-08df290388e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00053453.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9682
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 4cb37cdbf821..09009925611a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1192,7 +1192,11 @@ static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work)
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

