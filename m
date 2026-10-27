Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B6B606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=We5tsbO5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29D4810F8B8;
	Tue, 27 Oct 2026 23:26:21 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D0FF10F8BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:26:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xS6NEwk4zwNVlhhBpWni1VX/gMQRoIgseeGVs6DTBky4ykOhTu5m2Uy302fJN+wJZcn8APFbjKtatq3+/EP+7Gx3SwczFUDpPO01oTZhEeXT5p29Nqw4ihmO+paShGSLRtF0R05ec+lr3BXH6G5GwPtav4/YfHzugr3sLKOolGGFWWlcO4KWFcJtSpzdVAk7K4VsTLuWF+OOg2kog0NDS7z67ooEUgAGKpJJCPmLk3iggcJQmJ+Aq8DtT2qLfQtCXAivy2ByTJ6Y8qFRxsLKdFLq/o132GVfCbyRZ5q9RlFI2t7eDbQOrkWMlVWTYsIcPTaa+ydQWSsXJFd5g+VFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9T1jsyC+/83LbNMRBKHQ/f+aQuxQZlN2rKA/54gAaMQ=;
 b=sxIjZgzxY9g/CC0cQL26FU3asMYSgRcCKwu3t7AlS4kwgCpsYktDArLOKL/xGaiqYPM+yFkFoshP1OSgTOEtlLLK6HbG6q8vaSvmZhm2Rj28MIRHHRA9/ITBqIN7AUmbLAYinEJ33F4lr0iMiTLLEgQYGJMCljygVZQctQN08QF7eVKWUZ53i/qlQWnBtp9R8emtAPDp1L9RGXc8Gh29RDflZpSl4+bqYgzDHK15ePcJFEQcs+gZyrOIzog88EABUcl4zRdm/FdSzRtpx+QMXFnoAI/3x8lkPqUhl5/fq2O5NsyWJe1RV+IR6UO/7nHWKhSaceL4Geg80XxcTEKz2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9T1jsyC+/83LbNMRBKHQ/f+aQuxQZlN2rKA/54gAaMQ=;
 b=We5tsbO5vO1+s6jNm8JyWvuu9Px6iRohYyYvPGjfQsGqYwdKljqOJWvVUupP0sKMOqL74+wmXyaRSKDXy3T8vDN4dollkKOLmOB19iMkWr6rEyySBd5N/SndBvO5aRyNl6UUqmjmkevUAuQQzskmv1KXYvaDMIwGV40e9v6CeQI=
Received: from CH5P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::20)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Tue, 27 Oct
 2026 23:26:11 +0000
