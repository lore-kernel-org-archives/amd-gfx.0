Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA3AC54FD0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10C8B208E4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sqYv2jne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C8B208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B82F889ED6;
	Thu, 23 Apr 2020 07:02:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E87289EA3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 07:02:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFeit7LL1MATQyUlKLEfdoat0FnWg1Py63nspccRtRaVsQy2+fN9tpMWGiROnhqvmD2gW6GaP3sdFdGPu1RgNrn4kmbjURUIhnVDJmPEAbaA6DBekp4/u+2YMx5kkZtZuZ77UhPrA7vu+khYIbuixdvlTxJRnZOgtt/KEoSxkRit2+gaSHzj9bqh7+Oy7bk8rtiDqut6vy1LOCnI3GQmNfOrBN94NtTdaXxU0AwgPxMtQzrH+D22+bGRmYPcvuSZVrm1WClWjI/gx6FI7h9T9/irsb4EtxC+kASNvB/E2Oh6nmaCMPkW3tPlJqCCn0FocfMz8sTUKUFlmu0OwXLmkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BylIL7KeF/gI6vSivf7P9WxrI3fxDNA5PRo7H6hi+FA=;
 b=StShhcn76QAPRFm7LXqsHhGSeizR7B48yYr43A+QnW8PieGWaiUI87lXwJZyq2JvNzBxg85ocpGwdUOOgCxXZ622GfSYDIClqGMTcSfzHjeJ9pJmUyIhirdJS7db/ophv9wukVF4vm83WWJzIU0z100DnbPsoHkQeFkfIvIff/3orT31bUxuOEK4kl8OaLzpblVAwhZVh3G+Kk17TXB0NBL5DSgBtLygn7kMvfhLg6zb/6079CtIhNwJNJwjSOniOxnnqkqP94HDOxj7YtY/VamXtLEQllB2kSGzhgxnlajEtWN8GpjHGJ1OnMfQiLZBjJyi2XjBSL/Xn5CuEYcavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BylIL7KeF/gI6vSivf7P9WxrI3fxDNA5PRo7H6hi+FA=;
 b=sqYv2jneIejLbE+/ZpL1W2Ttm4GPwMTsKH5+bexj3f7BvSY0AK/tdBlpLz7YFLHdITTH/RXUI6e54ZnLPSS0D0Ct0gw5qliq7NknsFLGZrIkbWJiYw3+CxbLUaE7+ZZIYY4si2rdet2Vqfz/KjF5tEqGnJaWkpwzV9KutioGyaI=
Received: from MN2PR14CA0010.namprd14.prod.outlook.com (2603:10b6:208:23e::15)
 by DM6PR12MB2635.namprd12.prod.outlook.com (2603:10b6:5:45::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 07:01:59 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:23e:cafe::20) by MN2PR14CA0010.outlook.office365.com
 (2603:10b6:208:23e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Thu, 23 Apr 2020 07:01:59 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Thu, 23 Apr 2020 07:01:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 02:01:57 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 02:01:57 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 23 Apr 2020 02:01:56 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] drm/amdgpu: skip sysfs node not belong to one vf mode
Date: Thu, 23 Apr 2020 15:01:45 +0800
Message-ID: <1587625306-20704-7-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
References: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(428003)(46966005)(70586007)(26005)(2616005)(81156014)(7696005)(4326008)(81166007)(336012)(426003)(6666004)(86362001)(70206006)(2906002)(186003)(8936002)(356005)(8676002)(82310400002)(6916009)(82740400003)(47076004)(36756003)(316002)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe157e2d-fd8f-4b61-1747-08d7e7543778
X-MS-TrafficTypeDiagnostic: DM6PR12MB2635:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2635F78883E614AAE35AC2F384D30@DM6PR12MB2635.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 03827AF76E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lgkYL8cuKykb6G37/XRih+1GGBoaSR1k9cBT+tD38kcBg78vJaHglZy/WYY8GKyg4/h1xnGvBr7sgRMr7vi3jaqb4aOp3rAseV3fpzIVY71fJ/oWApV7y/0yK2Ue69xFAq6kv+xgUJChy0tABMP7FVCYdJt/ZlZDS6mFoBzW/eH6BwphY+HuiFXNwWuixgQjcZKrhc1X5w/10AEcgvpmKwoEEpnhoIJ0xmiRYxD7eCVkEon4nrzwYNQTUvOA6Fe9b+v3vzCBnhS0+f6BvCaknGNaBtYOzupSDCdBhmRzyKy5LdBLxqV5oBLll4TSTw8Q6QK1WKIHpDwxfb2iMjXBFst/hnoYqeA3wyL+kaEW5g74PV/e6OQp8HN+EgA3X7cRcFV49UGaOGH4kpp08gAgkFynEA0NnRXStug2EDl0oe+oFFthpwDuoYQ1U13tdWbBcvwurouCjSYfuKAsXui3uey4OKF1xNLkVgrEXMIWBfcjZQp/S/reApCpgBPPHLECHyGW282vOCM+qMrkkyGRbw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 07:01:58.9591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe157e2d-fd8f-4b61-1747-08d7e7543778
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2635
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 48 ++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 49e2e43..c762deb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -3271,26 +3271,27 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 		return ret;
 	}
 
-
-	ret = device_create_file(adev->dev, &dev_attr_pp_num_states);
-	if (ret) {
-		DRM_ERROR("failed to create device file pp_num_states\n");
-		return ret;
-	}
-	ret = device_create_file(adev->dev, &dev_attr_pp_cur_state);
-	if (ret) {
-		DRM_ERROR("failed to create device file pp_cur_state\n");
-		return ret;
-	}
-	ret = device_create_file(adev->dev, &dev_attr_pp_force_state);
-	if (ret) {
-		DRM_ERROR("failed to create device file pp_force_state\n");
-		return ret;
-	}
-	ret = device_create_file(adev->dev, &dev_attr_pp_table);
-	if (ret) {
-		DRM_ERROR("failed to create device file pp_table\n");
-		return ret;
+	if (!amdgpu_sriov_vf(adev)) {
+		ret = device_create_file(adev->dev, &dev_attr_pp_num_states);
+		if (ret) {
+			DRM_ERROR("failed to create device file pp_num_states\n");
+			return ret;
+		}
+		ret = device_create_file(adev->dev, &dev_attr_pp_cur_state);
+		if (ret) {
+			DRM_ERROR("failed to create device file pp_cur_state\n");
+			return ret;
+		}
+		ret = device_create_file(adev->dev, &dev_attr_pp_force_state);
+		if (ret) {
+			DRM_ERROR("failed to create device file pp_force_state\n");
+			return ret;
+		}
+		ret = device_create_file(adev->dev, &dev_attr_pp_table);
+		if (ret) {
+			DRM_ERROR("failed to create device file pp_table\n");
+			return ret;
+		}
 	}
 
 	ret = device_create_file(adev->dev, &dev_attr_pp_dpm_sclk);
@@ -3337,6 +3338,13 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 			return ret;
 		}
 	}
+
+	/* the reset are not needed for SRIOV one vf mode */
+	if (amdgpu_sriov_vf(adev)) {
+		adev->pm.sysfs_initialized = true;
+		return ret;
+	}
+
 	if (adev->asic_type != CHIP_ARCTURUS) {
 		ret = device_create_file(adev->dev, &dev_attr_pp_dpm_pcie);
 		if (ret) {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
