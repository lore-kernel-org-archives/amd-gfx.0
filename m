Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C931C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 06:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD8910E6D3;
	Wed, 12 Mar 2025 06:16:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CZzP8ngP";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87D8B10E6D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 06:16:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7fMp7YiMZPrsJaqCFISsOtLuDFNVWrHfk2QNW1WvNgD+/u0786vMqus7snaeTgB78xqmGUOq1Q4KQrKYNN39MBksIjP4dOWLOg9jX8P6py2SsDmqkslbKGXNDM3iTNMwD8pN3yrCq/ExQ6SKFB4HtuCnuSIFchzT71Qta4m//m4jK8NMo3EYy18UlHjC1OApYUB3JaIvPz4Li2wVxK9t9hKy8iu/ORYuLctCZP84Dda3c0PBrGkUorIXYMyyfKfWkACcivZexblwmocgtIYeiFSvJ+V5QZnfAeDQbrRkbDb8H0gO0f7UFPppZ9pDMsFZe3pSr68mh7utBRPsd7qQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYhL+QahmWbayuC9uh99XqsDEFYzZ+Ytk4CsAJIpDqA=;
 b=l2o6FnZ8cI14d3dUNdNQ4CqjnednOLqyIHaocxy+KEz2LXa/Wmg/5CuTyhMnYlazbW/xyFEHfj/PCr8bGpMAdqgWeipSyIeEtoJmZbc0FP7T/P4gZsazGdfjb2CitN8esJuOr+Q+xzMlMbxlDJy7ylU3Q+RaDhnPG7SvI07J9sIuTvICB2ySOIWce0SHvr4e8+yjlFza2uSEL1KBhxwpZ9ri6ZxUgW1BXQYeOLmxBehovG/QVbPnXBFFmweG6z3IRfZVCSIAn89Me5oaIka2m4jSNzeq+OxhYJBE6H5FKqqf6uwSxHO3zOHHkHj5WTzCsHuBGNj28EUjpoZYGPgcIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYhL+QahmWbayuC9uh99XqsDEFYzZ+Ytk4CsAJIpDqA=;
 b=CZzP8ngPP/JZb9UTfPUTMHpai8wpyJoAII4C31S1yAwFmD/NxrvdW8IaMsrXXmxI+a9G+Lbdhkwbui2Kk1rNGrY8zVqrkMmRrjKmeg8vDisdwqMkq90jrlojhSogETco/Y1e97XiOxsIgeLWmEpoKJEsO2Wy72qJIjhD6Z/A9Fk=
Received: from SA9PR13CA0107.namprd13.prod.outlook.com (2603:10b6:806:24::22)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 06:16:19 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:24:cafe::64) by SA9PR13CA0107.outlook.office365.com
 (2603:10b6:806:24::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Wed,
 12 Mar 2025 06:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 06:16:18 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Mar 2025 01:16:17 -0500
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH] drm/amdgpu: Save PA of bad pages for old asics
Date: Wed, 12 Mar 2025 14:15:37 +0800
Message-ID: <20250312061537.1233118-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|PH7PR12MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4e02d1-5ad1-4837-35e9-08dd612d674a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?17OBe2Q2YpjauS6rR2ul5dxv8Oo2lPI7Mt3NeRuX7wc7htuFjwm7dFt9ZC8u?=
 =?us-ascii?Q?OvuW8B6qD5xffPiGqWL0XrrwViM1XyoCFG4emwH9NOheGS9lJ/autd06NL8U?=
 =?us-ascii?Q?szm3H7wxTjsWsDKO881moqY+gYwefs3syUaqls8c0I8ZtjHxj8aFMw2S42mP?=
 =?us-ascii?Q?dRXxHwt0FonNs2SD8Uyp6sXOnrthX+5KqERpDrW/AZbGzQmMxFziwRL1wiQH?=
 =?us-ascii?Q?npuFsBuENInrrfgcrY/KGEuLtVyGBpEkpcSWTM2twM2r3IhktYcylWvBVB4Y?=
 =?us-ascii?Q?ugUHlwTl1MMbSr0szpn7Es8QxBssvMnGXaP+0a/9UtquIMsmqulhpkD3UNXP?=
 =?us-ascii?Q?7nATfhQpjQCMlihYyke7xos/4j1nboGazFFM3+OV6+Ems89F4vbQvIgUOksr?=
 =?us-ascii?Q?rHp4iqKFjg2iIDVVdLSVL2JeXLQYLfDRkcwqX3Q7Lel6uzPNtvSSlqboohaq?=
 =?us-ascii?Q?SLN+V31lORCvkw66FgqMwdL/cofF5hPH0lKxDTQzNoGs2LsiATnF2f+wWr9P?=
 =?us-ascii?Q?B6Ykg1fwXbbld4NuWDfoUO32aGcyzed+fcB5BJOIWYPypeVFGI2ZhYU4Jf/0?=
 =?us-ascii?Q?/t2PoSPHfhJ4XSucwBdthFhIEKtpU42Qr9AgHa99Sx16TJ6XuikacwgE8FTG?=
 =?us-ascii?Q?sm3YJywsW1IEOLpGjI3WbhsC4Nh8pGrCpzlAx4MGOFQfIhLpTdvSKVwVDvgf?=
 =?us-ascii?Q?s5w5/C9FijfaJ9utIOlyJz+pi3dqRpYqbcet5pzsTNmed+zqWiT/S78+CHkv?=
 =?us-ascii?Q?4TDAR+BHtSJ780ZlSkoWkxnIR06SfWnO55K0yvQURontDYsai85aHaOp6Nt4?=
 =?us-ascii?Q?9qXa3xor5MF+VWN1oXblroIwvoAbDwzZfdLqG9iVcro7nOn9/II1tjhrMfX7?=
 =?us-ascii?Q?uagou/6mr21KdGk0VwRlJU/L+ewydw3W6v/bQKEEMKT7PPf2pM8nX5daVHL5?=
 =?us-ascii?Q?IKBnVVOvtKKttWhRshjoqDDYIfuhPb0rj+He3nYEEDz70/20/v20bZWZq/Ql?=
 =?us-ascii?Q?ZP7dTILPEkacgRbPItTvxB/ONbq46UFBiL6MnznUR8Pj7uidkC7+cozCjnYM?=
 =?us-ascii?Q?1bFYnB1kLFYOleRq9idCwxegYuZTHoqnrDEitw59n5i2biQEDI10TX4X1aU7?=
 =?us-ascii?Q?rsUS6cp20Vr2rJQOgzjIEJw174Y7oW+fGirLgj0gW1Zwe/hxmQ7r9dePo1J0?=
 =?us-ascii?Q?w/6BsFyQ7h4XKSEtBka3iCIWOLkUdl482OG3CLWcZ8Piq/iCJXnrsrY07Sf6?=
 =?us-ascii?Q?dXfeDvdDzgN5CmWR5Pduurn1vVEKffjx50z5DwQlfxcdXFNsaLfdZysj1pHs?=
 =?us-ascii?Q?FEgQfJz2mSkL6HUukighqA+kTQpBE9LA3G99gPFckczLLFffoYwf99/8xOb7?=
 =?us-ascii?Q?Zz2GlQLk/8+XWDdkV8Prq91Gmh10nPf3818ykNrTH7qXvOijhfmnnJbGN6oT?=
 =?us-ascii?Q?3AatAtIz0Elh+q17wrTCsnjZwwJoh8p65RIryNTluDAzNs3sKKS3xNKUH73r?=
 =?us-ascii?Q?UlKQLYED3qse3FI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 06:16:18.9880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4e02d1-5ad1-4837-35e9-08dd612d674a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934
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

