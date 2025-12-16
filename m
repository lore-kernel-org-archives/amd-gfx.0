Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29199D5CCA5
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 09:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDBFB10E79F;
	Tue, 16 Dec 2025 09:57:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mGzIq5J1";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4294A10E5E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 09:57:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g01Zw7FVF5iuFue1BuGTb46F5vaVQKEAyEtcb9BsVupg2D5mANnAjTSWkV15ARGCsfZQpaS0ykUe5BswvZO8AimEjrCzcnesllRYhxDQGSbFlggY5IoGZ+5XckZkwAd7aiVn+WF4B6IrnpimlDJArSjlWryBkZBGeXAX0weu85JudJnp9h5s99Y6MDWeBalUGXDhnsVPzeXI6ZxN+6x+8ezwRzQB/Zn3HyuSlE3tTHGjrIjajS7FiibpJQhv5jl7l8yY02KnGteeryWr+M4D0lqz//sO1a1E/ENUz1XV8ELRmWWnlR+BnwDeKSZX0tlMCkH8SxnG0mFmtvjAvdG4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Bj3VYxS0IOA5axg9P41KEDV+LB7En3i0h29t+pG0vI=;
 b=ob11tFcy8Eu1xAVYX6Ec9TkZB6I1AA/ulfBsEKz/kn8BO+s7dNI0dzSgz0IrCxAPA6MDaoS6ju+NpSQdRgb/IGMVFPXqNtm3Sreg/Y9dhIwGbNR/cFFOF52xYaqxne7h0gdQcfhvnvbOUNJ+o2cYDAyfa3yNL4mmSO5ehm/6mZ0XZLSCjezb2s3oX9GLxugSstw5ANnqAXnFb2Sf0s2I+1L1Ny481UE0i36yxSEuArb/wJkMl46hNl8veEWmWNB68Q2Fm6AO0dewdqs73ILIEBj27WuK/mviY9lX5kKU44RJaRJl6Z7hFIh2e1Hjyd4t2xvjsb7dHgA4GLnVbjsv+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Bj3VYxS0IOA5axg9P41KEDV+LB7En3i0h29t+pG0vI=;
 b=mGzIq5J17bSPuX2EXr3+8sUyVPDAtW53K1eMMTPhKotnzdEhx3D5C0HTBWIjxb6io6VbGvELeZHGa4igtMXQZbc/9/uI+jm4MPg2AUIj/WEUg6wTdOtIOMlU/jfYMVH1lYEEiiquhnFNfOAkYyZOGPTBw3zDvtp6fq3Fv98JFSc=
Received: from CH2PR10CA0013.namprd10.prod.outlook.com (2603:10b6:610:4c::23)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 09:57:38 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::9b) by CH2PR10CA0013.outlook.office365.com
 (2603:10b6:610:4c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 09:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Tue, 16 Dec 2025 09:57:37 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 03:57:36 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Dec 2025 01:57:33 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Richard Chiang <Richard.Chiang@amd.com>, Yihan Zhu
 <yihan.zhu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 02/16] drm/amd/display: sink EDID data null check
