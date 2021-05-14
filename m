Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281BCC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD165611CE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD165611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 766176EE37;
	Fri, 14 May 2021 07:42:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46BC36EE3A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzu0ZssNyiC207Am1AXBQ0nI6a+D0OHJN3sCtOjy7Vs3M17fu0N6m/mwh1HKBFUwv/FYgn5RmWCwyhbHEnLFgAYeIJyiuZpg/8wJ268k9LSw29ws+71BtEE4poKPMoanfJUQRnPoyjeGN7Y6RzqdHj8LIsm5v+PZS6NrReB55VS+WsQKV/tEyRwhQ/PC2F3wctRm1xjQ9WJZm+TFSz1nmfqGCmZGp1LDWO641osBTEGWcZ8JUdSj5/WQZG5/BBT6lcm6AnrKMknJworZTLSN2OtHy+kAyW8R0NWy9s0vMHMPNJ/OpPB/KcpU9SXybgDUiPJgsEM3bzJi0t0wiYtBKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EetYIBiv869sj6R/n3vkeOLNDco/dbS1pFz+cQFrK7k=;
 b=CakYTo7HwfTneFLihkXEDKjFt07RJBLB8vNsIZ4dpQZIzEh4WZFTZK2/fkAnSvqRw1P1zQhwuIG48OABTsEbx/p+2oWy6u9UVJgXgiQSI/9k3IUnf+BdlnXXBXlAgl6gEBh6ZkOG4eeA8Aq4FDG4abMMhHapxBB+wMqH7wukxswP/UCw3Ur9waMJOmz14eHfzeot5jsBF1mXlG7uMimrTZ5p+6ctokI9Bz2iEc444aBvnjkemm3Eg0VWRhfPXuBgmx9fE0wUIUMQZerAgLtrRg49Gle/xE2bC1eOiXlY4X2fjCvf+/yzseZEznaHO3OP3UVNAxnM/7ekZ+cW9P2iXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EetYIBiv869sj6R/n3vkeOLNDco/dbS1pFz+cQFrK7k=;
 b=SgxD2c757DfDeaZ6sBxRaxsfv/ywsnPO6Dp61LCN1sxF6lS1g+SLXEccwTNRoUWCEonw5lVwK9gepvsURk9yu+Xc0c+wkIgeQZ+VYbJ0T0g4Hw3CssuOpYoT9+svSzO6UzuwNsQHT0WdLj42mTOSi0aA0x+Xei2R759WrOmF++s=
Received: from MWHPR11CA0041.namprd11.prod.outlook.com (2603:10b6:300:115::27)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 07:42:47 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::41) by MWHPR11CA0041.outlook.office365.com
 (2603:10b6:300:115::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 14 May 2021 07:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 07:42:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:42:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:42:45 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 14 May 2021 02:42:44 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 John Clements <John.Clements@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: query boot config cap before issue psp cmd
Date: Fri, 14 May 2021 15:42:33 +0800
Message-ID: <1620978153-4564-6-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620978153-4564-1-git-send-email-Hawking.Zhang@amd.com>
References: <1620978153-4564-1-git-send-email-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30f7c4f8-079a-42f4-2095-08d916abddf0
X-MS-TrafficTypeDiagnostic: BL0PR12MB4913:
X-Microsoft-Antispam-PRVS: <BL0PR12MB49133676DC63DC316B18D169FC509@BL0PR12MB4913.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6kiX2ga/TlNjaZAfckb08AlYGlx6MGLRvPT1Y94HTN+ttURq+UY02SGRViP7FaaNYJG9JMEe2lG7Uoc8fpNVUBcgp/WFCw0t4YsMBN2/W5lgcf6i1ZREVHJ825sK4LXmVYY+9AXD3yLV+84duO3Ov77sLRudHky69gF1ON6rKow+bGkk/gPA6bMmGcWvHdHS08MawnXyf3T3AzWydndD8QC2YKvMk7rb+00l0jI1ky3UfDdTQ91E0DjH8igHB8AmcmWoFamzOGw9xQJ5PC9jhbaJTI2/zfjrvbkcGq5PrM1tw2WRLRzuIkJozijRPhZdgfsAWZJosuleXoanW+55PLhuJjGLsZsd7BLX6l4mzVl0AdKcxZfiw55pCs+On6Ycc6RtnoNmttuKRcjSdbfTuWSjryiRo86HYOyX4063s3GF9UsG2eZd6XFZKZ2duQY+27wiuJe2zJuVx/VefZ9FwAPgBsTVMBbWHu13TMOYjdJHkllx6mRaXPWw/2DxmfB8zybvHCTdhC4SDMKO6Vj37byzd++l9PXK73yy/4QxS+dgqH3uAZTkwXdyDuvJtxRIr+f5tDWEcQPU2L3rCCRb3cZlSCn2Go/2CzE90ROD8re9MhBcleu2f7AAw2PtAHKAiEcic5kTqhbxgTTRQlCrK6km8BFMj2ymRIQYFRrKiIEpTMMcESvEFE/X0oze66Z
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966006)(36840700001)(82310400003)(2906002)(4326008)(8676002)(6666004)(186003)(83380400001)(26005)(36756003)(6636002)(478600001)(70586007)(336012)(2616005)(36860700001)(426003)(81166007)(5660300002)(47076005)(86362001)(7696005)(8936002)(110136005)(316002)(356005)(82740400003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 07:42:46.6847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f7c4f8-079a-42f4-2095-08d916abddf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Only send boot_config cmd to ASICs that support dynamic
boot config. Otherwise, the boot_config cmd will fail.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index f7bbb04..56a3c3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -38,6 +38,7 @@
 
 #include "amdgpu_ras.h"
 #include "amdgpu_securedisplay.h"
+#include "amdgpu_atomfirmware.h"
 
 static int psp_sysfs_init(struct amdgpu_device *adev);
 static void psp_sysfs_fini(struct amdgpu_device *adev);
@@ -538,7 +539,7 @@ static int psp_boot_config_set(struct amdgpu_device *adev)
 	struct psp_context *psp = &adev->psp;
 	struct psp_gfx_cmd_resp *cmd = psp->cmd;
 
-	if (adev->asic_type != CHIP_SIENNA_CICHLID || amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev))
 		return 0;
 
 	memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
@@ -1931,9 +1932,10 @@ static int psp_hw_start(struct psp_context *psp)
 		return ret;
 	}
 
-	ret = psp_boot_config_set(adev);
-	if (ret) {
-		DRM_WARN("PSP set boot config@\n");
+	if (amdgpu_atomfirmware_dynamic_boot_config_supported(adev)) {
+		ret = psp_boot_config_set(adev);
+		if (ret)
+			dev_warn(adev->dev, "PSP set boot config failed\n");
 	}
 
 	ret = psp_tmr_init(psp);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
