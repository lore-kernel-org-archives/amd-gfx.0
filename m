Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64011E81A3A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 15:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C7FF10E3A9;
	Mon, 16 Feb 2026 15:50:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TCHLjJI5";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C78D910E3A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 15:50:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tffjG5gfx6yDQ/iT0AKuqyizAouYUcAeEYDFc8tMDOabCJL7cyxnoDLwpWRrlMnNJAvD7/UUvI/R5NBm5Wz6EnTcLDXd+V+QbfYbX9RcxC/EZ8JPC92vXWyq8e1w2LnA4kffc+oHyDqInCh8NZZ6NLtY9nSeufA6R+dtwYnPpeO1+OjXmHqxGfXaqxi0FMWNe6qgdSsA1Ete3pJWvOQr+IeI/Liz55rlcYuiiYyZL8PtUHPldFn3FVglapVTJ2bBH6Z70fQXYXFyF76FWr1SjXYijAY0iAQHTkqiNq4QYwYBuDyHGRTd0W9Y+K2REuTvZXjLgjKI/TfBV9kROSaEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApadLh0HWotSSXLDAaXBHF1yknSlHk/q9I/po6CPE4E=;
 b=xz40V3dDSr+G1A2yLyO1sziBwxBzw4cd6ELxBrWeMzyMT973Ui48XSkz4z754/mgzlruVyFhGUZg9BvlGfOPlolvLFmjNKgg3U2Q1xEBP9NLBFMmT5aSf+wL3ml09TC8fdVMVLQDkSWhJuKn6kxAPPSafXNzL0UMBVti7K92rXx5DikRYfwcc2iuh7AcqcgBM3TZYXmf2EOdYoyCvzyRBVmHz1IzTDVNbxO+SApFQSmgMOw8pB9rSwYkrx5WDr1yxKkqb4rZullI93KE9jnsXh3pPGG8mOedJKepRv2cL30liqKlHy7D4Ve4ygxmMLNxG8jdaLJGh6tlzSbCrb+Jnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApadLh0HWotSSXLDAaXBHF1yknSlHk/q9I/po6CPE4E=;
 b=TCHLjJI56ttDGoPiaTyncXpkcQ4rWASPtbjO7NhRvWhbF7m7mftwqRmi435zFkCaf728jqUOLIWjA6kpssqJ9kpmbraqxpP1L7lmZjlFMWXp2Lu514e1NhCdJiycMvfetGfv8o0Z2qBXShg3GIzRR1LuGkNMUr91OFCfmQwjjyQ=
Received: from SJ0PR05CA0011.namprd05.prod.outlook.com (2603:10b6:a03:33b::16)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 15:50:16 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::cc) by SJ0PR05CA0011.outlook.office365.com
 (2603:10b6:a03:33b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Mon,
 16 Feb 2026 15:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 15:50:16 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 16 Feb 2026 09:50:13 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v2 7/8] drm/amdgpu: Add amdgpu_eventfd_notify(pasid, event_id,
 count)
