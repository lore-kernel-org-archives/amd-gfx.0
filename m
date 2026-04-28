Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE94FF8868
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 16:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DEC810E33A;
	Tue, 28 Apr 2026 16:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zTWLl01i";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6991A10E33A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 16:22:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3/HL9L9AZ3/l0rbibMrxLnq1gUIQGq6SqQNsyZhp2T5aL7muWGRUtwebiWiwTZhveAiAqYJdQfm2iD2N1uQ+e2T52Sg90im+xE8O6KJ3DJgpE6flfLydRkSOABJlAqsH4mZ5fhrlafX57sUQ6WiKzffA7OpkU2dZ2CZLXFgmT82CjNEM00g6D05G6HMe0lhEQhS0R+L0eCD/Eu8kaVkcVZH7bATuP+2os5BcRfKnZk1Dv6sSzU7ooFHEO7S924lNAX3Cw9Rrm08aC4bawoeRc+w388VBA/+PUCEDLPhIKCdNjZG3KR2w8q0yiVvjb9qbLVb/gG0jyY796kQ/OrotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gz+4VnFvQnR3u9rdTWhdC7y94WmtJDjwe8EDIMuirAc=;
 b=v/IBh4U4sqjI471Sq3NMbEjkC/wNovUbpoi1HYdcEeTaaIf3CgSj+1k7XECMmaz2QiD7qtBbjyGRyXo7+ERiEuDK42KBkoy/Hq18c4JZ50E1blYk+xfxJvJ4SYN2pCVLnPoLYC+Gh0JsEYI2YU87lM/nOFdfHefEUP2QU4qWSwRzTj7NEC7iMGNEpra5Frh5hyVNO0nNmLTXZ1MtAySDGWPH3BvpdV9xNWvC83tY9kEBx5dKk5OBM0+O+7cfrPuuQIUqSWs0tf64Aj9J+2+OYCR2YrPInDZvcRQg/apGJT9tW68ebHHhGpcirhzwKciQ+ZN0uACYa+viWtamzLxXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz+4VnFvQnR3u9rdTWhdC7y94WmtJDjwe8EDIMuirAc=;
 b=zTWLl01iUvk+z7FwAAFDQo+f4jB3bQfZl51OrZ1deuPYovjSHp0MmE2R62OhRHcDJe5iBzuShwNvBw+WrQoSSNr1EUsDoAQ900ySGzHraYfEwE+Z7KtFvNpFqYNrExtnPu0ZwJ2oONclTfsvXKBdcWUONxl+XTmNr6tud/pv7Lc=
