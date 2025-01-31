Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEF0C0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 17:21:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 824DE10E407;
	Fri, 31 Jan 2025 17:21:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZXYbeO9f";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D29A10E407
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 17:21:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmyHjBafRsd8xO0p+ERLobUEQZU/LfX5KUODrmpGNdP+Jiiu/Pk25DeiNh5W7MSrHRWh9ZjR3KRIez+/2ISJYbGPVV3EhGHsuSQ5vv96AGIpSaMwA/lxjjrzWWqJYiFv2mV4fiH6rp+RdwXsaH0R6WCM/REDXwCk1rTUrtKI9OnPijHhzMKf6XYS5qk0oUdcSg8K/9Hx71uLAQlytNdP/CyTW34ckYjnutPu0NtGmi+OAv+a7ElRjZE+mCkHN7bfCKA03F8yoyqhWHAiKK/dv5JlVf15b+hx8EKjQOBeo8jAC0ZQv5H4J8MNheX0mnVaTMp7+tYhMlHpQB4gkiX0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeHV+qIHJtOHOu0kCm/whqu5xUty9tK0ZvuCOX8YyEU=;
 b=zLUd0sho+ragIuB+wQSJAFPxWqSKtGOFYvHyNu2iYboyhvPTfurBRtmQWA7ahT6Vr2DnFf9mMiAYVVpineJqqABWKlpjYaP3gOtjvMGDVt9PgoMg/FDhMXkPgNtjWploRdwHtgEI80gFR8Tb2m2TX17pAmNpdpufXfndinK+gKUsVMR/lTzsURcxYYqIC/OEMXUOTlVbTgadtivuVQwQHYsq6SFFiQSsawboKL7+bRg4q85WDv7X42qxebGoaiHaVvG7bVHqPu8g6+A7KWXEKfWfpqBJLqLgXAiu4VhVEw7sN1tZ9rlbnUYFRQV5B35H5TJYvLdYyqBvb0OMZ+Lt/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeHV+qIHJtOHOu0kCm/whqu5xUty9tK0ZvuCOX8YyEU=;
 b=ZXYbeO9fVlOk2B7bJku6VcCXVMKvrbepBMTkpekNiDoX+/9vYp74GHc4wW0lUk9+1UBj3eXyBVGmxsu7c1Yi7NDwkbv0X1G2t9DxqMLM2mSzJqTnQ+ioL8jaNFI0I2aR/i5Xo0J6D0bYBLZooWEuzcOktMofHJLqkjwHKmo668M=
Received: from MN2PR22CA0011.namprd22.prod.outlook.com (2603:10b6:208:238::16)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Fri, 31 Jan
 2025 17:21:28 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::e8) by MN2PR22CA0011.outlook.office365.com
 (2603:10b6:208:238::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Fri,
 31 Jan 2025 17:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 17:21:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 11:21:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V2 2/2] drm/amdkfd: use GTT for VRAM on APUs only if GTT is
 larger
