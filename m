Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847D6C25B78
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 15:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9665210E1E0;
	Wed, 22 May 2024 15:37:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YQ6Mao+m";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6D0F10E1E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 15:37:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPjxbRTFLS13afDodqjFcnNSleNt2rr1NM/4ELZo/UvHPCHr64efDvtNAKA9/i4vTL8Oc4inUFQuE8ZmGbIgRIR5V6l7/osGq2hFQ9UAKqFJKCaGV652YTz0y93L88H9w1XZKbl6KiTEpH/pMWp8Lbjtm8k0TUQ4dNuuciismnK2ujx9aa0Wr5nIoHKzeDsL1f+Cbl6/6w7QVIUltFSpNfu241NbJFoglcrHMO+ki+VWYpW16NN0ePXHO6Nn2TgTyhHUYuGSkIJW72K5Fu6rovsMqPou5+yTmYJ4lNpyXe0av70nzW35PWZdvX2i9IukVvu91UvA3+PgQWxlm63vGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0B4IuBW1mlJ+LOmOrhMoDpGMpa8fd9seT8gEBswwIY=;
 b=GHHgcEaP0XnPrZLA6n+oU/PgDgTGbENjkR5Psav6Bj9Kcae+uP+GMC2KAVnE0Y5DuOWqQBy3hRwyfpOd+qH+vRUptQrxhaxvTtTjD22fQ39+YfkCNRI5xMg+rGafnwC5D0+k0XgKUevPV9y58Uc9CLdRIrKj27QirbOfEg3o6RjQNwYfS7ORcZmHT1y3VicB2wR+Oeak/WQmWp8bjXqaPQRMQM0UeKkeiqkzG/7maKV4h9o/ZcDRX4b7E9dTbj/+bQMp7IaEbV+l0WddTunPWzo/ivJi1aN6KfsoqLvitpFVRzZnOamh/WAMCuWbEw307rlPuBYyxaqEv7JtCf+SeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0B4IuBW1mlJ+LOmOrhMoDpGMpa8fd9seT8gEBswwIY=;
 b=YQ6Mao+mmHq8N5gt+3BXtifu6MeIAfI7Iaq2dkgNrHgFrY4NWVTGDFWiMwnXSQhMo6uAq2dDpjn3F1glT+PYKO1DYv+zrB0pMocsRRVPTY2XX1RkI0r7Zzvipd4nEj+EZyCWJaw7zhSCy64B3O6DG9vXpk+mY9rCxioHoq8VAUI=
