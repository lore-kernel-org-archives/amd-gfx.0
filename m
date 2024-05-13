Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B31FC25B75
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 08:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85F5D10E54E;
	Mon, 13 May 2024 08:56:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bT62R55y";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7F8210E53D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 08:56:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q64YvgyaReAZRGBAwWF0jlNyTOqqsLRg1EBxGdkYE40xGyMVSQAnOGvJv9o3/usPCGt6kzcKJ8SwmLGHePPQMi2CjuBlKfiPJF+nLHVLcGhp6I3Yj4lBfelwSrH9Ua5q7QZtFJ14h3qaRXeZZ785Meskxta/CH5Jzn40LfsKdo/ARe2Zf+fnDKjOtcs8Qzrwyak+yzajY0hVc3dWqe2Y+DXIowVbORk4+agn0BneoriLfmKR323FwPfW6gm2RnTa+YW3JvdFVxCs6vBZIu866iPMP5WA0gY0lVKmz4B5wGtpj9tFvtfLCIrlLr62pVjdnRRiRDsq7nyYjuU7MOLQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reMpMFvhNoob8vzsd1QW5GvFyK1hPpeu/hNGn4EPpUo=;
 b=Ac5zn4uQunZsZ+mTSIYV/cHtWzSYDonrJExgG/yh3SgENhDM0IKU8WHn83C2tEfj12s0IBJesxCpRI5TeinjgMBkD25SZ8Ty9dT5WEIb1eHjXylbkuW0V9TeO2UUaN361HHdrZtT+O7LplKghtjzLawPNTFCqwrafCVK2KfiAY1zwOu4PswqB9M5HfKdrNeG9/ipQge+M/FpFENtP+dfIVGKb/szt+VlkmP8y/mk3zqIyT9TWi1merAEErj+epao/AKM5OHSJewfhgyvdTrcRchKsqJW/P9TNLJLRUMnFrfIgryn4M5xrN1KwrZuDIHkehPP+ZiP5Qj7+frL/CMwXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reMpMFvhNoob8vzsd1QW5GvFyK1hPpeu/hNGn4EPpUo=;
 b=bT62R55yws00y2MKNh83RoCXEbiqEqUzYwkkcNUrLmSHZHb2X5SRJGWoe9IYr364aBp+TeVKIr9T+w+X43JxRNv8VmC7oKPCrImpudDgKnU1jrtEZ+tR+V3nnaA4m+Lk2lIQFtVkbQH3Oeva6cT5gDw1vYu9Tf54UkjOI9mG/K0=
