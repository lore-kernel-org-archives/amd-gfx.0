Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E0DC83F34
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2655510E331;
	Tue, 22 Jul 2025 22:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OrCUS09I";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9994510E331
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuTxbC5RjSTSaYVnu4F+sLqEdJjoPiYFhbpEnYFHY7zOMnRdoelcPc8QjMRN/8tfyp+iIzUkm0ej8Ys752CKbl/N7wqqouA6uy2YaOujetoQ3T3lgxtONLMc4EkVEAk/ZZFjPFPoMADV35axcZCU3nOl1PyZ7sO3kqqsn818OA7LMlPNIOAge68KHyOVwGn0cjDi0pzd+jA6Myc4/Idx21SjXaPzl/Ozy39zpYN1tzh4P8bg4/rTNnZyY1FSwSdCn20BXiI8lPyOZQJvtw7uUqQzcWyjFXeULC91dfqZbScM45p3rbjrRpg5UHtdMwp8FLRUGu65J0fNS4On2TMWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jp3360fgUOfIOXh28qkENIozyDE2b+QE8XmkOL7kVPM=;
 b=dwxJta/sPiH2Xs8RhOqSNZd+SRgpfXSD8Tg0mkTKYqiytMZLkCf/lIJuqCsoIpXMqPz/o+ISONxbMAiI+o7y8iMGo+nW2qhAEERkBXZt5SkkDGEs2zPbeIKJv6cZzFdJMXEoq6lZQGNfDBtTagxzm7pDVYcjwzHZ5UhLilop/AEKfD/CDEsHHMJvfbK2gxiBl1RSmkd0uRaNABwW+9iNPZ07C0OJk29aEdqPWs4JgP2jSvHAPiFOGJKua/kQ1riLJMPzUrDZ6+Vq5y3nW+P0VbMo101LmZCGB+Ms6iM3NAk+8ODGpYDhR5ZlWWLG4W+0HbkxAyLA8eKmmN0aJqQMpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jp3360fgUOfIOXh28qkENIozyDE2b+QE8XmkOL7kVPM=;
 b=OrCUS09IZmEiw3ijR9Gkj2gQBNAiSEAImAu8609hSK8pemEjwdhDM39GLJdtuHtGGQZw98/ibhgg5iqmHfJqakCg7gAhYkXphy1LsaMCcQV/gqgZAGKuxfZKrz2hu/3BXV8gYtoqbKRRGGbc7iDlGuK13pXliUy6F3Bn3o7CAq0=
Received: from MN2PR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:c0::37)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 22:39:22 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::fd) by MN2PR05CA0024.outlook.office365.com
 (2603:10b6:208:c0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 22:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:39:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:39:16 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:39:16 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Alvin Lee
 <Alvin.Lee2@amd.com>, Jun Lei <jun.lei@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 03/25] drm/amd/display: Add comma to last entry of enum for
 consistency
