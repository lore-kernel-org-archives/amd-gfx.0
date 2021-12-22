Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF67BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Dec 2021 15:55:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06A1F10E1CB;
	Wed, 22 Dec 2021 15:55:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF70810E1CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 15:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/5f6paqeGr+WF1LUiK3TeSoO5LWaP9drziKTKV+jIydJwjH2noSyMDGnRj2+VhZ05G2pHMybzD1gzT+1Dyk1TWIHQhsR4q8XZ9VSXKmDWByMzCTpK6HDrWj9QJb+woaYERBu/WxbFvjxtkYOXMVxRLhF/NWEDFhVo31EA8lkr9UHA1kpRkDzK/Ig2aCyNqZ+bPwXFkYsl2s5XZNAV1TR0QQLup39wEkoHQ48b/RbqRHsyL0FM9Kh5IP6fjdeJfBtZ4MuRbTpDVjPW8awTGRpa7zVIYeICVs/r1K54hZV0vc8gzj2/Ho6JaQq8mTDnMNFlJebhNFbje9/8DeiqBgCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EENaMN0kjU79d1WcpPJv0p+g/7JLD4ADREhz3WyMtXU=;
 b=baq3mmblSOV6mQEb6NjDG62QDuqftE/Z5FUJgE32YQXPRM3sHAxIo9maDPsazBfaalci9WxdBw3t5egEQgI+6/SC/xsW9YdFAvvdMt6qX3Rp4hZ7wGPQGX0YoOk9YySo2igzupkyAk24yxAzq5aTknBMW946qWVUc8G3QETS93rftzWkUwaOFyM2rvZGUQN3/iJGm32z8JWbuYP5jHeScP1Jqjcca2m6KR467o9pV8v22ieNXPQUdKDNxIIAplplBJUaMSCso/UIkZnUUabmhvqeSbn13HtHo0AjQ5YIOvnSazpjnPttcH7IOsMbTLIFHfHXqO63VkjMR9EOSVwSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EENaMN0kjU79d1WcpPJv0p+g/7JLD4ADREhz3WyMtXU=;
 b=zP2DxAhR8VkABF9fCOyOH3h3DLjnlAmjNp8U9uZUZT+mVcfElR/e/AlZXzS38YAkSd6bHLZm9tnAFNL1d7yKh+hp09AQYdfGCZdR2/af+UYSapPNdZk4XEzQZoU6dSP0/0Hj9l6q4/vkH/iwzCszdVUxytU1bEdJ2L8voz2S7G4=