Received: from DS7PR06CA0017.namprd06.prod.outlook.com (2603:10b6:8:2a::24) by
 PH7PR12MB8780.namprd12.prod.outlook.com (2603:10b6:510:26b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 08:56:46 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::f8) by DS7PR06CA0017.outlook.office365.com
 (2603:10b6:8:2a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 08:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 08:56:45 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 03:56:42 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <christian.koenig@amd.com>, Ma Jun
 <Jun.Ma2@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: Fix null pointer dereference to aca_handle
Date: Mon, 13 May 2024 16:56:14 +0800
Message-ID: <20240513085616.584249-3-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513085616.584249-1-Jun.Ma2@amd.com>
References: <20240513085616.584249-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|PH7PR12MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: b7468fe7-5dd0-4d33-d115-08dc732a9e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1fVFArCj7DnMsetm1hKpK6iIJEYcStpI7P4Q7pg7dhpez1itUm6j7afehmNt?=
 =?us-ascii?Q?MsK/GmJ8yZg4b53twgIoDwB+z03o0lyt1R8uehXgxopga/RPUGNf6xZBs1z2?=
 =?us-ascii?Q?Hhm2zowuUpruH4eB7vqAV1yQSND8h4RJEjqh5O2YVvzgsQ5L664kr/iLCi+B?=
 =?us-ascii?Q?J9UBVGrxnawNI+25tvR3kJPllzg3YaYE5VJcrJ6r1fSfLI3Wqual+YwJtRvu?=
 =?us-ascii?Q?QjzZltB9QikKdG2AR+GUvoN8XcccpPRGUxZqUXO9zooZDcLRx+N3HasNHTYN?=
 =?us-ascii?Q?IBARF+i7rP+BeWZ6L6tuKT0em1wBUoUQQMC5q6tyaOnzgBNhtvTUrDfuGpvw?=
 =?us-ascii?Q?txR5Dx0kN5dgoTYIGlyo0Nnoxm8HjL6kfVSEUQQ1euXKyunanDRUZG5Jzgyi?=
 =?us-ascii?Q?apq6ob30NTGhTXcc45SUlelsPBZcubxxGZGeDUXqJswu5qxDev0dH4RkCqt1?=
 =?us-ascii?Q?oicYFzphR0iEwOmSNr/6KCUvdsGBnPhizY6AIS6Z+VnNRz3zxJyxILOK34N3?=
 =?us-ascii?Q?6UuDiJ8/3eed45P1cdfCnYtnPyBwEx3YvbOdK2iv92PkRWD+7tN1rgTw+OwU?=
 =?us-ascii?Q?w/qf/ZPBgMgU0xTsbbjLLGctH0N9JiMWAXpRFvKMMUVWL0mm70oaGh5pyGxQ?=
 =?us-ascii?Q?dBVVLMwMIZ4yP5e5HrOPJ/3yzHD7DecCQoUjLP4MR6+iHF72AD8ZGW9gh+lv?=
 =?us-ascii?Q?UBJCR9MP1dOM67n5zrKCUnUqP+209Gze6k0hge1pVpGg8NLjIKRnIBDjtXS3?=
 =?us-ascii?Q?cVJVSLdprTzgaugicpBeelKXGZV9XaPYiYZCdHBkDq8rCjvJQHkmAKt3yW1k?=
 =?us-ascii?Q?WXccNdK9Z9+g1NDEdEE5yBUgNZxfCt416Bk2HD20Q0bHEome/dWGf7mP/MoB?=
 =?us-ascii?Q?I1FAIki9gUltx+hfsyud/PQU55OYxyVb5YF5KJoQXrbNrdOF5FfB/MhCzCUT?=
 =?us-ascii?Q?kgxvHDzsZmxCLS/fL51eCKbpK01EQAFXwve4n1EyeAidtfwOgbK8v5Rrd1KZ?=
 =?us-ascii?Q?kvksul8TUqicK8jlU7zPYv7cQJlfuexA5/pJJaVN1MasLtvkpiDaEPFjOilr?=
 =?us-ascii?Q?w/BFa3fugV1IxiM34H1gjYtsCfW1nS6XKyRTAyabyizKq9duuV4/DeZeTBkL?=
 =?us-ascii?Q?c0byNuPEKlQy7H0dr2fO7PdQbLSrOMvalItMvA+qhP8SPPz3Ju+Lft4f8V4Z?=
 =?us-ascii?Q?NPjZlTHzrNXMkj8sGKEClCF87Xy2d3K1YBI1rsNdgPkQfrvuGOt8cEVDBSjs?=
 =?us-ascii?Q?JiOd+oxYDJDSbo3ddvhK//YvbZdWooGX6Jscr4L/34GBouV99URo6IfntS7N?=
 =?us-ascii?Q?UahoMdnW7bnTFmFReXa8HMUiuntfczOlUKgoXfiwjWPorKkJuBVOnEcvQKqK?=
 =?us-ascii?Q?kLvQ1vK6EbMMbAnwKdCMSKR+NcIE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 08:56:45.8872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7468fe7-5dd0-4d33-d115-08dc732a9e31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8780
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

Check handle pointer before using it

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 28febf33fb1b..e969a7d77b4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -279,7 +279,7 @@ static struct aca_bank_error *get_bank_error(struct aca_error *aerr, struct aca_
 int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_info *info,
 				   enum aca_error_type type, u64 count)
 {
-	struct aca_error_cache *error_cache = &handle->error_cache;
+	struct aca_error_cache *error_cache;
 	struct aca_bank_error *bank_error;
 	struct aca_error *aerr;
 
@@ -289,6 +289,10 @@ int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_in
 	if (!count)
 		return 0;
 
+	error_cache = &handle->error_cache;
+	if (!error_cache)
+		return -EINVAL;
+
 	aerr = &error_cache->errors[type];
 	bank_error = get_bank_error(aerr, info);
 	if (!bank_error)
-- 
2.34.1