Received: from DM6PR02CA0094.namprd02.prod.outlook.com (2603:10b6:5:1f4::35)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.21; Wed, 22 May
 2024 15:36:55 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:5:1f4:cafe::ba) by DM6PR02CA0094.outlook.office365.com
 (2603:10b6:5:1f4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Wed, 22 May 2024 15:36:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 15:36:55 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 22 May 2024 10:36:52 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Harry Wentland <harry.wentland@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, 
 Roman Li <roman.li@amd.com>
Subject: [PATCH] drm/amdgpu/display: Fix null pointer dereference in
 dc_stream_program_cursor_position
Date: Wed, 22 May 2024 21:06:38 +0530
Message-ID: <20240522153638.357634-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: 70668ea0-d617-4846-308f-08dc7a7502af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GlkDNzw0v1RSMVnMQC3hYc3K6mzN4rXbg03Qksm4gyVIpFUhCrmnlhx9NFgk?=
 =?us-ascii?Q?97b2DQs//sYNgjlMP4S5wIoJshFv/b+91o0X177WIfUIG4H1YD/3GHrQeDvv?=
 =?us-ascii?Q?6aqplWRNxdKXPGFkNYZ7eJcCybOGwTL1GpfANwto88gRvmtKll/OTNQe+V7K?=
 =?us-ascii?Q?UpPHIz37qSMtYtVRELHiYbKP8O78+oIF/9I+GxWStNxUSHp2ZCPcuY2wF5qW?=
 =?us-ascii?Q?kFPsqdlpm3vtBxm5lG4yz3LAV5cENl+rJxqNkbjp8RWuWmHDZY7EYflW+O3E?=
 =?us-ascii?Q?Zj5X2Q4njU2X0m4LK7e+e/qlWLJ7JzLW5ZSKsnDDMSbH4P+WGYYNUgA/Pdcs?=
 =?us-ascii?Q?//CvVsYJ3nbBeL2+c9wf4FFercYRllg06uVzQoHmmD/Pj2EouSg/VeDGbB5h?=
 =?us-ascii?Q?QrZnKLC/FQKDnZbbxVv2oebN69g8tgemQYIkq+Dab/kY+qIfbaq5DsxKO+ZT?=
 =?us-ascii?Q?q+2Ov0iKXp7Lkc5ecKp0wKnkassYpaRQ0sMjG87nU0DvTBT7RKYzSVZdprEa?=
 =?us-ascii?Q?3NRAjnzbnKKD9YIOpXyThumFmhX8XbwDaQXRXOkVJ4ceIyH6DmWc6aC3pfJa?=
 =?us-ascii?Q?VUhX0uHuo0GYu70RzFmDt5mF7mNsFVW1MZXSx/RtRGFzOz2h4SYAGkH6n8OL?=
 =?us-ascii?Q?V1aIAmczUoblANMA13riN7dNQmYsv0dFm+ZyxNYERrIbWOl5m96RzEkJacA4?=
 =?us-ascii?Q?tj37U2Hue8q4ccaDc90jExSAUtx9bUDLx7v6EATzz+bVhGhrcBkBy540TGFO?=
 =?us-ascii?Q?Jn8whAyJGNGnCDrRm6KkJg7FFyoMnh8oXECoQYXRynD1CSrV/1YbtsOuoHa1?=
 =?us-ascii?Q?wTYvt97P4cErEk5dFps3KCy07k97OrDMh8RJnz1VkfScY+f62pKbxOaF8d2E?=
 =?us-ascii?Q?SphbWNSUys4YyPt76yKoiq5pD9kk7mVwiUeBuNczVO5b1fUQnBeOejveMafB?=
 =?us-ascii?Q?XGqGNWAK6j/6+ZghChrzZZ8Ep+4R2hJlA0eGfQDYC6JFKkxngB98WFgmvhM6?=
 =?us-ascii?Q?Tr/0M/GX1LaUF2cPTky6pJGbFagJ0/P3xO1xt7eTvwZ8YUfIeaXT1oAbRSBM?=
 =?us-ascii?Q?CBlhBW0EJkj3QGgF8El+UD/2nDY9TMY/Twgu/FbWpH+kiBea0p4SoMmA5Iv0?=
 =?us-ascii?Q?J+uKF/V5LSRCxsojCo9JizwipwAEVDJOv7JEg0nnwKohdjjPxC3PM+KJFWUZ?=
 =?us-ascii?Q?CjbTLz6lkADe7aXUNWXo4ZJN96JvATIYsAJGjBqXyX2PbAUVqxKNTsQj4saE?=
 =?us-ascii?Q?RmzNOolMB/2Fk96aO933YkkLXS8fcE/tbLfRGVS1Oe0s5t0d636yjK5H29WF?=
 =?us-ascii?Q?HdUzS24e2N/ywtfbM/Nb4Bq165IB3BWgocC6vWjQGNXPJH7CLBKaUJnWZVbR?=
 =?us-ascii?Q?zqt4qXdoavyF1WevHIXVIZJP7M6T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 15:36:55.3940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70668ea0-d617-4846-308f-08dc7a7502af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
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

The fix involves adding a null check for 'stream' at the beginning of
the function. If 'stream' is NULL, the function immediately returns
false. This ensures that 'stream' is not NULL when we dereference it to
access 'ctx' in 'dc = stream->ctx->dc;' the function.

Fixes the below:
	drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:398 dc_stream_program_cursor_position()
	error: we previously assumed 'stream' could be null (see line 397)

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c
    389 bool dc_stream_program_cursor_position(
    390         struct dc_stream_state *stream,
    391         const struct dc_cursor_position *position)
    392 {
    393         struct dc *dc;
    394         bool reset_idle_optimizations = false;
    395         const struct dc_cursor_position *old_position;
    396
    397         old_position = stream ? &stream->cursor_position : NULL;
                               ^^^^^^^^
The patch adds a NULL check

--> 398         dc = stream->ctx->dc;
                     ^^^^^^^^
The old code didn't check

    399
    400         if (dc_stream_set_cursor_position(stream, position)) {
    401                 dc_z10_restore(dc);
    402
    403                 /* disable idle optimizations if enabling cursor */
    404                 if (dc->idle_optimizations_allowed &&
    405                     (!old_position->enable || dc->debug.exit_idle_opt_for_cursor_updates) &&
    406                     position->enable) {
    407                         dc_allow_idle_optimizations(dc, false);

Fixes: f63f86b5affc ("drm/amd/display: Separate setting and programming of cursor")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index de48084eac25..55e1c19b97f1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -394,7 +394,10 @@ bool dc_stream_program_cursor_position(
 	bool reset_idle_optimizations = false;
 	const struct dc_cursor_position *old_position;
 
-	old_position = stream ? &stream->cursor_position : NULL;
+	if (!stream)
+		return false;
+
+	old_position = &stream->cursor_position;
 	dc = stream->ctx->dc;
 
 	if (dc_stream_set_cursor_position(stream, position)) {
-- 
2.34.1

