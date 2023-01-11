Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3723BC5479D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jan 2023 07:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD57810E2DD;
	Wed, 11 Jan 2023 07:53:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FDD310E2CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jan 2023 07:53:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KP0B+hoYMlDAuI2vZJciSiKOaaaH+ypJNJ4NkfsRcHrvUqGNa6h0Arm9jmglTEsk1lTd1RnVWQ3FGAyDCbQT+XIcVncC8JCXHBVo3h5u1n33HP517zzwIIvXb/6rzecXmBuMrltaaEmALUkL/hE9SunTO3TdoHMtCoUS2HV1kin1pAAvf/O33GQf+oqjvGgjQyWkDb0PwVLbhyJVrUKvhTkuHEIr9ZgSQ0mt3zXuaOPgGNZ6JRg6oQ8NtTILh8IRXNosSkiA7HHA2Uq0tl91ssqQNmTTZNMQ4ExIsFzo1NERP9H9XDGEljIZY0lCFGU4QKToyPXDGDkexUeTY9/OqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0cC7/tivWwNWWLO+seE/FaliGPbaO5TEvLb9YTJxRU=;
 b=AvT3mKYyqUTT+OuQtLKCe62T5LXfrmadPEHCljklb/Qg5qVhWWPYKnlhZCyEYf/KtTXjEnVcslv6Ed/Ijkwwnp75KVVq66hHqAcxwvepq//vXHE1r52sPdK7dCD7/7qhHbRW0SopP4zqAkQqyZladfuLt0NgLz2GIGX0CnXQjHcoocL2WWHmA1JLonOoh75MGrR5Llocfx5jpUXMG2WTTF+Vow2pRJ2JSXl17EwieasqgF91Ox4b39ReMEcJEF2fj+CMnzxCNQRWj9hQtFgS/vjtoaPf1tD7um/p75+P5JZeWE+xpA0iQBk4R3mESeVO1odIUtB59A31EWV2U95xXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0cC7/tivWwNWWLO+seE/FaliGPbaO5TEvLb9YTJxRU=;
 b=FPA/2CdoA03rACqzw4OV4Kr9Twitw2R93Ky7vUtu0mvFfvW7Fkrrl2JpvY06nsfTfMcEknVOJZJQyJw0EfAYEefxKlwpqvNv0qTV7rKIBjHsob7UQKFj2ZmjuOcAgMIL9zv2+RLu827JcyPwbc0tTy04D7FRah06Ul3dALVyWoQ=