Date: Mon, 16 Feb 2026 21:19:42 +0530
Message-ID: <20260216154943.1582412-8-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216154943.1582412-1-srinivasan.shanmugam@amd.com>
References: <20260216154943.1582412-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7437d3-abbb-40b1-fbcc-08de6d73144c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0tRU3RFVHVjR0xiZzRJRm1DT3ZkelpQN1dMNmVEL0Y5SW94T3RXUEFZTktM?=
 =?utf-8?B?MGxBdkd3VjA3SG5SM3NtRUxrZDFEek9YNDh2TEtKVkpUbm51NWFha0xFS2o5?=
 =?utf-8?B?d1VXNFpLWk5rZkg1QktMZzgxNWovUUtwSFh3dVdIMTR0SzVpSVFHcUdaSUlz?=
 =?utf-8?B?KzNtaldURVNuVU9yR3dEaHdYbFEvYVBBc2pjREdUYW95eStxZTgxbEdFN1Vr?=
 =?utf-8?B?aTNQRjF3NjVidU9tbDVhMG41MjBHZ1ZKeGQvdUdVMnh6OEZiNm45d2Q1eVpP?=
 =?utf-8?B?RUh6dVJEWkJwSVJuQUZBTk4ybUMvQWdFbFQ3UlRRYmJDYUtXNVh6bE5uMWkv?=
 =?utf-8?B?MWhOSThMTVVRZEwzMGltclc5Z2ZPeVVrRUZmQkUwUWhGYTJFTnRMYldlaEgz?=
 =?utf-8?B?bzRRMDdsMmRKNHRHUXpMK0d6ODNrd2t4czdXaElxQjZTSUhyb1c2REk4S0tr?=
 =?utf-8?B?VGg3YnlubVVoRk9NaTJNM01YeUNyNU5DRC93OXdGbktuamJ6Y1dBN2w1K0Yx?=
 =?utf-8?B?K3JmTlpWZnJBMVF4a3VaWFhWMXhuNEF3eTBwTUt6NnF6VjBFUDRxVGxqNjBm?=
 =?utf-8?B?eU1UTTBCZnZEdDZHMlpWeTdaZTJuaU56andvWnVwYnRSbkNBOFNjamZQK24v?=
 =?utf-8?B?V3FEZXNHcC9xemoraG9seWZIcTBKYm14aHZjWmRVbzcwa2tRbDlqZUtkZEJJ?=
 =?utf-8?B?ZzJpdFVtNUkxN3BxbG5UajJpcU9oUUJVOXQxYzk2NXg3RmVoNVZuZCtmUWlV?=
 =?utf-8?B?L3UxcHZHMTAxVmV3aWhlYVJ6R1J4RVZhTmUxaCt6aTZURHEvdXNHTHJUQjVC?=
 =?utf-8?B?TERUc2FJVXNUY2RkeG9jd083Vlh5bjk1cVVCWXQ1MHowT1Fnem1CN1gwTU1a?=
 =?utf-8?B?QndYcTZ3dzF3akUvTnU4M2pIKzlBelNyKy9WSTlMaUppNlJLbFc0NTYyaGJI?=
 =?utf-8?B?S1dKc2VkMzFEbWxXaUkvRW5RU3BlVmR0a0hySzVDNDFJUkIwSHhTVDljQk1L?=
 =?utf-8?B?SllaZk5KS1poamorQzZ6b2t3VGQrQnQxYml4d25KSGNnczVVaVA5TEZ1aEZZ?=
 =?utf-8?B?WWE2TlVpQy91SzRhMmxUQ0UyRDRTa0Ewb1piZ0o3TFFDdUpmMmdPZHk1UUlG?=
 =?utf-8?B?QmFydzNHZllaTVM5cGRydjdhNm4rTGxNeW9ER1h0UVZnTHMvQjBjeVRoZXRr?=
 =?utf-8?B?dGx5cXJ5bGwxZkszbFhCT2tNaEVIKzgxQXBGVVBzd3JDakdyOURtQlMrWWFE?=
 =?utf-8?B?SG9hZ0dkWGsvMFVUdGFpZHNpQmRMdjNpbkRteDRSaDVhUFdxRERqdDlWanVq?=
 =?utf-8?B?Q2VZVGo3QUFHVjJzczlQblZWelBLbndkZ0txMklKNmtMMDRJSDU2aXp6a2oz?=
 =?utf-8?B?WTAvRWU1SVZxeWl1NzREZFRTWkltVnQzVU9ldUJpdTh0QUpXcUF4dDFvSzlV?=
 =?utf-8?B?Z2xaUlFCQy9OZGJkVnBsWnowTmtjbGw0Vm1VcEY3YnVTSEFHR0ltTkhqUFh5?=
 =?utf-8?B?NXRsOVdSOTcvcTVpeUMxZ0t5VWRvSi9wMTkvWjd3TzNxc1hwRkMvNUhIdEF0?=
 =?utf-8?B?RlNETkJvVyt4TFdtS3NPL0VQYWsySElybmJPRU1PUExmWlAySEdyWFVBWGd6?=
 =?utf-8?B?WlV3ZUh4b3VaSG9Hak5OQ3B0dWhndTVjNnk2YXVnc29ubWJ0MDQ4eTMzeGww?=
 =?utf-8?B?cUFBOStQKzBpU21lN096bFJGdklId3g1eDJIbzd2c2FuTUk5NmNoUndQamwx?=
 =?utf-8?B?L1VYaTRWNkVrSHkwaUhMUmhKWDZDeTQ1L1Ura0J3aXFoUWFnSDExNEpCbGZs?=
 =?utf-8?B?VHJndUtBWU82ZmZGV3JvRmpXRjFsV1FGYWpyZDdJd3dmZUdBaVpFVTBnVWlz?=
 =?utf-8?B?YlAzTmt2RmRLRndlNTBHYjZTQkVXYnkraWhTY2NscWN0aGJTcjNXTVhFSUtj?=
 =?utf-8?B?YzRyUkVTM1VpWEJMV1IzWThOQWdrNnA3aHpqenM5a2VWK2JTdm15OWVQTlp1?=
 =?utf-8?B?OTB3UjJuSGxpTFplc1grUy9FaFptV1lHTEJTTUg5WlZwZ0JiNnFGSFVWbzRF?=
 =?utf-8?B?TWhEYlhtN3FuSERiQzUybm50ZnNKWDI2cTlTT01sSy9NSmxTT3JKTTI3Nkpx?=
 =?utf-8?B?WFNYNGp0dERkaHQzaUFMc2l0UktUY3VBU3psZ0JTQVJwbTExQ1UzTzJTa2FI?=
 =?utf-8?B?MFBJVlVGeXZLQnM1SGZmc3JzSnhPMlhacWRlUzlQaUlHOHdONXJYc2Z2eDc1?=
 =?utf-8?B?b3duQ0d3OE52VmRRS1oydjN0bVdnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8Q+45VsQ6dnR2hz48/fOMVL0Ol5labc3236H4/n3zMgxKjtAo0IaS0fHuEg4R9LgDcMzaZQjO5i/CYozcO8F3Iw464wE+RoIZ6YsdJJiTJU53NJDXTjSS90L/BcwgP8IeNg6DBzuCrTovn9wp0kNwB0SXTbrjFLlfAek5inpihXmIhHcAPedTe5BtYO5TKOnbjr8peS0xaoyNgp0FPaPmh8J4ySWtTOR+eS6OBObuEmFq6W1GBUn8569A45QFIS/my0h1QCceUQZg2+wmeXQjjT2lrQDHe8kwVUUnvsOV3USzUXDaQcoAG59oQcritB/Qtjv+rsgKXMhF8WomYWJS3I9Ze0moQfLdzNRMTLaPBftwKm+14vdyF1cET4GKMJ/aSpMMKcCcXlaOzRPJSgDS91Slh8UZOpCR2F86m9ctA5dvr5hnpYduF1PQhYiHA4w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 15:50:16.1615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7437d3-abbb-40b1-fbcc-08de6d73144c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449
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

