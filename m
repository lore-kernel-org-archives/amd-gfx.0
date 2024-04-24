Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF483C10F15
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27D4211390E;
	Wed, 24 Apr 2024 08:34:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zgd32JFD";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A06D011390E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:34:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTf6oq5tzRKncHINGmOygrSma5pbX3m5pDBvrZA9CuXybWDqDqsnHtnfIojNCMOLUAlaKcNRJk1ySdTyCf4F2626GmDszVSE94Gv+LP5G6YFYd4VCsrf37o/IuyjPQrG+D11HvVTRrFRC+PRWDyuwS3uBWF/fuMbGEB76KbiByEvogy/SwOE0tZ1CSu8RuqDgaDjjgQBJwDxrmZyxIbHM7CQoN3Kjfgv8ERusQxnXAVOzY/qsdIwRPATKw+M+PGMYCnjWvwwsuWMZ9/ofOASahijzhnHEQ6dPHXKs95guA8VqY3TcsEdEcjFk4k9qsPVHmx8Q46pLTu3xnQpaLac+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/vMuBhsJQdIPCUlEmqiovJUzMUiLYNzQfNPUhL6I0U=;
 b=H6n8d8Ii4jZR6BxfsgxjfCJmfH9XaPFBswBVOJvqjYxjTnKMUoIY9tuGdD6oOZ/Ho/hj1OeS2QHdJobe/dDcjqsx3U22cnhwTIx1PNEel61YcfbcpfnYsbwgxFaA/ERp8kvcgSw1vOKSjpXfIj45yzecNPeDh4y7MHBUPYQkwrEA+Wp86GDvpGXEfvduY3x9fK7HggLgkw749Tj+9yQhtSVmFKwrinnV2C0tP1L9mRGyZRsswaku7DUhfTdxwbCk0VvgPv7/EtMjDhggU4GfYj7JJmmRd1GkGgEoPkaQX7RUR9qvugAqvOuec4LC6ZR77J3AnEC0FlbQuL+ArcYpQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/vMuBhsJQdIPCUlEmqiovJUzMUiLYNzQfNPUhL6I0U=;
 b=zgd32JFDnrrcsCXEdk8L6ybSx6Q9Sw92zzd8gK1Aq2BmnYclXytCxp/P+6OcpMVoCd7ALwxUrD39W7+TpPYxKbrkdroIde5FMYQaFnYjHaBKs0ZvC5ywQpQfuhDQRbMu1R4SzR342xwHwyfmV3BXBPhBC8Mu45ZaeplJbFNKyNU=
Received: from MN2PR19CA0022.namprd19.prod.outlook.com (2603:10b6:208:178::35)
 by CY5PR12MB6225.namprd12.prod.outlook.com (2603:10b6:930:23::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:34:53 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:178:cafe::e8) by MN2PR19CA0022.outlook.office365.com
 (2603:10b6:208:178::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.36 via Frontend
 Transport; Wed, 24 Apr 2024 08:34:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:34:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:34:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:34:52 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:34:43 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 05/46] drm/amd/display: Check pipe offset before setting vblank
