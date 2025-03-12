Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C43FC282EC
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 02:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D677B10E049;
	Wed, 12 Mar 2025 02:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rgvdSxYo";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD1910E049
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 02:34:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6XVtzo++6lQbVufdPmVNZmZAsxknZ5Itgfyi/0beYy8woqiwOMFom36KQ+p0GUjaB0nq+sGxQew/EJQRShEWhTc+w1im7jjsg7M64okHDBFk9AUJ6KLroQ9xx/rnBVKfHQKCK6fD0ylQZMKSHcAkauZ9GWb0OspI0zyHnBoRILueCAGHzC8vuO/Fecaq3ULhEcCOtszPegKreI5DuabGx+kFvFYXQRCbHXeE3M7vS6kSE4wbRdqBjtGXR3SiJyIyaRUNwDkFPdGEjvpVqk4Az6nkcZrJZEwCmiI28o4diaDupZsvcwAZDBh0VIO2TkZmjmUpPcdaf8sTzipkqn++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWYSNpnWheRFGQS5cOteYduZFkMYP8A01TSHdHGrpGE=;
 b=S6shsWDsPBNzyJ3htlJjRWLqlhOqUM//NRDpQ32kMfvxuq8a0QN8XSF9hLwqTp4ks5sZVNeFpuYZGDWwsqpAKW0mRWXBaSmlClV0iIXrJvQ1SspnXmzKzjrgU8w76RcOBH6/fU4i3TH8OnuTvgkIwXLC8wBkFwIhPLGAU3M3GlS3Xuqxvq2ZMQzgPpH65J2vF4P7lPKvx6pqilRVxFdKu5XxOpW2U6KXv4F9uC5HiIhLV5JXM67b8BoqKPuiGTSEn2ZvUEdDb0zpbzdsEATPcs5G0OE8b2udCrf9cKyvAz9VF9yRHe8NRGa0GqV+fleAngC+cXYlJrwnNZDX/tdMxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWYSNpnWheRFGQS5cOteYduZFkMYP8A01TSHdHGrpGE=;
 b=rgvdSxYoOjd+UUO6yhyh5R1Eh+SGrExlSUNVmo1ZZyVkO7zLDc/kfF/7jFytLs3pFXuSxNpMXjS4lfcI+IbUIdg1tJ/GyVAlqaoH37eXe4OgNQkcw3fajd186brte4dj+94IrBMnJd0FtS/5XX8an3SUqpj3YFHoM+/V2j8gdpk=
