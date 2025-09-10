Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C43CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 11:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AAC310E8ED;
	Wed, 10 Sep 2025 11:37:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HqV4X4zw";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F49F10E8ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 11:37:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcouI7Wz4zPR3ifsHagrwuhVV4pxl5q4ynRAV44RG2XEyZOxY9ctyifrKbk+rW2IzTVi6qPuc6KEjz8rL8DyZeFPDcYmRVyycbraHP3LMxE2eGzKTejKO/tAMRVQ7vx969TsVhCoiHTgPsMF06pxv4FrvN6+uBh4OJAoazRXpEY02+O+iRoQ0ef7PNfVdGW2vz3ZO6M4JxzOWQ3bE5UsAo1lBMmKhZpvLLztVBad9GjS3yoBJ/f0gYTMdtuTPvXWxQaJP5MBVxr53AS0otb7jJ84uIdEHwVZLxKc/Vm9oHFQD/e/7Y8+fX17MM3GyXOYm9foIoX3FNYntzUUBpC1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8g/D8V0Ydz6ih8G7C7IVdO6KBKrysdmGgTHIlLusUc=;
 b=ugcZ0Khs1wxcMxP0m11NmcfOG3JmDYbD1MqCEv+Oz/rpjP7wUK0Am9pZq7FPUXHztFzf/S2mqBwbnzlGy33FKQTmOE6I6a9nIYaDILhifQOOpZ9e8zeOPhR79eaCoVw8FQVvKqgFeoJK+mvlbUTRR+F/vMTaBXqILEs/I2gB6aK2MD3YH9nc89HCMmRktNWNyClEVy5M23IjPPYoVpkoOHnCRGuUJKL+mtN+bNeXKpxibqta07YFl58jws2hmQdEs60z5trWNFDCfrdcNsjZ3mdUf4++ejgLNL8oUaFbHiyvLZreP24WjqFB5P8fq93Fxgk8lTmWdtiqnoyJdy7Bag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8g/D8V0Ydz6ih8G7C7IVdO6KBKrysdmGgTHIlLusUc=;
 b=HqV4X4zwaEXMQ1jaw11uwefmm/M3gNMwXUI6+yRZswcTXxgFB2M3PzBP2bq7DR6vun7zXyo9ebP6zJITsQd9ujcru8M6PNv5z2dhsISiKGnCeGFsSicIiB719iJ50A0CuMrGdib4bi2EDdj7Ymi5YgsN11PJWppdaLGOxezoAcQ=
Received: from CH2PR05CA0038.namprd05.prod.outlook.com (2603:10b6:610:38::15)
 by IA0PPFB6B4D32F9.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 11:37:43 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::a6) by CH2PR05CA0038.outlook.office365.com
 (2603:10b6:610:38::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.6 via Frontend Transport; Wed,
 10 Sep 2025 11:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 11:37:42 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 04:37:40 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 1/9] drm/amdgpu: add UAPI for user queue query status
