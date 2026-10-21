Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71975606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MQTYWQXM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16B5C10F95C;
	Wed, 21 Oct 2026 06:27:41 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C597110F95B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7SZz8dBmJIjyHnm2e91s7NssEmFXz9hqY3h5mrNo1xP6cHLLzLJVYlR7WpaZrsLkndIaVWA1HXZKsqwnvUqsBvXwlugm1FfMwKeiqoF5m4pNMcNh9do4fX3HzOp9NCFiwLZpizghdwXvtZRtnI7kssaM+zxIJ8NjqEnjQuwU9rNPvbm7kvdGFq4C2nzsMGneH3Gg+t1vlDGK4Yb5HNLpulM3jN/rdW4Wje0yCGKisLcc5oGNezC2N1Fv6ORBPof+5euRlXOupsiw7A46GC7qjqZDLPcRMjaKf+lOJUd31+vFV05DBbtE9zjBhqkFCuyLmK/GAAm3veAiXwAggts6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tu7Rk1Pmjrbl4U7w1v9yecYeo3HxYGG2BTC6mdzft1I=;
 b=eFZnG1ZOCwwuS3VJ7zkFtoroKM7fKCEZFmACAuPz1Tr2FtV4ZT06LCxZT6c0Ej4NyTeo7+bQe4N/6HqC18bI95sRNCI1nuy5tF3tO09m4v5TM7DauvWD2RKerxO+cQihA8CEs+gEMzBzFlSbauRTuBkmdK26WBDhDmp6/U/wnd+kgDFxAROQ1igbiJrsRoIj2+wbxCPelr6VufHutCamLtktZpFPSGfoCuvsolPGkq61ET/dCaSht4PR9wp8NfxCWtHI3f2Ved2wwk2lVKSzL4osQZPyPBxGqfFS2Ue5kk4MdqdEQ7BpU3e4W1LHDpq/i5ub6MVOpLkN0af364JEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tu7Rk1Pmjrbl4U7w1v9yecYeo3HxYGG2BTC6mdzft1I=;
 b=MQTYWQXMqXIn0AC1V/fN9/e0igJz+r2p97V6EZw4kiO2GlcPI7kkCKcutrqoQntXRoYws5uiUOo/xBiX/J88qTzkX23lN2PPpqbCprmEsWstWGZkME35HSM0D5OlOk2h7gbPpdgaT0yxmOQY15RyxNsD11obHr0ynuBOEG4DgO8=
