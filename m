Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FECC52D1D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4F2C10E86B;
	Thu, 25 Jul 2024 15:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N2MNG/n8";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E8510E868
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MD1UMWN7nzbcAXp22WMLXJTYlewkLrG8l538+7ofZ+aPXARw4WKwvFoo0wOjoXIFtQ/SIsKMu1FxtcmIKFPNX1k0g4TAC7ZCK7UtdINPu3tBTOJ5a/CAlO31jESRz9FHbyqQugGY8Z5u/oSmFlTNqf4bk5jrbGPaizJPafOdolp0hrJBLZjuxIYpamZQwTrFhrMQubvmwrhQQVuRq3LlYnFXUiyTlXMkeSib/CAcOq8bixQSf0WqXMsgNvkRyU8CGKmorCVKK2JMx6slqvYwpx1ZsaFc7opIxBicuokW4znhDs3s/g7LGPgTniCSExDk/JWlR0ZW4wlvWO148o5MEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjDHt92Bh6RnI3MdQNXt88GFIN7LB6ttliTV0gDGpbc=;
 b=t6qDMXujUewbaTPeOS0zM+ssG1tIYmUDJH4AWq/U9a8vgE9j+UBc9fB7WIB/chjn1GBDkcBu+Kzeg4Owi+ckmyS0RGoLh/dEVN7yczEGwwLe00TmqD3s5r0YEMsANjNHrnbQgTOkUKIi2h4TRCCg6w2BDrJFLEotgLc3H+XqBjCu6S5glpHmTDkoArL3hWw0vIMdV52sa+PL5bsHSeP9CMjDe6huA/z20CUwX/MV0kwgBL/xicMv1TJDeOygJ9exDxQOEXOTrlKqvl1FgO0ovKn/RqBv5rGuacxXUv+aoblqLcD9dfokJLkWZiin3Gqeg2AE+v1xaPX9h6qa9yh1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjDHt92Bh6RnI3MdQNXt88GFIN7LB6ttliTV0gDGpbc=;
 b=N2MNG/n8nQtwE/2e6EU4N6iUhZ9kqDjoQgTxvehbG0ZEw6bHwTVWGYcU4z9hb6V+1OngSWLa/c+1tA9wrfABwHWM+ifJ/MwUWuZAhsR8Re2Jg2Jk3I01WPEPPKpjdHIBBDt1Wf8Y4OVIDcKMXfsRXo0wQzHU7amIkHHTTlDpvb0=
Received: from CYZPR10CA0022.namprd10.prod.outlook.com (2603:10b6:930:8a::26)
 by SA1PR12MB8948.namprd12.prod.outlook.com (2603:10b6:806:38e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 15:01:37 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::22) by CYZPR10CA0022.outlook.office365.com
 (2603:10b6:930:8a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 48/53] drm/amdgpu/gfx12: use proper rlc safe mode helpers
