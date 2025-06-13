Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EA3C71135
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D71710EA6B;
	Fri, 13 Jun 2025 21:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cdXI3KPN";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19A8510EA60
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRR1wn4aOhEPGym4j3mwfgCUh75EZ3x3xQtVPrjtvfSk4IfaENhPe04amJXt0UPYBniGPStzGm2Azmtqx83OlWRuCX0ID6XYzF1GKCsDWqZRuOnU4O5LWg87pJR6CfVn3Y/tM8JmZzF30iyb8XiqguDM9IHj0JgOGIllDLd0RGTa6anxZOmvRgzPlOPV0yr9QY2C9laLNJPMmcliqYQrVN1xyF5kSR3xVZ/EvfRBlT+067F7EbMPBCp39qjgLgo+cFIUiB+YK5FNfiVdr2Jql/GXROeJTEGHGjrFkwBLNmsUr41pWqz8+P/fm+940KoMcXoSHegeeO4Ffu5oJ+PW4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agnSIAv2ls6qV76TQZsD6vH4N8s5Yk2OVmBn2eT8iSg=;
 b=ghvhHFPaqEzKB5ee5g+ryJGmaE4BAfLOYsnqfohOwOyUcOvPcBsr8wsLIsuwijWHlnc17JLSlHy5ixgMi+ZNJEXH6uXgE+vnVSAwSc9DAtnXwDY8wUruoVdkNwslil8kg4jUcN8Y1y/8o6pADvV2RZsnCpsqyYUd9c3IZY3VkcjWif9nmsvkqv4JrewMBDkmZ7RDS3Liq9d4V7LxoUbtZMalJteVx9gb4vIUu6FtZ0ajyn4hJTk4bOEJFOIzI+Kh3Q+O19PYqTEtBvLf3AAUvek+IP0zZbuXjFyJanVhvOCSxuchHLVRSaICU6E6Cu9qQdnNC112tRP13XnKs7OaIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agnSIAv2ls6qV76TQZsD6vH4N8s5Yk2OVmBn2eT8iSg=;
 b=cdXI3KPN5P9Bld0xg+DLJo2UD0tv7/XryrsUq+O5pP/04BrN71Shka3fZdTcXfcnNEJmD2orj3e0rjpB3cnrT++QOsCp4CaOsW57QsmMjy5rFeRDgVai5kSVjBkR41PARA0EeOcY1dM3ILXSwmzGXLucTZHZAkf6DouzJH9XtbY=
Received: from CH3P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::35)
 by DS7PR12MB9527.namprd12.prod.outlook.com (2603:10b6:8:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 21:48:12 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::b9) by CH3P221CA0004.outlook.office365.com
 (2603:10b6:610:1e7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Fri,
 13 Jun 2025 21:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/27] drm/amdgpu/jpeg2: re-emit unprocessed state on ring
 reset
