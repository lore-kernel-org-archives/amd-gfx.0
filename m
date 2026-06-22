Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7C4CDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4203010E467;
	Mon, 22 Jun 2026 04:42:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DdTxJFhh";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010050.outbound.protection.outlook.com
 [40.93.198.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E9AB10E463
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KR97xXMdxRHuCxOsouqlHY98UDIHVyYGkqK4Ey+V0tt9//mnilX9EVSp1z3KSQCfbjnaTx9LJ1mrWYNLrqaZbaToniUhEUASY+lFRoTGWswlVJ1mvF7PyilkD7e7ryIDnqXsejrAxE+HnWg0UZzsPXIIK0W/IeNQCbE8egFZ5zpi2KbQZWS3fuL4SdsJD7K4y6/2UZb41DqfuzyDvLAUMkjHIgc6ND4hBWe5H3SfsPZfbtgPcockaCKdKfP75GoVYWAtKTulkZWppv6Gge2RhEMU634czbTN+Gw/9UKTVCUfAVkM959iROEnXUQ0s3n0ThVIY9K6uTkoMXlWgGaFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BWElpiMy147FRVdUfJVAL7KsjECB+zX4RQClIIS8Nk=;
 b=dZsQpMXA+g4sybttnvEOIMX7r1L+6ddNMA0IXmF3cKo9ISSxnApHnGZp01n6vpeRoi7mSMDarcCva+fek4NTSn3w5P1bYv8JiRNmKvn+gXAM6xDM+7dtT2NmnY9q14EJZ26ffypT1VLlvhmikfFUA5OL0WjuN8LgCRo4OqXkO+W9HlZqXCuzXwQlwMXxvqxOH2t9RQ/PeBojZ28XD8q/h+ziUHVRMSB4xG0IxIfqij8WeJbJgjwsCsKjTaxSFpnHRepWDSQMiPE9es6js5DLYOzdVXm0NkUF89AzJGHMmpkhYUG7ohF9+15pE4mlbDLQrev5Fu4QrniaVqP8tsoBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BWElpiMy147FRVdUfJVAL7KsjECB+zX4RQClIIS8Nk=;
 b=DdTxJFhhKbn2x92WIUdFtiTIKOcLzWd9C0+UWBc4sQsvDzAAn+LZn6lqQ8ye/OgS5Ug3P3eY3pqI0mE+FMRBvj7PHbAYUyX445wNGNVl0YHSFV7B57yxC8wmWQk+kHXbw3VHTD8VUyxnk++8VDjX5zGvpQZpVXIiusV4awqeDuY=
Received: from BL1PR13CA0417.namprd13.prod.outlook.com (2603:10b6:208:2c2::32)
 by SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 22 Jun
 2026 04:42:15 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::92) by BL1PR13CA0417.outlook.office365.com
 (2603:10b6:208:2c2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.11 via Frontend Transport; Mon,
 22 Jun 2026 04:42:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:42:14 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:13 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 06/48] drm/amdgpu: retire ACA support for vcn v4.0.3
Date: Mon, 22 Jun 2026 12:39:55 +0800
Message-ID: <00c5242919997a81fb8d08ddd66046cd3a1db0ac.1782103073.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc4c8e5-27d9-4f81-acaf-08ded018a1e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SgfXZLiAPl8MTe0t2kAffvqc0Gpo0KBmovJjBzBGNwxJj/+J/N2olAnPO3oomh/JfbYFIDkdAPUO60AwWkJZrwlWAZ6684A7IAWZfFmzi491yeDodx/1sOa1ayR4vmAqu6purrkHC65H/lmCl6M2chWbdo/TgawvvR+jU0Ya4AjFISQveHO4652KwBvJxg4yJASZQQtS5zkNAeP/n37BiPxqL8VZmG/KdJEVdaxjQIccQ7pqaP/Mw439uU8nPzc3XxVLI+f0hi9UVWtVG4EwHwX9Yd6be7mamSfhS2SSiuOBcVyeeVaXeZdwp58D8ftN5sc5Xu5CiVHlSOb9SgB4O+0Ca+ZB6ju2P000lXCGIxiYB0IH/SGSRqwkRkTgTad1B26DAxY84goeGkIoUVAmbO0WpjPGLZqXER6zRKCldfRiz7zdL38IaZmwdZIJU6Uxuuu3GdVeREmhYbvL/NcbDz7gEHFiVf7fgTsH49p9Y+TYGlzTP2I7ToDAMEi9EnXcvo5/DOg7KWGSBa1CJwABpgx1keB8sisaY8VyQpEsPjfcV4FF+oomnWlVX+lsnAe+L2TF6XfXQ5TcGbQ8GgPv/ry9ZEu4BG+QR4tGZPfDIjSQP2eKZBM3DukTPuWvT/TdWTPooeGfUnuzXMt9sN69k9QBYnrp+zM/5S4zvgHAtpsuC5xlax0eBmVWv9cGvOTZcN5VHZXd/r9dFzfi9miJ3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kF3PJrpbDtDenR0Xk3N1ECYgGyCxwaR81tBU9nT4sWR/WFfV7nYtCuEm2cSsNkHvBG8mCiIq7Ntx0wCir7+mbDWMYnpiU11Vq88gy2X9m1w/J1f3kwL+Qo+lBoXvh+pud/NXsc3XDcr3xyYttwnf2mvOajV+TilNt8J/aVbWji6lcqJosg/RpBs92kUvzMC9m1EhxgumH8adcpIUFY1jnw8+EgRArGfKFu8ir6FKMr5FktI5WPaWMqx2WpbTJ+sKmXY1PaCPVm3uVCiivZIzaeePGqoXerV9xATpgnn472+h9gZxfyqaE7s8Kv872D0QrYnD3WqdlzjIkZnvb/LlAmHUgIMgWQHWn7QGiYaDALwfm1HWkr09MVLaNCPYyS18oOG4p7SeHHOsWoubBIpW+EOzI86VPpzBzXVm+REoqEsASgDbqIpwgaSrS63p83oz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:42:14.7052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc4c8e5-27d9-4f81-acaf-08ded018a1e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438
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

