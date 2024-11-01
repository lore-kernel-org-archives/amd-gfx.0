Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE78E6B27D
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FCE510E9D0;
	Fri,  1 Nov 2024 13:50:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jz0amHxE";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D96910E9D0
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 13:50:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2AHsaQvrHBBW3EnlI/01X7C1jv9hNN0qwbqo6/AODeYLhQD6uV9Vq+Bmc3CuKo4p346snbUPG1PDXY17u+i/afW0b8hOQO6wVcxkPgN91SyXC/nl6K7CdvCdRyok+HF2q7GAnw3PU0WxixLRmbrnclVtAZDEprmNBeGI0MiZVr99NownlvUTr8hZigDrMU59FvsW02ncXKdoCMM9GXuIo0c0rzfaKUHh4LShILxtnytnoeM2Rpl1i5J+MFb/WEJTtSHrBbPFJvdxdtNpE+hl5THFgAQ80fmGN3ofJLViJqi5OOYuqpmjL5Z7uGbssrgKDbWr/EihwWK1qG14RgfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkzmX1uShN6ykWwJFnOKiioEaagsXBaFVRgVrOFLqIQ=;
 b=CdASdZR1eOqiZ2aBSU0Yi7xQkEt0pfDoBPAv25Ec8o1kzUVbNDP78RuUpPkj0k684xQjg/UZx61eOAVrr7fMpmfYpxiJ7GSnVFjqCsutVPk114AIXM8AAsS+vuYWH8bLhOZetYEGnr0uHbBRK/Em7aLSMZlV1amF9/rIXzROuP38EXuK6FmrNc0SbLkR+vsLW+wAzI+seaS1Bmd+ahCovd08vD0nJ3fHF8kMTPoAQsRaUqxIvJPcKmOlQJG4ME48phE7Bw1Mf2EvA8Lw1w9mtKNldPy+HpQA0aGLIc5AiuWPdoKt+kDVKVV+9lwa5HXGuIU0E0PTZVPs4I13jWPXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkzmX1uShN6ykWwJFnOKiioEaagsXBaFVRgVrOFLqIQ=;
 b=Jz0amHxEEhktNHhPNFjpUW9kEtfXEk1vww/K63aI1g49XXZSKhz3Vz0FM1v5Tj/5ICLhpXkessdYHZ6YFuDhKpwMS97WIvcltjT0EHsGWcpkbU/irWC0D8fZyNB1Q5AUGp//moqsA6qFvwNFZqU/x1IlpWFKbuEyYhBtmHCqGDk=
Received: from BLAPR03CA0128.namprd03.prod.outlook.com (2603:10b6:208:32e::13)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.27; Fri, 1 Nov
 2024 13:50:21 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:32e:cafe::b5) by BLAPR03CA0128.outlook.office365.com
 (2603:10b6:208:32e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.25 via Frontend
 Transport; Fri, 1 Nov 2024 13:50:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 13:50:20 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 08:50:18 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Ilya Bakoulin <Ilya.Bakoulin@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 12/17] drm/amd/display: Minimize wait for pending updates
