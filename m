Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6726C71136
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2440510EA68;
	Fri, 13 Jun 2025 21:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L/M8ZEjf";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C6010EA63
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tE2qL5cQOSekipr0xX+IDpcdZgxx5QAD5QKJPXdgDGH8YD9KTG0jLkBcnWnuQXRgOJF7Zi6hjxWRh8/365Nmgxm8n68W4QgHBKnXgmieklnAZoi4Z8jGu1hwAcTR1Ra+fiq/b3cdpjs8XPDWx9LmP8sjbgzQKXpQMD2XyuXr7/qvz9PDd/Aw9noyPLSaM6Z2Z9Bzg6YIK2w6a6iaKtZ8goY4xPU8t35qxflAxNj29LPUzKs2Q8ebem25TnNFEMYF1fqlgQ+et2XM4HOnShwEG4fmm7vteeh/6w2XzTbpWizAhTVlMNib0cPtmj4rWPT6X5a1nLVsiSqUEdzI7SZLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6o4KEFtoWWtYO0SIXkTaDm2XaWkvBnLhu6CvxAGGv0=;
 b=KWTPKX5eviMSMU85N87xi1CFEzzDh5UmpWxuXIjgUlDbpPuKG6nDCQcCa1sZxZOoPhdT+Dsq9rBTUA2hooyV51ogbeN2bUGsvZqKgAz4o5wJ2Ihomqicm522Bm7hnYwQ4DmNtU1wtj8YqPJNzjxm9LSH2yWkcIbmu0Zjrq63EMCXpR5jd8soAjPD6ISAUjHsoW3y58ekx1+/2mMltGXVDvLQn/m4K7Qfw2Iihy4pnpa8TlNw0ZFVKgBoTRgfjWX5x29CJUm0UD3flme3WLs9cZSj/ZnFT//R/oyGFVl0/eNyaBzusCmub45SPPFtjGfzGk5OuSX83O+AVTwpMYouTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6o4KEFtoWWtYO0SIXkTaDm2XaWkvBnLhu6CvxAGGv0=;
 b=L/M8ZEjfdQ7VSkmdABvK/vfLnhozNK+OeEB9xndrPjfcQIdPpL6zcSRFf/M1ogREpGv5Tu3+KEgpWt3NG2S56ANxeUQYgzY3x+2SGCoCF7M/lBqV2YscCJafGMN37GDHf2luCAW/lQ9Ont8hm2tHfS9yXOTP6XwWsoIqWgMtXUc=
Received: from CH5PR04CA0023.namprd04.prod.outlook.com (2603:10b6:610:1f4::23)
 by SA3PR12MB9197.namprd12.prod.outlook.com (2603:10b6:806:39e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 21:48:14 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::cc) by CH5PR04CA0023.outlook.office365.com
 (2603:10b6:610:1f4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/27] drm/amdgpu/jpeg3: re-emit unprocessed state on ring
 reset
