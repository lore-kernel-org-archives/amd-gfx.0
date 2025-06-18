Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5278CC7115B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 15:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE86A10E8C1;
	Wed, 18 Jun 2025 15:54:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UGNSORqq";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1583910E8C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 15:54:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0yJ8lsXMCnFNKDbpCO3ZgUwX907cMiuPlfd7RHZNZM8Vnn3p5mu00IoG7FuCUR47fKbF+TaKd41Jx4iCGLcEFA0d6tQ65BSOmljMab3diPGioNtm2wBxXOlwFXiC7SD0OlTlDGRAqvC5GDLRO0IXdV9pSZwTF2J4oz6HCCrwpz/OvwKys/fmWw15LtxcV2plk/qBSW+60CDwZl5saZXjaHwzCJdoD2ykJyU/NsKC/5rcYGzZMC3G1qHE9VGwp37fjtOwu8E4ddzEeQod7XGwnjIH7RG1masqyBk0bhCCmTzVrB7AiLJAc7q3jI+ZX+tFUPpn6QyE/8wdt41VfAIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqkwStxDwunkvvROh+IIY1DOnlwwBbjU1IvZQ+u+3yg=;
 b=u7JWcmokwbxopXStW/2UdMl1K9f0WpFMATJz/BS/931lyHlX2SunLSsuWtUDiYXt3aoA/ti2b+N4rkkwDaJFg4kXV1uSUyJP4jPQjSD3dFfOBBQsia39m9U56BV9LJ93pnhrmw+2FZY99AdVXfP8MLpnJnIMOjm6Vp8BOySDwtwNFNgFrmf0SlCLTEE8tg1rOK6U5Qa5trnPktLN3mqNXYOa1jdZCv9Bv/xx+a2wAeEWjOhIYHkGQ/h7VGZiaB9se3TQA9AFhkBpTHxvFaHAgYPLokzFlSJBXvy0L26sC14UUja4P6lilGWR18/V1iY17XpA3vLVuTdyz07vbeGBqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqkwStxDwunkvvROh+IIY1DOnlwwBbjU1IvZQ+u+3yg=;
 b=UGNSORqqh8V0tOJgnV9m19NrKA9TdVnGalU2o7AoDMGW3fxbq2ALTYVhm/Bw+tXbZ5/9aiShoUKa9Ha6AiLv8z0Ic9nFKkUGCN47oMRvjDO5dNoyU4LA8puZifbslWmVIGCIPhTGsUxoqeBqedNQVH81weC5mwGjeEu43/YkJbo=
Received: from BN0PR02CA0004.namprd02.prod.outlook.com (2603:10b6:408:e4::9)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 15:54:53 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:e4:cafe::a4) by BN0PR02CA0004.outlook.office365.com
 (2603:10b6:408:e4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Wed,
 18 Jun 2025 15:54:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 15:54:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:54:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:54:51 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Jun 2025 10:54:50 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Wen Chen
 <Wen.Chen3@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 05/13] drm/amd/display: Fix 'failed to blank crtc!'
