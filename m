Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADE0C7EE3A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6873110E426;
	Mon, 23 Jun 2025 16:15:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TSNAkqVe";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB0610E408
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQo1cu3xerwHn5yVdYv4wno7hIdb6w4OcsFC/WcxI7lWgwkh7879k18QigY20liMZRiwWq+k2v7ljF4JI4a+N8AuqzyyI+QNfDjiZXbIc5Lh0Se/oyxFoReOgZwxcHDGH2cVyI+msTGiuru/Y9iE2TJzEdZ1SZfDYCtaPurqpS7oNzVhow7kfzOaEzmdRE02WttCBkwl/ugJF/7EdoR+1WEtGrXMulYbyuBrF/JnHHdJjchBhbNGRWbMbx10EAHgDE0o/ssEi32uO+EoJ9rDaDkJ6EI20n40TGFiORcNtvL0Yr0XfsSXRjI2xA6yk90RdZ4PiBxQqUQrcuVDVsFL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noE8h9Ijrcb2izOFQLmLJwgFa0u720BMEexAvhAJIlk=;
 b=GuDHkwNIt7rWP9JdpEYF9vmCDLRCr/wkp0y3o0qqKE4kuPZ2h1QUrmi905K5BFC622HqKpS/VQRLV6u0xDbG7zbowR5FkIFjnDPOu9t4tLJLBRiM8MIsuKrfKrTR84W18bEYOL3fvoaZEIBEff/ZGQoYoyuyxrlTHNZrMC3Sj097kNUvmLBm8IOf2zEOD2fzUx7v45MR5EjZXl9Nft+gj8pfS7kr3/Nio1DrUaoQqxeDLlgjs65tdf8NQJnhn4WzvdjLvCsF10R5LMJ/bD77u/qN1PjMHBKIMHm7ziyMnRDlyeGAFOoR1awqJvqGA5RdBSumI4EmzAdGtqP7IzjQGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noE8h9Ijrcb2izOFQLmLJwgFa0u720BMEexAvhAJIlk=;
 b=TSNAkqVeR5Z5rFVcXh2yNS0OdIukJYlJPFB1XGAuqc2gQM+kYWxXl07hK6OfoasbQTBn6/oKbyYzjqzeY/v4fS6Oe0f0ZLbmwXiYz8Qpv066p6CJTticoKBQgDMCrFZmCXevYvBhhCwTWVtjS65disIRFLTRVAKJTcqPcw71+HQ=
Received: from BN9PR03CA0942.namprd03.prod.outlook.com (2603:10b6:408:108::17)
 by SJ1PR12MB6265.namprd12.prod.outlook.com (2603:10b6:a03:458::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 23 Jun
 2025 16:15:14 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::a) by BN9PR03CA0942.outlook.office365.com
 (2603:10b6:408:108::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Mon,
 23 Jun 2025 16:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:15:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 31/31] drm/amdgpu/vcn3: implement ring reset
