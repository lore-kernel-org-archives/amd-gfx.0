Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC97C7EE23
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 02:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56E7610E639;
	Fri,  9 Jun 2023 02:55:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4611F10E0A5
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 02:55:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5cTZABetrY9LZY/zUxlNgXVD45tlzoRU9aUhOWXAuv3vD2x6iVKN5W0PniQ+lnTZpzOz7IVJyjGGpkw1aUUG+L3PtX6w13Dk3HveGr8s3FmZHUwK4dzc1kqvyCafTqrzqVQosklLHXAnmWq+aAI4x7r+llr1PUhOgxdpaPhcSOklFOLYoqVRUr56gJJHLgbbVGSXIlLWJTiNrOi5jlOFDW/tXmonf666b2Bbkr3Y6ZjesuFiScwiuY0jKQdWJvlDOg5rI8edldFQBMBox6QS7kVfWWPtxuhUPPHB7zmucDP/OQA8HPCOskrTLnbA7jXpiyOF6SLC+nTVfMy+z5mGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2ieP8QxdiBTVS9dfMdYj16bBEmbEGFlUeb7VOf+ZU0=;
 b=bXsbd6AvbP0KdpBVgFkyY2i19V6Z7b2s4fxsT1n6xgpYjKVOtTzAOEITYy4yusR2MjoD2rqTGVX0y2uQSNkywr7+Il1yCDBYUg6f1To4lraWV/cMfgtJeveHEzfOHRN1Yj2qWlFi513lNGfq9owBMddINTRTszab8juvwFT1arLgdgkV/yOrX3vBIkRDyObTB3iwwOcaHzgPoHPazwyu920g3l+KNBAZ+k31cxSeZPPkVSa6DVqOMdajjg8PNPIWwaPKCVzWxCo+9xaluARZHKGf/QRwdJ2gSGq+TsEswo/gTTSOxgGQNJMtrjS6fKlIHBRlWSzm9SajRiBuYEVTbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2ieP8QxdiBTVS9dfMdYj16bBEmbEGFlUeb7VOf+ZU0=;
 b=PKLRRxciXtwUUZah0wJRuV3yAbtkPDvNglPUD3NukSDpWQOlZBtDBl33yJmMAOa2IFCTU1OWh8tC+F0wBBbq7HU24tWiA3dKRPeN8v1oATsBAzggdU2AXhuX6A+OujisptIJtbi4E06Bl3NylzjCt5InScagwlPIttz97r/urrA=
Received: from DS7PR03CA0285.namprd03.prod.outlook.com (2603:10b6:5:3ad::20)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 02:55:51 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::e3) by DS7PR03CA0285.outlook.office365.com
 (2603:10b6:5:3ad::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.25 via Frontend
 Transport; Fri, 9 Jun 2023 02:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Fri, 9 Jun 2023 02:55:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 21:55:48 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Thu, 8 Jun 2023 21:55:47 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: workaround for compute workload type on some skus
Date: Fri, 9 Jun 2023 10:55:44 +0800
Message-ID: <20230609025544.4179487-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 374f6ea3-2c5e-4533-63c7-08db689507f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mDO0J31iJl6mJOpqR2mlBBksHAEu7e2MEIsJjdkfvp73xza6VyptY2+tE0o2R/p6gNBdQ84Q24BjWD5eE0tnGlnQl9ebhR8nLXLHCVNCELuulsXdF3f1lbmbO1C/qnTO1EDMZFQSHHU/6l8lq2Qe6RLnaZbm1UH7xfabJrcUhFZ80gN2MsODggvSK9j73bCcKzgvBKFAnsGz6syptaD+8gH9rat2yg/AfIBrhw6uU/54hVSk8raQB80IGwdZ31+n1XF2r8nQWseXFkMIai1/xa0v8/e3E9JYoceIgQIY8Ogapk5ltHHR2N7dUp2TzGrrGxVGTmyeXclKQ9XH1RmSvqUunyazJuDeX7MQCs0vSLSqrxa7uCWzDqFFzspOeB8Em+Asp89ziFyzsUMHYcCylGmTlLUySTzr299LBq1JcD4MVU5KytJUzO/69NTHFdfIRbE3ohU2Tgl808R2xksCehak6D4CwjTMt3ti11reqD5ffRRK0p11qY4AZ/mQRjlFin8Em0GfQWmryQtlMgsUZ1JcOjSNeHjwVCiQubfIF+jgf8YNVm2xK98+xdLsXMTfytzKoSpKIs7BfsGiGfDCp1P2DtaQTdeoTG9DDfe0xBIBfpVMNPvNmmDyKZqmK7/1GIwCWBGyvs3AiKXtAiDDFlugc3vgf+O8IJjKneYeCyUeFXhHPmBXkMDuPAlaxOvMHpxfm8Pq4UICsSzLBeYthMEavE45m8N2ZS2mhc0rwp8brLhpl0uts2FR9leLV9YPx+RsOlKRISrLCJxa96W6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(70206006)(478600001)(6916009)(8676002)(70586007)(4326008)(316002)(8936002)(41300700001)(54906003)(2906002)(44832011)(6666004)(7696005)(5660300002)(40460700003)(1076003)(40480700001)(82740400003)(81166007)(2616005)(26005)(356005)(36756003)(426003)(83380400001)(47076005)(336012)(186003)(36860700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 02:55:49.4901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374f6ea3-2c5e-4533-63c7-08db689507f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
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
Cc: evan.quan@amd.com, Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On smu 13.0.0, the compute workload type cannot be set on all the skus
due to some other problems. This workaround is to make sure compute workload type
can also run on some specific skus.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index e2265f50bacc..6e8acd021ee6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2179,6 +2179,32 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 		}
 	}
 
+	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE &&
+		(((smu->adev->pdev->device == 0x744C) && (smu->adev->pdev->revision == 0xC8)) ||
+		((smu->adev->pdev->device == 0x744C) && (smu->adev->pdev->revision == 0xCC)))) {
+		ret = smu_cmn_update_table(smu,
+					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+					   WORKLOAD_PPLIB_COMPUTE_BIT,
+					   (void *)(&activity_monitor_external),
+					   false);
+		if (ret) {
+			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+			return ret;
+		}
+
+		ret = smu_cmn_update_table(smu,
+					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+					   WORKLOAD_PPLIB_CUSTOM_BIT,
+					   (void *)(&activity_monitor_external),
+					   true);
+		if (ret) {
+			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+			return ret;
+		}
+
+		smu->power_profile_mode = PP_SMC_POWER_PROFILE_CUSTOM;
+	}
+
 	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
 	workload_type = smu_cmn_to_asic_specific_index(smu,
 						       CMN2ASIC_MAPPING_WORKLOAD,
-- 
2.34.1

