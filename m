Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5FBC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Nov 2022 07:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 299EF89CCE;
	Tue, 29 Nov 2022 07:56:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D62D89CCE
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Nov 2022 07:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nctf7zSMu33l7YoGw/51QAaQx7hNLq/+moFfpNAI3/CblQdQH1ZybDG9Yl4zvdjHFMG8ArMvkBs0O50I8ZYae1/UGayTD9B3pKPfSkz9yGZUdrIpBmBnSu9hgeM5RKqwJdw3yH6SV5mjt8W8IFrEkSXrmGfrbMX/wHj0LIwd23f987xqcPFJxTlPAz79zoxXgbZwxz/FaYQ19OQ1ES5tsgbOadNDdwMl5fprI3pDdoswn1x4cc7LWrnScDQbNLLcugsnVytRZMev43WAWoKaSZLH30BwgUFfWbJru0u9qXk8pkJrx83OULQQ+gBpeVgDCg7nUG0O17M1pC2A/b7pfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnwY6zUBM6hJRVcpawmvLRjNWl9/s80g4ajl9fKbMS0=;
 b=UwR+GYbNCHy/YenoylIP3mt0EpTZsQqvhg4rDjvLmZYNL+8n7NsMcE4vsWtyNMYLgu/sYAYAlgB7hJZ1msU3GNbM52blyqbTxFJHYwOW8cNvI2XjYkZdDrCNmiOMzsr7lUVu8y6qdhMUqxmcDy6nKzC65BNtZ6LkHRekh8gwYJV2Nz/zYJ81t//NnyL2IT5R1/O0/VwvIugXNMsvJ1PIPfGPIa4AH6hlA5Zwo1RzHei6+2TiSxKvUtDGi7OFnxTHwAPqT4m0RPL7yQhvave5I0cNPvJ3smrylV4S31nxDZeZUcy4qTrn+cv8ogV8+xPQW1s9CfddF6uuQY2YLw41cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnwY6zUBM6hJRVcpawmvLRjNWl9/s80g4ajl9fKbMS0=;
 b=tkusdD9C/wP5CDF0+BNJ+Xnu2n0C9h4myVoXzNvQMtY83S+x/JMCE4aMRk1uqkn0wWLGuJcJgjUN2jPokS2TeiN7XU4lA/+zI9TS6OCTgovWwXkzhJZbY/s82dT+48qoYyWlYeTu5qjxkRu+FhGk2d0cFdCa1DxtCchoY+xvWZk=
Received: from MW4P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::17)
 by PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 07:56:05 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::ae) by MW4P222CA0012.outlook.office365.com
 (2603:10b6:303:114::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Tue, 29 Nov 2022 07:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 29 Nov 2022 07:56:04 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 29 Nov
 2022 01:56:03 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: enable VCN RAS poison for VCN v4.0
Date: Tue, 29 Nov 2022 15:55:54 +0800
Message-ID: <20221129075554.30067-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|PH7PR12MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: ec37e98e-3762-4c67-c8ca-08dad1df2aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Byz5O+E52IHrqVXs2WTPY8s/ht4a26pAK9DdoAGDiprOuvhI9WbzCNa8c4I8QdmbZCQWHgMl/gzWrsL3zzbYgL6Skj7jSigef67oeY1o1JlzD3jvk6MMV5UWOrsMjmCu4PBqmggtH+p4quGulBy4V96Sv6NzWPa4ltYkXj6Fz5SUUbISHrdBaRqHrOQshbiNy1pSwGpFY4hmegvg5YCn+je2YEh4sG+8mse1XjRJcVqezG2Atd5Ev0HcK+lk/5Bwrt3lLswRuxyRUeIhuQDpIKmDkL62ajX9MIcU+SSQLMUm2HZo7jMdua5VlPZUY1kJSnaHvYbjoehiwUBNm9TbrVg6bigrla9M1mYqpViq/lt8HhjjQnSNTfFXnBuo25OTuhXu8GXeppRtMOQ5y+l6i+6i75Tt30nn2qaGGdCQ1V8GLuadXPW9Jmt25obzK5IEptrl+kpMpnUBgy2wwVsplYBY1Rq+nDxo2SDIQnqurD5+U/tBRJ1oXaH27ts+NeMxgIgAVDK22UBrLZakJBgJ9qxO6952DcfiBGWF4tTwVa4Z/1NN+Q70doPM1lYd/37S2Al2tNpqSRwj09rSdfzE4Z4Lg0BoenExaXlSjr2sAfDNHKoGcdk7HW/mqx08erDtKaqea6toPRAQ28EzfEVw1pQvKxt7uT9YxyWtvDv6MXWd/lcjK2+dBRi9dj3Ig7V2EilO9u2gE67ftmmKxCHt1YoSYWVHIuy8QCOITD7V2js=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(82310400005)(36860700001)(478600001)(47076005)(70206006)(81166007)(7696005)(426003)(82740400003)(1076003)(86362001)(6666004)(8676002)(4326008)(356005)(70586007)(40480700001)(36756003)(26005)(316002)(16526019)(186003)(40460700003)(5660300002)(110136005)(2616005)(41300700001)(6636002)(8936002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 07:56:04.8572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec37e98e-3762-4c67-c8ca-08dad1df2aad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7210
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Configure related registers.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 66b3f42764df..0bc65b2f0ce8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -862,6 +862,25 @@ static void vcn_v4_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
 	return;
 }
 
+static void vcn_v4_0_enable_ras(struct amdgpu_device *adev, int inst_idx,
+				bool indirect)
+{
+	uint32_t tmp;
+
+	tmp = VCN_RAS_CNTL__VCPU_VCODEC_REARM_MASK |
+	      VCN_RAS_CNTL__VCPU_VCODEC_IH_EN_MASK |
+	      VCN_RAS_CNTL__VCPU_VCODEC_PMI_EN_MASK |
+	      VCN_RAS_CNTL__VCPU_VCODEC_STALL_EN_MASK;
+	WREG32_SOC15_DPG_MODE(inst_idx,
+			      SOC15_DPG_MODE_OFFSET(VCN, 0, regVCN_RAS_CNTL),
+			      tmp, 0, indirect);
+
+	tmp = UVD_SYS_INT_EN__RASCNTL_VCPU_VCODEC_EN_MASK;
+	WREG32_SOC15_DPG_MODE(inst_idx,
+			      SOC15_DPG_MODE_OFFSET(VCN, 0, regUVD_SYS_INT_EN),
+			      tmp, 0, indirect);
+}
+
 /**
  * vcn_v4_0_start_dpg_mode - VCN start with dpg mode
  *
@@ -950,6 +969,8 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, regUVD_LMI_CTRL2), tmp, 0, indirect);
 
+	vcn_v4_0_enable_ras(adev, inst_idx, indirect);
+
 	/* enable master interrupt */
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, regUVD_MASTINT_EN),
-- 
2.35.1

