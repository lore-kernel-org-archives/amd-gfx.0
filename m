Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2650AC02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 13:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE39A10E412;
	Mon, 20 Jan 2025 13:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pfRdXeQd";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBBD110E412
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 13:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TN4oQHbyZ84FFPfS1lQk5ApEfkHGoAnS8wlmMS1u4g02NQjRwT8ElAg0ouGKEMAhJz50RHUULlBZaPlLWTEQRMEsBOHIw47nCLzqxdgV8BL4fKrd8+Y+hKME0rIqAlm6bxF1wVOet55kbKt/NytRZjS75PNC0P8YwKq9YV9suk6C9McxZvk8eQNony+FS2hdDEAGq7MTOQycQh3WFecHSoYpuu+ZnIFU7VsyZ3SbN343T1jKgOY+qBG+is3gRcar/ccbBo1umvka31aM5i6Vj8hCiYiuUcUtcdYinO/OJ5PoameQt3M2shtoYOF1HUtiO9KiD0acT+ZMkrfZkv8o3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXj077UZQsn7JA4Z32Qh26TcU7DIfoiU/GWH+BNXIjg=;
 b=FbfBimgCy3o+EYIbdwbFUndiRrSj1PoczJNrAWhlzRGIFOZxRLFP9sEHdLOx1KqsLc1z4qti34wfOpIqYByKPtTeKvKjpA7ZRtjkUeY5AXkxMboHlrdrDxBWj9OqWrlQbjFThf0IJNv2ZFfhsHJq29UKQyLWXNy/7rp1+8F5mA5VVzbnEs1H2tockQKDZQVFSulf3psx5n8o41Z27TdYpLqgACxa8SKRNGfTmeaUdmGDVWx16ff71wKi7YdJw5NMJYC+GzMp/rWy2zoZ8notd+xwMdIEmMmUY1eIbBKFQ916iKnKaY9O8e/AJXrO6qj9UDIIXpF+qnTo4HovdEhEhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXj077UZQsn7JA4Z32Qh26TcU7DIfoiU/GWH+BNXIjg=;
 b=pfRdXeQdjWZ9xr6tsF2rbKBiihG9IE3O2NAni81KQbfsQgtbksMXr6sBHb1lblTJOfddgb4wVaUVi5lXHleScGoHKhInvOfpaDB6/GUu6FlQdTRypMuSZIVzZ3U71EYVNdumx5l7rPr/Y4ssqUbzIVxwbCzMbLymg2I/5h98Drc=
Received: from MW4PR04CA0208.namprd04.prod.outlook.com (2603:10b6:303:86::33)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Mon, 20 Jan 2025 13:38:35 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:303:86:cafe::38) by MW4PR04CA0208.outlook.office365.com
 (2603:10b6:303:86::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Mon,
 20 Jan 2025 13:38:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 13:38:34 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 Jan 2025 07:38:30 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v4] drm/amd/amdgpu: Prevent null pointer dereference in GPU
 bandwidth calculation
