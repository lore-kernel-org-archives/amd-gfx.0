Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5EAC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 15:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF2360EFE
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 15:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AFF2360EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C14889CF4;
	Tue, 12 Oct 2021 15:53:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47CC089C59
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 15:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j73aNXnJe+qyVDFgNAhZRALESjZy3ZV2/5P2CMAjLsTD5+gRkleVDORB7n3TnKILwCPhJZMIhRKDz+bNyRGYakspP1jn9xiQRZ7RJ9GsnwgPjImGBnxziCIqNhlYn3/g3RT+cNnWlXMiJU9PMVB6rlfjG9zah7aptz7pyXyi2UHWDXW+6q4QYg1frxO1k6l9kJJUvaKAU+GBfGBt8ggDnze3V2f95U6LvKuNUqMeI+EsgaS7vsPFU0cIRPm+o6U/WC/vvhNbmc34jWXeuu2vixzPnvWGP6L1Dz09cDKen0DAbVsuvhJ8i3eIHkyGTAwbRPlG1ZXd1V5So76qHwNNwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18fKRy0CQWAh7suG/0A03y5sSHDDXfAajvW4aZMsJmc=;
 b=T4ZrPLGqyP2DaSREbtHdIKpoh2dVefT0iFEcSEaT52l4uf7okti4JCaoUroT/SEq4nsChEmPvBnWF26rfnXrytzwgfEr68YxbJUhcnMOJ6XGMPk3i3P4jE9GS9JupgZG0SSp9EFBfQRPENdxIalkfvuQXaVxZ0oplIfY6TWeOQZ9t/Hy1mnMiQ+Jd4rMZvJC+WDjZ2qjAxpUuYi9st28u5MrXWb2i3P17XqMRLVOmcDVslfz6ScCnYmsb/zbbetURl4o/JqkyPl/u8v/saq/P5JgSj2CBvCpwlxY2XUlCwh116k0rHINEo7txJSmSV5tcFJFJFH2wy1KwyjIZE4UXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18fKRy0CQWAh7suG/0A03y5sSHDDXfAajvW4aZMsJmc=;
 b=NRNFiEKyKORbweYQJA5FpyJuxaEPtFNDoYGd33/xgpEyxipwIr9UGp95XG5jXQ8VDNjw2JVjvPgBQOZ1sXqeyVlarB2UMSPX963XDy6q8RSBcO79t2fFfzZAsIOSbuz6akfsNVRP64WrZ5vy22j0+cpmYGpG/E365CH6eD8Xcto=
Received: from BN6PR18CA0022.namprd18.prod.outlook.com (2603:10b6:404:121::32)
 by BY5PR12MB3730.namprd12.prod.outlook.com (2603:10b6:a03:1ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 15:53:35 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::61) by BN6PR18CA0022.outlook.office365.com
 (2603:10b6:404:121::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Tue, 12 Oct 2021 15:53:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 15:53:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 10:53:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/psp: add some missing cases to
 psp_check_pmfw_centralized_cstate_management
Date: Tue, 12 Oct 2021 11:53:07 -0400
Message-ID: <20211012155307.1059170-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211012155307.1059170-1-alexander.deucher@amd.com>
References: <20211012155307.1059170-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2f79d20-36ad-469d-235e-08d98d9872ec
X-MS-TrafficTypeDiagnostic: BY5PR12MB3730:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3730D847D84410F126CEB27DF7B69@BY5PR12MB3730.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qo6AtqWbPquQw4wFf9rrNAE/jxpu+uAEGBheMA4tPHGTU/YqdKlTuwQNVjgJkC1dtJbMimG1Pb9306xbP4ylc91S64oUMKOhD1R+rimvrpY7Y1TbAT47nHvP5p7WpnhDYwSc3jkPb/FgyksgctODQhky8y7HvlGE1pCnzrqkLMJTbrq2rkkNjAsFuShjHNUIIHI3uwGweVCvxHDRBqmw3pvIbPWWL1MQucpTOmc/jaHl1vLi/IGVtS6MToMx5ywCYgSvMuAEs12ZDB4CWarWB2AgV96paCz2Dkhpurk4dVlbeChlZi2Q0tiGjaxssqBod0wzDDW58leluEsxQCDg/UplROF3rwSUl5v1xGbb2y2dtgQx/1dSxevtzpvrWV1Bl/ucRlJFcTLNK3zczXmuh9ukplsuzBBUTas4xCn94OhABKhW/A3Ra300/i4d/vM69B/bl6mYxE1v9FSJ9ORI3f8NBJkaM275GvmfYG+timxZxFK2lIaBaYe+oEOprCEnPkBTMuAUsGOVPSbviAVOJDWBun/rBqMeMsZgFikbfqxt86AeoklHB/VbdkHIy+HyZ45ai+NhZxcImWV5CM4zFHppodPCaoLfa8hCHtgTpvEZhJfo/rtPaSIpNuYCoWEJi9esOtOvQ9rCNQiAR1h0zFtuBXL7tMuT5QbUUaa1GKeApTkFnSQlq0oy6o6txDKIMJXV2M1ua562n978jI29qyNyOt6akdUae+Z/SfaZI1Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(426003)(2616005)(186003)(1076003)(8676002)(356005)(4744005)(70586007)(70206006)(8936002)(86362001)(26005)(5660300002)(16526019)(316002)(47076005)(36860700001)(6916009)(2906002)(336012)(81166007)(82310400003)(508600001)(36756003)(4326008)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 15:53:35.1559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f79d20-36ad-469d-235e-08d98d9872ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3730
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Missed a few asics.

Fixes: 82d05736c47b19 ("drm/amdgpu/amdgpu_psp: convert to IP version checking")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 6b39e6c02dd8..51620f2fc43a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -77,7 +77,9 @@ static void psp_check_pmfw_centralized_cstate_management(struct psp_context *psp
 	}
 
 	switch (adev->ip_versions[MP0_HWIP][0]) {
+	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 4):
+	case IP_VERSION(11, 0, 5):
 	case IP_VERSION(11, 0, 7):
 	case IP_VERSION(11, 0, 9):
 	case IP_VERSION(11, 0, 11):
-- 
2.31.1

