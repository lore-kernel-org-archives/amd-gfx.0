Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04842C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 09:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5FD0112EF3;
	Fri,  5 Aug 2022 09:45:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2609A363D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 09:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Erw/+Hgqy0sG4YgdSYVm15Rc8+tYyJi9gCC0SLEip97ZTkOtC3YcyCOA9IeFs1NtzVjDau8efVE9YpYi6CVEJiVnDEjYQpiMNxkxQBsWnfbaxhOY9PK1hTYec1v2gMFNS2i+0UqTygPdiI5maJF8CFFZhHpkuJZ1Wv6UNqPH5/mRWcmaa+Uf56jTHO6YLuqCP0iyRi+XZdqAW8cmGJ3OcY4E3IgMrN1vp+t7F0nSG1eWt7p9KCjglYpRdeVD1T5fYxEzc6t50XtTdp/WLDTnj1VgUCgOkfr7QfRjekgExapHSDc5GvrPKAWSXuwszBKYiMBUNqq03fZtIuREcxDw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSQCdcQxfmzpjO6zlSPoOEO47AT30G2IZOo3zI9UE9Y=;
 b=mFTgNlM2N1rf7UZmvOd+0eUzc/5TVwswSK8JmaewLMZBP/seWgoBAwja68QqXpXwPPKk7ZJyNkpSJ5e6Vdpiu2vblaXkR7jusoHcDtvx4892xMtIVX9uniNqZ85VwIYBM0zzKZAoeSSrAPFOZQBtQYd00OBXg24nhgF7WdBB9LuFa/DbKXIpE307lxeI0QkoAwaiB6SmIgFsrJYXZRTMzjyVJopTFeFhv7zdzE45KrGjah9UlCIs1lY+Eat2Ftme9tX+5HnAl+8ciP6PP+5TguXKd3yKwwegBxjqFQYO4GMvJlvJfKs50auBd+z/AtjsY7phcH8GkTILF3ZnHFw3GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSQCdcQxfmzpjO6zlSPoOEO47AT30G2IZOo3zI9UE9Y=;
 b=TAf2r3bnxj1KZuw1Ei3vageQ8Xg63RpuZfXlVolzuE4DQH++niLb0ol4bRHOE+Swt5uwr9CMHHQ04LxLWQ2zplRo2AM0yjQTtXM53AaODJXfZvagUtkRqBRixQtxtpuX+edBWSUne00Y/3wmWacfIWGBi6c8Vp4OaVM+llAGaPo=