Date: Tue, 22 Jul 2025 18:36:09 -0400
Message-ID: <20250722223911.2655505-4-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
References: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|CH2PR12MB4087:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c85022-b4b3-4eac-b7b4-08ddc9709a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XNFzqrrr3nkAOJDH3y2VO/xSL6V6AAUEyoHS/OSq/B12SsUfFvdbFYFLJMZV?=
 =?us-ascii?Q?9+yc1GeqLkxJsNy48hrf39oZVy6JHIpgXoY4nd1tiG4HwXrnWUIpsu8FLF5U?=
 =?us-ascii?Q?COMfDmXHVqDcSZfBUiFPoDDg7u6MjRrJi1S2utEfcynOsI6fvufFzwd7F1p6?=
 =?us-ascii?Q?7F82BoZiDecEQzG6UQFuUcHELaykYPDbcsp9FH+1sZDlOQYvqDCqnCCuD/JU?=
 =?us-ascii?Q?USPfUePeLgA5NTAa3QDFYC7eovW+m03qKho8ehdqn9gNr9OfhJ4x1c1GoTto?=
 =?us-ascii?Q?gxP6ot29uxNCdx4oPN7ngcJG+/jLbaxPuTyqDSmXTX/rOBvmUdf5iMljveoc?=
 =?us-ascii?Q?nDNL+cjV+VL70C7yE0/U2V0iZr6whmAZAStjeQDGMg2XYOc6wcEcS0kF+f1P?=
 =?us-ascii?Q?DTONnxA/VuRDN8H1LLNdK7OsNbVY2Xy6m721IfGqJOMqv8mbtvFPxpMBljYy?=
 =?us-ascii?Q?LknUya39Jxk8crM4Dvypcv+/uFYSUmHYUpFf2Hc9x69nsGlmC/eV4kKyq+BU?=
 =?us-ascii?Q?8DD5UKBNoBDCuAzUa/GzhZoJJG7/raU+E8+4bfcmpUon9tkmfYWtCtQsVcKV?=
 =?us-ascii?Q?HvHKfLQ9FVo39Hh65Oeb7zRcaw2PS72KVHKjMH+b0b9K334RlfgIFnAMJ84D?=
 =?us-ascii?Q?soD4sC2NjttvRy86U1kU1WaANdUXNW3AcZk7kLNo/uoflbVmlh5cTb0/Ixmh?=
 =?us-ascii?Q?6uV7mAZLJH0+pfdAh0YXSuu2l0gu5nn18q449B3mE2VtR9/7YmKhrqeB06Rp?=
 =?us-ascii?Q?u/ppyb88IYOlTHBBlr+oiJKAixlVgvgx5xuH2C2IDHNQt6sIGH/vvneUkKmn?=
 =?us-ascii?Q?87FzKrwhZhC7KBZfDP1ERcTe7GSMg9aFBrqijx/3fdm3FugaAz1es33OnGq2?=
 =?us-ascii?Q?LsPWlzbDteDrj8s6rKdvKM1W+JMisHHW5wl8Viy0wP6f5+TMJTc1bGXLPsPo?=
 =?us-ascii?Q?0o2eZ+7idsBIiV06pN/ZGQezJYWZgTRTsydpfUXkPOccBqOsdnGzCSRDwi+6?=
 =?us-ascii?Q?/J+Duw7VxS/6XqhUiz/rTTqmK1YP84UU69pQsgTVHsg+6sWR+CYOocwSGAkp?=
 =?us-ascii?Q?fIDacj9m+KqqXGCLjzl2hgJDEoWsQsDzJXlFzBq4UB8pnZFnnDKvETjgJO9v?=
 =?us-ascii?Q?Uxpikn5BPsVWOdaFQVAfZ2WGd+9t4teHZ4iZ85+O1E6HjvlgbeZyxW7PI2Pk?=
 =?us-ascii?Q?SrDDvtyxUZX8/8icwK1y5QvqTy5uPMLRlLKJWpVxwhTRr/s/Waq6POoSxGJA?=
 =?us-ascii?Q?qvKxYu1ku8qczrtxFdnAispABvugVnTFUQHWt3ymVaJ6YhBP+G9u+48dWaTT?=
 =?us-ascii?Q?1MJWiPw6ichvMgcmQ7u0tIY6W0hl5b7aSYONJ4fN4+1gAj60hyteb8Lw8hTI?=
 =?us-ascii?Q?5bFfjwRStOfSWIgklaV+hmriYuN5Xkn0Y3fEId6jpGMr6rvGU5gs01VSfoBx?=
 =?us-ascii?Q?BX8DTNux/ia+vWZVOYV1+f/lTtKYGheiJDAMZ9rLEL3yaK7cKGcje/pN+/NU?=
 =?us-ascii?Q?AbQ+tZql2QeVHTopR/fTpqTfK3cUXGkg9yAf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:39:22.1365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c85022-b4b3-4eac-b7b4-08ddc9709a7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why&How]
Add comma to last entry of enum for consistency.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/core_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index f0d7185153b2..df0d72b2c1b0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -433,7 +433,7 @@ enum p_state_switch_method {
 	P_STATE_V_ACTIVE,
 	P_STATE_SUB_VP,
 	P_STATE_DRR_SUB_VP,
-	P_STATE_V_BLANK_SUB_VP
+	P_STATE_V_BLANK_SUB_VP,
 };
 
 struct pipe_ctx {
-- 
2.43.0

