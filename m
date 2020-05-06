Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0BBC28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 06:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0113D206E6
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 06:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Zg7QT59z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0113D206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A240689E08;
	Wed,  6 May 2020 06:42:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C856E22E
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 06:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgoCI7uJQcZgLdR+NAtc4zVvrbRt4lZXQ2mqVUfMIf1yh1XfnNEPc/UYRa6aMLx/MI3A9WxHn8VA1OFKJt4M/qv4die92yoac8inkc1MuxSCgv5/b3uy5LcOlkS+drlznOHhxhpXvWSzJV9fmluZe+Im0yfhk8WNuzh0Z+5nxyKwnrpKrRa9DfvhyClTEAZUuwrVvWSZKKxTyDISeVaOXJgQFht1zS42OvL35ZilmW5Qfw3yVZgVO5paLLtP+fqXVikKMFTkgLOKYJGzShiKSU8VDFtU6LTVMmbzvRfxmKZntVEm+6E7ZkO4q5VYvs2OqixTdXHjNliEKcdtnK6cRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7rNHXigosmgBJ82cx8Jlwa1Rkm5q8jsAY9eDrJZ5tE=;
 b=m3uSrV0T60kWyDyuUBP6vboo41tgqLdERLNAyoqd1SMeTl5Ndw4KJ7dS3LrTuTLlBOIDmaOpGHUJIxRs7amG4f/SghfCy3Yi6TS8EzLuk+HlJLS5M+NapR4KqSls8wyLV4uRvbSSSqJN4Od/Ys36s9HEk8MyeFBuBGxufnwsQQR6M91gqc/INPgkk/63L+DVmPMwardjBzA3z8hoAmxPXSumxfceI7Lp9Zic9197YazUTvlY5ddpzWCy0bKgOKUaKUV/kw8xGCHt44PFLXNL33CccVFp8rNS5PkDnSXK4rViglGvawHr5sI78l48LBHTSNj9s4FYo9qK7kRP36+ySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7rNHXigosmgBJ82cx8Jlwa1Rkm5q8jsAY9eDrJZ5tE=;
 b=Zg7QT59zqu7qJ5xvxGu8WKp0+/m5Y1WQASGhN+7l7xwoopNXxRVEM8NKrwJtqHpMoayBDtAkMomhvOyLPNvoQlThVmE8bUVdL4rpeqyfr0gTWMLIfrt1Vdpm0oSKzwy8QB+HnBQyu0ZTMTTI5LLK5MVaKK4fWrC54VTXSG4SmdI=
Received: from DM3PR08CA0019.namprd08.prod.outlook.com (2603:10b6:0:52::29) by
 MWHPR1201MB2557.namprd12.prod.outlook.com (2603:10b6:300:e4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Wed, 6 May
 2020 06:42:07 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::8b) by DM3PR08CA0019.outlook.office365.com
 (2603:10b6:0:52::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Wed, 6 May 2020 06:42:06 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2979.27 via Frontend Transport; Wed, 6 May 2020 06:42:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 May 2020
 01:42:05 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 May 2020
 01:42:05 -0500
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 6 May 2020 01:42:04 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 John Clements <John.Clements@amd.com>
Subject: [PATCH] drm/amdgpu: use node_id and node_size to calcualte
 dram_base_address
Date: Wed, 6 May 2020 14:42:01 +0800
Message-ID: <20200506064201.22945-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39850400004)(346002)(376002)(136003)(46966005)(33430700001)(1076003)(6636002)(336012)(82310400002)(2906002)(33440700001)(26005)(426003)(4326008)(6666004)(81166007)(2616005)(47076004)(186003)(82740400003)(5660300002)(316002)(8676002)(36756003)(7696005)(478600001)(8936002)(86362001)(356005)(70586007)(70206006)(110136005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddeaf3cf-f528-4908-245b-08d7f188981c
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2557:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2557789CA95C1EE17AE4E236FCA40@MWHPR1201MB2557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zg+/1+sStmeOgFUI5myQfarXjEyVm1fAjBYywZvGZ7ZA74imUf9OyEKsTjXhb6fknuGSkg5NIIUk3wnnxvaVa7kUnNwREGuoDUEynl/Y1Xoa/rdaYlTum7G3DdhO4NoGRoDeq1GSo/3RXGrdBNGNHNedp5lEf5qSJn4QWseSP/PsjoMhoSwIWIMlzi/3JGaEegqO3eWJe1oRHzb+BrTPSX/jWKXkUtuedLgBHMcHeZjbuaAXFYl9DKoqOCLbKq277wB1bTPvwL9mQog94GxglO4jmjZ1X9sVnb3q7qfHkq6avtF9MAIcKqhiFh5fBdimiFqwGFVR86+Tu/Z4aKInZ2kHJ2jySkQ+zjxbJHlbQOOQ72+XHA8gxRpq9N530txDacgxJ5JF+TJizJv24GPjCG6J2mZwl+SRQ+1DuXiCf4yTU2dWhJv9zqdUawpQqomzudUUwGIrNdSXBKrgtmKjLrNcF1QZ4+Fd5yUB/5U43tZmDjf6jXs8034qvNaWMcia/Q7v+/pv2NR9WFQ6bMo5GACwpN3APufNSMkEiSaUj0HXGGFCFurKUnf7oKd34G9sXIcW3ksDFXYGqJjvkcwATg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 06:42:06.5152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddeaf3cf-f528-4908-245b-08d7f188981c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2557
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

physical_node_id * node_segment_size should be the
dram_base_address for current gpu node in xgmi config

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_df.h   |  3 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 27 ++--------------
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c     | 54 --------------------------------
 3 files changed, 2 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
index 057f6ea..61a26c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
@@ -52,9 +52,6 @@ struct amdgpu_df_funcs {
 	uint64_t (*get_fica)(struct amdgpu_device *adev, uint32_t ficaa_val);
 	void (*set_fica)(struct amdgpu_device *adev, uint32_t ficaa_val,
 			 uint32_t ficadl_val, uint32_t ficadh_val);
-	uint64_t (*get_dram_base_addr)(struct amdgpu_device *adev,
-				       uint32_t df_inst);
-	uint32_t (*get_df_inst_id)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_df {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 48c0ce1..90610b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -649,31 +649,8 @@ void amdgpu_xgmi_ras_fini(struct amdgpu_device *adev)
 uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
 					   uint64_t addr)
 {
-	uint32_t df_inst_id;
-	uint64_t dram_base_addr = 0;
-	const struct amdgpu_df_funcs *df_funcs = adev->df.funcs;
-
-	if ((!df_funcs)                 ||
-	    (!df_funcs->get_df_inst_id) ||
-	    (!df_funcs->get_dram_base_addr)) {
-		dev_warn(adev->dev,
-			 "XGMI: relative phy_addr algorithm is not supported\n");
-		return addr;
-	}
-
-	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW)) {
-		dev_warn(adev->dev,
-			 "failed to disable DF-Cstate, DF register may not be accessible\n");
-		return addr;
-	}
-
-	df_inst_id = df_funcs->get_df_inst_id(adev);
-	dram_base_addr = df_funcs->get_dram_base_addr(adev, df_inst_id);
-
-	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
-		dev_warn(adev->dev, "failed to enable DF-Cstate\n");
-
-	return addr + dram_base_addr;
+	struct amdgpu_xgmi *xgmi = &adev->gmc.xgmi;
+	return (addr + xgmi->physical_node_id * xgmi->node_segment_size);
 }
 
 static void pcs_clear_status(struct amdgpu_device *adev, uint32_t pcs_status_reg)
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 5a1bd8e..a7b8292 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -686,58 +686,6 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 	}
 }
 
