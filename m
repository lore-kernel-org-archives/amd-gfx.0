Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B04C48BE5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F7436109E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7436109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AFA689CB3;
	Mon, 21 Jun 2021 07:01:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 899B989CBE
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 07:01:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBLgFYZ2E/TjZeUCH3I3+QORBWqegLgacKN7r6XoGwEWwZGQW1GZ3Dr1DXs8T8QS7HllhbPLAkV0DHw+chX1TZmR0kE3E50nCnIsRwJRjsyD/Xt3ntrK0J4I27QThGYLiwdsti1o77CwRhYcgz9RunY6fwYqhNig/YsLrrTifUKwqkq3z7MIwtBOtsitxOOW2EwEAcFhi9fu7APs4xz54ulz7exJ62T6lkDHwQZzMacCsxo20SGyAhdOOKOkqWsfYwJiCfPlx/ij+ak11ai/cJ/KGegK6GfD+j8DJiMtdvUJhh11jl+hk1tsFwA3rqsBYZxfYzldIJvciDm73jeS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lM+cXc8lgZwAWgZ6z4nF6F0w8MWMPhWA5x9RuixrGg0=;
 b=NtK8Y2NbAB24lIKLy0aW3XSEEWXvN1PTT9S8RqNSmNqMJciUeti1+aejhOOcfXTNDt7zgNXpZixBVsL6Ezw/S+sctBUjQ4YhuywBk5fLiKebfgFrnnaVvPN0lk+5AX5OQA6tR0oKvH2BinTWmtQKRvISdDMtxRiVRZ1Lx5yHB7meB4B2w3LPikGokakO3s72Z03XBj7Aofin5D2YfmVgviV8/ClnJ/8sthufsbF4krERw9fo02Trpv8P6MB1Csw4KxoY5J3N3BbBJYmQXxGYXR0bvfQcjDU0drJjhbiuemAYTpxANxjnGky08LeYKxKiBK4XfPeL54mlbzre4C6GtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lM+cXc8lgZwAWgZ6z4nF6F0w8MWMPhWA5x9RuixrGg0=;
 b=USD2kScRAyNmu+4LfFrmOQecEfMm8FjWY8UacTP+dXUnHg63B1awzZdgPdJLsEg6Pnzgm8jaCJ/NPhQsDWtdcaIt+f3HXhR0cJzY5vtsEH2BR7XOSu+hrFPlEUHss0XxDcfn6DgSP4HDzFTwlAPYnqnfE2LsBoVDtYyrD1q81w4=
Received: from DS7PR03CA0253.namprd03.prod.outlook.com (2603:10b6:5:3b3::18)
 by BN9PR12MB5099.namprd12.prod.outlook.com (2603:10b6:408:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 07:01:10 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::23) by DS7PR03CA0253.outlook.office365.com
 (2603:10b6:5:3b3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Mon, 21 Jun 2021 07:01:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 07:01:10 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 21 Jun
 2021 02:01:07 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 4/7] drm/amdgpu: fix the hang caused by PCIe link width
 switch
