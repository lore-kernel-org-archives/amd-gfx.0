Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3171BC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 04:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD41F6103B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 04:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD41F6103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 721C1899B3;
	Mon, 23 Aug 2021 04:51:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0EBF899B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 04:51:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+owr/FGl5fPg85PbhnSYRsbUmBdVXYf1KQQ8hrvRxznf3RwMUeqcuX2spjWn3BEXwz/Eu6XSZnWbFT9Fi3V6BWUsSegoGbkeMb3Xn+2SvJ7npan3vmeoQmEMzqjsN+tjmvTWkr79NezlaYna12Y3uJwf38MVPWM1vfFYLUJDiwZ+AEgqSs9YgR5n/y1oxUspnzwmxvpMh7iOVY3yJibtzkZrYrOh4U+sc3gPsOOyuPNFYkjs1Qn90alkuhRPHMLkjyxZAdLbZmiPHTOS74ibrlb6Qm9kb0yMgXYGTyHNhirT9vd4xpMiYeazU68RYWb+1y/0dn/mcV77x98j6dkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lR7IeLtgndspdIywJ3FrWUHPxxv1SDg1Tv4Q2RINX3k=;
 b=GvsjqFnSPFcZ1be0y7FQE/clY81OCAsWamU6+ObdT0g2jMlM+wt+cW/FV9hxisH6AhN8YNlWJetHTCXDTsdCOs1j7sRaOO9vF3ipIPBW/Jp0oI8UDmzwia82m06j9eiremR9dO4Ej/cMxmAJoTlKGOtQJHvSA67jGKa9uVcB45X+MfoSpu6R1mcHIr4Rg5dDd9ZG3xNDmOplRpIeimC1mcX6EYAHsKUaZ2EOqQxy/OAhgOrx/3EklCDJj4NS+B2NiypLrw6BxkTpfQDRefJAU4GxNIwisg1UMFIOhQsaPyfgLHDx9PpO9+KRQEFd9D3bn7gmlrT7gx9vjBy4C9vskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lR7IeLtgndspdIywJ3FrWUHPxxv1SDg1Tv4Q2RINX3k=;
 b=Dpox7QW/DQ1Cs5HJ0bHD5bOA29gsZz3NqwH7wuTZCms7wRfp6igGELGwGTd0QFC9X2A/SkjA9/VTHF2vVNTYUXE6vSamMwI2gqkinrqoFYo9qfWqjHhPltXtmtb8vo1CCGLMM7eEOv8a7uST7ipCv26XR0LboNNwrL/rz7PS4pg=
Received: from BN9PR03CA0986.namprd03.prod.outlook.com (2603:10b6:408:109::31)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 04:18:08 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::43) by BN9PR03CA0986.outlook.office365.com
 (2603:10b6:408:109::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Mon, 23 Aug 2021 04:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 04:18:07 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Sun, 22 Aug
 2021 23:18:04 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Guchun.Chen@amd.com>, <Lijo.Lazar@amd.com>, 
 <James.Zhu@amd.com>, <Leo.Liu@amd.com>, Evan Quan <evan.quan@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: drop redundant cancel_delayed_work_sync call
Date: Mon, 23 Aug 2021 12:17:37 +0800
Message-ID: <20210823041737.48921-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210823041737.48921-1-evan.quan@amd.com>
References: <20210823041737.48921-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97384eba-561e-4e91-c7eb-08d965ed02d5
X-MS-TrafficTypeDiagnostic: BY5PR12MB4210:
X-Microsoft-Antispam-PRVS: <BY5PR12MB42108A566817E91C418FC6E8E4C49@BY5PR12MB4210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkohz3t3HYih91FHSiqWabdf5LGpdqBDrXVFuZI9sV6KpR7FahDq2qh0JQTPlRTEBx60xcMTmzegvkF2EpjEzmfHc2bzhQ0H+BfNl1fJ0KxCOC7DJkMAuX/Zpzyohzb14ZppJ4YRKP1gzhZGJq6Aquu9ne+bOfnVMX/OKrw72AUjaHbg8HUxnmGBiJ5UPOZHKwULDDvF+mZZpsb9dkWo9vMfsbZJPiFsErNMnjKh2RMoQHa921wGky75tto7bp/SQIiX8y0LwmMJFmMBNe7aOxKjqLIbHwk+/ypsim9RVEW9DPs4J06Vldt2TWrXj85QTLZFy/Jw93BA6sG+qHoMw2yzxn7NAgCGoLXWdmN5iOmokzt3GDiyyYSpvwaDpjJWld2ZwxmNLE/f0JARWwxxn34natM5zwYYGxGTqumvP0h3cehibM31NCgsV8hrUNrYdQidcKzyOwihhMXEWYI4aWp2U2sO8AkI1Itu704wLHC2av2gWuKpd/xCn63C+jZHkzOb2wEUDsojtOFz7viMpdmavWJ4ww3+yhvsVhJIQKJIcJe3B1bRAtoDiKU2FyQeDlmGYOYHv1LBnJtafSruAJhZXKJJ4NrpbwDdQfWPwJg8eBhpHZ7szRbmQPEvqzV6rQekcd7s89jXxOHounVkVQ5zpPMyHky1qefHJJZWJLg6Bi0E3aBxcEQzEEb1WBwOh8YCH6cHz0OVO8fZlaKV4IRwYIagafxj40LpK/E29k0e5PhYx1OCQxrmp7NdXtwCqghJsPigt/CXSnAusz6X2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(36840700001)(46966006)(7696005)(34020700004)(70586007)(2906002)(8936002)(86362001)(82310400003)(6666004)(70206006)(47076005)(36756003)(478600001)(81166007)(1076003)(356005)(6916009)(316002)(426003)(83380400001)(4326008)(5660300002)(186003)(54906003)(2616005)(8676002)(26005)(44832011)(16526019)(82740400003)(36860700001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 04:18:07.8425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97384eba-561e-4e91-c7eb-08d965ed02d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
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

As those _sw_fini() APIs follow just after _suspend() APIs.
And the cancel_delayed_work_sync was already called in latter.

Change-Id: I7f092e39242a1ffbc3c29e1fcd7bf31b769b0ef5
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 2 --
 4 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 8996cb4ed57a..9342aa23ebd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -47,8 +47,6 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
 {
 	int i;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
-
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
 			continue;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 859840ac5f0b..3dcd0c0dbd09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -325,7 +325,6 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
 {
 	int i, j;
 
-	cancel_delayed_work_sync(&adev->uvd.idle_work);
 	drm_sched_entity_destroy(&adev->uvd.entity);
 
 	for (j = 0; j < adev->uvd.num_uvd_inst; ++j) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 21b4fc48d33f..310a456090cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -217,7 +217,6 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
 	if (adev->vce.vcpu_bo == NULL)
 		return 0;
 
-	cancel_delayed_work_sync(&adev->vce.idle_work);
 	drm_sched_entity_destroy(&adev->vce.entity);
 
 	amdgpu_bo_free_kernel(&adev->vce.vcpu_bo, &adev->vce.gpu_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 84b025405578..1f21e8fceab3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -257,8 +257,6 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 {
 	int i, j;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
-
 	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
-- 
2.29.0