Date: Fri, 31 Jan 2025 12:21:13 -0500
Message-ID: <20250131172113.1807775-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131172113.1807775-1-alexander.deucher@amd.com>
References: <20250131172113.1807775-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d388af-db23-4679-7ba5-08dd421bb2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?My45PyF7lTuieO5nmkM/7DdpYSxXY/QPNQYGgBJBThNIZ8hBvUPuoV5LUWV3?=
 =?us-ascii?Q?hsjdYHHcJHHCqnMvSmeQMOuY83gtiPAQ5dtyXxuq7OtwBJ0t8XG7yKO4wASC?=
 =?us-ascii?Q?w916i4qdaSyHd1+iKxwdf9SnTGYE3eaH1eZr+iaVcJohp4QnzNjWcOITDVcj?=
 =?us-ascii?Q?HJaqpmGV7rY9SbiH1u64wCcdk/xYmHg2Jn3cLnvAvntoH7Raz603Z19g61FY?=
 =?us-ascii?Q?4nJFmgg+jUAK0k3GgEIUU8TMTGJwy1UIukgNO8Q9bsGrveMcw/rx9A7F3ucD?=
 =?us-ascii?Q?QOHZzSGzRduK/Yke12NaBjW9CDYbse9GYhzMT6X52YlT+LKudAVP2YOiP5bn?=
 =?us-ascii?Q?UKcBP75ySf+RUSU2rZ502QxIX8iKz4RHw5mlExdmvfY1bOD2nQdhZLe7Q6aw?=
 =?us-ascii?Q?jWc9KC3HdRe1Nl2TUSUEnw5nJpEcly0XvZRbK+2bc5w7OeIAsZ0NbYy6y8sx?=
 =?us-ascii?Q?PoP7AS3Sb6cWCHAmkapnEO5bk6+Pe5ftF2wZBkBUDTUzhbWsga0fEbadzVu+?=
 =?us-ascii?Q?4ociePgcFJIV7wH25kBz0gI6rhwe9dwFsoqzO8BpI1rs2MRxqKgildcjSbiF?=
 =?us-ascii?Q?5HIvDUiXW1u/jOWwsNJV1oAn4eOrdb6t2F//aMLEIKK3G90lvLg+xbzfBKgR?=
 =?us-ascii?Q?6tTmot60HC19QbgHlFmH99NxiRimNeOG1jkabJJ2wCuOvc+pGi/NzTIHfbOd?=
 =?us-ascii?Q?vK7OskjApr9J5Z5HQz9qs1mtocguDg5a/FnonNoveKy2GFT1IqIZ+b9dmx0r?=
 =?us-ascii?Q?lF8Q8G9nq9oxVYlAgWLvK9YK41laowkj8jTFnFCA0YBf8wz/c+wNwQqNAT8h?=
 =?us-ascii?Q?k4sNFpRyffkfFX4/ITa2S2wVHq1266HY4ynATT0PSmrLjHA8c3ezXO6BMbnz?=
 =?us-ascii?Q?+3VNL19UW8218wVfzBsy460a8BrLRfDA10WVcsQp0/Jt8opx2lmQgPq8h1X8?=
 =?us-ascii?Q?LHRKPj8AzP5Aun4QpwDQi/9U1d5SS41E8+YKE3fReYgFdb29+XujouZh22QS?=
 =?us-ascii?Q?B0rYdsMz6Rn3QIRvlqcJBzou12DNlRgE4e18R5mexXWIMVGTmQn1cJ3lIxMH?=
 =?us-ascii?Q?iqMS03p2zuMAimvT47PLbPqHyDPGH9IiwAl6OZbDql7btalHhMhE60DfbdaP?=
 =?us-ascii?Q?87ggOFz9pV0sxz4g/q8m1/DgBU/4WcrfNTvl0w3CTdqbe/hWSlgJHBEvcpWN?=
 =?us-ascii?Q?UzgrHZsOmEd9XCU4lP1j5yRMH7VtOt2FOyOwROpTIrqfHf9OfrkKLB/i0qLK?=
 =?us-ascii?Q?PQ9uPhZkSTuplStlAN22Pmis7YUPYbErjigNSIeZwoxSYP7yR7zCnRYiAAyX?=
 =?us-ascii?Q?3rOgfLNz5z9xYVh1S9qt/qVVFQ3SdYrhyUEDFd7CiHF47+3udvNCWj611Jr5?=
 =?us-ascii?Q?2bHmlYZTIm2B+ir/rClo201sGGf4noy2QszBg9BgZSK1/4AI6DUDP4WmNQ3Y?=
 =?us-ascii?Q?kmcVY7LCUypjy+iVEH5QwISU4hopJNbKL7yNFcaGgWvgPCQSuVFjTfizVAb7?=
 =?us-ascii?Q?gd1nExktXQcaiJQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 17:21:28.5813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d388af-db23-4679-7ba5-08dd421bb2ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
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

If the user has configured a large carveout on a small APU,
only use GTT for VRAM allocations if GTT is larger than
VRAM.

v2: fix reversed check (Philip)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 32b42f1104623..1b8d7c4889341 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1989,8 +1989,10 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	DRM_INFO("amdgpu: %uM of GTT memory ready.\n",
 		 (unsigned int)(gtt_size / (1024 * 1024)));
 
-	if (adev->flags & AMD_IS_APU)
-		adev->apu_prefer_gtt = true;
+	if (adev->flags & AMD_IS_APU) {
+		if (adev->gmc.real_vram_size < gtt_size)
+			adev->apu_prefer_gtt = true;
+	}
 
 	/* Initialize doorbell pool on PCI BAR */
 	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL, adev->doorbell.size / PAGE_SIZE);
-- 
2.48.1

