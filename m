Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C70CDB47F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE28610F19B;
	Thu, 25 Jun 2026 08:21:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uvp/zxk+";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010039.outbound.protection.outlook.com
 [52.101.193.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61C9310F19A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBKrKMAUU5G01LUidSee+cS/Bj1VZ6ZpHtc3z6GhZBdSnggdz9z6HCRLEGbmCg1bKFIIDJR9JB7XjPaZ3z4Hup/MeVBhoBBxY+3RRA9DwClcui8eXxtGFXsOTtOSfr+rbmVuTisxjptFL6Fs+xAw6rcDTip4rBYr/ZamLxEO1yDJwmQPmX52Rljys2HuXq3vq9NiW8wo5bgrVWKk2RHlAWPpyPpj5lmtJdd6fUoqoKdFnZnjkBSBPQFLW1OJF71HXOcAs17EPbIBX41twng2XVBCY6iuqDAqnUmT/ZRIqGxMjGSSRGsDZWEOj7vt8Dz2kkWxq9N3Z41dJHv7jhRXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72/Mm7RbrkPFDQeEnIiW/3QFl7ZOnvm849Iyf93CkBQ=;
 b=JouUIXMqU6QExnnaO1L0TIjdkCi7UGU/SQWxKZbx0KvTRomV9NE4++zo703Sxj8UrqaVPm8pom8deUs1q+HgTNA/8cxg4soxmTP3LzDQ/gcgZo5KdLMlv4hkHmJbChmyM3VioTYep5keiYjzKpqPtsTJOg8I4v2k5T/x3n9CTLHjdbxvq7m28DJTjYEFcDC+pnXWwuiNZxq7CUSp76AC9JPUBPs27AlCrr0o7qfP6CSwNaNjFA3fXFpSAbLrwTKUSRwBhwfIzHJ5AQBhxT+wv/6MkSd5469hzl0wjRj6GirdTTMSOA06tHHhrOCjnICrQsjcZk+eyzwUiBY4Loa1HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72/Mm7RbrkPFDQeEnIiW/3QFl7ZOnvm849Iyf93CkBQ=;
 b=uvp/zxk+st3Y6bIpo1M7J5SOzEWNQgJlWfvPtjqMyQ2xvzr2Dn6LzvzHUM29qmtfrBtyLR5d3hvI8g6z1zmaL2j3RETCtclnRlxcQbkvGNbWG937ECmWFr00PFq+ntwZlvkNLBiqkurOnAM0OPJPuokDXMR0XW/d3FcbdtX/2ag=
Received: from CYXPR03CA0066.namprd03.prod.outlook.com (2603:10b6:930:d1::18)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Thu, 25 Jun
 2026 08:21:24 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::58) by CYXPR03CA0066.outlook.office365.com
 (2603:10b6:930:d1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 08:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:21:24 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:21:18 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 35/44] drm/amdgpu: retire legacy pmfw eeprom init
