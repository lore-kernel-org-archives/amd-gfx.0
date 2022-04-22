Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877B9C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 16:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2950E10E459;
	Fri, 22 Apr 2022 16:46:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B9910E459
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 16:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlwtGqMxJlUXG3/rFz1D7xAPErTGvZ2waQ8K3llBwPItydLOiAr4Ky0zthCwbrl4deebihUg7ntV7vmoqeRYwDRb2XcdTHohSl8eVqYtjyL6hz+Aur5q6TEBXn7MN1pH4netwz1GghVXZj+7aaz7QT0oeRxdBdo2DpFnOrz92fWqTG1iN4RrIFg4xnuPd5P3aTlhVWZ0TDUIj8Nj4ZhVQj2uAGzoST3vj7miFzuBZdlw9JNWPSSVivq7Ol+FRJpkHjRNbunq4zdSCvjaTJt3iHkYI7IcfyAApM48Mi8BVg0jggtJ4TwA7ep732X13M9hjm5VETGd/RpgMPH6n5c/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3SiCm3pzK+u/gkO0VGecYDp0hDCu2zK7khCAR8dPi0=;
 b=kKSwEtDAeRXfgPBtChHzidKMRyWn5EnWNCyltvqhYAuofdh8xViFMCoPfT9z12A25zsNrLFafAl1WqbvRPqBd7exvaGa8/8ZwdqHkNMzxLUJLE3VAyYbpJVZFBD4TCFq5G7SPiGLm0JimBQISB7GajvPCDV4zAwOz/scirsUHdjw0HQQgsIEu6d13U3Ut6L1xT9RePMNFR1scJQlc5fZoLGDwWjrw8v8SBOPqtkotwv4LIR9l0bhz43Cvu31lauGRI5LX+SkJ/SIA4jKC7ptK5TXxBixgV5EurKmTknJnP5fUR+FG5lqcBnIt6bLSzcSwLoVUXWncsytRmbrjmqbgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3SiCm3pzK+u/gkO0VGecYDp0hDCu2zK7khCAR8dPi0=;
 b=R0lF63ZljamUNyz3SwQ3NQseZpGigQT10MSqmaEpYEodj7rYkbU3fEtjy4jxZD5h/vUMMbxpz0A8Y/cIRIUEvuCY1RAGcFOTQ4ByacrrTgRn8JfweeS7CrIpa+h7olseXHSL7xU4DgK4bbc0Ebs2/75fQp067B7mLLkqs9HEhjg=
Received: from DM6PR13CA0023.namprd13.prod.outlook.com (2603:10b6:5:bc::36) by
 BYAPR12MB2950.namprd12.prod.outlook.com (2603:10b6:a03:131::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 16:46:08 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::cb) by DM6PR13CA0023.outlook.office365.com
 (2603:10b6:5:bc::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6 via Frontend
 Transport; Fri, 22 Apr 2022 16:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 16:46:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 11:46:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 11:46:05 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 22 Apr 2022 11:46:01 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/13] drm/amd/display: Fix HDCP QUERY Error for eDP and Tiled
Date: Sat, 23 Apr 2022 00:44:46 +0800
Message-ID: <20220422164457.1755751-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
References: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73b3a92f-0ad0-4b5a-cee9-08da247f9988
X-MS-TrafficTypeDiagnostic: BYAPR12MB2950:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB29504BF2B7478A61AADA2400E6F79@BYAPR12MB2950.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JZ9gyj7mJzWt7kta3bNTWodCAezcNkKrKN8lKAlXfJRi3yRBul+wWRfW7K08wAyh626H3Pbk+7eTYDZsnGvrWdMNrokIJqCCUw4IZQlBJR0pFJarYRZAnnn1v0MfRVRldDP7aDVSrmEn8TdMLwPs96+Z9HcXuGyhrvFB6J2v8Q1NppbgHTc5OlrGRVat+5sWMz28rhknryA+RFmseimtb+CkMyR91RebC0JeSbA/RH9eqSVmVcnFmwRXCA8KMZmXNPRTf/jQX8rJkxDbDDpvaANa8/cZc9aGfm3oOcpcQiFOMmKYVEwL9bjObmmCm+j6Cz1T6luObul3Oe7growUpiI2KTkD/b+7RL6z/+hxAFV5vE3cHMKLHWXrOT3vxRXaotzBQPI4iFf2cjecINo9hc+kgbS64t8YO14RPJOvxxYPwz/SDiuEfy0kPGmrEN5Go6fYL4ZVszEpdu+zO9ZECSRK4S/2vVXdv/8uw33O0UIxZ/9mAtaWjjIio3ypQJbbcuOTq3bsTfCrQkqSzk6wbWR3VPCfcUpjKOulJMzXTikNV8UuKSkdmf1Bbcz/v2e03BBxMmdhl/ZYcqVefQaJ6dY7hphFcPbuYlFwZX/7RwMAMaxLd+qijflKAq82Gy5wSPAxmRNzzldH5t8j09+FJgjggiFre8jV6NSbZ3aTAsCQD8eirKR02Eks4NZF33ow+Q5qab4NCH/YzN51XblwzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(7696005)(6666004)(26005)(5660300002)(8676002)(508600001)(82310400005)(36756003)(4326008)(70206006)(70586007)(54906003)(1076003)(356005)(36860700001)(2616005)(426003)(336012)(2906002)(186003)(81166007)(316002)(47076005)(6916009)(40460700003)(86362001)(83380400001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:46:08.0735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b3a92f-0ad0-4b5a-cee9-08da247f9988
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2950
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
Cc: stylon.wang@amd.com, James Zhang <james.zhang@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Mustapha Ghaddar <mghaddar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mustapha Ghaddar <mghaddar@amd.com>

[WHY]
For dio_output_encoder ID we are relying on SW concept which is
invisible to HW

[HOW]
Needed to create separate cases for when DPIA and non DPIA for
dio link encoder ID

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: James Zhang <james.zhang@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Mustapha Ghaddar <mghaddar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index faab1460d0b5..3d13ee32a3db 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3966,8 +3966,12 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 	if (is_dp_128b_132b_signal(pipe_ctx))
 		config.link_enc_idx = pipe_ctx->link_res.hpo_dp_link_enc->inst;
 
-	/* dio output index */
-	config.dio_output_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
+	/* dio output index is dpia index for DPIA endpoint & dcio index by default */
+	if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+		config.dio_output_idx = pipe_ctx->stream->link->link_id.enum_id - ENUM_ID_1;
+	else
+		config.dio_output_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
+
 
 	/* phy index */
 	config.phy_idx = resource_transmitter_to_phy_idx(
-- 
2.25.1

