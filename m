Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFA4C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 16:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A41510E43A;
	Fri, 22 Apr 2022 16:46:06 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E7AD10E43A
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 16:46:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L78NiV8mAaNG4UYS4FSyobe62WBoEuy8O8P39uWKh1rCIZiMiYeI3VK4bHUDsRxJXU8fbhWJFcllN9JfwkkCUKQsJT4B2fWfSTOjKNPwH8/LJ9JVA6PYrbhW++d/UXZvvxHHLeiRq4xAaMl1HDLoY6qVke/CLV+LL3HD0aSgRQnPqigKC4R4Xa6ewUwzpab4hHpiqHhHmLtVD7RGDhn4pRKC2FJLxvCuzsvaRwb7CtLfXV8iBkc/Pk/HLGpMhUldYC0WbmaoBkIGK5GMC6lxmkQd4AoqUvUZM2XCus5wb39RyisiPWZ9jNJ99iUkdGEnETSRwIbqpF/1VO8CATPt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=842G2K0rP2/W2CkJfmo44BOnfxI5ysqnSP9se2DZrpA=;
 b=nYSH59QFXoulgoqSqN4w2RM5MovPrBlhbbHABzwfTqmmjIuw/fPnoeDnQyfYIge442OjNn8tA2IwkLNqheCTabkNoYGQKRxS9+SFodL+lbnlGHMSuEbtLk1kkDUHs+0uZCo0ZuZy+XBVyg98ofRwP9hUGkC44TXdmd049344HQf0W2ldy4C4lLmYvqFi9mMSVzr+r5E9jegsi3U5T39po4HTwliJLkEEfbQ69ywLUp7UnT7XiheDticP5SsBgxUqvAo45Z3PVnOVqCzgr8CBwEk86DAl0Of1+x0uE8eQQLSbUSZgf6D2/c60Ol5rClsZgKikms/EN8aSVgvEiUgkjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=842G2K0rP2/W2CkJfmo44BOnfxI5ysqnSP9se2DZrpA=;
 b=EsaCdX6ZRWia+VJGEQjzj+nvo7wh2+4eRcqRp8D9jGOCQkUdTOZFU6QAF5/Sf7HWAWOMCxLbxB/FD7Cx3KJRqK+cwl5DoXbR0Nw0Go2IZ81fVZ/DH9Bvwrvjt0PXttb+qmW4KV2fzV6u3wDNnsn95AmW7O2XYF5++uS6KxwTmWY=
Received: from DM6PR04CA0011.namprd04.prod.outlook.com (2603:10b6:5:334::16)
 by CH2PR12MB4808.namprd12.prod.outlook.com (2603:10b6:610:e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 16:46:01 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::29) by DM6PR04CA0011.outlook.office365.com
 (2603:10b6:5:334::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 22 Apr 2022 16:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 16:46:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 11:46:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 11:45:59 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 22 Apr 2022 11:45:55 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/13] drm/amd/display: Insert smu busy status before sending
 another request
Date: Sat, 23 Apr 2022 00:44:45 +0800
Message-ID: <20220422164457.1755751-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
References: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf73c176-94e9-4343-9a16-08da247f953c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4808:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4808EC97B6F8D163D32A0EDFE6F79@CH2PR12MB4808.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IAio1BmTR0axZeR64LDncJujo7t/MhZalkm2H95Vn+zAQ+rikk1ENIINqv8/d++gKm5k2YmIme4pJ0yjNZmQyMGmOGa9yjlscMqYTcZ9Yudk4MIg/SLlxrF9E7tf/i79QR8sOYKA8s/8AJ0LRCXkQpUIuwLTcJMt5mDxZC8c3Xa96d+qKQeWpsjG1TFnjKALS3c6250a0nXCa76Z3lxywZ5mYOQ6a9Zo8fayPXF9TaCsoQLyg94gStVapX7zpVsYxSgNNI1tA3Rwps3+FMtvUAKT/J7a7tVUCKoAuIiYqXU/3Z1GtpoURkei30Fp0xP+QvpjiXY++svCInhOrvHXA+fxzS0qiI/NThey52yMkEie7FOfexeQNp+0tNrtQ0MTyHsvlHoE5FQAIUVwKLWo0LDXGhKR5tCrYqc7nt+aJ+Uk4h/a+T0p/nIfhuw0UN0wELpPeOwT8yw+XtTWvPTrbhhBLN1atiGahhtYpq1DNSRhz5cc0mwnKB/ABFLmj20CyTIQNLGl0D61CS/IMVGrIpRWw0WyBiiVLyEKMv18sP/ZaP8+QNtWh5BPeFJrEbs6XaQw7ZFPeaKFicAAibWbVzisyMTOd3VWPgcZ0YqWVFIr7VwvY+RRl/7B6MdKNCdetXT6aAEpoQYvzrY+UrSML9OO8n/XgHczAFuiqHn1hNs4cE7clr9DgWYcrWfN1/3JcolTLXkAfiNO0qFzrpujWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(26005)(36756003)(336012)(8676002)(86362001)(82310400005)(5660300002)(6666004)(7696005)(54906003)(4326008)(6916009)(81166007)(70586007)(316002)(70206006)(2906002)(186003)(508600001)(47076005)(356005)(36860700001)(40460700003)(1076003)(426003)(8936002)(83380400001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:46:00.7851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf73c176-94e9-4343-9a16-08da247f953c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4808
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Oliver Logush <oliver.logush@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oliver Logush <oliver.logush@amd.com>

[why]
Need to check if result register is busy before sending another request

[how]
Call method to check if result register is busy

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Oliver Logush <oliver.logush@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
index d9920d91838d..1cae01a91a69 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
@@ -94,6 +94,8 @@ static int dcn301_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
 {
 	uint32_t result;
 
+	result = dcn301_smu_wait_for_response(clk_mgr, 10, 200000);
+
 	/* First clear response register */
 	REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Status_BUSY);
 
-- 
2.25.1

