Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650F1C54798
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 06:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4D6D112895;
	Tue,  5 Mar 2024 06:41:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="StJcvcA5";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 939C6112895
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 06:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqfJU3tm0Dk4TW32HxtCEvt/1+XKbPHbNaMHTkoNxCrcAoELX7WnNh/WJzUIm99KyZH3jyo6ghFr9Q5A4Wt4BQWjmlHCMNveh8gjpqn6DcQ8p8RCAuEue5FF+9pEUoC0U5sI9NfY0FRYVs4Om5iSQAllTCU6c4qjjh3IocCT+J6x13x8d2EgHek8RXLL9gtPVPvgwG8v6KawjnMKstu1S+ONUnsYJoG0bYGrr0oXjBzdCNQjC3ts2WjxPoo40/v5cMnmRyf8TtTsNN0xV3fpKMpFCb6pxrqcG+8kg4QmgySotR32ahiD8oDww1hMUmI5PlnBfJGnluznmdhftp5sgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRidR+uRP8HkfJ5geaR9PRQGOs5mlAqNNQg+aHrQM/M=;
 b=R9OJFdQjbHspOjLN2pKCS8jaILaYhLut50ImpZ68mBk5I+RgjGx7KoWFPH/0vj5od/DxU4BdNS0jFo2zXgxm/4QhC2c9gx7TaWzbucRMR+zUcLfF7jepKpYIzQ+qI3CMspU8nkXqW+l9fP/n/GYSTYzpeHHaHHwvD+a1TyDkAefKfr1nOJl1C6BE/6CxVmQAgZBTJj28svbBHMNPng0pnX9fxyGSpDOAN3WQ1BfhIIKB0bmKVT8MR5md2T0kD0raTrvPnYvXVmlan9NjC3UI0Dfn9AUa3izp1JNdC3YsZVCNlZqnNQYn8EZHdImCCmDrMlF1RGemLgsoYNT/4noh2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRidR+uRP8HkfJ5geaR9PRQGOs5mlAqNNQg+aHrQM/M=;
 b=StJcvcA5IDCPLUpkUKCQoxF+dT7Unr3rtnt075IjttqlD3CwxOuuH+DJ2hgMP/aohxC+AL/t7xYO88p7yldnQZDYz6AHuarDmYsE8DuhLpJTRcUNSM42ftH4Ip5SIinqr33hldZ7ZPC7l8moIyu2tzuIVRzi5K3y+AFeraHXI48=
Received: from MW4PR04CA0070.namprd04.prod.outlook.com (2603:10b6:303:6b::15)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 06:41:01 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:6b:cafe::5c) by MW4PR04CA0070.outlook.office365.com
 (2603:10b6:303:6b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 5 Mar 2024 06:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.0 via Frontend Transport; Tue, 5 Mar 2024 06:41:01 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 00:40:49 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <samir.dhume@amd.com>, <leo.liu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Use offsets local to VCN in VF
Date: Tue, 5 Mar 2024 12:10:31 +0530
Message-ID: <20240305064031.548905-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240305064031.548905-1-lijo.lazar@amd.com>
References: <20240305064031.548905-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SJ0PR12MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 07012b8b-eb4c-432a-b9c3-08dc3cdf3911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DxiM0IcpOs9IuIzoyVQUMoQBhYuws8CfESccI+ypkuQchZ9PMBuRIPdrXh0KIioS4rPAoV3NdLD9SCdWL+emhSpgGkb502ZYnOOhBLiO8LNvA+cCuzGkIvtpsy2IPaKcB4XXaRhsdO2MN4ibJGE7Bc+zCB/8CcozL3Qy713vcenCe+pPBFrY8r0Hc0D9Ypkr9AY3TPLB9Q13FGmLCVP7ewaJHdq4diGW/11YSf1jmEBn+ETDZQtq0y2ZyP/u3nOnys6TzZZivSnKK3egVKvaQGhq11L8OhQwsOdYsEQgB/Vnxrz9SJiO2OsJrelzUXz0tj/vOqGbkNfNrT2uXZ5TVylDAot0AyJ3Ly1OTNWVecIRIFZ6WPyPNYWhSdvlPqfIdHadP9zUdRBS+9QOAF9HQdzEBVK5y4RDJH+FS/r309+8EjHoVmzNW1/JgFBMlWoXIkS5uulcJ0Wc8imB9pZvmMKW/vcm0aCcoGpMTRc/euYi2iOV7ypijei4Nc5EQK1J1yIAv+igfWzkqMM3FNRGaKClL2VkpVy34JGbc0uFGeYS1O4Z6ouuC7tx2OymPrmwkhfzhGVwv6GIBSjhrUeD22DbNvk3g8VIc5fMgVo5rewfVJ4E9G/mlALm8z2Odm5MycUI2zbrYvPmBEJhuBzbSMRirG4m8Bqjr712L6dU4FFflB2v08TnXo3KwnxCMdUy02u1E+XuuTVDo+MxUyTGRryHK0Qgfet+TqhjrqOV5elzR5k7pzQQhPcdmS0Jbtvf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 06:41:01.1041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07012b8b-eb4c-432a-b9c3-08dc3cdf3911
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879
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

For VCN 4.0.3, use only the local addressing scheme while in VF
mode. This includes addressing scheme used for HUB offsets.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 7b5ad13b618e..a27f3f260aab 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1381,6 +1381,24 @@ static uint64_t vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
 				    regUVD_RB_WPTR);
 }
 
+static void vcn_v4_0_3_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
+				unsigned int vmid, uint64_t pd_addr)
+{
+	struct amdgpu_vmhub *hub;
+
+	/* For VF, only local offsets should be used */
+	if (amdgpu_sriov_vf(ring->adev))
+		ring->vm_hub = AMDGPU_MMHUB0(0);
+	hub = &ring->adev->vmhub[ring->vm_hub];
+
+	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
+
+	/* wait for reg writes */
+	vcn_v2_0_enc_ring_emit_reg_wait(ring, hub->ctx0_ptb_addr_lo32 +
+					vmid * hub->ctx_addr_distance,
+					lower_32_bits(pd_addr), 0xffffffff);
+}
+
 static void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	/* VCN engine access for HDP flush doesn't work when RRMT is enabled.
@@ -1443,7 +1461,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
 	.emit_ib_size = 5, /* vcn_v2_0_enc_ring_emit_ib */
 	.emit_ib = vcn_v2_0_enc_ring_emit_ib,
 	.emit_fence = vcn_v2_0_enc_ring_emit_fence,
-	.emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
+	.emit_vm_flush = vcn_v4_0_3_enc_ring_emit_vm_flush,
 	.emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
 	.test_ring = amdgpu_vcn_enc_ring_test_ring,
 	.test_ib = amdgpu_vcn_unified_ring_test_ib,
-- 
2.25.1

