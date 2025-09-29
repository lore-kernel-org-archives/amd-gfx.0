Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090B0CAC5B0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Sep 2025 08:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A575C10E3B7;
	Mon, 29 Sep 2025 08:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JUkuIyZt";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C42410E3B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Sep 2025 08:10:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szNcqR+LXhZH093RHfACMIWavs31kB3sDf7vOrVkJxGY89YPob9ZiyCkwhPVR0qajegHoA2qBo7+cRY6JIxAewwWocH89CD0RHOYHGWOMWHGfftHH8AUwQB0YtIpl3pxCAR6SkciXehUWTWWSmTmgTy3aEPcUwj3nfYHaGOG4ICX2jax/m+icZOrt3FZaTDCiIzMzOgM0HOKvG6E1XOlm4K0DwO0tkPTE+r4keAWhD3LAxRT7W4Q7BxA44HAuBTxdy4hWd8ANb+JZJ0smoUBU+2+qykenKeEnMQrd/elYVRYk10zy7QSsG1xUh8v3HLOdmjrLbsFwYtwHCG5PdDOFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42YJ5qRIbjboPgr9JRRxkdp6WASJV8q1ovo55/Nn5uw=;
 b=bHXoGtHpDanTcWf34XctCtikMrGo9XzSk9vOIchPguuzF8H4jcyH/JrRUX8lyP20Wjj3lkW+JCPIy9gKe+eQW4Rzy2Ab73zgWzXZ/DYYh/i5hxpK1fxp+cVKxaxPsGEx548eJqmhILMJEbZue3S/1XquLwEeTLetAtqgGawY2JOc3GWc4WRe1MK+IAAy2K5GlSATO1ClV/OC+yjZHIO8y307iSjlnUARR99wzhX4eS/jaom5xLWUjm900Bby4n4wdp/sQm/3KUCViyVxlSQf6kbeMvg7O40zWgLbm6r5sniQ8nqAlw8nuGOvOE6pXrQLO9XpGjfowEIVBRv73VTQ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42YJ5qRIbjboPgr9JRRxkdp6WASJV8q1ovo55/Nn5uw=;
 b=JUkuIyZtySXnMHJS3yShGXqbVQJq5qLIAs3WKdBagsNrE6ChGupdVpymMIzFjRbv7nVhW/TLldBbStDveBl7aQZvk21yVn3qbLVWsKZr8xBTxmQQVFI/OzIHI0EXa4H2jV3ad+NZoNk0WUchD5MFSVwVi/p0pOCtoGidCpzsjf8=
Received: from BY5PR04CA0012.namprd04.prod.outlook.com (2603:10b6:a03:1d0::22)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 08:10:11 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::b) by BY5PR04CA0012.outlook.office365.com
 (2603:10b6:a03:1d0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Mon,
 29 Sep 2025 08:10:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 08:10:10 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 01:10:05 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v5 7/8] drm/amdgpu: add UAPI for user queue query status
