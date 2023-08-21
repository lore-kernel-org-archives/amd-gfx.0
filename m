Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE27EE49A0
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 06:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98BBD10E1BE;
	Mon, 21 Aug 2023 06:06:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E4BB10E1BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 06:06:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xpn72lTxcTuR3nRvE7YGAE0dxUjNOBT0MyKCgHiCjSAKcKyLOHcmSvMFGq3cBduLQZy1LFTKQfKskv3GyygOmTxQo0ZVDQB5nx84VYrvp1JNN/miOi+heeFrpv8qKknFjIBqKaHA3uRnAZFmUJuzaQfyHqgRoj//+SrAoHlPtD5gR42akOAHdwpPi5RzWtXgxqhfsJV8VQAiCWx5aCa4xqdXXvR0SYiybLsRZ6pXofYWEXc0QzlHMIn9D1wawaJ+y3kqwZtyyyGlIABG6TvZW9kGJ47gY5bCOF2pQseEKssNgpXT90Qg696TXjiDHaFylgRdvsNPPsW4SoQfdUz8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sE5xRjdFA34NEQfwKhali7eizF7Nw443JADFBN/LGWQ=;
 b=AoyqLXoG2J1qSKyz7rol5BtRBuUeKKBAnkvOz72H4P1LJDC9LWvzn1qEWq77w1AkgyG2Lw9eKuTwnhb4Jwo9lcraozIYLvXDZXXJCKm132emSKGL4syIQfo6PL2OYEbNGbi7C1S4+L12G6tLjsmjjOuVblrA22oIwiiAezaHfCdyYU+aSxhTT5zn/zlqGYSJOjmRxb2SeXH1i9cgzE6HdPuv19mK1V2U1drahFGKH3SLnWn3HfTr5ikfnvU1FRme+o2C6WnW/VR9FXHADCDXq6DzIu1iGf7h524zh8cShMNPUo3gfcuv5EBh1/CRllMcSlrcsBvjVPXvOHf84SVh+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE5xRjdFA34NEQfwKhali7eizF7Nw443JADFBN/LGWQ=;
 b=GTc0PeCw46PvLzg0j5dIgpGMmEwuD+Mam7XMu1nlbsB8rD9+7twrL1GqF/xipFP3FrPAoqn+9rUYRFjsMh/a2O+F7SqyAb/UxUz6znmgUkyjZUx4zutOLLc+fkOAVy/AJ+WXMj9XkQbM1pkJJap6G5e2SDqyb++7d9mFB6uLXrA=
Received: from CY8PR11CA0011.namprd11.prod.outlook.com (2603:10b6:930:48::16)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 06:06:14 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:48:cafe::aa) by CY8PR11CA0011.outlook.office365.com
 (2603:10b6:930:48::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 06:06:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 06:06:14 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 01:06:11 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/amd/pm: Fixes incorrect type in
 'amdgpu_hwmon_show_power_avg() & _input()'
Date: Mon, 21 Aug 2023 11:35:56 +0530
Message-ID: <20230821060556.937890-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 235ed0fe-19fb-44f9-1810-08dba20cb9b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TsT6iOvBUq5sG4g9n+tsHJa7hFvUiwkDbyw9K/1KDEzWk/z4oVcLHexD08ajD0C/CzstD8kZ6WK5M7i/DcyNMEfL3773haQ4X7q7QrgZy5WMo/T+KzpA6OY5uMUg4+08fm+x5XQmXsD6evEvh9C46aKJmVEQy3kl1x8cRQuSxinzFjxuRX4Wzq651F5e/M5100T6yJGzTtXwoJWHeAgsPuHp2bY3zkT4qzAITMqRozp49mQEy3b1xebp447n7gkQQobgOSsmRwLTex0VIYFPeqIXJi3sW9WNBABxKo2qEGtCk/GYoITLzaAr2UZyyMOOfixrf3fk5Z4inLQgPbn/MdneBexFhqSRRbgQae6WNGF1KFHQxGvUSuTQeIhAstoIYX8q3J002NMgNdweRb6cNp1n6M24UVavrvfsE4rLIKrHJivhRCWMEK+QPPtMjsGrVo3vdl0RLQN3iKA32J64Qxpn+daWXm8g3iKIevOwlHSILI6GKaDbHFhvpA8pkgArNNCVLhVuATQc7+sBBDcAkv/FJgP8soLW2WWha4wKc4WARojskjIq8wQp2PAbwd1zdVjmA5puV1gArs+s9a1syAqI2Om0sriiwee1/6EGD8pzZlLA8uVlpy7iMSv73t8BP5Q+y/0dJZXOap2JOTpVfKr2sTypHB09OphFK+cVnT/rFo+PZav/UTVLAlw+mizgVCMkoqSj9jjNr98gdqxDzMmavHgg7B7GVosYz+titBxgG/bVmfsOFz83P6KWGjIywqtqqEoJfI73/uXdvULD0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(36860700001)(426003)(1076003)(336012)(26005)(6666004)(7696005)(16526019)(47076005)(83380400001)(2616005)(44832011)(8936002)(5660300002)(66574015)(8676002)(4326008)(2906002)(54906003)(478600001)(110136005)(41300700001)(70586007)(316002)(6636002)(70206006)(82740400003)(81166007)(40480700001)(86362001)(36756003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 06:06:14.0817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 235ed0fe-19fb-44f9-1810-08dba20cb9b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The val is defined as unsigned int type, if(val<0) is invalid, hence
modified its type to ssize_t

Fixes the below:

drivers/gpu/drm/amd/pm/amdgpu_pm.c:2800:5-8: WARNING: Unsigned expression compared with zero: val < 0
drivers/gpu/drm/amd/pm/amdgpu_pm.c:2813:5-8: WARNING: Unsigned expression compared with zero: val < 0

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index f03647fa3df6..cdc28e4da0c9 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2794,26 +2794,26 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
-	unsigned int val;
+	ssize_t val;
 
 	val = amdgpu_hwmon_get_power(dev, AMDGPU_PP_SENSOR_GPU_AVG_POWER);
 	if (val < 0)
 		return val;
 
-	return sysfs_emit(buf, "%u\n", val);
+	return sysfs_emit(buf, "%zd\n", val);
 }
 
 static ssize_t amdgpu_hwmon_show_power_input(struct device *dev,
 					     struct device_attribute *attr,
 					     char *buf)
 {
-	unsigned int val;
+	ssize_t val;
 
 	val = amdgpu_hwmon_get_power(dev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER);
 	if (val < 0)
 		return val;
 
-	return sysfs_emit(buf, "%u\n", val);
+	return sysfs_emit(buf, "%zd\n", val);
 }
 
 static ssize_t amdgpu_hwmon_show_power_cap_min(struct device *dev,
-- 
2.25.1

