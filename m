Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7169F433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 03:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46E6B10E7DB;
	Thu, 16 Apr 2026 03:27:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N1z2hzF9";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012042.outbound.protection.outlook.com [40.107.209.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDE8210E7D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 03:27:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQqsrLIkLey2H7ffZJbpBPLgm0byp+4l+HGhP/OV5JZrQXRVQBKcKkIhik+nCWgDPTW8AB5z0qKgY61ukdi2BUoMUS9EgWcE30ButQSUyw908bZEJVc5Uhv2O6hjlkFjcOLGJHENevMXYbBUgCnZX7Te88QEZSMQA3GGghCnX6cZnZ4FGn66gexgtZpWd9K5+vCeLIzOm8Yj5rtF+0l9A8B2cX3Ni4DtkkO0buiAdxgc8S4aXfM5LS7PxTUIMspCDIjhCWgKPjyydZd9seHfxl2ByLtAYDIhim2m8R/ViB/c79GlqqWDFxZzQJkwW9XMNIO32FeViJKsPMBpYHdw3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+rQ+RC/FFQZ3lPnOhtKcg1QBPlQ/DwEcia5YNTd5Mk=;
 b=D/9Uy2u6UNc5t2vqv6kpEiNQH0aw7qUM0Tx8zgi7PFo6FCYsYojeLKe3LeZgDj/i/C/nQs0p8lstFX8d6vr9ZG5AkLuWFPzEG9YbyRbEz/9ZM1yHNuf02x8GL6PDGQeCFUTKp2/f2O1UwMjvGmhGY+aYAYhULxltw9VgrZjIRwQ+Kh1eCUHs6HxvRJDokpVB23MQWM9MdfOz9iqNm9IECaQxf0++Fr1aJnllgoqZGTvjRaxJLCIs0IloCeYTOcHlyavCPENj+Da+HuGc0FkMT9U3V7AK0VH0tgmtkk1XvCQcmozM4Iz1hMnU0SmTa4vYBIxifgjmrQpmGqX/b7s+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+rQ+RC/FFQZ3lPnOhtKcg1QBPlQ/DwEcia5YNTd5Mk=;
 b=N1z2hzF9GSHrS1BC4g74bthlpFaJn7B5NXE5Y95t3fgYeUD7xMjFJzWD9GcZ2NEOhurVJKJYnGAybmNOMjJ6wF83y230ISaAM1dCfY+a+oK+yzkOHWj3MGKGzVZtVj6Rf9M2J/4R2JtSyZ3tOg18OmaZxOVcFrku9ZeU2kHwNgg=
Received: from DM6PR08CA0015.namprd08.prod.outlook.com (2603:10b6:5:80::28) by
 PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 03:27:24 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::2) by DM6PR08CA0015.outlook.office365.com
 (2603:10b6:5:80::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 03:27:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 03:27:23 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 22:27:21 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 02/10] drm/amdgpu: Embed eventfd manager in amdgpu_fpriv
Date: Thu, 16 Apr 2026 08:56:51 +0530
Message-ID: <20260416032659.2368054-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416032659.2368054-1-srinivasan.shanmugam@amd.com>
References: <20260416032659.2368054-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 577324cf-44ed-492b-021f-08de9b681332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4AGI4/y3fEKYFO5rExUtBO+BlfMaeaOhOj8XZH35Z6eK7srPjdFV/wIpjYPrkNBLDNnTfP8Ofxo96h4qbzBzaIo08VAvI/a7zskjmdliujg4xGScwWUrWnVYeAl+djpzdf7tEsXI1XWj5Q0GrmMtdrKrfpphEmnkDiBjBcPBEowyIJ2KFp3Oq3vq0Q99hA53YyeqUrOcbxtdprBGi7B2ZsN0ea6e+GF7COuYBO73kJ0EgtMRFpKekqqC8mvQPsU5v+W365KW0Rr7gWF8BpPUfQfJkHxlKH4KNC9PATbRb462/bIEVNWaG8gAUVBOEvBqZHdb8QMOltMLFRmRqh3+2KIoOmYEvJQ4P00PAnaCb/r3ldFZsqlrGFWFuanBNBPgZ04t0Khb3+Nf8jk+PPpBno6TL7MmTOTIdiKIKtoxF2LcnJs0rG/hezOOxwG8H/Y4/yarUl4yaQVZO+puQlGQc0w+gJIBkyJ7qxJ5PFezyHCY1Pm31dE5Dlo//d/aGCXDRxf/yDKUE5UV9cfP6dgABxTs5U4iC9HidgYOPNwcn8EJ+7Z0PTTimQy+7HGWVtiHOm0VJzhSTEMLmJAqjMOmJE88IsAdbWrnjSP3w+IsEdGEgPQZ+lKa+KVSDgSjWRsPEGkjKmDkecw9OQnIkRCZnS3mXYwI3Z5KysjoF2mauB1zJI+24uL2tHUdDC9dCDiQLUWpGkF8QuvPM8gSyB4b0GFKvQom4O8InKVvpnGC1yK1eBKwC30ZCRhA9xOmOjbPyRKZcV0hp3nTEuVOPWIsjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DVFZlu+obPkrLd4uHLkjvzDOhdDvOBcdoR+4bB3lHNek00h4Z5j3ioNRL6jpAfptBktTv/DCADispVIknkUBiJ1pKTRNeH32InSsfEyIBdmIckCGSTysJAQEAsKv1Axa4SMzdMOjVeuJc4N8OsEqKVMd4KZU3R9XINRroNXw1RJWD9N28iSIndbklRZj7V5OUQYas3PqedyMIR+ILXtG4G3g457wfvDal2WuY2RMDrwTZlahWi2iewb3J6u+kNtQmlzjrxlWpabPsMvT/ALLFdq6SM4UQUlY2B7ggW6tnXBXmyQ6H0f9JllyQI59GwDvPuH4kPlrocBo6Y+GI11T0Tpg4HfOLINF8A++R+5cn1GSxb9qlklxny6HuszBb6C+xU6/JCzbRrxXpXKG0rO8OCXFUmTnJFm2/7nKRIfuJ7ir2qjxb7WlPvNQuJzEHEgV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:27:23.3656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 577324cf-44ed-492b-021f-08de9b681332
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907
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

Tie the eventfd manager lifetime strictly to the drm_file (amdgpu_fpriv)
by embedding the manager instead of storing a pointer.

This removes the need for reference counting and avoids destroying the
manager from IRQ context

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 39894e38fee4..a48f8c214699 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -104,6 +104,7 @@
 #include "amdgpu_fdinfo.h"
 #include "amdgpu_mca.h"
 #include "amdgpu_aca.h"
+#include "amdgpu_eventfd.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_cper.h"
 #include "amdgpu_xcp.h"
@@ -455,6 +456,8 @@ struct amdgpu_fpriv {
 
 	/** GPU partition selection */
 	uint32_t		xcp_id;
+
+	struct amdgpu_eventfd_mgr	eventfd_mgr;
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d88e4994c8c1..7df0e7fb2864 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1469,6 +1469,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		goto out_suspend;
 	}
 
+	amdgpu_eventfd_mgr_init(&fpriv->eventfd_mgr);
+
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0) {
 		dev_warn(adev->dev, "No more PASIDs available!");
@@ -1565,6 +1567,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (!fpriv)
 		return;
 
+	/* Drop all subscriptions before fpriv goes away. */
+	amdgpu_eventfd_mgr_fini(&fpriv->eventfd_mgr);
+
 	pm_runtime_get_sync(dev->dev);
 
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
-- 
2.34.1

