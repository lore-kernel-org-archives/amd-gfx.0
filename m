Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED712C27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 08:44:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EFFD10E5DE;
	Tue, 18 Jun 2024 08:44:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jzV13DKJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B113610E5DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 08:44:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaydB6kBd9Sx93cl7+DjQS34L3LCiz3eagKZivcHTgOYu+nf2G2xcjO9rd9b+epXBUo5zoV7uGBH6GOONHnecmHUzQm8QmH1PSPWbz1AVEFGDI7jsp4gwQr5NBPkVZ45LzS+ZfNyjclqs7AWCSJB3TJzAHXSYMDs46GE+9Fo8Bc26wQaoyZFGPwMo1dkfdanT2Rivlix0ece+WkPmCF0W+ZZwjT3vSelqCzT1tjed8w10joOrHuJUAUeqcMTkg+KHlamPL8VPIlvckMQVzNDG9APDwd2aUYJ6z7Osyv5837aS/oul4N6sTmHloTgzJmc8oWOfUdGaxfDL+8Zys486Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38KdAz6g0utLVEamCMi+EmiUiRNUt5vJK/Z/mTeug98=;
 b=PZCj4+Dm1+GKMqgunlAqUjDXPtpUflK548rv7AcrzvBs4piB24oJNJLxyJpbtT4aScmJ2oDqpjzKfWxbY6S6IVnknF+Ks0NUsfuok6zSlVZ8KwORfrC9e7p02Cte3DDaQtBRMeCSsgmhI/yK9M0YS/ngthrKUylyJ54ZAZmpMBmmLAHLhWdS8MGLelorY4uXDPPvO2VOLFuoj0xsm6vaYhR7zQ3l99WiChCsUKyBHUXJompRweG0dc6PpU8dKdvSThGmjdqAQwoUgKxBEjW7+0Rz7dkb9tXCpiAluJSRuerYKKXmU0DQqPBDBgwEmnuwS7JUHcVTQvnul3foV7NbXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38KdAz6g0utLVEamCMi+EmiUiRNUt5vJK/Z/mTeug98=;
 b=jzV13DKJf8BB2CdQA6oaKyz9uYwa5Gd9HFuW1cyS8+NDhnqOXMXmzF20vCMoHbBGzQgYSzjsc6zSqLjzO5qxwZJNbt454LyA+K0CrI902e1ecnJ98OKdiNS7N1OdECLc18ekGRTvkvkc1R9zowO5Yd7kE49q21mg+YanRz9An9Y=
