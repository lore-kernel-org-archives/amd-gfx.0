Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFCFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 14:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9DEF10E88A;
	Thu, 10 Mar 2022 14:02:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA2A10E84C
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 14:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzGQKRaZYATf71I8aUhzArsrmZ/pSvOIre++lO5psIB6VTIyX+5jlOkwR/ilhXapZ85Jl8y0DUDHTmwE2NkA8l3aJdEQUxy7P1UPuYqcFdUK4yVRlxJ81dKfHeYaVw7rhdytVdqy2pGYo222THmd/ixTuGdzh9SGNW7F2RHK0zFxuxZuPHL3CZH/JvB8eVNBLQzLL9BMTz/L3YJyAAmGM/3k/IPUTSRcCjL4ngRPIfTbuooKdYW8N2D/DH6/9cKMY0tzcpPcqUHN/gLDQYq62CY1jZkjLzNn29F+ZQ1IYwp+cFnt43RZ1lueVVoS/3MnygMOcSej/AxBkTO4Mu1/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VE68RERAvlmv/31bTEMUaK/pSXDtvynS9TD5WeWbEoc=;
 b=aBTceL4yIVpyqpnHbP2phr/M5KMs4TXyIuOa6gLoPZipHqIisVnaKZmiBtR/RzWY3RCTxQ+fDKJYkjmtEaD54BrsWu60+N974Sp1YIJW2DdgRFQ6ThvK0C++3bOHx55MZ5MST+Lhymu7exHGEm5qn9kiuypvEN7gaSjZrm10C3LWaWWvAUSEIItOYpOMslK4lu1wwgrbLKOhBstqm8vs9YIpdSdWm3gJLLzdD+dsbZl7/DP759cctxnZjevDf0NObdNz4PjUznelaS7NkMNHC6OMlzb6McbUlktwhm2tL9HTLI4kVARLEE3mCXcZXnl12DIqS8ML2QtpGJpz++gu2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VE68RERAvlmv/31bTEMUaK/pSXDtvynS9TD5WeWbEoc=;
 b=CufLko7OvH2lTnRU3yJjVrMoScYABbyOCwwiyQKNdXyuLCAm0hc+IpvShyvYj+1wQMb+doxZVE4LYWVYg4HkCRPvii8qAxq1foyTc3jIyNa9dRpt3kfa+6Wxkgz+2PePcDsoYPjsmjEhsGwzcYtX1lsD/TMaa2ySypNvcoAaRTo=
Received: from BN6PR1101CA0013.namprd11.prod.outlook.com
 (2603:10b6:405:4a::23) by BYAPR12MB4710.namprd12.prod.outlook.com
 (2603:10b6:a03:9f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Thu, 10 Mar
 2022 14:02:37 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::c4) by BN6PR1101CA0013.outlook.office365.com
 (2603:10b6:405:4a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Thu, 10 Mar 2022 14:02:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 14:02:36 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 08:02:20 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 06:02:20 -0800
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 10 Mar 2022 08:02:18 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>, <Evan.Quan@amd.com>
Subject: [PATCH Review 1/1] drm/amd/pm: use pm mutex to protect ecc info table
Date: Thu, 10 Mar 2022 22:02:14 +0800
Message-ID: <20220310140214.2562-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97630f96-9733-4fce-ab25-08da029ea20d
X-MS-TrafficTypeDiagnostic: BYAPR12MB4710:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4710B8672D8F9016D99A34329A0B9@BYAPR12MB4710.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jAN/pkPEFM3+Fk/OgRzRtQtp6Ci7nH01/JlwfQZ2aRUBcl8fi/9EDZ0pqKUtNJUCEKyESp8nOAhv7hOe6J0iTJSFEULCZjoo9Max073O5SMDM1rjiYUnfv3WaXyLaW15p5PZzsUxLdaPJPnE6bJYJRa0Y3MIO6hriyoklztMa4Md7ZkiwXHoQh5bPqZG+QVCVMCS/DjfQ9ZlROywb3Y7oKO8hhA/p4u94NRspce+wWlZq071NIy3Y1aIE0/xujJYWDMIOGOW07S8zlCWhDjDJRO5J0p2oRNtOrD+4vF3xITFXPuK0lJof2lxD0sTJP7Q11gDKbG6eR5iYjbG8KhUfiiF0J8SlIyHaGpMIjEymmN7kCQsA5hUPeIIfTJpKJlfHaNLhMf5kWQfw68nOvMGmvGIfhUTRZ7p5/hAFAO4HIsjaYXILnDECgtITyAkBCFpOowB3no+VvVxm4StQRO0P43NHl05fvuxgayxTlQN6gwdn+7WmSEz/mVmQ/m5jrvsF3hPPvy1vVmLe+apmJu8QFTzDYPUdiK0WZ3y08ylrpsoOY/DAiriSQ5JeOWc3f4wU9lh1c9DnZcF5am80tpJcWaxyWQcKw5txOj8wzhqFNxjh7Jq4kkXR+ps8G6/xCwQ7bn1UwdboWFQAwjUIzB+v0y8VeyOT4ECB6pBQGRSVITGWnPTNCUvDTUQV9lgFlKgmRtBczgReNzkHyG+OCWBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(6666004)(70206006)(70586007)(5660300002)(8936002)(86362001)(8676002)(82310400004)(356005)(81166007)(40460700003)(6636002)(316002)(110136005)(36860700001)(4744005)(47076005)(336012)(1076003)(83380400001)(2616005)(426003)(26005)(186003)(36756003)(508600001)(4326008)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 14:02:36.9333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97630f96-9733-4fce-ab25-08da029ea20d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4710
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change-Id: I6afe0332cbb20528648c38665264930d6b091c2f
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 9a892d6d1d7a..89fbee568be4 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -643,11 +643,16 @@ int amdgpu_dpm_get_ecc_info(struct amdgpu_device *adev,
 			    void *umc_ecc)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret = 0;
 
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	return smu_get_ecc_info(smu, umc_ecc);
+	mutex_lock(&adev->pm.mutex);
+	ret = smu_get_ecc_info(smu, umc_ecc);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 struct amd_vce_state *amdgpu_dpm_get_vce_clock_state(struct amdgpu_device *adev,
-- 
2.17.1

