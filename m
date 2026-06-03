Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D404CD6E4A
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 07:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B103310F9AF;
	Wed,  3 Jun 2026 07:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wJet+PES";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012058.outbound.protection.outlook.com
 [40.93.195.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F8D710F9AF
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 07:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NN7oyT0a3qgFFCoQVf0kp7Et68y53ppULXpoB2PPBQAVp8ENucTTadc3HPoen2ro7JDTmA4M4G59bpduDV/6YD/ZFErWdwpPee9iUadOE9w4xLHaWMZAgoqTGSlKwEMMHgoKabkCUkjIpYM1Ss65Y3M1Vr4XG3ibq9FXdWY8vVjTjZumTXm6kZT3dW7A+ENuXrz/uDwkBKUZRFrTHJJBy/XFuAWiWuBpVgrjGoFnZ2v6CPbQTJNi7fxjRMKymEuwnEIK0mZ6Rr2LF7TsfAHr612wsP0b54DsH/2cFbQFQHkS2HSfRB0g/8P8A9pZl6QmjJCk/kvOfEzI28SZJmX04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBcvfrtIoGf1Rq+QD5I1ozeciOrDpsTZApmBmButUbU=;
 b=FPr3hn16UpDSvxuYOYJBv0RRBFTp/68y/76r8g5YUIfO7oxozw2v+8+mWX1Hj0zq4IS7uoSdv0/IQA8inLpOlQc1/pb/FTquzP0McqxvR66OINaE9IYMDO8LtPwPS2zMQozOJuzAYLiTL2GhnYnQ4TTFv5LUo9b8oDyrf0UtQ8qPxGAGeTcukcjl48K7L2TVakaUur9VUWKJedQS8o7PwSHwlUgbjMDzkHJPt5lZDZ4AhQhYeE9fmkgGWFnXSvV2/FfwCoNkQ7/ZJbL6v5i71vWe/XJPhhC9NipQPbfCyoWAsxFOMroS8uKXaO8X35ow/d/CxQ/GrFnrjyE4aB9sAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBcvfrtIoGf1Rq+QD5I1ozeciOrDpsTZApmBmButUbU=;
 b=wJet+PESPjsIlZkX8qTD/iBsn4pfYuG+QFTnxYrb4w2qU1an+yiSw7u22cJBfBbBQdX8eoMAmF/Kqfu8wMaPO8UGPU6nNpejjwTiNTjmRGr20dZMVLdtgsrM1KSiPbk3/iT75rjMH8j4nNbOKqYrJyxt71jvrtQ6ig9I3G3fOLo=
Received: from CH3P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::32)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:16:22 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::a2) by CH3P220CA0012.outlook.office365.com
 (2603:10b6:610:1e8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 07:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 07:16:22 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 02:16:19 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH v3] drm/amd/pm: Stop pp_od_clk_voltage emit at PAGE_SIZE
Date: Wed, 3 Jun 2026 15:16:07 +0800
Message-ID: <20260603071607.874791-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d7f9cd-9fed-41e4-2b82-08dec14003ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: br2wbGn5CO9zVV4A343YbHhsp9Y/qwviGukLz3HxsFW5ruAfd5z0sLT9PvFrQnEfNGnSbTofb+3Qe+E7Xy2nxdGrUdj6duryvVt77CIbLHaKNaHU7+/AIqdJfHT7UrBluLWwylsEbKj0i7O1ySUkne3p539Ak6msVRdolKUhKroG0ZnoS0colI4YNmYiQozH8eVcX2MYyG/o3MZ5xlu0HSisCHweLP5TzJm2Q1+e3TW6eAZIoDpLU9hi7xzZTZNMcqrDckfSdXhJ/DIXxcgufzeeG0ZULU1BVN+l1NB8muD8TtuB+M99po2+LNUEJZc2hCbXE4iheeORgYYp8bYAa6+J+Y34H+oaPHcW+ey7wfzQeTAzT/VXzixXuSxSJUxTyRomv87vigxYsHCGvJYiG5S9KZEu0c51rVH8kRvPM/fVH2qaXtfuABt9T4pk24mxNihJKCrDeqhODcjLPt7GI5dd0KrKgdy6reDj1Azlda9VI+LPQZoZK9ekCFQYQdYh2HrWrL6jGEJYgh7r7T/D2whhwv00h5zH9RlWULUE1s7/K84ChCQXHvV6BBb6gylBZIsKSjQJAPb5DkeV6Gsrd7bh55/zC9FgonCZqTDfqONg0weIHmSmVl0LhHDnEG3qim8fkrf0kImdklIwVnFBPwRMOTcZq+DM/akUQM2GoHRQ3ZdwiYZeUXjoQQx5SEdDqfHSAnXTW/BF85C7LjAcecwPoGz6fApQDLL/cCl6qqY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(11063799006)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0jPJnq8IjwdHGerrkccZJhdEhHSCIuxT2Ut+dbbU0txt8l+vnp0KfqdN1CYS6+ajpWntoRjvk0gWC8TqM0hjMwbdxelHtmcycUmqWGfzthOHvJqRoViWz0SOmON78Id7qRmi6maTIsSVlwwhW3qRiMKk+PGIqEZsllR63IdhNB1s9gIWKa6fvlM2fKjBqwdd5AdVWxXYa5pr6n0mVNOFhMtJZMKqIxc0iGav+tnsZEVf8bcO2SW2yaz9g53NmnQd+p8h46Lop075ha62By5JZvpH9vbQs38junbyHvfS8OgZ0Nf885Na0oqDi9x1E/xKH12kSbr2Oi+RRfrB83LzaN+vjPsvnvttGvdEJzn8GhHT6MVTZTQJOpO4PhuCOnhteqJlnsiMi8fY9nK1ff/R6UnFPCOCpeHgesu7OgVaCWuJuQYyaF1MLcJhIrQKhCb6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:16:22.0525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d7f9cd-9fed-41e4-2b82-08dec14003ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
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

Stop appending OD sections in amdgpu_get_pp_od_clk_voltage()
once the sysfs page is full, instead of checking every sysfs_emit_at()
in SMU helpers. This is purely defensive hardening.

v2: Drop the prior series that checked sysfs_emit_at()
return values in every SMU *_emit_clk_levels() helper and
smu_cmn_print_*().(Kevin)

v3: Update description, remove all clamping

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 1e590db80221..85bef52887d2 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -874,6 +874,8 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 
 	for (clk_index = 0 ; clk_index < ARRAY_SIZE(od_clocks) ; clk_index++) {
 		amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
+		if (unlikely(size >= (PAGE_SIZE - 1)))
+			break;
 	}
 
 	if (size == 0)
-- 
2.46.0

