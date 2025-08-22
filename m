Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6943BCA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 19:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9490110EB97;
	Fri, 22 Aug 2025 19:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bTTku3TV";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E68D510E17B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 19:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXuP9gc39SNcRYyxejWt3nHxGGufmtvoERKBP2zaJ6rKJwPAJpGPl2FxS35686XGSYyYyZUKSV7CLW7miK0MDHGiG+3+KSCzhj0LGNyfXoi1FhwT8LuMa+Ymxe4atN8ztXbe/YLRKfUaU7UzUMNfw6rdSUj7Zc45sGwE01HLgrP2omyPgXmwClofyL4pb9fQto8PD17yyulCMSfx+zdru4UIKUbDYbfkNdbdMETLLXTNWTBhBvakQ8hI565h24pkFg/Bl3LLgNgOUbdbD9/1ToyhZX1h7YaYh7ERM1urTPGURCUNAX1jpDutBM7FKN1/U3GgntP5VrTKikGxWrfM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQtsQRplO2NgiifoIFRTsz06BFFfsXCBvUnEaP+N9sk=;
 b=ARKMHRlqnPfaGCeMEHLyOW2zCkQxmQdh49mfCTFCMwR6V11z/PmB1mjjfVEQwVPAY41fnXwC9praJLDFCEKP8LISK7guviiB/PdqH8h+XKNrHAkxH6hjJ5+n9D/OmPm+P49An6Jt70zhkYwwDGN6z0Kt6KAgBHxKGdmkwKZ3NukvH8ejYxOpaUO5tLyDGJXI8YUh+HOW4+8nZC64bs9moVpIKq5r5XOgMOsuCPiJNnAi62I0vNEglYLkF6J6S3iPYjeanwjAkmuTZCyfkgYjOA9pxabFC5n8YfYLFBHxJjssmCp9W50jIx0VOS3roYs9lvXuvuI2ILa5UC4KuThLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQtsQRplO2NgiifoIFRTsz06BFFfsXCBvUnEaP+N9sk=;
 b=bTTku3TV7RSZF433siQOlPMzLkFLQqKZLSHDFHZzobMeKT0OC8UmS9yZYOqRduv+GwBxGBShg+3iFZ7fgjKo1yPfQbDYfhX73WXXwp1qQ45HXMGxOWvKSf/U+GYqpWQA1AIkrM50KCJJgp296NV7LqxzycB/gCogQQBcBngf/EE=
Received: from MW4PR03CA0282.namprd03.prod.outlook.com (2603:10b6:303:b5::17)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 19:48:13 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::5c) by MW4PR03CA0282.outlook.office365.com
 (2603:10b6:303:b5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 19:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.0 via Frontend Transport; Fri, 22 Aug 2025 19:48:12 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 14:48:05 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v15 1/4] drm/amdgpu: Allow more flags to be set on gem create.
