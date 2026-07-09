Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6BDC44506
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:01:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ACE610F6B2;
	Thu,  9 Jul 2026 21:01:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OU9vCJuh";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013059.outbound.protection.outlook.com
 [40.93.196.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CED210F699
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:01:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdBj0LosqWRw0bj3lSOezDeGQD3FgVD+7pFbpws0A7xD16JmvXawTFoD9oMnFa76yLVMdgoF1gOpvOWwFTN7vKjagYSimJr2h6nwThNuaUaNvIQJ0Vnc1wp+8f4sPI3QXeiLGKwV5yO8m6+6lzvJlP2yRjWvDMp5h0rSsBo79kr8kWsfsHxZ5X8WHrbLOSPrOjC/eCPE26zf8Qv+gwceMEd4kQkfmW4uqp/Ll9sBshWLZGE3gh+jBXpIxbe/AiLxolaJWTCsAuL7UrxVmm/I3nsayoCXIN7D9xzcM65Fy1OUq9FiMjByhkFGNh2uhRFgZlE00dwIJBG3NAU0adSsaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPrM7h/riTgxad5KLyi5T7IXJzvpf2AaNd0dqe5twq0=;
 b=yCDmpG3u3tLVZoUpU3BClzHDDxUj8NOoH/h6mHYylVtjhETSKvG9Ui5w+1dNvS1B2tJ1Opk7kJxC62gbM3IiDOtra65zfAohNYSs52uEtwvAfcK9QuYPab1w1WRPZK5Xt2qFeevm3CRI1vGaugRPERK49Lyw2yTRsULAjDtJqX+dU6syDkxIdoNgt+NvgGul5AYtkslp5HNLUnUErS4D5Jb4MX08OVC4RRGx7CG837IHQOiKdbXLvsQciWRp2vqC8QsjxcPsWfqGHttjKbYuTH8FXg+JejJv10iqg0/wJUmUkJSEP4cn8OI6+dh+ee7vZlC1KwJcQJPphapm/g8qSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPrM7h/riTgxad5KLyi5T7IXJzvpf2AaNd0dqe5twq0=;
 b=OU9vCJuhFerhJqmu1ehJqX4Oi8W1obCWTDhTB01p5jAwHyQovFYXAY0RTzVM6zO4evPbTEDUYKwDQqoJ5Kti3ykqPOs+i8tN2e0sHIkHsSaq0WrNUrRVtzUA8A6rBXHl9eA6bUEbGpNcjnUfjAHBvgRfR3fR7iaBXR0jerad64E=
Received: from PH8P221CA0039.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::14)
 by DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:01:47 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:510:346:cafe::f) by PH8P221CA0039.outlook.office365.com
 (2603:10b6:510:346::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:01:46 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:40 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>,
 "Aurabindo Pillai" <Aurabindo.Pillai@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 08/80] drm/amd/display: Add passive dongle handling in
 force_to_use_aux case