Date: Tue, 16 Dec 2025 17:56:02 +0800
Message-ID: <20251216095723.39018-3-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216095723.39018-1-chen-yu.chen@amd.com>
References: <20251216095723.39018-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 51245eb9-d19b-4320-a18f-08de3c898b26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Pn715UEk/i0eRUnfjqYCv2JmAwZ2HfVK0OUK+2X+K5GSQ8gyh74s1vv/dV4y?=
 =?us-ascii?Q?d7p7hoKOVij95bHPRcCWttiOeRELKp+ANeNrGmKLw7Lpi8Q2srJ2snM4wvOJ?=
 =?us-ascii?Q?ATj0ibFARiQcFg3LWQIvoNwcS1F06biiPr0DnihZwUln4xw9JW0mBnyS/bsy?=
 =?us-ascii?Q?k7AdU2JIhwZC2+yfaxQ6xfvzomFvfmALDSiQ23yXEGFn0/wTnA+1kQVJRc+L?=
 =?us-ascii?Q?HtZLAovsiVxwh0rai6tuJnKB6JUqPum7yu4WV88N9k/B5PJtwpOR/fRmHhqC?=
 =?us-ascii?Q?be7mZbwg4G9lln1LM1MoHbhK6r1pS/PiNtJD2O90BGVNwg+Km67PPcoezLHn?=
 =?us-ascii?Q?RM8p34Cn9/sgp8HG6PVNUGqI0/jgmAvn1vLGOfiKxnhXsWOUhs5CygSNiJbq?=
 =?us-ascii?Q?wJLujx79gAkbrlp55K3S+AxKtP0GktYneOL+S72iRWIg2YNtJa3uIIXEZVBH?=
 =?us-ascii?Q?QUgeTpRa2R0b9QXOGQqVcyZw1fZb4/NHXSagGQsDANPUKdv3X8AxvmJiIJvU?=
 =?us-ascii?Q?vtMQQKqW4iFmozZBzs8iRMxuWizNvZhmemyInBdV0ceaxC7G6qengrul29Xw?=
 =?us-ascii?Q?bXjyb3WSdNmGNaMdopHCSwLrvacBnHZWHLvkOF3sUs7kSsK5lSRDUPtGQhAO?=
 =?us-ascii?Q?Vh61McoxckkhhDvHeSEzU6VCN/0eDkvrBsjQHMkK2G49bt/oG8pH3d+rPywL?=
 =?us-ascii?Q?4lJjJhh2ovJpAfORJzerCe8SGi/SpxerDtKsp015FCsoJWzgph/NgwJjMBem?=
 =?us-ascii?Q?MBsycA+OPqoh4PO5xT2VOBpQDCwwP2tAt8Oll0UR4rJ5LvLUW1JLafDugWpg?=
 =?us-ascii?Q?uzSCA32XhNyl6jhYbg+tiply0jv2GtDx1Vjdny71AkoGpUeKh+uvJE+UQGfi?=
 =?us-ascii?Q?kONsBlp3gniun9KfU9z5ZX0dp+eMH4xQ9NQKBI+cD81gLWwFpUs/XlIOkbC1?=
 =?us-ascii?Q?wAFie0gKQU0rX12U2s1m/bvfq4L39YPxw7Fn1ZX/gcHb4vR2FyrLFW9UAXu0?=
 =?us-ascii?Q?2qGPw3ObTrbbaNNICiV83ecjOMy8nzvtPflN0/hYf0v4reA7KKccFnIis/yn?=
 =?us-ascii?Q?7tK0Y67hhF78riRnx8If8D2C6t+UM+kFZyn8q1pdfLzL6A6LCMN9bCtkukkF?=
 =?us-ascii?Q?YCIxgWvGx9ZJqzuy7m8OlrknCbGJjiwD00fGRWWKG5WPti1oNBS07eFN0o5f?=
 =?us-ascii?Q?JkXkF/a19R61WKc5ka+KoKmTKdBzawrdswk5cfn71GjfFeKZ/CN4ZouBSOuC?=
 =?us-ascii?Q?j5fJMTGAb159NDC6sJNBirF5kMfzNvYvNS6q+ICMFNWq1BVw5opfP5aYOwm9?=
 =?us-ascii?Q?aJ0awAUZXKpzdrlxryCdGDKMPQjAOqvqfBenGpyL7hO+FtoFVs4dqhLpvzdm?=
 =?us-ascii?Q?Bczv6NvbZn0aIaJNSff2pHWdbqpfkYTQDIO9P2EWhok+xz2LFNjnaz6+LzZu?=
 =?us-ascii?Q?qwaORtgJgimf+dTCOfvtUDyYvtcp4NXN3iJnIY4Hf7/cVR9K25ec8UMK3YL4?=
 =?us-ascii?Q?xzgUVSRQoZhIBrPv0X2Mkh2smT6WA39u4uAF5y9pQNE/eJmvnIJrbfm71BRT?=
 =?us-ascii?Q?pOdUsqsigUjcWOXRL7c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:57:37.5410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51245eb9-d19b-4320-a18f-08de3c898b26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923
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

From: Richard Chiang <Richard.Chiang@amd.com>

[Why]
When sink EDID data pointer is NULL, it will cause an
unexpected error.

[How]
Check data pointer is not NULL first.

Reviewed-by: Yihan Zhu <yihan.zhu@amd.com>
Signed-off-by: Richard Chiang <Richard.Chiang@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 373e68cf2bde..080642dfde2a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -623,6 +623,9 @@ static bool detect_dp(struct dc_link *link,
 
 static bool is_same_edid(struct dc_edid *old_edid, struct dc_edid *new_edid)
 {
+	if (old_edid == NULL || new_edid == NULL)
+		return false;
+
 	if (old_edid->length != new_edid->length)
 		return false;
 
-- 
2.43.0

