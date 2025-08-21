Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8966ACA0EFA
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 18:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDEFC10E1ED;
	Thu, 21 Aug 2025 18:28:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZyV1bvtj";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96B8810E1DB;
 Thu, 21 Aug 2025 18:28:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5o2ZpKpKatI71szeVbzBESKjbVNUG1bJ+T4eUQUaZPT/Zn0ZsDWUi73qhPutq9FGSQXqMIW21Ne1lyNVUsM7VyrMgh+LlVMTCC+P3urX6xvomvPYL5ftJ0Sm+Etz1FeD3YS0qM8nkS7G0sElNGOQ1LkQlJj6rDpoSW8p9rKPTnMmjwRbwIf3cW2sKzpEqFH3t1t6LJCd+pNlfW8xEpNySS4Fao81HF2L07JKG9Rbh0QSmRl+9DDbvYus0ZmUhs9ToD6UaA59y+PfNwT+k3or6jA4vkDoI21MFTyUuo4UdyEAjT6ND2zX1sl2q7JM7VS48Lca/jbpYrSqKXr3U4nvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HONRa0Zkp9mhaB+2KSYxElJNtFv0jD2qP6liFbl2NKU=;
 b=u6VRreMTBpgt2UDno62yRPFxkoFGUq01VlyUzHiqp9SGToenmuNBq1JQQAOC04L0fAt4dzf3+33TfN3AnyZK+NHSZIj7kBmkUhq1PFOTCkbciSY1aFUhO+pxqabjlgWpM5zp5h/y9IQm2f5LM+qkvc+sdkFVSUP/pSRWghClx7Zb/LeAZ7Y/EHe3WISYBHYj80xlQinN2k6qDdg4Pi5a2BOFa9RddXKhINNCLl0k/GSGO6vFRB35rz3tvIlRBVFfgAtnprsURtVppS98ZMrX8Gqp2XVieBiFoXul9UPpqGOm/9pHvlfsdOCufPzNc94B0LWAnKLz0ysKUIvli2MvFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HONRa0Zkp9mhaB+2KSYxElJNtFv0jD2qP6liFbl2NKU=;
 b=ZyV1bvtjdVH9KMygskxm2XW0pE7dsXeTZBe1uhI6LKhsIi8S0kJHToLQHc+BHgPjko2sRB+WO9u4dgGzhFtWAw+OOTjBdvfGGDQtTNF5guHgFXmMmYDvYZoePjXbEL80rVSKb+2caAaB44hxEisXvWFzrL4cm62UKePCVJOLP3Y=
Received: from BN9PR03CA0076.namprd03.prod.outlook.com (2603:10b6:408:fc::21)
 by CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 18:28:21 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::42) by BN9PR03CA0076.outlook.office365.com
 (2603:10b6:408:fc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Thu,
 21 Aug 2025 18:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 18:28:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 13:28:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 11:28:20 -0700
Received: from [10.254.35.236] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 21 Aug 2025 13:28:19 -0500
Message-ID: <b223fda0-ccb0-47e4-88cd-aa7d4be719ac@amd.com>
Date: Thu, 21 Aug 2025 14:28:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i-g-t v3] tests/amdgpu: Add test for native cursor
 fallback to overlay
