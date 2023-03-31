Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB37C6FD18
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 03:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E0410F0D1;
	Fri, 31 Mar 2023 03:44:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF66410F0D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 03:43:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKk/n4bZSiw0ZZwjlNdtIymOIUz8SAoHbmB6oZlLjm7DD1Lr6Mzkx8JY4z1HK9M5pRvYOuHrt+1667DbGYWDDW8DAxW4zFffEDYe9tuh8IUva2sDqRAZ3Si8uMmWc1gLtSwpzlLqGZCqE/tkE3BkqN6C694YygnjFK4U7b/noCgvkoZlVXzfIQnh7zbHCaAsSrJuZhKKTA6crYNAZ49KxtziL+roJeRmWYzFpMWc8hBTzVpS41jl9tl+kJbM7eEOo+ysKnCLQzhSClC40nC+x9QT+gT2ae1lXphcWYiBvwKasvbEm5o+/1g7qNwpe53mh4jS6ofzq2C6vXPOjyWafg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCjd3wp57yYwfBdoVWOqGR8yt9xkqwqzEnQLg+tSddw=;
 b=A698HnngrPCtX3PABs7uQXolYAtsAhOV3oThjVZqgIugYwcAKE+WuLdCKh3X/ki8QCECAxn2dLDQHODHAxxiO6B4x3WvPVGS3Goiql+wthsUYXtamIhwzr7Cky8H5TvpVPgMmcQ4Ptea0/1M3cpmPJtAfgEVdQzpwfjx2ike7KEmYJP+jzqKJjK6DWKyLDXbC+jhHiq7b254dNsNiI5q0mh8dTHtfjApyxU1BZBHlaxK+MxLqWPDHiQFAvnN8uofPep6/n+Sk4znHNSOCJzCbaj4+cPCugqNqq3VGhPMn4K5Ec4HckYsFiEDLFDCpixQlk0AXD1jzgEsXnyi4FyTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCjd3wp57yYwfBdoVWOqGR8yt9xkqwqzEnQLg+tSddw=;
 b=v1B+Mz5VQvszSAzivqMKTS8+ePzHzJkYtXEbBtSj2bvcR7c1pIHlqRqGtCbGzRVbRNfc00Z2Hukj/LuqfGIyRjv0NedK0/c3IACUtMY6Ne+DU0d6SmUr10LmkyKt7XX8/ZZds99MAlW7cuNfzeS+J9q+UmRY9gm/UueXSYRNAgM=
Received: from BN9PR03CA0418.namprd03.prod.outlook.com (2603:10b6:408:111::33)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 03:43:55 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::db) by BN9PR03CA0418.outlook.office365.com
 (2603:10b6:408:111::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Fri, 31 Mar 2023 03:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Fri, 31 Mar 2023 03:43:55 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 22:43:53 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: allow more APUs to do mode2 reset when go to S4
 (v2)
Date: Fri, 31 Mar 2023 11:40:40 +0800
Message-ID: <20230331034040.2498766-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT017:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4e3cc4-e251-46cb-7a26-08db319a2759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRWOznF4Kgyou5Ur+W1zcecIZEAjsOkt3+ewWw4nRTAqGuD39BcSgU5tAn5AarqPPzU85k/CXpl0I9hC4rESpiOVGXIuajKFJsDDnD+cFr2lRtdN1+5rsLYtGw95tTElw7pZt1RzGq5XyxHP9QXV7ljakFPCsG8fmCccT/a6b5t8d+mOZU5x1ynLu9roATz/LXglZIkyzkYAMOQ/Ielo5tZhT2x4gpRtfo469wZlJxX/9DovGmdR/rNQpLYWpTGkbbtVzds9zMcXDuM3lF7nTLr+TqtIVKmgKr5aTy3TuSubMFaeOKH6xxjmM5k2C1HJ6FLACMbwS8Gd8bRc2WShHmmES1+/IgsurXkTTCo/cNg5XCprun58IwamsANibbjE6gO/19KOptWV9akT4C+RsUORWRisORDGb10AR3DRxenLRtAEk9gnkFyWNJYKoM/uquJd7XV5LLCTkB/gloSeuCfzZiidL61mtnZfZ9rSXD9U9BAZ6QGXk4IevBSXqRDqx6UkKiBhrcvwDsOxN40gphprwu7zbalqUQOnzVibD25bPimtyuq13P4AXoLFP/aW3iysrEv3BnUhNiE8GB1Kv+0STPkjOWj4e3Y2iFKfPaGV3OjjR8tPaaW0+hd/5UKec0yMdBBbMGj/C4tkOmusKrS851S9E1gbDK8abPh6x+CvBuIlYyHtRKDwlcir2mVO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(2906002)(83380400001)(2616005)(426003)(5660300002)(44832011)(6916009)(6666004)(40460700003)(36756003)(336012)(41300700001)(316002)(54906003)(4326008)(7696005)(966005)(8676002)(478600001)(70206006)(8936002)(36860700001)(70586007)(186003)(16526019)(86362001)(47076005)(1076003)(81166007)(26005)(40480700001)(356005)(82310400005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 03:43:55.7488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4e3cc4-e251-46cb-7a26-08db319a2759
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553
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
Cc: Yifan1.zhang@amd.com, Xiaojian.Du@amd.com, Tim Huang <tim.huang@amd.com>,
 Yuan Perry <Perry.Yuan@amd.com>, Mario.Limonciello@amd.com,
 Alexander.Deucher@amd.com, li.ma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Skip mode2 reset only for IMU enabled APUs when do S4 to
fix the possible S4 regression issues on old ASICs.

v2:
Update this commit message to add Fixes and Link tags.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2483
Fixes: 2bedd3f21b30 ("drm/amdgpu: skip ASIC reset for APUs when go to S4")
Signed-off-by: Tim Huang <tim.huang@amd.com>
Tested-by: Yuan Perry <Perry.Yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 0f7cd3e8e00b..edaf3ded4a04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -981,7 +981,12 @@ static bool amdgpu_atcs_pci_probe_handle(struct pci_dev *pdev)
  */
 bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
 {
-	if (adev->flags & AMD_IS_APU)
+	if ((adev->flags & AMD_IS_APU) &&
+	    adev->gfx.imu.funcs) /* Not need to do mode2 reset for IMU enabled APUs */
+		return false;
+
+	if ((adev->flags & AMD_IS_APU) &&
+	    amdgpu_acpi_is_s3_active(adev))
 		return false;
 
 	if (amdgpu_sriov_vf(adev))
-- 
2.25.1

