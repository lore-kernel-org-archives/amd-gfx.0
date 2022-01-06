Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59572C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 05:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4A241122CF;
	Thu,  6 Jan 2022 05:58:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DC6E1122CA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 05:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBWC70ZUcSQpPg3OQmLrkoTN05KC09eO9A28i2gEyhmeZ8x0MzmsmatGDUG2L0amTVvFGYG4nLPOCr/Kf6bdSHPVlHbtRWopoWOPFpN/RhywC7AapUiVm9dqUBfEm9kLVFN4y6naxK7ik2+tdi64ty3xH6+n+hS8fz07zjsEygYbz8+ZgsaU+4cUQ+YMwR2njRm7Qg4OTstvOhQNG2fWPvk0nAz//uKWE+4lwQoUiXULKaPjPvMxm1giWXgPUD6rHOG3XvYEMJUqxOELzm0W4FAfNSDGiIwgBxfjl5ArQsx33XEJVEEmRZLhXmco+zMlBQjLKa4uRXsjYWVJbZesNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAdTPOb85CyZQJTC133Y0WMpc3B4kkBzo8/KCS2cFSk=;
 b=ZQyzzhiVSdbJNpRsGz1bFur/AxDIWJLQbZr++FL49pC3nV068bNtmh8NVtZL+PBbLP6To7Kfo/EKN03+GFP9McVJ3JOh46GfDygYxc9wYVCBOZ0sSmu8eH3XhtneBAPnTX6bw1BHj5awV79dZrOaT8Q9qN568yyWjGurlppqXrrwFzL9o1YQ62kwxM2w9ZUsyETblqsNZW2alxPz0lomwYJ6JJH2mDmRwvw0IDV6LLDFgWdt1PsNyFn+seIW6SxZNMh4Uoxd+nf5Cjd90LdI8zZ5+cXyyg+4Pdo/0eQZh/GTalJhcgPS5hzWeBUit7h62rQoxak+HfMu8yOwRZFfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAdTPOb85CyZQJTC133Y0WMpc3B4kkBzo8/KCS2cFSk=;
 b=ONkWkBiS/f/JbbAEIdTKHTqYM4fe2Cerl6ASPVros+aQbeEfnaEHMd8TAdZqJ9i3Um3JzhGlC8EA5MvIyVJfZYAeOs7o1sbGLNrzulfxYnxVAtyH7RJVyObJ4LFvuVZt9+PV6GEghvDbGyvI0Db6+IjwXZ6p2NhNUfMFtver9sA=
