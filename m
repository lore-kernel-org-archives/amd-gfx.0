Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B47BC04A94
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 06:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EB0510E4B6;
	Wed,  2 Aug 2023 06:53:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91A6210E4B6
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 06:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CehsGeesY6CRSZVADQUt8rPke7h4itmnbzA+nnyPL7Fv9bS7lJISeVaS+kLWyIROEgBYE2nd/S8an3mG8EoVdh496vaswrxmtWR5a2KuO3mk5e8pEXocgkp6UT5r59pU5MTqtZHq0HW7ro38h1N6YdnL+EO3mS9vk7gbUlE/Ijv10Oh2279i6l7QGwUtclUwG46RPRiIavQWXUmWfF8xAcVS7Glg4WYgGPpFxHTjym23L30YuV2JdbpKlxp6j43D2J1fQFzHH1uKJ4llASYzE/9eX/gTcVg4/LG5c4J5t6AkMMOcCPcLdKT3iGzue2vJHAw+MIfwHpDa9mwo817+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JUbU6Lo0HedRsteOOW5yPGGtHU2KYC5GC8ySHFYrf0=;
 b=k/53ZnFUZhPl3Q510WSL0ics62WEjuqRtqptgLaGQ7MPfnQwQRIZchMFF5qgn59FfBgDaXMQoE8g1HD5vW+7FZEwbPYxxD4IrwuA5xH0HBaEwmtetW/Qojjnt6+Zk19oZeUclNXIh2WLsHHGG0slZc0SlShflfZRM/71F7lmIu7M+DgGYELRSAlyPa65GFJ3MDpZihWry7C3I0yiei8gg2K6xsJ6+93TNERTUwiLOyjQR5xr8b0O7yNnN9jRw/AXMCWPoHp2moubDX9GAWIx95vjytEPSdX2Vcdq4rMkaUs9vpcOW79o+avCzgcPfC4qGzogjstr4jEpnAF84NBEiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JUbU6Lo0HedRsteOOW5yPGGtHU2KYC5GC8ySHFYrf0=;
 b=cUo3DSUuQ7ZYSN4koQHY67hFKwTpVr/LMbPmSZGUDE0yzATh2oB/eQieidNoOygvaoasEnaSfsThCcNxpo3CSit+rcAmXco/JeUgC/AneEzqFcs9KQtNJbYK1NcR/6E6hxCyCrKIJoAEtH64NCwYCFMZ6wBi5IpeS3H+tzd0+1A=
Received: from SJ0PR05CA0013.namprd05.prod.outlook.com (2603:10b6:a03:33b::18)
 by CY5PR12MB6645.namprd12.prod.outlook.com (2603:10b6:930:42::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Wed, 2 Aug
 2023 06:53:26 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::e5) by SJ0PR05CA0013.outlook.office365.com
 (2603:10b6:a03:33b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.16 via Frontend
 Transport; Wed, 2 Aug 2023 06:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:53:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:53:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:53:16 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:53:12 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/22] drm/amd/display: Blocking invalid 420 modes on HDMI
 TMDS for DCN314
Date: Wed, 2 Aug 2023 14:51:25 +0800
Message-ID: <20230802065132.3129932-16-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|CY5PR12MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: f61105c2-53eb-4180-bade-08db93252ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ueedtIqjJmFW1y87OyeTSK3MAz5pt+XsIId2L2Uq1wjfPn4SE/ChHLM8tiTh08q3UWRGKBtirFrjjxpX+ekI0H5GZdP1+Rz2ONGuBEEgZ8qcXAjNlI97JacDfz/ScgF8wfDBWiI4X7QbxcKpma80VFpga2ArrMwA1xVPDr6RL/OEcDrdYrdeyoNY6s3KE2Luj5ByqloB7dXrVx2LcuveSek28RO30R64Opk/N9w97xHlqWYAuqcTxEjhT5VFgJfINfrx4COdkbLkPabEyUnKDdPKE8oeyZMYvPxSdM0pgW6lfFlffW0jhvB+ukhO6qKVWLguQRCgzBIbW1NDpzXfoUG8mY2uQhGTfGaUe+IEZa323+UgKamGffqyZg3SBnKNfRmYe4OS8RPePNL4bZUiZgBHv871goFPMdve7FiGVP2/VSZHddFZKXlsPkJNZzw9zMndrAbqcSq/EwwWcSzpgq/rUZb3Y4GWOTVpJLpcMnUyEGLycf9XGOGRbNbcX9KFI9H+DPXaapLHQfQ8Y1Ei7Ku5ruPmWf/hG/TNsnhGSaQnpkq2y6fLec5WBd3Td/2nBvT9PWw1MDisROE9Rciz7wcO2NSlPJBIvZpVs6Fr1yT1PyX5Tpks4mW7FkhPknE79+JUYDgqpD20EHI8od72fSzxh7oOaUOrd9ngFdg32OO3JoPCZfwBpOh4XJiN/LTAcgO7pyrxFAGoHkC8lwHu7JSTTvb/oWT6uPQbosJgGdvBIGSvJyv0U86bflOoTqbGsRwlREEPASYImAG7kRm95NHs1761FFgbV0I45OL5Tbo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(2906002)(6916009)(70586007)(4326008)(5660300002)(70206006)(54906003)(41300700001)(316002)(2616005)(7696005)(8936002)(6666004)(1076003)(8676002)(26005)(186003)(336012)(426003)(36860700001)(47076005)(83380400001)(81166007)(356005)(82740400003)(36756003)(478600001)(40460700003)(40480700001)(86362001)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:53:25.6561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f61105c2-53eb-4180-bade-08db93252ba3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645
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
Cc: stylon.wang@amd.com, Tom
 Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Leo Chen <sancchen@amd.com>, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Chen <sancchen@amd.com>

[Why & How]
HDMI TMDS does not have ODM support. Filtering 420 modes that
exceed the 4096 FMT limitation on DCN314 will resolve
intermittent corruptions issues.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 32251af76935..a94aa0f21a7f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -4227,7 +4227,9 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 				}
 				if (v->OutputFormat[k] == dm_420 && v->HActive[k] > DCN314_MAX_FMT_420_BUFFER_WIDTH
 						&& v->ODMCombineEnablePerState[i][k] != dm_odm_combine_mode_4to1) {
-					if (v->HActive[k] / 2 > DCN314_MAX_FMT_420_BUFFER_WIDTH) {
+					if (v->Output[k] == dm_hdmi) {
+						FMTBufferExceeded = true;
+					} else if (v->HActive[k] / 2 > DCN314_MAX_FMT_420_BUFFER_WIDTH) {
 						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_4to1;
 						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine4To1;
 
-- 
2.25.1