Date: Mon, 23 Jun 2025 12:14:37 -0400
Message-ID: <20250623161438.124020-32-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SJ1PR12MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: 834a51b2-4f09-4788-703b-08ddb27122d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MVjiBrAuXF5O2XDjtnB4TyGjAJa94s8dLtpGi6SFvKrp+Og6IhHQzHyNKnng?=
 =?us-ascii?Q?IWZ3DLETWfEG3f0qG0jEHu5BlimaO2TrQ9VA3fGcWoo1zcjGYEYs7Y47Aj+F?=
 =?us-ascii?Q?Yo3UFZks0any/LCgencQM7yqGQJG35UTxwaCkyJjR2/JN+01WF/NiYPHCTx2?=
 =?us-ascii?Q?uUCpUwWiTwuP9AkDxz03RDvR/mQNS4KWPMZFJ1OruUfteiqvlN0GCYRCN+bU?=
 =?us-ascii?Q?k9obApOq8NoysMuCKGCzOnaw0eOpRELhLXanRwGtD/+RXI1BNIPUgStpePp0?=
 =?us-ascii?Q?SDR2OteCgtH/d3ijFcBFeGyhjrPu1gNBGBj5cGwGkABcIZxIehG2iHTcNgvr?=
 =?us-ascii?Q?Fq+GlSCJwfFbX5tyd4HuqHNKg5sgmDaFLqr8OWIeS9M9UE5XR/Db68Bc3X3+?=
 =?us-ascii?Q?JlHPaPBUrPXVyMBXLUCaf0Xh2i+X5FhpmcpdeAw8bSEQvqc8QT0dWEa6P+iB?=
 =?us-ascii?Q?VOaZWipsXFQvuxh0E01E6dco56c/UU4rnR8EVX1HkA3Obah8dAmTlo5RnA60?=
 =?us-ascii?Q?woKUbYH4OOR1WkNQIMlTIRkyOQ6+WvawQNdteuSLijNH0xKaSI5z9YUD5FOK?=
 =?us-ascii?Q?T8WlkS713va+Uf8Iio+3NL9o8z9M0CuONQ6iJb5sf4R2vDICemcQ8CPR+FRd?=
 =?us-ascii?Q?RkLlajeVUehEPy8rbSwEBW4v3gkoJp521/2GmkWqQKNVKoSmN8hODYRjp7Ts?=
 =?us-ascii?Q?z048022BFwVL/gxm2OoVxnwGtWwRJgiVlZ0Fe7pFe/www3Ub+1Is2R32+Q4/?=
 =?us-ascii?Q?ACIdvUNlXgKoaht7u1gVWhky7bR5a25jhZ54yuucyE0Q7mMN+nw+rByCUOVV?=
 =?us-ascii?Q?/dJm3LY/qSesXcjtobT8U5gTsHk0BiwcdHaUUkmY5IfXQvAvYjvGR9F5fNJA?=
 =?us-ascii?Q?kOT51sUMl+k9NEis55dGfAhc9wcwDxksLhxkIxN8VFf49pc4uETngJfWyShg?=
 =?us-ascii?Q?wa4CE1oXPUVdjmIuCzCbbffjfNp8ybXvnYAMxz1QpmYd2oU5abYx8+AnbDaE?=
 =?us-ascii?Q?c9gHreZhFqYrkkopvZPlTuhLSGFRWHBOmS8PCuvGe3TbH6fT6+XOCwQbXGoN?=
 =?us-ascii?Q?agY+zFFnShOxV88qcBANNbMjOKgfU6j3Ag3PaafxOkU49tb8+oxNyqmNJLdv?=
 =?us-ascii?Q?Z94iH1gXdf+Amic7qjx2XxrQaB9bWbVtGZbS3+yoJ6e0NG7+KduPqmipzGgS?=
 =?us-ascii?Q?hl1H6bDeH4T0h7LhknuJ1Hw0nfGjDNs9BDAZS8cQ2QsTlZNX6zFp7M25NQ0k?=
 =?us-ascii?Q?KBEBvTcrcxWy4GeRwxABYY087aoJhLdgsml+qHuh9IBUylT29tzmeDwgXyVj?=
 =?us-ascii?Q?OYBswNbprI9JkheilQ0u0hDicsL46RDroZG0goL++AennoxAPlMAiHG9Q5gD?=
 =?us-ascii?Q?stMYXGC0eX9ytXh248TTvbwduY6XG0I8O1eOTmb7WKsHjU8r1U2yzCLWvgAL?=
 =?us-ascii?Q?jJX2aXN1CLXKdGik+B5PQW2ctCVlF+7rRVQ8KwFXyH540NyDavUAsrJndig1?=
 =?us-ascii?Q?DKZ7Z2bSIyKIWwlovcAi3468klth9vhxNmL7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:14.1617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 834a51b2-4f09-4788-703b-08ddb27122d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6265
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

Use the new helpers to handle engine resets for VCN.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 9fb0d53805892..dd015bc6fd0ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -110,6 +110,7 @@ static int vcn_v3_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				 enum amd_powergating_state state);
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
+static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst);
 
 static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring);
 static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
@@ -289,6 +290,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 			adev->vcn.inst[i].pause_dpg_mode = vcn_v3_0_pause_dpg_mode;
+		adev->vcn.inst[i].reset = vcn_v3_0_reset;
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -2033,6 +2035,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 /**
@@ -2131,6 +2134,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_enc_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
@@ -2164,6 +2168,15 @@ static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev)
 	}
 }
 
+static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst)
+{
+	vcn_v3_0_stop(vinst);
+	vcn_v3_0_enable_clock_gating(vinst);
+	vcn_v3_0_enable_static_power_gating(vinst);
+	vcn_v3_0_start(vinst);
+	return 0;
+}
+
 static bool vcn_v3_0_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-- 
2.49.0

