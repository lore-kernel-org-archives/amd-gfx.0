Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAAFC678DC
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Aug 2023 11:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E2910E4E6;
	Fri, 18 Aug 2023 11:01:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D3A310E4E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Aug 2023 11:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGg+YK1OSZHuMle40+yvTFhE4GewTlswT7PF/09Zo++95vUEpEuliB2W2UkQ76KSUPju1y3zxcJsc03+PmQ2oRGaRxAZ1AU1ghsPsBceWcTOV8JDZjQVV67c3/mnvv9YudIxWWvWARSX0HhJa8qeQA2A1Ks2tuVGAg44R9xNzP60ELCPdfO7hUkTKhLdZ4Q4YmZanJQCip+JHsS7UoYxe9nTsg/r5djT/9eDbqlvrEuI4gdPu3+YdabYsbCVjKVvg5OEHxGUyzWVEgq4gq8IzHC8uBcoC1imzKF3Gm4q/z93Crj/wCVrlSLJCnYHlXSL9tDwJGxgvXXn6ia5UE1UUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUFthIVx1l8aFegnOYtrkXHj9JWBzfua/Tz3ld7hFT0=;
 b=R5yi1UvPC7Q1iGNF1DVd4aNFWp16Mq917c4czcdCTbylL/PuT5xCpZl5LqDOyda3TKRjMmw5dE6fWhedxKrA/HgWrY2r+EA/C06SxouM/QYOHw6FIZyGJKVIb9A6b3jhOCOV8MmmzbIIoBYY4GqJ9gXtEz9m0XgQNmKW6aIEEm6KYUFcZzx14/d7oCa0rIiQEaawzop9nl7cm3ojOTy8UdcMHkKyGgaMpvEKeqh3YDUUDxlhgPSxeQj9/2yCLeXl10IAswfvrKh32hUbpGP37WQDLlY9kdSEm4m17xi/qfAHQmkOwNkG9g+FJys1cQ9SmgRb7CzQ9nGRjPPckP/uIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUFthIVx1l8aFegnOYtrkXHj9JWBzfua/Tz3ld7hFT0=;
 b=FT0tmXYJ1jMn4oY5jjGWKkCIe9uIZyrdooA+K2axkrrYuJxpXfJLPbGWEVS6csR0Sj03fkijcDU3Bq8zM/SDKj8ahLn+5QPo7sqr+U/CHLQDui3XfggTuPM4ZcjWMeYhZU/aKxzsvntduAzudGop8ayws4ykr5BGO6h3vZ9m6Cw=
Received: from CYZPR05CA0022.namprd05.prod.outlook.com (2603:10b6:930:89::12)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.32; Fri, 18 Aug
 2023 11:01:21 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:89:cafe::c5) by CYZPR05CA0022.outlook.office365.com
 (2603:10b6:930:89::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Fri, 18 Aug 2023 11:01:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 11:01:20 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 06:01:08 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <KevinYang.Wang@amd.com>
Subject: [PATCH v2] drm/amd/pm: Fix critical temp unit of SMU v13.0.6
Date: Fri, 18 Aug 2023 19:00:55 +0800
Message-ID: <20230818110055.1231261-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|MN0PR12MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: a613f7d5-ad61-4ccd-f5df-08db9fda7482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9WIR6DO7tKL/hF7KEg3oU6ZLFBiNshu17nP6XblKnc3v7SZeOk3oqwcQzfp2IX/uA65tFOX4iOOEC/e7tOotpo6QBDg7gXp6v07PNCjMTmMy7uhS671u0eUZyBbe8DJgBhjKvn2BADoXefXr7WkHnEAJn9m54QGExRl19a6ZFb3wIsHcf6VEwYzo5WxFTqtCotC3prPxNSx6xL2ilNaCqhXrOMSiVfmAUw8p0CcMfEnBJAxyc8EYLZk24ybi/4QdgF1h+AJ2T4TOOZnLQ15EvjzxUrX6rw/gvzXD3lFh6OrXt8yEOOXM0AZq6hTDn5aVxC3auBLVhPLYj/Gg4AmjEt2FmClITy+xgOZgVIksVTpR/fwg/905iL82NVCYOSlMcxQE+gWyYP9HHTqLBVsm0s4+M5/d/+xzadUfb6jaLDkfQjoLF3nd+RBlCNv+1hr0WcM6a8VBXX6FfuWKWJbEWT4UhC5VUV4uhKoPajCahHJFlsJgaYEwR9d/H3MXvMj7txLfCJyVloW0VQYdeG5GLgruRyHjr4etlYFFVjZVgDpkci8TfWe7q+Aj+N93bxcWxjp/xwvUtwPe1RuHcLLKgzMAW/pTDEKEFktb16h1DatoI3NrjlH1Q5gccViBtmt43405Ar+++vlXLbxWPSGbO8FIv+eAhjTW+FYqClYgSEO90EBfEHPgpQmcosk0wD52qZpsz7kq7XhVgtZ3Ro2PfPoiBoJHbVZ8aodYUrsR3w79KgGDqyn12cBbWQ/env8ZoxLnKwwYLFFGYybVXyHVog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(82310400011)(186009)(46966006)(40470700004)(36840700001)(40480700001)(83380400001)(40460700003)(70206006)(70586007)(316002)(54906003)(6636002)(478600001)(110136005)(81166007)(356005)(82740400003)(44832011)(2906002)(41300700001)(8676002)(4326008)(5660300002)(8936002)(36860700001)(426003)(2616005)(47076005)(7696005)(6666004)(1076003)(26005)(336012)(16526019)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 11:01:20.8389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a613f7d5-ad61-4ccd-f5df-08db9fda7482
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787
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
Cc: le.ma@amd.com, Lijo.Lazar@amd.com, asad.kamal@amd.com, shiwu.zhang@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Critical Temperature needs to be reported in
millidegree Celsius.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 7d8af9b309b7..d3b578e6bc2a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2086,7 +2086,7 @@ static int smu_v13_0_6_get_thermal_temperature_range(struct smu_context *smu,
 						     struct smu_temperature_range *range)
 {
 	struct amdgpu_device *adev = smu->adev;
-	u32 aid_temp, xcd_temp;
+	u32 aid_temp, xcd_temp, mem_temp;
 	uint32_t smu_version;
 	u32 ccd_temp = 0;
 	int ret;
@@ -2119,13 +2119,14 @@ static int smu_v13_0_6_get_thermal_temperature_range(struct smu_context *smu,
 	if (ret)
 		goto failed;
 
-	range->hotspot_crit_max = max3(aid_temp, xcd_temp, ccd_temp);
+	range->hotspot_crit_max = max3(aid_temp, xcd_temp, ccd_temp) *
+				       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
-					      PPSMC_HBM_THM_TYPE, &range->mem_crit_max);
+					      PPSMC_HBM_THM_TYPE, &mem_temp);
 	if (ret)
 		goto failed;
 
-	return 0;
+	range->mem_crit_max = mem_temp * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 failed:
 	return ret;
 }
-- 
2.34.1