Date: Mon, 21 Jun 2021 15:00:37 +0800
Message-ID: <20210621070040.494336-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210621070040.494336-1-evan.quan@amd.com>
References: <20210621070040.494336-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12f555ab-323f-4ea1-4b57-08d9348259b5
X-MS-TrafficTypeDiagnostic: BN9PR12MB5099:
X-Microsoft-Antispam-PRVS: <BN9PR12MB509923D92EB906673BB6CD4EE40A9@BN9PR12MB5099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DpAOsYGbmyWC2l1Czuu+3I3P4AagzvShhqivX6z+FGU9Oh7Y5eiKoIMKPo2YtLsOVX0T3EhIUysMpVChoXpSzC0AWeVjYwh5duLaVk7Q5N0xgdc3Tq1QpKqLTPyQ2LridZGnAEHVH6LSJN6uLwvivKfIPOWt6GGO7LST7t0OCKzfcVZQDKXT2mZoba4VTh1YpwcYM+geacP+EeBhazgCDb86YrnVBoGe5mugy4wgEOnXak2H0aEGwcDLPMVE9PjZux02JuBg239J3CXtNna61kGoKnJsGAUXuiTw1vSdbaEJ+1VQsQ9WVfbawdKZnP2681NdCJW+riiDcEjxJF8Lt3iNqPgq1d1B+80iDbOZoX7HsfBkpcl5rd2onU6qEtAcN0R8TGHTEnizq+yRq5jy6lqKTpwPqC+5IqQUIEAgrN2WD0xMezyCtssof9SRuA/X1JKHCPnftgljTexjlsBRD9X5Q1/NT4Jg0ueLpJGC7iWr4Rjh2ho//6QIwpv6Cund/mk305FvX0Xcwg9E6XDq5YoRtsmI8ISlplVNxqeiBZkY3JEqnoQfvNfJvEjkF85+yrIYqE9URxV1HxfchUlyDMfkqJZota5c9AhLb5V4bB97xUt0NxdEpksE+VlhYqjgLxeb4fw/dKuEmanr3i3QHCSYJNbFaIev18FR0i/6gf+skuviCgvvWjabnz8W+LY4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(36840700001)(46966006)(70586007)(82740400003)(356005)(426003)(83380400001)(2906002)(36756003)(6666004)(4326008)(81166007)(316002)(336012)(54906003)(2616005)(82310400003)(44832011)(47076005)(26005)(5660300002)(8936002)(186003)(16526019)(1076003)(7696005)(70206006)(36860700001)(86362001)(8676002)(6916009)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 07:01:10.3982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f555ab-323f-4ea1-4b57-08d9348259b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5099
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

SMU had set all the necessary fields for a link width switch
but the width switch wasn't occurring because the link was idle
in the L1 state. Setting LC_L1_RECONFIG_EN=0x1 will allow width
switches to also be initiated while in L1 instead of waiting until
the link is back in L0.

Change-Id: I6315681f6fb194036b20991512dd88fa65bc0d56
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
V1->V2:
  - limit the change for Navi10 only
V2->V3:
  - move the code to nbio_v2_3.c
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c   | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c          |  3 +++
 3 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 43d074bb00a1..45295dce5c3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -94,6 +94,7 @@ struct amdgpu_nbio_funcs {
 			    bool enable);
 	void (*program_aspm)(struct amdgpu_device *adev);
 	void (*apply_lc_spc_mode_wa)(struct amdgpu_device *adev);
+	void (*apply_l1_link_width_reconfig_wa)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_nbio {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 315d57bb373d..754b11dea6f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -490,6 +490,18 @@ static void nbio_v2_3_apply_lc_spc_mode_wa(struct amdgpu_device *adev)
 	}
 }
 
+static void nbio_v2_3_apply_l1_link_width_reconfig_wa(struct amdgpu_device *adev)
+{
+	uint32_t reg_data = 0;
+
+	if (adev->asic_type != CHIP_NAVI10)
+		return;
+
+	reg_data = RREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL);
+	reg_data |= PCIE_LC_LINK_WIDTH_CNTL__LC_L1_RECONFIG_EN_MASK;
+	WREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL, reg_data);
+}
+
 const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
 	.get_hdp_flush_req_offset = nbio_v2_3_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v2_3_get_hdp_flush_done_offset,
@@ -512,4 +524,5 @@ const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
 	.enable_aspm = nbio_v2_3_enable_aspm,
 	.program_aspm =  nbio_v2_3_program_aspm,
 	.apply_lc_spc_mode_wa = nbio_v2_3_apply_lc_spc_mode_wa,
+	.apply_l1_link_width_reconfig_wa = nbio_v2_3_apply_l1_link_width_reconfig_wa,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 63c96ca8d2a2..5231b3402990 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1414,6 +1414,9 @@ static int nv_common_hw_init(void *handle)
 	if (adev->nbio.funcs->apply_lc_spc_mode_wa)
 		adev->nbio.funcs->apply_lc_spc_mode_wa(adev);
 
+	if (adev->nbio.funcs->apply_l1_link_width_reconfig_wa)
+		adev->nbio.funcs->apply_l1_link_width_reconfig_wa(adev);
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