Date: Fri, 13 Jun 2025 17:47:37 -0400
Message-ID: <20250613214748.5889-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|DS7PR12MB9527:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c333ff5-b029-4ec7-ec22-08ddaac3fedf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kQnhkc5fK++evIxhRtUodVhDXASZBK1xe44ZkXZW6b041ksVXOnEaKWx3O4s?=
 =?us-ascii?Q?YKTsOdkug/iBQxeeJOnL+OEuiloQCHqbU2eV2zdJv2Ri5ysQp3TFZUOTJNwr?=
 =?us-ascii?Q?MOgI44Gnw3rOFnk3EJKSw0lCuKHgyZlXbslsI+9X95T7L/BvNfZeqo8P7TfA?=
 =?us-ascii?Q?oAOU7AsS/9DZ0mApHgO0rt+vxWdsGDkM2KisOKSs74/6+EyJ/8omBHncJgY7?=
 =?us-ascii?Q?ilN29BhYGtFNwfFeXrh9PaL1VR1k5Be5Hm650gUdiceC+Eb5xbpmBpMqJF14?=
 =?us-ascii?Q?NLHR87Bzf1XLdSnovV/CGALqvjLx6347RlYAh+A6/ZTTn+NaRbwqs4B61Zq3?=
 =?us-ascii?Q?JSFQzFO5/Jws4BtRnnmFVTWIveWUj/qurSmzhGPfVr6zEbdik89rRpNtjl+5?=
 =?us-ascii?Q?Ns6vCTyFXHv4qrMoeBz6RFzH1A4nWow23+KexWLcDyjkqTNwmqyCHXlHDXc2?=
 =?us-ascii?Q?4vRf85wi3l0V2823cq8hjZSNdTC9kNUXlrXcjzqM2HUsqj4I5M+OLAduT9iB?=
 =?us-ascii?Q?xme6AhNofCRoyv2R2XqAM2mSvsGIN6n6+v0weSROP4FXi1MZJkppibLw6R2q?=
 =?us-ascii?Q?Yqj8ISiKlQEt9QtTJYia2EE8+i2uz7BeXN5tNv76CG4g5L7Qyl1hlqT5EJIH?=
 =?us-ascii?Q?o4rSe3hmcpTc1PORwJZKHPoKkuaeDDv+nsxXAacfROkLST9VPwoN0eA2nf2x?=
 =?us-ascii?Q?5dTXrS45HWzDideu6cIaK+omP3L7wkOznP3FO2W8jSPjosDwGdxHlNM/uSbN?=
 =?us-ascii?Q?ldBGKWvfyIqdN5fdVZZrBhJWYpq2zeKC5vLI2hP5aMupTfbioEzfLZUry9WA?=
 =?us-ascii?Q?mIf3/+kAZ3KMQDtZYW8stj9o/URUhX3cVZnMUU+9SkqXFTuoHx/QKUeNKoXm?=
 =?us-ascii?Q?W0T+id1xWM/IRyumYLMlcSrqfMU4h+7rnu6NtcAmDBbcXFYVnIWtN+eaguEm?=
 =?us-ascii?Q?DFGg7R7ySZdixZVSiq8L7KaaXZKruIpt+5jNkXmeH8NVXAyAQG0RPxAsL+3r?=
 =?us-ascii?Q?cLlM+pmxJ27a5qP5tAaHgwr1rye1PH/ILPjg9INH0VXb8q/nz0VWM7/JDqqz?=
 =?us-ascii?Q?TrvT0bKGl3DOf5+1zyH90QcAggcygxZWL4YaxX6FYLFHZ3GzH++Jbr6ybaa9?=
 =?us-ascii?Q?61PgNyOVwIq8PrRFUvNZVml3k8tEF1kzMNwDqYMO3Y5CHjTZKo4F0dlMERgp?=
 =?us-ascii?Q?gKm/q6Ah3LG9OA2s7O8GK2HqwYd34tzRAgZqCXHjvtm8BouhuknJiLrmFfx4?=
 =?us-ascii?Q?5naVEPPBcxPxSDwB+pQvDvQ4vG5OcWSmR027+E0vrtAvo6Tf2HvI8A8WQZpz?=
 =?us-ascii?Q?9hUuI5sE31Y/EHRxB9m95zjCnpyojqw1b5Ce/antHEe36NXcFv8um3MJIoH9?=
 =?us-ascii?Q?JGns83gyf/2Nh2yy8HpzvfTcn0nHeHcRDusMasbuibzDQGfwkS9Du2/Kogkk?=
 =?us-ascii?Q?q3uhccdfOr61avveSMbbWygXRIp88Hq9F0qTmgZnVzx2MqrPRTZv/eJSmxlF?=
 =?us-ascii?Q?FoHOqNhJolqeWCFFZmsXt2SEbnJmN+mcEkB2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:12.7359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c333ff5-b029-4ec7-ec22-08ddaac3fedf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9527
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index dbc28042c7d53..f6060256f28c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -770,13 +770,21 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
 	jpeg_v2_0_stop(ring->adev);
 	jpeg_v2_0_start(ring->adev);
-	r = amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
+
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

