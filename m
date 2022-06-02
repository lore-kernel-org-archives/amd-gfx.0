Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC08DCCA478
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 16:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 663B3113119;
	Thu,  2 Jun 2022 16:46:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9774A113119
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 16:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXPJ3h6j4RrCj9oU5UITPXOd194gNS5ii2DhZlUYe+HAbISRMurHUgS14sJtWpDE5hWqe2OTVnkPsYAKRNsyhnYVziIM95kpCGLkn7EsxtXYXFBojvxPZ5Tsb7xBYy+g9kkebf5zogefUDimnzB+da1wQgxt/XAMwtr9tZyRM8o3B9SIYYCsu5AgE29cgTWnFqnz1XAaoC1DaQhttLyqLmpbACcbh987X6W5/FwcS1z96rBakpn8Pm2xyghpseXC5IPqP37HP0kTtKH8rqul7Lxe3g+kL07+U73JK1y1cZgZQYywKwUSfZnINv5S667cqxwnokSC0fl85uPC0ABVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xafqe41GZZ/RxRi3YA1jXhLtvl8Mzcu4JKLxM8i6uW8=;
 b=myKIpJoxl66hD6sMm599/k2mPWvF4KM5q+atd53q/s5RTBx1AdlHhQVdEPPoFmsKywL5Ovf2UUc2pXDVjw0wbCU38yGNis0io5bqQ1FvBGDJWp9j7p3gSWqwTgtF9oMW0Yf8FL03GRfl5zmH6OhQ2o/g+RAcpwRGmoBe9ab5cu8HJYqNaIY3PdoCmcCRBP68/Ka/H3qgm3mNKIfRy11BIesoVCWwFe1gn8NkVuZcP5ZxRnP/EB9lsCmBV+C86zTC/UyhyOBS5FGMrziYwNuwVZmie8AAAhKMJYpN3CTUG0uVTg6VPj73K/PdiqbeWnSYQA7T09FCvzn1QzoNLdXiJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xafqe41GZZ/RxRi3YA1jXhLtvl8Mzcu4JKLxM8i6uW8=;
 b=b4xc6/8ka/n+hCNEt48VDEYfJ5LoAv89rLqqDqlTuRKsclYjr+l4ArQld3loND5+/nQ7spxKBJ+2lja+Es1RanjM+BPmDaW4in/FB/lrR6VU+R5CcpV7lh2f85V/yxiPnKYpREm3dJpRWvsQ4u6Q5w5h8Kede5YcuwsBDI3Ixfo=
Received: from BN7PR06CA0053.namprd06.prod.outlook.com (2603:10b6:408:34::30)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 16:46:05 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::87) by BN7PR06CA0053.outlook.office365.com
 (2603:10b6:408:34::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Thu, 2 Jun 2022 16:46:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 16:46:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 11:46:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: add comments about VCN instance handling
Date: Thu, 2 Jun 2022 12:45:47 -0400
Message-ID: <20220602164547.1171254-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3303db9-6e75-4061-0816-08da44b762bb
X-MS-TrafficTypeDiagnostic: BL1PR12MB5160:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5160691F133AB3D887EC42A8F7DE9@BL1PR12MB5160.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dwmzc11+xMcy7guenk2KA4KZnb9bDgaG76jgk3o/W1lJtIA/PddsvAy6kMUVjxcf6ZR0K51jVznqgY1avrmV0pBg/cofPrBTGOT6v36j42LCCHpMMojYye+lONRfIioCcP4lECmlgiHfq15oaiM1vlw44hm2bW6HVAW0EcGCvU5WasRloneWE2TZd0wCKwN80Ho3GePdTLIIEV7TnB96CcEHZ67v1I4lK2AvFBOOmQqAzB+xy6rNbVA0sPbqKrHL8w7SB6kQSB/dqkBxZbmk20bTDQXf3VFNtqH4QDvj7w9MlSgC+hu57Ki+X8FAw6BKgiakMP10anYecHtgBG8epoPdXbqSa9PvqJWicgTXTqGEKUp2CV/HOcfbg9Abb1Rjbg69Y6UlcOzyfrNOyqxw4LawHvODMba+LnI332xiok1MrZedK75cNsgl9or2nQnpuliF5mw9qnqoTXsedTRW33kwBNkmVsRwnBrA2mrPou8ATV4jd3igLp5gPFrNtRDjlcuoybtgZnxJZXJ0Lzy7sb5ui3RFR570AX3JV+dikJOC+BollnVM1F7GVedRc+irwb2GdOekhE30FLiz+B1AE9WV4Vs1Km71ZgMMl28OuMsfJP55xqrp/XMpjRY4EkteltoNWHHrBRBXpFRKw9cmYIbbmSkswe0IBmszX8irDo9MGYUNRwBBFT8zBR9vHMSq9RJyOLCtd7DgOAI4ZLxckw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(81166007)(8936002)(6666004)(36860700001)(47076005)(508600001)(356005)(2616005)(40460700003)(4326008)(8676002)(70206006)(70586007)(82310400005)(1076003)(86362001)(186003)(316002)(16526019)(966005)(5660300002)(26005)(7696005)(54906003)(426003)(6916009)(336012)(83380400001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 16:46:05.1537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3303db9-6e75-4061-0816-08da44b762bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add comments to clarify code that is safe, but triggers and
smatch warning.

Link: https://lists.freedesktop.org/archives/amd-gfx/2022-June/079905.html
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 91f21b725a43..b0811287f017 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1435,6 +1435,11 @@ static int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
+	/* num_vcn_inst is currently limited to AMDGPU_MAX_VCN_INSTANCES
+	 * which is smaller than VCN_INFO_TABLE_MAX_NUM_INSTANCES
+	 * but that may change in the future with new GPUs so keep this
+	 * check for defensive purposes.
+	 */
 	if (adev->vcn.num_vcn_inst > VCN_INFO_TABLE_MAX_NUM_INSTANCES) {
 		dev_err(adev->dev, "invalid vcn instances\n");
 		return -EINVAL;
@@ -1450,6 +1455,9 @@ static int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
 
 	switch (le16_to_cpu(vcn_info->v1.header.version_major)) {
 	case 1:
+		/* num_vcn_inst is currently limited to AMDGPU_MAX_VCN_INSTANCES
+		 * so this won't overflow.
+		 */
 		for (v = 0; v < adev->vcn.num_vcn_inst; v++) {
 			adev->vcn.vcn_codec_disable_mask[v] =
 				le32_to_cpu(vcn_info->v1.instance_info[v].fuse_data.all_bits);
-- 
2.35.3

