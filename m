Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A4CC77B60
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7FD410EC45;
	Wed, 29 Mar 2023 20:14:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA5B710EC3F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAXJl0PnsvahFj/F9+5l1qLEAUrLE+9UlsF47IVyVBUzEAb2RyiRnnubaPaMXCWriLxjMchi+aHeretFaPy+elCiKu6iAHPTpsfkF/cQI26xC22M1zoIy3uUXO+HBkrFdGMY2Ch/MP5qujWtu1ODQCR/uH9Pfak+U7EBAM41nvrsU1ET4WWqemZcgzRlg9a4HSTFIJWRO7WCAqXeyLrbYwdU3WPvVGbDsFn10U38/WVYjZZU1eMjsk0WKddfsGKyk53goWYTYkYkc7EzvlDz0s2Ywldin/0Z2mF/ibXuWpPjeAwJNo1n6NOOcx4L0taQM4U3NKMlNF1ZclE/AqCaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vp/vlVlQsQKk8za8HD2j0T/2Cak/zwBlh94K2atiwa4=;
 b=cDR+h6BW9yw6eOPJ5mTdZ76XxBFlvjFsEghSi5PoSb1PpdnoLR7UhCKd8UCLNGqsaNwqektkrvmVKcDzFMFlxsNDA3GcwHW/vCVoNrG0zgRXT+MMIlvhBdIIGvf+HYDACM1HM0eR++d9mBrb73R/TmitGUD/36eBzYlyrVs0Qo1JDF7qbnI4asrRlEAL6duL0BBS/gfMddpWMMxaDskUZ2a/j2aeaBHAVwDU/Il2S3fy6Wgr6PCg2TF8g1LblLz24RdBX6inkdxIPdHFbz/+xa1I5FT7iTYmA1lQY51TrRUwwd3L/0/hQT8YM96UU4fXu9L6IfN2VPvsbkP2vHZtCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vp/vlVlQsQKk8za8HD2j0T/2Cak/zwBlh94K2atiwa4=;
 b=NhhTzn/FOZTOTwTMT/mv3jQynhFhtHAnQQbmg+48530C/0v8hBi/aOYcgZTOF7+ER183Oflyn3mhhmP+beMFFJYsvd9TKJUrFhiGVTX68knVnOt/Ruo+6csNQtzmS83VDS/W6L8RT34TV35gMxdE4qGQ1toKpkg/nmr1BDhep+g=
Received: from MW2PR2101CA0014.namprd21.prod.outlook.com (2603:10b6:302:1::27)
 by MW3PR12MB4587.namprd12.prod.outlook.com (2603:10b6:303:5d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:14:48 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::7d) by MW2PR2101CA0014.outlook.office365.com
 (2603:10b6:302:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Wed, 29 Mar 2023 20:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 20:14:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:14:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/14] drm/amdgpu: adjust s2a entry register for sdma doorbell
 trans decoding
