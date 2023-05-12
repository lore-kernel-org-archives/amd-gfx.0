Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B059C77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 07:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 047CC10E4BF;
	Fri, 12 May 2023 07:49:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C144A10E4BF
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 07:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLm/CBqkcYP6F9THAcDgbMm8tb1wlQWmW4Rxpp9AZIBSkrxlMqUBECfrT2jOUhxOoI9mySLSHUG0QzmlmRXHPt8RCGsp2g5/SLaNW9V61boPJ7F0afN7d4yq/BXTuQIZ9/7goQieB1lH0HXqWjLfbBW2iT4xZCDOqXh74nc0KodN3UWMxRrAuowExQ/EB4DN8EXCWdQ+WHWHU88MVinrXM41OWAxq+ttjQ80OsiGXcApHCzu+Gw75bcNRJi/pE0uidYc0ymP7NEd95abwlsMjxUHdJ6hbpflEmQxBmNcWQk+u1QwsZKE1C8nAr3Ck7DaS/u1h1I65YYVC3c/X7zX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7Qg5jtIJwsnSKkd9kKv5Hy5jkoqYhNLMsFyPTgKs08=;
 b=mT3tL2pw2RtGUGHW18M9agCF3h7F5YKVjmOjW2b3QpLV+VICzMaPDimKxWAKGm5g87iHl/hND9ifC9KyuLVILrvSz8MDOef9U1sHI31uSDiu3XcIoaIfSDEz9ZRi5Se2fKspaNoAGZmmhxbVKQM3KHYL5dhOKqPbg6q4iwf2TVpEBt9G+aidm+kUZ6OTfsU0cDerYWeBqmVgj1MPLfGL1mWdgAe+cCSKawx4DaabIMmMiquql2gqs1OYcY6vuXR3bzm1H2FIJSewAUd81AjVrcTEme0xkwgKjCKuJ7SMrmahhbsYMaxSlL7ks5bZwsAPvp+WNH1p1nSyXH3Gqtllag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7Qg5jtIJwsnSKkd9kKv5Hy5jkoqYhNLMsFyPTgKs08=;
 b=pEzbI5raODmtKbTVUZONg8emBuuBj8PBiCJYTCxEUI4xV4ojMc1hLMV0ksVKbYfSXUpVXh+i+OTIbU7azBMy9Zz6Bs3ZdjC2zTUleYx0wlSvP0VwRPFFgBzUdq/3nYQsMxZwUk+2dV/ttt25Q+hiV06WZBa6D43ApVwFeEzJCLM=
