Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C623C64EC7
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Mar 2023 06:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC3B10E189;
	Wed,  1 Mar 2023 06:06:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CDC110E189
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Mar 2023 06:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxyS2Wgk0oLYvmgW74FdHV2v8CeUEPsK0gC3LRyZWRSw0yt5OXzCwwOW3pD0qrRu/W337TL1/u16IRFX8cEj6bbOrrd50VRU/eDWGJ1uiDyDAk4hGrnD/ZSG/r9F8+0QRLTZWJf9OsJ2LohIEGaP7Yci8Cv4zVENqQAl+W9A6LwZe92QLzoOCmOqbXO9gw8Q84CmMX2JKbJ18LUIcxbOa7aOBgGp5o16ZLLqlb7EJie3lsZAoYgvdDCvq3DP2Ou4zoivkWNKMpp8c1E6TgcpCQKuhfhbYhAxQwHWfPSWBa2NQc7f5V140GWDUmAl9E7oTSynxD4mqm799qaQojSE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxXQk7rvmaaYaVI+cGvClCIfm2yokXYXmAP3/xZv5JQ=;
 b=j3dvt1RTq5Hm8jmRus5r550G1dA48nP7DfZz4SqIpM9z4LyDBmNp/fWKZhDEWjE9xWGuQ0EmclEZKEzvWROdozXqab39WEHYpfHO4gwYsz69juBENQPILuwkQxy+sGkUi0pgZSuF1HomBX+kJLdIqe7lSfDqVnEdr10h5AnwWQP+qppH+6aRsTXMFXW/qWOtFwCPAImBXUxAP/TdYK1KmNdroOCqe7L0KMS4DTTAX//odfn1Fq4l3OJU6K4jExNUtYnOGVlnMHB0HZvsXc3gM5Y5ny2iOa46AeXhBXvruJq/oGit+mPd6p0oYwnnxOrRfVjjOqIpJ7fQXDFLjmG9iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxXQk7rvmaaYaVI+cGvClCIfm2yokXYXmAP3/xZv5JQ=;
 b=JKXMzjuiWwV4jA4ksSdiSKXL8CulUeQgTBZmQXt8DNg7zb3tjuXLFDQZITtGiIiFBxzfJjSh0VqeoUo+JsSUun8LB2KqizRzAbRZIrtUWpt8OH71Q1jDxF+WUiZbVxSgnrzZfDdemsJPPTH3fT+ozipZ3Gv7GA2ohXaKPV6L2Eo=
Received: from MW2PR16CA0064.namprd16.prod.outlook.com (2603:10b6:907:1::41)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Wed, 1 Mar
 2023 06:06:28 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::9f) by MW2PR16CA0064.outlook.office365.com
 (2603:10b6:907:1::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Wed, 1 Mar 2023 06:06:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.17 via Frontend Transport; Wed, 1 Mar 2023 06:06:27 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 00:06:20 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Support umc node harvest config on umc v8_10
Date: Wed, 1 Mar 2023 14:05:58 +0800
Message-ID: <20230301060558.7470-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT012:EE_|CY5PR12MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 097c0921-949a-4e38-c8ee-08db1a1b1852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVK9k3XeV8aiprHuAgkMPw1Ni9l1LzWoLjhADzAMSZD14GO9TF7uTWyVVdUKQ9p9QY/+fvVrCx9xYnK00tr5smXRedg4XQWZ195l7RRmg0EqYtOpKL2vcWAOfrfUqYwJAWgTO2q2K5/vfl9sV/kXpA/Z93W1DzcwW6LLwjj7xCnyxyLQS0ZT1tbFZikaGf6Serx9R/zlMT7b1v3v63IFC1M1kR8cLtCiCWfrI0A5SaSyqK3SmmS8DXShmTpa+jpViEb0syFIOxLwu+P+9KMcE1hvQm5yBfCELJDVJI2vxytK0yV8nr2A5qqLxg10h/6wQCAlUNd5qU4YyeKo05q7UyZx0IgN75PmfPr8D3oWIEAhsV6ecDr2sBlZgO2rxYhQZMN76c8oCPk0oiEuH9PPTWhXPBQM3YUVidv2CJlBu3fDN+jtVYzq06rWxfcRpieuQ2gpv3n0duMQTL+ysXGqsuUqce9veiX00pZG6G93ldYoMU23VtFYfbSsa1Mx4SbScVtSeYci8qEzPbwqko9zEVI7OjyXHqRTXt1N/uQey1gB7yijL4qOECcSE5rkzG/H5Xk46zwA6Wun5EICfcKsoWwAXwtTGn6L4e2Oljca7OggsTh4Bf/HDba5agDvkka+dLxMb/sHh+e0mnon0gGfHhWiww/nF18pNwYU6xCBcRJTyWE0rBBB6mSPL1ts6tdjFwX5rzY5kW8J5Y8FL5Ezp0FNSYAYJsYZEva6Xva01aA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(36756003)(86362001)(40480700001)(82310400005)(40460700003)(7696005)(186003)(41300700001)(8676002)(478600001)(4326008)(70586007)(6916009)(8936002)(356005)(70206006)(5660300002)(316002)(2906002)(26005)(36860700001)(83380400001)(81166007)(82740400003)(16526019)(6666004)(1076003)(44832011)(426003)(47076005)(336012)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 06:06:27.5856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 097c0921-949a-4e38-c8ee-08db1a1b1852
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Don't need to query error count and error address on harvest umc nodes.
v2: Fix code bug, use active_mask instead of harvsest_config
    and remove unnecessary argument in LOOP macro.
v3: Leave adev->gmc.num_umc unchanged.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  1 -
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.h        |  4 ++--
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ea040adb1f150f..aebf3542481ead 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -543,6 +543,7 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 	struct harvest_table *harvest_info;
 	u16 offset;
 	int i;
+	uint32_t umc_harvest_config = 0;
 
 	bhdr = (struct binary_header *)adev->mman.discovery_bin;
 	offset = le16_to_cpu(bhdr->table_list[HARVEST_INFO].offset);
@@ -570,12 +571,17 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 			adev->harvest_ip_mask |= AMD_HARVEST_IP_DMU_MASK;
 			break;
 		case UMC_HWID:
+			umc_harvest_config |=
+				1 << (le16_to_cpu(harvest_info->list[i].number_instance));
 			(*umc_harvest_count)++;
 			break;
 		default:
 			break;
 		}
 	}
