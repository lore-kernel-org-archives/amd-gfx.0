Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2185EC83F04
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 916D510E601;
	Tue,  1 Jul 2025 18:45:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EsSR1AM2";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0238610E601
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPR7hO/WN0A0DsNC+HsL4PLFhTZcAY0Q9JqQWl1UCjxZTYRfhFSa7ThBPNB2Pz5zYRwcIqGxFL7y4MVoLZ6VM2wdkaMX60VQYeAkVd3D2f7VKZ5mRHA6pCpiYf3HifU2INqv/KUYQ3lphrbVcON9xpUTk1KlSy/5GN20+fvHhDQK+/BrdLM+FscRCUN5UZK5czSZERu+wQAzdJzSZlJNnNuyQgeHU1oQdhod+rAQWvp2skJubfu16qqwsVIjtctYGDglIxm+J9/sj/LeJjxlFUwb2ZW+retAxzY9vMYT9zevwzNrfkbFJjUYCyNMBZH4HI/pdhrgtQHgbKXlw5GvWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/P/I+o6s6f7561q4UDvj2L4zbtrv/MyLuOGAfm5iABk=;
 b=FofaXlaEqT7TMJt6bKbpsOMq6H1j2qcMEw7HudIqUMX5KhVOvwhj5MrhMSyTXfyT8ZalnkRZS89kIr1+Dt9tttrR0xhFwh5Sr8yFaBByWPh31yiM0+SPajZLJ8p9n+H9ekVKETFQYh7G2J5fJb/+OODpPP/69QpLMyDvpVMONDNPWu2Cqx/fqQAnt5lbeYt44QuBE3/SJFQJrgy2gBnwwnCVFHtf2gqaONIsw/rZp61hR+7f9oRMjj/T+6h2io/G4QjAdfKmYM8zg5oNO9qYNNKTxS4SH6sdabJuidetvLT5BukrPJgObmJF1c98IthyxgjD3nU0BimQG/Hzdq541Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/P/I+o6s6f7561q4UDvj2L4zbtrv/MyLuOGAfm5iABk=;
 b=EsSR1AM2jWs53FaS4wf8CcHpIFRxF6/RYla+sYoNbm8gI+UB7QhNQ6xSU10G5OW1AndkrHNVhPffJucNoKDrXvjGVKEwRJjOzTNwWJyfC5Niv2Cr+IQXg84USoZ/YgZfZEG0xVGB0DKIwoKnKco+A0fwaHk5/bgnpqbvEMWn5+U=
Received: from BN9PR03CA0620.namprd03.prod.outlook.com (2603:10b6:408:106::25)
 by BN5PR12MB9464.namprd12.prod.outlook.com (2603:10b6:408:2ab::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 18:45:13 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::3d) by BN9PR03CA0620.outlook.office365.com
 (2603:10b6:408:106::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 18:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/28] drm/amdgpu/sdma6: re-emit unprocessed state on ring
 reset
