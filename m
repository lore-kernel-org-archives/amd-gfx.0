Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94223C001DE
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 08:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D7F10E167;
	Tue, 15 Aug 2023 08:43:04 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80D1010E159
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 08:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmJZDow4+f5FZbSi6HRvk9L2tCGr1PFcRODMQLKYi35T2YuTIS8np6+aDVlG6KyqGGq/8GQ8yTVMmqdjoKgZsVO+fvqYAXQq746fozzlXsfY1dg8YgAiNmECTGHpa4+zdC6QIOfeuaslqEIlpzvG4UHIPfAn8uYKr6yQDzegDF2oyhhZdOZRKQ4Z2j5ZnqwGahzGZoG372VUw3krOWzFtjWZ5AuMvGluefSwbvIxtkyxxcl1HLOSzUPtzpxhuydVTvnvj0un8+X20doCtVtqgwnYdJJ1xT/wxVMN1pY+0wnYZLFeDNhQK5UHSXXYqTx6uweIfP6SWTAfIL3018kKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzrrdsQzl2ps/gk3A0oO81JeB4ppufOHBNQKa0qSnwU=;
 b=LQa++9Xeve8V1Xp53d1MgPKcDps4UfZeiU/BgCUZG7ma1o5X6vROBcnZrJsQvV8oIa2ibc6LiMlFidxGYSE4rMras+opLMfiIy7mVTryeVbd39xAPOvOpO+HWq1+Oad62c58ImcdbK2ZrQvysAIvo6Fc+nJCaG0daMKeoUukvJguDRqx2IxpiRZvbNvfE67cMhNK3rRc3afooDMQcUPORVy+DW1iLRS6bx+BVvd5jITKgV3FxytErD+etnqKfp7y77G0XZ+9nDcDRNrkGAaGGwcNvb1cr0GlEgBgMTABNgNPZp0KoFdkqm+UkOZ9S0nCCkIHSd+jpwQdcJ+z41X9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzrrdsQzl2ps/gk3A0oO81JeB4ppufOHBNQKa0qSnwU=;
 b=gKG64ETm7K/w+OfYUkZGUV0W35Ri3bCCu9wPdGn6q22haPMBspZxl6Nii7YL1WsAsTRSoqk2QIQzb6tOSPFN2RaFfnyPIU+JHFeUnntGPbZS3GkWFA6kBiuNBCfw+Ez5yf+AHUSep7yL0nKdKdYOxS6ELbkSw4799kX+w9NWxZE=
Received: from SJ0PR03CA0197.namprd03.prod.outlook.com (2603:10b6:a03:2ef::22)
 by CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 08:42:58 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::9) by SJ0PR03CA0197.outlook.office365.com
 (2603:10b6:a03:2ef::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 08:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 08:42:58 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 03:42:55 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/8] drm/amdgpu: revise the device initialization sequences
Date: Tue, 15 Aug 2023 16:42:25 +0800
Message-ID: <20230815084231.3229009-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815084231.3229009-1-evan.quan@amd.com>
References: <20230815084231.3229009-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f5a527-1f71-4597-5dc1-08db9d6ba07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CglvpqVw5QE6VTrGP09DFD3L8UvEftEwd3IKuN1j/ABL8/sB6KYQj46IsPGkMRleMqwfqiJBJVElYC5DHX/DKnuaaXO5js7UsCvq5BepeJDGKCgljSohp11HOxkBtcArhqlJt7qZJ16+nXTfXLVQ8WocRfd8WnZYD9MtbGNYCiU/KG3pXornWLNZM+7RkhAFo8twPcrxg7FdHDxB5n2XjQysQ5gwULi1+zuYLM5kzJnZ2nzxSvoxMgtulRLyaBkGBagyh59vIcwIeyaDEndBT2hLQvvzuEIoDGK4IQTaSvF3q4iTB5V7krmZzReKpuu8j6E1uXCQJp969bDYFGyONDwcF0sN6ESX1g/F+Q19v/WSJ6WqcIJBJH3oXq97nTRMt6t/fPxGCU/HdRsYlsfJY2ThAeR7y148mpeJn0Qi8t68admWSFRxonmPoHCXLbckwEEtUh/ISCi+5UPPwvLwGbHYBT55VgtK7MIbTQ84wHSLJy7DBD5tnJHFotscxUkDu7jJ/Y38zbLWeGA5K57hiCFQYv2RqOEQj4zSH7yw6NFrORJ9rgdnoEsfC7gpWmopaAiUs19X1uvs/7ZJwnzzJUXayWsSYHcharrNh7XdcZxfYpY7Hy8hAVbAhzAYAnrpdP3d+SLLVS/nYfFnK8L1LfLI1plHfGG0jCV/hcWzGmyCqp1b1FOCgUX4wH99G7h/v8HkQe1QWahoJU1ywPhpQFm600JxvvFaKVqSmU3PcS5mkfQTsc1RTTQMi7xJ1ABV/G5xpAPpveZXoEPDZRk7+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(186006)(1800799006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(6666004)(7696005)(478600001)(2616005)(1076003)(83380400001)(336012)(426003)(2906002)(16526019)(26005)(54906003)(41300700001)(6916009)(316002)(70206006)(70586007)(44832011)(5660300002)(8936002)(8676002)(4326008)(36756003)(40460700003)(47076005)(36860700001)(40480700001)(81166007)(82740400003)(356005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 08:42:58.0930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f5a527-1f71-4597-5dc1-08db9d6ba07a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

By placing the sysfs interfaces creation after `.late_int`. Since some
operations performed during `.late_init` may affect how the sysfs
interfaces should be created.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 77eb18447e82..b1accf5c1982 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3860,22 +3860,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* Get a log2 for easy divisions. */
 	adev->mm_stats.log2_max_MBps = ilog2(max(1u, max_MBps));
 
-	r = amdgpu_atombios_sysfs_init(adev);
-	if (r)
-		drm_err(&adev->ddev,
-			"registering atombios sysfs failed (%d).\n", r);
-
-	r = amdgpu_pm_sysfs_init(adev);
-	if (r)
-		DRM_ERROR("registering pm sysfs failed (%d).\n", r);
-
-	r = amdgpu_ucode_sysfs_init(adev);
-	if (r) {
-		adev->ucode_sysfs_en = false;
-		DRM_ERROR("Creating firmware sysfs failed (%d).\n", r);
-	} else
-		adev->ucode_sysfs_en = true;
-
 	/*
 	 * Register gpu instance before amdgpu_device_enable_mgpu_fan_boost.
 	 * Otherwise the mgpu fan boost feature will be skipped due to the
@@ -3904,6 +3888,27 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		flush_delayed_work(&adev->delayed_init_work);
 	}
 
+	/*
+	 * Place those sysfs registering after `late_init`. As some of those
+	 * operations performed in `late_init` might affect the sysfs
+	 * interfaces creating.
+	 */
+	r = amdgpu_atombios_sysfs_init(adev);
+	if (r)
+		drm_err(&adev->ddev,
+			"registering atombios sysfs failed (%d).\n", r);
+
+	r = amdgpu_pm_sysfs_init(adev);
+	if (r)
+		DRM_ERROR("registering pm sysfs failed (%d).\n", r);
+
+	r = amdgpu_ucode_sysfs_init(adev);
+	if (r) {
+		adev->ucode_sysfs_en = false;
+		DRM_ERROR("Creating firmware sysfs failed (%d).\n", r);
+	} else
+		adev->ucode_sysfs_en = true;
+
 	r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
 	if (r)
 		dev_err(adev->dev, "Could not create amdgpu device attr\n");
-- 
2.34.1

