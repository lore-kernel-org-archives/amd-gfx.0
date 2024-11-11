Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3227D12D60
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 02:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8361810E410;
	Mon, 11 Nov 2024 02:46:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Rtmjdl3";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A099910E410
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 02:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dT3eyIzYh9RTT++p/6BGQFuBLoIMH4WewsVKkqwesyuDLcn50wxHTKjbuOAo3OzJlJWGPcMIWOaZWyeuQ6nCksODaO0hz7/a3UTXoQ0LJQq6Wvz0euVJX5XJhfqaRJGZFxmYnzPKBhA2YlGg0L0FSxInQQhn1mEP0VDTWrflz7+2gmRIoxPIqGhpeO7phgIwSJf9ZvZbwE/qR/HsoZu5yK7dH9mZ8ERsNvgPIusoMfGRB+KXm1yD5jCBAMQ3rd75FTtZ2NeWQaoyQDfdrGSSZJCDpHuTgBqirChjRmCB3tHZF+n2Dmx7zS4ZHuDKJXqvuNuTikr/1K5tPNjS2La2CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htm9ay1EqBLs8vG58vjY4ZdfA0Sk1wGsV/HXdVpeTtU=;
 b=fK7d7U+E5vP1Lv+XcDUk8EHbLl6mURTZ4MDlTdMBC4v4qT5OKxlliUYi6AYTURIlJYFCguBxqNhZcvyJ1unlImX2MAD5E9N3zoqvdVZulXSqNg7l3fnibcIVQ7FjLeHxBT1apVfhJScVuV0IHm7JvwBb6gFZqMd8GNsHTsbRUgbrxi5teeiumqgIYZgL9lgb0DJrl9Ghex9CevuZpE37CxG5PMvE3dp700NxH2Fu1Wppdy2ib0fpjgexYclQT8r22h1UWBHpFfqO5fbYueUY/Hn0zHN/O7X9IJDAjr/plVG/8gDixSx/LZx56zuESe0tT28E0ag8vhKTOA8Z6Mj3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htm9ay1EqBLs8vG58vjY4ZdfA0Sk1wGsV/HXdVpeTtU=;
 b=1Rtmjdl3OLC2xmLp4AeKtbSfp3Ui/S292HTcXbaRRl28dEqd8KYJxfFTWLP6w1jnWn9KQobBN+tQZ7DvTSnWa6oDGPr5lMqQzflSd/qvhD3TzLYbkljSmZRlChmlxiVMfnu1OGdyY6bfhBmKEVnlScmRrVTTUyX2SO+Bc1FTobQ=