Date: Fri, 1 Nov 2024 09:49:35 -0400
Message-ID: <20241101134940.1426653-13-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: d0bbcffd-33d7-4019-18d0-08dcfa7c2098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W02Zs8TnL00Ho8KeoIYkWKc/yCmbkwJRXZoTC/IaIhXEzcGc+ze+5RdbDMci?=
 =?us-ascii?Q?KeGk2vrGoEAG5S/VjuxyzQHHvEOwUTEiM3vAQbpi/KwbPFFXNerieaRXxA/h?=
 =?us-ascii?Q?yTn2sX6M3pyylF7/Z8t5p2IzS1Mw3qjFu/dw60oaNdHZYBzHuyNreLBN8G8O?=
 =?us-ascii?Q?lpnEKmZvJkqT214P35XVHvEfmm8yq+RgcXy64h3J7zysI2P/js7BKM476fFr?=
 =?us-ascii?Q?cUkWr1sQxH2IPiIVW5vq6qoamIZroGBoEaQklY56vtrI72QsZ8wuVeCjjyUO?=
 =?us-ascii?Q?ynnTGZIdkJR2VcwfmSQzwnLa36U/iT+oiiHTvGe0Nu2SR7y7mgxOh9KumkcJ?=
 =?us-ascii?Q?TtYcRcYpIg8xLWQbOAEOlmktoYnM4mayLhIesHMqKeQts2y9C/jpvrzczteM?=
 =?us-ascii?Q?+bh6anBS/WvcQgaQrNZXQwK9FnMQqy3ME3d6Hv1iXrkqBGQlrEopJnqtYrmM?=
 =?us-ascii?Q?lKyy7avsClTxvxYGI1h1AtjVuLSIYlhqHBVG2GXRzRYXoMiEpvQRx0YIH9Pm?=
 =?us-ascii?Q?8b8klz3Q0tUeGxYEU/Aw9OeoUUpDHiWcGu+YLhqlENDJfdfRUFS0UCytvrv8?=
 =?us-ascii?Q?YrNBQruYxRFkGOoFPro/xsZ4xLyp99eLZvjBJNOuwJUYrtTy5ytxBWqBUmur?=
 =?us-ascii?Q?PUuifBUhRHZz7V6hRHFkn9Y/yUWq6NsMnECt7mzZABKvpDsiH/8mJ220j0Gc?=
 =?us-ascii?Q?iGjNbedJ9qAmp6J0Dwq8d3jp/D5FMfgSYbWAfEXpyVlxukXId2EFftPiaREU?=
 =?us-ascii?Q?Bfyu8WQHUu1dkFUMUp0rwAemgZCThGL2E2hsnWjEFON7l37+8tjSqUzMxAEO?=
 =?us-ascii?Q?jS/D6uek0fRW/360mqASkaTCr5/V3tlP5h37QRGxUb2O3svNlmKnsNBdCNcr?=
 =?us-ascii?Q?lgpUdCWDNftUENZ0BFEvrc7UFafCELT3m32mQpSH6/NuKwKIC1etGW5JnDTr?=
 =?us-ascii?Q?Cd3aMtOFQ9T0dXPJJf5gfWBMKBvFzudqvPww85VnCxk+p/JHUA4Xe67HUVbe?=
 =?us-ascii?Q?Ct6hueWmqFcDBmZBDq+liXXKmb/TU15uqtWRwQoBZVCZ6+YrH+wauiU4TYVK?=
 =?us-ascii?Q?iGwwiCl3ckQdbvqtmqPcgocwZdeaTKlODFSxq2KgLU0PNtKZhZ7eRYdJtHvy?=
 =?us-ascii?Q?BD4zfqyzpqjj3vUcab04xy8tNEJ6mLUnyXBszyA2boFAb0iS4fQoRgweghsq?=
 =?us-ascii?Q?uh5+AkVgjnO8UaU00BeLam4zUxyvFxX27UTjtwuOTgz4qKed9bcNex423M6W?=
 =?us-ascii?Q?L6pqoJClNIGHpGCm71QZSISWQcb5iK1aw51AJaoYAsfmFcFov/fVF+v6rUqG?=
 =?us-ascii?Q?tsGFi76NhYbpIOqd+ASsJr6EbUd7j6XZsW+wPbCDGCsbW9DJq7gtoHZgiv4T?=
 =?us-ascii?Q?99e2JBD6aSoLLkJoXnotxhlpPBpOt7n59nyW66GZmajLUXxtrQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:50:20.8870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bbcffd-33d7-4019-18d0-08dcfa7c2098
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why/How]
Move the wait for pending updates past prepare_bandwidth if the previous
update was not a full update to reduce the average time it takes to
complete a full update.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8a52fef46785..7872c6cabb14 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3835,7 +3835,7 @@ static void commit_planes_for_stream(struct dc *dc,
 	dc_exit_ips_for_hw_access(dc);
 
 	dc_z10_restore(dc);
-	if (update_type == UPDATE_TYPE_FULL)
+	if (update_type == UPDATE_TYPE_FULL && dc->optimized_required)
 		hwss_process_outstanding_hw_updates(dc, dc->current_state);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -3862,6 +3862,9 @@ static void commit_planes_for_stream(struct dc *dc,
 		context_clock_trace(dc, context);
 	}
 
+	if (update_type == UPDATE_TYPE_FULL)
+		hwss_wait_for_outstanding_hw_updates(dc, dc->current_state);
+
 	top_pipe_to_program = resource_get_otg_master_for_stream(
 				&context->res_ctx,
 				stream);
-- 
2.34.1

