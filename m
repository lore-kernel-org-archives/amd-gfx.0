Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB06F606A31B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eERDmeMq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6971B10F59F;
	Tue, 27 Oct 2026 14:20:57 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013025.outbound.protection.outlook.com
 [40.93.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DAE110F5A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 14:20:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KX4zJvIT7fM9qpsDnXQCV+KZsKM0kPc/gH8tEiLiEyg9WChDIgBsO2UhRQkAjBMno35fsX5NVLwp1+c2jQwica9NEzhbKQPrjJ9vMVympM83yVYESz0SG/7SMj/Ds7vD4LHpLaN+GREI0VItBc1U86iw5qnDUmo0FfrNtvHqN+T3Ioq00MjfO2pLJEpJkzmUPutVrIrYAxnzlI4Q1lT5ngKcJY5mNVnyi/heyTVhcYChw69XoHvC2hqCm45Nnczzjv9s+5tHBPjCv7xXH6h7Nl8y+aB+yAGO1twNoibJYrPp8uLck0B+Z1nNYFfNbnJaQSAOp6xS+gSqcQ71h/7lNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBVqLr3rcPirY/xF8WapC4H8sBk4L+CuZC9j1XPcuds=;
 b=SCixEWeXpRnd3p05T8rPVh1vHJxEtSET69pG9Wmsj8+myiTBZ7nAgr8UefqYHIVlZg7l/8Nrhy1Yy/TdiKGnFNhstwDs6gw9drGFj6eW/xGHxMiCgCPNxLuqEDRos2p9NaIBeXebMN2GrcGK/BPb4VWSti6170gMQ3U3yR9UbGw8jZajhNmHaxhMDLr2K/2A+RBsLKRAVBCF3DuVNAC4KX9/N7xc9HoELrXRcv1bFcPo9B+6YKaE7EnEbr/Xp0wIfxCiKJh12pjtJgsBi9ltRDOPA5kPuQ1AJEoIVFaERZngZPE0lCyuK39UuU46HRNFGS/XB9O+7cVouy5FQ7Y/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBVqLr3rcPirY/xF8WapC4H8sBk4L+CuZC9j1XPcuds=;
 b=eERDmeMqL7As6IvzdpUA4TMKyXhAQqGUjPnC2Qbn0lvttAWxcXTxbegA3ot22oOAYZP2n6KI2wTgJENw7CLY6RUh4hmsiZhj2ziaICwdvu+bCnmyoCiHoCy6DOyuviudZjGDGLx8N1i8VcB1FxMWs1PLjFkSn1Weh5gIS+8SVno=
Received: from MW4PR03CA0242.namprd03.prod.outlook.com (2603:10b6:303:b4::7)
 by IA0PR12MB8908.namprd12.prod.outlook.com (2603:10b6:208:48a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 14:20:48 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::3) by MW4PR03CA0242.outlook.office365.com
 (2603:10b6:303:b4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 14:20:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 14:20:47 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 09:20:45 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <arunpravin.paneerselvam@amd.com>, <christian.koenig@amd.com>,
 <kent.russell@amd.com>, William Palacek <William.Palacek@amd.com>
Subject: [PATCH 2/2] gpu/tests/buddy: add range-biased allocation performance
 test
Date: Tue, 27 Oct 2026 10:19:25 -0400
Message-ID: <e544554daa5353cf83c2529f49ff01fdc97f034e.1793108566.git.William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793108566.git.William.Palacek@amd.com>
References: <cover.1793108566.git.William.Palacek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|IA0PR12MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: 340e528e-c96c-421e-84c6-08df34357efa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|261009223027099003|261021121427099003|261021123027099003|10067099003|56012099006|22082099003|18002099003|261026121527099003|11063799006;
X-Microsoft-Antispam-Message-Info: rhLBFEBwAyEvyOQmJYwbnb/SV1KqjLYLmchtDLT5AsOWYDn8QnJpCZLhNXQsN15nOUJtt/5XqdcShu+3Mq3LwXEOGHua1ROT+IlJ6vvRc6FrWt4oCzM55rZxWco8fG0C76NqCMWvUWuT+ymdAS+VrBJNXkjsx4aV4tItyuJeKS5pWK+McALewEheT5pVCLAHlIjWY02263qHEjfmcstQNsswgBx5GJkUeGrsI0pfsmqwK0tGljzVrzEaGWnGFwTaOGvo85vPJ7LsSE0f35oLfCTYjxmA+5yDijFcoYosw4e5jQ0gM4udF0Gx9dSXAlDKomjO68QOz8lb9wKseB2tvJxaI5dUDYhk+Q3QGEIeMqr4kkUF6eQ1pAz+vAwTNcNoAoKTbrhzZDyXLje1hLwM1MCze9+hZ6U8y2QXtekMGZECaXZd7/Nectir0aBNQa7ZgdUNlEn9paTFNmP6X6NIdjneF6a31HgUzL7fOq+mYhuoLHXkENCaO/9zy/qcC6XIldJWwLNUtqYLqX6ZC5r5SRpyW8MIb5kY5bdo9XIAoSNkKz3jkqtOE/y6DV2CqZa5uRlsOgVtIyKck8LaU1BF5QhwGPxiA1j0dwRk2Blzd1lh5A2OOhkuQ2M9vlEqVQxzp0bZ+2qfNh5y6mHNOpAGKnSiqp8+D5y6HtdC0SDvjvoCOG+daYqGxP+gCLuU1Z4UG7m4Ia1nDphqQxpQNd39kA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(56012099006)(22082099003)(18002099003)(261026121527099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V1lS/f3OK73WmarT2ZsHguytcwmtXS7KNryew15wNR/0uGiw18Wh1efD+WpnvJlMmH7NmMcR3b8uLo0Y+z6nHcNGRvmWUGoPFKP0PV0oSQxoWWP3CxGEFxp8ELIhd3V929ba9r1ra0kpQUHdOw5BD+5xt7okMx/A1Lttg9Q3bf/yrkwKCxx1IteZnJ0TGxJ8urZr/AeB8Obc9cH/kTe0cV/Qu3aM7t4kBFTRykjKdLL+maw0nMOmYb5m5PVrVCDCCkxBy0ZWLpwJO89vGP6NovHEm0/woDMdYFsZeyAIVtdrYmhy2+p23g0aIMryqag0ktEwST3tcaeIDiQwS6BKmxm+YLuvQTgZZ0I6SSPYijiu6V6r/iyVBu+JtD1ZIo0ZhhAnbIkpV+Mxk1tzKn2e0hbfXyVxWRe8iNPxXoLEsiRwYGYZKtf/jJWZS770ew1+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 14:20:47.6848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 340e528e-c96c-421e-84c6-08df34357efa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8908
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fill a 1 GiB range of a 4 GiB manager with 64 KiB range-biased
allocations that request cleared memory, as amdgpu does for KFD VRAM
on NPS4 partitions, and report the time taken. Before the previous
change this took about 1 s because every allocation walked all live
blocks in the range; it now takes about 2 ms.

Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/tests/gpu_buddy_test.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index 4d288f58fb5c..10b4fab2407c 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -289,6 +289,30 @@ static void gpu_test_buddy_fragmentation_performance(struct kunit *test)
 	gpu_buddy_fini(&mm);
 }
 
+static void gpu_test_buddy_range_bias_performance(struct kunit *test)
+{
+	LIST_HEAD(allocated);
+	struct gpu_buddy mm;
+	ktime_t t0;
+	u64 i;
+
+	/*
+	 * Fill one NPS4-like quarter with 64 KiB range-biased allocations
+	 * that ask for cleared memory, as amdgpu does for KFD VRAM.
+	 */
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_init(&mm, SZ_4G, SZ_4K));
+	t0 = ktime_get();
+	for (i = 0; i < SZ_1G / SZ_64K; i++)
+		KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, SZ_1G, SZ_2G, SZ_64K,
+								SZ_64K, &allocated,
+								GPU_BUDDY_RANGE_ALLOCATION |
+								GPU_BUDDY_CLEAR_ALLOCATION));
+	kunit_info(test, "Range-biased fill took %lld ms\n",
+		   ktime_ms_delta(ktime_get(), t0));
+	gpu_buddy_free_list(&mm, &allocated, 0);
+	gpu_buddy_fini(&mm);
+}
+
 static void gpu_test_buddy_dirty_tracker_performance(struct kunit *test)
 {
 	struct gpu_buddy_block *block, *tmp;
@@ -1612,6 +1636,7 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
 	KUNIT_CASE_SLOW(gpu_test_buddy_fragmentation_performance),
 	KUNIT_CASE_SLOW(gpu_test_buddy_dirty_tracker_performance),
+	KUNIT_CASE_SLOW(gpu_test_buddy_range_bias_performance),
 	KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
 	KUNIT_CASE(gpu_test_buddy_offset_aligned_allocation),
 	KUNIT_CASE(gpu_test_buddy_subtree_offset_alignment_stress),
-- 
2.43.0

