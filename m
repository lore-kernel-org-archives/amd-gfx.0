Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D207DCCD184
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Oct 2025 07:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73B0810E2E4;
	Sat, 11 Oct 2025 07:50:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bifGbOBq";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F125110E2E4
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Oct 2025 07:50:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGhMq6NL2Hi63+UZhviFzjT3iCNhvfbrEiVg1TXTOCKrM9wlE+25E/fPRjN0eh0mTPc8SBrV4wvFNQkv+ziOhX1EFPnJjWYvp/8d7RS1dOPOZf5MWBmTZGfiSgYPXylaz/m5ACPvVKIv52ltyr+0qmWnoM1ufs77s3nCm39Ce0AwDY8p1Vgtk4cPtRvHeDVfN6qlj2d5s3Kxuo4GbIVEBDyq/BjsN1rQxZqyV1bnr5zuauPqHh/Mi7FGCuGOAVdPWKcT9Fw1BDffbwrh4x8av9MfhAByA+qvhSGcxASd68Sd+IUzRHNp1+E9TK7AZN+XHG99IN8aSvnMnxBu/BGgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2DdvYHO7uBa/umrYXoorIy77b3aBgCOesfFHXgX+VA=;
 b=nCLP3QSguwKnflU8QWtCWSow8BucttbJa4OXJSAjJi2sAPjrVTV1nONhjgwh+4HgIX6LydczzJTZ/cb+/bw9H6ZmsnDUpHPBv9rGBLE1/qvCk36i+q9s9hu0lnGP11X0TfKTCnBrP9PdoC+GWwcbjSufHQNJFDWb+pWo9kU1d4eXD8ug7tGs35msx+W7OuPfGCfZOGP9EFVGSyv3Un+B66xwKBm/pkTGWW3j8iRaAScLN7Z9JJKHypSxPAD4q+7szOFuHcypwseR4ypd1sKCAkJ9FBByvCYEprSA+H10una08j+5gqSwahE7wrQoUPpUCW0cLA8XRQgept9j3x43Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2DdvYHO7uBa/umrYXoorIy77b3aBgCOesfFHXgX+VA=;
 b=bifGbOBqjOg+8PwEhsePRmML4phd3d9bBL6EgUBsnY7l1Hc+NZ/O3zcQMQLnc471iF0zXUzkUdirp0eEFkwGllHpibr1o4L7CuUPsl+B8NdUHHDp3iV9dn7/M8TJLnRd/kkBxVxfF0XW0LrWtTdmEu7iw37Txt/o8e6q8mYK56E=
Received: from CH2PR07CA0045.namprd07.prod.outlook.com (2603:10b6:610:5b::19)
 by PH8PR12MB6985.namprd12.prod.outlook.com (2603:10b6:510:1bc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 07:50:19 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::83) by CH2PR07CA0045.outlook.office365.com
 (2603:10b6:610:5b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Sat,
 11 Oct 2025 07:50:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Sat, 11 Oct 2025 07:50:18 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 11 Oct
 2025 00:50:09 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 8/9] drm/amdgpu: Avoid hive seqno increment in legacy ras
