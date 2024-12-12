Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D781E7717F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 22:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C183810E2FE;
	Thu, 12 Dec 2024 22:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KrB61EMg";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9302F10E214
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 22:09:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/sbMfMA9j9KWqXj1r0XSXrbaY9cfBGh0IwTT1dz98VCdw/sx+2VAyhaLmcwmvMp+MFIwoo5DQrTwG/O7oitMFKR1oNDa+fKMPYhBCu2dvPuuUozo9gYK45Ma1KeISC0ezuWjakQ8Xnz35nTNh7j2hHSPgOP+EymglEFbIaRG9Yk+kq6ZoS/hCHsximhZ4QD4mKtzJWrOz1610pN3Oc65CkeXfU8/Pz4IhTyF/PzbbQlKu93gr9rwRmIQs3fKjsd1E+S+4LZfZ7KD4HvhXSHS4yMy0pN8JyILQQqFVaDKsR54GmjelWYLwSbfWMJIfYGaxq7VC0qJnd7Nc2YB2WWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1JkdZ2ILu4gV0P3jj9uHzX9TpcrRULHZU34rWnPSb0=;
 b=Dg/NLbP7JlpyNGKRLgG0HZtJn6k4Lf1NhCr/Czabqew97YDkMfgcTUSa8aaoeeMT/nWHujFOIbE9s2+TUtMNWmR8Kb/YH86aubph+fOIvtlA/eoHvczwwcrUFXPcuS1Obdl4tRuDiXWDxP6d65k/oHodDruvdwrhKF9x/TwZ6aElGSgmBEcnuhPnVUeQu7I1jKlXD+9g/suC5SYEj3W4xeoYHBuBAS99MHB8quzxuNror1Eq+kIQ4r/DuFoyoojUNaG9cD5mN0euIonGtcJ0qq0MaTxPF4HBkTMFVVuJ2ko93ZTt4l7WoMs5a8rD5tiWCm7/ELQHUuFs0eIg9qn35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1JkdZ2ILu4gV0P3jj9uHzX9TpcrRULHZU34rWnPSb0=;
 b=KrB61EMgHuGtX05cSKw37wpTGZpOshjmPhOzBDd1o3gA/JWV+5IfV1e46vkENg8LWLfcyBEdFYoBz3vQptOaihOUaSw+yRiRqLwolPK1IKBOLynQV4YY/KekJJN/pkO0DQD4+P26HDcqRU9Cwm6DSaLKk7bPIa4ROm2sxSi4hI8=
Received: from BL1PR13CA0246.namprd13.prod.outlook.com (2603:10b6:208:2ba::11)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 22:09:12 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::18) by BL1PR13CA0246.outlook.office365.com
 (2603:10b6:208:2ba::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 22:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 22:09:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 16:09:11 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/6] drm/amdgpu/mmhub4.1: fix IP version check
