Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42575C2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 19:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CC0D610A7
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 19:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC0D610A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE6626E9A8;
	Thu, 17 Jun 2021 19:25:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDF276E9A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 19:25:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLp9LJcfqEaRg8lp1mUDpNr7KvKhl4OEqBE+exWYqz2jy8i5HEPXR68WMlFYCgcllihlg6C7xEwiqVwK3jnHEryxpPf2AuOEoHhjPqmaNIrVkVCakiQi69wmt7Z6b3rbdnYVQ/gH09piEz91LIFLV/IkWl96WV0eUdjuVUTAyLxLBxvn70Z77udx06oAa8OoZv1dFJ96sC+eWtWNDnwyyLFH5a/6UD2Jil70V1IPQf2dDPx94wmoMQLfCpf+Uqr3wTQkNlQ8+b7/4IAJ6q9tBgDc1e5NqXkTYEWdQbfXyhaD2xzavlK/XWxXy8ZSa++Dgw6o8Op4iTA2FTNib1O8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpHJXf+81YAcoAO4sPDO0yUwLA3N4/5hyksQmGZY+dI=;
 b=hKXLrzfcwtICCzWyxEEepzjTeoAhgW68Be+qeAtrYdLGP7eQSj921HjQISCPbInnbt2CClXJCEnE/ttPoG8gcKSo8UyDgwNNCUCV4+/KZ92qj4nMFhy8RhxA9AombOArpv7VUBbJFetnJ9lVOMZSolMWkS0qnfqI5ML9+YTNXCdBXadJbS4f4uTuumRk7UtwrAeG4mfmdmrDaXTIfNumAXjLZY0E5J/Bo7fJprlb0T86C7b6jrusJXfT1kzRDoaTfn03V/jsnDl/y3Po2tucURMhQTudb86ysWCYxedbiWnc2VCqeoUz8JdEdxVaI2mcKDlbchz1wLblLMM229Hhsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpHJXf+81YAcoAO4sPDO0yUwLA3N4/5hyksQmGZY+dI=;
 b=Gdh9xuT9YByW7vb57cA3IhRcPxQVmoabC7iLCdRYXhAaqNuNZTW5Ys0Yws1Ep8g8CPD/8RvKwnhXhBuQWAF4x+XYaY7PCRj7BIVq3pdh0h5TXqfFz7G6zTMcEcCyGfC1HlyD93xHvG3BPfZj+ZPHhHGMuTql3Zxi2XpaZ5sI/Yk=
