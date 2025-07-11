Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0C3C83F28
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0818B10EAE6;
	Fri, 11 Jul 2025 22:40:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="auN/eGrn";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27A3410EADD
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCJ1A64uWx9ct0oN0NuwfLhHVA/tEByRWHBMMeMOcKEzEnM6siVhowO2nVunI24BZu/mPgJ+Kcv/ZmBnGz022fOZUFbIKXyfoyIMVpxFc8LbNmxLNbLwfKnx0Hhi6f0NUZh7QjYdkE+vjTrOI9Mn9nq5QvHv2g0Kh4YS4MF1ARSjltrNnGjKVuAFb4JdUD3o/MhJ4GXb3FHElWH3xj3q6f45gJGL3nxOzezt5eMXM2G8sI0a5Wq0Tr9l4/Xby/qCLnZ+N1CnokZ8p85UYZ9d6XSAyYrDhLdvFHbqWOzmEohJ4YvDTYc9qU+0hFxw6niw+lOnOE33FdN+2s/kmuOuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RglbqRfqhkun027hDFU/BEyLxnQTr8J0mwPIK5IPRU=;
 b=tRX2hAOZT2RyZN5W9ZWLzFMg5mUxpFFCYoEp+oRTHaqbODd1s2iP0uGLUQvz918jB0v2F22kOuSTppZ4N7WMBC38CjGIE2wYLvQJwJslLwTIS+23+KuQZRLxG6rvvVtOTJTbVjzphbRd8IptTu6oCiQb4KfTWzEwT87onF11g31X+2X5vKthX6C3K/0jXMaTqpFlXe+cVrbGrw3hP4s/1YSJAod6JxTugVyoZjCU8V1u1wVto+JUYnPYL/WS41chIz84g9uaEYb/NN2q+eRrerFYJHnZ/jVPkW7IDtwotw16C5hMU5Z9i4+/Mg4Oo098ZtVxe1Ev7SFA/iMtBdlbaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RglbqRfqhkun027hDFU/BEyLxnQTr8J0mwPIK5IPRU=;
 b=auN/eGrnpRtL9vNsEscnKoEd6C11S062jl/tSnFwHePoS0YB3bBEHSo+xesq4uENX6EoWQtsHOwkMVyHMmLzn+7NtvzkrWvFUWDWng9HZZBiyYbKEKxJ2zx9jlzlWDf86ITyPGWA+UlKusQw6OTH/b9owT+1ErvWHeYfA/1m5C8=
Received: from SJ0PR03CA0221.namprd03.prod.outlook.com (2603:10b6:a03:39f::16)
 by LV9PR12MB9805.namprd12.prod.outlook.com (2603:10b6:408:2ee::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 22:40:43 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::c) by SJ0PR03CA0221.outlook.office365.com
 (2603:10b6:a03:39f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 22:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/33] drm/amdgpu/vcn: don't enable per queue resets on SR-IOV
