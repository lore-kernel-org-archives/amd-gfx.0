Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854F9C4345F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 06:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD39112155;
	Mon,  6 May 2024 06:12:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qtShq246";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A79DB112155
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 06:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FW7FAN22/3AQNoXfvKDLOgaVQv8LNjBiwxugpjwIwYhfg6VDRfauSRHmSB7RS0LdxnKKbblMq9yEaN0MfbRrQem9qm19hmT6+y3Y5YjQUWmHhEJT9HYfYJrp67001v3exUvtzIfiKvCnFc2GeZERT04NMFV2qXow2PzhgGvVKeMTb6oeN+2DNYDn8cYbzJ9olJrVNtH6We1AnlylZc+UWbWBa4BGa7ZlqMGLezjtR5dKbK41+abIYaALd6wUmglNEinO/vjcNdAIhgi0IJSDeqts8Ggg73jFSLBNagoLb+12fpTGV77TuFplcBI5lWW5jqzJovYHE5iCymeKE135iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7/lZn7PWdrgi2pTPVPn9izxub5HEkaOshrF5izB2aA=;
 b=aV5MwJI5qySsUOATFEbxZQtO6BucgzmD29l/XJQyLlJxIK+H+lGWnDtBFxyU8nii9uUYL8pl6E8AE8VE6+SpPAJQsZGhxu4qjGx/AzUL9uf8HL6hcBpOaID+93EsnsUt9iMO2KEcxnV73mFEF34f9NeSsKxOG/r9SlHEnmu5WO9WHB9VF1fzrBibGkjz74arb3q/lFHJ3rSkbVraoLXZLoycDVQCoqaCe29eYmRX4WL5v1wSrIxCRvGLETp6R+cvpraRZbvyU+EyoZM+loHmu/hV9dswAsZpPXR+xDE4PdQ0Fv9a/01aZrH6BHx9cKqL9YU91ZrpVyo1q+N9MKVuFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7/lZn7PWdrgi2pTPVPn9izxub5HEkaOshrF5izB2aA=;
 b=qtShq246otEvm5Q0pB7NOIvkxaUmpax9udiLNcUBr6qG8Vpez3eoXByKIh8087NlkFJ9k5LoSamMJytT62xk5MqiAu03akP7yb3N1RqUVmV2Ng7UYrLMjdJxLDluU88AeRO9hRkoi3qvlj8X8DM3MC0KTRDhLmkapuqVav50W1A=
