Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC387C636D4
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Feb 2023 21:10:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE1F10E299;
	Mon, 13 Feb 2023 21:10:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAA3210E742
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Feb 2023 21:10:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNHo8AfSS3/zGx8x0jFbykW0H/I+CB/CPFkkwHm79dzsHrZIm4jvQQsKvWaXmjMFCXsw0jzyu/HYufqsIEuy1CCrDh4grZnWAloqVr6hgdtLev3dOIgl4k/ayBf177d4plxw4MAVPFEgVZHgW5ogDd7O+5JK8fE8hLcXaVRRfDSyIUyp8qvElBxuAgwA5zN7zs+xVhdda0jAlDW5xp2cRtJo1RSs7Ji+u93SLjO7MZMkUtJMnoALuClacubmR/lt1h8SqQOtvpu0FDxyZ7sPpH3VBgZsbB1XI18S5H2UNbpTQkvBdcuhtlA+731QOiKNzHd/t5BU2MrcZCLZKzUdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5nMkJbT3tWOIxyE86knhMO2Rxk2p2MVP99Uf+Jybfk=;
 b=jP7YFW1SwjTMoGWY8SyC5Ac+r8j5aSSFpOhv/XVl0kO7fRDlMYYiguKo59iVQAVTi0y4rK4lF9B8LRyONKqWqLfcp44ItLB5dEj0a3Vn9wwDl4niAcM0ydC3eCMHhZvNRnteeXZiNdKhNnXpmRFnHqJAJBt/kKhZSG20gE325p1OWgbWq5/ZkQDQrrsUSdUiKHR2Ppa+JOzoTr1Q7VtULhuQoAtnCy+N8PVZQ2Z/sj+USNwjs9MgcJKTnJjKRlNlR1zOUjSzNA2mV4pIW6s1pBfznLjrRbfmTiL0l4ALyLzgTg2VeLrhhDkOqyOuY7ZRc0LsSLaLx9l3WTF+nNwDHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5nMkJbT3tWOIxyE86knhMO2Rxk2p2MVP99Uf+Jybfk=;
 b=VSTtipwVkfaLIlyjEchA+YklPFLa18TzW3GJfgpwz4XNkWVaEJBBuDOeE/C+0+3EwxifK7vyLl7mZt5ftId9M1VxIL4Wc3GYVLeCDXG3k6eYj2HUxXo5eU4gBuIK8pT8QeuyFl9Yta2jQJu7N6v5J6iyPdjAxxpi3oELnKWV7hc=
Received: from MW4P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::29)
 by SJ2PR12MB8652.namprd12.prod.outlook.com (2603:10b6:a03:53a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 21:10:42 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::a4) by MW4P220CA0024.outlook.office365.com
 (2603:10b6:303:115::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Mon, 13 Feb 2023 21:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.24 via Frontend Transport; Mon, 13 Feb 2023 21:10:41 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Feb
 2023 15:10:40 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd: Don't allow s0ix on APUs older than Raven
Date: Mon, 13 Feb 2023 15:10:30 -0600
Message-ID: <20230213211030.5295-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|SJ2PR12MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: b34ad2bd-5027-4c64-f9f6-08db0e06c3d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMCATTLogVLa7/LqOLwcIvuXL+jSSMANpsPoH10hrm7XplEvfbPtYa/rUGBkFJ8UTewLbRVMjD2s6gWY9jtrJpdNYU0xkPzj8XraOW+q6gIrf7eJDaFpT1/NjT0XpAcw+qIex/TTPEm5Q4S1lzSETeNDsdZSjkT0cwyCUZ4IcmxqE1HvrbkEssogphsaVYeSSdb70JN64E57rRGpHtKB660BuvN/vvnK2/VCQlNS/Q63NvT6BsV4wpKoG2HfhzgyWISZ3K5Kk8/3qVYWeKxIcT8Irbk8dQtdE0xWYwVheNmjI4hS8M+w4j/tgOjLbOxCL3dWDBnXGAvKnBLZUlfNKqGrTRJw2JyBtqBBpOUzZUh0Zur/jNVLqaSZjlBJ2b2DRAYbJ/gJRGXgfp1tPRc4WO4zQpbem9zr7T89OpaTmDAsGsmFGMmPHjiDbut93wOSZAlVQ7B/YyTXnpm3XxDPMKrXelUqr2cco3jqKN/XcFxX+zQHH3qBqK7j9JQoXpZldT4dJVJetz8I9rC0xN5vBVbjU2tzfeb8CTLrsddIbHE6LP1jSHaThtCbTjBCsY/LwrrSNDYwjECbv4ZGo8Fn3EXnh/z3UroGt1dX8+Hbkz21tMdHf/ftvlGeRXP5eszTqaC/f008JHYHyfboVrFQ01OzJYO7w3kCF9Q3vRYXIgIXY8Y+SwTDvHHPgBsCgZ8kiLIbzr+ru3geFgicHOfpwhcxlFhvbBShb1QhZdd10SV8iR+PoW3A5pXRVaC5+Z6+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199018)(36840700001)(46966006)(40470700004)(36756003)(40460700003)(54906003)(41300700001)(356005)(316002)(8676002)(4326008)(6916009)(70206006)(36860700001)(40480700001)(86362001)(82740400003)(81166007)(82310400005)(26005)(1076003)(186003)(6666004)(7696005)(16526019)(70586007)(478600001)(2906002)(44832011)(2616005)(8936002)(47076005)(5660300002)(426003)(336012)(83380400001)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 21:10:41.9339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b34ad2bd-5027-4c64-f9f6-08db0e06c3d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8652
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

APUs before Raven didn't support s0ix.  As we just relieved some
of the safety checks for s0ix to improve power consumption on
APUs that support it but that are missing BIOS support a new
blind spot was introduced that a user could "try" to run s0ix.

Plug this hole so that if users try to run s0ix on anything older
than Raven it will just skip suspend of the GPU.

Fixes: cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support")
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Don't run any suspend code or resume code in this case
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index fa7375b97fd47..25e902077caf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1073,6 +1073,9 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 	    (pm_suspend_target_state != PM_SUSPEND_TO_IDLE))
 		return false;
 
+	if (adev->asic_type < CHIP_RAVEN)
+		return false;
+
 	/*
 	 * If ACPI_FADT_LOW_POWER_S0 is not set in the FADT, it is generally
 	 * risky to do any special firmware-related preparations for entering
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6c2fe50b528e0..1f6d93dc3d72b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2414,8 +2414,10 @@ static int amdgpu_pmops_suspend(struct device *dev)
 
 	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = true;
-	else
+	else if (amdgpu_acpi_is_s3_active(adev))
 		adev->in_s3 = true;
+	if (!adev->in_s0ix && !adev->in_s3)
+		return 0;
 	return amdgpu_device_suspend(drm_dev, true);
 }
 
@@ -2436,6 +2438,9 @@ static int amdgpu_pmops_resume(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int r;
 
+	if (!adev->in_s0ix && !adev->in_s3)
+		return 0;
+
 	/* Avoids registers access if device is physically gone */
 	if (!pci_device_is_present(adev->pdev))
 		adev->no_hw_access = true;
-- 
2.25.1