Date: Thu, 25 Jun 2026 16:19:28 +0800
Message-ID: <4cb6dc33bad9b6fa1e27da3592805596c0056296.1782373702.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 221cb21d-d2cd-446e-6e8a-08ded292bed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: Mb3J2PoQU2DYE6l/vWm/CSBXO33D2kZV61e8KuHaKWor3yWp9E4rB0fHeDndtd0DWgPBK+UYDLiWbYhImBJi3ZLduAVaRM3ME26I1vbpsZjNW0MSiTVRLOf+sOQasOqxIt8QetTOOHAWZ+B2mmkJTLC7+bFKSdaOIzPCUFUt6A0nyvMSaQzXnoJtN0V0Ze3HK++euPo96ONVv+mkV+0HIWGFSOBw7ai7TGUhhx548Jo18Y/f55ETAq6UC6OHdV44jFG/Mol9UKsTpm+P31fHtEazxJIpj1Elrkh/nyvaUxqBY9+sXYlPrr2DNkY8QHTp2wnAFyqwMo8mSjGzv0mQNSb1Lli6cGnIDSOleVKP7BfKGIWrvEa5XP0kcDMrscMebXZ6+pxcj+HnSjabYO9f8WHStoGXuHZ1jqT2sbXlJuVKozfkYpvib4F5vkJ86gCcVV8G3H2e4QOye7HhD3VNqXRjgpct7DbCeIEAicBlKZOpk39gdyLUUjO3eI6LBZFLDykOz4pUtNJMJWhFtQO4kbn+moeBqEsEKORZeYLHG/Ivlyz8/9c+rMzDmuvhFOKHM7BX9CZSCh4BEZgjXVYR4JaOAvAqMFJuQ3KFZmA+9wxw9fJe3waHlWhhEwJr4qWtEeP1J15wGlScMJYcmK5O6fu+bvhDD83fGYXh2zyny6aq2gajLn82ioaAc//NWY7Ph15QIqGmQPnTmArogfVccg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WPSh0mMaWTI4E+NZUCHQaq6b4Ggfq2euEEzXOXSD3iJaoU3IaezPJj+YEXo+NL2tcLNcwAZ1sMOiQbXreHhwN65qfL3sXTVMacwLgMeP/WUcN18qTZO3JmFELhimuar0xv8xX1iUQXpopwJSpe34WyWNvxa/pXU/cZx+Z3yxgLBLXBB39OEbdcaVG2VFawbK5qzc+1eIaakP80Nml22Ms6CQGvanizNRm7ESnXzC4cLRAlWiJ+BeMfm6JyiUc8okjLiFDLJV0DEoLmvc4P1slxYp8EHmjkNVkJTEpmD8hRImI9KiftIOJqkHYhWZd6Mug2XRccL6glZI5nIyVm9M/fXUkEDNsjEqvydEEzEqiVQVradqd54BMC39pZULSRbpp/nsov5paHcx+SIv6pOZ2COK97MDzBvfPBmPCiDJOJNeVX3Q4p+yPd0dGI1K1W9R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:21:24.1227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 221cb21d-d2cd-446e-6e8a-08ded292bed8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
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

Remove the legacy pmfw eeprom initialization function,
as the feature is deprecated and unused

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 39 -------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index f5d1bc1142a8..09aa5655e3c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1485,42 +1485,6 @@ static int __read_table_ras_info(struct amdgpu_ras_eeprom_control *control)
 	return res == RAS_TABLE_V2_1_INFO_SIZE ? 0 : res;
 }
 
-static int amdgpu_ras_smu_eeprom_init(struct amdgpu_ras_eeprom_control *control)
-{
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-	uint64_t local_time;
-	int res;
-
-	ras->is_rma = false;
-
-	if (!__is_ras_eeprom_supported(adev))
-		return 0;
-	mutex_init(&control->ras_tbl_mutex);
-
-	res = amdgpu_ras_smu_get_table_version(adev, &(hdr->version));
-	if (res)
-		return res;
-
-	res = amdgpu_ras_smu_get_badpage_count(adev,
-								&(control->ras_num_recs), 100);
-	if (res)
-		return res;
-
-	local_time = (uint64_t)ktime_get_real_seconds();
-	res = amdgpu_ras_smu_set_timestamp(adev, local_time);
-	if (res)
-		return res;
-
-	control->ras_max_record_count = 4000;
-
-	control->ras_num_mca_recs = 0;
-	control->ras_num_pa_recs = 0;
-
-	return 0;
-}
-
 int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -1531,9 +1495,6 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 	uint32_t vram_type = adev->gmc.vram_type;
 	int res;
 
-	if (amdgpu_ras_smu_eeprom_supported(adev))
-		return amdgpu_ras_smu_eeprom_init(control);
-
 	ras->is_rma = false;
 
 	if (!__is_ras_eeprom_supported(adev))
-- 
2.34.1

