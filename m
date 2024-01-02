Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164EDC47074
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 14:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F3FC10E16E;
	Tue,  2 Jan 2024 14:08:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AACC10E16E
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 14:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2p+oojAXMmaIsOmx74DO/YkaPn02/9T0HArkXLNbrtB03Ce89VgLyFTEhTo5aF+g73muDLwGn00HBnPwIs7aopwFOdbVcr6O1Z+uuO+XOVSo1tIo/XIftQfLQUTwEZOTq6OX+PygxcLV6hIgV48nWNfHZT3b6VYioC0DOOoSb7HJJyQlXmJDQSiiqaOhPlDJqBkLkdKoAWoR3Vi45WbwD+HJ9gg/AJVg0UfvDtENOwLtc6zPYBBkTa9pAKiws/HMP9y/e64GIA1a+INwYnyadJHjKugtN3PC6DhpADEDggDcDshjkVe/BRcJDlNUPKbmADlEIg/G0d/+dW4Cdictw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUs2UUoXHy4CooRXIWMmkwA/v7OjewRUZC1lxrSk8bo=;
 b=Txc1TUAUBHvNZEtK25qIzcaT9qSMZPRi3RybkMVMdcIoYc8VlxS2QCpQu9VgpzUKS+wuvwz1XWrQBPP5zCQ0McqbuY8wSTqklUojRREzYu3U6mTX8/d6O2N+kaXRrw69wJhYkviU5qwqO1UVInE8UZ45oNosbzpLa8Ki+0rl5GlaX11bPTfyF5hoIHGyyzmb4u/K+135uFzljsadG0zEGNyIcZw7QwLTSs2VaPK2YFrU/3BYeOc061d3Ih8vk2W2TTktLCWpFTZme8leAwjcn81bz732MhXxUrsgCTDUk8+Ji2Zgsn0wwmdTqmqi8ndVFAfholKsObdyDU6ivO4IIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUs2UUoXHy4CooRXIWMmkwA/v7OjewRUZC1lxrSk8bo=;
 b=caieb4llaDqMx7O0EG2I6Zco1blxZsUc6SGU9E24BnnZqcD4BCNhWzcE+kpqcoQC26J+HA2Xc1IDgcdWl3QXhY/VaIR7XByXDsSbgRM9Extn8zcP7TSQsu2R1fA7ebl4ojg5GiPu0IMkT7I/H1X9iSKZYX+Z98psOZB5nCt8xr8=
Received: from DS7PR05CA0098.namprd05.prod.outlook.com (2603:10b6:8:56::8) by
 SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Tue, 2 Jan
 2024 14:08:02 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::6c) by DS7PR05CA0098.outlook.office365.com
 (2603:10b6:8:56::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.11 via Frontend
 Transport; Tue, 2 Jan 2024 14:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 14:08:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 08:08:00 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Tue, 2 Jan 2024 08:07:58 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: Init pcie_index/data address as fallback
Date: Tue, 2 Jan 2024 22:07:34 +0800
Message-ID: <20240102140742.23917-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240102140742.23917-1-Hawking.Zhang@amd.com>
References: <20240102140742.23917-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef92528-4300-44db-4296-08dc0b9c3b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLbnclfQWD6W2MKgFsDh90XRv5sAKnNjH0Td+E9mb9v8WetjGcH4DuaQxLK9VIym8sXZbdfLE2RfuR6wE6W8suvvnW7voi2jz9+c6PhC4omJ1Jyddfd8bIuqHnFYd2NdezPSiF3eLOMp/gL276yWZs7cVUkhqmhnoUaMrUZU3UEtxnYzx86iEIdTUXEK2q0t3/7ImgvRrPwP5fbicWWSSzcK95MJOYRFGNiAdzFEg4eo4uIDbk46L+RcHDOoSarc3ugtoNP7fjNnDswI57kSVnfHfQ3nFq8EkVlnEZRJjSJPxOyaY9lA/g86wFwzLNFCanc9BQLb1K14hQIDAj9FVwpe4+ERCpEODNQ/NlehBjRYtG4bHHUNCDJaHvKs2btcJMIL+Vr6CeVkJn1btdAuA956p14O2ZjqKsXDb71i5GQl997GAImFTbcIIQWsr/iH9rhpxjjrKOc7AJZ/uN6jzsfzY0hq+zwDApkbHFK5zwZCAvodz3/FQv3aTKqsWXY6Y/YygDRN9wODHBFNaZx+EmWxtzUIY1gRuaiGGgVfywHzEUhuGeFanlAGuhqtZjNHChJIss4yIniNa0pWuGtaZsmw/pnHLKfPNjM/8sWaiKkkVGYavJAg9Y7eGFBGOOkGLcvw/05pJvpkZ8D/3FlJylwPVUb9wd+6dpfLzu9wSFR9MkEfR+nSTAyl6UrH5n/riTBWjQXhpvngsjqQeMRxBkMDTZnYcbdgTCOqaQ10iGkDl10YiQITtZE4PyPvuZge5XRqSlEmG3z0X8jgucuMCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(336012)(2616005)(1076003)(83380400001)(26005)(426003)(86362001)(36756003)(81166007)(82740400003)(356005)(47076005)(5660300002)(4326008)(7696005)(6666004)(36860700001)(8936002)(8676002)(70586007)(54906003)(70206006)(316002)(6636002)(110136005)(41300700001)(2906002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 14:08:01.6396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef92528-4300-44db-4296-08dc0b9c3b4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To allow using this helper for indirect access when
nbio funcs is not available. For instance, in ip
discovery phase.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 001a35fa0f19..873419a5b9aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -781,12 +781,22 @@ u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev,
 	void __iomem *pcie_index_hi_offset;
 	void __iomem *pcie_data_offset;
 
-	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
-	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
-	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
-		pcie_index_hi = adev->nbio.funcs->get_pcie_index_hi_offset(adev);
-	else
+	if (unlikely(!adev->nbio.funcs)) {
+		pcie_index = (0x38 >> 2);
+		pcie_data = (0x3C >> 2);
+	} else {
+		pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
+		pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
+	}
+
+	if (reg_addr >> 32) {
+		if (unlikely(!adev->nbio.funcs))
+			pcie_index_hi = (0x44 >> 2);
+		else
+			pcie_index_hi = adev->nbio.funcs->get_pcie_index_hi_offset(adev);
+	} else {
 		pcie_index_hi = 0;
+	}
 
 	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
 	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
-- 
2.17.1

