Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56458C71136
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jun 2025 15:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFD8D10E8AE;
	Thu, 12 Jun 2025 15:23:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Np8698Kx";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8DCB10E8AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jun 2025 15:23:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InAXXHgBPa0bYAx7P5XkuD0wXFzve67WVFnybUumywnQlHXJm7r2TsO5LZz5ljoE1XJoO/G66HnqWKgfdMewCdP7JeLkYKVrc/VA4DfftW2ez/HYA0UVkB98+W+rw7EWAzhiS9JmW6vh9QQzuSpUr2vL1VVgcEL1UKdrBzU5x377ut5k3mWXAbTbff3SmzuhfBfbWO6i8Doll5/3m+cuSScJ0FyMps00imAZFaLCIoB/m1XGZaItiHGxoGM3lXwnoziuKro0LdvWwino0P69Olbs/MSwnWoDHYhea8m9WXUFU3NSSGmJvSTx5s91LApJLiR9PPEnvoqaRON9sBEHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFwvjnv5uvrBebli+No9aGQ1SO4tSsRy0vb4jDH973Q=;
 b=NqyYI9nCvDxQLugjtlxS1bEhCdpbGAwh4qr1gfX2m8l8CmVcBACcHzzwZQlIYZcK7Qlvo7tFRpGYAqcfnj4DuI8sGjz7i7JQDuxexPrCqB2IcQaPml+DnFlSsfGwyZlkvFJ5TpJ+zmVRMCiuKfRU2OgQ05qkGU3G1bwn59j1SziqF3IW5GhpY6GBlD8MgwkYQWvJVHJRtEI/tEAhXrCyjYeyOQ62io/WZMW8UY/37WR2LZmE6EqPTITy1eoosMmqpkupg0v4q50MUyj4fOdr14zHhbkfumJSfOibg7qIHe0iCarhJuqBUXkN7olxhNRRniSAhYxYdpNtR087njLEaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFwvjnv5uvrBebli+No9aGQ1SO4tSsRy0vb4jDH973Q=;
 b=Np8698Kx0FRGxLEaHv6dehUtYiA3RlDZlyGS7NiwWBrx7L20izo6Eqh4XC2ZsNffvWrdyOg/c3tZRZ2xLzudb4xI0FC1u9I7fjSIhAlZ3TFLv6VsQbQLz/1T3XvavYlCXCsQlXNjR/ipCBcTe6n+7d57M59w/CgKXFlIYllq85g=
