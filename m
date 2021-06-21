Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE3BC49361
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22EF06109E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22EF06109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62AFC89C9D;
	Mon, 21 Jun 2021 07:01:10 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8647689C9D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 07:01:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQ3MP7UoKBM/jrNM0HDomsY70Ckoitf0CBrnzJt6/rB0KZUz3ZDaMWsVWWQM7b6TbnakyP5H+V5ffYVnzBqjxwLRwRpuqJm7wnMlY8H0ZasrOhE+kgHjGlcElkqgATLsdvvp4cgH03tz5f2IdNcUCAKEUMvwxoFtOazKFKG3xvXjwGaBDaSJP/AW5a89SCitFnGprqoHA8qERwYUF2NkMmSsBcOOroz8gOb7koZwsvzrpn3yMEhntUZvJJqBp0MK4axy5D7iFUp9KfGHa+DP38NKlTyWir5O2qSz8GpRulnLpaF5MQkHEobYoaFs1j4QWqccTqaVba7zPGzds2dmRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drVP3Z3Dgo1glMDQ9iN6rCQuEQDxJS/ShCZ3M4A3/OA=;
 b=TTM/yDiy9hSXBDNtOAstqIjy5tbZk2LI29Ga8jRRgxIupZ4pP4XSChgr2DyZIKprh63sBWjb3LX9Co7jquAUjOMQgP5QZ/gep5ItefAWLzLfr2oTnWedcVTkSqIZVcyPaVMMYVf8XVTGbPOr5Ogml1vAPMh5Xpua+eDOcEtl3y894stiOGTWieN5mr+j0e9LdEghUFrOz/EoxX6RbMF5k9DeA7bDd4Te/85MTLE2cCYltDKMe5oIAjqDOiiS5d0mYqnm9MjGOF/q8NSpHI5vYyUH8zdNymXFBT3PTZ4EPytdIPjyt3UYLufLbTBxTA0+cwavV3FXgcBNwl6BH1u+yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drVP3Z3Dgo1glMDQ9iN6rCQuEQDxJS/ShCZ3M4A3/OA=;
 b=yxv5Ai9rLjjzPKVQMC9CIgv5xd2nlLrSiq28WI5MdiYObmRr7QUQAErw1YtuHfr3Na/HN2zHGRStNcJjTzDCTWsHZDrGkGN16Rfy6jdsdABQxK0O60UoF8DerChXDxilGg/LyYcXtjEQKOe7Wx0vCJMu1ueKOvqaYjQRLMSBUeY=
Received: from DM5PR19CA0069.namprd19.prod.outlook.com (2603:10b6:3:116::31)
 by BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 07:01:07 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::cc) by DM5PR19CA0069.outlook.office365.com
 (2603:10b6:3:116::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Mon, 21 Jun 2021 07:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 07:01:07 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 21 Jun
 2021 02:01:05 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 3/7] drm/amdgpu: fix NAK-G generation during PCI-e link
 width switch
