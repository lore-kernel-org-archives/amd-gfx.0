Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B8FC282DE
	for <amd-gfx@archiver.kernel.org>; Sun, 16 Mar 2025 15:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B7DE10E17C;
	Sun, 16 Mar 2025 15:37:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1hEBg1H/";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C09510E17C
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Mar 2025 15:37:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNtVENWTPEZrPJIzBq6yds/woTuuRoJhqyEWxcFiJqCK+G0kcrlCa1BSQHeTm484lfuS+wv876GcUDGs2O2MmFJ3mijAA+MWbVDV+CRXFL3fsh6I6TutSm2dxoCappynF7DgsIjv0U2nFl87y45XbeWrkORyvEuJQbcx6gQz7lcnUTChSQs8t+xSqUSNI4OUa+W1yfbVbeZusNFXwfRrmjIuP0Nzja8tK/7NQ92AT9lhhZJD6YmX/j+ra88dLVXzxbzGxIKpaFpfmIWDAVtO2jjKS5mpBteLNsJErm55305Au0ZM/KjpQDrG2dUW232WafkxrTcjgxwR3UXDGOHRfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpxxjFq7xJ9wUUPQjLRT7kBPe2CZVqCwyTryu0fjsP4=;
 b=VUFF7V6vWHVaWEwee03iEBhFh7Q59eW3JDv9rePWXJ/qyfpuYkfljmNQlBzyPZDrLhdmVfsaXGlMq0dhrr5NZ/k1XTfbQcklFxw62KDoIAad6ocCdfE1xwOGrsJVScVbk00o/D8CXD6ccbtSEzk7bEago9hqFAs2iHlA7EptbwAAjBYtbQiOZ0eqx0a+xmvJsup+y4mErqd5P95q3A8min9aYuQXhsMJSMJyV6vHwNPDGpn32vwUwZytSvGJ26jRuMmhzX6IvTNec4F91u8ALZ57gkKNW2zdwEOW5zU7PtjnVtHKLrF6RHs1qUi4F1CtRRSiNs36WjywTA8rRHISXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpxxjFq7xJ9wUUPQjLRT7kBPe2CZVqCwyTryu0fjsP4=;
 b=1hEBg1H/prLrwAd0wVh3NvSwpNZA0IvW6S06FBzuJkH0/POFo//n5kIDSRy0+36yhPhoLXUYcC7zbCmwT2pbcBGU2zvx/vM1pqA1q0fF2pBBjk2rvFJljG+kBu3oQjNP4vOF0DBa+o3S2Tx09TRnE8c8YxgDJ+BFc8c05J/95cM=
