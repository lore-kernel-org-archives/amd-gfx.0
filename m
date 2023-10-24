Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014C9C00A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 03:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5940E10E095;
	Tue, 24 Oct 2023 03:33:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9A7310E095
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 03:33:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwFEZ/BXEXD7n/l+P227b0Qinfh9+7l30sA5YNIWqajrmKezThek63AlC/MsLsj5t71PCdKv6fnKFuQX65cC2kbi6eEmEnvLGkf9R29vGdswT8chHtEb+E7bKvq8FtSgUv9NiHq6IrL8Hu4S9nQAhF1AcedgBRFv5V4lrJm11Lsw9plT2k6nZXDKYh5qv2wo6IV5eQWlqrqPLQqbJGuYSqxC4sW87WhSJfl7zcbau/fNcNimr7LeFpKKDKp6dLuOq9jelb6L/jYWd60kQ7YJl5uTL4q06PEjDWueq6ppEQ27KvRpXAhxOAOeE9/MfqOIrr5PHZ+x4p9Wfb4pW+1gXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIcQkBFwH7UxTEpsGwngvJ40N7ip6b80nTTP8TU+MiE=;
 b=Wk7U2OWKt9lxHch0B23FSDFLSJIBNHxm/FFsFf6hnyR/OrUxPLQXAXrBBzj7WlH+zcuu7pVXHvf5L2rp4iImuVVhsPjjN/cv1sochv9joo2zOF+F5R+S/vbvSytmZQJtf1vOA/PpgRBU12leX6Afc2Yk/cRJJcTsk4VGPdng2C0T6UB04Ku+ra2Rsgk/3qZ1CCxzzo4fRBaOTmfe3XN8pI1IaPyaReziLZ1SRMRqR4kTj8ilAqFGYrQTE4tyhU9BG4BXhu4CyiLfFSp7fJ/d1H9et472YiOjGrLNInlm5MJFHdNJBoW59F4PCxtbXsfd0iVfFNt0COkfoIubzx1svg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIcQkBFwH7UxTEpsGwngvJ40N7ip6b80nTTP8TU+MiE=;
 b=b/PVoG1LIJWncxVQ8vUMi3zzTXwgSl+rhYCwdyfwWibQmYKPLwJlLJW9vVY1vspsqiLaBNtJZtZ6FLhcI2Kf9sa3B3sULuZD2P6KbyMhC2juP5W9PnXDqdOOLaM4QGGET5AWMjLdc+QFBMYXOCkp4uupjeo3oiJtnl8/Uyoyv0o=
Received: from BLAPR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:36e::9)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 03:32:58 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:36e:cafe::82) by BLAPR05CA0006.outlook.office365.com
 (2603:10b6:208:36e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.16 via Frontend
 Transport; Tue, 24 Oct 2023 03:32:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 03:32:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 23 Oct
 2023 22:32:54 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via
 Frontend Transport; Mon, 23 Oct 2023 22:32:49 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: avoid to disable gfxhub interrupt when driver
 is unloaded
Date: Tue, 24 Oct 2023 11:32:47 +0800
Message-ID: <20231024033247.760912-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2623b2-1d13-4c61-08ca-08dbd441eb44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4BBpHikfMl9iaNICVf9nACSXRVnuxIhDyt3ORsW80U8sOXl9uwm0vWU5JTe7438YH9TRTCdRlrTG7MvmvbfuXIOeg8laXl52bMMVjl6jB6sg5gKn6HZ36mCwGyMHcQLUjioCfNE/km7MQqY7LB4fXsPA1/Jpvq5EPvYC4lJ1PlhW+PXaiga4p88hZ4avTmAbp3Fm6nb4BbFJvLrTFkkXzUu6/s4W/UABVFfQ+zKXxjmRGZs/2jKUO+7NkKUPTvPpfSVTE0jLuK2eFLE8XLlhIo+L1r1M+PkSreAee1envsYZt/HmA2+JZOybNvAix3x6IxIiNABZ9MDB4BBEouUGutwVVV/doJramCtxGu1cDulaL6rxoC0npfe6DMtRlFJoRtzQdZZZJ2glWqtgeZI5JM71mYN7qiUg3Q/4ZbISX3oV9pr0sJyJjUVugzhhgOM8glTe3seypXUVhOrAUjBXZSk1Tf8eUbuDtqv/bY8WU4GYB1h3/oMqPpE2VXjOwGO0QH5ds8qY8CEGJcsPNct03HtJ5G2oIPR/+Hg+uZeCyGv7if/AW7UbU2dPBiD+ofzNZnArpBJ2foY6TaM8nUXRdw/sVfAxda4R/pT4wdwLEdHTep9s6abpLITASyhtI5uRQJ4f5w7Vxl4mtLkHSNr8QdcDJs5mUXKIjADAmOHQIG2qJUKRh+aMYHdD5DZvo7JIXLSEqFw6uO89jnH8PX8QVxrDx5+IqOWR9KumXxSsDHq+3/IjtWk1OAsDqMmbkSK+jY7rgfwCovlFvnT3yhWz9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(478600001)(26005)(1076003)(426003)(336012)(40480700001)(47076005)(7696005)(86362001)(6916009)(316002)(70586007)(70206006)(54906003)(36756003)(36860700001)(40460700003)(2616005)(356005)(81166007)(2906002)(4744005)(83380400001)(8936002)(8676002)(4326008)(44832011)(82740400003)(5660300002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 03:32:58.7655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2623b2-1d13-4c61-08ca-08dbd441eb44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236
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
Cc: Alexander.Deucher@amd.com, Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

avoid to disable gfxhub interrupt when driver is unloaded on gmc 11

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 80ca2c05b0b8..8e36a8395464 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -73,7 +73,8 @@ gmc_v11_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 		 * fini/suspend, so the overall state doesn't
 		 * change over the course of suspend/resume.
 		 */
-		if (!adev->in_s0ix)
+		if (!adev->in_s0ix && (adev->in_runpm || adev->in_suspend ||
+							   amdgpu_in_reset(adev)))
 			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(0), false);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
-- 
2.34.1

