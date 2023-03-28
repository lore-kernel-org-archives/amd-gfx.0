Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D22FC77B6D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01BD10E916;
	Tue, 28 Mar 2023 15:14:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3789B10E923
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxPDKia6NJqyWxkFsErNMuVymIfAdVJfnVmoVxC2ajyhXP0LPcRRyPYyZaQwj/1C8VnYhGENIsxBp6y9A8t4XxyiNVStofZJNlexPjv9HEhtjKqC+WVywwljUL0IVWWVjTy3dM8wBqXkGjKpb93bsgReBt0xbP2K+Svk/ggAjibQsK0i64RlXvLqdxIvGk8ShmPliTg9SoeiANg07bKRbnbRU1CVm83e4XzBeQKBiZF83eV30JSMGdYQ2TtE1RIDvZvh6QT/KYiZy4tGjkL8Xn8zpKwl5pqwRSP4vKj/aRyuRz532wqoskgbgm2E+JvErLKux3rbsejLGwArCDy/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EG5xLVQPCuGxEHwm48pGZaQcMuMaoyH81Xa9BLlVJ/M=;
 b=OwXth0zyfPlZkQjhZTNeGZ8yWpZZ2pW7k5wO4bVPzS8suGjy/3UFA0qv4Z1vYufhkreYzJOoOqU2xbwY0wpJ3IUuGVcYrWPBNA+7GI1TRa3nSQVW9cFhel1cz6+JtCQkwILwpG0obV5XpwXelAi2xG0stVdbbqEtu0i7/eKfButSszjKseVjFVu3Q8PV/h+YwBIV9X1VSzfnlHnUYetu1HEh5VL/GxP+K1bULp/n7sXu+IADBy71VYyqvgBod6sENk/kC+Wm80MdLC03/VHk75uWgdhNcLDPqcfrLMNxtvGGvlxLHzikuuwxRb9JsZMEBB19ohdp6KGh+4pLncbmXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EG5xLVQPCuGxEHwm48pGZaQcMuMaoyH81Xa9BLlVJ/M=;
 b=2FEpgtgOVm5DyEfD8UKS2aA/kW1DplxfqJDmIIff+iwy3tj9VlLEKv1KNDK/eVSM90+yghEx1b2itU2s3wZolBdmJF40PU8eW3cKqurNpHeDJ2Mk2Vd/QxNI+ymUP7MmiuC5iyGfwhe5gxs6TrQJjRWHSEfzPaxzrXQLdEmfYxw=
Received: from BL1PR13CA0062.namprd13.prod.outlook.com (2603:10b6:208:2b8::7)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 15:14:47 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::77) by BL1PR13CA0062.outlook.office365.com
 (2603:10b6:208:2b8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/32] drm/amdgpu: assign the doorbell index for sdma on
 non-AID0
Date: Tue, 28 Mar 2023 11:13:36 -0400
Message-ID: <20230328151344.1934291-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: a918873e-6850-4a4c-93cc-08db2f9f2b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9XnjdLxaO2kGbNWxjFB1GpmjMLrYq1b4DV3yX9n7K/i7OoKddo5gfzQod4z7PlS7vUgaOQQAaMxArL4ohX4/LS2nNqz7dDE0SkPVQvTOjHZT+FPeRMbuOJmgH5aqvVdezAA3yj3RkIYXBkIVSt4EynZIBt3i2NQtM4UDZ0rxBMffFBDCqQMCOb/a1SMwS1Cmo82T0Mvg91wMntP4S5AZtd0ee0L5kdI/c2ksyEZDC5+5vmXwK9PYKRSya2C6Y4uQvru057qLGt+kTXDLT7XkVarxNLnh+Ew9eo+77e/rp7XJqr/FxRDl/eI76UoJbSDiH2URiaod9QNC4Et9PlGmz/eiS3jeQPcRRvPniv/umiupir6jxYvFc5fhHV1HSjNAFXa4qm7aokBZwnEprQcaT8ya4C0sGDQaD1FRpKfbSjkM8H9hBMi2rc0d9BdLuoOCAlHeWvQCq+2kGEsuyPJd5IWhKnTF0sxzfSCfWDl8yY2fM7GkXAJzV2KMhn/7pHLScJfHBHgLG7yZn+teARv4ZkJc/LwuiNe9Ei98uhEicTPLCPmaPZ+HWvBVi6cCWDdmeEyDXjjRi2IbVPKhVkq9ASo7LDOwpoEfAFSBu/xD6ZqjTcGDohuQFinsNbjVXy6Qu972GG94uSmi0sSAl+23vj6yetmFVxuV/2KWUb8hLFNnMvjkW0gHD5cwjuJ4yPwexuOlwz6lLzUI29B6b9ectCurojwSe1jKSSqiMCLQ2Ec=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(54906003)(316002)(478600001)(7696005)(36756003)(2906002)(40460700003)(6916009)(70206006)(4326008)(41300700001)(40480700001)(5660300002)(70586007)(8676002)(8936002)(356005)(82740400003)(81166007)(26005)(86362001)(16526019)(186003)(2616005)(82310400005)(1076003)(6666004)(36860700001)(83380400001)(336012)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:47.1072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a918873e-6850-4a4c-93cc-08db2f9f2b0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Allocate new sdma doorbell index for the instances only on AID1 for now.

