Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E493FCCF9E3
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 02:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 819D210E695;
	Wed,  5 Nov 2025 02:05:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hvrpqOsR";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013060.outbound.protection.outlook.com
 [40.107.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B69E310E69E
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 02:05:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZT7bg08jrBK/g27e8Wqh8znALaW54tkLGHuOKQ1YL+oQtOOsT/NqthKAcVo0tKU6hwzWyimsga6/yag3WBSX6Ygo3az7Sd0j2HV7KlCZVpIkYB3/k9HP33zM1A/86KAawB9PvY1raQbnHK7eJL8q1qQxCMJzvrbaCvOdXTmLMWLUOQt1zUUO3eir3MqnOe7I79MI1zxSI7vuDcjb58IhkJuQR2BukZi69FWf1ng/QXFBNt9dKFzSLgZrVMwTWcN60Gt1W0+sIR1dqC6Ljx2+QKeijj6FeWX2NqLbzYTYtRsT/mYLGFpiIzz+o8CyJ7zyCYu3RGeqohKU0xcEar+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YygK4RAWPegUDd+3MOEFTQaVXBjD95pv7aFiATySI3Q=;
 b=VoOEvA7YuTDYB3o2HPvjtslpY8RpaQML4iQmd40g1cZkGpvUhPWzYCyslEXiODrALrr6NFl2LRjpTFwF/66vFDjKOxdFLWTx+U8CCl58Oh8nRikjSDX1i0x0F3eNEUVrcfmlliZsZHeHfPCajfDHA7e6oltQ+gBXIMMQmHRcwExDGhPkxA0W3641D1yomrOlHtYSVxv2J4LgRiH8TorVX/9GIzJ4v+GbBZH6YNyg/uBKQWgkugJZlu9IpZOrGAgdQPYxOaWG9kprsPACbYjGnIYTpFXtXg+qVZ3+L3nGn/ELfhEk5W9N+V41WpdtGoH8LDrB4U7Bpk5Qdgn0lYCUow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YygK4RAWPegUDd+3MOEFTQaVXBjD95pv7aFiATySI3Q=;
 b=hvrpqOsRE6ENEpFzr7yR0j3lrqFuj5EF/hj8Ssu1nrq4Au8uHK0datn18zRFPP5GnD2Ue/hGMJr4ppY1aqfOX+4eDMqQc6k0Z7RrEY8DUwNclg89Ij15Gg6W3FeBnI7LIGFNgiJQn9IXjtjQUeptaTuc3ELRytAQUT76bMKzYSY=
Received: from BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::7)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 02:05:13 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::fc) by BY1P220CA0020.outlook.office365.com
 (2603:10b6:a03:5c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 02:05:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 02:05:12 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 18:05:03 -0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 8/8] drm/amdgpu: add RAS bad page threshold handling for PMFW
 manages eeprom
