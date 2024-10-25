Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CAFD116E4
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEEB010E9E7;
	Fri, 25 Oct 2024 02:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gfzv6CJT";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB08310E9E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKLdOSRtztLHt2/rzKrreX3wveZfi68sGirUfQo3PiZC0qAlRUvrepaTqhOfcfKejri+7ZrA4MmvKayPuG5IclaPHLdcIq3rY6n1Zz69Mzkng/ML0gscUVbKgsIrpfG/LPn9mpWqPphFtRz8L9e31b+u2T59tpu1nTOMqXvru/I5Mi6LQVjRLO4qa5B2J/HCX7GwlBPACKM9vNqWPOhT8RljUBvsRCz+wS/v8tm3Ib6Y5QwLq9ihV2daPm4xfqsJU/kYa/Zk76p97ZkWgbv1rpkmnmpezcT1DYW2E/01PmvF+9IyDPse5wwZAn3/TBSRYE+acgAiDUHrqj4vrMOacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkUW60+2QriHFXG1RoTZFkUZL2Z5rJJltPRbnHacsBs=;
 b=lwCvlMQUSH5rwOGofVww8KtilZI8xb91iV5jE25OMSmAfL4sDA+lfi8tDAcDEhA+lz8wmSrSXP5jZJ7Ehr1jOoEFk1ANehEvbbjqKOVf3swj0Nb5zvfQ5TRT1/a0orKuVI0r9Zz0Qp+38w5dnRaJsTgRnK3L5l4ZbLW9x13YDVOb9T/6AVMg9ZYxVTr534haTNa7Gr8zOmAKcHMllIF23knAgYoMX2/h+nzec8Asu8RPH5u1MnZYYuhTXiNatYMTkxrXqaHc2Avb7TpRRUT+oVY60g9cgrt3VpIcbR2kvVta4oxHrJQXcRGZkUhmkTTrna3oI5gcYxg16i3NTAE7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkUW60+2QriHFXG1RoTZFkUZL2Z5rJJltPRbnHacsBs=;
 b=Gfzv6CJTvBmhFUanvnkJEzX9nRVry4ovoXYn6Y/nghskUlD+MkQ5HX59X2bPK4D9/SgUZTS4inBbRAwaUBejYIMcMIPUzT3dBIE/qVP+l6fiUeOQHfskkzC9WtXDJmZ4x1FLL5s5vaF6UZGYq/3pLftZGNvsAc2oxTbS8boe18E=
Received: from DM6PR18CA0027.namprd18.prod.outlook.com (2603:10b6:5:15b::40)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 02:36:26 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::e8) by DM6PR18CA0027.outlook.office365.com
 (2603:10b6:5:15b::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:26 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:21 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 27/29] drm/amdgpu: set funcs for each vcn instance
