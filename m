Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7789AECAAD8
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 09:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D1B10E7D2;
	Fri, 23 Sep 2022 09:21:35 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C83010E7D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 09:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlCp/D060L0TsmyVdXLMGheFbYmvqv4i+DHWM/sdzVP/oCchzn9IoBuXREh1nNVNitB+InzRsb7WZV6QJn5g3zYxQNdFJoN10qjsyJWzcWWX5rJ+KQ073m/I3urM8wMA0u1wO0R4zUWjnIrTke8L1A5nwdM4F9ZnqmhjYBxjZqik1kF2Ry8j5xe5uPIZDszdAtfy6SWxCo7pK9E/LH5pxZreOZSvU+tynRFQ2oF4SMwRX52OV6JmQjyEF2INgiYeWJZ7emDbL1+CHbMD6Y9EoblzRjHQ+YICCGl6yBtrjRvuUJQLGo8X1AEDYtoE1TyNn/2h337SI6iA21OPsUnL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xx6jsAjNv6IQY7emsn/Ryi4SP+m2ddA92ooVNCjBjG0=;
 b=hYJH970BScJQvYNxdW1jsn/LQidHkqFsGmJpJJKHGhoxzc/Bv/ew0Hde/c6CZL0Mmoli801NJBNmnc+FIDSHNDDZBSexx9oKmwcn/fYUDSqNXM99lfWwvBZLeSE3DOvWxCYRK3HXNfGiEg3PXEzHSzTlfeQokgsT+C9s57l2tHh0U/ANWmdBbsnSfJ+DNdxjavtsw94I9WzqXEUHlJJz+OQ5cvj34RTQZ2IM67XZmWOrc4uEows+wg6Rp+D74BtnNs0zZ/tUby/UEpeYHNHU/6HZrSXYTSZdPBq3toekROfB0rpeFp7HLqFwRAyioJfO7SCnlPIrFa9QtAdrDTO1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx6jsAjNv6IQY7emsn/Ryi4SP+m2ddA92ooVNCjBjG0=;
 b=JzvNuoe3jZ6zIMXvKGnJh4G4xaspTbxOe1Bjpe8TyQ/mF+TVEahSstP5snhhgOjPWpXE8I7lTj5nn2cOxeSrblpLwQnVVvYQheGwzfVsFfwpKXclxnc7lfex0OgsfxeFSR4zf0E2vd0rplDULk896nxYrGLYkilNzQFltgFKAQ8=
