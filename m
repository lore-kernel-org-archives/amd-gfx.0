Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB20E9A04A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 16:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 597F010E5FA;
	Wed, 18 Feb 2026 16:51:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kbwV2TyW";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010001.outbound.protection.outlook.com
 [52.101.193.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D91110E5FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 16:51:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMEM+1dq/JPCsSmONDOUGJ4fN/TQkt41WoUXm040VKJtQ79GGFEz0WlBHnjrrPVq3uOHfNueuAEaj2eJgVTpGgV8NmEIpfWFW4SbxHnrb2M5qVLtF7pRXUwcZCFEVE27us6U2Wlm0sNc6rqt0KWZLCJKSCARbfTpQrR9YOfewh45X11NPLZYeghzKtxnIW4T3jiVOK9QGTAG26rrxm5SMQS0wMiG48WDDmMccAjwC/nZPQkZOMr692+ZwxFwhIEKyiKWFCAbvcSSolOjm70WGgoYaFX51U7QVddGRGyIS6IdpLkCb108IZKxyg7bx8dXHpKLBELKV3LDLA5K9Fib0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdFZNSjm+hjKhRbE8BTthrBdOzvkFj6txNg1lsmZGB8=;
 b=cW7ps1MBM6b+DHVljmvmvb0ToEiKXYi7Rg+LBiYKCEseJDa6jOuiJpCblUd2qYB72hCf0NH/s1uHxW86/Xemsea/xHHCGI5wGzEHG6Aat7yKZQStL3d83d9YuXl18fbwB/CHRiF/qQW4fHYH5tL5DOzUWXC79p8CLV0/1KxUafRwteuVQGDAzUv7RCvQzBiTlV5fhVrYN6taru3lwm0RbMTubAU94ypo7/7PhbKyrlsp0Rv3eE8j8JDF/1PvpYjKmZPeEkC8C/zDOn+WMmCbirnZpNUIPn+XOeSrVE4hV3TGntHuxYTs3kT6/A1zLbDVEGpgmUoygeaHYGlUcWQ3wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdFZNSjm+hjKhRbE8BTthrBdOzvkFj6txNg1lsmZGB8=;
 b=kbwV2TyWkU5yLK6rjTtfaHI7ni5F1hCcu9/7MQxLfiUhvbBC2Nf8hiizwt2V+4zg5kG5ABuPytmqJ2n0NbQf8l1j2Wh+BLfwTcoEMWovsXzBnOjd3t+LUyngfE5ngkhHgo5z7ZgC4Stor5buaMNRo16AJhRaactEREkxhr7Hfbc=
Received: from SJ0PR13CA0137.namprd13.prod.outlook.com (2603:10b6:a03:2c6::22)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 16:51:25 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::d9) by SJ0PR13CA0137.outlook.office365.com
 (2603:10b6:a03:2c6::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Wed,
 18 Feb 2026 16:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 16:51:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Feb
 2026 10:51:22 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Feb
 2026 10:51:22 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 10:51:21 -0600
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 2/9] drm/amd/display: Fix cursor pos at overlay plane edges on
 DCN4
