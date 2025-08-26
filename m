Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8F9CA0FE9
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 07:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 846C410E5F0;
	Tue, 26 Aug 2025 07:47:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VuwWYV4N";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E75EA10E5F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 07:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNEsQ1zM0KM8es6vnh2k4EA/wDm3b9MUp3n/UYhwjz/n9Vf7HPNCnSjSORojr217LYjKMFh3JxfyDK/6c3pRff3J+N4y3C5WnMKGji3s7hTCQ7rMJx1irmLY4+5RDt5KHWJsrQuHHzgkiSBZOOmFFj4WcyIks3RzuEfLlCZSBLg+fpylFQ4s7WfTSZfybCtj2skiswxEVpQ9M1o/EleomE9Jd/l9ma9qesI+TWkK120ZN4PkuTqi5GJrRbyH7ZODXBOg/3nGIfqvduMf735mOCijy3qq3iCcJ3tbbIAhWcLYzl3sAqrmxsKjPp4xxorMzShDdBMU+92GqLWw/OabdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1fk7IvWDpjA4DYQ4bAb8CBPHtlxFvXxgh/8ppQqu/o=;
 b=hQyl8EgLnfvcr8KZICJ54SI40CMQNn0CvyBCdbdLjqZhWx3ao0EjltGjT1Pfum83kR+n68MsLhwdBzLGUKmmjDcqq4FdWnAGD/mWng3FpwlYnY5dOf+Vy7Nz5r0oY2vlXc3iX+vEy6g0FprEVXg4p9qKZgPWZEN83LuKMGWNvUPCb2jF85Cs1ZeKRsVjQoUZaXvi1vU8iCarEkWgHCWcWua95mokleBMFgmyLbTU951OhxwabQdxiPI2AzLD8z48XeKJsZnRDLCbcdeBHHXoNTjsk4QZAYsLrINPZYs/3uJNBPxsPPRE6e+HVFhevkz1JAfPGo+C7tkTOwckSJ37aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1fk7IvWDpjA4DYQ4bAb8CBPHtlxFvXxgh/8ppQqu/o=;
 b=VuwWYV4NW6JMP5vXtqRG26Pd7LyjAlpdi9TiiFPNB4eHnAoDs8yRNWETTLnsj0uzXBr3HaUcmH1LGJWVLRMKpRKAZ4yzphNR86vvAngM+h6p53+ruJpce9/fwhIqWWrVtJrfSeegRC/1rlGhSEKbU8HLeX6xatBlLu71aehRAho=
Received: from BN8PR04CA0008.namprd04.prod.outlook.com (2603:10b6:408:70::21)
 by SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 07:47:02 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::26) by BN8PR04CA0008.outlook.office365.com
 (2603:10b6:408:70::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Tue,
 26 Aug 2025 07:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 07:47:01 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 02:46:59 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v9 03/14] drm/amdgpu: add UAPI for user queue query status
