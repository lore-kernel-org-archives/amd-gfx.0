Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB16606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iIwqF1pC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9C3910F8CC;
	Tue, 27 Oct 2026 23:26:38 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012050.outbound.protection.outlook.com
 [40.93.195.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE4C10F8BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:26:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLMLxN33Jd6qeq5XfBAdvnaTD1NheRzC+H9VT3A2vPXX0zn85wXmmZuCppY7qVBTSXVJuX+370LKCjNclUOdXRUD13yFR4NS+vPE2SZDGajyeBmneYjDgGkIvYn/Gr+A/jBNm+AYlj5XjEt5OD+/cqL/wbQ0e3zKtHR6nXw+jft1vinGZ29tswkZcJkiR1LyqKTjeZ+S+3mk6xxPdLF3rW006JUmsbxcMyXrdTGTsTd/h1H6VdKVRh6Fh5s2V3eTjVai60D2i/qFUEDpGR2pDQSK7nzfpFmPDU4NiIXDqFrLo4fX3LczsbUFwxBYTwMkTrIvzuUq89ptBJiX3uks4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6Nw4bfR6I1BM9oke/zg/haQNX/j5a+ht5LNAc/IqGg=;
 b=UQD8UvNxAiKv/6uX/BQFsy0eqpaZMYIUjcBvDNVtHXDdNfCcUCDPlJFP9tAuZMq9PsVvWGKSSVdsVQhaOfVrv701uqYDqcc+9mxNeL4ZMiPvIPuuFCcnnKJM4hfYQAaOOAq7Zutik8DGYmDpXNMHCoCYbdbdrb0vTnbXiaeDlWEXoHIrCJ33Dj71jb4WyQ49SD6Y/pUxckPAci9PwY+MFXKydFHjM7ezPgSgo8fyD4VK0LlYy9TlFnnuWACLn/eZ+AeqNqtK/WkLoxOPkj/Xp4F6tixwvKE0ywDheCAUPpInw41YoTVJEwYOJ5mrehAcFGwVfwcFCCSZXb5wmaSoEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6Nw4bfR6I1BM9oke/zg/haQNX/j5a+ht5LNAc/IqGg=;
 b=iIwqF1pCBVFnlktJkVCmZ8qwfufOjNdPpXy82t2ofQ2B6Xbd1HAKuxo2ndIsqAShhVjCWjkZ/TU4xHLbmjlB4F6SmDSINiQaqu2c7mnEtk1VRoQTjIr162GL/y7WmgJ2bpy0x6gGJnHjsuDbC0XB4ihsOhuzuxFfICs2KmoXh0E=
Received: from CH2PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:59::11)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:24:26 +0000
Received: from CH01EPF000BE942.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::47) by CH2PR03CA0001.outlook.office365.com
 (2603:10b6:610:59::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:24:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE942.mail.protection.outlook.com (10.167.244.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:24:26 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:24:24 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Shen <george.shen@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 18/28] drm/amd/display: Skip dsc sequence for stream if dpms
 off
Date: Tue, 27 Oct 2026 17:17:14 -0600
Message-ID: <20261027232005.2879750-19-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH01EPF000BE942:EE_|MN2PR12MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff4d916-3ace-458f-e6a5-08df3481713b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|261009223027099003|261021121427099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: hK4x4m6iyncu7YL//lUXYXjcm4PcuFL4YHGfzdZBH30Pm3+UYNwgv0E1s5l0I0GuygQhMafQpi3gyW7I5JhmGIYEVIb5U40laxPHdy79JWAiOlCxjABnxBZOvMK5enOHJ2ntV+mqGR3YQVomLZCEkwYf+Xan6e5A4AxeVUFOVjqez+AfRPrkg2R6h6A7T/Ix5A37C0Clpol2h5YO24byAS+43pWmcofNdUrFDEhfwDkOEdpCyrYETt1P3hI0u3O6K8ny66TLEfplYqdvOUEdwfyGtIdPYdRoF3tKqOz52E7r1JJCJRaJl7VjQr8c0NagBk8NfClLDf87K87AFJ33TkAKgtwj1wj3VhAWH7SmI38OhFNxxyXRRdDevfhXAcpe8s1taHMJAoIU7weUEHVmaFbKmA33UlqV8DTaYnQOcdgDZPcwApF8fx3FgUxMkrnCG0IsrBYg+XIn+guuE5DdIs0NGVwfZQLFpaD+PmBwvBJ0iOnqCvfFEs4ceb4rpUVAng6a+TwvPx21GXksIxi+ihNkoEYlOo3IJF1HbTqKQJvw7SIAVdgAs8sbezXsPyrkV1yAsZy2L/4owhHJ5KJUwQumH/xSR71cLfBfAMAx39VLoSlFWhGz830KVifFO2cBNA+hruoKyutwsQSr5W+IbR2XudBaAalMWRcsfHNq1V4fLeUFkrqVnuyx4IjKoFiOyqdoicbK9zeB3JIEzm90JQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(261009223027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3wNaYVFNYiTdLy6Pkui6vLhInwy6kPMlqD38RwsR5LY67XLQV58QHdi3V6f0vczcNBbWnVPOfsmVQfHQNFa/lg+CBPRP9nf1PK9aOw732NdZIg7FRFZ/ireMJeHAkbOa9vVaCSUpfbwuY/SrvlbYEAJHxlbliZOPpb89eVi/CwW7b1PV26XIRU+aWb1yUmed0f7dHVeMSRmhsD18Ptq/dAIrnos/QvfV2DSaG2tmFcTEkno0TA16ucG8S3zeC2TxEnOd+Ge37SV0Sjpqkt/5UKGMOI26bD1FKMVjqKVRqjWs7FVwk08VuTitSK7I2krIQf+8dcNXO47NRXr9/Qu+CMHiZVYtdocsToCxj8uUPiGvRDNJGxTnGYGCKogwm2l5M4LTf7zH8nKOr48SqpgyWOWw0ELFzmoq8BpiKOsVT/MSOrk8FPWWK8meTolPGvh3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:24:26.4504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff4d916-3ace-458f-e6a5-08df3481713b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE942.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
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

From: George Shen <george.shen@amd.com>

[WHY]
For previous ASICs, the DSC update sequence was skipped if DSC was not
already previously enabled for the OTG instance (done by checking the
DSCRM_DSC_FORWARD_EN bit in HW). This was done because DSC does not get
reset if the DSC enabled stream was not powered on (DPMS on), resulting
in stale DSC-enabled register state.

This logic is missing from the initial porting of the hw sequencer logic
into the new block sequence building style.

[HOW]
The legacy method of reading the DSCRM HW register requires a hwss
operation, which becomes cumbersome when trying to skip subsequent DSC
programming operations. Instead, check the stream DPMS state in SW and
skip adding the DSC programming operations to the sequence if DPMS is
off.

Cc: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 88262cf86598..694c425e22b4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -6269,6 +6269,14 @@ bool hwss_add_dsc_sequence_for_stream(struct block_sequence_state *seq_state,
 	dsc = top_pipe->stream_res.dsc;
 	stream = top_pipe->stream;
 
+	/* In some timing-sensitive sequences, the stream may be reset before
+	 * powered on (DPMS on). This will cause DSC disablement to be skipped.
+	 * Thus, we should skip the DSC sequence if the stream is powered off.
+	 * DSC should be programmed at some later point when the stream is powered on.
+	 */
+	if (stream->dpms_off)
+		return false;
+
 	if (stream->ctx && stream->ctx->dc && stream->ctx->dc->res_pool)
 		dccg = stream->ctx->dc->res_pool->dccg;
 
-- 
2.53.0