Received: from DM5PR06CA0077.namprd06.prod.outlook.com (2603:10b6:3:4::15) by
 MN2PR12MB4637.namprd12.prod.outlook.com (2603:10b6:208:3e::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Fri, 5 Aug 2022 09:44:43 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::8e) by DM5PR06CA0077.outlook.office365.com
 (2603:10b6:3:4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Fri, 5 Aug 2022 09:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 09:44:43 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 04:44:41 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/pm: remove EnableGfxOff message for SMU IP
 v13.0.4
Date: Fri, 5 Aug 2022 17:43:50 +0800
Message-ID: <20220805094350.2665868-2-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805094350.2665868-1-tim.huang@amd.com>
References: <20220805094350.2665868-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4cd5d6d-1754-42cb-ac60-08da76c72011
X-MS-TrafficTypeDiagnostic: MN2PR12MB4637:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbSp3KQ5GKf0+HJJpbegrGwVDCc9luaxDOJLHv2VIwKN68nJXwk3ViYyNOS++8dARzr318xU7xGNR41CvykMKBgGKwhTHG/ECcJtyoNKZH4d2OtN/eJOU68b4huXRzqQfEcADGHgKpn/lvQ11xyuppuQ/rsbhsmvx8OXnWgZkVgXBNa9MzgRtiZS7KWKf8pvbi6hHyxLGLy9MYBbPCla+E2gMQygCzTvrmrLs6GvsqvcKjebkYRHGDvEQAf1yMpgSCOGZ/3DR8xhEYpGZOwj454kiIv84E+boOjH5W6sWe9r6hA3zaPGh/WeDOZZn3J0EiHSVaihUgUCG0f5cwTfUPjM1IISmePFiO98tQJjHebHNlJRWFGJY/NToYd0vSqHY/3o7NzaOEKdtuxPj8vMRwbI64/Kh7VT6DrKrBWnBl1HWNtEKggzSYPcVF7N1AT5B6m73RSbk0UOVDLzBb8cjEbZZN88lLYheotdyM4DWM5CwH7MDJqr6ukrGs1hD1bDqRacNJicN/pS2m9GrNif4izVyiZ+QXjencxgKLd7yTIIuFVYrQMJPybE44O77bzMeaO+frnEftsPScX7vuRY26iO+y47A9hWYXDWaTLBS9pU8RWr6KrvhdCUPRAI0LfV2Ahx0VPe/9I8IRKQ3icpqLaHOGsvOJCU+yOblJq8xBFt1RzCU4nbeOi+GIq9YJNE+mWqAxIvlEf+7R/89wj4xTy2J8F8p78/1JeGk8HlGwLLVVmVT6ZmX8NzJH7cL2nKkjgKhizO47nhjJtAfN5yxAg0qBDruyaDwcZh/YrHCYWzpHBY4pMDnxQMmxKASyV2G/fBEy9T8/LfUu1kvTHJfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(40470700004)(46966006)(36840700001)(478600001)(6666004)(41300700001)(7696005)(26005)(44832011)(82310400005)(40480700001)(2906002)(15650500001)(36756003)(6916009)(86362001)(54906003)(316002)(16526019)(36860700001)(82740400003)(356005)(81166007)(70206006)(4326008)(1076003)(70586007)(8936002)(5660300002)(8676002)(426003)(336012)(40460700003)(47076005)(2616005)(186003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 09:44:43.4007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cd5d6d-1754-42cb-ac60-08da76c72011
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4637
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The EnableGfxOff message is dropped from the new PMFW ppsmc interface.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c   | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 82d3718d8324..64665e8a86e4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -71,7 +71,6 @@ static struct cmn2asic_msg_mapping smu_v13_0_4_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			1),
 	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetPmfwVersion,		1),
 	MSG_MAP(GetDriverIfVersion,             PPSMC_MSG_GetDriverIfVersion,		1),
-	MSG_MAP(EnableGfxOff,                   PPSMC_MSG_EnableGfxOff,			1),
 	MSG_MAP(AllowGfxOff,                    PPSMC_MSG_AllowGfxOff,			1),
 	MSG_MAP(DisallowGfxOff,                 PPSMC_MSG_DisallowGfxOff,		1),
 	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,			1),
@@ -226,18 +225,6 @@ static int smu_v13_0_4_system_features_control(struct smu_context *smu, bool en)
 	return ret;
 }
 
-static int smu_v13_0_4_post_smu_init(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int ret = 0;
-
-	/* allow message will be sent after enable message */
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxOff, NULL);
-	if (ret)
-		dev_err(adev->dev, "Failed to Enable GfxOff!\n");
-	return ret;
-}
-
 static ssize_t smu_v13_0_4_get_gpu_metrics(struct smu_context *smu,
 					   void **table)
 {
@@ -1026,7 +1013,6 @@ static const struct pptable_funcs smu_v13_0_4_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location = smu_v13_0_set_driver_table_location,
 	.gfx_off_control = smu_v13_0_gfx_off_control,
-	.post_init = smu_v13_0_4_post_smu_init,
 	.mode2_reset = smu_v13_0_4_mode2_reset,
 	.get_dpm_ultimate_freq = smu_v13_0_4_get_dpm_ultimate_freq,
 	.od_edit_dpm_table = smu_v13_0_od_edit_dpm_table,
-- 
2.25.1

