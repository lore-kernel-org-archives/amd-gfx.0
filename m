Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B0ECA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 02:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B48F10EB2F;
	Fri, 29 Aug 2025 02:45:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0Wvdrybe";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAF5610EB2F
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 02:45:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fllE/TeygoJp1TuEbjsf3TUsfOpQeadimxQLPIdvcnvXJwJOzeO/DQ33pMenLXgrv5u/XdDVk93YjxXoCCmm8Suw+2/3AVE1PRvovaWWyy851i9DvHWoye1arIep17Q6NwJ3JXvEgJDFrE/yFFnxzJ7qdW0JsyoLmm6UY6NxCNofMTJxZWmvM9OgGfZx8JTDGwj5kprNACyR1zqLIuQkVaZb+1CE0Kr9kudNqfXzuO6rwP9HYJrbjXHq2Y6IF0+gafaGkWFbfFNFU1w/WscAxmEJGyf55CVcqSBwnW8fg9me4P12CUaIa1W1qiMELJoNdQ1QgIkdQWI2AWQPo8CjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfMYHW3bpdPceIIU4XgZk/Q3w9oVl6fvaiFyTtGt9ao=;
 b=GFr0YVY7aL4VzUCn1xU4m1W3xnboT2K+XC2kl/PfCW+GjCXHEkv+IOp+YB1W9lUa/fXO5rOKQW9Aa+7S1onuSzSlaF8OxVK/ufdAWDYpZfZ+/Ibfq/0kqf/QHWYfImTIbwth6JpE0kKSjkxR9dXF5q3veGzw8B1u1vn7QgvVFfzqDuWJqUBaebfO3+Qru3C4gEzCiULLxewS7kGbnVHbvLCDB+VLQUx2R3GPfjj4GkSmwCROaFpoxNbH0bxLZpv0onHdjGg9skykUOhlkBy85+bGgrJB1LkCoetnn0AsfszxMTaggNpf26GUP9f3nN7L3m/v0aDyVX+Qzg6KXPMbsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfMYHW3bpdPceIIU4XgZk/Q3w9oVl6fvaiFyTtGt9ao=;
 b=0Wvdrybem7W7WaEx5yejgTrNRrJGcDxt+6VLDDn5Fs7t6fDh/NU4cgtufJ8/XOGtP635De5NrZ8EMbTeNh0vfVtPD2+5Pn7AFp3eqQh6l/4fczfVrhHtxVpm8EoFgzaC17szhP7ixWWKu3P9Rj3IxcEWYQTjUEPiXK4qqKGTmv4=
