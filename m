Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E51C3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 13:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6FF920848
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 13:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oI6EH0wU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FF920848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2536E321;
	Thu,  5 Mar 2020 13:33:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447606E321
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 13:33:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngFgYKP5JWFjqchS5sm3UrUxQQANwbWgI6dhxK5r4obxh9+otB4p5kYQsIYC5Lqr5VuSEyKVYBJJAaSUG1T1A4OL9TdkdCn69l0Ak11bhNvYDw8OAtztwZSoIVKltZc7m2mG7CXMZtq/Hj5o7/kyL1hhlThfxbzUX52dxytpC0lA3Re1+qTybxFL6LCsXk0LvP5lsvZfXjvQAIg7SBbEkkdnePpTVVt599e6UcWw3En4+6yW0/zjfaPGOTRSQyQCKhOnYHacR+A4FrZ/huXOY04ptvrQ2nU5g7/vy1Z4kiY2N8yocF20BqSu3jFw1VefO69OdTnuphCQnH16/HIvrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/W1mzzXRSdfyyzoOfKsVdCyGQdN/wcFBW3g0HHdIlk=;
 b=FwRUlcTgQKjtpd1FzSfmqPoYLoQRtLw9kE1029AUGhJLLnOgp4M6qje284lwOZGPYCHur21dxyb0JTmHxpe0iIn9tMNcALC2VtKPtn6ZZ9tF2m08lVJa4dIo1LSgliyL0FA74cSfmrxyICBlltcdFZxRWTabwPiVNCbFlCU12+t1PStJSfINP+mZDgMCjgyAFLOSFk+mD/8uAs8QSpConw7DrFCJKgDQjDN0rAPWHgkMQjbN4C+/ktrHp/jLOsEuTOBUAmqejF/Xb2wYogE31WEXKHGGFrTgllfK2lTFmbAC88SI00TJvLk6LJQSIHXV6Dxenqje6PqFPEsJgJLqdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/W1mzzXRSdfyyzoOfKsVdCyGQdN/wcFBW3g0HHdIlk=;
 b=oI6EH0wUSFmGz6mJLSkON+QuGhGB7SDk3pCO26RV7hRw7VkgDQdrY8zOSkr4ralEODqwyaE3WJSr2twLMUpnkbDelNcPOcQr1CURaSujaNBBXNAuhvrd8xVdzfHzgbOth5WEHoNqAZaGpxH/SUchRPvdAx07NqMj1edHo1pSVOU=
