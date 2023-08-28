Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AA7C83F11
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 09:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEBC710E257;
	Mon, 28 Aug 2023 09:03:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A16C110E257
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 09:03:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFUAHWgzJ8pOiL23L67lZSH2Yn0Dx5MXx/DB4uSbZsLZ9FJf46Az8y8yR/pJ3cc4o4F5E7s4ZS2H8HgbhG7MrOxHPkDlITr8cwvoMgJGc+XwJlZxtvm+xr2GvsY0bB2wxFgwpi222YTPzEbPIXqV+BkIQXvzHaremT8XH9B8/DEpNC4QA3zrQ21S3yvGnEuLms4cQrJMQJbv5TGhpvZX3JRI6OMt+PJWop6K5/wHsVPqXVzDngWDc4NaBKtJULqc4kzekkTyaV8+Pkq77eh0dTRmkDrPwEW6dgxVFJXw4q8lfBhcYXRL3aBcsQt+ckf7CO1BPme+w3uYjx15fpJv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbTDEtdK1eB5mhh5IhdQTN8qQlp/BvU6erqnyj42KcE=;
 b=L4W4Kl3QJINwaB9fws4WSVjQ/B5tqjgl45VkdyxttJA/BvvtFmXvMPIkwHQgSTZs1VEg6cQrRrYnNaOlP/VQkh33qe8zCsmdfVdgcgC3SS8DyT83SJw6Vxua/vjwSvTo+aZVZePuj5kjgnBxRQEU8S+nbvsvcgJsPg+29n+RrR+AmTuMfHXay7WnDkhgAX/++/Mh7nLnc/UuIll9ottXVr2pKMSv9FkxoF4gkUORllMzLI36/w1JMB8wdQmfigOe5X3BipaWgkupP3TgTGfu6ZYWGQzejE95Bps/iQ9JY0PNNp+U1RF+qndrFAVcoLEApMERm7zWgXlS7hex6Mn6SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbTDEtdK1eB5mhh5IhdQTN8qQlp/BvU6erqnyj42KcE=;
 b=kiN3kRubIUbxAkEvGVKE3CQMbU1SVGtngYWjzAooeHHJN+VowlMQMg2YZLXVbsnIOGi44To/Yxooe07kqEw9sQXIhml/Z3X6stvazPgyRNHjB8ZMCkrbDg69NdA4ClhTcm94DMSNF53WbmldPsa3hH2T4BsH3+E9BHTD8jqQN88=
Received: from SA1PR03CA0015.namprd03.prod.outlook.com (2603:10b6:806:2d3::22)
 by SA1PR12MB7224.namprd12.prod.outlook.com (2603:10b6:806:2bb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 09:03:24 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::61) by SA1PR03CA0015.outlook.office365.com
 (2603:10b6:806:2d3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Mon, 28 Aug 2023 09:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Mon, 28 Aug 2023 09:03:24 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 04:03:22 -0500
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: access RLC_SPM_MC_CNTL through MMIO in SRIOV
 runtime
Date: Mon, 28 Aug 2023 17:03:12 +0800
Message-ID: <20230828090312.14840-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SA1PR12MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a215c49-6c48-4cbd-213a-08dba7a5a2f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qHn+VdalA/8L/+ozpmkjozgpUOTSpXBjPCj3M5M5WHQu2W6xSSzXTmaCLfCr4QvjmzGuGURxsstFL6BSesnMraPMcaQxjBHGgTw+CFZiHQC17+ndoAZjPRa8+4qluhqEFoBKpHJ13FWtWAx+QV4fEwhF6X9uhvUv1zDUZlvUT2AWJO1kT0+QMom5W/N8lifd0hBl04G+h/6gA1BLntDixywpRF6N66UANhn7/dQy4emfK2bbroZL5/LkgdBCKDJjUyhwcK1j3z2m74irNZE0ZORv4w7dUfQMOya9LGLTE8OTG1pAVgPdB+KwFtFrYK77uR5cNgqbnN3OuJKq6XHnsJmIVhYSBvvK9ZonsstZOvlFWfnRWzmXQQoEA81htlOiHyE9ez1mSXEHO94Mr6DlwtrlyARZJsfBW6MkN1S6SIgyWI4gWdmbX3vBuEG2FHybXvXITGwE4WE03Khnf7cMQs2yYrrvaVKV7Dr/1qw+mNSV4GQpCouATVCsxRh9ANtMbHThsYjFFkbD/6LPX1IzQNFnE8L/+0D4wZqPpFTNaPTJK0pZPX2uurwUj7Hv9wNXLMGFz1T1np3WNKALl7N7ocH6aKYyCH3zFRSBNmZhAiCs3LcC2FSvBipwUxwugp83vEEs1a4oKT8v0K57aovHh4InyoI4HeNtE/wS7y8L30VSwM+tHSHAU+TVcoAroLN+W6kUwskEAbgzlbtIIZoH+0KcjcVM6rJr0D3aAr8ZuWTLerBMoQtu+Eaw1XGeAV0YggFaITdIh5GDxd92reHfYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(186009)(1800799009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(6666004)(2616005)(1076003)(7696005)(40480700001)(40460700003)(2906002)(5660300002)(86362001)(70206006)(4326008)(6916009)(8936002)(8676002)(54906003)(36756003)(70586007)(41300700001)(316002)(82740400003)(81166007)(356005)(478600001)(83380400001)(36860700001)(47076005)(16526019)(26005)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 09:03:24.8004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a215c49-6c48-4cbd-213a-08dba7a5a2f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7224
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
Cc: ZhenGuo Yin <zhenguo.yin@amd.com>, yifan.zha@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Register RLC_SPM_MC_CNTL is not blocked by L1 policy, VF can
directly access it through MMIO during SRIOV runtime.

v2: use SOC15 interface to access registers

Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 +++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 13 +++----------
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 0aee9c8288a2..6ccde07ed63e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7897,22 +7897,15 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 static void gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 					       unsigned int vmid)
 {
-	u32 reg, data;
+	u32 data;
 
 	/* not for *_SOC15 */
-	reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
-	if (amdgpu_sriov_is_pp_one_vf(adev))
-		data = RREG32_NO_KIQ(reg);
-	else
-		data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
+	data = RREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL);
 
 	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
 	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
 
-	if (amdgpu_sriov_is_pp_one_vf(adev))
-		WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);
-	else
-		WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
+	WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);
 }
 
 static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned int vmid)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index b0c32521efdc..337ed771605f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4984,23 +4984,16 @@ static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 
 static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 {
-	u32 reg, data;
+	u32 data;
 
 	amdgpu_gfx_off_ctrl(adev, false);
 
-	reg = SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
-	if (amdgpu_sriov_is_pp_one_vf(adev))
-		data = RREG32_NO_KIQ(reg);
-	else
-		data = RREG32(reg);
+	data = RREG32_SOC15_NO_KIQ(GC, 0, regRLC_SPM_MC_CNTL);
 
 	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
 	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
 
-	if (amdgpu_sriov_is_pp_one_vf(adev))
-		WREG32_SOC15_NO_KIQ(GC, 0, regRLC_SPM_MC_CNTL, data);
-	else
-		WREG32_SOC15(GC, 0, regRLC_SPM_MC_CNTL, data);
+	WREG32_SOC15_NO_KIQ(GC, 0, regRLC_SPM_MC_CNTL, data);
 
 	amdgpu_gfx_off_ctrl(adev, true);
 }
-- 
2.35.1

