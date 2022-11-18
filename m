Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75177C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 17:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F169010E791;
	Fri, 18 Nov 2022 17:01:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EACCC10E790
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 17:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oj13tHupzDTDNG3cTWDVO+/QWKmFuxH/N4Xn+XuGME2+eZxE/2l40dJtfVuqOjf6B3I9BtiLEcw1a/aN9rMTIYYFzUWAkF0HS2iOAARFldWGz2lft+7sPZrLT4GvmjkF1Ng2mhXeY904Qopfh5Yg4Y4ReiZ4ICAjagZGKSgQhijr0CzEk9KPR29fdh5MrCWpU8XPAMHLLZaKBAl4jpiEupOUBKktcJ3CjQilAtXet/LM2wzfZvLTkwu34f0hW6wrEY1o0nJZvlSzaRnjloKh/DysdK5J9Kju7IVLPWtJ1qojIRd5hhYPc1hBltcXyVH0fw+S3RKE/WXk1M6/V/wykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tu9RN3ysxgLclJCd72bUUxoVMSMUzYe8FAHVdcfN2Oc=;
 b=Rju/9x4e4bCsc8JV8tu8ByAUyZ5kaXJuJhe4WLRWKRGnfYroIxMoSMfwgbzx4CpshZ6TJ9eTYIjPri/iEwVBktZa6CZWMbV6FTHtL6nM+kAtHpNPx96X+CHkbWwNgx88xCabCME2FKjJy45UnKRbyXUQlG2k22nMA7l6RDtBnJZg6B9QmROkSHkNmxY6IGbnd0+dHsyMpAUfbEBaidftWnQMpOsPq1YfNmW6Ln/manxHQ8cBYEX4hQB1Lixg6k50me79NmozktwMhxAFATHFuOrd4bjZdDLbSX6kS2m+9Y4rhp+4p8HDjVe31QZqA8m4ng8a2s4yY2CH7rh8BqL6+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tu9RN3ysxgLclJCd72bUUxoVMSMUzYe8FAHVdcfN2Oc=;
 b=q7c4xISYQvm2WcWyMbvJIrIftQ1A41vNxqJBqfw0l7YINc419zjUZ9fh9nHqzkbBY/t2PzcyLFzKZfT42opaVsQDNy1E1QGysK3Cy9PcNP+C5ZLkP8nGT51W0oZWJVqkn1pXRomV4Wot4QyZiK9TyUW5XxnOGjKkGca5r1y2Z40=
Received: from DS7PR05CA0067.namprd05.prod.outlook.com (2603:10b6:8:57::12) by
 CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.18; Fri, 18 Nov 2022 17:01:19 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::8c) by DS7PR05CA0067.outlook.office365.com
 (2603:10b6:8:57::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9 via Frontend
 Transport; Fri, 18 Nov 2022 17:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 17:01:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 11:01:00 -0600
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 11:00:37
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/22] drm/amd/display: No display after resume from
 WB/CB[modify]
Date: Fri, 18 Nov 2022 20:59:27 +0800
Message-ID: <20221118125935.4013669-15-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|CY5PR12MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f144502-519e-46f8-876a-08dac9868295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uq6YdQXx5BSADP0vTEY0ARa8hjSTwqGBAG5h0wXV5TZCP5sbydKfM77yu1BHrjugkZu/ikc/U/LEruQ59fjaP9tAbNr5i5PegIpsTmPOYqV9t4GtJfnps6pX8pBlEe+4beaB0htFysP6sx57kWlWDyZMn4LYIGTMrhn79W38dBDJTXAcOtDRsRy7AOsEROm/H9pJ4wzVt2GFOPRw0okRSqvvgi1dsS/i0A8nLlqRyxB7G4pq2s2W9EBsEN2Bxk11DP73NGM6ISepfIR/MtXUk1aIkDCU7HEji3nl+Dq4f/HfI5G2PwR61JtJmWWBjPOFQYVaEeLJrz5fp3GBISX4MEM7ps52Xx1PujozErB4DCOYET/eY+wkry4fR43IdnrSBxqze0oT5bv/VDjFCQRgmydme7DcP4FyKGoacO3kmvsgdP9J40xQyO9cgruTLDgL8BvvARyQp3pdWIIsdfEHwaeeYhjkOtJ3vlxNrJE5q/w+nSy+rzU/7PMBYRb5Omdh040w8XL2PjMOgtekUBv7ZLhFYlC1UoprYOZKyudHkmVGw4dwDOh6pYoIfKn/KAB34DT1ZVD+DLrwOqY2bQDw4R/LykHSJTTFkQC7/gwFoK05Q7NXnFthTCFU62FLgsEgcTc15PUGnLMTWZDAIvXtxGc7jtPB/PCAV/p283+2acMK1LEG81duTSSH/xAOu1BoQHzLIiLjSxf31X1wKovpDNtwJYr8f0u2E4FMeobC/OOlF/Ediz163xuEwCge2+YwpN01DPYpfL/Hs6hd8VQXZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(36756003)(356005)(86362001)(81166007)(83380400001)(36860700001)(40460700003)(2906002)(40480700001)(1076003)(5660300002)(336012)(426003)(2616005)(186003)(47076005)(7696005)(82740400003)(26005)(82310400005)(4326008)(70206006)(478600001)(6916009)(70586007)(6666004)(41300700001)(54906003)(8676002)(316002)(8936002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 17:01:17.9203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f144502-519e-46f8-876a-08dac9868295
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Jerry Zuo <Jerry.Zuo@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 tsunglin <tsung-hua.lin@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tsung-hua Lin <Tsung-hua.Lin@amd.com>

[why]
First MST sideband message returns AUX_RET_ERROR_HPD_DISCON
on certain intel platform. Aux transaction considered failure
if HPD unexpected pulled low. The actual aux transaction success
in such case, hence do not return error.

[how]
Not returning error when AUX_RET_ERROR_HPD_DISCON detected
on the first sideband message.

Reviewed-by: Jerry Zuo <Jerry.Zuo@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: tsunglin <tsung-hua.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5b97723ff6fa..eff14e978e90 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1372,7 +1372,7 @@ static const struct dmi_system_id hpd_disconnect_quirk_table[] = {
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Tower 7010 Plus"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Tower Plus 7010"),
 		},
 	},
 	{
@@ -1384,7 +1384,7 @@ static const struct dmi_system_id hpd_disconnect_quirk_table[] = {
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex SFF 7010 Plus"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex SFF Plus 7010"),
 		},
 	},
 	{
@@ -1396,16 +1396,17 @@ static const struct dmi_system_id hpd_disconnect_quirk_table[] = {
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex MFF 7010 Plus"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Micro Plus 7010"),
 		},
 	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex MFF 7010"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Micro 7010"),
 		},
 	},
 	{}
+	/* TODO: refactor this from a fixed table to a dynamic option */
 };
 
 static void retrieve_dmi_info(struct amdgpu_display_manager *dm)
-- 
2.25.1

