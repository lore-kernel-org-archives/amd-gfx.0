Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95364C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664AF61184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 664AF61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD9CF6EA7A;
	Tue, 21 Sep 2021 18:08:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AD456EA8A
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvUjnFt0XNiTCDsXEereeDclg4xCqNwFSLVJgOFFIXMlnFp7PI2g9OcgYdqjZjLpy++uQ5lEUMme5L1IKjH83l60QsBIBDBC9/horXqPNF6xlSaXPa20QvLtmDDpP4AN8lvcRe9QgfgVV+WDzCkKyJ91d+XnWS1Q+zfbbiebA8AKWT+EDPy6xMI8hm5FrFrrpr1FrwAYOywTrXBLpN+Mwv+M34KiTrjkOP+ctDIx5px4RiZBB/d6kEjfHWd3215fo+sI+x/o6LdHwHY8ifxU8GBCgQLr8DX4jcM8mFFH2kOf5x1lJtSMoF+T4n+APms0COD5i5RD/ZhNgzuT4lPB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=EhAjkzbBfhev57LxQajmltbOwS03H97phrZ5RmbK5dI=;
 b=f8RfsUZM5lwcV2A5H+psMRdROWS5IbT/Xn5udnp9olZMsaB263r/7uI4yIzFcWEIZ7xouaB5/pkvOTiTjSBgH2NcBHCUBjIDMsBB+N4Z/TfdDxTqwrWRLl7B8CXvwuwuKV5I74aCBBUOQyU64LMBWN2a2Mz2Hk2UwxEOy97Rv0h95YuRz9qtfop0Ezkro5djPzmJjyY2SEhPlU5fP4Wp56F/ZgJF5MPBu1aXWeExTmeVdI0YVe8QeKvBd8SphuxPouu8tWXKAa5eusB39GyDN1/358/KykKNrftXVgPADT87ry1iZvFS9n7kXuWXxOE3Y85chLtE5ps62NykfnnSzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhAjkzbBfhev57LxQajmltbOwS03H97phrZ5RmbK5dI=;
 b=DWadFc9ZlYx/11xuz0Qh+3kdZ5Q1l8/KncbCWk+OFvOR4oGWpS95u5GL3EOUcKLxxD3R/cjSZYJHBMZpSFVF639m4pN3h7aNYMC/17+IfG8QO4jdwsMqW1du+nvC4J/hnr8vgJFS8WwViKb2yKRUCQbeyp2dO80tSyJHIEsPUmY=
Received: from DM3PR12CA0047.namprd12.prod.outlook.com (2603:10b6:0:56::15) by
 CO6PR12MB5428.namprd12.prod.outlook.com (2603:10b6:5:35c::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 21 Sep 2021 18:07:58 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::f) by DM3PR12CA0047.outlook.office365.com
 (2603:10b6:0:56::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 18:07:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 37/66] drm/amdgpu/display/dm: convert RAVEN to IP version
 checking
Date: Tue, 21 Sep 2021 14:06:56 -0400
Message-ID: <20210921180725.1985552-38-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ba33d1d-9c28-41f1-e629-08d97d2abde9
X-MS-TrafficTypeDiagnostic: CO6PR12MB5428:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5428CE1E862B28E1DDF33E69F7A19@CO6PR12MB5428.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:323;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tAekXTEGziD3h4HEXq7S5NIdORsVDnB0wvjrCKlJ7Y8AujwmhTsILKhOkMInYfkpqWG5jnEmcpR6sbslrKQMu09Y9epRVEWfYqQU5WmC8qwCbAwo2J73fqpeUjOXf7LZAPxlN70wPjMrZV3CDng0aEpb9aLuGPZggcGU1AIMcmco1xho8A7jJWBuObcGfCGMSlfrdXjPfV02ASuzafPnOYyYINOoUQ/A/cAJpEkjbtVtSxWlfjoCaHlRp4zus/JXw3ZUxLMUhzW35xud1WdydiNTZNVt3sc6l/nxh3KMPp9ULcsd0l6n7vwQjhvSX32WjajN9ZZFVfMojmqbkQjWPdr3DAHsrsf1wLYbj6iriQsTT0g0/MAyJvX1Q25EBLthgFnhnOcRsn6J6j8zZu62SEaWlHNrVeQ42J+kFTwwOt9a5ediyiD19spF6d8KwOaKPjspV1MKgxppbsDGxHbHZNgtUJ5vgcQDLSNtIZ7RHJQYk+vbVhMoN6jsAeHo+E4KqwwMR0PQ2Sm5mzVeRoghBlW01HFj0eVwQ1vymVmKmZ6N3I2dHys3nRde80mkiyV4AWxmkSKf0EjkABsQpZJqUyc8CCkrfGRjoH2J8BH3renEyj7LZJ89/p4rTakv6Uh3lWCZ2Jr9J7df78bg/mJQqBTW+7XbycRfUJXmdybAYcfCkpKTlu94jXkUBFPutCyM4zbl+DbLLuxbSZEUS8MTfWM4lb9ZxAT4mcenvmAeFrY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(1076003)(83380400001)(26005)(7696005)(82310400003)(8936002)(36860700001)(81166007)(356005)(336012)(508600001)(8676002)(316002)(47076005)(16526019)(426003)(4326008)(2906002)(186003)(36756003)(70206006)(70586007)(86362001)(6916009)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:57.7097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba33d1d-9c28-41f1-e629-08d97d2abde9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5428
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

Use IP versions rather than asic_type to differentiate
IP version specific features.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 +++++--------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e189d72f08e9..519930fe79a2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1341,7 +1341,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	switch (adev->asic_type) {
 	case CHIP_CARRIZO:
 	case CHIP_STONEY:
-	case CHIP_RAVEN:
 		init_data.flags.gpu_vm_support = true;
 		break;
 	default:
@@ -1351,6 +1350,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 			if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
 				init_data.flags.disable_dmcu = true;
 			break;
+		case IP_VERSION(1, 0, 0):
+		case IP_VERSION(1, 0, 1):
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
@@ -4183,17 +4184,11 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			goto fail;
 		}
 		break;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	case CHIP_RAVEN:
-		if (dcn10_register_irq_handlers(dm->adev)) {
-			DRM_ERROR("DM: Failed to initialize IRQ\n");
-			goto fail;
-		}
-		break;
-#endif
 	default:
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 		switch (adev->ip_versions[DCE_HWIP]) {
+		case IP_VERSION(1, 0, 0):
+		case IP_VERSION(1, 0, 1):
 		case IP_VERSION(2, 0, 2):
 		case IP_VERSION(2, 0, 0):
 		case IP_VERSION(2, 1, 0):
@@ -4360,13 +4355,6 @@ static int dm_early_init(void *handle)
 		adev->mode_info.num_hpd = 6;
 		adev->mode_info.num_dig = 6;
 		break;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	case CHIP_RAVEN:
-		adev->mode_info.num_crtc = 4;
-		adev->mode_info.num_hpd = 4;
-		adev->mode_info.num_dig = 4;
-		break;
-#endif
 	default:
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 		switch (adev->ip_versions[DCE_HWIP]) {
@@ -4387,6 +4375,8 @@ static int dm_early_init(void *handle)
 			adev->mode_info.num_hpd = 2;
 			adev->mode_info.num_dig = 2;
 			break;
+		case IP_VERSION(1, 0, 0):
+		case IP_VERSION(1, 0, 1):
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(2, 1, 0):
 		case IP_VERSION(3, 1, 2):
-- 
2.31.1

