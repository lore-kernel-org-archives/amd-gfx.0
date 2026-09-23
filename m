Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77ACCC9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E355D10F165;
	Wed, 23 Sep 2026 19:34:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V5viN7K5";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CC7D10F163
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:34:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NX5QXufMmAzAYVgSuaBgwczTFSIpka/ls7vum2T8VkVA0IhTdTatobnqipMKbv3lTTZ6eiNGpeWI9tNb8DCtU7IdstK2aPXJTUocELYu8pzwd5xS6hIKs/Y0yqUx3wUZ5Y2bRS81PIaaa4myN39zKhGAYGnd78b72WI/GCEWTpMyzcthVw803HH9fLLiIjt5iYmmsBBVdcx4jbHuXrh7JCsyiEjr7FOczlBPcVqvVKTiAVtR0U6uRmxfABkg4j/TWpR5/t8+34mVCxN8He1bSLeaWTwHX+vcOXyTdIAB5ZlkD1lZlhl6dEygEgvyBIWNg4GBaHBBikD6TvNKeoDmew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cabcwgX3n4CeTJgyeCpJvRlF/E4eGkE8NrEVqASpiBE=;
 b=LccXP1NNN/FdqyTkThRInif532FAkEWNsZrJh6a/Jtcwwn5sP/Xm5K7UxKhKhAJSDaHNyvApQguv7LlrTWBOnXZw47sy+IPqUxUwy6ky7BVB2ce69JjcbgFpFBgY642VOqiH6YTaJR934LoYr+nv0VV6xIwNm7G7vt6l+AHaoTBWiUIB6eFF60buzZAg9WoOi1A8fpceW+Q+OBJ6J601eR5HRZNAXHWK6eT8lKIiBAPyZvW9wJH4C7kbWHF66OOIoWLeg17GvoJSjqcJVV729al9W0c8aLfRYGBUDUsNRU+TjlX8zj4CWRfOBJg+npYWPDIxe26ZLyPpzv5TKMSsWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cabcwgX3n4CeTJgyeCpJvRlF/E4eGkE8NrEVqASpiBE=;
 b=V5viN7K5Dgexgo8cecJdwWkDeKgz3XXI/lY6NaIyofbjgDRtnMLHpoG1mmotND2cFCf9XeC02NEVdMFaOm0HFUhsYiEMkJmEBBd7IiJA2KT3tdwEgSrqAHDu4YUQLw6ykivJ/xkWUqKX7ZXmOtuskfNBTfpstLJYeoChO18R9wk=
Received: from SA9P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::34)
 by CH4PR12MB635819.namprd12.prod.outlook.com (2603:10b6:610:509::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 19:34:25 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::4f) by SA9P223CA0029.outlook.office365.com
 (2603:10b6:806:26::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Wed,
 23 Sep 2026 19:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 19:34:24 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 14:34:21 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kevin.wang@amd.com>
Subject: [PATCH v3 05/10] drm/amdgpu: handle runtime pm in
 amdgpu_gem_userptr_ioctl
Date: Wed, 23 Sep 2026 15:33:41 -0400
Message-ID: <20260923193346.2292597-6-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923193346.2292597-1-shahyan.soltani@amd.com>
References: <20260923193346.2292597-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|CH4PR12MB635819:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac12531-6e86-4126-dbf7-08df19a9acb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vezLbqbkY6Iu/i0lxxEfSPuGmBWbOpL5BpbzTZOxW+r98XIXX80nQAslXRaze+4Ly7QIYVDH+LyO5W+M0dpEcb6armF/sRNo1Gp5Yz9hCAE2Qd+Z9+7ZZZRbubbD/3mte9HKpzEChNn+w79BwrxJ0MiWwnHluS54KjXC/XXTkL0Yd4itE2HkCk1ImtCIAbmnDOhZgS6BzO078EJtAFDa+6WOOjU/1aDDnLJXvJ/xKIpPXAAmwqrkbTHqabHg3C66ntR8cx2Izz0kF4351wlFd8dABE5GrP1mxta0snwCKNISbf8+kbuF8VXFkrL7ttpo9cFdeJ1eFPz5cl0vxMcVP48f6zFRdO0VV/0SE3eoB26+rVJcKBVZBepmbVJ/w0yjnMICYXTw/JS8DvEQiJJDiflYCUToYMEQ5+O59VJo6j2G8vckNrs+Iw67qBAwrGVfP/k3dCg+EROgpEr1Ktc3macOf/ZvTHR0Ec+yusHTc5czSv4dL3KUx3TMPbHkRmtMXywpj+6rclWBzNOwn07W3Yu8SeV1YC2ei0KeCVwCyYr88S+OhAV2Ue1IMvGpaX3WyYkTfH9IlGEG1tva0JVBHXGG7AwgeBadhOW59M2OQvmsUaXCjo5pD6fVfHnYqAbBouWyV7dhTPbWSScuOcK6DxWcppw7K3ODXumQmLBTJyqQS6chXRLQBqam3/pMJtI8eWNZioRTmkX/RZe2VkdhlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tRgiG27s9RzYW1KG47reQJNZf4UdvgKRYtjnNV3gmznyXP8Z38sXWqSxi8V+ye9NVIq+UJWjff5BCjWv2KIiz6m/z7OxhIJ/RZFWqjuWPyY6xG/Z74Ahs7Tg64M1ObJUHCF58k0jV2QkMf1UKVpuZWFoYV1GrYV3vuOhTX69bIPfulU4ZmGSYyX722n3kJ6hjN+35Fw8j8WhscInLj4BJhNbV39DYtKnoR/2m1L6g6q+6r6codkNoHfndRyPnKcyFE/M1IfNYe9hGwanE+KDCVOw1PxbCsKDaRlYl1V+4E/mOpGpbr7Ue+jAenMoO/YNQ9IGin9q/n06JP/l0J/VR8A3NE2R9/U+unyHaP2XXYjPYJ3V0YMt77irgYRmVHeHq6ejOf3fh35P3A0F9SP5xLlXbMbJISWIkABcfBmz47sKLMhHzXvoKCjdaKrSrXKf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:34:24.7206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac12531-6e86-4126-dbf7-08df19a9acb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB635819
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

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Wake up the GPU while setting up user pages and validating the buffer.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Co-developed-by: Shahyan Soltani <shahyan.soltani@amd.com>
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 5d2802009cd9..e1760e112ec0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -590,6 +590,11 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 			amdgpu_hmm_range_free(range);
 			goto release_object;
 		}
+
+		r = pm_runtime_resume_and_get(adev->dev);
+		if (r < 0)
+			goto user_pages_done;
+
 		r = amdgpu_bo_reserve(bo, true);
 		if (r)
 			goto user_pages_done;
@@ -599,6 +604,9 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
 		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 		amdgpu_bo_unreserve(bo);
+
+		pm_runtime_put_autosuspend(adev->dev);
+
 		if (r)
 			goto user_pages_done;
 	}
-- 
2.55.0