Received: from MW4PR04CA0378.namprd04.prod.outlook.com (2603:10b6:303:81::23)
 by DS0PR12MB8218.namprd12.prod.outlook.com (2603:10b6:8:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 15:36:58 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::11) by MW4PR04CA0378.outlook.office365.com
 (2603:10b6:303:81::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Sun,
 16 Mar 2025 15:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 15:36:57 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 16 Mar 2025 10:36:55 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Koenig Christian <Christian.Koenig@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: update eviction fence driver name
Date: Sun, 16 Mar 2025 21:06:34 +0530
Message-ID: <20250316153635.1181513-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c5d047-aae9-439d-b6ae-08dd64a06305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3BOSlFadElrdVc4Y25hZXI3OWFHWW9tWEVROXVTVk82b01zOUVVUkphc1lV?=
 =?utf-8?B?Rk1pdThyZDB4TXlHZTM4NmdIRFVLN1gwL3FyemFOamQ2Y3l1bk8zSisxYlpj?=
 =?utf-8?B?alhkNU1PNGRmN2dEUzh4VEtBSXJDTUtpV0d5eUkwek1SdDRHV3l5YmJucTdC?=
 =?utf-8?B?ekhwMEUwc2NNRWFic1VwOXZRMkVQQ0RMZitwRjVyNzhweHBEd3N1ZERENHV0?=
 =?utf-8?B?N0w4dlRvdmpIa3Q2eTVQTllsaHd4c2w1Unc4czBFOGRoU2JHT3lPSkFBNTZZ?=
 =?utf-8?B?V3diWHhBSTJwQjZIdUJvd29XZnBCMGNMU0U5UnFpS2RXempjUlRVVXg1QzFD?=
 =?utf-8?B?ckVhMnlkamhwcis2eHNaaVlUcmlON0hEMWQ0QTJ0ZkFzTCtaT0hzV1VITmIz?=
 =?utf-8?B?T3pPd2RrKzI1dTVDTnZtaFk5ZFRLRmJ0S29rT0NIRDQxR1JBa1VGOGJJL3Jw?=
 =?utf-8?B?Qnd1Qm4zcWdDT3Y5aHp2WkM3Vzg0RlBUZDcrWTdkeGQ3M3Q5Mlh4am8wQ3hO?=
 =?utf-8?B?NEQ2WTFreWgyZ2xaWkdJOEZWRW1rQ1VSUnJYTmtPc2xHSWliL2RUVTRpci9T?=
 =?utf-8?B?bkVzdjYwbFBzSnlteXRLNHRpMzh2ekdwUGdPdDlNRm80N0FHZHRpYkQyakpw?=
 =?utf-8?B?RnNMMXlGbUVrYm4vQWRqellNVkdhTmN5QnVvSFlHSUFJTTlIQ3VNVmJaMEFz?=
 =?utf-8?B?M0JQbmlmL1p0NzAzM3lkTHBYNE1wb1lkSDlBU2ZkcGZhalFuYU9jM2NoZURh?=
 =?utf-8?B?MEt4LzJmRG1lWnVuWHZ6L2xjKytCcnd4dGpPckUxMm9lbGwzR2c5bXpaWmVo?=
 =?utf-8?B?V0dlWmhaTkMvbXY1NkZUN2VTMnd1TURkZ3cwMm1laUphRjE4MWsxbUhhUm5H?=
 =?utf-8?B?UWx0MXJXNkR2QjlaM3VSK2VPRlgrQ3FZa3VOVGhkQVVrbEFEWjlOdm9VTTF6?=
 =?utf-8?B?Q2xzTW9nQzd1Y3k4SUMxMFllaWFKR3pwYktzNjFxSjRSTlpCMkxFa2twdlhx?=
 =?utf-8?B?WC9mYTlDVHJkbDZpNjN6WkhNa0l3NXVxRFViU1pYektMV3hIUE5WUGQ4UnA0?=
 =?utf-8?B?L2c5U1pPRFBGenFRZ0ppNVpNSTFrdkY4eGN2aVdVM1o1cGp3VEVXS1JEYVNk?=
 =?utf-8?B?YytNOEs0RnNUeFJZSitGbnZTWkphQ1RMSkV2VVprYnFRTkFiQ1VsYVlKbUsw?=
 =?utf-8?B?UURma21qOE4vdy83QnhaZXNFMlJOT2VyVENBcHB3T01yU0RHV05sWlRaWFI0?=
 =?utf-8?B?elFQUnRSaEF2VkdLTXBmK2JZZkU4UVhZRXVzUTFLUTE4eWdOVHQ0S0psU05s?=
 =?utf-8?B?dmZXbnA4UUZZV0JLK3MzVHBzNk8wK2wvYzVRMVYyc2dKalgvWVVOblo3ZXNy?=
 =?utf-8?B?SE8yUzFSOC82cnBmalB1ek9rdVFjd2N1RmFUSFhBdUFEZUlpSi9jSkFnU0lz?=
 =?utf-8?B?NGdGUFYyTVRJS2ZmQjNOdjdzWUZVMmVlUUNHREl3STZBQWZMZXAzOFkramhR?=
 =?utf-8?B?QWp2aW4ySnZkaWEwSmQyN0pYQUpCOGRVb1NVRm5WQS9pL3NqUjdBNlhEd1VE?=
 =?utf-8?B?K2tGWWN0Y2tpSDRhMHRKbVdQYU45NWF4OGw2ZU1LQ24rZW1VY2tPQTQrZTJr?=
 =?utf-8?B?VW04a3FsUEFRVVlZblFNVlBIWTQ1OG15dG1Ja2lNWkZlcTkvUkFxZlM2clMr?=
 =?utf-8?B?WnljYXYrZTJtekFoQ3VsSDgyQ2RiNmFzcWVjR29LcjVCTlFHWlNOSG9jdFh4?=
 =?utf-8?B?UTMxYURiTzRWUVNmcFNIcmhuYlEzaHFHbDJlbGJYTGhEd1pJd3QrR2RZclB3?=
 =?utf-8?B?ekFPeUhJcU9id1NrTiszQU5UTmpRUk9qaHg3Mm5BY0taVFYrdjdIUTZZS0hz?=
 =?utf-8?B?eXJ0UmJtQ2pRdmpBNnBzZGJra0FkeGV5UDVZajhUeW5UYVd0dnFDN3lwbnEy?=
 =?utf-8?B?NG1xWm9ZbldqODVKUFFWR0JxV2sxbUZZdkVFellwekluRjVnNTRrby9HTW9v?=
 =?utf-8?Q?Hk/hmZBewX+RsKhd2gfNTYKLnLT8mk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 15:36:57.4092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c5d047-aae9-439d-b6ae-08dd64a06305
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218
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

update the eviction fence driver name to amdgpu_eviction_fence

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 167951aee502..5142c477fd5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -31,7 +31,7 @@
 static const char *
 amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
 {
-	return "amdgpu";
+	return "amdgpu_eviction_fence";
 }
 
 static const char *
-- 
2.48.1