Date: Thu, 24 Oct 2024 22:35:43 -0400
Message-ID: <20241025023545.465886-28-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025023545.465886-1-boyuan.zhang@amd.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: 104bc7c0-ba84-4913-94c1-08dcf49dd2e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2hNc3FSdFY3bGdMcVloejFxUnNIbmpEeGp4dHkraDFlYzJUNXNYVEgramtr?=
 =?utf-8?B?emErM0tVeFJnSzZEQnR3cEFpUTZFRW5nV3o5a0pVdDFoT1c5NjFJSVdaLzBR?=
 =?utf-8?B?ZUtWV3ZxOVdUVVJOZWNnVUJqeWhEUXJLcEVyRWN3Q0dvWDY5d0R4V0FTZkU4?=
 =?utf-8?B?c1BwYkNFM05TL2NjaVRaYkxpdHJYQlY1Y1g2bC9JZWFwRzgwN1I1THZSa1JI?=
 =?utf-8?B?b20yMzRrNDk1VUhUcmdaQUcxNjFGUWhkQUo0TmI3ZTF2eEUzOVo2MUROYkU4?=
 =?utf-8?B?OXJBQUxNd3RML0kxVi8xSDVDVGFNbHpaWDBZTjFhVkhHeFphZ0hJbzgxenVW?=
 =?utf-8?B?VU5DSHdacEQvWXBleTBNcUJ2MDVIQW5BNE1aN1EzT0RnNnI2c2Y0d2FGU3Q2?=
 =?utf-8?B?aDNJVnlyQmRnRE9mdk5oZUlWanBJM0szZldQMlNmUFYxTHN3R1doSVJWbno2?=
 =?utf-8?B?MFZEelVhdHoxbXR1TmtHbmNsMnYySHRrck1PaFRWMmEwdE5yYmtwM2hXN250?=
 =?utf-8?B?ViswK2ozUThweUlvdFppbmlmK1pRYmhGS0RUOFgvWCtMRUtPVTVDeFRoTzUr?=
 =?utf-8?B?RXEyRnNBSy9QS0hXV3d5MXdXeWZrbkFFbmE5RksrWnUrV1hQdmRVbUJxWGFm?=
 =?utf-8?B?cEtyWkFoazRIdGxOQlNzaWI2dHE3dXlIUDRkZk5RSlFGSUVndTFGeEp3NVJL?=
 =?utf-8?B?MWZTcStIcGJjZGU0OE5mKy90NDMvd0w0TCs5WUdzUXJtNlM5NnBPeGgzSVNR?=
 =?utf-8?B?S3hDaCtxM3RJdzlTUkI2VGppQWQ5TmFGWTBzTTBGMy9nZStGb25YYlVBbkxV?=
 =?utf-8?B?WUUwOGk2Kytmejd0RU9IMDh2ZUVhN1BwS0FIS2VCa294eUFIR3p5Ujk3cGFX?=
 =?utf-8?B?enE0MlhMV21tSGpYdlBrOGRtaVc5d3lZZEt6ZS9vMklpTnk1Z0M3aVlaVzdN?=
 =?utf-8?B?SnJYZFBxemNpVEJDbks2bEo1Yi94RXNiUXV0MTdKcjlFV0dmWk40V2xCbUM2?=
 =?utf-8?B?VlZEN0U0Q0xqWWF4dTcwYnNWOVk1alNjTzZlNWZ0V0tpS0Y1ZHgrbTFOOGVC?=
 =?utf-8?B?K2JKb1RLR1VrZXFqN2lCVHgwR3NHMEZOaGszME40OHVqa2tIZCtRK1JoU1Zp?=
 =?utf-8?B?bWpZS1NzZjU5WU1pdS8xMHJoNlFkcDl3VEJvVU8xSml4YUpKMFRtSjl0bU1u?=
 =?utf-8?B?TWtGa1hTdVlGRVdxd3lMemJPc1pCeW5ocXZLZGdiM2ZRRmxMcmZHWlJHSUpV?=
 =?utf-8?B?SC9GL2ZvQXJNYjlNVS95MjQ4ZDUwNHNZNXFDWmpEU0s1Ly9yN2pkYW5KK0tq?=
 =?utf-8?B?VzF0SzhsUitYMGwyblB2blRHQytHNE0yMkVTSGFNNGg0T1FhcU5tZzdteXk1?=
 =?utf-8?B?MmZjcjdZQ3BqSmJzaElYTjY3UnpGbjZ1a09OSXBSdHdmRENhUTNJMGZsM0NF?=
 =?utf-8?B?WVZNNHR2Z1puK1Uyek9aN2JjTW1SQXozaUJ0L2dyWEtKZkNzVWtER20wUWhY?=
 =?utf-8?B?MG9PakU5QnBpaU9ydVFxWE9RYmF1UVhkVGxyR2IvRUpONGx1S3A3bm9sT1JS?=
 =?utf-8?B?a3NUaFFyS3lpb1ZVVU1TMkRsbUYrdHRITjc4TjhpRjhKWGIrc3J3NXJSRnNE?=
 =?utf-8?B?WmhreGtWeXlwNCtJbUdGNTQ3akU2K1pkaWNwOUNnOUoyL25IajN1M1pwb29j?=
 =?utf-8?B?c1N5dDRMU2RvUE5hSEZUSUdKdmVHcmlrNi9EeS92ak8vLzYvdmpYaVFiTXVk?=
 =?utf-8?B?eXFESnJXSUtSWXNkbDZZd1gvQlMrVDBFVExqeEZrT04xYmJRSld2SDZWbTNi?=
 =?utf-8?B?VS9IczQyWUU5U1lOK1ozS29NeHhqeGJNMGlOamxrdk5kdTZBV2hCdThnM0Iv?=
 =?utf-8?B?VTU2N1ZCNThySHgxTkk2NG0zVjNCSkhybFprUEYrMTdielE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:26.2869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 104bc7c0-ba84-4913-94c1-08dcf49dd2e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Pass instance parameter to set_dec_ring_funcs(), set_enc_ring_funcs(),