Date: Sat, 11 Oct 2025 15:48:10 +0800
Message-ID: <20251011074811.533871-8-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251011074811.533871-1-YiPeng.Chai@amd.com>
References: <20251011074811.533871-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|PH8PR12MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb4cffc-b642-4674-6750-08de089ad2a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7p8zS3XzxVEBtR2pArIkWum7lo37C70t4/iEx+Nt7ZTh49xVNrzdcJEvBrVk?=
 =?us-ascii?Q?3cYi1k9wqANd7LKfb72YEOJVr1AH0WJex/Y5p8N65kwrqn2MPqYFXwXFs9mm?=
 =?us-ascii?Q?SUA2ta5VnugHt8LjYVMGtKQLJ72/gzMwN0LXs4QXGy67V+6mysYr78MJGv3W?=
 =?us-ascii?Q?jdrqmFE+4DHAlv+RYyOcmVKhdS4EwzXsG2DExEapwjdZ/Zv3AM02f4FpK6OM?=
 =?us-ascii?Q?s7l4ka3xdixrvKztzxGDzbA13klzPTHYqFgf1NlMv0LkxmoLVIs5BsGYxLi+?=
 =?us-ascii?Q?qYYHHJsfZ6fi1GhCSQgxEa+YYjH0zpl2B1S6h04rN469BwGJwpW/SP5NMiFY?=
 =?us-ascii?Q?DkF89+FkvSLyvxMMZ/gTXcuyxpW3geRWCjFgHOvIryRWwVzEckPcBRgqtWOh?=
 =?us-ascii?Q?/MdBqum2zuBVAUZGaH/A5XDIPE90KlO7cRdaVkEn6CZZwDkTTjtog3KQpSud?=
 =?us-ascii?Q?V0OKtn3GsNLO6h51G2tizq8TWA5HjdniPfv3l7MtnDtnUepMCv/RoYNWGOZd?=
 =?us-ascii?Q?xuYgib2THOa4tjJSZWT+6MmK0ema8oHY8JTq3/gulZmLmT785Bm7OUcphCq4?=
 =?us-ascii?Q?WxTJb7zhFLykQuMyTXZpEjtRndSEaAwbB+xtnK2xg+3y1N6fJPKChTW3P8He?=
 =?us-ascii?Q?pGQi7HkdrMsZt0tSCr5npknSbJ7/AGFKvBbh8sbDOn3nKKlVcZkMJUqSf5lB?=
 =?us-ascii?Q?gn8c6H2fBw9gmo3dOC60WPcNeI1d1DjsFlUbyht32XYgIhZg5aIrmmGS+vlk?=
 =?us-ascii?Q?UANjAOi0xFm15hMQUBM3yhoY9RTq6jZUs4ZnnW8T8memfecP7Kj7DkUxIoYQ?=
 =?us-ascii?Q?gyPiszYck3OVvfRA3pTZPAB0iIE6JfxXDrFl2ZUC+onsK/gCz0VEA0mJ0SxM?=
 =?us-ascii?Q?WRITFYWXworJRQ4IUTMLBiOdbcTG2/XDxwLKJGuXD8x7Lp9M6W8KHtSofzzU?=
 =?us-ascii?Q?JKhemvMD9VG42EZ1Stz4p7sQy56MVXZpHPEcPyPNqzk5VcnDeKnp/+5Z0jOS?=
 =?us-ascii?Q?TvZzYVdRvLvVG77jlWEVmJSEbZUMavC49ymAq0IhnLuFbMRI7ri2PJteLF+K?=
 =?us-ascii?Q?z78JkuV/z0LhLDJda1o9zw/4yvWm+IUpGsLsJUmJnn2p+7wm8l2wqinwJTlt?=
 =?us-ascii?Q?3T/SDG/PWOjmdH6y9VMUUZ04i9sNENj6r8rULxlRU34eHLR0LTvy7/FbXD2B?=
 =?us-ascii?Q?VxrAf9fWgQ6QpQk+sVYMCxbJg+LeaWzBos/0ULUGNp2c6jaFrpa7oCQkNXE0?=
 =?us-ascii?Q?EXZs8gxiYps5ThOGrx2WY2nI5/D/xS/alVCC+ycGwJLwYma6zvj1WG31BEmO?=
 =?us-ascii?Q?j7KWg26R3ffhEwHba6QeDRBJgsotry4YAFo+w6tKH4cEckBdorhqSqx++b47?=
 =?us-ascii?Q?+hmP66NxVLgdhHoqTIViYlCez7/lnHW1gPFJ5sTNDo1aHiWIRVe3FX4uysRk?=
 =?us-ascii?Q?nHUxFvC8w431ObVGcsPUFFHxd2TeLtBlwVpTjety7MVERD6UBjMSdFL3Hk8t?=
 =?us-ascii?Q?kk6PIOO9GFQENwnd3jJDNPxscOvAWEyJt0qYMacf1WV2+/gq2dqEnvuez3/g?=
 =?us-ascii?Q?kVJ2uZhZrw8RDGPXKfc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 07:50:18.4953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb4cffc-b642-4674-6750-08de089ad2a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985
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

The hive->event_mgr variable is used by both ras module
and legacy ras. To ensure the continuity of hive seqno
growth, after enabling ras module, it is forbidden to
operate the event_mgr variable in legacy ras.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c0e6caa75319..d69ada9e8208 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4603,6 +4603,9 @@ int amdgpu_ras_mark_ras_event_caller(struct amdgpu_device *adev, enum ras_event_
 	struct ras_event_state *event_state;
 	int ret = 0;
 
+	if (amdgpu_uniras_enabled(adev))
+		return 0;
+
 	if (type >= RAS_EVENT_TYPE_COUNT) {
 		ret = -EINVAL;
 		goto out;
-- 
2.34.1