To: <IVAN.LIPSKI@amd.com>, <igt-dev@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <amd-gfx@lists.freedesktop.org>
References: <20250723172754.2721348-1-IVAN.LIPSKI@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20250723172754.2721348-1-IVAN.LIPSKI@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: f4602370-a73c-42a7-d925-08dde0e081a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|42112799006|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUxYTE52OU5pZEV1K291a3p1NENFK3hTdHZ6OVhoZHNFZ3F4R3d2Y2ZUTDM3?=
 =?utf-8?B?RnJKUFIyNDVxc05iSC9ZUmpickF2N3lUV21rcnVjUXZwWjhoOEpFVUE3dGVD?=
 =?utf-8?B?THU0VGZJbW5PNnpKMGxYQ3UzYSs2aENTUzRJN0I1ZllJTmNDUkpNUjNhSFhB?=
 =?utf-8?B?NWRNWk1veDJCRjFrWUJxcmhiZTNERGdTVjJqcHIwOXY3bUFDVGxGRXhXWlBY?=
 =?utf-8?B?NGRQZG51SExBRlVxTytKM3BHYmZkTlh2cnVLa1dDYkRqS1ltQUtiREkyZVNZ?=
 =?utf-8?B?bm82bmpkWHJNU2lrV1h5ZEdZN3ZHYm50MzRDMEtmYURycXBSMU0yTUkxV1FR?=
 =?utf-8?B?N0lmWE1hZHJ3dkFrU1N1S1k4Q1VYSGR4OCswNXB2UkFaMUp1RFRzYlQxeGdJ?=
 =?utf-8?B?bW1WaDFNaW41aTBpWlVBODZQbnFIYUxCNFE3WEFyc3B5RUt5c0NKTFBlK3M1?=
 =?utf-8?B?ZFdkSDFFem1MVGNFVFNzNFNCV2p6bEFUZEErcnBDRlN3aUozdDIvNElZSENQ?=
 =?utf-8?B?TkluU0lETWt5dFRhZzYycjVia2E2ajdKdjJvYlZrQmhtdkJ3NVo2Z0xKT3Q3?=
 =?utf-8?B?TjlrVHp5NDFpMitFcnZSU1RWQzFSMnNJejVSWWxlM2NlUUM1REJNRWtDbjUr?=
 =?utf-8?B?TzNsUm51WFAwSWkrUkZoV3NneTNWajg3bTVmK3BUUnQyQ0dZaExqRmloNXhm?=
 =?utf-8?B?SGEzUFltVHB5SUowc2tURVhaM0lpQ2xGdUliVkdYa1dZNXRhUjlEYllaQ0FL?=
 =?utf-8?B?bHdHYktzeGtVVmpUOTkxRkY5Tzc4Q0RlOUkzc05MQW5DeHA2RWlDZ1RUcFRN?=
 =?utf-8?B?Q0w3bXlBQ2M5OUNkMWg3eHEyWFMxM04rdklTZ05QcjYrNG1tcFlTN2JqQW1D?=
 =?utf-8?B?RnhweGR6cUJBMkNZY0h6Y1p4aUpVUndnRkpXMzEzZmRMNGU4bDlEdEhtQlBM?=
 =?utf-8?B?STI1VVJvTXBPdWY0SERLbWFraHBKVEJ1cEVVYThaZ3YzVXBnZjBFdzhMdHhU?=
 =?utf-8?B?T3Z2anU5VlBYY25XMFVSVkduU1RwSFpmMy9sWHloZ0VxNWZwMnRSNGNMZ0ZO?=
 =?utf-8?B?VFpYZkZoZmhvd05wTi9kWG5pYUt0RDgyMXhDMVUrMU84R3p3cE9MZFpZSHdy?=
 =?utf-8?B?OTVHVEpXcTBIRStzODFBU3JlSk5jVWpNdVJDaDNWd1MwNGhBSXJ5UFpTS0RN?=
 =?utf-8?B?SjUxVWZaRk9ENXhQTjdhRU8zN2JaakprbjJtWmJPdDNZb0lyaFFsT09xWUp1?=
 =?utf-8?B?ME1OT215alBDM3IvVFcwVmkyUkhnejU2V3JUVjhsblozd1drUkNST2wvZFEy?=
 =?utf-8?B?NFgzZ0pCRWVKQ3hydHA2d2YwRUsvMWtDM2JscFF0N3hpT0kraEw1bGYrTEty?=
 =?utf-8?B?d0pYNUN3SWx5TDh4VlU5QlBYTVI5cTg1cU5iMmcxVEJQTVN4TGxyTHZYRVEy?=
 =?utf-8?B?cUJxdWdIUVhYSWZTcnNxWnVxWmRQYndGaHpPUG5ORFMrZWErdXNKYTJmNFFB?=
 =?utf-8?B?WkxpRDdKSVBQbFZNWG8ybGVLeFVWcGVNUDBvTTVQZVZZWTVXUEVrMWI0WWZC?=
 =?utf-8?B?Qk93eGdJWDFPc1FOME9rMkJkbG5DdVYvN2ZPOEdabEw3UTJSMUtHWW4yTU9Q?=
 =?utf-8?B?eFZHaEJKSHZPU1hxWWpJNXJUakQ5YUVHS2lSZ3ZtY0lCc1lXR3FPVDlwL3Q1?=
 =?utf-8?B?WktzZzBtS2RzVmZmcCtHUkxKNkQyWmtDa25ra0VBUVc1cVNlL2Ntb29yOXBz?=
 =?utf-8?B?SmhYalpuNkxVeXNEMW1ZMXBlWnAwYVREZ2ppUVhhYjg0QWo3ZzZhMnpiZC8w?=
 =?utf-8?B?akdJTjhqMDc2c0RzcExhYlZxQ0lwdEFRN0VMcTdiZ2gwUHlpRHlHMUFoWFdR?=
 =?utf-8?B?emphYitLSDJuWGVFa1o1S3ZxRmxidVl4Z3liTGE5UllSRUhVcS81b3JPOStP?=
 =?utf-8?B?VzBuNWdURWY1T2F3SG5SY2NpNmlKMmhucHNZNm5zbytwVnJHNG1VejZwZ2xk?=
 =?utf-8?B?VXl1YUlFQjI2VWx3UXlPL2k2YnF0aWcrV2NiSFVCdDlxZ1dZbVo1UlRrbVJQ?=
 =?utf-8?Q?vJYaug?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(42112799006)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 18:28:20.8130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4602370-a73c-42a7-d925-08dde0e081a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065
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



