Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0F9C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C038113FCA;
	Fri, 10 Jun 2022 20:53:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1470113FBA
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1E7fVO/NGrWwVU2zM8miituNI5ADnGuGKabEXdRpHwDYUKPQ1VhugEdnOZ34CaBsvKEQQVQeSBHI8cfWMB6JfQX5z4JDhhx19+T6qL//hD5huid62IUeQuFoltEtyo7/dUb9bw3OVFvjGcFZw0jn26nbEF6CNp+7RP6FPDhtcgtXYKMt1QHY9fBrQOg0OqyC6d0VgulHy97YOQNymosmRAcAiB9mTpPddkwkazzpOKbQFrwSqq5WtfR+YdZY9jMDnvbbjPalJp+saTaELpq5/eE4OG2Wsx6teF43cNjbtkWDTGRajy98glY4/Dm8IIoyXI0ZbE/aeW2Dilgy0R+UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z+DXkyQJPXkyrECvntmoxEzq+26log5BlDG8x7gfDo=;
 b=GFCgb3VW+e4Owje4enhWOo5s44MP8MOE+5nq2MCdX24K0nxfang1uYCG5Jmp14eVw8Kd8WaDl5CibbLl8IxytombLQ1Zg9sASZGrvT9Ux4ReoFdHhGB+4Dmk2VseKHUxwx6ohACe3OaxijCom3pR11NNs0WFpJpgFCm0WKSEPv64stSJcD+X3R3edrPeHkZ5IZonW7wLN4X6H/dEunKa1HtFAToLwqioch22lgA+y+uMCHh0jkqjav9AH3uIL6kgNLl6A9hZb1IZpBqNmPhtxApVitWPpp5IuaQ4MMDPTYEpRwDGa37IDq6ydVJW8yCZVkabMkOauM41UpXKVA80TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z+DXkyQJPXkyrECvntmoxEzq+26log5BlDG8x7gfDo=;
 b=4Nksp1P7FFePmPPHiqmM4omnSzOofDQQ2sOvTKUirlFiZQtqbNqm6Olgpv23hfac871/4vf3k4rzFtvg4L+tnQLBFlWYuxGSRQ6yQjmqR5dXVS1HfIgh9ZPhbC3lPgYswa/k6Ws6WVVnYk/3J7QLEEQVC5Rc2r73CayKtS3XvfQ=
Received: from MWHPR15CA0045.namprd15.prod.outlook.com (2603:10b6:300:ad::31)
 by BYAPR12MB2695.namprd12.prod.outlook.com (2603:10b6:a03:71::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Fri, 10 Jun
 2022 20:53:12 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::4) by MWHPR15CA0045.outlook.office365.com
 (2603:10b6:300:ad::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:12 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:10 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/23] drm/amd/display: Reduce frame size in the bouding box
 for DCN21
Date: Fri, 10 Jun 2022 16:52:29 -0400
Message-ID: <20220610205245.174802-8-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91dd6e8f-2089-4491-7132-08da4b233bf7
X-MS-TrafficTypeDiagnostic: BYAPR12MB2695:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB269528FAB555C595E95E9BB8F4A69@BYAPR12MB2695.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f0uTefovMx9urpNCxK3tzfMhI+jYFyfFrk0EhKTWe/gqSEf0tfbBmJXsUgRzcq1DW2imVBWRd7TOLi5yOT5Xdmyz/t3MMZrgIIKJFixAATdraYmgy8HwubXUKHaHARM2Cn91RKsa0tjEuC9svfk7m+4nWBvjgEqcud83RGa2EdVUo9RkR6J93gpJHXoOLhFLmjf2aBMhp4jZNClUx4kUJ52Lcf7ToaJ5Ct3P97Ij7w9ArW4aZEuPxpZqWolhWAuDYGPamARD6w8FltrtIvanfOtlNOze+lXOt0E/QYbABFk+Z7Eq4iZ1VUnSWoiNQ+gD20Y3AdFZqU5dPMIU279DImjsQPLYgoZ0l/tvcNoHAS3dckbV41vLIV8mwhQ4HVLfSOcgYL8q35auCJvndFkHeuGKrZrpsX/GH1ZqUwDmZMdPClwLJH1PQL8BQakVHYwU9fJbiS6Ej0XHIB+RIxQU2UXcdEKEcn++5/78vXfjm6XE9YuNj3CZqJVMZ1zjac1C1mMwOqPc+TP+YyMaE7UQJYwwF8onrbOtcOkWwS3hdhSbmJxvKJIJwdFtr+nEWtFn5XFiO5IVqykyJ7X1f0Lq0ArovfGSrr/Qb9cWtbrom4v+IbiIuZM7fKm4i//7XECLar5BZUh8Y2iKDU7RL3rnd/SiTd/b+EKHnD3Zlb54kyhC6RCHFQMRNLlw0fagGNzRSF0TIsl4MXroiI0uKJMU/ZohbQzCeviwMzZKi0c1ImKkdPWF+Xvjq7MqQEPRWZ9t
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(8676002)(7696005)(70206006)(86362001)(5660300002)(70586007)(6666004)(336012)(16526019)(186003)(44832011)(4326008)(1076003)(2616005)(2906002)(54906003)(6916009)(426003)(26005)(47076005)(316002)(83380400001)(82310400005)(36756003)(356005)(81166007)(508600001)(36860700001)(40460700003)(8936002)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:12.6482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91dd6e8f-2089-4491-7132-08da4b233bf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2695
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

