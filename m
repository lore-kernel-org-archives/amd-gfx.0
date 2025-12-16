Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6D9D637B7
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F6BC10E89B;
	Tue, 16 Dec 2025 21:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E74m72kb";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20DAB10E710
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k278jDpTqRmSEdDF7TSrGkGNXWaYwbkd5Vhyw0zW75pLk5QPuD/8piQRH5nV0vDgCA+f/qF0fBvlBsLJ4wsTerQtmD6OHAPLi+JOiI+4nz8tHo3exIERMo3/ontaDZoIEqvrGZozuJqGw9xkWlbTbiVWg+zG4V2VOQ5mri1D8024jHTaRu3G52wsB/FFm3mxlHhDyUA0sNL8BJxdX+1Wfo6Y3NTC6mcM7zOANlz3LN8/CrjhXhXkGb76dKvvq0g8ofYgOj1Yf/VwpG58ZXZbc+EkV6BJWFYyaaHDyQNg6k5F/JNEOcHwyhlNTk7dPfL1sON6sj8aJGeg3OMesIsmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bg3PFpgIoEvkVEmZXF9OCOnqRpirb+8HSLsAQ1kkZJ8=;
 b=uJOlzJ8A61j0ifadYbnbD8MBY28bSUj6fZlY66JPgyj2BSeNVUH69Yblf+AC4zIqkcB9+lzoz9lSANwdez1VEejpmU6AMjR9tJt0HB2uK1p1j7BUs5SKe9M+6EE8JdjUbZT8l7ZC2dc3xF/u9I2P4eGt1BrtD5AyLfCtgTg3zl26X58sgy4Ufq0Q82sKREINgTtm1Q2pzz7L+5LFXQmY4A2k6dxtLjOVbdxUG/7RtwrRloK8+UOjImZkUY9wkignMJeJ+uw8rhpTRnXA+0NrnHBVTbwpDkFcyEYazJprUrAhCcVFJZ8gdcmQ9VvH6d9AnsqnMpOeXPLzuF5zu2skVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bg3PFpgIoEvkVEmZXF9OCOnqRpirb+8HSLsAQ1kkZJ8=;
 b=E74m72kby6Xuoi0d05y51yv0k5GRNKOyhNyN/m1vNhzaPego+jm3s028h2JWXwm1ycaiDWagWhJguF305d6oqJrAvklO/xHX2lgn/oI67KYmVkvEjrei+ausp/+45iVvLBYqoYamFIYSGUJKYEBdUQXTsQ73YQLLZInjqgodalw=
