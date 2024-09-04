Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209A8CD37B4
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 13:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C78C010E3B1;
	Wed,  4 Sep 2024 13:27:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Flit4vFj";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B96D10E3B1
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 13:27:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmcwO7oTxuQ3C5RfY5/nOj1ar72RuTUW3pJsEmQo7Fnp4t0RNyattuMXx8YMMAA6rGJ1vakvtmtdxkadX9J/HpLLABz+iF+CwMHlwgDla9ogvqtNDVHmiPrdogxFpZ6O11PIZnVBdl280AraTgjAWCwLqManzibMG9stzKNrJsYbXJBDF7bdLN//xX5tRepGi6TwsD3iaPQRspihhSV0MkzBwCdzWGUQCJY48fWGVBqkotvDAQ8ZL3tIiEpGULvngdZJ84hGp0mt2DAeDnzQERNV0YFyTDZTD1pt5fNQtJrXLpef4Ullo8onVN+n8uSvbQAmtz4apGjzeFmX5l5Zag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A057Yj6IRwbqLe3ERMMK1Kg6io01Hrlx7262dVa0qu4=;
 b=mmndfvTTnWm0qBhMJLtmlskoQtHiJPqeWWjBR5wuseFD5zxWnca7B52qe/SCbV9sm2q8rwwszlu2ZIJPZaPTmtfQTkjnkEnWMDQbvKBdEYahusRo5WsH38bfKsagmjhIeOVkEcyjyiS5aFl11d02KtzV/gbPfl7pPlOlnCw1RrJb8Os8H2Aof3qe9bN7OzcP/ya5dIaKjuTSRuDmfY6r/M1vyUW+0YxCmGFRTbUm/53FLYguErH/+Z/TfjwbiFFI9eQunnmCe20Ea43rBWAZrHf6wd5drpSDhSvZ9OqvQ06FASFLNPOqnO246W6Nl0OWplGb+OSpgqjIAUDQIJGy2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A057Yj6IRwbqLe3ERMMK1Kg6io01Hrlx7262dVa0qu4=;
 b=Flit4vFjayCxotb3XK7HdIv6ubHCqdNA1XYk8BuBy0KUy9/BWr3K3TgtIwsTYhiN1dWIm81eorLXew/dA5GnADCb2MgtVyM4nhtR5Gj6eoCHXqtV7dmFSYb9NT2yQLmbC8L79CzeRsVeg5N8UN2a980TFW1P0O+DrvnCi5e856I=
