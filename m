Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFDACA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 19:50:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E96CA10E292;
	Mon, 25 Aug 2025 19:50:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q285h77b";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67E1D10E292
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 19:50:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJGs52dcnAQQKBTTKmGwlV3mhfXe0SFJUHfz72lLa7anQkLtJAVD1ml+E8AcxQQKRriqcTqj0pTCEXuJY4zRe2LI0QA8ylH1Tf+KwWXH1qSiX1wh1nTGUWQkBjWEx/v/qQHIKq9dWzAxKEfmDtFrOg4kyXhh1H91gApBMeQX2ziCy8GV2roOI2Ah1V4DqZprWZH3waXDpqH6wqjzJ4BYze0COuWoUrlvV1t0V5sqjcfnsQ9mWdo9BH0oxLwNL0Ray91NkaNCUYXY/YYFMs8Yy3BqkNCEJcL/RmGBgwcNiogmz05yd1bTaxRYvRwZ0NOgNHuTmyP4pEYBUQAumjq+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQtsQRplO2NgiifoIFRTsz06BFFfsXCBvUnEaP+N9sk=;
 b=P3BYukXf/DbDBNMJzPL6ocVETUNs/6ynC+xGSrvdbV5vkZprFg/46UN8k78N1NzQlnNFZIdGg/7dJSzHvFaDQTRR7NLkSetYq6GZhAaEcBeVL7FrU5SWmvsPm77mH7aRSzI8xYLfsHCpeCdG0Cq0pIRNmuYNNL7hPyPh8Nl3QdoWGiea6jJiq4Zu9Kka+k3ZxxuewUAf2T7lr+LrfgLBIOi+042pG0xZDXbFQdhHFUBeLYWv0lhmjptVNcQjXz+meyAu/qb0YVM/cyfkdlj8ilKdihvvGdoKPQ3zJVV22p2lIdOnq1RwSyP9gaPfBbVNQKlcl0znvl/a8+e2m9ms3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQtsQRplO2NgiifoIFRTsz06BFFfsXCBvUnEaP+N9sk=;
 b=Q285h77bhrBOelZ8k2yfURWgpHokLKVP5Ikd8IB+aFQPTlJt4mbZXluBBJuMnSD/1i7vhTEBtQgGJx4XiuuGht0CbwkpWqi3zp8MNu9aXbhrmodPoJtJ640ob/GrA5prZ6kF00Eixb7PkhX6TLLoaCGVPdtVYcjoFqGhPQPBD0Y=
Received: from SJ0PR13CA0037.namprd13.prod.outlook.com (2603:10b6:a03:2c2::12)
 by BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 19:49:56 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::2f) by SJ0PR13CA0037.outlook.office365.com
 (2603:10b6:a03:2c2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11 via Frontend Transport; Mon,
 25 Aug 2025 19:49:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.0 via Frontend Transport; Mon, 25 Aug 2025 19:49:56 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 14:49:54 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <simona@ffwll.ch>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, David Francis
 <David.Francis@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v16 1/4] drm/amdgpu: Allow more flags to be set on gem create.
