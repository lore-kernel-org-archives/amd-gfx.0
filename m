Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05092C47095
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F8E60FEA
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F8E60FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83A026E936;
	Mon,  7 Jun 2021 16:48:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEC146E933
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZiQ9Fux8NdHzSjX1j+HTxLR7ZGC0Swr7J5LEICaEOJOjm0db8z8bfPTd4av5kW9eS8+94cZV6Ne1H+9fx8MKc8ZcnVNmuGdfNUhM1dBe8AnxeL8GRD7y2HaP7m5uvABtvuTF4q6tNTzL4Xu/mAUpJj5Hikk79gD9wfjPxXLksa0qsxBq53PySDeuR3E4vpCv1lsyBaFsWSPF/UVjnUVrW8vOKCsn9dysZNA//8mCZZ6VbniSc5OMxwZdyAwby63aMivUimLtsRE1t2W1fV5nSJfV1430vn2DO2hRme8kfpdlOBHLMpfvxGwu1f+xJkiAmA5LOSxw8XGRMkC1i/b7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjfFZ6Et2IXD740b4SV/Q6W0rThe+QzPUbaehFFDgns=;
 b=LJFii+oDAOWRxmMPiynQJb1sfWbyqBWMYGpOfPA12ofi8fHP1MczhcwTO9zqeVs/PMvNwSCFyVwA94hsxF/FnGOdH77312eYNGdqlbH/MMKdzEB+rToZgQPFqM3WSJxvjcnkQ/L0+qusbISZFy3DQYCw1hFBcfqOoirNRF39W+tR5RqzZEK/zjibKsD06254e0EJ/lwtVH0yveejpUDd51DcjHTdhAs2yNbe507wX5GgzS2JsF0yDCvua2ThIvA+5y4BZ6wSNw9Ao+K9fSCvWcUMqNvlYaUsDiTUkvSvMfI5+iUhhuN2ktMVu8t6fLFsPqFl8+5MgEsZDjHfhBH89Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjfFZ6Et2IXD740b4SV/Q6W0rThe+QzPUbaehFFDgns=;
 b=OSaQSKKGeDuThYGgOMcPs6yCRzzT7PqmG2HiEE1h4BSpEZezdBnf7tJKT+5uzq9Ofyn5kX8MbSKlMse7EFRzpjOruOzBG99yNcWw7n011sTf3+OpxWxsYaqcvb+HYUC9HonpsnJRPbFRrUQ7nnuRVAd5ZCB/BilxNaHbYXv/2aw=
Received: from BN6PR1201CA0018.namprd12.prod.outlook.com
 (2603:10b6:405:4c::28) by BYAPR12MB2680.namprd12.prod.outlook.com
 (2603:10b6:a03:63::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Mon, 7 Jun
 2021 16:48:21 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::fb) by BN6PR1201CA0018.outlook.office365.com
 (2603:10b6:405:4c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Mon, 7 Jun 2021 16:48:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:48:20 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:48:17 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/30] drm/amd/display: Support mappable encoders when
 transmitting training patterns.
Date: Tue, 8 Jun 2021 00:46:54 +0800
Message-ID: <20210607164714.311325-11-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80c12419-1030-4c42-3df1-08d929d40ea9
X-MS-TrafficTypeDiagnostic: BYAPR12MB2680:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2680AE2F2796F7CE5C3CE349FF389@BYAPR12MB2680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vPG6Yuia0Vd2QYv+3sdVNO8YWOJhUc/mjJGLhho09w1hEUJMBJkqDOW38KfVHmeGcYjvGEQOY2z2+8wTGaGm8YcSGSaxLmfJI7VCO6l+6mnFFkBcIfkNE1E5/zA7fU5cSzx761Xnw/WRrmEXnhHIiyf01eWsaHU2MFsh0oGGiZ3mZCWabQEzo4YntiokRQJ83MkLNyppiSx6GQsn+7pipq4RjlhrzKExPnUUPBELDdXZn4WC1vxeRcb7krRhxcNGdmS5Gq9r09cw4gGMxFOxO9VHKK7y4FprKM773WHASEGnNnO18oD0DtBKXahm5IAxNd0cr1wjn4Q15xAlppk3H7b/HNM6NwN+3i97gEBbLDxQ1Lnxo7mxJo/7flaVfFzVJ6AFyOqe2zRMreSWa8Y2qrIDgwvcEQSVr/SP0pVbtzVr6bjatHn+71aDFasMayAwWYAwKdn9IdF6xNRw6s9OpqAsxdBgST3pwA2JoNilDNz9rhsKY0Tf5pPESctMlu9KYee3Pslh98YUsBR779lhR9AYy0rKNSpYHevMTviLjqKOBR/jutPJhogisP380guDmgsaTMUdU+/mWfES+k/KfOMYL9DWTCJrQEZh1l2DEbUDH0aeX+xNsJrjGMaPL8pmlEEdHai7qwPuxfA9oQ39f/V70OTErDK6PctAe/1GsIThWz4oAINnEHrA5BE6nNfy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(82310400003)(44832011)(356005)(86362001)(8676002)(2616005)(70206006)(8936002)(26005)(36860700001)(426003)(2906002)(4326008)(336012)(47076005)(83380400001)(7696005)(54906003)(186003)(1076003)(6666004)(81166007)(16526019)(498600001)(70586007)(6916009)(36756003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:48:20.4989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c12419-1030-4c42-3df1-08d929d40ea9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2680
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com,
 Jimmy Kizito <Jimmy.Kizito@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why & How]
Add support for transmitting training pattern sequences for links whose
encoders have been dynamically assigned.

Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 13c5c4a34a58..f7dfc8fefdfa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -332,7 +332,16 @@ void dp_set_hw_test_pattern(
 	uint32_t custom_pattern_size)
 {
 	struct encoder_set_dp_phy_pattern_param pattern_param = {0};
-	struct link_encoder *encoder = link->link_enc;
+	struct link_encoder *encoder;
+
+	/* Access link encoder based on whether it is statically
+	 * or dynamically assigned to a link.
+	 */
+	if (link->is_dig_mapping_flexible &&
+			link->dc->res_pool->funcs->link_encs_assign)
+		encoder = link_enc_cfg_get_link_enc_used_by_link(link->dc->current_state, link);
+	else
+		encoder = link->link_enc;
 
 	pattern_param.dp_phy_pattern = test_pattern;
 	pattern_param.custom_pattern = custom_pattern;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
