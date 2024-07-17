Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419E8C3DA49
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 02:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAAA010E6A5;
	Wed, 17 Jul 2024 02:40:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2aDxEgfC";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB9C110E6A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 02:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiJ+wma7Rj8J0+JpUdYLll5eb0JQbRhmNyKDg9tVK1gNyNJg3OKSEAi9V8pHkQJCmCudLOHbl3hQCI0P4APkED9XcxtSMPXgGsZwUe/O10cYUq4vH5LYgWBLMm+WPWzd73bmYFyA8eYpputt19noJUTmN4tA6MsnFR5ZinwS81+ZvOgnloV7SO7m1N4ZQ9IcYq5DkE2o6sofs3jSwe/JZIfk4VhEWvm6mtAUblBdyc7aVwIZkzUuO/VSkxLokuuCxcNHGuElo9U+4g2MLyezkGNKLHJOUqxYDKikWasY4UKYJhP5ZwBHhhId5SRAWJtQnmt/oTP6kdwrKU5tf+pfFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYuxbl0h+Sn72VHGZOyyfd/qdg9MnkI/GUhPoph6X/U=;
 b=v2kleqKByJ/6dB26zl75W9Yh7/lp/MH7O+Nn+SpBUKJuM7IhzFVSiLF9wR6gWL0gfycgt0qx7VjkBZ3L4kfmjWXOdwz/gR7VjDrDry00urjXpaQ02ZnabyxTsUWCXUao+RTpe2uIY3hkdKzC4gXYZ2dXdY4FfnIatfXFE+VO0s1BXpuf2yiaTfAAzXxUqtSXOtzc5SV2Brcv3+ZKyLJ05r2WHK01Uh7HvJlO/ufR4BtO65T6qpkM4u1yqvCDbAWrAi5XUq1uREOrV1FrvrcyRsmefcKwmwQxuCBZA1gMwYSW2wDQSPzYLvJaYOAHHYydCcI4lNw87ISnDF6gTzWGKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYuxbl0h+Sn72VHGZOyyfd/qdg9MnkI/GUhPoph6X/U=;
 b=2aDxEgfCCwnUTw8nKafkEALQpmIFwCBu9iIAL5cXZJQ/CPyuFff5fl51geiz6VUxTgzGmD4lnNJvjGqQQceiWy2Ypm15/0ZGizI34kcH/WOsu1MTQtOHYxVEmawydBJ8p9pDBClyFsIIeaOeAtMKLBsixm69Ov5qSAcq0edFJ+0=
Received: from DM6PR13CA0071.namprd13.prod.outlook.com (2603:10b6:5:134::48)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 02:40:44 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:134:cafe::a3) by DM6PR13CA0071.outlook.office365.com
 (2603:10b6:5:134::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24 via Frontend
 Transport; Wed, 17 Jul 2024 02:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 02:40:43 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 21:40:38 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 "Tom Chung" <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>, Hersen Wu
 <hersenxs.wu@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH v2] drm/amd/display: Add null check for dm_state in
 create_validate_stream_for_sink