Date: Fri, 11 Jul 2025 18:39:56 -0400
Message-ID: <20250711224024.410506-6-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|LV9PR12MB9805:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e08c90-294b-456a-e61f-08ddc0cbf834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YM3eXmvUVwE1Vm3p2e+1j6bRgxHU4b9SMi2enkfWBxCKQsKMYWuef4HMn286?=
 =?us-ascii?Q?l08rgE3BGsen8rci8OQP75+PrPE5pZMxF3pbV1aKJ+5oaM//Am1cELa9lzSB?=
 =?us-ascii?Q?jOGi1QhIvTcUHiSkxr6t2V8EAqz+WsnY2GvYBW3ihcYN0Bhxig3QuQeSHNGx?=
 =?us-ascii?Q?F+PT+7q4CgQI6Zls5lfe1KC57n9eH7iIUggP9ti6m29VP7F8ysCO55O3VHxe?=
 =?us-ascii?Q?ZROPXEm0OMjMyqkL0ESU201yIVsGphY/2qu+sdJm2J8jT76OisGal31ccT9r?=
 =?us-ascii?Q?Ms7CO8iINqTcS5uHz9TRG6bn/g4KKTZ8VA6+ilo15GCpPp479+W004z7tu4/?=
 =?us-ascii?Q?lHNKiVCbr57t5T02LHCCDLwzKCvgzl1HLhNUfDXIxl9B4FlrbimnLW1/8T31?=
 =?us-ascii?Q?rsAb+Z5Bvtpmna4si6VGJXGYuVQY6K6DNxogwigU8bYKYnW07g49NiXXUmc9?=
 =?us-ascii?Q?vUozkJTphocPDO5/H7JOB5eNLFYv1scqB6bBwQPS/oRv5fIR2PnfY16u8Yf+?=
 =?us-ascii?Q?YplFiv75G/0osk/GERY3qa8+U/v+TR3KAV/2PEB6jK31JlkXUPzJT9SelXnH?=
 =?us-ascii?Q?AG0ntiq2T4c+/LKrgQtXzRaNtg0ZKh9yryWb6wkXHww+6SbXBAXbVKN+9xFg?=
 =?us-ascii?Q?j48Unvu2mQR1p4b2Rsuah3FK7PPYpiXz/Rr2r9nX6nyeHdRRv75vaNcTXFzR?=
 =?us-ascii?Q?l/7ZMAzi5Y+Y5+X8AH2006QUvxF1lnwIjflR75D/ljkmHdJyrelhClIo1Gv6?=
 =?us-ascii?Q?AqCrPXLa03MdoF9PAOSLxIBd1xo9Dfzrvp+6xwvOnK+0jsCy54cgwfUWwpwe?=
 =?us-ascii?Q?2rfNS25MGoxyegPFuPno6HLXK5YknJg4SeFgz0f+/3o3HPtDwxpPsizG/8K1?=
 =?us-ascii?Q?r1caplwFfSGetp3UoeZMBGj7KkD2c4okkDp/jqYIikuqHch1y+npu0r2hm2h?=
 =?us-ascii?Q?e8uOhFOUmyYGRIdsbBOx/YRs9DYEsadb9pcmtsrPbBX7fHAKpZOHQOCo5hGK?=
 =?us-ascii?Q?esRgJTd8jnpleVstN8DAHgk2MvTdIz7DK7zZwdbGq0YiYs88+tYdAcaY9JkX?=
 =?us-ascii?Q?Bdqa/xklqmZbdIYXTF9g3Su2gejGxtrAiReXePL42UAlzBxCxZsXaT/w2cyL?=
 =?us-ascii?Q?jBfGuD0qQ+kSL3NxzvugiwYLw/OIDitxOwiLgdV4F2LYxOz34sMR2O1W2UYX?=
 =?us-ascii?Q?SHCkcX6EUv8ItvMhGuT4Pt4OC/SElbUOIy1SsHDGJYINnG1lR+vKL4x/WW1v?=
 =?us-ascii?Q?kmLaCLMIF1/HKdfUsSQL7gS1WU02R3NvWyjsvwiecHGA4VUoPwglBnIVD6Lf?=
 =?us-ascii?Q?39Qg/bmlEAjY/7waGE6CawsvLykiRfVeBk6R9bPNoSyfr1jS/k1vRqBGMM++?=
 =?us-ascii?Q?9Sp0ZoCuFL0HbOB11XMQtX280BssOS7TeR3x39rK0bbX2AMLnxrE3eyJ+w4e?=
 =?us-ascii?Q?a76CjYdceX+XNsXnGiG4Pz+0TKs1RQ6Pgw7swKACxjs3QsKMDKhSwDd25o+y?=
 =?us-ascii?Q?44/EbaaUvQK4Mfn21LdqyUDJCocO55fwAszI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:43.0716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e08c90-294b-456a-e61f-08ddc0cbf834
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9805
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

Power control is only available in bare metal.  SR-IOV
will need a different method.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 5bbce8544fef0..e6613246d8b8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -241,7 +241,8 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	adev->vcn.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
-	adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+	if (!amdgpu_sriov_vf(adev))
+		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 6000c528ad6ae..732e9a9293d26 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -220,7 +220,8 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	adev->vcn.supported_reset = amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
-	adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+	if (!amdgpu_sriov_vf(adev))
+		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 3d3b4254bd729..a137bef918ed5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -198,7 +198,8 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	adev->vcn.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
-	adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+	if (!amdgpu_sriov_vf(adev))
+		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	vcn_v5_0_0_alloc_ip_dump(adev);
 
-- 
2.50.0

