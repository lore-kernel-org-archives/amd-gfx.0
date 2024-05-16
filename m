Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB0BC25B79
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F163B10EDAC;
	Thu, 16 May 2024 19:27:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gJuUJg8w";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 067EA10EDA0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QB+Kwg/w48jubD7ab6V34C9NHPfm2wgq2MOtVWYFv5zBKaBOWbr+OPpUtVP8hQQNZ4eRkH/P6LhETEju+OIEuDLtw8AE/EQF1B+w02ybStwoCZnjxgLVZ8rySy0dke8iVIXsuxFxdWNYfzsGdrhI8ySJS1JEm4Ty2qE82f4UrAOBoK4uKY68/nvaLHKiogbn9IhDuEP4dDPpoXFk3HqgPnJrrPDHm+4kGVfGNKgtsoCQnICy+GpRF0IXr38mxHbXnY5kBhdZM+9F18i/UYe+TachlMc5rHjNiicosLYyIGnSlELyxeju5WvZoCw2uKxMkpC1wLO4p+//BCYqVJ5eyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQrjrgnndtXyc+jjFLFegc0SrPNXquI0BdfUi/RifQg=;
 b=kKJ9JqOL1kMyVx9DQLiO4Bqe+B12P9I8FY6gWa4MzYxPYNRRbSZxEepUCqZGpJd1cMCWXrtq1UxNInmYQ8YOoKpwSS8RHEOCToLabXTH98/aXss5mQfE5E6IIVg/nsFryYK9jQWxJykgWoFfPE/+Q2ppwUV69OB2FKQxc1vAct9TwpuWlGqKrpPejtmt6Izd6qgf0MpyYGEe8JtkGlTVO1ectEMSphXjvlW0drnBmTkyfZaKFEWuPVOr75+zfLb6JxKgEuFiGHDExU301R9vHSMJ1W71TCBc3wPbSeQDb2PqYvTQvQMaSKWHcwtZvO96H8SjGqJ6xtKzDTUzWngSwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQrjrgnndtXyc+jjFLFegc0SrPNXquI0BdfUi/RifQg=;
 b=gJuUJg8w0mBxiQ0FpQ8UbbuhGkHxtHToVQ/7tFHm9Z2zHUU9Ax2ogg0msHiKAvngho9n7OhHqarQHwscydvhhzgpU8fSzmiBwx8iRWjRzT/aFilio4CLi6M02sXqgdQQ/Vh7pqVY9mujlnhOnOD0BIHHw6k/6ZUEnHOgIwHtHzk=