Date: Wed, 18 Feb 2026 11:48:03 -0500
Message-ID: <20260218165116.155001-3-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218165116.155001-1-IVAN.LIPSKI@amd.com>
References: <20260218165116.155001-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: df0c91f6-9fe3-42a1-44e8-08de6f0df3c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0efeRJzgWE7fukV0txjgII8AWO3gvRC/9gsvsv8ntx0V+M78KDV+/wHY38ds?=
 =?us-ascii?Q?WW2inEYzwhJ338xY4fGnYLrysrYCW1C5Q9ujYavEoPxEqa0ZvxggcQYiF4Ow?=
 =?us-ascii?Q?zJakWCJL66PJxLP7QYmtmfU+hQn0pl3uGgS87IpmzCqyXAR4j6PedUltHnGX?=
 =?us-ascii?Q?NhJRvLaiuOXR0TiKtte8yjdTfeqE29Ni3lSLFv1MvpUKoEYJpnwxW2wEMwFL?=
 =?us-ascii?Q?CzFmpI5uAEe533tzmkGLd8dldqsXSd733QHNx7ifAezsOz6/oKjAvMg3UysV?=
 =?us-ascii?Q?a2oxMAkxY49O3D6sio1q4F0pm8kT3LkNv9HVAPd7L7wACAO4z0U7M+aAycFo?=
 =?us-ascii?Q?EHncJIDYMuz3GyQlCgluD5GuaRJqdrfv0M5MhbMXtHWYcbfeKv4WBoYaOOmm?=
 =?us-ascii?Q?7qghXgMviUUAeYhS40TUeA6jodqRXbCQngKkXz86dUuhs5J4tKd7P9XYIgEj?=
 =?us-ascii?Q?n7zXdFcLmAJgZwjKz1hErGBe+Ueb0N//vXcJUy9ADiAtH5jmjHKTm6Q/F2QK?=
 =?us-ascii?Q?USx/nvryNCeTwPBXlnFdCCWkVam4MgnmAqIg8ZfO46n/eN2fl16O8VPbdbBN?=
 =?us-ascii?Q?WgexkOQ7zqcN6Ejpbp7fNxLpa32j3YxUhVmh0giPxd3Jw9hA7HgvQ8w93pvb?=
 =?us-ascii?Q?n5lzwVmqZ02qQTKxm2u9x8Vp7M81nGu1v1APZMzuTQCJOkNDgLDfA0Kdb5uC?=
 =?us-ascii?Q?XUN5XcyhyPLAnpumWvlfaO79+fKKDPUQjaLgE0+mCj89DAbxpF7aNgflCVFD?=
 =?us-ascii?Q?9kPEEGTKN/+tRVtSg6Bw//YxinnNf+1HXHJiJY4eY9EvvugUjtm4HWoWQ8W8?=
 =?us-ascii?Q?cyw3BJunVrqAWYEok9KQCNUp1qV7ic5WJk5h5G62GAnd+J7N3ZzaQLVlXZBv?=
 =?us-ascii?Q?yGlOgxBiEJqs5Y5PnpV30Kxs+B5+bzigtVP36Mnsawy83lljYd9hh562JtRd?=
 =?us-ascii?Q?LX19ZIT8cX+pMkngoUcTN3js1TfFqK1MSd50vH4YryyecEvjojBJmyJVZVCL?=
 =?us-ascii?Q?GFckEpNc3d/x2p85nl06i3+EHGhyfzTCoI7MXq1Dsv4GMYNuU30WQj5slKlw?=
 =?us-ascii?Q?Ygtna42axaZK9zEAuPPToubbOkVFJy85kW1wHfWqIvLNKkp282EST3lgKZ69?=
 =?us-ascii?Q?kZibUbXTDsN6BTCDe/uWc1rBl2uENZAcU1uHJc0AfF32IVDe80j6GULTT9EE?=
 =?us-ascii?Q?MtbmPbkA0gPoGM5jacNu0eDK+myfk3pVjo0swQwUs20ewbS5MP9Aj1QKycNZ?=
 =?us-ascii?Q?LqaMmGFi6UxU5YXio1q1aujyLTXmIhRUWziJyyDGzrBs1Ep5rF6AH9VgPLxN?=
 =?us-ascii?Q?4BW0i1f4LMpH0Wb7GXPrH3Wk+wX6SXGniOiOxJv2m/legYD6Df9xUwDTkGmW?=
 =?us-ascii?Q?5VFxarX54TeosWPUjjzgD5seqzaBTCCuD5Fgahhd4pa95ZoeGwU3Rx8iKI/5?=
 =?us-ascii?Q?12ru0cX8/0b44r6FOJ8g423b5zBsWP5A6bTTYG/spcXBKABII4aYSv8BKfBp?=
 =?us-ascii?Q?BN6pKDwvM/a5JUpWi7kxcva0ctb5JSxtxB2z8Ghv0zuWFSp2BMmIIWcmIx+M?=
 =?us-ascii?Q?dDEtDZm/iXGw4zu4TtgXaSdBXqeqHUCC8MJvEYQYOcqVmsTFkuiJuF5SF1fd?=
 =?us-ascii?Q?LyTFdgbxdcisX0x35hOI4vwnrFphmCsUB7vtM8CybzoVAnz6qNzY9PNo4rgz?=
 =?us-ascii?Q?CLpkJQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qsdgpjFRsPzGNTU8QlV08ZpfFBnnJCrN8tgRSefrgDh83Ty0JSG+JYgCd7/TGUlcOUJmQkk7LxA/F7ppLUc+SKKiJyNZ/T9UDi0Cmh1QQpJRxvhGf5PnLDGG7FnKIsn2WAC8n7y6tc+Bja26/sMoSQ1VNqevjLZNimFV0tplSLb0bi7ndzHKMd6dhSo7pjzPk6c+HSIt5i3s94PhFeRhPenUeSJkAocKiRgT61/p7fhKZ9yh8mcmRjdbd1bpkQYVfQxgDIK1SPwTJd3mu5VQ0cR5l7SHRVYl/8midqIDxKgq8pQtZQyi9nXDU5M6q8DfoOQRbDra7eogdxwIqApCCqtLdSopBNDtnv5XzjFWvJlrfvmAlJrPVS1xli33JG2XuFd/0cS27PO2ODlASLi1B0eY2IDbJPu5u5O9rqcVEsbcSZYZ1/bHbHtcvvHQla6z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:51:24.6650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df0c91f6-9fe3-42a1-44e8-08de6f0df3c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
On DCN4, when cursor straddles the left/top edge of an overlay plane, the
recout-relative position becomes negative. These negative values wrap
to large positive numbers when cast to uint32_t, causing the cursor on the
the overlay plane to disappear.

Fix by adding hotspot adjustment and position clamping after the
recout-relative calculation, matching the existing ODM/MPC slice
boundary handling.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index b91517b9fedc..f604c30e8493 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1202,6 +1202,25 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	x_pos = pos_cpy.x - param.recout.x;
 	y_pos = pos_cpy.y - param.recout.y;
 
+	/**
+	 * If the cursor position is negative after recout adjustment, we need
+	 * to shift the hotspot to compensate and clamp position to 0. This
+	 * handles the case where cursor straddles the left/top edge of an
+	 * overlay plane - the cursor is partially visible and needs correct
+	 * hotspot adjustment to render the visible portion.
+	 */
+	if (x_pos < 0) {
+		pos_cpy.x_hotspot -= x_pos;
+		if (hubp->curs_attr.attribute_flags.bits.ENABLE_MAGNIFICATION)
+			adjust_hotspot_between_slices_for_2x_magnify(hubp->curs_attr.width, &pos_cpy);
+		x_pos = 0;
+	}
+
+	if (y_pos < 0) {
+		pos_cpy.y_hotspot -= y_pos;
+		y_pos = 0;
+	}
+
 	recout_x_pos = x_pos - pos_cpy.x_hotspot;
 	recout_y_pos = y_pos - pos_cpy.y_hotspot;
 
-- 
2.43.0

