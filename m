Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7267C5AD49
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C2A10EA07;
	Fri,  6 Jun 2025 06:44:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YNh5dW1l";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A97B310EA07
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmgURENmBlwU7Xl3NjGVELLw4Jc075rXB1RY3gWXu7Q0/xoeyoM+YwVoUz+oiBOgTVXTCwuoeFRwaGeu1MzBhmPRa8eRulXN6ZP10C04puSZftmiJzg35xe5ES92mLrl7zimz2nvicqnCCxhDVGNOsI8r+SyrD0aohP2aGVij4KLywNClnkQPHS7jQrn9Ft0XDdHoeYd62MAlLnpkb6OvJ6Id+ynr4K9bX5mxpRDzk8HL2EGjYoYuaQib5spsva4geybJfAv6/OJHarGFTJYH97zvjDbpO25CY6M0SzSkH8zma3KfMrLYcVGTIweyqCWpw/2p9kGUkYPz/xNEDeAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmKumLtAoP/zb/A9HA/MDNrFX6bdoP0a4x8iAjuuKL0=;
 b=zHmWeY/oun9afjJfAuRM3dWjWvUQYO1I4LSuxT6aMKWniF0KxhZdZlBkCbue3NDRxlVNY7R5DTzvgNKbTq5nA0DwvOfEccjtwNJQ1YcIsaKmO4rCNNsAMgTjKydwY5xd+meQXXpjbws4A8/gfLFlybMYCXK19Owz7is5tszry7fgAizCqQpA9mrllJ0PpTkv0VjYfxI1I1gw3n9v0NLkPT8gnDaILy9JjKwPYIBPLrzmXoqS68LibdN7n3nTthSn4cUHrjXhLpFxY/EcAlp50DqA4X6hINDB6HlO6H1WEGET5pMscskIUXjrFaX3akl/HJ5L9QsfRVsadsdH26us1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmKumLtAoP/zb/A9HA/MDNrFX6bdoP0a4x8iAjuuKL0=;
 b=YNh5dW1l6meaVBcEZo9T/vHMYMGYuKoi0z2H/hoBYoY4BbSdpaUxbtGEQEujGeMOp9QECOggHSMw6hTX5GsonC/V7EOlwokAcJAJKzRq3vBdrGzHVtpiDZhG9J06j8tJWQKaYtlTTORsnIYs4mzOLWUlEok/SoJLaM+RfDBn6d4=
Received: from SJ0PR05CA0133.namprd05.prod.outlook.com (2603:10b6:a03:33d::18)
 by SN7PR12MB7298.namprd12.prod.outlook.com (2603:10b6:806:2ae::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Fri, 6 Jun
 2025 06:44:28 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::32) by SJ0PR05CA0133.outlook.office365.com
 (2603:10b6:a03:33d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.16 via Frontend Transport; Fri,
 6 Jun 2025 06:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 29/29] drm/amdgpu/vcn5: re-emit unprocessed state on ring reset
