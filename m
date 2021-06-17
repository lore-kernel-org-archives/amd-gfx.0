Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0FDC2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 19:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03634610CD
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 19:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03634610CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB056E9A4;
	Thu, 17 Jun 2021 19:25:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD56B6E9A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 19:25:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H83hSAk+++1A4ub1R1AnnWVROlykZ45Wv9CNC5wlvVwSpwbEn3JJIsVskokOVhI4gfsylVn3IAopzgUQpU7GQQBrSdAx325f5MyvTGOFQiKqDTSQGUbEH2F+sqeJZQsjPNO/ge7nhoBHGIw13BCpC5KwWBEmk5t0hBbGaMYSkiUlU06jRkevHtCpcWwCsN5BbppUybMIXLUB2dpM3ok3As2HrvU8uCgb58y/+xI4mlJvsQeT1gWT6f6SGrQKxWVChV/QfLmGx7wuHdzNoEI1lmYspe+vc15WhGdcSko9SH3avJrjxpOFGRg34/z55xrJyRuU+dFO22IO9+iLJhCyEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HghwSLpcnHtQ64vj0mqaR1Rr3Ra4RlGz/nAVgJBGchk=;
 b=F9BKZ4kGPek9a3MmWFZlxSORTBeDB3XQ6EZiloouGR1fUdkJe6+gZxgkPQys9yTWw+mPkq+c3V2CgvlX4j8kLdJxk2ULfbH/xvVka0+JvSfr7Im+kJsv1x+UpdlbCVXhvfc7VS9ku7SOL6T68FnHYYRb7ZAQT/sP+ZBWXdSBDFANH0H6vrSMoUrnFgWGzOZd/Az7e4MPJifVDBWYnihvDHemVFO7PoQWDgBWh4MUK6F6nRG/uOeLMlgqfy17Gi6wAWZV8FKsgnjWxobNGCVlkHhdA/4vsrBW2Ofyvok5XuH0ieYubS/w8IPjvJAgrumIjly0ZwboAUb+G6nnG0BqBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HghwSLpcnHtQ64vj0mqaR1Rr3Ra4RlGz/nAVgJBGchk=;
 b=LlhFexwtWn+dldNLYtm8sA0wcU/3R/i6V8bcMxVmKjFGRel0DmpoAgdSU4613FLTcesE/rM9t6kvgWNe3C65/nbp58achazUICRvjOrNMf8Sagj4hVHYQqUK7Ml0If6TTjj7hVLEaanRVgALufWX+1XD+clY8jvBR22anwdcGi8=