Date: Thu, 25 Jul 2024 11:00:50 -0400
Message-ID: <20240725150055.1991893-49-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SA1PR12MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: c6611c9f-bffc-40f6-3d4d-08dcacbaae6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?66t/twRmXZzWBkKCJPq5sCQxnvdkoRrMx2yY8hLIsWuvIBIEG/4WLGF7aqKX?=
 =?us-ascii?Q?SXtCU1i4KT7f1v4PhUQRkeSiZBVqBzrSw+HGifIzpcHMs9NTvwt7AqFlUw33?=
 =?us-ascii?Q?mDwhOhni7+jLS/f1WrWYGCmzsmdwY9IVxjXdPxmSMtN72NuEBTVARAYOMJHw?=
 =?us-ascii?Q?aPujUbfREYS1lA7513ICsq0nYw00Jvec3cDI3zCJWjLGdDNS/ugr0TQij/wY?=
 =?us-ascii?Q?BGSayiE1dlGAV17INBd4rNY4x4DSQhQIgpsIb4UWlkvekpp0Hs8LRaHcFhIP?=
 =?us-ascii?Q?stSxoNrAyooSPNiWCFOZRfcT18hBeoadglmHXI35PjoWxyQSWZx4yjBy8M9B?=
 =?us-ascii?Q?cyK7NonRzG+KPEFt6w5WpPGCOU37a1xK97D22o4xt+byPwtGM6DNWor1WEkw?=
 =?us-ascii?Q?jSYOtMQfwc9pyFH7LG1knxcd/ynHlAMftHihpkMr888dhmbUa/NB2vO/K7Eo?=
 =?us-ascii?Q?1rrioxtYmEjEb8XvppYjK2sDIc02erEcxgtFp6YwBHdtW73TksWmmtuDLF8O?=
 =?us-ascii?Q?GYGwUd8GKgAZs8vuLzxdkAjT/bwkjdjdb9m8kzskPTqRj3JxOhJiuK1NMrC+?=
 =?us-ascii?Q?zsF/qPGbtLtm78gKsmcAxpewxY/ZV4hafk/fDCucNzOcbRnr0cL61V5rUgSw?=
 =?us-ascii?Q?Y/rZt+k+XwrvyL30VdYLa1yLOToJwcR96y7rB8Euq/6gS3X8oDxyfFS0njAQ?=
 =?us-ascii?Q?779EashvL1fYaJDBYMYK7zjOvdLR9N1NF2s4pfXLLGThSQvmDjMCNIuAzM6z?=
 =?us-ascii?Q?AdIiFdJLZHdE/BxHtRIjJDLb/kpc9v4fIziWR87w8t+0SF1bJTpzmxFGLTLZ?=
 =?us-ascii?Q?kULIhyMofwSmvnBOYj6ubcDcDwyfw8B/NcbYtQ3LibHw57J5mJ1SRpW+lN0p?=
 =?us-ascii?Q?/Dhp6wtfaQu1TkU+pMm33B6Xvu6MGdIJq4/CfmOhYUg3GqoD+c055rxqSjWA?=
 =?us-ascii?Q?QUFWTn/KVI+BZR7jFanc0VjlBRBkq88BCRnOOfUlmO0OraVIFZXjOSo5Me5Q?=
 =?us-ascii?Q?G5gWXgNznoahyDuuWowXt+j+EMDCW+Lq2OG0rwFVGXWNiLrFvLBIIeUqP3PC?=
 =?us-ascii?Q?FGzv2+R8SJLmyozZSHmYdbfxRGqe2QJggbVwHyY35DL3p4t/AC/WH3LHT+N5?=
 =?us-ascii?Q?hs0IEKJYBLX+IUYzdz6iXQgsVRX4TuLo7x+I5ontaN26oJ5Sbz+V7wVuX0Ev?=
 =?us-ascii?Q?U2HuZE8pwSZgx0erZlpw0RE2ySeS/4kqwFBVqnTI29ZdeNieQArb/qrj5RFP?=
 =?us-ascii?Q?5pf7r9p1MbpOewox5VeagTdTTEIDLtd0IW3p3yxZe9kFbFsl3hsCBOE5narr?=
 =?us-ascii?Q?yL1RkD1D/C6OxP8Q0mmctDd0UA6Diy6rvKaI56MeoFKlKonnaA5gxSslybzp?=
 =?us-ascii?Q?HnTn4eBT4umW3FYAtTLKEpHT+cz2uLkbyEOukiffM2NWCkIWClWMb7dzKawj?=
 =?us-ascii?Q?waRvhUAJztJJ6V5eQfZz+ebw3+UQL/sW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:36.9028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6611c9f-bffc-40f6-3d4d-08dcacbaae6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8948
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

Rather than open coding it for the queue reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 7812c9256566..4984df3a0b75 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5183,7 +5183,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	gfx_v12_0_set_safe_mode(adev, 0);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
 	WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0x2);
@@ -5195,7 +5195,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 	}
 	soc24_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
-	gfx_v12_0_unset_safe_mode(adev, 0);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
 	if (unlikely(r != 0)){
-- 
2.45.2

