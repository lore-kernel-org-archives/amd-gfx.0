Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D06C44536
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 08:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0469B10E954;
	Thu, 22 Jan 2026 08:58:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iRgEfUwJ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1221E10E959
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 08:58:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVQD8l9bW2hjmfKB2MZowk65Wmz/YQlj5yzppUcO464x8+mu2gwt6pl9lBHkyjC2UE5odJ+gnMbwQmzc7fA36Alv3/5vEz9H2ZZlsrrdTi51LBVbyOv23DaQstentTF3vRWo7kpqstIc2ILu0Ae02ko2a+HSlYBFFAYTazkzyDWYXroFBD5JgTYms46I3cQWiKyYoN9TTGpCn+v6hepDnQMcYB/g8a1fpSxUvMgGoekzTrDBdGC/8nawHxo8dDsFPSCee9nBL4QFkWw8LcLpTUfed5DWC2ycncMFQCsgeJLrq0Y3j3yhbTlmguoNLMlojEHiib5mDwC4WxC8WnSVRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmVzITBiSRpbGzUG4tPM8eLbJnkjB2JVsyyY3s9C70o=;
 b=Fbtd6BfzZAG98ENmgGUAZ9MlpWzibVBVIjbqktpjbzb86vwTCHBMwMXxiyfLRaX2ye9rLYqx/kczRErIWPsbNDsHQWyWdUh2DyadoxwFUWFYxRByXonXvsdE8Qd0iqZew+UBQKYY48XsC5MECLDN2ZJV3+FoyfzoBycBw9NtpGNSyTTT1QdxyVu5scO9aUiOwkc+u7QEo7bSJm/fbr73nRXynkssFRBUrO8mKb8RByBiil1HdRNP7P0xQpmIBXDEqMsu4rIMs+lkf9DmshUpCDRpAdMWRr1fXbqbQ2LK9J3YQ2gNORri3HK0YquBdXmqk5WZEJUNwWgi34N0gpqVzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmVzITBiSRpbGzUG4tPM8eLbJnkjB2JVsyyY3s9C70o=;
 b=iRgEfUwJAqS/ETaWQfNivYVM6ipIc9Z8Dv2nLXWw3M8NGGTBra//xQTcP5Yc9OMD71HGte4Zm4dnHcB83I3hofi/+VjTDNj0Vvxl1XJfPc5eq3kHLIdDvsN2WZIfecdbRcqFiQosvWuz3TRIKuyznSMh0aehni6KXEy2N+OkmIs=
Received: from SJ0PR03CA0144.namprd03.prod.outlook.com (2603:10b6:a03:33c::29)
 by DS5PPF5C5D42165.namprd12.prod.outlook.com (2603:10b6:f:fc00::64f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 08:58:26 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::c6) by SJ0PR03CA0144.outlook.office365.com
 (2603:10b6:a03:33c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 08:58:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 22 Jan 2026 08:58:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 22 Jan
 2026 02:58:25 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Jan
 2026 02:58:24 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 22 Jan 2026 02:58:17 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 6/9] drm/amd/amdgpu/gfx12: Add CU mask and priority support to
 GFX12 compute MQD update
