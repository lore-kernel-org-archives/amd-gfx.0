Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DF7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 06:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D8B410E975;
	Thu,  5 May 2022 06:36:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F172710E975
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 06:36:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/hWKbksWpbFejBYhVqqqgJdHLZWFEBR6ai/eJ8/L20RMoucq8neReh1/xwI7WPMZfZPcPxR0I1tovnTbRNFT/5/C3fd4PoIie0R4GspSvf+ghaADhJw5yt1fdVGcQ9DEyd46RCe8Cfbn5TskmL/AlLwNYCQCDxHHEiz8zz8IZ1U9TXp5ul76hC+d3+t3t3z7h/a4Ko5oYE9uTcw9u4yILmZDKPr+Cl2AwvwhpUpqggVjy2k+zmYJiAyYg+TQc6HoUsP8HsLRzZwO41P2mMs/tR6XT10Vu5RNdt/VOOD0cZxHrQLl7ZsS3ymM0Y4N0n9JxBVG/6zn3D1GNr5wN4pmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uu4UR7O+TP++EWtvEUTWB2ptTnDDHq8AHV+zdbGOVkg=;
 b=gQ+Y1SoPsQMsa8qLGAIFOvnNwpQI+fSviHiByBS6SQuvi4uOUyU9TGJ/9SQX5Rkm1xb7MHXSJ4Z1xXc/9FCVBfCL84gWav1OFmp9/Vlgt2u1E6cMFTnKo7bpNsmOly00tcB21RM/ACL9hJjUwUWh6Ucn4Srk6BmIGJY/yaufyPenUQJBjmr67Drl9xX7JMFdmbDve/LPY3t6V825NmM2e6DZ37XDt49bGVgFP121N/gwN1wZLTbCTyiUjRd3WKatrfbdYe8yQu0/B1G29sTpHNKDOJrVsogSItnFiig9cFIo1XNn5wqVoTsoWdTog88WfIESfCcsnkTMvVhvqm46lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uu4UR7O+TP++EWtvEUTWB2ptTnDDHq8AHV+zdbGOVkg=;
 b=PxG9ma5ZYYMyOjW008tD0h25Jv69IoNUYL+JOW6IFRxfBKByIlSirDBB7zkkxvmd1ULgdPqdacpgUh7mY++i2IhB77FY/bL9SCVIBIe7a5XDBb2HhtV0Az5WSQlwJ6Pympdw7v3BUKl3SaLfGOcrzbC1Db2aHSRgiIzDOMx58pA=
Received: from BN9PR03CA0561.namprd03.prod.outlook.com (2603:10b6:408:138::26)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Thu, 5 May
 2022 06:35:59 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::a4) by BN9PR03CA0561.outlook.office365.com
 (2603:10b6:408:138::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 5 May 2022 06:35:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 06:35:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 01:35:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 01:35:58 -0500
Received: from yiqinyao-Pro-E800-G4-WS950T.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Thu, 5 May 2022 01:35:57 -0500
From: Yiqing Yao <yiqing.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: flush delete wq after wait fence
Date: Thu, 5 May 2022 14:35:27 +0800
Message-ID: <20220505063527.957333-1-yiqing.yao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf7a6366-1ff2-4b49-3ff1-08da2e618456
X-MS-TrafficTypeDiagnostic: LV2PR12MB5848:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB58484A530E3E183765FD357585C29@LV2PR12MB5848.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zD85my0XS8fbvfNHuizpjhm1QdN+MInDYUFs1zQ6gylCVC/izqMGviVfkl7dY8e+9KvEqYDuyFGJbQBrMa+S1zmb28zFPEp//u3Ye4cmdiYfZNCNjoAZqa4CAA8B0lv7RP3/aVkwlB/yI6f2a8snjl46FQfKwh+ZvA0YumFhDcS/DKmMmJUH3sGE/f2QXvmItM+X+u2lLH3rxJqxk8N0+sx+Xx7kz8QmgS5I1nL0nHgeGEZ8ATjFXRCb0Phqa0Xc/UEuvSYzlN6IJIXSHGe51BjbrV7SfZQ2Off526HIOuIIZSjT/w+VoOulkwiQiy9qgtzkjOupLcjP8N4tiP015uAKUNU20nBcuiIQMgrgVlWOBLZuk7bwN9Tgj5CIjOCgypPYVXazqTwJlsPfXeBNdaj8N8QZLHa3OtR2dwN3GZ+e/nJwpcZ3R1BFhAHbJNpw+4n8yCHI1gEnbn4AmrMfGTssfykxm9V973fYVWZ1iOIZ4uZcwPcXdJTZTNJkwCxoR4FqvIKMJDUo3aqA7diYXGAZHMgo9rkS8euBIvzfL9VUDLyhje8lcF5Oo8hZ48ylIR9AtAmRUrQqDlqPaFcae1fRg+WGiqK7ejMM40zVIBP2kO+GQ9dB8ZJHJy3349Ku7U5i7rpghl8Ocn7QSv/mRW4DHaAD6I86CtR7NmkZjVFKD7WsEFI/8grmGQ8tVy8AxGNq5yYpSK0FT0Z0qCI/QQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(6666004)(8936002)(1076003)(86362001)(7696005)(44832011)(186003)(2616005)(508600001)(26005)(4326008)(36756003)(8676002)(6916009)(40460700003)(2906002)(70206006)(36860700001)(82310400005)(356005)(81166007)(83380400001)(336012)(316002)(426003)(54906003)(47076005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 06:35:59.2515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7a6366-1ff2-4b49-3ff1-08da2e618456
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
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
Cc: jingwen.chen2@amd.com, xinhui.pan@amd.com, christian.koenig@amd.com,
 Yiqing Yao <yiqing.yao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
lru_list not empty warning in sw fini during repeated device bind unbind.
There should be a amdgpu_fence_wait_empty() before the flush_delayed_work()
call as sugested.

[how]
Do flush_delayed_work for ttm bo delayed delete wq after fence_driver_hw_fini.

Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 14c5ccf81e80..92e5ed3ed345 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4003,10 +4003,6 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 {
 	dev_info(adev->dev, "amdgpu: finishing device.\n");
 	flush_delayed_work(&adev->delayed_init_work);
-	if (adev->mman.initialized) {
-		flush_delayed_work(&adev->mman.bdev.wq);
-		ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
-	}
 	adev->shutdown = true;
 
 	/* make sure IB test finished before entering exclusive mode
@@ -4029,6 +4025,11 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	}
 	amdgpu_fence_driver_hw_fini(adev);
 
+	if (adev->mman.initialized) {
+		flush_delayed_work(&adev->mman.bdev.wq);
+		ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
+	}
+
 	if (adev->pm_sysfs_en)
 		amdgpu_pm_sysfs_fini(adev);
 	if (adev->ucode_sysfs_en)
-- 
2.25.1

