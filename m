Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250E9C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69D56100A
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69D56100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F89589F53;
	Mon, 21 Jun 2021 16:37:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD9E889F53
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 16:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nX383s4tXIejBxVIj41fDJQi/yzLfmw3R8vvHH64Z3LzryPz0JVyqoZnSqSgYBULGxrnPDGLljYaXVmYBDO2xOdXC9IBE5dW4kWXVjlBjknGSTpBiregqrlBSeADN7ixGMM2C56r6KcbOu1JnsKIfYGvGG7wDkxtSqEljh0HmmUGWACAbPoy3e71mY+80YelOf1KVUqxjAajAvuuVCCBXWwxCVq2npJfPD6yg5JotruaXk7vuAa9a5MlLbrre5hD5Dk+S569kGZWSlH5DZzE6dv+59dZaBehvJsXaL7Z7bJeCjTliUTJh/k/DRHHwX1vP0gaBE4LsVUqK991KOhUSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++DKKSeW7nMzaDJne70sGeUbsDpaY3/WozhrAsqjiFs=;
 b=fXzFDaWWR1MaWwuXP3tN9IBKIUyTw+V7uaWwcZO9uOMtswewMwYCw9DFFfigLiGHmY1NFmlZXHl3lJLE3nIDKPwCSQPftwStz6HgDkNn4kKLsOqMRtzONYochzaSbpncWz5fl6RgbkTdsbrUF+vKUi4CurZpN3ojtMBuAAKdJzjULSLsB78XY96z8vzV7Ba0nsd/lRF1enaRZ3g5rSE8m0Wz7coFCmwbejrPSOheMLWkjeAEwOndG+hrSQysBQVbmc7FK+nDJ9dpESPH9VtOiCi9x/zHkQYiYxfLeXAwOKady89sVRzgvd1jlSXjodpLVGuyy38Z7aMSCVVCJgrCRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++DKKSeW7nMzaDJne70sGeUbsDpaY3/WozhrAsqjiFs=;
 b=CIlfLy9f8EquiGOsTw9fcorRbO12uLnFC+/4xkVI9UYEXcSqUzBk4ZzVW2R34VlnrpsbqB023LMwaFABbmsU5FQvb71Nz46nQnwsI//3prk+hiUQysnSJamqLxNNhS0Rh2Zd21LV5q83xpu0yXvYCKO/xjNxdpJ+MxgmP5H6CIk=
Received: from DM5PR12CA0069.namprd12.prod.outlook.com (2603:10b6:3:103::31)
 by DM6PR12MB3449.namprd12.prod.outlook.com (2603:10b6:5:3b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Mon, 21 Jun
 2021 16:37:23 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::d6) by DM5PR12CA0069.outlook.office365.com
 (2603:10b6:3:103::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Mon, 21 Jun 2021 16:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 16:37:23 +0000
Received: from rocm-perf01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 21 Jun
 2021 11:37:22 -0500
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 umr 3/3] Enhance printing of page tables in AI+
Date: Mon, 21 Jun 2021 11:37:12 -0500
Message-ID: <20210621163712.17852-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210617192540.4272-3-Joseph.Greathouse@amd.com>
References: <20210617192540.4272-3-Joseph.Greathouse@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e0696a9-26f0-4adf-9d1d-08d934d2d8a1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3449:
X-Microsoft-Antispam-PRVS: <DM6PR12MB344986D172C123D195C5DD22F90A9@DM6PR12MB3449.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IIeeXZ2eMgKaven9bO8cLB5o3ctEXmi7QVz7YH2+1fmU1xJnTjTuUkez/fow9/+VAoucdJgprS9lvqNJ0Zgpan1b2/ed/B5ARBqXSbVkahq4b7i5tB/UXCFmbb3BbkQId8VSRq5WrCOoI52C/Fo83NBKNuiFhXRvHz4cA5j+PfhWrD6ZUkFRcYUg/5G5nKeBxuqdhZEu2t6W/JXXxpk6eqt0wvP9nBsOQVtanGjk4HIDXK01Lkq3Ed5H2GXT7qwVAPgEgThxtGlI22WxVEj0Nd01oC9P1OuL1H/1jOiXDPAR70vl9cN7zmarBRPa8r7bhPtqKqn+Z8Q9AC70bmKlr3RGhqnPl0nVNHvzphhkbSJ3X4ECAkG/nkS+t4+VfdhcNl/5OJ3CY1xtsfsgm//wBRtD+QdGXDBJLHMuu5Fuj3WQowFObFiXsZkpmrCKQICE6QCDgfTQgjnFdmt6DGnC7oh/Ef86lVtlfAqDQETa1x73MtP1oYE8BfcoJlbTDo1kXIvfP2xNrWUVyG5ceXKZoNZnHBMEn7x+ZJgTWMqy6VSx0mUXiT5weA0Hz2em42Edrh+UOl0LWxZb+Omynf7bU9/oVxqgdd/xvynhTxqCaG22j0QJAHZCEzDuvpEvzaN07OWTPjEShCEwN9gvV9z0K+ss/rsS4Nf7p9zWiETDe2myDNzSkFV6ZBJdDefmd19U
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(36840700001)(6666004)(316002)(2616005)(426003)(186003)(5660300002)(86362001)(16526019)(8936002)(478600001)(70206006)(83380400001)(26005)(70586007)(356005)(54906003)(336012)(81166007)(36860700001)(8676002)(47076005)(82310400003)(4326008)(1076003)(82740400003)(36756003)(6916009)(7696005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 16:37:23.0803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0696a9-26f0-4adf-9d1d-08d934d2d8a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3449
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

v2: Correctly handle printing translate-further PTEs

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 src/lib/read_vram.c | 184 ++++++++++++++++++++++++++++++--------------
 1 file changed, 127 insertions(+), 57 deletions(-)

diff --git a/src/lib/read_vram.c b/src/lib/read_vram.c
index 2998873..bea1232 100644
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
+					pde_fields = decode_pde_entry_ai(pte_entry);
+					print_pde_ai(asic, indentation, pde_cnt, page_table_depth, prev_addr,
+							pte_idx, pte_entry, address, va_mask, pde_fields);
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