Date: Mon, 29 Sep 2025 16:09:43 +0800
Message-ID: <20250929080944.2892809-7-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929080944.2892809-1-Prike.Liang@amd.com>
References: <20250929080944.2892809-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|SA0PR12MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ad74f8-76e8-4395-edbd-08ddff2f9c50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmZJNUsxcGxVTWZJclZvVWNxZFBJR1M0ZmVlTyt0OGVWUzUrVXROekpaaDd2?=
 =?utf-8?B?aC9MMHdHdmozbHRiUW9BZlBENFpQTlRZY3lyeTNuckYzVEcrQnhpWEtNSjZm?=
 =?utf-8?B?bGJxRWdHSzRvc0x2eEZsVTlRSGsvR2ZTUGo0T01WRGFmVG4ra3Nndm9FcTVV?=
 =?utf-8?B?dE1NRWoxU1I3L0lQcUxXejZqSitGakVacFM0cUtVMDhhUkdpNDRQZzY1cjdN?=
 =?utf-8?B?aDVZOXNrTVpXUlNSZnhhVFp3ZDdvSmtLcFpXNnVMSFlsczRQNmxQSmxReTVl?=
 =?utf-8?B?WDhESzZ0RzZ2S0poUUVZRWdmYzJvK1A1VEtwYnA4SUtFTGFkN0lsUWpmZzhu?=
 =?utf-8?B?SkEvOWZyZVJxemxNYjBjOGRtdHdlUTEvWEpLL2RobXJiN21QM1BUUngwdjhW?=
 =?utf-8?B?VWovdkc4NXhza3AwSDFZQzZSWEMza3lTY21sblJRajc3MDdpY3NhbmJDOENr?=
 =?utf-8?B?VkhFaFRaWVJXaVQ0bkpKcXBXZHU5cjFJRFlGekEwYXBZdjA0OEpMRW1vTlVj?=
 =?utf-8?B?WDdnZlNjd2xDVVVrbEtNRXh2RGlaS1cxZEhIS0w2TWxHMURJaTNHSHRsVit6?=
 =?utf-8?B?OFdnM0lyOXRXTGFVeDJNb2RDK0ZVejNJd3l3R1ZvWkJ2QU1SWTFOTk03dzdN?=
 =?utf-8?B?WmJsT1UxZEdOYmtpOGVMeEhYUDBUS1M1QklCVWh3MXpQazZZNXJ5ZVZsaW9O?=
 =?utf-8?B?RWhDK3Z4YWdCcm5CRHVHUGhFSW1oRjd5RVdGUzNEQzlzeDRVNFlZTjliaWVU?=
 =?utf-8?B?ZkNKZWpESHc0eVVIRithcXprMWNVSjJ3RVY4QlJtVDlYUkk5MDhUb0hKUURu?=
 =?utf-8?B?bDdaamdHVk1LbmFhVzRlOFZrTTIreGlWc2JTOEx3NVpJQTR5anloS1N2bFlt?=
 =?utf-8?B?RHVySHBzTjVTMU5Mc291MmQ4TGcyUUl3L3JiSWhIaEhKVEpjYSt6aGpKbldY?=
 =?utf-8?B?eHJnODJCQ0hFYWZsbU15bFk0VG9UMi9tVnlQSlJuMWZvUmN5WVVOZ1Rha0Ns?=
 =?utf-8?B?MDMxSzFsYk1NMGwwcVd3eGEvMDd2VVhWdWdXUXQrZGMweTREL0o1QWpjNlVI?=
 =?utf-8?B?V0NxWUNLSDUyUW9rS1d1MzlNaU1FSW14OWZ0Rmt6ZTYyeUdXUHFleUc3Nkx4?=
 =?utf-8?B?VkxmbE1VS3RUSmNYUTZ2MUhDWEZ1N1RRWjh1T1lXS0NDaEpWd2xFQmZleUdL?=
 =?utf-8?B?V2g1VWpOUDdjREY2N0VIaDY5WGxCdmVjUGlBT1VXdzVGUTdHby91RHdoTlNG?=
 =?utf-8?B?N3AvR2NGNThBbFVvSi9VaUtrL2ZvSnFIa1FyL1FrYjlpaFg4TklMbWVocVVa?=
 =?utf-8?B?UEFIQ3NBemJRTm1PZGYzN3RtK0hlenZ0QndwQzUrNDcwbTB0YklrSDZiUEhT?=
 =?utf-8?B?dHlYc1FuUU5SRTBSL0NOamhTVk9HOGVqcXYzNmU3a2lzQlY0UFhFZDNOdTN3?=
 =?utf-8?B?QU9VUkgrSE41TFNWbUdNNDBDWGFocDdlQTREZkQ2dWluVTg3eVJCSWxZVTJk?=
 =?utf-8?B?NXZGUnFpUWE4V3RVc0JWOU5jd29Wb1JyblZ6dEdBdHFnUmpsb1c2RHBKL21y?=
 =?utf-8?B?REhnNVhKRlQwVnliMVFkTGdRVkxoU21iazJodHk5Mm5qUlo1K1pLejZFS29y?=
 =?utf-8?B?eWhZeTJJWTlUd0JZY1JUTkxjazB3QnlPZTlDOWRJNXNqd0w0L3RMWXFwTGk1?=
 =?utf-8?B?ZWgxcDVZNXJoNC9xUkJsbDg0d1p1S0k4RlV6S0lPaGVTZFNwK09manQxUlp5?=
 =?utf-8?B?dmZkYnh4cE9VTEgzWUhkTFpQSW5ZNm93L0xVWVpwL0Q2ais0OGJiTGx3RkY4?=
 =?utf-8?B?dGlMSVhaNkxnL0d4MVZkTkZybjk0Z3RNdG5LeHRSYWlJRnZjNk1wOTdiSHk4?=
 =?utf-8?B?OXBQR1VkNTlVMGRPZERsMExWZktmU0crZ1FMZUs4SyszRlJpQzI3cmhFSEZx?=
 =?utf-8?B?UzQxaHY0UVJTcm9TVFYzMUFRNjArRGlORnRLakt4YzlNVVZQT1hUYnZIUG1R?=
 =?utf-8?B?eW1DYk9QbTBhaXJXUnRFQXpzYW9DU3NvZk8wVWROUkx1VVNvM3VIdjM3L0Ny?=
 =?utf-8?B?R3pMMEJiT3JkUi92ODJoMjVjNTJMMUlTUmJ2ZXhqMTUwSktCblZrRWVuemZ0?=
 =?utf-8?Q?5z8A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 08:10:10.6132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ad74f8-76e8-4395-edbd-08ddff2f9c50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
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
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index cd7402e36b6d..871e0f56d61e 100644
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