Received: from MN2PR06CA0003.namprd06.prod.outlook.com (2603:10b6:208:23d::8)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 19:26:57 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::1f) by MN2PR06CA0003.outlook.office365.com
 (2603:10b6:208:23d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.29 via Frontend
 Transport; Thu, 16 May 2024 19:26:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:26:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:26:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:26:55 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:26:55 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>
Subject: [PATCH 02/24] drm/amd/display: Remove duplicate configuration
Date: Thu, 16 May 2024 15:26:25 -0400
Message-ID: <20240516192647.1522729-3-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: f67d9c9d-43ea-49e9-91df-08dc75de2696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mUx2PcmfwnnSy1B6lN7JZDFyTX4HcCNS+bbvzIKxSvi0CgL/e9hc/NZaDeDP?=
 =?us-ascii?Q?k+5Z2w0S3jrcOY1XrI3tcTGET49r9CP2oy9XZrZ4H+J5mc75il1KgQDkGEbc?=
 =?us-ascii?Q?t9AIAcPJMmF0JnEuhR1mVFJQdeWm29rRMTfFb2l8dpKdUslwG2gFuhTgtx73?=
 =?us-ascii?Q?SbvRb700OYYIshyTNFWLBRy6yG48/h7cZycK008iTtEHzOMIO2wsLwFYPCNm?=
 =?us-ascii?Q?GkUf3KpQq3F7D1LZ8ho7jzLOWZ5QR5HUkCqw54AYMU+/ZcBW/3DfZF4XI/Q4?=
 =?us-ascii?Q?0ZT3OxS227tBoFil3gm4ukNrW+ktLJ6j5yExXxW/Z3b4xRpo4VjIG09RDVsj?=
 =?us-ascii?Q?k0XIXf7lDp2M3ZjaqCRl8CW2QFyRn+H6HYYihCB4Yhms4xIYtL4+1cDCHtOm?=
 =?us-ascii?Q?FCN8bKX7fwOqn0WNIYl8Hkrj8uqpgrcLsILBfA0iMBkHi58AZOMljYWfaRr4?=
 =?us-ascii?Q?aUmNZ36E4a1IdQI2fen6QOPC5Q4QKeBfQFn5eJs62T8K9nS5S1+Z31FIz21h?=
 =?us-ascii?Q?6XDvXSWc+viWsBvAHOxWS2idAAJrtSFgG8IDjUKrLxoHo8YE/MpvDTOqAI7M?=
 =?us-ascii?Q?j86lQJYrn/+MNDk6ASR5WEdnehqZ08rF1UDcxCE/FbjH6N2f8/IPGiMYa6sp?=
 =?us-ascii?Q?+iTm5iiTyx2NuOHfMhhBGHsRf09bsGxH/1TZ1Yjpzy182iX1stt3iKADuvWi?=
 =?us-ascii?Q?K/VanY7jmxAFIZ4Wh2lmHSwgR6eLbRQ0cvkiUrPgsoFJpl+JqazQC7aNHSHL?=
 =?us-ascii?Q?YoQun3/zGvL4OnpnP8ARYgkUiyXbP1MFmJGnSZp2GCSpIaXmnE77n3qiE5jZ?=
 =?us-ascii?Q?J97GuNciHpO5/+LhWxA4KPxGCtPcQY5pamKedemmIZvpkSlef1JO08wtoEeU?=
 =?us-ascii?Q?eK3ph8lQLJu9Lr0BL/HMMtVdUe1YQxjl63b2i9YDro97LSOLfPO8Z+ZsKmyj?=
 =?us-ascii?Q?HztXSTfRKzrdo4/Aaan5pQXm6NhJbdUqVXdDuvhKXMi/DIY4twBefSnQsCLl?=
 =?us-ascii?Q?ooQB/7TTz1/LZT0Gcl5Afi/SaMMkO2aj2xynGVRbwiROHVHVU2bAasey2dYG?=
 =?us-ascii?Q?vRh+2HhEpLGfYamNXzTuB5RU5Z9ajZW/lk0mItkHIuvF7Yq8CSWVQNb3kbro?=
 =?us-ascii?Q?oP1WIo++m5A2lYS3f1HRfUJjioLEGJfKYQn71t2WRQG1H94VofZCm1CLhrog?=
 =?us-ascii?Q?TtdnS1lvX3vkqZ0HepGCBMHdNh6Lx1qhoMXuZVkkvafwsUuT40jcGS/Q43iy?=
 =?us-ascii?Q?IkhwfqjCwhoQV7g0JKptk2FNvz8PTK2qP9Wkt+/nyPqf0o5uMZJMECuAzZBD?=
 =?us-ascii?Q?Y8R9+GTvH/mdFog0Zgt3OMJUWdsH1bL2Z9Cd5lbJEHn46cRGeHUaGMYgN4Sb?=
 =?us-ascii?Q?qSHdLG8XW15OZAegNYmV/m+Ahbjc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:26:56.9890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f67d9c9d-43ea-49e9-91df-08dc75de2696
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

The function that commits planes calls the same set of functions twice,
and in the case of the FAMs utilization, it is not desired to call the
dmub, hwss_build and hwss_execute. This commit just removes the
unnecessary calls to those functions.

Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6f534c2e76b7..ae04937e60b0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3741,24 +3741,6 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 				context->block_sequence_steps);
 	}
 
-	build_dmub_cmd_list(dc,
-			srf_updates,
-			surface_count,
-			stream,
-			context,
-			context->dc_dmub_cmd,
-			&(context->dmub_cmd_count));
-	hwss_build_fast_sequence(dc,
-			context->dc_dmub_cmd,
-			context->dmub_cmd_count,
-			context->block_sequence,
-			&(context->block_sequence_steps),
-			top_pipe_to_program,
-			stream_status,
-			context);
-	hwss_execute_sequence(dc,
-			context->block_sequence,
-			context->block_sequence_steps);
 	/* Clear update flags so next flip doesn't have redundant programming
 	 * (if there's no stream update, the update flags are not cleared).
 	 * Surface updates are cleared unconditionally at the beginning of each flip,
-- 
2.34.1

