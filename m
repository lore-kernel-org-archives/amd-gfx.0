Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37700E7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 12:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D152310E32D;
	Fri, 13 Dec 2024 12:10:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T31zqNen";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7196110E32D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 12:10:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXOvQFuNl8tXUUZGxSBsINQSWHqOPcEahbgasNj6EhZ2WN3s2XZBb0LHm/pMR6nlbTfAaSr1pfJct9Xdlt6N0K5fwMj6hAvUEKsDrP2xswYXO+FJRbQVPxDnZHkvh/yXkvGKi9bBCJEePU/z0FOv9j8a4n288p1IY4E52PfmW24UrbCc+W1Aewfq5ANhbFU7OiNeYCy+SO+WHi06qoiZi+1doL7SIRTCwAEvwmzjcXSTu3ZISxcjMLdobFrSGsFOVdwZSjjzS6PwsQiVG825mzAiZHRln2CuzXlg79gHYP5Vajr/JqF9cbjfF6Jqf+zX3P/IKiaSCoc2+j1d6+q7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvtixz754s25jNy+UM73PoIXxb6aTEob0zXCduusim8=;
 b=FJxYK2bGHDpEOSz48BrhhHPa8eXlHwrFF5uS1DHXU3gnInzIFUYHTtw6dyMzbyxLMkaPMuaRxEJmPKZ9O+apnVzUs4QSfl71iov6Qg+VulPIrkWVYIxOlZIMIqIdGp1bWUj8CX/yD7i1l/6IQkTuZJ6bRLU5QZ6nZCu95g4lF6XyPOIbXeaqe0MXS/Vae+DOnTNEEDMdCFodJktF7thoJxa5pqOjQnja9hjqMa8Ge+Q2Cj0GrApju24bGICOfwzhQzIPiVuqZzOC5aAvcrcJNw85E1+Ugx0cX6osct/gc7lsnOjHzaeTloawu/2Vp/qKap4qn1jxlbe7vlQGXyEWFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvtixz754s25jNy+UM73PoIXxb6aTEob0zXCduusim8=;
 b=T31zqNen1dvpdb/P8Jt9GVK7wNwPDLC3LT5173cXt30eXofXoa7Xy6KAmKARgk4w2sAradxVGRifTrj40EK1Bx780p0r/u5rsjED5wAvO5CTb+sYOC5qm/lDoknV+rSAnKEHdvCeyYRidzwV8zGHLczSNhwre18f7xwPJOZy8xs=
