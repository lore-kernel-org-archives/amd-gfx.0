Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18CFC41535
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Dec 2023 12:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F20B10E7A4;
	Fri, 22 Dec 2023 12:00:24 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7111310E7A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Dec 2023 12:00:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpFryJp1vhPwHK7Krlg6/MMic3Lv4ci7OV/2xOVm5waELTVTymFIXzEUh0eJ4rjBiu5iduX/ldN8qwZscjB7j3Tin9mdkN4r1owhiANtIZTWtAhzEKY+L2wcyPq+Vk0z98rGm3wH4O6qfZTDuUSgkS2xOZgcgNAGeUnSRzhX7wYq6pkJLvxnuHPDMfgGQjGlrw5R1ngzfA8bmbsiHlTaJjCGcsgzW8rajoysx6cPLdvckxImJELH/Kfr6WjSd6KIF4/bLXLahWTVhY1FcJ3iiYOMhew3y1utGFtGwa+mFudNk4beG8c4wVlZj1hYB0VLn++yCLF4xLg2M26XxjHAWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YGytVdxEH1EOSlVDJtAGEWaUGzNjRWblvmTwY34MMw=;
 b=ga3hnQ4KMSi4XwurRlFWa0EOJ7SGnfeOaACuFOFFCcdEo9P0+8uyWpVMQScZf75xj4bVO6mEeTxCbJNbd3LUgrx2lA8JczPqGjL4Aqwe00RcLB67UMgLzjPl+Pa1cQr3yM2Pkdi5eT6/B6Okf6jSxDMg67Hjm+vlRrp5kK2T8JV+/ZfyKxVxKUI5ZLr70jFSvqxF7RjnsmBYuCkTC17ZqCMFVM3tk12FCVT6pp6zXpIKs/dQwE4DiLUq2lcHVt6XrxILfKe5lZxqawH44w06JUijaxtqROkxCdYITkveFV/EsWkht5YULO/PK7iTu/owtNhJLtzYCGAbTPCQrrRMVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YGytVdxEH1EOSlVDJtAGEWaUGzNjRWblvmTwY34MMw=;
 b=5K6SRuqur8K+/YacvOKd0swoKoewZNfJ+RJQvzToKNpoXiBXTisOJfla8kJdBeKYhd1XHod8hT6yoMCqQ1r6bXEA8iaqEZ4mQ7002zgoL/uH0xKjxoLL+ukE8zC34HdNuKTd94jzPL+KkNMuWaIkZky4OOzAY7eo7kQOUi1YNI4=
Received: from DM6PR06CA0057.namprd06.prod.outlook.com (2603:10b6:5:54::34) by
 SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.21; Fri, 22 Dec 2023 12:00:20 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::c4) by DM6PR06CA0057.outlook.office365.com
 (2603:10b6:5:54::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Fri, 22 Dec 2023 12:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 22 Dec 2023 12:00:19 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 22 Dec 2023 06:00:06 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>
Subject: [PATCH v3] drm/amdgpu: Release 'adev->pm.fw' before return in
 'amdgpu_device_need_post()'
Date: Fri, 22 Dec 2023 17:29:53 +0530
Message-ID: <20231222115953.1692976-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 108539c2-3e6f-4966-2e7f-08dc02e591ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AEhXdELoIPckkzcwhua1yNehaQjCnjUPJhNwFyo5UxvfRIWPnGZNHWv/ycXrd6bXGfDBUkFQQ2ZskwQmpbn00lxtMPHiq78S/w8/IyBKSGYx5GbM1ZsBopWV/ALxosm5In2zjTtttQkHyUPbttspHDzVKXRDFXcwSX1jInbU7lSNFQ942pBgZ4lClNmx+i5ZHNjdJL7bzGpixhn3dQPL/SNaDwp6k5HBhSvSuxgUOghyKYLIUuR4wE0ZqQFZr//X4q+o/RXKugkrI3oGQP5lsKvhhbixClGrsxNwsprtoR21+rQdwA8mOGcwPPTJFnUmGU8TpciYgHQUamv9Js5VHsEjCwfqvJ+YGMMQg4ACsU4HIAB6YctYfe0uDTh2MI+6G7YErx/DEIhlBo/AXHZHZ987lnv50B4I56V+V9j4e8sKw9MwyxGez1JDk03xU1tOfhvXMIlfGQWyGQqfl87jh4GpjDC+Rp5JHHlNgvYhrITviv6Hy2fgcnaqHATDmdP/GeGx2YqDiBK/toXhcAwLv4SBChLItATJv3CKsNslBKC7WasiMQydF4nhaQZ3cvE6x3q3hqxNWErKDA9DaA9JLwPahRNJ3gRVngW9e4wKFX9S9n/z/vt652Lk1Olf1Vnb4TgU1GXD7WiaameqKo0br4nb+JDBaRwoNnYdhlpKTlX5TnCQIAuxRrFtRY9P+2hOmE5gAfgVX8Mum8bpOnsFrBa6HDqhlX0mqe8ws1oBTn6x9lqyUfOUkevRrzPsvMwgL0z6JjQBvhclBgOUEchZhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(1076003)(66574015)(36860700001)(81166007)(83380400001)(82740400003)(356005)(36756003)(86362001)(41300700001)(336012)(426003)(47076005)(44832011)(5660300002)(8676002)(4326008)(8936002)(110136005)(54906003)(316002)(70206006)(2616005)(16526019)(26005)(478600001)(6636002)(7696005)(2906002)(70586007)(6666004)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 12:00:19.3864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 108539c2-3e6f-4966-2e7f-08dc02e591ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242
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
Cc: Lijo Lazar <lijo.lazar@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In function 'amdgpu_device_need_post(struct amdgpu_device *adev)' -
'adev->pm.fw' may not be released before return.

Using the function release_firmware() to release adev->pm.fw.

Thus fixing the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1571 amdgpu_device_need_post() warn: 'adev->pm.fw' from request_firmware() not released on lines: 1554.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Cc: Monk Liu <Monk.Liu@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
   release fw needs to be done only FIJI ASIC (Lijo)

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4b694696930e..33f37efaf373 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1544,6 +1544,7 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 				return true;
 
 			fw_ver = *((uint32_t *)adev->pm.fw->data + 69);
+			release_firmware(adev->pm.fw);
 			if (fw_ver < 0x00160e00)
 				return true;
 		}
-- 
2.34.1

