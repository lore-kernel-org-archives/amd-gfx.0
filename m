Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601ECC433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 22:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D29AA4B2;
	Fri,  3 Dec 2021 22:59:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0DDCAA4A9
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 22:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBz2+pLxyQHJgGbOnt0/h0DBnRhh+OSdEsiBvLGexGh7ozRWuPyx4yYvJ6+O4E8ErVnssI8V+8uHeqeoVlU6iAJru2+uyUJ8yiiauoDYVJJBvODLAf7BQnwf/s7+AOJUME3A9iPj2ld/nuMAcOMTRe/8ktiMq7T+ScfU4wHgKGtZvL/+qPxGIDsvnmuMy12pXrct07BxUDgsBVxJnM+iEeQOmXRyMjbXHcmU3MP20jjvTWQ91+bFQ1GZ14pR7THZL6enbrJ/UAsrWX0bXmxwe2Wx7TYISgNeUqPmvdi6t5v3/hnTfq0j81l6wSEfgFMyNL4Gkc33vy1vz+ElObegMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcySYpND+pB9esowzDhVChC73K2W+ddZCQgW2inSIWY=;
 b=LaxD+BJYQOmlvpT0gRJgkmAsxRSSDIhgBLAWSrPlJl19OsSETf3j767uHPzba24pOgnxwSK7GZKIjrPsf5SXnUfXXab29O89vPqQs4goPtbz1A2WAYze9e3E3cNnBJjCo9Um/MfkpLmfLYYyPjb71IrtO+nI1SzomUANgJaKnHFuOVp9P+W1EHLojD/Nx1sBqyzuRQ7SbT5zGj9l7LTqesZ2MHebAbOpU6cv7njAgFmKFULlx8zOPBsLzDaUXxZdGt2oDegCSsQ6S8Ui9x5MsOQxnKJ0V+7Ah6lmGlr8W6A1cfXDu2raBpInjlCikzplWCGKS4hNjP3F3OpbzrxTrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcySYpND+pB9esowzDhVChC73K2W+ddZCQgW2inSIWY=;
 b=wzPnFXGyFZwlnMmjamnuztyrFAgst5MWrdpGFcPS+O5XFn/Bl+MX+VJpqd3bfu9azNNDIU/zVSdjU/1BtIPHqO4rXS8UUn5mUUI1+RXo2bbrTp1w0NuCPd4I2bupkj2ZIEg72KdB/1CINL323395CAcpOTiRJ/pUk5515sECzLw=
Received: from BN6PR22CA0032.namprd22.prod.outlook.com (2603:10b6:404:37::18)
 by BN7PR12MB2611.namprd12.prod.outlook.com (2603:10b6:408:27::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Fri, 3 Dec
 2021 22:59:24 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::82) by BN6PR22CA0032.outlook.office365.com
 (2603:10b6:404:37::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Fri, 3 Dec 2021 22:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 22:59:24 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 3 Dec
 2021 16:59:22 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/15] drm/amd/display: Reduce stack usage
Date: Fri, 3 Dec 2021 14:58:01 -0800
Message-ID: <20211203225802.651367-15-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
References: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46e91988-a2aa-488a-c87c-08d9b6b08cc2
X-MS-TrafficTypeDiagnostic: BN7PR12MB2611:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2611F38199835018646D4F2FFC6A9@BN7PR12MB2611.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jAMDAxMdEnS/Sx1+zbAmwdMSVnXGid3VA7uiLsm/h2awll2lVvsOJEYkKjhhPEjBnwiTuN37IoIwcpWe0Qze6tts0Fvrbqr1Ez8rl0wofh6scCx/MXW1xJLu7YzJ5Ugi+paRG134GZwTiVCFG3zq9roNIKPNYPKxsk+4JWlG1C4ZFveiquLenN2Vw+FcghaS+x+jxO0uUfScv5vSaBxxUsM1L87EA1QlHopGH/A9Y0dWKM6czY8Y96SUQZ8N2G2Mdtja0iZHbBsWQ1AbanaquskMLVSaZhKK6WZHRp6eZ/Uz62Iv9Ird2rUQkw/HLRfLJ09gPKTanQioc6y+v/t1rPemjs1Xd1lhObBOumFsfLMx+S0eUM7HKjQQcmYLr9RYoqWIl/nJdOAI2BK74hD2JdKDiEM7F1LqGYfZyDD+7jwbUADgWLWCJn5tNaD/dHu29hVCvys9KQy4meYzKs3PtAEa/WdqIIwjqfH5QctG8dOFY/foniNokGdWCdtB+ueBZ+WFd4n3qKH+I5NpLlnfTn0+RR4bCs8yfwmAEeZeZ1GiMAbPmGRvgZtIblpWGJ5aQY9pQYG7Y+dU477QitnY9ghrRVvxsLfQWscUan02D79ftuNXuOkcvr9l11lYN8WJFTr3HHtqQ+DUIH1GZqZa1bNFdapVkcZu8t65fM8d1GBluR7+Xna8kWMnlnKAHzZ+qhD/hTyQdd3J/2TEJmJf2+uFhJrzu5DeDuxlQuKUS8ymyA/Dvi+XPnihA2BiqR/bOmmg+KwDStmk8uwGKkcQt1YOsSTTEpoUoDrMu4K7BNM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(81166007)(508600001)(7696005)(1076003)(70206006)(356005)(36860700001)(316002)(70586007)(2906002)(26005)(54906003)(86362001)(6916009)(16526019)(5660300002)(6666004)(8936002)(36756003)(47076005)(83380400001)(336012)(186003)(426003)(82310400004)(8676002)(4326008)(40460700001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 22:59:24.1241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e91988-a2aa-488a-c87c-08d9b6b08cc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2611
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
Cc: stylon.wang@amd.com, Joshua Aberback <Joshua.Aberback@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Reduce stack usage by moving an unnecessary structure copy to a pointer.

Reviewed-by: Joshua Aberback <Joshua.Aberback@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 471620a3d7ae..7ee548ffbdaf 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3001,12 +3001,12 @@ static void commit_planes_for_stream(struct dc *dc,
 #ifdef CONFIG_DRM_AMD_DC_DCN
 		if (dc->debug.validate_dml_output) {
 			for (i = 0; i < dc->res_pool->pipe_count; i++) {
-				struct pipe_ctx cur_pipe = context->res_ctx.pipe_ctx[i];
-				if (cur_pipe.stream == NULL)
+				struct pipe_ctx *cur_pipe = &context->res_ctx.pipe_ctx[i];
+				if (cur_pipe->stream == NULL)
 					continue;
 
-				cur_pipe.plane_res.hubp->funcs->validate_dml_output(
-						cur_pipe.plane_res.hubp, dc->ctx,
+				cur_pipe->plane_res.hubp->funcs->validate_dml_output(
+						cur_pipe->plane_res.hubp, dc->ctx,
 						&context->res_ctx.pipe_ctx[i].rq_regs,
 						&context->res_ctx.pipe_ctx[i].dlg_regs,
 						&context->res_ctx.pipe_ctx[i].ttu_regs);
-- 
2.32.0