Date: Tue, 26 Aug 2025 15:46:35 +0800
Message-ID: <20250826074646.1775241-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826074646.1775241-1-Prike.Liang@amd.com>
References: <20250826074646.1775241-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b5ad7f-bab0-4a39-3540-08dde474be0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0NCSjZnVldLZnNwWmR1Y1ZCZlVIekkvdlVMTGFlbUNqa3ExWGF6eGdENU5H?=
 =?utf-8?B?ZHA2RG1UeW9GWHRvWUlHS2hDTS9MVStGd3g0Sjk1UXovV0RudUdZYXVTMXFa?=
 =?utf-8?B?YkxiM0c1SFdza0JBWHBPL1VZNzN6a25CMUREVXpjdDVSR0R2alFYZGhaQmJt?=
 =?utf-8?B?UG5ZRlN0MStnUi96ZnJpcjRIK0ZGRFA1aStnUzVQZGUyengwcStMZmZ5TDlt?=
 =?utf-8?B?NjR4MmpoZEFkUjJxRWpEODRQbG5xT2pFOVVyR25XZW1HQ0JVMzhzNmNjSXp1?=
 =?utf-8?B?ZVdHTnVlUjBVek04bXdnUEYrNThsRGxxL0NBNEZaczNmeUhTMGw4b3FaYXpU?=
 =?utf-8?B?a1ROQ0RETVlWd3JraUxuOWFwcGF5eFZmd3Fpc1llaUdvUTBqR28rZXVkd3Ix?=
 =?utf-8?B?SFZaZVNyV1QwZWdBc0ZER1MwZnN5aGxLTGJKaTZYanJxYnhQM2dlcmYvaEFR?=
 =?utf-8?B?ZHg0aTFjRHZET1BpdnRNMU9sYUJoNG9Zelk5ZEZQaVpYakJ3bWFWbU83WGVR?=
 =?utf-8?B?Qm9MeEVKcnhyV3ZCK0cycklHcWEyMVJCK3BGZ3I4aXF2Z3d1aGRISFJ4czl4?=
 =?utf-8?B?UURPZjI3QVJlQ3RxKzNzNE5rRFhlRmNmM2d1ZUV1NmxXTlVuWVZpLzVHL2F0?=
 =?utf-8?B?d2s3a1IxNStXT04vckFHQ1JmTHpjNy9NUU9kL2o0bjc5VnpFZkxhSHYra21V?=
 =?utf-8?B?Y3RPWnBzNjJRcEZqV0llQ1k0UkhsZVlTQnBkNEt1Rmdyd2FqSU5hVW5GSkdE?=
 =?utf-8?B?LzN4S1A5WG5HQm9HNGhkSHBHbGpPZzltY2J4MmZNZG0zUnU4WFZQTHVhZGJt?=
 =?utf-8?B?UnJXb3l5NjA0MXREVjFuZ0taaURjaEZlNDlJSWpxK0RWTEhyVVhnY3R1YlVS?=
 =?utf-8?B?SDVuT094RVppaTE1STBRSzlWSTFzc0RJUU5RN1E1V25TTVBhQitPQXNGWEVm?=
 =?utf-8?B?dE4xN0dKOUdGSWNuMmE4WG1GVVFRNmhjQWZTUXRXRU51MXBCZzhZNlVRS2Jq?=
 =?utf-8?B?NnNVZFRNVElVYWFYYzdtbzBpZEgvNFJReGtPVUd2c2RISWJVVkZ0bzNKWEd4?=
 =?utf-8?B?djFKbW4yWFlhNzlHQUFsM2VDNjRpVGdoU0p3UnMwM1d0eUhYZHBKemhaZFVR?=
 =?utf-8?B?QzZqNzhDM0U4ZkhXQkt1c3JmMmpzd0ZFTno0OTJjMERmaXJQUkFaMkJybUdT?=
 =?utf-8?B?VmlMTVhXcXpnSldDNlZxNEM0NjhxMjIxTFdZTmdkeWUyYUpTajZpWEdlc3pQ?=
 =?utf-8?B?M1EwUEE0emdhaE43RG00STlXL1I3aVE2d20wbUlNUWVQMjNPTVJNUHJXdTVD?=
 =?utf-8?B?QXl4QnY3WkNycmI4b1Bia21ac2grOEFzWGJ3NU5GVWZVT2xsYzFaVy9iQ3dZ?=
 =?utf-8?B?THJBRC8wRGQvaDVULy9NajA0UlJWMXRoZnJiNmNYODZuSlNCQW94OUNmbkVx?=
 =?utf-8?B?UkpnVVUzRWV6eHhHY2M4OEJ3MVc3M0FtWFRpWHlmQ0hLNXZPbmplYXFpUEx0?=
 =?utf-8?B?U09HbWxBOTB1NWlYenBmdFNUeTZ2YndDekhpOXFwMnBPY3JNekJTcm5PaWVz?=
 =?utf-8?B?cUFBRWRRd2xQSCt3RWk5RW9haFRMT1o5MElzYzN1ZkNRUkw1eXJhanhkaCtn?=
 =?utf-8?B?RVVRS3RJQkRKMWpSRWJuSk9LYTBiclJIUGo3TDdnc1c3dE5ucnBjK2U5dzBp?=
 =?utf-8?B?N1Y1dnRwdWxTblZwK2Q5OFJHU0g2eUJCMSt5QUYrR1lycTg3aEs2clU0Q1ZO?=
 =?utf-8?B?emJsUHBMRXV4WmszVHpJOEVGWjNXd2JlaENKMWw2QktUZzc3SXAzZE5wNVh3?=
 =?utf-8?B?VURaVDUyUTJieTE4K1NJTXZZaG1VN0pzZzJNZnFDTllYTlZQYjhNOWVjUzNj?=
 =?utf-8?B?MUxIeGJNaVhUVExFK2xkQWZHLzFQczNPS0tzNjhSbzJ5MWljNEhGUmpHbDhp?=
 =?utf-8?B?RHJudDduVEwwb2wrTEwyWVlzQjdNL094WFhKMFZEdnN2cFdkUVZQYkdQV1dy?=
 =?utf-8?B?eUEwaHhqU0NNaWNIVjJ4RTRvRThPMWdtQTVlYys2UVpIazQrNGxudHJJNTJt?=
 =?utf-8?Q?3QMCYx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:47:01.1974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b5ad7f-bab0-4a39-3540-08dde474be0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074
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