-static uint64_t df_v3_6_get_dram_base_addr(struct amdgpu_device *adev,
-					   uint32_t df_inst)
-{
-	uint32_t base_addr_reg_val 	= 0;
-	uint64_t base_addr	 	= 0;
-
-	base_addr_reg_val = RREG32_PCIE(smnDF_CS_UMC_AON0_DramBaseAddress0 +
-					df_inst * DF_3_6_SMN_REG_INST_DIST);
-
-	if (REG_GET_FIELD(base_addr_reg_val,
-			  DF_CS_UMC_AON0_DramBaseAddress0,
-			  AddrRngVal) == 0) {
-		DRM_WARN("address range not valid");
-		return 0;
-	}
-
-	base_addr = REG_GET_FIELD(base_addr_reg_val,
-				  DF_CS_UMC_AON0_DramBaseAddress0,
-				  DramBaseAddr);
-
-	return base_addr << 28;
-}
-
-static uint32_t df_v3_6_get_df_inst_id(struct amdgpu_device *adev)
-{
-	uint32_t xgmi_node_id	= 0;
-	uint32_t df_inst_id 	= 0;
-
-	/* Walk through DF dst nodes to find current XGMI node */
-	for (df_inst_id = 0; df_inst_id < DF_3_6_INST_CNT; df_inst_id++) {
-
-		xgmi_node_id = RREG32_PCIE(smnDF_CS_UMC_AON0_DramLimitAddress0 +
-					   df_inst_id * DF_3_6_SMN_REG_INST_DIST);
-		xgmi_node_id = REG_GET_FIELD(xgmi_node_id,
-					     DF_CS_UMC_AON0_DramLimitAddress0,
-					     DstFabricID);
-
-		/* TODO: establish reason dest fabric id is offset by 7 */
-		xgmi_node_id = xgmi_node_id >> 7;
-
-		if (adev->gmc.xgmi.physical_node_id == xgmi_node_id)
-			break;
-	}
-
-	if (df_inst_id == DF_3_6_INST_CNT) {
-		DRM_WARN("cant match df dst id with gpu node");
-		return 0;
-	}
-
-	return df_inst_id;
-}
-
 const struct amdgpu_df_funcs df_v3_6_funcs = {
 	.sw_init = df_v3_6_sw_init,
 	.sw_fini = df_v3_6_sw_fini,
@@ -752,6 +700,4 @@ const struct amdgpu_df_funcs df_v3_6_funcs = {
 	.pmc_get_count = df_v3_6_pmc_get_count,
 	.get_fica = df_v3_6_get_fica,
 	.set_fica = df_v3_6_set_fica,
-	.get_dram_base_addr = df_v3_6_get_dram_base_addr,
-	.get_df_inst_id = df_v3_6_get_df_inst_id
 };
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
