Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0673AC3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 15:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C150F10E6F7;
	Tue,  6 May 2025 15:59:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YKj2V+Fj";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 497F210E6F7
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 15:59:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9q4k58nQZbvHx7xBlp2zeG0flz6kidReiE0cfIKQFQKhmPBbbvHxVai65KROubeMjceFoUV8tiP/pzkmtIXY9KxNwHcb8I4GHZ5wQXHRp3/M9XwHS55AQfkSyTykMZWzOBe5JnL6OTWGosNHN3T5ZPajQp9chkdYuLaPY8CwDWkcz+ja9h7lbCaWJj1YyW2PWJon2ndaIjZyZSgST4KNucIn0L94lqEMzbuixS14viK/tLgpaIIYqPdhLSmwOZFcvWNaLHsmaJ7bM3/BvVbZl+4UP9YfOi6jI8SR9PUDOPhwecXB22thbWzPxQmEV5B8dMG0y7fKA1hpwhqJGGKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Z/f1QoyNQx0gidRR8XxecOFqsL6JUa6lHwH4+H5SPY=;
 b=P7EzLSRTi1TkAdFAMiHx8nEIVYNPer4CE8O7P1pj/fdDQLXMfOIzFImHpbuFOHkjscGHBiaECpDXtOdFwkxPu9MFmPela/c7vv3hayHal9r76BDXqnB4KDdtQkWxhsiylxhW8JzAmWdPUda1SIcucNQs0/TaTN4JoevgvDc7x5uxl8O6a/l1NTXgjrLccoeYkNJV4ptTS7gXwC1aPRfTrWHfOKTf5HWmTn3mny1GJvjFknVxwOoea6F2csdun/SLQeiXAzysG3qVqHzlZ6/6unxmh7/e7bGmSYL6zOPOY6t0W78A1dNAp94wM/d5ukmfKjVrxhtjfYcyVHlTO2KD9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Z/f1QoyNQx0gidRR8XxecOFqsL6JUa6lHwH4+H5SPY=;
 b=YKj2V+Fjc2yHN/ifkMJoU4GeldsaWLxStg/RfgyTsChoHRQWrFI8eKw34BW7yKNyeX7fKyILmHyegx0OWbb0r3zA+Hr2B0CvrsjS+iC7lMVi1DZIpruyaODzYl4MjkIiH6gkL4tiViBEQs2cOyhwmj7EGDtn3IrnHAxcP7u6T8c=