Received: from SJ0PR03CA0351.namprd03.prod.outlook.com (2603:10b6:a03:39c::26)
 by PH8PR12MB7231.namprd12.prod.outlook.com (2603:10b6:510:225::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:27:31 +0000
Received: from SJ1PEPF000037A9.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::5e) by SJ0PR03CA0351.outlook.office365.com
 (2603:10b6:a03:39c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:27:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037A9.mail.protection.outlook.com (10.167.244.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:27:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:29 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:27:26 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 34/49] drm/amd/display: Read cursor update lock into mpcc_state
Date: Wed, 21 Oct 2026 14:22:40 +0800
Message-ID: <20261021062519.674697-35-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A9:EE_|PH8PR12MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c52295-dede-4706-195b-08df2f3c62d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gvB+of8ppT1CNnK9KBoH1s6rZojSDPge1WzMhQZouw6fYUnCJaWKa2c3oTBWsxwMMF2L0IoVW9GqxIurBuDVgtnx2/EoygWQ5A6EhNk8clsjTEENbhZ7qQ5c9p2m37FjPaYsHJc02N88QFghJJziH0En1cikHhX5dTNVOJUD5GST846OSOW5XsfoqswTpLsVFmL5HS3rrV9pfQ5Ob33A2vRSPzwEGqxwipR8HLNZaBks7M2dy/7MkVagiscGvoqohNJxCEo1GfIbBm7jyMVsLG9l8Bei3HGcJJuTqY57X3/3ZivINuW9AdzM5QI5YTRkYcC5geeeGPeZ0RNUB4jQ4CVoRgwq0QT2JcAt5V/d6t2sX+ew4LB80VWKMl1g/Zqgw+pmyGuak2q0CNE4NLVg/abQFTJH042iapIjXRYy4q8KN8QJgqBNDPfEqbG4d5W0MYIMBsceuE3iuD8NcaVwninkbuGndtHq2mhSZZqvrSmUKosh/haFaWLwd/ninS4WEZMjnN0YyEwBozBB69e36zGsuhVXJr7Os2iZxFldVnoaMczNA6wMtdIdfyhegY8YRA1ZI5eSmTxG2bWpSeGBrKkiQZhsXg2poaba9askh+kTs+lqVejZcnnWhUTyzeqSoAY7K1TSXs1IBeFTWex4ZXyphaEEN2eIDmqmUpAChN0pz1omVvzI4kPbe4cPqdB/yrknps1jzFhf+HrRBAuNrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p7v0Mi+RyICGjStE8KOm3UI1gsjRc1DfJFUdC+A6Ovk0tfVAkLDtWAjOR41toU7M544ZPLCeu5h3Qihz/eLqnx7nyomXGy16zl2tsFS/c6MdBcVuyaZE2rcpwAdlSuYtY2suG/bAhI/VJIUh0OmF2THeaCL4d3wv7+dUuI8rxL1iFQuZo+Uy86PNP2t4t4nRMWNbJXx6twoIru+c8Vdx+2TgsADQ9EqyjwJxpk8p7EGUpBWSAkPi865YK+pj86en/MwLObw5Ylm6AICeWeh4LEeynDz1Is8lEtXV28gr8WAL9BaBMuAclIwW76Jx4arJgc5pVyo5JGSIkN8SJ2CJoaHjrcXsiAtWw/Vk8gbfynWI//CC1ndA4yLZPbNlXJ0gKarD31Rus92NGRUDrUPQgklijtAtkXFWEqv0F+5QymcGOBxXnvEeaSBZ+FxxQl90
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:27:31.1294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c52295-dede-4706-195b-08df2f3c62d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7231
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

From: Tony Cheng <tony.cheng@amd.com>

DC only ever writes CUR_VUPDATE_LOCK_SET. A lock left set by a
previous owner holds cursor updates. Read it into a new
cur_vupdate_lock field of struct mpcc_state in mpc1_read_mpcc_state,
for the OPP the MPCC feeds. DCN10, DCN32 and the DCN401 family use
that reader; DCN20 and DCN30 have their own and leave it unread.

The field is printed by get_hw_state later in this series.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h          | 1 +
 drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 75ebfab87efc..a0a8ab195533 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -298,6 +298,7 @@ struct mpcc_state {
 	uint32_t overlap_only;
 	uint32_t idle;
 	uint32_t busy;
+	uint32_t cur_vupdate_lock;
 	uint32_t shaper_lut_mode;
 	uint32_t lut3d_mode;
 	uint32_t lut3d_bit_depth;
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c
index f9bd1d6e1642..a737887b7c71 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c
@@ -453,6 +453,8 @@ void mpc1_read_mpcc_state(
 			MPCC_BLND_ACTIVE_OVERLAP_ONLY, &s->overlap_only);
 	REG_GET_2(MPCC_STATUS[mpcc_inst], MPCC_IDLE, &s->idle,
 			MPCC_BUSY, &s->busy);
+	if (s->opp_id < MAX_OPP && mpc10->mpc_regs->CUR[s->opp_id])
+		REG_GET(CUR[s->opp_id], CUR_VUPDATE_LOCK_SET, &s->cur_vupdate_lock);
 }
 
 void mpc1_cursor_lock(struct mpc *mpc, int opp_id, bool lock)
-- 
2.43.0

