Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D350C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Nov 2023 05:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9172610E12D;
	Mon, 13 Nov 2023 05:31:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 975F210E12D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Nov 2023 05:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2tqlFjXYlQ0FYw2tj5ccfSBYJHGDH/vh0Yaw5XVcfmJwPFOmMOl/YHUNXa0fqxKGL/4sAr0Z53XMH2ARmuMUPHWyD5VkMfSzF2sYMj0v9gfV4kTDoVx2TDfZPAce12nINDVoaZH/2S630LmbdqZKoyUEcP4AouWrF0IKiTVVb4HkWK2FvOnlusR6LMaaSM/4BsXC7QxDodYlskAGauh8PHlPxuIXYExZBUksAGRfOaMZVaRUAQRFW2b6dsvf093/0R9OojATczrxRMzBmtsNmONq0+oyyLLR9q8eaXOh1z7vYA+WvcKO54rC6uUDbyWLex9uuvTD2vOYYlExRFqkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHYV6UoFxbge8x6HPxyREZO4svej8bIot/H+LI4908c=;
 b=EtPbMffxugP1nvLn0r1Yl+CCe8IpX/HTlAGcRLt3XE+98I+HTLrp3vgppCLYLQWCeAScpigbjJ5yKpgx/fAxeLmV42aAgWwYYCbsYZ95J0HtvgQo+3aCJMhs8rM2za5i7k0zTRm7vrqbaSISPSbcXIehswp2lASas1b+q9Hfk3ZJKNdXff1WsxcLUiyafhulQiN3F5kcIthw2hqCTtmEewTph4SIe3lJfu+LsGvC2WTlA5YV4LP65uA0XzkyGW3Dq2zUKhtFHLkq/cyxAzvRnoYWolt/7MOcaIB0AU6bKGsqxkUMBw5RyIgJ943oqgQWUD8Ybkmsrrsc6TwTHu8a1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHYV6UoFxbge8x6HPxyREZO4svej8bIot/H+LI4908c=;
 b=bx7O3yCXJlyVhs7Q4FtRBC9m+6nhF6cfsUchBZO9mZEbr8VMirtHRob63vB8THYKO3Cw/O3snz2Jk63Q5rj6Evbx3p8eK5eN90xxaSR+QLo2nl2W4Gy5AAL2e+vw2c8N88y7xh2hQVLc5yYX6ROCfNNvgRP6PmIs2kPFRD36psM=
Received: from CYZPR05CA0038.namprd05.prod.outlook.com (2603:10b6:930:a3::29)
 by PH7PR12MB7968.namprd12.prod.outlook.com (2603:10b6:510:272::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Mon, 13 Nov
 2023 05:31:34 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::9e) by CYZPR05CA0038.outlook.office365.com
 (2603:10b6:930:a3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Mon, 13 Nov 2023 05:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Mon, 13 Nov 2023 05:31:34 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 12 Nov 2023 23:31:31 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH v2] drm/amdgpu: Address member 'ring' not described in
 'amdgpu_ vce, uvd_entity_init()'
Date: Mon, 13 Nov 2023 11:01:13 +0530
Message-ID: <20231113053113.2057704-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112042559.1631414-1-srinivasan.shanmugam@amd.com>
References: <20231112042559.1631414-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|PH7PR12MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: f8da9529-c711-4b29-a907-08dbe409cc9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1t5+iE7G2Q3VBrRhT9dZaF0TQ6MhHTbk8CxC91J4Kj41dP9snq1Szpf1/byIBLu6LC48X/ibF2lfMb4XbYGFksySnYwRFvBkSqX2986upZko+HOY60pYe/tsQ0iPObqdzHDuNfZaGWxO3/9vdvrboaewYXQUzxsfEE9NrgUc/Juss+ZuiXKmWbEez6Afz2ILJ+tQgCnmz0FMFlH1ntEyDQxi43Bz0gZ0D/mlCZk7rG7cvnZ8C8sW4HDLtb56l/DqjvKgnaE9/kCQcLf3gnr3LooOm198eo2iZwfQkOMqeL0ohRdTtQozMKY4IS+Cm61X64qVCROdeyCIN/6hg6yrpKeK6vrf3g6SSA+rMZg+5RCArK7ZS1sxPjsLBgB1XYo7zl1ejXD0h2E5Pb/DScnuvaUbaz+BXM4JZ5xtLq2Gs4w1u3DbCxEVQgyVssX+hKlKXAKvG4fEaxf6zMxMgGtJcU/0ydOzZ7Rt2psa4GLdwpRmY27aRm+5bZGkpUaaVeBY1TzQNsS6/uWb1kFpSGVdaRnjYYzkAENDruuC6KUTKYzYh47eLbDxpDFuemHfq92CywH6DKMG8fb4CEE7Kye/6VVozU6jec5e3Lm/74bDOY3ibALwD6A/URNAQtRCpuchH6qtJGWx7Qgb2pvcf1VT252vRGKJ8Psww4sCl0K7jlbmSxAHfbPtYS749aBOZs5OpqfLTNm+zylDpx4tIpmgW49ZddWr3iK6fDft3f4b1NI7/zkIWMoOjGOm/cxkeXzIC9JGH3Ux1XSqq96l93baVA60hDNoxAZsW0tOzZsJHSe3hes/Aa6Qe8LOQDgqXNw3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(64100799003)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(336012)(426003)(26005)(1076003)(66574015)(7696005)(6666004)(2616005)(36860700001)(83380400001)(6636002)(47076005)(44832011)(5660300002)(4326008)(8936002)(8676002)(2906002)(41300700001)(16526019)(478600001)(316002)(110136005)(54906003)(70586007)(70206006)(86362001)(36756003)(81166007)(82740400003)(356005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 05:31:34.0973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8da9529-c711-4b29-a907-08dbe409cc9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7968
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following:

drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:237: warning: Function parameter or member 'ring' not described in 'amdgpu_vce_entity_init'
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:405: warning: Function parameter or member 'ring' not described in 'amdgpu_uvd_entity_init'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

Updated ring variable description to "amdgpu_ring pointer to check" (Alex)

 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 65949cc7abb9..07d930339b07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -398,6 +398,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
  * amdgpu_uvd_entity_init - init entity
  *
  * @adev: amdgpu_device pointer
+ * @ring: amdgpu_ring pointer to check
  *
  * Initialize the entity used for handle management in the kernel driver.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 0954447f689d..59acf424a078 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -230,6 +230,7 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
  * amdgpu_vce_entity_init - init entity
  *
  * @adev: amdgpu_device pointer
+ * @ring: amdgpu_ring pointer to check
  *
  * Initialize the entity used for handle management in the kernel driver.
  */
-- 
2.34.1

