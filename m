Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E41D5E15E
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37E6A10E968;
	Fri,  8 Nov 2024 11:14:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zjy9Rk7A";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDD0010E968
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:14:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TP/81qOVSJ1RpvUVLukzjFoJjoQURRswGCXDO+5xj2cKPFORMPu1kxnU7BIXy1+Rc1WmG/nEtyckYnUM7EKvfl1kteIJeCLS4hDn9+qpiDbJWzd87/lFl3HaT9A9tKTpyfmaIrYUei2xOhaVx4IVdWe6qRjDWMwReapWO/Dv6aXAQWMXYS+1mI5cJ6eOx1zOH5cyrsEiC7TATdY4WSIHkXDFHLsslajBayLuQW9v0nyRBq6mQTt7vbxMXibgyJbVoM+tMnWGR1TV8nUN++Efck+Wo5xdFYX28J1zOAG3MuW7hLeQDgrX3AwCfP3T0EPQrlaMQjY4BmF1ji6leah7JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXV218dHFe9aV1qtK+JMtlx4u8NNWfm3DWrj6NnXSo0=;
 b=qogBnUIcr4V7/g3YgIMvdeMRrDUcAaBdwiRf8fYfHVQv9Q1R6vdmxWBJNB3cTBasmUogSYvcLS7qUtzh3yHXZn2VDejFK9BR47PIF7GC7eXWQKmXPWPD04zHUp2v74zqaMxiD7sz1FSlTddQ0Z9AgW/N3oRFj4xQDyL4OrTDeQyuskekJS849rH9QTinuv0ujpArFp3hGwU1OvArbHupJbSB7/0SdtRkOaI7p3xybnnkiaM23FzGR4TbkEpZ2XaaMBm+KE9931OmvWfZktfAvWseLrC15OtKf5gWNMN7FL7hEIe+3k8q4B8AntVeWQb2CHGe+AvURF7gEBOjzveanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXV218dHFe9aV1qtK+JMtlx4u8NNWfm3DWrj6NnXSo0=;
 b=zjy9Rk7AIFo0b2UdwWZ55a2yz4SSM7AQ272GK1PFKEO/4ZCZ0o2oVvLE1Gv4WHwPVVer29aJ0Bg3JBekEZLgT50AG1eZs5NiWeTMbhGSvwvOKvKk5ossjcdm1b3zMIKnSBAzHkqvYHquJlSge7lquYt6JmRN3dE2XWjnMzX1A98=
Received: from BN9PR03CA0261.namprd03.prod.outlook.com (2603:10b6:408:ff::26)
 by SN7PR12MB8026.namprd12.prod.outlook.com (2603:10b6:806:34b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 11:14:50 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::8b) by BN9PR03CA0261.outlook.office365.com
 (2603:10b6:408:ff::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:50 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:48 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 15/23] drm/amdgpu: support to find RAS bad pages via old TA
