Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D222C3DA41
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jul 2024 14:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFF2310E220;
	Thu, 11 Jul 2024 14:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MF/1cWjY";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7495710E220
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 14:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qn/eD5lMamynIWnQNOk1+1csQrAENh2pt8QkUTed/KFZPCdj6AOx5FWj+V0vCPCW9wS8+2xFWA4U+SMufMVdyXuHR/ai42y5lGRmdRvmLYhhGJ9cbgqRfcRHfg5Dl5Kl2wUbE4QXF8kNAtd9lcJ34Jz4kLWrT6QlkSt4zHf2/ZutRGuCIkLeYx+98xwBhky4djcVjURppbmRt6Y5RtVIZSH8DTpVFnjZYCdHBoHF+BSF1YdFtZTHsCqnJRU13o0ewnVbGfw3V2tMffTQZWa5kRHz8pILZzikztLhVO2CdjqFyV1LdMH+nbgM/el3/I28SPHDZFhdq0pEhYqtvX5MRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqVJUiwl/EanCuS+Pj0ZfichuwS6dk4olvmZXPeGWiw=;
 b=bOonOu1RoIGzHR5WyJ58BXz4oGhep/Ewxp659k+AyHa+X/uxBYEzAkhL6ERUFmc/t1lmOJQ67pycbemmHK+w0nSqyPQO0Dog+7kVuheAPzgHKu7JshtrbD0nWSgp++4rhw1t+qsvjS2nDBQd/b2FUHy7TCNiUJWDc9Lx/+oEWQ0irtog8MbwJOwrlVlpw8kEf3BlcYgiiw4ok4YQVGA5IIA7s2HItJZKCP5ZmIgEkU2kfeujxd1zNOCY8nc3vyTvP14JsFv+hj2ChS4pk3OxPPe0HSio/DHKlPzRNCOscWxrx56/84+64sYajExkwnQNecIKtBJaYcxgQUkYoeVVrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqVJUiwl/EanCuS+Pj0ZfichuwS6dk4olvmZXPeGWiw=;
 b=MF/1cWjYNRfzXhy9NjuSL0oXv65WMSY1sTQ0MNB0jnV3elC3jfURQPqIcyIkJVvdAtdlf3vKAhHxO5KwcVnirLAWdO1kyuyzPCxpVFaGGdQv6HonQnEzofdbHDBcMC+2mTynxV49+wg93Ws0su2XTDJolyYDRAuUovq0e1Lmd/g=
