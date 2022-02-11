Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF7DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 07:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A4910EA09;
	Fri, 11 Feb 2022 07:52:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D93FE10EA02
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 07:52:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiObDFSIlxqLzQ5NU3/4Mms+5Kx0RR++ygvxhvyone/xBzLDe5HkazV1rww9YVtGyuf8jSG2j8ScHbm2yhN4esUHSLeGdGQNYlag11j/z/wkzFkLXiBE4g+S0v2bF6OJqBp4jsimbB/bCgiLj52PSLxZxJnXvZlpibyrwxSQIjJ+IFa4UJGHahU8yU8lzU6cHGvyvT23D5ePo0LP8Qu8wp7xWVpAwdCGMRjLkCxlrBz98lOQIXXzpyS8E8tPe/w0v9p2skkXjXzNNn6b0BhDRlZ08PaPxFtAiwBmQApgE6zNjcvsHvsMb8bEBuDQPJH6aWLGjKIryDNc+guDP1dS3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euQZN4acobW7bimXWtISg1OYlwObC0r9DEScOg5JnCQ=;
 b=YwnzUl9iFYS010d0JJsKaa5Ozv212oyp1/G6s2MZebVn7mS6gLN4dCir6r1WVDYhGYbpgwjb6RsLNHCsPN2YPbi5x9uo9aHsQ5oyn+3woIk3Xyl51YW1Q14G7KLGD5jQLX/nOSqx3co4G7p0Dk4Ln3m9lEeSUUWsZvxbOGv+ZauhLXlRsaajXjR3YubiqQ4TjXF/eOfs2eHsrEWd9gUUkXstXj8kU3IruE/08MLmCyl5rayzuCTaIbBlb774cgO5NnvzXilRo5UWuZHFgFmRbsCxQXCOg7FYer1+b8gvj84feUgtnlx6/eVO6CQkUxYkmJy4QuLuW2EWajPQj76w6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euQZN4acobW7bimXWtISg1OYlwObC0r9DEScOg5JnCQ=;
 b=QWHDgQj/5rc2CP57Vbq55Ij9Srhq5fcXICEYvUIWzdPHHhcztO57c0oKvJXp7iWmDlHtQPt1qZqLLGbaxwTp0pHQw10vXRJwXb0LhS19u1uM6/jyINEMGzhCpO+1r7wmRJB2O2rOJpPK5KiePRQ0QV5vsn/X9pp4ZfVEScz/Zjk=
Received: from DM6PR14CA0065.namprd14.prod.outlook.com (2603:10b6:5:18f::42)
 by CY4PR1201MB0200.namprd12.prod.outlook.com (2603:10b6:910:1d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 07:52:50 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::2) by DM6PR14CA0065.outlook.office365.com
 (2603:10b6:5:18f::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 07:52:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 07:52:50 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 01:52:47 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/12] drm/amd/pm: correct the checks for sriov(pp_one_vf)
