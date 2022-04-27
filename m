Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919B2C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 10:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0644010F00B;
	Wed, 27 Apr 2022 10:27:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B675910F00A
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 10:27:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX/dTJNBV3T/KAmOOr0gpZuC3MPui5Pwcle6zBVYp/ZfPAODlKBrSQhF1buCtFw9AOb+ijdMioMqifACc/CDTtWPtiGuz0MjHHuzhcd+yNHsaCQy2XMHBBz4optN4lM6rM6KsCm0pZD4C82LLL6BRL7OY4iTmBuw2CZi1vApOxAi49SWgxudPeSQlZaOT7ifmBkWfucwlX4N5JohRADTRkE5tyKr2sbOKeHjQ66NEhaVmfOsYiyqcnz2ZC2O3U0wLjUkAeI2wPDeHkT1kSLPb4kkjkx4/K7PF6ITUT5CKeHrNevTEyRMsPUrI85TAEcbDOpzCyC58Te6oJwxiXbCxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quF8php4Jc/3SQ8iGnV9ruMsiv4r9/DtQdA6frmJ88s=;
 b=mi+w2/W8SE5AQSdTYcmxH4IahETq68sV9PENdvf3mh8GY9F7blHUXPduiZlHxS6Jw8yUqGSOyRhuJsqdkhXU4k4RqUREMprMGDZSsKzucucO+7jbWx75k5Bx/VWxG2NvCsyXtqeuW5sgyWyq9SIJfiVI49XuixCWULNlwb0CFlFXQ9MhxosvrcUSECTPjZdvbU+Qx3A8zNjj6XZo619xI4JNxN1ih3/TR4/RmruN0cyZm/psqHi72rePO65C5i8ygdqGdz9xReqNTRm88Az/y5vW1xwAJlwm3DedM7Tgwrlt3rKcKOCZiVPMk5T3jyOOj8sEKkW+oGOQ3M9mFboFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quF8php4Jc/3SQ8iGnV9ruMsiv4r9/DtQdA6frmJ88s=;
 b=FtwHqtdbmzl2eg3RW/Nz2G8wdTcjmCCS3IA+c4GtTUYQzXUG0fuojKHbXeBLOjEKqpRJDdxpsQeNA0yPI/JMeIlK9YUqrTm/x6BtZnf6y4Uso+VoF+JBbS8NbniqHpccMRumed2G+3qYfRmPP2jOrvAWFKFmgYh5VlyiaFVWWD4=
Received: from BN0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:408:e7::30)
 by DM5PR12MB1739.namprd12.prod.outlook.com (2603:10b6:3:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 10:27:20 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::48) by BN0PR03CA0055.outlook.office365.com
 (2603:10b6:408:e7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 27 Apr 2022 10:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 10:27:19 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 05:27:15 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <hawking.zhang@amd.com>, <alexander.deucher@amd.com>, <lijo.lazar@amd.com>,
 <evan.quan@amd.com>
Subject: [PATCH] drm/amdgpu: disable runtime pm on several sienna cichlid
 cards(v2)
Date: Wed, 27 Apr 2022 18:26:59 +0800
Message-ID: <20220427102659.23579-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9f551f7-d59f-4fe0-96e3-08da28388296
X-MS-TrafficTypeDiagnostic: DM5PR12MB1739:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB17393492A9B811B0560D6DCCF1FA9@DM5PR12MB1739.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ukp6cSFHuRggzrxpa4+NFAfmU6e/LVgXYrKpAMl9vyhl133yV1Cuw2wNMU3stoBA0294hDgpagxisUIXla4v6W1v0STNIECC/5tAmK7wsNacV21NgP0A2t+slJ77iY6jAuyhVHjLmgZzzBsP1xXphyYFm1N+W3lZYa0X+IzsokRqgFkFlmCxMIBulNRnNc/5AFt3vjg+ALvt6Uq6qAPHCHn6nDj1DWfiB2HUUdEv83cLz5m35ahYK0aJRbi6i6dCRLvhJSsE/+q+ZZ26Y5jqSBhn/zZjMNyWjDEimlVt1yvbtTICAiumlBJEojOlqkL1aLoFx1e3JMFa2ENlGDIdle9SMwyPMXHx6VNMvj1vAu7QpxwAYHUJkQML2csTkMZywX9bSzVXujT2ilkFUntMB7oynkJ+DwQg9ocgCWG+Di8MbRP+GNT1V/iiuHpUPfZpju2v9xvbkL9yj9W9mmWoXnuFTMMU9meiXcM9Vsd7FPEUG45cVfRdFMpimC7tZcdaD+kXJssxsvdybSGhos6PDOvA2xh7JwOZ+JMjfEU5pnJqbns1b4+xkyCoota1rdA/X6gNZ9VYr+kQH8KFojTGrF6DERWYJnB/vxETuXQC1XEdjtF9mvnaMWfSlg9Axqsb8QJSdfSAkGm6ZoqF+4pAMANNohL94yPDa/zGQOzYyaA4DwTF7kDyqCgx5zrVR/U3/cygQQy6Tq1A1gxFBLWoeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(47076005)(336012)(6666004)(426003)(36756003)(110136005)(82310400005)(316002)(1076003)(186003)(16526019)(2616005)(44832011)(2906002)(356005)(36860700001)(5660300002)(7696005)(508600001)(26005)(8936002)(6636002)(8676002)(40460700003)(86362001)(4326008)(70206006)(70586007)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 10:27:19.9751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f551f7-d59f-4fe0-96e3-08da28388296
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1739
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Disable runtime power management on several sienna cichlid
cards, otherwise SMU will possibly fail to be resumed from
runtime suspend. Will drop this after a clean solution between
kernel driver and SMU FW is available.

amdgpu 0000:63:00.0: amdgpu: GECC is enabled
amdgpu 0000:63:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
amdgpu 0000:63:00.0: amdgpu: SMU is resuming...
amdgpu 0000:63:00.0: amdgpu: SMU: I'm not done with your command: SMN_C2PMSG_66:0x0000000E SMN_C2PMSG_82:0x00000080
amdgpu 0000:63:00.0: amdgpu: Failed to SetDriverDramAddr!
amdgpu 0000:63:00.0: amdgpu: Failed to setup smc hw!
[drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block <smu> failed -62
amdgpu 0000:63:00.0: amdgpu: amdgpu_device_ip_resume failed (-62)

v2: seperate to a function.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 262938f0dfdb..1bf8ff71b6b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -43,6 +43,17 @@
 #include "amdgpu_display.h"
 #include "amdgpu_ras.h"
 
+static void amdgpu_runtime_pm_quirk(struct amdgpu_device *adev)
+{
+	/*
+	 * Add below quirk on several sienna_cichlid cards to disable
+	 * runtime pm to fix EMI failures.
+	 */
+	if (((adev->pdev->device == 0x73A1) && (adev->pdev->revision == 0x00)) ||
+	    ((adev->pdev->device == 0x73BF) && (adev->pdev->revision == 0xCF)))
+		adev->runpm = false;
+}
+
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
 	struct amdgpu_gpu_instance *gpu_instance;
@@ -180,6 +191,9 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		 */
 		if (adev->is_fw_fb)
 			adev->runpm = false;
+
+		amdgpu_runtime_pm_quirk(adev);
+
 		if (adev->runpm)
 			dev_info(adev->dev, "Using BACO for runtime pm\n");
 	}
-- 
2.17.1