Received: from DM6PR03CA0080.namprd03.prod.outlook.com (2603:10b6:5:333::13)
 by MN2PR12MB3742.namprd12.prod.outlook.com (2603:10b6:208:16a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 19:25:55 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::d6) by DM6PR03CA0080.outlook.office365.com
 (2603:10b6:5:333::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Thu, 17 Jun 2021 19:25:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 19:25:55 +0000
Received: from rocm-perf01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 17 Jun
 2021 14:25:54 -0500
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH umr 3/3] Enhance printing of page tables in AI+
Date: Thu, 17 Jun 2021 14:25:40 -0500
Message-ID: <20210617192540.4272-3-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210617192540.4272-1-Joseph.Greathouse@amd.com>
References: <20210617192540.4272-1-Joseph.Greathouse@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc0dd73a-5aca-4020-a931-08d931c5ba53
X-MS-TrafficTypeDiagnostic: MN2PR12MB3742:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3742DBBE8F160972725FD95EF90E9@MN2PR12MB3742.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRGB8o9FjdaCogE/OqYj5kBROGnHAaiP+A3bFXX2ev72ZqPpS4CaGSFwhopS8c5IAZqsGuhPkf6z6JcFTNvCW+9lrRxWDgTabhsNDlzXX9xGu4PKxWd4BVNr8Dna+nUQviv9ophGk5DaP0CzE29Zm8MWmebzMPDzNGChRvbhR8YtuR4GhAGLhpbaLsH2RoEoODrORgc3B2ZC0bpZWPdza8py+sQuZA70DE080fAOi3+GWJj+Tl1o5oxvXGIIgpTy48/A6PuYFi8hn0xa5aus4tbJ1dNQlnEmlWksb5bC9zgSYFzu5rSnR1qZ5OR8OSl/A2uO3tYQcsyYkfGx/9Br4GzTM4TBBiSwyZ+wuNjz6bNw0a+MgAxqQHhEN4rxwy6dsNkXKVL0lltJlLorOyrZYETXVkDdk4ZwPWuN++s05FhVpUBoOXbAEVecrfKLjUFMWbCO9ZgMQZSzXsUmx+oKBTwYcRGdFDXt4T+isVODwubRGqNQ+dIntWoSrb7GXxm0Q+H/GpRzRWnDgDuocuZXw+Owj1Fv3M6SYQnMuaxjnTsfDKNhi45U+hcO4T5lO8qMQlri6M/Gi/s6SWMoqCICI2X6PxdCsu0OO03QKen6UX+/yAJGGgmLvZ/fZUADCLqrNwl+iSdTG2Mn1PBgZ0FMc65dXNrvmP3fOAo9FqlQR7KdScgeFkx37qL7f9YHwSsO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966006)(36840700001)(86362001)(5660300002)(7696005)(70206006)(6916009)(2906002)(36860700001)(186003)(82740400003)(26005)(336012)(426003)(70586007)(47076005)(54906003)(2616005)(316002)(81166007)(83380400001)(1076003)(8676002)(4326008)(16526019)(36756003)(478600001)(82310400003)(8936002)(356005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 19:25:55.3089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0dd73a-5aca-4020-a931-08d931c5ba53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3742
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

Pulls print functions for GPUVM page tables on AI+ chips into their
own set of generalized functions, so that we don't have subtly
different printouts for different layers.

Explicitly prints PDEs with P bit (which makes it a PTE) and makes
the PTE with F bit set (further, which makes it a PDE) properly
indent the next layer of the print.

Prints remaining fields from the PTE and PDE printouts, such as
read/write/execute bits and MTYPE from PTE.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 src/lib/read_vram.c | 184 ++++++++++++++++++++++++++++++--------------
 1 file changed, 127 insertions(+), 57 deletions(-)

diff --git a/src/lib/read_vram.c b/src/lib/read_vram.c
index 2998873..cb38b60 100644
--- a/src/lib/read_vram.c
+++ b/src/lib/read_vram.c
@@ -415,6 +415,112 @@ static pte_fields_ai_t decode_pte_entry_ai(uint64_t pte_entry)
 	return pte_fields;
 }
 
