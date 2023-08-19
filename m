Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495C2EE49A7
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Aug 2023 06:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A52D610E00A;
	Sat, 19 Aug 2023 06:41:09 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8BFA10E00A
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Aug 2023 06:41:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVYeQ9Mh4bq0wz1I4FKYfPyfFt6+aSeKGYL+1RdkX+JpEOhaN2JhlEL0V/nzmWEqUInTUcD1+fqsJE4X1HXVq/BZXxmfzxBwnzq0H0Dq98KRDK1GKbV75q9qmkpKo+7LCLifIfnjhhLAVcIsaoh92SC05bBpIEZLga+RmNy4oN8i+qBKjT3fXprAoW9nbuOF1mcpvjVvQBm9tRjiYN6Y2kObquaEjCADIFV3UtuSEdvg49lxuu+eRdG4nQO2utHK/Cvp5B4hIaru4xZQ89SbYYIuSKW044t8P8zwxqdM051rUVIEpxnoxBlTvOz2eWZCuLtm6SOSLaXHG5+nSt4PRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoyaxYmoota4O69xEvszHiwWByxYeLCAEJmXdHzcw0Y=;
 b=ZE8ebeDDGwU5xRhC6TizpwKTOQoM0+lJe5ING5g7vPzgUq5dXhcQhqHGxXlL8uCoO8Z7cJ84X0mJhL/u9//cCA/eLli5gClMBqjfqy+sw9A50v/C8MJ/CN6f4eXAfyFcHVnteUgT4vFJhaPHERQg/96VOPePIL3i0tfqHmjY5oJkso6v/9tb+jCDnqsiWaEklQ8DeNW5yYc/ECw5EKKtCBbLyuP6rbW0LAykgFP5H/Nkv+dUpGYaRMC5oGhgX/+uTv03K3JOMKbNC8SACLSmLqE/LDsciWTihMFr+qzcvg5zuwpNYYtEAwOPgND/SqSg45ow80S68gbURPt2psDC4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoyaxYmoota4O69xEvszHiwWByxYeLCAEJmXdHzcw0Y=;
 b=LYYZZbHlON9OeQHm6RPzhtkzzlQvJM2feIcF7cWsFalTDL8MnseKED5ME84gdxTkOLomSZlpCbbboUwWr6oFSjA4Ih5NAXVj3Ikp0yrl7NQ1wgFjFUf6yfkpz7tZ+O1UB5V0GqZgOD+5ns/r4/0lW/ptvqXAJWccvJ48xmJNMDU=
Received: from BY5PR16CA0036.namprd16.prod.outlook.com (2603:10b6:a03:1a0::49)
 by CO6PR12MB5412.namprd12.prod.outlook.com (2603:10b6:5:35e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sat, 19 Aug
 2023 06:41:02 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::49) by BY5PR16CA0036.outlook.office365.com
 (2603:10b6:a03:1a0::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Sat, 19 Aug 2023 06:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Sat, 19 Aug 2023 06:41:01 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 19 Aug
 2023 01:41:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 23:41:00 -0700
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.27 via Frontend Transport; Sat, 19 Aug 2023 01:40:58
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the return for gpu mode1_reset
Date: Sat, 19 Aug 2023 14:40:51 +0800
Message-ID: <20230819064051.27866-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CO6PR12MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a44e5a-f114-42e9-1376-08dba07f40f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ikg61oA7OcyIxtjI0Ewe2EmKbn1dKx2MX05dFlkkY25qmkRXQyIcw98QVMvxro9+jrlmr0Er0aeYBHoFTyHH8y2R8pjnzH1+WjmqB7fJf86vZZzaICCiyPrZHcL+WDh699bnmUMRf9qsTbyMtL9gayupObKeSnV2TkDhB5pW/QF7lW0AmIjgS8tXguehu2oJCCzc8S4VWzxnLlUGolcBJ/oPImIJitx3DVbmUCxZZtRfRoJL2T+Qle/PAWg/z6GP1mcCP/mWSKVArHHgEUZE64wvT2fG5Hz2jynkwUo2j34i8csvo4HgPr3u7Pzv+MCBPF/aUfrpEYAlYdAzktoMQrJ299MSs1xrCwlcHXGXT2oXTA+h63LAtLErqu6WJqD4XxDX4aBu2+PJhh+iIK6IGQk7D67LUZHnKiRexUiMeNbT48/UCvetbMB6ks4FN5BZFA7p+BXXUsJulLMq07NCAl/EVM5yJHLWXMnLzXNULdIbj1DXyWyNWtb0WxBTCbvwOBqUxhotpUeCA0WsiVTiwaC2aL0801c6YOzrOhZVXzgpUQFj+ibo9KfrzOzWCBrYpo5UzbdvZSGKirDbWieDUDr7xVb195Jr7nQTc0N2ndiYhjm04MSsLl9UmUPERA3QgbbdRwbm5kmYr2lvXqNHp8mIJAQUBQp07/wF2M5y6nn7QTUGlYMR0h1RZa7oqF6+VbL2BdwQTW1HkYk6x9XCdK8h1uQomkjK4KZKPKQOhqu3Kmm9S4+6q9USscM6stHzOisv6NHuHZOz8seQvrENBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(36840700001)(46966006)(356005)(40460700003)(2616005)(1076003)(426003)(336012)(6666004)(26005)(47076005)(7696005)(36860700001)(4326008)(83380400001)(8936002)(5660300002)(8676002)(2906002)(70586007)(70206006)(478600001)(41300700001)(110136005)(316002)(6636002)(82740400003)(36756003)(40480700001)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2023 06:41:01.2850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a44e5a-f114-42e9-1376-08dba07f40f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5412
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_device_mode1_reset will return gpu mode1_reset
succeed (ret = 0) as long as wait_for_bootloader call
succeed, regardless of the status reported by smu or
psp firmware. This results to driver continue executing
recovery even smu or psp fail to perform mode1 reset.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5586146b8c76..533daba2accb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4701,12 +4701,12 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 	}
 
 	if (ret)
-		dev_err(adev->dev, "GPU mode1 reset failed\n");
+		goto mode1_reset_failed;
 
 	amdgpu_device_load_pci_state(adev->pdev);
 	ret = amdgpu_psp_wait_for_bootloader(adev);
 	if (ret)
-		return ret;
+		goto mode1_reset_failed;
 
 	/* wait for asic to come out of reset */
 	for (i = 0; i < adev->usec_timeout; i++) {
@@ -4717,8 +4717,17 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 		udelay(1);
 	}
 
+	if (i >= adev->usec_timeout) {
+		ret = -ETIMEDOUT;
+		goto mode1_reset_failed;
+	}
+
 	amdgpu_atombios_scratch_regs_engine_hung(adev, false);
 
+	return 0;
+
+mode1_reset_failed:
+	dev_err(adev->dev, "GPU mode1 reset failed\n");
 	return ret;
 }
 
-- 
2.17.1

