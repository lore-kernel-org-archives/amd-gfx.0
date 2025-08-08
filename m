Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A26C87FDA
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 06:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CFE410E4BD;
	Fri,  8 Aug 2025 06:29:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0xoF1VDY";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB5FE10E4BD
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 06:29:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNaWNOQdtMk6ewPDFyGFtTur4bkYdVFXmCGWDFq74mZ5enpGW1xQDoYWxZWHWdkrfrdrCqCH6KqTJJDE8FM9jTln6CWPr4XOzo8qn+EIWLFda8HlJK5fxifFs8mzqj7v9AUs7J0JV0fsg3IjSFmglltvEjPWuDCUao/S4lEvDcBhY/FVs/mb94dgzjk1rSlD3ISQg//RbChlP6wyzdBAkmZb1QAhhS8g2O7MbPBO5a8IzZf3u7eZKJGuQFM3Jr0S2EvhzXMHDoGtGsSAOZOjAURz9lz5iRMnLwP197q+qfLurf038LX43pqH/Zmzeyphv9QHVw+7PAmUhUt6Xd6rqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1fk7IvWDpjA4DYQ4bAb8CBPHtlxFvXxgh/8ppQqu/o=;
 b=XAtF/9k+RxFB33zGaKrNm1ZghBTLlhN55ZeXRU4nDNClkEf5yai842um6ugxTytESmGgUkfUf5rBjNIJtAT/JUCChYiu0WclPExw4VpmSkmuC3PWPo2Lr0VjX2nPyZ3vBbDLcsxasRJwQIoyHzyjDW9U5HeCkzyOZATLOUZN5PbaQVGPYS5Q8EQH9pzpdrhXifh28vDw4f47V8o+0tBnJnOEm9xtSc+P5TeAGPkzWLUguy3qi4zifjgTgGvbuabK404+BWv7aKoro7Wshr2tZoYmTVccN7FIHW0oTM8rRwHHzxh4sKY1epqoD7vuN3ayhV43Tkc5MmSkEGVIy5Jx0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1fk7IvWDpjA4DYQ4bAb8CBPHtlxFvXxgh/8ppQqu/o=;
 b=0xoF1VDYlxXRWwyEPxJDGUicayCNTxyG1K09t9iPcGmP95L4oEWQsX7w7pZzJMxI2Sl55+1oaMT+lEzIYaB3jDCav5tR464iawxM5p7eqOGh2u7Ie78NYAzKPwTh3clsxTXxzKkHc5w/cXTzkcqm45gjHD9l4+aEQCy2KH4Yu00=
Received: from SJ0PR03CA0339.namprd03.prod.outlook.com (2603:10b6:a03:39c::14)
 by PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Fri, 8 Aug
 2025 06:29:35 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::c2) by SJ0PR03CA0339.outlook.office365.com
 (2603:10b6:a03:39c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Fri,
 8 Aug 2025 06:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 06:29:35 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 01:29:30 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v8 03/14] drm/amdgpu: add UAPI for user queue query status