+static void print_pde_fields_ai(struct umr_asic *asic,
+				pde_fields_ai_t pde_fields)
+{
+	asic->mem_funcs.vm_message(
+			", PBA==0x%012" PRIx64 ", V=%" PRIu64
+			", S=%" PRIu64 ", C=%" PRIu64
+			", P=%" PRIu64 ", FS=%" PRIu64 "\n",
+			pde_fields.pte_base_addr,
+			pde_fields.valid,
+			pde_fields.system,
+			pde_fields.coherent,
+			pde_fields.pte,
+			pde_fields.frag_size);
+}
+static void print_base_ai(struct umr_asic *asic,
+			  uint64_t pde_entry, uint64_t address,
+			  uint64_t va_mask, pde_fields_ai_t pde_fields,
+			  int is_base_not_pde)
+{
+	if (is_base_not_pde)
+		asic->mem_funcs.vm_message("BASE");
+	else
+		asic->mem_funcs.vm_message("PDE");
+	asic->mem_funcs.vm_message("=0x%016" PRIx64 ", VA=0x%012" PRIx64,
+			pde_entry,
+			address & va_mask);
+	print_pde_fields_ai(asic, pde_fields);
+}
+
+static void print_pde_ai(struct umr_asic *asic,
+		const char * indentation, int pde_cnt,
+		int page_table_depth, uint64_t prev_addr,
+		uint64_t pde_idx, uint64_t pde_entry, uint64_t address,
+		uint64_t va_mask, pde_fields_ai_t pde_fields)
+{
+	asic->mem_funcs.vm_message("%s ", &indentation[18-pde_cnt*3]);
+	if (pde_fields.further)
+		asic->mem_funcs.vm_message("PTE-FURTHER");
+	else
+		asic->mem_funcs.vm_message("PDE%d", page_table_depth - pde_cnt);
+
+	asic->mem_funcs.vm_message("@{0x%" PRIx64 "/%" PRIx64
+			"}=0x%016" PRIx64 ", VA=0x%012" PRIx64,
+			prev_addr,
+			pde_idx,
+			pde_entry,
+			address & va_mask);
+	print_pde_fields_ai(asic, pde_fields);
+}
+
+static void print_pte_ai(struct umr_asic *asic,
+		const char * indentation, int pde_cnt, uint64_t prev_addr,
+		uint64_t pte_idx, uint64_t pte_entry, uint64_t address,
+		uint64_t va_mask, pte_fields_ai_t pte_fields)
+{
+	if (asic == NULL) {
+		asic->mem_funcs.vm_message("\\-> PTE");
+	} else {
+		asic->mem_funcs.vm_message("%s ",
+				&indentation[18-pde_cnt*3]);
+		if (pte_fields.pde)
+			asic->mem_funcs.vm_message("PDE0-as-PTE");
+		else
+			asic->mem_funcs.vm_message("PTE");
+		asic->mem_funcs.vm_message("@{0x%" PRIx64 "/%" PRIx64"}",
+				prev_addr,
+				pte_idx);
+	}
+	asic->mem_funcs.vm_message("=0x%016" PRIx64 ", VA=0x%012" PRIx64
+			", PBA==0x%012" PRIx64 ", V=%" PRIu64
+			", S=%" PRIu64 ", C=%" PRIu64 ", Z=%" PRIu64
+			", X=%" PRIu64 ", R=%" PRIu64 ", W=%" PRIu64
+			", FS=%" PRIu64 ", T=%" PRIu64 ", MTYPE=",
+			pte_entry,
+			address & va_mask,
+			pte_fields.page_base_addr,
+			pte_fields.valid,
+			pte_fields.system,
+			pte_fields.coherent,
+			pte_fields.tmz,
+			pte_fields.execute,
+			pte_fields.read,
+			pte_fields.write,
+			pte_fields.fragment,
+			pte_fields.prt,
+			pte_fields.mtype);
+	switch (pte_fields.mtype) {
+		case 0:
+			asic->mem_funcs.vm_message("NC\n");
+			break;
+		case 1:
+			asic->mem_funcs.vm_message("RW\n");
+			break;
+		case 2:
+			asic->mem_funcs.vm_message("CC\n");
+			break;
+		case 3:
+			asic->mem_funcs.vm_message("UC\n");
+			break;
+		default:
+			asic->mem_funcs.vm_message("Unknown (%" PRIu64")\n",
+					pte_fields.mtype);
+			break;
+	}
+}
+
 /**
  * umr_access_vram_ai - Access GPU mapped memory for GFX9+ platforms
  */
@@ -457,7 +563,7 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
 	unsigned char *pdst = dst;
 	char *hub, *vm0prefix, *regprefix;
 	unsigned hubid;
-	static const char *indentation = "               \\->";
+	static const char *indentation = "                  \\->";
 
 	memset(&registers, 0, sizeof registers);
 	memset(&pde_array, 0xff, sizeof pde_array);
