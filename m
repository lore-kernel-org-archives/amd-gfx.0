Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AFFC001E0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 13:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 488E010E1E5;
	Mon, 23 Oct 2023 13:47:03 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C14E410E1D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 13:47:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMYr0AgKMcBFVaHuOg4sBxyA+uceiByZ0i1x5YuMagpFq40eUCcUStF/OA0lD3F76Zxa4Zxck5/KG7eT0ji7nAsAaTRni6Gbekvj9AqdT98uNCVzGGSqcchbzRniRubavZw2Wm4jtWB3GcxHOPgQVexnqPYUbmHmxWgkeYMhCVrgz7ESjl/OygKUy0Y27zUwtTKALB4vEwTEujuSJigK/rf+n9t7QjWorAPj+VhOMNOPwgOy0kPWwpKrpFPjUOE2OgOUzpbCObPAXvvTzXCwfIS62s/966ikbazG5bE2Hc9oPa59b9B1Eb4y9qcdPxpsMdaviafMnsHlCgpQsdG78w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyMjlR16CixCYXYA1U7gY8lNLxVsRFB1vq8Ddf6urxw=;
 b=odWHbAMDc4Az24ZdCegJU0Ueo8i5SqmVMUvEU6tYa0vFYk6KHIMPst8qXMS5qODMJQxRhELZjxZzsFUilQaQA8/HuBIokbj/IdMlrZqSQ+jybFw5mjN6e6qBWdDy7JV8C9GaD6IN5CCG1PLQJgjooJVsS1WXSljO/uz34e9vB3vlKC/oJhadKtC5psjW6puS9+7txQKJcheDCLXbVvMa8alIXCNs0DVCmJhIe19geRDWg+ZL2QN7tpWmJ3Bug4Tl4EIPN/q5SdJsmwScHhnR9zK+1s4A6gKX/31HwkbRoKCOSVIN4fmZN319QRmS84AvUJXSS5/ysOtLOy0vnroSHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyMjlR16CixCYXYA1U7gY8lNLxVsRFB1vq8Ddf6urxw=;
 b=PhrizeDd/Ox0v+HAQ8bavklt/ZK0xu3gP6MRnHE3jL0aS6j9X7Pvl9V2d+YlWzf+8iOcjls1wjkc36NeOB8MTnTvhZWzQAvrZ1WKI3gWnOvKokCnMoQ/zUsNOa73WO0qlQG3wv3bM7sGh7hkMD5rsL/xa7K0mv+ms6qx2itakYw=
Received: from BLAPR03CA0011.namprd03.prod.outlook.com (2603:10b6:208:32b::16)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:442::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 23 Oct
 2023 13:46:57 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::f2) by BLAPR03CA0011.outlook.office365.com
 (2603:10b6:208:32b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 13:46:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 13:46:57 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 23 Oct
 2023 08:46:56 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Disable ASPM for VI w/ all Intel systems
Date: Mon, 23 Oct 2023 08:45:14 -0500
Message-ID: <20231023134514.144863-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: a87df016-e0cc-4458-d3de-08dbd3ce8684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: skvaXFhUCINheCqw+zTKGiNDs9EFGu9Wj7hC+h/8PHviSOECVmFGYLQq7GkBDclA+9Cx0NRtbRQWKoLcZD7zPK4/1bViNvavRphv+9YJuXELYNy8RofR+/zpFjFQIgshP4nutLif93DGeB4yri2YuaUyZQN1lxKCKomqgIBYbYvXP/iGP1P4XCZqOBg457T1S2ezOwlpaBpGilwGmk5UWRlmtmf8EgfCKdXPcSWJtGTDEZuBiWeXEr/c9k0bbnRtTanU3NNdKqMhjIH0Xc+edTsfGF7+Z0yOLX2ftWP7J98OUyIW2JbrQ5foaouCgeUv8y2fLJUkGY4qly6OUz0xTquAdcSl1XVX54wX7JCGNsa+7fosmDxZ4CZaoNCPWhrSRej71KGAH1eOhLVSyN1WEPZpxRPuzo6m6FDxWOGzabkOGHS+/lWr7DVctXniHmA/sIxELq7OZ/tNh5ITC66aKGvZIwh0/PBUt9DvUswE6Xu6xchrjk6cxRQ2ZmaWv0iZ06ocJMLOmu3DuuKD43hqs39NCFE5RfNBbhHEBbAk8bqc9DHutnDF1/+UUS8AOnZQwK9ZMnfggcO9g0217bE1e0+lUeplW6FAT7tyl/28kkZjRBwyseXl+Nyzux/vmxRUDyx2tAT9L3uqyjupuVXTFPYRgLGsvCmterUPKoO4LTgO5nXQVPr1RVQjn8/v+a4x1d8yJ2KjhJJ5GGYNN53xH96i/V+On+CwVBmpt/ygxKhRDSCQh7z86//+djTlPhenuBuPqcmhtpdKosrDWWXOqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(1800799009)(64100799003)(82310400011)(186009)(451199024)(40470700004)(36840700001)(46966006)(426003)(83380400001)(26005)(336012)(16526019)(1076003)(8676002)(44832011)(2616005)(40480700001)(36756003)(40460700003)(86362001)(41300700001)(8936002)(4326008)(5660300002)(356005)(6666004)(82740400003)(36860700001)(47076005)(6916009)(54906003)(7696005)(316002)(70206006)(2906002)(70586007)(81166007)(966005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 13:46:57.6164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a87df016-e0cc-4458-d3de-08dbd3ce8684
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752
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
Cc: Mario Limonciello <mario.limonciello@amd.com>, paolo.gentili@canonical.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Originally we were quirking ASPM disabled specifically for VI when
used with Alder Lake, but it appears to have problems with Rocket
Lake as well.

Like we've done in the case of dpm for newer platforms, disable
ASPM for all Intel systems.

Cc: stable@vger.kernel.org # 5.15+
Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
Reported-and-tested-by: Paolo Gentili <paolo.gentili@canonical.com>
Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2036742
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 6a8494f98d3e..fe8ba9e9837b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1124,7 +1124,7 @@ static void vi_program_aspm(struct amdgpu_device *adev)
 	bool bL1SS = false;
 	bool bClkReqSupport = true;
 
-	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_aspm_support_quirk())
+	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_pcie_dynamic_switching_supported())
 		return;
 
 	if (adev->flags & AMD_IS_APU ||
-- 
2.34.1