Todo: there's limitation that SDMA doorbell index on SDMA 4.4.2 needs to be
less than 0x1FF, so the tail part in _AMDGPU_VEGA20_DOORBELL_ASSIGNMENT is not
enough to store sdma doorbell range on maximum 4 AIDs if doorbell_range is 20.
So it looks better to create a new doorbell index assignment table for 4.4.2.

v2: change "(x << 1) + 2" to "(x + 1) << 1" for readability.

Signed-off-by: Le Ma <le.ma@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c     | 18 ++++++++++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 711bdeaa7417..613bc035f2e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -80,6 +80,7 @@ struct amdgpu_doorbell_index {
 	uint32_t last_non_cp;
 	uint32_t xcc1_kiq_start;
 	uint32_t xcc1_mec_ring0_start;
+	uint32_t aid1_sdma_start;
 	uint32_t max_assignment;
 	/* Per engine SDMA doorbell size in dword */
 	uint32_t sdma_doorbell_range;
@@ -166,7 +167,10 @@ typedef enum _AMDGPU_VEGA20_DOORBELL_ASSIGNMENT
 	/* 8 compute rings per GC. Max to 0x1CE */
 	AMDGPU_VEGA20_DOORBELL_XCC1_MEC_RING0_START       = 0x197,
 
-	AMDGPU_VEGA20_DOORBELL_MAX_ASSIGNMENT            = 0x1CE,
+	/* AID1 SDMA: 0x1D0 ~ 0x1F7 */
+	AMDGPU_VEGA20_DOORBELL_AID1_sDMA_START           = 0x1D0,
+
+	AMDGPU_VEGA20_DOORBELL_MAX_ASSIGNMENT            = 0x1F7,
 	AMDGPU_VEGA20_DOORBELL_INVALID                   = 0xFFFF
 } AMDGPU_VEGA20_DOORBELL_ASSIGNMENT;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 7deadea03caa..6935a24d1e89 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1310,7 +1310,14 @@ static int sdma_v4_4_2_sw_init(void *handle)
 				ring->use_doorbell?"true":"false");
 
 		/* doorbell size is 2 dwords, get DWORD offset */
-		ring->doorbell_index = adev->doorbell_index.sdma_engine[i] << 1;
+		if (aid_id > 0)
+			ring->doorbell_index =
+				(adev->doorbell_index.aid1_sdma_start << 1)
+				+ adev->doorbell_index.sdma_doorbell_range
+				* (i - adev->sdma.num_inst_per_aid);
+		else
+			ring->doorbell_index =
+				adev->doorbell_index.sdma_engine[i] << 1;
 		ring->vm_hub = AMDGPU_MMHUB0(aid_id);
 
 		sprintf(ring->name, "sdma%d.%d", aid_id,
@@ -1329,7 +1336,14 @@ static int sdma_v4_4_2_sw_init(void *handle)
 			/* doorbell index of page queue is assigned right after
 			 * gfx queue on the same instance
 			 */
-			ring->doorbell_index = (adev->doorbell_index.sdma_engine[i] + 1) << 1;
+			if (aid_id > 0)
+				ring->doorbell_index =
+					((adev->doorbell_index.aid1_sdma_start + 1) << 1)
+					+ adev->doorbell_index.sdma_doorbell_range
+					* (i - adev->sdma.num_inst_per_aid);
+			else
+				ring->doorbell_index =
+					(adev->doorbell_index.sdma_engine[i] + 1) << 1;
 			ring->vm_hub = AMDGPU_MMHUB0(aid_id);
 
 			sprintf(ring->name, "page%d.%d", aid_id,
-- 
2.39.2

