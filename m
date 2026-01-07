Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30694CFD65D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B187C10E633;
	Wed,  7 Jan 2026 15:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xqzsXDL8";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D957810E63C
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=woX9f/nvQHwiuLdrmoYcsRA2X8zclgKri5ALf8bXlKSRI2haAbKteYkMkRb0/+q2FjuuLdIdcIOGRSGPl2IqAJhN0lMO9JquZDEyud+RN4oARcEu1gtRcJMx9zeOn3v+ZCx0itF22fdxsH2ZvFspixmwkGMBa4fymSkYililM0vZ7nt5zqaXLhDhuOmNAsP5qrMIkrXiJDZ+WTGR98svcNir4AhXbAlSSCevA5ls3IdEd9BW8agmuyxVI/IweYerK1Tx/f1io9qh+NQjt0CbE5AcjF4Jtby2gGOvKn9gO6X6MPNDWdQIlIff9wNymvXse8tSKrUgX8nkNqMKgFSRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKXUXr0tPQzZlYpIEJERSiuScALuwu1PD3rb4ijb3tA=;
 b=qwFJWytn/kYPMYJcu7EfXWYxOELqPuzVuo1FGvLvbihyc9BwfWCKR3JiFJ5e2WGf9L1Jlag5+2MbehXpUbBJ5E2D9+nWrPj26aReUGi8fmzziPf/bp+dBzq9369Ao8P+TNw8O9tN2BN/OSZbGfnpRqGGM0Tg0RRh2JzAPMLS+gtovhgFwbAdPSZtHtIRkzqvquTPGm6ukOQxgw1nlY5/7d3KQJxpbSb+E3tHbdibhOJikkZop/P08yhOLd4s9yWMOWcpk3nU+vcUoS260TnO21bdJDbJpNulh5zrZs0EZr7ClQ0hkbuzEOaL8MQn+1iQQ0dCl4nc9E+Fa5k7S3VcOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKXUXr0tPQzZlYpIEJERSiuScALuwu1PD3rb4ijb3tA=;
 b=xqzsXDL8XrwZcnWDEUWPAROfF2Pbwd4vprSzxFy8o23giCRKN+cYZ7u34FMC++AEEccTNDqI267msWdf2iUd9vP0gbOsFzQ8Ud2FdlKtdF9M65lpES25c1xavfnC6aIqc3yVommVqXgwvFqnSampZFfyZ5p4rHOh28d4CaGKxMo=
