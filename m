Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7999DC6FA90
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 09:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A06FA10E7DB;
	Fri, 23 Sep 2022 09:21:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B3E910E7D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 09:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+2SdUvHEDwU4mNOeeuugncj0t8d/wr7Uxno+jbFUETCC2ivYsl63PTXHx6Bd9/ohgq1rQnBVjbH+Gt4i21Bjf/fvWZTvdaNkQHU64zJXJSpmBl8TsviOiY4HN7GGdSAzNW3Emq0OKwKaqK8BH9bMwm9QwstxpnSZPR9RZ8At39oEz1CgB3NWpzBybrpDb+qRgwh0uxw2vgoRKLtcrZjSym3BXEUQpK3e4m+fHDgVveLuS7X/sSwondHXFCLW8Lza5ic8d4FRTKtphrn8unnk6W1E/2PvxfKDzpq3J8lqKjrnmvYO+/o7/OG4TCQPTfPik/RDFJrjdKmipQHFQEcLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8ybZdzvsAyj7yRIbtFXFeilr9NtRQeETaAiRRb8cCs=;
 b=R2fj0Dyky/UxF6F+f9JsmOieGysHr1xs+Ld5RmOwLpRE7hHYXxfFLybNkfRidTtmUHJ37VraaNaO62HI7/gLgyCQWc3ro5ZRrIwy79FOYgkeAa48+52bnWy5BYYYzr8A9dnYBUCA23me/Q1jXr1MMOVnYeFIgjCTWxeZ/5Bsx37D6rWLk1PnaYElOQ0g6ElvlJbaXn2vCb+C3Ogd2aYjYLnReYQD1OBGV+uHFwDUznqPIH/2zXIJIlr/QIRDcNqTNZh7F9XBd4KQJaS4BfyR4sMoYL4RDjdbXki8B6v6H3PCvOjQWbSWVDrEBoDycrBsAkqksMJLjoo/YBjWiz8bhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8ybZdzvsAyj7yRIbtFXFeilr9NtRQeETaAiRRb8cCs=;
 b=SocTlSBA+TYaVmjJ6/RJdKQ3Qu5+IPjnh+ojQow7fDt8R9+Ppa6zCGeOWRDwzP6Kev2OGQ8Ghj+qq5ESwgqGHXM1fFC76pbfbbXhbx/lxWTO9USTMP2AjwmJyAKHYz5V6cqlhir3D+zQUH0orB1sd3qv+c409ws9bvu85aeeQ+0=
