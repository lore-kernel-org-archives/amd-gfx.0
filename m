Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C1DECAAD5
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D76E10EB53;
	Sat, 27 Aug 2022 02:50:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A034210EB54
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:50:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTQkK9+/KKMj0JnutNmnzgJOLRMpTOIy6o4sAXJT/WCaEuNOcXW8XEBxsb0FK3iWCgWPpI3OelWkXSf+fYd5Z90IXMIcf5LO0J9UwbVqCWf2TuQaKx/IYcMoZEJscaykp9ytt4sMI15VMLWKAbrm3Im+oEgERr0lmzDCtzooVl3tEVjrxtTQZR21B9eXmmOqZVuYzVYwtf45mnTBYw+N7YDDAkZdTnm9bUrLpGV5PheN2NoXZFzrei6/LmhLrjYuj5rimYkxpcVneMoi7e9Kq8QwFfcNFA9EVzIAAkl4gREXa0ElzwI1sfsdJw93yIhmAPldFZexWL6SDyfpUAkP9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwAng8S55ibPeUX46k3V9AP6tF1ZOZHfLluagGuwovs=;
 b=jU/dLJyMtAxi3DLHXu3htJ/NLM61JQjm6bNEb09V2ImuwbSuZNWtYfzqTYXQPEjUsbagkdRZ1O/BBgrn/XcJRjgei2ZQEPjcH4BY5SNB+JnZgzYv62wYNv4NxqMS+K5VFQRieksS0Ye7T2uGdPn/F5C20Vx6T6Kg3jnzXtAHhhjnNlZdz4upWXM6sTWF2Y5qUIGQAX1ZUMT9IrwaRmoGEzWMGZ0/fwrXbxk+qNPYXs41KcpCDhTw5m+35uBVFitAPXj2WBWLPuJWkPOLiZDW03WtiWEKAHPlusUIzandlX4sGGqtGHxe2j4mx1hiPd9bNPXxRztm4wzVpGiQAlja/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwAng8S55ibPeUX46k3V9AP6tF1ZOZHfLluagGuwovs=;
 b=ZGlhCX3fCafJTmpKVTdwlrf2s2rEoe0qbSPrypghA7zJxKEPHMFd6sMC+zn7ev59dlZkBspqFPb69kRJd7YsrRh1XPvWg6SfxN9WraYyxR0PA89rGa+KtHtF1tidZ7vuVEqTYeEc+RVPMx2alsMUGpqEBhnl2bdO9xmvNvO1EkU=
Received: from DS7PR05CA0008.namprd05.prod.outlook.com (2603:10b6:5:3b9::13)
 by BL0PR12MB2451.namprd12.prod.outlook.com (2603:10b6:207:4e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Sat, 27 Aug
 2022 02:50:25 +0000
Received: from CY4PEPF0000B8ED.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::42) by DS7PR05CA0008.outlook.office365.com
 (2603:10b6:5:3b9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3 via Frontend
 Transport; Sat, 27 Aug 2022 02:50:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000B8ED.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.14 via Frontend Transport; Sat, 27 Aug 2022 02:50:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:50:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:50:24 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:50:20
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/33] drm/amd/display: Refine aux transaction before retrieve
 caps