and set_irq_funcs(), and perform function setup ONLY for the given vcn
instance, instead of for all vcn instances. Modify each vcn generation
accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 59 +++++++++++------------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 62 +++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 46 ++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 31 ++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 36 ++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 36 ++++++--------
 6 files changed, 112 insertions(+), 158 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 0d84cb4279e3..2e5888b905fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -92,9 +92,9 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_5[] = {
 	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_DPG_PAUSE)
 };
 
-static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
+static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev, int inst);
 static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
@@ -139,9 +139,9 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 		adev->vcn.num_enc_rings = 2;
 	}
 
-	vcn_v2_5_set_dec_ring_funcs(adev);
-	vcn_v2_5_set_enc_ring_funcs(adev);
-	vcn_v2_5_set_irq_funcs(adev);
+	vcn_v2_5_set_dec_ring_funcs(adev, inst);
+	vcn_v2_5_set_enc_ring_funcs(adev, inst);
+	vcn_v2_5_set_irq_funcs(adev, inst);
 	vcn_v2_5_set_ras_funcs(adev);
 
 	return amdgpu_vcn_early_init(adev, inst);
@@ -1737,29 +1737,25 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
-static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
+		if (adev->vcn.harvest_config & (1 << inst))
+			return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		adev->vcn.inst[i].ring_dec.funcs = &vcn_v2_5_dec_ring_vm_funcs;
-		adev->vcn.inst[i].ring_dec.me = i;
-	}
+		adev->vcn.inst[inst].ring_dec.funcs = &vcn_v2_5_dec_ring_vm_funcs;
+		adev->vcn.inst[inst].ring_dec.me = inst;
 }
 
-static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i, j;
+	int i;
 
-	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
-		if (adev->vcn.harvest_config & (1 << j))
-			continue;
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
-			adev->vcn.inst[j].ring_enc[i].funcs = &vcn_v2_5_enc_ring_vm_funcs;
-			adev->vcn.inst[j].ring_enc[i].me = j;
-		}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
+
+	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+		adev->vcn.inst[inst].ring_enc[i].funcs = &vcn_v2_5_enc_ring_vm_funcs;
+		adev->vcn.inst[inst].ring_enc[i].me = inst;
 	}
 }
 
@@ -1904,19 +1900,16 @@ static const struct amdgpu_irq_src_funcs vcn_v2_6_ras_irq_funcs = {
 	.process = amdgpu_vcn_process_poison_irq,
 };
 
-static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev)
+static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].irq.funcs = &vcn_v2_5_irq_funcs;
+	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].irq.funcs = &vcn_v2_5_irq_funcs;
 
-		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].ras_poison_irq.funcs = &vcn_v2_6_ras_irq_funcs;
-	}
+	adev->vcn.inst[inst].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].ras_poison_irq.funcs = &vcn_v2_6_ras_irq_funcs;
 }
 
 static void vcn_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 03fc50b3aa05..0d1c1534db40 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -102,9 +102,9 @@ static int amdgpu_ih_clientid_vcns[] = {
 };
 
 static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
-static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
+static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev, int inst);
 static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 			enum amd_powergating_state state);
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
@@ -144,9 +144,9 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 			adev->vcn.num_enc_rings = 2;
 	}
 
-	vcn_v3_0_set_dec_ring_funcs(adev);
-	vcn_v3_0_set_enc_ring_funcs(adev);
-	vcn_v3_0_set_irq_funcs(adev);
+	vcn_v3_0_set_dec_ring_funcs(adev, inst);
+	vcn_v3_0_set_enc_ring_funcs(adev, inst);
+	vcn_v3_0_set_irq_funcs(adev, inst);
 
 	return amdgpu_vcn_early_init(adev, inst);
 }
@@ -2062,34 +2062,28 @@ static const struct amdgpu_ring_funcs vcn_v3_0_enc_ring_vm_funcs = {
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
-static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		if (!DEC_SW_RING_ENABLED)
-			adev->vcn.inst[i].ring_dec.funcs = &vcn_v3_0_dec_ring_vm_funcs;
-		else
-			adev->vcn.inst[i].ring_dec.funcs = &vcn_v3_0_dec_sw_ring_vm_funcs;
-		adev->vcn.inst[i].ring_dec.me = i;
-	}
+	if (!DEC_SW_RING_ENABLED)
+		adev->vcn.inst[inst].ring_dec.funcs = &vcn_v3_0_dec_ring_vm_funcs;
+	else
+		adev->vcn.inst[inst].ring_dec.funcs = &vcn_v3_0_dec_sw_ring_vm_funcs;
+	adev->vcn.inst[inst].ring_dec.me = inst;
 }
 
