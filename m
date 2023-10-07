Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE03E94139
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Oct 2023 03:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEDDA10E058;
	Sat,  7 Oct 2023 03:24:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D94210E058
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Oct 2023 03:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqQExzmlN1rLGVkOMWSI/SpcAkgt6Ugd1ha15QhhudJ64aIuT2A4g7fjOYbBKuzleBkdUnW12YQ75qQ/SAijp0qnpWg2NDC7yCqtMdS3kJDfsHYnu490WeK5CzDSH4VHBSkIompHDRxfzl1aO7jG08cybxZJk4dApIvY1sxnEPjAOg1/OgJpnB0mExxofGBEG5nT+gdP1fV26FFAA3in6myrx2BZWfGljrQs8PmbUjrk7OIba6Bgk7P9aMRTAI+3DVH6Rbxuy1/Rh20yoDh2apbTypqhch0tEbaRSmedp3Ry1KwMt8DA0GNBSOxKfjbaYgxyQQoIDjSapk9Yzpr+UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h44sfw0IbLZm1HgPUGgk+zU/ImHcIm0Bu1I5rJzjTXc=;
 b=Bv57/Yktglh82Qx3MmTqpDmcyC+LiYgAgf1Z7Wv7G8MmMe41VpDtf2yEbeIe9k9T6Zd9L4jrqzvPbvz7xfkwhxs7/Qc6XVPHmDt7QEEEaI4uuRy+E+60eBcH2gU+ln22JJpY/EcMLfxtJiH6vaxpeE+pFrpA6xMmN19JqnXomz2p09eS1z1xsNS1yMjcjr43Gyua8XLp3bfYb8rzeQh+JwcA8hviRrqSUX2s8E4KOuHpYEAnlLTt2qo4I2/GPP5PD7Bk4oREOaYMxvXoXMzS217xNBhOIs2t/MJJ/tEjjhaQ8Y6RV1NC2eeGvFQ9Gq7yaz/188k3S6B39rgwrLIlXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h44sfw0IbLZm1HgPUGgk+zU/ImHcIm0Bu1I5rJzjTXc=;
 b=46gxdgVybculh2pBBetJBRifRVZ3+3TD6KkoLQONSlW/7S/cnaBfo3+so0wSR6TO8jUDcEePRFWnNlFYyvPIBcgo6Or6dWenSHRexHty3gnaFUvdJWq1Df0325WPaTiKK7a6mtw51jGstZykk73vL7NTnWgOVFDCIN5d6SDL89g=
Received: from DM6PR01CA0018.prod.exchangelabs.com (2603:10b6:5:296::23) by
 DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.30; Sat, 7 Oct 2023 03:24:33 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::e6) by DM6PR01CA0018.outlook.office365.com
 (2603:10b6:5:296::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.33 via Frontend
 Transport; Sat, 7 Oct 2023 03:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Sat, 7 Oct 2023 03:24:33 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 22:24:31 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>, Solomon Chiu <solomon.chiu@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/vpe: align with mcbp changes
Date: Sat, 7 Oct 2023 11:24:15 +0800
Message-ID: <20231007032416.9557-2-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231007032416.9557-1-Lang.Yu@amd.com>
References: <20231007032416.9557-1-Lang.Yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: db6cd7df-be54-4e08-baf6-08dbc6e4ecf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZD8LQ4eFYuDA4yufFJS1/v9KXcfDNLDo1ZFTS/orXxRyFOHsrN3ZuIgkh5we/qbS4LuzcTryStLwNwZJ9qIjUq0xsaKHXC10SUTqogHDj7IXXXXqgyx7ynfFz1/Z5YwmMJp4MgUuzBFSbVHLB9VDIb7ypIfANtwsuNa45EAKoufKWz8G8bSWXfecv5DntGX6vj//KP/libkaDuJnsAYaZ23fDzvv5KmQOq1mqhcte2Fh6dKyLbpTiUHvODat5fECs2jWiPmAQHbieCxr+3CrskhXbhcRa3lE+HeXyn7bD8KW7/6Yi+uIIJMCWlp2gvIzo58ShBXPtpV/U3XHyboT73kLilXV9NFzfM3ygbZHCQU4FyH+3vYftQAQb2ldqt6B+tVe6WFg3b7e6jbYZ8bqpdjdL1yD5J57uwKaPs9cPm6TVNN4OSHHQjcBm7dB5SBXlbBowwFkPk6Tuv2YejfLSS0uwk08IdWRj8JH2zJH0ce74x9X/UhWBlhYM/XNDkJi4Mo1cF2MsxtYqAkpn8UM3NiTw7XRySGq+iswrgfq04nac21UYgSogsdmd0IqUtexxht84Fo/XzXgwZO4YPyNqOcnHHCXoSRuJl5z2jhTGdDK/Skz+hZYB8+GZAPtDmLnA9kr2DihxMyADZoAzQj4mXpmDl7FfxGHLwHCGA7o2EEKp/lcKfGK02Ny5F4510vDVhj5VCzigSATAmzHtPlT7lSlvOt0terVh5IB1hAlrpq8vQHaeSWQPaAMg97CkpnZyyD4743jSVOX4FLbkxK/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799009)(46966006)(36840700001)(40470700004)(1076003)(478600001)(83380400001)(16526019)(2616005)(40480700001)(40460700003)(7696005)(8676002)(110136005)(6666004)(6636002)(4744005)(54906003)(426003)(47076005)(2906002)(4326008)(70206006)(5660300002)(8936002)(70586007)(336012)(316002)(41300700001)(26005)(36860700001)(82740400003)(86362001)(36756003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 03:24:33.2137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db6cd7df-be54-4e08-baf6-08dbc6e4ecf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915
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
Cc: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MCBP is decided by adev->gfx.mcbp now.
This is missed in rebase.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 23966221dbec..bb74478098bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -253,7 +253,7 @@ static uint64_t vpe_get_csa_mc_addr(struct amdgpu_ring *ring, uint32_t vmid)
 	uint32_t index = 0;
 	uint64_t csa_mc_addr;
 
-	if (amdgpu_sriov_vf(adev) || vmid == 0 || !amdgpu_mcbp)
+	if (amdgpu_sriov_vf(adev) || vmid == 0 || !adev->gfx.mcbp)
 		return 0;
 
 	csa_mc_addr = amdgpu_csa_vaddr(adev) + AMDGPU_CSA_VPE_OFFSET +
-- 
2.25.1

