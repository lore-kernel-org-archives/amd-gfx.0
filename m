Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E018CAC58F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 08:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FC0B10E33A;
	Mon, 15 Sep 2025 08:02:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YLjGsuVq";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE6B10E33A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 08:02:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brrNr3GBTcwxknJ5GS1diliRyIdo46O++WMZYUcSRL8N18Ap9cqXXF1MA0jD1zrSLc3OMj77y/2vWcA4begZsqzwM+g/nBE3jPUKUnNYkNFnbI86TbuBVEq1T+4r1YN5KuDeMnGlxKIEdEfdWYgX4oyCpkDlqEhcaf/fPTC3DFEjKQuAdkjb0OCg1zBJlFEv5DT6cmR7tnQDmDvoz4yvkeim5BpUgmhq2fgDaTqaMSsMaZWNiRgxR6qZxsGUHRPRcDdPyKt/GEgkRlCznlSPMLaYUXegW/Z0TAIYXk1Co/pErmx/pCbvNKUjk01GR69Dwf3Ug8wic1SDvIlS1HbjQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXYkKeT5lICZWznz0SBR1vgAhdIjjpUL4zR7IdNA/4o=;
 b=tm+q+p6YHxaWDoexteHv1cAIpSaTFKNVcwWDdgswT3HHLUKvyvo7KNxI7gsiAh0gpgMjzOusn+knkVh+P8N6tO0gWQsma9VB6w1AGx5uXg9tdqhpoK4M6+5nn5bML3zYXdpfu2wRAnLAl8HnAy8CAHTzbKrVTqKhGWK3cB2DpbSDB+Peg4GjxZl0oL7mVIGqcROELopMBA0WnZWsEIUWpM/xrHE7eE4Qr0081xpk0mKtNF7J5xFIcJAxYk2L9AmxrdhB/jxs9661rNZTf/p0Y6OdqpItypEMvEYapmGDbWtFvhJnYYopiRjUCJeB/ln2XWZXsspWK/wdbBmC/w8cEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXYkKeT5lICZWznz0SBR1vgAhdIjjpUL4zR7IdNA/4o=;
 b=YLjGsuVq6cTMEN4NyJthCYvGWooeOM2XkEB7u9dx85LBORjRywektEF2ZCq97xIoVf7gvX36RnZl8dXm+huyjbfpvDC3vHk6Z7r5Be7PAawHSvvhJuiATezhMvkQBeHT/7ysFqZbrVKO6nNauE7lDhX1fKje1gB2Ik9OCokXMWE=
Received: from SJ0PR13CA0062.namprd13.prod.outlook.com (2603:10b6:a03:2c4::7)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 08:02:20 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::b0) by SJ0PR13CA0062.outlook.office365.com
 (2603:10b6:a03:2c4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.11 via Frontend Transport; Mon,
 15 Sep 2025 08:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 08:02:19 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 01:02:16 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v4 7/7] drm/amd/pm: Update SMUv13.0.12 partition metrics
