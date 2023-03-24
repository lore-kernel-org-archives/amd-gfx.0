Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C6CC6FD1C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 06:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42CFB10E4F9;
	Fri, 24 Mar 2023 06:53:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D3810E4F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 06:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBDpyZerckpH6H7M1E0yq6OdWCTUHGH9hXWjCWuJStQqW2Dx9umkMrVie2U/2RqyJWKksNzLg2r1TQjrvfB6Vc/M2rrybyxeVsUAljjk0a5pwx5uI4naPwOO5RJA54/gKdVLWAGYrK3fLJwjtl6/o7X0Zm8xPCE6Qtuzd/uPjyndQxJ2GBpp+KRQpJPqevgLOqXB2nIRmUcaVlq9yRkp1j4ibOAUJKo1mNVMpBzH4E5Eo+V6a5qUMv0RKX4rUAqjdQ8Cd0x6Qo2AU9z6gw5+nV07m3qZAFUn3i0T9K/u2OeNWcAHmO/rLcLsptaVs9Bt785gFyTIrRDhMrha4oudxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlFfU8QSuYmbuehoOICrAuf/zvYgijK7xmh0Iqjh3Wg=;
 b=Tef2OWoEiAekc1lD00S5fdyJWCfWTBAg5/8xI4k1pnW66E0e9WxRrkDTEarEX8WSwyNA/hIGDYQAA+Mk7r4XvUMlC9jkX0Vs574MevbxZZsV3AUB8rVTQXZ9vGqkkO7yme1sq0sPuWB/T/by3q6MCEu3PyuRE1VGHzX5MxpQdWsQ5O6+t78xRmyZ6nYApV6WR63rLPDWVUEXGeFP8gQFjwYFOGkSBkqlw9TxOlT7GMTtgbh7UmvoilmM7Ldacki7gTR5lw9kmCcJ30S+LQJobJccMV2g9/TrtxjEjB4r2MfaPJNN50dtnxl+IFjjmiX6LQ7foc/pTOqybEIRymNBYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlFfU8QSuYmbuehoOICrAuf/zvYgijK7xmh0Iqjh3Wg=;
 b=m0WqyY0L5Z5qc7vej9kiVhaxhf1nDM7kEN8CnXNmjtNzwHdGxI3M5M/90a75KpiAX+VrMrR8zvXr72XsRFyeCxbnbdnCncXDlk+cEwnP+Wsubb9Mt8u69Etb/2iesGBIshz41iWWE2s8xXJ4VOOOcAJd04kpOjuQw+bbZf2fqQM=
Received: from MW3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:303:2b::33)
 by BN9PR12MB5227.namprd12.prod.outlook.com (2603:10b6:408:100::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 06:53:19 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::10) by MW3PR05CA0028.outlook.office365.com
 (2603:10b6:303:2b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.7 via Frontend
 Transport; Fri, 24 Mar 2023 06:53:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Fri, 24 Mar 2023 06:53:19 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 01:53:12 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/19] drm/amd/display: skip ClearPayloadIdTable if device
 mst_en is 0
Date: Fri, 24 Mar 2023 02:51:08 -0400
Message-ID: <20230324065111.2782-17-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324065111.2782-1-qingqing.zhuo@amd.com>
References: <20230324065111.2782-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT039:EE_|BN9PR12MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9ba8c5-45a9-4bf1-21fd-08db2c3473ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NCGUnzxFvSN+ka8xPfRsp5CZgTHHqTjtEiINBj5RuND1Iw2gPZtAQ5+fqtzOZ1r1nvulflYG2Uxoa8P6F963I/HcXEu51bBwzm15PSYbzUOP+brM26REwxzJeZgb6k+eiu/v39XOBTkyyvGlGesN/eKMynQhNtxe7StQRWRqj5fOl62hyjRjtWYYA/FJVHXZAOxRii0pOCXx5eQP8AL/EtvXVxfsuHtOpew9UGxxAEoyrvEAdAGRqhOm/cajbMLonD2ziUQ4LDTGnGPESerJ/6iQmMoG0ZbI5MAWBYmJFHtAzRL46C1aXHxIbuA9uv1JRXqMPhzcvwKSkryzFtWhomA4Iu42bfcIBlRx5Y1YGKfnRWT8wOPlNGdq5n9SRnc/DAIx1+RxjoEDVjgbNRxzlJhW4YTKnL6ZuwsP00XopI2LIm1XfaxE7vhnQOYt31KgLIjMWYq1DDH6K184iF9CnVp9S5ZV+Mh7vIe0pzx9/wKKjnmJnKVPRQ/0eS+NROQFHEyhpE5THArfNePE/ZQPDWOmzm8jYg8Qo1RKZ8EiTygGzAlFZ8rNmq7JwdPm+VLhXGaVjXrwDPoTZWfXAOxFqFqMgHAOqdvaI7ZZweXTB99UaZCDlzDPu8me6XrCPeNIKDby2RXoqsp5pJ5gFHt55o0YyoUHqmcZZwiynrvZZk6HzXj45bknC5QG3jIFMBpMkyHZAHpjZPkNWwr01LynH2g3EZUQYxEemqmoSfgl2yw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(6029001)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(40480700001)(356005)(2906002)(40460700003)(36756003)(83380400001)(2616005)(336012)(186003)(16526019)(478600001)(86362001)(82310400005)(36860700001)(70586007)(6916009)(8676002)(4326008)(70206006)(54906003)(426003)(47076005)(316002)(6666004)(1076003)(8936002)(26005)(81166007)(41300700001)(5660300002)(44832011)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 06:53:19.2364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9ba8c5-45a9-4bf1-21fd-08db2c3473ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5227
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, George Shen <George.Shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Peichen Huang <PeiChen.Huang@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Peichen Huang <PeiChen.Huang@amd.com>

[Why]
Some dock and mst monitor don't like to receive ClearPayloadIdTable
when mst_en is set to 0. And it doesn't make sense to do so in source
side, either.

[How]
Not send ClearyPayloadIdTable if mst_en is 0

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index aa08925d54c9..f6c5ee2d639b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2160,6 +2160,7 @@ static enum dc_status enable_link_dp_mst(
 		struct pipe_ctx *pipe_ctx)
 {
 	struct dc_link *link = pipe_ctx->stream->link;
+	unsigned char mstm_cntl;
 
 	/* sink signal type after MST branch is MST. Multiple MST sinks
 	 * share one link. Link DP PHY is enable or training only once.
@@ -2168,7 +2169,9 @@ static enum dc_status enable_link_dp_mst(
 		return DC_OK;
 
 	/* clear payload table */
-	dm_helpers_dp_mst_clear_payload_allocation_table(link->ctx, link);
+	core_link_read_dpcd(link, DP_MSTM_CTRL, &mstm_cntl, 1);
+	if (mstm_cntl & DP_MST_EN)
+		dm_helpers_dp_mst_clear_payload_allocation_table(link->ctx, link);
 
 	/* to make sure the pending down rep can be processed
 	 * before enabling the link
-- 
2.34.1

