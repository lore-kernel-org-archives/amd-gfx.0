Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9296EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ACA710EDF9;
	Tue,  3 May 2022 20:37:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E75A510F3D6
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFMwt/KxmgMoWw86jgxBGKNnP3J8dtbwq43WTqjzoxWuXlvtJ9WdIgDA+KrGXFCinerd5r4FVo5f33kqrg0sVV5mlrzq/Qb3UszRXQifBZcStiglR23NezhtAnnDoXavDH3/L4AYOdG5S/w11agXHY4hb2JshueO05n8OJ+EI22p7VsIQVq6lllmKioUk5yMXYmZjTksfVmhK9VDgxDSy9eT4fsVQx7qX++2CSpB8j2uI3AMVOSFF3xi3XXGakfYmHnPSH4ZEzmPCR83qKeDb7TPADhcaSzC3GdvFaNk+rDmXjmNjbJcbcYuGPo3j2KKGXV7+BrhqaNc8gYCTIZPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbjLaVNc0A+eOyGVgvlXZoDmDBalBQ13XJqPAo8ty8A=;
 b=aYApBNG28aOelNpvIpk3P7VhX/PcZo7rJqnehGne+7BFgHl981E2sTtMRgEAcAMPA5hDghLs9kbTjWbcQwcmDizb8kVWVmnzFoFH0fFmectGSmaiB22EgBPBR+u5BAZGvOVLuNpF8zMDKdhnO/bxj0gaLmEzM36yWxBN1TQ4EkGTwohC5r72k0eugWDzN5iVthacUvHFHB5Eiw0L8mEwcQuVypc1bKt2kcJV4iiivif/vXaB1E+tXWShi1uKi2LGVQBJ6cbLCvbsAbpAHnPwmkgcLRE9Uzge/cvuV712D7SpepCnlOV4d/pkpzv2Z5ORL9IAlYE2eF6coRhmNmuzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbjLaVNc0A+eOyGVgvlXZoDmDBalBQ13XJqPAo8ty8A=;
 b=Usi3QcbRpeODp23xL20lIJIX/7JXEJyXWHAGnbC622tqjUtRTlb4ud9NIVDkkF3DJ8M2GC+czNuyaz0To0vf3nEnggEqcdcWpeNtssuLxVlbposAWuJUQx02qRYEQrcdM0teJQoMYQyt9s6jEi9J6g5r0OJhYSJO0MdPEDvo6iE=
Received: from MW4PR04CA0127.namprd04.prod.outlook.com (2603:10b6:303:84::12)
 by BYAPR12MB3190.namprd12.prod.outlook.com (2603:10b6:a03:132::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 20:37:33 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::e3) by MW4PR04CA0127.outlook.office365.com
 (2603:10b6:303:84::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Tue, 3 May 2022 20:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:37:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/26] drm/amd/pm: support power on/off vcn/jpeg in smu v13_0_7
Date: Tue, 3 May 2022 16:36:55 -0400
Message-ID: <20220503203716.1230313-5-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a8b4acf7-133a-4294-2b3f-08da2d44c056
X-MS-TrafficTypeDiagnostic: BYAPR12MB3190:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3190DB76E5C7F016C37DBF28F7C09@BYAPR12MB3190.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpF6HKOMqWNs+OIKqCoHxxpaHnEer3rsdlUWKPHTHceUGzfhO9Z9jrmOSZxHyU0+WbyWy/4CUl1YHcBmPDgch1ZyNsHKai6O0PPUYpLRA8dEGvog+/e/e51e+9W86Oq2lT7Btj31gldtGUQraqKdLeKmCByTvnV8bnO8uD4ufiQnQ2MAsGNvRY5sVKVjOAPx8+K0NoULlBB/plRSRR2Rp81JdC3wpbyZbvBELRcoo1zVqMKBZU3+gUFP1pXdIUvgKmkUtgPha4qnCD3MfDTNJ/qjPwmeW//vbBdwr+QRn65wT7NKeYtay3TZW/bO8r5JshpVIOwfiHA7tcn97JS2/PIszNXtjg+tlcxmsVVXW6vpYLvXD1uxtekl9YNHtDzqVrj6+LxA0bH8auO8QkG5gieAjvAlkA+6pMzhs3Tl8GE/AlaV6ePblx7N4Ywj9poXluXI4XC3nJoEb6qB6U15K8tkK63P0uS+qwWzstxo3W/m4UFy/SLA7hgyDPgBEZmpehu2Avu5As5GE+Cvz5VUHiQoyrZ9pb/ttFxT6q85gfaH8n1RO3zj8TSWMbXEVhnPJAXbpgZKSV9TfqbF/uK1ZZ0xXAr5iI8s4r7V+3hRao13Qz84SPLsIHsgmlULch8kHD/kkcOZqLxa83d0DOcdnBE2xIOvO2sq4sItJb2CUsgYKU90APxHrp5ub2db98huAhZYHykdWbyb0dyJPGGkjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(40460700003)(7696005)(83380400001)(6666004)(1076003)(16526019)(47076005)(336012)(2906002)(8936002)(186003)(426003)(26005)(508600001)(5660300002)(2616005)(86362001)(36860700001)(81166007)(36756003)(54906003)(6916009)(82310400005)(316002)(8676002)(4326008)(70586007)(70206006)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:33.2370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b4acf7-133a-4294-2b3f-08da2d44c056
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3190
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

add power on/off vcn&jpeg callbacks in smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index bb183f4e1623..335bf396423d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -101,6 +101,10 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(GetMinDpmFreq,			PPSMC_MSG_GetMinDpmFreq,               1),
 	MSG_MAP(GetMaxDpmFreq,			PPSMC_MSG_GetMaxDpmFreq,               1),
 	MSG_MAP(GetDpmFreqByIndex,		PPSMC_MSG_GetDpmFreqByIndex,           1),
+	MSG_MAP(PowerUpVcn,				PPSMC_MSG_PowerUpVcn,                  0),
+	MSG_MAP(PowerDownVcn,			PPSMC_MSG_PowerDownVcn,                0),
+	MSG_MAP(PowerUpJpeg,			PPSMC_MSG_PowerUpJpeg,                 0),
+	MSG_MAP(PowerDownJpeg,			PPSMC_MSG_PowerDownJpeg,               0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] = {
@@ -458,6 +462,8 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.system_features_control = smu_v13_0_system_features_control,
 	.set_allowed_mask = smu_v13_0_set_allowed_mask,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
+	.dpm_set_vcn_enable = smu_v13_0_set_vcn_enable,
+	.dpm_set_jpeg_enable = smu_v13_0_set_jpeg_enable,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.35.1

