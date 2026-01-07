Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2D6CFD647
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6E7710E631;
	Wed,  7 Jan 2026 15:58:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kytVu6WJ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E64B010E624
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:58:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5zACSQ1njQp2mU29v8CcJOjtNbl5m4fGAcArQe+y/uKR25H/LwtbHOUqJnt2AQt+AYv/otjHicmV7ShneF02cEgQDVvvB2/eu2vpccLDEGWEiiDl3gUHNnxpHwMu2QZzF5HjKzLl1xieNal188OXqanbzCIGuToREqJXIyPjIfmNCd5y0UpAHSqQlBIFV+ee7hYKaIOYCPC+6yX8ty/2tOuw46mPLKIzmm3IVVgB9WCyiIxg/BoVY8uus5gEdgbeBa9YNwbwN2qSvtwoDDUDiV81SsIWFcTgTqWdGH0ZjQu2Ry/TLecYPxqXVltJ73vg7IyzOdY08o/gYMqCoDh1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahQ/C1jq5FWWe+xb+v59ZIbOXpmWmqig4j78LTXLa/Y=;
 b=EBrDgqz/HKxEd6ySJUPeZeQBlFv5ACkBC6TUg+GQLc/QsTrytyamJBZTkWX110hV94H/kHh5eVc62U3U26GDM2tCt1S+F+fInUVZz9zCVeCBRp5Pg7KcHwoIJj95TbNJf9LpEo7a1pZC8XGn4BhfYbJnWA/LVnLiRLyjeSu+MLxReLPnBzvy9cusLxlvQy5Ezc0eETBmfooeA2eV/ot9eCyHI0rt9FxopKSerotPkhTGos3DgZZHVpSaZgp20V7R9Ozw3AjWBSCsO5KGYWD6xyFPriOInfqD+aAWMGHHifB+wgDwYL3ySUNpcmYeHmrMOWR1+F1pl9Hw6I0ghN4GuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahQ/C1jq5FWWe+xb+v59ZIbOXpmWmqig4j78LTXLa/Y=;
 b=kytVu6WJem6YIpkt3Yh/cRW2nFFFcIfhIiIiMGcPiMiNhteD1VJNhBnREY8CRKRn+opU4QBEQhrsKvxHIkFO+eU/PZdmXMDE2NGkJs2U0VGAUd4Qwu67IPSzMeIzZuD62wblqNgAxg1+YsGZOhy2fBPZiHclJhl9qw+VYotJs9E=
