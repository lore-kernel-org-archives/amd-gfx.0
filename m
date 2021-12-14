Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9F1C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 03:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A71D10E876;
	Tue, 14 Dec 2021 03:18:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CEAA10E876
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 03:18:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOqi6ykC7wPSpNZPHoOjrBJcHaWBVNcg4v2AUri1ljG/uK/jGZkxNQR6DhpHMNTsNtTexI4JXnvtFyMTV7ASGQCRP3b2U2okQydnklYpDhM/JtbMRaeK7BfJAt7xo8lAbffZEnS1CvxqkT+SN5IPN8DBxprnjsTyBmY75t88RUbHx7ti607PnJkJHKoC/d4EpXuQz3bolMKpHZrByM+r/GC4jgkhlH49UMZHZuegxiAF0dHiPV11cT3UnM/57lJummQZ3isCf9h+q9/e7vHHYolyzFgQ+A1aQ1SqK+u98pnvYpXBbPjJzye5beA5cRk/zdhPK/EhhkmOpBRZmIRVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQCcJOYrVyucALmytXiASjIdATsg1w6svanVx04A3lE=;
 b=oWhCySrSHOrNjsw1jdyMcQ0v4c0J/hGMgzPmebFhegXeFnqt2h5VqMOekpGCINovAONlJkfo1q6gknyYZt1cadTiUx1w8Hhes1/WrruB+mrEAoJTWZONZ0myfWZfQcUnDs66z0OPWjzVYkTMwis4fmGjWgya6khz58xH0eA/ekhD9sJjDLLPcc7tzytrXrJzrk6AvQE/IY9WH6MZfHB8GPZJ5ItCRmvQxw+zRoJmBSx9QQOC5/IrPRRDGtPm9jp+RdaKdIzjYqGhv2akIkUUEEWBgmCPIjZRTrke4n6nnn1eTWlg4x6usVnfxw4BPHG8xgRajYsqlcqcm12HMqAuzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQCcJOYrVyucALmytXiASjIdATsg1w6svanVx04A3lE=;
 b=FVnhPW6l+g0vxItsq/M1Z5oQ0VnRexp/VVW+6Rnl9Q7RK+7VR0OFYRj6pv2HDeFOYCChujBXTI5gza7+QgfGFoub5rsN14ruzwFF2+s+eNKym8tV0z6rRHvaMGRFHJiyTEuiCLpq3aY0fr6iqBRFTzde2uYH4lvL+TS00vsOSHQ=
Received: from MW4PR03CA0128.namprd03.prod.outlook.com (2603:10b6:303:8c::13)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 03:18:16 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::d) by MW4PR03CA0128.outlook.office365.com
 (2603:10b6:303:8c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Tue, 14 Dec 2021 03:18:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Tue, 14 Dec 2021 03:18:15 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 21:18:12 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: skip setting gfx cgpg in the s0ix
 suspend-resume
Date: Tue, 14 Dec 2021 11:16:45 +0800
Message-ID: <1639451805-19735-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 659161f1-c2a9-48a1-dd21-08d9beb05e68
X-MS-TrafficTypeDiagnostic: MN2PR12MB4240:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB42402131F9C19B20C92411A0FB759@MN2PR12MB4240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3wOh8EHFxa1+1RlHqQJKNt9eug5gG1qxwAJRFjMHhiXHbiAhyGCtGLXbpCzatx6MOfnBIGzaRVc46kt2gTcDv2Y+gj8zAA+SCwTUqUGGaKLPebgT9VKw/2UC2bMv+yq83eZHwAZk1161k3L4BrLXtAVISQqCO90+WW8wswQc2baSFnWLy5RC24Kjvg5QhcwxMAs9TcObCs8EtHoVAlOxAKpJRwF80aOtKO9iS8sbV+uGr+jDBehOVzAmB3CwzIutcWjuM5VDORa2buqCr5GYnyf8oqzPNZwpHwy2/YsAdLbVITibsV3FeHU8WBNuN0dqEIaB8PBWi9qzPwzKlYM9Tve49mwp9VV7P39BEgZKKwEhaQvEOqLwrIoL3rsnFrSH1fYtM7YtgVh7ZNU0RWEFrXRm2rXZH7oTmecmRkWotmLy5+EPBjpmTOf9tdbQ8SjVCgYMyyv/8gTyYkBZwjPst1cvrXd/El+4hU7ThRtZ+EIMEwGnhPraluoeg6H00IhjKsHFMy799HzzNnWwli3uIBeOn3uOyzVAAeH8MwAkl/IvExy1c9bN3vEeuij3SnIqmidlvEJWFyydjkdQwy9b08A+nJoFEGmPNij2jOyODstwgxbtuUEBYATAzVhEjsebvvpelB7gTPyYGzmuhYJIBpx0xufFczY68hSHXlhhlydTPLVmt4mPMgr4K4ro4c+ZS7cztRK+VgFECkMjs1i52G2IUeBRlF7Q+EZr5hlPoR6HAG8LgV80F9UzEShA60vyD/4GGGr8xxZYlehudzgIpy1a+eGeSgH0qR4YfCIJkSIDhzXF8q1EbydKDf8eIj+9lZZN4MrFi/DmShy7QqxmGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(6916009)(356005)(8676002)(81166007)(70586007)(316002)(47076005)(8936002)(36756003)(70206006)(7696005)(54906003)(83380400001)(2906002)(26005)(15650500001)(6666004)(186003)(82310400004)(36860700001)(5660300002)(4326008)(426003)(336012)(2616005)(40460700001)(86362001)(508600001)(16526019)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 03:18:15.5525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 659161f1-c2a9-48a1-dd21-08d9beb05e68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com, Mario.Limonciello@amd.com, Evan.Quan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In the s0ix entry need retain gfx in the gfxoff state,so here need't
set gfx cgpg in the S0ix suspend-resume process. Moreover move the S0ix
check into SMU12 can simplify the code condition check.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
v1->v2:
- Move s0ix check into SMU12.
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 7 ++-----
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c | 3 ++-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 2d718c30c8eb..af98fa140d83 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1569,9 +1569,7 @@ static int smu_suspend(void *handle)
 
 	smu->watermarks_bitmap &= ~(WATERMARKS_LOADED);
 
-	/* skip CGPG when in S0ix */
-	if (smu->is_apu && !adev->in_s0ix)
-		smu_set_gfx_cgpg(&adev->smu, false);
+	smu_set_gfx_cgpg(&adev->smu, false);
 
 	return 0;
 }
@@ -1602,8 +1600,7 @@ static int smu_resume(void *handle)
 		return ret;
 	}
 
-	if (smu->is_apu)
-		smu_set_gfx_cgpg(&adev->smu, true);
+	smu_set_gfx_cgpg(&adev->smu, true);
 
 	smu->disable_uclk_switch = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index d60b8c5e8715..1ae59f2321b2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -120,7 +120,8 @@ int smu_v12_0_powergate_sdma(struct smu_context *smu, bool gate)
 
 int smu_v12_0_set_gfx_cgpg(struct smu_context *smu, bool enable)
 {
-	if (!(smu->adev->pg_flags & AMD_PG_SUPPORT_GFX_PG))
+	/* Until now the SMU12 only implemented for Renoir series so here neen't do APU check. */
+	if (!(smu->adev->pg_flags & AMD_PG_SUPPORT_GFX_PG) || smu->adev->in_s0ix)
 		return 0;
 
 	return smu_cmn_send_smc_msg_with_param(smu,
-- 
2.17.1