Received: from CH2PR17CA0026.namprd17.prod.outlook.com (2603:10b6:610:53::36)
 by SJ5PPF28EF61683.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 16:22:39 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:610:53:cafe::a9) by CH2PR17CA0026.outlook.office365.com
 (2603:10b6:610:53::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.29 via Frontend Transport; Tue,
 28 Apr 2026 16:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 16:22:37 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 11:22:36 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: zero-initialize GART table on allocation
Date: Tue, 28 Apr 2026 12:22:19 -0400
Message-ID: <20260428162219.3761327-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|SJ5PPF28EF61683:EE_
X-MS-Office365-Filtering-Correlation-Id: a57fa4e8-cffd-4a34-17de-08dea5425cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: LlwXSx4AQE9+64vdE6aPSry7L/bcXgmvwpVL2oWM6kFOoYUU2m615kXtpc/97faaBBYjVBio5rVNYHOLbu/lTuFahllmD7GQP4wlK0cjqPBxYZr44Wf4c9m04ZbJFtqRMNALE+/ZGoub/rnIAsLsgiTBu3dOVGLlrmz3zbc0IpJJbQS/FFz7gdtkj1ix7sBuZWuQPRdFeGE5zsDf5fTmJxjfUHlhkk2BWBaD7UG/h2oNpPM44phRnWoz8myo50VYgvuZZIPFR6BM5XkS2dB52fHcXbcGn+CbQIEUTuSU/h0sHgBPcIGWRV6gpsG2VrHMr7M5kGh7afCDMYVttRMXONgPkEv06tqspAmjCn40APdLQQx1qlzAccB81sx5MJL0LA85PWzLXxiJcSJKVRcscIFU59dgU2pE1wGp3KSv5i3ahUERAFS9+P1FQjF3ddZZMfSmDqfbADOSddvSrKdIgx+cjCzms9LPSVSD7Jje90rwv1JVniMeoj0bl2S3pJPkVV+ajKpnmp5Q4ol2JeAQ9wv/jZzVal5JuwTmlEfSk4b5Fpu+dcXSDAK3thsvYtYDTbfzPRPRetrWGoC0R765aHrBvHtg86WSedZ92nkOv/GjRLmvCvTlpmZY1rnzR3N4hczzXOEu6vK3AWXdkumjLv+pCrbxX+MHR2S2IEtUgpMZOQOIM2lV3lv6WHQci6PkH78+RODPTYhoy4SKyR7xLfa/um7RpK5DNtUO4ruSj+WK7Dv73iQW6GRhPcAFSDgRiG2bO5wlOrS5fcgCKZ2qvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PliVWIzCPlhc1QZ7GzQ1QdI8bZjb6L95dNTNWHKkE2wsVlUyUvrqtOF0inUx4Wof0HkOcp7KLaJw+S1Ra91nq6Z1xrpvRkt1ZHQ/tT/eYUV+m/OwYNha5j+T4SqUybECetogi1bok0/zap2F+HOtFP9NsOnMhTO5M/74OjreNjBYt0m6Ek8B+cfLq7tiawZdASot4dUY+p1UW2HoJuxtgzqOI7DUkRx2ciXrypcbW4emR3pI7jufQ7bkdNSD4uzFa4TrzylrOwtQOUcIpemePLJPkQ6ZL6PMpA26Flz5u4h2OgicJE7eWDLjEXH+jxGJ1ZQp5GQWpzNlRJ69P//91rEdhFIQr+1HfQfkdrl5x6KDvXEDT3azG78eG71tTmWrT2rL20zHKt6t9qwEJ5z5VPKTlAUHRBb5CMVT1VOevU9geSSncVg3OmjelfSjSy+u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:22:37.3507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a57fa4e8-cffd-4a34-17de-08dea5425cac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF28EF61683
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

GART TLB is flushed after unmapping but not after mapping. Since
amdgpu_bo_create_kernel() does not zero-initialize the buffer, when a
single PTE is written the TLB may speculatively load other uninitialized
entries from the same cacheline. Those garbage entries can appear valid,
and a subsequent write to another PTE in the same cacheline may cause the
GPU to use a stale garbage PTE from the TLB.

Fix this by calling memset() to zero-initialize the GART table with
gart_pte_flags immediately after allocation.

Using AMDGPU_GEM_CREATE_VRAM_CLEARED (SDMA-based clear) was considered,
but is overkill here: the table is only ~1MB and initialized only once.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 4d884180cf61..f09337bac0e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -262,12 +262,19 @@ void amdgpu_gart_table_ram_free(struct amdgpu_device *adev)
  */
 int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
 {
+	int r;
+
 	if (adev->gart.bo != NULL)
 		return 0;
 
-	return amdgpu_bo_create_kernel(adev,  adev->gart.table_size, PAGE_SIZE,
-				       AMDGPU_GEM_DOMAIN_VRAM, &adev->gart.bo,
-				       NULL, (void *)&adev->gart.ptr);
+	r = amdgpu_bo_create_kernel(adev,  adev->gart.table_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_VRAM, &adev->gart.bo,
+				    NULL, (void *)&adev->gart.ptr);
+	if (r)
+		return r;
+
+	memset(adev->gart.ptr, adev->gart.gart_pte_flags, adev->gart.table_size);
+	return 0;
 }
 
 /**
-- 
2.50.1