@@ -713,14 +819,7 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
 			va_mask <<= (total_vm_bits - top_pdb_bits);
 
 			if ((asic->options.no_fold_vm_decode || memcmp(&pde_fields, &pde_array[pde_cnt], sizeof pde_fields)) && asic->options.verbose)
-				asic->mem_funcs.vm_message("BASE=0x%016" PRIx64 ", VA=0x%012" PRIx64 ", PBA==0x%012" PRIx64 ", V=%" PRIu64 ", S=%" PRIu64 ", C=%" PRIu64 ", P=%" PRIu64 "\n",
-						pde_entry,
-						address & va_mask,
-						pde_fields.pte_base_addr,
-						pde_fields.valid,
-						pde_fields.system,
-						pde_fields.coherent,
-						pde_fields.pte);
+				print_base_ai(asic, pde_entry, address, va_mask, pde_fields, 1);
 			memcpy(&pde_array[pde_cnt++], &pde_fields, sizeof pde_fields);
 
 			current_depth = page_table_depth;
@@ -783,27 +882,11 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
 					log2_ptb_entries = (9 + (page_table_block_size - pde0_block_fragment_size));
 					ptb_mask = (1ULL << log2_ptb_entries) - 1;
 					pte_page_mask = (1ULL << (pde0_block_fragment_size + 12)) - 1;
-					if (asic->options.verbose)
-						asic->mem_funcs.vm_message("pde0.pte = %u\npde0.block_fragment_size = %u\npage_table_block_size = %u\n",
-							(unsigned)pde_fields.pte,
-							(unsigned)pde0_block_fragment_size,
-							(unsigned)page_table_block_size);
 				}
 				if (!pde_fields.pte) {
 					if ((asic->options.no_fold_vm_decode || memcmp(&pde_fields, &pde_array[pde_cnt], sizeof pde_fields)) && asic->options.verbose) {
-						asic->mem_funcs.vm_message("%s PDE%d@{0x%" PRIx64 "/%" PRIx64 "}=0x%016" PRIx64 ", VA=0x%012" PRIx64 ", PBA==0x%012" PRIx64 ", V=%" PRIu64 ", S=%" PRIu64 ", C=%" PRIu64 ", P=%" PRIu64 ", FS=%" PRIu64 "\n",
-								&indentation[15-pde_cnt*3],
-								page_table_depth - pde_cnt,
-								prev_addr,
-								pde_idx,
-								pde_entry,
-								address & va_mask,
-								pde_fields.pte_base_addr,
-								pde_fields.valid,
-								pde_fields.system,
-								pde_fields.coherent,
-								pde_fields.pte,
-								pde_fields.frag_size);
+						print_pde_ai(asic, indentation, pde_cnt, page_table_depth, prev_addr,
+								pde_idx, pde_entry, address, va_mask, pde_fields);
 						memcpy(&pde_array[pde_cnt++], &pde_fields, sizeof pde_fields);
 					}
 				} else {
@@ -870,21 +953,6 @@ pte_further:
 pde_is_pte:
 			pte_fields = decode_pte_entry_ai(pte_entry);
 
-			if (asic->options.verbose)
-				asic->mem_funcs.vm_message("%s %s@{0x%" PRIx64 "/%" PRIx64"}==0x%016" PRIx64 ", VA=0x%012" PRIx64 ", PBA==0x%012" PRIx64 ", V=%" PRIu64 ", S=%" PRIu64 ", P=%" PRIu64 ", FS=%" PRIu64 ", F=%" PRIu64 "\n",
-					&indentation[15-pde_cnt*3],
-					(pte_fields.further) ? "PTE-FURTHER" : "PTE",
-					prev_addr,
-					pte_idx,
-					pte_entry,
-					address & (((1ULL << page_table_block_size) - 1) << (12 + pde0_block_fragment_size)),
-					pte_fields.page_base_addr,
-					pte_fields.valid,
-					pte_fields.system,
-					pte_fields.prt,
-					pte_fields.fragment,
-					pte_fields.further);
-
 			// How many bits in the address are used to index into the PTB?
 			// If further is set, that means we jumped back to pde_is_pte,
 			// and the va_mask was properly set down there.
@@ -920,6 +988,17 @@ pde_is_pte:
 				va_mask = va_mask & ~mask_to_ignore;
 			}
 