Date: Fri, 8 Nov 2024 19:14:15 +0800
Message-ID: <20241108111423.60169-15-tao.zhou1@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SN7PR12MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: ff1a76be-f066-40fc-d93b-08dcffe68fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?amFDNy1L542myl1StbtBHnDpMzTr7SdIaywGBCXp6vbRqEJYlfCcDdASvtlA?=
 =?us-ascii?Q?RIlfEtQG8agnM83VTkonfeywjh8cDhDaLEv3YWiAuKezFoaotYjdUH0NHZfd?=
 =?us-ascii?Q?O5/A/DViwDQA8Nvkt+FVNLfyod3h7pogxHSmSGWCiAZ6LiG8HMpaih7ycvYH?=
 =?us-ascii?Q?RP2U/uXeRUdHY/5W6Z32NpxURAlww7bvK55LQVVrgNLug6W+FxH6WTfJIqO+?=
 =?us-ascii?Q?ye/inmw3XiOb3jXNExvDsPehICaRJXFRk6kkAsg5k2a+W8Gt67hew6COM4QM?=
 =?us-ascii?Q?y6LyGlzE0P7m3eNM30HmXVv7+No1nxeFrR+Ihc6EgVSUQol69Goic/2WDHQ1?=
 =?us-ascii?Q?dNuEgogJrfKmV/7xBiWO8atuI8kSIpMXzNgWduQGemLfAea9XcQyoxSMY1Dt?=
 =?us-ascii?Q?zD7xckX8g8LraeAK5St0G2o8/UvDZaBFNZgHbM2MwcTwGUzK8NqHMU+jZWgX?=
 =?us-ascii?Q?uTWmUke94LBRJg0cj9a0JGpmAUYbp34z/Ux6JrhOQ6ZPX4yYMYbUzBzZjbQd?=
 =?us-ascii?Q?OJLcp5jr48/6AI+Tx/4hPj3K9fm8/dovWaZgpPlksHlxCryJ0MfkFp061hII?=
 =?us-ascii?Q?JwGz/XQVOi05QaaPdU2VAbKXdk/gPBzyr7u8yx4psUdEazma29s+DCP4PkkB?=
 =?us-ascii?Q?Kmj6ZJfytRt7H6q19A8wA6T6xlBhnQtnIsc51FuNrMrrTz1G2U70FyE1jItU?=
 =?us-ascii?Q?mNNWO5CaYPoZMBfCKsLKq6oNEoQQ7uSrSd6xuIm+oD4eRcpTuU+xbzlxdDf3?=
 =?us-ascii?Q?rLt9jlz7aNYDNWMP6OPsuzbY7r1+7zd927gNgTsF3U0BlSjoLamCo0aH6hpo?=
 =?us-ascii?Q?2pRr9wkFyUDuQiJpHTMlVmy7k0+5iOJScTJAPgex/WVkn7+K+J3LThJXo6Zx?=
 =?us-ascii?Q?lBVsN3O30bFz9xf6QRvA/amOJuQLzHc/sNzVPZPUDtmSbjz1K8DXt8qtL2cw?=
 =?us-ascii?Q?g5SNhc8U9okwE9KZjy01ykGkLLPFRdC+2rX/+Rj9hwrgxEiX3RPRSUOLIF1F?=
 =?us-ascii?Q?fw+KtTO6JB50IEUrBZ7rpRkgK2v42+Z89EWOUJBTdeQGQE44HIKJDy2DYrnr?=
 =?us-ascii?Q?0EpUvs3lSvpgyBUcXW8pCpS7jU5619npkgZHzenTvj7kHJxR0iWmUaT1fZhL?=
 =?us-ascii?Q?qRNt9m6t5pU5I54FZZ/QMEv5h7Oercwv+j84macTTCAmS0szC0Uu67JCOlQ9?=
 =?us-ascii?Q?rhZqtiFn1aS0e+BkChCiRI55/24/N6t4Fr7o0EckdJdalrKwTyXOJB2+XNj0?=
 =?us-ascii?Q?8zujS7rTvgL4iujnMkqCk7PqOwkOrUCTfEE/xVlSgkioPgqazXijlmieXX+D?=
 =?us-ascii?Q?gYFMf/24chGqvRcUF4stOG5Zq2C51WZbTjvCVgZc0POR/AHh2tbEoprf08Nm?=
 =?us-ascii?Q?feVHwojrRvvFVTIfCQ1VEIpFIvzfFdjBB0a+cHbwekXijdf3/Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:50.0253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1a76be-f066-40fc-d93b-08dcffe68fdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026
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

Old version of RAS TA doesn't support to convert MCA address to
physical address (PA), support to find all bad pages in one memory
row by PA with old RAS TA. This approach is only suitable for nps1 mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 26 ++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b45344fe8cc8..ad0fbdb01a89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2704,9 +2704,10 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 	struct eeprom_table_record *err_rec;
 	struct amdgpu_ras_eeprom_control *control =
 		&adev->psp.ras_context.ras->eeprom_control;
+	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
 	int ret = 0;
 	uint32_t i, j, loop_cnt = 1;
-	bool is_mca_add = true;
+	bool is_mca_add = true, find_pages_per_pa = false;
 
 	if (!con || !con->eh_data || !bps || pages <= 0)
 		return 0;
@@ -2737,12 +2738,31 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		}
 
 		loop_cnt = adev->umc.retire_unit;
+		if (adev->gmc.gmc_funcs->query_mem_partition_mode)
+			nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
 	}
 
 	for (i = 0; i < pages; i++) {
 		if (is_mca_add) {
-			if (amdgpu_ras_mca2pa(adev, &bps[i], &err_data))
-				goto free;
+			if (!find_pages_per_pa) {
+				if (amdgpu_ras_mca2pa(adev, &bps[i], &err_data)) {
+					if (!i && nps == AMDGPU_NPS1_PARTITION_MODE) {
+						/* may use old RAS TA, use PA to find pages in one row */
+						if (amdgpu_umc_pages_in_a_row(adev, &err_data,
+								bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
+							goto free;
+						else
+							find_pages_per_pa = true;
+					} else {
+						/* unsupported cases */
+						goto free;
+					}
+				}
+			} else {
+				if (amdgpu_umc_pages_in_a_row(adev, &err_data,
+						bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
+					goto free;
+			}
 
 			err_rec = err_data.err_addr;
 		} else {
-- 
2.34.1