Received: from CH0PR13CA0039.namprd13.prod.outlook.com (2603:10b6:610:b2::14)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 02:45:03 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::2c) by CH0PR13CA0039.outlook.office365.com
 (2603:10b6:610:b2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.5 via Frontend Transport; Fri,
 29 Aug 2025 02:44:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 29 Aug 2025 02:45:03 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 21:45:01 -0500
Received: from stanley-test.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 28 Aug
 2025 19:45:00 -0700
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: wait pmfw polling mca bank info done
Date: Fri, 29 Aug 2025 10:44:42 +0800
Message-ID: <20250829024442.1019668-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|IA1PR12MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 69153234-8568-4fd6-f9be-08dde6a60e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wEwqcTi+MB154BzBklRppwhgjUebweibILCYzzM7OMd1RjdgC1PONA1QEnhj?=
 =?us-ascii?Q?n7a6YpTKxKca4ktXFwpjuJi6cPBeBpyOFuZU8b0XJxFdDSQ7/uE2qzm49QT+?=
 =?us-ascii?Q?GkjB/RziNQrV3W7TISIbySSn/8sB2NCQ03O1dx43m6C9rd1Sq6HUNwXVuR0Z?=
 =?us-ascii?Q?9gHWNIEJodsbIUAXduZMd6oXZcRqpoAfOVORnJKGfhlIjE1a31Ku0T8YG8c7?=
 =?us-ascii?Q?FwGHtUjnF3VuBva9IXDfErtpv+OTIZTwdxlbh+AKx2xwECBbm0cNa9z/fKiQ?=
 =?us-ascii?Q?XyTlWos3jgJMrP0icTnjtgQia+AdLxFHGTTFfJpu6WkBpb7WOqIcui35M6SP?=
 =?us-ascii?Q?JxJGU3ukba63SI3K7WFCeLOr/xj72qFzNd6IKknjsFSuHWPNx2IVYlLbgdcw?=
 =?us-ascii?Q?47hLxB8hJjcTVVM9KuiOUxdDGQjl0tG4wIHE++HJIuXzVeHfbRTg/aoJACKu?=
 =?us-ascii?Q?dXegC+NmXvhiE9Vgpporgq7gC1Ye4ItX7QjiURTTWyArWpkOGioCuBewAWaY?=
 =?us-ascii?Q?U1j731gXGMptk/U9xCop59RtOg2Z2SQbTA7S9wj7IHz8Me2974IVwMCx55Sg?=
 =?us-ascii?Q?9nPVP91RWS8/nLo5CrNneyG4BzgLCFSno1Z5QCA0qE63baZuq0nocJ4SsDAD?=
 =?us-ascii?Q?cLSnguayHuV8rDawiLtwUBN9xfR1CisMVQrQ/RP0JpOZAJnTo+NFokLW+0fn?=
 =?us-ascii?Q?DCpsjphAq/5+AimeeiVmiD+ij943nXkVcLFbeQNzAfTgI2TphBD15DfnZqQR?=
 =?us-ascii?Q?7738RoEPMJEwGnWN0r6X3YLdRm2Q3nn+1JiRrqOg/5/CnV3UJR/T3rul0hHl?=
 =?us-ascii?Q?v/0oWR8SKYZcjGqHaaMPu2iViQUmL8qYxkPujH8nj2h2IDQNtGfUwqnto1ks?=
 =?us-ascii?Q?EGG88Oc5TZT7m5wPGSViQZbBn49km1Pz4pjKR079J25A3Psbrv2oBb0jpAE1?=
 =?us-ascii?Q?dFb6IueS8w3FdLVOegF2m8a9+AoYR+X6XSYr/c3G5w0o/uzgXI4vPqseHf62?=
 =?us-ascii?Q?PYcdSLkT7rxdy421IvTrXN2on61u1K1wQQtsq3fUymaJMvIh8j/S7lvwrTWs?=
 =?us-ascii?Q?dr1T5RYHbHFXbzw1JGo0iBFWN4NviEAiA83tp3Qs80/av9fhY52/3wA6pfY8?=
 =?us-ascii?Q?ZO4yttzohpNwMwf+yWKVJXNlAayxhbgkshb/ZPRQ5CkG7B0DLqUvvX4lqkBL?=
 =?us-ascii?Q?b5LCKAqNn2XJNpc1hhBjQlDRbUsGL9aUikwdGCohsQ3vpjRqhMSlaBgV3XV4?=
 =?us-ascii?Q?G+3oboO46IsmdqN1mD1BpWuVFleQwYezv87srkqKNmRIg8IYCiSK5+xVtFfV?=
 =?us-ascii?Q?zkTsnF2W947EGpIeNlmDJfzg3uySCBzLgby0QR30b0KwtpS2seB1K/K3YbLj?=
 =?us-ascii?Q?8dT7JxQl/qI+0pV5zl/nvUipTt8H6rZ0ZICIpTwMEbrAlueAtAZi0/TMD13B?=
 =?us-ascii?Q?E3KzgOjDnE/ecMF/gynEEtbNSNXjMz0CHom7hWKjsI9zqTEKy1qX3dppND4f?=
 =?us-ascii?Q?nkiBQbhgDprd6OY4w4HqhlEz4dsg43Xxr5qG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 02:45:03.3823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69153234-8568-4fd6-f9be-08dde6a60e3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240
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

wait 500ms to ensure pmfw polling mca bank info done.

Change-Id: I50581f03929c86d75bf09d66238b64f2806697f0
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 096881c90200..be0da05aa9a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2705,6 +2705,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	struct amdgpu_device *adev = ras->adev;
 	struct list_head device_list, *device_list_handle =  NULL;
 	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
+	unsigned int error_query_mode;
 	enum ras_event_type type;
 
 	if (hive) {
@@ -2733,6 +2734,13 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 			device_list_handle = &device_list;
 		}
 
+		if (amdgpu_ras_get_error_query_mode(adev, &error_query_mode)) {
+			if (error_query_mode == AMDGPU_RAS_FIRMWARE_ERROR_QUERY) {
+				/* wait 500ms to ensure pmfw polling mca bank info done */
+				msleep(500);
+			}
+		}
+
 		type = amdgpu_ras_get_fatal_error_event(adev);
 		list_for_each_entry(remote_adev,
 				device_list_handle, gmc.xgmi.head) {
-- 
2.25.1

