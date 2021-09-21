Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A07C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096E460527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 096E460527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C4316EAAF;
	Tue, 21 Sep 2021 18:08:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E4906EAA6
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBUPw33lxqliVCOAFdAHzlZzaPtImJIQbbm1Ou8Sch3iKy6J83NPHma+RLJlvnCinQDwKx+lFHf8tcgnHeFQiM9v1N2bDjEdb8O/y80cAlyFLbF1eXoDqE+diNbscJUPWef9Fiueed1BpM29v3CHvun8xKCJCIbudYdGl+afctFEFd56EAYEF+XAsAeIeuopKUKTrLSmobnbdEE1Vjn9LLqvEqcftZH7LzGVDWpw6fYXX8BGj63Jf3sFeny5iJoFPq/brpOvf8SoVjNZfxtXxmcQnBPDQcyy6aGn/ItbW6NvHbqWhDvfE60ux64AUJOeQrqs+n2lHj6fuZ+OIX9RNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Jpu7hZ18K1Udo6/Emx6Hoi1UK+xCCpnS6FTEeW8hV/M=;
 b=JBSs1I4skqgIopDVtmJU/A+72xrqeWTe+tzCUtXj/cQY5r++sZr5uyWC/rHjnTDhTk9CAZ/saP36tN28dQBWWUSeIgGk7Ae3JNqmyf/SfBIvttwZ3KMfuK2GNMRZ0CM9gWIhoHz4mPfxZv/Dl/Zd33dza/cEyO+zcZ8u43zWM2OXV9YSeFVYzUOJTltOdgXfypY0Tw6cMvRNGEfPQXFnqgKKo0Z+hXFJ18g/O47iKCofGlCtqNoaclxyOCiBmztAQOHYj/ik1WJOhV76VQP4mdSmW3LwZPh4ivuGKuCBKy2QF1AiLErMwNv6k/bLIic6mWTI+d7HHAiPmh2eOsungQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jpu7hZ18K1Udo6/Emx6Hoi1UK+xCCpnS6FTEeW8hV/M=;
 b=LgVX3/lCgKBqxa4K9/Hq/KRWqpco+bJ+yrYQ4rlbe2O8WKG4lEm6+N3GHPkG4uqygidRlNruiZTDGxl5z0NblnUzS0+KEB71d/P1FmAiqKGi7xb9UGAhBHKniFOeVGem7cMACfDLpEW7rMNYsr0Ii+FrvNhrJTXSHVFrb082/TQ=
Received: from DM3PR12CA0059.namprd12.prod.outlook.com (2603:10b6:0:56::27) by
 MN2PR12MB3951.namprd12.prod.outlook.com (2603:10b6:208:16b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 18:08:07 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::d4) by DM3PR12CA0059.outlook.office365.com
 (2603:10b6:0:56::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:07 +0000
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
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 18:08:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:08:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 55/66] drm/amdgpu/sdma: remove manual instance setting
Date: Tue, 21 Sep 2021 14:07:14 -0400
Message-ID: <20210921180725.1985552-56-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 25a2f082-ab11-446d-9031-08d97d2ac3ae
X-MS-TrafficTypeDiagnostic: MN2PR12MB3951:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3951C16472932964C4DCF96FF7A19@MN2PR12MB3951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xcxRyppQxSGWrvMXxYpfz0V4P326SXMQOjlZo32sWwv/70FHpBPN5tBd78M6HpP75ys83ZSY9aH3jOTXNgfqjKLBzbFKIdwvqTt71wCjrCZs6uIGe52Ci5EW8DkEBpuTUvwojT1Gmq7/fjSXZibEPWoxYEznqdKH4CTXObd3ea4yMpPi+5nmLFbF7uD5CVPkgPrnhtXW3bG6hPLsHnvnasYsIo3Qzjj5+ImcGb4ux3vCgve1wfXFhWGbez7sd5qQAOhksOi9VBunPPH8xD0K+DjZLomTAQqU1Wr0F0rR3M61cPi7Zwmk16B1HzGgfql8MZKzpOgHTvO+pGD9FJJ2Cwk+Ll1gugGkO2vpCgdbwt0L0ukTfGBcGRFTGd9qtZ/V8T5F/A6SEP3eJJYskDVCQEfNz97w/K+p8GAIcMiwq+xmvIdxaklm4iDT8QYc3WOhErE73l1u0gp4T4p3r36yc4rusb1Q/ljdwdPb8aT2SSQDlKVB+o9kzGPdjX37Ytnrd3s+GEkhdlSIHo30K5MqUcjjZAyFhVcp6K6SBDV75t/0beoZ2OgnbQnBJ7sX7UJ65L39m5kKCmoQWTzCYk6upaBFX9w2VO7TBa6qOpT8g/KL7mcW/zQykarlXJSNQeK7t+GW/J6fOtf5EgvsU3JDeztq+RihbBv/uMj+1PFY31KqtDpNyA4N9lvIFrPRi4JDBy47ISnQCITIQspMFZmpciC3Bh64aZ5h/+USVDW7iJQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(83380400001)(70586007)(82310400003)(7696005)(26005)(426003)(4326008)(336012)(508600001)(2616005)(36860700001)(86362001)(36756003)(81166007)(186003)(6916009)(356005)(47076005)(1076003)(16526019)(5660300002)(8676002)(70206006)(6666004)(316002)(8936002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:07.3872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a2f082-ab11-446d-9031-08d97d2ac3ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
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

Handled by IP discovery now.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 17 -----------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c |  2 --
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 17 -----------------
 3 files changed, 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 3219dca3e44f..cb74f8c35d0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1856,23 +1856,6 @@ static int sdma_v4_0_early_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
-	switch (adev->ip_versions[SDMA0_HWIP]) {
-	case IP_VERSION(4, 1, 0):
-	case IP_VERSION(4, 1, 1):
-	case IP_VERSION(4, 1, 2):
-		adev->sdma.num_instances = 1;
-		break;
-	case IP_VERSION(4, 2, 2):
-		adev->sdma.num_instances = 8;
-		break;
-	case IP_VERSION(4, 4, 0):
-		adev->sdma.num_instances = 5;
-		break;
-	default:
-		adev->sdma.num_instances = 2;
-		break;
-	}
-
 	r = sdma_v4_0_init_microcode(adev);
 	if (r) {
 		DRM_ERROR("Failed to load sdma firmware!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 2ab670c58520..d3b01d2977c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1295,8 +1295,6 @@ static int sdma_v5_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	adev->sdma.num_instances = 2;
-
 	sdma_v5_0_set_ring_funcs(adev);
 	sdma_v5_0_set_buffer_funcs(adev);
 	sdma_v5_0_set_vm_pte_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index c5252f12eee9..92f29beda3b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1209,23 +1209,6 @@ static int sdma_v5_2_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	switch (adev->ip_versions[SDMA0_HWIP]) {
-	case IP_VERSION(5, 2, 0):
-		adev->sdma.num_instances = 4;
-		break;
-	case IP_VERSION(5, 2, 2):
-	case IP_VERSION(5, 2, 4):
-		adev->sdma.num_instances = 2;
-		break;
-	case IP_VERSION(5, 2, 1):
-	case IP_VERSION(5, 2, 5):
-	case IP_VERSION(5, 2, 3):
-		adev->sdma.num_instances = 1;
-		break;
-	default:
-		break;
-	}
-
 	sdma_v5_2_set_ring_funcs(adev);
 	sdma_v5_2_set_buffer_funcs(adev);
 	sdma_v5_2_set_vm_pte_funcs(adev);
-- 
2.31.1

