Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE69C76195
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 17:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C99710E627;
	Mon, 20 Mar 2023 17:38:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C1E310E606
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 17:38:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKswWSpz0HD8WSjRFSZ8wEppf3E4hUDedBY6bWwU+QxOvvlmcdKoTQMdvTW9VEUgNctlVbmAggKcgViC19ElleHnz8fvUwgFSCaRiIllVrA2VFPjlP23asy+ZeulUWcs7iPwNtrORTGiUHWRDgrrHSW6xqIgZLKcAC2sj078ttkcXSOUQB4p9ZCq8+4kN3nFhL1brwgwZci/cKemyjy6MTqMAltOGebXWD0jANZJEYejisEk1IsHPEgoajx79e9dNAkpCyTLGfjjWErq5DZ/PXpN+EHnLX0GR5tCIQ0o5bRV2cJwppf03p7t7DzqEwG3L7HaiE8OsFE83AM65CCKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2Ail1kR/xNBWLMQXT/xQQX0Z6m0vY8Rgu/gvD3A2YU=;
 b=jayI8N2uX0jheiKgCvR1ts69AWIpu93ooQER6k8CYHek/88wjFo9WgGZDDlNWnAk064tj59c9zqjGqxx1sdSBttfiex/oxde0DCivalkwGGyDYjKWYnWGwwXbPQ27mM4Qntcz6AyGjagHMQf7P2esxLLY3WdGP6b61zw4BsGMb+1AW9BPKaCnN/PeAoWKoQ4HWdpTbc6M7PIzkyNqa4TQoiW0WrObN5sd4mh52iVnUhDsfw4ryLYUHjo4cEx3Jc8mK2Qf3IJeSPlIju/dLEqLoXUGTvxtwgtBL16YzjMZgctwIeRNOWvvWcZfjY+JXyMtFjHDdPYEUvfUNq8u7+UWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2Ail1kR/xNBWLMQXT/xQQX0Z6m0vY8Rgu/gvD3A2YU=;
 b=CWnFgQQGrBRrBCfzpzqxIN0UILMEb+N1pUakopM383rydblIZgLMNGlW+NxBenkCe/+nmvmBZ5LgUZwxk8jW03+70YkJIBryzZU7bZxkYKXC1jOY0QuCt4u7uj8ap9SO+D6TMKpPD9Jghrdci/0U68jEaHPBUR8VqW3I/NwbqJQ=
Received: from MW4PR03CA0169.namprd03.prod.outlook.com (2603:10b6:303:8d::24)
 by IA0PR12MB8861.namprd12.prod.outlook.com (2603:10b6:208:487::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:38:31 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::bf) by MW4PR03CA0169.outlook.office365.com
 (2603:10b6:303:8d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 17:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 17:38:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 12:38:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/11] drm/amdgpu: don't require a job for cond_exec and shadow
Date: Mon, 20 Mar 2023 13:38:05 -0400
Message-ID: <20230320173810.250835-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320173810.250835-1-alexander.deucher@amd.com>
References: <20230320173810.250835-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|IA0PR12MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: d02a5281-f768-4c34-af5f-08db2969ebd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lt9wP3ceGv4Atc3il5xACL50JOgkyjtRp+hCIOXtt9C4LyC98ExVp0TSuhQLKZHG9NyqX7cJ0BYXf428qWGzO6fdqWTinpisyxvaW5n2c5WGDhVRAgQA6OZT/0GnQbUzz4htkC64V698M6WSVmpcwokF6agKsB/bAqa6AXzTcVSl3c5UPup2VdGCBD5K0f+KDGSFHUP1pX0paz1Xxr/JYops6zdEtdnsWQ8VQTQIo0o4Sjdipw3OMpGP975nyzuD6yV7mIsSjENzTyP86Jvz0knCFf+2ONROVYAC8fu8p4NGvHB+ynWMpDlZHucxF0xrvurs6JFGosk1jKSgO54/Ne9BVQk5WGP/UuA73by5ppGeu2jrXLnHkUGxa6GzcRK2r9p0Ih3zQ7QZ8A7eu2FcveoM2pmCsjUE0PXiZLOpeT0KVQtPRtDl0dCqYlMcE1eFFjfV5ps49pGbb/HKXeeC8MBsnJVNqE2P0/wgq1gAr/xr/+gbcyc+w5LtwATWNmeHadXm187MAJvAd59fDoGYc3o0zo9UL2eb5YuNzCEWHkSErAajORZWWDU+uFiwuOXy5kaoqgF1cr/L3VI6IhcejRfzu3rx5+cdNt1JodfckljRZYdM3iQJgYd9I7V+IJNTHoUprmR/bUsSZsMuMGKylfLN94bWs2XyvNpnj+jtYAPfvALAd7OdrUmW86dR7KcW1vWivVfKPglBvHzCavoNEpvaYg+IhTEgu6Z6nqWq5HM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199018)(46966006)(36840700001)(40470700004)(41300700001)(70586007)(478600001)(8936002)(54906003)(8676002)(5660300002)(356005)(6916009)(4326008)(36756003)(40460700003)(86362001)(70206006)(316002)(7696005)(426003)(26005)(47076005)(1076003)(186003)(81166007)(6666004)(40480700001)(336012)(82740400003)(16526019)(2616005)(82310400005)(2906002)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 17:38:30.6580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d02a5281-f768-4c34-af5f-08db2969ebd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8861
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to reset the shadow state every time we submit an
IB and there needs to be a COND_EXEC packet after the
SET_Q_PREEMPTION_MODE packet for it to work properly, so
we should emit both of these packets regardless of whether
there is a job present or not.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 7fb8e6691d13..3b35e21eb934 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -223,11 +223,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 
 	amdgpu_ring_ib_begin(ring);
 
-	if (job && ring->funcs->emit_gfx_shadow)
+	if (ring->funcs->emit_gfx_shadow)
 		amdgpu_ring_emit_gfx_shadow(ring, shadow_va, csa_va, gds_va,
 					    init_shadow, vmid);
 
-	if (job && ring->funcs->init_cond_exec)
+	if (ring->funcs->init_cond_exec)
 		patch_offset = amdgpu_ring_init_cond_exec(ring);
 
 	amdgpu_device_flush_hdp(adev, ring);
-- 
2.39.2

