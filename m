Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B940DD5E15A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7092210E0BF;
	Fri,  8 Nov 2024 11:15:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="opwy3Uew";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 692BD10E0BF
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJXwSI73vx5+PP20R0ECJ48kwEE8pBUt1VbZn5GbMmevhCGvz+l90ZLqsqOlnINeZOuWKsFcjBQ3IbtlC34+WlG5Dq7rQNYkAMdYti9vw5IovwpKWWqPn/UhHCOguWJLqyepxGOGBBaSHNOgStRhk5oFsJ1RvVcrLIl/p6vDkA3WMWL+XtnNth/VgcfMEBbG3S00/9KWpWKb5a9QfNgkbd4QcFYkYOnca51fXRoTcyshkvlQF+EMB2wJGSIPpCkOktBlYaWmXna2w0l2U4zZSjShe+XPmcbRXJhVp0nUq97Qzvp4nCtCYNFGvmumA4d76zCL64WWGszgHNpOjFGLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39cdlBGaW6WHGbm1FB6SCVJpcTUFMnZwVQO12yLKuRE=;
 b=JJ1jJC0notMtLkg7Qe5AgLncnQ7PrwwEYlYMRe4G2XERvI5vTWvscJGbURizub4lqvfIo6ekCLmWHMijQak7Zwm79m6MwRz4CBA2xHvHA8dBbX2HJfhXgI7C9cKgBlqncGhv2Yb/FH40MkCmMf12xmbCm5CBpb2T4xJBryj9pN6ATBYG/Cues7Yb7yz/F5P9kPwhxbnT4pNtcHxGTs0QEBaE9ujTrVz/voe14nQGXYZbRhZCADoHzey+Y6oPJIhWbvxPtNh5A70kDnoKqE9mH1COI8u2NavFpEoZK15JkrKVumoDbP9JtfS/V3rn42Mh9yX5uehyYeNzHExnQu7lsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39cdlBGaW6WHGbm1FB6SCVJpcTUFMnZwVQO12yLKuRE=;
 b=opwy3UewtN444fgA6uPJx1saRhwItI9NyDl3KssSA2zj1msKK7fAvKAH3Z+b5ips2+E2UHAb7km/kC5vphQQAAr5K6W+IDcOqQwAhe1oLcZTaMbPGh9RO65raPhluvOuo/9MCQM9mu8H3x0w4pPeldg71CnI48mXNyYKKXJUYG4=
Received: from BN9PR03CA0261.namprd03.prod.outlook.com (2603:10b6:408:ff::26)
 by IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Fri, 8 Nov
 2024 11:14:56 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::34) by BN9PR03CA0261.outlook.office365.com
 (2603:10b6:408:ff::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:55 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:53 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 19/23] drm/amdgpu: add ras_mca2pa to convert UMC address in
 legacy way
Date: Fri, 8 Nov 2024 19:14:19 +0800
Message-ID: <20241108111423.60169-19-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108111423.60169-1-tao.zhou1@amd.com>
References: <20241108111423.60169-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|IA0PR12MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 5770f60e-5d82-4471-89e8-08dcffe69357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eahZbTbQAWnl9pqvqR/d+Ke60NoaMEBCZiFxtuF3fdulAOy67zjyStzCJj5F?=
 =?us-ascii?Q?pf0zKS8P/pXgtFtgkNyxQEI+oUs0BQFqkKqQqiWcqd0O3BLkj9IOrKvZWYlx?=
 =?us-ascii?Q?Q/woWEKyLY8Jvh7zOGwjagW3kpOHbKEoyhBhBE3dJK0RvC29ptmoq6Y6Jt6E?=
 =?us-ascii?Q?g5AVU4NIsozicavWmJeEvp8uvkrYpcMdDx5V1DyInyIRA2zD9BbPxrs/Sxa3?=
 =?us-ascii?Q?OgUem2xPTgHn5d1X3vHuzjNcM6qUUCqLy+C338c8/2CJkEl76H5/lHEb1yH/?=
 =?us-ascii?Q?ReFnkQSKqoQD0Vfr0f9OMr4q5P5HYEDsd3BmRvYcK2Adk6gL+oUn/Js847sg?=
 =?us-ascii?Q?RnoUU3Iv5wklTQidgoZLiYEd1WvcMaJJ2+zyi6QU3JVlMoHRQ8Z+XUZ2rIKJ?=
 =?us-ascii?Q?dFIT6vXMeHiYpMUCoaoisM3r29HrvHeAqxneRjj2vxVDMufrQDcpeaqSKc0U?=
 =?us-ascii?Q?SLYKWjKzfInWP/fcUrggAQVPyFEo0uTyaKE/QcZIQt6TgmIDiryTEMRNHNQm?=
 =?us-ascii?Q?DnunJujB6K0qQ/T//E3eRxTSPmpf4+/qRnq0PLZXX+J9yByZxVo5u1OrNtO3?=
 =?us-ascii?Q?4pyBVhztro4b2T7z2tclHglppBW5yh9dGuKIO6yOpSPyyTSjnK1mRAmS8eKp?=
 =?us-ascii?Q?tH6CS949DCJqAhTh3Hu/qIzZJ+LWpu2Umax9OV0EhXTfmNQSr5dKTLHbmwTk?=
 =?us-ascii?Q?CY3jLfiV4FObqHpy5zbOjEmf9TeoCOcHf9w+bM9ObLccDSsz213cL9aFCvP3?=
 =?us-ascii?Q?0mBFSNYXFNGdMdDaOwG3Z0aAbgx2WiQZXnr6P7e50GcS/oP8q67JSvIopdwp?=
 =?us-ascii?Q?N1qSa/vzPe9i0IgjilcZ79SDNnMbutHgQH8YeFDnJSGKt3J5FgcUAvKsRZRg?=
 =?us-ascii?Q?FIdmHct65suVkZEU4QzM4RXr/EdBrcY7HJxVURU5MCVGdYUFj6WFey+Zn++p?=
 =?us-ascii?Q?lbpZ0xAkv/0Dyp4oqoF7SdUjhSu6XBi11mY9KN9Kb+pR6xHbwoKGIVDMq9WY?=
 =?us-ascii?Q?HYm8cC/+LjnmtQtqoG1GGW+cPG+XEkxZM+W07g1FLvTKWxZQhWk4vss2uVTD?=
 =?us-ascii?Q?om1Iht6cfuLGaJ/Oo7EkhPrJ5TrFn90XLw/jfcoY/7Nc7sxn94+U41E46N7d?=
 =?us-ascii?Q?UNRbZDnoncNF9eTx2etmM3y9nVAmGpZGh+9kTup8Pm7CHk/JMT4yRTi2pEn0?=
 =?us-ascii?Q?5fIApVvgAOwgKbc/3gJ44Pk1w9QQRnYWfV6wT49eHEfxug/suYGrCWAy4L1C?=
 =?us-ascii?Q?EJlzuLSs/AzHGn8GbJZ55XP0nOOti0lorEDgoG3rS5hVjh2dN7eAM1IwcuYw?=
 =?us-ascii?Q?Vfgict1azBGEANDRuhkvmq1ig+PIfwuq6L/i5FhBfyU5QPxv4M0H6j+wC82X?=
 =?us-ascii?Q?kBXj6DwmxATovlHHdeS39ghD5+KgZ+F/KKzMDWIKk+QMSSa3Mw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:55.8535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5770f60e-5d82-4471-89e8-08dcffe69357
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506
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