Date: Fri, 22 Aug 2025 15:47:46 -0400
Message-ID: <20250822194749.362771-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822194749.362771-1-David.Francis@amd.com>
References: <20250822194749.362771-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: 806fea31-cd87-4b29-2638-08dde1b4d448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkoxUjRPVE5MK2M0TzA1cm9FWkYrcE5tYXduSXpqcGlFam9MSERuemlJZFJj?=
 =?utf-8?B?SFpQYUVxQWNjTmpkc01ucHZsbUc4bnEyNCtRdkZ5VnY4NmRDZ3dna2Q2WVBH?=
 =?utf-8?B?YWRtYkxHb3VmSkVCNklIK3ZHeG93K0NRcjcrNXhBeXorRFE1dS96Y1MxWlo4?=
 =?utf-8?B?cHEzc3djc04xR1BmNkNLcENreWdGZC84R2tqYWZlTXJCNnZmSFYzTkgzTHFK?=
 =?utf-8?B?U3JrZHpGd3pGbXIvTDlLLzFKc2tRdElORDAydnEzRU5CTHpPVWUxZEdMZGJo?=
 =?utf-8?B?VWoydkg4T2E0d3dUcG9NbVl5QkhBNGdzTGNtWjgzTGFkNEpCZnVLdVpNMFgx?=
 =?utf-8?B?NmlrRFJPdThheGFMSUdCdFovTERiVFJubThYWWNyUS9tb3M3NnJxdUhza0pi?=
 =?utf-8?B?Wll4cmlEdCtzNWlmdGZOQjFkYitPbGd4L09Ca3ZMQkEyVVlYN090YWRSUEJD?=
 =?utf-8?B?akVicWZCLy9HNEJzaCtXZkdhZkJqNCtUS2l5blNWMDhjWDBjNEgvUU4wYVF6?=
 =?utf-8?B?S1BBSW9RcEwxc3k5Nk9MT3MyUHcrU0U2NlNIdXZYOHdKZU92bFhWZmpnTEd1?=
 =?utf-8?B?dkFWRVEyNWpic1YzUnpOMWJQbXhGdWZBRDlSUmJ0NzdKSVgxSHFtdWsxQU1r?=
 =?utf-8?B?aVMvYUJ4MUdMZWNnQTM3d3haNW9FeGxRTXVkdjB2bUQxODJPVFpzVVptSzBh?=
 =?utf-8?B?bi9kLzU0YkswNWpZYjkrOEoySUo1TmNtQ0Z5YXNTL25TZE5XcFkvKzZmRE14?=
 =?utf-8?B?T3dVWE5wcFRRaHM4YzdCQUZFUzZXNWNJUnl1WjY4T2FQcEdpV2kvK0I5aEJK?=
 =?utf-8?B?bFhXdmppY1dxVG1ZdkpwOGwxTWRMTXhIK3FuRCtMTnVvbHM3VVU2VHBiR2Ev?=
 =?utf-8?B?T3VrZWFDSk8ySGtTQWJBWkVKT2tzUTlMN0pUYyttTnhzbWxZeWZiUFVPUWVZ?=
 =?utf-8?B?V21kYmJsT1pQTHZ1N3B2MXE1eXVzeVlJZHBkV0hUUVZzbzhta2xuL2wwL2tB?=
 =?utf-8?B?MlBScnlPKzlNWkZadUVZOFRTbHZ0UDdLWFp3L3d2Y2xKRW94UDkwcmp2VUI3?=
 =?utf-8?B?UUpMYXlFckJ2eTBjTC9KN3RVTnRFc3JQbWZmMWlEK2VONThNeDlITjRrTi95?=
 =?utf-8?B?Tll0Ky9GYWtNR3JweFFOQXFZVUV1U3FCWkpXVXlVS1JxdjFHNzg4ZGJFaUFT?=
 =?utf-8?B?aWNqVnQ1UGptTlQ5QjZlOS8ySmg2S3BtZDcvSXBBZ1V1SzRuekF4R0U3N0hL?=
 =?utf-8?B?eWxzQWIzcTNQQnFIdzZqeFJMMUhLRWl5WFlNbkR5TisyZUZNRVFBcmJTM0xa?=
 =?utf-8?B?MWFVNG9qUmJONFNPVUlCK3AxZ0pJU3c0dko1bjRIamo0YW03UC8weFJhb0N6?=
 =?utf-8?B?MGRMM0k3YzNIWE01eWsxRXMwTy9GN3ltMVN4UzdBWVMzVzV1bE52dDBLWnBh?=
 =?utf-8?B?dHhpU3RPRUVFNjFHK1FDQ21PQUx6em40WEVnUnVacTNkVGZucUVoN2Mxdi9S?=
 =?utf-8?B?OGFtYnZOM2MzYTdGVGpWckFEb20xZTN5YVRNbUNSai9jTDZsNDFzVnA1aGRV?=
 =?utf-8?B?azZvaGRjOEdSa29IVlEzQitrNjQxQ3hCcEJSbkt6b3k1L0dUT0pKSlhsenlm?=
 =?utf-8?B?MkFoN3dOYWhmcW1qa2dhbVRnUlUzWHNRZ2sxRE5zTEZXQVZnaVdEdTZUeG9y?=
 =?utf-8?B?S1lnL2x5TUEvSkhjb1hSQnZUdCsrSFVmeGM5eS9qYXpDZ290N3l5S3JCZlpX?=
 =?utf-8?B?K1NaRWtEZjJwbnpQck5VRXFrVDVPWnFiYkh2Z01nOXJxNTNla2p6TlpJMEhy?=
 =?utf-8?B?MjFEQWdEVklxc0REbERlMEwxWUJrVHBTaHdIQ0RDdnVIcWtWdSt3MldJSzR1?=
 =?utf-8?B?Q1I0NjBwTzRDWHNSS3R5RVpLYXRtTUEyeUtNaHhFdWVWWHQzRDRORlNDQ2oz?=
 =?utf-8?B?dGZSbnlybzJvKzZUMCtxWDRzQk5JaVhyK0lRNkpMODBBemViTFRHOGVJbXBx?=
 =?utf-8?B?N3IvMjg5Y0pYSzhLNUw0dWRXQThUOXJSaThLS00wUzQ0Q3dzdFJndmlLRUpa?=
 =?utf-8?Q?1ngXn0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 19:48:12.7079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 806fea31-cd87-4b29-2638-08dde1b4d448
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419
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

AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE is a flag that
specifies that gem memory contains sensitive information and
should be cleared to prevent snooping.

The COHERENT and UNCACHED gem create flags enable memory
features related to sharing memory across devices.

For CRIU we need to re-create KFD BOs through the
GEM_CREATE IOCTL, so allow those KFD specific flags here as well.
This will also aid us in the future and allows to move
the KFD components over using the render node for allocations.

Signed-off-by: David Francis <David.Francis@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 10 +---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e3f65977eeee..aefae3a9e6f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -442,15 +442,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	int r;
 
 	/* reject invalid gem flags */
-	if (flags & ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
-		      AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
-		      AMDGPU_GEM_CREATE_CPU_GTT_USWC |
-		      AMDGPU_GEM_CREATE_VRAM_CLEARED |
-		      AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
-		      AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
-		      AMDGPU_GEM_CREATE_ENCRYPTED |
-		      AMDGPU_GEM_CREATE_GFX12_DCC |
-		      AMDGPU_GEM_CREATE_DISCARDABLE))
+	if (flags & ~AMDGPU_GEM_CREATE_SETTABLE_MASK)
 		return -EINVAL;
 
 	/* reject invalid gem domains */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
index b51e8f95ee86..b3047d73fe07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -71,4 +71,18 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *filp);
 
+#define AMDGPU_GEM_CREATE_SETTABLE_MASK	(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED | \
+	AMDGPU_GEM_CREATE_NO_CPU_ACCESS | \
+	AMDGPU_GEM_CREATE_CPU_GTT_USWC | \
+	AMDGPU_GEM_CREATE_VRAM_CLEARED | \
+	AMDGPU_GEM_CREATE_VM_ALWAYS_VALID | \
+	AMDGPU_GEM_CREATE_EXPLICIT_SYNC | \
+	AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE | \
+	AMDGPU_GEM_CREATE_ENCRYPTED | \
+	AMDGPU_GEM_CREATE_GFX12_DCC | \
+	AMDGPU_GEM_CREATE_DISCARDABLE | \
+	AMDGPU_GEM_CREATE_COHERENT | \
+	AMDGPU_GEM_CREATE_UNCACHED | \
+	AMDGPU_GEM_CREATE_EXT_COHERENT)
+
 #endif
-- 
2.34.1