Date: Wed, 10 Sep 2025 19:37:23 +0800
Message-ID: <20250910113731.2688320-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|IA0PPFB6B4D32F9:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b98f364-791c-4c58-500e-08ddf05e7476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWRnNFV4dTBoY0xEeGlENDBTc01OV3RQZjZ0UnB6YnlPTlpBVEU0NVFlazNm?=
 =?utf-8?B?cGtPR2FETmo5dzEyYXVhVlhBVTNUZEwyRjc3NWpCZDJHTi91aERmbUlOa01H?=
 =?utf-8?B?aE1Rd0pqK3B1MVpFaXEwUHAzV3duR0ZNTkZsZDQ4aFd2UFNyRVV3UDEyUTFJ?=
 =?utf-8?B?TTAwSmN1YmhseEZ0ZjYwMW5LRFRNT2t0V2d5SFBEcThLa0NMMDZlOGwvdExs?=
 =?utf-8?B?bW9VOHFicVJnMmZGc3htaU9CZXJBYkZQa3FlQTRrWmVzTWs4UGZoTTU1K2Ru?=
 =?utf-8?B?bE9lWmFpQS9LeVl2MWJ0Z1NWZ0JONEVFbG16S04xNXg1T2YrdDFaUzhybW02?=
 =?utf-8?B?OVhLSnJpOThuMlVFbXcxblBzblRKV1QzU1A4N2tzQzU5SFNzak5wdHhqK0Fq?=
 =?utf-8?B?QWlJdXJEUFIwMU1rdDBDSDFaUVJTQ2YwMVJ4QlJ4MXJpS0pxbFVGcnNWNENM?=
 =?utf-8?B?RWtBSjRJaVpndVFVM3RRaUhaVXdzR2NkVi9id2M0RExzcTRQTlNVdWlzbWYz?=
 =?utf-8?B?UDY4K3hTVGV4Sm5Qc2krNmpwTGF6ZWVseDZxbmY0eGpBNFJGL1VxWmhFNzRC?=
 =?utf-8?B?TjdWOXFVWmh3U21GYzg4RzloZGFUM2hpK29BWlhIekNhS1F2Y290RXhFRlNu?=
 =?utf-8?B?MjFhMTJYWlJGVWRFRjArSGVVWnREVElJYzkrVnluaGI2ZWJaYThsczJHN1d5?=
 =?utf-8?B?TTlJWmQ0L2tjenAwMVhJWjNnWlptQWcyRjl6bmJhQWpDanR5MHV4UnNJell6?=
 =?utf-8?B?UEQ1V2Qvbk9uaTF1Y1RUVWRiY3dBVGZpWmJicHZGT2RhK0ZLemEyRloxM1Zs?=
 =?utf-8?B?ZDhFTFk4OXAwMm50SU1NeGJqYkI5TUxHODExajRsNnF5MW9QNFNvb1FRaFVM?=
 =?utf-8?B?NmVEYmFCRFdTNHltVndMZ3pHNjN5dGJuK3pld0FXOFc0SDhuWWZNQlF0QXhm?=
 =?utf-8?B?RVVFZmtIZDBTQjJ6NzdUZ1kvekF0UXhYczNFNy83aGwvNnBGUmM4WlY3QS9j?=
 =?utf-8?B?ZVNaUGUzU3h6ZjFjWU5rTGZlbnlsaGZuRWxLbC9TNGNLWVB5UEEybm1OVDEx?=
 =?utf-8?B?cCt1YlFBdmQ1dExIS3h5bDdsMnpydUxNb0VwRndwQ3U0WUF4VjFRSkZIaEpi?=
 =?utf-8?B?UlNreWh6cXFDajVYS0RUWjhIUzBvRWxuTlZ5T0JEUDk5NUcrTFVndkJyQkZs?=
 =?utf-8?B?WEwzamhDVHVxRjI0TW56MGtQaTNlSE9iQllpNTJ5cHd4N1ovbExoTmtXdHRi?=
 =?utf-8?B?QkYySTkxTkdqM3ZITU1RZG5BQWQ5MHJ4ZWxONkdyYXdNZS9NcUhRSk5yV0dI?=
 =?utf-8?B?VjFnVWRSYkcyUkdzUjVycUQyWlJFUEpKM0lUeEtmQ3RFVW0yRlIrWlhQb1Jy?=
 =?utf-8?B?QVVmNkFML2RYb2p2VDhiajFqTlRLM1hSZU9pNi9SSTVsRDF5S1g4bStrcXJP?=
 =?utf-8?B?RFRubjRxMkhzTUc1N3hDNzlHd0s1Tk1FY2tUeW1nNG0yaGVEdVZOWVYyYVEx?=
 =?utf-8?B?RmdwNUJ0bDJML25VT1dlbkpQKzhMUDZPeWY1dDc1NEMzdXRzdnhSMk9Nbm5i?=
 =?utf-8?B?ejYrQlJWcU84dm9jK3R3K3VMSXNETWtaT0c3OHJOZ1d3OTR1S0J6ZGc2Q0xQ?=
 =?utf-8?B?T2ZUQUgydno0S2JwL0dkLzBadUUxbTJTdytqYlpNemNCcEliRzJXclZaQTdr?=
 =?utf-8?B?ZnhkMi9hVVNBN2tkVmRWZ25jbDBGYVFhNW1PZjhhemxIODFUSmlRMXpZRFBp?=
 =?utf-8?B?Mlg0eHV0MDVMczM5aFRDSWZ1Z3BnK2wrU2kyeWFqU3d6Wnc5Vm1oL2xxYVJw?=
 =?utf-8?B?US9Ydk9kdlpPZ1hTcGZWV2xpUThFaVliaDFvYU9NejVhQTJ4Q09FQW1Od3I0?=
 =?utf-8?B?cTFKNUJPV05jR3VSUmxCYUtrQ3A0LzdoN2ZhYzRjRXUrcWxRdTg1c21sSHJU?=
 =?utf-8?B?alZXak1jYm1JdGwwdUlSek8zUzA0QzdoeHFQWmRDdW90VVZnUGhIRnZqVUtr?=
 =?utf-8?B?dklWS2toS2t4VFg4TnZ1TUlGQkFFbmpnLzZRNWI0L1BIVi81eTZIbEt6SGJU?=
 =?utf-8?Q?HK0yVb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 11:37:42.7420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b98f364-791c-4c58-500e-08ddf05e7476
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFB6B4D32F9
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
index 85b3ca14f81e..7292f7bfcd13 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -334,6 +334,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_QUERY_STATUS	3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -346,6 +347,12 @@ union drm_amdgpu_ctx {
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
@@ -427,9 +434,16 @@ struct drm_amdgpu_userq_out {
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

