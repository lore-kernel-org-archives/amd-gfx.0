Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2040CC7EE23
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2AC210E401;
	Tue,  9 May 2023 22:10:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C4AB10E401
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJFrDfpi0XZIQ3q9NLJbmEGJ/Hlj7CrXs1wCryvc52Bw0nLtDMxgSZUMkW9WHGosY6syo1FPOjSCJxSyEMqHT2EufCq/J9GHUuQLfrEajEEIfbccI9/TtEX5v4a7J2KEZkNvirX59PfcQLahDmm2IbyPpq5ftA0BH41HM2zV0gZaNp7CGIsdgZsZMuG9hYfzh5T1TZ4fU3mynnqBEDzqquKQ2bidlEfKz6nr1nVR1gZY96IcpESzBvlz+d55RM0vY3FsfFUdLsxWVIF5tyIzuHHt2R3D+CM/aP4zIQhCGd1v7o5Y1QCA4a4NZNNU7AWXL85PMzUSdbJ9msjk2WLDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77tfVeGwflVBicaAedKN2f84N5w1EATTXVnOddWx7vA=;
 b=NItG+XAp5PyzT7kBjGZoNwJndCggwHNG9/ot7O7pQrRZKKlKc1HuZOYMUEQVKKmZ69uP7ddimh+gJJma4jfKN6F0m8OQsxSuzyrU9+amTvguKNuHO6NFEBlShyZiRkU+s2sb6fGKW73AScQVXYyeHbBZRhkZRZhy5LqnbF2t9xLeJbWXsOWSKkkvXuii1VuikreSaLJNQ4W6e05k9TqK6/t0kvjxydz3su5L2KvJB7EpponTPNlPDmkmY4uDd+YGAM8ukhruJ0tOR2k05r/F7pmnRSAKcX2nxn8bD+AD6lYBPmF2fzQrvtxu9orWsdW3xt4lKL2Ebzk9x/vXgFzgyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77tfVeGwflVBicaAedKN2f84N5w1EATTXVnOddWx7vA=;
 b=nA8djtgcAtr9WgxczorWQpX7akOepuRKM29aQmrBF3Yw6eirqLrbbb1mCV62A/lsnXOmRYJF9ZFlXaHbu+g8c467DfvTYIiA/CbynGMepPFcPklPR+rzHEuFQbhCbonXMCf4xeSvNyhiTtTbVfO/9BfrCwDLlfwkljHL7rcKQwg=
Received: from BN1PR10CA0001.namprd10.prod.outlook.com (2603:10b6:408:e0::6)
 by BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:10:18 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::55) by BN1PR10CA0001.outlook.office365.com
 (2603:10b6:408:e0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:10:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:10:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:10:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amdgpu: Read discovery info from system memory
Date: Tue, 9 May 2023 18:09:59 -0400
Message-ID: <20230509221003.475858-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221003.475858-1-alexander.deucher@amd.com>
References: <20230509221003.475858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT033:EE_|BN9PR12MB5356:EE_
X-MS-Office365-Filtering-Correlation-Id: f14a3ebc-7623-4bf9-4de5-08db50da2cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vypI15+fB1YDdzngSo8T1Cjr4pF1mzWngjO3tu5gmn4biik1ILj77ifk0W7skqizslFOMDZAWlx2oub6+vkC9nnDhrvmrzIR3qBgIhRNDmx7/epjlMNFmTFsHldO88HYehht6ZB7Sixj7h4NELylvy+SlkYFdcHDiZ5DhUM1F8bovtRKM2npIqWN1eG8arf6Dquyrae7yfoxTqOkMkQRPC0c5oZC5YR4UXcLNIjmz6pTZgS9Yk/j79EVnee4DERqqXOXC35IxtgKhU4r+2VHrewsH0H4l+ahnKVR34HTI/3k313LUAZ/p/BggEZrKxdPzTyKnUmYpJZRWqAkoFp7bAcDx267XFwQQcmM1KUiU13d00TwwP1cLFTsRrBlrUBM1eiFGds/AdleImtTApg/xhGTMBHD1VB95zAMvJ+KUENGS6CdXxcIhXNC1to2hzTHLTNBTbq4o1JI1vSytiTYXL2gk8j+vyDz4ysnEtIYnu53oZH76mEtVq6d83ZNCl/E7wHRbUr/k+Ymaac5rNOzgI8wxi7UM39c00VKo0+525DuzxNbKp7XIOQmKrVq1XvsS6u24f8Vb4yqc1YMIuiXe4pNTg9OgLSq2g2N9fMwav3DQi+0kelOOy6oZUDqgW3aAuI0tQCc3sZjZFG3Ka3STXej8X7+llRLcdS+3HXlYqAhZlkYxhoEh/tcKPEoC7IxI5DTiv5kXtToCO/Sb3WNtDiUdKI0VN4GCi+OYY7Nai8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(5660300002)(6666004)(4326008)(26005)(6916009)(316002)(81166007)(41300700001)(82310400005)(356005)(82740400003)(86362001)(54906003)(1076003)(70586007)(70206006)(2906002)(8936002)(8676002)(16526019)(186003)(7696005)(36756003)(478600001)(36860700001)(40460700003)(47076005)(2616005)(426003)(336012)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:10:18.6153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f14a3ebc-7623-4bf9-4de5-08db50da2cbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5356
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

On certain ASICs, discovery info is available at reserved region in system
memory. The location is available through ACPI interface. Add API to read
discovery info from there.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 6701f17a4db6..246070938c41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -203,6 +203,29 @@ static int hw_id_map[MAX_HWIP] = {
 	[PCIE_HWIP]	= PCIE_HWID,
 };
 
+static int amdgpu_discovery_read_binary_from_sysmem(struct amdgpu_device *adev, uint8_t *binary)
+{
+	u64 tmr_offset, tmr_size, pos;
+	void *discv_regn;
+	int ret;
+
+	ret = amdgpu_acpi_get_tmr_info(adev, &tmr_offset, &tmr_size);
+	if (ret)
+		return ret;
+
+	pos = tmr_offset + tmr_size - DISCOVERY_TMR_OFFSET;
+
+	/* This region is read-only and reserved from system use */
+	discv_regn = memremap(pos, adev->mman.discovery_tmr_size, MEMREMAP_WC);
+	if (discv_regn) {
+		memcpy(binary, discv_regn, adev->mman.discovery_tmr_size);
+		memunmap(discv_regn);
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
 static void amdgpu_discovery_read_binary_from_vram(struct amdgpu_device *adev, uint8_t *binary)
 {
 	uint64_t vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
-- 
2.40.1