Date: Wed, 17 Jul 2024 08:10:00 +0530
Message-ID: <20240717024000.512972-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716150828.218679-1-srinivasan.shanmugam@amd.com>
References: <20240716150828.218679-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 765d2658-b50b-4e86-4dd4-08dca609db25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PvimCTE9Hqp/dVdddL3x5E4fCeQuVzI+Qz20qtvItaSV5ZMPktuL+VaddqQL?=
 =?us-ascii?Q?iOlqb0fS0Pgdmca28IpxxJnYTcUlGd31V4I3fm+G4THCdJHIMkgxZbKPf73Z?=
 =?us-ascii?Q?tbHu6GlGyWCswicjUlNVSNV8afaRpiPbGXkgrd44tMF72DOAgPq663BzK1iw?=
 =?us-ascii?Q?7aP1gtfyjj9fHTgEieXgNF9s7gkt4+34lq9fU5gMrN10yg5K927+EcQGXRnM?=
 =?us-ascii?Q?tNor+Wqsq9EUXw0g5Tl92QLW5NIgvnc6Wrxhbn/eJjmc6wRMAt1+0qqlZIpL?=
 =?us-ascii?Q?8zLa2pzxLFww3cq5mkIxh9K4ClTfaMYr52ILSKyyclJyDo4x/AODcRVQcUdf?=
 =?us-ascii?Q?EkOP2I1Uo0El+DK5JYhiYSZRvNncJN1qdGN2Cfk2/mSbmrGvzfsn5P2HKZLy?=
 =?us-ascii?Q?gnNX6D8d1bYvOX28XQJWL1EU0c7cfdIjqPB3dUhb5upAmrVLIyui/2fDFZ0x?=
 =?us-ascii?Q?Fq2uMXPBCuW3+u0PHB3SXRy0v9WkMblcOKv2vGy4jJtb/hBcNvCCWuqNBWtP?=
 =?us-ascii?Q?glAhvmxSrdCztF9P5SfIuCodI80uwTNG4mHxJ0wHeRGH4wa5O36PQiOFwy5+?=
 =?us-ascii?Q?GSJuJP43na2L0w3RaUDE8IU28EtCTgJytg29kdoDBgJHhQj9E8XED5eV5pK2?=
 =?us-ascii?Q?pHn/F9nEFxoQeN+NuXNkImUVbPHPA5LA72yqPdlTCnrlSU3eIit57y4r+zTo?=
 =?us-ascii?Q?3tzhyWYjwkjXeg8uHurvFNU2UtTP34IZJQuuD1HVXPMSisI/RhMpjRvcEwWg?=
 =?us-ascii?Q?G2e3LWnfjPfEWBSd3ppyreW9r3zdmPYGfkj6rkPXYqtz+mYznc6gEPdv8nIP?=
 =?us-ascii?Q?/5ayx5jDDxpAcbGPk+LA9r4PvzKuZN/X72kjrybA5mARVjpWy13ZV7zIAfEd?=
 =?us-ascii?Q?RG3POvlwt/oM3vbpU2mugRhkiCiy+jdKTAry2QTG+IoOqJV6fDT4WD0zjlpa?=
 =?us-ascii?Q?My1y5FMhxCSxazm+XFwV0b44mzImO4KnAUx9WSYuyALAz2syW4h8NpU0zx+C?=
 =?us-ascii?Q?xcSh4oVe7x8cf4G57bbjdDDPSjP+Qq5X75b6mLL2NekPJUORISZgbM+zrVqq?=
 =?us-ascii?Q?0RA3bv7duD4Al3+aZibkOSjj25YAKYVrMy5GfGVrrdX7P1LSpkpoivoa8t16?=
 =?us-ascii?Q?mw5VvyhgJyFdoU7Ic7V3dFDIWOV/zmktmTxMQxjbtXbDdJ7IH1il9Odm0lEb?=
 =?us-ascii?Q?2Vver5wNKP+bjiJGFR3GY5+cxtkAaV/WMula2TkCcyysNyPs1dTZQwNNcyNz?=
 =?us-ascii?Q?HPGxW8oLTNK6fq8PjPQalL+TvZp1jWCabb4ip2EEz4sbzGmPmh8ndOdnSIMe?=
 =?us-ascii?Q?ooiEvVqQBKs0qlbTk/1Xv6qUsyjS6Shfzf7AadYafNkT8sEoMf3ZNHbrakOt?=
 =?us-ascii?Q?2A9u1GqHrg2/HdTbV5x3sWKcHdu8MhdulG2+59LfeyxEcDfWwSzfgMmNCBXu?=
 =?us-ascii?Q?P8vZF04BSslTwPQ4taf1sQJjoxIaXqmT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 02:40:43.9776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 765d2658-b50b-4e86-4dd4-08dca609db25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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
v2: s/DRM_ERROR/drm_err() (Hamza)
   
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d1527c2e46a1..e7516a2dcb10 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7195,6 +7195,11 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	int requested_bpc = drm_state ? drm_state->max_requested_bpc : 8;
 	enum dc_status dc_result = DC_OK;
 
+	if (!dm_state) {
+		drm_err(&adev->ddev, "dm_state is NULL!\n");
+		return NULL;
+	}
+
 	do {
 		stream = create_stream_for_sink(connector, drm_mode,
 						dm_state, old_stream,
-- 
2.34.1