Date: Wed, 24 Apr 2024 16:31:21 +0800
Message-ID: <20240424083202.2647227-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424083202.2647227-1-Wayne.Lin@amd.com>
References: <20240424083202.2647227-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|CY5PR12MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dcbac63-9b40-46db-5028-08dc643969ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bc33Wd2O6I/AuR7C5cx/X6sxT/NFJiomF4kmgiMNk4c36swiBferwhLAWWA6?=
 =?us-ascii?Q?Ytt5otOGwz6TPaY1gXYicFrymcrPsLNHmJ3cFKKAON5sc85ETlumcnJq31Nu?=
 =?us-ascii?Q?q9l4v/aLUDKDv6b1VY18J7P/eLU1lE/sdyUHsuUYD5XJMDkKyvukdD79C7oj?=
 =?us-ascii?Q?h8VoYYsYdPEpvyuCxamPHij55LS5sri1dq4cxlJ4edXFwpVKmqguJRippvbZ?=
 =?us-ascii?Q?RaanpTPGFg4AOH+B2sTn1U9dmzjFxt6wOZg7eILlklsyqZSuxYf6KgkmbGWg?=
 =?us-ascii?Q?C7GMAIvbMCrqkwKflfHDmy2K4rc4I1skcBqmF4FLwXf8b6Bc1EUN3AniToVS?=
 =?us-ascii?Q?8e3ayzAcZURyi5YFZ1vme2F1HFVTTkYlSoeBkyew3whlGhlcsW6vqWI5ks4C?=
 =?us-ascii?Q?Nefs52wrOxsepBrKg38/CHUZNkM28eoA5QgzmDfPIaQ7Hv73J+fwparqFeod?=
 =?us-ascii?Q?xqiwG7bpbHge1AItTGqyUd7Rtbqy/wGmFJyuCVlXRWEqbS/EN+lg8GiQPa5I?=
 =?us-ascii?Q?xMYXnyYWhUsflnd+c/ftm/gU9GLbtXp0Mv/eXCyDqjcwXvxPaKVfpjMw/LKo?=
 =?us-ascii?Q?M7Wf1OJawc1VCESfUnWtFf0112KvcfHuSGr3448wAy8GrlBkYyyeaEtnwNEc?=
 =?us-ascii?Q?gtIVsYZB7Wwxnxyf/A++/kChiDPhyauo4faZNkKPUnITFaQMXs+cfACk1jj7?=
 =?us-ascii?Q?wyEOnvSdKQPNKe9K33tvxxbHwki22K38hrlHcKJzIUhDTB9XgAaNEUHt7pm1?=
 =?us-ascii?Q?VbLt/BUjqGhe+DvcagGlCOkNCBERsgBAku0FiqXlWwrxf9gb1DJpLilM3E4h?=
 =?us-ascii?Q?JSXdD7+j2KLl0ylk1l7MhNQI4NTHP+Wq1VfygAmjPWFevS8LEn+REBaMllYt?=
 =?us-ascii?Q?UwDyGFYr0Jab3Sv49evnaQnsSzGZTQt83vbvkFIcUT6H/jw5iYGTi+jY9uDu?=
 =?us-ascii?Q?pgoK2EkhY28umk7EoCXzKF0ADV8kWYOVBrMXbZKDXbKr6iMUoWSPw4DhPeWN?=
 =?us-ascii?Q?Qbbkp1CFGrPlVyF+AxRzduIXNCHzknxb8OglnU25OFaEK7veMMWnsuq5sTCJ?=
 =?us-ascii?Q?KPTcq8WWHSEjKhUUoVhZBKP2djhaw/BrtsREuMHjjbvYElQp3OwvfUK1zhjf?=
 =?us-ascii?Q?tKWZjwzxrnGlFq6d8woeesdbDtnUrBW7cE3nf71RsjWq3xIujTPd25VCphR6?=
 =?us-ascii?Q?GqtCRQj/ICzgsckxpCg9hkdwAfT9Bx7Js9XTC2yVVJBXFjm9DaIt9iMN0udt?=
 =?us-ascii?Q?+/gKNKx1eT65EQvl6Jjsy0RBvhZecW09xdHXGuq8ZBr2LXCcyo3kHk8EJIfm?=
 =?us-ascii?Q?2lAeU0DYheVetNBwwdz1S3IEDaOqC89qUFvTez1JmI254Aa0+kezQcXuMH0o?=
 =?us-ascii?Q?s2I4UfKzguX4GpzfV3gzVc0YwGvt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:34:53.2503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcbac63-9b40-46db-5028-08dc643969ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6225
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

From: Alex Hung <alex.hung@amd.com>

pipe_ctx has a size of MAX_PIPES so checking its index before accessing
the array.

This fixes an OVERRUN issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/irq/dce110/irq_service_dce110.c    | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
index 1c0d89e675da..bb576a9c5fdb 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
@@ -211,8 +211,12 @@ bool dce110_vblank_set(struct irq_service *irq_service,
 						   info->ext_id);
 	uint8_t pipe_offset = dal_irq_src - IRQ_TYPE_VBLANK;
 
-	struct timing_generator *tg =
-			dc->current_state->res_ctx.pipe_ctx[pipe_offset].stream_res.tg;
+	struct timing_generator *tg;
+
+	if (pipe_offset >= MAX_PIPES)
+		return false;
+
+	tg = dc->current_state->res_ctx.pipe_ctx[pipe_offset].stream_res.tg;
 
 	if (enable) {
 		if (!tg || !tg->funcs->arm_vert_intr(tg, 2)) {
-- 
2.37.3

