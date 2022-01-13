Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE11C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 07:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80AC810E117;
	Thu, 13 Jan 2022 07:35:29 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2088.outbound.protection.outlook.com [40.107.212.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F4910E117
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 07:35:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9yv/zRKMLqlJvKLv0bJVt034F0j9cZI2i1CzLD82dyqhpcGUFLzkXdHzJMQtUCuWzb3lB0JzF4LphceTpJKRiGto6NFVMKoQQDwIXqNG28w00D5qnGCbIduxK6ASmf/LagCYa5epmCKtS4TbV9e5xOFEs6XAb2pVU0kkdbFI/4cqPRPItflBL6FIjVo5U+nBs7TgWVmgnubfmr510g9aUXQrCFkvesdNi7C/t9P8gNzZBFs4n0SRPzlNOYizc8t4ggsToXBdKo2m2LeksLl95QHjmEA0d684Jrat8YuYvAeKSFvxVPxXYZ5tFNaoHfZ5vW7AYQfAPeHE55pLv7/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4NBvtDWTICvOqkVj9zLkGnH9ofaz+zr4kXpHnTLSTc=;
 b=S/2dkRN6lgQmxvfpIJY8SgxEqCA9yR5tjjeXAzyZQ8hV47+lsB55rbRfJ6nL9q3ZNziLZ5jl2bJOcRHhR0I+sRPeG1B1l+clA2mN9Ok5WAauIECkGGYRWBwSIqDv6c4V5Z6E4fogziGsmuq/E2AGCiWKsk8X9KTvGofOSgC/xfiSsBqHPy5DfeXWvDvEDIwkRQOSQVHRdGrx9o/6OjzhtXWCVWGjxEfcfbm9NZAmZpgk1JgU0++oJ5Y1r2n+dt3eas1Ye+piqf6cIVOOM0AB++CvfE20xJNgVOXuBUs0NLEyKbn+9zvSgMMuMBeqr2koh5em4aizyYxhmkSIfpHnrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4NBvtDWTICvOqkVj9zLkGnH9ofaz+zr4kXpHnTLSTc=;
 b=dOwu/m/dXMjP1KyjXXI8CrGUTTZ2J/4xRF+PRuU1TcPASgtFK02neomxj+m6fig76mnZfqU+VH/hXlPc7fxHV03nbyYC8etDXoV4WYLrQVRIxWs3fF45ArBGgH906MN1pdV7hjfdOwSUWFjaShLb+WepBkcvdnStvI4KaHzFni0=
Received: from CO2PR04CA0194.namprd04.prod.outlook.com (2603:10b6:104:5::24)
 by BL1PR12MB5361.namprd12.prod.outlook.com (2603:10b6:208:31f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 07:35:25 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::5) by CO2PR04CA0194.outlook.office365.com
 (2603:10b6:104:5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Thu, 13 Jan 2022 07:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 07:35:24 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 01:35:21 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: Fix compile warnings
Date: Thu, 13 Jan 2022 15:34:36 +0800
Message-ID: <20220113073437.3140364-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113073437.3140364-1-YiPeng.Chai@amd.com>
References: <20220113073437.3140364-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e37e13a-b099-4630-d1ce-08d9d6674345
X-MS-TrafficTypeDiagnostic: BL1PR12MB5361:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5361EABEF622C997105B2BADFC539@BL1PR12MB5361.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HpxKJyllfSA/4O/HBmKviFBRbzvjKureAf1HD1DbCmfDyv4djyg+/Wl0OV/DK3S8BLdCjKfQyeIFkH5b7GhfibmJKxyobZ7ksHFlFGrdYV7cSd574gcaPA9JJeCY6dGYG9H1F2IwBcIrh14Hp6CimrtfLyHb+c0lHIzQNcyNu55Bxim2asj4sYCiaZ6awpE/s1fOGgBzXbTWPsy0yTK71789vlYLKx9GZSzEC1Cw2rLVORjRihSC0WFYtKK0DeHiitoUt501DA2+Yc2oIZZlhdUqIpkZLb6GBnf2D8BMcH6ehOT6teG7IeRqq2Gl4/rnysNJESM6MzYKRR2BLyj2wRyWLIURCmUsWikkI9qkSF4d/k6gedvFWT8I4OGro+I0VbiV5OKfRv6mH/o17Yp2Ybg6GBlOnW5N3rJtXEbyA/buKiBpbLg5a9Q9WR7QlLs+Gsp+KVR+5ZIt0XFocQvVJuGIDKXYzGDi3wYSZEfhl4WdLKZ0auqDwPpg7CAFS5dyQggShl1Y/yHsBQFbSC+b2KzRJ/qmhSpHQa2As2AhBlrwk+nUpXIujm7uq8BPyzi8neDT2tGxzVLnhlw2yivPDc15KhrFpNFmQfDO/SKyrDlDz8F7l8XexPqjJqn4jrh2RIGbnySuqS4y+SDLpHHQNyP1fqEi3d/C213wsGzkqvNc+0iXuqd+QQkkGgucvbW+ha8vx5pu6OZZdth3Ge7pILGd4aoj5AI1urguKrYI+t3Cu/w8RswXI1XhMBzAtS8Nv9X2bIrBHcaTkOAgONci0pnthq3A6EyaJ7jvU+44hbUD8ka1/GD4K2Z2S7dBmG4Ka19ldo/VcUU12mxjEWIlWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(1076003)(36860700001)(4744005)(2616005)(4326008)(6666004)(426003)(336012)(36756003)(83380400001)(7696005)(86362001)(5660300002)(6916009)(356005)(8936002)(508600001)(40460700001)(316002)(16526019)(26005)(81166007)(70586007)(70206006)(47076005)(2906002)(186003)(8676002)(54906003)(82310400004)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 07:35:24.6698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e37e13a-b099-4630-d1ce-08d9d6674345
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5361
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix compile warnings.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 394a18e3c6af..7afeec4255bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -869,7 +869,8 @@ static int amdgpu_ras_enable_all_features(struct amdgpu_device *adev,
 }
 /* feature ctl end */
 
-int amdgpu_ras_block_match_default(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block)
+static int amdgpu_ras_block_match_default(struct amdgpu_ras_block_object *block_obj,
+		enum amdgpu_ras_block block)
 {
 	if(!block_obj)
 		return -EINVAL;
-- 
2.25.1

