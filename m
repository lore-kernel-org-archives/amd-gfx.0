Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7D8C369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 21:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3F5510EA70;
	Mon, 28 Apr 2025 21:21:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dB39zWma";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 633C810E218
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 21:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U39byb2+Hw6JVFZQqj4j/Rzd147ct0he/jf8eeqikvnvJ+nhhzTxZxp1SdSgPKzVqhyjoXLqhywdWstk5hj1hTjFtO0XJ49FuiXIzjRMT2I+KhIp5hB59Sar7+IiIrSbRWX0YwobylUJNBcqpo3Yuyw4Pw8FnAX1KDO/Cbhd6Eem3wI4PQHUPzIPHcBIP/LKkZUo6Q64Y3uf9037Ep1884MHJSqxykm/eehl4a6uMs6Y3EEewi6zZoFRVLKR9kSXk+viWsnHawgMPPyE7wxn/PZ/IsdYiPQ3L2p4Yq7EgygFkKOQ0pi6XLxROLarzeCfSGjanDBO8iuep2gZ1OvNYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFrM8k4bt1k+eSJBuoyC2ihQRcllL8G/xCNQn4KGBT0=;
 b=nfkxqGIQpQ4YdHqmum3zmfM/Ypxn6YO3CVcx9Vv7m3mIPZFJwGG8h/oXXa1ddE4D4ePcEi+ijqMcv25yDTJM2hAm0ELtqH8liQ4B9ADysAxfKCY74MsBjPWSD2Y7n2Z2d1uLjTPTVkgrwc+hgkud1oAHEIifbeeqWEEVWhWtjkZpKl3C6GZcnAI/yT1q7p6KvOriLpU0M9l8AGVwDxr++2L3PfaQlJzVH4rP1YKmVqFYBY1LRCcF1p+HMzB59OdxwwjYVYCEI24kv8O8NToM4uawSEW8tDzjPEL9WA6SCH+sp621BjKvayJtDomjmHDZZWDRZQVPumNzIngUIypZ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFrM8k4bt1k+eSJBuoyC2ihQRcllL8G/xCNQn4KGBT0=;
 b=dB39zWma2flJrB93X+ZFwGuquUIcbi1kzZ1yVXQ+N2SiFpAnY1NtomV/axvzqzn/WFDB0R96KmtGD066YpiDpX1YJmXA2DmdZyayTz50NyU74hB12ivtwhYsxomokjfG/irJMoKMj80OnA80zPrHhjS/O1u9/QQwOjmXMQl0+dg=
Received: from BYAPR07CA0075.namprd07.prod.outlook.com (2603:10b6:a03:12b::16)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 21:21:08 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:12b:cafe::6d) by BYAPR07CA0075.outlook.office365.com
 (2603:10b6:a03:12b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 21:21:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:21:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:21:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 1/8] drm/amdgpu: add UAPI to create user queue gangs
