Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3826C27C55
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 01:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F137410E67B;
	Wed,  5 Jun 2024 01:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bT7tH0CR";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A14D10E67A
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 01:34:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRLTvxURBUb/Caa9Xu8TrZYvPhiZrFaBN33QCLC6PBvEAbICeIEL3+9kiCUYryh5KvFKzdQPi4TkOjdGw3jDHMlj0zEB24tJphU9oGLduAgvAzqQnvnET0ASr688uPbyLAY3tKDn1d/XnGxZTB2iiP3A3TPoGc0n4FuQP/GLIDxCvdjzVIIa5bGOAbHLwpPTt2f0Quy7Q454JMywFm2u5ArT5IHJcZEBFV8tq1MkH63orY5ERDfpP7AtjCDztfCOly9wnRDUIESaOrnMx8gyQlA8C0Ai3b1uds4hmXgGb846xDRv++ZruqtQMDb0PMwx29KgHwpv2euclQeXEfk/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/6tXnQNzK0Sba+DUJysz55KMG0s7WRiY5nvK/RFXfw=;
 b=ML1gZBJydICScOD3+Q5Daqha4CLGBGbodwktTpS4c2wbfLpaJiZo5wUTP71BMijQHfxm7snqRxcjTDXnc8Wugug9kgVQaoQNtg7EcKREqwdnoEwOhde3oYxQbh/t69srUvzTqrwmbO9Y8zj7cO0lLXsc2MsNJ/hWN3fdh/pmHK1txgYH98IO9+EkFnS03IXvZDVJ2hvTy9/D9MmHR1SRDpLww7wH7fATXu2lsZat5fQqLtef0GhoZ9OAbWR5c+mMLUvgYJUGZdvFkC69RbvZShrFN3AGiNcXlx8Zj+y/USf2fx11rAh4wck2BVadSMb2GCVLPlqZAYVz1jDMeAMFyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/6tXnQNzK0Sba+DUJysz55KMG0s7WRiY5nvK/RFXfw=;
 b=bT7tH0CR+fsLOTB5D+HWiMdyf34L5jJSpa8NopbSPD3NAWhJaVN1v+2W97G/P+Qq6sBNWesZYtosTpvHxHHIohSlEehc/Of69FXTHGMFsyI4A8LK30iLdBUcur1k5DWNCCX88aSFJVpTdQvxFs/UuRNWGl07t89io7J5p0XfpCs=
Received: from BN9PR03CA0122.namprd03.prod.outlook.com (2603:10b6:408:fe::7)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Wed, 5 Jun
 2024 01:33:53 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::95) by BN9PR03CA0122.outlook.office365.com
 (2603:10b6:408:fe::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Wed, 5 Jun 2024 01:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 01:33:52 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 20:33:49 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v4 5/9] drm/amdgpu: use helper in amdgpu_gart_unbind