Received: from BN9PR03CA0240.namprd03.prod.outlook.com (2603:10b6:408:f8::35)
 by CYXPR12MB9428.namprd12.prod.outlook.com (2603:10b6:930:d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 6 May
 2025 15:59:18 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::a2) by BN9PR03CA0240.outlook.office365.com
 (2603:10b6:408:f8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 6 May 2025 15:59:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 15:59:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 10:59:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: add UAPI for user queue query status
Date: Tue, 6 May 2025 11:58:58 -0400
Message-ID: <20250506155900.3866874-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506155900.3866874-1-alexander.deucher@amd.com>
References: <20250506155900.3866874-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|CYXPR12MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f15cd4-dcd2-4bb3-c313-08dd8cb6f556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXd1WUhENW5FTzh2eU5MK25wTEpvTlF5OHJOM3p4Z3JoRm8rQ2tadzVqdkov?=
 =?utf-8?B?M3hhZzRoREpZNHZYOWtVZUJtazJQcmhNSE1jVDVIOGpub0FKMHpPYS9zeThH?=
 =?utf-8?B?TWMyNlJMMnJOS3ArbkFyUXJpSnk3TW1PeXNCYVppWm1xODY3UVlPeCtmc0RH?=
 =?utf-8?B?bXMvR1VRZ3ZCaFFjUmpBR0pJNGY2dHBWTVZzM2IxNTkzWkE5WllCVnJGVXZR?=
 =?utf-8?B?UnlNLzQ3WFYrTi9LU1VTTCtzem1rN1VTL1NxUmZkdU91QWdDMjM3QXpOL2FN?=
 =?utf-8?B?d08rWGlpMFcvS2NSTFZvTTZiWEtjRlFTRnBEU2IvUHNXV3FudFMvRjBsZ0Zr?=
 =?utf-8?B?K2duS3RCOWZsbThqek80czd6L1M1MjRIdmhzV0tMbU9QZkxvLytudEZGNjEz?=
 =?utf-8?B?OW11TGpaYkhsWmNWUzljOGhYcVZPSkRMVGFzTWY0Q2lXUXUvb3JZSTE3eGhK?=
 =?utf-8?B?bTdMVjk3SGhWcU8yckVtWTh6Ujd6dzFpcVVWN2lnWGFRK2RLVGpkM1cxeGZv?=
 =?utf-8?B?QXYwakJVMGQ4L1gzZ09XSGtvbjVQMDJqWDh2SFhQRGFvWmthK01UM2dua0RZ?=
 =?utf-8?B?bmlva3A4UHRtb2c5aGRUL0ZhWVpyUzRMT0pGWndEcUdDUUIzYVBpaTZNdi9z?=
 =?utf-8?B?SkFLcVB4UnZLenZ3akRCVytSV0UzWTEyVmFBRy9DUjRmelZQZHBvQlk5T2N0?=
 =?utf-8?B?M1dOTkU0WGNubExrUFJsWUh2Qzg2azV1YU1PQk5OSkFZY0ZlQmxjK08xK0xC?=
 =?utf-8?B?MDczbGNRZmNqRWRMTEJsMVloZ0lCQzFzQmYzZW84YzBtakVEWU80clA2ZzND?=
 =?utf-8?B?YTFZMGZFWVkrTFl2Q2diUWY0RkM0WGFWWUs0cTFSbHVSeW9SRVdaSkhwdEQx?=
 =?utf-8?B?T1hvNjNsT3dDb005YkIrcTFaRDBNVzNTU3hVRzhoSWxNRGo0MkdoeVAvQzZB?=
 =?utf-8?B?b1dDazFQVk5mZ3dwQkZpV2lTbDdBUzRhM3JYTjNqNFVobEpKRVlCa1ZJL0FZ?=
 =?utf-8?B?ODFCZGZTYVZRd01idG1TZm1BUXBoY3B0UkpHN3BmMTRxcFJhZFV3ajJLSFBN?=
 =?utf-8?B?YlRhMUxjaDFTSEcwb2FieEd3SnpSanpEdllvV0JySWQxdWxONm9kbW1EcmhG?=
 =?utf-8?B?NHpEaDJLRjZ1ME5sQmlHa3dJVURzblR3T29sM3UvMUNkeVNYVTQzRTdFMGlC?=
 =?utf-8?B?VzVjS1Q4cnR0a09PajFBbXhESHpNbzRsMzFyUXFPanpQdUNYYWIvaFNyLzRY?=
 =?utf-8?B?RzZNelhuaDVJbFQ2KzJUMDAwNmlraGRCYjZkTSs1c0FDL2JpazUvTFBacVZZ?=
 =?utf-8?B?MzdUd0ZCSytRZDNPNCtFVVJXVVZWai9zK3RMbTlHckxydzJzRG12RmNKWUFt?=
 =?utf-8?B?WUl5ZUROaGlYdFUvaUxwdkNETXYzVEdscUlCV0d1Q2NRVStqbTAxQktuUVZw?=
 =?utf-8?B?QlQyN0x6TEFRY3ZBVVJwY1BLSVBvQWZ6b0hETXhacWtKT2w0aWIzS0JNdnJC?=
 =?utf-8?B?V0NVQmpFZVBHeDh0L3hGdHZham1rYXZsUmxwWTV6MDIwcVdZU0wzYjh5NHV1?=
 =?utf-8?B?WHNnM2lJempuTng4dUdDU1hGNHI5aURLZ2JJaGFOaytHU0NZV2ZVbXZoMXg4?=
 =?utf-8?B?UjMwcURwRjA0UzJxWUpDTUVnU3JUbk5aSWlra1VOZ2NoWHMzMFB4STI3bWxh?=
 =?utf-8?B?QTZjZ2J1aW9UVTE3RFB1L3NMQmIrcXNEeHhza1JNYmNBeVhMbnROekFzV0E1?=
 =?utf-8?B?WS9USjJMU0FoMVA1OE1wdERraFJTd1RwK1ZURG1DRE8vbDJFK21XNzQ3TUx4?=
 =?utf-8?B?Q2FEc1Y5UzFQL0VWS2ZxL1lVSDZUVUVvWnhvTzE5Q2JybWgvdjdKQ0JVUTRl?=
 =?utf-8?B?V29tdWl4S1VMVWtCVmJXaTZ2MEdKMzhyU1RGQ0l0VmtyUFlESS9lZEZJdVhK?=
 =?utf-8?B?Z2oyaXFKbWMwU0wveWZrdnZCYlp0MElUdkVJRW9yell6TCtyU3Q0Rmkzc0Vr?=
 =?utf-8?B?aDd3aFc4K3lWUGkxYjVFWkNpOFhibU9mVXRpL25wMFAwTnZ6eEZ0bi9BSWV3?=
 =?utf-8?Q?z5egBU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 15:59:18.4065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f15cd4-dcd2-4bb3-c313-08dd8cb6f556
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9428
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

Add an API to query queue status such as whether the
queue is hung or whether vram is lost.

Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 1fd96474e64c0..56f052a10ff38 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -328,6 +328,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_QUERY_STATUS	3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -340,6 +341,12 @@ union drm_amdgpu_ctx {
 /* for queues that need access to protected content */
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
 
+
+/* the queue is hung */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
+/* indicate vram lost since queue was created */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
+
 /*
  * This structure is a container to pass input configuration
  * info for all supported userqueue related operations.
@@ -421,9 +428,16 @@ struct drm_amdgpu_userq_out {
 	__u32 _pad;
 };
 
+/* The structure to carry output of userqueue ops */
+struct drm_amdgpu_userq_out_query_state {
+	__u32 flags;
+	__u32 _pad;
+};
+
 union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_in in;
 	struct drm_amdgpu_userq_out out;
+	struct drm_amdgpu_userq_out_query_state out_qs;
 };
 
 /* GFX V11 IP specific MQD parameters */
-- 
2.49.0

