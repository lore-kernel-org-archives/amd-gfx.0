Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85107C3DA63
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FFEF10E8C9;
	Thu, 18 Jul 2024 14:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f4WBzPW8";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A6410E8EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzhJJ1vaD49cx7KHjdW1SgtrIggxQlxrwIXBNuP8HGj2BxkxVC5idF6OXDgulauEG0JYlbPOrZq/WpvJKQyaSDlm2z7bLbp1IkJr82HGRyvBnWdqCnx1ZAT0tmYaJOzVrQGHozWc36lceRr8tyA2iY5iujOqwCWDNqutUSMziTmOxoFmrkHtTaTAgVnw2VuNMVP6iFjDAuda13x4/TsRwRoxgRD+/w7DVZHdarnU1vVB2lhCEbAJObXc7tRFka7eWIMmieaNloyVsMhB3Sjj+cZ7g1md+f00uzEvUpN1+MxXnMLCJDpZTRh5gCWqvhDHy0+cL2TgZFgJ1K9VYKZXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n66DnahI6yG7q44T67ImGme971AhajuUI4ntBlONyZ0=;
 b=tjG9SS9lR+o+5h0PkD6va0w5XtcG521Vdeg57tMD1ReQ/aund0awybDzbZPg2HGgl+PGxnxKM9GaIKWzvU84rGyt34pqyMwS/gd4PiVGxMSi7yHiMJTVx2URwpvpB8B7AgFt5gZRYpeWfSgY+AcUeRMMXo7W1vUgjL0BFiKpi+vLAot/gKaGXrQlwuV/xRipbzgEv39/cJrGbGh5r4Yy7lFSKzK1IxbsJnIfiZ8TdbumJBSiwXsxxI5A+tCijeyGT+AxrcKwJ28l9MsTEp25u+7xkIe76wqaYKSdfXupXiM1oy/ofmi7twZR/Yt7q02LiYKHc71CM6tx47exaEEJNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n66DnahI6yG7q44T67ImGme971AhajuUI4ntBlONyZ0=;
 b=f4WBzPW8lKAHL5HpLWTP18n1T7otwX2/fxgNul3q67zxGNIDAN+2Yf3fC9fRt4V8nJKmTj7TAkphQpBMLZ2+UAdabBveOTU7IUWPCvo7e06uDgahxifaLQiv0U6ja6+yqyHjWYNQnpeJlk60ZCvV8D3EEyypnu6CtdTStyRHL+w=
Received: from BL0PR02CA0011.namprd02.prod.outlook.com (2603:10b6:207:3c::24)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 18 Jul
 2024 14:08:01 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::24) by BL0PR02CA0011.outlook.office365.com
 (2603:10b6:207:3c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:07:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/34] drm/amdgpu/gfx11: add ring reset callbacks
