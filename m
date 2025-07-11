Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1EDC83F25
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2890C10EAFD;
	Fri, 11 Jul 2025 22:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G2jGCXaJ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF8F10EAEC
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmXqtCc1MQbVVH8UPRZLo14Uq53tatfa26vqNdKRXUXMuK2n7YTF+L/FjcXuCjeH8uxlbJeZecAgO0YfTQJjz68I+pV90B8GxL7Dzjy4SIPXte9pklInvZdVGtgQh/s+rRR31Vc/bG1eFNK61bijFWKBjjYsqdG+aaBJUsgt7EgtBh2WU795VyhRg6C3FAIAhKV7I5pGC2AbLftXu5doM9EyJ4boxbprIrgXY7Zb25lYw5fkZYhzm59Sc4c/t/SD7wlrzhXNKX7LkjZtSRigx0nNa5FIojAa1ZHRRCado1Muu0Zjy+c4YQBjp7gXbQhqnLbvMuwqb8/eLJ+OFCHvSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnWzvTVIJmprs/DESpA3tAgLyhYDo0nD38Y8aM2cD28=;
 b=Vb1yvLmghU/h7gPhibTtsDfW4evUwNpafDHsWqAZA3VpWSC2MX9XvDTj38V80xwAPRz96tsEjM3S3U3s7wyHcltHcbbnmNObVqRuoX14VhQGrYXcbT6qbu+3Nu/Xw/V6jLBpyBZOGqeuZHWXRoXgtmc5SMxq8V2eli1TPINflZHQc0GMFqh3kPiFb6CBJCNvt+jH3EWUxtwz7hPArjdbJCgdYmOBddixQn4RuVI76E+P3C9AUKLuDdin2MCQ6+u+Ph7ks1XET8+i++HTwitM5UQIVIceayL3cJJbAuoTV982ReIEhWAC4Aadqgsskk8Eu8lPKwXmdfqyRVc/Amfqcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnWzvTVIJmprs/DESpA3tAgLyhYDo0nD38Y8aM2cD28=;
 b=G2jGCXaJoedFk3ecs1GJC7D6sXmYMSMVVOQicxSswgejQRMGVts8MC/NlATyyft1hm6zvtUTrO/KFhoYs2Xe8dLIDEwVUf24JihsONwUn4rwVWYNjfVKWS0hpjcOxh8cy8QNvjZWeUGf/O3jL8wHdBpBGAqH9R5zCQ6e4mmxZsY=
Received: from BYAPR01CA0052.prod.exchangelabs.com (2603:10b6:a03:94::29) by
 IA1PR12MB6114.namprd12.prod.outlook.com (2603:10b6:208:3ea::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.24; Fri, 11 Jul 2025 22:40:53 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::50) by BYAPR01CA0052.outlook.office365.com
 (2603:10b6:a03:94::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 22:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 23/33] drm/amdgpu/jpeg4.0.5: add queue reset