Convert UMC address via node instance, UMC instance and channel
instance. IPID is not sotred on eeprom, so we have to get related
values in new way, can work in any nps mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 41 +++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index bb559b521a9f..4f1dea11501f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2665,7 +2665,7 @@ static int amdgpu_ras_realloc_eh_data_space(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int amdgpu_ras_mca2pa(struct amdgpu_device *adev,
+static int amdgpu_ras_mca2pa_by_idx(struct amdgpu_device *adev,
 			struct eeprom_table_record *bps,
 			struct ras_err_data *err_data)
 {
@@ -2694,6 +2694,43 @@ static int amdgpu_ras_mca2pa(struct amdgpu_device *adev,
 	return ret;
 }
 
+static int amdgpu_ras_mca2pa(struct amdgpu_device *adev,
+			struct eeprom_table_record *bps,
+			struct ras_err_data *err_data)
+{
+	struct ta_ras_query_address_input addr_in;
+	uint32_t die_id, socket = 0;
+
+	if (adev->smuio.funcs && adev->smuio.funcs->get_socket_id)
+		socket = adev->smuio.funcs->get_socket_id(adev);
+
+	/* although die id is gotten from PA in nps1 mode, the id is
+	 * fitable for any nps mode
+	 */
+	if (adev->umc.ras && adev->umc.ras->get_die_id_from_pa)
+		die_id = adev->umc.ras->get_die_id_from_pa(adev,
+					bps->retired_page << AMDGPU_GPU_PAGE_SHIFT);
+	else
+		return -EINVAL;
+
+	/* reinit err_data */
+	err_data->err_addr_cnt = 0;
+	err_data->err_addr_len = adev->umc.retire_unit;
+
+	memset(&addr_in, 0, sizeof(addr_in));
+	addr_in.ma.err_addr = bps->address;
+	addr_in.ma.ch_inst = bps->mem_channel;
+	addr_in.ma.umc_inst = bps->mcumc_id;
+	addr_in.ma.node_inst = die_id;
+	addr_in.ma.socket_id = socket;
+
+	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
+		return adev->umc.ras->convert_ras_err_addr(adev, err_data,
+					&addr_in, NULL, false);
+	else
+		return  -EINVAL;
+}
+
 /* it deal with vram only. */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		struct eeprom_table_record *bps, int pages)
@@ -2745,7 +2782,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 	for (i = 0; i < pages; i++) {
 		if (is_mca_add) {
 			if (!find_pages_per_pa) {
-				if (amdgpu_ras_mca2pa(adev, &bps[i], &err_data)) {
+				if (amdgpu_ras_mca2pa_by_idx(adev, &bps[i], &err_data)) {
 					if (!i && nps == AMDGPU_NPS1_PARTITION_MODE) {
 						/* may use old RAS TA, use PA to find pages in one row */
 						if (amdgpu_umc_pages_in_a_row(adev, &err_data,
-- 
2.34.1