Received: from CY5PR14CA0024.namprd14.prod.outlook.com (2603:10b6:930:2::30)
 by DM4PR12MB7669.namprd12.prod.outlook.com (2603:10b6:8:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 06:12:41 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:2:cafe::2f) by CY5PR14CA0024.outlook.office365.com
 (2603:10b6:930:2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39 via Frontend
 Transport; Mon, 6 May 2024 06:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 06:12:41 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 01:12:39 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: fix uninitialized variable warning for sdma_v7
Date: Mon, 6 May 2024 14:12:05 +0800
Message-ID: <20240506061207.2017901-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|DM4PR12MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b33951-d4e6-47c5-5ba1-08dc6d9389b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+D/st7NaEdRKqSMstuzs52i1SqaC2avqejqmAhxm5xGzdy168NkH6SYyyqRE?=
 =?us-ascii?Q?vdWcBVEhX4G25twkh90OZnw45YM8D8MGlVOZ3ul5MNEk2yx4qzLRRYOtayDg?=
 =?us-ascii?Q?mx7A3RoAKJqoHncO59Q0aPc2lB0GI0T/9BLTayru4EN01mE9CmGsl1OHi6zB?=
 =?us-ascii?Q?IayGNfGfbFyf4dfXPZ/1cTAlGvsHBZSFLJlE8fXvDL7uY6PODC132Hy0HJ53?=
 =?us-ascii?Q?meEdjAZ32vKaZOcGmbTrbmc2cC+WGRyiczaW8NYjVerWQw1Qh35r2+50fGMU?=
 =?us-ascii?Q?1J2fdGAQuML7CAoth8EvfO1ApUtIOA7g3/FjiE0nZXjM7aCscSPqudLBMC7Q?=
 =?us-ascii?Q?4avBcSrGtZcrsOmgDdikP1n7BUc/vKHbaS9CBvfUuy9thcj6UIBYPx6PeELb?=
 =?us-ascii?Q?IWRoT/JOD9uDvMsskCLgpWlk6h7ckT3fcjroB0ny8Pa6AwZj5oDbOAwp9lEi?=
 =?us-ascii?Q?8hEPgdvP2X1PQHLPpioxZlF9gOSZdhlvkg/rB+JvBAEFlW3qXLyy03bvl98A?=
 =?us-ascii?Q?OvZC3FFKIXt7HSDtPavQbQ545AhURBqFgY3mlNr3crFe8morjHSDv/EwUVbw?=
 =?us-ascii?Q?DDvhtTxNvDfv6sfOjA9Uqdl/1KvyPswGH0n0Eo71+AeoGL5ZisX8IlU5zIe2?=
 =?us-ascii?Q?Gu9ZpAFa+lwneRWhKWMubRy4wNPFXkZZrYMgE25Br/Ky6wLvwDfQUZEDHeQe?=
 =?us-ascii?Q?HG+c8B8yZiV7Q3lzp+AktK+bNdiRw5oorMv+LDxKtsvYYY3NmbIq99db0bKV?=
 =?us-ascii?Q?AJzg9c+UgeldbMcf8Cq66Nm7JC6TDC+AmIhxufSFWT22vSIQdv79cTZwmmK0?=
 =?us-ascii?Q?Shnv6tEO1f3nMhSUG0Z9vmvsii/EKQ3mGkjVS0NMEfR+Sx60FNfWKDRuVTNr?=
 =?us-ascii?Q?NqA9hYgtwkLpIsdVZNG7rPe7L4AZGQGSwFowl/hOtbOC9bUgy37jD0oxt1zN?=
 =?us-ascii?Q?HbvnPgmiYmn8F6Fwzngid/8A8mSzG8SQ4vR271VuY/3EBXVBFGAxwpgLKoWT?=
 =?us-ascii?Q?0poeS2WKr6pNdrz26m/0+UCHtKXMxvHGUA1SItPqhSV8wqzcnylu+Fj5YS6l?=
 =?us-ascii?Q?O4tegPkJ4u1UUCU0e5RoAi63coivbZwAPJUmmh/0zvHlP8yqTnWM0mW/FjHr?=
 =?us-ascii?Q?3PWANrsQryzWw+U+yv8Xp3et6obPxnW9kuM+3/cjy46gyRy4BMIfzTSJGIPV?=
 =?us-ascii?Q?EaDEmT2xFYm13cV+cf/P+cxEdADFxnLg+fmnW/U6Dsp+5HqGPbqSVDS5USlX?=
 =?us-ascii?Q?eFJRAk2KCU8F/4CMlqSAGB+0Ipj2RfBHKIFdvVGHZpwDFU0qzvTXfdNiOzPq?=
 =?us-ascii?Q?nj2yc8K+ndA/fJlDzEsy233Ob5uGvNarzRucEdAXYB2dYV9Sp3gqCkHsiN2Y?=
 =?us-ascii?Q?X6UX3xvvUXZSm6uRyB3reGiHM2wh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 06:12:41.6486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b33951-d4e6-47c5-5ba1-08dc6d9389b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7669
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

Clear warning that using uninitialized variable index.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 35d99a4afe83..0b5af1c50461 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -876,7 +876,8 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_ring *ring)
 	r = amdgpu_ring_alloc(ring, 5);
 	if (r) {
 		DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
-		amdgpu_device_wb_free(adev, index);
+		if (!ring->is_mes_queue)
+			amdgpu_device_wb_free(adev, index);
 		return r;
 	}
 
-- 
2.39.2