Date: Thu, 9 Jul 2026 16:47:36 -0400
Message-ID: <20260709205936.5719-9-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c91e9f0-4d7a-4b03-7eb5-08deddfd49f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|22082099003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: QhXJfytX6rMjRmnEPJ+o/Iza9nvx8GrYEllh9v7/Po8VwxetvuK1vH42/8+GjqQKdTINKGDVHo6F9rmV6MgMRGVgvJuhiCVR1GQpIZKiTOS9TJtvrfd6kf2DO4e52wY8DHX7wwFNPtiwJkrOFv9zA65GgA68tZ1+7mn+oaO13/RFGN6X5cC2qGttj/fIbIBImyHcguIQ8SU0augJqQTl4EgRKPHhmGcamzocq2HVr4l9RXLH/pAS3XwOqBScQCfEvBiBe3/F99NVtuwO/26yL9FcrgBbexdpPylRdJOI9MKodyjqV7k3kMxDjYC0bsHsWGHlY+0lLsooKBG4XEan+IATofOku5JjEuA1Po1K+WQBxx4tU3ybyWcP5mtjYAkMrBtC8G1/o8C2adq+jgl0AADgk6Y+HXePMghV+hVMdAimkaApoxv56CKQGuWKxPJNSvquY99YGThHoz+sCTbF81fbFChw6wc3ZUYC2OM3gW2ngi4mFP7HDOAk7vf1++6OfDM3nYlPL/aozrF4Ddxso7WcKtoWSTKr1/ET47cvnOF3zncz09uxMNHrvEcINfcGfa2R6rt/i/veWRw8J0/CEYu7gr5uNrd7CvLs1S0UCDNV+D7p3JBFZ4oCX4S9+WWzL69XDlEb/IO8lv2uUB24ybbz9+9Xi7g0duEfVlaFM+s8Rc6sW0K15sCF04Yfb179xzijgLBJUoqd62PggPVlPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IEEwiUIVvSeo+vdUmnUypJB7NoeGDcTl9dra2xUCpoS8hdCGUZAygXzf91xj/eZeOmV04k7xY7gFicNblJr8z6DN9E5mYvAqvxCyEAK8fnizmSfdkJcuj5IA9VjIirpnSbTjumX3e+PVotRO7FS3KKaXiouatjN/0C8t5q1qIWeXOi+Tjd4pUPNeRd7/EHmOQ/ddpryQAwj6fMBmZdsryx1nCziMN4yER9IgtTbEDg/SHSQvBF2rmIkQOCFg8fjRgWCWIPDxXcjkNVJon9hWE2C1djUHw2tf6cQ/LmpQKvZjaaYsMsQHuTql5EYlfrBc8Z2T8yqfpsNTaXrmvg+zAX2I4ZhYzkKPRDvYqNT4eYGnPNyVuRs/ncKd7VQA+e1D0nHO01YVOK5RGDzrLdUt+PPedrnrvnnz+K0T2iY0hM/z31XkpJhL/96HcXQfIxem
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:01:46.9586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c91e9f0-4d7a-4b03-7eb5-08deddfd49f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Matthew Stewart <Matthew.Stewart2@amd.com>

[why]

Need special handling for passive HDMI dongles with I2C over AUX.

Reviewed-by: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/dc/link/link_detection.c  | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 281a7c5acaca..2abe9d3a68d5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -497,6 +497,12 @@ static void query_hdcp_capability(enum signal_type signal, struct dc_link *link)
 		msg22.data = link->hdcp_caps.rx_caps.raw;
 		msg22.length = sizeof(link->hdcp_caps.rx_caps.raw);
 		msg22.msg_id = HDCP_MESSAGE_ID_RX_CAPS;
+		if (link->force_to_use_aux && (signal == SIGNAL_TYPE_HDMI_TYPE_A)) {
+			// case with passive dongle with i2c over aux
+			msg22.data = &link->hdcp_caps.rx_caps.fields.version;
+			msg22.length = sizeof(link->hdcp_caps.rx_caps.fields.version);
+			msg22.msg_id = HDCP_MESSAGE_ID_HDCP2VERSION;
+		}
 	} else {
 		msg22.data = &link->hdcp_caps.rx_caps.fields.version;
 		msg22.length = sizeof(link->hdcp_caps.rx_caps.fields.version);
@@ -597,7 +603,24 @@ static bool detect_dp(struct dc_link *link,
 	if (sink_caps->transaction_type == DDC_TRANSACTION_TYPE_I2C_OVER_AUX) {
 		sink_caps->signal = SIGNAL_TYPE_DISPLAY_PORT;
 		if (!detect_dp_sink_caps(link)) {
-			return false;
+			if (link->force_to_use_aux) {
+				sink_caps->signal = dp_passive_dongle_detection(link->ddc, sink_caps, audio_support);
+				link->dpcd_caps.dongle_type = sink_caps->dongle_type;
+				link->dpcd_caps.is_dongle_type_one = sink_caps->is_dongle_type_one;
+				link->dpcd_caps.dpcd_rev.raw = 0;
+				/* Type 1 dongles do not work with I2C over Aux and also some of
+				 * Type 2 dongles do not support I2C over Aux well, so for these
+				 * cases when native Aux transactons fails and I2C over Aux fails
+				 * report that nothing is connected, as we can't tell is it bad
+				 * DP sink or bad passive dongle.
+				 */
+				if (sink_caps->dongle_type == DISPLAY_DONGLE_NONE)
+					return false;
+				else
+					return true;
+			} else {
+				return false;
+			}
 		}

 		if (is_dp_branch_device(link))
--
2.55.0