Date: Mon, 20 Jan 2025 19:08:07 +0530
Message-ID: <20250120133807.235523-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8e5f6c-4de1-418d-0f58-08dd3957bcb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1cvUXlCYVRkdlE1cTd6UWp4dEppMERUWE05MERzRGw5UktTaEFRbGhtWG01?=
 =?utf-8?B?WFhFaVNoM2RrUXdwdTFJdURsZFBXN2h0eUVaSytIQVJTSTFSUGpXNk5xRlBk?=
 =?utf-8?B?TjNReDlzSmpKWDBCakNUUUNkTlBMZmRhbm1MU0pZeDJPSHkwWllnUjl6R0xz?=
 =?utf-8?B?bkludk8vcnJjOVFueUhKSjYvcHY1RXN5ODAxZ3Qva1JPZWxmYy92eXhoOU5s?=
 =?utf-8?B?UlNuelkyQ0xPbUFSRWZ1MEF2TEEzZFgxQ0FpVFhKYjJIUjZScHd5OFFDUStQ?=
 =?utf-8?B?ZGV2clF6Y2tlbVJEamxtd1RsZDljY1BCMEZ3VDhTSTNTZGk0STc4V3lIN2NP?=
 =?utf-8?B?bk84a2NqV2wrVU42YU95b05xcVF6ZktpMVpqYjBnOUdveFRPRlpRc25rTS9t?=
 =?utf-8?B?eFVtU05meGx6WGpyKzVUT21rT1JCOU9raTMyNm9lNjhXSHZTcEhNa1huZzdC?=
 =?utf-8?B?bVNSblVOQnJTOEFnSFJGVW1wbi9HTTd5Qk9sd3FzazhKVW1lQ1luTjBkSll4?=
 =?utf-8?B?dVJRUEFLbHQ4amsydUQ5WXlyMDMvOXVGejNnUHZJTW1MNkQyWURZKy9XYXpZ?=
 =?utf-8?B?ejBwME94YU1qWnhDNjFJbjBlUitqaC94QzMxU2hYK0N0TndBT0ZMWUd5ZGVx?=
 =?utf-8?B?UitXNk1qK2xYam0xZEN2ZW5hNHVNenN0REFNYmZJaWdJNmY5Z1RqVVZEYlJF?=
 =?utf-8?B?RGRsMHdOMGUrOWM1dmRhTUptNlZhbXdBd3dCMTdlaXJrcHdSL2laTEZJQklH?=
 =?utf-8?B?cmcrWFhqdE0vUENrMUZpZCtrSUpCYS90TTV5R1hvQ0hTRG0rNFJyYUh4Y3ly?=
 =?utf-8?B?THd3YVFIYm0wYW1LMlVqTHRyUUFwY3o0VzBsdHZQOGhMUFNJeUxoUUJUdnBS?=
 =?utf-8?B?WlAwbUJRZEZJeDFaY2hDcVZ1QzVHN3A2a0hSY1dRQTZLSkFvNWQxY0lnaGFs?=
 =?utf-8?B?UHJ6em40blFsT0RqTDRZaE56ZWJSQUEyNVlUWjN0Y1R2OWZjbDFZbzVPVlAv?=
 =?utf-8?B?ek55NUVJQjBCdGJ6ZnMxUm9tRFlBQldPYkxOSHZuODhSREw2b29yUy90c3Ji?=
 =?utf-8?B?V1Q3YUNDenlpUGg3SWVKczVPcFE4S240bU1aRGJyeGZONWw2QlNuTFBEYWcy?=
 =?utf-8?B?SitrczdJVnJ5KzVUN29QMDNhU2ozRXhiV01Dc1dpTmpoZ2FGZFY4cUdadXIx?=
 =?utf-8?B?anp4MnRKM1p3WktxNXVCWVFTWXdCaHpUSkt6UGlrMzJsR3ZNalV6V0JoVXZD?=
 =?utf-8?B?dVdubURBUXgwMW1lcVNTRVNEZ1BsaUlrUFBEcXFQWVdvbVJoM2h1WGlHbjRF?=
 =?utf-8?B?YS8wK3pKalc5L3VSNSt0c2hkTnAxTkFoYlIrTHI2WkdsTkIyWUd5eFF3ZTRs?=
 =?utf-8?B?UGNSL2hKbFk3VlRvVEh1WkpnaTFWRGlMMm9UVFVPN0xXdHhlbW5sc3YzVERm?=
 =?utf-8?B?SWdBYVl0NjkrOGJWVThTUXVTVngxWkdFcks4N0lqTlFiWVdqangvZjR1cDlV?=
 =?utf-8?B?TjQxdmo1NEw2cWhMVUZuNjBVK2lWb0JYam9CU0pZVm91Wko4d1gveFhHb2hF?=
 =?utf-8?B?U2JJek85UzltZjZ3Y3laWVVmVGRjWWNHSjFZVGZiZUlSWnlLNjlqOXZJRFBJ?=
 =?utf-8?B?V2hiS0FtNFZuaDNKOFhDZWo1Si9ESVE4VEpKUGNTQXN4MnF0MFlDUEJnUmdk?=
 =?utf-8?B?UEU3eVJLbXY5WjQyWXhmRUhNemFxdEN4RzRYb25UbU5US2hVK0RtT2dIWmdh?=
 =?utf-8?B?Ujh2d3h3a3V6VGhTaHQ0Zlp6ZjlkRjRXUkxSVTYwVDhXempDK2dESmk4ZERj?=
 =?utf-8?B?eVh1NTlGQlBuWFVCcjlid3JSZlVtZEQrckxVVVM1N09xQzZBZDM2aUt6eElM?=
 =?utf-8?B?ZHUybGthT240Z3FMdlFseXRva29MY0NTZllpTVpjWUJNS09uenUyTFdTbkZl?=
 =?utf-8?B?OTZsTHM4V3d4dUpQOGtlSzUxNzlvc0FVdUVPQTY3Y3Eyekw0Yk1pNXpyRDRT?=
 =?utf-8?B?cG0yeWJZKzdBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 13:38:34.5705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8e5f6c-4de1-418d-0f58-08dd3957bcb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439
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

If the parent is NULL, adev->pdev is used to retrieve the PCIe speed and
width, ensuring that  the function can still determine these
capabilities from the device itself.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6193 amdgpu_device_gpu_bandwidth()
	error: we previously assumed 'parent' could be null (see line 6180)

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
    6170 static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
    6171                                         enum pci_bus_speed *speed,
    6172                                         enum pcie_link_width *width)
    6173 {
    6174         struct pci_dev *parent = adev->pdev;
    6175
    6176         if (!speed || !width)
    6177                 return;
    6178
    6179         parent = pci_upstream_bridge(parent);
    6180         if (parent && parent->vendor == PCI_VENDOR_ID_ATI) {
                     ^^^^^^
If parent is NULL

    6181                 /* use the upstream/downstream switches internal to dGPU */
    6182                 *speed = pcie_get_speed_cap(parent);
    6183                 *width = pcie_get_width_cap(parent);
    6184                 while ((parent = pci_upstream_bridge(parent))) {
    6185                         if (parent->vendor == PCI_VENDOR_ID_ATI) {
    6186                                 /* use the upstream/downstream switches internal to dGPU */
    6187                                 *speed = pcie_get_speed_cap(parent);
    6188                                 *width = pcie_get_width_cap(parent);
    6189                         }
    6190                 }
    6191         } else {
    6192                 /* use the device itself */
--> 6193                 *speed = pcie_get_speed_cap(parent);
                                                     ^^^^^^ Then we are toasted here.

    6194                 *width = pcie_get_width_cap(parent);
    6195         }
    6196 }

Fixes: 9e424a5d9087 ("drm/amdgpu: cache gpu pcie link width")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 46af07faf8c8..ae83e23872fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6187,8 +6187,8 @@ static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
 		}
 	} else {
 		/* use the device itself */
-		*speed = pcie_get_speed_cap(parent);
-		*width = pcie_get_width_cap(parent);
+		*speed = pcie_get_speed_cap(adev->pdev);
+		*width = pcie_get_width_cap(adev->pdev);
 	}
 }
 
-- 
2.34.1

