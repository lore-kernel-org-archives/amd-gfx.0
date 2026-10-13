Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2FBCA9EDC
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 01:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A6A510E4DD;
	Tue, 13 Oct 2026 01:34:12 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013051.outbound.protection.outlook.com
 [40.93.196.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F96210E4DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 01:34:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdQaVQHwpxv+nnksV35aCfezigfiX8coRT85+B3R617afBBU8pJWtEw+A629UT/inkwownCLhefZkQmUCSVhm0AJQTCx9O6IRU3KmSajzMe3UM6SdmXV9eaI3j01NDBQboSOw40gxekAgEMVydE/WG1x/8ytXHMd4JyN5HC9OTuJg8ms5cNLGqgM0jRHtbsmcf/tBHBaP0rX1Lig6ilPrhPZwUIiwZ9qGJTcaWiIOmvZxOpJMfjcmG2L5GDjdqGA10UbM+D3iDzhT9itnMBlKcX2SmqqJnhGUqVff/SOO6clhnSXTlZdC1wNVTSoYbZ1cMaSIX1hYou0p5Vzadje1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZLilpmra+qWto2yML4jxHLfMTzzrTRU5uj+8CfS7P4=;
 b=yYafbsSTKryNDsryScNglvWAdI7F2hRW2fZqYUdSvK4S90Anqm41AYo8TGJ6w/f+MZXXRl4nPl+fhvECVq0BPzj9nVML+FKw2q5xcaesqCftzFTaH9sJgv62VVRd8hVK8uLycm8rFGUc0aliRM8h9CgCTbH3GBhz17BjCIEBcZh+Ojk0x2BfTzpSs7lthXzN4iQFUa8qCg2nH5RHwxwS3VUVKWoTjWAsJU7BZF7bcNd30Lhb9cTd14/rMdHFKq93Ht8+SSrT6ByVkY2Yj/rQLDAg4dY4qNIaETcSJ10B2rTuT16ezh8tIeDnrz7U4sUWlurP7+DDIIm3v+HzLoBLjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZLilpmra+qWto2yML4jxHLfMTzzrTRU5uj+8CfS7P4=;
 b=G7KYee0rpnzkuwDXJzZCua78ngY2VRrvcsOlQsHCKfhuu1uyOWYJE2GcrS94CDQg+O/x2zh7pVtJhE/e6JYB0FqgOu8B2GSlKRntmtm/KedRfWt9pttfm3Ipj+siuEBwnge4xuQSIHAAjM7OB1lYBUnBvQwBWu4aVXEx37W9Zaw=
Received: from SJ0PR03CA0133.namprd03.prod.outlook.com (2603:10b6:a03:33c::18)
 by MW6PR12MB8899.namprd12.prod.outlook.com (2603:10b6:303:248::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 01:34:01 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::23) by SJ0PR03CA0133.outlook.office365.com
 (2603:10b6:a03:33c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue,
 13 Oct 2026 01:34:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 01:34:01 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 20:33:55 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 20:33:53 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, <sukhatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 4/4] drm/amdgpu: reject unknown GEM_METADATA ops
Date: Tue, 13 Oct 2026 09:33:38 +0800
Message-ID: <20261013013347.2015715-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261013013347.2015715-1-Jesse.Zhang@amd.com>
References: <20261013013347.2015715-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|MW6PR12MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: 722a9078-bca6-47e4-9d31-08df28ca0f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|261009221227099003|10067099003|261009223027099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5/GDRg9UM813hIj9Wz0PelzFbJCBmRtoZ8xsc5FLeqeQYjBQyWLSjiu1pL+mzJOPoje2RIvXMASmi37OCE62ouzsTVHEERLnkw7n49FMZUHC7yRZEviBD1XWjiIP4kgPRpYWSM6higDGCSUqC7sqthZb/1VpJqE5MQKqBuk7M0CYoJm5DUDjE5tJ4eK1DVRh+Wxx4auZwhxRq+Q4CZY6EYAro1Fi5l3m/CpHDIWvzQt2M+PpMGJAxQLZWc7KWU2fUtCC9AZ1dXXxSns2RB2nG6SEDUCu3ppNEZq+a3MiqUkjOWPw3ckNT0gxapmi7j2AzShK3rQYvkH65BOA7ByUqNBFMB3okTKH22ruz/z/67S8X0CmHaC12z1QaZYhpkc0PWAC7OM9WSTO0qBZHvMhNt8jOLh4D9ozOP5Sdhd3h3pdL5WQwFhakay+OoMuzHo/U4iGeQInJwEUWRXZOJCZUh+W6cCjEKBHQd8+NYiylz/H3wZH8YqnabPvS9WVow+MVqgamEK6fsSZ/ErdlPFcvZh0OWuYzRn9s0C4/oGA9uC8t0eToQVYmYRhrWx5mbHfai8wtLX/0QI5JvBC7n2yvso2Yyp8nHJPIbpuZ8ZTWLmaq3mxnDkfPLsV3bpi/utYxA8mZCGv3bD+VbBtyhHwk8BXAkloADwy8ktn7pyDpbBf3asTr1IeSKcE19jcIY4wDgSISyFc3/8hawQ/OWDZzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(261009221227099003)(10067099003)(261009223027099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6dWvRxuZ0SxmdAHJ6Lwmi0hZl+OxXa0QNSxzMCenYZTavOpAV+JOA3HAjlsGzo7uSkG9Wo2f9PiEmTVYD8oWuMXfBs6DXBByfxZ2u+iXvq5sQs8p7a6VWlKLrNiZmxCDCtn0uedNeszTMVSHmcR9PuZ4vQdbMlFq+LhhYbdpCLdL88U9J0edC0oIAkhMya3y3w+gDir2Rb8TWyNT87YkyLQ87H8Is0Wp7emNgh/wlCkB1H4Sys1SnbzTf9AaxLnS6KSp4hyC1uSiDkjWwi6fOvZrXK4QzgoXjsU633XR8lyuRGyQ2k30voTrw21e0jXpf4JfU91vPkztGEQWCTXemoefZA5mhWRCg+W3QKEw+70BGvoKzbrUmY2gmcUYBuXZRMWidcSz8pXFca73rb1vv7g5PPdFQRHP3vns/5nj/woNvnliZZD1ijRQd0vVgH+R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 01:34:01.5626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 722a9078-bca6-47e4-9d31-08df28ca0f5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8899
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

amdgpu_gem_metadata_ioctl() handles AMDGPU_GEM_METADATA_OP_GET_METADATA
and AMDGPU_GEM_METADATA_OP_SET_METADATA and returns r otherwise, which
is 0 from the successful amdgpu_bo_reserve(). Any other op therefore
succeeds without doing anything.

Convert the if/else chain into a switch and return -EINVAL for unknown
ops.

v2: use a switch statement instead of if/else if/else (Christian)

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 0552b17d9aa8..fb60a99f43c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -764,22 +764,28 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 		goto unreserve;
 	}
 
-	if (args->op == AMDGPU_GEM_METADATA_OP_GET_METADATA) {
+	switch (args->op) {
+	case AMDGPU_GEM_METADATA_OP_GET_METADATA:
 		amdgpu_bo_get_tiling_flags(robj, &args->data.tiling_info);
 		r = amdgpu_bo_get_metadata(robj, args->data.data,
 					   sizeof(args->data.data),
 					   &args->data.data_size_bytes,
 					   &args->data.flags);
-	} else if (args->op == AMDGPU_GEM_METADATA_OP_SET_METADATA) {
+		break;
+	case AMDGPU_GEM_METADATA_OP_SET_METADATA:
 		if (args->data.data_size_bytes > sizeof(args->data.data)) {
 			r = -EINVAL;
-			goto unreserve;
+			break;
 		}
 		r = amdgpu_bo_set_tiling_flags(robj, args->data.tiling_info);
 		if (!r)
 			r = amdgpu_bo_set_metadata(robj, args->data.data,
 						   args->data.data_size_bytes,
 						   args->data.flags);
+		break;
+	default:
+		r = -EINVAL;
+		break;
 	}
 
 unreserve:
-- 
2.50.1