-static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i, j;
+	int j;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
-			adev->vcn.inst[i].ring_enc[j].funcs = &vcn_v3_0_enc_ring_vm_funcs;
-			adev->vcn.inst[i].ring_enc[j].me = i;
-		}
+	for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+		adev->vcn.inst[inst].ring_enc[j].funcs = &vcn_v3_0_enc_ring_vm_funcs;
+		adev->vcn.inst[inst].ring_enc[j].me = inst;
 	}
 }
 
@@ -2231,17 +2225,13 @@ static const struct amdgpu_irq_src_funcs vcn_v3_0_irq_funcs = {
 	.process = vcn_v3_0_process_interrupt,
 };
 
-static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev)
+static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].irq.funcs = &vcn_v3_0_irq_funcs;
-	}
+	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].irq.funcs = &vcn_v3_0_irq_funcs;
 }
 
 static void vcn_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index c52ed8166d9d..e9a8e027d5f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -94,8 +94,8 @@ static int amdgpu_ih_clientid_vcns[] = {
 };
 
 static int vcn_v4_0_start_sriov(struct amdgpu_device *adev);
-static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
+static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev, int inst);
 static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
         enum amd_powergating_state state);
 static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
@@ -127,8 +127,8 @@ static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
 	/* re-use enc ring as unified ring */
 	adev->vcn.num_enc_rings = 1;
 
-	vcn_v4_0_set_unified_ring_funcs(adev);
-	vcn_v4_0_set_irq_funcs(adev);
+	vcn_v4_0_set_unified_ring_funcs(adev, inst);
+	vcn_v4_0_set_irq_funcs(adev, inst);
 	vcn_v4_0_set_ras_funcs(adev);
 
 	return amdgpu_vcn_early_init(adev, inst);
@@ -1923,21 +1923,17 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
  *
  * Set unified ring functions
  */
-static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 2))
-			vcn_v4_0_unified_ring_vm_funcs.secure_submission_supported = true;
+	if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 2))
+		vcn_v4_0_unified_ring_vm_funcs.secure_submission_supported = true;
 
-		adev->vcn.inst[i].ring_enc[0].funcs =
-		       (const struct amdgpu_ring_funcs *)&vcn_v4_0_unified_ring_vm_funcs;
-		adev->vcn.inst[i].ring_enc[0].me = i;
-	}
+	adev->vcn.inst[inst].ring_enc[0].funcs =
+		   (const struct amdgpu_ring_funcs *)&vcn_v4_0_unified_ring_vm_funcs;
+	adev->vcn.inst[inst].ring_enc[0].me = inst;
 }
 
 /**
@@ -2135,20 +2131,16 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_ras_irq_funcs = {
  *
  * Set VCN block interrupt irq functions
  */
-static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev)
+static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].irq.funcs = &vcn_v4_0_irq_funcs;
+	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].irq.funcs = &vcn_v4_0_irq_funcs;
 
-		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].ras_poison_irq.funcs = &vcn_v4_0_ras_irq_funcs;
-	}
+	adev->vcn.inst[inst].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].ras_poison_irq.funcs = &vcn_v4_0_ras_irq_funcs;
 }
 
 static void vcn_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 2468a5e409c1..716bc85141cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -85,8 +85,8 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
 		(offset & 0x1FFFF)
 
 static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
-static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
+static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, int inst);
 static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state);
 static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
@@ -110,8 +110,8 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 	/* re-use enc ring as unified ring */
 	adev->vcn.num_enc_rings = 1;
 
-	vcn_v4_0_3_set_unified_ring_funcs(adev);
-	vcn_v4_0_3_set_irq_funcs(adev);
+	vcn_v4_0_3_set_unified_ring_funcs(adev, inst);
+	vcn_v4_0_3_set_irq_funcs(adev, inst);
 	vcn_v4_0_3_set_ras_funcs(adev);
 
 	return amdgpu_vcn_early_init(adev, inst);
@@ -1525,17 +1525,15 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
  *
  * Set unified ring functions
  */
