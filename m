Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5993D3A67B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 653CC10E398;
	Tue, 29 Oct 2024 17:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K05B9+j7";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7973110E6BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hf7KmtOsP1hlKxMfTqowZOm1PzqseCa0aYm/N1lwWYmUVqGkOKG+/JLs+O3ZbzBlRG4LxQMBdielaugzsvIPy/aJOv1Ebla4sUCbr9j6OhV0YdcoTJuyOvlBAjjtdSzhQLjwvD/G0cp2Y2V4SiYAJRzbJKt5PfAZ56bl2DrJdmFkjgkPeVe4Knl3nl49w8RYVnSp28m+5yKu5dTitZ0t7YOINvECy4w/Fal8G6SnXGVVXwftCusYrGWbWE7wk1MR2zEYRZI6qgZDh9nL/BHl98HwMV4HegKQrlSk9wYyNjWffnAqVtC0NyaHdy7e/rwxliLc9DoPo17qyajWsBTPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwpn4PDC3/fZfHnY/XAnyIu3199BSuJSdxQ01seR3uU=;
 b=HjXhtusVsXy5G59v0lBP+jWXTxZZKkPjhBCPDbHj0Sd8efAtMLYhA+kgU3U1RPB0NL9rGYMY3w0S6BxC84JVQEL9Q6XNVjerTGeG7rq8fGw6qEFDDdm3+Ea8Qzr0f28OShpUJ3nSf1jiPNtcngOHn08Kobweeg3IhCO3enI1hFY1Chu0Gfc64/vsrtPuIpydnOoC+5qgVPGLrYf8sg9zctv5K3VW668bcjwzxZx35TJlHqXiRMG1YnZvo2dwCZoIov94c5XGVyFOt5Qra93+ztan2iJekhqdaKvuKypfvfT/Tomd9EA+49JXLD4AjjqtgkU3fUGV7v3sRP94XVc/Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwpn4PDC3/fZfHnY/XAnyIu3199BSuJSdxQ01seR3uU=;
 b=K05B9+j7LUNjCGjzpJUBDLRtpKoJaMixbWJyMjIxtm7dLOc6x5Q7z35IBuJEYBBIqsONDVpQze6w7yg1ijqlNJ7GUxzKj1G9SRFYzESQX7J0/KSf8pLRrdqg+5qp01Tzf5HO70ynDwvRlABh1Aw/pem4O6w7wVqYbsDy9MxTVzs=
Received: from SN6PR16CA0053.namprd16.prod.outlook.com (2603:10b6:805:ca::30)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 17:43:11 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::10) by SN6PR16CA0053.outlook.office365.com
 (2603:10b6:805:ca::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 17:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:43:10 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:43:04 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 27/29] drm/amdgpu: set funcs for each vcn instance