+			if (asic->options.verbose) {
+				if (pte_fields.further) {
+					pde_fields.further = 1;
+					print_pde_ai(asic, indentation, pde_cnt, page_table_depth, prev_addr,
+							pde_idx, pde_entry, address, va_mask, pde_fields);
+				} else {
+					print_pte_ai(asic, indentation, pde_cnt, prev_addr, pte_idx,
+							pte_entry, address, va_mask, pte_fields);
+				}
+			}
+
 			uint32_t pte_block_fragment_size = 0;
 			if (pte_fields.further) {
 				// Going to go one more layer deep, so now we need the Further-PTE's
@@ -946,6 +1025,7 @@ pde_is_pte:
 
 				// grab PTE base address and other data from the PTE that has the F bit set.
 				pde_fields = decode_pde_entry_ai(pte_entry);
+				pde_cnt++;
 				further = 1;
 				goto pte_further;
 			}
@@ -972,12 +1052,7 @@ pde_is_pte:
 			pte_page_mask = (1ULL << (12 + pde0_block_fragment_size)) - 1;
 
 			if ((asic->options.no_fold_vm_decode || memcmp(&pde_array[0], &pde_fields, sizeof pde_fields)) && asic->options.verbose)
-				asic->mem_funcs.vm_message("PDE=0x%016" PRIx64 ", PBA==0x%012" PRIx64 ", V=%" PRIu64 ", S=%" PRIu64 ", FS=%" PRIu64 "\n",
-						page_table_base_addr,
-						pde_fields.pte_base_addr,
-						pde_fields.valid,
-						pde_fields.system,
-						pde_fields.frag_size);
+				print_base_ai(asic, page_table_base_addr, address, -1, pde_fields, 0);
 			memcpy(&pde_array[0], &pde_fields, sizeof pde_fields);
 
 			if (!pde_fields.valid)
@@ -992,13 +1067,8 @@ pde_is_pte:
 			pte_fields = decode_pte_entry_ai(pte_entry);
 
 			if (asic->options.verbose)
-				asic->mem_funcs.vm_message("\\-> PTE=0x%016" PRIx64 ", VA=0x%016" PRIx64 ", PBA==0x%012" PRIx64 ", F=%" PRIu64 ", V=%" PRIu64 ", S=%" PRIu64 "\n",
-					pte_entry,
-					address & ~((uint64_t)0xFFF),
-					pte_fields.page_base_addr,
-					pte_fields.fragment,
-					pte_fields.valid,
-					pte_fields.system);
+				print_pte_ai(asic, NULL, 0, 0, 0, pte_entry, address,
+						~((uint64_t)0xFFF), pte_fields);
 
 			if (pdst && !pte_fields.valid)
 				goto invalid_page;
@@ -1018,13 +1088,13 @@ next_page:
 		if (asic->options.verbose) {
 			if (pte_fields.system == 1) {
 				asic->mem_funcs.vm_message("%s Computed address we will read from: %s:%" PRIx64 ", (reading: %" PRIu32 " bytes)\n",
-											&indentation[15-pde_cnt*3-3],
+											&indentation[18-pde_cnt*3-3],
 											"sys",
 											start_addr,
 											chunk_size);
 			} else {
 				asic->mem_funcs.vm_message("%s Computed address we will read from: %s:%" PRIx64 " (MCA:%" PRIx64"), (reading: %" PRIu32 " bytes)\n",
-											&indentation[15-pde_cnt*3-3],
+											&indentation[18-pde_cnt*3-3],
 											"vram",
 											start_addr,
 											start_addr + vm_fb_offset,
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