Date: Thu, 22 Jan 2026 16:57:16 +0800
Message-ID: <20260122085738.1542800-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
References: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|DS5PPF5C5D42165:EE_
X-MS-Office365-Filtering-Correlation-Id: be0ed3f9-efa5-4c50-7e87-08de5994679f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vk1GFAZA5Z3PiDqrldo3AiSwhJENF6/3WRxZ6yEkwGwlQhBS6tM7rdSSNZvU?=
 =?us-ascii?Q?nij1Gf9qSMqPfJXc5+lNFzIrbtlGukFSCmX6MmCK2pOep7waFmVQoyRo+x7s?=
 =?us-ascii?Q?0cBJgj1K8Shqtdfmx1qJ24snU6R+QJi0NxkVduwKnUFXnh7nP1hEzESPl8Nj?=
 =?us-ascii?Q?TEWTfxAOFkT3GeBjcWz9UOqufceHD2WFDgjxODHnmV5wqJiciCpAj3EfwBxl?=
 =?us-ascii?Q?fIsWuKZQIXEDvZl8ujbAqH6xFldTHTAT/tNcws7hNeCErcEOZKGJ5bAK0E6R?=
 =?us-ascii?Q?uvg2utjIkwzhSmHgwaj6fcVChkwN6oSkZtw4XtdbDBE+cF2S5zA7/cnug4bl?=
 =?us-ascii?Q?s5xO84eP92LK1sudXF8i2IS/3fW3a8I+UwObHSTk/kVj93WQ3HKk5uq1qRDA?=
 =?us-ascii?Q?+BDFm/CR56XVeur6jvcjr12Rm7IBZ9lhe0WqIc6CrQ2fICGcx/iwNMrUMPa2?=
 =?us-ascii?Q?Pvit2SYp1oqfQeRgNdqyzksqD2vzdFn+weXP7cWb8U3EE3T9a0O0nIU2yQuq?=
 =?us-ascii?Q?sV0poW+sgGdFvKPwfQfwjQK/PQdTf+ua2LobHTWZFbyTcO7p9OktilG4RTKm?=
 =?us-ascii?Q?QLUX3I0aIDTTlNF+tInVxu5TZ0XSb6IT7BGP1l4jZqGhvVS7u6yAEkq9aaOt?=
 =?us-ascii?Q?7N7Geqlh6dz8IrIPI4gk7C6ki35epyJWL30/tmZWnOtxLJ6CicpkBGPrFCgW?=
 =?us-ascii?Q?gWdoTMe/vRLxUDXu6LBQTNL3ZGAV0w+QXVf6pEiBT3DpV4jrhhjmiW881bjZ?=
 =?us-ascii?Q?MsvvbYMo+U32X1D+lPS+Yxl/uNw+xMVx+7vDJRCafq5pWavSTgzxe6nO9YEP?=
 =?us-ascii?Q?yhMhkteDti/gLe6riPdheoAg2IHj/icS2MChMTBEaTJXZhB1VCYRvm/nC3cM?=
 =?us-ascii?Q?d99DBO9QkJwnAp8xOPJ2QVgMLawDtBzt5PsgNeOwzy5rchWXx4rQDLMPgMM0?=
 =?us-ascii?Q?H0AVv6CWGktJZQSz/O8Aqx6VpTcJn/zCQgO1cNNQ+n0YAAayYrDVVL91rjfq?=
 =?us-ascii?Q?DOnxIHBQ0HTCn1O8pHRuJgRLEiAQ9Z8Hn7Eu2eynSzQx9hhMLycP3cEjHrG/?=
 =?us-ascii?Q?YB8OAsYpxeRUd9L4N0cqaHwDIkmAVPmN9IAu+TeiQDEfggLodEHyy2biEAKK?=
 =?us-ascii?Q?6fsbCWRx8I8Oeytg7/uRkMOe1DL4vJffki9kAlmBNoFPT1h3R+Pq8CLnwtHz?=
 =?us-ascii?Q?UMtkIfrr6scbTAz/gjuxKTEpNkvm1wDsvK0VpfqZm4udoIfPyUfsizTjQ25O?=
 =?us-ascii?Q?z/YRqPAhx2OwDpvMPSNMmOq2G/Y3O4ztCHpjkZ0utTXhig0dXHssVry0gRS9?=
 =?us-ascii?Q?mJwcUPKOGtrZLsfVJerPWCb4YEvDbPfx5Uq/jBvSPQbfKiOHI+EV8gf1WcX2?=
 =?us-ascii?Q?z5Z6vnK0rxEKV1s33RncEKQx+6OkAiAgfa2feTvRF4I3enl6gjLjhIfwipmH?=
 =?us-ascii?Q?QRMSm/M1BLj9jZGHsCBYzDtxr0XhQLKhF1lk89xHlKCn0NXZJO2nKnlANBin?=
 =?us-ascii?Q?KOTINiAXvfFqR8bWjzrNjfyIashB7CUAMHh5IjEYJkOHBwgbLBOwYv0QqgpL?=
 =?us-ascii?Q?P4OCnxguw+MTP1+ocmQyBumexQO0ksh9XD0fYrLbpNxo6c6g834i4khQd4Sp?=
 =?us-ascii?Q?Nm3t3dPcbB6gWbygS+e1TGIOPpwFb6orr1ul7xGV0uikTqn/enPgwQNhD5XG?=
 =?us-ascii?Q?0LGTog=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 08:58:26.0392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be0ed3f9-efa5-4c50-7e87-08de5994679f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C5D42165
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

