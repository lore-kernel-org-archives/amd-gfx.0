Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A64CDB47F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F37310F19D;
	Thu, 25 Jun 2026 08:21:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XDF2GhL6";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29A4D10F19D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3WL1xpKM7Q+dfOkJvTkAT0VXVVTRunFJC5vG+ITEcDEOqecA1gfdvbrUgyJCx47tde3F7DPsAU3kOCZ58au2UgxOQYDavSXW9dsgQgbx6sA90Sb3ElPPS05zA/Zrzo0ooXx5ZzVtgvY5m5mb5Le82n+aVjy3nMhPYgY6P9bqwYDStteGoNBjokf/MHCL9TVEk6hT6gW/qE1xEDoFdxNcMosPmcn7mUojIDqUx1/9dMEGEpkNIcpgEe22eTApkuS3pilKvFuBkUlJ8hMlETh81sncIqJeIyFMbCRuwUPawh8rKFM1+mt228eGYMmZMsX3S7NSsZCDWUehREi2UuEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlIcRwXMZSqjMHEi65hWATiitbHU752MptOWsFRkfNw=;
 b=Jjau//L6JwBrWbYGq/6yeWRTqauRVDIUNNVXdk4BNHTQOv6g5LU4jp49naTYtt/d9YGj7N12o7n1N9cDPGPRcH3hESBojbMuJReKjyVerG6IM9fQ6CkbN9QhC7U5xM7/3UBwEpazwNchAzyPJksEIbgReSzu2lf76HH553FeutSFjWtxvwEMpjkQkf4Xi5Xo2RWQ/BiLVYrLcuoJkOl3XElg1m47FdjgedjnwlUpVDCCnQi4wiRMTJNGFVUhqDcA3YTH5+aFa2TCjuNCouiew9AMYP22P3JKAPp1LQtR90+bam7mGFwEhNKJq8XOVfsWg5gc19hON6gdTlCdbG96iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlIcRwXMZSqjMHEi65hWATiitbHU752MptOWsFRkfNw=;
 b=XDF2GhL6OaQzZxmc3jKxiyeIue6bijydJWIhDim12xjO0nzbDDUNWd+OtFg6asPiRvdWXavZTM9WtoLMr9ehvhVNBuhHAxOzGZdOTsKpfO5kYDwYj6TXsOQqJ4K9AlBe+TAvobHOiOPmNzQgNrozHmB5L0ryL838UjxIsKGsN4A=
Received: from CYXPR03CA0071.namprd03.prod.outlook.com (2603:10b6:930:d1::12)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 08:21:25 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::1e) by CYXPR03CA0071.outlook.office365.com
 (2603:10b6:930:d1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 08:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:21:25 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:21:22 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 37/44] drm/amdgpu: retire legacy pmfw eeprom interface
 wrapper
Date: Thu, 25 Jun 2026 16:19:30 +0800
Message-ID: <443b58e1e00fa2209e6a6c9ed710e703a123e86f.1782373702.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 12eea9ad-3f65-41ed-ec88-08ded292bf81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|56012099006|18002099003|22082099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: ew13rCaPt5P5IuGO7cZlZlyKMl6eCpylIkcy5p/j/znxcXSIiihvWqAQqak0/yNh9IUUg9xxgLUB2YET0Jb+oK5rhPWZWyvn9yR9vAyq2EXOgwckqzZp2f84fFWePA3fxAKgHQ9z8jZKFFl3SRkemw0/ewSVTvxX4+tWDqvKD9s5IcwCbtZV8MerWepGbUF8G/1S8mJja5GZKlgwUiWnZ/ABkzRRsXVX9UFAarfSKU+4Ve839Gopwm743kNbLCwkxRQhKLO/zAV8MFCH/trbEYJakcf9k5i9Bx8dITOe2HyNonJRMBHmca4YgjrIwtbtGunaKMxAy9BgeZdXAqckWrbezUyocJwcADbaH7O8giLjaI+vy9/nAWHvUb8Y4lwFBBCVOrnzpivs2M/mnFv3Av96YQtRRsYaIpRo3H4/IOsfWmFLF16vq7HQQrbj3ALnZTilhUY29eOVUhHiIvrdp/RzdEvSDBNS4X5Bg/hSqGXO78B5/863FroBPK2Of08n6+nNq3tq1IL7cqIOSvgeCjbDB6ncB4lTFL4irCI46WNIqtW6NNLzb1LpGY7ubbIhwUrkdFYITjPnf5uBrOl7JIjpeImi4VB7YVOgdflOBOMOmcRp45GhelOLpJLwh+vE2Nrs39JkH4CR2JiYxJU9oc2LItVpoYBcenO+ZBsqlSiaIoL2UAhTdKj4rg7sF7VKCl8zamw5y/JVPcyrAjyMyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(56012099006)(18002099003)(22082099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tzacAtGLHm7weBdOv6gOnJ2JFuTPphh4oS10cBKT8wvlTRTiyETQ+lr4MkNjdadKsuy5lXGykVCkENMftW67HCINFDbgMt6/AyJOuzIHxzzUrYtiyRtk3jjTHCZ8yBM+MJYeABLxXnxOIQ1p7rsCYrdaAVYB/gzOiYuHMgSSbmxqPJXr7gf9k+B2xfFXgSJxPtStiuCyiFIolI1EVDjGqnghZg98+vaDpOUEHv/yKCob4SXakjxtG/AKg1Ofwr6a8c8WH7ISGU347i5Vs0WsMpWDmQrzoD8JTd6v+XkKILBgG680LcwSKU8gUwQcmVM4nOnHas/wKAfU9kCEqck3W6u1eY2kolz6FxUKCnWTU7k/m+OUMWFtdc/ld0CWl5kXRsln18LC3uYr4KYsko0iuJ4K2P1wbF5+immMJ0y/mxZwG5OGzVo6xczVXFA0Jyqy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:21:25.2328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12eea9ad-3f65-41ed-ec88-08ded292bf81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907
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

retire legacy pmfw eeprom interface wrapper functions

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 98 -------------------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    | 21 ----
 2 files changed, 119 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index baa8cc3646d5..8c398c2e6709 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1740,104 +1740,6 @@ bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev)
 	return !!(flags & RAS_SMU_FEATURE_BIT__RAS_EEPROM);
 }
 