Date: Fri, 11 Feb 2022 15:52:03 +0800
Message-ID: <20220211075209.894833-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220211075209.894833-1-evan.quan@amd.com>
References: <20220211075209.894833-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 888ca95c-bfaf-4d79-1d98-08d9ed33804f
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0200:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02004ECE2D0B4CEE039D3977E4309@CY4PR1201MB0200.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+jo76f2ygdYke51xztcoAz5jqxkwW5lczuKYoC73j8PslNJLySe8pj9d2qN7UYCJMzieqdyNqBwJCe2Unl0OxnRz1s0nPCRg+949mVOUR9G1oHjTEEURL+P9l/Jq1DZZXVuJFizPV7BxpIs/PykCfNF0YAKos6144vOa5QDj0/sI873pvOmqhDzOGJ6dWSkG9ao8m4nN5lUoO2AY/3k3dJGMetkOXYWGaRoGSpbZO7Nz08h3Jt//zqcNmkhxb+A0sm/tKFEmQaNG4yfeGqcAjfu8ye+RPjAwa2IiNebG4u6S3Rlw+0VDsGS3rdtZrn1Iu/iCKyVV1ry7UEBUG9kgn9YdTfIeIo/duRlEibCTg+bEaCIZnocFlhQp0j9L93NxmWe9zRL8Nob3sTS9A/wsOu+TeBUvqEBcsjDWn9HySZyHbTafXrMQs4pACqsrXCXc/Awtzf76wCz/puX5rEL2HSmeVuSz4IZVbFqnG8uZGJbMURL5OetIwX7vTO81won8TGFGVRGEMuGtSAD8L1Kvp6lGwzfG2lxxPm2FJPVhwFORPAz2jQC1g7JF5Crl/jS9nU8LlH4gKjOAIXq+F/Jq2ykvZngE1pMezOhEnRe9bpVLQTKL786eiQtl9SF0ZE/OhwCs30j3xOCI/tSGlAw4pVbuadBpS1hHOyezlvPHB0X+xFLDF3ZNx4iGv+BlCXttZK0GM9ioNdgDbdien+9AkbfXoa67lHA73lOIJdrMDk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(336012)(426003)(2616005)(508600001)(8936002)(83380400001)(1076003)(6666004)(36756003)(16526019)(186003)(26005)(7696005)(40460700003)(36860700001)(86362001)(82310400004)(47076005)(2906002)(44832011)(356005)(6916009)(54906003)(316002)(8676002)(4326008)(70586007)(70206006)(81166007)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 07:52:50.0325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 888ca95c-bfaf-4d79-1d98-08d9ed33804f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0200
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
 Evan Quan <evan.quan@amd.com>, rui.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

By setting pm_enabled as false for non pp_one_vf sriov case,
we can avoid the check for (amdgpu_sriov_vf(adev) &&
!amdgpu_sriov_is_pp_one_vf(adev)) in every routine.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I3859529183cd26dce98c57dc87eab5273ecc949b
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 97c57a6cf314..8b8feaf7aa0e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -543,7 +543,8 @@ static int smu_early_init(void *handle)
 		return -ENOMEM;
 
 	smu->adev = adev;
-	smu->pm_enabled = !!amdgpu_dpm;
+	smu->pm_enabled = amdgpu_dpm &&
+			  (!amdgpu_sriov_vf(adev) || amdgpu_sriov_is_pp_one_vf(adev));
 	smu->is_apu = false;
 	smu->smu_baco.state = SMU_BACO_STATE_EXIT;
 	smu->smu_baco.platform_support = false;
@@ -1257,10 +1258,8 @@ static int smu_hw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
-		smu->pm_enabled = false;
+	if (!smu->pm_enabled)
 		return 0;
-	}
 
 	ret = smu_start_smc_engine(smu);
 	if (ret) {
@@ -1274,9 +1273,6 @@ static int smu_hw_init(void *handle)
 		smu_set_gfx_cgpg(smu, true);
 	}
 
-	if (!smu->pm_enabled)
-		return 0;
-
 	/* get boot_values from vbios to set revision, gfxclk, and etc. */
 	ret = smu_get_vbios_bootup_values(smu);
 	if (ret) {
@@ -1428,7 +1424,7 @@ static int smu_hw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
-	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
+	if (!smu->pm_enabled)
 		return 0;
 
 	smu_dpm_set_vcn_enable(smu, false);
@@ -1437,9 +1433,6 @@ static int smu_hw_fini(void *handle)
 	adev->vcn.cur_state = AMD_PG_STATE_GATE;
 	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
 
-	if (!smu->pm_enabled)
-		return 0;
-
 	adev->pm.dpm_enabled = false;
 
 	return smu_smc_hw_cleanup(smu);
@@ -1479,9 +1472,6 @@ static int smu_suspend(void *handle)
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	if (!smu->pm_enabled)
 		return 0;
 
@@ -1504,9 +1494,6 @@ static int smu_resume(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
-	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	if (!smu->pm_enabled)
 		return 0;
 
-- 
2.29.0

