Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D9FCD98F6
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3C5010E480;
	Mon, 22 Jun 2026 04:43:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W5+K15no";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85C6B10E47C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:43:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhZBiV3igQZQ1iMGE8JbMyT13V4axbI8V3vpbMa+RNqObGAyCVBdaDj0O/EzGOAW+JJRYOKdyF8F9jeeSpJfaiI9pkTaZGVE+fHHjCN3vG3EMjlsOpxhbYa/sDBUZaUJQFX63H6+JojR5XW4X2jl5QJUMOd09QKDbS8PP4Uw32aP1oPRpqLMKtrT+4N4PGY5Qc26wbOLVrzpAWGfhm2GcyJkdnIB+nxHh7q+e5oz83FATxhfKtV0wKD5NfVtXzjM8z4tINsM10b1nLgM0O5mVQNEVtRIY295Ah0uM0UN74qeFcqpoOFC24XamJejUbFWwG1zWVIY+a+Q4H30h7XXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eu2riU0nOC+yL2Auw38ntJINvlj7M8B6Je+X6w0AnY0=;
 b=gLUlp9X4/lGZlTst0zdtZZ5F57GE0EHGn4pbM7WTPTXN+S1Q+hm0t5Lxlh2oCplL4PGeocp+ih1svI33RqvWmVzkJTnDhF8zTOe5XJWdLmnrijNHUGqU3Ee0Yfbnxx6evRoovPJtxmNUY2N3IiBdY6Xy+lnPSx1z39pXtXYx7U5AlhFvITqHXCOAr0jEb0yKsXwKZ0tbKCaYZFvb0I4QD2puVMUgnuabcZPgz8pxZCqy+rneQjicloolFkV66Qe6G2lwpStZKu9YmwyUNdvCUoWaAnaKzfTpnMwLXqy9Ic67JJwbY8Xnt+0+b4bvjNS20aBgnBWVv4j+1YiGOLsNtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eu2riU0nOC+yL2Auw38ntJINvlj7M8B6Je+X6w0AnY0=;
 b=W5+K15noxYrsVqBWR95nHVo/Opw0JYzN/1Rpem8c7HDZymuBy138Ap0bhRwOoAqn92Ba9amo4zIqMKOtHk7lG5IVtsPup2GbVeNzCtjtj9JfMxW2YEE8TwCmrQZMgLqoofYGS5427vd4f86yW5AzSYJH7doqfIAmgEb3uFo9QuY=
Received: from IA4P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::7)
 by LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 04:42:59 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:558:cafe::2e) by IA4P220CA0006.outlook.office365.com
 (2603:10b6:208:558::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 04:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:42:59 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:56 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 30/48] drm/amdgpu: retire legacy PMFW eeprom RAS bad page
 handling
