Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0285ACDB471
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94D0310E565;
	Mon, 22 Jun 2026 08:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IEJSTn2P";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29EA110E572
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/giwOSl1TumxQUrpkwtStojlR+EkoFFZ3v0eYq9+N7GtxWSPF/1n9ay8OwlPsUe37p6KfHtc/UoJF0phZKUIg/xhigf1k7WhzR0vu1xydi21qaTIz5yMnmEWjheSrOOEbqTjD/DADdygnpqEOtNlGdpSF3sQ3XFiBDu0xWZU5oxVajQpSCayj3m3AlWVq3nmqgr1WC5tbGrY4rzbAnK+6tOXbB/UFgfW2SiXjs2YKjom/bVFZ8m2pRnt+DtQxy6IzzT8yweHzQ5sAPtGQGO2yoRixgA+m9zagnmqhzirgYcdbhGVaMF0Lumg0ic6IlJrfTF3BWrDI6L3mZn4sfWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHZmPRq6kAn8FYIrxbk4VfjCukYc94cC3riaDVcTxVA=;
 b=Qu7fXu/WcvutmL7tJxtzK3Z4UvsWb2XZZA7JxWRKm9BDCVYFWBKnuhGZ87zLLiepY+4J9WhIefQLVfwQNeCUvKEo9pAQu3WfgRxvoJLpOMi1R4G0YVL0P27yR7iN7oNKCTrSRHHm8Mb5GtmYJdyt3tarLyq6CTIgc6HriKBbxWjFyaA9pbmutllY8CsuX73S4QsqiUe8+O5XLKYIQn543mjAb3f99mFut5AFDEhbnMwjQ0nqCw5vrBzt3LQdQs+ZlnV/HNJS0jgc7kIjrDVGoS18+ynXO6Of6yVDnXrQJbGK7L/QVSeVMFUONGPs1KmgOg3sHs0iZAj151sMWGkXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHZmPRq6kAn8FYIrxbk4VfjCukYc94cC3riaDVcTxVA=;
 b=IEJSTn2PrzMph+2LyoeSR6Lp9DwV2kn9G8mjkBFgmn+y2lRKV4AZ2eDHmJeOzKbDm7vkiRSUOasIDZnbkSHhBcczSGVpB801PB6sFVEr5bKH7Mlz2qfRKHLVTU7WYhRnEO/jKbOOs/w/bURYCrvcCC1tzQw3jypGCjm9G+g5zjo=
Received: from PH8P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::22)
 by MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 08:46:06 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::14) by PH8P223CA0027.outlook.office365.com
 (2603:10b6:510:2db::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:46:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:46:05 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:46:02 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 28/48] drm/amdgpu: remove legacy UMC v12_0 error address
Date: Mon, 22 Jun 2026 16:44:30 +0800
Message-ID: <09eec649a7d4577e4f4b5fea8d76437c29bfaf39.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|MW4PR12MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: 76427b74-f342-47d4-6892-08ded03ab2d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|3023799007|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: M2Xk+Ii4b0+iGEK9aqpo3YZS8qiWM4SBHSmnbkOJ4pBhK51zJMuIdzxUtxck8XL/rMNSsSgyiNiMQ/GDREoz63YdThiur9MJlz3JCrkOlEbjk9lGGoP2J7XOGYFW50EHnbR5NVzQ8pw5s5IJA9eU/UsDRA3lJt+B81RsDHz7COHJ1V6CDYJMJZMjlQLzWt6JZw3ewW24W0S19PhrOVrtq3LUPuuXOV76f+PsGodT64LM24+Ch53z/XYYVimDJZQYk8mY5G8Ued8tg5+AVGvdHH2563hptut1US/RJsV4woTX8ebzZ4lnDCWgAaP2p/RJmR3RHkzsCE/dpEfFjkzZ2IDXRdtflSuWyPgNm6dfEJgYILnEAYsDhX34DgzH4BaFI+jLf+jhNfmFfgBnbFSe5FsgdgvCMdhy8lo+2sAjIMPhvFS8I9JJ0EyrFR7ie9ivchOJrCTVNUOzoHhfJEh48ACedSscTM/RNO22EhJ+NoQz3IhKVCorfkMnsRVyLeEwK9g4Eo+4wuMBW05L1IvURFKKDn8a1y5mPWDNIphiHwTdTG9mJkK/NKtaOnqDzc5cySyCCmz+N2rL+9HTh0Da5nC2nNbCdsabSLdyN7XRpnZvaw+Q0FOj5qu9W8p1gI5wfGKht8aZYnZ9kXyGPNNaCnpQMuf2c53IvCFrah3Ge9Zd+6SnxlVirchxHOSayGCr5+PfLoIsGLx6GxSpUfyuOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(3023799007)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jbLn0UDLB8d4Z7gk6wVs15VbG+jN/BKawdiTLCPY1eomDOVX7Xqf4kp9QkOw5E1IAdWeOx6030X3e8SakwhoZgbqWXWl/lzvOqMsxzELa0HsjfIgfk/4Xjn0YfZ1knQruf5fRsmj6YEHoF2HFIEdrYuygWkzRJyiiQ02p4Fw2iiXHLvnmd8I49LVov/SuEVAYrcZbAiE43kwazNmO63+zSVzzjuZa5owQt0iCC+1F7S4nKgJQjO2cQKe7hzA0059mW4VFYhYu3Sod31ImnJ8uQOdcD+Q5/bdVVX7M16ZXthLeqp76N4pru2vitNwLsK7CImjybuXd+hf+0SaeV3O3OHf/zjvd4uiOawgWaPE4JVbk1zDdGWqZwq6FvJaUgOJPFWqVz5JQGQRTY9JOu/680jhSLb5gZSYHxSX9+gd3tPU8OVFRrOdnoICLRbJl1hp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:46:05.9061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76427b74-f342-47d4-6892-08ded03ab2d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6754
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

