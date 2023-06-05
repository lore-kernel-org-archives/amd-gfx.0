Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B47C77B73
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 14:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB2B310E2B7;
	Mon,  5 Jun 2023 14:28:57 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8766C10E2AF
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jun 2023 14:28:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbbggTKNmpBcpFKGiJvKZgcruBRg1Xv15unmdgq1DJDBVYFGUkxzms7PcdGjyxnC8p3SJQDABR/0Ao1UVojBvOspJvaHhHIbLOfVkWXkGomnTeYrQoJSCnrlg8i94QaztYZ1tOAhxXk4OF9q2b5imHTaDtXFGTnRDX4mowvkedKDNuo2Sb2zUTgwJ9Kn/4dHQX2+mVhg3PrYJYk5OD3ZAgeCteLYuVxR2kHaTQctBXEaMpFIYEBhKWb4LN2qTCBqSQ0na0BGml2eoVnQUQEP30deMVojzMSQ9gIZqzkEzy3vHBe73h5n3Es9AeyDrBj/lTaupCIB8FEnF/QBw+V9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjDX6n8YnZUWSJSXGJsJ5pZSXgHaUX5DLjOayu5JuCE=;
 b=FklSYxTb0heR9+b9j45oLAPTmrL7e7eOR6tgWFRFwJ40lKt71v13gXGilweXzZOya7JBvmKHJPTn2URtEYUPcKVfOVmkWtKP46ocLm/yla5WbAVJV9oInylrLC1BqLL3K8yG5evcPU94V0rDEPhB+BSJIMEs0VtIDydSYw3AC+C3Lw2Erwj38Fbf42s/B2JORV+yG/Xu90TgHUevZ6QGbW5dY7l/RaKpVDJqZ4HtDYsDr5FrbjkV90JSQEVm3NSSUpmjEaxSHEfemtU5hhmIh2PV7vVh5laq7k8rx4UYo1Ee+V6XfDFcFYqJCuX32aae+6BNtUzs2e/LqCigAqm7nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjDX6n8YnZUWSJSXGJsJ5pZSXgHaUX5DLjOayu5JuCE=;
 b=5Qfb+32G6wPA+JZdv90NkrgB2mRp3keG8StpDwCDs49UfVHJ3/IGIY2s7k2oiZJ8AFvr68Kn6ry3JdA8EmqAgTVeUGP7f0E+oacnBbmweOJPCo0/cCCW28HzAeQr03sTHIGQu4tSJ5vHZqSWi0CAgbH5qlinfGbNz5aQEp+ZBkE=
Received: from SJ0P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::23)
 by LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Mon, 5 Jun
 2023 14:28:52 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:41b:cafe::d2) by SJ0P220CA0016.outlook.office365.com
 (2603:10b6:a03:41b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 14:28:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.32 via Frontend Transport; Mon, 5 Jun 2023 14:28:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 09:28:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd:  Drop messages in init for radeon, amdgpu
Date: Mon, 5 Jun 2023 10:28:23 -0400
Message-ID: <20230605142823.62123-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|LV2PR12MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e8a1aa-8b8d-4fb3-a9a3-08db65d12e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTZgh7UafN/FXdSvxtWp7UynSoH8tKFINuQOs2r0Pqk4O0yLXS6J4O7UBGVd1rHH662sRQSraMrkg37dVxuicjk6ZvYWPwL2RNxYA7JPfY/xo7qTgzc8T8aiRVpYXmT3z/AE7Xd8sv+GFKaNrShKH5tLVeiMowA6XGN172vb6yERwWdNYIrTc1d87/LUM5zbUHF42Bj2TT6GKSxwYxa0IggxouCqcDSYakdP3157XJfquxNbnzPj9jUU6nWZoJl2rn8zIVju3egrzgcyYQhakM4YCBt5WN5VQR9G4GXXHZ/kI2yy8X7P5FzBiXFft5OJ/Dy2G2XvnRPU/iugQV2MnPwJ44RgvmmcgcQLmDxqjB+u4WJSTyPbxUT2COoPpeD8dWEvhjkGIlL04NeG+IETPKoV8vr660M/LNR4WOxwGkrhJ0lPX3raBx+h+nJdrXtby3Ts+8AHCzLXSgEt++ecr5ddGxDd0Ag9YWsS3a29cRp87Kk28lnF31G7pF7wILVIKk78LJwC9DMzEZBiBCqgPFOCKPD/xeNQJWV91DES/xgglVJfhEVdjzGcs7OLrDkI9twdd/N7i2/QqSXOdy79Q40gVFkTD5yHrm5FYraFCvtY4uMquwrmR6osZ4w9ARpEUhji5H23bilXgj529fhbpkJgJdtSNdmY2J5Lvr3n0ioLOl08skoib4iJ4A+wo6gksXhobsNDsVCyD5XIIXNQmbhHSFJ5xA/UBpyldTtKegM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(47076005)(82310400005)(36860700001)(40460700003)(82740400003)(40480700001)(86362001)(36756003)(356005)(81166007)(6666004)(7696005)(478600001)(966005)(2906002)(15650500001)(316002)(4326008)(6916009)(70206006)(5660300002)(8676002)(41300700001)(8936002)(2616005)(426003)(336012)(70586007)(186003)(16526019)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 14:28:50.4899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e8a1aa-8b8d-4fb3-a9a3-08db65d12e7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920
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

Since there is overlap in supported devices, both
modules load, but only one will bind to a particular
device depending on the user's configuration.  Drop
the message in the module init function as this can
be confusing to users.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2608
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 -
 drivers/gpu/drm/radeon/radeon_drv.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7eda4f039224..94509b76fa6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3065,7 +3065,6 @@ static int __init amdgpu_init(void)
 	if (r)
 		goto error_fence;
 
-	DRM_INFO("amdgpu kernel modesetting enabled.\n");
 	amdgpu_register_atpx_handler();
 	amdgpu_acpi_detect();
 
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index e4374814f0ef..16b9eab90185 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -634,7 +634,6 @@ static int __init radeon_module_init(void)
 	if (radeon_modeset == 0)
 		return -EINVAL;
 
-	DRM_INFO("radeon kernel modesetting enabled.\n");
 	radeon_register_atpx_handler();
 
 	return pci_register_driver(&radeon_kms_pci_driver);
-- 
2.40.1

