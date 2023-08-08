Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997B4C001B0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 07:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B60410E39D;
	Tue,  8 Aug 2023 07:52:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89B1710E39D
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 07:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jzb7nZOt+nA+JosL45R9JNvlLuxdFOrJw8aIfHPYalh4MV74EbhfA4FcB8oVCsQzcJUFai3B8Ds7BniPBYtLAKztsAnkIooDrz7CJcj1xewmpNXfWFyHhJwQSu6vRXN4Or3/wxJH6pC7wSvk6YGeUh96QojvG4obxhcHDHDh+y8q18shILT6uxgVa1C+0E4tqx1RuEkypOc9IqEWWY+Rdc49s7tnbmFQyTGRwrP1l0WnMZPY7bcZx/hZt2TVQIO6tJXxXnqW1XCPwCkUMrr6VHeZlpIvzchWlnKfNFXhjHZ87ejnuvZyM8zqvW6HdDe7+qsYLfFyFqtKBnq0A4Y8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/YlYyuLRsuQsU+3RJWDD9s68ER+jAfyKRHWFZT720o=;
 b=eJvGUME6nsWvs3DwwmL/pdjV5tNGBgrVx1dvaS4Do7rBzWz7o2IYQRRIErVJ5fibVpIQm5BLKF6zcb0NVZJ0oCAcMVVY61XR666WDrChJ39PxYKXtlr0CqE04h73e25xmVOuwdkjSE6eDvCgZZ5XmGVBhz1CyNtAwQ7vcbR7E/1d9JNmB8AxjbU48XMsIqytZPXaNgPy5mY+jxGSplThB5qOnWukvCTz0Ty+CjkV4i/FFMrt2KZAzHjdal6dZ1XZF3QWTl91PbYP0I2vPI5hrxZhctm9DXXd+cM5urk7HDhFh6GaSvNCaRW4QzpMacuHiUHHHFHkB5bxO5eyNsd+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/YlYyuLRsuQsU+3RJWDD9s68ER+jAfyKRHWFZT720o=;
 b=018EwrF68djfU+qugsM6DIs6ko6b/wxzZE29xw2gmpt2w7IZon6JsLqauVLhhLGmRbDYeq9rPpoVcQ0nR+4yU7VfMbsBl0RZVA98BrS3GqhzujO4o/2Y0nVjAs6iLY8XdfTSYoVJwznTfwgt0OjakDZnZIiKB5ScDuoLWrPtDh0=
Received: from DM6PR03CA0020.namprd03.prod.outlook.com (2603:10b6:5:40::33) by
 MN2PR12MB4519.namprd12.prod.outlook.com (2603:10b6:208:262::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 07:51:51 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::28) by DM6PR03CA0020.outlook.office365.com
 (2603:10b6:5:40::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 07:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 07:51:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 02:51:53 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via
 Frontend Transport; Tue, 8 Aug 2023 02:51:52 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: disallow the fan setting if there is no fan on
 smu13
Date: Tue, 8 Aug 2023 15:51:50 +0800
Message-ID: <20230808075150.227155-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|MN2PR12MB4519:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af0de13-d568-44b8-3514-08db97e45625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tndWPsw2YvVacUOY7kjI61nO6yPnwcrqYZwvDWMTB75g2BDwt2auPOLg3n2xbZegTH/0kWqpqSkxlqUqHzv6HoBopRHrUZq7vKewqbU3MWK932aGEZ3ryk5qXIacgJYcMEFbiEj2FfwUnmCd/tfTrn1+FmWBGnOjYM8EQatTHBpcN0dUyn6VhYdXF4nPoXNMwU/QPKsQ9P5lUsLbfnXzDt1hGwm5lHtfllHd9+kXZSt+vuHqSwDy4ndNV+wePd5orNEZQSBbLz97jj1iKuDFafCcUeOGzMxapodgs3uJXAh1xGt8u6THjjB+JUjT5ysfA+37rMX4ebcjmJnL8Te9oRbfGPkJZy1X0tv2iXyY0+yuMAoF/iGFoptWEoEwLHX5lG8yA3M91UtZwCTW6CA5UQ5Sxf6wMxUx/MQaBy4AuSBWPitfmomDdiYmHxrpOecOs/AvguASyV8EaB+B60aefqJnWOJbJGRZ0Mnf4lxlBssi0KGkzQOUXl5m8mFbVgF0UErHMmYOQlXsh9S6qR08NxOkOwSStWtfiUEWpeG41JVMnm1fMqcFAETSurog4Ci09UyxhiqoFd/JU6idV/w13yKVxrIfQYWUCUVSLwbqR58siSsBDNoUMxmu7uLnWS0D089qbakKT3oQMxq1hSQY59Y6dwAZDzvJXqXxIZ/Q+3bC7gBkqraOc5iLvMhFdkUMqI6x0zxxjV8u6wexjfgQaG7QKxJJSCCmx+BOdkJkfQHhEEka/YSQhJZq1tbuip7FxNju8bL5R65jSe9pDGWxJNyA3iya3DBL3hBjoG1m9VjBqza+wumy09wvMvNtvPOMI7i5Iwd/wQGtyWxGklK5Pw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(90011799007)(451199021)(82310400008)(90021799007)(1800799003)(186006)(46966006)(40470700004)(36840700001)(44832011)(8676002)(8936002)(5660300002)(6916009)(4326008)(41300700001)(426003)(316002)(47076005)(83380400001)(40480700001)(86362001)(40460700003)(36860700001)(2906002)(7696005)(2616005)(26005)(1076003)(36756003)(336012)(70586007)(70206006)(356005)(81166007)(478600001)(82740400003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 07:51:55.5580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af0de13-d568-44b8-3514-08db97e45625
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4519
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
Cc: Kenneth Feng <kenneth.feng@amd.com>, maisam.arif@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

disallow the fan setting if there is no fan on smu13

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 9b62b45ebb7f..09ef0a7e7679 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1131,7 +1131,9 @@ smu_v13_0_display_clock_voltage_request(struct smu_context *smu,
 
 uint32_t smu_v13_0_get_fan_control_mode(struct smu_context *smu)
 {
-	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT))
+	if (!smu_cmn_feature_is_supported(smu, SMU_FEATURE_FAN_CONTROL_BIT))
+		return AMD_FAN_CTRL_NONE;
+	else if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT))
 		return AMD_FAN_CTRL_MANUAL;
 	else
 		return AMD_FAN_CTRL_AUTO;
@@ -1143,7 +1145,7 @@ smu_v13_0_auto_fan_control(struct smu_context *smu, bool auto_fan_control)
 	int ret = 0;
 
 	if (!smu_cmn_feature_is_supported(smu, SMU_FEATURE_FAN_CONTROL_BIT))
-		return 0;
+		return -EINVAL;
 
 	ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT, auto_fan_control);
 	if (ret)
@@ -1204,7 +1206,8 @@ smu_v13_0_set_fan_control_mode(struct smu_context *smu,
 
 	switch (mode) {
 	case AMD_FAN_CTRL_NONE:
-		ret = smu_v13_0_set_fan_speed_pwm(smu, 255);
+		if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_FAN_CONTROL_BIT))
+			ret = -EINVAL;
 		break;
 	case AMD_FAN_CTRL_MANUAL:
 		ret = smu_v13_0_auto_fan_control(smu, 0);
-- 
2.34.1