Received: from MW4PR04CA0260.namprd04.prod.outlook.com (2603:10b6:303:88::25)
 by CH3PR12MB7617.namprd12.prod.outlook.com (2603:10b6:610:140::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Fri, 23 Sep
 2022 09:21:28 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::86) by MW4PR04CA0260.outlook.office365.com
 (2603:10b6:303:88::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 09:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 09:21:27 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 23 Sep
 2022 04:21:23 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: support to convert dedicated umc mca address
Date: Fri, 23 Sep 2022 17:21:10 +0800
Message-ID: <20220923092112.14141-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220923092112.14141-1-tao.zhou1@amd.com>
References: <20220923092112.14141-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT034:EE_|CH3PR12MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e6ff22-b418-4c81-5913-08da9d44fe6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxV/zEDcCk4QniRonKo2dTWHbqacUjuHvh52TQDA4voNEUAa8FWi38epTbJnMKbOWTQPl0XqpQWNNENhG6qg9AQKqAUijEX6PRAjdsVwM0gKJ7S1wbGeFESPa4ca8dUT89NsSbzk/Bo+5Npkzpkcf+JmH8Dbn+yjg50rbAoYiQ7ctUxUs9S82gnI6VHtWI5ea3Z9QZNaugZoW5R8A6eepL/EmN9gVISzhUOVO42jpkRMTra3ton4k+edUHDCiy1n3ssbIzVVY3dgzMdKzWh6nG5Og4AbmVbM+uM2EO4y7Oo9fq9KXVQCazCmqeMVcWLmIDTf/P0gk6+lpNyKJj8DRiWeieb2a2MZKiwqId4MFU7o1GrQb/wZbTvpkfJRERiNYlalA29LyNsguq0lVlQoAJ5GBuLvcFeDb2IL3KA31wV7EsxTv0jyvM9ddBJvy0agfWF8k4ATn9g4p3zwLECaaLItrUMody3+kL4/adzxfoJLu6P/cOJTbt6pu2nMuF+bCTcTpM30uA+xzjedsKAibhbVA0c1y+ZOUs+/QDemk5FNWMoZmeuxYXgvQuAnQ9YWbDAR0u/BZcoisaBckTuHNZykUHHE4DNg4qKZ0pQQ/cjFQ2P9Y1iD8SleT0pX55QSyiM2RKEbbWyhrv/AdW0kAeZ0QdbLTHLD8ESWdYfAVsMdnPqEwVPSVG8NUB8uOcd51LGWxABMg29+p3ZohRvkbvet1azLDwrJ+qfdIo1NAnRnW7eWcPfUWSWbchzDBg4fK0LLptpwa7oTuhNvPnhdRWIKG1FWqS0ljefRqYeQnwY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(336012)(16526019)(36756003)(186003)(478600001)(81166007)(2906002)(36860700001)(8936002)(110136005)(86362001)(47076005)(5660300002)(356005)(6636002)(40460700003)(426003)(316002)(41300700001)(82740400003)(83380400001)(1076003)(70206006)(70586007)(6666004)(4326008)(8676002)(40480700001)(2616005)(26005)(82310400005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 09:21:27.5203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e6ff22-b418-4c81-5913-08da9d44fe6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7617
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

Update umc error address query interface, the mca address can be read
from register or input from parameter.

TODO: define a common address conversion function to simplify the code.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 45 ++++++++++++++++-----------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 0f1b215653f3..090f20589728 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -460,32 +460,39 @@ static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
 	uint64_t mc_umc_status, mc_umc_addrt0;
 	uint64_t err_addr, soc_pa, retired_page, column;
 
-	mc_umc_status_addr =
-		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
-	mc_umc_addrt0 =
-		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDRT0);
+	if (mca_addr == UMC_INVALID_ADDR) {
+		mc_umc_status_addr =
+			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
+		mc_umc_addrt0 =
+			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDRT0);
 
-	mc_umc_status = RREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4);
+		mc_umc_status = RREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4);
 
-	if (mc_umc_status == 0)
-		return;
+		if (mc_umc_status == 0)
+			return;
 
-	if (!err_data->err_addr) {
-		/* clear umc status */
-		WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
-		return;
+		if (!err_data->err_addr) {
+			/* clear umc status */
+			WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
+			return;
+		}
 	}
 
 	channel_index =
 		adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
 
 	/* calculate error address if ue/ce error is detected */
-	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
+	if ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
 	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)) {
-
-		err_addr = RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
-		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)) ||
+	    mca_addr != UMC_INVALID_ADDR) {
+		if (mca_addr == UMC_INVALID_ADDR) {
+			err_addr = RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
+			err_addr =
+				REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
+		} else {
+			err_addr = mca_addr;
+		}
 
 		/* translate umc channel address to soc pa, 3 parts are included */
 		soc_pa = ADDR_OF_8KB_BLOCK(err_addr) |
@@ -500,7 +507,8 @@ static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
 
 		/* we only save ue error information currently, ce is skipped */
 		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
-				== 1) {
+				== 1 ||
+		    mca_addr != UMC_INVALID_ADDR) {
 			/* loop for all possibilities of [C4 C3 C2] */
 			for (column = 0; column < UMC_V6_7_NA_MAP_PA_NUM; column++) {
 				retired_page = soc_pa | (column << UMC_V6_7_PA_C2_BIT);
@@ -518,7 +526,8 @@ static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
 	}
 
 	/* clear umc status */
-	WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
+	if (mca_addr == UMC_INVALID_ADDR)
+		WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
 }
 
 static void umc_v6_7_query_ras_error_address(struct amdgpu_device *adev,
-- 
2.35.1