Retire ACA support for vcn v4.0.3

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 94 -------------------------
 1 file changed, 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 3c3f3d1a040d..728946911f00 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -2163,103 +2163,9 @@ static const struct amdgpu_ras_block_hw_ops vcn_v4_0_3_ras_hw_ops = {
 	.query_poison_status = vcn_v4_0_3_query_poison_status,
 };
 
-static int vcn_v4_0_3_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
-				      enum aca_smu_type type, void *data)
-{
-	struct aca_bank_info info;
-	u64 misc0;
-	int ret;
-
-	ret = aca_bank_info_decode(bank, &info);
-	if (ret)
-		return ret;
-
-	misc0 = bank->regs[ACA_REG_IDX_MISC0];
-	switch (type) {
-	case ACA_SMU_TYPE_UE:
-		bank->aca_err_type = ACA_ERROR_TYPE_UE;
-		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE,
-						     1ULL);
-		break;
-	case ACA_SMU_TYPE_CE:
-		bank->aca_err_type = ACA_ERROR_TYPE_CE;
-		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
-						     ACA_REG__MISC0__ERRCNT(misc0));
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
-/* reference to smu driver if header file */
-static int vcn_v4_0_3_err_codes[] = {
-	14, 15, /* VCN */
-};
-
-static bool vcn_v4_0_3_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
-					 enum aca_smu_type type, void *data)
-{
-	u32 instlo;
-
-	instlo = ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]);
-	instlo &= GENMASK(31, 1);
-
-	if (instlo != mmSMNAID_AID0_MCA_SMU)
-		return false;
-
-	if (aca_bank_check_error_codes(handle->adev, bank,
-				       vcn_v4_0_3_err_codes,
-				       ARRAY_SIZE(vcn_v4_0_3_err_codes)))
-		return false;
-
-	return true;
-}
-
-static const struct aca_bank_ops vcn_v4_0_3_aca_bank_ops = {
-	.aca_bank_parser = vcn_v4_0_3_aca_bank_parser,
-	.aca_bank_is_valid = vcn_v4_0_3_aca_bank_is_valid,
-};
-
-static const struct aca_info vcn_v4_0_3_aca_info = {
-	.hwip = ACA_HWIP_TYPE_SMU,
-	.mask = ACA_ERROR_UE_MASK,
-	.bank_ops = &vcn_v4_0_3_aca_bank_ops,
-};
-
-static int vcn_v4_0_3_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	int r;
-
-	r = amdgpu_ras_block_late_init(adev, ras_block);
-	if (r)
-		return r;
-
-	if (amdgpu_ras_is_supported(adev, ras_block->block) &&
-		adev->vcn.inst->ras_poison_irq.funcs) {
-		r = amdgpu_irq_get(adev, &adev->vcn.inst->ras_poison_irq, 0);
-		if (r)
-			goto late_fini;
-	}
-
-	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__VCN,
-				&vcn_v4_0_3_aca_info, NULL);
-	if (r)
-		goto late_fini;
-
-	return 0;
-
-late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
-
-	return r;
-}
-
 static struct amdgpu_vcn_ras vcn_v4_0_3_ras = {
 	.ras_block = {
 		.hw_ops = &vcn_v4_0_3_ras_hw_ops,
-		.ras_late_init = vcn_v4_0_3_ras_late_init,
 	},
 };
 
-- 
2.34.1