Date: Tue, 29 Oct 2024 13:42:38 -0400
Message-ID: <20241029174240.682928-28-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029174240.682928-1-boyuan.zhang@amd.com>
References: <20241029174240.682928-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: a8fe90ca-b56e-4640-189c-08dcf84127fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHJpZExaNU1iZUFORzVjTzRacEM4U3VXNlVBTUM1Q0NVeGorSmxZMWRvTkFP?=
 =?utf-8?B?YjlBTXE3YlhZR2hiT2UrOElrWVRJcS9mUmtUVDg1ZWdtMHRUR2ZDaHhTZzQy?=
 =?utf-8?B?ekw3NFhHR2NJRHVQdFNyNU1UWDlNb2JpR2dQWHI2SFVaRjlrbnZ5VGVrLzJS?=
 =?utf-8?B?RDJ3bExXYjBNSTlqRFRwZ1JRQnJFN0lad1Q0M2FBUWpxa2RQTmhHc3hNelBu?=
 =?utf-8?B?QmpTNDkyMUd2RXkreC9ZWWRoVGNBaVYybDg1dGNadWNEdFg0SnNJdEhJNFQ1?=
 =?utf-8?B?alNxalV2UHlHQ0NRd2FRMlgyZis2UE1wODA1T2orNWhTVmZGeWxnbDhUaU1w?=
 =?utf-8?B?QmdUS0s5VFBBQ20yWFk2WDFJSUJ6SE9FMmk2N2Y2WFZQOWQ4Ky9xNk5KKzM5?=
 =?utf-8?B?YTg2ekM5QUloT3U3T3dHclRDSkJ0eEM5N0gvVVRJakl6OFo3WW85ZTZOditM?=
 =?utf-8?B?dWtmWjhsOHBZQU52WGxsWEU2OHQvYUEvMXUyS2JHa0lQeWUwN1RMWFhmZFZI?=
 =?utf-8?B?SW1nb2ovTmtEeGQrNmpPQlRZenFWZCtVVnRUMld1Uno5OUhLMnBRV2h3T25r?=
 =?utf-8?B?MHlMdVRPTG5BeHNmUmRxTmNBTm9LTy9ST3N6b1daZllPQzE4MDhoTXk5VHJS?=
 =?utf-8?B?VTNNckhMQkdsT205QzZPc0o1T2xPVUptQWRVWjFUS1p1bnlySG5BeUZrRmtr?=
 =?utf-8?B?TytWQm1vdkY3QTMvMGVIRVVHQmg2Q3FtcTZkS2k3RlNLSldmOEdVSGtMeXJK?=
 =?utf-8?B?ckZXNjcxNmNjNkRwdlZBSG1lTm83Q3NFczIrTmZLVEVpYlM3REVsQkpPc3Rw?=
 =?utf-8?B?SkVwelBiSmczY2hkdlF5aGF6OFJNRDFXZVRCRnRIRTBCaFp6Z0ZhMFdNK1Jt?=
 =?utf-8?B?MndDUllUUEtnbVFFTGlKd21KUWQyQkRwOUxmN0NwQnBpMkR2Z2l4d09Kb0J0?=
 =?utf-8?B?dDdtcFM5L3lYSEFLNStGWEVtbGhRRENJUE1MSnIyQk5rUFk2QkZnbG9UaHFv?=
 =?utf-8?B?bDFyNHdnTFQyajFQa2FoV1JwTnNTTGlpWlJGK3RrcGQxcVh2RWpnK0VFK0RD?=
 =?utf-8?B?VG5ibjZnNDl4UTRwWUxTcFNWYkM1U0M3MXZjaHlJbU5hTnpDSzlRNmYwVG8y?=
 =?utf-8?B?L1pkVktFcVhmRVZZQW4vcmIxWkhSRkRxdXdSc0dNN0FySER1cjNXNmlVZWgy?=
 =?utf-8?B?R1EzMGxjK05YSlFmdHZuTXlzZ1pnOG5SUTNsc0NVOURNYXE0WDJxUVlkakpV?=
 =?utf-8?B?UHZKTWx6TFhjRjdWeG1ZNFo2eEt0S0s2Wm42MEVFZjFidUZrRjdNcSs1WlJ1?=
 =?utf-8?B?S0JTMHZ1ektobXJlWGNrYi9BTFFueTM0UXpVd2sybFFvM2JSUXJaTTlKL1V5?=
 =?utf-8?B?dHZnYnhUMHdkSGV0eTYvMThYVkZTRG9OVGlYOGliWmlPOHdKZU5GUmtiRUtk?=
 =?utf-8?B?ZEpUWU5NNk4rajBIdldQL2JnbDVQNkt1MXNZRlU4S2RyTXNEWGxDc2thQmVY?=
 =?utf-8?B?L0w3RmNsa3BjWGRycFpIbWhSenEzNlJGNWVFOEt3Smh3d0NoM2tlV1Z4cGFT?=
 =?utf-8?B?aEVFM1hOa0VhRFpyWDJkZVVFU1ZxMVYreGVJNG5JMmgxeWVCNnJ6dU0raHBQ?=
 =?utf-8?B?eHhSd1R5ZTBSUTJRcXRldmRuRHZGeDU5OWdmNFZjWjgycjB1VFFOOHhmbjBD?=
 =?utf-8?B?U1djYU1yQ0V6ZlkzZWJoLzlKR1o1T0hKSnVrejFDOXMybDVKSzZIL2xPWEJu?=
 =?utf-8?B?Y0N0K1U5bzFhWGtnK0lKQXlSTXNwUnpoeVQ2a1hXckNodjIrRjE4YytvMy9n?=
 =?utf-8?B?YU4wenhuUjlhRkxNR3gvRExVNFpzOFB4T3FaakM5d2JUeGFRKzdvSkF4bGxR?=
 =?utf-8?B?ZnNVSlBaK0tqYlgwOWZ1N1o2TjQ3dzFlUHV4T0xpT2JNRHc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:43:10.6513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fe90ca-b56e-4640-189c-08dcf84127fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045
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
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
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