Date: Mon, 22 Jun 2026 12:40:19 +0800
Message-ID: <948cf7c1a4d3dc9ba97415ac530e65810c37e75f.1782103074.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|LV8PR12MB9620:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a8a4f6-0192-4d04-cfe6-08ded018bccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: qFpjXRpzx4ntkXRv6qdY8q5IKtD4VqPu96HF5+SV64ieMFt912/rH5BLxsECA+ZArzbHbnZ3fIhEI7kFXpMWIlnVK3m2Bn5dCLJavVfM2kq3DvJzcK8O7cMCttJ4F953S5dS4aYrFqYYrT6A4yNjb7JTN3Ps++obxLyftHOOgry3MK2I/LfFA2b3GRCD63sGNOaMOMS+dycqOgr6XSmqJ6qpB1eX5qSgoCfx0+Tw3zI3pDHSPAprHcXYnOlLoKpYGJlkr0EVNdM1tbkQk6nyeqvQIU/mSWp3zAQ3wse8pkq6N8+5Q7HMfMJY2gkAu8R5YyGJnd3GgGrzmdHf08Qc4/O+4xnyPfPVP3+HPYot8setIuNZtPz3BEEnXUSLhZt7/xrCbDOMH8c3dOLIz6/YYFWDIizkYlzlodLhodnSbXmrZCeOAgEMzGWRtjQPC3tfL/nwSd1kBFfE60a8hxUACA6aYIT6YaCXkmAfos9JOZknfAmVIqX/pMyTQkST40GpQjTfhv1i87zvrhJNjFKJNNSsEq/PuG1hhOCoyCoPnvd5bqklIK3HFiOlP91Ges8NkVFOjgwSiQtF/YuVN2+UlJgs98hGza4Kk+o3rI2rs6mTOkAOLE+g9of87q9aee9pmiIfSiG9WPXZtuvytrQ+9otQY/A6Ro8Gqa0xUwOw9EydyPY6r1/aLNtblLDNCUm4+aR8ceG+2P87YBcuMaPwWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oDnvOKO5NAVrjwYy9VQCI07ZnkZuKcUpM1N7qZ0nnnaNI5kG+LFmI9hgXAacxXsDY/HhUGIlDRaxuDZCkIoIT00Px55+pYSDQ8VV+KpJd84KpYGM0LIjHT+7m4uqzEmmHtfK62rNmmwq+KC0eplCjfOngwvirADwwst7uxmuH+Iz0Z+pO3tahIHnRbpm4zi+cyutdISg7UEqK5cbyEl0bPvUXXYOdruWdEEkgzZnf8CFHBSijTiFbTOBPi54D0rH5SEffumYyNNvQIK1MJlV25XVKcWd+G6RfS2jBzPYLxNKGr1b/XFWGAUmgwNiIa8GHqtUODGOAaBbjXBnxIXUPzLL+qvHdRP7CJ3RgaW5NKlQFag10cBEG3u12ecYTc/r/twuUP/acVrviXPqGh6uXP1DTYvuiwQVJevAnXYbumgg0GaxVS1LiHBPdvyeptTj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:42:59.8161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a8a4f6-0192-4d04-cfe6-08ded018bccd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9620
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

retire legacy PMFW eeprom RAS bad page handling

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 33 ++-----------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 292d76021644..d28e8958b0ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -916,33 +916,6 @@ int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *contro
 	return ret;
 }
 
-static int amdgpu_ras_smu_eeprom_append(struct amdgpu_ras_eeprom_control *control)
-{
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev) || !con)
-		return 0;
-
-	control->ras_num_bad_pages = con->bad_page_num;
-
-	if (amdgpu_bad_page_threshold != 0 &&
-	    control->ras_num_bad_pages > con->bad_page_cnt_threshold) {
-		dev_warn(adev->dev,
-			"Saved bad pages %d reaches threshold value %d\n",
-			control->ras_num_bad_pages, con->bad_page_cnt_threshold);
-
-		if (adev->cper.enabled && amdgpu_cper_generate_bp_threshold_record(adev))
-			dev_warn(adev->dev, "fail to generate bad page threshold cper records\n");
-
-		if ((amdgpu_bad_page_threshold != -1) &&
-		    (amdgpu_bad_page_threshold != -2))
-			con->is_rma = true;
-	}
-
-	return 0;
-}
-
 /**
  * amdgpu_ras_eeprom_append -- append records to the EEPROM RAS table
  * @control: pointer to control structure
@@ -961,15 +934,13 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 			     const u32 num)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int res, i;
 	uint64_t nps = AMDGPU_NPS1_PARTITION_MODE;
 
-	if (!__is_ras_eeprom_supported(adev))
+	if (!__is_ras_eeprom_supported(adev) || !con)
 		return 0;
 
-	if (amdgpu_ras_smu_eeprom_supported(adev))
-		return amdgpu_ras_smu_eeprom_append(control);
-
 	if (num == 0) {
 		dev_err(adev->dev, "will not append 0 records\n");
 		return -EINVAL;
-- 
2.34.1

