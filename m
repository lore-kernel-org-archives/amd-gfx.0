Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFE4C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 09:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4416056B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 09:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D4416056B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3486F6E3C6;
	Thu, 12 Aug 2021 09:33:44 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C7FC6E3C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 09:33:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcGluMyAQQt6AhlLAUkHeAqSeCsseLxfzJL32wOUGfVm1Lw+CNrq/VBcTlT5GT2/PgCqfnK5UZ6U+GJyi76QfnT3FOqjygKoPMn9/dkK6mHyMWCu6sCSB1SnkI6PdAfhNAbX/E0FJGozQiE8Uo9o9NzMWoVOwW/0ctI5/X9HqIB4q679uhrvgvierju729x8HlH2CBMyZlO1jiLiY/OLS8l7vdmY87f6JyLJqvVGmI9IWpeoPA25JdxUrsK3zhq9jQ9a8s675bxYScz+4XRjTZppF+NFO8TBocaOAMYIsnAKoZfYPTVguuubWvTA/FVDToIWC4pcQs/33eAIabytAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVA9O0u8YG12noLu2b4xIhModwbhiSEmfPPRrgYQqHs=;
 b=Bn6rZ+81z1lj9bz1eJg4lQJ7nT4OJMrwj0Am8BAashfUU6PbzcWCMRA2UKDxyJ0MA2tj5rZICb95ukRcSJJOTRqrvef1/JvaYaRR1Rz33q6dkCoTte6hDrmXJJgPlzVR2JYAZbLihtfxT02NOJ836AXRah/zWH/tQXado9SvljB3Sf2MS89+sKflTDXCzj2a/CBPMd1+dC38K+1q0wUhfKiArRJ6gpwLBTbcW4AvLc8+fO8Qsv1CmTjgfavFVoFNF+ttRrYBUMkbjHJjXS1CaxSUaxM3BnHAR+eEb/XMdlwsKEZ7qEESrHKyQrAu6SMcoNLx5MZbP2ieRN+/9A6wuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVA9O0u8YG12noLu2b4xIhModwbhiSEmfPPRrgYQqHs=;
 b=U6gimEdOEWYJ+mD7DpEtuonbjxITXcxHNdOEtoDB+CcjgX3FhWkCvUIodwZ+54cvMV8sUZxbsW2Ap9kMK9sxroNW/QQnhM58pYdcw/zzfBUfY+gGE+hvkifNmasauhQJYEzVQk7WOFz40xFGawwfOEVsDKXj+02HCdJ/iI0RjRM=
