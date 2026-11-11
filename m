Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B392606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DLbcriuZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE6010F8FF;
	Wed, 11 Nov 2026 01:46:05 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD4F610F8FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:45:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Do8ip5QgZcvMEypuY9KQvTmVLLu+3T6uoeYi6EQcJFz0MfadEFp12yH5go63aOQOLcGJRk/fgqCFETBVaavdrzMGWJeoqbMuLOT8L4hINRRx74VgPXHqSYAVRX88tTEDg/irQJbzJBKeLc4SWyXrzNtyVlaj/g42EGNoiHciY/ILZPRztMeI/0Ax5H3Qg1/o9rfwbcOCq3P0I1B0m4jlWJhdayBZx6BjE98kHK6dQXxVNgGLrv7Kjf1GyBUy8MfeMb/VnpAsZ09EP/pC6lkEJlThEkYFHpjLoFjGmSYOeP3aI2unx5Esq/dteb/ruccfaHnzRqf5b/DpYBQer3SAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=405BYk+kUykSOQLx2K8y6MOgGZOY+vN0aDHKHYO3S5c=;
 b=vlyxX6F3oqxw5Nkp4iwCYHlLwA52MTzUOxCAoabVNkU+/R/4LwzsHWgopZKPDGgwa+GDNRQw34hIoJpczMjYZToI57+6GfFDHqY49Ue7qmSYqKDOXiNKvW3MvkoFEidcaLAVdwyf1JEaDRQvKO7QLMgIZfxyEp1eMz/W+DMBBan+qAvEPE5RTjoUhhBajSTcT51XMx7bSyGa58EFpun5jA+WsYD+iN4oFjn4evHjpZ/N73NYZQXlTY6d2tOKL78n70XaldKcADy00ZqsadwMpER1AcvPY44xd0mcqkRXLkpstqVVXxpRrq9kYuF7WKAAsTS6IFZMNDbfW5vClLoVzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=405BYk+kUykSOQLx2K8y6MOgGZOY+vN0aDHKHYO3S5c=;
 b=DLbcriuZ8KbLBfold4DtWkTjJfRes2X6SbnmQS8/VV/CXbBO7hTNmz2E60E4BIpbJ9mfgwH2A4C6Nr7gDYoUEo9r4wBBx/X+1OmzggnTXFdTyov1/8TyJWunkRHFVPBRDwpMKDgb2HdjEPWPzPmvJ9jAnbp0idBPh3gMr1fFG/4=
Received: from MW4PR03CA0289.namprd03.prod.outlook.com (2603:10b6:303:b5::24)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 01:45:56 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::91) by MW4PR03CA0289.outlook.office365.com
 (2603:10b6:303:b5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:45:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:45:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:45:54 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:45:54 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:45:46 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 74/74] drm/amd/display: Promote DC to 3.2.407
