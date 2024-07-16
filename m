Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F57CC3DA59
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 15:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE5D510E762;
	Tue, 16 Jul 2024 15:08:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n4D94Iem";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 626AF10E762
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 15:08:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v04DJut8YvS9hGmcAHBdRZFFZL6kWBgselLlmMA7Nsn49b/6bUVoDfnQHKL+6+P5he9rhRchveYhB6zDnaR/2f7RrzhsbNOS+HGTrf+LnsfWGXAQl0K+XcTNe4IzlQJWHy/phgQV9raSz2Cder/MgEXAOAMFo9nasqop9PmctNlwXG3Ms7QmtE/+LRNTFsfpZl8RZ9BLbgzQw8I8/Rzlkp1q0qLR81Wglt5E0iJyIdIQriaQwuVBUdQtsxkvTuIIexFkQFhCp/Aa1+iHnsTYBI6cb+kiVpnDWL4DdwpMg8PgLtXmL3GXUWVHZwdHxQWTnkikR+oN6EihyPKIwCdVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3DwMQDAylT71gfciQTGu4vYqgEhHMlmM36pps3QRUY=;
 b=tOVspvHdElLHijtC7jCwJ+33FfPARb+QZDLDSW6OI3H14A6qwvlZTCdTgmG0KuKEAM7G4cOGPbrFH4jHa6yYlR8ptT6OyLXdVPx293/LrXMJjRc0fzsckI2e/Mkkj7+gmPoipCA+tLaqNbIooNWPgpheNpYPygxHVp2cFuOAeoui2GVM+3VVxsT2qc9UpnKUOCPibT5XxD+KhAqW/MURd/uJl9Sdw8rwuBW9Kqqzh8e4vdJMHQlpWm+Za0MtVcRR7oVqtrVcxtW8z2FsVD7wb8Hsm50vGZ0FXmvnJT8W40JYqgk29q/4k17YkI3WHlInrvU8qjU9Re/oVN6l9Xfo1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3DwMQDAylT71gfciQTGu4vYqgEhHMlmM36pps3QRUY=;
 b=n4D94IemiXilOHg/UDsH4ETguajMMnMS3pouaR9yZzyiTMruECj55SXT+vsPgtqOAePtnt1lRbcvZeZwNcHci1e5L8J+OCn4gl8YFU9syyZeuiRxZ29GRMmjbiXcHqbUYjWH51wntvKNWcNqZI6JGTiTWx4C3EjaekzcDquNqrQ=
