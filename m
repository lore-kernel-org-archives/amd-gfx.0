Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D45FC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 17:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C36914BD3F;
	Thu, 21 Jul 2022 17:27:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA95F18AB50
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 17:27:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcUTaAZ9m3xM8rOFNFF/BIgoDcDJFClV3KLWc0QWroOxqCqyY0VyYsrxLhprVzO7zlJPEmXlk4+7qn6VUKMFCE8dKRd81zjdLm8kKJa0JWOycSq8OWUevcuf05dKgMDILQzxdBNFFu8JJfpq3+QArVTclK+NY/m3BcKXe8jc8KA73qU+LQ/RBef9oyLWkEKU7l54zcknQwzywMeM/IZByV3c44aDWETma+lwNfMzlpXRRUFe+Pzz+IrRUFtaIHqR7a+tMEBwwRljEoiUwE/RNwWjbigaNHVgfDICxMQJuvx4R3JrWUuHfjzdbiuqCR0xiPTT6qCj/7pWIfsLjHHRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFYUZ1IJK++sqVLdd4rPBz6redlcvreFTSAjgTSSSFM=;
 b=appLIEvM9kzgnUFkTkXPt3dF7CkxdU5X+RW8ZsaxAabN9OlEQbdIFpIzUtDHTnTRtun2FOITl9hFRUcyPPQcmaN71yqmzTkmVo1e8HXMWz/bI9bo2m3azT0loT5oMSqB9rV24x/79mD731UDY6oYyohoc0tF6jYRwIWJaGu9LloC4f6dVxFtgODzztcWgd4mccNvizN/T+i99RbhLU5jHqXTKXXi21BftQpMTi1hCbxC9nvYcEKl9WZfNHx7x/DzsrtI4oM0d3tuCG8GCBsqHnu3I5vkk03IkbE3UdFS9AEaQubfuTD70OCEX+T3zeIHFkCmG0/f8kBU9iWvE3rO1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFYUZ1IJK++sqVLdd4rPBz6redlcvreFTSAjgTSSSFM=;
 b=Gr9Ts2n2fdSe1RB5ohyRyA2xrLnzAfNGy0bYHkxY3BhgyTAj/gZ8sUTxfI37oUCTnMD+jXfM76joY2GhmamDCZatCPOy/QYiDrSG+gldPbwtFwuKqrmhse0FfJPejXgeCIGhytiyaSAtPfUkk17V9GlxSNwFEr/H79XXeaY8EqY=
Received: from BN9PR03CA0912.namprd03.prod.outlook.com (2603:10b6:408:107::17)
 by CH0PR12MB5234.namprd12.prod.outlook.com (2603:10b6:610:d1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 17:27:49 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::40) by BN9PR03CA0912.outlook.office365.com
 (2603:10b6:408:107::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22 via Frontend
 Transport; Thu, 21 Jul 2022 17:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 17:27:49 +0000
Received: from sonny-TP67XE.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 12:27:47 -0500
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu: add VCN_4_0_2 firmware support i
Date: Thu, 21 Jul 2022 13:27:10 -0400
Message-ID: <20220721172712.309984-3-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721172712.309984-1-sonny.jiang@amd.com>
References: <20220721172712.309984-1-sonny.jiang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d9d404b-f1b4-42cb-a5e9-08da6b3e5591
X-MS-TrafficTypeDiagnostic: CH0PR12MB5234:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pNB1/LSpD2ummGZUBLkms6QUUa5LOfxsZCvC90ypgadHQ3gxmaOjkZh15xfJam25H8/xRRca3H64RDOn37hRPhOs/ient0liLbwmWG1ycfwJkdOwJCwcpRQfSpEuXh52PNTYgIIYWWcGDEhNTyBUuaHs+WawwTyZqI80Z8l+8k+gowNJqV5uJx89rZTIalRjzzqVeTXLhBvEZog/eQ89N2rbvPWLo49ezC8onAqk6oq8HOGiAdIf5TC+jbQeKEUdkWiTH/07C9DkOfBRVteNBtDwbZup/hqRw4A5OOObAN68cUyAid4tt30NXRpmuUBJlTKUmiByHhl3UAb/L19D86RQGNtcbg7dafN4lqfpMCIhLvodvPwoXraoQKWgnZIlePt7R98Cr7ycMyy43NE45H44Ixs2mfKcm9sVFmq+JgbzrJkgd8w+ImeyiKnyiBmWbrDVLZBkJNQCZBGOwkceHjoPOHMDhnG4jqJhkpM8Cp4IsrmqBrbO9WrCbDpsw1fgyYzzOU3IDXgUrYSfnu/iUVYAxgFDe5M4UJ0PczbbNojHn/MKEiKACJxF5oj3NEG7BvvgvLIQu2JMhLPBs8BSrC+1+jU286QHotOU17hrC99lbyf4icTtrzpmCZW4lHuRcz2sqltinlfCeIiLeDqIWC+bMPpEH9Hd0DlXkAwQ7vpFpFszmG+q2qC91kY3qHuYKMEiIT5j1LgGjXQ1hXhdq2kCaSUpNM6/D+W2K3fTF48YRydwKyNDFRw1BjlUhr8gE8Cv+0yufTRTyjj7msN83GeABZoVGo4MulE2SXuF9ODhN3xum7msfjmYHxoi6d9qSiNU5/rMVnLZBvduBmzSD6DnR2uMEw6nRvcEnlYFkcU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966006)(40470700004)(36840700001)(40480700001)(6916009)(40460700003)(36756003)(70586007)(54906003)(70206006)(4326008)(8676002)(5660300002)(44832011)(86362001)(8936002)(478600001)(316002)(36860700001)(82310400005)(41300700001)(81166007)(6666004)(2906002)(16526019)(7696005)(186003)(336012)(26005)(356005)(426003)(82740400003)(1076003)(47076005)(2616005)(129723003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 17:27:49.3318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9d404b-f1b4-42cb-a5e9-08da6b3e5591
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5234
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add VCN_4_0_2 firmware support

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 1bfdfb9207ac..f36e4f08db6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -54,6 +54,7 @@
 #define FIRMWARE_YELLOW_CARP	"amdgpu/yellow_carp_vcn.bin"
 #define FIRMWARE_VCN_3_1_2	"amdgpu/vcn_3_1_2.bin"
 #define FIRMWARE_VCN4_0_0	"amdgpu/vcn_4_0_0.bin"
+#define FIRMWARE_VCN4_0_2	"amdgpu/vcn_4_0_2.bin"
 #define FIRMWARE_VCN4_0_4      "amdgpu/vcn_4_0_4.bin"
 
 MODULE_FIRMWARE(FIRMWARE_RAVEN);
@@ -74,6 +75,7 @@ MODULE_FIRMWARE(FIRMWARE_BEIGE_GOBY);
 MODULE_FIRMWARE(FIRMWARE_YELLOW_CARP);
 MODULE_FIRMWARE(FIRMWARE_VCN_3_1_2);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_0);
+MODULE_FIRMWARE(FIRMWARE_VCN4_0_2);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_4);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
@@ -185,6 +187,12 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
+	case IP_VERSION(4, 0, 2):
+		fw_name = FIRMWARE_VCN4_0_2;
+		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
+			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
+			adev->vcn.indirect_sram = false;
+		break;
 	case IP_VERSION(4, 0, 4):
 		fw_name = FIRMWARE_VCN4_0_4;
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
-- 
2.36.1