Received: from CH01EPF000BE944.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::64) by CH5P221CA0004.outlook.office365.com
 (2603:10b6:610:1f2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:26:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE944.mail.protection.outlook.com (10.167.244.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:26:11 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:26:09 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 26/28] drm/amd/display: Update alt shared lib to use dynamic
 state
Date: Tue, 27 Oct 2026 17:17:22 -0600
Message-ID: <20261027232005.2879750-27-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH01EPF000BE944:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: be0e2ef7-33af-449b-603d-08df3481afb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|261021121427099003|11063799006|56012099006|261009223027099003|261022113327099003|261021123027099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: G5aX9aaHvgmFaYS7vFRykAWxeEHEjLn0uGFj5HhabaWFidHUJ4RtBbxiKR6Q8m98K7ixIapFbT0A1R2sGAWeVMNZom0MZ5INfxzt+wNHY4DgRjUIN1g6xSeS2L2QnfpDfASTIMFhyfXYMaoZGWWvghBTV8y3J39RURo0ngA2Cc38YYgGqssqV/Q7Yzj9TaQOFEUeIyudhuOE8zjS4+Mvn2pjV7Z9MraJzDpm5jRiv6J6Ypr9YRoVNysuBSHhNK+TYcLSX6DwWdJU+jtDWDywYePa15w6t9zkSGniT7MwMymUBB/11DnGZW7HII04NdUdh/afTwrXd7GdvfClt8kCslNTy5MRO8NAgqXxStsClDA0CzhfNn+Dh4WMsYH0Kw7J75dlCL9WffBfteqbsAVPW4JcwndG2RDgmp1GjuUqt9XLO+iHm8EatGFe4DNnTImQxQfVToL3PQMomSYqixAarBLqZgC9DFhFE7vi624RvWs5SI03g0vzcq3fpVeRVGOakXSmawrAtbAZN1C2ZsvingZ86frr2Y/botGjd2in2E7+78Q2dHJ3Tye1A2+Oc0o653fwh6FYA5HK11Oh5X5Exzhp3K0qSCs3xQsY7QsB7G7MYu2Jc1gNwF2JGXgxDi4QmCubP+7IK0j0nvyQYyfC9C7yplm1u9eeoO+liMeZJVjy9XW9xQnVtjekzAzXCWPzMh3IdlrBka4/4UccDSmLaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(261021121427099003)(11063799006)(56012099006)(261009223027099003)(261022113327099003)(261021123027099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WzRKCDIR0TT4ku33o8dPA/lMlR7R/oO/B6WwgB/rrHlPOMqHbQ+mnXegnno+qdvcb/e3uM9qkc16h1ZUkzPq60zjd4l4f/IKgE39FGT7XffQDc1S37SQ9qG0MRxBoBUzNQd7ZKI55EJo+kdg+1bVABv30zikbirmT3Zl56ehPA+kK9tWb3sJrFSY9dMhfbfseS9O6I5g4Q0PfLZjhx6wduC9WxF4nseO2IsEhXO23Q/kjp0tNaSVlsnjiQE8Mg337hw6QOQ899OC7lCo/zUthjIkUqJ/MIxEd4E4wwiyGm2I3/fX5SbCWZ0DaQxyW1g4PMwRBpZ2dc3bF/HmhR28zDfANub+sfzpVIieLcrqCQuNcF0J9jx/SuLXANVjM0AHrxSMAOadeZs4c1jDUWIkVjiGdh8yXaxJW2lOANgdQ+pfyE2aKsCj0gn99PDQcfUj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:26:11.2470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be0e2ef7-33af-449b-603d-08df3481afb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE944.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[WHAT]
Update to use dynamic state pipe_viewports struct instead of from
static state.

Cc: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../src/dml2_standalone_libraries/alternate_pstate_shared_lib.c | 2 +-
 .../src/dml2_standalone_libraries/alternate_pstate_shared_lib.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c
index ec2f2bdada6a..127e594561f0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c
@@ -989,7 +989,7 @@ static void populate_lsdma(
 static void populate_copy_params(struct calculate_lsdma_copy_params *p, uint8_t svp_idx, uint8_t pipe_idx)
 {
 	struct dmub_fams2_cmd_alternate_stream_static_state *state = p->alternate_static_state;
-	struct plane_pipe_rect *pipe_vp = &p->alternate_static_state->pipe_viewports[pipe_idx];
+	struct plane_pipe_rect *pipe_vp = &p->alternate_stream_dynamic_state->pipe_viewports[pipe_idx];
 
 	populate_lsdma(state, &pipe_vp->luma, &p->svp[svp_idx], p->plane_index, pipe_idx, false, &p->out[svp_idx]);
 	if (state->config[p->plane_index].bits.is_multi_planar) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.h
index 8983ea6937a6..1a3b2ff2d369 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.h
@@ -81,6 +81,7 @@ struct calculate_lsdma_copy_params {
 	/* inputs */
 	struct dmub_fams2_cmd_stream_static_base_state *base;
 	struct dmub_fams2_cmd_alternate_stream_static_state *alternate_static_state;
+	struct dmub_fams2_alternate_stream_dynamic_state *alternate_stream_dynamic_state;
 	uint8_t plane_index;
 	struct svp_params svp[2]; // array of 2 for svp0 and svp1
 	struct svp_params svp_c[2]; // array of 2 for svp0 and svp1
-- 
2.53.0

