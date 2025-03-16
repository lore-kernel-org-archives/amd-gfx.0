Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28155C282DE
	for <amd-gfx@archiver.kernel.org>; Sun, 16 Mar 2025 15:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE36C10E195;
	Sun, 16 Mar 2025 15:55:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T55expJw";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EAD110E195
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Mar 2025 15:55:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiL/YgNfNwH12XK5Vth2HdL86c5Y/MebIes9b1JqidAUw3S0Cn3lLOdHDEP9BsLiH/cu1CioopSfT4w5NTl09UHMW6B+FP0tefqUxfKBruf7Lsi0ZtYFQQnP88u74ydSyNLBPWTMlIM1vRPfCDrkjLDw1jxxZuB9fkBU+Gman7g2w009zjmsPYOhgvX0DbW4/UJF4Ee0SEf8R5kD4IClW/IdAAtmJNxx9tKvD1HaRff6+Ma31o9IK8rAyiJp9Hdky7DiS7q2ki4dVC7PtK7ZuMOe8t+gRt2A3QNK6tav1+w7vNZOca7pKcs+/twaLSbHvpSOul2f+R2yQ+4gaakR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpxxjFq7xJ9wUUPQjLRT7kBPe2CZVqCwyTryu0fjsP4=;
 b=uICXjOdGlqZ0MeW8Wdhee9CeYeE/9byvhBa22UB+rGzw04FhGkuZa1QxLquM608UWpJOIFAIED15JVpi4cG+mDuIjtWkyNd+a9lfqSBQN1Ua0LIsERGmLJMvxUR029HfLvi3ERBvmVba+hCT/+WDUA/1j7iSmFXa1MKIZuUgeK/dOvd0PaZgu49Gw4ZI/Q356PxIJjWVC9/o25XE3UoCOSd44ZUgnmshOorAj5za6P16dQK3jVc1NNLLMY4VjrlCQ+ZP059T/KgNkmAfHEmrM6anBkK3mPfIYlV/ChSPXL34E5GLL+dT/fuK8ur6RXHvM0jHpDh+hTACaWBidOyXWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpxxjFq7xJ9wUUPQjLRT7kBPe2CZVqCwyTryu0fjsP4=;
 b=T55expJwOW+7db/Mwh35pODt0pmHQg9mF6bqZGr8mJC0m9qD/62/TbPLUsbmLdv8rn6J/WIpniE/UgnOyMiZmA0AHkuRW3iJ7w0ZIsjRYgKP3jgCgtODR1aAcR9/nIjogfu9V66z+CVYQCODquNXhxUE7pLeo8JJRMDPCgCea0Y=