On 2025-07-23 13:27, IVAN.LIPSKI@amd.com wrote:
> From: Ivan Lipski <ivan.lipski@amd.com>
> 
> [Why & How]
> The AMD display hardware does not use dedicated cursor planes.
> Instead, the cursor is rendered either using the primary plane
> or an available overlay plane. This test verifies that the
> cursor correctly falls back from native to overlay mode
> when the underneath primary plane is incompatible. It also tests

The last sentence seems like a typo?

> 
> It has 5 subtests:
> 
> rgb-to-yuv
> Switches the primary plane to a NV12 format FB and verifies that
> the cursor falls back from native to overlay.
> 
> non-full
> Switches the primary planeto a FB that does not fill the entire CRTC
> (currently sized at a quarter of the CRTC).
> 
> scaling-[50,75,125,150,175,200]
> Switches the primary plane to a FB with a chosen scaling (50%-200%), which
> is then filled in the CRTC.
> 
> max-planes
> Enables 2 overlay planes, a primary plane and a cursor. Then
> switches the primary plane to YUV to cause the cursor to fall back to
> overlay. Verifies that the cursor can still fallback to overlay when 4
> planes are enabled.
> 
> no-available-planes
> Enables 3 available overlay planes, a primary plane and a cursor. Then
> switches the primary plane to YUV to cause the cursor to fall back to
> overlay. Verifies that the atomic commit fails due to no available overlay
> planes.
> 
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
> ---
>  tests/amdgpu/amd_cursor_overlay.c | 484 ++++++++++++++++++++++++++++++
>  tests/amdgpu/meson.build          |   1 +
>  2 files changed, 485 insertions(+)
>  create mode 100644 tests/amdgpu/amd_cursor_overlay.c
> 
> diff --git a/tests/amdgpu/amd_cursor_overlay.c b/tests/amdgpu/amd_cursor_overlay.c
> new file mode 100644
> index 000000000..cf5ea83a0
> --- /dev/null
> +++ b/tests/amdgpu/amd_cursor_overlay.c
> @@ -0,0 +1,484 @@
> +// SPDX-License-Identifier: MIT
> +// Copyright 2025 Advanced Micro Devices, Inc.
> +
> +#include "igt.h"
> +#include "igt_kms.h"
> +
> +/**
> + * TEST: amd_cursor_overlay
> + * Category: Display
> + * Description: Tests cursor fall back from native to overlay
> + * Driver requirement: amdgpu
> + */
> +
> +/**
> + * SUBTEST: rgb-to-yuv
> + * Description: Tests native cursor fall back to overlay cursor when a top plane
> + *				switches from RGB to YUV.
> + * SUBTEST: non-full
> + * Description: Tests native cursor fall back to overlay cursor when a top plane
> + *				does not fill the crtc.
> + * SUBTEST: scaling-%d
> + * Description: Tests native cursor fall back to overlay cursor when a top plane
> + *				is scaled.
> + *
> + * arg[1].values: 50, 75, 125, 150, 175, 200
> + *
> + * SUBTEST: max-planes
> + * Description: Tests native cursor fall back to overlay cursor when a top plane
> + *				is YUV and there are two overlay planes used.
> + *
> + * SUBTEST: no-available-planes
> + * Description: Tests native cursor attempt to fall back to overlay cursor required,
> + *				but fails atomic commit due to no available overlay planes.
> + */
> +
> +enum {
> +	TEST_YUV = 1,
> +	TEST_QUARTER_FB = 1 << 1,
> +	TEST_SCALING = 1 << 2,
> +	TEST_MAX_PLANES = 1 << 3,
> +	TEST_NO_PLANES = 1 << 4,

nit: to avoid confusion, s/NO_PLANES/NO_AVAILABLE_PLANES

> +};
> +
> +typedef struct {
> +	int x;
> +	int y;
> +} pos_t;
> +
> +/* Common test data. */
> +typedef struct data {
> +	igt_display_t display;
> +	igt_plane_t *primary;
> +	igt_plane_t *cursor;
> +	igt_plane_t *overlay1;
> +	igt_plane_t *overlay2;
> +	igt_plane_t *overlay3;
> +	igt_output_t *output;
> +	igt_pipe_t *pipe;
> +	igt_pipe_crc_t *pipe_crc;
> +	drmModeModeInfo *mode;
> +	igt_fb_t rgb_fb;
> +	igt_fb_t yuv_fb;
> +	igt_fb_t rgb_fb_o1;
> +	igt_fb_t rgb_fb_o2;
> +	igt_fb_t rgb_fb_o3;
> +	igt_fb_t quarter_fb;
> +	igt_fb_t scale_fb;
> +	igt_fb_t cfb;
> +	enum pipe pipe_id;
> +	int drm_fd;
> +	uint64_t max_curw;
> +	uint64_t max_curh;
> +} data_t;
> +
> +/* Retuns the number of available overlay planes */
> +static int get_overlay_planes_count(igt_display_t *display, enum pipe pipe)
> +{
> +	int count = 0;
> +	igt_plane_t *plane;
> +
> +	for_each_plane_on_pipe(display, pipe, plane)
> +		if (plane->type == DRM_PLANE_TYPE_OVERLAY)
> +			count++;
> +
> +	return count;
> +}
> +
> +/* Common test setup. */
> +static void test_init(data_t *data, enum pipe pipe_id, igt_output_t *output,
> +		      unsigned int flags)
> +{
> +	data->pipe_id = pipe_id;
> +	data->pipe = &data->display.pipes[data->pipe_id];
> +	data->output = output;
> +	data->mode = igt_output_get_mode(data->output);
> +	data->primary = igt_pipe_get_plane_type(data->pipe, DRM_PLANE_TYPE_PRIMARY);
> +	data->cursor = igt_pipe_get_plane_type(data->pipe, DRM_PLANE_TYPE_CURSOR);
> +
> +	if (flags & TEST_NO_PLANES || flags & TEST_MAX_PLANES) {
> +		data->overlay1 = igt_pipe_get_plane_type_index(data->pipe, DRM_PLANE_TYPE_OVERLAY, 0);
> +		data->overlay2 = igt_pipe_get_plane_type_index(data->pipe, DRM_PLANE_TYPE_OVERLAY, 1);
> +	}
> +	if (flags & TEST_NO_PLANES)
> +		data->overlay3 = igt_pipe_get_plane_type_index(data->pipe, DRM_PLANE_TYPE_OVERLAY, 2);
> +
> +	igt_info("Using (pipe %s + %s) to run the subtest.\n",
> +		 kmstest_pipe_name(data->pipe_id), igt_output_name(data->output));
> +
> +	igt_require_pipe_crc(data->drm_fd);
> +	data->pipe_crc = igt_pipe_crc_new(data->drm_fd, data->pipe_id,
> +					  IGT_PIPE_CRC_SOURCE_AUTO);
> +}
> +
> +/* Common test finish. */
> +static void test_fini(data_t *data)
> +{
> +	igt_pipe_crc_free(data->pipe_crc);
> +	igt_display_reset(&data->display);
> +	igt_plane_set_fb(data->primary, NULL);
> +	igt_plane_set_fb(data->cursor, NULL);
> +	if (data->overlay1)
> +		igt_plane_set_fb(data->overlay1, NULL);
> +	if (data->overlay2)
> +		igt_plane_set_fb(data->overlay2, NULL);
> +	if (data->overlay3)
> +                igt_plane_set_fb(data->overlay3, NULL);
> +	igt_display_commit2(&data->display, COMMIT_ATOMIC);
> +}
> +
> +/* Common test cleanup. */
> +static void test_cleanup(data_t *data)
> +{
> +	igt_remove_fb(data->drm_fd, &data->cfb);
> +	igt_remove_fb(data->drm_fd, &data->rgb_fb);
> +	igt_remove_fb(data->drm_fd, &data->yuv_fb);
> +	if (data->overlay1)
> +		igt_remove_fb(data->drm_fd, &data->rgb_fb_o1);
> +	if (data->overlay2)
> +		igt_remove_fb(data->drm_fd, &data->rgb_fb_o2);
> +	if (data->overlay3)
> +		igt_remove_fb(data->drm_fd, &data->rgb_fb_o3);
> +	igt_remove_fb(data->drm_fd, &data->quarter_fb);
> +	igt_remove_fb(data->drm_fd, &data->scale_fb);
> +}
> +
> +
> +static void test_cursor_pos(data_t *data, int x, int y, unsigned int flags, unsigned int scaling_factor)
> +{
> +	igt_crc_t ref_crc, test_crc;
> +	cairo_t *cr;
> +	igt_fb_t *rgb_fb = &data->rgb_fb;
> +	igt_fb_t *yuv_fb = &data->yuv_fb;
> +	igt_fb_t *quarter_fb = &data->quarter_fb;
> +	igt_fb_t *rgb_fb_o1 = &data->rgb_fb_o1;
> +	igt_fb_t *rgb_fb_o2 = &data->rgb_fb_o2;
> +	igt_fb_t *rgb_fb_o3 = &data->rgb_fb_o3;
> +	igt_fb_t *cfb = &data->cfb;
> +	int cw = cfb->width;
> +	int ch = cfb->height;
> +	int ret;
> +
> +
> +	cr = igt_get_cairo_ctx(rgb_fb->fd, rgb_fb);
> +
> +	igt_plane_set_fb(data->primary, rgb_fb);
> +	igt_display_commit2(&data->display, COMMIT_ATOMIC);
> +
> +	igt_paint_color(cr, 0, 0, rgb_fb->width, rgb_fb->height, 0.0, 0.0, 0.0);
> +
> +	/* Draw a magenta square where the cursor should be. */
> +	igt_paint_color(cr, x, y, cw, ch, 1.0, 0.0, 1.0);
> +	igt_put_cairo_ctx(cr);
> +
> +	if (flags & TEST_MAX_PLANES) {
> +		/* Display the overlay planes. */
> +		igt_plane_set_fb(data->overlay1, rgb_fb_o1);
> +		igt_plane_set_position(data->overlay1, 0, 0);
> +		igt_plane_set_fb(data->overlay2, rgb_fb_o2);
> +		igt_plane_set_position(data->overlay2, data->rgb_fb_o1.width, data->rgb_fb_o1.height);
> +		igt_display_commit_atomic(&data->display, 0, NULL);
> +
> +		/* Display the cursor. */
> +		igt_plane_set_fb(data->cursor, cfb);
> +		igt_plane_set_position(data->cursor, x, y);
> +		igt_display_commit_atomic(&data->display, 0, NULL);
> +
> +		/* Trigger cursor fall back due to a YUV plane;
> +		 * expect the atomic commit to fail due to no
> +		 * available overlay planes.
> +		 */
> +		igt_plane_set_fb(data->primary, &data->yuv_fb);
> +		ret = igt_display_try_commit_atomic(&data->display, DRM_MODE_ATOMIC_ALLOW_MODESET, 0);
> +
> +		/* Remove the overlay planes. */
> +		igt_plane_set_fb(data->overlay1, NULL);
> +		igt_plane_set_fb(data->overlay2, NULL);
> +		igt_plane_set_fb(data->cursor, NULL);
> +		igt_display_commit_atomic(&data->display, 0, NULL);
> +
> +		/* Expected atomic commit to fail due to no available overlay planes. */
> +		igt_assert_f(ret == 0, "Expected atomic commit to succeed.\n");
> +		return;
> +	}
> +	if (flags & TEST_NO_PLANES) {
> +
> +		/* Display the overlay planes. */
> +		igt_plane_set_fb(data->overlay1, rgb_fb_o1);
> +		igt_plane_set_position(data->overlay1, 0, 0);
> +		igt_plane_set_fb(data->overlay2, rgb_fb_o2);
> +		igt_plane_set_position(data->overlay2, data->rgb_fb_o1.width, data->rgb_fb_o1.height);
> +		igt_plane_set_fb(data->overlay3, rgb_fb_o3);
> +                igt_plane_set_position(data->overlay3, data->rgb_fb_o1.width, 0);
> +		igt_display_commit_atomic(&data->display, 0, NULL);
> +
> +		/* Display the cursor. */
> +		igt_plane_set_fb(data->cursor, cfb);
> +		igt_plane_set_position(data->cursor, x, y);
> +		igt_display_commit_atomic(&data->display, 0, NULL);
> +
> +		/* Trigger cursor fall back due to a YUV plane;
> +		 * expect the atomic commit to fail due to no
> +		 * available overlay planes.
> +		 */
> +		igt_plane_set_fb(data->primary, &data->yuv_fb);
> +		ret = igt_display_try_commit_atomic(&data->display, DRM_MODE_ATOMIC_ALLOW_MODESET, 0);
> +
> +		/* Remove the overlay planes. */
> +		igt_plane_set_fb(data->overlay1, NULL);
> +		igt_plane_set_fb(data->overlay2, NULL);
> +		igt_plane_set_fb(data->overlay3, NULL);
> +		igt_plane_set_fb(data->cursor, NULL);
> +		igt_display_commit_atomic(&data->display, 0, NULL);
> +
> +		/* Expected atomic commit to fail due to no available overlay planes. */
> +		igt_assert_f(ret == -EINVAL, "Expected atomic commit to fail due to no available overlay planes.\n");
> +		return;
> +	}

Is the TEST_MAX_PLANES testing the 
1 PRIMARY + 2 OVERLAY + 1 Overlay CURSOR = 4 planes scenario? 
If so, atomic commit is expected to succeed, not fail.

TEST_NO_PLANES here looks correct in that regard, since amdgpu_dm would 
reject 1 PRIMARY + 3 OVERLAYS + 1 Overlay CURSOR = 5 planes.

These tests would only be valid for APUs that have 4 hw planes though.
Some DGPUs have more than 4, for which these tests wouldn't make sense.

Perhaps we can programatically determine the number of OVERLAYs via
get_overlay_planes_count(), and enable the right amount (count-1 for
MAX_PLANES and count for NO_PLANES)? We should be able to use the same
fb for all of them, instead of creating a new fb for each.

> +
> +	/* Display the cursor. */
> +	igt_plane_set_fb(data->cursor, cfb);
> +	igt_plane_set_position(data->cursor, x, y);
> +	igt_display_commit_atomic(&data->display, 0, NULL);
> +
> +	/** Record a reference CRC */
> +	igt_pipe_crc_start(data->pipe_crc);
> +	igt_pipe_crc_get_current(data->drm_fd, data->pipe_crc, &ref_crc);
> +
> +	/* Switch primary plane to use YUV Fb. */
> +	if (flags & TEST_YUV) {
> +		igt_plane_set_fb(data->primary, yuv_fb);
> +		igt_plane_set_position(data->primary, 0, 0);
> +		igt_plane_set_size(data->primary, yuv_fb->width, yuv_fb->height);
> +		igt_display_commit_atomic(&data->display, DRM_MODE_ATOMIC_ALLOW_MODESET, 0);
> +
> +	/* Switch primary plane to use a quarter-sized FB. */
> +	} else if (flags & TEST_QUARTER_FB) {
> +		igt_plane_set_fb(data->primary, quarter_fb);
> +		igt_plane_set_position(data->primary, 0, 0);
> +		igt_display_commit_atomic(&data->display, 0, NULL);
> +
> +	/* Switch primary plane to use a scaled FB. */
> +	} else if (flags & TEST_SCALING) {
> +		igt_create_fb(data->drm_fd,
> +			data->rgb_fb.width * scaling_factor / 100,
> +			data->rgb_fb.height * scaling_factor / 100,
> +			DRM_FORMAT_XRGB8888,
> +			DRM_FORMAT_MOD_LINEAR, &data->scale_fb);
> +
> +		igt_plane_set_fb(data->primary, &data->scale_fb);
> +		igt_plane_set_position(data->primary, 0, 0);
> +		igt_plane_set_size(data->primary, data->mode->hdisplay, data->mode->vdisplay);
> +
> +		igt_display_commit_atomic(&data->display, 0, NULL);
> +	}
> +
> +	/* Wait for one more vblank since cursor updates are not
> +	 * synchronized to the same frame on AMD hw.
> +	 */
> +	if (is_amdgpu_device(data->drm_fd))
> +		igt_wait_for_vblank_count(data->drm_fd, data->display.pipes[data->pipe_id].crtc_offset, 1);
> +
> +	/* Record the new CRC. */
> +	igt_pipe_crc_get_current(data->drm_fd, data->pipe_crc, &test_crc);
> +	igt_pipe_crc_stop(data->pipe_crc);
> +
> +	/** CRC Check is sufficient for this test */
> +	igt_assert_crc_equal(&ref_crc, &test_crc);
> +}
> +
> +/*
> + * Tests the cursor on a variety of positions on the screen.
> + * Specific edge cases that should be captured here are the negative edges
> + * of each plane and the centers.
> + */
> +static void test_cursor_spots(data_t *data, int size, unsigned int flags, unsigned int scaling_factor)
> +{
> +	int sw = data->mode->hdisplay;
> +	int sh = data->mode->vdisplay;
> +	int i;
> +		const pos_t pos[] = {
> +		/* Test diagonally from top left to bottom right. */
> +		{ -size / 3, -size / 3 },
> +		{ 0, 0 },
> +		{ sw / 4 - size, sh / 4 - size },
> +		{ sw / 4 - size / 3, sh / 4 - size / 3 },
> +		{ sw / 4, sh / 4 },
> +		{ sw / 4 + size, sh / 4 + size },
> +		{ sw / 2, sh / 2 },
> +		{ sw / 4 + sw / 2 - size, sh / 4 + sh / 2 - size },
> +		{ sw / 4 + sw / 2 - size / 3, sh / 4 + sh / 2 - size / 3 },
> +		{ sw / 4 + sw / 2 + size, sh / 4 + sh / 2 + size },
> +		{ sw - size, sh - size },
> +		{ sw - size / 3, sh - size / 3 },
> +		/* Test remaining corners. */
> +		{ sw - size, 0 },
> +		{ 0, sh - size },
> +		{ sw / 4 + sw / 2 - size, sh / 4 },
> +		{ sw / 4, sh / 4 + sh / 2 - size }
> +	};
> +
> +	for (i = 0; i < ARRAY_SIZE(pos); ++i)
> +		test_cursor_pos(data, pos[i].x, pos[i].y, flags, scaling_factor);
> +}
> +
> +static void test_cursor(data_t *data, int size, unsigned int flags, unsigned int scaling_factor)
> +{
> +	int sw, sh;
> +
> +	igt_skip_on(size > data->max_curw || size > data->max_curh);
> +
> +	sw = data->mode->hdisplay;
> +	sh = data->mode->vdisplay;
> +
> +	test_cleanup(data);
> +
> +	/* Create RGB FB for reference. */
> +	igt_create_color_fb(data->drm_fd, sw, sh, DRM_FORMAT_XRGB8888,
> +			    DRM_FORMAT_MOD_LINEAR, 0.0, 0.0, 0.0, &data->rgb_fb);
> +
> +	/* Create YUV FB for RGB-to-YUV, MAX_PLANES and NO_PLANES subtests */
> +	if (flags & TEST_YUV || flags & TEST_MAX_PLANES ||flags & TEST_NO_PLANES)
> +		igt_create_fb(data->drm_fd, sw, sh, DRM_FORMAT_NV12,
> +					DRM_FORMAT_MOD_NONE, &data->yuv_fb);
> +
> +	/* Create a quarter-sized empty FB. */
> +	if (flags & TEST_QUARTER_FB)
> +		igt_create_color_fb(data->drm_fd, sw / 2, sh / 2, DRM_FORMAT_XRGB8888,
> +					DRM_FORMAT_MOD_LINEAR, 0.0, 0.0, 0.0, &data->quarter_fb);
> +
> +	/* Create two RGB FBs for the overlay planes. */
> +	if (flags & TEST_MAX_PLANES || flags & TEST_NO_PLANES) {
> +		igt_create_color_fb(data->drm_fd, sw / 2, sh / 2, DRM_FORMAT_XRGB8888,
> +			DRM_FORMAT_MOD_NONE, 0.5, 0.0, 0.0, &data->rgb_fb_o1);
> +		igt_create_color_fb(data->drm_fd, sw / 2, sh / 2, DRM_FORMAT_XRGB8888,
> +			DRM_FORMAT_MOD_NONE, 0.0, 0.5, 0.0, &data->rgb_fb_o2);
> +	}
> +
> +	/* Create a third overlay plane for TEST_NO_PLANES test */
> +	if (flags & TEST_NO_PLANES) {
> +		igt_create_color_fb(data->drm_fd, sw / 2, sh / 2, DRM_FORMAT_XRGB8888,
> +			DRM_FORMAT_MOD_NONE, 0.0, 0.0, 0.5, &data->rgb_fb_o3);
> +	}
> +
> +	/* Create a FB for scaling. */
> +	if (flags & TEST_SCALING)
> +		igt_create_color_fb(data->drm_fd, sw, sh, DRM_FORMAT_XRGB8888,
> +					DRM_FORMAT_MOD_LINEAR, 0.0, 0.0, 0.0, &data->scale_fb);
> +
> +	/* Create a cursor FB. */
> +	igt_create_color_fb(data->drm_fd, size, size, DRM_FORMAT_ARGB8888,
> +				DRM_FORMAT_MOD_LINEAR, 1.0, 0.0, 1.0, &data->cfb);
> +
> +	igt_output_set_pipe(data->output, data->pipe_id);
> +
> +	/* Run the test for different cursor spots. */
> +	test_cursor_spots(data, size, flags, scaling_factor);
> +
> +}
> +
> +igt_main
> +{
> +	static const int cursor_sizes[] = { 64, 128, 256 };
> +	data_t data = { .max_curw = 64, .max_curh = 64 };
> +	enum pipe pipe;
> +	igt_output_t *output;
> +	igt_display_t *display;
> +	int i, j;
> +	struct {
> +		const char *name;
> +		unsigned int flags;
> +		unsigned int scale_factor;
> +		const char *desc;
> +	} tests[] = {
> +		{ "rgb-to-yuv", TEST_YUV, 100,
> +		"Tests native cursor fall back to overlay cursor when a top plane switches from RGB to YUV" },
> +		{"non-full", TEST_QUARTER_FB, 100,
> +		"Tests native cursor fall back to overlay cursor when a top plane does not fill the crtc"},
> +		{"max-planes", TEST_MAX_PLANES, 100,
> +		"Tests native cursor fall back to overlay cursor when a top plane is YUV and there are two overlay planes used."},
> +		{"no-available-planes", TEST_NO_PLANES, 100,
> +		"Tests native cursor attempt to fall back to overlay cursor required, but fails atomic commit due to no available overlay planes."},
> +		{"scaling-50", TEST_SCALING, 50,
> +		"Tests native cursor fall back to overlay cursor when a top plane is scaled"},
> +		{"scaling-75", TEST_SCALING, 75,
> +		"Tests native cursor fall back to overlay cursor when a top plane is scaled"},
> +		{"scaling-125", TEST_SCALING, 125,
> +		"Tests native cursor fall back to overlay cursor when a top plane is scaled"},
> +		{"scaling-150", TEST_SCALING, 150,
> +		"Tests native cursor fall back to overlay cursor when a top plane is scaled"},
> +		{"scaling-175", TEST_SCALING, 175,
> +		"Tests native cursor fall back to overlay cursor when a top plane is scaled"},
> +		{"scaling-200", TEST_SCALING, 200,
> +		"Tests native cursor fall back to overlay cursor when a top plane is scaled"},
> +	};
> +
> +	igt_fixture {
> +		int ret;
> +
> +		data.drm_fd = drm_open_driver_master(DRIVER_AMDGPU);
> +
> +		igt_display_require(&data.display, data.drm_fd);
> +		igt_require(data.display.is_atomic);
> +		igt_display_require_output(&data.display);
> +		display = &data.display;
> +
> +		ret = drmGetCap(data.drm_fd, DRM_CAP_CURSOR_WIDTH, &data.max_curw);
> +		igt_assert(ret == 0 || errno == EINVAL);
> +		ret = drmGetCap(data.drm_fd, DRM_CAP_CURSOR_HEIGHT, &data.max_curh);
> +		igt_assert(ret == 0 || errno == EINVAL);
> +
> +		kmstest_set_vt_graphics_mode();
> +	}
> +
> +
> +	for (i = 0; i < ARRAY_SIZE(tests); i++) {
> +		igt_describe_f("%s", tests[i].desc);
> +		igt_subtest_with_dynamic_f("%s", tests[i].name) {
> +
> +			/* Skip YUV and NO_PLANES subtests if YUV is not supported*/
> +			if (tests[i].flags & TEST_YUV || tests[i].flags & TEST_NO_PLANES)
> +				igt_require(igt_display_has_format_mod(display,
> +							DRM_FORMAT_NV12,
> +							DRM_FORMAT_MOD_LINEAR));
> +
> +			for_each_pipe_with_single_output(&data.display, pipe, output) {
> +
> +				igt_display_reset(display);
> +
> +				igt_output_set_pipe(output, pipe);
> +				if (!intel_pipe_output_combo_valid(display))
> +					continue;
> +
> +				/* Skip TEST_NO_PLANES if the ASIC has less than 3 overlay planes*/
> +				if (tests[i].flags & TEST_NO_PLANES)
> +					igt_require(get_overlay_planes_count(&data.display, pipe) >= 3);
> +
> +				/* Skip TEST_MAX_PLANES if the ASIC has less than 2 overlay planes*/
> +				if (tests[i].flags & TEST_MAX_PLANES)
> +					igt_require(get_overlay_planes_count(&data.display, pipe) >= 2);

The skip checks here don't quite make sense, see comment above.

Thanks,
Leo

> +
> +				test_init(&data, pipe, output, tests[i].flags);
> +
> +				for (j = 0; j < ARRAY_SIZE(cursor_sizes); j++) {
> +					int size = cursor_sizes[j];
> +
> +					igt_dynamic_f("pipe-%s-%s-size-%d",
> +						      kmstest_pipe_name(pipe),
> +						      igt_output_name(output),
> +						      size)
> +						test_cursor(&data, size, tests[i].flags, tests[i].scale_factor);
> +
> +					test_cleanup(&data);
> +				}
> +
> +				test_fini(&data);
> +			}
> +		}
> +	}
> +
> +	igt_fixture {
> +		igt_display_fini(&data.display);
> +		drm_close_driver(data.drm_fd);
> +	}
> +}
> diff --git a/tests/amdgpu/meson.build b/tests/amdgpu/meson.build
> index 421e686d3..b9f1842e2 100644
> --- a/tests/amdgpu/meson.build
> +++ b/tests/amdgpu/meson.build
> @@ -10,6 +10,7 @@ if libdrm_amdgpu.found()
>  			  'amd_color',
>  			  'amd_cp_dma_misc',
>  			  'amd_cs_nop',
> +			  'amd_cursor_overlay',
>  			  'amd_deadlock',
>  			  'amd_dp_dsc',
>  			  'amd_freesync_video_mode',