Received: from SN1PR12CA0073.namprd12.prod.outlook.com (2603:10b6:802:20::44)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 02:46:24 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:802:20:cafe::c4) by SN1PR12CA0073.outlook.office365.com
 (2603:10b6:802:20::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.25 via Frontend
 Transport; Mon, 11 Nov 2024 02:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 02:46:24 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 10 Nov 2024 20:46:21 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: Add 'inst' parameter to kdoc in VCN v5.0.0
 functions
Date: Mon, 11 Nov 2024 08:16:08 +0530
Message-ID: <20241111024612.1881727-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ab07cd-e002-4fd5-9728-08dd01fb0837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0hEeWYyRXBsLzlVYlo0UVpvdHhKdmlnKzB5NllVSXJQZlIwUFhieDFUMGRM?=
 =?utf-8?B?eVhDM2hVQmk4ZXJ3VFRZQnpiTWdsV3NFQVlhU1V6bzltVTFJbUVFUnh2TkVQ?=
 =?utf-8?B?UElzZUdydW9jSUg0S2dpRzc2Z1ZIL0t4eExML0JxcUZMRnRsaEVmczJxWnVz?=
 =?utf-8?B?cnVab1RJeUQrbmVUd05UT1Rpc0Z6ZkFjU1JPd2ZrcGV6YU8wWnoyMHNDdlNY?=
 =?utf-8?B?elFWejliS3FEcEVJcGdVNzZ1aDJLRDdEZjV2VXk0RGt5eTdWcFFkaFdtSnpL?=
 =?utf-8?B?NUdWU21JSXRrTGlTTnpGVU84eWwxL2J2SnpSQ1VxN1JuL08vRXB6WU16UGpn?=
 =?utf-8?B?L1RZYUc4cWtKUkxUWjBMRGVubnBHc2w0OU0wSmh0UXVjVzRTVUFteFV3UU81?=
 =?utf-8?B?Q20ydVpJN0lCNFlIbitwc2ZxNnd2cG1IMm9qS0xWMGlVTDMyeDV0Nzlzd1ln?=
 =?utf-8?B?MExxVmxJcWsvT01mM1NVLzJXYWhXYm1YSVJ3OExKOUkyY0FKa1NUaGNoOXFo?=
 =?utf-8?B?WXlDblM5Z3IxakM2Wm5jMGtVTWdDaHh2ZzBLTC9XdGdBbllNWHY0UWdmY2FJ?=
 =?utf-8?B?aXlJcmNBTjN6dTJJck05NVF4eEVMcUVaUGVrZUF5aHNnZGRaYkJLbWtrRVZ4?=
 =?utf-8?B?c3VvR0R1RlVPQ3lHbW11MzV6b1BkcUp3Y1VZYkpmRC9rRXVhLy9Vd0pZS1dJ?=
 =?utf-8?B?OVFrd2hPMlZQQmdwa29uT0lidWhqbmIxWXF5Z3NBdGVzVHFkTWg3WXg3Njdk?=
 =?utf-8?B?Tlp3RlRIVG43VTFqQ01id2lPSTUxWnJTajJEK1I0YTVYSkx1akVzd0JSclNk?=
 =?utf-8?B?dE9CdTcydGg3NVFtcG5WU2tMYkdKN0w3aVluK3h3YkxDbTFuMkEzUFRjbzhR?=
 =?utf-8?B?bExuOE9TY2hjcVdxOU56VVBxbjBSVUoyTUFXR1RKUEZqK3gyZytwNUNib0xv?=
 =?utf-8?B?M2VyeDZQSENrektjTldjY3dCZ1NaQVVja1loVmN6VHc0eWhyTHU1OFhIOERL?=
 =?utf-8?B?Y2lYRC9xYW43Z2tUWEtVM0lUcy8yQWFXeG90d3A3OFMzY0VzSDV5VUZadks5?=
 =?utf-8?B?ODdGVGRpNXZWSFF1bHZMcTIxVEdLSnRFcm0xenJPS0FPQmNFTnIzUy95bGt5?=
 =?utf-8?B?OGNwVWNrSWFSeGF2RHRNUWNUZHprMzJwcmdLMk9FZi9vNXBPL3cxakRSUGRV?=
 =?utf-8?B?WTBsRmYvUUVWeXFMRyt6a2luejJDWlRLZ3hVVHRhOUhlS2cwdVFidy8vRjZu?=
 =?utf-8?B?Yjd0RHg2eUhBMFQ3a0ZsN1F5UmhmSFJXcmRYbllvYit1cVA1ek44cFVRZGVp?=
 =?utf-8?B?QUtZa29KWHVEbTR4Sko3N2NpN0UxbVJGckY4ODZUeTg1eGdSS0J0enp4aHFl?=
 =?utf-8?B?WDUrTmE4ZUFjVDFLajRjcFR2TGVnRG5WQmE3d1E5K3FRR2JqVUhUVGhvckF6?=
 =?utf-8?B?UnNadUlTd2w3RStGWDlwR3l0d2FQR003YlVWN2laV2JRQ0VWRk1rdjNIay9q?=
 =?utf-8?B?MWpnRTk1cWtseWRMWGFUN2dnOHBwbjY1N09JeU9OTGJnTmZodGJyTGd6RmVQ?=
 =?utf-8?B?MnZUU3gySUowcmorMm9uNkdpd0UwQ0RmM0V2cXBhWnkzTWxhSEJFTWJ6azUx?=
 =?utf-8?B?Z0w2V1pCTDJsU3JJSkxzNkZMOCtVMlArcEh5TkhVQVBtSm12U3U1dkhOTWhq?=
 =?utf-8?B?SFBPZ2pQcWIwdUJGQStWeXRvRVlIbldPS2tDSWcxOWpvTU1RU2lYclhtQUdV?=
 =?utf-8?B?VFJOYkNjTS9wTVA2V2pkRVBHMGIyNkxZRjNwWjNUb05ySHBPMjlIU1lJS2pU?=
 =?utf-8?B?M25CWXF5SU1uNXF6ZVUvelJvK1E3TkdxeEFteC9IUUpIc3lIczZGR0E3R2x1?=
 =?utf-8?B?aDc4KzVuOTdZUEt2cVJwS0xtc2Q5Sm9aem1KM3hQb0JkaXc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:46:24.1195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ab07cd-e002-4fd5-9728-08dd01fb0837
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471
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

This patch adds the missing parameter descriptors to the functions
vcn_v5_0_0_start, vcn_v5_0_0_stop, vcn_v5_0_0_set_unified_ring_funcs,
and vcn_v5_0_0_set_irq_funcs.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:767: warning: Function parameter or struct member 'inst' not described in 'vcn_v5_0_0_start'
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:949: warning: Function parameter or struct member 'inst' not described in 'vcn_v5_0_0_stop'
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1165: warning: Function parameter or struct member 'inst' not described in 'vcn_v5_0_0_set_unified_ring_funcs'
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1331: warning: Function parameter or struct member 'inst' not described in 'vcn_v5_0_0_set_irq_funcs'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index a72de204f130..66447e8459ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -760,6 +760,7 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
  * vcn_v5_0_0_start - VCN start
  *
  * @adev: amdgpu_device pointer
+ * @inst: instance of the VCN block to start
  *
  * Start VCN block
  */
@@ -942,6 +943,7 @@ static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  * vcn_v5_0_0_stop - VCN stop
  *
  * @adev: amdgpu_device pointer
+ * @inst: instance of the VCN block to stop
  *
  * Stop VCN block
  */
@@ -1158,6 +1160,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
  * vcn_v5_0_0_set_unified_ring_funcs - set unified ring functions
  *
  * @adev: amdgpu_device pointer
+ * @inst: instance of the VCN block for which to set the ring functions
  *
  * Set unified ring functions
  */
@@ -1324,6 +1327,7 @@ static const struct amdgpu_irq_src_funcs vcn_v5_0_0_irq_funcs = {
  * vcn_v5_0_0_set_irq_funcs - set VCN block interrupt irq functions
  *
  * @adev: amdgpu_device pointer
+ * @inst: instance of the VCN block for which to set the IRQ functions
  *
  * Set VCN block interrupt irq functions
  */
-- 
2.34.1