Received: from CH0PR03CA0036.namprd03.prod.outlook.com (2603:10b6:610:b3::11)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 02:34:26 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::11) by CH0PR03CA0036.outlook.office365.com
 (2603:10b6:610:b3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Wed,
 12 Mar 2025 02:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 02:34:25 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Mar 2025 21:34:22 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amd/display: Fix NULL pointer dereferences in
 dm_update_crtc_state()
Date: Wed, 12 Mar 2025 08:04:09 +0530
Message-ID: <20250312023409.2687233-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DS7PR12MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: d04a3f2a-e8ee-41b7-701c-08dd610e680d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QLQ8oSeT8NyG9xouF1nxwDxvQ3qzU/0Ye9JqQ4HB97zKnPnedFcvIyOps2u9?=
 =?us-ascii?Q?KAVpoyeJHQO4KSsUgCALWXMthuc2k32OmydrlEzZix4T3t+DifhWWX1jwv7x?=
 =?us-ascii?Q?zuWg2hVRe2c4bLc9V9wDcAUapF0sElGpYhCQiari4KSstvspTmr3ODuT5YtT?=
 =?us-ascii?Q?8kgEsVXK7D/oTPWsmXloDzw+EubIHi6jGTl2SVHDVPWxYLRpNyIOGufqSMrz?=
 =?us-ascii?Q?zD3Xrx5XJAO9SuEpfUOUwJx+qvE/5zRec9bdwIMgXUpYWoeS96Wr0IRBpU0O?=
 =?us-ascii?Q?Fm0GJOXSNwMXTQA4hzejzjPFVdOm9ZQAT3F+DmIlkYIYR5PcXEVoVQMX4Jaz?=
 =?us-ascii?Q?pJqRF29PqIfNA94mzDe7ZJEFdxf1KfhiDTe9qxAGFyHPwQAhHOihwAwettsi?=
 =?us-ascii?Q?Tvy96xz9vCtJD/I3GKjNrJi3wi7mm3TzjoI26Wob6a86/QVqtb1PkrPzCDG+?=
 =?us-ascii?Q?ToK0OYz0qodW4XNdwO6HvHPbdBQj6DFlVM3BwHbwqXYlmRqBjlAbm9BHGqEh?=
 =?us-ascii?Q?Zbsb4S5vZoLSl93t7f6bLTD02LM+xFCeFqqd+BkA3CuGWVks1LXR4gMfI9QE?=
 =?us-ascii?Q?pwKAjIu3ZB2jXlPRC7t8mWVIyXyhqaPRdgnodum5k4f/B8EYoTJ8m3Al5a04?=
 =?us-ascii?Q?pbngEolOInVMJ0LMecdxPEyfUjJjkMJbgpQU7PHbA10W9XRbRpzS6hhCAHyZ?=
 =?us-ascii?Q?Qc/NaSuKa/Gt05A4eAQ35XyQ03HZl0bIfmoYoHGCrF4xuC5kFs/7Dq8CIidg?=
 =?us-ascii?Q?xXxzXZJFCg+RGMvw2aDApqIp0A0VxtgLTas+TpEHX884mlptBvtTJmcciDkB?=
 =?us-ascii?Q?oAZtIEiCjr/8+5xRTiJUs/YAmf17MZrkrRArGDNLrSMnnHtqmHYub06425tf?=
 =?us-ascii?Q?8h2b6cgI1sbEWSc6uHKXRj27W3gFYaSWmhC7jOJo9nmfu9HoOrvy9ne29dsm?=
 =?us-ascii?Q?xDW9OWWTsuPceb1ibhq3GT8YXMcUAdrNneIcURnzfwg+8T8SNpzFrhI+29Sx?=
 =?us-ascii?Q?wgnIpzedcfMVkPKA0/MC2VlycfTpCSXhIwk4EERzRb4Ii1g/Pwchbdd6NY0F?=
 =?us-ascii?Q?NEyiVAeo0kBRLGXKjeDcHiKRgbrVUqtOOoPn813oxKwunqZo3h10gZXyvpT5?=
 =?us-ascii?Q?PpE+Em0WvjZynGyYyMIiiuuT17L08CiX2fLOKMhbWUpG0gdNMcUqVV9Amq8F?=
 =?us-ascii?Q?eevT2UBGaXiXsxWtU1/lpN0SfWuaL9eLhQDeF+UIR0SIl9DEQGYrU8vMjQ+U?=
 =?us-ascii?Q?6PzdcSFeonc9Hu+sWZZmAT4OUvBMWhjs3QAr9KJrTq01Y6Pfj4RgTiR/NPVK?=
 =?us-ascii?Q?q2Fv+kA+WiOzole9cIpZ9Oe7LppLqCJ8bjgrtoH/1301ewzNaVIlckCb+3Y7?=
 =?us-ascii?Q?d3ZDgFsayPwGY7lTo8iYgPcTh3BWs3TMCRp2NeKwSAkPndFmdZ5VCN+sSku+?=
 =?us-ascii?Q?oSh7kpxXs4WQfaRBPMioiJ/viXe6YkDC6ipk1Ek4SPScWhKLW99AYReQR/cO?=
 =?us-ascii?Q?iU/Uv0za23f1VlI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 02:34:25.8844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d04a3f2a-e8ee-41b7-701c-08dd610e680d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203
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

Added checks for NULL values after retrieving drm_new_conn_state and
drm_old_conn_state to prevent dereferencing NULL pointers.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:10751 dm_update_crtc_state()
	warn: 'drm_new_conn_state' can also be NULL

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
    10672 static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
    10673                          struct drm_atomic_state *state,
    10674                          struct drm_crtc *crtc,
    10675                          struct drm_crtc_state *old_crtc_state,
    10676                          struct drm_crtc_state *new_crtc_state,
    10677                          bool enable,
    10678                          bool *lock_and_validation_needed)
    10679 {
    10680         struct dm_atomic_state *dm_state = NULL;
    10681         struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
    10682         struct dc_stream_state *new_stream;
    10683         int ret = 0;
    10684
    ...
    10703
    10704         /* TODO This hack should go away */
    10705         if (connector && enable) {
    10706                 /* Make sure fake sink is created in plug-in scenario */
    10707                 drm_new_conn_state = drm_atomic_get_new_connector_state(state,
    10708                                                                         connector);

drm_atomic_get_new_connector_state() can't return error pointers, only NULL.

    10709                 drm_old_conn_state = drm_atomic_get_old_connector_state(state,
    10710                                                                         connector);
    10711
    10712                 if (IS_ERR(drm_new_conn_state)) {
                                     ^^^^^^^^^^^^^^^^^^

    10713                         ret = PTR_ERR_OR_ZERO(drm_new_conn_state);

Calling PTR_ERR_OR_ZERO() doesn't make sense.  It can't be success.

    10714                         goto fail;
    10715                 }
    10716
    ...
    10748
    10749                 dm_new_crtc_state->abm_level = dm_new_conn_state->abm_level;
    10750
--> 10751                 ret = fill_hdr_info_packet(drm_new_conn_state,
                                                     ^^^^^^^^^^^^^^^^^^ Unchecked dereference

    10752                                            &new_stream->hdr_static_metadata);
    10753                 if (ret)
    10754                         goto fail;
    10755

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1b92930119cc..e3df11662fff 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10727,11 +10727,20 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		drm_old_conn_state = drm_atomic_get_old_connector_state(state,
 									connector);
 
-		if (IS_ERR(drm_new_conn_state)) {
-			ret = PTR_ERR_OR_ZERO(drm_new_conn_state);
-			goto fail;
+		/* Check if drm_new_conn_state is valid */
+		if (drm_new_conn_state) {
+			dm_new_conn_state = to_dm_connector_state(drm_new_conn_state);
+
+			/* Attempt to fill HDR info packet */
+			ret = fill_hdr_info_packet(drm_new_conn_state,
+						   &new_stream->hdr_static_metadata);
+			if (ret)
+				goto fail;
 		}
 
+		if (drm_old_conn_state)
+			dm_old_conn_state = to_dm_connector_state(drm_old_conn_state);
+
 		dm_new_conn_state = to_dm_connector_state(drm_new_conn_state);
 		dm_old_conn_state = to_dm_connector_state(drm_old_conn_state);
 
@@ -10766,11 +10775,6 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 
 		dm_new_crtc_state->abm_level = dm_new_conn_state->abm_level;
 
-		ret = fill_hdr_info_packet(drm_new_conn_state,
-					   &new_stream->hdr_static_metadata);
-		if (ret)
-			goto fail;
-
 		/*
 		 * If we already removed the old stream from the context
 		 * (and set the new stream to NULL) then we can't reuse
-- 
2.34.1