KFD can call amdgpu_eventfd_notify(pasid,event_id,count) with only the PASID
and event_id. amdgpu looks up all render-node fprivs for that PASID and
signals any eventfd bound to that event_id.

This is IRQ-safe: notify iterates the PASID registry under RCU, and the
per-fpriv eventfd lookup/signaling is already IRQ-safe.

Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_eventfd_pasid.c | 27 +++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4faf908d5af5..7ab03624b301 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -480,7 +480,7 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
 /* Global PASID->fpriv registry for KFD->render eventfd bridge */
 void amdgpu_eventfd_pasid_register(struct amdgpu_fpriv *fpriv, u32 pasid);
 void amdgpu_eventfd_pasid_unregister(struct amdgpu_fpriv *fpriv, u32 pasid);
-
+void amdgpu_eventfd_notify(u32 pasid, u32 event_id, u64 count);
 /*
  * Writeback
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd_pasid.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd_pasid.c
index 770ccc0be70b..5340ce9b2869 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd_pasid.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd_pasid.c
@@ -112,3 +112,30 @@ void amdgpu_eventfd_pasid_unregister(struct amdgpu_fpriv *fpriv, u32 pasid)
 	spin_unlock(&amdgpu_pasid_ht_lock);
 }
 EXPORT_SYMBOL_GPL(amdgpu_eventfd_pasid_unregister);
+
+void amdgpu_eventfd_notify(u32 pasid, u32 event_id, u64 count)
+{
+	struct amdgpu_pasid_fpriv_node *n;
+
+	if (!pasid || !event_id)
+		return;
+
+	if (!count)
+		count = 1;
+
+	rcu_read_lock();
+	hash_for_each_possible_rcu(amdgpu_pasid_ht, n, hnode, pasid) {
+		struct amdgpu_fpriv *fpriv = READ_ONCE(n->fpriv);
+
+		if (!fpriv)
+			continue;
+
+		/* If render fd is closing, avoid signaling torn-down registry */
+		if (READ_ONCE(fpriv->evf_mgr.fd_closing))
+			continue;
+
+		amdgpu_eventfd_signal(fpriv, event_id, count);
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(amdgpu_eventfd_notify);
-- 
2.34.1