Date: Fri, 11 Jul 2025 18:40:14 -0400
Message-ID: <20250711224024.410506-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|IA1PR12MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 3096cf39-101a-4dcc-c53c-08ddc0cbfe3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?27m+lI0YsML8q7/7yCj91qhjk55GBMw6JsVokZI1GNA8iTNmQj3N9cVAaMUL?=
 =?us-ascii?Q?O0qi9ETbBJ0YTmQtcl590YYGWRm0YbIt7ni/Y7YkDfA+eRBhwP6fFp9XnzDH?=
 =?us-ascii?Q?vhK6z7HxgyCZiAr53czgIe8ae6tqDBQq6vPYlH5p6XQKMuWFBEPVH1yJpacC?=
 =?us-ascii?Q?w6SOas3+XnX1OGI3/Rcu92pse73R5zOinmp6SEdPTOnaOudCgElezxEXtpVW?=
 =?us-ascii?Q?1DS0CqnhhDYCKnjkoZ+GwL1OwO1b5XDvvmu9wdppYuAXRxfzqhmiIg8nlnXU?=
 =?us-ascii?Q?3PAiPWipxBCb5/1b4R4kWECISgXXhxnJ5HQupjmRVvsqbV/ssO6ugywot1nA?=
 =?us-ascii?Q?tJkNc1W26dSd6d+IAq7K1nT68swEA8tpjnuUJX2cdvnJecVujscOV7Lf8BQY?=
 =?us-ascii?Q?Gow6ZjRdMJlowHdD3O2QLcF3V6FH8eJaqbT7k0dH7xEKo1kOt1weyiqUlOD0?=
 =?us-ascii?Q?TtmtzhS09Rd2nk7PGl41gEXsWI9oeYcV4S68sUd53L28JUcfQHr+3cu/bhqK?=
 =?us-ascii?Q?WHlYTL6o01m8HtUSlB3GZoJNYkEy/3gox+b+8TghxAB3YCw0smz8UEiz1gYm?=
 =?us-ascii?Q?MIrTqJcQ64DKFfRPEtIG0iJZdmYkGrtOGWndq3EvSGsswhJKt4mvCeiTav0n?=
 =?us-ascii?Q?g85TV7+coGpj1LraqiBH5aT/XJC6pT9Pmx0ZAAC88FgCtmxQDKDYTVIp7PVH?=
 =?us-ascii?Q?o8fF9vTnJQ2zbuiaCrColj49RP2gd8goLDqwLZ7+NzBBK2JZ4p11LEsqBUmo?=
 =?us-ascii?Q?jG6wxfWkrcR/KioQC65koJIUie7Qp8A3hdbPfUx+/SrY5CH8A9GeCzRtQfVX?=
 =?us-ascii?Q?1fjGZHxq+t0EqbZLzxhSxpkLTrq5AvoehJCPg3T71DIExEwqAWI6mYblszRK?=
 =?us-ascii?Q?OJ7LM2/9qo/mCo/JMfstTPAXJHm/xx4Qe8VjYiZ9WyoxUN7yMrGqv3ZTzX9J?=
 =?us-ascii?Q?i3FMYXVfWWmFafaUJ/HxiAXir23D9PsdQHuZ1/zBuvaXwn0v7CFyxu5LEMK6?=
 =?us-ascii?Q?1GgQzvLOuOcxWr3/5xgjhK7aqRf3lLEwvCtq7ErZKXVpNjtd8Hc0dB9PFGQ5?=
 =?us-ascii?Q?OblytJdh4buNE2PUOy2eqDNtC8Xl3tOZa1b7cy2jYCj0ZnUY7WP/u306FujK?=
 =?us-ascii?Q?PTXW9fhqMcRwEkFJjHlxrnruapbj2ERrRJYbXL0zma/6t47iTrKal6qCbVl4?=
 =?us-ascii?Q?Y6K8bd8rz1zQ/6SU4WLCDqDG2LzzPzmynl4Uat2DyDZI+quD9onwaqQZl2Dm?=
 =?us-ascii?Q?urrcDM/JiIzVNArPnf7lGbOQiWI6PTBqn6P1DW9H18diwXjE+fA+8QU98Xdd?=
 =?us-ascii?Q?pnfyCzECsSfxH/HQLbntU5h/ehX9bZ8s4hkePzrUQjjcv/+B5yA/ygbCMiVW?=
 =?us-ascii?Q?frCgJ+7x+IZHt8MZVNkhBC05Qa3QuKXQ8J+GF57c4Sy5mAc3Y8QcIySbYVf7?=
 =?us-ascii?Q?sT9sh8z5EizxnVYg/0ru84jYKFVReFEOnbUC9RJkv8z/DYBJfrzjno6bPGWv?=
 =?us-ascii?Q?A730DGx9G/7VfPeljfMHLY7432zt5KPGZHqh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:53.1811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3096cf39-101a-4dcc-c53c-08ddc0cbfe3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6114
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

Add queue reset support for jpeg 4.0.5.
Use the new helpers to re-emit the unprocessed state
after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 974030a5c03c9..5a69a44e0f855 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -174,9 +174,10 @@ static int jpeg_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->jpeg.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
+	if (!amdgpu_sriov_vf(adev))
+		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
 	if (r)
 		return r;
@@ -767,6 +768,25 @@ static int jpeg_v4_0_5_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v4_0_5_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *timedout_fence)
+{
+	int r;
+
+	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+	r = jpeg_v4_0_5_stop(ring->adev);
+	if (r)
+		return r;
+	r = jpeg_v4_0_5_start(ring->adev);
+	if (r)
+		return r;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
 static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
 	.name = "jpeg_v4_0_5",
 	.early_init = jpeg_v4_0_5_early_init,
@@ -812,6 +832,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v4_0_5_ring_reset,
 };
 
 static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.50.0

