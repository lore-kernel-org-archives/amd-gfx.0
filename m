Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FECC3DA4A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 17:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8E2510E6A9;
	Wed, 14 May 2025 17:23:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wwNp6RMQ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B7E610E2CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 17:23:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBU3f2I7M777tMOUyrX6lZgiKXkNsei/QqFj4JsGVEOlR/Oq6kq1XI43IrniN71ifqBlYKpcp/mkCsuWu+efdOalkKGDo1W+4HrWcEDv0Mc0LgB3kA62jNTCFaFnpKwS8ALT0RIiw3qx0iLz0HCUEjbmu9Z8t5lTvbQCrtjpRJ1SVm/xtoAua9pHpVc9TcTgYaDaPLbfWF4gYVUa4BFBi21q7ICZgsJgmX4zsOebUWw5LQaJ+dzYBDQw6LlScFTWrNocGphW4QA61Q9rQLp7NA+QcFW0L93tMFzncAk/b0DMror2PkkKwQC+vU9s3K+nTcjj1QwZ3TSOXY2WFXNFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1z71DsIyLa4rECgEAnwPtZDWhoo1sdu1v2ZfgAsiFGE=;
 b=jBChEgvB3VaNnRWjs0WGphoI6GmIZabCP4vfku4C7Hl3QMxr7VYtZmYUQRy5szYDQ+Eaj+QkEV9gWIoj4/oSrm64iAcgAkJrWYqhaZgZiezGFwySA3fN76nCG68xhBknbS0bx/g8uZP6vD6y0grf1itkmzpLj0bQFbBt+fTFDTqAvipASeL3q8rv4ddbNwKb9EwIkWMtLebwLgVgrN1ldEDpBpfKITVB9k6FAfG9LmPhxo58zZJTeKpV1ykkr5iQLAeplD4tr1POPMdgAaO+xwnuKR922cuM4XSK2gbqp641A6a4cE/X5HjZFlz1VuXjqCFGrADcpE5L9aV+Q7TfaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1z71DsIyLa4rECgEAnwPtZDWhoo1sdu1v2ZfgAsiFGE=;
 b=wwNp6RMQaGWWm2ybQ2ye8mdpuJna02SD6ghhMXVIMJCcHceq+J/xJJb9wFdZTgBs/uEYVx/XuldpEKRGGs4ZmnWx2Biczb3n+LM8KYYcetoOKPckaR+YycVl0KKBgHfgQs/oFAXSRFykAkmCrso9EJamUXj0A+Cwa3C6aM15Z/k=
Received: from SJ0PR03CA0290.namprd03.prod.outlook.com (2603:10b6:a03:39e::25)
 by CY3PR12MB9703.namprd12.prod.outlook.com (2603:10b6:930:102::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 17:23:09 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::56) by SJ0PR03CA0290.outlook.office365.com
 (2603:10b6:a03:39e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Wed,
 14 May 2025 17:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 17:23:08 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 May 2025 12:23:04 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Christian.Koenig@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v1 3/8] drm/amdgpu: read back register after written