Received: from DS7PR05CA0069.namprd05.prod.outlook.com (2603:10b6:8:57::21) by
 DS0PR12MB7679.namprd12.prod.outlook.com (2603:10b6:8:134::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20; Fri, 12 May 2023 07:49:36 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::e) by DS7PR05CA0069.outlook.office365.com
 (2603:10b6:8:57::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.10 via Frontend
 Transport; Fri, 12 May 2023 07:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.23 via Frontend Transport; Fri, 12 May 2023 07:49:36 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 12 May
 2023 02:49:33 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amd/amdgpu: perform soft reset for sdma fed error
Date: Fri, 12 May 2023 15:47:50 +0800
Message-ID: <20230512074750.1890604-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT113:EE_|DS0PR12MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: e43fa102-8336-4c89-16bd-08db52bd6e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QUH0mfsBAFHkBFZatptiIyBbgV+0hEBf+iHc+CD9i3L13/6B/yAlbFZxQUgeHiA+gXWdyridiVGDjPVV0sTpra+8yFAKYVsGKQlNIGWrsaGWN4/lrqdIowm13+L068fQ+/wLUmRnEW711g3s++lwUfhqTtadZ2XzMhWGXK4jHBCVPDMv0H9/B/7Jgqz+6JcxCMYJQ2VWuup6DfhBg2+8z449H0ObeuQVPCWCOn0GLjIqOi/5nfL1znUUxE6UdLVhE4ED1/OWBQOrvYGOWeEd8SWn7Zx4DmRwm1p/On0QyF3daXQC3Wz/O6hb8v3yRl3seeXFCJlIlNMaSkaw9aI3GOXMvZboDQcMY2x33LHBUKpfqBkC58l7Vvc1T0iPfg0nd3r5ZqmzTBqliXCqWHeLhtOghbvZ+xrSr/Raw7yv19u1B7BJFNVb+Xkcw7Cb7jG4ZuYgVNkUiJID9Mz1NW1f1DjqUmfDvyJwlun1ycbRUBQxz6uHfbIDUcpgyGpC5FiMHX9QVRUPwT60K7FErsXdl/NF5ml3i2XpnSfqPGQ56dSJ5tFosy7s7p+eLbhyr1tUEKTKLuY3Cn7fOr3fNre1MH5zyza2yPqm+ECcY/mf6ItMhwzTk28lHtIA5Z3C3fLiMHea70AZYIYB9DVZ9yI6kUutDP9S+cXENFt1TyWyLBR9AThd+qdYpJCJnPOVqfDYuMnDzCYebpRtV2R1dxo9a7KaDtFoMmzgc3cvNo+Zc2fhpeyu7cHUp1R0lFL3zjJJdbBLxHQ8d9csECMtsVkE1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(2906002)(356005)(86362001)(82740400003)(26005)(186003)(36756003)(478600001)(40460700003)(40480700001)(16526019)(5660300002)(36860700001)(6666004)(7696005)(1076003)(81166007)(82310400005)(4326008)(426003)(6916009)(2616005)(47076005)(336012)(316002)(41300700001)(8676002)(8936002)(70206006)(54906003)(83380400001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 07:49:36.0164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e43fa102-8336-4c89-16bd-08db52bd6e9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7679
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com,
 yipechai@amd.com, Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When testing sdma ib ring fails to detect sdma
hang for sdma fed error, force to perform soft
reset.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 3d9a80511a45..1d463e1fd3ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -53,6 +53,12 @@ MODULE_FIRMWARE("amdgpu/sdma_6_0_3.bin");
 #define SDMA0_HYP_DEC_REG_START 0x5880
 #define SDMA0_HYP_DEC_REG_END 0x589a
 #define SDMA1_HYP_DEC_REG_OFFSET 0x20
+#define regRLC_RLCS_FED_STATUS_0                     0x4eff
+#define regRLC_RLCS_FED_STATUS_0_BASE_IDX            1
+#define RLC_RLCS_FED_STATUS_0__SDMA0_FED_ERR_MASK    0x00000040L
+#define RLC_RLCS_FED_STATUS_0__SDMA1_FED_ERR_MASK    0x00000080L
+#define RLC_RLCS_FED_STATUS_0__SDMA0_FED_ERR__SHIFT  0x6
+#define RLC_RLCS_FED_STATUS_0__SDMA1_FED_ERR__SHIFT  0x7
 
 static void sdma_v6_0_set_ring_funcs(struct amdgpu_device *adev);
 static void sdma_v6_0_set_buffer_funcs(struct amdgpu_device *adev);
@@ -760,6 +766,7 @@ static bool sdma_v6_0_check_soft_reset(void *handle)
 	struct amdgpu_ring *ring;
 	int i, r;
 	long tmo = msecs_to_jiffies(1000);
+	uint32_t rlc_status0 = 0;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
@@ -768,6 +775,15 @@ static bool sdma_v6_0_check_soft_reset(void *handle)
 			return true;
 	}
 
+	/* Soft reset should be performed for sdma fed error to
+	 * recover sdma engine, so when testing sdma ib ring fails
+	 * to detect sdma hang, force to perform soft reset.
+	 */
+	rlc_status0 = RREG32_SOC15(GC, 0, regRLC_RLCS_FED_STATUS_0);
+	if (REG_GET_FIELD(rlc_status0, RLC_RLCS_FED_STATUS_0, SDMA0_FED_ERR) ||
+	    REG_GET_FIELD(rlc_status0, RLC_RLCS_FED_STATUS_0, SDMA1_FED_ERR))
+		return true;
+
 	return false;
 }
 
-- 
2.34.1