for old asics that do not support mca translating, we
just save PA for them

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 24 ++++++++++++++++---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  9 +++++--
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 285e3aa2bb2f..7cf8a3036828 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2836,6 +2836,13 @@ static int __amdgpu_ras_convert_rec_array_from_rom(struct amdgpu_device *adev,
 
 	save_nps = (bps[0].retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
 
+	/*old asics just have pa in eeprom*/
+	if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) < 12) {
+		memcpy(err_data->err_addr, bps,
+			sizeof(struct eeprom_table_record) * adev->umc.retire_unit);
+		goto out;
+	}
+
 	for (i = 0; i < adev->umc.retire_unit; i++)
 		bps[i].retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
 
@@ -2858,6 +2865,7 @@ static int __amdgpu_ras_convert_rec_array_from_rom(struct amdgpu_device *adev,
 		}
 	}
 
+out:
 	return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr, adev->umc.retire_unit);
 }
 
@@ -2981,14 +2989,24 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 
 	/* only new entries are saved */
 	if (save_count > 0) {
-		for (i = 0; i < unit_num; i++) {
+		/*old asics only save pa to eeprom like before*/
+		if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) < 12) {
 			if (amdgpu_ras_eeprom_append(control,
-					&data->bps[bad_page_num + i * adev->umc.retire_unit],
-					1)) {
+					&data->bps[bad_page_num], save_count)) {
 				dev_err(adev->dev, "Failed to save EEPROM table data!");
 				return -EIO;
 			}
+		} else {
+			for (i = 0; i < unit_num; i++) {
+				if (amdgpu_ras_eeprom_append(control,
+						&data->bps[bad_page_num +
+						i * adev->umc.retire_unit], 1)) {
+					dev_err(adev->dev, "Failed to save EEPROM table data!");
+					return -EIO;
+				}
+			}
 		}
+
 		dev_info(adev->dev, "Saved %d pages to EEPROM table.\n", save_count);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 09a6f8bc1a5a..3597ecd9baca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -727,9 +727,14 @@ amdgpu_ras_eeprom_append_table(struct amdgpu_ras_eeprom_control *control,
 				     - control->ras_fri)
 		% control->ras_max_record_count;
 
-	control->ras_num_mca_recs += num;
-	control->ras_num_bad_pages += num * adev->umc.retire_unit;
+	/*old asics only save pa to eeprom like before*/
+	if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) < 12)
+		control->ras_num_pa_recs += num;
+	else
+		control->ras_num_mca_recs += num;
 
+	control->ras_num_bad_pages = control->ras_num_pa_recs +
+				control->ras_num_mca_recs * adev->umc.retire_unit;
 Out:
 	kfree(buf);
 	return res;
-- 
2.34.1