Date: Fri, 13 Jun 2025 17:47:39 -0400
Message-ID: <20250613214748.5889-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SA3PR12MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: 8adfcd53-2772-4fb9-dce8-08ddaac3ff69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EIPqiZhUSpTXoVRu8rew7wMqDRBu4S3F95bvtRMvE+hD1F0/1wnUnWjox0vv?=
 =?us-ascii?Q?7KbiJxAOf5snJbhSUrnCSNNlbr7kf0xq3FJeM68+swcl9bDqaarrUXXWTNuJ?=
 =?us-ascii?Q?k8NCa8cFfwUzRcb8MhPPu/NmOdWgNAW7HZ+z3hZ1CvTAQWLTIO2GKL/c29Ei?=
 =?us-ascii?Q?TLckgVBBQevP91X+DKwL1ksGvOCgV12t0w57xPJUQeckDa4qGm6A79wUUxkm?=
 =?us-ascii?Q?YoBzURuhzTmD4Vt4j2WomssdIlHawC2YgZWcf1aZ/UWvPpRVH2ReP9VbU3VT?=
 =?us-ascii?Q?WGGKD6+zWWeBwru3Jc2c/jsVHscu5viFxaqBw12kwSNWJIrFcB6sATC5KOXV?=
 =?us-ascii?Q?SSWyTeKgWIeUvY8/LwfCdQmvf0tH9om9ao4gr0+08rRTrYVGxHS1VvGnsmd3?=
 =?us-ascii?Q?LClPc7DCdmEBf+bYAyaLrqLrgZsdHu0SmHTFZMggDKxKuMkp0f9CZftVVRn+?=
 =?us-ascii?Q?xaWdaZ27QztaG9r3H8o6GCAad8T1Jh4r+D9wi4hzdvhsWUw1gRUb1fu7ysdG?=
 =?us-ascii?Q?2+DWWyf7nZDtXuPrbtzBQHbmeyJXSwRCOG5Dwhb8a0uDDAP20SCu/aNpd5pk?=
 =?us-ascii?Q?LIdevTNmPazq2IeQSq5A35g2jgqc9bWkGQC/zsu2kYtBt7W+grdLZJR2ntL5?=
 =?us-ascii?Q?8MgUfXh1B9gJH9aUtVpTTi2l+8d1nSR8xh9eU3VEo+sE3Du/hok09EFn9WfH?=
 =?us-ascii?Q?7wW6798oFn7UvTkhThd/mVSEUyvErjFGJsXOOdN4iq3nIahTnnm+po+uR9Lv?=
 =?us-ascii?Q?YIKTx/y2cE7/slSPPc+X6QnvwHQ2cXcX9k5In9kTf9jjTzj+R9I2js+oopm3?=
 =?us-ascii?Q?/UVTYjUHhA64Zt6VYoFU7WO1JGlb2ZqL3epie8di9uQD8Ebdx4SHLVUcOkHz?=
 =?us-ascii?Q?DbXNANEE+YSIALOON6uNXFA7/u69u51+KkMrKCQS1cuyZOsLpPh31OR5L6O6?=
 =?us-ascii?Q?dZR6LGbbjTtemrVynbCwlLtlOzRWFySork5SHEaJ13wdsdtvV2APUyhSuW+W?=
 =?us-ascii?Q?KExU4S+vkqBYZ+Ioya+8oM/qytLy2MQ+dWJpDUbTiGxPnjzLHBAyydS6HmcW?=
 =?us-ascii?Q?X042nw7ml9ED1H8neDykbJqbzBB5NG68Fqs9lHcr+WlNAmEzXmWJr+qQcWeS?=
 =?us-ascii?Q?dT64rhLBWx8jSJTxaszz298vqY2g61GEkZ65OocNT5G/EUlXliF+RwscM3pl?=
 =?us-ascii?Q?/07t4u/jPGja8hO0PdXKmu41jsfDNztfWWUH+bRWtiM08IBlj2cef6ZHwzzA?=
 =?us-ascii?Q?P3BkgnR/kRod28NU6Ifr1bc0F+kF1Qj82lbjbZSPapWn24lHQCvtloywWRg6?=
 =?us-ascii?Q?Y+Mjod5i/Y6SSI1gCm+ekSA7Egmg96Z6uORS17juxoQDZBub1OMYUi9bp5ff?=
 =?us-ascii?Q?wrmPvZAqPY5St51PlDccxiAtYo2r4T74/TU/xzR4UGSKKDxr+0G4CkHPBTIB?=
 =?us-ascii?Q?SL6SIbfI0kYFoXPF5bUAP2FPGQL3qi/ZiQAFkRKHpk5aUeTYoeqfeGef86cr?=
 =?us-ascii?Q?x57mABkPtXJkmWavn0G7ChbYktOR+jktoMmy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:13.6418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adfcd53-2772-4fb9-dce8-08ddaac3ff69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9197
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 83559a32ed3d2..46becf4e63482 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -561,13 +561,21 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
 	jpeg_v3_0_stop(ring->adev);
 	jpeg_v3_0_start(ring->adev);
-	r = amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
+
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

