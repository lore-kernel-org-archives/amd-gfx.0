Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85428C25B7E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A157B10E61F;
	Fri, 31 May 2024 16:53:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BCY539QD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C737610E6C2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wlfw5O7F642itR1Dzvnroej7xQfeIHqpfnT5nO9P56VydcN+JHeEAv8OGWCvZvznQE7lXYepOWXfm2EhVSTU23Y9JoXLYnPY6zvuv2EQFVBFN5EblPHgK7QQCbdkyrXBnIMZC7wQt33yTVHBiVS5pO70zC0iulfbIxRqnO8A+WRVOm3n+LDd66OBxDmHqT+2+3uvaBa9EcQVu2EqwICh6F1WUPCPr3Qio66hQvu4MGRgbG5Usao2rSjv+au0WbZY2ak6Yuce6nYkyRZCQjEQMEA4HGtQLWhTBD/Je1KzcgRvVMVgfFfdz0vWbAOm9xHesODNmCJAaoUL4Y5jfAzbLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntnV055bx2Qchi5DawqeYH28wOPa74iGKD0QAd+tmb4=;
 b=jrrRLuVT3Z63KFgI3U8bqf6fsjzHzuohwSLC+yYVZBvk0RS0OabXQT9WXG7mehlPctg6Idnxnye6JZDubt4gIwJWvM4A/KYtB4sbhm8tkOMsjZSn7hkTHIZ+aCLjAp4XEwB+MPHKnkH677rtNkHh6kKwhbDrPPzxpe9vHR9lBP8kCVeoLNHXk8+Pabrxkk7wjbCodvlRG+eTgPsvWWIK+cObIZqy+FvZ84yh8BtLWIpWkESZDJOAtZ5w5lSNmIyWcp08PhD/OZXuGL9FrPwpWiv4XBbrVSaknGXKXqFc0HhiNT3O9WiP6rCiYWljyI6t5Mf0toGKEQpWMO9zIkONXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntnV055bx2Qchi5DawqeYH28wOPa74iGKD0QAd+tmb4=;
 b=BCY539QD/WUg1OPHAP0GWk7KW6PZiD8Jd8TRsM2s9Hhq6Ly8NW+Q/tTu/U0rIYa2bHJfeWxgP/Lnwk/byqIzKPIDGUkdGqkopgx+hLGhqkzTvurRLbH81bkNeX47F/3vPZLYyYOb3QXlWgfzE2LuKQYplQkCnCFm2QMobwnAtN0=
Received: from PH7PR10CA0001.namprd10.prod.outlook.com (2603:10b6:510:23d::23)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 16:52:42 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::ec) by PH7PR10CA0001.outlook.office365.com
 (2603:10b6:510:23d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25 via Frontend
 Transport; Fri, 31 May 2024 16:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:41 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:37 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 17/32] drm/amd/display: Prevent IPX From Link Detect and Set
 Mode
Date: Fri, 31 May 2024 12:51:30 -0400
Message-ID: <20240531165145.1874966-18-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: bb1c9c72-3836-480e-1f4e-08dc81921668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aEaWOIR63pJ7p9ECwif++4IkUyIMVE2X9dSchmB2XHhvOlyiZj079FQvgkfK?=
 =?us-ascii?Q?sgvJ2vqBWrsVhZT1bXzAfirUo/dBE7/FhKbFCiZWfNdTdWZ1uINF5NWW3HZ+?=
 =?us-ascii?Q?UAqS91D6ZieNflrqoF4EzEqr1t4Txev2aDL+PKI4TtMoodd/VOvPw5XDX0eC?=
 =?us-ascii?Q?LWJ8KSTUbYgFAuTMbvNFM6ymw0ufy+yZeObZlI9qYyw/W0FpFR5m1GJo3bom?=
 =?us-ascii?Q?5TsGPUgYt4/aBoTXkFVvBIvL2M2U/sLOqMHRhI8vCHKPTZAqWmBrz3zyB31k?=
 =?us-ascii?Q?JTN0B3tkSGKGsfN8SmDnh3Rybn5MW1CgoZ9RzKnvCobC9HTNQM7cxq8eri5f?=
 =?us-ascii?Q?o5KJNe/gR8u4hvMmHSkL1ZwoczT+NeWnieFDRMtyVQA3HqXT6v9aSEq2Czj5?=
 =?us-ascii?Q?gNEKldU35U6JFKjzB5w/lVqCsr3Zp7Yp1nBdZobhcvrFLoxDi9tX/MYiHL9y?=
 =?us-ascii?Q?ONsAIfFD64Mtgfh5qjF6vQMXnd4g5r7F0ptGSmBCEJ5N7RNp6WPzmYpbcHNv?=
 =?us-ascii?Q?wTOR9vhomqwmduhRbCPoFpNyE0mv68iBmnmkfpjTN07qRw+K4t3pAaKBrCld?=
 =?us-ascii?Q?/X7iBLwhnWNFUyBdAQW/uZQ8y9aUc4g1UOyHxiwk6Cqvm7TH6zSsqgNrRWbS?=
 =?us-ascii?Q?wu9hE2UTXt295fv4ZZxvf0uwIAXy5lwcdoF5Jq0rz1Vg7PIKlFId8yiLFYjy?=
 =?us-ascii?Q?Z9WAv+DA6PzD48ctJVfKRtTK1Q38rgqQFPdKBAeCmP3wWEO3ZLl/LfsWEoNw?=
 =?us-ascii?Q?Ux8qaIzHKqjrAfcbbCM2qUU1XKT/ZZju7YORwpMPFgPelLOgiByHLuqbtxQo?=
 =?us-ascii?Q?EFVC3+POVWQ1TrBTGX5W4BAwGN+HIi+7+JYVUPU5Geh9kKJkqZ/++FrAcdn9?=
 =?us-ascii?Q?ApPrePJtMgGWuDGhzw0brtAyEIdIFGB9glQ7NLeAfdLBCIIWLhEoCiJb4Gs8?=
 =?us-ascii?Q?QLP3EhBQcSOeRu6sK4A+PUGkU7Q5RjOQU98854Jyrme1tE7BuZwldwZlQNbm?=
 =?us-ascii?Q?ZPH5zLGzpEZrQ379QSXOCtK60V2gSG5Ra1fHctf2yoONGGZ3PoOxsLBBCLIP?=
 =?us-ascii?Q?EJtGPbZUwrY1NVt4H3V0kRLeghTPmdOuieVYCVHWc1ZSHBIiA6QNzoB+1J1Y?=
 =?us-ascii?Q?PVCPPiaBkwdVLY5NV0e7htnkwY8xsquslT9p3ZsaV1llmtWfYO6w7nfIpbce?=
 =?us-ascii?Q?EQetJZUW3VIX0yF7q8DiqBh9lqdCioCmywc89FTcFbpEpqKBUW9skdvCuKcB?=
 =?us-ascii?Q?Kazepb74BJggcB5j0qPvlo+7rdkYUHTBeEZ7ClDZNv7GbZ86aFs2Hedo7xk/?=
 =?us-ascii?Q?LnX5fs73HFBExwmtFJ2wQYA3+XAySpVtd20zcuNnVIkg+T+CLnrXSCM3haZv?=
 =?us-ascii?Q?9Dm8QTfAYYtjwlxhl3Gtbqr5kMyW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:41.9961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1c9c72-3836-480e-1f4e-08dc81921668
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630
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

