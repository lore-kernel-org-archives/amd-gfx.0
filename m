Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B4BCD5BAB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26AA210E55F;
	Fri, 22 May 2026 00:21:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KYLtqYSs";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011000.outbound.protection.outlook.com
 [40.93.194.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97D3C10E555
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:21:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWA/wCJBBQcOd0H2RYwKCDbQDX0p6w+fed5ZgKXG0hMLhSU0H9Jpra8l3E0Hbsg7SED/bQMmEJ885jTmXT6/OsjavNn7JHB6dMaFJ0L+WjefpFzSk0H+J+kiJApDAa4OgMQJVFVpf2fds3s1Jb8/OFFe0Bc/WL4Upt9+EsaIz8Jj6qVRIGs81Y7IJOQwtbBod58KJS3dIaScULSkqVFVLwYb9Mvh0/2UJpD2sW5xB1nHvjMk1+FAL6TqimJcgtbhGqCoD1w1rYlUwcTEFDCAGpx1I5fZGwNB9PApdGuv4JT8laY9mlF8OS9j5CX9fFgeBbiLvK3KbGkunFandfT/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRN/krGKWrnhUN3khdbIyooQSlWCYYayzaUfhFV6y58=;
 b=I0G2gNC4k6X0uthX90R5BGg99PfK05a22VBVjHSiZJqC2cmTJq6ZpRiHc0utG0qX3fZU4DN3rsAeQcl4JUyrHhdi7Wac8XruoKeQy2wC51JKceAIUsyTqgq3L8789pID/ST9AbCPCdla7joXlv/J/hPs3sWLsLhdn6dv91pvkd/OxPiOaMcyaU0hzfS2CJA3jpDlyCtcLKkDCdkw9PGs3wpButAvQzPKfIy7EqoSHwPzcZ4jQigEYOtGwAvenXkac22rUfP9JTw71MvxW4JWLwZgj36L2VMDAblAyBYWQ6PsqtJ0CJOnZ8peaFHhEkAHe1z13jFokx9DQ8qJ8Kzb9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRN/krGKWrnhUN3khdbIyooQSlWCYYayzaUfhFV6y58=;
 b=KYLtqYSsV4hRo9hnpQmgwJ4kCOOxaFyQpQgjYzsq0VTCIK/11VCPxU4d+R5HF8XeZhNPgQb08uRxx0o22DUKuAMiW4CE3gYEQFd1TsvvtHfggxDi1SMu18OKIYCgq5lSpMl9Vn2m9WqMSmGA5oj85KKumHpbkFJSIsESivvPzOY=
Received: from DM6PR17CA0002.namprd17.prod.outlook.com (2603:10b6:5:1b3::15)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 00:21:24 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::22) by DM6PR17CA0002.outlook.office365.com
 (2603:10b6:5:1b3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Fri, 22
 May 2026 00:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/42] drm/amdgpu: track guilty fence for queue reset
Date: Thu, 21 May 2026 20:20:09 -0400
Message-ID: <20260522002048.98506-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 721bed21-fd67-4571-56d6-08deb7980e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|22082099003|56012099003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 5yWWCvr+d535EeoDITZvvJh4HJ7JaikGHBeV437m0H8PmLk2TwbFQrFGkjpIuOHIrgEZbeNEs4isl61oKafZklXa9wksjgGk8ASiqX7g2xMjfGzKCKVmCAuQXDilUg4Ui2RdDlxrUuVlG9GHAcDXsaK5hAFt5Vdg8Ypj1C5DX/pMPTyewzKEsQP//BGWjNsqEnsCxLFyDIokJjNvS1QrR6PHMOy2sgIgUmKk7ALzfort14gjgSyD1fTeYys6JZ0kEPXsmK2yCuaiN/czBM7V2eCWAt9EcHyuZQfCg/4u4JlqzFLHG5tr/8AfZ0tTCBymCw/voM58Dz0zljxUr0TOVVGX0XcQqj5qjWRu+vLOS2D9lbqS0B+2D7pqiIGcynQLXrMVl8NLqFW6rzAmi1wJ6AqUzmP1xDsyHhxMnDm555V93vA3nDhmlBMGR2nhzvBwJYYpHKNWDKCPYhdPDV/wCJrq90qjmqn/n7GLaE8vyroxeAWwDAM2IkMy7lFQs+JJlKqemKENrV7DUSv9XePTjWzq5kYimSB2AQyWk6rYpZELOlcOymnlrCiQp0fNFxv2S905vkqby35BI8fb8Vv9baOVJj9++DNhcun4yGWlXCdcbHRdQIiekdpk12TbtfYnGEX45dL+cexVyRN0YBVf7XeyV8Pd1EQDF3wrAFtzOhKsLPcj2zp2Z5pkRZbC4qqe2OPkq97bzCBNX+GmZN40KZB6ZJhc9uVWHEZjOBxGWvI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(56012099003)(3023799007)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l4nC9sj8pO9NaMmxpgpbVmpXoq06PMuSAnaHqb9WUpgWTfCr0bXhRNFdfsr8VSQk1x/SfPd5bBzB2CiSQpP42GGXSjQ8Oz3n7VzbCJ2Mqwaok37aRsxA9fOPSZ0NPuWr3S3Ferz2CvJAbXNrZOTzuDrJGHfB/xVpWHzcMmCg/X9jboy1odZGPMpvs+G63vnDA4plNe0DGPLd9IVWLtpi+wQpaLTgGpfsheYenkNP0jeWoZIZoSlsMH32BiBjZuKrLmAQutR0btRzqbm+EJVhoPeusZIPvvgLDnLsgYA11IKAE0uwUC/RIf1ML5nl19VZ2DmmkBtw3+0utccaCgxOt7l8J1Lmga+AlV8MoOjvFioQYvbOXThSVa0WjgOIzUNpk3YCrAN4T9XKOVXl0+vSu4zYZJ1JN4Py3K26Hj5vVkZZFEB6eWAhu7ZflcY6YGbS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:23.4976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 721bed21-fd67-4571-56d6-08deb7980e48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732
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

If we've already seen a fence, don't backup the
ring contents since presumably either the previous reset
was not successful or there was something wrong with the
data.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 6a43c8494fa8c..a7a6db0bc6940 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -803,6 +803,17 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
 	ring->ring_backup_entries_to_copy = 0;
 
+	/* if we've already seen this fence, return early.
+	 * ring->ring_backup_entries_to_copy is set to 0 so
+	 * the reemit helper will return early as well to
+	 * avoid getting stuck in a reemit loop.
+	 */
+	if (ring->guilty_fence == guilty_fence) {
+		ring->guilty_fence = NULL;
+		return;
+	}
+	ring->guilty_fence = guilty_fence;
+
 	do {
 		last_seq++;
 		last_seq &= ring->fence_drv.num_fences_mask;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 8f28b3bd70106..9276a3bb69de1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -314,6 +314,7 @@ struct amdgpu_ring {
 	uint32_t		*ring_backup;
 	unsigned int		ring_backup_entries_to_copy;
 	bool			reemit;
+	struct amdgpu_fence	*guilty_fence;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	u32			*rptr_cpu_addr;
-- 
2.54.0

