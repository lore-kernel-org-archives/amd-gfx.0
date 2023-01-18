Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF2CC38147
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jan 2023 17:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0C7D10E7BA;
	Wed, 18 Jan 2023 17:28:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A50910E7B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 17:28:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0MAIBCaBeTdKCOL6fJCZLTIrTyOrLCzNlefP1ByVE61uVhF4VTFiYzBvxA3P0i1VYEYVKy8SWAN2d3fYbo0lJzcyTsIubXKjm38Td247ERKZhF/G70lyqmcP5DYklwhS69SppaJFQNWqqlxo+M9QsPGqlab53SAxptCCarPKcTOL+2r0I0z9ckAzxyRxBXVVuqan+5CjSPlaSHOpbKgx4XVC63D3ShOdsiuJGmi5Lkl4TlYQK0BYCGS4u6HWCBC4SsS0z9FiX0hEi45jA/Y0jiSSzjdGf80M81byIxBcvLaHiMRqru3kcL7vxJQ4e7o+lkIpLbri8ePpCFslrGSnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aBW/qCYEqf2fvjjOKrFn9oqO/7PnviFEPmhpTk8A/s=;
 b=n9B+7TznMt0Jqm2HUClEr7O1cQ6L2Cv1PLqKgoO0YvrXLz1t5pPZTeVtoUmGXHMe0g4QCgeGYFbWS5I/+L2HTmtKOKq4P1aqG4jvdCR9/SHScirhCrE3JS7GjIB6+1Q9EqwdI/AyxYrZlutNRZqGZMA3IO2bmLVp27+0OjNX7PtH05ENJOIkEuJt34CztrS9xwZoBmVeeo9V+hyn2Yfvb99NBGFsyDMk62DZndtlDI+gogRv6z6FwP/mb7hV/ijsvnPS+cdITfhgh/6TJ6R66NqCARtoftuKhRRuMV0LwwyPO3LFLQRcMSip/xEk1tVChw563pXSqAwI+cZ3+FFIFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aBW/qCYEqf2fvjjOKrFn9oqO/7PnviFEPmhpTk8A/s=;
 b=1W1HxYW/OmiOvw283ltBwf/obKAthjIAssMHWkW4F2HcJIf3UV8A1g6jDcpt4TYPhTBePPt1euLa/uz9vIq0CRIs+eSKfQi8iyCy8dKFpMtKb3/Ww6mg+1izd9Qxjqa3TcqDSLAMnk8MIdZGH6GbZ0mRDNUXeohWZf0H+FCIqho=
Received: from MN2PR13CA0023.namprd13.prod.outlook.com (2603:10b6:208:160::36)
 by DM4PR12MB5842.namprd12.prod.outlook.com (2603:10b6:8:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 17:28:42 +0000
Received: from BL02EPF0000EE3D.namprd05.prod.outlook.com
 (2603:10b6:208:160:cafe::44) by MN2PR13CA0023.outlook.office365.com
 (2603:10b6:208:160::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.16 via Frontend
 Transport; Wed, 18 Jan 2023 17:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3D.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Wed, 18 Jan 2023 17:28:41 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 11:28:40 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] Documentation/gpu: Add Mendocino to apu-asic-info-table
Date: Wed, 18 Jan 2023 11:28:40 -0600
Message-ID: <20230118172841.5690-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118172841.5690-1-mario.limonciello@amd.com>
References: <20230118172841.5690-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3D:EE_|DM4PR12MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: 94412327-3476-419b-e1ed-08daf979719c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DBkI/vvjS7bSBYiyLd8nLMI6C515db9oCydx4Sf84RSM7MF6oCoMl5mEsEPeTY4YxIW4kcg31a8q/s+jJL8VGUVek5O2uK7VhRCD4wcwVppryjxePzGYbcuWZ1L/KTG5/2CvWxA+DEbqqaqbFOwRo1EyM11dzf0/xhFiOndTmhE7ObVsRbaQMfCpLOQtV2e8OfSGhQimEu0X2p6A/kFIMdRRVDfDv67m77AvEYOf9Ny+AZGpnMBCxUbOy31eFlj3E2Bvuqs3WrodAGrd2L5/qwZheyB7ClXfinuA6oBTI8fsjBgoeb+ggyFRPINFwO2uVpfUbAfvT88IVFaYXITqxcstt8XJl9LCupbOoYMpiD3S41/frHno+gDz45u+NueQ7FjvLispFV3BR9W+Asi1vxjNN18CyMwwuVQwCmbQ90FfCcY4EUaC2bmEA5PylcC0UgH1XowBSq9FERRvWA9Lzw3cAm6b/a/ghWYps11QJ4BRPfy/C9CQNuydcxOARzUYHtJxl88fnq1QyEjsT8744xlyXX1wmkNdiUTZmYx5ZXYmBYbUxDoU6eUZW66LeRTMzViFUC1aPSdMijtpQX8hkwW+WiGslUJ0abw22taDJ7Hrh0EuNJNViY5ro4JkWIdiHii+hXNjnkLxz+QENYMmUd5RuG09kqX3lG+hgXH/lYCNytG+dF+f+Oa97ehnOJRornEgsW9Y4r02+Ki8dQD1C+BP19rqw80leH3KnFcX9MsiE8tnMl8qkOzivr+2OMmE0whu1CRsZSCEtQq81/RtHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(36756003)(5660300002)(2906002)(82310400005)(70206006)(8676002)(8936002)(44832011)(16526019)(6916009)(4326008)(47076005)(82740400003)(26005)(356005)(966005)(41300700001)(81166007)(478600001)(426003)(70586007)(40460700003)(336012)(40480700001)(7696005)(86362001)(186003)(1076003)(2616005)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 17:28:41.8343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94412327-3476-419b-e1ed-08daf979719c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5842
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
Cc: "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Mendocino launched in 2023 and uses the new naming scheme for APU
processors.

Link: https://community.amd.com/t5/corporate/announcing-new-model-numbers-for-2023-mobile-processors/ba-p/543985
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/apu-asic-info-table.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
index 4ca544a377e16..88f4e3071e696 100644
--- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
@@ -6,3 +6,4 @@ Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN2, DCN
 SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1, 11.5.0
 Ryzen 5000 series / Ryzen 7x30 series, GREEN SARDINE / Cezanne / Barcelo / Barcelo-R, DCN 2.1, 9.3, VCN 2.2, 4.1.1, 12.0.1
 Ryzen 6000 series / Ryzen 7x35 series, YELLOW CARP / Rembrandt / Rembrandt+, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3, 13.0.3
+Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2.7, 13.0.8
-- 
2.25.1