Received: from DS0PR17CA0015.namprd17.prod.outlook.com (2603:10b6:8:191::23)
 by DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.18; Fri, 13 Dec 2024 12:10:42 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::5b) by DS0PR17CA0015.outlook.office365.com
 (2603:10b6:8:191::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Fri,
 13 Dec 2024 12:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 12:10:42 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Dec 2024 06:10:39 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 "Tao Zhou" <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix error handling in amdgpu_ras_add_bad_pages
Date: Fri, 13 Dec 2024 17:40:19 +0530
Message-ID: <20241213121019.1385312-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|DM4PR12MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed190b8-0276-409e-a0a5-08dd1b6f2a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzQ3U0hsMWV3bU1IdTBYK2c3M0FEbEFMZEpsYVRGaFpQRnQwN0NiRHg2TTlz?=
 =?utf-8?B?VlJuN0FaMEhZN2NtcFRFUTNTZlpxUktHOEs4N2hNSEprejFxNVJuRzhmRUJB?=
 =?utf-8?B?VjZKcHBUQjBhQ2MrM2xxUjBWY3lLS3dCZnYzMll3TVFTcmJ3eXlmTGxXSGJC?=
 =?utf-8?B?SEJpeHhWTTFLYmxJWXBya2k3ckUwWFdzemZmajl6SXlkSk1HKzRzSGRhSVlQ?=
 =?utf-8?B?clAzUmYvVk5VVytpdGNpOXRSL3UrdEdyL2FqOVhKK1Z3WnQrVmhzRUxNUWxm?=
 =?utf-8?B?NFhLWjFaT1NhaEtmVnRRTCtQMGJmYi9jOG9OZDkzVUhuWis1Q1A1Wk44ZStF?=
 =?utf-8?B?WVhlUDdVdWozenBHUEFlL3N2b2NzUlZCdzE4REZvN21TelFyeVQxQlhUMG5l?=
 =?utf-8?B?aEwwQXg2S0c3NmtiUDVkU0hyaDZHNHY1SnNFNlFRK0VaZGFPZVNVWVNKTmp5?=
 =?utf-8?B?T2dIc0lWY1FpKzEyS3ljaWRWVzB3ZWJlYW4vWElOaS83c3g0QTB3KzE2N0tl?=
 =?utf-8?B?OVVrZ1l3TWxpM0JJUGVRczBvYksvMUNGQmFiakpRMGNhZytPZGgrTGFYM2ps?=
 =?utf-8?B?QTdzazAwRUxOTlBYSUpBNzVOazBCOTBjU0JRbDduakxhWmsvaExIT3piWGlP?=
 =?utf-8?B?RDF3dklnaEJNNEtYTlNCeHA0TXIvZ29VVFRHZWNjb0hyMWN0a08zYWdSelNl?=
 =?utf-8?B?dzlvL2hiWFJicW9rVk43QlNDUXZTcEc3L0JvdytkMFVWWjJvdE9QOFhLVFh6?=
 =?utf-8?B?NUNQU2V3YU9DN1FDK3BXWHN0UkZjWnpRSFpKK21GTHNTU0R4VzJVanQveml3?=
 =?utf-8?B?eEhMV3dhL01OcG53RUNhL0NocVpjYzRycnJuQkFLMzRnMzZHK1FhMTc4eGxz?=
 =?utf-8?B?WGZHUW1BR211bVlyRkhPQUJGUXRoREZHMWQwakZDZExOQ3UrSklzbm4rZ2xz?=
 =?utf-8?B?RHdjbERaUkd1MGRqN2lyNEIreWRLS0tENFlnNG1xdUdqNUI4elJVd0F1cy95?=
 =?utf-8?B?MGYvZG8wSHZkQ2VwT3N1VjAyb3Vjb243a0swdHVwTmpFUStZUXV4bEsxaHVF?=
 =?utf-8?B?bjlVRjNhM3gzMWFJOVdTVmwrUWR2K0EycHNGWmF0V3cwQlRiMStwZS9NVC9O?=
 =?utf-8?B?VDNrRmwwRWVoS0dnRnV5OGYyYWZ3OVpyZCtWWGRVY2lMQU9pK1F6SEhtblZt?=
 =?utf-8?B?aHNoL2xrMzhyN0NJM0ZlSlRKNVdHcFV1VHhPZjQvZklTbXdoQ0NDemhubkVm?=
 =?utf-8?B?UVBkdTFiQWkzQVdqVG5GdU9hVlJ3cGtvMis3T1Nuam42bmpPT3Nkb2U2WUQw?=
 =?utf-8?B?cWQwb05IQ2MzUlZxMmw0YnM0YkhaTGdkZVFRWGFDeEVoajBkbEVEa09ESGdC?=
 =?utf-8?B?dGV2dGpxaERMVW9mUEswRkhmQlU0N2dldU9hNUpxTU03czZkV0lhNE5qNVll?=
 =?utf-8?B?Z2VTSG1jRnAyM00yckE2NW1kNHdQWUl1TmpqYk9JT3ZIdDFQQUR3S25NWHJT?=
 =?utf-8?B?NVJKZUZzdEtyL2YwZC95WGtNc2IxdDZYY0lZdGFISlozL1NhWDNaUndkWm5L?=
 =?utf-8?B?SEFWWXYvR0VubnJYalE1bk1EMGFQa1JPUDhNSEFaTXgxVDdYRFJqbjROd1A5?=
 =?utf-8?B?MHZ5d3pQS1M5MXFaeFVaemRMYXg4d1JhbHFsQ1pUOFEwSnNvM01JaEVRMFNt?=
 =?utf-8?B?ckhUQlhuNE4yWThuZ0N4MmZrQXhkZWVxQjRQOXdWMVRFODdLcWYzQjJqSXN3?=
 =?utf-8?B?Vi96VzIrUjFPR1U3TlBWQ2FPb0ZrUEFqWld6TnpNYlpaS1BiQlM1aDkyUXBa?=
 =?utf-8?B?QXAxMlNzVzlXN0dHUm1HT0FWOXVySHhDREI4akJaMVVYU2o3YlRuQUpoOGZ3?=
 =?utf-8?B?cmdqeXRPL1pObnVlKzVobjlrUTRiTWhXOExLVmNHU0pMcmREalp2U0ZTa25t?=
 =?utf-8?Q?yTNDR+uzrOjoOFciP2PrG5g2Ozmr98L4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 12:10:42.0500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed190b8-0276-409e-a0a5-08dd1b6f2a4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062
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

It ensures that appropriate error codes are returned when an error
condition is detected

Fixes the below;
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2849 amdgpu_ras_add_bad_pages() warn: missing error code here? 'amdgpu_umc_pages_in_a_row()' failed.
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2884 amdgpu_ras_add_bad_pages() warn: missing error code here? 'amdgpu_ras_mca2pa()' failed.

Fixes: 9fe61c21405a ("drm/amdgpu: parse legacy RAS bad page mixed with new data in various NPS modes")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index db081618e85c..2afd93156ef7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2832,8 +2832,10 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 
 	mutex_lock(&con->recovery_lock);
 	data = con->eh_data;
-	if (!data)
+	if (!data) {
+		ret = -EINVAL;
 		goto free;
+	}
 
 	for (i = 0; i < pages; i++) {
 		if (from_rom &&
@@ -2845,26 +2847,34 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 						 * one row
 						 */
 						if (amdgpu_umc_pages_in_a_row(adev, &err_data,
-								bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
+									      bps[i].retired_page <<
+									      AMDGPU_GPU_PAGE_SHIFT)) {
+							ret = -EIO;
 							goto free;
-						else
+						} else {
 							find_pages_per_pa = true;
+						}
 					} else {
 						/* unsupported cases */
+						ret = -EOPNOTSUPP;
 						goto free;
 					}
 				}
 			} else {
 				if (amdgpu_umc_pages_in_a_row(adev, &err_data,
-						bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
+						bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT)) {
+					ret = -EIO;
 					goto free;
+				}
 			}
 		} else {
 			if (from_rom && !find_pages_per_pa) {
 				if (bps[i].retired_page & UMC_CHANNEL_IDX_V2) {
 					/* bad page in any NPS mode in eeprom */
-					if (amdgpu_ras_mca2pa_by_idx(adev, &bps[i], &err_data))
+					if (amdgpu_ras_mca2pa_by_idx(adev, &bps[i], &err_data)) {
+						ret = -EIO;
 						goto free;
+					}
 				} else {
 					/* legacy bad page in eeprom, generated only in
 					 * NPS1 mode
@@ -2881,6 +2891,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 							/* non-nps1 mode, old RAS TA
 							 * can't support it
 							 */
+							ret = -EOPNOTSUPP;
 							goto free;
 						}
 					}
-- 
2.34.1