Date: Tue, 1 Jul 2025 14:44:34 -0400
Message-ID: <20250701184451.11868-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|BN5PR12MB9464:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa53ad1-b2ea-4821-c0f5-08ddb8cf6a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rk8G2AyiEDwBlpV5XiYX6HRJMafnoI4XS2Wttd/YUKdKQC/ImimrZYE4v90K?=
 =?us-ascii?Q?gSGtfuCAfshJ2DDETRZRwXa1WkhkVGAnSOsMqDLd6pe6DQIy7O1AQQXy/tgZ?=
 =?us-ascii?Q?qMw07iqzRPyt6DdEYABh2ib2X3eRtWeHphh+H/KLy3d+b8627weQhJCX3r+i?=
 =?us-ascii?Q?0CUP/xw36UqtBAK04p72OA9SCxNj5VO/K1ERpw7f7Hrdpfpf8nzn/yhWmIzA?=
 =?us-ascii?Q?vtQmQm3s0qhn2BJU/Fe7K3o64Sc0hkatL/icAsauntYr+fIac1UBUTXMRowZ?=
 =?us-ascii?Q?oqTEmvIQaS8WqD/qXD/QhicpIKBG9bHbZ3DtYkwbZ7tr52l8+Pc36hs3cE3N?=
 =?us-ascii?Q?OV4dJjsU7wAfzRUm7NFhazXxccceiiEkBChgEDVgzohLSiZXwJno94qSqVd/?=
 =?us-ascii?Q?QzPkmygPvhkQOGufD/4hNK88MYxpd8cA2lkggTPvdDvlNCo4dWNWboYLdbk8?=
 =?us-ascii?Q?6Y8S5p5VNUp5Ep0UAxL4+nq9D3BnvmLC8cNpQIo2rJORVj+xHnpELaymaCmg?=
 =?us-ascii?Q?TgZfrD5X6Y+3VqaT+rWV5/jRlNTHEpj9F+SZYesdOAMBYUge2KKuWd1eI7hD?=
 =?us-ascii?Q?fbWDuZDFPAtI8xACABIWGsJcQMwh5WEx6X07ng4C36beWniT96p1x1IhS013?=
 =?us-ascii?Q?+gar8zlMGrS1TFxy+Ov6X9/V5lbLJv08GCEQA0wE4ohWaGoweJ4/jdrXPHBl?=
 =?us-ascii?Q?8EI55jFaloQM6HXC2aRoeuCMP2nD3oFR3MNwNffcdU2/G1ehjrQwO0xUiuO8?=
 =?us-ascii?Q?oeK/cCk4v8yc91WR3IzameilcxhQkuHwMnKxI+vD4RxE43VCWc/SkC33DQhy?=
 =?us-ascii?Q?znn4ofxviDZmeVt5RsMTl31yVnfdLIyGTUWjxNOySCCuws00OyagPzl8r5MK?=
 =?us-ascii?Q?QgIU45ErO6waSuLLYy/kDaxeP3FQbf/5bZd4KqAZJciUB+sj6UB1jdIDfLl7?=
 =?us-ascii?Q?FilkjskrLGU4zgYnj5KzhMPR8P4jMBMijdeUmz8ZNJP/Qz9Sy/3EN0uyvTT0?=
 =?us-ascii?Q?uPccaxigamHTyyw24hHT1Al5GO9VGZcI9PnyOBj8gTiS85LTpXpT33w8cA3B?=
 =?us-ascii?Q?BgzoeDZNew6OnSqF/mLZHG5QmnNxkoohd/h1kfR3GbpLfBiZWEV2W8AedhId?=
 =?us-ascii?Q?EKh5fizQcUP0uKf2Orpvo6s0eFq5rgsbjyfdaGBtoSNZAAwAN6zhgZ3ZVSST?=
 =?us-ascii?Q?6NG23JEb4jr9Nr0dvcNIPHcJv+WbEwtd4tE8bIuUz7/M+dKbY+bb+QX/cuFt?=
 =?us-ascii?Q?2BLLWG97W1ujySAiOXavbrMBlTHqu+JYpPMbdhfgUOWIv/CChIUokZ7+MwbZ?=
 =?us-ascii?Q?p2NnyX+tVvmUE1Kg98Ma0Jf1ndon5hqan507GVQ1wl/scWs6seZrd8bfHVkl?=
 =?us-ascii?Q?BI7ihDsWc87L0fDtw1Z+ftJbxG8CPTAheJCN3i03Epbjdr+tboBW6rgOHy/P?=
 =?us-ascii?Q?xR4T/jGshdOkbiYq3GfAC/yoCSMfgDQ/ScDKQeVpak0iYPyq4MDIgBTCBRRN?=
 =?us-ascii?Q?SteixaPnjn9c36CP7LPtdFSPAw5zD5pTHMbQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:13.3015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa53ad1-b2ea-4821-c0f5-08ddb8cf6a0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9464
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
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index d2effa5318176..3e9bff854e5a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1575,33 +1575,27 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i, r;
+	int r;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (ring == &adev->sdma.instance[i].ring)
-			break;
-	}
-
-	if (i == adev->sdma.num_instances) {
+	if (ring->me >= adev->sdma.num_instances) {
 		DRM_ERROR("sdma instance not found\n");
 		return -EINVAL;
 	}
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
 	if (r)
 		return r;
 
-	r = sdma_v6_0_gfx_resume_instance(adev, i, true);
+	r = sdma_v6_0_gfx_resume_instance(adev, ring->me, true);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int sdma_v6_0_set_trap_irq_state(struct amdgpu_device *adev,
-- 
2.50.0

