Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504B9C982FA
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 09:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD7A210E83E;
	Wed, 23 Sep 2026 09:52:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TXTIkpYG";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012046.outbound.protection.outlook.com
 [40.107.200.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8946910E83E
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 09:52:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LO0lJSP6M1E5e42tgZRsGcjfbpkpqTaCbCLCefU4MRhKQrrIXZ33BNiAjFYsncAC81cSqQK6OkgX559Ym5Ul0uxTOmxrbiFfhiBSDKtkpV4cwPQu4WbKK1em/IwBU4c+phA0VwccztwdYavb2jKr6yu7IFnR0e18i12p6vEdv0YarddMdWVZhwDQX2Q/if8W2vvm8oxlv9VjJbp12JvhRjq2IIfMN/pZDpT9VL38m/KNy9cr8VZNkNfbTOFb2b/y7MWO0upDy2W6L9Fw3mtrBMO48cuG4RU85bwj5lNMC/TGfFFWMa4ioYpDXNHuDn8DuEPC+IgXEMzeA7FnsrIuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lO8xWC2M4qWiyhzJb95E4VX3BtpBNI/ziADFkVFz+ck=;
 b=CEcZEqQxvn14c9+7PPWQdEI65xjJ5MSBOiZl22p0ykJwQpm31kgLhwXeYLDbvcw25k5M+kACyXKq0urI4k5iGU8X9JH/Mgt4/aePp+BIkJ/OamyNnBZSNl/VgG3wJy3Yzyzm6grqAAUwmego58hQ6JBYQJUr6e1hIQ5i5+9T12Pt0VhzkoBCMOivar3z1eR4mfpHgtSLjRe5vnLrJ55/JPPDGTAzdmZNSTAhfBNvVUSV4mhT7my4xgHlWkKuVjRRfSOYV5alsyLNLZPdfZo11yG9aEy4lQ06k1FzDBAtl3a6HWijvc3HjYVlaXZjxpsGvW+3PFu7CE7IBUp2SrfAgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lO8xWC2M4qWiyhzJb95E4VX3BtpBNI/ziADFkVFz+ck=;
 b=TXTIkpYGjLAz6+3nczLrAbtQuf7Sp1m+WYL9wVCiP9K4HZesiC6Xs/XfyW30OJBeD11Uoqgsnn30ZZM1hjXaew0wOfVinVTrEpubDqiWM41uYKI+uK8LR0RT0R6qMDIOrzy7EK9y2cB2D2bniQmnOepwUgGIjTBcYZ8KjeLhJK8=
Received: from SJ0PR13CA0195.namprd13.prod.outlook.com (2603:10b6:a03:2c3::20)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 09:52:26 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::4f) by SJ0PR13CA0195.outlook.office365.com
 (2603:10b6:a03:2c3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 09:52:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 09:52:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 04:52:24 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 04:52:24 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 04:52:22 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Sunil.Khatri@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/userq: fix reading the WPTR at a non-zero BO offset
Date: Wed, 23 Sep 2026 17:52:13 +0800
Message-ID: <20260923095217.3932523-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a4b0c3e-891e-4ad0-b37e-08df19585f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: PFaSLgPIeQ2GuPWRUeg8XEr/kSeSzVdxzJAzrrW4LDmMANgmQG+SdpZKGNz+a+XbxD0l2GSlkb8AxEjNaa1Zn6jUTgRqYfjUCCUrh+GACAOa80KZ9w/wh20fORcYRK2i8/CV7aVx+wCza/s1FqEuHC+Rgk4buotes6L/n0K4ISL90JBm0fupTnObwWYYmnhMsUUjLuh/hYSpO33SMxSefVVW+ZxvxbSl50xwIceLr29A+wo/LQ5OuNYiovyw0UiqP4J3Bg+sOj/Rcn1PqWJ9unxjJTrr9PxJEYqULvi86FWLUs1M3YeI0spY6AdkEC/gw2+LwVdUe3lA6b5XIOr8YfHF8d5QAI+5zgzp3oZxt/cwM1Orw/1+n8ZF+CS2emUr35XB1F2jrLlSp++xwJ658J1ib1dgqgxt/7blxdAQ+AZCoqgRJSVmeTvg5z5s39Sxze+tEkdUH2DaTvd5ObBIXaSd8XmPFh14+bb5mqTyN145EdCft5u+viZGPgrC7q95adoLQaoq6jEMdztImS8ywWjSUoSLuPJAB8xxlzPZPTVvqEDqr2ZVa/rAoM7l23najwGkWLGa2/0u+gWMD90QtZGryy4Pkq/oYaGpnM81HqzWxOP52BrZqRu63vmD3Oc/AC/KIPB7FJOfikdIHmjHG0FKUkkgnAGnNZLW92235My8rus9sdU6+Z4k71wxtTDhG8LwERciJ/i/tf5V9va7mg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pKltvJ/fBUfc9VvbLmiguPAGo1yISblCUkYGNOpQDPGglFRAKgHJhXbWH1lvrx5BY3vSTq4Gp8+ybcJV12PrSOAa3XXTugxIUDxAQeCy4Gf/hQ+DeNSfRxelc3mrIvtX2+GWpiTJ2X/gYI9BNj10ZPuU8KGMx1Qmaob8XG4AMgpKz/ILt2PA3RjN5fndUIHEEaargmMILluLQ+91apqOMBCYmYHNA/ZONA6syGj0W9pqf66j70M4ZTXtXS7IAWOg+IlrVMxHrVtMnMTvL66uhU75T2mbAGnVuxnRVOQmGbksvdI4m84z1spTdkKVmZMTvm0SIFgRm++wIzH4vuRvJ1ASNc2azjd1y+p0I7MbqlVCCIkJkspkXoNEmsam9W7HieT16XU8rdXKXqOhJk2lxZ2i9XLDrLBZ4P+yCjVzQjhR3AlUZh4P7rBvQMmeqK9a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 09:52:25.5288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4b0c3e-891e-4ad0-b37e-08df19585f4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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

The user queue UAPI permits the WPTR at any 8-byte aligned offset within a
BO. amdgpu_userq_fence_read_wptr() locates the mapping containing the WPTR
address, but amdgpu_bo_kmap() returns the start of the BO, so the code read
the first u64 regardless of the WPTR offset. USERQ_SIGNAL uses this value as
the exported fence seqno, so a wrong read makes the fence signal early (or
never), breaking dependency synchronization.

Translate the WPTR GPU address to a byte offset within the BO, accounting
for the VA mapping start and the mapping's BO offset, before reading it.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index c270635c907b..b885e90ec5f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -372,7 +372,7 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_bo *bo;
 	struct drm_exec exec;
-	u64 addr, *ptr;
+	u64 addr, offset, *ptr;
 	int ret;
 
 	addr = queue->userq_prop->wptr_gpu_addr;
@@ -404,7 +404,10 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
 		goto lock_error;
 	}
 
-	*wptr = le64_to_cpu(*ptr);
+	/* The WPTR can be anywhere within the BO's VA mapping. */
+	offset = addr - (mapping->start << AMDGPU_GPU_PAGE_SHIFT);
+	offset += mapping->offset;
+	*wptr = le64_to_cpu(ptr[offset / sizeof(*ptr)]);
 
 	amdgpu_bo_kunmap(bo);
 	drm_exec_fini(&exec);
-- 
2.49.0

