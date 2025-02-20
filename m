Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F103C021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 13:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1C9310E1A3;
	Thu, 20 Feb 2025 13:48:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f18JqpFS";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E528F10E1A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 13:48:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wuUvxnOHIQsDfKK4gi0nmxW4Y5FqUf9mESE9aGY9iEIl4PmpOtXhxy2CEJLc/V50r8rOCJcJKBx9UCjsw1T3/ryCgfKWccG2qEW/+SJGXsz9EV3pHCr3/HjXhoRkri0lDHGEC0pE2+NXs+NZK++CS6yKN3qbVrvDzk+Ru9BYWUeyH/MepIvtjxcbbL6VrU5ikDjoYwScUnxpq8b+e46uSNaauBWHH8xzenuqta3LoAdhwd/jCXk7gpRwcVVWU4+xk40RP/qQ0IwQmOpwYx8NG77T3gxvLIiGCnBLmwxXt9JUGjkUn3DZzuBt/7OWoqB9ZKwYdfqGvVchANPkUk9F9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9kXB0aujC9XPFxlcNHob21opcaXdKVnfK6df82bb5Y=;
 b=mXUuJYs7y7xbhfbXvY7Gy8hiIp1UrISzxSEHxE2HD4bD0pwuXt5jRSCRMq2XuEHHZ5lGdz6UCnePKkHud0Kip0fTQxtWXiLTiWhk2CexKVtQ7LAjhS7Moo/JbJHhVdsD+BM6k2UI/bWA6YaxU/igD+Vw8IZYjggGOECrjVSkzc6mZRuJUwwzFfozcrEBntDmTXRNPdoMbf0e4oboKgPqHytMGdz8Zl8cHEvOpmj/Z8cCM7hKX2Of50nXbHZm6uM+e1vk3KekPDusbSFGvByiLtUP6yKF6RsNwS6WsDuRy7CaXav09jU1kiV7CTFurXn6D5cA6ypUZtWbHFGEH8nEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9kXB0aujC9XPFxlcNHob21opcaXdKVnfK6df82bb5Y=;
 b=f18JqpFSDHbpXxs3R9ImjsR1gRWiYTpznFppNRljYTPp7qgVJBQjRK8/4cFtosKhimZKxv7RrysKjxKOoCRRrGIS4oe285vwYz5WxdXBX8A6Q+lGWi5U3wEcGRyDiZWLS6grhrv/2bG8QAJdeYKjz47fT8YrQ93kCRIa2VY5UgY=
Received: from BN9PR03CA0252.namprd03.prod.outlook.com (2603:10b6:408:ff::17)
 by PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 13:48:49 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::2) by BN9PR03CA0252.outlook.office365.com
 (2603:10b6:408:ff::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 13:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 13:48:48 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Feb 2025 07:48:46 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH] drm/amdgpu: Do not poweroff UVDJ in JPEG4_0_3