Date: Thu, 12 Dec 2024 17:08:53 -0500
Message-ID: <20241212220855.790502-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212220855.790502-1-alexander.deucher@amd.com>
References: <20241212220855.790502-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 89732141-d185-4731-df90-08dd1af99c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3uVLxaghuRU0OZufT22fPFPoD0t2xzvLXLvt28bpfnRfFtNDGy7B2ZILjLJ1?=
 =?us-ascii?Q?Nh2+e9qDnV/xvaXSJy/UGYHJZuioSXaV6hv0QegZYaIW+6lYTZV913DK1u7H?=
 =?us-ascii?Q?rz7Zpj2n0DEnWxouIBGFEySgGycOjUNm/BHDFQL8oWDgPwl/kNq73eEaKSaQ?=
 =?us-ascii?Q?694nE/t4GFcbWvi0/bHD3062AnXCkf0eFPGWc+dAcg02LGweatNlnJE7ZPsR?=
 =?us-ascii?Q?0UFKxISW8cy9jQ0Ieh+EAEpv+wmvMr3ZTCU7cUTTuIDZiQ+B0F4yuYSD5xeY?=
 =?us-ascii?Q?+0NruqOUByybaiZjwaEVsxJsKNbCi1pVkQ2xDgRU11ZTU6WWh56MWbOBkjEK?=
 =?us-ascii?Q?O0w+2Kg6aoTBp2F9Ugxd+kVzxrHH6uJJ8go9CYR4cyNKg7nkusFSRV+kHBEn?=
 =?us-ascii?Q?ersCQuyfNVNNkmivNIIC3Czw5cbn1DJjDCa3M3LtIRoEtJEmgz1ArkyKFcQr?=
 =?us-ascii?Q?XsHhD4TM5LTiIpjw2BZ7rqCpEYB/xFPRjj4qClS30L+7D4w1jF7lLK64LsE8?=
 =?us-ascii?Q?U6AQwPv18MzFCEDkxf2D+ZTZXyez8Jsdv7yhcrqJ/1+f3JBl61EC9+Q+wewK?=
 =?us-ascii?Q?hGDGSLHFHqWv1pZsHF9+LtDR6+PehA15hE7pzxYC2aiEd9ZNrJkkXKBsRSl/?=
 =?us-ascii?Q?ojk3ogPqUOJ410ZAdjMgb8WOcbGU2P1DFtiLV3de4G3mzhS9r7ik6rRYAAnk?=
 =?us-ascii?Q?ABxGVg3xv5UvEdfitz19zqr6pSIb5GpO9Ib4UHMMjLeCc3r3IsbgdWwtWwuC?=
 =?us-ascii?Q?H320X9/eCryZeQwPlISWZ6Jv4COKrKJxXhFOh9T90lV3c7diHWe3oxuMhWt+?=
 =?us-ascii?Q?hmoPd4OHYffu/L11Ln6lAJQfeavQAqX6KK03048iQhwZ9gLE7EttzYAkroC6?=
 =?us-ascii?Q?PmZ1aX7PSc2NoZVEMzNvbqBaL7+wMXbLkj68Bo+BJgxBHrGQf3IBdFLzrvmB?=
 =?us-ascii?Q?KdzxOvqEwIryjigUjxo2iqdCPcG7hMjr4WKbBniYzq6pS8wF3x3r7rEd5S2x?=
 =?us-ascii?Q?AV3/R1o4uFrjlaqV17Mk6gAs0nmLT3//VMxDEFiHMJjPTGV9IYA+4kFU7hw7?=
 =?us-ascii?Q?n6p22yPD1ZxARddR+NOaa9mRjLRQHfm8rtBtfmhGYYyspov7++Gl3QdmVk5k?=
 =?us-ascii?Q?y2ubmKJwXnVvVlye6btvN46tszLO0/CfJ21oNpx3XnOR9B2Axs++s7lUJbct?=
 =?us-ascii?Q?/HngbkQqKvrgSJsD4qa073n6Kk0v4CQiF7cTtPPb3ND6ytfCm6yzWhU3XCnO?=
 =?us-ascii?Q?HG80TTz/2U4guRVpZFyfWkzoS3YbokOnwORgs4TiR5zfZBF3Zu6o3ZdHmx4B?=
 =?us-ascii?Q?l5fcL4Mf37xm03T6+05HzIRZpxGUzdeaKXZL1wzmOB8VhHk3yEbhSkPxI1tE?=
 =?us-ascii?Q?s10Im5xEter1EgeYVpkwTc40QMBAwQMiwdb9jxnl7NcTocn3WMUb1NehVQXH?=
 =?us-ascii?Q?TGkUGj2PBWmGXhOMrt8bJtgpgJ6e8AGS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 22:09:12.7250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89732141-d185-4731-df90-08dd1af99c4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
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

Use the helper function rather than reading it directly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
index 0fbc3be81f140..f2ab5001b4924 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
@@ -108,7 +108,7 @@ mmhub_v4_1_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	dev_err(adev->dev,
 		"MMVM_L2_PROTECTION_FAULT_STATUS_LO32:0x%08X\n",
 		status);
-	switch (adev->ip_versions[MMHUB_HWIP][0]) {
+	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 	case IP_VERSION(4, 1, 0):
 		mmhub_cid = mmhub_client_ids_v4_1_0[cid][rw];
 		break;
-- 
2.47.1