Date: Sat, 27 Aug 2022 06:50:24 +0800
Message-ID: <20220826225053.1435588-5-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2549a064-7d4e-4af2-0543-08da87d6e496
X-MS-TrafficTypeDiagnostic: BL0PR12MB2451:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UY9hQOziQQ2yUY7vhIV/HoYYhkvR9jw5S7WLft/JF/ckHn/YpRgw5ufSuNt4/sdn1rc1o8030vfsIRuzcXjH79dVBXEW/sq8Kt0DyxFHXWOSGn0dzhQDZDvVgpcwbt/SAQycREkWtjLPSlx1FefjyTiqHsH/Ki6+efBHcp+LWmli5lB19F5oKg6bgMkRokFcung5DxscCBaFXV+3ByHTJurdjny2zYfHeTx4cfLNYkj86xotLl3bCvb1Jj561f+FfjvWIAckpql/YcDVair4EfwHSLrxKZl0CrGqGGmLhxfLWV5Ko+dBglZgSUF6nj571/X7FFIHjC1WqOvAzR9aLK4AKfzFGMQ9WL3uaVagACvPZURuoMD9svt+oeFSk4aD1WeFv5srmLG138JP1OuONjNMyPMnqitJ0fmwHmzP00dLNKXiUUYsR9hqPMpJKQjJo/GZrVhizyxK3sAPyhjNh4TLAkfk7NDHoN3qiYGpBa3paIPKNq5l0QCdDsWGdEnEkJ36cLt0bP80IeAH7plKBc+9SHx1430EbTPiCGKKyg2b8nkK7n+sdrR+DqrMUINcNN5WM+WNVo7DW2dMzjWo7Q4J85sJcy4idKS3ldH6xSEiBR5pzDHlhLKGwIdjOiIvLqtlLC8ANjkJeHuLz/V8bhC5+SFDvgCHTB2rkHIm3KoIz224t1SA0WDwmLx7nmPblDgevciC+JTnzL8oZ0S7m6juQHgeoCNRQgMwopaqmY48RHS9dSN4FtoO94nSwmwt1PSDX4ugNMhsUtV0opZv5b1STtSV3GL90WxZZdQ0l3HZfmL+rs0ud3Ahgcc3lwmxIwKXBhKEN1ZKqL805M8Mhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(40470700004)(36840700001)(70206006)(70586007)(81166007)(86362001)(36756003)(8676002)(4326008)(356005)(36860700001)(82740400003)(47076005)(83380400001)(2616005)(26005)(7696005)(478600001)(41300700001)(426003)(54906003)(82310400005)(316002)(40480700001)(6916009)(1076003)(5660300002)(40460700003)(2906002)(186003)(336012)(8936002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:50:25.2884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2549a064-7d4e-4af2-0543-08da87d6e496
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2451
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
Cc: stylon.wang@amd.com, Lewis Huang <Lewis.Huang@amd.com>,
 Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jimmy Kizito <Jimmy.Kizito@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lewis Huang <Lewis.Huang@amd.com>

[Why]
LTTPR caps will read fail if aux channel is not active.

[How]
1.Perform 600 read upto 10 retry with 1ms delay in between.
2.If fail, return false and trigger another retry detection.
3.If pass, read LTTPR caps in retrieve link caps.

Reviewed-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 45 ++++++++++++++-----
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 2b7bb3a796e8..8617de559174 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5275,6 +5275,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 	union dp_downstream_port_present ds_port = { 0 };
 	enum dc_status status = DC_ERROR_UNEXPECTED;
 	uint32_t read_dpcd_retry_cnt = 3;
+	uint32_t aux_channel_retry_cnt = 0;
 	int i;
 	struct dp_sink_hw_fw_revision dp_hw_fw_revision;
 	const uint32_t post_oui_delay = 30; // 30ms
@@ -5302,21 +5303,43 @@ static bool retrieve_link_cap(struct dc_link *link)
 		status = wa_try_to_wake_dprx(link, timeout_ms);
 	}
 
+	while (status != DC_OK && aux_channel_retry_cnt < 10) {
+		status = core_link_read_dpcd(link, DP_SET_POWER,
+				&dpcd_power_state, sizeof(dpcd_power_state));
+
+		/* Delay 1 ms if AUX CH is in power down state. Based on spec
+		 * section 2.3.1.2, if AUX CH may be powered down due to
+		 * write to DPCD 600h = 2. Sink AUX CH is monitoring differential
+		 * signal and may need up to 1 ms before being able to reply.
+		 */
+		if (status != DC_OK || dpcd_power_state == DP_SET_POWER_D3) {
+			udelay(1000);
+			aux_channel_retry_cnt++;
+		}
+	}
+
+	/* If aux channel is not active, return false and trigger another detect*/
+	if (status != DC_OK) {
+		dpcd_power_state = DP_SET_POWER_D0;
+		status = core_link_write_dpcd(
+				link,
+				DP_SET_POWER,
+				&dpcd_power_state,
+				sizeof(dpcd_power_state));
+
+		dpcd_power_state = DP_SET_POWER_D3;
+		status = core_link_write_dpcd(
+				link,
+				DP_SET_POWER,
+				&dpcd_power_state,
+				sizeof(dpcd_power_state));
+		return false;
+	}
+
 	is_lttpr_present = dp_retrieve_lttpr_cap(link);
 	/* Read DP tunneling information. */
 	status = dpcd_get_tunneling_device_data(link);
 
-	status = core_link_read_dpcd(link, DP_SET_POWER,
-			&dpcd_power_state, sizeof(dpcd_power_state));
-
-	/* Delay 1 ms if AUX CH is in power down state. Based on spec
-	 * section 2.3.1.2, if AUX CH may be powered down due to
-	 * write to DPCD 600h = 2. Sink AUX CH is monitoring differential
-	 * signal and may need up to 1 ms before being able to reply.
-	 */
-	if (status != DC_OK || dpcd_power_state == DP_SET_POWER_D3)
-		udelay(1000);
-
 	dpcd_set_source_specific_data(link);
 	/* Sink may need to configure internals based on vendor, so allow some
 	 * time before proceeding with possibly vendor specific transactions
-- 
2.25.1