Date: Wed, 18 Jun 2025 11:33:53 -0400
Message-ID: <20250618153936.6472-6-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618153936.6472-1-Jerry.Zuo@amd.com>
References: <20250618153936.6472-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa71d88-ccf8-4dbc-17ee-08ddae8076e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rzc5VGFjVi82WSsvL0FnbFNKVm5uUnQ3UGJJdjgvYzhDTUxxQy9lZ1dJV3RM?=
 =?utf-8?B?UC9tYUVhSEczbU4wL3V1RHZQcHdKQ2VaNjJnK2FqTm1FQm9Kd0xDNHcveWpZ?=
 =?utf-8?B?WE9hS283NGpLdWFCMm02RmlSYm5oeDdSSCtOQy8zNFp4TDhUSis0SUI1eHZj?=
 =?utf-8?B?YkZiaUN1UXRSTUZzenNGblZIUFlLcUY5bHV3NDJVa3FjNGQ4ZUxOdGxFSUlY?=
 =?utf-8?B?cWxkaDVBWU1FbGgrY0diNm1Nc3ZCNm5nNC9qZWI0Y2J6RnNUWk0wYVpod2Rv?=
 =?utf-8?B?L1pDQlFRcGdkdWtYaC94Vlg3OXpzU2l2N0ZtNjhlRFpuS3VjS0VJZzE0OWdn?=
 =?utf-8?B?Uit1dWpiVFhOdVgrNkt2S05ZZjYyb09NZzF5STNVRTlzSWFlc2tOLzRIbEYx?=
 =?utf-8?B?VDhwNjA2TnBJOG1YOHRUSUVURmVKS25WcnZlVVNIUGpSelMzTysvNzdhenhG?=
 =?utf-8?B?Yi9iOTZUL2VTN1ZMMjlYWmU5L1dEL2p0bDJXREJnRGh0L3VhUldSKzdSTUV5?=
 =?utf-8?B?c0pLb1NDMFBPakgrbE9PYzFOKzA0K0tLd2swRzR2RjJ6VnFQL3FSeXN3d0pj?=
 =?utf-8?B?aytaNGIwc2ZEb0U5NjRQOUF4TlJVQ1U5VVYzbStKSkQxQ3RoTzhIemg5MDRD?=
 =?utf-8?B?R3hYSi9LY3lwSUZyN1BRcWVwaDhlWVU2bTdORU5GMTNEcmg1UXhIb1BHeHdk?=
 =?utf-8?B?bnlIanFpMHBzYmEvMWZ2Z1MrOERiVVhubTFsdXQxSncwa3p0YXBjNHNVa200?=
 =?utf-8?B?VVFEbjFpMU1MVDNqV2lPTXZmZEhIZ0lwWWdhRk82THJackhIT1hNeGZnMFhm?=
 =?utf-8?B?QTcxTkgwb2Zwb2V4d3paRkZtOU1XMVpxT0txR0ZDOXVORkV0RW9EUkdGcSs3?=
 =?utf-8?B?Mit1RmdocFo0ZmRPZGxCdm93UHhkeDZZRXBjT0R5UVZCckx2V005OW94VkFa?=
 =?utf-8?B?ZGZnbkh1LzRGeDAwYjRLRHl1Ykt0d1Vick5sNENEZ1BnREZxeTE1ZEdEalls?=
 =?utf-8?B?V1BXOHVFUGdScmVtd1Zxc2JERlFGTXhueDNmdVpOaWRPQjZYdHNkcVBQOXV6?=
 =?utf-8?B?U1A4YVJmL25WZ1FKN01LLzNDMm5zbDk5cG9NZ21iSGtPN2k5eEdTaVI3cjgx?=
 =?utf-8?B?NWhjT3VBMTkvL21FN2h2WEhlMkl2UllOZ1E2TnQ4Z1lxQlo5M2RCU1RaQjND?=
 =?utf-8?B?cS9qT21ldXZBTDRLZVZRTVMvNlhJWEEzdUlQem5wQVFWQkFQY1NFY2Nnd3pC?=
 =?utf-8?B?K3NqdjdXbGV3cU80OGZBYi85QkhQd3RZNVQvVjFPeDBXSGNmVTc0SGlFZHRT?=
 =?utf-8?B?dkdyM0w3WkNZZTdLaS9TZzRhVVRxNjI1Z09iUytFWUhwWWl1aUlZK2Rmay9M?=
 =?utf-8?B?Z0wrd2IwY2Fxc254S0tkSmRiQUVxelhWSG00ZFB3eUVoSmY2bHJJRGxkUnVH?=
 =?utf-8?B?MzZDU1ZySGRsdGFwL3Jka3lVTDFTQmtwOWdnckc5aVRmZHh6a2duZ2Jqejh5?=
 =?utf-8?B?WFFiMDhLVkhzQkZweVEvd2s3NlkwQmh6a3hvbFlOWERpdlpHOEM3ZUdXR1h6?=
 =?utf-8?B?NDF0NkFpNU11ellVc2F5L2pYYVlPOEF0dStNYktwa1RGTTAyd1pReVZtOVdt?=
 =?utf-8?B?MzBnbzJxcnRQNkF4aFVLcEZReVBTZ0hEZ2VwS1ZVNEtKSTFXRUJNaEVLaUVB?=
 =?utf-8?B?dGdhbllNK0xaLzB3QVhHbGhqQ041SXVGcFVVb0JYelZBL1lIVStSMitnbFZU?=
 =?utf-8?B?aUhnUXE4VzRBVDJkazU2T2NqcjBwUGdyZGhyV0cxMVQ4OENsNEc3SEcxZlh3?=
 =?utf-8?B?Rkd1YjNibnRwbW5OZmZjT3NkWjZVdTgwMDk0elBwbEppN2NwdTJmOFdGTnND?=
 =?utf-8?B?K3JZWFQyWVZzdWpjd3ZDZ3BkeWNWTWhaOUpYV2VtNEFJM3o2UHRhSEhQSHM0?=
 =?utf-8?B?RDBKb2drZ1NYcnljckt5Q0UydkZnYm1WeUo3ODhkQXZiN2UvdTQxVTNWMDMv?=
 =?utf-8?B?TktxMHVRZk1MNWE5YlM1UFc4cVBENVV0dGJPWVlya3BkVzlkbGV6ZmtYZjhP?=
 =?utf-8?Q?k2rnIu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 15:54:52.9478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa71d88-ccf8-4dbc-17ee-08ddae8076e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
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

From: Wen Chen <Wen.Chen3@amd.com>

[why]
DCN35 is having “DC: failed to blank crtc!” when running HPO
test cases. It's caused by not having sufficient udelay time.

[how]
Replace the old wait_for_blank_complete function with fsleep function to
sleep just until the next frame should come up. This way it doesn't poll
in case the pixel clock or other clock was bugged or until vactive and
the vblank are hit again.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Wen Chen <Wen.Chen3@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 6a00f0984ce1..7f9b6c4bf889 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -956,7 +956,7 @@ enum dc_status dcn20_enable_stream_timing(
 		return DC_ERROR_UNEXPECTED;
 	}
 
-	hws->funcs.wait_for_blank_complete(pipe_ctx->stream_res.opp);
+	fsleep(stream->timing.v_total * (stream->timing.h_total * 10000u / stream->timing.pix_clk_100hz));
 
 	params.vertical_total_min = stream->adjust.v_total_min;
 	params.vertical_total_max = stream->adjust.v_total_max;
-- 
2.43.0