Date: Mon, 28 Apr 2025 17:20:43 -0400
Message-ID: <20250428212050.1098434-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a2f945-3b09-4e0e-c5df-08dd869a9764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kfeV+3AiDeD95Mf+Yd5u5ibY7aCzoOJ0Qr7XtfV8P9Ts6BFR7Z6S/NVlilg0?=
 =?us-ascii?Q?XqRH6GF1LXwFMci6CSMnmC/9eWe7OAFt/X7KSQD+cJi2tbunwOPFJxZNrQp6?=
 =?us-ascii?Q?n7J18iS9kT5dBPcXMGrKGnKLPdw65PX/BUBpIqTrncNxESDzLnVgUMH2TukC?=
 =?us-ascii?Q?hqHNjxoyX1wGcWomIORGB4K+cu4FNCVR0Q2b+tQqk4nz4ginQ96yMCNyROKd?=
 =?us-ascii?Q?U1XmfvRF2p5bW1BTd6hxRYizqL9N/L/Nw6VW8wuItSgxOAigV1mcHVxoeI8o?=
 =?us-ascii?Q?O1ptBmY/gQCzkO3xSltrbQLI8AcpId2RxsjkY5UMjgo7llBWtzjkps2CnrPJ?=
 =?us-ascii?Q?Ju60GvuZTjLHwYR3oDs3ltUY5794bgoQlSonHvIee5atXJDx8nPZt+YezVee?=
 =?us-ascii?Q?Gpfh0hs7j4pa47b7FOOiW+mzzSVD927XmIUsoj4JhWAhLebYa+MqfVlLhEfW?=
 =?us-ascii?Q?gyA9Xfm4BsW4dYyXP/dur3pchhu98Knzxa6UHASgWqRuM3VH/2EScp7Zmwz9?=
 =?us-ascii?Q?k05aPbV6ZsRfyxnEtT3bH2wJogRm2STnWZELH6bPoYlbcC5oXjApHPkyrKBf?=
 =?us-ascii?Q?tK/cd4KiR2WSqD7kpVezmEjSi0NIsPQszsBKmzgmu34nSAFeOVlleLozw3qR?=
 =?us-ascii?Q?SgZc/7kTpojB6wZBiJHlyX0x3W+6XhRxtJNx2NuIfEUmLkTW3I96l/GwJton?=
 =?us-ascii?Q?1AFyqw9pTc2XL7nHBYYgal7LLzalSYV1BMk3yNWc+xZHKEB3i18Mc1Rdx+qa?=
 =?us-ascii?Q?qRxc0nGcHgfV6fvwi95vWPhmSj2vGg2aHS5UJB4vfkm6wf87z8awhhfFIbIl?=
 =?us-ascii?Q?bFJ4eJeWlvUbO+NrEmtAD/aKXaD4T/BhDmzFmdm+m/a30mHiw9Z30RUhzMNg?=
 =?us-ascii?Q?GWDIuW1xlLH0Sc7DnJZmqiDZBv2VIq4NHi+/xcWMvascImaHTKGP0yj24uRh?=
 =?us-ascii?Q?HozYgW4F3snp7c22zpMxM0KYvEYppd8z8M9nX26hTIyzmQUAoyaJNKlGOlzL?=
 =?us-ascii?Q?bleEDdnYmIvEXcm/OZhyvm5luTNyEOSmAz4Ed7RjvuyeSTq5pPjxoweCp76i?=
 =?us-ascii?Q?Su/HNruG0IMww5JlKe0h0692CZ6AcVRbIvwwG3KYqDxHc4ho5QJC3Aj6DmGV?=
 =?us-ascii?Q?XivVtM4G7oqXb3QmmrM5R6Dnm5mhNhdr9hWc+H0evD7TCYBbxfmwEUpVTq39?=
 =?us-ascii?Q?ASmMeFTZyjKtBbyh93up5U1uM2y+ojxwZm6K7VicsU+2CaNed06pQ5YyQiAz?=
 =?us-ascii?Q?lxW7uBPCOOh5o0T6xc9VpVET2+uxEvTx+4pSG5hO++tiAlwQsFst2bg1dFKX?=
 =?us-ascii?Q?KhX4CAurZhw1WfHY5SIQEmU1Zz9MLi5jCVOaH+ieY7iKoadu4s26KXnGT8UC?=
 =?us-ascii?Q?BJ3PDo1qs6y1g9At2Gr+dR3un7HFK+V/UqHCoyto0QX0VLgSWNqZmf0zXI3c?=
 =?us-ascii?Q?s1/sMDHdDT30NA9Fr7S53y65PPyK9HGeVBRoL9VmzLsRa3BatwaAOJPRQBqU?=
 =?us-ascii?Q?wXWqaLy96th7IlH9Q5JqSkfJWfFxsl/rcLOM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:21:07.8105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a2f945-3b09-4e0e-c5df-08dd869a9764
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643
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

Queues in a gang will schedule together.

Acked-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 56f052a10ff38..83414563779fb 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -329,6 +329,7 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
 #define AMDGPU_USERQ_OP_QUERY_STATUS	3
+#define AMDGPU_USERQ_OP_CREATE_GANG	4
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -417,6 +418,15 @@ struct drm_amdgpu_userq_in {
 	__u64 mqd_size;
 };
 
+struct drm_amdgpu_userq_in_create_gang {
+	/** AMDGPU_USERQ_OP_* */
+	__u32	op;
+	__u32	pad;
+	/** Queue ids passed for operation USERQ_OP_CREATE_GANG */
+	__u32	primary_queue_id;
+	__u32	secondary_queue_id;
+};
+
 /* The structure to carry output of userqueue ops */
 struct drm_amdgpu_userq_out {
 	/**
@@ -436,6 +446,7 @@ struct drm_amdgpu_userq_out_query_state {
 
 union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_in in;
+	struct drm_amdgpu_userq_in_create_gang in_cg;
 	struct drm_amdgpu_userq_out out;
 	struct drm_amdgpu_userq_out_query_state out_qs;
 };
-- 
2.49.0