Received: from CH0P221CA0046.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::19)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:58:08 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::d3) by CH0P221CA0046.outlook.office365.com
 (2603:10b6:610:11d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 15:58:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:58:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 7 Jan
 2026 09:57:58 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Jan
 2026 09:57:58 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:57:57 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Charlene Liu <charlene.liu@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>
Subject: [PATCH 08/21] drm/amd/display: only power down dig on phy endpoints
Date: Wed, 7 Jan 2026 10:48:00 -0500
Message-ID: <20260107155421.1999951-9-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Matthew.Stewart2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: c36c6fb2-0773-4dc0-15b5-08de4e058d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?75L4kyD5Nw+v6VzFzFAlDnCpGHVeRC+tvvB5jyeG3GrErhj1bANb+VqKbU8D?=
 =?us-ascii?Q?V06av3BymqpgXAOGijEJkBCnor1hL0jsOa/TXQBZczx+Spr9OiyRvPzp3yeB?=
 =?us-ascii?Q?4baRCn6ErQXlYrzHPMc7PZ+Zlfj3SRwYaZ2CsZdBPSmHBr1ZUJlAH/4QwhI+?=
 =?us-ascii?Q?qo4OL+TibLL6X7lvUqMoCgxoFhzFdDKXWmmUy1WUUc4/BRLBvrgA4G5PKgSQ?=
 =?us-ascii?Q?0nVuJBjptvF3PJK/TAe3hKxxHyzYLQ297ZalBmwz2U7L4hKW92bvXQLE4MiK?=
 =?us-ascii?Q?m9pX+yff47GbroheOlXIdAhC7kXTE7lp/2iJBdB+XtV89IDEXSqDj33+Gab8?=
 =?us-ascii?Q?sbObtFACjb0gDf28i78jO4ANGeL+AzNKDy2yxlti/mQ+iaFExTboWfnFNP1W?=
 =?us-ascii?Q?tO4y8GTRTn4/s/NgROCIhyYBOstjhot4w0uuh6oTSB0PkcfHbg8Q1N9ey3aW?=
 =?us-ascii?Q?vElCw2zcjvIKWfJRU7Ug4XsktMY15aoZkGApqER+oZMroH2urqLNzAWEphyc?=
 =?us-ascii?Q?eVFs9F1Uqe0Ik55mvUB+Ga6HekVAN8egoKx2JtkNBMZmjC5X1f5Crr7ouBPX?=
 =?us-ascii?Q?7MVO6sHgtp65bgk0ADc8kmU4jabGwwh0Uwujkds8D5HcimlWHcSfvBNml9KH?=
 =?us-ascii?Q?OEcCZmlOp9ai2EF0tX2Urs/9oFsbg4BveOTxI4fq3fQ1YrJExLWqSbNJKpjl?=
 =?us-ascii?Q?io+Eb6TdDk7nHIcvHl9R5VCHAt7A7dLHxBZfAd36sLybmDOYNUT4zJOM1Q2l?=
 =?us-ascii?Q?iS0la6bdw+xPHGpGrvxUmNIWZp7E11S4ukdYtXlivHZJSlRaUtpGoRwaSwWs?=
 =?us-ascii?Q?20CJc+mYHsc31eKo+/5obqi8ItNJ6Om/fqwyFxVMrFKkTgsUMZnT80wMnwfb?=
 =?us-ascii?Q?GeNU2WWdKFSAWBYwL9of5Ygtfsl9CL2xY7EV2mc27adiK5tMkeGciiDWp3s4?=
 =?us-ascii?Q?quSt4bhR3TxPBj6CIDBrtYbarM9+8Dfna4Y40EnxykrSJcmO0IAxYY5EMIh4?=
 =?us-ascii?Q?zoi+CyUMr70YIenMckAwkmAp2ooCw8Ov7YD+7Dc/EwYlj6oIlkp0CoYzvOWI?=
 =?us-ascii?Q?4O9b6iG+mwjfDf7yFUB1Z/0bpb/W4bCaOPQ4ggA6+5Qz2XRrUt1m+HmOe15V?=
 =?us-ascii?Q?IkhloKWHIS8crWvxGFdFxkcU/5KCjGHS34sBASipoFnbZrGUrSvfuDQol5+C?=
 =?us-ascii?Q?IMsnmrnV5yFdcsKCnRwZAM7IVphszIaZZhFt9A8G7LSS+xVkS1PgSnXrylaw?=
 =?us-ascii?Q?s4QhGJFuuPdfg7geS6JDQRs143pmtYX4IMZTA68IP3IE3C2XYbzlzcT8M66n?=
 =?us-ascii?Q?crpjPy+qJJ7ixCOlSAi0VonedYtonkw0Kd+hsSE0v8bYSq3309MJ39RPEvsB?=
 =?us-ascii?Q?OYmqfpPSvcTF77dt9QmYfM9TsPA24IKbxQ50So4eH93exj8tA6gq64PDKEok?=
 =?us-ascii?Q?2VIJD/2AZJg1fNbVcS8IUAJaboPoOhYlsFkIImcGq1h4XC7u8V9N2bqYch20?=
 =?us-ascii?Q?X42k/fxmF0a86XMMSGBNlf3ev7zx3ShkGkg9GRuyDisx16faAeIDrPSBUkwN?=
 =?us-ascii?Q?lgazEnOw7KkmHcA36Qs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:58:08.5594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c36c6fb2-0773-4dc0-15b5-08de4e058d51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
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

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

This avoids any issues with dpia endpoints

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index b7593b886dc6..22c1d5e68420 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -287,6 +287,8 @@ void dcn401_init_hw(struct dc *dc)
 			for (i = 0; i < dc->link_count; i++) {
 				struct dc_link *link = dc->links[i];
 
+				if (link->ep_type != DISPLAY_ENDPOINT_PHY)
+					continue;
 				if (link->link_enc->funcs->is_dig_enabled &&
 						link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
 						hws->funcs.power_down) {
-- 
2.52.0