- Extend amdgpu_mqd_prop with CU mask fields and debug WA flags
- Implement GFX12 CU mask mapping (WGP mode) and MQD setters for CU mask/priority
- Integrate setters into gfx_v12_0_compute_mqd_update() to apply runtime changes

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 74 ++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a0180699e492..1d55c64d94ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3110,6 +3110,79 @@ static int gfx_v12_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 	return gfx_v12_0_cp_gfx_start(adev);
 }
 
+static void gfx_v12_0_mqd_symmetrically_map_cu_mask(struct amdgpu_device *adev,
+						    const uint32_t *cu_mask,
+						    uint32_t cu_mask_count,
+						    uint32_t *se_mask)
+{
+	struct amdgpu_cu_info *cu_info = &adev->gfx.cu_info;
+	struct amdgpu_gfx_config *gfx_info = &adev->gfx.config;
+	uint32_t cu_per_sh[8][4] = {0};
+	int i, se, sh, cu;
+	const int xcc_inst = 0;
+	int cu_inc = 2; /* WGP mode */
+	int num_xcc = 1;
+	int inc = cu_inc * num_xcc;
+	int inst = 0;
+	uint32_t en_mask = 3;
+	int cu_bitmap_sh_mul = 2;
+
+	for (se = 0; se < gfx_info->max_shader_engines; se++)
+		for (sh = 0; sh < gfx_info->max_sh_per_se; sh++)
+			cu_per_sh[se][sh] = hweight32(
+				cu_info->bitmap[xcc_inst][se % 4][sh + (se / 4) *
+				cu_bitmap_sh_mul]);
+
+	for (i = 0; i < gfx_info->max_shader_engines; i++)
+		se_mask[i] = 0;
+
+	i = inst;
+	for (cu = 0; cu < 16; cu += cu_inc) {
+		for (sh = 0; sh < gfx_info->max_sh_per_se; sh++) {
+			for (se = 0; se < gfx_info->max_shader_engines; se++) {
+				if (cu_per_sh[se][sh] > cu) {
+					if ((i / 32) < cu_mask_count && (cu_mask[i / 32] & (1 << (i % 32))))
+						se_mask[se] |= en_mask << (cu + sh * 16);
+					i += inc;
+					if (i >= cu_mask_count * 32)
+						return;
+				}
+			}
+		}
+	}
+}
+
+static void gfx_v12_0_compute_mqd_set_cu_mask(struct amdgpu_device *adev,
+					      struct v12_compute_mqd *mqd,
+					      struct amdgpu_mqd_prop *prop)
+{
+	uint32_t se_mask[8] = {0};
+	uint32_t wa_mask;
+	bool has_wa_flag = prop->cu_flags & (AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE |
+					  AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE);
+
+	if (!has_wa_flag && (!prop->cu_mask || !prop->cu_mask_count))
+		return;
+
+	if (has_wa_flag) {
+		wa_mask = (prop->cu_flags & AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE) ?
+			  0xffff : 0xffffffff;
+		mqd->compute_static_thread_mgmt_se0 = wa_mask;
+		mqd->compute_static_thread_mgmt_se1 = wa_mask;
+		mqd->compute_static_thread_mgmt_se2 = wa_mask;
+		mqd->compute_static_thread_mgmt_se3 = wa_mask;
+		return;
+	}
+
+	gfx_v12_0_mqd_symmetrically_map_cu_mask(adev, prop->cu_mask,
+						prop->cu_mask_count, se_mask);
+
+	mqd->compute_static_thread_mgmt_se0 = se_mask[0];
+	mqd->compute_static_thread_mgmt_se1 = se_mask[1];
+	mqd->compute_static_thread_mgmt_se2 = se_mask[2];
+	mqd->compute_static_thread_mgmt_se3 = se_mask[3];
+}
+
 /**
  * gfx_v12_0_compute_update_queue - Update runtime-configurable queue parameters
  * @adev: amdgpu device pointer
@@ -3150,6 +3223,7 @@ static int gfx_v12_0_compute_mqd_update(struct amdgpu_device *adev, void *m,
 
 	mqd->cp_hqd_active = prop->hqd_active;
 
+	gfx_v12_0_compute_mqd_set_cu_mask(adev, mqd, prop);
 	return 0;
 }
 
-- 
2.49.0

