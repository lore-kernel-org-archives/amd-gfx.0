Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D555AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 05:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 462AA10EBF9;
	Mon, 17 Jan 2022 05:42:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0639110EBF9
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 05:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNy/wO46x8NwnCkB1rfA3wQ/a2GZNjyILgs9hFy5AV57b0Io9w5sp1NTGslyF1MHq1+jYZS4C2ay0eQ/QYk0asEe5nuAVSMur6NFz6L1V0W39LxSUwKBsoU4I0SCEaEvTQrPjqoxXFejZkWygUsIEdCWSjkpNYdTZTYbDLyzKQiwCT2UBGmbruwL7/6jazEi1xikU/wWAXhPvPWac2RXI4muTRHc/QH/UHEsbV1hBjAL+m8haoXAyIgA1yXlgirC2xa4+FUd6z3K2vlmx/ggmqvkp5Y/2nPxAo9yL7aPjobalFoP+4dXstHF995Y84zi+Ey+InS9SPx8st27VpicQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgWFchxPQ9+QxzkatuHd9+3y264hf/BLn+ow8c77Ac8=;
 b=BMMXrAu+OwgwP3iS0O36mw9O0ZnP0L62nPCivNaGY8Z9s07usjiYFhBwaTzKbEZMGMOgVDRcavfzm9X36YW79J1T/RQID2Q/VxXjPnGTLWppwP0+t4RfV8dzejqP7JthJHwP78igDcdD6i50u5Le7vDYknZg8yZumOpbUc3lgTegh2wsOzymf7LMMLmc7suOBAnPO2UWQIQgJ9h4ixefq0svC1YO6+EIH+uyQUIBSp6WJ3ApxL7CKZmhhVCYtoHFhn8i/Cv4CdbNxcpYfMqqG8t2lKFMssZswghdK5F+ntPHxk7go1wtOEKJZW0JaFBOyBUSDuf2O9/mbf1hVO5eSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgWFchxPQ9+QxzkatuHd9+3y264hf/BLn+ow8c77Ac8=;
 b=O9L8Nyr213Io2Jxi14EAWzNC4FQBL7303uWjsBrstNCx3ZfvK/N7iVE3TRlQLdTOj+/ZkzKtiIqfo714IEdVjsCzER/hBKd+A65MeoBgGy9nmkTmR4LEr/Jm7QHhWQkDRXAbP5TGj5jZYinnqDAllmqxgjMeeDUvyG5cCHPfvME=
Received: from BN8PR12CA0010.namprd12.prod.outlook.com (2603:10b6:408:60::23)
 by DM4PR12MB5087.namprd12.prod.outlook.com (2603:10b6:5:38a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 05:42:33 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::55) by BN8PR12CA0010.outlook.office365.com
 (2603:10b6:408:60::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Mon, 17 Jan 2022 05:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Mon, 17 Jan 2022 05:42:33 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 16 Jan
 2022 23:42:31 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 5/7] drm/amd/pm: drop unneeded smu_baco->mutex
Date: Mon, 17 Jan 2022 13:41:49 +0800
Message-ID: <20220117054151.124838-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220117054151.124838-1-evan.quan@amd.com>
References: <20220117054151.124838-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 617847f4-f463-4c1d-7bd1-08d9d97c2902
X-MS-TrafficTypeDiagnostic: DM4PR12MB5087:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5087ACB761F13D18D619E6E6E4579@DM4PR12MB5087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m6dSjdEMtC85/k7NuRO5uZ9muvXRbW3Aak/9RkwoWzGkCUoxAhqC0nmYeJG9QH7jLTU0/Qzuvp4CEqz/Go/G0MHVqAgK4d+g8tC8UHPwJJbdEMlYztku69rCcgf0gi3JUlomkppgxBg1apcCAxw4Zw5hDzWFZBKBBUAOK7RnZnU+Sb5HYQZwdGj2zOflda21xUasKWURN5D8zcNDBOlMzrnEufF4xHjc6hPIfzh2uvmGEc2DMtDA6YwrzvExovope//U1uCKOdQPHPbGk7ox7t+BpGEjxdHyejmR6/t2hAtNT6X9gaRGDnizBrpRInP/RC4Jga+6Nk6RLngBK6NW8yZ3kvIP+FT54lSFUx5PFlxPfSkigm2sOJK4LyQaKKxcPuo2XsffbFe6oXoSuTlqs3ZlX7X2uTvgvWpuHLtIKpr9giJo/6LeUo5bVNOAGHChoOQsjd2tMgvDGnYrPWzsiNc0j0B9cUFK6YLu2012lZ5BjbTYBtCtoid3ZENLtmostoMuF599NUBizg5QN9poyB52CJpR09WlR31WmdHU6soqFughEcdRSiqfj0dZOpJfJCF0EeRuPpjG0/HxKi2whWEL6M9SspJ8uMw5ieAmsmuvQYRzyYT7mR31KOZp05gzdESrbxCM2t1WjhBkL7RSr8l+PWe0oHV1fBqLMkw4wHqCLKJ1cHCsg3E8BZ53cRv62gxBr2AfrXP559c99evw8Ww/02uNIaguBqu4LxCVM9dzDgCCY4rPgEhuSKwWPC4J8ThrrZb0GEvrvTzAJcYqluFT0ujePAt5RqdKfdGjrIhJvYjjIAurHifZgs3zh8e0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(6666004)(81166007)(36860700001)(70586007)(336012)(8936002)(47076005)(2906002)(2616005)(7696005)(40460700001)(316002)(4326008)(36756003)(356005)(1076003)(82310400004)(8676002)(5660300002)(16526019)(44832011)(186003)(426003)(26005)(54906003)(70206006)(6916009)(86362001)(83380400001)(508600001)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 05:42:33.6367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 617847f4-f463-4c1d-7bd1-08d9d97c2902
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5087
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
 Evan Quan <evan.quan@amd.com>, Guchun.Chen@amd.com
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
index ccfbbb6c0b28..7cc3886ddee4 100644
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

