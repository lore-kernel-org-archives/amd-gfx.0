Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209CAEB64D0
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 16:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4E6410E0DF;
	Tue, 13 Jun 2023 16:42:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97C9A10E3CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 16:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmsXNYYYa35aaanO6wRmrEQ+VG5C1I1jZbyAntl+alb3zKnbfr97DBw7qDQA+LuLXBWIt9x47/xnJ6clQok2Z6/c+fKhL85FnjyYGHGh600CQQWd40sZirxA8WrG9AWu8PfCuomE93xchgwXwCHjgp0JrXP89WgtN0x/8B1IWE5+zGNjuBqI+Y76+sHpYUx770OzjcjjLRV551rbUmoP9hzI/XVpcWj4uO54BvvYh8FsHScIxpSkgELqNok56PYMwEx0y3o1kA2IxYr05yFZFsxUyUUcb9ePTBUC2myLZ/tsx0SNYweuGem4JoGkNa1OAwHBZCrRWw3Gmw2m7+eiUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAzSPQs7zSudx+qoVNxNZI2yEwD7WFBRcRAXeCQkL8M=;
 b=m/E3GcimsxV+m1vM8cLDeXvbF9CzIh4hQpFYn4c/vbexN/oTFSDZ2Qhdlw9a9pt8ZfREWluaX/O5NYzcDIgIqla9kosULKfcyxVFzdhoFtIDJl9SrCXh6e/2tQ0o/eAKeGA1zRJh2sbbSdmfNOjsRfPWl+JkGMj633bxqYbSj/t+9PWqS5g4iovFlXaV2aczCdgf9FMjbLRkE0htppjrpxyhy6DmJAM/5h0/Ly2apcZlue23dmC7OyWqw1kJ5/3w/NgGUzoVuHIQpGmro9nFypNFpghtkxUsI9mlsCenS3s9M9bkSXqIjZrK012aDoxNJmW+VmUUi5kGm+9ND8MRtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAzSPQs7zSudx+qoVNxNZI2yEwD7WFBRcRAXeCQkL8M=;
 b=nJqy+Vlf6DKiAJX5EfGAf5Xgqmt3O9+xj6zdjZqq4Y8lHhAduw1ufqjTdqrsxSTmHVNKgZRT5iCuS/7xXzxp59ebZedukFkmZucCKBI6tFft/il6bH57t9TAse1lo7ZwnWWWX8ni9C/nny9Aeh5+b1iPKmiEN+MrpRMHgJgnbpw=
Received: from SN7PR04CA0234.namprd04.prod.outlook.com (2603:10b6:806:127::29)
 by SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Tue, 13 Jun
 2023 16:42:06 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::a6) by SN7PR04CA0234.outlook.office365.com
 (2603:10b6:806:127::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 16:42:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 16:42:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 11:42:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/pm: make gfxclock consistent for sienna cichlid
Date: Tue, 13 Jun 2023 12:41:47 -0400
Message-ID: <20230613164148.2631132-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd02de1-5a10-4e47-9f0e-08db6c2d1f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eH2Qyv1vsAgGxA8a6iShIzIVuY3I6eWZ5fg5wsf+Y4Y4I20yjZbJhWgM8HXFWFhS6Axj7KrAEeTMnaBJ6JmL42BifJdcNjwEPin2s6PA/YJDTdDp1N7o+he77+Bb2kE7Ban7W08qxhCaPKfR+hjV1iHWm20OBALsBY9ei8LzPiZHNrN367g9DKEruLOZ/rG5gdbdcZPmNj2dUYK8Cz0tShJe/Eq97QdE/doFV3XrOXpkm4qzqCbXRY+6Olgxenh1jIR2t13mgQXa5JJQiWy5wNWuXJXCwdqXL+EVsCajMuIYvxhaUSvUzOEhfEMJApXsAT/3DkDjk2sGuErrhFX8U4BXnADNsz2wjMMUyVnNeBDgj1iHjbTArdbXkFwdKL4ZYFtQa/Tj/oR6774wF5dIMqPjzfkor0DbPAte3wzPQZy2MxQVxQ4yaAh+uaPNyJ+o1s2SsRIVBnIVYEB2uDTd45aPpEpJRDnBy1zjoUcfn7MiMdFtfP5c9/kJPs4i3fN4mFI5IK5233AkizFPe7Y+lkOP85j+LEPh61SoIGazjd2lIIWsr4kbdhD0dWn49umhIZ6b7ea/4bzIBlxJ5Px/90JTtbZFX8VEgIr3YReRhSmJOu4lL3dezp1vd6l1NMsYUjvcgdQy75ZzLpmgf4bSy09rNIxhrCVQ2jdB3dBzGNJKb5GaqZgjSEir8Fg0k7v2AmK3KGIYm+RHro0VzIH1AlWOHpHAL79HRRmQ6as0lk3mZATJZOjDLcXLfKNTSpNLOKqayY7QpttF6WijV9EgUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(83380400001)(5660300002)(26005)(41300700001)(186003)(16526019)(82310400005)(1076003)(40480700001)(36756003)(36860700001)(47076005)(2616005)(70586007)(6666004)(4326008)(336012)(8676002)(8936002)(70206006)(478600001)(7696005)(2906002)(6916009)(86362001)(426003)(356005)(81166007)(316002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 16:42:06.1266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd02de1-5a10-4e47-9f0e-08db6c2d1f8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081
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

Use average gfxclock for consistency with other dGPUs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index f7ed3e655e39..1b7d93709a35 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1927,12 +1927,16 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
-		ret = sienna_cichlid_get_current_clk_freq_by_table(smu, SMU_UCLK, (uint32_t *)data);
+		ret = sienna_cichlid_get_smu_metrics_data(smu,
+							  METRICS_CURR_UCLK,
+							  (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
-		ret = sienna_cichlid_get_current_clk_freq_by_table(smu, SMU_GFXCLK, (uint32_t *)data);
+		ret = sienna_cichlid_get_smu_metrics_data(smu,
+							  METRICS_AVERAGE_GFXCLK,
+							  (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
-- 
2.40.1