Received: from MW4PR04CA0260.namprd04.prod.outlook.com (2603:10b6:303:88::25)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Fri, 23 Sep
 2022 09:21:25 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::86) by MW4PR04CA0260.outlook.office365.com
 (2603:10b6:303:88::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 09:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 09:21:25 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 23 Sep
 2022 04:21:22 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: export umc error address translation interface
Date: Fri, 23 Sep 2022 17:21:09 +0800
Message-ID: <20220923092112.14141-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT034:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce23aa5-4d4f-4909-e6d3-08da9d44fcf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IinHE+FASNIY4arR5zG7n9rz9MXen6nwUrFSwmFFUzApQ/PURjff0VF79HWdVV4HmvD2KEc1lxvNeF0wumZknWfTsvVw1DFwF60lfnbuErhR6VCUJx1O8ool5XtGjy5/4eK/X+7wlRzM7a4nkSTutm0IxpoT5/cId1+HbDPZfUtD5woRPSzbDEU0z2TQOHnBrwbuJJdmF3G9ydUMHgQSkqrm8mPCohIJCyu91y5tuFWnVbXD5Ri8vcgThFF9uH7M/TMJsoouoL/zP9CFhhwi5su8tqf/FbVIBjY8KD9/oAenS4mTVyHS5Tsg07pcsJZKiqgkz4SYz/sNWDYdSTqKErMQbtja3JDTA2iGCcNVAqutt6h2OhVshRK6HgHeerzxAXk4qWtjq1Zbvt4sh6le22ldh+zOSfeIiXPgoRXs4aa9AG6yjS9oPPFuo/EtHvRsEPoW/1uFrHhFmJhDnmMSzgVNBUqNINldCyJm0QWeFKhsndPGO0Xqwraoa52S3b0AiNUmPLwHCneJx5ErGc4HPEEIe5bNwPN5tCtgiA1+kJ9qxC5cpTx8pJteLm5u8NaNdP4h/bZ++hU6nrr5GeC6PzyyKPLet9/9FP3JdiJP5WVq4TzYIcUJEV3CgeR2Ny/AUijDEF2xPyyAvPo6x76lE26qiFqEW5+MzljRkTj3GlLw86sAryk8xtqOA07mkarz0zqnYFbB7NUFAIWyxBtNMJQxHAbjKVv1F4D4ksFU/0vmSWu3Vw7vOjoz7wnT7WqRrwvuGTljSvUwGG5iN+1/wIvHpyM13Q7kZs3VMm0wcclz8su59V0wtjRBIu5uLdOY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(40470700004)(46966006)(36840700001)(8936002)(47076005)(478600001)(40460700003)(36756003)(40480700001)(26005)(426003)(86362001)(6636002)(110136005)(316002)(82310400005)(36860700001)(186003)(8676002)(41300700001)(70206006)(6666004)(4326008)(356005)(70586007)(2616005)(2906002)(7696005)(81166007)(82740400003)(5660300002)(83380400001)(336012)(1076003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 09:21:25.0673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce23aa5-4d4f-4909-e6d3-08da9d44fcf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794
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

Make it globally so we can convert specific mca address.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   | 11 +++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 3629d8f292ef..31fbefaaf676 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -22,6 +22,8 @@
 #define __AMDGPU_UMC_H__
 #include "amdgpu_ras.h"
 
+#define UMC_INVALID_ADDR 0x1ULL
+
 /*
  * (addr / 256) * 4096, the higher 26 bits in ErrorAddr
  * is the index of 4KB block
@@ -51,6 +53,10 @@ struct amdgpu_umc_ras {
 	struct amdgpu_ras_block_object ras_block;
 	void (*err_cnt_init)(struct amdgpu_device *adev);
 	bool (*query_ras_poison_mode)(struct amdgpu_device *adev);
+	void (*query_error_address_per_channel)(struct amdgpu_device *adev,
+						 struct ras_err_data *err_data,
+						 uint32_t umc_reg_offset, uint32_t ch_inst,
+						 uint32_t umc_inst, uint64_t mca_addr);
 	void (*ecc_info_query_ras_error_count)(struct amdgpu_device *adev,
 				      void *ras_error_status);
 	void (*ecc_info_query_ras_error_address)(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index bf7524f16b66..0f1b215653f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -452,9 +452,8 @@ static void umc_v6_7_query_ras_error_count(struct amdgpu_device *adev,
 
 static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
 					 struct ras_err_data *err_data,
-					 uint32_t umc_reg_offset,
-					 uint32_t ch_inst,
-					 uint32_t umc_inst)
+					 uint32_t umc_reg_offset, uint32_t ch_inst,
+					 uint32_t umc_inst, uint64_t mca_addr)
 {
 	uint32_t mc_umc_status_addr;
 	uint32_t channel_index;
@@ -540,9 +539,8 @@ static void umc_v6_7_query_ras_error_address(struct amdgpu_device *adev,
 							 ch_inst);
 		umc_v6_7_query_error_address(adev,
 					     err_data,
-					     umc_reg_offset,
-					     ch_inst,
-					     umc_inst);
+					     umc_reg_offset, ch_inst,
+					     umc_inst, UMC_INVALID_ADDR);
 	}
 }
 
@@ -583,4 +581,5 @@ struct amdgpu_umc_ras umc_v6_7_ras = {
 	.query_ras_poison_mode = umc_v6_7_query_ras_poison_mode,
 	.ecc_info_query_ras_error_count = umc_v6_7_ecc_info_query_ras_error_count,
 	.ecc_info_query_ras_error_address = umc_v6_7_ecc_info_query_ras_error_address,
+	.query_error_address_per_channel = umc_v6_7_query_error_address,
 };
-- 
2.35.1