Received: from SJ0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:33b::10)
 by PH7PR12MB7281.namprd12.prod.outlook.com (2603:10b6:510:208::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Tue, 18 Jun
 2024 08:44:40 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::74) by SJ0PR05CA0005.outlook.office365.com
 (2603:10b6:a03:33b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 08:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 08:44:40 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 03:44:38 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu: Fix pci state save during mode-1 reset
Date: Tue, 18 Jun 2024 14:14:23 +0530
Message-ID: <20240618084423.1144125-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|PH7PR12MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: eb66a18e-6dbe-44bc-c876-08dc8f72e4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|82310400023|376011|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/4ta9OtXgUxvH7uAgqduNe21eXy0NXnqIjR5Dr2YpbHSv1uhLgwqXDTjucaG?=
 =?us-ascii?Q?9Kc+4ZWNKzTBRrD5aQlkPQzQVsjJbi0xwYZFHC/Nq1sPK9miCHOpNufBT8I5?=
 =?us-ascii?Q?eEDl5BlCo5xLxWVqDY7XGRldehyazeJ9y3mRJv9H74jiOJzvJ+NgxPM8xPYX?=
 =?us-ascii?Q?YbQ6E1Ge+W5l+B2IMoUtMIkxyNh/EFjfYfKS5HD08FfVTQzPFRwrvpOIJER8?=
 =?us-ascii?Q?3B9B9RLyUJlaEFoyDs0c39cW18xHN/Rkgpi1Ic5YQPUvLvSCjtxePPKxEjGE?=
 =?us-ascii?Q?luON0zPTimEvMMf6Qn4c3hlmJRtSZN5LYmdxNRqP9GHN0dXv/adR85N8LBko?=
 =?us-ascii?Q?HCLLUf/Nov8/ZVHUOKSVl91yz3vzok54tkdPVrprcglRFp51slDZhiKpgC6K?=
 =?us-ascii?Q?Tqvhwz/zXcetUz9FCAua+g2Nym+5Q2L25M93pdcgqvjy8eJLWjdHsIauqmzQ?=
 =?us-ascii?Q?TTil3PYnCgugEzNUyPxNjp7HkW/pje6jGVbHDutiXMZG0V8DWeuPHIg+1f7i?=
 =?us-ascii?Q?RZJVnSc48+Ey4MMFolAZHfsfNbA3i39mstWuhGBKVyXmH/8MClbRXPaNiNgR?=
 =?us-ascii?Q?1jFMga4DsAZL8zeBvlXidgQJICc8yfFT+QmT9WWmcUF2S4CF7NZd5UH9wtAS?=
 =?us-ascii?Q?G3UHWEMKZDlAW+k2c0lycaexfcEN2+KF/khaeJSke1ZJqL86LMvecwkxCwmI?=
 =?us-ascii?Q?bw6NtBy9Bdknd9yYLCQQKbUAQ+laHTc41AZjwiZWoVJNgRYIa10S01BOaenW?=
 =?us-ascii?Q?W/SPDmSa30/LRVhluCBVvHKBaoDOE8YXBrbgyKwz60vflhYTssTAlebCrzpk?=
 =?us-ascii?Q?dbf6CFDY1mxgCZj3mmXhN/bukVoe8NAmmkJCqSEfnJmWbnIt9Vrub0NmzuqR?=
 =?us-ascii?Q?KF5ge2fnsN8IaWm303QBOtR5XLk21tnKWWDUzIAtbWYTTug9K3pj6C1r1h8U?=
 =?us-ascii?Q?ZmEi78xmNRuymEMLKI2yMjk3qTrQvOPLkIHbt8CeqVQjSPuMMj/rHS2JYU9t?=
 =?us-ascii?Q?q1mv2FoMyU4t4fwK0SnHqA4zQ35ST2WEnsakfLenTJ+FRMhSMIP90OhK7YpO?=
 =?us-ascii?Q?fESg6uRjeABcZFJ4olKSB4PajOhp4xitJ/QYjB+RWNyA0kxv3Y8b5nenHFxp?=
 =?us-ascii?Q?EqGejvf1bvWmzHA1/7kWhKpow4EAa+E386Px83VmAfVMnfgG8JjKewov6W6E?=
 =?us-ascii?Q?5n198J1qTqhMA4RTuTKrS0xLF1AXxrgZlWuDZF3ETcCotoeEnYLmb39prEz1?=
 =?us-ascii?Q?u6fhPmi1dKsE4RUBo2xoJEDfyYNaiBxn5YJUOw+V+cEbHMi3dGy2n1PvSPEv?=
 =?us-ascii?Q?0r852oa+sc+odpKL0L3rtAft5dCcFoLfNL40YQMVrogRkmEl25lnkwB6N+Me?=
 =?us-ascii?Q?0qBbGzi86GgFOtRIejcJ4fOlUYaMeyKm+SdlHSf3w8FIL0+dig=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(82310400023)(376011)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 08:44:40.5980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb66a18e-6dbe-44bc-c876-08dc8f72e4d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7281
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Cache the PCI state before bus master is disabled. The saved state is
later used for other cases like restoring config space after mode-2
reset.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Fixes: 5c03e5843e6b ("drm/amdgpu:add smu mode1/2 support for aldebaran")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3fb02f5b91c9..6c2ab14ca102 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5224,11 +5224,14 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 
 	dev_info(adev->dev, "GPU mode1 reset\n");
 
+	/* Cache the state before bus master disable. The saved config space
+	 * values are used in other cases like restore after mode-2 reset.
+	 */
+	amdgpu_device_cache_pci_state(adev->pdev);
+
 	/* disable BM */
 	pci_clear_master(adev->pdev);
 
-	amdgpu_device_cache_pci_state(adev->pdev);
-
 	if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
 		dev_info(adev->dev, "GPU smu mode1 reset\n");
 		ret = amdgpu_dpm_mode1_reset(adev);
-- 
2.25.1