From: Fangzhi Zuo <jerry.zuo@amd.com>

IPX involvment proven to affect LT, causing link loss. Need to prevent
IPX enabled in LT process in which link detect and set mode are main
procedures that have LT taken place.

Reviewed-by: Roman Li <roman.li@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 011981bee58c..ffc1e0172c46 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3097,6 +3097,7 @@ static int dm_resume(void *handle)
 
 		commit_params.streams = dc_state->streams;
 		commit_params.stream_count = dc_state->stream_count;
+		dc_exit_ips_for_hw_access(dm->dc);
 		WARN_ON(!dc_commit_streams(dm->dc, &commit_params));
 
 		dm_gpureset_commit_state(dm->cached_dc_state, dm);
@@ -3169,6 +3170,7 @@ static int dm_resume(void *handle)
 			emulated_link_detect(aconnector->dc_link);
 		} else {
 			mutex_lock(&dm->dc_lock);
+			dc_exit_ips_for_hw_access(dm->dc);
 			dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
 			mutex_unlock(&dm->dc_lock);
 		}
@@ -3505,6 +3507,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
+	struct dc *dc = aconnector->dc_link->ctx->dc;
 	bool ret = false;
 
 	if (adev->dm.disable_hpd_irq)
@@ -3539,6 +3542,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 			drm_kms_helper_connector_hotplug_event(connector);
 	} else {
 		mutex_lock(&adev->dm.dc_lock);
+		dc_exit_ips_for_hw_access(dc);
 		ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
 		mutex_unlock(&adev->dm.dc_lock);
 		if (ret) {
@@ -3598,6 +3602,7 @@ static void handle_hpd_rx_irq(void *param)
 	bool has_left_work = false;
 	int idx = dc_link->link_index;
 	struct hpd_rx_irq_offload_work_queue *offload_wq = &adev->dm.hpd_rx_offload_wq[idx];
+	struct dc *dc = aconnector->dc_link->ctx->dc;
 
 	memset(&hpd_irq_data, 0, sizeof(hpd_irq_data));
 
@@ -3687,6 +3692,7 @@ static void handle_hpd_rx_irq(void *param)
 			bool ret = false;
 
 			mutex_lock(&adev->dm.dc_lock);
+			dc_exit_ips_for_hw_access(dc);
 			ret = dc_link_detect(dc_link, DETECT_REASON_HPDRX);
 			mutex_unlock(&adev->dm.dc_lock);
 
@@ -4888,6 +4894,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			bool ret = false;
 
 			mutex_lock(&dm->dc_lock);
+			dc_exit_ips_for_hw_access(dm->dc);
 			ret = dc_link_detect(link, DETECT_REASON_BOOT);
 			mutex_unlock(&dm->dc_lock);
 
@@ -9298,6 +9305,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 
 			memset(&position, 0, sizeof(position));
 			mutex_lock(&dm->dc_lock);
+			dc_exit_ips_for_hw_access(dm->dc);
 			dc_stream_program_cursor_position(dm_old_crtc_state->stream, &position);
 			mutex_unlock(&dm->dc_lock);
 		}
@@ -9367,6 +9375,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 
 	dm_enable_per_frame_crtc_master_sync(dc_state);
 	mutex_lock(&dm->dc_lock);
+	dc_exit_ips_for_hw_access(dm->dc);
 	WARN_ON(!dc_commit_streams(dm->dc, &params));
 
 	/* Allow idle optimization when vblank count is 0 for display off */
@@ -9732,6 +9741,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 
 		mutex_lock(&dm->dc_lock);
+		dc_exit_ips_for_hw_access(dm->dc);
 		dc_update_planes_and_stream(dm->dc,
 					    dummy_updates,
 					    status->plane_count,
-- 
2.34.1