Received: from BN6PR03CA0023.namprd03.prod.outlook.com (2603:10b6:404:23::33)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Thu, 5 Mar
 2020 13:33:23 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:23:cafe::bb) by BN6PR03CA0023.outlook.office365.com
 (2603:10b6:404:23::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend
 Transport; Thu, 5 Mar 2020 13:33:23 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Thu, 5 Mar 2020 13:33:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 5 Mar 2020
 07:33:22 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 5 Mar 2020
 07:33:22 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 5 Mar 2020 07:33:21 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [enable VCN2.0 for NV12 SRIOV 3/6] drm/amdgpu: implement
 initialization part on VCN2.0 for SRIOV
Date: Thu, 5 Mar 2020 21:33:04 +0800
Message-ID: <1583415187-16594-3-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
References: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(136003)(428003)(199004)(189003)(70206006)(70586007)(316002)(8676002)(478600001)(81166006)(86362001)(81156014)(8936002)(36756003)(426003)(26005)(336012)(2616005)(2906002)(186003)(6916009)(5660300002)(7696005)(4326008)(6666004)(356004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB4210; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:3; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df5fc11c-ee1b-4cd7-7f18-08d7c109c6ad
X-MS-TrafficTypeDiagnostic: BY5PR12MB4210:
X-Microsoft-Antispam-PRVS: <BY5PR12MB421094C982B06DFC55B881DE84E20@BY5PR12MB4210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03333C607F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vCKbhViR83AMejk3dDA/BysfqMz6Q9JVnwt11so925rj2CD7SYxuHLW1xZyAkxyZHTIZLL2jIM76ANlVjaGDaqAuTOL1ur1Ub0BxjFNGUSib9cxLZ3bUXKy9qczYf4TOzX7QZZC9TN3ag4OKKKSDyrxVkLyVU9zefK+Zi5rZNrxDjMkQX0anq1oqX9w63U4ukTUs6HlhFNoyS31RYtCgzJfWv9vnpT917fzSATLgWz6znc1Q5txfzxz0aQhg7VQkQRBkFyStTAA2/a5Vn0o9Nu9VttI1Jyy2n9Df5nEPlqRYiED+8AGgR+mQn5gv3s7sGLOZfHPA4YgzC/oyS+m/0rU+lFW2R3GLJpsJ5heqdGP6p/jKYT6zwE1cbb639CzaTMbQbHAPITnhCIyUrnxB5JOYNtz4B7UdFQF30GExjG7nmuDjXwBmD6ltCXjI6GWS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 13:33:22.7920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df5fc11c-ee1b-4cd7-7f18-08d7c109c6ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

one dec ring and one enc ring

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 231 +++++++++++++++++++++++++++++++++-
 1 file changed, 228 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index c387c81..421e5bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -29,6 +29,7 @@
 #include "soc15d.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_psp.h"
+#include "mmsch_v2_0.h"
 
 #include "vcn/vcn_2_0_0_offset.h"
 #include "vcn/vcn_2_0_0_sh_mask.h"
@@ -54,7 +55,7 @@ static int vcn_v2_0_set_powergating_state(void *handle,
 				enum amd_powergating_state state);
 static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 				int inst_idx, struct dpg_pause_state *new_state);
-
+static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
 /**
  * vcn_v2_0_early_init - set function pointers
  *
@@ -67,7 +68,10 @@ static int vcn_v2_0_early_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	adev->vcn.num_vcn_inst = 1;
-	adev->vcn.num_enc_rings = 2;
+	if (amdgpu_sriov_vf(adev))
+		adev->vcn.num_enc_rings = 1;
+	else
+		adev->vcn.num_enc_rings = 2;
 
 	vcn_v2_0_set_dec_ring_funcs(adev);
 	vcn_v2_0_set_enc_ring_funcs(adev);
@@ -154,7 +158,10 @@ static int vcn_v2_0_sw_init(void *handle)
 	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
 		ring = &adev->vcn.inst->ring_enc[i];
 		ring->use_doorbell = true;
-		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + i;
+		if (!amdgpu_sriov_vf(adev))
+			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + i;
+		else
+			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + i;
 		sprintf(ring->name, "vcn_enc%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0);
 		if (r)
@@ -163,6 +170,10 @@ static int vcn_v2_0_sw_init(void *handle)
 
 	adev->vcn.pause_dpg_mode = vcn_v2_0_pause_dpg_mode;
 
+	r = amdgpu_virt_alloc_mm_table(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -178,6 +189,8 @@ static int vcn_v2_0_sw_fini(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	amdgpu_virt_free_mm_table(adev);
+
 	r = amdgpu_vcn_suspend(adev);
 	if (r)
 		return r;
@@ -203,6 +216,9 @@ static int vcn_v2_0_hw_init(void *handle)
 	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 					     ring->doorbell_index, 0);
 
+	if (amdgpu_sriov_vf(adev))
+		vcn_v2_0_start_sriov(adev);
+
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		goto done;
@@ -1680,6 +1696,215 @@ static int vcn_v2_0_set_powergating_state(void *handle,
 	return ret;
 }
 
+static int vcn_v2_0_start_mmsch(struct amdgpu_device *adev,
+				struct amdgpu_mm_table *table)
+{
+	uint32_t data = 0, loop;
+	uint64_t addr = table->gpu_addr;
+	struct mmsch_v2_0_init_header *header;
+	uint32_t size;
+	int i;
+
+	header = (struct mmsch_v2_0_init_header *)table->cpu_addr;
+	size = header->header_size + header->vcn_table_size;
+
+	/* 1, write to vce_mmsch_vf_ctx_addr_lo/hi register with GPU mc addr
+	 * of memory descriptor location
+	 */
+	WREG32_SOC15(UVD, 0, mmMMSCH_VF_CTX_ADDR_LO, lower_32_bits(addr));
+	WREG32_SOC15(UVD, 0, mmMMSCH_VF_CTX_ADDR_HI, upper_32_bits(addr));
+
+	/* 2, update vmid of descriptor */
+	data = RREG32_SOC15(UVD, 0, mmMMSCH_VF_VMID);
+	data &= ~MMSCH_VF_VMID__VF_CTX_VMID_MASK;
+	/* use domain0 for MM scheduler */
+	data |= (0 << MMSCH_VF_VMID__VF_CTX_VMID__SHIFT);
+	WREG32_SOC15(UVD, 0, mmMMSCH_VF_VMID, data);
+
+	/* 3, notify mmsch about the size of this descriptor */
+	WREG32_SOC15(UVD, 0, mmMMSCH_VF_CTX_SIZE, size);
+
+	/* 4, set resp to zero */
+	WREG32_SOC15(UVD, 0, mmMMSCH_VF_MAILBOX_RESP, 0);
+
+	adev->vcn.inst->ring_dec.wptr = 0;
+	adev->vcn.inst->ring_dec.wptr_old = 0;
+	vcn_v2_0_dec_ring_set_wptr(&adev->vcn.inst->ring_dec);
+
+	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+		adev->vcn.inst->ring_enc[i].wptr = 0;
+		adev->vcn.inst->ring_enc[i].wptr_old = 0;
+		vcn_v2_0_enc_ring_set_wptr(&adev->vcn.inst->ring_enc[i]);
+	}
+
+	/* 5, kick off the initialization and wait until
+	 * VCE_MMSCH_VF_MAILBOX_RESP becomes non-zero
+	 */
+	WREG32_SOC15(UVD, 0, mmMMSCH_VF_MAILBOX_HOST, 0x10000001);
+
+	data = RREG32_SOC15(UVD, 0, mmMMSCH_VF_MAILBOX_RESP);
+	loop = 1000;
+	while ((data & 0x10000002) != 0x10000002) {
+		udelay(10);
+		data = RREG32_SOC15(UVD, 0, mmMMSCH_VF_MAILBOX_RESP);
+		loop--;
+		if (!loop)
+			break;
+	}
+
+	if (!loop) {
+		DRM_ERROR("failed to init MMSCH, " \
+			"mmMMSCH_VF_MAILBOX_RESP = 0x%08x\n", data);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int vcn_v2_0_start_sriov(struct amdgpu_device *adev)
+{
+	int r;
+	uint32_t tmp;
+	struct amdgpu_ring *ring;
+	uint32_t offset, size;
+	uint32_t table_size = 0;
+	struct mmsch_v2_0_cmd_direct_write direct_wt = { {0} };
+	struct mmsch_v2_0_cmd_direct_read_modify_write direct_rd_mod_wt = { {0} };
+	struct mmsch_v2_0_cmd_direct_polling direct_poll = { {0} };
+	struct mmsch_v2_0_cmd_end end = { {0} };
+	struct mmsch_v2_0_init_header *header;
+	uint32_t *init_table = adev->virt.mm_table.cpu_addr;
+	uint8_t i = 0;
+
+	header = (struct mmsch_v2_0_init_header *)init_table;
+	direct_wt.cmd_header.command_type = MMSCH_COMMAND__DIRECT_REG_WRITE;
+	direct_rd_mod_wt.cmd_header.command_type =
+		MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE;
+	direct_poll.cmd_header.command_type =
+		MMSCH_COMMAND__DIRECT_REG_POLLING;
+	end.cmd_header.command_type = MMSCH_COMMAND__END;
+
+	if (header->vcn_table_offset == 0 && header->vcn_table_size == 0) {
+		header->version = MMSCH_VERSION;
+		header->header_size = sizeof(struct mmsch_v2_0_init_header) >> 2;
+
+		header->vcn_table_offset = header->header_size;
+
+		init_table += header->vcn_table_offset;
+
+		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+
+		MMSCH_V2_0_INSERT_DIRECT_RD_MOD_WT(
+			SOC15_REG_OFFSET(UVD, i, mmUVD_STATUS),
+			0xFFFFFFFF, 0x00000004);
+
+		/* mc resume*/
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+			tmp = AMDGPU_UCODE_ID_VCN;
+			MMSCH_V2_0_INSERT_DIRECT_WT(
+				SOC15_REG_OFFSET(UVD, i,
+					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				adev->firmware.ucode[tmp].tmr_mc_addr_lo);
+			MMSCH_V2_0_INSERT_DIRECT_WT(
+				SOC15_REG_OFFSET(UVD, i,
+					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				adev->firmware.ucode[tmp].tmr_mc_addr_hi);
+			offset = 0;
+		} else {
+			MMSCH_V2_0_INSERT_DIRECT_WT(
+				SOC15_REG_OFFSET(UVD, i,
+					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				lower_32_bits(adev->vcn.inst->gpu_addr));
+			MMSCH_V2_0_INSERT_DIRECT_WT(
+				SOC15_REG_OFFSET(UVD, i,
+					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				upper_32_bits(adev->vcn.inst->gpu_addr));
+			offset = size;
+		}
+
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET0),
+			0);
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE0),
+			size);
+
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i,
+				mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
+			lower_32_bits(adev->vcn.inst->gpu_addr + offset));
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i,
+				mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
+			upper_32_bits(adev->vcn.inst->gpu_addr + offset));
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET1),
+			0);
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE1),
+			AMDGPU_VCN_STACK_SIZE);
+
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i,
+				mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
+			lower_32_bits(adev->vcn.inst->gpu_addr + offset +
+				AMDGPU_VCN_STACK_SIZE));
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i,
+				mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
+			upper_32_bits(adev->vcn.inst->gpu_addr + offset +
+				AMDGPU_VCN_STACK_SIZE));
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET2),
+			0);
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE2),
+			AMDGPU_VCN_CONTEXT_SIZE);
+
+		for (r = 0; r < adev->vcn.num_enc_rings; ++r) {
+			ring = &adev->vcn.inst->ring_enc[r];
+			ring->wptr = 0;
+			MMSCH_V2_0_INSERT_DIRECT_WT(
+				SOC15_REG_OFFSET(UVD, i, mmUVD_RB_BASE_LO),
+				lower_32_bits(ring->gpu_addr));
+			MMSCH_V2_0_INSERT_DIRECT_WT(
+				SOC15_REG_OFFSET(UVD, i, mmUVD_RB_BASE_HI),
+				upper_32_bits(ring->gpu_addr));
+			MMSCH_V2_0_INSERT_DIRECT_WT(
+				SOC15_REG_OFFSET(UVD, i, mmUVD_RB_SIZE),
+				ring->ring_size / 4);
+		}
+
+		ring = &adev->vcn.inst->ring_dec;
+		ring->wptr = 0;
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i,
+				mmUVD_LMI_RBC_RB_64BIT_BAR_LOW),
+			lower_32_bits(ring->gpu_addr));
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i,
+				mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH),
+			upper_32_bits(ring->gpu_addr));
+		/* force RBC into idle state */
+		tmp = order_base_2(ring->ring_size);
+		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, tmp);
+		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
+		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
+		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
+		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i, mmUVD_RBC_RB_CNTL), tmp);
+
+		/* add end packet */
+		tmp = sizeof(struct mmsch_v2_0_cmd_end);
+		memcpy((void *)init_table, &end, tmp);
+		table_size += (tmp / 4);
+		header->vcn_table_size = table_size;
+
+	}
+	return vcn_v2_0_start_mmsch(adev, &adev->virt.mm_table);
+}
+
 static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
 	.name = "vcn_v2_0",
 	.early_init = vcn_v2_0_early_init,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
