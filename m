Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B17C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 09:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1B4E10E57A;
	Thu, 17 Nov 2022 09:12:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4801D10E57A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 09:12:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyo6noREPY0eMj+O8YVM3yUMWOUm9qF894a0U9cuzNhB9EfWeDl110HGJl0t7MszzIwG6CRNrrvBwY/WiCN0b+i/ZzsXCQvRb4X2cF4eTYlCDBSqYrCAz4m8JuDiVn/NAVmLAgeLf5boMOLL/Gj8tnyUq+IB7FwJsr5GWtheIFeaHiZSbTbB9Rpn3DbyD8AfDQBHXXVVII66KJNLjS8Sgdl7HaFp5xjlt9p+GfG4Jkj/18yEpztBCfobdZ+Ud3+Vj5Ib1K0c5JnjEDyFTqzj45H+3Srw7BdisTJMjoV9bsx9Q7Ql4aZz9lurAhumSmK6KEc/H3YR7Av+anC5SuWovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SyQjyu+QDiPtCkK1g9pWw0g9e/F9j79vY9Eq2mkJiY=;
 b=Hc/a6wfc2r2dmeCsthfa1kWih2sTsUw4EneuEWPy7exMa11UGixSYV6tk8r58v8mfcTaYHmmaQYH91rcuJJDvkLKIOIotDRYTE1o5x1VpChbDhYjCtmUa6vBSZKdzJGkQUNZVQq+WWNTMgUWnvzlIgUCGfRgj1ZVaecTimD2p3v9LQuchWzZzfNC+PjFUBECIf/s6MKz6eRGmvoa6G5A4Ml+F4G6QzaRCu78mjw8MGDv3ktHdBwbW+JUHtYENlQaWoKgcoRADY+Xbrqah74SYF65oUOMvCF4N7v/cecRduf7m2TqdD53m8/kbmQr8C5JEE3J8Q/bc/3fXHpGIjoSkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SyQjyu+QDiPtCkK1g9pWw0g9e/F9j79vY9Eq2mkJiY=;
 b=pBJ+rSBVlNd1cS3mFwx0uJ4XsOTClwf4NwtLDne4U5wvpYBqXfJGpiHDOg6gVJlIEKS6pfzTD5ikcTavrit2et3uoe4WoA39GcraD/f85lQ0cMmuYmuMkIzCbjwG0zwyzXJBubwS/+rEXeXt5eVkgup7+JelQ/DAgATvU3/a8bI=
Received: from DS7PR03CA0250.namprd03.prod.outlook.com (2603:10b6:5:3b3::15)
 by MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 09:12:37 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::93) by DS7PR03CA0250.outlook.office365.com
 (2603:10b6:5:3b3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 09:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 09:12:37 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 03:12:32 -0600
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <Christian.Koenig@amd.com>, <Xinhui.Pan@amd.com>,
 <Graham.Sider@amd.com>
Subject: [PATCH] drm/amd/amdgpu: reserve vm invalidation engine for firmware
Date: Thu, 17 Nov 2022 17:11:19 +0800
Message-ID: <20221117091119.106597-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|MW4PR12MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: eccf7a62-e679-4bce-f1fa-08dac87bdf09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXwfMBrRJmseKcssziuVN1AJjHagn/jWpBeIQSOLDmgnK809Py1Zvu6DhGalshSAmmOTZ3rRMUd34ixgI+4T3pyrKqjhP212IIEtxeMEgmP8Q9T+h/Wqx2E8mEb1Pz9zPuzLiSvqKUfwPVoVQQpmzioIghvmk5LY3gEWSmeVvyu7B8ZrcbHNO9IUwM/EUdLOsmtNv6jNIaCKjCYd+yCkUlAXg+FL/vwkAFaOIK9wpjtDmKil2kOo16ElvGriHb4z/Qv0Cm3EHUdZCe0AXXQCVC5inw5HHl7oXgR8bAwS4X24i3Q9i+LJEERAtFq3n4J1fXawvf4cVbAN8zj8+Q9MkG4kl+LFxnqWbPpwqtHeL5FobHu3Yx8cAmgUihQD2X+/aKbMooXYsF87Z4v08qs0y/ydYUCl6PGl1gccDgONozxRxvmahGUZp6PQlbXj6iCV+CSXyZNmse89ORlYXZkjM/Bg0xxnbeeh+vhBg5Asu/koQGbWmdzPE9FM94A8tav+gBlUUHAohcHL07PAvkcyRHrtmdy4s4cAFuPowGHdjmkqsGxf53p9p+axnIXSces8hpLNY5rQxes1Z59gZ8NTc6iwwzj1RajYv2CqtlHq/qhIG10CwNexH1HfMzsXPJPKiRW/GWWk2zPZnILU23ctP1UjKygPyoUKRGd6hFEseIgSzugQp3QkprREKSc+3YVbrAGlvMvFmhIsFhZdwEMuFuMWHWA+URTu8O9lkd7Xtsj+rwyLcxTjv64MJdmvQ6sG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(4744005)(8936002)(4326008)(5660300002)(316002)(6636002)(70206006)(70586007)(41300700001)(8676002)(40460700003)(110136005)(478600001)(16526019)(426003)(47076005)(1076003)(2616005)(6666004)(7696005)(26005)(186003)(336012)(36756003)(82310400005)(2906002)(36860700001)(40480700001)(82740400003)(86362001)(81166007)(356005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 09:12:37.4225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eccf7a62-e679-4bce-f1fa-08dac87bdf09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If mes enabled, reserve VM invalidation engine 5 for firmware.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 4365ede42855..e970e3760cec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -479,6 +479,12 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 	unsigned i;
 	unsigned vmhub, inv_eng;
 
+	if (adev->enable_mes) {
+		/* reserve engine 5 for firmware */
+		for (vmhub = 0; vmhub < AMDGPU_MAX_VMHUBS; vmhub++)
+			vm_inv_engs[vmhub] &= ~(1 << 5);
+	}
+
 	for (i = 0; i < adev->num_rings; ++i) {
 		ring = adev->rings[i];
 		vmhub = ring->funcs->vmhub;
-- 
2.37.3

