Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948ADC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 03:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0196710FD7C;
	Wed, 13 Jul 2022 03:17:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4284610FD7C
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 03:17:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsP04pcqJN25hEq1NZAun/ZbfM01Lvn5iHpyaHiO9pALBCFQlfRwj3w586waXirquitOQbaPW1W0dly4q74ArR6RCuzbn2NC5jNR5oBhw6zVSKXofJ853vMk3EuJJnFzKZv3RS+1ihN/XsG8aAAfKRoBUjeDR//Exvy1ZRKm7obMjxzMgSUuCO1z7A/Waqv/aTI9mC5sCBRUwLn0xdWiTfltZ+80Vv5nbqeB2dzp/eC96QFyIvpiwcbq93qkjCQ9/Gv2ol64W8bsrpM6W4Gk+hZsQBOjwrjff6gwDsDXEuaBizvpoGVp4tMMviZVnJjG9I23AwsCFVX2qtwyKC3XPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H38tn/hXLa1muX7UmzCdgYHpIsWPut6QmwlE0fskKa8=;
 b=oAUiwPcByCJGKxun7xj00fgtDKCH2ecrV3p2/NmQ6Hcdj7D+3saLMaRsdrOZAwU2tbPeWJlh3WhwxUjWDuekgNGIckTK32SpAzauPjbALOtTTzG67D9eKNfgCKuD5QeKiuxQC3XTHBcgSCUShRAdHavCCDoPj79mKA+tPfAH6b7eWweSmRNGK4Qr/+3gSGMY/z+PjFO6EYo9DtiQqoq8AOdstBKrRuiSlH9OMsGdWEQ4UeSnJXwG7kKwxGHRM4iXgV21fvTcI4eIicw8DHUgovfd3weqPaSsfemPN2Ah2MGEykyS6pDylXk/WSxPiWksgWecAQALHDNZnlJBpu8OPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H38tn/hXLa1muX7UmzCdgYHpIsWPut6QmwlE0fskKa8=;
 b=5Bs33LBLGNJsLe7z0KeweQJgQFMeJu22qo3IPf2EY0P43m+8YUOAkfOVfWMlaihYDAcw2HFFuoWKeZeEyq6HV2yOXgLm5GA7P/DxQeiDvP97Kk8XD5rmcYhimPtcogLN0tQZox/3F42ayp7o8O0LLNpzojm+v1pVwqTuUb1FajU=
Received: from MW4PR04CA0093.namprd04.prod.outlook.com (2603:10b6:303:83::8)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 03:17:34 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::ec) by MW4PR04CA0093.outlook.office365.com
 (2603:10b6:303:83::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Wed, 13 Jul 2022 03:17:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 03:17:33 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 12 Jul 2022 22:17:30 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: skip SMU FW reloading in runpm BACO case (v2)
Date: Wed, 13 Jul 2022 11:17:04 +0800
Message-ID: <20220713031704.2004-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a793881-4eaa-4e73-c727-08da647e3a9f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5208:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jnx9tJ+TiZuBJw9ie8in16SifF3TBIbPBNScASuuoW69UXFglRWSSr0DD+fKLSoa9D4d4rLKwgMzWnaMCxeMFs2kw2FGqNuTtPerw+DPEEwQgT6ASDWs7g1CPRBkhgBn4UXIVxZ1+Pi/8WV+ybhOb1BpEPtoBWSJRRn9Tfeo+HPhjIJoKeLvVAYOnpIwyNl+7J8AG1Q5dJOhpZeZcT+xsJgWYL1XO1LF5hPmxM7qGO+38QcXWn83h1aL5od6NiJ6uUKM9neTAdlQMrRPXI12pmDhqHVQLsyXjqGyJu8I7v9a3lZVvLGCzBo/dEal6HTIP0xyHnDRQjK6aY8sEXNjwQamHb9hBjKm9pcyXmQqI2C3wzamPvCwHQ/gC0xRTpLuqXGzfNMdFi3nqtw+ExdRA+XO5BX+2+ox6HQP5WggHe1T4jXuyyRcM5tI5OalX0cJOLY848WtNMvWhkfqGQl9LkZzgl2c4bop3dhs9TGAlBGM/3jycCwtsk7Bt3mkAAK5kkQCTkgziSPEB8NPdqUv9dyG90AWAxSz8uzdtCfnk0wOdOXUQEI63cmhlKBiU/AmJLYBCvRD5M36gcTN6VvvhYzhhXKVJUGtjzDzPalrmvs2Rt8VQfFQm3LXkpXY96HMtNhHZS26i+55BHhZf2mmAbqPPe6OhlDZvqA703/e4TNOBDPuNSgbWzZ1j/PsT9twUwIUjcotvywjnydKn5t0+5lyxbokjEKt8Op1RYnbqU59gfYPNKdxc7sG5nNZu1Y5kmOLy71SVz9nxH/fHkQCF8J6wPvP6F5X6B04OFtxWIiF8WXcNOs6jNFfFAuYuLrl2Co8MkcOb93fEDedoRgF/igzNmY3aQGAglraHUFQIHuoNg1Do0LRWf6GTQE/0ZRz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(396003)(136003)(346002)(46966006)(40470700004)(36840700001)(6636002)(110136005)(82740400003)(44832011)(36860700001)(82310400005)(316002)(40480700001)(356005)(81166007)(36756003)(16526019)(186003)(426003)(40460700003)(26005)(47076005)(70586007)(70206006)(4326008)(8676002)(8936002)(5660300002)(2616005)(478600001)(1076003)(41300700001)(2906002)(86362001)(7696005)(6666004)(336012)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 03:17:33.6678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a793881-4eaa-4e73-c727-08da647e3a9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU is always alive, so it's fine to skip SMU FW reloading
when runpm resumed from BACO, this can avoid some race issues
when resuming SMU FW.

v2: Exclude boco case if an ASIC supports both boco and baco

Suggested-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e9411c28d88b..de59dc051340 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2348,6 +2348,14 @@ static int psp_load_smu_fw(struct psp_context *psp)
 			&adev->firmware.ucode[AMDGPU_UCODE_ID_SMC];
 	struct amdgpu_ras *ras = psp->ras_context.ras;
 
+	/* Skip SMU FW reloading in case of using BACO for runpm only,
+	 * as SMU is always alive.
+	 */
+	if (adev->in_runpm &&
+	    !amdgpu_device_supports_boco(adev_to_drm(adev)) &&
+	    amdgpu_device_supports_baco(adev_to_drm(adev)))
+		return 0;
+
 	if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-- 
2.17.1

