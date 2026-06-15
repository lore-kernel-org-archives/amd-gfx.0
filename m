Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA6ECD98E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3303D10E753;
	Mon, 15 Jun 2026 23:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IFnUpIls";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59DF110E70C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwLMJSzLFtjYd4rDDq5lp1I4VGaqKdRNYkWZDafA/+xrUZPS6B07QFuxJtpxBIC74A8XBebElAggtGA4kp1Jz79PBo0DRjoBUZYCI9SM/HD5RtMw90IqxgycRfFVAdR5kcwOF8O74vnfrjum0bmW0ctotoMSKhoG2yqnzMH1UGs01YuSTmozfmuH+tkarsrnfQJxP5XJmIwGsn9VEZxJ7642eKTflaAZ/9r5zuVdLT0kTvRt5BeY/q6A1mq5SdEaCNNhn1Hrd1/cEqPFRtX3tiFUs0t0GAF519BKW3PtUaHpRoaLK76wxVGCvX6p4J1XAaQiKixHjI0dCd4M6PvGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuJBg97kdE9o+/UOWND0FxTf2NaBtTXgEnbTlB5Jcqc=;
 b=CKv2zBzVhmlRBLVsGngtYGpi+Z5EEFOp53xc/FQfU4zbkR153jIynxCHlGhHGKvlCtCqEQg+YTMKTnY05WtjGoXhCN+Uapw1cDrz6S004ZocAFUEzX2P4Cl8XrM4KUb3oArREfOeAh/tzqeG5mSVyePYAtaUpKoE2FLxzHcwnaPdd5jOBqVUS9brxMAHWuHb4zBe9zy+3BftY1PwPgVLK2FQsYeuwfn29bUD+ZMJQhFBLcqDjDFfUkbd5J+FEXpqS4nuZ0ImOyKAjNuB7ptyNbwJPsGU2e1zqV6qIS3vbkuLbaubhjR1MuAiOnhpzLkENfwsFG1LeOvWrrpl6LXvcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuJBg97kdE9o+/UOWND0FxTf2NaBtTXgEnbTlB5Jcqc=;
 b=IFnUpIlsBaEDHdxjBlTBr7SBbD2iN4rboYbxsGpvMWu8gFyn8Rwpa4qDj+4nndvKu2RF/sGLeRQo/1KppV5gmA7KS0ICfNbrXoIJ6beG8Vu65i/1rNjnJHbqSY3jssNJcUHURC5mkD410GGSbkJSKM3laIzFOSHWrNaPbdxitMw=
Received: from CH0PR03CA0062.namprd03.prod.outlook.com (2603:10b6:610:cc::7)
 by IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:05 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::85) by CH0PR03CA0062.outlook.office365.com
 (2603:10b6:610:cc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:57:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:00 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:00 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/43] drm/amdgpu/gfx12: WARN() rather than BUG() for invalid
 SDMA engine
Date: Mon, 15 Jun 2026 19:56:18 -0400
Message-ID: <20260615235645.737189-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: ccaa8d4e-e597-49f9-cf91-08decb39cb01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 0AthuDbFERia01LFyXtDInR5BHCT0Mx3E1RYnnOMsHsJsu0p3JdjRU01IrF1iOdmHCJQKBK3VmDk0cpzKCf7bfxB/dHVXMwYyiwvaX7TMFKB57kPL9xu5JnLHN+MDvvHX20sK6KfUOjZx3vv0GrLEWifX/rbETvlc2DgXj22EBTpts4iSw/A7f2ljsvFL4OvJ8eumYQNcfTK63nNXDJm2B/g5T+bhjmwJRYmLVcHMWWpYpGxkrVdILSB65fkoe0wBqsfnWUrztLIOHjYl5oXnExzkmTSAUVr2V5leoUAi9kXpQxJ8u7bLm6jMgSLXpIQSOHehQAHMfqULDqlM9JsjpUL57GKv07Zs4iKnmdh9IlKb8d1KoDwBmE9X2Sxgs7Ga6GB9n51xePmZVVf5W+0Vu5GTol6/5pP8rOG0SM4jv47nw/+QD0vtHFHuw3f6aUVWk2JihnsXFqKdZg2k2rC1Kv6umPkwryhTvwexT8V0onetA2m0hxyJirhHe8CmgrF7VBom+EfvX6rqHnNl8EAUem+6KCyhox3XG+Sn6t5h/0EKgp1u2iNIgc3CPqIyLph5JaysHW4iykNtCoaeU5uanFR5v6n4mNXM+maZ21fozxrqSPWr/mC/XD103jRlvYp98af/YgPFxB5O5X6AhioDYJBlseYbDd49wrnXqnK3NSXKBs82JIIdbm5zEOCA8ltwpxMqUWIPd5ywwCYWcPNEGfxJYhuxhwADmmhEOuzQLk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5PsxJQdud0gH4yBwEigosq6SIRrVTCdh/OUSFwTYoemL0zBapym2sQgnWdbUEkrwKxpsZ+oxXCUGbtSQYE8u9naPwUCccBc2g9chzmzla5cVuqE+cwBPQ0b1B5TABubu430sgz1rZeshXa9zoKr6KkxR2Hg1UzG0AClY8BAgJViptli5yuk7kN4Bf6ao+Xm57gmCUxMNrC1aCyqE2yrPsyhvuzWS3kTgtP7RwFJAe+tBg+LA1Q1PGgpDi7qXmMNYVOhcP+cX7iuhc03b5IWjnvyQHvXZTqi/S8WhK/44xQITdsfYIENdrnoOZosD1A2jy15WEItHLiRNqWmG/LWhIjSRdvFwuGKSDrAGDEeG6euRi2JbKXJ/u+229cKCyX+KEIbLGfULS9U3uXPXvXSaScDonlaep1EpYrzpK0IQoV1Yvpgwbx5qCPiFvACsE4A8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:01.2132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccaa8d4e-e597-49f9-cf91-08decb39cb01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
index e0ceab400b2da..f37d51ed9a6b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
@@ -90,7 +90,8 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
 				regSDMA1_QUEUE0_RB_CNTL) - regSDMA0_QUEUE0_RB_CNTL;
 		break;
 	default:
-		BUG();
+		WARN(1, "Invalid SDMA engine id %d\n", engine_id);
+		break;
 	}
 
 	sdma_rlc_reg_offset = sdma_engine_reg_base
-- 
2.54.0

