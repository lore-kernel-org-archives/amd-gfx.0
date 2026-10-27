Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1796D606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Eanpammk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC24710F8BB;
	Tue, 27 Oct 2026 23:26:47 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013037.outbound.protection.outlook.com
 [40.93.196.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A44310F8BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:26:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/C4z+LlghygPdZZ2APHIAbarjgMnWRCQvocQS2qtHHt3Sw7vZNbFUiQkaosPRoxusS5sypTu8crNDImilNLAYuCiOMaCSuowC40UnZzBdoB8N5P01j+6Ns9N8nbNwQXyoEBC5GntOkqX/sMYz497yDzgDEH/uNa2Q6hHWJ9NW58000iE7jC1SeePrX8JrXNMm6tWKsaNqkKwYQiqD7zOznNEeWLcFI6cGHbFn2raw3xwF3/NGVpcJVfCpPOx7T43X0vuV8IuYx2q/P6bOaERb0LJKSplQ8XA4nx5JIYeNw5ZkblRM+qMVAIeKKm0/rig8Jy/T0k0XLoCqXaLkPJDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZmdzDIskf6ELUl3JRs4ROQJmKuo3HDRZ0C24l/4kwE=;
 b=ducQtTQfkoYfaYu7SwtAVrQq/tVcozHOXliqT2H85qzGuShojgjAhkPDGzCiyAWq7xUB0NdSWlkddrJJ6NS/AiNXMTkPckEZ5MmU5ez/ptwJ6FaalVD+7PYRfqNWf54h9upv9VTVTS3k8I1tafBeZwGpNLTk0Bg7U17cq96KBUF0mU8gnOJCCpavBij3LiMF0PEuVPnXRAXGHXY8gxrKrUZgp1wnS8huITtqIQAlrQNb7on8GxtQJ6hVdVUEmyLfP0h6EiikIj5d6u9Wvjf5mpaIRT5QSd4dGKzXaz3FX2hTjS2TLwq9qkAooMpyf5KWx2/I37bipP/65SskjzlcKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZmdzDIskf6ELUl3JRs4ROQJmKuo3HDRZ0C24l/4kwE=;
 b=Eanpammk9MTlDgk00rEcU4+p/zgrsEQ/dbHyKS6hj7PaXadLk1Zy38GGw8W07RPhcl+5MOF70hD4po1LbqTo8rusWPlshXMXkFe0q2snJCbTgTx5uZga9QAAfgt55qV+dr4eCDDRAf4ogg46r2UDlJsg8TJEVNbvKqiebV6nL3w=
Received: from CH0PR03CA0105.namprd03.prod.outlook.com (2603:10b6:610:cd::20)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:26:37 +0000
Received: from CH01EPF000BE947.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::98) by CH0PR03CA0105.outlook.office365.com
 (2603:10b6:610:cd::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:26:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE947.mail.protection.outlook.com (10.167.244.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:26:37 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:26:35 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 28/28] drm/amd/display: Promote DC to 3.2.405
Date: Tue, 27 Oct 2026 17:17:24 -0600
Message-ID: <20261027232005.2879750-29-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE947:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b2cf98-3f03-4ed0-c0a1-08df3481bf2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|11063799006|56012099006|261021121427099003|261009223027099003|261022105027099003|261021123027099003|10067099003|18092099006|10086099003|22082099003|18002099003|3023799007|261026140227099003;
X-Microsoft-Antispam-Message-Info: bJWJia46RWETYIVYfW0Xl/JeLm9L8O4dJ+CceOsLzoWVC46Upm2FpC/klRIgkV5Xfu5lkZk9vCYtbZR1s6YJYHKbkyBCxF3wi3u0WMsehNQ9q7PJQhny9kCUhybY4/0lSxDYolu2C6JtjyOCOOBBfkj8I1cBl5xyybILFu+3V/I9bKaIgSsMrEiL4jZD35u1Ol+VRT+19uUZVhQ+47Mx7K6av2xBkU0ExRItG04aGOgOEKpKHjlQa9jCC71CEq7SeMWmmdDP+8vDLnjYD/4gvutebeRcILpvxUdDkhco+8DS23LGTchZ4OQMuYHwcr8RFIjpFz5wmkZMayybKbtWs2gPzLkaO3kV46bGIkuSscf3jk9C/SXM4p/w/a1Ie4t8iD1pwqeJsWosu/3hO7wynp/EkfRkDqTLzWr+Wftr5xS4ngkYZQZraasot6Kd5NuKicKPC3tulBLVwEKoL8d71VgPR8maYtNVEI3FFcbwKTm4LRoETIl6pNgejfYizjYOL7HR8UQfCYmbpPwJDgtzZ+UwNTHLIyM26fmxVX8U0BHqylvtjpqMGuy1JIn9LHl2VUWumoq/Jvno4ua6TVNJVy7ZKJaWTtKmaVGNbPQvfCHthqBB9qBqjGvgruc5+sZJWqkgKgv4WWwzzKHtSHD+tzAuCamGbA1BF+/HLuz7ipu8Hve/ceUZPjWwfSPS9N8l4ly1S+a53Z/Dl6ZCzeSR7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261022105027099003)(261021123027099003)(10067099003)(18092099006)(10086099003)(22082099003)(18002099003)(3023799007)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eUSIXMSRn6PoWwYgL4k7wXa52nmmq9O6w1XSg8JUjjZ4jDQDr3KQY8cfje3sNaZ4Y4QBDSx98G8Q7F96jquuzn2gCX6IdSswM0kjs2kXvkMkhUnIFG3Je2xiCTOrdcUKfn1M+Zh3cr3ssVwbS08ATT3vHD/j9rQDSPPRjFrk1FUXottU3DWFUnfzuYZepBN8zs0EgB60AV8qxOb2Pd3RADqa7yCzUOHHizCqa6TrLZ+XbU01bGUw113m2kByF/E9HU91oGHyvvd8iDvwPkD15m6X4swZefnvl8YrHxWVeeh2ibCmffs3gDGWdDYpSFoo//q9hnjPr/uDp8eToL1Dhk6+7EhFPXEFzGLgJCJ++drtgUc7k7kuTzG2h7bl2iBy810MydXJOlArojl6dcD7dmC6uD0JnYgIIh9+DPYDkZTheigFC2IvOcvRt/59H12V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:26:37.2021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b2cf98-3f03-4ed0-c0a1-08df3481bf2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE947.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:
 - Decouple FAMS2 config update from dc/dc_state and add a BLS opcode.
 - Enable immediate restore for FAMS on DCN6 and indicate wait_resp
   based on FAMS in the disable path.
 - Configure alternate-channel apertures and update the alt shared lib
   to use dynamic state.
 - Parameterize the FCLK/PPT/Temp Read P-State optimizer and update
   rounding for VM stage groups.
 - Remove DCN401 RDPCS PHY state reads.
 - Adjust DSC slice calc. policy and expand DSCCLK support check.
 - Skip DSC sequence for stream if DPMS is off.
 - Reset DET of HUBPs without a plane before outstanding updates.
 - Add missing OTG_CRC1 reg/mask entries for DCN3.1.2 and DCN3.1.4.
 - Add debugfs override for HDMI VRR and fix unadvertised mode
   detection.
 - Support replay frame update interval and allow bypassing the
   link_off_frame_count check in replay debug mode.
 - Avoid closing unowned DDC pins.
 - Add visual confirm full viewport debug option.
 - Use DCN6 driver_if for PPCLK_e enum.
 - Add more backlight, color, CRC and connector KUnit tests.
 - Various cleanups.

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index fa4c142ac271..2715ffc4fbc2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -69,7 +69,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.404"
+#define DC_VER "3.2.405"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.53.0

