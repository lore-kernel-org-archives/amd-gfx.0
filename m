Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4086DCDE002
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B901110E18E;
	Thu, 25 Jun 2026 08:21:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S1IDl8ay";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A790F10F190
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQ7g2FGHArL/TkDhrurH2JxVOKesLeffutN52ILefGsBOD6v60h/FYU6V0G37jXYFQy8cdA12K7Wbmk8f7kdAuOso/aqDDT4mbXeptjV+jIFRkmIzA3b5KaRMmmT2GUKdZR1oV1oP6MTstXSVH0t1XcMBxQiHavBlG/nkS4y9fItOz+kO4IT+ljcGJkCsM8UhyPlOomqhTJflAoM4SeaIMPewlOBH0wiCzKxLrSDcQMQLGv6ZKTT+80trCdUuf4kIx+BgYlgQrDpYlS9jIKRyGuySL0EWZaC3y1PbUKknD9ogRPIbHl+x1NvzBi5ly8TvxhrsSSe8fnPn85jVKZCMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHZmPRq6kAn8FYIrxbk4VfjCukYc94cC3riaDVcTxVA=;
 b=NRKE/AISfx1GlOw96TloFjtrlNX7s8qAEhMg9sQ/9KS1TMMySae0GTJSDJ3FetV+FzrroyHn/Bk9d0iaMtD3vVtR2DEosko1YloQyBBPJZYX/eng03xlZoo5u52seAlqmk9gN7zS9Kv56lHj8Qs2r4CuGN/8+Vm8foC7rQ6NtriQiOttD49Ne6ppcLsX0QdGTep/kb30FUM6lwHvzJafXfdJrphJQe2VnO7d4dLor8R0cqToHixn/SvDue+FtBo80oaaghdQyWFpv4YvdVTpdEbyhv4Jl2EOjWzwKf/VXqWlDPBq+bUAmCpqvlf4dQoMtnjRyS+q7OHwx7wfR2/c7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHZmPRq6kAn8FYIrxbk4VfjCukYc94cC3riaDVcTxVA=;
 b=S1IDl8ayo8Y5rxiHhEj1yWd4cdprvkEHEwEjY4ra2WHBm2zYzv4A1GlhWB6vS0DGI7zvOlb4qx9oU7d6firF7eeDefV/zf/lunB0oJ/YbG/GI7oH50k9D5oPnA53dzWUJbho1c2ydk2Lojw5yJVcylH2chPtFq5orgngtrDR8go=
Received: from PH7P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::32)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Thu, 25 Jun
 2026 08:21:02 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::59) by PH7P220CA0021.outlook.office365.com
 (2603:10b6:510:326::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 08:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:21:02 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:21:00 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 26/44] drm/amdgpu: remove legacy UMC v12_0 error address
Date: Thu, 25 Jun 2026 16:19:19 +0800
Message-ID: <8e42c01e83dd5822de93368dfc88006cea2ebbb2.1782373702.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|PH7PR12MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 30756f89-9670-4a60-64df-08ded292b1b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|56012099006|6133799003|22082099003|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: jrAn5Nhsufx6+MOmyUht/SUFRIA44CkkB7PHvhUfQAn9mi6OAX/AutvC96O/ghXXT/XWipPVkLevEXiSS/d0dothexp5PJp0zIeWrjTPAJXP1BKQXE+xR62FiJOJB83UbYYOSYYelHvIjUbQuR+/jDfHEIEaZgo6mFVwSmfW3vWyJ8hrsYFvG1D2tfkPfG+FO37zzpCc+EYICOYMGQButMhqejiL17W21pujFVUGvG84gY1OUNIboSykEX9he0KzUPhXo5ItJ/FKZgxK7XpsmIkDLtFDV0nZEP7otMQhZgtbPivC9V4U4T58bIaojoZU5i15W8Z4oZNKL0gKGxhxczProBmzQKDF/0RslgT8HmqWEWXWxhPvzUvxGTGORq+3XbR6YJHG9G35DFFMwg8yS8EOsl6LSxwbrMRJNJ7lJKS2OhNU7n2sKzXyBc1B6tFKCgtTUCvab0X64ZHYe+jzW+e4kgpr8houg3BmoKtfnYVMfETr5lpDNsz7DdIf0PF/43Ii4g1BPjDRYjbkas9UHT0sxwUgSjwPZWuGQJEcluHV6IBnscbl7Tx/7OxfLk9h6TBTkQS4eYwnF92CeT7MeklBL86Buwo4dPRYZjiLklJVh/xJEZp0TZhrFq9rGB22kxjBy19W/PYIf2Q14+G7hKMDwMTyMUX7alYzluPUGT4aCd9jrPD50tOQxdyVC77iz1ThvfAW79qQfEXGUrKZig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(56012099006)(6133799003)(22082099003)(11063799006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PIkDS3N6nvRjOFjbyChrd/IswXm4kf9bmBRr1lG8st+RZNcsTTuAqcOGtoj0izIXRYLBPv9MwAL+v7E6uUGyiRLMAoKG+MFm4JsFrTBoXTzhOKjYYbGOqW9PhwQSN60R6jOEVYFoEmsSSue0Q5Oxv7ftGPjDtldULjUUeegLuUUyp3IzXcOtRRSs6MG+vmMrP3UTY0uB1opf6b5EDhDI4QTCd+nG60fkk8USxcg5zcX71w9lIFJv2Gd3I4ToEkOYTwpEGKZCDF2lzkj6H3Sdf2sOFJRYP0UzHVwsZFf4SBW5ajzokv5JvTmZ+PaRdU/M6zitdDIa4J4AdUBdzwekHulbRvcbjOiAc1dXqviOakYPHf5VtZbJmaAmqksHJNYHcVn3QcSnqNC5N0uDdqMij7m0+ZPBlRaj+eu7o9QZ2jyeNYRaT0e3tfv7JlV+2djG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:21:02.1024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30756f89-9670-4a60-64df-08ded292b1b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260
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