Received: from MWHPR02CA0021.namprd02.prod.outlook.com (2603:10b6:300:4b::31)
 by SN1PR12MB2526.namprd12.prod.outlook.com (2603:10b6:802:2a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Thu, 12 Aug
 2021 09:33:39 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::7d) by MWHPR02CA0021.outlook.office365.com
 (2603:10b6:300:4b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Thu, 12 Aug 2021 09:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Thu, 12 Aug 2021 09:33:39 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 12 Aug
 2021 04:33:36 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <nils.wallmenius@gmail.com>, <Lijo.Lazar@amd.com>, <Guchun.Chen@amd.com>, 
 Evan Quan <evan.quan@amd.com>
Subject: [PATCH V3 6/7] drm/amd/pm: drop unnecessary manual mode check
Date: Thu, 12 Aug 2021 17:33:07 +0800
Message-ID: <20210812093308.1322342-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210812093308.1322342-1-evan.quan@amd.com>
References: <20210812093308.1322342-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb1bc4d6-7b9a-469d-adde-08d95d74444e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2526:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2526CE3A87D973CC9BD60376E4F99@SN1PR12MB2526.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qiBmu4dp9nnRtWtQESijQi/2qlEgSJAa4K9TDxQjz5Un0qPNUOpZb0PpSMU72xVa8vsVs8KC/b0JKNbU2o9KwEGBvIdxTKs0WcRgFWX4AQjAl19RXhf1d/1Qnuhud5PEZRCysaFyJWz1yM08ZxybFvbelFY9Lx7K8gipc81iAb1iKqXEPRwWTIXLbYhwxRyND87kYcrQLIwyvOB0ke0vrT8229bFMxo/GsX2NDzSMzCX5NOI3Aj/BUsoukdrncMf7hya0XVsA28Gn6Kt5ns8jjxxLGxsGFJOEg/6mMdL0zP6FpqvrGTBA7gTAjk3vOpk3y2FkaWsPH+/d4WARUV5aZLsKLPi3Jxvk6injssedeGXC96RBgp8dYKvG4ebspBZmWZfjvjnSU0WJht2ujPY8I8XVm5Oj+9O5buzBBqIyxC0wrF5lZ/VdhepCPH+3tqX7d3g+D6qStK5tV+uwr9CBLfNTYvMXogvAC0fbta/8zkIUiokvR5MaeQKVC5ERqcox5uXklmjuG/fqOHn2SYx6yjjrL5JUZJ0m6t/PtEEWeLRJLMVqtkSUZW3GLXXFF23GLg7vTcPz880999wd/lR6TVmX+ZmRlUTlq7ivnBJJEesYW23tL1k3O3gxKkehqMR2DtkkuIr1FsJIEd+6+7FEJU3NzSVNMY+U1z+PhjAINPepyTMHZhu2LhNNeBeP0xt1o2sgC7DvcWf1X+BIfFKu82T6ufTFJvBxidK+avJt0T7dYHZBLUuVnYlB5aOko+tSzDjTbgjX57x1/r3hSEqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(5660300002)(47076005)(70206006)(4326008)(44832011)(70586007)(6666004)(1076003)(2616005)(54906003)(7696005)(8936002)(426003)(86362001)(36756003)(508600001)(2906002)(6916009)(8676002)(81166007)(356005)(83380400001)(82310400003)(186003)(36860700001)(16526019)(316002)(336012)(34020700004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 09:33:39.1673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1bc4d6-7b9a-469d-adde-08d95d74444e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2526
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As the fan control was guarded under manual mode before fan speed
RPM/PWM setting. Thus the extra check is totally redundant.

Change-Id: Ia9d776141ec4aa39255accbf00d7e7ed81c8424d
Signed-off-by: Evan Quan <evan.quan@amd.com>
--
v1->v2:
  - switch auto fan control off for AMD_FAN_CTRL_NONE mode (Lijo)
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 9001952442ba..01b9653c39c7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1208,9 +1208,6 @@ smu_v11_0_set_fan_speed_pwm(struct smu_context *smu, uint32_t speed)
 
 	speed = MIN(speed, 255);
 
-	if (smu_v11_0_auto_fan_control(smu, 0))
-		return -EINVAL;
-
 	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
 				CG_FDO_CTRL1, FMAX_DUTY100);
 	if (!duty100)
@@ -1237,11 +1234,6 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 	 */
 	uint32_t crystal_clock_freq = 2500;
 	uint32_t tach_period;
-	int ret;
-
-	ret = smu_v11_0_auto_fan_control(smu, 0);
-	if (ret)
-		return ret;
 
 	/*
 	 * To prevent from possible overheat, some ASICs may have requirement
@@ -1257,9 +1249,7 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 				   CG_TACH_CTRL, TARGET_PERIOD,
 				   tach_period));
 
-	ret = smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC_RPM);
-
-	return ret;
+	return smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC_RPM);
 }
 
 int smu_v11_0_get_fan_speed_pwm(struct smu_context *smu,
@@ -1330,7 +1320,9 @@ smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 
 	switch (mode) {
 	case AMD_FAN_CTRL_NONE:
-		ret = smu_v11_0_set_fan_speed_pwm(smu, 255);
+		ret = smu_v11_0_auto_fan_control(smu, 0);
+		if (!ret)
+			ret = smu_v11_0_set_fan_speed_pwm(smu, 255);
 		break;
 	case AMD_FAN_CTRL_MANUAL:
 		ret = smu_v11_0_auto_fan_control(smu, 0);
-- 
2.29.0