Received: from DM6PR07CA0039.namprd07.prod.outlook.com (2603:10b6:5:74::16) by
 IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.23; Thu, 11 Jul 2024 14:06:05 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:74:cafe::92) by DM6PR07CA0039.outlook.office365.com
 (2603:10b6:5:74::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Thu, 11 Jul 2024 14:06:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 14:06:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 09:06:03 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 11 Jul 2024 09:06:03 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <marek.olsak@amd.com>,
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd: Bump KMS_DRIVER_MINOR version
Date: Thu, 11 Jul 2024 10:06:03 -0400
Message-ID: <20240711140603.2860632-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: cef09992-a539-44ef-23ae-08dca1b29ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5XdYYs8IYyQ+xwNSxecZhxvhPu0bxgHjK9w9fABjQC8nC/bnuBk7Bempwfgi?=
 =?us-ascii?Q?jF70YHB2CLXk5uZpmK1GtUFGJSkDHKFylceGVRXJSaRBUmsUFCmbPoXv8YKV?=
 =?us-ascii?Q?POFEjldh8VeqSKLgoG+FQXpLl1dL8tKWuwQDq/PfeooiJOudUgQkUIr8OU7w?=
 =?us-ascii?Q?MzDX7ymBcI1E1rxlHHlId8vIFN6lnhd4pbo2iOnSyy38GYJZBoIL4HQ7PBj8?=
 =?us-ascii?Q?ZK4o0PGCc+Wf8+daGbCtO9ks3KlSoTA209/W010cXlHGc7m4VfDqRtwZRMYm?=
 =?us-ascii?Q?JYGOGHfGZFVtGXRG9Z5s92SbX1/Vyv8EDvTSxloGFdVvzE+1dDM5wJko+I8W?=
 =?us-ascii?Q?D77LJAWxRJ13LXFLNxiZnG7h+k9U4uiYd6hs04N8w0QVUp4eB8lfS4V1Igpv?=
 =?us-ascii?Q?z6iJowQl96Ru3eRitPQb5rjigbA608Kf2x9ZPCJi2ar2GLdx//7z6GgEmPi1?=
 =?us-ascii?Q?qGryS35OWqUN+UQRdB6JUdwQMyuFGAjA+moYKssnlzPDC4ENr7SUTwwXX9hE?=
 =?us-ascii?Q?SnJLjlYb3s/47Xct20jeSt4iUOZxg09MNBufcvl6PRtkRfvJP9MyheexW1EN?=
 =?us-ascii?Q?+lMCXXNYJgVTAwb2ccgsn4IZyAMtJDozwxO9jYQJBpIZorHXAXwzmoX6tUeE?=
 =?us-ascii?Q?D2B16FivtOonLJ3wVD6QHcyOfIl4YqzWmApEVp/rDnUoGXUagygnC4aPuluR?=
 =?us-ascii?Q?pMqKJfbD9DEOlZMAO9hGwdG9LsIQcDOKfCsVBBPU1RZEUOFvezmvOwQLZbsB?=
 =?us-ascii?Q?NLBNya4tysvHnpUdW/ziir4gLRXUSDK47XEV0Dvsn48Tk8L/KpxgUC/jvAql?=
 =?us-ascii?Q?RCsaDGjWGKIh1nhFlyIjrgbRJCkTmfJ67m6O8jX7nHi0cpM7dg8Y+8xMvRVm?=
 =?us-ascii?Q?DKz1sx5545pVrBNnPzqWAYqcL6Y/KZBk8VvHN3P1PzvCe0oon+BSHhvDxpIV?=
 =?us-ascii?Q?c25zySoQ7TrH3lHKKU68Oi16rRYJQ7Y05mgH28GSeNCxFD9EpdNGzjcSta09?=
 =?us-ascii?Q?9dqMBZEhsAtPuhBvslyur6kUQ6Dh7doeWp3BRK6omJNnGtCqdqNAvH0xl6jV?=
 =?us-ascii?Q?4RKFiwtEf2Fq0dknm94jMC3+PQ558Wdfs1BV3iGf+N8/aHCpRrWiMxx/l2Wj?=
 =?us-ascii?Q?M5FYh8TwbbUqiDhi7HrMGGIJiigQhnjC8vz2bAVy07JBkoYK7GOlNSGeZcij?=
 =?us-ascii?Q?BoxYsz0tdzlskAgu9VDt9/MkBn6bkmolmTrTcoTL2KiSrtSVHbZIUKfLXlqK?=
 =?us-ascii?Q?O9MurbbazvQ/2B2gkDyOm7LXb01gJc4S9bu0t1/+BLpiDjfupgdHXDgP8IfZ?=
 =?us-ascii?Q?k1WoAn1d8mo6tpR1D6FP3igLkxoeV3aejngMvyZ4vYKqsfylfyANFemZ7xba?=
 =?us-ascii?Q?zPMyr2lRA5MsvHfPOgRLL2JafguuZqF39wZpnLvW/38qyYDNkoDVxFTW6ZQV?=
 =?us-ascii?Q?eZSGr1uWgxFuduMG6Un7jFKPnCOV0wdY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 14:06:04.9842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cef09992-a539-44ef-23ae-08dca1b29ac3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604
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

Increase the KMS minor version to indicate GFX12 DCC support since this
contains a major change in how DCC is managed across IPs like GFX, DCN
etc. This will be used mainly by userspace like Mesa to figure out
DCC support on GFX12 hardware.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 802debd8d9f0..af44cbc90d2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -117,9 +117,10 @@
  * - 3.56.0 - Update IB start address and size alignment for decode and encode
  * - 3.57.0 - Compute tunneling on GFX10+
  * - 3.58.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF & AMDGPU_IDS_FLAGS_MODE_PT
+ * - 3.59.0 - Add GFX12 DCC support
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	58
+#define KMS_DRIVER_MINOR	59
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
-- 
2.45.2

