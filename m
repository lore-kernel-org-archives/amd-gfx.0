Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0DCD31A29
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 09:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CB5310E5D9;
	Wed, 14 Jan 2026 09:01:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c0z2G3Li";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012042.outbound.protection.outlook.com
 [40.93.195.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CCD410E3AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 09:01:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLw62V9KRqagntwT8/zw5ntq+jmQBlYyoJ3F5hALF5Fi5P4aKpamDf4LWhqc5BLLiMPzzl0438KI627ydIlst5JcogWknYdCsZzGuxtCuHv6fAjem5LUgJrWc48Qm8W4OtmlFCNjK7zBzdT1n+m6A8aMqV1X9ca4KaijjElZY0fCFBxmlhTMHreurIkIb1bFvR7Nuha5VP+MkL+yUnQxCiQo1EJ7zJFepGS8hyZaplMr4VBfNDTqJujDCNyjdaD2ngklgnWXHPNCEVizge5khLG55ux2bM9pgDNPet/oh50ZH5ixHxdLbMfHfuPdyEk6zi+/Lpf4GZuUoeH/i2hBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pb5iFblco63byuECCv3U4v0JBvBb1RuS/IP1HVBdlDU=;
 b=IrwPqXICiF9EO1q0mUk2MM2y3GyaqnpLgbCYYkmNh5lhwkFqsJAnVzlitCIDx+Q2acA5mBmFHFvilqEPi7xnBvCOIfNDpk5If2nkjc5Wk/o1yrIBsJ7NAE40fqsYLyooaVGSsvkwOtfR2Ij14aNqGf5aN4T7jBLkeiHn4WbGq7fe55vrnw13wF5k2V1JlDemzvPrrlBQVVHvnaW9KObabOFw6UjzAR1N2pkIubLuBe93EQENQKDmF9Ov/sYyoxQvePBtnsbFvb10yGAdcL5m3XdwmEEIG5eP+QWDNClo2QuRFa7RxgFWc0OdjtunOAOKqdy+TjGw+GKtSBB9wwYyEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pb5iFblco63byuECCv3U4v0JBvBb1RuS/IP1HVBdlDU=;
 b=c0z2G3Li6SwrrXUWS8u7TTQlFQkY/EiYh0ohLNE8JCHFyYEOTS9Lc5XTeor/O79VmsTyoEDN3QGCS/p3O83ftTWc3qSIwokVan1vTlyueWyZpXJgv0B8ha1RmTZVnuR8T1SQAQBGqskLnUfKKOlHneDhq8bfxVDjKNNLRYsg2mI=
Received: from CH0PR03CA0042.namprd03.prod.outlook.com (2603:10b6:610:b3::17)
 by LV2PR12MB6013.namprd12.prod.outlook.com (2603:10b6:408:171::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 09:01:37 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::1) by CH0PR03CA0042.outlook.office365.com
 (2603:10b6:610:b3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.5 via Frontend Transport; Wed,
 14 Jan 2026 09:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 09:01:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 03:01:37 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 14 Jan 2026 03:01:30 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 3/5] drm/amdgpu/vcn4.0.3: implement DPG pause mode handling
 for VCN 4.0.3
Date: Wed, 14 Jan 2026 16:59:21 +0800
Message-ID: <20260114090056.356633-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260114090056.356633-1-Jesse.Zhang@amd.com>
References: <20260114090056.356633-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|LV2PR12MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: 1601c27f-6aa3-4e02-23fa-08de534b866b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C3AtKes0f71Xgd4/tZBsc89o9MQMqrJIDLxTcg8qLQw9Y/94t8fCywH3H4Pe?=
 =?us-ascii?Q?MC5z04Hmy7Wi0UoU1j/GEqxZzQOhUYnN0Og6tsgoaN7F6Theh654WlIlPDvF?=
 =?us-ascii?Q?Chn9oxFeSZHv0Xy781OrTxwJc82ydKh0G2oIdg0UiP7ULJneifnXTqnCgLzI?=
 =?us-ascii?Q?+7xBbDX2lq7iqXsQUn0QUgUpjf1dPn3q42nzvEWqeWwHvUs/jNHAlSbSBpxb?=
 =?us-ascii?Q?ioIOdLFbpm5fWfhOF1h8LtfkpQSvScpn3Ukjz4QCXH7cg51bfOxE9JJmgiee?=
 =?us-ascii?Q?J8rXQl/6DWGqTWw/HzUfZvq7wRUiZx3sypohTWXGvmNoascfo6WKJTkxEQ6k?=
 =?us-ascii?Q?TNaXaVbitTvVnwXAGylbhC0U9P4qncnDzkCPbPGNLZWUhMoH5UcYmzWRU91I?=
 =?us-ascii?Q?NRRIGincnUXUvhSqfxRIXL1lcza1d8VDlw6Wl6wAO72MnPKFJrL6bajhKhQo?=
 =?us-ascii?Q?G+8t8F2LdqIvECnLkDnczVw3RILzYtFqnsjLWKVA5D3XgQsEHEykTwOoNzxD?=
 =?us-ascii?Q?7YPPh3Hk5RuLq5C5y34aqjeEOrLldZG5weWBpzFsHdFETJChg9AcgaiJAUoa?=
 =?us-ascii?Q?Z2RDdsgGyNpvNrorIJZPShCjdwKb+C+e+iNM1ppZPEkNECsmXaBxvjTVFiRi?=
 =?us-ascii?Q?DtDdjA7NWbXiv39PUG7Hz6xHWK6Z8nrhRYlEnN8vOE3mXQR3OSAKyR9FuBf6?=
 =?us-ascii?Q?Kad4Fd/AIR++OINdHoCf6ts3oEiu4KZ/RClSpC7SCoITNhJPlTNWvOwDwXHt?=
 =?us-ascii?Q?YdQFbhT8zKggL4YkhtknuLZWMVaT30fjFmThY96RgAv1C1UyK5v0jvC+wSrp?=
 =?us-ascii?Q?c+JSmLbaOneBvmz+hid9YoDPqV0lghEsZXxI0uD9zIh32gX/CDg3xV6yBD9m?=
 =?us-ascii?Q?qDQF1vJ3BucLoIvO5VRzg6nKmceMHefWfMO5zBe0hZwlgxtHuvSwOe2v5OGM?=
 =?us-ascii?Q?dCbT6cr4LvHfeRDwBiHiQFNnI4GxLu7FdGARsaqhiSd/H6LX3kpIoxNXRq9X?=
 =?us-ascii?Q?aTV4KkOCmejBnQuat5hzDa6JmpiStjbeInbHdKlJl6BohpXslE8Lx0tJRlmP?=
 =?us-ascii?Q?ysw+Ns4XAfL6WnRqF2F89w4+9yDWg+cesPwGWWkPNE3zj1+XfFBqZ8hCZpsY?=
 =?us-ascii?Q?DJngD7xuXjTpXkno1qrBk/YXAgjQ8fNt1jGu2L6UqBDGUKPJhIYwW3zC5Jsq?=
 =?us-ascii?Q?hGivpWSpjvRYiNxrFLDpxcR1/c0/XYTzPg32ucfsHcjhjzcSOJ96k5gDGk3m?=
 =?us-ascii?Q?ZYB8NLTCNmiznqQGm7LCSAweRuQzg9b74v1kg79askBmIGDS0DwpK/uqujt7?=
 =?us-ascii?Q?HRfpiIydDu77w2gzraGuRhG6h2T1rfzKw+M4LTriPZBPpV1qFU6fuRGeW7hW?=
 =?us-ascii?Q?ltc1634eQlCvcdTlZkccaBy9xmK02aPOb+TeNCPyQwgC+KJ8TREhwxID4SNb?=
 =?us-ascii?Q?OZDTR+x7A5PN9EeryTt9zkyyidMRmeaXGCR+Gow7wW6YCpan63Gnwm/kbWqq?=
 =?us-ascii?Q?Ae3l5hUHBHH3m7WSeT8R8rukFiJ77sck8mXTUBh0FkId1FYMX37s/mpNYJGT?=
 =?us-ascii?Q?Th3u1xu3hvnt8CgDCDg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 09:01:37.5229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1601c27f-6aa3-4e02-23fa-08de534b866b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6013
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

For MI projects, when Dynamic Power Gating (DPG) is enabled,
VCN reset operations should be performed with DPG in pause mode.
Otherwise, the hardware may perform undesirable reset operations

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 41 +++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 0ff2a1241bb9..acb527834361 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -847,6 +847,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	int inst_idx = vinst->inst;
 	struct amdgpu_vcn4_fw_shared *fw_shared =
 						adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
+	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__PAUSE};
 	struct amdgpu_ring *ring;
 	int vcn_inst, ret;
 	uint32_t tmp;
