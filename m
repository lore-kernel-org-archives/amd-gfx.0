Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCE4C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 03:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 085976144F
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 03:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085976144F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8383E6E9A7;
	Tue, 11 May 2021 03:04:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 722B56E9A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 03:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqvPrv4yCVaZq1BTqfCMcmzJe/+uWFw0DZvVentFq6qiWz4+FC+UA5Cg7H2jcVcoif6veVmrIvTohiOvusv0XGYr3y7uc4fk2sJlenJipt2hqYZKDQ1gtpub8vks0GlxtrnXfIag9Y4orkCKOCFOnCfmcLRn8dhOfz9KY8JzwRPeggQ7Y3TsasKP/u3sF2oFkPSevh/XzFrqM/QfmbUjpfMw3ks9wFtc6rTgdPPtCr6CjAP1gp6k1MHvUfe6q6QtOPmplPCPOZIhZK9ZwKoxjlaBlURrVoMuakNcdJvrjh7G4Bvm5ZKJwbR3Mvzd5cqyWoYOXhgVcqildIUuXxIP3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KqcsOkkDuKVxgX4BPdIe80C5Z5HpsPuWoZ7Mv3GdRc=;
 b=jO6riXXSHjcYYqQY9GqWM5l5T7KAC4JGTDgaTMwXx5WSPjNs49U5VY64Bl7EHN+eRmV/Dp9upyrF4tRK8Rfp3YSch0oGD93+/SeGaaNEudKHGnQcqkdpqajZ0DhaIIWU6bXqWVsrxv00+Y6djt+Db6gNgDG+C//pcYhJGkwJv8l9PMGg6+DxQpWkM/+Fzxoxp81YcP5QCNAXuhwaPmR2HqteijbA0Dut0GM7K+LfyP1Yr0VFwyPGv7h3iuUIjkkPW0eagYme/zRr/wDyJ9HgTqj15E0hDSSIw/Q+5syQH7li/W15+fbuZiUJwMXrJQEqsWLnyHXPLbLMPZ0hMdlpzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KqcsOkkDuKVxgX4BPdIe80C5Z5HpsPuWoZ7Mv3GdRc=;
 b=haWT7+oAdK8m+yXns396/jzSkEJLv016ipB2h90YrXFpbtR+T7d1ftDs/sLL7J42pL5j0taFnES6niBBd4Pe6MRwFn4opPQWAtb7Z3sVVwSps+fdIe8nbGM7EJsubLbfL70mPu9ghHixES80PqoNuC7CVVINSQd90saLXAePpSg=
Received: from DM6PR03CA0004.namprd03.prod.outlook.com (2603:10b6:5:40::17) by
 PH0PR12MB5435.namprd12.prod.outlook.com (2603:10b6:510:ed::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.24; Tue, 11 May 2021 03:03:54 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::a8) by DM6PR03CA0004.outlook.office365.com
 (2603:10b6:5:40::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Tue, 11 May 2021 03:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 03:03:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 10 May
 2021 22:03:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 10 May
 2021 22:03:48 -0500
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Mon, 10 May 2021 22:03:47 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable ASPM by default
Date: Tue, 11 May 2021 11:03:42 +0800
Message-ID: <20210511030342.19756-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 806cc2ed-c2ea-4afc-0595-08d914296974
X-MS-TrafficTypeDiagnostic: PH0PR12MB5435:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5435C690C248E085520D89FA8E539@PH0PR12MB5435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OgpNWtFBXmA85NKIyhzZS/rHPPSfVLwj5ylm9AyNIyoZcHRWb0PdQYUneg+OVjt2NWJxPyKdx8jEo39PC8aEAqZMBCuhTVZS9UTSwRRvN4L+gVILVyJCGQzpoh99uNW40VPXeD0rHLkYFZ6JnVe82a5L5wOCije4BXf+4PbJfH06+AgjWAmvAo24QA7mWZXRUoSfyWnJ2sHhY7leX9LS59+lDyZ4aucESo2/GI8KyvAMO66nnNIjEpiq4mMiSiVxq3KHVbP5mZniQfi0h3bc+YY3vyPwdinzY9NJ/5m8LN9ypksepaZtx6Wo8G3qIp3gYHo1+MyeBFiRqcfNIRGZjTvtSrMHPKG1H+GKNLUJA+sk1RgMx4y41EBq8kRpVDH38H/tle/FXLpXZgaEw+dPzWNcTVtvhbDXU4fIcZlujxDaRGLwoVGdr+cVxAsjU1cLqaWMa5mNGEQkO9qVufGa0UPWNECcWKLartYhdfCZVPdA4Qwjey8trxTUCnb/dVwnqPHDd0/LOzQPKcv9eGFEyLCsRF+d+HyNoc09QfD2iNlnJr4HXwwy9v+MRK7ok7apJW1CLmw3yt0YHoVZN0tO4jLztecG8vwLbU3YTpnrvhMCewA+iWnHZaYvdrZ46JVsNCb4uKCzlvK6422NPCPfNIplZFIOD2wX7/g2zMYkBGVDxOmpN0crw+O+469t26z7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966006)(36840700001)(5660300002)(316002)(8936002)(478600001)(36756003)(8676002)(82310400003)(83380400001)(336012)(26005)(86362001)(426003)(1076003)(82740400003)(70586007)(4326008)(6916009)(2616005)(2906002)(36860700001)(6666004)(356005)(70206006)(44832011)(47076005)(81166007)(7696005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 03:03:54.4102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 806cc2ed-c2ea-4afc-0595-08d914296974
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5435
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

enable ASPM by default

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c                         | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                      | 2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                         | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 82a380be8368..2fcfd893edc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -598,7 +598,7 @@ static void nv_pcie_gen3_enable(struct amdgpu_device *adev)
 
 static void nv_program_aspm(struct amdgpu_device *adev)
 {
-	if (amdgpu_aspm != 1)
+	if (!amdgpu_aspm)
 		return;
 
 	if (!(adev->flags & AMD_IS_APU) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 49ece2a7f9f0..4b660b2d1c22 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -817,7 +817,7 @@ static void soc15_pcie_gen3_enable(struct amdgpu_device *adev)
 
 static void soc15_program_aspm(struct amdgpu_device *adev)
 {
-	if (amdgpu_aspm != 1)
+	if (!amdgpu_aspm)
 		return;
 
 	if (!(adev->flags & AMD_IS_APU) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 735ebbd1148f..3d21c0799037 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1136,7 +1136,7 @@ static void vi_program_aspm(struct amdgpu_device *adev)
 	bool bL1SS = false;
 	bool bClkReqSupport = true;
 
-	if (amdgpu_aspm != 1)
+	if (!amdgpu_aspm)
 		return;
 
 	if (adev->flags & AMD_IS_APU ||
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index d2fd44b903ca..270b2b0b8e8a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -302,7 +302,7 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 	if (smu->dc_controlled_by_gpio)
        *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ACDC_BIT);
 
-	if (amdgpu_aspm == 1)
+	if (amdgpu_aspm)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_LCLK_BIT);
 
 	return 0;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
