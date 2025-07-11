Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C9BC8303C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 08:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9727710E3A7;
	Fri, 11 Jul 2025 08:21:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fqsR4kEX";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06CD310E3A7
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 08:21:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8mUUyuiXbFlDK/be8OsK8Uj5o6RJA0SqaIYlu+G8bbecqqkQwZRH+4/d2jK4W6icwGsgZXielgmHYhG7gQTUpjbkMpVn6vm/y//ae6DXQc8WI2dRaGwjHGVdjc66ECrMp8oVgCszHH/ICIa+T0jQ/gAK2ZSA3cq8ulrjeLICRMlJBgcwDTxbjw0szBRhGabRppWDoYk2jtPlBklHTFeuuz1QUG4O2KtkM1KG57ZlSaHKZTOXVyIjYLKWQqKVed/ApVzLBPwlg3gw6Wr9FYWdGwuh1BG4KH4tI9vTI80hVr8dkRHVJBXQL9oli/5nzmgPbPIYldwqTh9+Rvtdlrprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OYw4myF04k1kJZ6t04pWNg16gHS34R7eyNgO+msNQM=;
 b=xKKXukhY40EOxU0PdaMs0rATSFORClN0iO/Rw0GTm0ruKqcdCw3ohbZHxY9OG9MFvPAJKE94f6X4KWNai45Bb4HLdKvZ+J23nyQAN9HPraA7+t36hoyxDzYfjtv0n9wH3ox3xM9AMeZWp5EQJJ7w3+zoS1jZWQt4l5sr5daTxc2NbCEdz+H8CAPkz0jCm1SGAvgsHJJhTiwYul9mEjsT8J2KgIP3RqsaBfyfkD3rxQ4yWxIsuoNAcNL8uy5WAiyy6fb/VkUmG2J4j+0GVWhKqIOC/8D0MKWsCQr8vuibQTTYIVusHAh69tKOFpIKQ6cIaTDHFuooQ2NQA0B3Sbeoxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OYw4myF04k1kJZ6t04pWNg16gHS34R7eyNgO+msNQM=;
 b=fqsR4kEXwLaQnH3EVzIS5rpstLUmQLsHTH8Cgd/e6naKqB9vdWk6WzdHkaEntcqJIYfY3Lch19cfLq+R37OBY81x8HOLiM99elyFTYPtfxtbiwNHuWLVD0ugSufDwTkw6nAjIZrxdaMjKtlwKMEqRs5gebQW5n5eLBJdZgFvYxY=