Date: Wed, 5 Nov 2025 10:04:45 +0800
Message-ID: <20251105020445.1423034-8-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105020445.1423034-1-tao.zhou1@amd.com>
References: <20251105020445.1423034-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f61d3a8-44a6-4deb-1795-08de1c0fc184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|30052699003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CBmTRRU/OPXY+l8cjplWvORyTbwXEEn0HmOWwe6ICx6jl7lqVoOC1b9QWM2V?=
 =?us-ascii?Q?/dR0bDSNnd7gp18bQyXHRdQeEbUlInScRq0GqA5mfCHLo3UJ0e6nYjIMRdCF?=
 =?us-ascii?Q?4jfG2bxrR6PRJx1Sck1B6HsXs+x/30R606a51PFFfUpq3saoi/4n1Nn7l0b7?=
 =?us-ascii?Q?7dZ5fs9SBuk8VKrtGVGVlx6EjFAZFvOTqE90ko4Yji05AQLV6dfnJJmK5pm6?=
 =?us-ascii?Q?Re+10ZsiIMNhh5BRllR87mZt8bgCxFWxer8zOcCNZcWzUEZV1nzsgQRtEnz1?=
 =?us-ascii?Q?rLm1JcmUmk5XPuEVKPrHL3Y1BkKrcOREQIZiEPbi/3rhokd6m+bslkHSoGjj?=
 =?us-ascii?Q?dAGUvoB+eysEX/5MEZzAPiSbRYkLCCdCQA12Mau3NEABF+L2PYYpEwaohw4K?=
 =?us-ascii?Q?o8Sc5EyFBZawaj5PWnWJLOqmJrItw6ImZ7mfN5Ht0J8eQQDfHRPIh0blV/cp?=
 =?us-ascii?Q?RxOHYOb1HYAVOK7RQxwPC108FGWNnUcgM9UjcRQwpnR831J2BBnMHxriJtF1?=
 =?us-ascii?Q?9zU26bBq6IzgpiKplzFmMbNzCQdOJoSCNCZnd3U4V1bfOpf8cN3US5PGTAmu?=
 =?us-ascii?Q?DbPlUwnNd5de87Zh3Jjik9/zlicbf9TVxI+CSzdHaOOwqQIv2Jx8ZwGT2hoV?=
 =?us-ascii?Q?65hvglyCbXeqoUShtVUfRW0MQi1rBiLYhY4gAwKa9zsZ5th+Quan5Zr6RTih?=
 =?us-ascii?Q?NWIXqps828qlv3PTESDH4B0lfhGVtrlhv0UqOFRguKvrNMblqCxZfCx2eQPc?=
 =?us-ascii?Q?yKkcF6y/NOxk4z2H2Q/XFFBGoQOrwIEbT+OZorXVlowKXI/J5ihW+GYvzUOI?=
 =?us-ascii?Q?fHLlYIei3FrAIk8bmVk+cD8udrx4RiOW1oh+emEPO4ByLWINka8fCoDbV2/R?=
 =?us-ascii?Q?rco2xGM1yTtfnpCbzwT1xgdxKf2e+7LpMrXkdNLnP6OXyoGt7PWtkvo581Ng?=
 =?us-ascii?Q?XgUkGkh1DEtmUb76BtlkTCWKOUFRV1Gg6jZ35Jwjw6LS+gf4pHlulN7vw61A?=
 =?us-ascii?Q?3GpeX3BdDEQHEWx4tnue4R127P5sqLUhAfMtrI8fsQ2wxWEFSNiOC1cwjHca?=
 =?us-ascii?Q?TOFh/9+w7VU27tN+UA5kHeGofTlQ3kZhm8hUd934SM4QiKJE+LcOFX67eBWt?=
 =?us-ascii?Q?JjfL6HtsOnGsjTtjlzFYZZl0nSkSfnX+67uxNABZCS1BqOTUzHRcVxszd8ME?=
 =?us-ascii?Q?i5uB/QL3Si65XCxGfB0+vvJspElzL6XiQOFEvMjS6hJqVlKtZCOksThrLScJ?=
 =?us-ascii?Q?sM90sAQmtwyNcQVxhkkreUB+4U9hWNwFZobJHd47KGvGX+1DFEYEv8ZONWqi?=
 =?us-ascii?Q?klSj1l26LvCbUQ6OwRPl6bhifpIimbGWANZmPFKFjVPs6c5AlTcdd9fqd/mS?=
 =?us-ascii?Q?zlDvl100utaO9aL6sh08gy7tBq6W4tuQcrYWkrMDS8ELHbFynWtgNryPab/n?=
 =?us-ascii?Q?JxcyYPTIgW1oPewz1d99+N6OqF+xoGIBRgQcIHAUSjV+Cq8L1eA0+zoppzRj?=
 =?us-ascii?Q?lfHlkswlEfgtwArAPIHZGaxQ3EqZFaXjM4pRkRSLyVaAxTiefmbQL6s6xA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(30052699003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 02:05:12.8605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f61d3a8-44a6-4deb-1795-08de1c0fc184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
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

Check if bad page threshold is reached and take actions accordingly.

v2: remove rma message sent to smu when pmfw manages eeprom.
v3: add null pointer check for con.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 36 +++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index beb504cb4bfc..5768d5454a9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -903,6 +903,33 @@ int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *contro
 	return ret;
 }
 
+static int amdgpu_ras_smu_eeprom_append(struct amdgpu_ras_eeprom_control *control)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev) || !con)
+		return 0;
+
+	control->ras_num_bad_pages = con->bad_page_num;
+
+	if (amdgpu_bad_page_threshold != 0 &&
+	    control->ras_num_bad_pages > con->bad_page_cnt_threshold) {
+		dev_warn(adev->dev,
+			"Saved bad pages %d reaches threshold value %d\n",
+			control->ras_num_bad_pages, con->bad_page_cnt_threshold);
+
+		if (adev->cper.enabled && amdgpu_cper_generate_bp_threshold_record(adev))
+			dev_warn(adev->dev, "fail to generate bad page threshold cper records\n");
+
+		if ((amdgpu_bad_page_threshold != -1) &&
+		    (amdgpu_bad_page_threshold != -2))
+			con->is_rma = true;
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_ras_eeprom_append -- append records to the EEPROM RAS table
  * @control: pointer to control structure
@@ -921,17 +948,14 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 			     const u32 num)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int res, i;
 	uint64_t nps = AMDGPU_NPS1_PARTITION_MODE;
 
-	if (!__is_ras_eeprom_supported(adev) || !con)
+	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
-	if (amdgpu_ras_smu_eeprom_supported(adev)) {
-		control->ras_num_bad_pages = con->bad_page_num;
-		return 0;
-	}
+	if (amdgpu_ras_smu_eeprom_supported(adev))
+		return amdgpu_ras_smu_eeprom_append(control);
 
 	if (num == 0) {
 		dev_err(adev->dev, "will not append 0 records\n");
-- 
2.34.1