@@ -951,6 +952,9 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 
 	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 
+	/* Pause dpg */
+	vcn_v4_0_3_pause_dpg_mode(vinst, &state);
+
 	/* program the RB_BASE for ring buffer */
 	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO,
 		     lower_32_bits(ring->gpu_addr));
@@ -1360,9 +1364,13 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	int inst_idx = vinst->inst;
 	uint32_t tmp;
 	int vcn_inst;
+	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 
 	vcn_inst = GET_INST(VCN, inst_idx);
 
+	/* Unpause dpg */
+	vcn_v5_0_1_pause_dpg_mode(vinst, &state);
+
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_POWER_STATUS, 1,
 			   UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
@@ -1486,6 +1494,39 @@ static int vcn_v4_0_3_stop(struct amdgpu_vcn_inst *vinst)
 static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				     struct dpg_pause_state *new_state)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
+	uint32_t reg_data = 0;
+	int ret_code;
+
+	/* pause/unpause if state is changed */
+	if (adev->vcn.inst[inst_idx].pause_state.fw_based != new_state->fw_based) {
+		DRM_DEV_DEBUG(adev->dev, "dpg pause state changed %d -> %d",
+			adev->vcn.inst[inst_idx].pause_state.fw_based,	new_state->fw_based);
+		reg_data = RREG32_SOC15(VCN, inst_idx, regUVD_DPG_PAUSE) &
+			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
+
+		if (new_state->fw_based == VCN_DPG_STATE__PAUSE) {
+			ret_code = SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_POWER_STATUS, 0x1,
+				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+
+			if (!ret_code) {
+				/* pause DPG */
+				reg_data |= UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
+				WREG32_SOC15(VCN, inst_idx, regUVD_DPG_PAUSE, reg_data);
+
+				/* wait for ACK */
+				SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_DPG_PAUSE,
+					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
+					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
+			}
+		} else {
+			/* unpause dpg, no need to wait */
+			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
+			WREG32_SOC15(VCN, inst_idx, regUVD_DPG_PAUSE, reg_data);
+		}
+		adev->vcn.inst[inst_idx].pause_state.fw_based = new_state->fw_based;
+	}
 
 	return 0;
 }
-- 
2.49.0

