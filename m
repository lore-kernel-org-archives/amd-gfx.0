Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B46C07E9D
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 07:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39ECB10E9D6;
	Thu, 29 Sep 2022 07:50:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5043C10E9D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 07:50:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaVet3lnAToqY9MSV5WtY/DJyVU6sKa1/l7R24k2IP2zJgMERzIDKhTwZSjhwJu+9W9FcwDEKyCHp6GeVmZcs6ProH9kI0Neyrk7BJwjkInu2HCl3RMOwUtIGr0r72HxQ6Ziixf2HBypxozrd3OMDH3Oj9wXQULs0PpRajalbvpkDW7Fk5APWwFQcw592Dlk4yuUMg9Ht0gnu5Om91WYv9eNJath+ag5rk7Nc0KRdE8KagG5L8vWx7KbjCOmQiY41Ale+xgUP+N4o/Ad9shJvbeG2+yQReV7bIhC01O7w9AeXJKgZkRGng07+voI6WuitkvwlwSwsO1eOo+krH9pBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydR8bK/fIUawr3sBjitRiDAZpGaU3KniWkDKk5iX35Q=;
 b=F4UA3JQyMIEg5YZKBHFlpKWsV1f+NMs1qIe7tSqzzPHb8u9miKygdqIrG2WLIY5Y90S5EDhecbotqFSXEembejerfQC7jUbype0jV6qPRpflus//Tfc44K1F1bAiRlFPcH5nhuUm0AKn/n73e5+9LVVpRu3gsv5uIHvBYX6Xqi1IV0tL9kYL9f/JHI4l+y6zvZJN20eHMLvaRMFpYbsx4FphOPUv1pZUT3jHIVOcYJe4QMhjt/UkMKeZ56eXDiFgvbJwtWFH57tPG09ytNOFKS5kiOCmEoydk7h6+ipNY37nY9zxoo1WbwH/MIdlgGkhcc8iwPR/ANLT5gEjkia/uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydR8bK/fIUawr3sBjitRiDAZpGaU3KniWkDKk5iX35Q=;
 b=pp7/xWmKglmpelwOuLrPX+htArtArNnS2EgTFuI4U5UULe2Ka0KKJoFmpMVyG1turgF8huCpK/6WlwxIWQe6DP2MRIChJ1SvLJrqTK6Wdi3o1PMfv/VfT3vSbstKg13bjijRN5vBje+JpZ37MvEjaufUu6a3hXPnOK0GZ9uMl1Q=
Received: from BN0PR10CA0014.namprd10.prod.outlook.com (2603:10b6:408:143::12)
 by DM8PR12MB5446.namprd12.prod.outlook.com (2603:10b6:8:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Thu, 29 Sep
 2022 07:50:31 +0000
Received: from BL02EPF0000C406.namprd05.prod.outlook.com
 (2603:10b6:408:143:cafe::1a) by BN0PR10CA0014.outlook.office365.com
 (2603:10b6:408:143::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Thu, 29 Sep 2022 07:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C406.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.13 via Frontend Transport; Thu, 29 Sep 2022 07:50:31 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 29 Sep
 2022 02:50:06 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: correct the memcpy size for ip discovery firmware
Date: Thu, 29 Sep 2022 15:49:32 +0800
Message-ID: <20220929074932.10114-1-le.ma@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C406:EE_|DM8PR12MB5446:EE_
X-MS-Office365-Filtering-Correlation-Id: 371ab705-a279-4054-c9c1-08daa1ef4893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5vF0b55NU+LrGtT1mcjuulYLoLZmyxwoFylaIjOehpG6ySk3LyK60D1LTXN1wm9pxuezNCUIQWO1AnAL/yES8QZVVmRtxsnoyLtzOlk9Tzz8iPqI9gndhaZFGUVtmgCgykHFo6ZQuq+rGhiJdIsugbErMhm0q8JlYkvh1KsBB6r1B1qgFxiIy7kb2Q6qecBwKciSEVYXJUXuUuCjq0PHyLfAQuEDN+gfiPMqyVj/4sMgiiLyw2ZfPxAL/W1YyPO3PfcSJLOMvJha07xv++rufAXZh34o2+piATzlQacbRjqa0gYaHia6ffcMmJyJm7E1I6tzkEDgsPFR5cliToWvylTdogOUAzLeKocNLGfxzS/pLKKm1pEymnzsqY0x1kobHRVP+s95gwuAk5OMN37oG5HlFZdZbRXq2/s0/E32rNWMM2rjQB3chOfkdQK8UzsjLUVTj2Lec74dJWi1N3CyPn4Z3iFThdrY0b30DrAdOVapXsuN0yGOXKPTupK+MCqBroSmthKa9BP87fb1Z/4KNQeLjcqj+zNZ8oWTEwzYcthK0H8JQEFM2XDC79kUC0LBDNOovkB3YPivazehcT8LxNk978lXCIgcZCpx3BIEXO/ewS2PrwJ+whQ5o9idv5Cv6aYpReendkT03LwaM53SbhkGysQx0HtZVnEo/t6xZFhR2ak44vlMrgtcCi+fZy2M8OaMUM5xRg02gbc0YVAOLqL72UStS4LA1RMaAjYQ7eWIpGUSfWQ9L8BkeIoCruFDAsjeP17TxR/8HcXryfSuo2+KfgURkB/KEbhWOtYeG1CQX3pHp/KF/CvThGo/IPoP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(356005)(82310400005)(478600001)(86362001)(7696005)(40460700003)(41300700001)(8936002)(316002)(6666004)(6916009)(2906002)(336012)(36860700001)(81166007)(47076005)(83380400001)(426003)(26005)(8676002)(5660300002)(16526019)(4744005)(44832011)(1076003)(2616005)(186003)(82740400003)(4326008)(36756003)(66574015)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 07:50:31.2621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 371ab705-a279-4054-c9c1-08daa1ef4893
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C406.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5446
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
Cc: Le Ma <le.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use fw->size instead of discovery_tmr_size for fallback path.

Change-Id: I61f1ec55314ea5948ed3ef821becfdd63d876272
Signed-off-by: Le Ma <le.ma@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 309d35026222..0b4f4d2f8d32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -234,7 +234,7 @@ static int amdgpu_discovery_read_binary_from_file(struct amdgpu_device *adev, ui
 		return r;
 	}
 
-	memcpy((u8 *)binary, (u8 *)fw->data, adev->mman.discovery_tmr_size);
+	memcpy((u8 *)binary, (u8 *)fw->data, fw->size);
 	release_firmware(fw);
 
 	return 0;
-- 
2.17.1

