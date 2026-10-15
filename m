Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69BACC6B30
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 02:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FF8E10E212;
	Thu, 15 Oct 2026 02:19:18 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013044.outbound.protection.outlook.com
 [40.93.196.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0034710E212
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 02:19:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HB/wLGhYzD1jDN9PMOhEPBhL4i0zqPvJwhGAcKDg+gjOSTVNSLO/uZ8YhMmiEtve3UAjpBMGVExZZEV3CtzC7hloXMwe76BeF4bQ9dNHw4Km5S1DJzZuhIoUFUXjcE7nwArgAvkk1pKQ3IR3miaHDuOActen6rQECnP6M1UdoklV6SflmVeaUPGzViE4aXOjwIqT6F7VbzIU2X/3Aym6E+L15klgliuYRKVDXVoilY0qWkeHWBCrt0BR+O9SzBkmMCEj8dXPN5SJlJs3mTH0VKLLsuWEUmNykeSWkr/Z2CvwXJWkAvFT17GY43eBbdmorp0jCQ/SIHANgSgwQYYqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dxZlWTsMKDOg9fz9Z4ZBPCg9Z8dqyvIJcbYwL339DQ=;
 b=OvH6iUY+wlddnw1TZMdXPH3NFWQDHvXGeTKLvOVOLipzSGA3xOz88BbBmXRzx6T9i5+5s42LA4kATHm/ErTx8qAF6gcCVgSXcBJ9ugBQiDsJiAVFcd6jLhiqYaFvFT633pOj3u0bVat1z+LXQFasUndEfRUhtSLjWSYFwpuI3cYGc1FEDx8qLs1BJjeO/50n7c9YeFT86Z45t1shGdaCa5VeX2EARvqyKwj1eufrq6mxn8LebfzQ/RyKVW8vQWdj7r9cLu6QQUmsZlQjco1u8NeQ8tX9mhtOMA7bd74jW5oZNakbzgzxGEWzUDppjVCyFHJRZnRcq5VrOkxXBmRvwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dxZlWTsMKDOg9fz9Z4ZBPCg9Z8dqyvIJcbYwL339DQ=;
 b=VMdOV0UGw2dpckrQ2BW/7fHspc4AHWce6CIO5OtN1g7mBzqyeTab79599QW11INoG7aFycBwdd+SIlWZ2q2rJhj41hn5pLNbMf/+5PDvJaEyo49frlUp7tbuw4jRlQA5NZNUIoRlzq6M3B20a8nLhxSzzT4Ca/mvUmjF3p4Vza0=
Received: from PH3PEPF000040A0.namprd05.prod.outlook.com (2603:10b6:518:1::51)
 by DS3PR12MB442436.namprd12.prod.outlook.com (2603:10b6:8:547::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 02:19:08 +0000
Received: from CY6PEPF0000004B.namprd03.prod.outlook.com
 (2a01:111:f403:f910::) by PH3PEPF000040A0.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 02:19:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004B.mail.protection.outlook.com (10.167.247.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 02:19:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 21:19:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 21:19:00 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 14 Oct 2026 21:18:59 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Philip Yang <Philip.Yang@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: reject ANONONLY userptrs that span multiple
 VMAs
Date: Thu, 15 Oct 2026 10:18:14 +0800
Message-ID: <20261015021859.3229267-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004B:EE_|DS3PR12MB442436:EE_
X-MS-Office365-Filtering-Correlation-Id: 7134b291-d846-444c-6a7f-08df2a62b0e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|10067099003|18002099003|56012099006|11063799006|261009223027099003;
X-Microsoft-Antispam-Message-Info: 4it8Bn+auS+9nmOyXdJ2Z6/KiVR4vZLKht55E88dLEg89A8pcdexjAcgXPvHgxCVIdtzdddfyDc7xB/p0nXzKgwVoMbvbH2GagTgdKy8SZNciz44d5UT39hh1aKbKjYPLHzlisFXq2HpROhIjtX1Q+1uHAs4QZjtmYaF7tdbGbJs0ymwOVAFZGX5TYZNnE4dxx0HPh3E8nbNzEXyaYQVgbk8QtNdrqyQWArq6wC6jBhzYXfOPDv3SOXHyclGou+8ZlUMt5bEyHNjM7Xx0z4ZgqjbiF8TQv5nq9tolybdWioL41k//ZROKamjKBsQgjxQ8/6hV2LFMPNjnrrGTYWYmy7VW4s076aeg/PVr7mr3tl1Z98Qkj+aB6YsmBDU87bY/O6/adc8yb4SKVq58uIQsG7Xl0BTEm93JgmoEMKknQrKcZno4w8evyUbvIGYDLPDO4KWmTiSvBtMmuV1X1KkSycD9C67VgDQZWP1LZVt3mxWVhKDE3v5sspZ+0MXBzsE8EiHw+kYD2GpSOxBMi5BGci1+EgX3s49Ddf53zEINXU7y0JbsY5fc4LQt5nq2EurNim7pFS2mgBCpIizsA5Ei67Ap2nPJdLsrGozJ/N91oUQuSimIOiB2/UWgp/G6tnMhQuaX8+e7h0J6LOIBMtsD/NO5sa1e7KsAMP3TBZsSPhCk38+5X3cYM6CzEM4ZNkWQJFsxD7vwo5JGfa1yYEDjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(10067099003)(18002099003)(56012099006)(11063799006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KXZeI60ZR9QuCawxCCOTPX4PAxk1dUVkSkkkfAvu5qQaZNLXF1jEdRd9Zwa4Iju89BgpHQu2XMaeefs4dOhwD9xBvbNw/Vz7pVs+yd8ec6CQhOQB0TLYlQGon8qYNX8UrUI/7RN8PsQfSRl2gtr09EVG/qR8wVFeLiKUhhxcthD5k0sxIyWfSE/Xo0WY6heeGsZA1wq/lJvoKBDeu4mROG69DThsKVr/zicYJ7UkhH/KrG0DV9mseopkGZC5IRVFGWVVte7SZT3ry0R86VFR+zCNV9PPZY0EC3UvxPM/OiNxGD6H/sw3KYcj7iYbF1+3edFrIwa8uQrOvIkcUx+Kkea1Gp1lzx/eqP2UqGSSaV1H9olptMZnSoqyUHGV5MEUV1jJEJYF8k+1ImhrKa62ISMcuS5QJroe75WPPomv2JWUNEN2oE0jOjigNEgZ6Nbg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 02:19:07.2603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7134b291-d846-444c-6a7f-08df2a62b0e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF0000004B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB442436
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

For AMDGPU_GEM_USERPTR_ANONONLY, amdgpu_ttm_tt_get_user_pages() only
checks the VMA at the start of the range for a backing file, and
amdgpu_hmm_range_get_pages() then faults in the whole range, across any
other VMAs. The check used to reject ranges ending beyond the first VMA
(vma->vm_end < end), which got lost when the code moved to HMM.

An ANONONLY userptr over one page of file-backed memory is rejected
with -EPERM, but one over an anonymous page followed by the same
file-backed page is accepted.

Restore the check and reject ANONONLY userptrs that cross more than one
VMA. The second userptr is now rejected too.

v2: reject ranges spanning multiple VMAs instead of walking every VMA
    (Christian)

Fixes: 6826cb3b92a3 ("drm/amdgpu: support userptr cross VMAs case with HMM")
Cc: Christian König <christian.koenig@amd.com>
Cc: Philip Yang <Philip.Yang@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2103f8d6165d..9b2d3ab9010e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -784,7 +784,8 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
 		goto out_unlock;
 	}
 	if (unlikely((gtt->userflags & AMDGPU_GEM_USERPTR_ANONONLY) &&
-		vma->vm_file)) {
+		     (vma->vm_file ||
+		      vma->vm_end < start + ttm->num_pages * PAGE_SIZE))) {
 		r = -EPERM;
 		goto out_unlock;
 	}
-- 
2.50.1