Date: Tue, 4 Jun 2024 21:33:14 -0400
Message-ID: <20240605013318.11260-6-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605013318.11260-1-Yunxiang.Li@amd.com>
References: <20240605013318.11260-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e8b86b-39d1-421e-34f6-08dc84ff8eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjV0ZkdtdmYzdVVzdytlOWY2TllzVWtIUTVseDJoWWZ2OW1hNFo1WUUzYnB6?=
 =?utf-8?B?c2gwK2pWS2RRQ1NHYkhhMnhxZUswZDZ5WFVneDdCRUl2Tlp0OGRlb0ZmSWpM?=
 =?utf-8?B?NURlRDRINnk4T3lXMG55bEZUUEVESndOQlhwTEx3R2ZMdU02Sk51N3N5NW9p?=
 =?utf-8?B?WXlYMmN3dlphaTdKeUYrb0E5WDNPcS9wbnc1NysyQngrVjJqV0Zhamc5Z0pT?=
 =?utf-8?B?OXRhVjhSZVpQL0FObkFuSVZrTitBWFNhQ0R2S0RUc2RUaVZ3YkxTRmlCajJm?=
 =?utf-8?B?WmQ1Q2FMT085ODZCRG5BZzFWTk0wcmV4SXkveGg5L0grQkJHWDhxQkR2VmFT?=
 =?utf-8?B?NldUcEdEdXB2ZmtIM3NreFNtUHVLQUtKdXRlUkpWeHZoOEJGcHFrZGdHUnQ4?=
 =?utf-8?B?UHYyb3dNV1dXL2c0cGZhUWpjeWk5bWRST3dwclNuR3RsejZURG4xUnN1RGFT?=
 =?utf-8?B?YzJwaEU4d3FnU1QrVEhLckJwTUpmaVEwUVZPVngrZCt5b1lvREpSRjJJSjZj?=
 =?utf-8?B?anRuWXpabDdkQTNwNEpaQndSQXhQdkFLT0dUa3ZDd0QxZEhFRkxyNmJBUlo0?=
 =?utf-8?B?bkViUGd0ZGliaG5IWGVUaHU2TjhpUlBIdVZxZlJXWXd0MFUzZXNVb3Rsd1dI?=
 =?utf-8?B?Vm9kZEtEcGJiMHhyMkZXZW1qanNUNktXNUhUZzArUGtXdzd0NndXQmZqeWVP?=
 =?utf-8?B?UjJrbTFCWC9lWkpxMUY2VFZYdDhjSUhUSzc3WStXTnhuZStXQUsySUMrWUFs?=
 =?utf-8?B?UEptYkdRWWhHbjRBMlAwazVwY1ZuUWVabk92TGorNkJISTVlN24xOWNJZ2pu?=
 =?utf-8?B?MG4zaHFSRjFrMGsyc2JQQmlvWVZvWWRqaEYxemxzR29KWVlWd0Z3SFdERW9C?=
 =?utf-8?B?S1NacEVIUEo3VmZYRE84MHNkVmNvc0x1S2FNSEg5QnFia3NheDF0VjF1NndJ?=
 =?utf-8?B?UURxajAyN2RHRFpURFFmSi8razFMMU1CRTVSRE1pdU5WTE54ZG5Mc3o5NWJ6?=
 =?utf-8?B?U2F2Y2pwR1JZY2hJZEVKV1FnM0gxeFhuN0pjTUtBMGRlNWQveXZmclVkMFpq?=
 =?utf-8?B?WU81eWZaVWN4T2QrTTcyL3BNNE44NE0wSjlXdk1Mb2x5eVN2MkMvNmVOODBl?=
 =?utf-8?B?S3RTWGFuV25PVXFQSGt1ckZvUHZvZVdkMHUzbUxoMzcyYjJBWThuK1FzTjM5?=
 =?utf-8?B?YzRJeDcxRGFhQjc5RWkzWjlkK2ZDejE2Rmt5Ymd6Z3JPdE9uVXdwaXRXM1VZ?=
 =?utf-8?B?WWRTK3p5eUdPb0VxQ3pWZGtvdW5NbmJwMTVId2ZISW1RbUpKVG5UQTN0NGZK?=
 =?utf-8?B?NUFPalFoTWFkekxXcnNHdzJ5cmxSL2pNbEh6SnBSeHAvMUVPa1N1Wno3MEVY?=
 =?utf-8?B?aG5SRzl2OXpLcEJjN09CMG44Kzg4NkdHUGZjY0lWNG9WcnZKeHBFaWp1N3Rq?=
 =?utf-8?B?OHE4NVNxV1RvbWhoNEJuUjRIMDBhVUN0ZkJuVDlJRHZOOUdqQm5VbnB3cXl4?=
 =?utf-8?B?VmFES3g3NCttb0dUZU9FMStrVmhZYnlNalFVK2V4QnhIVnV3Z1hZU0hxblhk?=
 =?utf-8?B?T3lNUUFSUHdhTnlWZ1RRY3d6ZDQxT1Nac2RlVWhKeUxKQlNoeXJ0OU1RVXpv?=
 =?utf-8?B?UVlUOGF5MkJGZSs3MzNyTHp5eEVLQ2FjajdpREVJNTlDeTBDYzhWajlZcmdx?=
 =?utf-8?B?QnNJa2xUODM4RUpoRGdwVU5OVXdOS1JKS2s3NDFpWWN3NHRQNEQyZHdMaXh0?=
 =?utf-8?B?dXlJcWlJUXpqMVNRVlZQWDRmSjRzekRUL2t0ZHFzNUVJT2xjaTVKWTBHNUpl?=
 =?utf-8?B?RTFpMkcyTldxZDAwdDdNd1pRdTJMcmg4R1o2aWt1c2tMVUhPUU1oODUzblMr?=
 =?utf-8?B?MkRPUDBJZHE1NjY0VEZGV0lYaGFFL2YwT0ZNVEN6SWJKaVE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 01:33:52.5172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e8b86b-39d1-421e-34f6-08dc84ff8eb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346
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

When amdgpu_gart_invalidate_tlb helper is introduced this part was left
out of the conversion. Avoid the code duplication here.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index c623e23049d1..eb172388d99e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -325,10 +325,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 			page_base += AMDGPU_GPU_PAGE_SIZE;
 		}
 	}
-	mb();
-	amdgpu_device_flush_hdp(adev, NULL);
-	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
-		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
+	amdgpu_gart_invalidate_tlb(adev);
 
 	drm_dev_exit(idx);
 }
-- 
2.34.1

