Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24A3C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 04:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A0D310E5CC;
	Mon, 31 Aug 2026 04:35:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lxzBH3lT";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012055.outbound.protection.outlook.com
 [40.93.195.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 711B610E25E
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 04:35:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQNVD5AfDO3UnnytPgHl5xoZ9TctLYOBRKfNnPcjPRm38fFAwy+y85eMNld3EF8t2Y+mJglbow9kNGlCtMuUJbxWWlOkIUNB1rCbhTWy91atz5M4duD6Kp947d0el8DcWpu0aHJc9J8PrjxAJ6UTwSoYSNv3rE4L+TPR2zY7boDyuYJfvq8MUotpt2JvlbAhcQVBd9Dh/lloJb4d/8oDPgoJElfZ4dFI7ajHqEWh6/5SH+4grERKsW93unBUNRqFOzXGFxa5Bt2JZ73LdgJl8XQfJGNAqsRj3rtgnMFaHVGw6ZEW3g4vCaM3iGjsb2scV6wPBIheoo+ElCjTRTjtRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Bz63I7OaijFPLRq0rK9c/qFJIfTiOiSQlbSiSNe2IY=;
 b=KrVPn3lL4ne+oPNAKXRwCAB1s4pCuC9rcwgLxfewVsJpu/0lh5vqevij8w6ateWbtE0YQl6e3GZetJQKK2G3HwwQ06Rf9BpjntrE/bPaAyLLjHdUp4ytd1vwtdPR869lHQjJMxYAIm82vwvscOH4K4Ckdbp3SENLmcv5onzyHFZs2rQomwE2B+Gz/zKbk4KP0gpVxev4H0aNFzHibgRkHrolartsBRxJ8wo0FGOXIHsc/hQxaUUKOOjQVlQ7Wm1FizaxcSOizyiA65xmnYaiPsQjNtNzruJPoNoPEBp7iTZyEKDtyiMiAPu3fJ4KXIhyZNpz3ZFlVPT9rqA1cr1zBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Bz63I7OaijFPLRq0rK9c/qFJIfTiOiSQlbSiSNe2IY=;
 b=lxzBH3lTBNRDgda/8HDGJB2x4YcY8FfZflH1mBqow0Im5Itmj1RSOLjzJcMib6FJs0j99G1LliefLhR5FeeP9DsRdMhf4oBl6hS4Jz9rpHF1GfJeif+Vu1/qfJyEcoT9FidEM9tdw26avzwPCQ2Yh76DZJ9UaMJf5aOqj8XozS8=
Received: from CH0PR03CA0110.namprd03.prod.outlook.com (2603:10b6:610:cd::25)
 by BL3PR12MB6572.namprd12.prod.outlook.com (2603:10b6:208:38f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 04:35:23 +0000
Received: from BN2PEPF0000A803.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::3d) by CH0PR03CA0110.outlook.office365.com
 (2603:10b6:610:cd::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 04:35:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A803.mail.protection.outlook.com (10.167.245.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 04:35:23 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 23:35:21 -0500
From: Kevin Wang <kevin.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 1/7] drm/amd/pm: stage od reset for smu 11.0.7
Date: Mon, 31 Aug 2026 12:35:01 +0800
Message-ID: <20260831043507.523599-2-kevin.wang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831043507.523599-1-kevin.wang@amd.com>
References: <20260831043507.523599-1-kevin.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A803:EE_|BL3PR12MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a1bf93-3f34-4ac1-19a1-08df071945b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 4M+K/QTKnBZ0X32DwMsshq6WTFb2eU3Un3qzsXqaMZ0GNh3YVTJ3FzT3NdTrL/pcZnzNb5K/pAqt0LQA0GN7l/7gTiBbT2sgw0140eSFPPrxELuqMj6I8nilORxtUHnBDS7Q1neOgyWxDz7Le23omc0EioWq6hsdx553dBejgmsWhws/sybaPbd4PJoisgnOii8TC8p9z3gs5QrVYQuVXfmUibRUET4/0gp+PvkGyGNnxeoQxSn8IlHY/fIri5OadNvse/A0fWjNPH9JjX9u+UStZmgFHcDivaHz7S1hjf1RwCAXncSYQxwpjuW+W5/K9dQN48QG8oWrS1/1AKQfgl/Ws4rxtUarCeadsxvPvyiXqAwq+oJ9tzPcCIqG+8K5v1duGhKwumpMPo7JbSLT7c6yFUTN9eWJ2IMBV62qH3rx52L1dBVHBinw1tti8azFL43u6xYLGjHXlCbxZvjHUcPcHxRf+RBiI8iy6/WcfdAVXoJtcMrpFvhunb67fZ+OvSJg5FfBrbNbQdM8lc84DqZAbI2bHYoiqT78tAt78HO7Rl2o1pC4YUsHpj5WoQSUnvsYREG1jhEZThu0FmT/IhUB31WrHee/rtJbm0d6t/lSUZ3tJve4dvritIHpwfDWHEHEPrMUoje4jpHmZf1nJDcB05d0N4SBg+PDRcxlwj3I1IF6mqeG+UIBfrmV7JhU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jyM1X9a+8/koS5ygZp1CaoaDBt9GsOAxbtdQ7PDrb4OODptZ34RqrTkYNsnDC/giX2GN1x/kXHnJhH7XQcdk6saSzljQnwUUkzv85DBFnqV7B7WzP/tvEarrCLR9ocVdkoXcfcevcV0UIufPeeYZkHUh0ftOcAGwRFVtBztfjnSqnD/Ck78FvLsSSem6vvpaO1u0AzhU42IFUyVEbvAKbJRjxouETyY2salXr6JaN9LyQsatBEQsCqQrn/SVYeQKhEEHuKy5YuYcuK7ZmL/VDioD3Xont1oLaODSeKxiiA0P/naTiuO0uIC7OofN4pYlJ10wr7eXLbAaie+TbS9ENbtQneiHLc6gkxXui0uqsQ115hXPs332hYGBX3QtXKriMLqWGFsNC27w2srfAIzNNw99PJBDejRCUh4O5JoZIqi55H3DHn5qIx5XeOC98SHt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 04:35:23.4354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a1bf93-3f34-4ac1-19a1-08df071945b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A803.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6572
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

SMU 11.0.7 restores the boot OverDrive table for
PP_OD_RESTORE_DEFAULT_TABLE, then falls through to the upload path.
The reset therefore changes PMFW state before userspace writes c.

Leave the restored table staged in the driver cache.
PP_OD_COMMIT_DPM_TABLE remains responsible for submitting it to PMFW.

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index a0f0e858e9de..e26c3e2dff23 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2387,7 +2387,7 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
 		memcpy(table_context->overdrive_table,
 				table_context->boot_overdrive_table,
 				sizeof(OverDriveTable_t));
-		fallthrough;
+		break;
 
 	case PP_OD_COMMIT_DPM_TABLE:
 		if (memcmp(od_table, table_context->user_overdrive_table, sizeof(OverDriveTable_t))) {
-- 
2.55.0