Date: Mon, 21 Jun 2021 15:00:36 +0800
Message-ID: <20210621070040.494336-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210621070040.494336-1-evan.quan@amd.com>
References: <20210621070040.494336-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b61af50-82e2-48d2-7f3d-08d934825801
X-MS-TrafficTypeDiagnostic: BN9PR12MB5337:
X-Microsoft-Antispam-PRVS: <BN9PR12MB53375602E99B8487239A37E5E40A9@BN9PR12MB5337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhY6ygijJIAoMVfRLD+6egoNABbhLu2E6NMVXI3qeYLQaLwawQN7Rwsl9ocarogg2t5bwzlUoKIBEE12UQKggREfvPm+AqEaZRowOsSlrgygLazeQXvHbKHqQaJqTh60ASV+NyZ+MJvhJuH35H9IKAQgc17yzhoQTBrhEjEvaGe58dVNyW41jOPgk6uRqh9ALkQDhPyTx6SzF8V41IvkIyi0IdaV85pw0U6eerrZWcAxBxF726l6wCjUBhRQ9T01qdvGibPowN5c0Rg+fyU3BEV9dVUD8NdfWOixztCpd5YBe5GjpGE318Ik8SJb5NGtGX2kQ9cP8RRAi/HBc6StwX/aovRRCM54yuXlp6EYJbY4fd3hgvIvj/8eHCICXxw5f7CmBTScnTfOE7G7s1io/7YYLtxoPXKD4Za1U6AvCI/l0Py3pAhTzwErpEKOgMaSjt/lUrhunkbvn6ikd6Xt4OgTOyAefBDKeR/xlosl/E0n4RKwYcsESTZK//ybgmkKShAA4HwiEWn5fnjPcm4N5TLDxx20fjR0WGaIc5DsEPn4ZFWk5Omt38GBae9K03QJqN5gRNnDiEUrqW5xXSV6P8WlmYi8fc0Lv55ZCvuIzenn9R2/4HwMUXIFvo16pB4t0ePuhm4VaZN40kQvQ+wNPlUJOBg+RGoBd8hw7EfEl8WKtGS7QXB0tdqXjHHKAdci
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(36840700001)(426003)(47076005)(81166007)(356005)(336012)(6666004)(82310400003)(36756003)(54906003)(70586007)(86362001)(70206006)(83380400001)(82740400003)(316002)(6916009)(2616005)(8676002)(44832011)(26005)(186003)(1076003)(7696005)(8936002)(36860700001)(478600001)(16526019)(5660300002)(2906002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 07:01:07.5442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b61af50-82e2-48d2-7f3d-08d934825801
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A lot of NAK-G being generated when link widht switching is happening.
WA for this issue is to program the SPC to 4 symbols per clock during
bootup when the native PCIE width is x4.

Change-Id: I7a4d751e44bddc4bd1e97860cb4f53dfadc02a2c
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
V1->V2:
 - move the code to nbio_v2_3.c as that's where the pcie related changes
   reside
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c   | 28 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c          |  3 +++
 3 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 25ee53545837..43d074bb00a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -93,6 +93,7 @@ struct amdgpu_nbio_funcs {
 	void (*enable_aspm)(struct amdgpu_device *adev,
 			    bool enable);
 	void (*program_aspm)(struct amdgpu_device *adev);
+	void (*apply_lc_spc_mode_wa)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_nbio {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 05ddec7ba7e2..315d57bb373d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -51,6 +51,8 @@
 #define mmBIF_MMSCH1_DOORBELL_RANGE		0x01d8
 #define mmBIF_MMSCH1_DOORBELL_RANGE_BASE_IDX	2
 
+#define smnPCIE_LC_LINK_WIDTH_CNTL		0x11140288
+
 static void nbio_v2_3_remap_hdp_registers(struct amdgpu_device *adev)
 {
 	WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
@@ -463,6 +465,31 @@ static void nbio_v2_3_program_aspm(struct amdgpu_device *adev)
 		WREG32_PCIE(smnPCIE_LC_CNTL3, data);
 }
 
+static void nbio_v2_3_apply_lc_spc_mode_wa(struct amdgpu_device *adev)
+{
+	uint32_t reg_data = 0;
+	uint32_t link_width = 0;
+
+	if (!((adev->asic_type >= CHIP_NAVI10) &&
+	     (adev->asic_type <= CHIP_NAVI12)))
+		return;
+
+	reg_data = RREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL);
+	link_width = (reg_data & PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK)
+		>> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
+
+	/*
+	 * Program PCIE_LC_CNTL6.LC_SPC_MODE_8GT to 0x2 (4 symbols per clock data)
+	 * if link_width is 0x3 (x4)
+	 */
+	if (0x3 == link_width) {
+		reg_data = RREG32_PCIE(smnPCIE_LC_CNTL6);
+		reg_data &= ~PCIE_LC_CNTL6__LC_SPC_MODE_8GT_MASK;
+		reg_data |= (0x2 << PCIE_LC_CNTL6__LC_SPC_MODE_8GT__SHIFT);
+		WREG32_PCIE(smnPCIE_LC_CNTL6, reg_data);
+	}
+}
+
 const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
 	.get_hdp_flush_req_offset = nbio_v2_3_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v2_3_get_hdp_flush_done_offset,
@@ -484,4 +511,5 @@ const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
 	.remap_hdp_registers = nbio_v2_3_remap_hdp_registers,
 	.enable_aspm = nbio_v2_3_enable_aspm,
 	.program_aspm =  nbio_v2_3_program_aspm,
+	.apply_lc_spc_mode_wa = nbio_v2_3_apply_lc_spc_mode_wa,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 455d0425787c..63c96ca8d2a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1411,6 +1411,9 @@ static int nv_common_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (adev->nbio.funcs->apply_lc_spc_mode_wa)
+		adev->nbio.funcs->apply_lc_spc_mode_wa(adev);
+
 	/* enable pcie gen2/3 link */
 	nv_pcie_gen3_enable(adev);
 	/* enable aspm */
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
