Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B47FF417F3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1716310E51A;
	Mon,  9 Mar 2026 14:56:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SjOZ8v2d";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 372D210E517
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:56:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTwspBTZvU5qCddOudcFK3Uawx6rsY+TUHQo/3dOBB4ATMK+dpcYek0PYeU8PRjqfjL6LEKD2hRRCMyzv/3EEh7xhS0G2kgtLLpVkyXcenTv7HUkQzYVVsj8xWDmVuDMK86bnofUi+bfu2f8GwcS4FZFda6wbiRg8ZPT4M27LuyVkoHdMRV3vDga0QM+IicTmXTi3jPfzI0QbWOWJ0j8G0HOogl4b0mSjS8s/wkB20pRExScsL+ACInhvBR5upxKRRn+0z1zX+05j8s11e3sPLCiPYqC3iZQzyHPSxjgS0bVPOZfiKElrZGyIKB21uKPNL+yGVy604ccgtKpVizBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2b5uBQETGb9bWt0BdbLeJ+sP+/RaT7YM383PtP6tjk=;
 b=WYvtjGyOpXRD0Td6I/k8aua2XYyO2V2T2KotVG02qtAmQE4k8wdXPfyPi6t4gRpd8nh98uQ3wBXl3RTPS2ss5fkyj8yjU0xrYmnAVx1FA7skyv7IiyXwHdVkQB1HpB25Qjo9A4w9zj+flm05l+UljFake1kKdl485OpStmw80So6AEpF9zn6Hr73bs7l6OzGK1pHkCKGoU7ggwyUahy+71hZKkrlZMocG95vmClRI9Er/ywtJeV4k5v24fAXAkIpiZAzsZI5ifRVx598N/eovzr1WGoesyyGgjsnV2YuIOSWSo6Z6Te0jGKzh2joBo+wbe9ZA/LXtm+fZTq5KR0Q3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2b5uBQETGb9bWt0BdbLeJ+sP+/RaT7YM383PtP6tjk=;
 b=SjOZ8v2dgIwxnlZOm0nz2Kykf4ZbqxAdl/i3FHwLYnvnwAAImFfD6E2buIGb3fjS95WbH+Qf8Wq+dHs4k06twCRhMh+ULAK6P2fznQA6RKexZMKuvn3iNUTN8CAPmQiqDRHDvKCaABoFqFpj9FOdQqxA2V4XAFseOEbbYZgM3BU=
Received: from SJ0PR03CA0221.namprd03.prod.outlook.com (2603:10b6:a03:39f::16)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 14:56:43 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::bd) by SJ0PR03CA0221.outlook.office365.com
 (2603:10b6:a03:39f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 14:56:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:56:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:56:42 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:56:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Place gart and vram in sysvm aper for A + A
Date: Mon, 9 Mar 2026 10:56:14 -0400
Message-ID: <20260309145629.2844495-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145629.2844495-1-alexander.deucher@amd.com>
References: <20260309145629.2844495-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 096e59b2-7e3f-4924-2a43-08de7dec13fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016; 
X-Microsoft-Antispam-Message-Info: 78/xTVkmj+z9Bn2L/UYxcfq32Q3+M69B9sdkQW7sVsG/D2lAHnkIAp1UgWZY/bSgih0eEv8O8iiMqquO/tumib0QqUZzwjpLi8r2xlMsi3muP29JcqbUhMHLqb92FJrXypGNYn5q557RZfwd2jOmM9t795Pz9+FYKMmkTqkyb5G6eXri+BErSi7rjd2D8szQ8HN24pd3XMGkU1/ZPBbQRiTaIpxrZymNKJzKWPI3nv3TWZWKkW1LaqodVCl1TwXCMA06JavLkkGxWTuOCnZ/5PMUhjvgRP87pGn+ibhVlJ+gC5m38KSo3W9DpO4mV0ETYyYVNjTWARNy9nb4cRpgpqX2CHUlQ1H7puAcFlmc+6ChgsHF+enmwrb/mbhu5QFJoRgmeaIfHJ40mJ7a9dAwuhY7lwbaXE4NsvjHlTD/Z+A1o2pI/+HPfR1DRH+yom00GwofzmnNY0s26gcpLm5ChGdOwE+iZLF1twIASOLMzbZlYIdtpHN35oMr/JsQR6l77QyBERM5mFhTo0cJXGk3o36xxBSnDK3GIzA1qzmnlwnZV84uQGyc8cjyyn8TdGsff///DI6PoO5PfXQ6v9mrYsLFqW/rsbWzNNLMcLloCe03u5CsRtesCDZHyW/XnbjqoSbg1t8jAZXermlVCOsBIQZrz0tRAIyUo7PeHXVy/SoMUZKM5QlJTDoE8z1NLZXMrPtgNZI/z27W7HSSpdMg0kHSGXFp07twsTA6i6KlKyiaJmHml+u/+r6AdFOe7S9y/GiFInQYEPYz87eHWQ7nBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mBUsNV4HmWXDt//VofZa5GKZwBGt4l14jSuMV4xrEPBCb7eyyvPOIXDqqfRXzCYBAKOHV8z2a1F88pu9JAT9mJXmeljAwheZT67chOcJkGL8eOV2HY9r9F2mn7uqxkL8oh2dm1lxtI+X+5aTk55DEnWwYJBCM9M4J7mBZunQL0nMKn0WYOt1hvhD1kYv8W9q4948uapz+QTRIthmLHtHFAIzjQ9VJFd51w9eoaBoapO30NsN/eMWSeiYgt+8SA5WlqbDKStdWOL1f927OHcZVva/3b/ktchPNxq4ho1hpco6reyGHfYd3JFgOVUQPzeeUS6zTo9HjCEpt1N3FcJbQ6UeK9KRs1mu+LpRTVY/RXLJWqe0io7n3IbD4BIxu+gD78XKB4nhBjIt944EXhJkh5iv/CTdEJDXn6qQQ7w835N1Eha2ZeQ9AbT6rMStj0Sh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:56:43.2773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 096e59b2-7e3f-4924-2a43-08de7dec13fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

On A + A platform, sysvm aperture is used for both
vram and gart access. In sysvm aperture, vram starts
at 0, and gart starts right after vram.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index da4a0cf4aad0c..a68a398afebec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -691,12 +691,15 @@ static void gmc_v12_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	base = adev->mmhub.funcs->get_fb_location(adev);
 
-	amdgpu_gmc_set_agp_default(adev, mc);
-	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
-	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_LOW);
-	if (!amdgpu_sriov_vf(adev) && (amdgpu_agp == 1))
-		amdgpu_gmc_agp_location(adev, mc);
-
+	if (amdgpu_gmc_is_pdb0_enabled(adev)) {
+		amdgpu_gmc_sysvm_location(adev, mc);
+	} else {
+		amdgpu_gmc_set_agp_default(adev, mc);
+		amdgpu_gmc_vram_location(adev, &adev->gmc, base);
+		amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_LOW);
+		if (!amdgpu_sriov_vf(adev) && (amdgpu_agp == 1))
+			amdgpu_gmc_agp_location(adev, mc);
+	}
 	/* base offset of vram pages */
 	if (amdgpu_sriov_vf(adev))
 		adev->vm_manager.vram_base_offset = 0;
-- 
2.53.0