Date: Wed, 11 Nov 2026 09:29:20 +0800
Message-ID: <20261111014100.3596072-75-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: a59909a6-492d-40ce-16f8-08df3f9586fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|261102123227099003|5023799004|11063799006|56012099006|261021123027099003|261009223027099003|261026140227099003|261022105027099003|261021121427099003|261026121527099003|261028144727099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: atlAhqhNbEQukKyp7nJYQZvmUWQWRFzIu8XUbDxvgQR3BRHFTtvOXISFbODhz8++BBqzdNXTkJDLWW9kInDz5syyCo7gGw0AZxAQYkx8Vsnw6gEjP4/tHvrX1WvuSF1hL59mI7hcBRB0oO1WsJ7VBUWhBZVrDHC6yTldb5iFvEzU75XiQD8woXb5ihiDCdf2JEvJymeVV69mhEENwbxEtTmDVDZq71pQaMMC9wHsBDG/Foa2V6/IedITw0Uecn6NSP8G6x6mTyvauUf5XnKpxFMTLqfjX4bTKn0tScKObbJUdlJ2zYDAdm8uxNutp0yK0QYyWJKHD0Pk2eQGCmobUMoqzrLTDOOmbPjFbqa6KfilHbLzgxJ04AVRMEXX57pxCI9MsWhRkBJlIfqmC1diNwUn/SoZFAkFzWu0v6KfVd7gdIA8I/bmIvwfM/pD/LtmJSL092/SOZkFKuy4iz32H5bRrMvQWLZHhQgylhZ6MZ9xghS0DXaByMNoSQcUR4XT4OfSftVRr047Y9N4nC3UBjH+7CKMap88LK3xZoUjV2oOCnBBENkrVtgroEgIqGwtBavsznbM2GjjIndnvxLmy+tcy8EktsxxL/VkKe/6hPwTgqS97KSZGouZlQOhS4X15OHcASZgRkxtkNDzVZDKC6brOJcSDmdkq5pfva9RboQgeu4FQn6TzEGoSxgWK2MpdJYpawQewsmztVdXjF6Hqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(261102123227099003)(5023799004)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261026140227099003)(261022105027099003)(261021121427099003)(261026121527099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KXm5YuC9b2ebXrBOcMCZrXi6QIRNJy736TPc7TF7cnB/0u7RGm4fKfsr1eAMIrZW+OTrU7kkVz9hTRxNir6NwHSxs2vFFqAgBO9VJH0iFzCtz1y65IG83BTCKy2kM4g6Cy4GlbJ8d3cSiP04fBCiLsYMtDywsyFwkYD1DmIEicTIHqVBGAJKPAzrKyolWCmG43jqQnqaV3MKaxbo1R4GFqLJKbefedDEufRVydDIqijjyawE48hiUSoRf0uIlkbeeH9+VcTORPpwFjyKQV9aUjDsZ0/Vv6OB2VbjyQtHJ6J2q8P9TXAGCFAMlDAKptH6U+rJOvLA/GxAlPpbif/NRYeXNYQPiZZi+k1ACYGjlQYNkETOqCTmpIwbu4l59hiLYMjLE9xI2nv/WKJbzc6ueyAc+k/ZnTvBCbUg6vxr8al55Vb7mdz7MuA7At3FhNCL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:45:55.6073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a59909a6-492d-40ce-16f8-08df3f9586fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:
- Fix KUnit tiled EDID size
- fix hubbub read state logging
- skip_lcdvdd_off for eDP link lost retrain
- Don't shrink zero-area recout in full viewport visual confirm
- panel specific wa not fall back to tmds
- Use expanded DMUB-provided SoC BB and IP caps
- Only force P-State on first plane if TTU is below WM
- Program the kept-plane scaler in DC2
- Add and remove two MPO planes in DC2
- Add DC2 state facts and split the builders
- Program DC2 commit stereo once
- Read DCN6 SOP constraints from the idle row
- Use soc_bb hostvm fraction instead of hardcoded value
- Increase state if dcfclk deep sleep needed exceeds dcfclk
- Flip dml2_core_utils_get_segment_horizontal_contiguous() Inputs
- Update DCN6 Calcs
- Add effective_number_of_dpp parameter
- Read DRAM channel width from SMU init table
- Update DCN42B stutter latency to match DCN42
- Expect VRAM|GTT for the DMUB framebuffer
- Report QoS latency bounds and request
- upsp fixes
- Limit VRAM aperture retrieval to DCN6
- Make DPP_PG_CONTROL and HUBP_PG_CONTROL BLS compliant
- Seed boot clocks to avoid lowering pre-OS display clocks
- Account for split pipe overlap in alt channel copy size
- Get OPP heads and DPP pipes by stream in dc_resource
- Program ODM 2:1 and 3:1 on one stream in DC2
- Enable Replay timing sync by default

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2dff1b271416..b71a9a5cd424 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -69,7 +69,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.406"
+#define DC_VER "3.2.407"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

