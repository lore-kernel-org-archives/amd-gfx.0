Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A812CCA5FA1
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 12:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C74F10EE58;
	Tue, 29 Sep 2026 12:02:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OVys9FCQ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011070.outbound.protection.outlook.com [52.101.57.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 514C110EE7D
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 12:02:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m74f5o0uV0k+bMYJUcGE1Nci/v7pyiOC2Kik2dMGRtZclXFOklOX+2qb8PWqE0R9gIstyibKsGGiE3/9eJngFwQxaHadd026SkTeaL8Nrk5Rvtv7+8UQZaR3t7F90BPQXXKxIdWQLovVT0sNCP7SOvdeHgf8Gm/XIURRUubLnwYocv/WjliaN0nJWFR1mkV9v6F+W+KbFK6HRzoWaq5U+d7ineSS1fvkNF2MLrBkEpQbUVejhPaJhLbTbN6T9fA9uyk5ZiH0UsAbFnEZIJXW1NltQMCFRb5oZHWUC7FkQNbT8cShJVfynaOLBpkrpyiXZPVhGfae3ZKIAJObdQ4sFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s50d2FpNjg/CXRY+uE6/XMS5x0AZMurDli89nEYMzpk=;
 b=JHntco2h8kdsCYXlOB7Mad/uMvghfAuKp7hvaOB8StcvZE3xapf73ary3iYpnaeI48pzNG2i5dS1ESlk9zAzbZvsKEEi4wkD+B2OANoOu9O2yGatmJo3Z/psVi9m5KnR/HvRd8HCPevAZnJ4rD1EOR43DK/oYppdToxg2fy+G3QopO2RkgG4LhEX7sSu5OfuAvHnxRQ7x9dl90z9EMySYZnVMYQmrhoU1r1dCvBLxjnjBzB6tiKWQFeyUgLB5WvcfsPwxMTfDrnbbQNIHFftL8hyuKtzdEB5/6d4FFu4BHMHD4h2OSIP26fzdY9U6CU6DFcgLXl2+zAYTLY60HojrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s50d2FpNjg/CXRY+uE6/XMS5x0AZMurDli89nEYMzpk=;
 b=OVys9FCQOtPetQIDn5PXLI8QMhU7EIU1x1suKg7vFbBtHEubYuul3yjH9plNn2IpnsD2oX4xDmgqa23O2iMfLyWji/VvrLxRxJA0ImhIHKXfJWFfZlNSciscjplxEbJ/u0yhYO3F5NOEwcSyeyVLcJDguhiz72J/fREldndyLGk=
Received: from BN9PR03CA0660.namprd03.prod.outlook.com (2603:10b6:408:13b::35)
 by CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 12:02:45 +0000
Received: from BN7PEPF000000A5.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::73) by BN9PR03CA0660.outlook.office365.com
 (2603:10b6:408:13b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 12:02:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A5.mail.protection.outlook.com (10.167.245.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 12:02:44 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 07:02:42 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 3/3] drm/amd/ras: init reserved vram size before RAS core sw
 init
Date: Tue, 29 Sep 2026 20:02:16 +0800
Message-ID: <20260929120216.1230237-3-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929120216.1230237-1-xiang.liu@amd.com>
References: <20260929120216.1230237-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A5:EE_|CH2PR12MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: 4232c341-c190-4156-e434-08df1e219243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|56012099006|3023799007|6133799003|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iT2fqehA0/dfC+KVHRM28+VCmwFdtiY+PsTSMM61k6E+z51cdH/5kKhBqBjSe9y+4gJBurCxD36sThYkvZIokekf8L9BviX/RZD1zNzK4VlRYwaPpuaTonxLrKBzBZ1QBVweMDY2EWh1Y8k5qsWRIAksPQsg1ZaSODi9cftl6DvpoZ5+aTmAeu7KHrKSvQZDSAeL/Ua2WMLb0TgB9kyzMcU4g92yffdWI+SRR5hp7z4JqEsJ3q5faVfp5gf4/kCvwb90QFAcXoMlH+WrL4lGanLflSJycMqHVpoNo5eyuv+aPuzD4OLMV04y0FUk7IVxa16NqQ/v6cJYfI3m1PI2F0IhCy2rOfH+C2m5rC58Q/OtpKIKZw9N+QyNyQ7a6Q50ePvSYMRySBE+r2H70dgEAPUp4t+fjs/+lDDQFglERBq8a3AO7ajJM1UJJ1Kyg/SQoQbY7cMvEMoxaPIsD6IO79TmU/rhVaG6b9R21On2hW2bsGFtVqVIkmWALN/WgLepPiH6b7BrZpHRvlizYeSOYN+RCloNl2jxrVkUFIuAw1TNiFLMjFs8CAYy4imB7SaLqPVpnEKYT5xlyhCQrK6eW2OWhrEbE9lRKHdwJgQBoqxLCKBm6WmM2B0WryTnKjHz1vdEaJmh3dB7AUn0aCKscO5/oxs/FUh/2UmpXn/mnt3luH8XOvY+PpG50QHs8uBkI9bm4/uIMM9rW+a0hDQ65Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(56012099006)(3023799007)(6133799003)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o8Jng1YeTAtn0fOICnyctbWHZGUpjc/ninTx4s+cTrptP9TbM29ozKp0YVqp1pzyhpe4pBCK36/+raZKzwYIEFytLHgMrc/SKEiq9K+uMGMxyvWaDNAjaXcYtVEJh8D3M2AE46LfUQJJn9MBPxwgUgv0SKBURehnxrjrhTBVQpncBgPghjBO+DQZmHFaCbpNhZK2j9D4w6PNMq8I3TdWxWxoE/tAMVeUkTr12Ktynx9PM4mThdXufX7zuVOVH1rs9F1Z2dZYrUc6ikZYky1YH4KIHwJmW2EnX+x3KpYW5hKBknSBucOdD+HB7my2dEl/WdS1FoyBrfrV4h2CZ4EId3KRu8naI4Np9cekC1kd8E1qeNIxFOwMS/C3Wkz3tbfKPgl/F4m4RivG84rHlzjfV4UCLTzFToscWYEjHbGwo+d3XGuOK30vSGaNmKYKYNVA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 12:02:44.6150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4232c341-c190-4156-e434-08df1e219243
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310
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

The RAS core derives the bad page threshold from
con->reserved_pages_in_bytes when amdgpu_ras_mgr_sw_init() builds the
EEPROM configuration. That field is still zero at this point, so the
threshold falls back to the 16MB default and ends up at 128 pages on
ASICs that reserve 32MB.

Set the reserved vram size before RAS core sw init so the threshold is
computed from the per-ASIC value.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index becad704113c..0d39b1872b4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3628,6 +3628,9 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 
 	amdgpu_ras_check_supported(adev);
 
+	/* The RAS core derives the bad page threshold from this value. */
+	amdgpu_ras_init_reserved_vram_size(adev);
+
 	param.ras_feature_enable = amdgpu_ras_enable;
 	param.ras_feature_mask = amdgpu_ras_mask;
 	param.ras_bad_page_threshold = amdgpu_bad_page_threshold;
@@ -3725,8 +3728,6 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	/* Get RAS schema for particular SOC */
 	con->schema = amdgpu_get_ras_schema(adev);
 
-	amdgpu_ras_init_reserved_vram_size(adev);
-
 	if (amdgpu_ras_fs_init(adev)) {
 		r = -EINVAL;
 		goto release_con;
-- 
2.34.1