Received: from BY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:1e0::33)
 by DS7PR12MB5838.namprd12.prod.outlook.com (2603:10b6:8:79::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 08:21:12 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::27) by BY5PR03CA0023.outlook.office365.com
 (2603:10b6:a03:1e0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 08:21:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 08:21:11 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Jul 2025 03:21:09 -0500
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: refine bad page loading when in the same nps
 mode
Date: Fri, 11 Jul 2025 16:20:51 +0800
Message-ID: <20250711082051.29344-2-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711082051.29344-1-ganglxie@amd.com>
References: <20250711082051.29344-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DS7PR12MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d8aa9a-fee3-42af-c8b8-08ddc053e52f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HeQMTckFHi118CtwPGbJYohE9n0gEC9U7GdPs2LEF5Oh+ixiNP5ihLwGvZJo?=
 =?us-ascii?Q?alp7ea7kKcDoff6Q+NBGSk+Ugynu4s7ZXwNfT8Z4y6WbFnTA/uHdtc40nnbF?=
 =?us-ascii?Q?grp4CB/HY8r2LrogMcgvX7XUw0RPUCANN0J1jfNGsATEk21hTOe7wXtpNB9F?=
 =?us-ascii?Q?euvAyZ0gJa4w2ObU8qQFl5AY0d5o2cxhpeIib4Hw8K+FQd0Dl37lyv/wKZgS?=
 =?us-ascii?Q?qtCoirgpgNHg0Dhk/l8h9m1GaWYUt4FQvoRUTudgrymzEdhBu8Bqn3ZzjCJo?=
 =?us-ascii?Q?zjfC0lt7LYuGWtSxKWJAYwPILHUC+JW71lno5BHdBWH4RFYMELb9wCvw8wvo?=
 =?us-ascii?Q?MGOhaXNKUcqrHaZ1RHQpDfNEhB9wh5PLnlqTiuxJMq+GIRw7IZfPrBpfcySd?=
 =?us-ascii?Q?R5s0vdz8ndtzUukmNE5lvi8jPIZi13HT70Kf9lQxvsyIhjpozN3o7alR5bl6?=
 =?us-ascii?Q?VJQ8UClIwaVqRPlukpQjdWMvH7/PF5modZq2j4SR5jcgh9BuyUlXoZt4gwCV?=
 =?us-ascii?Q?HuHxJAM12Ls95+v4nnqxyxSTzgTBJ9MNoWwbiDmVkP3IEKJedj8A+6G+GHYk?=
 =?us-ascii?Q?SR2dn8yeGxUv8bj6h6uHVw6QFcJCA0FtKGW8ROYCAEYgt3rRxxR2fR2is9q8?=
 =?us-ascii?Q?KsgPeNeKNVxVDaNaAA3q+wpLTJFKHFgaZ1BFglyaXAAZENSFffnI3UZSXkuZ?=
 =?us-ascii?Q?omJLFwC6P2HXVtpK1GJ5KbqpxeE8YDXn972PwHXulFmtPGKL4igAksW8WM1B?=
 =?us-ascii?Q?R+gnicldn2CcO+hxpKSayxIDAAkGOI4B/ffgX7p25J0oKvlSggpJk/2V0V7Z?=
 =?us-ascii?Q?Y1465KzexKFTfHhhze/DCXpGIaC4Ap4zKABwM3X5jsnJpHCKKcCkDKu/wqfh?=
 =?us-ascii?Q?wQQNKbWFzB+NLRvprSMEzLkhmAh1DMvBdsTwI8Pn7wvefMVB/7Fa2zT1ebjE?=
 =?us-ascii?Q?fI9EWLuNP587ZoGgc6OWWu0Ix+P+zGX3BWGvZo6r57OdADZqyWqLH5YvPHaX?=
 =?us-ascii?Q?GMIlHpcVnpYLeFbbR9Tc6D6c1wnPvqZFW617bRkUjUsLiUQQ7jWMsCv4yVeY?=
 =?us-ascii?Q?gBXld9RqpG5V60VBytFTbqtNvqyJgcOqY54wKzdbSHjEtENZpc2zB9w9xMnl?=
 =?us-ascii?Q?QCMaNayEQ+h1AuGnpFel20FJqAuin7QWtkPAiWIdVh0bJZ5T4qtNrOyuFfU1?=
 =?us-ascii?Q?4Efr3MSyyj2u2DlbXMbSlzF6cOwmDnc4jtF1pv5yv3O42BH01QA8tIrLjRU2?=
 =?us-ascii?Q?N8wP4RhPALUKujx81QmU2anOcG1PwsoWcI+btTooXU6Ht682GCLngjZs3S+l?=
 =?us-ascii?Q?MR/D/A4WjtsGqV7bwc7MQlLeqgNfopGJXAbjsrTWW868iXgpb134r0YdCgdA?=
 =?us-ascii?Q?JaZ8aULZmqPWFmwILK2g9Z1lthfgvu/QOrOwOj7oPOuu5qL0HkNEKWHg7oqD?=
 =?us-ascii?Q?oXrUD4a0DIc2jbSFw5HNPtxlB1HYMtXXIFnUTLmUDjY1P/gojFIl001KfBaX?=
 =?us-ascii?Q?eiG8QFeE4iFUQyfQf0kRsZ0cAycKh6i8Jkl4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 08:21:11.5061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d8aa9a-fee3-42af-c8b8-08ddc053e52f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838
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

when loading bad page in the same nps mode, need to set the other fields
fields in eeprom records manually besides retired_page

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f8a8c8502013..94d4639c68df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2860,6 +2860,13 @@ static int __amdgpu_ras_convert_rec_array_from_rom(struct amdgpu_device *adev,
 			if (amdgpu_umc_pages_in_a_row(adev, err_data,
 					bps[0].retired_page << AMDGPU_GPU_PAGE_SHIFT))
 				return -EINVAL;
+			for (i = 0; i < adev->umc.retire_unit; i++) {
+				err_data->err_addr[i].address = bps[0].address;
+				err_data->err_addr[i].mem_channel = bps[0].mem_channel;
+				err_data->err_addr[i].bank = bps[0].bank;
+				err_data->err_addr[i].err_type = bps[0].err_type;
+				err_data->err_addr[i].mcumc_id = bps[0].mcumc_id;
+			}
 		} else {
 			if (amdgpu_ras_mca2pa_by_idx(adev, &bps[0], err_data))
 				return -EINVAL;
@@ -2891,6 +2898,7 @@ static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
 				struct eeprom_table_record *bps, struct ras_err_data *err_data,
 				enum amdgpu_memory_partition nps)
 {
+	int i = 0;
 	enum amdgpu_memory_partition save_nps;
 
 	save_nps = (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
@@ -2900,6 +2908,13 @@ static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
 		if (amdgpu_umc_pages_in_a_row(adev, err_data,
 				bps->retired_page << AMDGPU_GPU_PAGE_SHIFT))
 			return -EINVAL;
+		for (i = 0; i < adev->umc.retire_unit; i++) {
+			err_data->err_addr[i].address = bps->address;
+			err_data->err_addr[i].mem_channel = bps->mem_channel;
+			err_data->err_addr[i].bank = bps->bank;
+			err_data->err_addr[i].err_type = bps->err_type;
+			err_data->err_addr[i].mcumc_id = bps->mcumc_id;
+		}
 	} else {
 		if (bps->address) {
 			if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
-- 
2.34.1