Received: from DM6PR03CA0011.namprd03.prod.outlook.com (2603:10b6:5:40::24) by
 PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 15:55:25 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::8a) by DM6PR03CA0011.outlook.office365.com
 (2603:10b6:5:40::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.31 via Frontend Transport; Sun,
 16 Mar 2025 15:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 15:55:24 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 16 Mar 2025 10:55:22 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Koenig Christian <Christian.Koenig@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: update eviction fence driver name
Date: Sun, 16 Mar 2025 21:24:58 +0530
Message-ID: <20250316155459.1183356-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: cb968531-2f14-4080-bc5f-08dd64a2f6ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVgwUW5XZzFXZ2NFWEFoQTR3Vk5SOThEMUVZd3hCdFNHRDBaM3dMSW10ckpD?=
 =?utf-8?B?TDU1T3c4ME4rQlltN0dJSWpsdkZPQm5DYU8vTHA2elNHVE4rVElQaEdEa1FQ?=
 =?utf-8?B?UlFLSjZrWkRqMTZIVHZrSlc5eURBbElrY25lbEJNb0Uya0VIb1pWTFdzSlZD?=
 =?utf-8?B?NnoxRE5XNUZxOG85RVd6VjVpTk5aN1RyZjJMQjREc245aFlybTN1cTg2YVR1?=
 =?utf-8?B?dnlrTjB4c0JHaUw3eDMwMFFmV3NyYk40NjlMUUFtTTlwbTNNUUI5S3VOMCtx?=
 =?utf-8?B?aXJ4VWFTRm5lam9KdTNaNE5LMUlSeDJZbm9MdnlrTktBNHl3YnpFM0JDamts?=
 =?utf-8?B?Qk84RW1KUlVMRVZNR1NKM29NTzAvcW83d0R6bDJmQklzYlJBd05TTlNkVWJ5?=
 =?utf-8?B?bkxhL1F2cXZ6dGtRTFBDZ0t1alB3MTNLbFhHQ1RmZ2lHWDl4L05tM2NRSkZx?=
 =?utf-8?B?MlJQL3RsMGJQN01sVVpSTUY2emJ1MjhSZWhVdDdjTTNWVlg5MkNwcndURkVY?=
 =?utf-8?B?YkZpQnNnYTlqSEg0L0FvU1JzeHNKSFFTNjhjSUlnbFB3TEZaallYMEFER1V6?=
 =?utf-8?B?NXJmc2NuSEgxM01ibzJJQlVvMHlVRlE1bWNkREd5L3hXNHpraUlOMEZCQWMx?=
 =?utf-8?B?bjROUyt2K1FzTDhSNWs3b2hEOXdldHlFck1weTBpVmFUOFpqUStGZ0NEbWJx?=
 =?utf-8?B?NEUvNTZvK2RGcjFMNUk5YTZWd3h5b3owNm5obmpyVzFlZjhGQUpHbEo3STBW?=
 =?utf-8?B?Q0doWTMrMWhMc2d2eUN2TFIwWHRYZTVnYnNISEViMGkrTzRwUGt1ZWx2U2FW?=
 =?utf-8?B?RWFFS3FNWG53WnVlakFFMWw3cVBJOHBza0liem5ZdFNGY05meWZQMmVzN1gv?=
 =?utf-8?B?SWpzcEF0L3ZrN2FmOVozc3VTNENvWXZKMjNQelJzT0hSZ3BxZ01iWm4xSkwv?=
 =?utf-8?B?ZkFxTVZ0eU9RNWM0OThXd3E3VzdIYlV5L0dhakpBTnZYdnlVY1hMSjVVWFdG?=
 =?utf-8?B?NmY2clVBZGxJemhycEptZ3NQOHRjMm9BVVhWSEFxdlMyQSsyZ0tmRkJBc3cy?=
 =?utf-8?B?MkcwckUxRXNTdHFsZjB0N0V2L0F3dVVrZWk2V2dMOFY4ckg3aVNHUyttZFpU?=
 =?utf-8?B?TGVLUEI4VXJzUHJ2NjA2WWM1T1o3WFpEUnJYbjgvdnU4UWI1RGtnbkpQMWk0?=
 =?utf-8?B?Qis1Zjl4N29oRGFGZ0NWd1lDcUFTM0NIV0pQVGc3K2o1aWhUVEwvVWtramRv?=
 =?utf-8?B?L2JnT1g1SkxMNkpXVFE4d01WbGZIaDZjTHd4NklMK1lsZTBaQkxieW1xWjVT?=
 =?utf-8?B?L3lTUTBVTlV6UzZsNUkzeGZWZ04vS05UUm5sd2oyVjloeTJRQzF6c3dZTDRL?=
 =?utf-8?B?TzRpZmhqZ1ZRRkczaW1jY0o5OUY4aHJScHBIZ0tHdStBY2JDQzRtdU9uNTJY?=
 =?utf-8?B?Sm9iS3F6ZWkxUWpUYlcyeWxKWnQvSnhlY0dqaVZqckhBYVo4dTVuNGhWdmRL?=
 =?utf-8?B?VXVLMlJmd203Y0FKa0p2Rm5mNWVrSnVZWFFEeVUwN0xWbUJFbEQycEFwN3k0?=
 =?utf-8?B?OGpXb1RzaThUQnRxdGd2U1g0Tkh4RVFJU2tJaERtVklrUmZ1WC9qOWhuZktE?=
 =?utf-8?B?UUYvYk9OZnZrMUMxdWo4Qnp5cDhsYnNCYTYvaWJqcVJpZGNLSlZKWU56cDZU?=
 =?utf-8?B?Z2R5OWFrTDg4SUFwc2QrSCszMnRiNmNTWjhDU3ZRSW1FYkxYZVNnSmxCNXFN?=
 =?utf-8?B?d251ektOMXZDM3dvUEVYUVdnMFN3Zkt3NWZRU0sxNzRjMGhySitqZzBkNUpQ?=
 =?utf-8?B?QTFKamgrUkJUa1NydUdldzhUdkRxa1VLTEtrL2x6bU80Um91enA0b3YrWWxn?=
 =?utf-8?B?dXJwWVJsMzNFTWIzUzVxOXBwRUtyViswa2xLR3c0RkswWGxuek5SYTFraXEx?=
 =?utf-8?B?MHZGL1RIbi9iS3JiQ0FaYXpNbEwva0t5c1VacHErUkxFZXBKSnNIeUNzSWts?=
 =?utf-8?Q?TsaFU7oOMWa1EAGiV3YdjS5Mqq4bS0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 15:55:24.6083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb968531-2f14-4080-bc5f-08dd64a2f6ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232
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

