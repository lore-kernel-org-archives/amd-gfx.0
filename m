Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40641CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A3310E4F0;
	Thu, 19 Oct 2023 13:34:49 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5683210E4EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:34:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/KJlJ4o9astpNdK8xg670F6Kdepo5Gdyq3ikKDqp5DHTfOt9wIb9C5f5UWebVkAYOkoWscGDZmRD8FEXFwKacrO6y7zgs/NiJtuhsBUBB7Tus3MGHjiBhiFNIRDTuVBkMPFp/wUuPMKoV60vjdA33T3GA9jaaUYcVG4g4pUyZo9pEyDi8ABuMADYSIKHBtkZRe41+rr0g81OYg8irOXWSzNaGUFK+5vTyaSVO2PvNr9nSPVNOPLQDlRVoj7i4jV7WxfsnLB/ryL/c3VR8uohdVFu0tIHggE4g66QtcIU6qj1uZyu1iKE5lt0poZ0mTvfx3fKsSb+wPpByqHzSnmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJRyzy/rpfU8CXPksLbYB8BO6lQC6242thDUWNoXEUI=;
 b=Mo8Z2OYHy62DDg9HjZWWUDbyjDNTeklck3k3Bjfrrq6p6P+NafkAcHyvmYEBorvNXK0jtRSL/NdXdDMQVpGJB0jWVwZaK9KbfLCURzNPCytUYiew/c6+4w1BxiX/zzcAJlJf22Dvyrc6PIBA0Z5JkEnRs3EvFxL59YF9r8DOGgfTtLG3vxffANF7oTTlR7p1ulKePdM+iUdkyCv0p2kvqKwfYT0yJQKyjTW9i47LQ7qWKPMtwfbdkbDqZK+Qhh2osMKGMZrP9jcf+cqIegMvIM0pG/ah6qUTQiVePXlZKbTxfZYN4rlkxapOu3kSJEvPF4kaOPX1lJSBLZKx0ecsCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJRyzy/rpfU8CXPksLbYB8BO6lQC6242thDUWNoXEUI=;
 b=dlCQUDbcRVix9EFaVlqHXFWpJ58cQMQbiH/TQz4ZT64YDw7Q14gylcWt5gOWjLmSwwSDtKlc6npVwqu3Fworutq+XdgHCPN6iXr+nh2Kk5oQmrfoXqkpdFZ8mOsb9drhB6ezclTnovjvHoSn5AIvKEWIr7NUWAPbfS7IDyLBeA0=
Received: from SJ0PR03CA0099.namprd03.prod.outlook.com (2603:10b6:a03:333::14)
 by BL0PR12MB5010.namprd12.prod.outlook.com (2603:10b6:208:17c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 13:34:44 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::bc) by SJ0PR03CA0099.outlook.office365.com
 (2603:10b6:a03:333::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Thu, 19 Oct 2023 13:34:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Thu, 19 Oct 2023 13:34:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:34:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:34:17 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:34:17 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 17/24] drm/amd/display: fix num_ways overflow error
Date: Thu, 19 Oct 2023 09:32:15 -0400
Message-ID: <20231019133222.1633077-18-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|BL0PR12MB5010:EE_
X-MS-Office365-Filtering-Correlation-Id: 500ecc95-1739-4dcd-9e56-08dbd0a827b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJBdhrm/pTqBYt//4/jD2AKv7Qf/hkHkg7X3T5AhJQtvnzR7tf0D0WGvZqjztaEXG+daMfIfSucm0xnF1jO+fBQDltYfQc0F6x+ise9Sd+Cw/6hqpG/q6a9SH2KQWFrppjd9w9kHDwuDuZj5GwVctRqIyJiLWluxyZxWJuAt4PORy6QI1kYxZSCyOmNiEMb95OX67KSeaAuGQEcTvzqFoDkT1NYVacxaZdyc/6+NyNfTpKEo66okYssccb35aV8ril/i6/8LkFInsgcoQGlIMeqvbPIiA1kBQw1CViDdQEhRRBSGhNDYpRgFGXKtuGmLYp2hgGGFKdxD8qguSjl31x2v2dxsMz09lzOsDfOS1YTa6gbMGR5FM8rOzs5KErKtLN7hfuL9PvoAnWlm+O7E2R8FaAvNxzjB7i/O+LpnWyBIShmHnTW8cV7HP7QfLRpxmDPzYl/EAV/fwLLDrdhuf9ModoqO3FbwdCaSaIvs9AOq7LPhiikkCJbEfaaeAOq2ysr8V137r1MDTkjyM1XCCCDtADSNe1/Ku3jCNxO9ao3lXreMZfN1bzbgkJsTLhbFiiIvnTe4+WyR1Cv53Gc3Jkdzb5MlD7AbCd2voJY8PrS3D90C9esPFmx6TqFi18nYUsP5nK5M+rngXhyJkUJQLyHdDK5y9RR9YdfrZFuha4pm6A6HgvwVKb29XgnW6XFdHmpcxR2H75dVvGR2K2Qu2xWUUpqIeA2M62ROBlctTzvBfUiSFkjT/KIOS9mQAmi6/IGs+QKIAKOVzkrOYbQ4qA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(1800799009)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(40480700001)(41300700001)(40460700003)(2616005)(1076003)(26005)(426003)(336012)(36756003)(2906002)(2876002)(86362001)(4326008)(8676002)(8936002)(36860700001)(83380400001)(82740400003)(356005)(81166007)(47076005)(7696005)(5660300002)(6916009)(316002)(478600001)(70586007)(70206006)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:34:44.0791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 500ecc95-1739-4dcd-9e56-08dbd0a827b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5010
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Samson Tam <samson.tam@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <samson.tam@amd.com>

[Why]
Helper function calculates num_ways using 32-bit.  But is
 returned as 8-bit.  If num_ways exceeds 8-bit, then it
 reports back the incorrect num_ways and erroneously
 uses MALL when it should not

[How]
Make returned value 32-bit and convert after it checks
 against caps.cache_num_ways, which is under 8-bit

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 68dc99034eba..2173d84e4953 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -217,7 +217,7 @@ static bool dcn32_check_no_memory_request_for_cab(struct dc *dc)
 static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *ctx)
 {
 	int i;
-	uint8_t num_ways = 0;
+	uint32_t num_ways = 0;
 	uint32_t mall_ss_size_bytes = 0;
 
 	mall_ss_size_bytes = ctx->bw_ctx.bw.dcn.mall_ss_size_bytes;
@@ -247,7 +247,8 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 bool dcn32_apply_idle_power_optimizations(struct dc *dc, bool enable)
 {
 	union dmub_rb_cmd cmd;
-	uint8_t ways, i;
+	uint8_t i;
+	uint32_t ways;
 	int j;
 	bool mall_ss_unsupported = false;
 	struct dc_plane_state *plane = NULL;
@@ -307,7 +308,7 @@ bool dcn32_apply_idle_power_optimizations(struct dc *dc, bool enable)
 				cmd.cab.header.type = DMUB_CMD__CAB_FOR_SS;
 				cmd.cab.header.sub_type = DMUB_CMD__CAB_DCN_SS_FIT_IN_CAB;
 				cmd.cab.header.payload_bytes = sizeof(cmd.cab) - sizeof(cmd.cab.header);
-				cmd.cab.cab_alloc_ways = ways;
+				cmd.cab.cab_alloc_ways = (uint8_t)ways;
 
 				dm_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_NO_WAIT);
 
-- 
2.34.1