GCC throw warnings for the function dcn21_update_bw_bounding_box and
dcn316_update_bw_bounding_box due to its frame size that looks like
this:

 error: the frame size of 1936 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

For fixing this issue I dropped an intermadiate variable.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 29 +++++++++----------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index d9cc178f6980..c2fec0d85da4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -2004,7 +2004,6 @@ void dcn21_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 {
 	struct dcn21_resource_pool *pool = TO_DCN21_RES_POOL(dc->res_pool);
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
-	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
 	unsigned int i, closest_clk_lvl = 0, k = 0;
 	int j;
 
@@ -2017,7 +2016,7 @@ void dcn21_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 	ASSERT(clk_table->num_entries);
 	/* Copy dcn2_1_soc.clock_limits to clock_limits to avoid copying over null states later */
 	for (i = 0; i < dcn2_1_soc.num_states + 1; i++) {
-		clock_limits[i] = dcn2_1_soc.clock_limits[i];
+		dcn2_1_soc.clock_limits[i] = dcn2_1_soc.clock_limits[i];
 	}
 
 	for (i = 0; i < clk_table->num_entries; i++) {
@@ -2033,24 +2032,22 @@ void dcn21_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 		if (i == 1)
 			k++;
 
-		clock_limits[k].state = k;
-		clock_limits[k].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
-		clock_limits[k].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
-		clock_limits[k].socclk_mhz = clk_table->entries[i].socclk_mhz;
-		clock_limits[k].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
+		dcn2_1_soc.clock_limits[k].state = k;
+		dcn2_1_soc.clock_limits[k].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+		dcn2_1_soc.clock_limits[k].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
+		dcn2_1_soc.clock_limits[k].socclk_mhz = clk_table->entries[i].socclk_mhz;
+		dcn2_1_soc.clock_limits[k].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
 
-		clock_limits[k].dispclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
-		clock_limits[k].dppclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
-		clock_limits[k].dram_bw_per_chan_gbps = dcn2_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-		clock_limits[k].dscclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-		clock_limits[k].dtbclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
-		clock_limits[k].phyclk_d18_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-		clock_limits[k].phyclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+		dcn2_1_soc.clock_limits[k].dispclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
+		dcn2_1_soc.clock_limits[k].dppclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
+		dcn2_1_soc.clock_limits[k].dram_bw_per_chan_gbps = dcn2_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+		dcn2_1_soc.clock_limits[k].dscclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
+		dcn2_1_soc.clock_limits[k].dtbclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
+		dcn2_1_soc.clock_limits[k].phyclk_d18_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+		dcn2_1_soc.clock_limits[k].phyclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
 
 		k++;
 	}
-	for (i = 0; i < clk_table->num_entries + 1; i++)
-		dcn2_1_soc.clock_limits[i] = clock_limits[i];
 	if (clk_table->num_entries) {
 		dcn2_1_soc.num_states = clk_table->num_entries + 1;
 		/* fill in min DF PState */
-- 
2.36.1

