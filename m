Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD84CD98F6
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 081E510E47D;
	Mon, 22 Jun 2026 04:43:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tORKTVii";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0DEB10E47C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJyVxuN4Yytm5IDA8caRcNDKigHUhd0a4CzX1VEofcF9zv6HFwaefXM4nol1SN+WAO422u1ioPEucrV3j+ADhOWc8/S4VbguLhT2nB32kZLxIkwinweKUxAosTu0EpxZTWVkjBpKrs422M/uKKHy6wpz2stSPcglOflCBpr/rM+4tHmzqUC+c/leevn5QOtNnuk8AhJqURxqtDn+RsHjYh0QXbX0Ja7/5Pu4+KRdIA4IecfiCZ2MiA5cxqjAkEfeR2ZBLp/RKjlC+85mn8ow5Kjf6K2KDA5X7dEZF34hBVYIZGBqCoMUaOk8La3uwkfcKLcQLY6T9fFDBt/dWSxKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHZmPRq6kAn8FYIrxbk4VfjCukYc94cC3riaDVcTxVA=;
 b=n3MvlVAtDUowbmiIFTmmccxozUFiPPvpSxl4OZFmFSxPUHhfvg9AwB9r0LiD71qKFgin25vhw0UrrDQyISBiiOmrwrREW4ojXJXMcIheGCrUaJfDxXO+rj7M79LLqsxYgOQ8HdBxu/SHfzxi9XF91Srt/ZDIZaD/f/emJufFyEXTjGLi2cDSpgZEFqcRTj6hZvNVdtRWJt+O7ZlpRetuXIodP1ARCybFx9puyUJR5NK/kR+2v3TMOM4o+2bEjVvsx3ZJ6mX5HeNnchrXFfXlSKpU/v6nBO4Q8Xex9LvxJKxKe66zxxkJt2m0ZBDOVxSBH9g7Te+BrrQWOLrz1TMoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHZmPRq6kAn8FYIrxbk4VfjCukYc94cC3riaDVcTxVA=;
 b=tORKTViixINIjI772RRf7z6culCsTFZVquTh9PAfGfJg3TM3x6pHZ7sjiCrV1yWCdbhLacc1Cu5kSy0GRQqEk4w5G2/gddf7NoDkIVFeduM9ZHw1lon4tisTuKpb1z6sFkPAbVEppT69hd9xpJZWyFtIePaROhO8Uuq969xaDWk=
Received: from MN2PR06CA0030.namprd06.prod.outlook.com (2603:10b6:208:23d::35)
 by SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 04:42:55 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::30) by MN2PR06CA0030.outlook.office365.com
 (2603:10b6:208:23d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 04:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:42:54 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:52 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 28/48] drm/amdgpu: remove legacy UMC v12_0 error address
Date: Mon, 22 Jun 2026 12:40:17 +0800
Message-ID: <6d87f29554cb3b5d30cc7c8baec73dabd83969c2.1782103074.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b0f03d-9768-4fa1-efbd-08ded018b9bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|3023799007|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: B4SotcEtTvW6Dg+Ua+C+SUhX6UPaaGgZVM1B1gEYAn+luBhscfw2PzItf5KUC3+dDZBt0pBxmGAP4vYwhVsgV7wwaS5fwNYxTwUUtBXJJuAn/RxARoIMe25MgKHtrd5NuBnIZjx2pE+Us2ItS8/IzPrz6A8D5dn+9bHR6tsEovSfw4/Y6hjzPDKnpKPLRBLi/SvaYw8TZvyfwCAKxkCBpOsSo09Wu+RhwXN4N88zwbFbbsISK9oLQETrfzKKwi2ZkhjGnZyrh2jjdoTjfxEzVoUGFobljuvGIR8HXbbk2YwWAZpXSO8QwWgKD4mwi13Qc9auSXKno2YmkbB8WhSj+/HtoOIcxuJwa5G/0DkKEJlzht6G8XBdWcGhKxTQp35iKf/d+v2NK/KtSPCcCcvWxA3HzSHmx4yAWWvJ6bV2rDjEYfvZcJRcpdmtiBd/j+h66TzphGp8/mLO3HKPcYOscEp/UXR24V9pqumvjtxxDlRlPH/OtTAx+T+B+ZiGBPGN0k5XIJBdMzepQUD7VHoA3IfDC7xFisOjjOj7UoZ/NxuqHpv4jOs1CUts3rtZaT7bU8UdQKLmRikWW7cz0lW9qd1WgrDzAwcGVXsFFO4sXRiIJkoHaWKMh1FeYv7TkpX4TMi/C+c3ojofKYC5MR0ZHrpkRO8NSHm9ujKIfltWhcrksrZ+/0+VHkmtc5e5fuUOes/QvzR1JI+G/wj3SVEwdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SCy99v7op0mQDHI0O/P63LgDfYSXl8z1pRkNIC7u91xmsdpoeO41D2c20x5vcUYPcNMYLC+BULhkTTyamN7nRskttAaIMUdqx7vDA5VXVJytfrRqZ7kXM4nmNAqSvZ7G7JCwhd572zu0tlhJhl99AZOTyGi6LOXeAFOZu/OizS1pH+UncKKs12/xfyv17KQuQ7AqMGLOa57JdUsma4kcWsc9c0zUsOVcVkf1M9uZXfCoJRnfMZoBMLfd0+NulgChVhrLVC5UjMsXQ580XxUrKKpqXwt9Xk5R/dTVqMjIGt/NY+EqAf0fCFNkrQFIhemO3IBVmzV8S8h+1ps3eBFyZqHtqB1V37p6IxRbLxzq5JcW4yaG+fn/eRZMgada3MMePTL0kms+SGrCOZ+Q2PXjEDX4o5QODFEHOwYLBzkaSbTaACpB5pFv5mpFsabTXMxC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:42:54.6712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b0f03d-9768-4fa1-efbd-08ded018b9bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669
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