Received: from BN6PR17CA0003.namprd17.prod.outlook.com (2603:10b6:404:65::13)
 by DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Thu, 6 Jan
 2022 05:58:00 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::ce) by BN6PR17CA0003.outlook.office365.com
 (2603:10b6:404:65::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Thu, 6 Jan 2022 05:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Thu, 6 Jan 2022 05:57:59 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 5 Jan
 2022 23:57:57 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amd/pm: drop unneeded smu_baco->mutex
Date: Thu, 6 Jan 2022 13:57:30 +0800
Message-ID: <20220106055732.3073780-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220106055732.3073780-1-evan.quan@amd.com>
References: <20220106055732.3073780-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08922fe3-13c9-442e-8226-08d9d0d97e4a
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB244045372F35E0146D45FA8DE44C9@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbA0a6nOyEm/wdlikC1NhFHdV+EDPvZ0HI/6NvW72Z4H26gdR/Y/KNr5J5RcVKNnqB3T73ORwSEBZTtwQKxdacnK34TUyn1UW9HpqqWuvfVi61glXpDG/yK5ZUPiakXSEJ1lxsmpoi+T/DlkAAsAhqIjaQAr6wRGI9FgxuhlLrthlaNm1g4pNrjsgYH/IjBsl7JqSuTj/kcGXCqYtaI5RcRZgCJ/i0zgjWgvCBEDOUPP8cby+0y/UsLrtnJt+G6L4iIT12bcnB9TDtawJVLOB2TPXckGLLXFLWsewlypIMrKqQWlVxZMfzf0jtxa7o4mKnOldqbwnG0+1NezsTlM9jc4mR0ytajGl2Q5tR8pxH37kZoyJuFR5zdmlflbpsGmtrUbNPa5gOwkckcn3NEjJe9Ge19lzZrLMnMnnTurtdsUwrXfYBpgZERxOKHCMkI5jWj0qOxeQOiut0R/G4Qvck02fpU55vzfVmik8SUykIUJiqWVSrOwqtEp/ngizu7zpEY4jv1Fl4qPINdKzGJtZG8Od4YcZLGsixzVA5DSZvRaHGczaapvTVlJWq0aKvWh5UDHABRge/drMag+d227uR1Wu3ZH4V/7GX9V7vNJzIOEFEAtRblkFJX0ITCTgUXFCRn4BDuyV7qfiktVbDqKU7B3kqbQB6o+nMzlSmCU9mPwsL484dyc9SfvLxkbSewzaoKXW48Zm3U9KnQ9e96vS9VDgMwsI/c61Xtey+b1IEedfExrlwElm9uvvkkHDSm7jMBc7lqJ8r9iRc3TDRIBEsisSQfwqHfV14oDe74hxpo45Q31loZaYwC9CwDMN4MU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(4326008)(1076003)(36860700001)(186003)(86362001)(8936002)(336012)(6666004)(316002)(426003)(36756003)(2906002)(2616005)(47076005)(44832011)(54906003)(6916009)(26005)(7696005)(82310400004)(8676002)(508600001)(5660300002)(40460700001)(356005)(70206006)(83380400001)(70586007)(81166007)(16526019)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 05:57:59.4459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08922fe3-13c9-442e-8226-08d9d0d97e4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As those APIs related are already well protected by adev->pm.mutex.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I8a7d8da5710698a98dd0f7e70c244be57474b573
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 -
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 -
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 19 +++++--------------
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 23354dd1f4df..0b9c67743714 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -566,7 +566,6 @@ static int smu_early_init(void *handle)
 	smu->adev = adev;
 	smu->pm_enabled = !!amdgpu_dpm;
 	smu->is_apu = false;
-	mutex_init(&smu->smu_baco.mutex);
 	smu->smu_baco.state = SMU_BACO_STATE_EXIT;
 	smu->smu_baco.platform_support = false;
 	smu->user_dpm_profile.fan_mode = -1;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 2cef7ff46010..79b2a817491c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -428,7 +428,6 @@ enum smu_baco_state
 
 struct smu_baco_context
 {
-	struct mutex mutex;
 	uint32_t state;
 	bool platform_support;
 };
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 9acf2c045a97..0d85dc2f9cd4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1615,13 +1615,8 @@ bool smu_v11_0_baco_is_support(struct smu_context *smu)
 enum smu_baco_state smu_v11_0_baco_get_state(struct smu_context *smu)
 {
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
-	enum smu_baco_state baco_state;
 
-	mutex_lock(&smu_baco->mutex);
-	baco_state = smu_baco->state;
-	mutex_unlock(&smu_baco->mutex);
-
-	return baco_state;
+	return smu_baco->state;
 }
 
 #define D3HOT_BACO_SEQUENCE 0
@@ -1638,8 +1633,6 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 	if (smu_v11_0_baco_get_state(smu) == state)
 		return 0;
 
-	mutex_lock(&smu_baco->mutex);
-
 	if (state == SMU_BACO_STATE_ENTER) {
 		switch (adev->ip_versions[MP1_HWIP][0]) {
 		case IP_VERSION(11, 0, 7):
@@ -1680,18 +1673,16 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 	} else {
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_ExitBaco, NULL);
 		if (ret)
-			goto out;
+			return ret;
 
 		/* clear vbios scratch 6 and 7 for coming asic reinit */
 		WREG32(adev->bios_scratch_reg_offset + 6, 0);
 		WREG32(adev->bios_scratch_reg_offset + 7, 0);
 	}
-	if (ret)
-		goto out;
 
-	smu_baco->state = state;
-out:
-	mutex_unlock(&smu_baco->mutex);
+	if (!ret)
+		smu_baco->state = state;
+
 	return ret;
 }
 
-- 
2.29.0

