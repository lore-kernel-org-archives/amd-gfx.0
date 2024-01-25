Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1371C47258
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 03:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECB9C10E29B;
	Thu, 25 Jan 2024 03:23:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A91810E29B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 03:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrCbxVhAs5TlgvhJwTaX/smqH5NUok4kgECpFBGglBtChV9ZixTgk8OjfQzyhljEVuJoYZnfRAYffbJ2jkCSi4HLi1M56s1Z3TUxMn18cbXC3dqwTCLIzOSLxsLHEIHhWwn5zmG5l59bHFYaBhwykJ3jgQqx3Lyf/V7SRsW6UFW+Bv4a+Lf5jHmPDqkMu9EwSTnsxUt6pJQscbSZPqpydM1J/0B3CSWznx/2NHZjoicxNT14EzyVFj8IQgCTZWxoIO5jOuxLclT2OsEH+i136MPIlbabFvnKJfsV1vbC2TJOVJKDZ/hKtu/xNol/dlN0eJMM6W3dRmkuL1B6nOi7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8n4EIWGKF/gJN3ordI9DDkawMWfBrsEGuBTODXJd8pU=;
 b=WnrJ+EiuPWh7vCyCS8MJI3eaUl9bGfB3/55n0vzA9VUESetzGp5nZhPgfKrdNZ97KGrS5jtovYiqYJOBAHYMCJbBhtDN1wj/nS07z2krQz/nqP4HsXUpYcVXqT1DGTiUIcpp/5dmmU9BvjJMLjcrStnsBOMki+wJA3fzxNTQrpeYg9iFkN0gxeqwxwpkXF395jxrB5TIexbPx2LeS4b29nkGCir+q920vws5Gkz8Z0dtc0xRCNyDRqKeCZ3MxSDMudiI/RyTLrax7ttjf6f5C7agbVQAF1HMqJJh5nQP7PUD2psUMwdpKtyWECalfNvY8WAcZTYqW9bjM3tqe4UfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8n4EIWGKF/gJN3ordI9DDkawMWfBrsEGuBTODXJd8pU=;
 b=DAgN3tsZvC91vABLZva4DbF7j+GZL9s53k8Gprn915n/mbCKN4Q49RmoQHC8qSIWVXJv8M6I3xxEwlAM6lD7axnqqtrC5wsBAsXFw6zMTG4wxU0Ksg+IZlETvgQar9xHaCamlYP8mxO+dPAAnFPWPA4sxMerJxLirQHritBhSCU=
Received: from BL1PR13CA0064.namprd13.prod.outlook.com (2603:10b6:208:2b8::9)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Thu, 25 Jan
 2024 03:23:09 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::21) by BL1PR13CA0064.outlook.office365.com
 (2603:10b6:208:2b8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Thu, 25 Jan 2024 03:23:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 03:23:08 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 21:23:06 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: skip to program GFXDEC registers for PM abort
 case
Date: Thu, 25 Jan 2024 11:22:54 +0800
Message-ID: <20240125032255.898308-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 69bd2a15-9188-4c2a-8f32-08dc1d54f3c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 75TvNd9wtFj5hNbQnuMfqrvnlp6k2qbhVztH5l37gQiFEuj/2VDMEzd8M0IkUJBCxj4ESi3BSIqLFCg5cN1WAxWsqbzLgX6CZM/q90Boa1HgMilUkx0f/DbNUxMA72eKbWcrB/iMYhv2vjCCAaY2dNesYJeCp7X1gJ5TCyM++tD1tMC730oXJzJn1/4Uq7nj7czLCqyMoSSDOPcp17Ub5TJb1rN3UXpDgCtjqKKEaSchn+upJIIehlwo5RpXIu1G8Fba+9fRvulhpIWXrLFRKDRbpnYjNC1cucdWR9El3Dmy8XsugAC7SjXoQQ152pKHPXNvH/+t6lOaVVkfb8XPx3MX4ha8+P2XDSlETj8BNLrZ/1hXWIL4wG+M745J1IxNrzu64M40G8EySrgYY5U7CL5U0xCF0BKflnLssEd5+GusbDL9TAiL17v0hcOr4vmFA+bysBAGPw7eZlarlgFVLWbo1+DulqUtnL0X59LixbjNTa+vOSwrA7B4B8sE3X9AEldJ5mWJGwfUJLRix6S8vZe0tjyU98yITz5Nfcrs+lYzhlXHUb2lGZhR3GOM9ie51j1TkbNth7kn/1UrD89C2BtYdFPy/0sAlhFKHt4jawaiwE8af612MCsAZZxpDlOFXKdcRGZ/cnoiHEaYLOVZoT1xdJR9mL0MYx0nzduRC5ny10hkb/dFEow9/A/5LYquHi76P4XAJHJt2nrJLMr6ieKhZzCk0Div9o6h1a84ja1sWNGIDWoINlnuR672SO4GeFTM9S1lG0EH9R6vsaxnGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(70206006)(5660300002)(2906002)(54906003)(6666004)(6916009)(316002)(8676002)(70586007)(4326008)(8936002)(82740400003)(16526019)(356005)(86362001)(36756003)(478600001)(2616005)(41300700001)(426003)(26005)(47076005)(36860700001)(336012)(81166007)(83380400001)(1076003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 03:23:08.3830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bd2a15-9188-4c2a-8f32-08dc1d54f3c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
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
Cc: Alexander.Deucher@amd.com, Deepak.Sharma@amd.com,
 Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In the PM abort cases, the gfx power rail doesn't turn off so
some GFXDEC registers/CSB can't reset to default vaule. In order
to avoid unexpected problem now need skip to program GFXDEC registers
and bypass issue CSB packet for PM abort case.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 6 ++++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c5f3859fd682..9e9e3385b5d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1079,6 +1079,8 @@ struct amdgpu_device {
 	bool				in_s3;
 	bool				in_s4;
 	bool				in_s0ix;
+	/* indicate amdgpu suspension status */
+	bool 				pm_complete;
 
 	enum pp_mp1_state               mp1_state;
 	struct amdgpu_doorbell_index doorbell_index;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 475bd59c9ac2..9cb8f7fe55cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2472,6 +2472,7 @@ static int amdgpu_pmops_suspend(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
+	adev->pm_complete = false;
 	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = true;
 	else if (amdgpu_acpi_is_s3_active(adev))
@@ -2486,6 +2487,7 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
+	adev->pm_complete = true;
 	if (amdgpu_acpi_should_gpu_reset(adev))
 		return amdgpu_asic_reset(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 57808be6e3ec..0abdc85eda77 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3034,6 +3034,12 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_device *adev)
 
 	gfx_v9_0_cp_gfx_enable(adev, true);
 
+	/* TODO: double confirm whether need to reinitialize gfxedc and submit csb packet
+	 * on the other gfx generations for the pm suspend abort case. */
+	if (adev->in_suspend && !adev->pm_complete) {
+		DRM_INFO(" will skip the csb ring write\n");
+		return 0;
+	}
 	r = amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 + 3);
 	if (r) {
 		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
-- 
2.34.1