+
+	adev->umc.active_mask = ((1 << adev->umc.node_inst_num) - 1) &
+				~umc_harvest_config;
 }
 
 /* ================================================== */
@@ -1156,8 +1162,10 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 						AMDGPU_MAX_SDMA_INSTANCES);
 			}
 
-			if (le16_to_cpu(ip->hw_id) == UMC_HWID)
+			if (le16_to_cpu(ip->hw_id) == UMC_HWID) {
 				adev->gmc.num_umc++;
+				adev->umc.node_inst_num++;
+			}
 
 			for (k = 0; k < num_base_address; k++) {
 				/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index f2bf979af58835..36e19336f3b34e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -42,7 +42,7 @@
 #define LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) LOOP_UMC_INST((umc_inst)) LOOP_UMC_CH_INST((ch_inst))
 
 #define LOOP_UMC_NODE_INST(node_inst) \
-		for ((node_inst) = 0; (node_inst) < adev->umc.node_inst_num; (node_inst)++)
+		for_each_set_bit((node_inst), &(adev->umc.active_mask), adev->umc.node_inst_num)
 
 #define LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) \
 		LOOP_UMC_NODE_INST((node_inst)) LOOP_UMC_INST_AND_CH((umc_inst), (ch_inst))
@@ -69,7 +69,7 @@ struct amdgpu_umc {
 	/* number of umc instance with memory map register access */
 	uint32_t umc_inst_num;
 
-	/*number of umc node instance with memory map register access*/
+	/* Total number of umc node instance including harvest one */
 	uint32_t node_inst_num;
 
 	/* UMC regiser per channel offset */
@@ -82,6 +82,9 @@ struct amdgpu_umc {
 
 	const struct amdgpu_umc_funcs *funcs;
 	struct amdgpu_umc_ras *ras;
+
+	/* active mask for umc node instance */
+	unsigned long active_mask;
 };
 
 int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 85e0afc3d4f7f3..af7b3ba1ca0002 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -567,7 +567,6 @@ static void gmc_v11_0_set_umc_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(8, 10, 0):
 		adev->umc.channel_inst_num = UMC_V8_10_CHANNEL_INSTANCE_NUM;
 		adev->umc.umc_inst_num = UMC_V8_10_UMC_INSTANCE_NUM;
-		adev->umc.node_inst_num = adev->gmc.num_umc;
 		adev->umc.max_ras_err_cnt_per_query = UMC_V8_10_TOTAL_CHANNEL_NUM(adev);
 		adev->umc.channel_offs = UMC_V8_10_PER_CHANNEL_OFFSET;
 		adev->umc.retire_unit = UMC_V8_10_NA_COL_2BITS_POWER_OF_2_NUM;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
index 25eaf4af5fcf4b..c6dfd433fec7bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
@@ -31,9 +31,9 @@
 /* number of umc instance with memory map register access */
 #define UMC_V8_10_UMC_INSTANCE_NUM		2
 
-/* Total channel instances for all umc nodes */
+/* Total channel instances for all available umc nodes */
 #define UMC_V8_10_TOTAL_CHANNEL_NUM(adev) \
-	(UMC_V8_10_CHANNEL_INSTANCE_NUM * UMC_V8_10_UMC_INSTANCE_NUM * (adev)->umc.node_inst_num)
+	(UMC_V8_10_CHANNEL_INSTANCE_NUM * UMC_V8_10_UMC_INSTANCE_NUM * (adev)->gmc.num_umc)
 
 /* UMC regiser per channel offset */
 #define UMC_V8_10_PER_CHANNEL_OFFSET	0x400
-- 
2.17.1

