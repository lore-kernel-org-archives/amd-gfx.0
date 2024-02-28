Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E85FC5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 11:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0168710E5DC;
	Wed, 28 Feb 2024 11:45:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SdO5JhGQ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3462910E5DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 11:45:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfa5WB+/huX43LvGOrDXRMCLtwNwZ2Z69th75EPR0mEk8HGqSJEFFd6hobWUYBrJ180wUaJNOjHFUzUoYruAOoUzN2/ykGFFDjKu341RnbNV3GdQqe7kUQ/Vdx890qWx8NJnboTUhWyX6A3/NVtwb0Xb3vaHy8Uset63S5OneHI3ONY9MnMGUAIh6PyPbomMYJ8MZ6pd43+r4YGXAL0Mrj9KN+tP+TjemqUO/jSchHgG8n89lh7w1ZH+GfmjSFDsEJpGPGDEBZuK5ro2FjA4OU2NvUXZv08I8VnymLR3Bga63STns9CuY8PkjKtPF7JuyM3Tb57jrc9em/TGp/z68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzVmiqDVZfIpH2JDDpFDr69UhkpsV6+pH7Jpw1g2VOA=;
 b=PvNoeRGVoxj6D6PcVqM/Mcw+r5LZN8sVtIBFPuyc1fJjoGgZUPvweRgUZf6CeqzUjfLbNMZB+h9ROi2y9jNsa1S8ALBgAYIXJfQDnBFKqI1XuPc0bhY/dcduuzx54+QaWLigglsLXQM3EQ5DP/Cgh3oKT3cykjIdKUVpNbuVW6WSFZOk10txuIndGEk//qWSbovMxT/3TOHTK4OijaXeg6QXYzBc/JapbOfC+Z6U+ZW11VYflfP13HPfUpdQdJLh8jXoZs4Rak7fg0uwbFBB2H6UEkYrDkoBn8qo+b6lUOjz6IJOSqRkl8qqclAPjlYohdlBblG9mFGX+SNxNOLiVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzVmiqDVZfIpH2JDDpFDr69UhkpsV6+pH7Jpw1g2VOA=;
 b=SdO5JhGQ9OnvIUMgkE9Wob5WJ4V7CrMVe8QQlXFAXprd4Kri2itr+njzmNkY94W9A//18KEmZLmtO/9UsIONcid3WCzDAPHgusfTgbDnKOaDZ08X0h8LQ5KFrg8JjOtvw9mDy4UkFrEvaa/GhXfeuVcYcgLvoY4Neuj5uJAoMOI=
Received: from DM5PR07CA0077.namprd07.prod.outlook.com (2603:10b6:4:ad::42) by
 PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.15; Wed, 28 Feb 2024 11:44:58 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::14) by DM5PR07CA0077.outlook.office365.com
 (2603:10b6:4:ad::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 11:44:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 11:44:58 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 05:44:56 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH 2/2] drm/amgpu: Check return value of
 amdgpu_device_baco_enter/exit
Date: Wed, 28 Feb 2024 19:44:40 +0800
Message-ID: <20240228114440.1939084-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228114440.1939084-1-Jun.Ma2@amd.com>
References: <20240228114440.1939084-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: 300ac1e8-62c1-45d4-af66-08dc3852b09f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNGwlLXorIVdbPliAIteLoo+g7Op3vXjgYusKkF82WCqLCgtuHMxcozN+el8Xsj6uuw+RiXl9G9o6gU/gaI+8fSTXV16gUfqsrydfl+JIzAdv/J+Fe/Tm3mxVmIYRx3HB/Hs+sE7A0dse+GpMXo+xUXsG5I1WGf0hpmiBTjq11Pw3evi240Ms157B2KQt4hQWsIrlMGmsxx2QYRi2yruCKvUC85oySEtc6Rdo8KMYC2Qigg45F1Q5LmIEqZP8C2N1OXVWEVSwDjHz6Ot3MYexJavCW6er35OIqL9X2nabBB632myHi4QCFcKu6KIb9qNYsCSLYyEZti0m5v3156svA645Qb9pqPAe3R/QHAOl6dOLtdasD5pkRTWLvezK34cj9pc7jI9uM6141isTXn0ZQreslznsaCSwF2zjjQ6UxMh5Rh5E6MQcbSRHPdXkLqTNqtTdl/X40ao2xHRME3wj06d1JbTHtnZiGTsSg7K8TwYyiqtUufwpFvIZG9IxOBXZEH9Wl5zN1lS/b++C9yj+C8vpsZqLEyD8mgHiD0lu37Fj2w652Mzuj+7WlAuHKX18cJa2O2o91HCBg4Y1ukwZQN8IgIxafwoNe8kex1h7rXpFKG+2twXVtKsp4Pm/Ra02RdhGIGPmiigqgEv3czUikZFnje/HrMI2XOL8kxQp95VjSHoMO7FvxfBPPLCwj4zkMluth+W1wrpUSJvNARLLsw4ewkXwXIYvQPavMmgKgnsupab+X96LKgN0fWY9oD/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(230273577357003)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:44:58.0559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 300ac1e8-62c1-45d4-af66-08dc3852b09f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111
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

Check return value of amdgpu_device_baco_enter/exit and print
warning message because these errors may cause runtime resume failure

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 8b83c26dc018..11e089cfb465 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2705,7 +2705,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO) {
 		/* nothing to do */
 	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
-		amdgpu_device_baco_enter(drm_dev);
+		ret = amdgpu_device_baco_enter(drm_dev);
+		if (ret)
+			dev_warn(&pdev->dev, "warning: device fails to enter baco. ret=%d\n", ret);
 	}
 
 	dev_dbg(&pdev->dev, "asic/device is runtime suspended\n");
@@ -2745,7 +2747,9 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 		 */
 		pci_set_master(pdev);
 	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
-		amdgpu_device_baco_exit(drm_dev);
+		ret = amdgpu_device_baco_exit(drm_dev);
+		if (ret)
+			dev_warn(&pdev->dev, "warning: device fails to exit from baco. ret=%d\n", ret);
 	}
 	ret = amdgpu_device_resume(drm_dev, false);
 	if (ret) {
-- 
2.34.1