-static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i, vcn_inst;
+	int vcn_inst;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v4_0_3_unified_ring_vm_funcs;
-		adev->vcn.inst[i].ring_enc[0].me = i;
-		vcn_inst = GET_INST(VCN, i);
-		adev->vcn.inst[i].aid_id =
-			vcn_inst / adev->vcn.num_inst_per_aid;
-	}
+	adev->vcn.inst[inst].ring_enc[0].funcs = &vcn_v4_0_3_unified_ring_vm_funcs;
+	adev->vcn.inst[inst].ring_enc[0].me = inst;
+	vcn_inst = GET_INST(VCN, inst);
+	adev->vcn.inst[inst].aid_id =
+		vcn_inst / adev->vcn.num_inst_per_aid;
 }
 
 /**
@@ -1718,13 +1716,10 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_3_irq_funcs = {
  *
  * Set VCN block interrupt irq functions
  */
-static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
+static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
+	adev->vcn.inst->irq.num_types++;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		adev->vcn.inst->irq.num_types++;
-	}
 	adev->vcn.inst->irq.funcs = &vcn_v4_0_3_irq_funcs;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index f43604d7fb1a..b74b2c0942c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -93,8 +93,8 @@ static int amdgpu_ih_clientid_vcns[] = {
 	SOC15_IH_CLIENTID_VCN1
 };
 
-static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
+static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev, int inst);
 static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state);
 static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev,
@@ -116,8 +116,8 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
 
 	/* re-use enc ring as unified ring */
 	adev->vcn.num_enc_rings = 1;
-	vcn_v4_0_5_set_unified_ring_funcs(adev);
-	vcn_v4_0_5_set_irq_funcs(adev);
+	vcn_v4_0_5_set_unified_ring_funcs(adev, inst);
+	vcn_v4_0_5_set_irq_funcs(adev, inst);
 
 	return amdgpu_vcn_early_init(adev, inst);
 }
@@ -1424,17 +1424,13 @@ static const struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
  *
  * Set unified ring functions
  */
-static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v4_0_5_unified_ring_vm_funcs;
-		adev->vcn.inst[i].ring_enc[0].me = i;
-	}
+	adev->vcn.inst[inst].ring_enc[0].funcs = &vcn_v4_0_5_unified_ring_vm_funcs;
+	adev->vcn.inst[inst].ring_enc[0].me = inst;
 }
 
 /**
@@ -1599,17 +1595,13 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_5_irq_funcs = {
  *
  * Set VCN block interrupt irq functions
  */
-static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev)
+static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].irq.funcs = &vcn_v4_0_5_irq_funcs;
-	}
+	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].irq.funcs = &vcn_v4_0_5_irq_funcs;
 }
 
 static void vcn_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index d61428c75c88..3fbc2aafcd29 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -76,8 +76,8 @@ static int amdgpu_ih_clientid_vcns[] = {
 	SOC15_IH_CLIENTID_VCN1
 };
 
-static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
+static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev, int inst);
 static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state);
 static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev,
@@ -100,8 +100,8 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
 	/* re-use enc ring as unified ring */
 	adev->vcn.num_enc_rings = 1;
 
-	vcn_v5_0_0_set_unified_ring_funcs(adev);
-	vcn_v5_0_0_set_irq_funcs(adev);
+	vcn_v5_0_0_set_unified_ring_funcs(adev, inst);
+	vcn_v5_0_0_set_irq_funcs(adev, inst);
 
 	return amdgpu_vcn_early_init(adev, inst);
 }
@@ -1151,17 +1151,13 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
  *
  * Set unified ring functions
  */
-static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v5_0_0_unified_ring_vm_funcs;
-		adev->vcn.inst[i].ring_enc[0].me = i;
-	}
+	adev->vcn.inst[inst].ring_enc[0].funcs = &vcn_v5_0_0_unified_ring_vm_funcs;
+	adev->vcn.inst[inst].ring_enc[0].me = inst;
 }
 
 /**
@@ -1326,17 +1322,13 @@ static const struct amdgpu_irq_src_funcs vcn_v5_0_0_irq_funcs = {
  *
  * Set VCN block interrupt irq functions
  */
-static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev)
+static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].irq.funcs = &vcn_v5_0_0_irq_funcs;
-	}
+	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].irq.funcs = &vcn_v5_0_0_irq_funcs;
 }
 
 static void vcn_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-- 
2.34.1

