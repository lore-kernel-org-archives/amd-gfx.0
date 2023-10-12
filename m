Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F561CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 07:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B12010E42A;
	Thu, 12 Oct 2023 07:36:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC58310E42A
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 07:36:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVGjT9aR4LPlpOVmUTOL0c8x6wBJv7cH9z2g2oCPCGHzQ203X5hLtNgGorm/NCXEDScDW1HaLVSMhT3paC48ORaUHvRJYeDcxjpffTU9//N8KlXyNA+i8yxnVFCMdPcTpn12muHaIH2LuedLcSmnQphPICcWY8wpQOQPo0OiVE7+lPE37ZHiEfj6HHRJIeZVQN4WNzEoh/ciTJyM9x1u6cTu4OrbeLmzU/49zuUNW4hg6XxmYRgmw8hr5jmAKGnectP1vY03FFzwrcLut9z+0vbJ4NFWH0uP+zyV/wFflAA+mOoczxPKSFNrAA2O52OVoOnWRcPB2MjGn5RcBhLnMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IWXlI9Z9USJl7Hvjcgvw6Q0LlQS3jug8qz2MR71wZA=;
 b=QG/OUcm8El0dOgMbDPH+u+nW7DcDzz0QyrRcByZUHW9zxFaQVA3l/2hOtTVjZfvBiJpc9Ujo9bfPueCN9XfMTOw5ucvsjRbopOpO0yeOTE2CR8RKFqLYzUGdjdQFnAcriY+vZwHEWOAoL3YRSG91th4IBZFUJB7OWnFVAVTPThM4HjS7BIH2Q3WO/vDwmLbGCxocs6fN+LVImvBwDfxMY3x0oECsujQaK+xsNQtYP0H8qOYtXdbBZXGKKPm45hJ38ji0hBCBgOzAYwCTcGpS/ZrOpxWFmmzwXuTFrJgeTUy5ZVAriNf7+G+HBPh1acz4ShG3+h4OJxy0szRTrrDjDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IWXlI9Z9USJl7Hvjcgvw6Q0LlQS3jug8qz2MR71wZA=;
 b=aNWcrhVDgGtvhrvqXfuHYkgBGt/Zt1USrcdPrMAjBmh1nqc1ELkGtezGgAg6WFW6JGML7r2jvqmo9wEtGT6plhLFR3dkSMjM18pzg07QjnRqq3XMTUI/Geu6oS4zYARHGOyHQATW4RA4yIyYb5CtQz7YWi133qFQtX9jFxtZIp4=
Received: from BL0PR03CA0015.namprd03.prod.outlook.com (2603:10b6:208:2d::28)
 by CH3PR12MB8534.namprd12.prod.outlook.com (2603:10b6:610:15a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Thu, 12 Oct
 2023 07:35:58 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:2d:cafe::65) by BL0PR03CA0015.outlook.office365.com
 (2603:10b6:208:2d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Thu, 12 Oct 2023 07:35:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 07:35:58 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 02:35:56 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Avoid FRU EEPROM access on APU
Date: Thu, 12 Oct 2023 13:05:41 +0530
Message-ID: <20231012073541.114169-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|CH3PR12MB8534:EE_
X-MS-Office365-Filtering-Correlation-Id: 49091c52-35b2-465b-e38a-08dbcaf5e040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U1wHZ/fFwnyHfNkrQYuzzb1SBDD4DJAAjyV9O1RItr3o1LYssa0yo9o7ztjz+EINB73eqOgHz7cjBc52WrJPJiUFmyQcE+x4ebqgb97Jaq8t0KnSgvM+SK0cvulJ/ZHiQZePrCS820edSqnB02uZh1BA7FL/Qdop7YuSczyRN+3abERkpJyB+GfMnnLR/GJy5EZqA31d7BTI6DUfupi7058b82V9SkFDEnDpIETMTcB91DxhA2SbFSKUFLAFDXjGg2XNo8fT0Evh+fZdMp2f1UlZh/uSHsjIdbgq0EKmUr9t7fBw8E4yatoLVgssAslvR+WLv4o2j+Tz8+tAmO9cpmwm3a6gVnnVGKdY7ki71tGMWMR3TzHhPgTLPyXXBtzREih4u0QBCu5RghGN9HMLIFw62yCMV17TB3XY5vG8PMYH64LO5ibnKLp7Q9W0tPWlLsTZ68wX9W+FTHt8lk6MYAp0sZbEE/sqVXpS0IFaqKAdpNIrIhVXRznU7cSxnF1i31swf468d+GdaQk6kCErTy7nGLlfmzl6rfbhukPErYiPsrpkL3WXwmsVQrHkZymD7wLTy35YfkwFUXwOLeQqoTdT4eCueffWoFLr3uBBCaD9IVyBU80Zr21257Y4UMNmwH91BX4I5XeBDQC4GbUD/xjLwmmPSB55xaL5xf/6vFxTl0KpHIJekgzVGqorFa42RkwKHBAziGwhj6n/WOVrGmEEqfUDPHuA8/shf55MFCKjOS4Y9XiHlQs2Z6z5gdkVHbdO6AfaAS3YsSpvu0QhBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(36860700001)(54906003)(81166007)(70586007)(82740400003)(40480700001)(316002)(6916009)(70206006)(336012)(426003)(26005)(356005)(2616005)(1076003)(16526019)(478600001)(83380400001)(6666004)(47076005)(7696005)(44832011)(40460700003)(2906002)(4744005)(86362001)(41300700001)(8936002)(8676002)(5660300002)(4326008)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 07:35:58.0735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49091c52-35b2-465b-e38a-08dbcaf5e040
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8534
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
Cc: Alexander.Deucher@amd.com, kevinyang.wang@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

FRU EEPROM access is not valid for APU devices.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index d635e61805ea..a08c148b13f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -42,8 +42,9 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 
 	/* The i2c access is blocked on VF
 	 * TODO: Need other way to get the info
+	 * Also, FRU not valid for APU devices.
 	 */
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) || (adev->flags & AMD_IS_APU))
 		return false;
 
 	/* The default I2C EEPROM address of the FRU.
-- 
2.25.1

