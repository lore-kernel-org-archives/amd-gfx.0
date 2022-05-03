Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8E3C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA7BB10F453;
	Tue,  3 May 2022 20:37:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D88110F428
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLd6j1eO5X3/tZAQn0GhJFHaAGe7SpK8eDJz/3AbDIWMwP4qETton9CHVyeZop9bN2nnNMAW+FQrCTBE2J+t4zz/zDzTi3RpYbmVlJ6QvvUqHdO+MvrUU1aHaTLPQwFt2aF+EqC8hD2ckn6Mmdl1KSLEkBOPuq/r0mX8vd8Gy/3UJ8lhZiPqM0qaBv1ZFuantyKnYavLXbYfUhJ1A7BCt5Wr7b4XRIA3V1YpmDq8nhx/eNcOvT3fDv1po29k9ehI5HJIVW63tDtwOhAtdMVmkQwrn82q87XDB/kNmkXTF4vBo2OV0oZH3JUbufyqopBUMcglEYcjmotcRZoEE358IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcnNdt+DQholyc7muIjDjNUjylBfkOEj+q6T51SUuC0=;
 b=N69JwssYG89P1mIdgBWNjp4NLiLPdr2uyg1jnSWInHHuvFuykV2kYMeFRBMP9Vt5K0p0PvdWG6j2DIzKWjILvQWk/MjFs9V3nEcm9a/Mb2d7ialtwLPSCldoYD4foASw8tom+JinvDGpN/RZe9pprOw3w4Lo4IBmAPKlfK+6ijFbSloSbcghGjmQvmunIzbtfxpaNY0WYuHycHSjLMWUIkqqQTP5/HY/g1+hciaC28zfW7KvlwKr4Ab8pjBd/WHR93sVkRYSy6+uuY1sNiVR4YKPrWkUqIopC53Msm9StnA7lz/t7xuPg6RhHobM/rvnjMhuVfpjXNCe63bdHblEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcnNdt+DQholyc7muIjDjNUjylBfkOEj+q6T51SUuC0=;
 b=TZeoN0fCoYv/qcYti+piWyN09msLbHxLIiBg3XbWgeqWdocy4MwzdGjKHDQ3szIUatK1HixCgm9h+w11Muxeab7ZGdgC6eXxFBpfyBELM/HVGDZzjoDr30DDeWC0hQ6yc8v2+Xf2O7Tbbqw5zsICFKyOe6wvoDqNSAQQhH+IBNU=
Received: from MW4PR04CA0146.namprd04.prod.outlook.com (2603:10b6:303:84::31)
 by MN2PR12MB3439.namprd12.prod.outlook.com (2603:10b6:208:cf::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Tue, 3 May
 2022 20:37:39 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::78) by MW4PR04CA0146.outlook.office365.com
 (2603:10b6:303:84::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 3 May 2022 20:37:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:37:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/26] drm/amd/pm: enable platform features for smu_v13_0_7
Date: Tue, 3 May 2022 16:37:01 -0400
Message-ID: <20220503203716.1230313-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203716.1230313-1-alexander.deucher@amd.com>
References: <20220503203716.1230313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ead71920-4463-4a36-8059-08da2d44c3c6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3439:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB343930CFCD37D1E10880A180F7C09@MN2PR12MB3439.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3n9+rIt3hdqDQ3OuBHa5n8x7rjCEUE9mTn4NmNflXbG1JNt3vGz/LVKkAewBAUkMgS5agPMlUOQrKGckbqxXAdLLozxZJgRn0aFFaiyVIuhc2wv55ob7hCyi1366KrFTcv+VXIkFcR0KJNlwJrBIUYihWiFXQoHoQuvDeQbVO7leEg8xC0Di2waS4Fz7Nd2D8ccitcmO0ahf4Zz93qOIhXGLctiXoEhKKduEvyRF9GboIdjj1jw2kh2IHQOyB7ic6SHZ8/0r8Cgtwf/YVEr/ciQhJMYOSluF9gQkSViszaA6zfDhTrjUlg9vEhjLMl6JP5Rk8u6yTnfgfqjdhlwhjrk1mZJDRkQn4RlE59QjnCMG5rx5uWNwaHRVBMBA03LRtJlqCj/ArWmpKhXONM2FhxrdQKYSXWMj5cnA6k69u+QHm2bwj2YjPIM3Gzw+6/qcgxnhE2NrTDNCao43vqBJZZisEbbogDXW/2V3KLZLwS57mMiLiLUF/W/Djvqee5pJApGQCmz/Edxy3kEvynu0qIUrStNtBgZ5N/Jg2E9oFOPwGU4f1hTrGzHhCcZm5tp+sQsAzo9UBCHumfhch04ofVJD/zCzos4jfIwXH+SWjcfQIdVcnDYu9amHlfXRvpRtkN3HHKxjWE1FMRRuWk61jH+mzmV5scCFUgezMJK6Eh+Ianji/xmZhqmOpu2rKYNfRVFerLz+0BDQ1UIUZH2eCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(54906003)(316002)(81166007)(47076005)(426003)(336012)(8936002)(36756003)(82310400005)(6916009)(2906002)(5660300002)(86362001)(36860700001)(70206006)(70586007)(1076003)(186003)(40460700003)(2616005)(508600001)(6666004)(356005)(8676002)(4326008)(26005)(7696005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:39.0063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead71920-4463-4a36-8059-08da2d44c3c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3439
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Wang Yang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

enable throttler, AC/DC, VR hot, FW CTF, fan control for smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Wang Yang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 710e66b38577..145ecfe040f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -181,6 +181,11 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context *smu,
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_VCN_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_FCLK_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DF_CSTATE_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_THROTTLERS_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ACDC_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_VR0HOT_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FW_CTF_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FAN_CONTROL_BIT);
 
 	if (adev->pm.pp_feature & PP_DCEFCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_DCN_BIT);
-- 
2.35.1