Date: Fri, 8 Aug 2025 14:28:59 +0800
Message-ID: <20250808062910.1613453-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808062910.1613453-1-Prike.Liang@amd.com>
References: <20250808062910.1613453-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 40914c4d-1741-477b-9cd3-08ddd644f179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlhvQ2dUbGpWa1J4TElOa3dKbVhBMmhRRXFIbGFoY0s0WEx3Qk4zc0JkS2hx?=
 =?utf-8?B?MDlLM3V4Q2grSElnS281amdRR0FJUHdPOTViYXJ6L2dlNGJjMDBld0xYMEZK?=
 =?utf-8?B?M0wyaVJraFkxaDQyMDdxNlpwKzdGT0hpdzhPWmNQUU5UdFVQTkJ5aGVoN3hw?=
 =?utf-8?B?WC84TUpUY1NZdDRhS3NjZGNoNGNBVlY5bHFVc3lGOXh2S1FBOW9ZdUU4MHZD?=
 =?utf-8?B?eVdYSXZNVzRvTzdvOEpESzJOaVVEbXZGcXR1M1NCWkUvTFMvNnNVUWwvMXRo?=
 =?utf-8?B?LzBVeXlBQ2ZQeXhmcktxZTYwYXNua1c1bnUrNGdvOHFVY015eUpZL3VKUFM5?=
 =?utf-8?B?d3pZekdGVzVwN2s4U0hYck0wenU2WjdkS1JlTndnOExsZmxHaHdNVDVqNXBB?=
 =?utf-8?B?MElmV1FiKzdMVVBMdDJOQ3ZLQTVabWlkRWlkM3JNZHNCY3ZDcE4rZTEvMXVK?=
 =?utf-8?B?bDJxMWMvdzRWQWRIUFJReWEvckcxTERPanRSdHNTRTdEc1VMWStMZWRuSk8v?=
 =?utf-8?B?UzVEVGpSZnhSSjBTOTkxV2R2OWs2b3NTOVBrUXVyRjZpcWttU3FaSnU3YXQ1?=
 =?utf-8?B?YWRVV1V4cy9hRTk3UVhuc2c1dU5KYlZCNnN3ZkpQYlAydVJ3OXBpQWh3UlJW?=
 =?utf-8?B?Mnk3b0pGd29mNEFkeU04MWsxMVNQMDdVVW5aQ0FscjZxV2VZNjBvaDUrZnFi?=
 =?utf-8?B?cU1adTlZVmF3VFgrVk80cm1QU3pBUHRqa2EyTkRuQngrRG1ZcDdpcTFuTXhR?=
 =?utf-8?B?enhmalBiU2ZiQnUrNEw1NHJOREI2R0wvUXNmdWwxcjk2cnROZDM2K3lsYlc4?=
 =?utf-8?B?eGpNeXpBT2xoR2xGR0xjajg0MEtET3VYVUJKaE1PSVVNWGFDVUdkaktzblpW?=
 =?utf-8?B?a3hXOG1ZS1pvaHh1REZuZjBxNU0vVVpWWFc2RVZmQ1R4V1pNK1Y0Wk94eHFP?=
 =?utf-8?B?aFlXdUhYNmhwemFIWnBROXhaWHpMYVhNWHJXQVN2VW5wYmtqaFJoVnU5Y2dT?=
 =?utf-8?B?ZzNCVmtDbmVkQllxTnBPai9nOWorTXp5TVVEWUp6YnU3TUlRcGJIQVZmMHJC?=
 =?utf-8?B?K2dXRElHaDZOU3ZVczJYb1plWGVGY0R0ZjFFZTRuM0VLV04zNWNsYko3cS9E?=
 =?utf-8?B?dVRxME11V2pMdHJrSEdVbUNmQlFPNjVUcDd5OVl0TXU3Tk9rNENYbFlDWm53?=
 =?utf-8?B?dSs1bldIbUs2cEkvMktKakIvUDhaWkZhUVdQWmIzRnNhUm5RZ3JzL3Zva1JV?=
 =?utf-8?B?QW1jL1JPNVJpalN2WEk1VXJkNjdUYkhpcDhHV3Bkd09ab1hrN0RQK2p3UTBn?=
 =?utf-8?B?MmtFQWJIVEVDYWE3SFhDQmpicnRxNFU5NFRYZVJxdjlGeURyelZLWXJWSU91?=
 =?utf-8?B?Wm1XU0MybnczdC9VaGdlc0VPRUJYNmc3aDRkb1g4cU9LZ3JRVGxjL1ZDZ2tv?=
 =?utf-8?B?OFBMMW1OalBqSGVkcldEMzY2ek5jZWRQNnk3TnR5aURSZ0RyWE9BZkIzTW9q?=
 =?utf-8?B?SzduV1k4WW84RHVnSkt2VlV3cXRKMG5TdlBpR3JiTU5HVXE4eEdWWS9HYW5M?=
 =?utf-8?B?bEpzNlZXVCtVQ3dEM0Y2UHo5R09QU05FajdwNk4vemxxeDhVWG9OWlJ3OXVk?=
 =?utf-8?B?QkdIY1h0eVB1TDVPeEFJQkxWbXpUd0tJZFUvUlBreFhkd3RRODhJNEZ5ekY0?=
 =?utf-8?B?NXAva25FaHI5KzRmcHF1VFpmM2s5c3JuQ0kxaUhUTTU0RGFxcWhxcGxNa0l4?=
 =?utf-8?B?UHlNbGhwRU55eXhCeWFuaGJKQlRhcGltS0dIT1p3aEcvc2xISjN2Mm0zaGgy?=
 =?utf-8?B?TlplbklOSVNqMFF1a04wNkZKNjcraWpqL0Z3V3JQeDRWQ1Z2NGpVL1lZeWFl?=
 =?utf-8?B?ek9LbytNU2ZTeXZRSW1OZUMxWTdSVTZ0eUx6RzFLRmRhN3c0a0tyTi9WSldS?=
 =?utf-8?B?VGZaU1dJbVB3Z0ptRS9qb2dLcStrblBtSHQwUHB4dVNuQXdRU1EwaDR0amZD?=
 =?utf-8?B?eEVEQmZYS0ppVDUzeWhqMEdQM3I3bm1YUlV4TVJyOVEvdmNIejFPQ0lJQXVy?=
 =?utf-8?Q?3V6NuP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:29:35.2537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40914c4d-1741-477b-9cd3-08ddd644f179
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160
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

From: Alex Deucher <alexander.deucher@amd.com>

Add an API to query queue status such as whether the
queue is hung or whether vram is lost.

Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 66c4a03ac9f9..efd0d2356077 100644
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
2.34.1