remove legacy UMC v12_0 error address conversion

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 93 --------------------------
 1 file changed, 93 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index e1d900818a81..4d6197c0efb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -178,98 +178,6 @@ static void umc_v12_0_get_retire_flip_bits(struct amdgpu_device *adev)
 	adev->umc.retire_unit = 0x1 << flip_bits->bit_num;
 }
 
-static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
-					struct ras_err_data *err_data,
-					struct ta_ras_query_address_input *addr_in,
-					struct ta_ras_query_address_output *addr_out,
-					bool dump_addr)
-{
-	uint32_t row = 0, row_lower = 0, row_high = 0;
-	uint32_t col = 0, col_lower = 0, bank = 0;
-	uint32_t channel_index = 0, umc_inst = 0;
-	uint32_t i, bit_num, retire_unit, *flip_bits;
-	uint64_t soc_pa, column, err_addr;
-	struct ta_ras_query_address_output addr_out_tmp;
-	struct ta_ras_query_address_output *paddr_out;
-	int ret = 0;
-
-	if (!addr_out)
-		paddr_out = &addr_out_tmp;
-	else
-		paddr_out = addr_out;
-
-	err_addr = bank = 0;
-	if (addr_in) {
-		err_addr = addr_in->ma.err_addr;
-		addr_in->addr_type = TA_RAS_MCA_TO_PA;
-		ret = psp_ras_query_address(&adev->psp, addr_in, paddr_out);
-		if (ret) {
-			dev_warn(adev->dev, "Failed to query RAS physical address for 0x%llx",
-				err_addr);
-
-			goto out;
-		}
-
-		bank = paddr_out->pa.bank;
-		/* no need to care about umc inst if addr_in is NULL */
-		umc_inst = addr_in->ma.umc_inst;
-	}
-
-	flip_bits = adev->umc.flip_bits.flip_bits_in_pa;
-	bit_num = adev->umc.flip_bits.bit_num;
-	retire_unit = adev->umc.retire_unit;
-
-	soc_pa = paddr_out->pa.pa;
-	channel_index = paddr_out->pa.channel_idx;
-	/* clear loop bits in soc physical address */
-	for (i = 0; i < bit_num; i++)
-		soc_pa &= ~BIT_ULL(flip_bits[i]);
-
-	paddr_out->pa.pa = soc_pa;
-	/* get column bit 0 and 1 in mca address */
-	col_lower = (err_addr >> 1) & 0x3ULL;
-	/* extra row bit will be handled later */
-	row_lower = (err_addr >> UMC_V12_0_MA_R0_BIT) & 0x1fffULL;
-	row_lower &= ~BIT_ULL(adev->umc.flip_bits.flip_row_bit);
-
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 5, 0)) {
-		row_high = (soc_pa >> adev->umc.flip_bits.r13_in_pa) & 0x3ULL;
-		/* it's 2.25GB in each channel, from MCA address to PA
-		 * [R14 R13] is converted if the two bits value are 0x3,
-		 * get them from PA instead of MCA address.
-		 */
-		row_lower |= (row_high << 13);
-	}
-
-	if (!err_data && !dump_addr)
-		goto out;
-
-	/* loop for all possibilities of retired bits */
-	for (column = 0; column < retire_unit; column++) {
-		soc_pa = paddr_out->pa.pa;
-		for (i = 0; i < bit_num; i++)
-			soc_pa |= (((column >> i) & 0x1ULL) << flip_bits[i]);
-
-		col = ((column & 0x7) << 2) | col_lower;
-		/* handle extra row bit */
-		if (bit_num == RETIRE_FLIP_BITS_NUM)
-			row = ((column >> 3) << adev->umc.flip_bits.flip_row_bit) |
-					row_lower;
-
-		if (dump_addr)
-			dev_info(adev->dev,
-				"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
-				soc_pa, row, col, bank, channel_index);
-
-		if (err_data)
-			amdgpu_umc_fill_error_record(err_data, err_addr,
-				soc_pa, channel_index, umc_inst);
-	}
-
-out:
-	return ret;
-}
-
 static bool umc_v12_0_check_ecc_err_status(struct amdgpu_device *adev,
 			enum amdgpu_mca_error_type type, void *ras_error_status)
 {
@@ -332,7 +240,6 @@ struct amdgpu_umc_ras umc_v12_0_ras = {
 		.hw_ops = NULL,
 	},
 	.check_ecc_err_status = umc_v12_0_check_ecc_err_status,
-	.convert_ras_err_addr = umc_v12_0_convert_error_address,
 	.get_die_id_from_pa = umc_v12_0_get_die_id,
 	.get_retire_flip_bits = umc_v12_0_get_retire_flip_bits,
 	.mca_ipid_parse = umc_v12_0_mca_ipid_parse,
-- 
2.34.1