Received: from BN8PR16CA0025.namprd16.prod.outlook.com (2603:10b6:408:4c::38)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 15:08:50 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:4c:cafe::f) by BN8PR16CA0025.outlook.office365.com
 (2603:10b6:408:4c::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Tue, 16 Jul 2024 15:08:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Tue, 16 Jul 2024 15:08:48 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 10:08:44 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 "Tom Chung" <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>, Hersen Wu
 <hersenxs.wu@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Add null check for dm_state in
 create_validate_stream_for_sink
Date: Tue, 16 Jul 2024 20:38:28 +0530
Message-ID: <20240716150828.218679-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 91402ca6-10a3-439a-1360-08dca5a931ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YyaGiQ7QWGt7tfmXOmUJyoMrwYo0OB3e274A7EkULkPWU8+qleFZJ9heup2A?=
 =?us-ascii?Q?6lTw46dYhdH75UxWMbCE7NZSYlz378tIaghXWbY7FPyoKVhviUFZozBrxRcC?=
 =?us-ascii?Q?8ePJviTE4Lh0b5g9GynEIbQ7IUkgKi1/CdbFPMMbtKnD3yAB8XBGPvHwjb1s?=
 =?us-ascii?Q?KhzRsWSTsBkw4Dnt9hgyIE7BPe1FacSwCj/heYbroFV3PjZhjUU7pyI1dUEx?=
 =?us-ascii?Q?uzyFrRIDFaFM/12NAYn9MZY5jfy9SdAqMOpXkw1EbGtTftci798tpYXnxIWT?=
 =?us-ascii?Q?pC5CLQYuRZ96XUS9VrFTCrNWoEnc5b7ASr9P9SlBT6n9n3/1Lyo7k2jEsLwP?=
 =?us-ascii?Q?Mbehm8lFSXGBS7BrxfWIspWuKsZil3J7CDZ3eEDA0xSkN2d+F2lsJnl7BK7U?=
 =?us-ascii?Q?tUe/IeguQR8eSllvYq+o0l0IEsrEO5CDW7bhvqPuDtVy2khfDws4R5eklVOg?=
 =?us-ascii?Q?VSVRKFA8A9148q5YRbNSceyzk4/jDm4KvkAuzJBHy9o11ydyfAvs8lLmLxFr?=
 =?us-ascii?Q?UwUp8IwWn5UWBljyfTxIkUl+bgdbZyKa3IQe4MhloeQ/O5/ByxLBlTb8JAnS?=
 =?us-ascii?Q?mvWJSKBCVEb4k/SymsXYOcjtvRQgCHkxrcDeBSUVETTZ2Gm9joQZAEw0920W?=
 =?us-ascii?Q?vVsemDd72Q9iZZeMVb+K9HbI2gZQ0DwEH5oOtX9Ke+evPu1os0btlzk3e1qf?=
 =?us-ascii?Q?V5UizuOZvALHNs7zR8MfPTNDHZYGYPYDfwJJFJsVU/QYm3zY+bX2ImJT3Df4?=
 =?us-ascii?Q?KjqOXhMfnSQTqZLjFKPqQzyS4Mw1a5eoQ/TUvSuYiS04kFykOCNTpPSvpSX8?=
 =?us-ascii?Q?i1dn1SjocU6+Q/QFHg1l52p3XYlhUzEFeW5JRB4tlsrpbHDCki80whQr6eLT?=
 =?us-ascii?Q?NyS6NqE8fAkPzog/c8DVCCy6k6BVehdQX4TuvC5VG62INVp+VgSWVnWFYa9n?=
 =?us-ascii?Q?1IC0/qzRYHlXhmusBg+bme6+gf6z3fbkR/RzqWkT4c31d4z9ctFDNco2/7E8?=
 =?us-ascii?Q?ohACwLjDlIgx1pj5bzVPCYPDlc/gQ/XZo2dMmLicAC/nBkwZjnM0Z0vN6KhD?=
 =?us-ascii?Q?W55PL+Xo67ptijgKnroqjEHpbGunm/fV3RZcO8KnIT9da+P5hy2II0WSwBoY?=
 =?us-ascii?Q?ztmAvb6G0WLbw3hT1Iuupltp+z0VF3+gx6pm+h1zMkNRqF0F7G546zPFeJg7?=
 =?us-ascii?Q?MoGo1n5Foxk2ke/gRY0PK/Xc20ItJaz7tWgOLUtEYWB65F2U20c6ruaRnZOF?=
 =?us-ascii?Q?TtKZC0Nifv2YMzRychhL0WTu4MHM+hWeXbFUj0ZhBm4+baNOTW3aY7oYnOMb?=
 =?us-ascii?Q?xvr/kH9PsjKdILSm4IhEM3gWq3qiDCZypyzdomrOYWOu1z2z0o8dlyfJMifM?=
 =?us-ascii?Q?NxeWC6pAUilxvBFEOjvvcvzAMsHY9G11GFzybnvArTgxYJPYLmZx+JcVApEE?=
 =?us-ascii?Q?5XJx4C7rXttC6L55duS8IaoLVWYWR0xd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 15:08:48.4597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91402ca6-10a3-439a-1360-08dca5a931ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231
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

This commit adds a null check for the dm_state variable in the
create_validate_stream_for_sink function. Previously, dm_state was being
checked for nullity at line 7194, but then it was being dereferenced
without any nullity check at line 7200. This could potentially lead to a
null pointer dereference error if dm_state is indeed null.

we now ensure that dm_state is not null before  dereferencing it. We do
this by adding a nullity check for dm_state  before the call to
create_stream_for_sink at line 7200. If dm_state  is null, we log an
error message and return NULL immediately.

This fix prevents a null pointer dereference error.

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7201 create_validate_stream_for_sink()
error: we previously assumed 'dm_state' could be null (see line 7194)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
    7185 struct dc_stream_state *
    7186 create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
    7187                                 const struct drm_display_mode *drm_mode,
    7188                                 const struct dm_connector_state *dm_state,
    7189                                 const struct dc_stream_state *old_stream)
    7190 {
    7191         struct drm_connector *connector = &aconnector->base;
    7192         struct amdgpu_device *adev = drm_to_adev(connector->dev);
    7193         struct dc_stream_state *stream;
    7194         const struct drm_connector_state *drm_state = dm_state ? &dm_state->base : NULL;
                                                               ^^^^^^^^
                                     ^^^^^^^^^ This used check connector->state but then we changed it to dm_state instead

    7195         int requested_bpc = drm_state ? drm_state->max_requested_bpc : 8;
    7196         enum dc_status dc_result = DC_OK;
    7197
    7198         do {
    7199                 stream = create_stream_for_sink(connector, drm_mode,
    7200                                                 dm_state, old_stream,
                                                         ^^^^^^^^

But dm_state is dereferenced on the next line without checking.  (Presumably the NULL check can be removed).

--> 7201                                                 requested_bpc);
    7202                 if (stream == NULL) {
    7203                         DRM_ERROR("Failed to create stream for sink!\n");
    7204                         break;
    7205                 }
    7206
    7207                 if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_WRITEBACK)

Fixes: fa7041d9d2fc ("drm/amd/display: Fix ineffective setting of max bpc property")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d1527c2e46a1..b7eaece455c8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7195,6 +7195,11 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	int requested_bpc = drm_state ? drm_state->max_requested_bpc : 8;
 	enum dc_status dc_result = DC_OK;
 
+	if (!dm_state) {
+		DRM_ERROR("dm_state is NULL!\n");
+		return NULL;
+	}
+
 	do {
 		stream = create_stream_for_sink(connector, drm_mode,
 						dm_state, old_stream,
-- 
2.34.1