Date: Thu, 20 Feb 2025 19:17:51 +0530
Message-ID: <20250220134751.2992715-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|PH7PR12MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b7f9e95-3636-4dc3-410f-08dd51b54d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnpxbFpqa1hmdzYxRXg1dWdsaHJEam1qOExQOGdONkxDZk5xSGpZRTB3OFVt?=
 =?utf-8?B?WWdJK0dXV2x6MWVzRjVUZW5QNFZGWFBwODdxY0hDZzZvM1Z1a1JUZnJmcHZ6?=
 =?utf-8?B?VUlqSTF3NUMybjRSV1Ava2ZxTkgwVjhUdzBLYzdBSlJDWVQzM0hjZTN2STRl?=
 =?utf-8?B?ZktZSXNNNitocC80RFJrcjh1UUZrMk5yMFZUK1VoR2ZYRWluMG45ais3dXRs?=
 =?utf-8?B?cksrNy9Mc2ZMb2gvYnE5OHN4eFZjMytnZm5RdkluWE4wd05kUGlLUWE2dEZY?=
 =?utf-8?B?WkpiT2lKWHJMTGNVR3dZZHp3a01hczdhemwxMlp2azQ3ZFhmNXBTT1lRZWY1?=
 =?utf-8?B?S3NsTmZSYm41Z0NJK0hNR0plTjdUUjFjTjU3R0o0OTdoQ0ZiQ1E3UTdHRWtV?=
 =?utf-8?B?SDZjaVZYOXYzVDRPM3A3TVdvWnBZMnV1c1pRaDVabkF4NkpIVlF0NENUWjdm?=
 =?utf-8?B?VlRYQ1IwdzFSbmtuaG45d0FYeEVRU2hXYWRXWC9xS2ppa0dnR1RtV3gySC9s?=
 =?utf-8?B?aW0xS2Uva3BnUko0eXRVRCs1K3hMMU0rdVkrZDV4Rm0vQzFZaTNGYUlUQUNh?=
 =?utf-8?B?NFVjcU1DaStkQW95SSs0TTEyNklYT3gyd3hOQi9uR2kxN1VZSEJTZGpTSWxj?=
 =?utf-8?B?aWd3Uk10VXMrSzAzTWx3eExUcXViclNDR0xxdERMRCtOVkNPT0djTGtpWUw1?=
 =?utf-8?B?TkM2Q2YwY0ZDcVBpVlAyR0l1dlB3cHl6ZmhTZFZ3QXBBVVBseG40c3pCWXV5?=
 =?utf-8?B?VGVUcjh0SjVRdE5tWUQxVEo0Z1dIQ1NDaWJHaFV2bTBRQVhxTVQzY09qVG5m?=
 =?utf-8?B?RnhoZzRCT1djR21iekg2ek9NZWovOVlQOXFHOGdQdHVBR2x0bDR1QjR3MDdR?=
 =?utf-8?B?VmRwU1hGaHQrcDZ1cTZhMkI2SnR2TWpHQ1pGb2RXQUdSaitXcXQxcUJVb2hR?=
 =?utf-8?B?VlVVSDIyYjluZmZsdTlTdERjUEJwcnhBL09xNUliZzhuODhJcVZMaGNFcE82?=
 =?utf-8?B?Zy9tVUgwZFcyQlVjWmNhOUwrUWY2UEdYR1M2WkVqZjFITkFrdFBkUmFxZzJD?=
 =?utf-8?B?cXd2QWhTKzhSNHRhWDR3aEZ5WjZlYk0rQVVEZ252YXV5NHoxUjFOY1pYeG5B?=
 =?utf-8?B?Rlh3V3BLYWxBeTZjOXErblY3M1pOSVEvNXo2TkExTkJmcDJlanZHVjF0bEYr?=
 =?utf-8?B?bDdGRms1aU5IdkVXQ3RCOVArVldsYW0rNEJzeUVQZ09sTUhMRU5oV2hHbHpv?=
 =?utf-8?B?VUtBWXA5QTBzM294MG4zaVZsdmxmemlrV25sZ3crWkYwS0Y2M2JSMTgxY2sw?=
 =?utf-8?B?UGF4eDIrU3N4RkRkcXFKOHdhRlM3OWhMc0JVSVJMS1l6OExPeVdUYUdSMTFx?=
 =?utf-8?B?TGhKNzJwZkM0TDEvS2xHYjhoTHFHdHU3UE5KRGtEVkhvVWc2dzNoeUdMcENl?=
 =?utf-8?B?b3ovVWs1SmgxaFN0WWtubEVhVmlZR0dVTHdTSkpBdmNKd1BUUUNwTk8zdE5h?=
 =?utf-8?B?ekJ5Um1qVnMyc3czQjdVQ0dZY0NveU9aazZLTnRpZFlaUlV1Y0FJZDZaSmlK?=
 =?utf-8?B?OG0wY0FWRjgxeTArZjFXWkJlYXVBR0prOXZnRElHWGR2WjRvNWU2WmtkRGZu?=
 =?utf-8?B?YjFPaEJZT2pnMlNvdTZjSGlXT3hoYWd4N0lIVDVlZEd6cWM5alhqVDBvb0J6?=
 =?utf-8?B?YW9NemJqVzQ5MmFzbU5ad0RxTXJtTUpTa3NvaTFISTA4RHA4Rkk3ZmtDYUk3?=
 =?utf-8?B?NUl4eGRrNTdKekJYOFVSQWpJS2Q0Y3FiSGlTaEI4Z1RnZXRLSjAvTmlVdTJH?=
 =?utf-8?B?d0laaEdyTHZncVRBTnR1dURSRHdkazBSeXgvVHl0R1JZQzFBWk9BL0FFSHMx?=
 =?utf-8?B?YXUweUNTM1djckZ2anhyYmlZL1M2YTNhWGJzUHNoOFpvOHhRSVZHcnMreU1p?=
 =?utf-8?B?Vk5BbzlqREVUYjdBc05jWjdRUGFWNHR6K2hvRTZQdXBxWk9KOGJqZzNrNHY3?=
 =?utf-8?Q?Th6kRe2YX8JuUYqrlMJ4yEo+ECx+hc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 13:48:48.5577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7f9e95-3636-4dc3-410f-08dd51b54d65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6739
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

Update power gate setting to not poweroff UVDJ in JPEG4_0_3.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 0588bb80f41e..554406abe480 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -634,12 +634,6 @@ static void jpeg_v4_0_3_stop_inst(struct amdgpu_device *adev, int inst)
 		 UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
 		 ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
 
-	WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
-		     2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
-	SOC15_WAIT_ON_RREG(JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
-			   UVD_PGFSM_STATUS__UVDJ_PWR_OFF <<
-			   UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
-			   UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
 }
 
 /**
-- 
2.25.1

