Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A125C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 07:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7969110E1BE;
	Thu,  9 Nov 2023 07:36:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9309310E1BE
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 07:36:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mU7uAwVbFiARpe2fxZdsswarQc/6roPSiXlTNpCyFRYvji/fq7NklZ3PC3qEEvkriIfz7u6KFZXyB8kEY+y76TaqVUO9bhZ6bkTjkSUUHs0bYiXg74m5W5Nx7HGzkd85LDF/x5xsjbnizwLlZ41SuZ89Rn+zRZEx/bbSCBZ9wIOlPkvwnuBl082fp0KrkIaMwk5XaFXeHnktqOP8/npQWmHGt6UyfB8GW/KzqCPoOQ69lFTqCrGRky+0VLSDXB7Oj10f2/7mTnrECkW71rcm+C+eG9FeMt62PRB+W2FRXmqqJlh+tnXwWsNVOwgS9j3SxEmGnORE2KwoFmC6MGrklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kur+Yj++tKR683i9xw+9roOP6Phj01IQIjtqpSWo/W0=;
 b=gvJ5IflcBpBFC7hm9hUxBImwWaPhyjFElIy9BLKlXP2+KiG/JtCmM+ExXaijTebt/ChcKeXQ0EyHZn31mdMYwDNxjLnjis5Tyfs2wRcj/LQMt2oUFymtvF0SOkxfgwHMS7rJAW7aLDUVmsjvytM/moffkheGn9sRryX703cbTQbB6hZuWyYwJ42JfmbHKQo2xCatxBCKtvKcGyReDL1wMnKWKaWIxwKYiFF9gfeRYDr3ASy4eg23+vNlxSAVbwm0HDabf4xRi+gOqv7Zl8lWE+zkRZEPGOGfUdsLigBsvYIhmVK+YzX3vcxjjDukX7UVIiQMm3u+s4CMh710s+94+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kur+Yj++tKR683i9xw+9roOP6Phj01IQIjtqpSWo/W0=;
 b=AWM1R9k++EbEZD8nu2MO2WlAIh7Mbp0cShgy15ECSMriywcKyduZ/eABk6BAk107xasdkPNsLiKLfHeFeppeMB666/tSQeuAFmJRtlhdXgOWSFaC4RvhWpP2QLNKtuyTFoOkflxY+gWjTmi0bx7eET1M3mX4Nb4ZF3cn2+OsgZI=
Received: from MN2PR17CA0020.namprd17.prod.outlook.com (2603:10b6:208:15e::33)
 by DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Thu, 9 Nov 2023 07:36:40 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:15e:cafe::aa) by MN2PR17CA0020.outlook.office365.com
 (2603:10b6:208:15e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 07:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 07:36:40 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 01:36:37 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: needn't set aggregated doorbell for map queue
Date: Thu, 9 Nov 2023 15:36:25 +0800
Message-ID: <20231109073625.1751945-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DS7PR12MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b047116-fc03-4dd5-de94-08dbe0f69ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vp9r2QopEXEOfx9JZOriQQISzfI1ruVvxWLTgX9/8+EZIkdzozHF0iJq/LCA6ij42UkFM1GisXTHjuNQA/Phxeiyb5r55wRcNEo5dDXL9N9QlQJHYTMVqd//NOOUivKG24NNbpbSollEEhkIgz9X25MiPmA3WMj6YJ6crtKiMC4GQq7dmI9iV0wSJfrf5N/g/w4sLG/m6WsrFo4JEEJJ8mMs9BQmBBZ6rRhxLGdvWJa81R0FZed49mGmOKyH+vBJHwG7LN3XrWbCFVJi6ef+jv8rwZCmvWpI9Vd1k878O4XjUh/P8hXcil+Wsw0bsXi6rsZmRNmtTWfU6q+4OD08oqi6SYtvdYJNWfR6Z01jfYXxIE8o7J4gwXO11lXiHC1ECpocEFBDy0NFWvlBIa1VZlo7JsRql4vfgaI8mbkJJSSxT8wKWXtPnqp9mtNDy035nmV/7BADbzZ6b5VUd+oLZ7FY8AUAMmLCNTiVvKahpnJnxu2c1oyflElvX8Q9YGF6dlCnWqhfJbyljPZQpp4dsHjH3pu0HsYf2xOZwXvFifwFEgD1+g5c9/0vYkp5JN7xoxMxSO7u7xTbd48QcN+Fe7BzV15pszYi2HcevFM1j+jwa9cp7Gstn+rPnjsLb+oXLLnI9QjuTAKNm82EWu271TFQzJ0OPmOZrrN8vOok7gZBiJTXlFCLGSNH/mHpZUGb1weVWuH3Wve6SoUaMPW06F4dNpw7giP5UdgSkRQI8UIeWFKxAp5Oz88NKDkCkPjHfb0tvlXwXD5jYPPQ9Sg8AwTnDwMAIPFnDbEKYn06Mho=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(46966006)(40470700004)(40460700003)(2906002)(40480700001)(8676002)(5660300002)(4326008)(356005)(81166007)(86362001)(36860700001)(47076005)(83380400001)(41300700001)(426003)(70586007)(336012)(82740400003)(70206006)(316002)(8936002)(1076003)(2616005)(6916009)(7696005)(6666004)(54906003)(26005)(478600001)(16526019)(36756003)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 07:36:40.1999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b047116-fc03-4dd5-de94-08dbe0f69ced
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Needn't set aggregated doorbell for map queue and remove
the dead code.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 ------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 4 ----
 2 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index c8a3bf01743f..601bb6755bd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8220,9 +8220,6 @@ static void gfx_v10_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 			WDOORBELL64(ring->doorbell_index, wptr_tmp);
 		} else {
 			WDOORBELL64(ring->doorbell_index, wptr_tmp);
-
-			if (*is_queue_unmap)
-				WDOORBELL64(aggregated_db_index, wptr_tmp);
 		}
 	} else {
 		if (ring->use_doorbell) {
@@ -8283,9 +8280,6 @@ static void gfx_v10_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 			WDOORBELL64(ring->doorbell_index, wptr_tmp);
 		} else {
 			WDOORBELL64(ring->doorbell_index, wptr_tmp);
-
-			if (*is_queue_unmap)
-				WDOORBELL64(aggregated_db_index, wptr_tmp);
 		}
 	} else {
 		/* XXX check if swapping is necessary on BE */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index c1ff5eda8961..14633e2ceac6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -358,10 +358,6 @@ static void sdma_v5_0_ring_set_wptr(struct amdgpu_ring *ring)
 			DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
 					ring->doorbell_index, ring->wptr << 2);
 			WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
-
-			if (*is_queue_unmap)
-				WDOORBELL64(aggregated_db_index,
-					    ring->wptr << 2);
 		}
 	} else {
 		if (ring->use_doorbell) {
-- 
2.34.1