Date: Mon, 15 Sep 2025 13:26:36 +0530
Message-ID: <20250915080123.3024297-8-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250915080123.3024297-1-lijo.lazar@amd.com>
References: <20250915080123.3024297-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b49d67d-25bd-453c-a8d1-08ddf42e31b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SFTTs19VXNeV1utT7KXIAtVEmTLJDet9szT05Pbq8PiWlkBV0snbSIaXoa0O?=
 =?us-ascii?Q?+/txBxmKAZpg4cH/5DfijSTYADWwtcvka3ojo3KmgbtnusLQT64xPgxxlc9J?=
 =?us-ascii?Q?lH8IgPUjsDIqyjbL+EXXRt58Rl0mA7u7ejKvatRracpFbSnGOyAvuWClf0AB?=
 =?us-ascii?Q?zpRLRjFtFNa8r4fE+H3DfSibpA12bL1osBhTfi82pTjrWJYv7kL75xIN92XS?=
 =?us-ascii?Q?MTwnHSUsQwi792AmTvCSvFM3Rw99dZ/HrrPJ9Pv05eVVkleeMx3vdxpQ3179?=
 =?us-ascii?Q?KtVYH4bwlkbE2zUQY/eQAaaJRgKE8jgPoiXgDChrTh3x/CKFrEIV/QfyW2b3?=
 =?us-ascii?Q?pvQ3zWJUjAGmUrHuvuNRa1aN5oXK2KK9hJn10YJ7pxBGJLmp8DOrOanRgmyz?=
 =?us-ascii?Q?/mBFgGrXTaPBfQCkaejRXTmWDZmdzfnBoqMKCRS8afaROOgVHLwOWUerLvcz?=
 =?us-ascii?Q?u0uhpVV5eLeVyDHvYqMY9ZNuk/gZaoDwSK2SdWpP7p5txDczSQ7PhpHBJwe+?=
 =?us-ascii?Q?1kh8EO+1lMEvXAqqKzkLIiAAlcSpK5UtJ31IZCiC3Ru+Mfs1lvXUbiHkC6nE?=
 =?us-ascii?Q?8RTKOanXonvkPKgMLBU89xZ+WTUyOLreY1HCF7IHeJRaGViU8mgHwdacaOcj?=
 =?us-ascii?Q?mIvHFCWqpKVf6V/+kdiMuH6b/eR8GVJSu5estI7OJ0pJe6fDv+Sv6jciW0y9?=
 =?us-ascii?Q?2Z0Kc8JFsY7tHkuci2kylEy2UQiEQa1p1IkeIGyjq/9JTiRNBQZMXl+0zTSn?=
 =?us-ascii?Q?B2E/koegxq4Ne4SCoAM4RT3q4L9CqWQpr0UCvnoC+1xd7PEoRFZJ1Wy/P2Zc?=
 =?us-ascii?Q?kpnTZVA72y/aPaoHE46pwHTWQptj0i1xqMmKlH0qGWdswyFC1Pfz9B+H8bnu?=
 =?us-ascii?Q?qh3fAJkdsnUnkV0jRVtsYLyPeO2tjxgUIZyHJDbUSyi3I4UgGgwPzuZ+Lvog?=
 =?us-ascii?Q?+yFcw7tvMXrlSoBQLGCLq1+IwcsyI2xxThgxI+9P5xvnGtoqdQ1D+duXQL75?=
 =?us-ascii?Q?aTKAJKnXrKXMY0xsfkygbPCgqVloN+PHPmG3eYjJTVwZRpgEBCq5u/tVXiLU?=
 =?us-ascii?Q?7CFcPnWtexg80cxzvVMcb72CXO1OkCSFefgEuCN3hrdGGkfYs3m8jwKZ1K78?=
 =?us-ascii?Q?rnPMMJjUPeLuqVTQ1holuAJc6/vx4WoZoUwnBtNyvcM7r0N7jWEyFKTFJulQ?=
 =?us-ascii?Q?M/STk1HnrWfmibeekNcdVXltlXoNRbnGVEudc863xf+2/QNNRLcbx38P89de?=
 =?us-ascii?Q?yc7dzfXhvXti6hhDp7MlGQ38AmryuDskphfc/Q2fI9gvwIpry/WaRFXWqbgD?=
 =?us-ascii?Q?/PxT9dZQ/KdRmkplmI4+RWDa5/4bvxurf7jiHiTsUxDRfNkvAJfO+FelqMH8?=
 =?us-ascii?Q?FxGznBer4kl92MGZSi08fM841Ya4PeBVBK53gX6WKMZwxFR4uqTiaZJipp8F?=
 =?us-ascii?Q?irRJJDBvvHpsdu32UJQY1rLo50m5+uaPXpm+DClj17kb3tsqqTb03DjPhJqt?=
 =?us-ascii?Q?SZDT85OiJ82fXU8siRWdvyOcznnqoIr7SpvW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:02:19.4598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b49d67d-25bd-453c-a8d1-08ddf42e31b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
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

Update SMUv13.0.12 partition metrics to partition metrics v1.1 schema.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 09f1e4072db6..2cfc221dc3bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -671,15 +671,14 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
 ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu, struct amdgpu_xcp *xcp, void *table, void *smu_metrics)
 {
 	const u8 num_jpeg_rings = NUM_JPEG_RINGS_FW;
-	struct amdgpu_partition_metrics_v1_0 *xcp_metrics;
+	struct smu_v13_0_6_partition_metrics *xcp_metrics;
 	struct amdgpu_device *adev = smu->adev;
 	MetricsTable_t *metrics;
 	int inst, j, k, idx;
 	u32 inst_mask;
 
 	metrics = (MetricsTable_t *)smu_metrics;
-	xcp_metrics = (struct amdgpu_partition_metrics_v1_0 *) table;
-	smu_cmn_init_partition_metrics(xcp_metrics, 1, 0);
+	xcp_metrics = (struct smu_v13_0_6_partition_metrics *)table;
 	amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
 	idx = 0;
 	for_each_inst(k, inst_mask) {
-- 
2.49.0