Received: from MN0P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::28)
 by BN7PPF9E4583E15.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6dc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 21:04:15 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::94) by MN0P223CA0002.outlook.office365.com
 (2603:10b6:208:52b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 21:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:15 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: set aid_mask for soc v1
Date: Tue, 16 Dec 2025 16:03:47 -0500
Message-ID: <20251216210349.1963466-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|BN7PPF9E4583E15:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a00fd02-6858-4316-1c25-08de3ce6aba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pr7slpI4c2uMR/aGjIdO20JSDRN5yokt1wMzyNUjnlW0BDZS7HpDWvy9kUPG?=
 =?us-ascii?Q?hkUUoZFko/QnjlVks0fFzgqUsgGLn0BlklBIcCZvYn3juOloTn0z3oN/J2Ky?=
 =?us-ascii?Q?5ogH0xVHjpPUiMUWdwcP14AxxvIbccXB33+RAW4O/wyhVWtBNZaMWdJnnWa5?=
 =?us-ascii?Q?BS6PCUkRY/2n9LFQQMMTr7F0+a5ZOf4P4KhIrbziFSds6ALsLlQKP4QmOgXe?=
 =?us-ascii?Q?yciwoK71Ig1taOJqEVc/bXA9P+V+uXbooCmC1+EmxeG0X1ln7JGQKpLSM4N8?=
 =?us-ascii?Q?+9z2LR5LxmPizSQkaXmT5sDHsdq8B+E7jBn6NWr0+Pg7+10ljUN+FbCm1jEJ?=
 =?us-ascii?Q?QaqX+V+iYLKftIarkH0lSXXBlQ4ZGCjIgWLFiNxEewzWnktF900ZJA9T3XCF?=
 =?us-ascii?Q?LFv5Ry8RWhpmRmQOlQ6WlfWvM9ggSwqeeb5FTnomgE95CBPKSwHPnq0e8gP6?=
 =?us-ascii?Q?ivBN8WHqw8qeit+yGcD944BIxukKuEAyOCn0M0BfxrUa7RwqQmvH7gSho/4f?=
 =?us-ascii?Q?XxaVbO5PuK0xc8u0Yx0E7NsT7n5AJtSen6PIUIiiN8swcFeJH+4iPI2c+9VR?=
 =?us-ascii?Q?jWjmkjAm1hsLyO8Np22dfBngugqYPrA2y0SexZdAHX+cfbQ8ugSCpMPh/iRR?=
 =?us-ascii?Q?N17zOWjaX06SetKzQ8D7OdUjfRKmWBLtP/3E2ahnrKYtovCVyL83D4bijr7B?=
 =?us-ascii?Q?CxvJf6o9eu+znmNUsa3AQwlCs6hk3C5EGAbRHAqe9QHpFejT2811R700OebR?=
 =?us-ascii?Q?XzU0C1Rs0I6ONuRLqClnG7hfCFt9NOxknD/V3RJoiqGq2Tvhtqk3HB98ettu?=
 =?us-ascii?Q?3PCjgNTlA5Dtq5elhWOwwrlLOg6DgqSt3ykyt9vhMHjKwYBYBObpv1yeE7G4?=
 =?us-ascii?Q?Z6IRXmn57MVebNxOss/vde0cE4tL972mZzwXSPBjYIROToZzt7KoN/kLfna8?=
 =?us-ascii?Q?B/+XLnKQxATMk6kGcR7eUbVSW4Yj7KXLxaPuarkyfpAGIvq7x6KhVppriGyG?=
 =?us-ascii?Q?Wq7dfwlbFwJnEPQsHNQRzOzm2ILue9dKXyzbJdrPBpQmdUXddtU5apeF++Kv?=
 =?us-ascii?Q?BGVph7ljFCp4kkwFkw2P/fE7BOYRbZJCx2nQ3eOltmmESbqAhfDZpfbZ6y7G?=
 =?us-ascii?Q?UT2fbXrzuEiY8q0BVqD8CwucfqopAH27SZhehuUciWkbXavC+BV/6ICg+Jmr?=
 =?us-ascii?Q?P7G35Y2dp7b/Cnnth1PcwcDd6IK3D0c1ZrJHSfOURYZOWRVcW28mKSDXRRDD?=
 =?us-ascii?Q?5qIIfzQLg7bFOQjwx9Df+YICX7KjDDpXUOzYEUfD00/2FZk8dOlCSST1hl39?=
 =?us-ascii?Q?9JGfVaLKmZiL9z9zJY1ZYCP5zR/OPS2Alq6TsPFOkdVR4AvfQp5wAP5PH+5P?=
 =?us-ascii?Q?JoSU4GL6+YIZVnw2X1x8deFxo9H/IZTEUGc3U+YKSoh1ITIGiZVYYC4Y1I4P?=
 =?us-ascii?Q?SKEYYQF6/NdQUZU9JN4ia7wMyu7TD4wdxeKQnydglIxET8bbCJsKAsezAxoQ?=
 =?us-ascii?Q?RlzOPqn6ddTRm6Heyim2uGSRU9q2JfJTSovgK6NM1UI/lRgKUWaPnTEHK0Gd?=
 =?us-ascii?Q?N4ZBpEzY/fdHfGi7dmo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:15.2361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a00fd02-6858-4316-1c25-08de3ce6aba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9E4583E15
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

From: Likun Gao <Likun.Gao@amd.com>

Set aid_mask via xcc_mask.

v2: squash in follow up change

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 628abd25ac091..e9c7be1ed602e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -781,9 +781,17 @@ static int soc_v1_0_xcp_mgr_init(struct amdgpu_device *adev)
 
 int soc_v1_0_init_soc_config(struct amdgpu_device *adev)
 {
-	int ret;
+	int ret, i;
+	int xcc_inst_per_aid = 4;
+	uint16_t xcc_mask;
+
+	xcc_mask = adev->gfx.xcc_mask;
+	adev->aid_mask = 0;
+	for (i = 0; xcc_mask; xcc_mask >>= xcc_inst_per_aid, i++) {
+		if (xcc_mask & ((1U << xcc_inst_per_aid) - 1))
+			adev->aid_mask |= (1 << i);
+	}
 
-	/*TODO: init soc config */
 	adev->sdma.num_inst_per_xcc = 2;
 	adev->sdma.num_instances =
 		NUM_XCC(adev->gfx.xcc_mask) * adev->sdma.num_inst_per_xcc;
-- 
2.52.0

