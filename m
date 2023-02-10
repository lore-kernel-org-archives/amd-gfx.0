Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CD1C636D4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 20:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D24610E29C;
	Fri, 10 Feb 2023 20:47:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAECF10E29C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 20:47:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbnfpYzslGei2SY/a2rNDfnIAIosJ79YZjy+q5UxsTqL6jtX6sgJnzKWgqhrrAREtGf3bawOJut8KoLTtDsJzNf9kY0sfWXYjWwBW3jQtvSUyA47Dt6UenZxnOR7sgfdm8WcTxmZLu7ooxu1+jATzzPMhJxy8Q1e30GXh27ox/uRj1/T/GQJpA98d20OeXn7Sh4zXeEpuy6LYtrUlMso+HiLE1N+D9E3MSKY+v8/Op/aX/w7MEeaukp4yyg7U7chnNktHYNpRfL2b8LNk7S/OtZikOw75VRaaLcU2KxLKeuJrlGwxGLwfxYTGtS1kTZLy3EwGF5y5PxGMOrIANH0SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w36DTLVf+uEBUtOVCdZ+Vmrm0TtALU/snWAY+VRdVOo=;
 b=QK2sGYzwJCSCLJV/oquRpkvbRTMMQKaTzNJxgA3XNrXAa0JqVevu1vR+xuhp4xskt5u/Chw6C/z5nb3GL/K8wYYDB8PGEHTzRISNesuEJ+LZ0Ifxfd9BALU1g6Ymap5cTt0YTwfl926gfpFwINUueFU74MRjEljdN4HO6FRqrj7cXggpI+N2IpsTqzSZRxELg1MSJfp43fic/+3adQOdV4kLabcEysc2Q2ddVJ0yqj3kjIobrf3lJJZ73vhZ3FIAyZ844DAEQDulDSWy0Nd3fKoJVqQOQDyZ9p4QdGZ7Aht8f5lyFhQ4N3AA0asFDGUFfgIktM18Hi+H+/LpGiNjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w36DTLVf+uEBUtOVCdZ+Vmrm0TtALU/snWAY+VRdVOo=;
 b=H9n1SRqD3cv7vZbzV3bTX67XO6pAQESkhsSyDSwsLIiadqDJjLaPpt+z93jKdbH8X6rU1heZmDnj0rYbkv0J8njxJr9OWCT34lcDeUJ5pjd1frWCDz2uaFf+sy+HBOopxeEg3wqRKxhxBBQyRa0Qn8ANxJJHvHkAw81mmhkTRV4=
Received: from MW4PR03CA0272.namprd03.prod.outlook.com (2603:10b6:303:b5::7)
 by SN7PR12MB8060.namprd12.prod.outlook.com (2603:10b6:806:343::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 20:47:30 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::5e) by MW4PR03CA0272.outlook.office365.com
 (2603:10b6:303:b5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Fri, 10 Feb 2023 20:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.21 via Frontend Transport; Fri, 10 Feb 2023 20:47:29 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Feb
 2023 14:47:28 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Don't allow s0ix on APUs older than Raven
Date: Fri, 10 Feb 2023 14:47:16 -0600
Message-ID: <20230210204716.12849-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|SN7PR12MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 530a0abe-5f7e-40e9-185a-08db0ba806dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ScUitKONx31WJQRR2OonfyZ8mr3DdQyLEfW8PvI9YIZ81Go75GT3DsHqd14gAgeZsC4Vr6hGb4iWL6SGQTe3B1RAcvvI5O9aUqyYkYxYCulpPWp98fBAHtt1gpo6M7XIRoxbPraLC6ieiFx2KCYW8XMwpJG1US18bSVztSLodJsMGc+TJs5Wdv52RWUJaspZfH/fOX2a4xvzjQoFa4oxPBvryK1ctQ8b4YKl5Y7Qlj9qwwKPe7mIJHADWfgx4jvO5lsUXV99hM/+G0c6E4qZ4jbzeIl2M2gp+McxHQoy2tz76v0Mhps2vKKo0ugbmUuKI+tiao/+Cakc5Vu3yTqWvIvBuOJLJh7TAQVkUoErQnhdBg8fIihb9AiNEV6v3YWFj6kJfLJnl1SBUADndiVKu47D73gMMGNBm1kbFXWBYHKgxyW7B8ZgGpxtl83qTWb8G6QJ8c8JTvl8pzNsvCOuCtVAsVPev/tbkL8T2GtowvEJ3h6m7gaTHZaeU50SDQ/j7sQioumkZX6uKT9eoRy5WI9LHxfkcNb0oNa+AnbltFvSNONf4Z8l/p8w+/sj7g7cODK78V3F2RJNfv94GvarmY4o6WrsgSMR4CJe62tNWlZYhpnNkBNfjQE1+Q5Wzk6rKFo6tie3+TY0w74E2XY5qEJcDP+aOmQ8zY84mtt/2tu67Ww4x7x7qWpoDDRQySJaDYzm2zF6ElSDP/hyQUPZ6wi6y1a3wTmI3McfuBMl7tblmR32XQjTuYk7bg/YIBNJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199018)(36840700001)(40470700004)(46966006)(40480700001)(356005)(40460700003)(86362001)(82310400005)(36756003)(426003)(47076005)(70206006)(83380400001)(54906003)(70586007)(1076003)(6666004)(82740400003)(16526019)(7696005)(186003)(26005)(316002)(336012)(478600001)(2616005)(81166007)(2906002)(5660300002)(8936002)(41300700001)(8676002)(6916009)(4326008)(36860700001)(44832011)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 20:47:29.8837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 530a0abe-5f7e-40e9-185a-08db0ba806dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8060
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

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
index 6c2fe50b528e0..98f8d9873cd84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2414,7 +2414,7 @@ static int amdgpu_pmops_suspend(struct device *dev)
 
 	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = true;
-	else
+	else if (amdgpu_acpi_is_s3_active(adev))
 		adev->in_s3 = true;
 	return amdgpu_device_suspend(drm_dev, true);
 }
@@ -2436,6 +2436,9 @@ static int amdgpu_pmops_resume(struct device *dev)
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