Received: from DS7PR05CA0032.namprd05.prod.outlook.com (2603:10b6:8:2f::31) by
 IA1PR12MB7688.namprd12.prod.outlook.com (2603:10b6:208:420::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 07:53:23 +0000
Received: from DS1PEPF0000E641.namprd02.prod.outlook.com
 (2603:10b6:8:2f:cafe::a) by DS7PR05CA0032.outlook.office365.com
 (2603:10b6:8:2f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Wed, 11 Jan 2023 07:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E641.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Wed, 11 Jan 2023 07:53:23 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 01:53:22 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 23:52:57 -0800
Received: from yzha-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 11 Jan 2023 01:52:55 -0600
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Skip specific mmhub and sdma registers accessing
 under sriov
Date: Wed, 11 Jan 2023 15:52:27 +0800
Message-ID: <20230111075226.150161-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E641:EE_|IA1PR12MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 81742dba-32dd-49ea-e1ff-08daf3a8ea1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PRnaQxYTY8ddTbnH1MdQ0yyqFvyzbDdeLBC3gJHVYKnwrTzyLM+DinJzt5HR4uHJQaSRHKcNqWbKLPf2c0X7ptL2abGMiSwcycLJXtr9wHkKReddGfzD2yWRTlaa8B+X0TbvY8drVU3zS+yYE9cp/+9ccKAxCvBvf7+BSEyKOL1sji62pwcji6ZF48UqdcOPJz1BCGVpLswnsZ5GXl6nWiFqPf8iFju11hrTLnlWS3r7rUJZNC/VbGdRblvOXe6VU1PRWQdgjHh3VfooK3MKqldYcW2JH9LjvC3bcQLwhQiHB78GWRenMJta9Cwkzi6l7aDrNv9LpReETKYV8qIsGVaNIeWDNy28EdiykqhTjIIO8B6lnUInXIgGVEonBdMKbZfQ5F4502LYuv57sgzLp+MFmOa98EKIKtlpyDJEAFZlCQOJ4IKyy/F1fGWJE7ewDAFSg9nzU/Pf1fuhTTptJYmaiMYcfn+/eTquJ0rixOG75XgnfHMjmiY/GrfSkdV/oNAhOhyqduuzv5Q23Re5gBi1Wi0hsGKmACCzRaXDhqQ7hfEKV4dxpcYGuu1xlZIgzLZGiI0PibcGnF3tLnz+CDA7JDhrRZ8wEntwBDP1QccBg3Y6hYVa+7tf0FwW0JhgY6nM4jX3QjoewJEf9JaL5ZOeA3aipHMYFCCOWE/UKZAjeqn0aXStWOM91yX8vz3YwBpE3Sq9GLj+78WF17Xx0uBkI8W4S1QzaI0jEjysPwjXoulbyIIuvSVhz7JhQ5fe
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(6636002)(40460700003)(70206006)(47076005)(40480700001)(41300700001)(4326008)(426003)(2616005)(1076003)(70586007)(8676002)(83380400001)(110136005)(336012)(36756003)(316002)(54906003)(82310400005)(86362001)(36860700001)(356005)(8936002)(81166007)(5660300002)(82740400003)(2906002)(478600001)(186003)(6666004)(26005)(7696005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 07:53:23.3513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81742dba-32dd-49ea-e1ff-08daf3a8ea1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E641.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7688
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
Cc: Horace.Chen@amd.com, Yifan Zha <Yifan.Zha@amd.com>, haijun.chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
SDMA0_CNTL and MMHUB system aperture related registers are blocked by L1 Policy.
Therefore, they cannot be accessed by VF and loged in violation.

[How]
For MMHUB registers, they will be programmed by PF. So VF will skip to program them in mmhubv3_0.
For SDMA0_CNTL which is a PF_only register, VF don't need to program it in sdma_v6_0.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c | 34 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c  | 10 +++++---
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index e9dcd6fcde7f..ae9cd1a4cfee 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -169,23 +169,23 @@ static void mmhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	uint64_t value;
 	uint32_t tmp;
 
-	if (!amdgpu_sriov_vf(adev)) {
-		/*
-		 * the new L1 policy will block SRIOV guest from writing
-		 * these regs, and they will be programed at host.
-		 * so skip programing these regs.
-		 */
-		/* Disable AGP. */
-		WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
-		WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
-		WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
-
-		/* Program the system aperture low logical page number. */
-		WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-			     adev->gmc.vram_start >> 18);
-		WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-			     adev->gmc.vram_end >> 18);
-	}
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	/*
+	 * the new L1 policy will block SRIOV guest from writing
+	 * these regs, and they will be programed at host.
+	 * so skip programing these regs.
+	 */
+	/* Disable AGP. */
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
+	/* Program the system aperture low logical page number. */
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+		     adev->gmc.vram_start >> 18);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+		     adev->gmc.vram_end >> 18);
 
 	/* Set default page address. */
 	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start +
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index bf1fa5e8d2f9..6fe292a2486b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1403,10 +1403,12 @@ static int sdma_v6_0_set_trap_irq_state(struct amdgpu_device *adev,
 
 	u32 reg_offset = sdma_v6_0_get_reg_offset(adev, type, regSDMA0_CNTL);
 
-	sdma_cntl = RREG32(reg_offset);
-	sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA0_CNTL, TRAP_ENABLE,
-		       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
-	WREG32(reg_offset, sdma_cntl);
+	if (!amdgpu_sriov_vf(adev)) {
+		sdma_cntl = RREG32(reg_offset);
+		sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA0_CNTL, TRAP_ENABLE,
+				state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+		WREG32(reg_offset, sdma_cntl);
+	}
 
 	return 0;
 }
-- 
2.25.1

