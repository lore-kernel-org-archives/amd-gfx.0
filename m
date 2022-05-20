Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE30C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 15:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C86E210E184;
	Fri, 20 May 2022 15:09:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B31CF10E184
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 15:09:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5t5KyBxNXd2fRSatHPZipamMv5AxjcqpkWcBHGZATS8AWkWfhuMvn0NdPVuOydecUv1ahPBbE8zf3wSlQnR91s534oZb22zRyhf8Tv+3ZdhR1++0sEC16fRFbb5+BTX0y6rV6dncn16na1/dZIhR91W1+lxFDdzKrVY5+mzxSXt+0jq4F1XJm8jKWj55hgOKSrloyDX/ItoKdqIlwYzb5qrFsZEpoNKiuio0eEB9JxE27/9J8smUZu4DJ2mQghPC9SbQe1EyoDXm/MNf54Q2+wBLdmn014V/MZjzeJIuOskaNY6s22lnaEPSM4xWotk47O/Mh9oLzJ0WYueTswIgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jv/xQDC0nc0GSEkdgVvE2EZ2I7hM6HZ9g4OVpB3CAGw=;
 b=XnI0KfsxOmroxbXyvOg10nwogFt6yB3e9A9vjqUtUzjfgkaYqIdVkAnAx6uVEtahZX/1UfsuP4jj/0F+kqGQcCrLl4gohUyKMe6yJZ02RM2MchflAZycwYLVBplYpC5s2bILyEtIB7Tq+8MipwLkZTlsMLhf5KI7Ba/YAE01o+MJtzanxyuUvvfFt+mG5Gxiqs5e4l7TE5vomdsqfJHjl4B8+bO09HU1dkFTlG+tECIWBmGrB0HG8+3xx9SqiPJYhKqk6JBTIrDyT1L+rJbx8pEycMNH4tHNEs188MvwnojKo4qvOMrKgxofUi2NOqUyu6wtfoW2hfvYM5n/625HHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jv/xQDC0nc0GSEkdgVvE2EZ2I7hM6HZ9g4OVpB3CAGw=;
 b=UpOzUsYVSfK46v+yYalaxeqRjkCWfYPWhvMPMYfW6C85KP1pGRFA2ABqWjGmDv1e8TkvZc7GFv3mcs2OOW8YJMoOfHInKCZVWsGpy/2kl64e3l5qwpJEg2VQyjqhmabs4ptCK3C2QQnn2VuA4q3SIfA5/mSk7KK4vv6tcURXiyo=
Received: from DM6PR13CA0061.namprd13.prod.outlook.com (2603:10b6:5:134::38)
 by BYAPR12MB3559.namprd12.prod.outlook.com (2603:10b6:a03:d9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Fri, 20 May
 2022 15:09:27 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::2) by DM6PR13CA0061.outlook.office365.com
 (2603:10b6:5:134::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.7 via Frontend
 Transport; Fri, 20 May 2022 15:09:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Fri, 20 May 2022 15:09:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 20 May
 2022 10:09:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Adjust logic around GTT size (v3)
Date: Fri, 20 May 2022 11:09:12 -0400
Message-ID: <20220520150912.762831-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dff354b-c06a-4ac1-c1a6-08da3a72bb2f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3559:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3559660734340CD2C9DB5F9BF7D39@BYAPR12MB3559.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQVqYDP5iTFj5ayKtpF4acpk95uIbIrn9JUdW4Zw7QxOYY+z+nSut8FDbnJw+9lqOIdUApOxQ8mtTSAmg84T8TefnSq/dfd4khDmILhlFgXJx6ncgIgkrpQLhxDSQdBjm2ld7AUFRuD2KRfQN1dHsNDtZSQ0W5jYg6i1KkhDJ9eDZw6hZ+zc+QdbuvE1BkgDB0vGeepOCeP1ej/rS2zTSbQUVE8AH/QMR5gUUl6Y4vhbC/07kj6wM8wFLNHndfN+022SqiW4gm/XA3yausCIXRT5F3gU96VB2h4OBG5FS718zrUSzVuR62RlkjqkffPZOQY4c05kTydD0mzPleEZYuu5DK2KtTxjEIzQuWVa37gnyi9tmcCiNlpLQh3PpYKxLUOgoFo9WPSWblpUqVtACedWeGXpcqIsPB+wGgBQdQxw0XV1nTE6iB5W2S0XzJlzkfIpP1x4HKbmn+F/RJWkv4Hp8HvS3OQxT7AhaB9FMBsGvmI3Y314+/96AP0boZhGM0LSt6HdgjXRhpmBeEv+zkLgQLIYWuKj5ecfaahYFe+TN2VZbkrQa/WDLJ/lsUCsAkbBCZsAw89Jj8+53wPWp1ffr57BBqK8R6S28Et9zqYIGolDis6Wwb+gIBP6n8CBs5xfmLQkJzPkJSjuf3dvdvXn2zzgBAsCwa7RyjPMz6VEOGWZjGrH1bHXYVjqeEhnXwlzmk7dJxOWm7mFbdzJ+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(356005)(508600001)(81166007)(316002)(86362001)(2906002)(6916009)(8936002)(7696005)(82310400005)(70206006)(8676002)(2616005)(1076003)(40460700003)(47076005)(426003)(336012)(186003)(16526019)(6666004)(26005)(36756003)(83380400001)(4326008)(70586007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 15:09:26.6560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dff354b-c06a-4ac1-c1a6-08da3a72bb2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3559
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

Certain GL unit tests for large textures can cause problems
with the OOM killer since there is no way to link this memory
to a process.  This was originally mitigated (but not necessarily
eliminated) by limiting the GTT size.  The problem is this limit
is often too low for many modern games so just make the limit 1/2
of system memory. The OOM accounting needs to be addressed, but
we shouldn't prevent common 3D applications from being usable
just to potentially mitigate that corner case.

Set default GTT size to max(3G, 1/2 of system ram) by default.

v2: drop previous logic and default to 3/4 of ram
v3: default to half of ram to align with ttm

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index d2b5cccb45c3..7195ed77c85a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1798,18 +1798,26 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
 		 (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
 
-	/* Compute GTT size, either bsaed on 3/4th the size of RAM size
+	/* Compute GTT size, either bsaed on 1/2 the size of RAM size
 	 * or whatever the user passed on module init */
 	if (amdgpu_gtt_size == -1) {
 		struct sysinfo si;
 
 		si_meminfo(&si);
-		gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
-			       adev->gmc.mc_vram_size),
-			       ((uint64_t)si.totalram * si.mem_unit * 3/4));
-	}
-	else
+		/* Certain GL unit tests for large textures can cause problems
+		 * with the OOM killer since there is no way to link this memory
+		 * to a process.  This was originally mitigated (but not necessarily
+		 * eliminated) by limiting the GTT size.  The problem is this limit
+		 * is often too low for many modern games so just make the limit 1/2
+		 * of system memory which aligns with TTM. The OOM accounting needs
+		 * to be addressed, but we shouldn't prevent common 3D applications
+		 * from being usable just to potentially mitigate that corner case.
+		 */
+		gtt_size = max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
+			       (u64)si.totalram * si.mem_unit / 2);
+	} else {
 		gtt_size = (uint64_t)amdgpu_gtt_size << 20;
+	}
 
 	/* Initialize GTT memory pool */
 	r = amdgpu_gtt_mgr_init(adev, gtt_size);
-- 
2.35.3