Received: from PH7P220CA0166.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::13)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 13:27:47 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:510:33b:cafe::d3) by PH7P220CA0166.outlook.office365.com
 (2603:10b6:510:33b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 13:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 13:27:47 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 08:27:44 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/gfx9: Refactor cleaner shader initialization
 for GFX9
Date: Wed, 4 Sep 2024 18:57:28 +0530
Message-ID: <20240904132729.1948224-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904132729.1948224-1-srinivasan.shanmugam@amd.com>
References: <20240904132729.1948224-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c85ec6-e571-40ef-ca23-08dccce55dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmZzUE9UTGJldDdLT3oxRjIxUWYwc0o3Z1dObUtldi9vb0Y5TGJMZVZrVjZE?=
 =?utf-8?B?dFZ0dkUxUExwa3ZNUTQyVXZGTmpTbXhvNXlsMjFsVEpnNG5FcW55aTRMa1k1?=
 =?utf-8?B?bTZRWW5MRml1aHdodXhaZ0RoRklnM3ZwbjdERGYyOUp3U2RFT3JrK1hIUk1s?=
 =?utf-8?B?U29oNzZDYnBFY01ZVktYeDl1VGhmd2RSSzBaUSsvRFdEdEJuUXdReURxRWRC?=
 =?utf-8?B?aTArZ2JhYnp1Q3Jmajg1SGFLMEg2MVFZUjlvb1lEMXZ1cVA3L1JjS2NFSFFT?=
 =?utf-8?B?cWIxaWNPREExc2l4TjltYmpvTWZ1UXZQNjRqd0VWZUhWNm5vVG5wUmsvS3A1?=
 =?utf-8?B?aXNPdVJSdjlFVUhOMkpyYUpReUlJUStqL0RtNjRnenQzNGNvVDBNaHY0V0Zi?=
 =?utf-8?B?aDlickt4ZFdOMlNCU2tRcit6dDl3a0NHOHN2eG96eDhHNjVHNVZVT0dGTVoz?=
 =?utf-8?B?USs0SDZ2a2JlTEIyOTJlMzVFbENIODJUV0NVZm1KNmYrU2l4K1ArRVYwMFhP?=
 =?utf-8?B?THdMT2xITHV2c2t6bUdjeGJIRjhleUZ6ZXRVb3dubHF2aGszdW5DOEZoMnR5?=
 =?utf-8?B?L3B1R1lYdk5SUnY0NE9SOW9UK3Q4NFFHS1Axb0ovSXJ2TEtyT1NHU1hOeTRz?=
 =?utf-8?B?Yktlc21ZbUFvV2NoRTlhUTd0b0Z5VmdEeW51NTB3V2pxUjBjbzQrUnVmYm9j?=
 =?utf-8?B?dUVqK1JZNk9kR2dXM0tCYWZWNDREMmFzZmk2VFYvdFVsVi8rcEpqMFY4MDJk?=
 =?utf-8?B?T3Y0ZDk2VUM1VU5PbHRMYWdOdnVJODZFSTQxSTFBMi9VV1IrcWd1eEpPVVN2?=
 =?utf-8?B?bFBMcFJWVm1nWkRoSWFpTjRPZ25BNUJ4Z2kzSE91V1JLNEhJMGpzRVNXdjU5?=
 =?utf-8?B?cGo4cGEzVzh2WE5sMWVZN1lwT3FaY3JwUUxoRU9NMGFiVXUzcUhBMkRvemNJ?=
 =?utf-8?B?TTFzV2I2ZGgrZEx5Z1k4d2s0VTNTbVYxMnIxYS9zMzE5MS8xSE1Vb243bnly?=
 =?utf-8?B?cDFUdUZacGk0amZtVTFvVGQ5UmRzTUttaE1uWTRtMDlHWW9vY0lZZmF6emlR?=
 =?utf-8?B?ZzA0T01GMkh1Tkc0MyszUi94eG92V3FVUkNYK3ZobHJWT214QmUzR0UzRzk5?=
 =?utf-8?B?MHk2bjJOTjNkMEJCU0dVS0N5TkNEQVBjSU8yZHFTcm1WbEdxa1g3dTlCUHBC?=
 =?utf-8?B?UnU1REU5UE1MaHFPQ3pwMkRlNHJRcUM1cUpDR2VKajAzK0lqeDZoNXh3S0ZJ?=
 =?utf-8?B?eTZ2VmpIaThkQkZPWmRMZXJYRVFmMy9lV3JtdVpkTzBhdGh5WHlocXB1Z2lB?=
 =?utf-8?B?T1JDcWZqVmNsOVY5Ym9jZWRmaFpNYm16TGFtRUM2NUpTVWs3Q2MxeEpaVHRC?=
 =?utf-8?B?U3gwcUJsMHBWZU11d1hTL1hOamVnaUpvWlJzcytIVUM4NE8yMHZuZ0tZZmNq?=
 =?utf-8?B?M3V3K1VlOG9KSGhrc0JNcWhmdHZMcUZCcVA5dFdDSnF2VHFjUjNtb0I2cGw1?=
 =?utf-8?B?QjRSTHJsVHZwT1VPL2JYV21OUmcrNkp0SXJpVHdKT2JHd0ZIQmVrSWJqTS9B?=
 =?utf-8?B?NDdkRHM1eVJkNW1SNzdqUS9LYTBONDRxT1RENWltUHd5dFFGdkg1R2NiRTQ3?=
 =?utf-8?B?b1daR2ZMSGVDd0k2c2VLL1FreE5LNjByQWZ1M0h3Z3ZFSFB3Vjg2c1FxZ2dr?=
 =?utf-8?B?VTkzUzM4N1hIdGI0WnJUSWI3eHRYRkVlaTliSTFvWEROL2FvWDNTWDhuNlFx?=
 =?utf-8?B?U1RqaTQxSXhlYi9DRUxwY0dXL3JaYXNPSHZ0SDRBL2pBU0RVU0M4RU1Tc2Vh?=
 =?utf-8?B?VG5RcVdlQWdBQWhpM3hycU9TbDZjU1kzc2Rnd1VoN1Fyak05RW1HK3UvT2hj?=
 =?utf-8?B?WVVrRWJONEpPYnovVUQ2d0FacE1nTXQzSGlnNXh2S3ZTbmRvS3JkU2tHYSsw?=
 =?utf-8?Q?nz+xbTCE3zQRna7Q9XSrvta7WyV5rcGl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 13:27:47.1262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c85ec6-e571-40ef-ca23-08dccce55dcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738
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

This commit modifies the initialization only if the cleaner shader
object has been allocated. This is done by adding checks for
adev->gfx.cleaner_shader_obj before calling
amdgpu_gfx_cleaner_shader_init

The changes are made in the gfx_v9_0_hw_init functions These functions
are responsible for initializing software components of the GFX v9.0.

This change prevents unnecessary function calls and makes the control
flow of the program clearer. It also ensures that the cleaner shader is
only initialized when it has been properly allocated.

Fixes: 776ad43d4170 ("drm/amdgpu/gfx9: Implement cleaner shader support for GFX9 hardware")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 23f0573ae47b..d6d07cfd279e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3975,8 +3975,8 @@ static int gfx_v9_0_hw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_gfx_cleaner_shader_init(adev, adev->gfx.cleaner_shader_size,
-				       adev->gfx.cleaner_shader_ptr);
+	if (adev->gfx.cleaner_shader_obj)
+		amdgpu_gfx_cleaner_shader_init(adev);
 
 	if (!amdgpu_sriov_vf(adev))
 		gfx_v9_0_init_golden_registers(adev);
-- 
2.34.1