Received: from PH7P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::11)
 by SA0PR12MB7477.namprd12.prod.outlook.com (2603:10b6:806:24b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 15:23:01 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:326:cafe::12) by PH7P220CA0024.outlook.office365.com
 (2603:10b6:510:326::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Thu,
 12 Jun 2025 15:23:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 15:22:59 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Jun 2025 10:22:57 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Manu Rastogi <manu.rastogi@amd.com>
Subject: [PATCH v2] drm/amdgpu/gfx9: Add Cleaner Shader Support for GFX9.x GPUs
Date: Thu, 12 Jun 2025 20:52:45 +0530
Message-ID: <20250612152245.107031-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612144751.104030-1-srinivasan.shanmugam@amd.com>
References: <20250612144751.104030-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SA0PR12MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e39f45-86c9-434d-5955-08dda9c50405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFhkNUtILzZzTWNFRmJCNFZNQUdWek1pcWE0ZVRVc1VzdEFjMnY5TU4vbThY?=
 =?utf-8?B?OGlVaFhmVlA3QU1MbnExL0NVUEtzSlR4SWN0U0sxNmhjeVRLR3l3dE03eUVZ?=
 =?utf-8?B?VzRPN2tNdHV0TmFBaXQzZUtLcFBBcXFlaDNkTGI2bWZQMU1yYzlkUlNsMzBD?=
 =?utf-8?B?UnlDcDRtalc2ZEVNdkFEKzQ1ZFVDbUhaSHVmL0hacWlBZE43cVV0ZE9CbHRk?=
 =?utf-8?B?OHZlV1IrU0pUNWhhOTdqeXcvWUhTVTJhQlVFZ3U4VUZiUjdBbE1HOUJyY3NU?=
 =?utf-8?B?TmFHTDRhVEdYREtVNXZGcVJSZDg1dyswNjJGdlZtMUNOTEUxblcwRnVFTXlH?=
 =?utf-8?B?RlBHRVJRU0wreERLMDlFdnBUNGx2aWMxNE9QeE5vQnRKSnE2L1kzdUttOTMr?=
 =?utf-8?B?YzFwcnVDMjhrY0w5V2dzbVpDYUxUK1hyZjhCNWFZd3gvdnhoc0dJWUtTdS9q?=
 =?utf-8?B?T053aDlaMzlzV2VCT3JFTWVwSzRMNFpmWjdXbU40SkI2YlJWd2Q4cUlJTDYx?=
 =?utf-8?B?RFRQb0RoMEZOaFE0cnlVaElvcXJWdWR6QUhSaEQ5eHpldnJzd3NpNllHdEpj?=
 =?utf-8?B?M1JydDBaZ1REdkFhVENhVmw4VUFDQ0x0UVVJbWpqSlY5M1VwSlZoL2E4bzNH?=
 =?utf-8?B?Z21QdXZHVGU2NWVlaHdjaXdNYWJuVHRHWTNJWjdYQTFSUDY2NENNVThZRFBo?=
 =?utf-8?B?MzRTd3YrQitxZVhRZlJ2Y1RKd2s5NFJ2MEpzMTQ2RTBxT0ZCUTNySWJidVZH?=
 =?utf-8?B?cG0yMlRmTVpiY1FMUi9MbGNEVUNUNDNjRlF1VmYvUHVkbEtyRHdZQTczbk9m?=
 =?utf-8?B?M0hzbUJWYmtIM1ozZzR6MXFoLytrRmZBZHB5bEhzR0Vqa0UxNkZTcXVIQTlk?=
 =?utf-8?B?dk5JTkZhOWVlWkpCNlVoa21CaUcwTytwancwRUVNUENjSEhJQk1SZFJPMkxu?=
 =?utf-8?B?QUpwQnZxVU1TdnltaVFVNWFLZ1o2amZ6ejUvOTlMKzVEb3c4NUtvdkoyTmtY?=
 =?utf-8?B?QTd0Y0prazZuOStTbEtIVHA2NnUyUjI1elBrekx5VGhQWDJCVTBCMlBUQlAz?=
 =?utf-8?B?RTMxdmh1NnRXVHZ1Y1hMVmJGNXJiRjVNdHYva212UHZodkRnS1RoM1R1R1gw?=
 =?utf-8?B?T090NlZWS1gzTmJxYnRFZit0ZEkrb25PaG1TUiszNElyZU5GREVtT3p0MkdJ?=
 =?utf-8?B?OU5sby9iM0IwK2dpd3lESnF4SC9wVFJLNUZPbVh1MUVjaFRnSUlaTGtvbXd0?=
 =?utf-8?B?dldUYmMySXhEK0JiSkJ2R1pRSGdmZ0VQa3VtZUdyd1F4eFAyMGQ1ZWtTVnU2?=
 =?utf-8?B?cURHNWdJUE5xV2VUTWRDL2YzaStpSlMzdkxoUnQraHovQzZJOXI4blUxUW43?=
 =?utf-8?B?TlRLeEhyL1FMSUJKcjNPbnBqN2xOOHBhS05DYWlpbCs4RTJLOVh2VDdXcDlN?=
 =?utf-8?B?OVRJYW51SW9MVkY4WnlMWG1vdDh4TWVGVXc4SWwyU0ZNVzROUk8walFuMTEw?=
 =?utf-8?B?M01mN2RUVTVpTUFFWTdKRGtMeEhucnVTYkRKU0t1WlJYR1gvbG0xWER2UlQ2?=
 =?utf-8?B?T0pzbmgvblVKbkJoc3NldkNTVk1sdGpnRURqdEh4NUhYbXBpczR0OFY3NnB5?=
 =?utf-8?B?RzI4bGhIWmN5eStnRXJubldhQzloUkc5ZisrSjl4WmRhNi9TZXM0eUlINi8z?=
 =?utf-8?B?bkp1K1ZmSTQ1eHdzbmtGaFcvOC9oRFdLbStZWm82U3BSbGJtVnNNcXVtWUFo?=
 =?utf-8?B?VmFKMElpR3ZyMUZJM1QydG9VU0E3VWxaWTNCZHFrREJxZ3VrdmJFVUZMbUhO?=
 =?utf-8?B?a3dIU3RKQ1loUms4RXQzT0ptZzk4UUlVbWdwRTE1TlQ1ZEpwQk5UY2Zua295?=
 =?utf-8?B?UGp0RVhoS0EvL0ljaDBBY09BTEVJY1hVbnp4M3dLNTZOemtNdE9WUkpIdVQy?=
 =?utf-8?B?SEIvR3ZSR1lWR3Rqenk3cXo0MXdQQlFnU0NjQTQyRDJrdjZRV1U4dnpsd29W?=
 =?utf-8?B?b2N6VUZ4bFJ0NWMzV2hOeFBza0hBVFhyVm1ydEYvQVNCZ0pNOCtUTHBidG1m?=
 =?utf-8?Q?/3SXeT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:22:59.6854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e39f45-86c9-434d-5955-08dda9c50405
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7477
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

Enable the cleaner shader for other GFX9.x series of GPUs to provide
data isolation between GPU workloads. The cleaner shader is responsible
for clearing the Local Data Store (LDS), Vector General Purpose
Registers (VGPRs), and Scalar General Purpose Registers (SGPRs), which
helps prevent data leakage and ensures accurate computation results.

This update extends cleaner shader support to GFX9.x GPUs, previously
available for GFX9.4.2. It enhances security by clearing GPU memory
between processes and maintains a consistent GPU state across KGD and
KFD workloads.

Cc: Manu Rastogi <manu.rastogi@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2: Updated comments 

 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d50e125fd3e0..866e39f6fab3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2235,6 +2235,25 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 0, 1):
+	case IP_VERSION(9, 2, 1):
+	case IP_VERSION(9, 4, 0):
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 3, 0):
+		adev->gfx.cleaner_shader_ptr = gfx_9_4_2_cleaner_shader_hex;
+		adev->gfx.cleaner_shader_size = sizeof(gfx_9_4_2_cleaner_shader_hex);
+		if (adev->gfx.me_fw_version  >= 167 &&
+		    adev->gfx.pfp_fw_version >= 196 &&
+		    adev->gfx.mec_fw_version >= 474) {
+			adev->gfx.enable_cleaner_shader = true;
+			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
+			if (r) {
+				adev->gfx.enable_cleaner_shader = false;
+				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+			}
+		}
+		break;
 	case IP_VERSION(9, 4, 2):
 		adev->gfx.cleaner_shader_ptr = gfx_9_4_2_cleaner_shader_hex;
 		adev->gfx.cleaner_shader_size = sizeof(gfx_9_4_2_cleaner_shader_hex);
-- 
2.34.1