Received: from DM5PR07CA0130.namprd07.prod.outlook.com (2603:10b6:3:13e::20)
 by BL0PR12MB2433.namprd12.prod.outlook.com (2603:10b6:207:4a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 19:25:51 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::8e) by DM5PR07CA0130.outlook.office365.com
 (2603:10b6:3:13e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend
 Transport; Thu, 17 Jun 2021 19:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 19:25:51 +0000
Received: from rocm-perf01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 17 Jun
 2021 14:25:50 -0500
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH umr 1/3] Improve handling of non-standard page tables in AI+
Date: Thu, 17 Jun 2021 14:25:38 -0500
Message-ID: <20210617192540.4272-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6dff01c-b445-441a-52c4-08d931c5b7e9
X-MS-TrafficTypeDiagnostic: BL0PR12MB2433:
X-Microsoft-Antispam-PRVS: <BL0PR12MB24330B32C5C16C28C8DDA62EF90E9@BL0PR12MB2433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S2I4Eey1WRf4adY4GhJwqIATfaMIdadfQxsVMn66jqqmKr1w3fjtEE1tWyhndliI6CD9Nnl8f35zy0xMDm+fEayDhQWDmss3OlkZaFA/WdYqT6pM2Z8bhBN3JwczAgzxkUF7edKsozfgj+aLrbhJ4BZ24duu955HOSUq/XknIgwLV0omUV4BJIgDyptNZsqNyAq+tmALRdYU3ljOtOm7E9XmfbTJmbYKerHpYbm0WJvHrLyOm0OrqCpaPWGTQGi1hbyFsyjCg8a+sbsBYHJ5sYk8A3+KkyK4QTcebBY0/eizUc16Y4YpTJgKDbI/ev7TkatVCyD8poTHArKMZY89tFpx0tPQxW+vRocKF9FINUErou1LPJZ2AtHdSO1GijJ+KlQ05wOlgkRVQK8Qz5m2LkrzcSNml2g4EC4I2LsYj0FbTYEaxJ9X+jP5LCpGUknK1Bk0JSMl7RCFISFpwWlV7O7jjG7RZXKgRIjL5/RONf/kbLMsbm2CxTB2mrVirBi44EekmLCK7AqDUxDogfdfLkzYzo/ThzeWoc1y6dvHe7ru9c2b0RUUeQ5399YLWQSu4JO+cHp/9MiJWTtRyMv6ZyrxLKCjTHqcISZSuxlWFZVHQIExFyJRHNY8FJnDvMRbUNY22XHnCZ4U26ZtBDHpcT9GEHvFriGMHcORm50yhcCTZMbYXbr2ekRS68vr2r+I
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(36840700001)(46966006)(70586007)(54906003)(70206006)(426003)(82740400003)(336012)(30864003)(1076003)(36860700001)(16526019)(81166007)(82310400003)(356005)(47076005)(6916009)(83380400001)(86362001)(4326008)(2906002)(478600001)(316002)(8936002)(186003)(8676002)(6666004)(2616005)(19627235002)(7696005)(36756003)(26005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 19:25:51.2426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dff01c-b445-441a-52c4-08d931c5b7e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2433
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
Cc: Tom.StDenis@amd.com, Joseph Greathouse <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes handling of GPUVM page table decoding when not using 4-level
page tables with 512 entries per level. This includes:

- Calculating actual size of top-most PDB based on total VM range,
  page table depth, and page table block size.
- Calculating size of PTB based on the page table block size
  and the PDE0's block fragment size.
- Handling PTE offset and masks from from PDE0 with P-bit, normal
  PTBs, or PTBs from a translate-further layer.
- When using a PTE with F bit to go one layer deeper, pull new
  block fragment size out of that PTE to handle further-level PTBs
  of non-standard sizes.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 src/lib/read_vram.c | 199 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 153 insertions(+), 46 deletions(-)

diff --git a/src/lib/read_vram.c b/src/lib/read_vram.c
index efcd081..049acd4 100644
--- a/src/lib/read_vram.c
+++ b/src/lib/read_vram.c
@@ -297,6 +297,26 @@ invalid_page:
 	return -1;
 }
 
+/** round_up_pot -- Round up value to next power of two */
+static uint64_t round_up_pot(uint64_t x)
+{
+	uint64_t y = (64ULL * 1024 * 1024); // start at 64MiB
+	while (y < x)
+		y <<= 1;
+	return y;
+}
+
+static uint64_t log2_vm_size(uint64_t page_table_start_addr, uint64_t page_table_end_addr)
+{
+	uint64_t size_of_vm_bytes = page_table_end_addr - page_table_start_addr + 4096;
+	size_of_vm_bytes = round_up_pot(size_of_vm_bytes);
+	// Find the highest bit set to get an estimate for log2(size)
+	uint32_t vm_bits = 0;
+	while (size_of_vm_bytes >>= 1)
+		vm_bits++;
+	return vm_bits;
+}
+
 /**
  * umr_access_vram_ai - Access GPU mapped memory for GFX9+ platforms
  */
