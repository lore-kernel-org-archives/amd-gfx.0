Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5C8ECAAA3
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 15:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B14B310E994;
	Fri, 26 Aug 2022 15:48:09 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2076.outbound.protection.outlook.com [40.107.212.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A58410E994
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 15:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMI0xygj35JHd+OMoZaG50jN2sqZivl9xQiLLuuSZXxyfsdRc9s+z2YgNGGo+HhnxOJMLOdAPYgSUxNlnfd+oC5C1oo+UZt4/tFrGSatdqOB6sefyuy7gQHOcnUVPJTIV1PskKMvQnyLaF8x9qleII3YH/7KXpWlCfMVzMglDe6YfFKy/s3AIFOhyOv6oE9IDaVUkFvvHyXdMxh7W746AMMSyeWPDnnqQpZiuDpJrMvLRGGMI+4Hvy9N7an2u2N5YKVIaXuXTg6R0G9spBrQf1Di/AHYef78ghqxlBiLcX/zkpAIuqr0xdcQCfH42RiRrdCDSfrvWPcdVMjRVeQwIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gqQnXUZH+YEwoQO9q5cQrcEDZ3V7L4mEqnCBjvaPe0=;
 b=BWfBkLqFlRA0+4ZiESp9ubHCP1qOLVW0CmKfcHOs3M2+y/c+EqWBCTKhJAbmw/nIgqYuY7Z+uPOjt10vaE+Zm0UDXlPDp3hbS9J6MMRFQyZppRkVdsETTVCvT8rOmB4CkU/zebZ9U0ZzptLDfCucxFkeCjC9fDI2DLhKn9Mi6C18LY8JNW2x+gbflDhNm7rfFFpPaZv4LpNpzXWQuLXGg1nyPYBSNzaYnFS8GB78CFkurxu+O8Q0KOHjCGsKKQq6t/tPw9CHtE7zyxXQ8MFKX6mfDqFjK4nPH2qYMgTBmrVUJ2WR/5ETxY4u5eeRAIkxfqS5Fypn6Gtwyw/zXkoqMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gqQnXUZH+YEwoQO9q5cQrcEDZ3V7L4mEqnCBjvaPe0=;
 b=GspQECYXF4z+esQPOgKipoXQWdeaT3X1UpnID7j3dZvaIxVN4/pkBNKhoBAmeVunJNVRJqc6bZUTa/xkocAAY2UuOgAz8ffU1Vs7zY8D3tPgaZ0BnwvfZkM9V70tIMaPt/rBNru+8BHeg3RdMVMW1HrqBOVce7Cem27lJ8UYnYk=
Received: from MW4PR04CA0261.namprd04.prod.outlook.com (2603:10b6:303:88::26)
 by LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 15:48:04 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::63) by MW4PR04CA0261.outlook.office365.com
 (2603:10b6:303:88::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Fri, 26 Aug 2022 15:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 15:48:03 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 10:48:02 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: ensure no PCIe peer access for CPU XGMI iolinks
Date: Fri, 26 Aug 2022 10:47:52 -0500
Message-ID: <20220826154752.10984-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c88a8f4-90c8-43d8-8313-08da877a5c78
X-MS-TrafficTypeDiagnostic: LV2PR12MB5895:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t8tlArRHw3lxB34r++az9HEi1AkWatnztptRu98/ryvSKpv1HzjZNV/cPsmgYF4BTsBYufiOGh2PJG25IVfyOce/0wye3lToJpGJPtwStynj5uFKdIyOWkM5QDeDiZEZRY2/6LeIO3rAUHzl/SsRhOfIE9dAd5VSS7k9iD9M7ZG60s2BT00IL4yAT5EewJAtSoVC2eg4IAnGfOwOgB+O85cdKHlQhdVk4eQJK55hncuJW8LWfn+fcL1vGtWuBF55YEOyW61P5/XKQAYlzZHAGbmQYZC2tZQbp/B67h/rdG8gFOx8omz0mRFDpcTwisRDLk95nGU3aukqoj7u5d3gAEbckSRu8yG+B1io+ndSnd5ZlqgJB1Ca7Iy89mofIwM+Lfljfo6MqlYcHewGdweaEZ50rRGOdhys0mq+KKclyescrHAxn+fLL3/JUt43D8vN1keYIbvCJJkIlLArGRNzcVIx0hx3K5lTYIwvyw6NIRMnoy0HpVePzGynSx7xYzPqhmN4qlCFYHAZHMO6n4lrCnesYLxrKNG8aOP8Ee+dWp179C/R07W7pHni+Xv/hq9Dmi/VdySuacDU78/dXbg4It3lpdSMNegsiJeemWHYgzZ+HTAUASxannakCC7B7vau0Bg9XKGRXW47sC1ucKeP+HAAHcTFUaIseohxuXRi+in7++12FNcmUN6NQMk10VNQWM2FlNYTHqkIKAzrRIeB8lOJc6ouuYEPhUVyYuYOBCet8DNAstWDZzEsJ2D3R77gfrEsf1kkDriIvisa7WbsPGAPAnSNNJDgz37e4S1wE2CzfwPrMf1tP5lGoprOI7Hn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(136003)(346002)(39860400002)(36840700001)(40470700004)(46966006)(1076003)(4744005)(4326008)(5660300002)(8676002)(70586007)(336012)(16526019)(41300700001)(2616005)(478600001)(186003)(26005)(70206006)(40460700003)(6666004)(44832011)(2906002)(36860700001)(82740400003)(86362001)(7696005)(8936002)(40480700001)(82310400005)(36756003)(83380400001)(426003)(47076005)(356005)(6916009)(316002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 15:48:03.1633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c88a8f4-90c8-43d8-8313-08da877a5c78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895
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
Cc: Alex Sierra <alex.sierra@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why] Devices with CPU XGMI iolink do not support PCIe peer access.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ce7d117efdb5..1ff66718639d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5538,7 +5538,8 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
 		adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
 		!(adev->gmc.aper_base & address_mask ||
-		  aper_limit & address_mask));
+		  aper_limit & address_mask) &&
+		!adev->gmc.xgmi.connected_to_cpu);
 #else
 	return false;
 #endif
-- 
2.32.0