-int amdgpu_ras_smu_get_table_version(struct amdgpu_device *adev,
-				     uint32_t *table_version)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->get_ras_table_version)
-		return smu_ras_drv->smu_eeprom_funcs->get_ras_table_version(adev,
-										 table_version);
-	return -EOPNOTSUPP;
-}
-
-int amdgpu_ras_smu_get_badpage_count(struct amdgpu_device *adev,
-				     uint32_t *count, uint32_t timeout)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->get_badpage_count)
-		return smu_ras_drv->smu_eeprom_funcs->get_badpage_count(adev,
-									     count, timeout);
-	return -EOPNOTSUPP;
-}
-
-int amdgpu_ras_smu_get_badpage_mca_addr(struct amdgpu_device *adev,
-					uint16_t index, uint64_t *mca_addr)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->get_badpage_mca_addr)
-		return smu_ras_drv->smu_eeprom_funcs->get_badpage_mca_addr(adev,
-										index, mca_addr);
-	return -EOPNOTSUPP;
-}
-
-int amdgpu_ras_smu_set_timestamp(struct amdgpu_device *adev,
-				 uint64_t timestamp)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->set_timestamp)
-		return smu_ras_drv->smu_eeprom_funcs->set_timestamp(adev,
-									 timestamp);
-	return -EOPNOTSUPP;
-}
-
-int amdgpu_ras_smu_get_timestamp(struct amdgpu_device *adev,
-				 uint16_t index, uint64_t *timestamp)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->get_timestamp)
-		return smu_ras_drv->smu_eeprom_funcs->get_timestamp(adev,
-									 index, timestamp);
-	return -EOPNOTSUPP;
-}
-
-int amdgpu_ras_smu_get_badpage_ipid(struct amdgpu_device *adev,
-				    uint16_t index, uint64_t *ipid)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->get_badpage_ipid)
-		return smu_ras_drv->smu_eeprom_funcs->get_badpage_ipid(adev,
-									    index, ipid);
-	return -EOPNOTSUPP;
-}
-
-int amdgpu_ras_smu_erase_ras_table(struct amdgpu_device *adev,
-				   uint32_t *result)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->erase_ras_table)
-		return smu_ras_drv->smu_eeprom_funcs->erase_ras_table(adev,
-									   result);
-	return -EOPNOTSUPP;
-}
-
 void amdgpu_ras_check_bad_page_status(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 3c7fcce5fe8b..5e5275ae7aab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -165,27 +165,6 @@ void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
 
 bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev);
 
-int amdgpu_ras_smu_get_table_version(struct amdgpu_device *adev,
-							uint32_t *table_version);
-
-int amdgpu_ras_smu_get_badpage_count(struct amdgpu_device *adev,
-								uint32_t *count, uint32_t timeout);
-
-int amdgpu_ras_smu_get_badpage_mca_addr(struct amdgpu_device *adev,
-								uint16_t index, uint64_t *mca_addr);
-
-int amdgpu_ras_smu_set_timestamp(struct amdgpu_device *adev,
-										uint64_t timestamp);
-
-int amdgpu_ras_smu_get_timestamp(struct amdgpu_device *adev,
-							uint16_t index, uint64_t *timestamp);
-
-int amdgpu_ras_smu_get_badpage_ipid(struct amdgpu_device *adev,
-								uint16_t index, uint64_t *ipid);
-
-int amdgpu_ras_smu_erase_ras_table(struct amdgpu_device *adev,
-									uint32_t *result);
-
 int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
 			struct eeprom_table_record *record, u32 rec_idx,
 			const u32 num);
-- 
2.34.1