@@ -304,17 +324,19 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
 			      uint64_t address, uint32_t size,
 			      void *dst, int write_en)
 {
-	uint64_t start_addr, page_table_start_addr, page_table_base_addr,
-		 page_table_block_size, pte_idx, pde_idx, pte_entry, pde_entry,
+	uint64_t start_addr, page_table_start_addr, page_table_end_addr, page_table_base_addr,
+		 page_table_block_size, log2_ptb_entries, pte_idx, pde_idx, pte_entry, pde_entry,
 		 pde_address, vm_fb_offset,
 		 va_mask, offset_mask, system_aperture_low, system_aperture_high,
-		 fb_top, fb_bottom, pte_page_mask, agp_base, agp_bot, agp_top, prev_addr;
+		 fb_top, fb_bottom, ptb_mask, pte_page_mask, agp_base, agp_bot, agp_top, prev_addr;
 	uint32_t chunk_size, tmp, pde0_block_fragment_size;
 	int pde_cnt, current_depth, page_table_depth, zfb, further;
 	struct {
 		uint32_t
 			mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_LO32,
 			mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_HI32,
+			mmVM_CONTEXTx_PAGE_TABLE_END_ADDR_LO32,
+			mmVM_CONTEXTx_PAGE_TABLE_END_ADDR_HI32,
 			mmVM_CONTEXTx_CNTL,
 			mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR_LO32,
 			mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR_HI32,
@@ -461,6 +483,12 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
 	sprintf(buf, "mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_START_ADDR_HI32", regprefix, vmid);
 		registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_HI32 = umr_read_reg_by_name_by_ip(asic, hub, buf);
 		page_table_start_addr |= (uint64_t)registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_HI32 << 44;
+	sprintf(buf, "mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_END_ADDR_LO32", regprefix, vmid);
+		registers.mmVM_CONTEXTx_PAGE_TABLE_END_ADDR_LO32 = umr_read_reg_by_name_by_ip(asic, hub, buf);
+		page_table_end_addr = (uint64_t)registers.mmVM_CONTEXTx_PAGE_TABLE_END_ADDR_LO32 << 12;
+	sprintf(buf, "mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_END_ADDR_HI32", regprefix, vmid);
+		registers.mmVM_CONTEXTx_PAGE_TABLE_END_ADDR_HI32 = umr_read_reg_by_name_by_ip(asic, hub, buf);
+		page_table_end_addr |= (uint64_t)registers.mmVM_CONTEXTx_PAGE_TABLE_END_ADDR_HI32 << 44;
 
 	sprintf(buf, "mm%sVM_CONTEXT%" PRIu32 "_CNTL", regprefix, vmid);
 		tmp = registers.mmVM_CONTEXTx_CNTL = umr_read_reg_by_name_by_ip(asic, hub, buf);
@@ -495,6 +523,8 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
 		asic->mem_funcs.vm_message(
 				"mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_START_ADDR_LO32=0x%" PRIx32 "\n"
 				"mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_START_ADDR_HI32=0x%" PRIx32 "\n"
+				"mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_END_ADDR_LO32=0x%" PRIx32 "\n"
+				"mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_END_ADDR_HI32=0x%" PRIx32 "\n"
 				"mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_BASE_ADDR_LO32=0x%" PRIx32 "\n"
 				"mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_BASE_ADDR_HI32=0x%" PRIx32 "\n"
 				"mm%sVM_CONTEXT%" PRIu32 "_CNTL=0x%" PRIx32 "\n"
@@ -513,6 +543,8 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
 				"mm%sMC_VM_AGP_TOP=0x%" PRIx32 "\n",
 			regprefix, vmid, registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_LO32,
 			regprefix, vmid, registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_HI32,
+			regprefix, vmid, registers.mmVM_CONTEXTx_PAGE_TABLE_END_ADDR_LO32,
+			regprefix, vmid, registers.mmVM_CONTEXTx_PAGE_TABLE_END_ADDR_HI32,
 			regprefix, vmid, registers.mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR_LO32,
 			regprefix, vmid, registers.mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR_HI32,
 			regprefix, vmid, registers.mmVM_CONTEXTx_CNTL,
@@ -535,10 +567,6 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
 	// transform page_table_base
 	page_table_base_addr -= vm_fb_offset;
 
-	// convert some defaults to actual values AFTER printing out to user
-	// page_table_block_size of 0 means 9 (512 entries)
-	if (!page_table_block_size)
-		page_table_block_size = 9;
 	pde0_block_fragment_size = 0;
 
 	if (vmid == 0) {
@@ -593,7 +621,9 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
 
 		// defaults in case we have to bail out before fully decoding to a PTE
 		pde_cnt = 0;
+		ptb_mask = (1ULL << 9) - 1;
 		pte_page_mask = (1ULL << 12) - 1;
+		log2_ptb_entries = 9;
 		further = 0;
 
 		if (page_table_depth >= 1) {
@@ -608,8 +638,23 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
 			// AI+ supports more than 1 level of PDEs so we iterate for all of the depths
 			pde_address = pde_fields.pte_base_addr;
 
-			// TODO: Should "page_table_block_size" just be 9 to account for potential PTB1 selectors?
-			va_mask = ((uint64_t)511 << ((page_table_depth)*9 + (12 + pde0_block_fragment_size + page_table_block_size)));
+			/*
+			 * Size of the first PDB depends on the total coverage of the
+			 * page table and the PAGE_TABLE_BLOCK_SIZE.
+			 * Entire table takes ceil(log2(total_vm_size)) bits
+			 * All PDBs except the first one take 9 bits each
+			 * The PTB covers at least 2 MiB (21 bits)
+			 * And PAGE_TABLE_BLOCK_SIZE is log2(num 2MiB ranges PTB covers)
+			 * As such, the formula for the size of the first PDB is:
+			 *                       PDB1, PDB0, etc.      PTB covers at least 2 MiB
+			 *                                        Block size can make it cover more
+			 *   total_vm_bits - (9 * num_middle_pdbs) - (page_table_block_size + 21)
+			 */
+			int total_vm_bits = log2_vm_size(page_table_start_addr, page_table_end_addr);
+			int top_pdb_bits = total_vm_bits - (9 * (page_table_depth - 1)) - (page_table_block_size + 21);
+
+			va_mask = (1ULL << top_pdb_bits) - 1;
+			va_mask <<= (total_vm_bits - top_pdb_bits);
 
 			if ((asic->options.no_fold_vm_decode || memcmp(&pde_fields, &pde_array[pde_cnt], sizeof pde_fields)) && asic->options.verbose)
 				asic->mem_funcs.vm_message("BASE=0x%016" PRIx64 ", VA=0x%012" PRIx64 ", PBA==0x%012" PRIx64 ", V=%" PRIu64 ", S=%" PRIu64 ", C=%" PRIu64 ", P=%" PRIu64 "\n",
@@ -624,14 +669,19 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
 
 			current_depth = page_table_depth;
 			while (current_depth) {
-				pde_idx = address >> (9 * (current_depth - 1) + page_table_block_size + 12);
-				// mask only 9 bits
-				if (current_depth != page_table_depth)
-					pde_idx &= (1ULL << 9) - 1;
-
-
-				// TODO: redo va_mask
-				va_mask = ((uint64_t)511 << ((page_table_depth - pde_cnt)*9 + (12 + pde0_block_fragment_size + page_table_block_size)));
+				// Every middle PDB has 512 entries, so shift a further 9 bits
+				// for every layer beyond the first one.
+				int amount_to_shift = (total_vm_bits - top_pdb_bits);
+				amount_to_shift -= ((page_table_depth - current_depth)*9);
+				pde_idx = address >> amount_to_shift;
+
+				// Middle layers need the upper bits masked out after the right-shift.
+				// For the top-most layer, the va_mask is set above the while loop,
+				// so we can skip re-setting it here.
+				if (current_depth != page_table_depth) {
+					pde_idx &= 511;
+					va_mask = (uint64_t)511 << amount_to_shift;
+				}
 
 				// read PDE entry
 				prev_addr = pde_address + pde_idx * 8;
@@ -671,9 +721,18 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
 				pde_fields.pte           = (pde_entry >> 54) & 1;
 				if (current_depth == 1) {
 					pde0_block_fragment_size = pde_fields.frag_size;
-					// page_table_block_size is the number of entries in a PTB that spans 2MB
-					page_table_block_size = 21 - (12 + pde0_block_fragment_size);
-					pte_page_mask = (1ULL << (12 + pde0_block_fragment_size)) - 1;
+					/*
+					 * page_table_block_size is the number of 2MiB regions covered by a PTB
+					 * If we set it to 0, then PTB cover 2 MiB
+					 * If it's 9 PTB cover 1024 MiB
+					 * pde0_block_fragment_size tells us how many 4 KiB regions each PTE covers
+					 * If it's 0 PTEs cover 4 KiB
+					 * If it's 9 PTEs cover 2 MiB
+					 * So the number of PTEs in a PTB is 2^(9+ptbs-pbfs)
+					 */
+					log2_ptb_entries = (9 + (page_table_block_size - pde0_block_fragment_size));
+					ptb_mask = (1ULL << log2_ptb_entries) - 1;
+					pte_page_mask = (1ULL << (pde0_block_fragment_size + 12)) - 1;
 					if (asic->options.verbose)
 						asic->mem_funcs.vm_message("pde0.pte = %u\npde0.block_fragment_size = %u\npage_table_block_size = %u\n",
 							(unsigned)pde_fields.pte,
@@ -723,9 +782,13 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
 				pde_address = pde_fields.pte_base_addr;
 			}
 
-			// read PTE selector (to select from PTB0)
-			// TODO:  support for page_table_block_size > 9
-			pte_idx = (address >> (12 + pde0_block_fragment_size)) & ((1ULL << page_table_block_size) - 1);
+			// If we fall through to here, we are pointing into PTB, so pull out
+			// the index and mask.
+			// At minimum, each PTE is 4 KiB (12 bits)
+			// PDE0.BFS tells us how many of these 4 KiB page each PTE covers
+			// So add those bits in.
+			// We also calculated the PTE mask up above, to know how many PTEs are in this PTB
+			pte_idx = (address >> (12 + pde0_block_fragment_size)) & ptb_mask;
 pte_further:
 			// now read PTE entry for this page
 			prev_addr = pde_fields.pte_base_addr + pte_idx*8;
@@ -778,20 +841,74 @@ pde_is_pte:
 					pte_fields.fragment,
 					pte_fields.further);
 
-			if (pte_fields.further) {
-				if (page_table_block_size == 9) {
-					// this case doesn't make sense unless we support PTBS > 9
-					asic->mem_funcs.vm_message("[ERROR]: PTE.further is set and *CNTL.PAGE_TABLE_BLOCK_SIZE is 9...\n");
-					return -1;
+			// How many bits in the address are used to index into the PTB?
+			// If further is set, that means we jumped back to pde_is_pte,
+			// and the va_mask was properly set down there.
+			if (!further) {
+				// total_vm_bits are all the bits in the VM space
+				// We want to ignore the top-most PDB, which uses top_pdb_bits
+				// We also want to ignore lower PDBs, which use 9 bits each
+				int bits_to_use = total_vm_bits - top_pdb_bits - (9 * (page_table_depth - 1));
+
+				// At a minimum, we want to ignore the bottom 12 bits for a 4 KiB page
+				int lower_bits_to_ignore = 12;
+
+				if (pde_fields.pte) {
+					// We are in here because we're in PDE0 with P bit. So we don't want
+					// to skip the 9 bits from PDB0.
+					bits_to_use += 9;
+
+					// If the P bit is set, we are coming from PDE0, thus this entry
+					// covers the whole page_table_block_size, instead of the PDE0.BFS.
+					// So we want to ignore those bits in the address.
+					lower_bits_to_ignore += page_table_block_size;
 				} else {
-					pte_idx = (address >> 12) & ((1ULL << pde0_block_fragment_size) - 1);
-					pte_page_mask = (1ULL << 12) - 1;
-
-					// grab PTE base address from the PTE that has the F bit set.
-					pde_fields.pte_base_addr = pte_fields.page_base_addr;
-					further = 1;
-					goto pte_further;
+					// If we are at an actual PTE, then based on PDE0.BFS, we want to ignore
+					// some of the lowest bits.
+					// If PDE0.BFS=0, the bottom 12 bits are used to index within the page
+					// If PDE0.BFS=9, the bottom 21 bits are used to index within the page
+					// etc.  These are the bits we want to ignore, and we already put 12 in.
+					lower_bits_to_ignore += pde0_block_fragment_size;
 				}
+
+				va_mask = (1 << bits_to_use) - 1;
+				int mask_to_ignore = (1 << lower_bits_to_ignore) - 1;
+				va_mask = va_mask & ~mask_to_ignore;
+			}
+
+			uint32_t pte_block_fragment_size = 0;
+			if (pte_fields.further) {
+				// Going to go one more layer deep, so now we need the Further-PTE's
+				// block_fragment_size. This tells us how many 4K pages each
+				// last-layer-PTE covers.
+				pte_block_fragment_size = (pte_entry >> 59) & 0x1F;
+
+				// Each entry covers the Further-PTE.block_fragment_size numbesr
+				// of 4K pages so we can potentially ignore some low-order bits.
+				int last_level_ptb_bits = 12 + pte_block_fragment_size;
+				pte_idx = address >> last_level_ptb_bits;
+
+				// The total size covered by the last-layer-PTB is a function of
+				// pde0_block_fragment_size, which tells us how many 4K entries the
+				// PTB covers.
+				// So number of bits needed to index the entries in the final PTE is:
+				uint32_t num_entry_bits =  pde0_block_fragment_size - pte_block_fragment_size;
+				// Clamp the index to the new last-level PTB's size.
+				pte_idx &= ((1 << num_entry_bits) - 1);
+
+				uint32_t upper_mask = (1ULL << (12 + pde0_block_fragment_size)) - 1;
+				pte_page_mask = (1ULL << last_level_ptb_bits) - 1;
+				va_mask &= (upper_mask & ~pte_page_mask);
+
+				// grab PTE base address and other data from the PTE that has the F bit set.
+				pde_fields.frag_size     = (pte_entry >> 59) & 0x1F;
+				pde_fields.pte_base_addr = pte_entry & 0xFFFFFFFFFFC0ULL;
+				pde_fields.valid         = pte_entry & 1;
+				pde_fields.system        = (pte_entry >> 1) & 1;
+				pde_fields.cache         = (pte_entry >> 2) & 1;
+				pde_fields.pte            = 0;
+				further = 1;
+				goto pte_further;
 			}
 
 			if (!pte_fields.system)
@@ -802,11 +919,10 @@ pde_is_pte:
 
 			// compute starting address
 			// this also accounts for PDE-is-PTE masking since current_depth > 0 at this point
-			// if we are processing a PTE leaf node then the page size is 12 bits
 			if (!further)
 				offset_mask = (1ULL << ((current_depth * 9) + (12 + pde0_block_fragment_size))) - 1;
 			else
-				offset_mask = (1ULL << 12) - 1; // offset masks are always 12-bits wide with PTE.further set
+				offset_mask = (1ULL << (12 + pte_block_fragment_size)) - 1;
 
 			start_addr = asic->mem_funcs.gpu_bus_to_cpu_address(asic, pte_fields.page_base_addr) + (address & offset_mask);
 		} else {
@@ -935,15 +1051,6 @@ invalid_page:
 	return -1;
 }
 
-/** round_up_pot -- Round up value to next power of two */
-static uint64_t round_up_pot(uint64_t x)
-{
-	uint64_t y = (64ULL * 1024 * 1024); // start at 64MiB
-	while (y < x)
-		y <<= 1;
-	return y;
-}
-
 /**
  * umr_access_vram - Access GPU mapped memory
  *
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