Received: from DM5PR07CA0039.namprd07.prod.outlook.com (2603:10b6:3:16::25) by
 CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.17; Wed, 22 Dec 2021 15:55:13 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::bc) by DM5PR07CA0039.outlook.office365.com
 (2603:10b6:3:16::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Wed, 22 Dec 2021 15:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Wed, 22 Dec 2021 15:55:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 22 Dec
 2021 09:55:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable hotplug events on runtime pm resume
Date: Wed, 22 Dec 2021 10:55:00 -0500
Message-ID: <20211222155500.838756-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89f28344-a5a1-4d5e-305a-08d9c5637112
X-MS-TrafficTypeDiagnostic: CH0PR12MB5346:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5346C702B6F49FBE0BCB38A8F77D9@CH0PR12MB5346.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SBf8Isn8m3GNWHPJX8HcsAUpuwQCIrRxbG6aoxaTkrN9zcmmECJJzeoPvBDffOfLI1Fos2FR4ajk9Ba85lUs7riyBmr6DBW58RfP2KncKxFByMdOEKwMlUXTQD4y/p6/EZURfgArOZ2/PhR3Io1v1MFeEgZZT1h32GTBRSIpHxlvBV36ZddVVPCI9JrW1zXdciaOP4quY5pXyDiJ3tnv0s9CT3p96DOVfF+d9ZcCfQV7Z9TiPq3G26ZdvTtlQ5x7sDWI2+HkBQKVlJSTAtZloZvE4dNahVaTU3O/YJR4VqD+EhpM/3JA/UMoGSkxlOQqTzVmfwcLXquDLtVXCoQZ8hL04SlRfOGjaiIeQaPznIN7V0JSCfotSlYN9/fiH6TGYSqKPKXXF7GZ/5nGxc4Erc/trE1Dsq3fh82I7BfzqfgaO/w8vntlrTWyVV9uEBzNgiaOnKVVjn3qH7De8KFymiDwN21tUpRmqeVsdkKuFJRdZnY0EPn6BVe+DxaSz/KjoVvCpNb6jhAon3cA4jdSn4zFe6+unLxx4rqvnJ2j3FaCot26CyHHnZ0R9XJtQ3WUfy8+Q0Ba1oN++GpaAcH3ZbQVpS+38o/t4ZON53F/g7QSp7NgWlxmgKZCFW1CAD0F07T6nhvDepNCeilFJQ6FcaAyWsMvCDmZC7kshTO3txSlLoeJ4NFCaYlLSEZS1Oqn6Vx55atFw9w70p33zHPR5S2BuopqJ4ZJApSiTFUwMYZLS+9vnT7iiZicsBCI2GKFq92j/EMHzInxe8Z84cLwRtFvW56v7tTrlOjcHJRr22Y6FEF+0cm66PQIS6fJfSqxTuAV20B9bMSO5Ysl+zeGiDZZAXE461diUGs8TP3eUzzn1deeYNNFOYfLqVMoMdZd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(356005)(36860700001)(47076005)(40460700001)(82310400004)(6666004)(83380400001)(186003)(16526019)(70586007)(26005)(36756003)(7696005)(70206006)(336012)(1076003)(86362001)(426003)(316002)(81166007)(508600001)(966005)(8676002)(6916009)(8936002)(2906002)(5660300002)(4326008)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 15:55:13.8150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f28344-a5a1-4d5e-305a-08d9c5637112
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5346
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When runtime pm kicks in and the device goes into runtime
suspend, we often see random calls (small rendering calls,
etc.) into the driver which cause the device to runtime
resume.  On resume we issue a hotplug event in case any
displays were changed during suspend, however, these events
cause the compositor to probe the displays and power then
back up leading to the user seeing the displays go off
followed by them coming back on again.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1840
Bug: https://bugzilla.kernel.org/show_bug.cgi?id=215203
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 +++++++++++++---------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 00b29ff414de..0970105ed03c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4070,25 +4070,33 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 
 	amdgpu_ras_resume(adev);
 
-	/*
-	 * Most of the connector probing functions try to acquire runtime pm
-	 * refs to ensure that the GPU is powered on when connector polling is
-	 * performed. Since we're calling this from a runtime PM callback,
-	 * trying to acquire rpm refs will cause us to deadlock.
-	 *
-	 * Since we're guaranteed to be holding the rpm lock, it's safe to
-	 * temporarily disable the rpm helpers so this doesn't deadlock us.
+	/* Skip hotplug events in runtime pm.  Otherwise, we end up having the GPU
+	 * woken up periodically for random things which causes a hotplug event
+	 * that the desktop compostior to reacts to and re-enables the
+	 * displays.  This leads to displays turning back on soon after they go to
+	 * sleep in some cases if runtime pm kicks in.
 	 */
+	if (!adev->in_runpm) {
+		/*
+		 * Most of the connector probing functions try to acquire runtime pm
+		 * refs to ensure that the GPU is powered on when connector polling is
+		 * performed. Since we're calling this from a runtime PM callback,
+		 * trying to acquire rpm refs will cause us to deadlock.
+		 *
+		 * Since we're guaranteed to be holding the rpm lock, it's safe to
+		 * temporarily disable the rpm helpers so this doesn't deadlock us.
+		 */
 #ifdef CONFIG_PM
-	dev->dev->power.disable_depth++;
+		dev->dev->power.disable_depth++;
 #endif
-	if (!amdgpu_device_has_dc_support(adev))
-		drm_helper_hpd_irq_event(dev);
-	else
-		drm_kms_helper_hotplug_event(dev);
+		if (!amdgpu_device_has_dc_support(adev))
+			drm_helper_hpd_irq_event(dev);
+		else
+			drm_kms_helper_hotplug_event(dev);
 #ifdef CONFIG_PM
-	dev->dev->power.disable_depth--;
+		dev->dev->power.disable_depth--;
 #endif
+	}
 	adev->in_suspend = false;
 
 	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D0))
-- 
2.33.1

