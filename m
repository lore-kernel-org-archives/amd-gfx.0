Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7189FC44508
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 22:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16AA210E898;
	Wed, 21 Jan 2026 22:33:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nHNUBytv";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010048.outbound.protection.outlook.com
 [40.93.198.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C0AF10E898
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 22:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7aAxjim6Gh+Xw6jKF/zKpyuYewNTDpxtLsVFN2o/ktK4gkGhkFce9PWPvKduJB74RnMsjkfXIt57p1eN/yDt5Fj4zlUp9guH5m6LjGW41Y2abOtpuvZ/yDrFFJ5pNwibp0NdVKFXFhLJsOzgih/Nj0ZErSMo8abPiAH3bbxegiTWTPAG1MwT9Y2XdC3vABvx4mK3W2vI7Zwbp2SRILLDqliRCM1kslr2ijabgSjh8nXofqLZEI5HC8+16i9oSjlfI+xOVB2+xjqeGkeNvW/kHld5KcL0cjDFmczhCbHyJl+/PRTLEiGHJRQiWMbJ1UG/admk2V7nBtnz6afP5v6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8hayXu8j2qQuW8kxFClgXUyb7Di/vwZLC+FUlYSlbI=;
 b=M5LAJiQ03lZXUyix7i2Kqq1o7uFM7pTBEEgGN9V6wZ6aGFvf/l2EOYWJcXFFI/Yz4v4nOataQQFYYm5dCBpJmBTTZBwCOZyomJPKd1dUW5qCYccMAI5YDUn382uEpv+saKnZgD1rd/bsuLom+Tb0SWXmQjTF3kkZHW4jsu9fkg490xbiEoEAUv3+gCnPCWkB1/pdeFeaBEo7fqcgzficJlvDM2uJc4VxXqZXCMj16i0AO4vgCCaYKPWXqk6QSGg73axD6aTMMbzL3q0dL6vBac5NsITlcgQid9d1GI6+VD4EPIbecvA03AzRbhnxYVzbzYyLrewPgMDosJkrJfznfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8hayXu8j2qQuW8kxFClgXUyb7Di/vwZLC+FUlYSlbI=;
 b=nHNUBytvIEZuC7PqxRGHoafooldpBPPlA3WC/v4zr2Exa23jraHXfBvFxt0AXu6LglMe/fGglxaiXS51g6/SqWIBOmrpJIESdUHC2OSIzDe1OgNo/LlifRMpTxHtARgZYdxc8tRJAnA+KrQMSZTvfckJRNr8WJTtjCDQWNcvbq4=
Received: from SA1P222CA0041.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::15)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:33:14 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::9e) by SA1P222CA0041.outlook.office365.com
 (2603:10b6:806:2d0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 22:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:33:14 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 16:33:09 -0600
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 21 Jan 2026 14:33:08 -0800
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Michael Strauss <michael.strauss@amd.com>, "Dmytro
 Laktyushkin" <dmytro.laktyushkin@amd.com>
Subject: [PATCH 09/13] drm/amd/display: Add debug flag to override min dispclk
Date: Wed, 21 Jan 2026 17:31:45 -0500
Message-ID: <20260121223247.186241-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121223247.186241-1-aurabindo.pillai@amd.com>
References: <20260121223247.186241-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e54b67-baa4-454d-e1b8-08de593d10b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Awf67As+sgDd4Xh6UbZ9TSowLqLmJ/Y3fMro46g5Qkb/su/ubrzY6rBdqPRJ?=
 =?us-ascii?Q?nZvZJT8rCvp75b2l+/20/IaJ1XVo64gq1MgEswSgNEpSJn3wCsqmdIgQGS+u?=
 =?us-ascii?Q?eGyctCEKnXo/C1k0i/AjBB0/3zNCMCEgHWqrIjiQNzMpRyTSFDgNxe9J7OJc?=
 =?us-ascii?Q?oeANh8oxuVyLH5INFkwHwZmBzsLdd+tuXi8JSeZUXicVztBmDzKrTFoi7R1i?=
 =?us-ascii?Q?o2gREHZdl50Bo1cZ4OWaht3kEyh6vcjC9HE0Qe76D6ZPlxMGKxJS7qTNGR3u?=
 =?us-ascii?Q?n7M2K7NT8/0nHNofdIAd3id2flYyuTDGPWXhih746jWtdrZ8c1B9glpmb7Lp?=
 =?us-ascii?Q?QMOZe7PKdDF+wEKR8X5DYKG4djw1xm2YnVJhJDSjoeY4y38RLtQiyQ8jhvC7?=
 =?us-ascii?Q?VyZiUuhOLmAINJ3EOgjV4psamHkg3RFkU35O7G0ZRjiePpQz5GyIiKj8Al0U?=
 =?us-ascii?Q?dv2Kx54L6uY5b5e+U4Hr47Mgpb5AZ1p5F7Lc6Dh2Q8axOPF5qKImgbXD/e+K?=
 =?us-ascii?Q?OZBdIB0Sg/M2fX+drw5b1vRjG/ZZQi8wIChaLPp85AjFr+5W3UI08+FGspG2?=
 =?us-ascii?Q?AqsMML0pJlm+eUQXlKIIEHN9NQWMKir5dsYoag7UIFuboFqIGabiJK7wGNY1?=
 =?us-ascii?Q?qu5g+O1Ua0j5L9fXF46w3VfWVblytcAb74NCUfj4SsEx693i5yyIfQduEg9/?=
 =?us-ascii?Q?cDFhco1lOPgPYHLGanbNmRpeZ0QLe2Xiq/l/JLx0UPOH/W22kVhEPqMDPdvd?=
 =?us-ascii?Q?bNlyBe7cPUI8/MACjg+S9iL8OnJwcuiuRHP+jtxbVzsocj4Xs/s2z2CppLTA?=
 =?us-ascii?Q?vmLcPUAwUiVfD2shMtQ7aO1z2ly6Ra6yvTHen7GVLWaYUe7uOsH9a66lp6ko?=
 =?us-ascii?Q?8PqLypFreFJwkHNvR7xfGhVACSEPRdRIxp9g1c8Xm8iS6SMBOwjXj9ERvT1X?=
 =?us-ascii?Q?8t0Q/YuvMhpLGRVzxIqTOQWS6ILz0LT+0vc0sVbjrjMhSnRug2Ai/Wt1YPme?=
 =?us-ascii?Q?WfjJ4zeQ0dFt/Goa8LV3oNLn6j+KWLkQoSJPA0YJSic7Hz3Jk+pMZ+HLpuwt?=
 =?us-ascii?Q?rTAqllpxr5YoCAA4fcdCpW4G9Rg1cuireTsghd6tFQrkRe5DV+uGjIVfv3xI?=
 =?us-ascii?Q?hSzSYN0JYB/vyvLRh6w9VJBXsH0hZD4+egSpbMIwo4B/e8LXfmEkzBMv96Pr?=
 =?us-ascii?Q?Vj/FKEsKOlJj14z3zwGf7sH7drq6NU6tljV98lio8P34ME8VR9VdNa3tKKqS?=
 =?us-ascii?Q?fIBDFsiEKMJLpky+vtK5Iq5SNgXWSkX3UW8RgvT2TsQkHnee83oF2MX1SQso?=
 =?us-ascii?Q?DVuYIyBpXQlbYrhX+ojuiVE697zTQOP6N7QK5JvA7z+uL1jErVd82lqq4mes?=
 =?us-ascii?Q?22plXkg3Vpvn7y583jml2JWcPHvAH5Y2NqomzNUWvMclUsE8NGYG5WRNSkPF?=
 =?us-ascii?Q?I6f1pp9jY32O8e7S/RqT6ZyqwQL1FaXpaatIupIoreaX/EQKcCjMK5YOk23m?=
 =?us-ascii?Q?jqpsqdPj6RRHq6mfE4/X3hJ+pjFYjZ2tIhBnds4YhLZ7/VJJjjXrAOafAZc0?=
 =?us-ascii?Q?j+rHcd/LvRTiYrlBcs60lR0/S+hIm3U/e7Njdro6QQuM6GJNpGp5kaVoXrU0?=
 =?us-ascii?Q?dBiV/v3KNSnZTIFMsN86maH90InZ1M98oVpCF3U+ASBnMZ9ZS1H1dDIvrlO4?=
 =?us-ascii?Q?w+aw5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:33:14.0813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e54b67-baa4-454d-e1b8-08de593d10b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Enable dynamic ODM testing without needing a valid dispclk table

[HOW]
Create a debug flag to specify an override value for min dispclk

Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ff15e5990ec0..80fd8f4e4c64 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1210,6 +1210,7 @@ struct dc_debug_options {
 	bool disable_deferred_minimal_transitions;
 	unsigned int num_fast_flips_to_steady_state_override;
 	bool enable_dmu_recovery;
+	unsigned int force_vmin_threshold;
 };
 
 
-- 
2.52.0

