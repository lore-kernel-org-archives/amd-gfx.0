Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AB9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 07:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C87E10E238;
	Tue,  8 Feb 2022 07:44:17 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2069.outbound.protection.outlook.com [40.107.212.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE5FF10E13A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 07:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzaJzuw/RSM96itQHsZOcj9rkwrZsOqDmgzi1vtB0+rKNPINP+GRhzPdCPhmF0i6V6A3qB+xzeO+PhjfolVgUo5h7uA0S5n+rQKw13GBUbNzS3dEX1QYwS5luTUan4eOm+JMH5oHZnUlJ37L8texhTzdBJ5GfzR/Nz/cIC56DIC5afmh77/4/lqppPhBULl/bRjSpTGMw5UifA/ydxU4TNYyTkxSRiQBkPbzOStz26KkVZ+pSM51Ndj4SnSou5bC715V7GmX9DlsNH6IrzaXfClLVMsVViq3T1BE4UXae7RpzxxOYNpfun1VaXAak478FnvH2UtDSqv7TUwCuyZC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o/HhKjQQ7N5HwTp9xIB3vYcehfjqVVyaL7EzMVp6Ns=;
 b=Bsgls86nj1EB6ANPC9kQRvNJxl4RbHjQMmHJjlpW9msRQ/YfnWSAtk9or19uD8+7CHltLsoWs6n5Q1kYPXqNb0Oeuaa06ZHVXEj6ybW2tbivNWpf2YJLwty+cGDeaQ9NEJ4NV/sJITOPMKjmdjKmk8WQ4T2Hkm/z/ewGa9bdJsQRM8p8sX/fADAI1y2iPUUdeEMzleQfe8IrX10riGs7Bnz0macdv+R2fo4bVvIALUgbYpPrkIfY4Ghqmx0bVDSu4rfWnkZvzDB0l+Vy9YjY4lbkB19xSkqhzAd2RSAu/D2FkbF00TFWPN7YgkwW3O0ViKCTcOLglMaH6p1XFk6u5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o/HhKjQQ7N5HwTp9xIB3vYcehfjqVVyaL7EzMVp6Ns=;
 b=a7w2OHSIyNU8rfADHF5pWwjo5bUjr/AuBc6ATvQvwK09sjyuRuveAkatT8naBgzK4+1m/cXA54qFojz1wejpkBNagfj5tRTG1Pv0uQ05c6P6eoIyU9hDFLgBwoIA7LmbG7Yx1ZIXMVEfKAu5UERWwSRJra5iQGseW8/3yMi0gzA=
Received: from BN6PR19CA0108.namprd19.prod.outlook.com (2603:10b6:404:a0::22)
 by BY5PR12MB5528.namprd12.prod.outlook.com (2603:10b6:a03:1c4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Tue, 8 Feb
 2022 07:44:11 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::7d) by BN6PR19CA0108.outlook.office365.com
 (2603:10b6:404:a0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Tue, 8 Feb 2022 07:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 07:44:11 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 01:44:08 -0600
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: correct hwmon power lable name
Date: Tue, 8 Feb 2022 15:43:54 +0800
Message-ID: <20220208074354.379024-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2ab7a76-965d-4d71-9d04-08d9ead6cbcc
X-MS-TrafficTypeDiagnostic: BY5PR12MB5528:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB55281BC18E4F3845D73792CA822D9@BY5PR12MB5528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iWRbREBNKwJoHd5iWcU7txEB7h/l6cRrIjwq9r1OiN1SzfXq4xPiPsN7WhjCFf8IbelXG1QYObXA5pom3RABtfIje6MtxFtt6cY8w0y/wupjB7zg79/RTtGkYN7hXkSQBKq0CZCTmxT2bpmZcKomQ5gOSYGetVioU4csNWVA/XTFOC9YoxZLvUduTo3MkZsDvcB4zAz1gXoZRVDcLk7HTzexjZByjPUhCQ5gmmLkLmeDi4C6tuEyoz+gsuOavdOlw7kIaHJmmRlmGrQwT8Er928KCpAkI/M9yrtk4EF5bNO5c7VuYV7/46v7kbNfY5a+AibsZ/eQim/R4MlXYH+rmEM4z9s24PJ2r0MtcgwnqwG3cMGzroV1N9qkNsebqZRp+OMvsTkpd1bmIPhAhqh//tgNVS+18PqigLRzUP1gtc6/9AGp0pz6TdXZmvxt/gOmibc0AXw08sdrK7Q0HuBwb99sPX/NwwFdaZJmZvtRw8pr2E4XBVvCTWGDnQhQRPiY2yqR7LJV/om1ZKncneGgnfwqqCnlkOGYzP788GMs/06QI2xt8ZFoAE/Xj8f+dQJBfqevJ0Xn18DlKrYMf9kpSk0evOIAmfvfIGcz33/5hkmJ5jK84o+TajEYubsO9+FaOkcWRGJk7CnEmvO4OsLK3LnIA2sRSXpKXrbd6H5czOO6QbOPmMuq5JGFGDvWmP2Y3ou48wv3Ry7UIxf+syZGAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(186003)(7696005)(316002)(336012)(70586007)(82310400004)(6666004)(426003)(40460700003)(47076005)(86362001)(8676002)(36756003)(36860700001)(2616005)(4326008)(54906003)(83380400001)(81166007)(508600001)(8936002)(26005)(16526019)(2906002)(1076003)(6916009)(70206006)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 07:44:11.2096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ab7a76-965d-4d71-9d04-08d9ead6cbcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5528
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
Cc: xiaomeng.hou@amd.com, lijo.lazar@amd.com, Kenneth.feng@amd.com,
 Yang Wang <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

only vangogh has 2 types of hwmon power node: "fastPPT" and "slowPPT",
the other asic only has 1 type of hwmon power node: "PPT".

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 426e00112c91..ad5da252228b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2842,10 +2842,14 @@ static ssize_t amdgpu_hwmon_show_power_label(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	int limit_type = to_sensor_dev_attr(attr)->index;
+	struct amdgpu_device *adev = dev_get_drvdata(dev);
 
-	return sysfs_emit(buf, "%s\n",
-		limit_type == PP_PWR_TYPE_FAST ? "fastPPT" : "slowPPT");
+	if (adev->asic_type == CHIP_VANGOGH)
+		return sysfs_emit(buf, "%s\n",
+				  to_sensor_dev_attr(attr)->index == PP_PWR_TYPE_FAST ?
+				  "fastPPT" : "slowPPT");
+	else
+		return sysfs_emit(buf, "PPT\n");
 }
 
 static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
-- 
2.25.1