Received: from CH0P221CA0032.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::11)
 by CY3PR12MB9556.namprd12.prod.outlook.com (2603:10b6:930:10a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:58:13 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::5a) by CH0P221CA0032.outlook.office365.com
 (2603:10b6:610:11d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed, 7
 Jan 2026 15:58:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:58:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 7 Jan
 2026 09:58:08 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Jan
 2026 09:58:08 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:58:07 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Peichen Huang <PeiChen.Huang@amd.com>, Robin Chen
 <robin.chen@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>
Subject: [PATCH 15/21] drm/amd/display: Add replay_events in replay settings
Date: Wed, 7 Jan 2026 10:48:07 -0500
Message-ID: <20260107155421.1999951-16-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Matthew.Stewart2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|CY3PR12MB9556:EE_
X-MS-Office365-Filtering-Correlation-Id: c95399a8-94f7-4c96-5605-08de4e059067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SujUJEqKythEY7Mack1pGAJE/4lK2ukNi8lBsvKJDZdQn0nm5Q2g/5L8Pq5s?=
 =?us-ascii?Q?3SX7qyVPSL1K+fzZLkmgCBUnoj6MGtuWUDa0OHpPPauc+IKIf5vP0AqT8mit?=
 =?us-ascii?Q?eJ5UFUbSkDYXlMeIiUeqgBrXpM03aYykLHIMQaAna5dHvfG9yaZHgbW0lnky?=
 =?us-ascii?Q?fMen1QArGpeu3HvEBTKMeAws3bjJEYKfH51dhqlfvSJsaVBHuCFQzZoqr5De?=
 =?us-ascii?Q?oPyf2lMYL0hO9KcCfGvnGJKwidP8lv3Jt8RI17uw2Sp7wU0iusCn5eXqbSUN?=
 =?us-ascii?Q?ZRafsh3W008TVG63J5j+wI5XxWNGSdv58hQtoUlYJV9vdkyFPU/umptjrEYJ?=
 =?us-ascii?Q?W3kaaHAXcKhphZbOuixPHZlB5VdiHfuRku5ELmY+bRK4QRhFXe524g5JeYxY?=
 =?us-ascii?Q?0dx/KZOFbEONvijgxmuAtQROKNdmmnTH8mH6Uy04u4KCzmArnVW8dBrk8INC?=
 =?us-ascii?Q?/KEzHprKGQUeEogHSMX//J2q+XOskn/fBmY3zg/Uo6z7hliWldxBQ7Low9QU?=
 =?us-ascii?Q?yspt5YcRr2N6m8MwacmDWifZCHEJVW6n8wwt0CM6mv1ayunIbHDUUPQem2Fu?=
 =?us-ascii?Q?RSGhFFZn5NcHPGECZz7Q5lb0FlxG8nIIzCjDYe2TDfB2j8NApYuAWRvY+wSZ?=
 =?us-ascii?Q?LSG04lpE7QAB2IJ1mvL21pOmVBVRztjmsTLKu2z8VUlDQ1lkiVnEOHBRn2gP?=
 =?us-ascii?Q?Fu9lZ95z8Chf7/FBcz/+yBGndcpldhFX6pAut7YZWb1SOgtRXerOaksLAWXT?=
 =?us-ascii?Q?Hf4hVk23kOR+1SEy0Ui29mAcmlbo4uR8d9zSo/TKvVB/qeZDFd/ySilpt57p?=
 =?us-ascii?Q?NCPDxkAeQSMmQSHG8S1qOY9UUmiKOQSaLTqv4JvIKt75CDLR2688FkP869C5?=
 =?us-ascii?Q?EddsnIL1KI+ni3P2kPd5LF0yP2cqZ71c86xeEHLkXU2GmAOXkdjOXVcg631B?=
 =?us-ascii?Q?76/OIgj9/0g63yrpu6FYfGjzKsDjaBBOZnCVWbuTYtT3P7hzcj5drtSwrbdb?=
 =?us-ascii?Q?xWBIKci5NXTffhn75uN4baUIBJrDOi+5yhyfalTlNrHVX/POTOMZx0nV0Qo4?=
 =?us-ascii?Q?i4tBOq1TuHryXVt03wd4E8xeDfCfZs1wO/bTFbZVkQVIwD7iiHrwUyLOCQrO?=
 =?us-ascii?Q?DDvEAYEMBTqaF8XgkIQjVkzoCY8hgY5KzkJ56KvLDKjmmC+mBil8sWuA5i9q?=
 =?us-ascii?Q?pojM/T13EtPuNzg948dOux6th6UsHNwgaR6lKebByKRYE4pZdhA317EzUNC1?=
 =?us-ascii?Q?6aAu7WEIq61n3LxetBuMKi/Ct3g412GO7O1/DhfwkneXA+wCSpJVBVb8HtQm?=
 =?us-ascii?Q?pwMWPaO+ZUrAsyGG0MO3Ci3FI+tOliCMfcEFI6xUzbX+8wo24+DCDlq0Xg5C?=
 =?us-ascii?Q?WaLMOqkaJWsMLDnsONEgtemL3+3pI2uTRpjYhMqwLOsW6lV9U/dY6WYwyDFA?=
 =?us-ascii?Q?PGv03iBwrkte5yEJb7D0OewpiuQWhhRWKWYMCyWl5sNLoiHhBYRCBEVy6YK/?=
 =?us-ascii?Q?yBT01A/7IBlzNYT6AXGZWH3a64tpkEW9+ewSnrokHIr+RYwahJsmC1bU5OvV?=
 =?us-ascii?Q?nIjdaYU5Ajb6bCoSLss=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:58:13.7158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c95399a8-94f7-4c96-5605-08de4e059067
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9556
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

From: Peichen Huang <PeiChen.Huang@amd.com>

Add a new field to replay_settings.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 5e71156d28e3..bb1387233bd8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1223,6 +1223,8 @@ struct replay_settings {
 	uint32_t replay_desync_error_fail_count;
 	/* The frame skip number dal send to DMUB */
 	uint16_t frame_skip_number;
+	/* Current Panel Replay event */
+	uint32_t replay_events;
 };
 
 /* To split out "global" and "per-panel" config settings.
-- 
2.52.0

