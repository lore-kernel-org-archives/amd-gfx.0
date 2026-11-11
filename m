Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20296606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gUluwFwr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E6F10F8DD;
	Wed, 11 Nov 2026 01:43:30 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010023.outbound.protection.outlook.com
 [52.101.193.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB6CA10F8DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:43:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXkLAnvaa0wXsHrZQQKfTHtWW9hf86gx0QvMxai/uGvZSFd2bwEQsCFdB6u6PchEq67Ve3LzWPlIhdDPL9AZ+rXgIk57P0ZpLyCL/3PTmqlUiTapgTL5yK9pawPW3XFtq4nI8d+tptaPq/NDPiTzY4P6vbH/eKxm/bfC2+yO4ZFQ5y0dxVe++gelSf+6AMOnEiuRlCAJHbG5zHhwj0euvVPamOP5NwpC+geXQraHmzagOc4rCN21+JdW5sTvT6iutmfMK4hec80DhVDZoncMGU8AcL6i3lWZCXx/rMCP4lTn5uB0+8OA4o/RbgO1jzEoQ4xutR5XHV8gsSNrXw899w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8nGStFzmITzpWz//ApNne5OGgeS63Lo2UAdTVlvdKw=;
 b=ZF1h4Rc6ol/pApGVJiCHchE7c+ae9g2EUoOJx/oXEhEPRfHC4KzR/X/MzhYNnFJr661IeqPj46XaPvcpnRrHqKsBidAme6My7/aoscfZd0+mLbNZ+FWGoDjHMC9yB24GlTCqWEnagbiABKI1vTIW7Y1XDohTWKVc6rbM36ELnoLso+T0jHCo4VmlzQAfAvJuDrxjY5bwMDVIcZGOj+FwTb06+p7NNYy3+QrKjpvCxE0nw95YortU42pJPtG3JExWY6lQLU8rUkt2KkOV9jLu6Ws9jah7XONjrOW//eW2uckdkGT/utq0q1shvmpaJBBVjHXTQikRaP71Vh0O8T3Ybw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8nGStFzmITzpWz//ApNne5OGgeS63Lo2UAdTVlvdKw=;
 b=gUluwFwrth0osadRduK7e693HC1aj5gaAvwvw2Tkt+a0rnknk4qTbw/G43eY9n8rVy+D3y9MqZJGLUs4QKh1IT/Q0a0svf5gMKsvGUHBQF/KvGro5MxVm4OqJanjnfbxYvmOCBrFD7hPWwye9fvNpV7CauB4BmYHh42rCOWc7mw=
Received: from BN1PR10CA0030.namprd10.prod.outlook.com (2603:10b6:408:e0::35)
 by LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 01:43:19 +0000
Received: from BN2PEPF0000A802.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::44) by BN1PR10CA0030.outlook.office365.com
 (2603:10b6:408:e0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:43:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A802.mail.protection.outlook.com (10.167.245.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:43:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:19 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:43:15 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Karen Chen <Karen.Chen@amd.com>, Ovidiu Bunea
 <ovidiu.bunea@amd.com>
Subject: [PATCH 45/74] drm/amd/display: fix hubbub read state logging
Date: Wed, 11 Nov 2026 09:28:51 +0800
Message-ID: <20261111014100.3596072-46-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A802:EE_|LV3PR12MB9235:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b2cb0c-7cf1-4580-98df-08df3f952a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|56012099006|261009223027099003|11063799006|261021121427099003|261021123027099003|261102123227099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: phr85iJdGHSNckkoPNsVi7/2V+CMyCmWOF8Wkpkto+/AEwfjD67FYXTrB3lWpsXvQUdNAphuBOtS5fjonnYMpom7Ai7A+rpGPL56RQTHlG3z7Bmuimv0PwS584rERI+0ptOl8TJD3i7TETcvDc5vDOG2YFq/wBIcT7t7mYBShFYyl+uRo38pVwu8m8T2rt3eHA5jzW4WAxRQ1E1FzzpQY/Kq6pR43irScxl0dRbTg/R84z+I3ZYm5d51lfjQxQQcXMtldAdyKiY4wzNuA8SJvokx9+Uz7xcxsyY0+jBOC/dWTMm3oIsMO+TZAr2AzyxxFv6i0VrXYqhJewXqMdfeHXRqczdPpAIbEwsAsIbfH0DtdEqAVp727KLXmrsTDtPa8iYsTtgAxZZw8cmQi76a8zCCqNq23syU8/u9fv/edmOH2QnD3zEQXF5wTh8yR2BZZLDGq94Twn3MWVDS5stgiiUhIRfzSU1i/T9ISvODsL8owTetQlvA5rBTEnWLjX2ZhmQRLjDuak6k4lGg8Vx8yucTZfZcM++peesShAcv/1zDkJTOb5EG5jZp3C73v9NlDda/ED9GFMdi0Lvdbz/ox1R+x8WMmdd5rLNERwFLitQGIceP62/hPjDBD0f5+/z+EzsuY9EsN0/VRcN8Nj7NxjV6cY9D3+DvGSaoj/vPqxDZNNl64dBx/n/UGXcUGz8LpPuc0j6NjVVdtvSvU71LEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(56012099006)(261009223027099003)(11063799006)(261021121427099003)(261021123027099003)(261102123227099003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l9Xhpnyl46XrFU1GXoGsI0U4gUbcTCli7efUZQ0wOzdZqj5n00Vc4/m3Y4trm0v++lMqZqRB2QYvYzBvEyWILrp6bY61lIbPlCdRarWn1pR/U/rLBWNyWQCB5jBWoxk+04ZHtddWJBX6+M/dl6apWrJVwM4PkgmvSHfj1PuSUZKpc+avufnmSB2EOF10gQSO2ZSoxQUz/4sM0CAIgbbwhIY/nSpr9E+kN8jLI9fDhfDGU0OXGUx9eZPr1AaXUpdSFz566L60xvjrCsp4fve8jSLPIAxdZPKCZh3yxfAv5jpjtuYzA7HKeXnmCGbypPFgXkTvp19kSGf2Ko6Wq7c+nVm8IdPIUCJdEua+agqFhVBosn6hA1Lk1t3d2FSWk//Y2xX1elD6/byUGSfIO3Ih5Yj1Jryzblg5dgEE6eh5DIIEmY12E7EGGTYJbpQk8JEl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:43:19.7415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b2cb0c-7cf1-4580-98df-08df3f952a09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A802.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235
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

From: Karen Chen <Karen.Chen@amd.com>

[how & why]
In function hubbub2_read_state, it stores the LSB
into the MSB field and never fills vm_fault_addr_lsb.

Cc: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Karen Chen <Karen.Chen@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
index 46e43a51ab22..464fc5924a56 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
@@ -634,7 +634,7 @@ void hubbub2_read_state(struct hubbub *hubbub, struct dcn_hubbub_state *hubbub_s
 		hubbub_state->vm_fault_addr_msb = REG_READ(DCN_VM_FAULT_ADDR_MSB);
 
 	if (REG(DCN_VM_FAULT_ADDR_LSB))
-		hubbub_state->vm_fault_addr_msb = REG_READ(DCN_VM_FAULT_ADDR_LSB);
+		hubbub_state->vm_fault_addr_lsb = REG_READ(DCN_VM_FAULT_ADDR_LSB);
 
 	if (REG(DCN_VM_FAULT_CNTL))
 		REG_GET(DCN_VM_FAULT_CNTL, DCN_VM_ERROR_STATUS_MODE, &hubbub_state->vm_error_mode);
-- 
2.43.0