Date: Fri, 6 Jun 2025 02:43:54 -0400
Message-ID: <20250606064354.5858-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|SN7PR12MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: 46900970-cfee-4ffd-1dd2-08dda4c595ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S30atzax4v5Gco7gdBzx9Ni0wu2er6AvcV4POGk+wzW80uVdTu84z1LSmFJQ?=
 =?us-ascii?Q?WxGIlEUmRJJcd/HYBTdIeWaJiHWA8qEIiFTwWZelOPyr9VDMzS7jevNylhcL?=
 =?us-ascii?Q?RvmzHVJgG0rGYR7soZbv1qAboB6FIKrHy/kPKhIzJtJ/yQ8OZHdALI6V6dXE?=
 =?us-ascii?Q?9C2zCIvWMPtb9aCHWBQBIljPtfRqKbi7aNqOJLc4niziojdZYBFkjA7v+SYE?=
 =?us-ascii?Q?M44HXFeCCA/7/P7DoRtnoN96uGuNPC6ReTMPrtDnB7EdR0ou2q3VgMwU6Vm0?=
 =?us-ascii?Q?Faq7sm0GtL5QMxBEPyq7npsS2t3iVlJjvIlU0ibhw+yRme/7jan2aJMR8U+e?=
 =?us-ascii?Q?P8bcqUzvtRUvqkUyJIq1kFl+vdOPC1eNA+MmgiAb59WISwYwchUuVFIv///7?=
 =?us-ascii?Q?2v4GVh7JcVfZEL7shhMquzeBZZZ7WL6/v6OYD/cbRIh9Ja28sTYlh2vCrWkV?=
 =?us-ascii?Q?UO5gOE7skmlh1UbcezDtDKJFLqlLVso/sGRsK2oIZXwdeV6rREZer+zB6GPE?=
 =?us-ascii?Q?CAc64/H2EB6z7dkmDosNl2HhuejRLf+7YtNpcjPO1bTAiEeJPY99FyapuGTr?=
 =?us-ascii?Q?Qj+h+RTDpWd6/dFtiObFXMgoPmPM22HV6m5ObEHXs0f/vxHfSXkeaGY80Ys6?=
 =?us-ascii?Q?9ckdWxKW3I0k/jVZGQUrJXJhmesrv+XonP8cfR6BazK0NObGZenwS8WNxSow?=
 =?us-ascii?Q?VWjiaqEi+rpqQxV3ENDyfBYhnlzJOcK5IrXriFKoM9I22Y0bv4Q1SeqGgtP8?=
 =?us-ascii?Q?rw0yB+MmYbnbLorNwyfA1UWlnqEpJoluea4AR9IUPG8MXLraZQIzJaxvazmn?=
 =?us-ascii?Q?85yDBHwMxH0+llpWMIs7veG027rDz2V73biZCSkTganV0JLLLgZQb2OMnuWH?=
 =?us-ascii?Q?cKL3EDj+QJIbWTkMA2sC3QA5wmyaM0KaoFZhTXUTaCmeb+dfEDaF8MAcvOhM?=
 =?us-ascii?Q?IqgS0hDao6DWGAQkti7lgdI+M0ObIj7Q4jaP2dEJxP8/7lqSy0ijXvinoFBd?=
 =?us-ascii?Q?bYL+wmzIA7lrsBruJ1mhouYoaNoS0PiVi0uSBqGTSbp1q/WDwR4wnFj34FG/?=
 =?us-ascii?Q?rYunDGcy87RylTlnxkToqw5OzjxBJAozRyJgGHRe9YfZxvvqhAGlyJqSctNU?=
 =?us-ascii?Q?wkcsupLKn88ppngbzWF1bVgNNo7igu9z5Dz8bCUEjaLsYaE16IOGJRERx7gZ?=
 =?us-ascii?Q?+DKss4zTZ3R8ki1FDlLPKYnZbOnXjkX34SJXp9uNDKuzCG6uTlBAadkHUvZN?=
 =?us-ascii?Q?6P70Yh4FjeExwDpUkQhUDwbAOFbT/7Ye62iK8AQlSqVcmKFu3zVYLWNNCD1r?=
 =?us-ascii?Q?URMuiVP9ZjecLSdAWTBk+Rx9QFPe/6UkXFEFi6EWXYW7Hr/yaVt9mlCtgJ6w?=
 =?us-ascii?Q?PqmxCY8ujMAg9nHA/z8nAny1eGXFBaS0PZobbYJyEhtgkaeOMwz9eMuTjlvm?=
 =?us-ascii?Q?LCf3wKi514bsm5txXFd7/U7Qcl72Yl0A9liwUMp11a1LUQYcl2igun/O7Ue6?=
 =?us-ascii?Q?cZtnYsEcpV3nPpWqCi3EhLNkeM7T6q+bWg1a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:28.1944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46900970-cfee-4ffd-1dd2-08dda4c595ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7298
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
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index d74c1862ac860..208b366c580da 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1202,15 +1202,23 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
+
 	vcn_v5_0_0_stop(vinst);
 	vcn_v5_0_0_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+
 	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
-	amdgpu_fence_driver_force_completion(ring);
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(&job->hw_fence.base);
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

