Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6788CC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 06:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05DB810E700;
	Wed, 13 Dec 2023 06:15:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF7F110E700
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6/cn/Hr5+LBls88TNwd7nB7+dd/21qgUbzfZL6U45Wzr18K66k4MV2V4BDvaGa7HXA9MECUnHoU1j3oD3Wa5Bf7oWPpW0hB99LGZCGwIrVrbvStBTtyov8Hj/QckPhynrgihTy3dJ0lmd4hTpOxQU2vydO60VZYt+K/rASO/9lY9bcPlRPffI7fxHbcXWNzpUPcqUd+uOWTJlyJNTYYTqMqNi50VF15xQGm788wJBQ9tWidgG/s9tHhhvTI0ovPI6gLqnnM4G5Wuhsphcg6S88x1OYV/mAxGn+nXb2xljI2M1E6yP7gj2RIg7MK4DotFus2uQO1ZS7+IlknEQsSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e68t8BK+UpyX65C55ow9E4nZila8Q7xxCy1yXZSjTTs=;
 b=IBxWBQJjEUGX0h+ZG9JtsWS/71FI6bXEaeTJWdTqP3UzBxxfbwQL3qO2zpg9jVRY811VRCBMIly8bZZJ8xefPx6vSoGGxlWDDKCSLQbna/k+w4JzakKlsG1iv/pILuemokP3Ovi8BMrG48ixjLRJdjwTHFbu3naSUQbA/Ji1n8dsiEtFlRM4acIaTJX3Xv7A2O4Pt9OQoOmIAn+Byg6ZGQ5UcCOpJehfgxJC8dL4b0UQ+6VexwAQuuqY/pOCm32x3JVMMOzemOm0pNOutCRWmqIjNaV2iCdM70BtQQ+QINHjR36Emf8q8FVx4GYEZp9UQnJR+oM3fLf5UJv91Tlxcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e68t8BK+UpyX65C55ow9E4nZila8Q7xxCy1yXZSjTTs=;
 b=W2HX6L7yMteLw1lyOFdysJ44WjZkugFBA4pf5BJTwjyGld6Yv/kW6e46lGxE3eCVpZyG2jc3HGVKvjFuJAw6CbShrD5tqpYp75ceuUk559pBvOzB1+SIt89dfFYqpyKvAxapGJSkcxb61ANYBRt4aFDsrwUNNmrFRXnvNy0uddI=
Received: from SJ0PR13CA0045.namprd13.prod.outlook.com (2603:10b6:a03:2c2::20)
 by DM6PR12MB4532.namprd12.prod.outlook.com (2603:10b6:5:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 06:14:59 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::11) by SJ0PR13CA0045.outlook.office365.com
 (2603:10b6:a03:2c2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.23 via Frontend
 Transport; Wed, 13 Dec 2023 06:14:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 06:14:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:14:57 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:14:52 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/25] drm/amd/display: Fix lightup regression with DP2 single
 display configs
Date: Wed, 13 Dec 2023 14:12:22 +0800
Message-ID: <20231213061227.1750663-21-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DM6PR12MB4532:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0f6062-56ac-4feb-3534-08dbfba2d581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OnROI29ndSaQ5deWPi9rH/2RSVvFcgYHJEsca8CiYb5LfETxQZmtV1ItZxwouAuJW9C2J+Tfvrt488zDS4pFq3b++y1Q0GTH7MMXDGXjxieT//e6SvmayHOYllPsfPSEJUjkPXXqqaulLVyZdZ3LP5vfdh/GJP71+Psm5Wq/RVzVvsK2T8+vJvrlIfDwHYAQeDpRd8XnZ26EPC7E5iXx1naagyUPr2hKa9MdrlR/AxGw5jPWfZu0UWq4H5ILaeHcV65BRhzKDIgQqDESOcfpygNhuIhaVEG0nzoKWeS007/F50FHzW7O2wzqj+c1/B/sERwucej7yIrmae2T6UzrgF/EwkpKAwUhzu6saQpEf+kxE4LNcw8ANNHphZ/pVxfF3WgX76w6WZxUDCoDA0jYNTLshdEocuz7qrOH8xNvOspwRRHy3j1gFrs3KWv1UQcWJLeDwYTOTEpmMGqnnPMBOGl5qV/JUby6HXQeRjzC7Wes3+YQWjTOV32tICrz7nn5lXDFkdcvqVQR2wqx/y3expfA5vPdAxpJc739Sjev17UwuQ1zQMzA87UMM59AR2hfE1BeLSy0mZLx1ZN3dcE6FbD9aoaDv14V7QsaJ7ITXsuGIpbxpZyx2HHQUZxqCqNdfWaWqqpcH1DNyBfNTwAbUObEtCLjqufTAXhbynFexduAS45/nA1Hr57WEpZyYxmaRYxLAS7x9H9R4C6aDOAFPSB3hdcJjj1F3kL0mthUq+JddSHwAmDwvuVwmUNfmWGcKrMzfPJfOPnxQBnv/2eE9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(36840700001)(46966006)(40470700004)(40480700001)(1076003)(2616005)(336012)(26005)(426003)(7696005)(6666004)(40460700003)(86362001)(81166007)(82740400003)(36756003)(356005)(5660300002)(8936002)(8676002)(4326008)(36860700001)(47076005)(54906003)(70206006)(70586007)(6916009)(41300700001)(2906002)(316002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:14:58.6783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0f6062-56ac-4feb-3534-08dbfba2d581
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4532
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com,
 Michael Strauss <michael.strauss@amd.com>, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Previous fix for multiple displays downstream of DP2 MST hub caused regression

[HOW]
Match sink IDs instead of sink struct addresses

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index 9156e2ea55f5..8c0794af5ade 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -161,6 +161,14 @@ bool is_dp2p0_output_encoder(const struct pipe_ctx *pipe_ctx)
 	if (pipe_ctx->stream == NULL)
 		return false;
 
+	/* Count MST hubs once by treating only 1st remote sink in topology as an encoder */
+	if (pipe_ctx->stream->link && pipe_ctx->stream->link->remote_sinks[0]) {
+		return (pipe_ctx->stream_res.hpo_dp_stream_enc &&
+			pipe_ctx->link_res.hpo_dp_link_enc &&
+			dc_is_dp_signal(pipe_ctx->stream->signal) &&
+			(pipe_ctx->stream->link->remote_sinks[0]->sink_id == pipe_ctx->stream->sink->sink_id));
+	}
+
 	return (pipe_ctx->stream_res.hpo_dp_stream_enc &&
 		pipe_ctx->link_res.hpo_dp_link_enc &&
 		dc_is_dp_signal(pipe_ctx->stream->signal));
-- 
2.37.3

