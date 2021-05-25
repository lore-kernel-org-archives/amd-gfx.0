Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227B1C2B9F8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 10:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6FFB611CD
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 10:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6FFB611CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AE916E9E6;
	Tue, 25 May 2021 10:29:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 973FE6E9E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 10:29:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bk2iTOybViINw80Ue0ebM7aVG/0RVJyQn4qfcFpdyKo5ByPaTV48Qa9ssZHXuAY6ENC2afK7HbYYfYRA8RyFJ+AaYaf6tu1mIsb/oIySB3bP3PWLgjZElTnZ3rZ+6lNFB5YOpO/dzk2hgwsc6strwfTQ8XR0mnwkAfTmlR1uRcHCEpwu1o7weHt7JDyZaIpoRvUjRsojMXm0xPnjDPLWxNviUMTMsnlQ0gCvcLvL1Sxr1svBJY3JZYwoV++23LYMoq0DY2lepUBd85vzmCoVN+dtae1f081g/QzTJAkjEPxBK6pllkqSJX0+ouuAs/bsBv0V4iiFbhljtTXsywKrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qICGnACgoMO9NzOMZ/jTmRaP0B4MryxThM+F4+aPit4=;
 b=Vo0KoaZltqHUW2TDtFZP8anTxXkzkCc3FZoM0345zImRVFgerEutjgXPdQZIonRfz8QbF2TZMy3u8MeqyJzXjUcH+lU+mGAxtb6Uve6C1GG9vPP+YrAP/CjcOq4kxdbEM58A4vedsr6QLE4X187lwx+ecfs1A9RkbXUMmrhPdJezRoc0qZaWV5l/sn/G/wtdUjnFze+nclXQyZcH2NU5XMjQG+mmSVBfhXokBYj0/aE2SrcK7pd7GCKYqgXaP3O40KTpkhpvQeGv8VJfaZ+80ZyrOQZtkHT/K1paCPjet8kPP3PjQ2twSlYJbUUNd1pIM9k6WugEz8Z+oRq+WyAn6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qICGnACgoMO9NzOMZ/jTmRaP0B4MryxThM+F4+aPit4=;
 b=KfgCUZQBOl2cBuyRACS8kmBdotuKsNdRNjxMTKaYWFXm6cMHMwb+Kq86h9wttryWhK+2iz7iwJ+XjbVwgTAabAy1C/krpKYmGpygfK03dBapSNI4u1uA4nvQnGb8M6fZRDFm6agxQSHbzAaLEmcG5GRP4NDnPxhaINYCgNkmZNs=
Received: from CO2PR04CA0131.namprd04.prod.outlook.com (2603:10b6:104:7::33)
 by BL0PR12MB2499.namprd12.prod.outlook.com (2603:10b6:207:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 10:29:02 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::15) by CO2PR04CA0131.outlook.office365.com
 (2603:10b6:104:7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 25 May 2021 10:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Tue, 25 May 2021 10:29:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 25 May
 2021 05:29:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 25 May
 2021 05:29:00 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Tue, 25 May 2021 05:28:59 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Change IP init sequence to support PSP program
 IH_RB_CNTL on NV12 SRIOV
Date: Tue, 25 May 2021 18:28:52 +0800
Message-ID: <20210525102852.2983-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daadfe9c-2d3d-4212-e968-08d91f67ea1d
X-MS-TrafficTypeDiagnostic: BL0PR12MB2499:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2499E4DCB1D7BC72451EBB08F8259@BL0PR12MB2499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TilQ0ptMWOJOHSuPvrVl5WDus1hiGS8UwH8Rbax97Cm7xISZZeOnizC6gCfCi9EJUgR+JV8JMpP1q0zNiHfJ14RHmgoooADLI1LHOJHP7/KaPrUa4cQoyndAgaoxSlx35vl14S0nPgi/iGimm6UFEGNf0R6xT0WA6efPPPLJ9uEsqQ0TUJwZjohbO1t5Y+UgRz0MNAigqrJaJnzDbHdwSdvykU15RKZ1UoHpczZ98tFk4ByUZ+NyIir/ADG/UObYKKtwMxPC2IGnTVEfgJiQptKy2cfk2K0MVpjrXBM0BxH6DqrZ5UVacs2JVI3Cw5azrE1jqUDnP8cQSCEuChUmMiTqRtTzp1GNuG082FwkONJPNbIvY++23jmihz6oQVyOvJxJOrSgtaQPI+gfoE68bCkLdG5myZk746t3mD3KcLL5AfmuRP3gXlZaHEKjoz30RBxM0lTYPnKxoc4jGU7RGyxpqHCp/6MrCxh5WskIMnc/71C2YevXEUkBtik0Y/yUGzcPxcwR5XiKFMTpsYtQygO5HUttFGeoIYB3bRAUNc8SEIg1jJdl7oqw2DBXzm9XakpehoejsW/iD75MVEXLgtSb0MuVWBU23Ur7wzvOBCFtEubiQ446aFm+faOA5sROflj6PkfnkFcjKS3q+37kibSWIt469Zh4Zi12Rplz9wNB0kRkWQxN6yMPCeV26BIl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(36840700001)(46966006)(26005)(186003)(336012)(70586007)(2616005)(86362001)(478600001)(82310400003)(316002)(426003)(5660300002)(4326008)(1076003)(7696005)(6666004)(6916009)(8936002)(82740400003)(2906002)(83380400001)(8676002)(81166007)(47076005)(356005)(70206006)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 10:29:01.7898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daadfe9c-2d3d-4212-e968-08d91f67ea1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2499
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To enable PSP program IH_RB_CNTL,
the PSP IP should be initialized before IH IP, otherwise,
it will hit psp NULL pointer.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 437db0783b64..27ba0408a2aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -849,8 +849,13 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 	case CHIP_NAVI12:
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
-		amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
+		if (!amdgpu_sriov_vf(adev)) {
+			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+			amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
+		} else {
+			amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
+			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		}
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
