Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5879EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 06:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0506D10E2D6;
	Thu, 13 Jan 2022 06:58:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D8A110E2D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 06:58:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOWRm7XrS9TIr3Br9eRWLHV5kaBspu6YCux8fY4wXX1Sgv25MD3hmWnwxbadknHMsqf1bWPBuE6Rg+AtLN1MfeBWwNeLBKqdbFmnXBbWNmMRlUq6G6IJxr3uL4rq/VTBhqeFqCvaMGGkY6Ww+SNUmTPnGMzm3CGNx7jywxB5zx2rqxJ4JthzQzNoAZio+HxnhrnRxz5t0D13uT4lSPi/Qa0y1Kudxmmofjfl/vCFyddailmwtiXW61sCVWSmd5XwMeRcjRFfJezQf5imbQUakp9EdaYO350N4m2OuMNAthQVPmBeqsP+yC4lloGmunjlXozjOStDFxFGFvC47x+9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncDxWp32Iulvij7PtVzrfGNoW8mUcnoBj5Hm7gZJ+tc=;
 b=eboWk4yvCR8f7x/uZ+9XYNW5++iZZ/pCVxJmd3Y8MvalvpJ4cegh2VUFoqDGlytH1Hie+JqW+SG4FWGTVYKYAXjf3Ob4PRh+HHvT09iivLjvlAwbaXx+Gv+u5h+WQjHmf+r4gI5NTByFTCrEf7syICJCV4gnsuh3hjk4gmyuqCcBBpvWYyFTePnLXgEYgUW3BHMgPeZE4/ZZECrbf4LVqdsvl+Iz2yqFM/j45+BmOUD9Ayo5RfoiacHsgHEtImJh/W5If8/tmrT1TVv7CmzlUwPqh5lP5jxmodQMa0mKn82XggbwCAP7bNx/dNgnO/gdh0TSPgACvTbepKghKxiIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncDxWp32Iulvij7PtVzrfGNoW8mUcnoBj5Hm7gZJ+tc=;
 b=O1/OPW2aBQ30wT5CsO3PnqvFU9Q0gg5fNX1uO6jqMFoHmU+hkUn/reDMSmTO5jGlYtvfoRRSxhkS2sJs7yjPpjTNgtjMNXHuNiPlhjLugEl/EauZr9Y9gbwN+Y4Ol4Yw0XQRDJciuv2iE87OyLikPOKXhwMcfX0ymx3w/zPF9pk=
Received: from MWHPR19CA0064.namprd19.prod.outlook.com (2603:10b6:300:94::26)
 by CY4PR1201MB0248.namprd12.prod.outlook.com (2603:10b6:910:18::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 06:58:49 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::28) by MWHPR19CA0064.outlook.office365.com
 (2603:10b6:300:94::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Thu, 13 Jan 2022 06:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 06:58:48 +0000
Received: from flora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 00:58:45 -0600
From: Flora Cui <flora.cui@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <evan.quan@amd.com>
Subject: [PATCH] drm/amdgpu: fix null ptr access
Date: Thu, 13 Jan 2022 14:58:26 +0800
Message-ID: <20220113065826.129865-1-flora.cui@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d033d70b-9dc6-448a-555c-08d9d6622668
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0248:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02485C97AC98CC1BFDD1A00CFA539@CY4PR1201MB0248.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j7fz709SpUcEP4jiPbvjqN/LvYdOivlTr5MO/7Nn6/P1HefPmCmeLZws7DuXOB6ekqpw3zW/McttYGr+F6JtIk4Ni15dSVy2vEvcO0V0vS/+wBnJfL8koUvaUEgA4yaccz8emM71k5MBISvVjP2uN+Z7TygQI42ZieS/sfHAgBuEz12WexUJq7UQAzo6x9D/k5h/tO1kvjo0mxPJ0refXulQ9XQDnPwpOPCoCgcQ9r40d9/Xklo36TmE5Q5Mo4771coyBJezMOURPschXvoJBp3Fh9bE/bR0u621mqw3AWqpDgV5YiwQJwQ/tsoV1HhXM2oL0zIkURyJOpN8mR6B12rnW01eOwB8AcVS1AmVcG+iOECAcR7mz5OqE2jJCJWAS+JT6/ptKdDZMIUgBAXLW7VrzbNysaAKizBYjpvQKbEesUnGNZWlSgph9VUbMB4O4U42A5RUX5sdBJlKQhkiS1dRMpHk7PTi6xOLys37te4XJJoldXND2G19pP0mxu+vDCbLml81tydlfkO///vXGopNI/JLdtBZyAt6xIusbCJJtbJMr2UjyTC/S1EKBdhcCMDevoR7T+ngzfslKoHtgMU6uXdLHSPzMWsZ27zqvJOt4EM30IO7180REnq6MTcoqhYnAI9T7F/bojfl+vhI6vGHtkYtgjF5cxAZT44eOA17U79igtQXT8BRAjtp1o+mCmxKdc4MujjspSyy1Xk3qCqvz/dvKtDmREjTP5KVgn4KiLgA+McRT6qZR8hk76mo5A4EiMOdsdDBEAe6s+CKGWwknrrGzPU7yb3z0AaaoAo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(4326008)(47076005)(316002)(86362001)(70206006)(70586007)(336012)(16526019)(83380400001)(40460700001)(186003)(1076003)(2906002)(6666004)(110136005)(26005)(7696005)(82310400004)(426003)(6636002)(36756003)(8936002)(81166007)(508600001)(8676002)(356005)(2616005)(5660300002)(44832011)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 06:58:48.7584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d033d70b-9dc6-448a-555c-08d9d6622668
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0248
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
Cc: Flora Cui <flora.cui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

check null ptr first before access its element

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index f0daa66f5b3d..5fc33893a68c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -463,7 +463,7 @@ int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_versio
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int r = 0;
 
-	if (!pp_funcs->load_firmware)
+	if (!pp_funcs || !pp_funcs->load_firmware)
 		return 0;
 
 	mutex_lock(&adev->pm.mutex);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 828cb932f6a9..aa640a9c6137 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3281,7 +3281,7 @@ void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev)
 
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
-	if (!smu->stb_context.stb_buf_size)
+	if (!smu || !smu->stb_context.stb_buf_size)
 		return;
 
 	debugfs_create_file_size("amdgpu_smu_stb_dump",
-- 
2.25.1