Date: Mon, 25 Aug 2025 15:49:33 -0400
Message-ID: <20250825194936.899825-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825194936.899825-1-David.Francis@amd.com>
References: <20250825194936.899825-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|BY5PR12MB4083:EE_
X-MS-Office365-Filtering-Correlation-Id: ab44b881-1261-43b5-cb7c-08dde4109118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHE0ZG1OdGlOQm56dHdRdWNrckF3dGFDaXBUTDlNTHNSd21CU1RzTHNkRVU5?=
 =?utf-8?B?dkk2aktOa2FOSkdyZWF0YzNJV0NFTFR1WG1yNlBDWmtKTFU1VktEKzRCWEdS?=
 =?utf-8?B?ZzYxaFpUNmlCVmVVVUVEOHJkVW5LbFdHSkk1OUlZYWludG9rUU1LWmUxWUdJ?=
 =?utf-8?B?eWVPbUd2dnRsUlFncVZGczdTWU41NStReU1ib0RnNExGYmdCZC9qWi8rWlpM?=
 =?utf-8?B?V0duQ1E0c2FEeGYzcXJ6NUZGS2RTTSs0ME0zU2tVL0V4M1lES1duclhnOXhI?=
 =?utf-8?B?dER0U25TME10U3lPOWhHZlUrWHVjTkE3ZGFscFUzRC9uMVRQMHZmTDMyd2NB?=
 =?utf-8?B?Y1hSZ3doOXVQK1VZdEZlektHUUg2dlovMWpQbzEwaTBsbk1ianE2V0Q3Tzdk?=
 =?utf-8?B?cndyR3ZaL1JIci9RZFV1NnB6VFZDMC9BVmkxUnVGTEJCdnphaU5FaWEvdjdP?=
 =?utf-8?B?ZEQ4d3pmWTRaQ3c3azludndBalNhT0NlQ3RvMG1YMHZPT1JPNWx5dXUvRHhh?=
 =?utf-8?B?WmtvRFJzM2VDbG9PNXNjSmd2ZGFFbG51QmNvbUVMWG5IL29yZGhQa2pnSHA4?=
 =?utf-8?B?TGZkeG1WZkEwWUQwbjJORWY5RUJYakp0eVp4Nk5WN29rWGcwTWVhQUg4eGph?=
 =?utf-8?B?T3hzNkwzSy9vZ2w4MVBNS0luODY3TTJLNWVnVlVCeUtPWUlmNUkrTjdMNnFK?=
 =?utf-8?B?SW8zeHJ2UnFWZnduZktlVHNaa0RTQU5aQ1VmVWtDTnJncEp4ZjdyYWw0bitw?=
 =?utf-8?B?TCtNNW1LVXEvRUJXTDBlakRjTmdDLzc4RUpwQTJpNWFjZk8zOWVFdHRYTXJY?=
 =?utf-8?B?SXRuVUcrZWhiZ09HcGZjckwvL0xTYTNuZHVJeUp0Ui9XdDIwLzBkOVFVc29N?=
 =?utf-8?B?aS96dHhGZ2N1a3hSSS85SEVkZmh3bG1nTTdITjk4WUh4R3JFL0ZqL2ZJRVRX?=
 =?utf-8?B?UE52SjBtMnB3eVhBYTRQVmtaeWMxZmdxWlFrN3F6Zzk3NU5xK2J5b1NOcHAx?=
 =?utf-8?B?RE40MzdWTitQRGVyMDFORjlNelVVaEhlTjZGQTJsQUw1ckxIQjJOcTVyb29t?=
 =?utf-8?B?ZGFpWFhUUWZxUlFHU2UrRFdHa2pNSkpTZkhUNG80NUtrMHRaa1ZrNTRobi9M?=
 =?utf-8?B?QUxJR0RoSkc5ZnQxajBTMW9hU2VmRHJCR1UyeTg2bFNldkxPT0hIbU5FdXdZ?=
 =?utf-8?B?SUIrbVlrUlJmdkpFQkdCUFd6eHZIVVpadmpUdHZBSTZQRm43a1o4L0Zxem9y?=
 =?utf-8?B?MUlRckpWTjdCcHNMU3RLMTZlRzF6UHBKWW5CN2FKVzhzajdBc0p0RlN3UE9D?=
 =?utf-8?B?WWtsTmYvVEJNcEFWQnNsTFNzaDcwcXl4Vy9NYm5WMVpyYW1GVlFZTlpSaWNN?=
 =?utf-8?B?YlQ2Yk1jRFR3Smg1ZWFxWXFZOUVBbXozbEU1T25rRkJ6SEhwSmhxbSsvR2tj?=
 =?utf-8?B?L1pCcEp5U0t2T3ArTnVmRWZmOEpsd2JQczd0OVhGVnNhcUtCUzNFaDhWUkpV?=
 =?utf-8?B?V1I2UTJMdW5TZ0owYzd4MjRGWWNQM2pocm1rYVAzYUE2R1FDOTBhVjRKUVFH?=
 =?utf-8?B?NlZOT2JEWkRIaFBhbDZsK28xeU5NR1V5aXQwS2V6N2xzaFdHbTU5eE16MTUv?=
 =?utf-8?B?bGxKemRzQ0xCNVJTQUZtWVoxMHhicllsYm1na0xZUm5WdzNpaHJIOU5wT2Nu?=
 =?utf-8?B?MmtWL3RlenYzZndjL1Z3UVNCcU1RQ1kySDJROEZZRjBRQnA2SnVCUndFTGFF?=
 =?utf-8?B?MUZ2RnFkUldJUEpTZHhJMTVsekwxMTlLMWhaaWo1TDVwdmlUYmVubXBUTDhj?=
 =?utf-8?B?REZwQ05BanhLQmN4TE1XZTdkbllGSE1aem1Kd21UR1FWRnpUcTY4M28vblFQ?=
 =?utf-8?B?bmdIWWdHZjlsZU4wSDBKUFVmdUhqQ0gvb3hWWkJSay8wQ1dHTzUrMnlCWERv?=
 =?utf-8?B?UWVpdHZQWE9SeERzVi9ESGwreGNoVlJvTnRLREJKTExNc2c5Yk1pTDZZZWM0?=
 =?utf-8?B?V01Wd2IxbWtYM3hMUkRFdE5tNUtuWnRwejFjNDlOeHBjdk9Hek1uRDI1VXFY?=
 =?utf-8?Q?7AY5IL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 19:49:56.0086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab44b881-1261-43b5-cb7c-08dde4109118
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083
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