Date: Thu, 18 Jul 2024 10:07:09 -0400
Message-ID: <20240718140733.1731004-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef63e83-cdab-4752-776e-08dca733089a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LMzTF5BAE6D1y3WDRp1RmgArMiX7Jd3GKtsD7N6M5BFfnUs+Cbf/pTgomOWE?=
 =?us-ascii?Q?beqikD/vuiovCWDqGxH2RiMKIhATuso9h7pWBy+MWdg0Id0jHaoYM2CyYQbE?=
 =?us-ascii?Q?0hscHh3yeSrEpcpRSRxrGFgEeEaszp469p0aKNX/LwPqH7TxGTv9gQRP1WVd?=
 =?us-ascii?Q?jSpKvha2sz6Q7rhjB0uPa+YOqQSdDYiMcE45iIdM7TTcouSATG9lCGfRfkFN?=
 =?us-ascii?Q?aRIvkN8sJjtKXqyIATPizPbAbd6x0o+EDjN/rIuCQVUQwsy/NInaXVre7fdC?=
 =?us-ascii?Q?1vkwjMLwGL3QCc9RMpBggACbNMnJ0xhsEAaeB5nd9omaB/Jeh81SUTeFfE59?=
 =?us-ascii?Q?6xZeHLgvg1MAyV3yiAGlKYWPaCHYrYw9+SbYzrem5m6C0FfKx4UCN7gcu+eA?=
 =?us-ascii?Q?o5cvoilKNeSpRwlmTaUgpIFLDbroo+cft3P7M9FH3nVRrc7qxt75Wdr7c6YV?=
 =?us-ascii?Q?edjH2e+AnjqhEZUYDjDB23SpFez8UnqJ6CDPu1lMqc+o5+Mi+lvH6ud77CX/?=
 =?us-ascii?Q?L76ERiejNWCXsTl1W0SCO9HiA0ppGuIzV935vryOQibub2Kv2l1zez4oL4It?=
 =?us-ascii?Q?0jPaYVmj5hol+yRW9aNOPyG2sDfa8MhuDWp+R1NYFa+M21yxYJANwtqAoFNF?=
 =?us-ascii?Q?sTMlk2tumrtKQId+UeTqoskTnzGmjCBaUZZB5KljkIK/iOkEADvhgaH4vlA+?=
 =?us-ascii?Q?Q0/0dvLQJZetVIiJgWX6r1RuAN61rD5DhQXZw30VA9G5j5Aq4wg+hu6X0xRu?=
 =?us-ascii?Q?J0W6m2W2ZRtl7IAvLBCXxdYFiFa8Fjlf6KjxSntQFibQQNFfSwRXY1e8YfyT?=
 =?us-ascii?Q?K+Rmg9etp9tvqqO2TENOvFb/GfojeK9nlxtefuSVZWjGRO0D7pQGa6RmHnmR?=
 =?us-ascii?Q?cfTh+e4Z0zMQSK9OW+TJkHQU8GPmxAMeY2G+iICpS4DjsSnoFPzXe0XvBaa8?=
 =?us-ascii?Q?0+H3d7e85dj7N+CJXm46QXIxGJfWp0miYIRdAUFKDtlVf74BkLulWLUvZYdx?=
 =?us-ascii?Q?g6a71nrbjiLRu3K2+vlaHHMZrT0yowU27n3IADFr6njhlFSohUhATVuskwDL?=
 =?us-ascii?Q?E1DefRDeBKd3ppoOCZxc/mc4GDMZb6o0Qom1jqJgwE4bG8RwAJhJNKqqwD9A?=
 =?us-ascii?Q?3y1WIK0O/NdrbBufga+EZkDbSEHHhKiq/i6VlQ56lB+vh+lQsHBT3AYHNzlc?=
 =?us-ascii?Q?2qNZT1iMjHQQ4pyk8CWJ+yGg6UcmhfoW6v8Ca+Wr3A5WNx4/tBEGTpcSso9l?=
 =?us-ascii?Q?myQaKo5+2npf3INsPbhR8IQYFRwSwx6Z/vYi4EqWJyJMxho6aRCtq+1MwwrS?=
 =?us-ascii?Q?P9XCmn+hR4XTpAjQhnGv13yDnmFcd/tkNcldqtYG9gkCJC7eMZtAM2JmigCU?=
 =?us-ascii?Q?bRROZObGfS1Op4emI8Ce5H9XwbBMDqVPpZpULsf6e0k5Ig9fpfpSUQ8So4yE?=
 =?us-ascii?Q?2QXE/V80D4R/kdwxfAexPezXAk5rJ7Ca?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:00.8498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef63e83-cdab-4752-776e-08dca733089a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538
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

Add ring reset callbacks for gfx and compute.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ce5cb60b8628..56606c6dbb15 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6520,6 +6520,22 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
+static int gfx_v11_0_reset_ring(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	int r;
+
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid);
+	if (r)
+		return r;
+
+	/* reset the ring */
+	ring->wptr = 0;
+	*ring->wptr_cpu_addr = 0;
+	amdgpu_ring_clear_ring(ring);
+
+	return amdgpu_ring_test_ring(ring);
+}
+
 static void gfx_v11_ip_print(void *handle, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -6721,6 +6737,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
+	.reset = gfx_v11_0_reset_ring,
 };
 
 static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
@@ -6758,6 +6775,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
+	.reset = gfx_v11_0_reset_ring,
 };
 
 static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
-- 
2.45.2

