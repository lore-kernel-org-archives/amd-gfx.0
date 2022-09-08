Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433CAECAAD5
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 08:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C29F810E9AB;
	Thu,  8 Sep 2022 08:44:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDED410E9A6
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 08:43:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mn2eKKHwlcrElQ+06gTfQ8VkOIG1ZYMVlHDj7d5N9xQWJO9ujEa/YiNSb0Uv3UY6bcBkG3ZAlVCA9+/qtmP9R9CRfv6mXjiBLnQenA5iIy2lEdwZ+Vd0pvrRZWqpa5OdyP7nvE1NGAOlVV+3x1mQ9zuaYeidUsU/qe1Hew3oy9oNlEVkAdVLMsw2C9d8Dqn3hDOmND1vm7brA8nYc7UCPi5vkNYdICxqpO+GY2ZkJ2vA9KTbHqBanJyrDy869SRnOJ2tuJdtk/h8ava3pX1qd+jEeahHgHxIbl3qyIMUEJXgTEuCm+I8VfsX+R43pPevqucllpHrOth4qM48Obu8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rXvNlHLJDblacYk7N69WHWN07h7cXVvewvi2VGT+DY=;
 b=OQL1gKFjmxolwEeQKFM2aqDdIBOuWF7fByPFmWA/pYSHK3j9qhtORzZtgaAqmyefDx0oBWA5eV0LwdffAzRKhwwRBs3Ba+8dsg7U9ehPrLC6VmtKdO2MZhH1iZZuKlNHfvyQdNaOGNqxkFjvnqwhns5fYqXYcrCJCT6onmABIKBXIF7+w7cz/ly+/CeNvNlxgB02UGi2Kadm4DH4pNDtmLlkzyi/W3CnGUqMadZRH8RGrm5mvVt+jjHCLfhjUxNoNdlFOujd3Ymbk47SyitAUPnSAfUioFzpYI+sHkAzCvqL3d/pdeUw/EYLG2FJvtEAY7Cs8ToJkg3fXDwjM5MOUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rXvNlHLJDblacYk7N69WHWN07h7cXVvewvi2VGT+DY=;
 b=JdEehdd+ah/hDMxbrJbA8ixAzNpyFKIZsbBqOVIMdUBiISskaMujQW6Ujb2rzQl9jMeL0arUu6sLH7A6qmEE69Aqz9AvhK+V7pOAgn/npMHvlIKjDXy5KFyucpyYbnQWvTbv19yidrJtmDH6yjBq70f4V2UjDmdHlgMclnlZ1oI=
Received: from BN9PR03CA0375.namprd03.prod.outlook.com (2603:10b6:408:f7::20)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 08:43:54 +0000
Received: from BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::43) by BN9PR03CA0375.outlook.office365.com
 (2603:10b6:408:f7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Thu, 8 Sep 2022 08:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT090.mail.protection.outlook.com (10.13.177.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 08:43:54 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 8 Sep
 2022 03:43:52 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 3/3] drm/amd/pm: Remove redundant check condition
Date: Thu, 8 Sep 2022 16:42:36 +0800
Message-ID: <20220908084236.110566-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908084236.110566-1-YiPeng.Chai@amd.com>
References: <20220908084236.110566-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT090:EE_|BL1PR12MB5301:EE_
X-MS-Office365-Filtering-Correlation-Id: af802a7d-16ef-417b-ec09-08da91764346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZrIknEJ9+BoM1g3Ux28ZqKztqFbThLNOpiCsJmTW3expv5qED7hYqmHkIjgbTZ15kRSKomTmJo+m9fhyqcpwUgFGCVJ87tAFEI9s5bDd16FabCxhe3pzDNluWzrIegO+mK7jcaPkA0IreB2FYo64seA1vRXPW72JRRl14N4PitldMYPzoZ+RXeaQFHpJHFRNAcKhgI8v9z6s6hXaag9yfCZacXEUgP6NjxotDfSXSywptxLDqPD/qNgpfGCHnpQzuh85sijDiBBZOYqz/iEM4Q1llC0i3ZlwgTvouX3QEe4u+8W82MfNJmLIWzfIEydirtXR2W2kdmak6KUBTNQSo26AbjbIjSv4FTMB2HmQw0R5BKBVBFeJWMMdlS93c/LdtvjFvGJ2pyxVm5j7amJBa+xz6V2766/2PY7KSwItZMr/A4HuM9AoNXW5tGcx+E4n/caZOfdLxKbY6YOtRkFjCaXFGcW5S1XWR3ywV6JanRvEJ0cp3i3M3V3rNscQNV4O+t8yLCQ4KW/CFexm4YXjgWSwoIoyOlBRBJOEO/DrHQiB6Bn2MGWwNyh3UYkLOhrGsKaU+/lXNDRjSySqDIS0G7Ve5DiaXOzXQ/NTsHwcLcULfLnN55KhmLp5ErW5JvtKn68MY57J2ZYuEkdnfEXFPiZxLUZUDBzYjSzna175k96aBPMGew6L0weGMh7LX40lPaBxyngG/wCwJNIkAK0i+KOtwOjVebYRg1Es8TEzAlfJkF9iWhZqWrf9v/N4q0piF8IJQRSl8rrAsQVVqWqPsfQ0SJbZUCQddSEWqL50Tw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(36840700001)(40470700004)(46966006)(86362001)(6666004)(356005)(47076005)(82310400005)(426003)(316002)(54906003)(6916009)(186003)(478600001)(336012)(7696005)(41300700001)(26005)(81166007)(16526019)(2616005)(1076003)(2906002)(4744005)(40460700003)(36860700001)(8936002)(40480700001)(36756003)(70206006)(70586007)(5660300002)(82740400003)(4326008)(8676002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 08:43:54.6455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af802a7d-16ef-417b-ec09-08da91764346
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>,
 KevinYang.Wang@amd.com, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V3:
[Why]:
  Since ASICs using smu v13_0_2 have called smu
.suspend before calling amdgpu_pm_sysfs_fini,
pm.dpm_enabled was already set to 0 when smu
.suspend was called. This makes it impossible
to delete all pm sys nodes.

[How]:
  Since all functions in amdgpu_pm_sysfs_fini
have their own condition checks, so the first
conditional check in amdgpu_pm_sysfs_fini can
be removed.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5e318b3f6c0f..948cc75376f8 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3405,9 +3405,6 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 
 void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 {
-	if (adev->pm.dpm_enabled == 0)
-		return;
-
 	if (adev->pm.int_hwmon_dev)
 		hwmon_device_unregister(adev->pm.int_hwmon_dev);
 
-- 
2.25.1