Date: Wed, 29 Mar 2023 16:14:19 -0400
Message-ID: <20230329201426.1982669-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329201426.1982669-1-alexander.deucher@amd.com>
References: <20230329201426.1982669-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|MW3PR12MB4587:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a55f58-bb6d-4d0a-98c9-08db30923f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TaUG6BmG3WZfrFKWTEheHdBo3ZKsauEox8WRLVc9+wgebJ+uGMBc8OeY/ZyoM8X/WJr3ovhKRqVt4N59muJlgcLM8n0Y4pR3/LO1QVObOw40IrwR+LFmkt/RxOzzkz1JxzNp1zSVF+4MnRSF2uwLYygCUv6ywsXqh/q66r3RtTB0alxd/FMASdwiOZoSZPl4ShYnJPl7Qp7VAhH8ki6WAch1YS3qBvQBGpCXoLBSI0GrrLYOqpY+X1qsEngiaTLrn/MVVAIFKJiBsA8ZHA/YoiPKPdC07FzjFC3622x1ZXNi/nbAlqyEb/RDqM8PiyBwRPzLPPoCtMUV6NdQsuNQ2QG9kw7rgoyoEZNAdnbmfF9b1J3cxK/mHCzIoPo6oPDl2DHRPL7OrtAvWs2rtsdB35P7u0vpx44iz5GOwPVEYYbc5gCLkUWIMlt79Jm7WBHRfy6ejeuixPvqTQNGE4kVEr52BWhjzFxNe5m5VeNPxdv0jWqx6i+blzwXmgttTJV9/f7yHeeWBHBd+53kStVNLTSkEpx1Rj8HTIyMixidMh883ArkLYPFe2hP05WpitoVCLXWI/4wa//yGBAiKrH+HnB7xq9bMPSuMpoSmLifpYJX/s+eLBDSrpFg/2tzswnF6wuOLzpr36z6E9ApcHgEPxXaj/030N2lYlfIFVkizutDXgnNvXg+QPwZRER6oKyH9qJaU/ejQP83tiWi+cTdDUO86aeapWuCVQM/LTzg6fHe8jGbYdz88gIhHAWO4nAnOW+sgrTxYh+8t8zzMBDBNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(478600001)(83380400001)(2906002)(36860700001)(1076003)(7696005)(336012)(426003)(2616005)(356005)(5660300002)(54906003)(8936002)(81166007)(316002)(40460700003)(82740400003)(6666004)(86362001)(186003)(82310400005)(16526019)(26005)(40480700001)(70586007)(47076005)(41300700001)(70206006)(4326008)(6916009)(8676002)(36756003)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:14:48.5879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a55f58-bb6d-4d0a-98c9-08db30923f3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4587
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Use s2a entry 5/6 registers to decode sdma doorbell trans on different AIDs,
which aligns the entry table in SHUB spec, and leave entry 4 dedicated for VCN
doorbell to avoid conflict.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 32 +++++++-------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index 08819e4edd90..172f7f6807fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -151,18 +151,10 @@ static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 					S2A_DOORBELL_ENTRY_1_CTRL,
 					S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
 					0x8);
-		if (aid_id != 0)
-			WREG32_PCIE_EXT((SOC15_REG_OFFSET(NBIO, 0,
-				regS2A_DOORBELL_ENTRY_3_CTRL)
-				+ S2A_DOORBELL_REG_LSD_OFFSET) * 4
-				+ AMDGPU_SMN_TARGET_AID(aid_id)
-				+ AMDGPU_SMN_CROSS_AID * !!aid_id,
-				doorbell_ctrl);
-		else
-			WREG32(SOC15_REG_OFFSET(NBIO, 0,
-				regS2A_DOORBELL_ENTRY_5_CTRL)
-				+ S2A_DOORBELL_REG_LSD_OFFSET,
-				doorbell_ctrl);
+		WREG32_PCIE_EXT(SOC15_REG_OFFSET(NBIO, 0, regS2A_DOORBELL_ENTRY_5_CTRL) * 4
+			+ AMDGPU_SMN_TARGET_AID(aid_id)
+			+ AMDGPU_SMN_CROSS_AID * !!aid_id,
+			doorbell_ctrl);
 		break;
 	case 3:
 		WREG32(SOC15_REG_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_4) +
@@ -178,18 +170,10 @@ static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 					S2A_DOORBELL_ENTRY_1_CTRL,
 					S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
 					0x9);
-		if (aid_id != 0)
-			WREG32_PCIE_EXT((SOC15_REG_OFFSET(NBIO, 0,
-				regS2A_DOORBELL_ENTRY_4_CTRL)
-				+ S2A_DOORBELL_REG_LSD_OFFSET) * 4
-				+ AMDGPU_SMN_TARGET_AID(aid_id)
-				+ AMDGPU_SMN_CROSS_AID * !!aid_id,
-				doorbell_ctrl);
-		else
-			WREG32(SOC15_REG_OFFSET(NBIO, 0,
-				regS2A_DOORBELL_ENTRY_6_CTRL)
-				+ S2A_DOORBELL_REG_LSD_OFFSET,
-				doorbell_ctrl);
+		WREG32_PCIE_EXT(SOC15_REG_OFFSET(NBIO, 0, regS2A_DOORBELL_ENTRY_6_CTRL) * 4
+			+ AMDGPU_SMN_TARGET_AID(aid_id)
+			+ AMDGPU_SMN_CROSS_AID * !!aid_id,
+			doorbell_ctrl);
 		break;
 	default:
 		break;
-- 
2.39.2