Date: Wed, 14 May 2025 13:22:46 -0400
Message-ID: <20250514172251.726484-4-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514172251.726484-1-David.Wu3@amd.com>
References: <20250514172251.726484-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|CY3PR12MB9703:EE_
X-MS-Office365-Filtering-Correlation-Id: 10108e36-381f-4f9a-e4f9-08dd930bff1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2C9xkkI8gsMiosuJazDiEAi4Bw9EeswXCqlahXbA21MPrjTOwjlaOtj8JUSN?=
 =?us-ascii?Q?weAClih3lDiOJad2YMoX+6mnLlEKRE3qpXr1d53B/rfpUa4Xeiz0ywy0IPO8?=
 =?us-ascii?Q?Xhjv0IBN5cq+Bla4+nTAdnO0gCWt9DQftcsWBp7G8CK/ib9Iu/0Gec+fYqCM?=
 =?us-ascii?Q?ZW0F2D/XEWS+OxfxaVOB5fwEbGczVYpeyvtSaJusI/LlG9TzSBmnjeRxoNP4?=
 =?us-ascii?Q?LR8e1CGHiutldba3ZzjbNQPehc7HUoIuh1Blk+fcYkRdhdUTs3kbbho0tucr?=
 =?us-ascii?Q?Ix1NPDy/J8TQSzil+yKwsZTzu3gIUMuoV8MqbU1df2EmXJnvCUXHPDPSsjAj?=
 =?us-ascii?Q?EVRaANaHMzes4N3lZjwgC3YDPcnUI4X9r3L/y7m7fmznRQ8e3wuWMkwkER/C?=
 =?us-ascii?Q?ElEeIkk3mw8dlh4Nze/qy0NcVcN+MT4SQo4HxrkdfRPXYjdZ67+wCr7Vr54o?=
 =?us-ascii?Q?DJ3S0i1O9GEls1ReBf1x52Tl/3p1eA2IdCvQK1EgUFXTCle/p/3J+g9PKTK4?=
 =?us-ascii?Q?xUGiiVJUvB4TpWbEjoaVC7zQNVOwkV/voU8UJuPm6Kg8RoTfdeZFSQuDAp6+?=
 =?us-ascii?Q?G5Mg9iT6ALLYsVRgCmQPwCmzLQdQXewc9UeFEwiHv1XHHL6v+Meei3Fk1gVA?=
 =?us-ascii?Q?Rv5zWd61jp5ZI/67f0xg0YYqiDoR3fn1AmSrZpGyCmYJA+s7hM+Zk1+2N9Kr?=
 =?us-ascii?Q?2BLvga4/YtmuAaBtwozEVIWnD1W0vp5573poXih91ivUg9PT6SgilBK9lRz0?=
 =?us-ascii?Q?ZG26IxF7lBNh1Z/nGyzls/WFR1H10k8PTjQV/9BJt4DPLuQv+P6h7FwIDYwn?=
 =?us-ascii?Q?iK3ZOLIf+60ilNrmIV3zhWL4QFVyAXaFIPHSsbYrmjNrfD3DGe6I6A90K3YL?=
 =?us-ascii?Q?j2k23ZfbLJFv59O/CxwCdtiLOoMAWM68a9aITu4Y7h9BscPZKhn4bcMFsGbD?=
 =?us-ascii?Q?GWIbiCA5Il3Cz2DRaJfnOEnBJsNcOg2JPc5fPRdnn2I8qgl4w+zugDH2Oh1Z?=
 =?us-ascii?Q?2fQaExNjKeBz+0IGzGsKu06ZJ4sJJhe1qNXEVsTrtBCoUwRX5NXL2q8lXo4x?=
 =?us-ascii?Q?CbakpWSUnUOyQ40PFHcJUicWUMCRGEr0h3yzDnSwfa8r1mReQnGi9OpL7zar?=
 =?us-ascii?Q?I2x3sKIN3n0mlNcbCgKmIrZ+/X1x6aCOZcy5avX5OKUMuOeM5EVIZRLWnXbs?=
 =?us-ascii?Q?Mj27emko+CskvkxqgvmslKPmGI10nCQcHhtQyPjmjaxwcD5RSO2OHHNoX//+?=
 =?us-ascii?Q?9M01EpPd1s0E3y6FuhEZbTF6cFBjam9kl1O4YJLVUcD7o8GBSmOOgSA9PgOl?=
 =?us-ascii?Q?vyRVZh3I2e6Ny2J632A960BqNsLcDlvBu6teEX/yR+G9ZEx5G577fOgpu6IX?=
 =?us-ascii?Q?m/2HTDVvNiRnKNh4rjJEg2rcVYbdD1ZSMuhbGNW82kWAqHr993cBtoMITiSE?=
 =?us-ascii?Q?ayMsSa/JALaunXXFS/ghwldJCbzuskP4/X2ke8HGEkDiwGpPGfOI/OoWIKkt?=
 =?us-ascii?Q?hqsKHYQA92EUzMCPkjfCSjsc1b6gCfNv/ybf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 17:23:08.9157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10108e36-381f-4f9a-e4f9-08dd930bff1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9703
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

The addition of register read-back in VCN v2.5 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 3eec1b8feaee..beffe0795ca9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1158,6 +1158,11 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
 		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions
+	 */
+	RREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR);
+
 	return 0;
 }
 
@@ -1343,6 +1348,11 @@ static int vcn_v2_5_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
 	fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions
+	 */
+	RREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR);
+
 	return 0;
 }
 
-- 
2.49.0

