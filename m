Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE61C49361
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 19:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A57610CD
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 19:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A57610CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE00A6E9A6;
	Thu, 17 Jun 2021 19:25:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D57636E9A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 19:25:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPBLrrTmgTltF3zGgw0Dd27BpT8zhpkWRh1Uk9hhQWKr/hUISDCA3UkN92KPdYy3NdUMQ+ltoVaUzKcglSZbdapZQdNV/hb+X42iK8BZtfS5nxIgbUu+fQ7Oo/jet5Io2OSqpwjBSO0QHWYjK6iJfMYBPtL9aHAdA5oTrSAZ4M8+5UC17cVCr4D8S0bkrrCnSftGQZKw8zswUyu3ZXtcicVMpphA2SyIWqZRprzESkq6DN4pYXk06G+GLzSJzafCa0nIoL6GIpJ/9A5IOFcUt9wRWUPRL5VTpHFXAlDbdySZ2NXAZ/AE2OVfFzkD3d25LCK1owujo0Wxb70VS9KjZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+q+6dPWIgVJgUDc6G4OV5Cn3UD15HEFBAc/wHY0MrT4=;
 b=W5KMwN4I4T+uUyMJLJd6wKtrLw6udfphVELLQHEneTGnePBMoYSiLKdfr/MyvFlzzxu93kkVfprUDdkeWzcbg0p3vMzH1bl1LBi6SmNffo8H6QrpJ8wujBZcvgram2o2kojqXOxKSQuwiW9pHKfDza24JqVbl5jSKJ7Odm7CHtNO/X+x+iJO3b5DmZtdV+nH1LttUMzl5wzFpbLK6NFcriryHU/kLnosnyS9zxCZfomYx5eMRmjsz9FB2FOFNIds6j2VcTcF7iOKFKB2EDavopK3Gdv0qHuDfLeUtWEj3WHm3148UwDfWsC2G19klIrkJzhzE4bvaq2AZYECbBoaVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+q+6dPWIgVJgUDc6G4OV5Cn3UD15HEFBAc/wHY0MrT4=;
 b=qW0aWCuT0l7T1FGMRzf/vJeB4z8ZEPMJ/eNwdbaL4wpWdSpmr0i0vt5N8fRtddefsTUgKfYWGXiQIHaj1OyQUbtzuzv50nf385yQMdtlDgyauNeCNmnmAu25Hdr/nM4FYnwgOkWV8u1RdVvFvn5LuT4h/qqnUlyHJR9b0EO170U=
Received: from DS7PR03CA0163.namprd03.prod.outlook.com (2603:10b6:5:3b2::18)
 by DM6PR12MB3644.namprd12.prod.outlook.com (2603:10b6:5:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 19:25:54 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::49) by DS7PR03CA0163.outlook.office365.com
 (2603:10b6:5:3b2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Thu, 17 Jun 2021 19:25:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 19:25:54 +0000
Received: from rocm-perf01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 17 Jun
 2021 14:25:53 -0500
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH umr 2/3] Generalize decoding of PDEs and PTEs in AI+
Date: Thu, 17 Jun 2021 14:25:39 -0500
Message-ID: <20210617192540.4272-2-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210617192540.4272-1-Joseph.Greathouse@amd.com>
References: <20210617192540.4272-1-Joseph.Greathouse@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34225e0a-385e-4376-4aba-08d931c5b9ab
X-MS-TrafficTypeDiagnostic: DM6PR12MB3644:
X-Microsoft-Antispam-PRVS: <DM6PR12MB36449D9E744E33897F1FAFBDF90E9@DM6PR12MB3644.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqrHkFr3vUCbJ9aDAaNvJxc/u8G5wVtqwnAcHeBVYP7mqUj/DIX/tmXI7HJxi3/Zk+smcEmsv5cEFOc8JYzrX9CXUHt5lYcxfXWKWdYLBtwlaX+W6Fd4VvMH0MuCSFKBgDPmSFJHeiFBX1ID5kJTwIhxoNlLm2G6sW6eXV2O+5cTB2PmMKtkQdoCiTjbLSXbfM7GRoaLK2B9m/vtLH6alM64yOrfQTTa0FSNfxn57Yz/3hA78x7qLHTaOK7BsnDUAwsODB60DFOr9og7bDGQmEUU3YMIQEIYvfi0ICNPdZPlUbr4yxGPzo1I9TvEQG1iJSQoDhqJW5664LpacoDh6mrgbYskwY1tJN9c3skKebn9ZJbeQVGsaL2ZzG3tX29mxBzeXcz2rQSpwx2UsOwnGI9eNx+0QtU+6R5kjvNYviRcFazP3BiDZNaN3rXeQbGpBua3SA1PbA45ryikL0odMx4RipOgzlW+EOoQVs6nB8TRsR2glrumEGhbvqLjbvGPUTqIe5FCHHDDkRpatiNiKGmXMMzm3bCCXHylFNAobPr5Iy9wB4MwedzhRQ6RZijIMoXl5U+YWj6Ce3Np991KSupVEaxzLej2fuFl5poBN6eLNyGCye2oQimswUdcp04b4rh6QqeAttvn9sYpCEOefCYYMqVxozJ2Sle05VaO15z7PRMJEU05u2Gp1BBZJsjW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(36840700001)(47076005)(36860700001)(36756003)(7696005)(478600001)(86362001)(2906002)(4326008)(26005)(16526019)(426003)(82740400003)(83380400001)(186003)(6666004)(82310400003)(6916009)(70206006)(336012)(8676002)(316002)(70586007)(81166007)(8936002)(5660300002)(2616005)(54906003)(356005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 19:25:54.1945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34225e0a-385e-4376-4aba-08d931c5b9ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3644
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

Brings decoding of PDEs and PTEs for AI+ chips into their own
functions, so that we don't end up with subtly different decoding
bugs in the variety of places such decodings are done.

Also fixes a minor bug where we were pulling PTE.PRT from bit 61
instead of the proper bit 51.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 src/lib/read_vram.c | 187 ++++++++++++++++++++++++++------------------
 1 file changed, 109 insertions(+), 78 deletions(-)

diff --git a/src/lib/read_vram.c b/src/lib/read_vram.c
index 049acd4..2998873 100644
--- a/src/lib/read_vram.c
+++ b/src/lib/read_vram.c
@@ -317,6 +317,104 @@ static uint64_t log2_vm_size(uint64_t page_table_start_addr, uint64_t page_table
 	return vm_bits;
 }
 
+typedef struct {
+	uint64_t
+		frag_size,
+		pte_base_addr,
+		valid,
+		system,
+		coherent,
+		pte,
+		further;
+} pde_fields_ai_t;
+
+typedef struct {
+	uint64_t
+		valid,
+		system,
+		coherent,
+		tmz,
+		execute,
+		read,
+		write,
+		fragment,
+		page_base_addr,
+		prt,
+		pde,
+		further,
+		mtype;
+} pte_fields_ai_t;
+
+/*
+ * PDE format on AI:
+ * 63:59 block fragment size
+ * 58:55 reserved
+ *   But if bit 56 is set, this is a PTE with 'further' set,
+ *   which makes it act like a PDE.
+ * 54 pde-is-pte
+ * 53:48 reserved
+ * 47:6 physical base address of PTE
+ * 2 cache coherent/snoop
+ * 1 system
+ * 0 valid
+ */
+static pde_fields_ai_t decode_pde_entry_ai(uint64_t pde_entry)
+{
+	pde_fields_ai_t pde_fields;
+	pde_fields.frag_size     = (pde_entry >> 59) & 0x1F;
+	pde_fields.pte_base_addr = pde_entry & 0xFFFFFFFFFFC0ULL;
+	pde_fields.valid         = pde_entry & 1;
+	pde_fields.system        = (pde_entry >> 1) & 1;
+	pde_fields.coherent      = (pde_entry >> 2) & 1;
+	pde_fields.pte           = (pde_entry >> 54) & 1;
+	pde_fields.further       = (pde_entry >> 56) & 1;
+	return pde_fields;
+}
+
+/*
+ * PTE format on AI and PI:
+ * 58:57 mtype
+ * 56 further
+ * 54 reserved
+ *   But if it is set, then this is actually a PDE with 'P'
+ *   bit set, which makes the PDE act like a PTE.
+ * 51 prt
+ * 47:12 4k physical page base address
+ * 11:7 fragment
+ * 6 write
+ * 5 read
+ * 4 exe
+ * 3 tmz (PI+)
+ * 2 snooped / coherent
+ * 1 system
+ * 0 valid
+ */
+static pte_fields_ai_t decode_pte_entry_ai(uint64_t pte_entry)
+{
+	pte_fields_ai_t pte_fields;
+	pte_fields.valid          = pte_entry & 1;
+	pte_fields.system         = (pte_entry >> 1) & 1;
+	pte_fields.coherent       = (pte_entry >> 2) & 1;
+	pte_fields.tmz            = (pte_entry >> 3) & 1;
+	pte_fields.execute        = (pte_entry >> 4) & 1;
+	pte_fields.read           = (pte_entry >> 5) & 1;
+	pte_fields.write          = (pte_entry >> 6) & 1;
+	pte_fields.fragment       = (pte_entry >> 7) & 0x1F;
+	pte_fields.prt            = (pte_entry >> 51) & 1;
+	pte_fields.pde            = (pte_entry >> 54) & 1;
+	pte_fields.further        = (pte_entry >> 56) & 1;
+	pte_fields.mtype          = (pte_entry >> 57) & 3;
+
+	// PTEs hold physical address in 47:12
+	// PDEs hold physical address in 47:6, so if this is a PTE-as-PDE (further), need a differnt mask
+	if (pte_fields.further)
+		pte_fields.page_base_addr = pte_entry & 0xFFFFFFFFFFC0ULL;
+	else
+		pte_fields.page_base_addr = pte_entry & 0xFFFFFFFFF000ULL;
+
+	return pte_fields;
+}
+
 /**
  * umr_access_vram_ai - Access GPU mapped memory for GFX9+ platforms
  */
@@ -352,24 +450,9 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
 			mmMC_VM_AGP_BOT,
 			mmMC_VM_AGP_TOP;
 	} registers;
-	struct {
-		uint64_t
-			frag_size,
-			pte_base_addr,
-			valid,
-			system,
-			cache,
-			pte;
-	} pde_fields, pde_array[8];
-	struct {
-		uint64_t
-			page_base_addr,
-			fragment,
-			system,
-			valid,
-			prt,
-			further;
-	} pte_fields;
+
+	pde_fields_ai_t pde_fields, pde_array[8];
+	pte_fields_ai_t pte_fields;
 	char buf[64];
 	unsigned char *pdst = dst;
 	char *hub, *vm0prefix, *regprefix;
@@ -379,27 +462,6 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
 	memset(&registers, 0, sizeof registers);
 	memset(&pde_array, 0xff, sizeof pde_array);
 
-	/*
-	 * PTE format on AI:
-	 * 47:12 4k physical page base address
-	 * 11:7 fragment
-	 * 6 write
-	 * 5 read
-	 * 4 exe
-	 * 3 reserved
-	 * 2 snooped
-	 * 1 system
-	 * 0 valid
-	 *
-	 * PDE format on AI:
-	 * 63:59 block fragment size
-	 * 58:40 reserved
-	 * 47:6 physical base address of PTE
-	 * 2 cache coherent/snoop
-	 * 1 system
-	 * 0 valid
-	 */
-
 	hubid = vmid & 0xFF00;
 	vmid &= 0xFF;
 
@@ -627,13 +689,7 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
 		further = 0;
 
 		if (page_table_depth >= 1) {
-			// decode PDE values
-			pde_fields.frag_size     = (pde_entry >> 59) & 0x1F;
-			pde_fields.pte_base_addr = pde_entry & 0xFFFFFFFFF000ULL;
-			pde_fields.valid         = pde_entry & 1;
-			pde_fields.system        = (pde_entry >> 1) & 1;
-			pde_fields.cache         = (pde_entry >> 2) & 1;
-			pde_fields.pte           = (pde_entry >> 54) & 1;
+			pde_fields = decode_pde_entry_ai(pde_entry);
 
 			// AI+ supports more than 1 level of PDEs so we iterate for all of the depths
 			pde_address = pde_fields.pte_base_addr;
@@ -663,7 +719,7 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
 						pde_fields.pte_base_addr,
 						pde_fields.valid,
 						pde_fields.system,
-						pde_fields.cache,
+						pde_fields.coherent,
 						pde_fields.pte);
 			memcpy(&pde_array[pde_cnt++], &pde_fields, sizeof pde_fields);
 
@@ -712,13 +768,7 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
 					}
 				}
 
-				// decode PDE values
-				pde_fields.frag_size     = (pde_entry >> 59) & 0x1F;
-				pde_fields.pte_base_addr = pde_entry & 0xFFFFFFFFF000ULL;
-				pde_fields.valid         = pde_entry & 1;
-				pde_fields.system        = (pde_entry >> 1) & 1;
-				pde_fields.cache         = (pde_entry >> 2) & 1;
-				pde_fields.pte           = (pde_entry >> 54) & 1;
+				pde_fields = decode_pde_entry_ai(pde_entry);
 				if (current_depth == 1) {
 					pde0_block_fragment_size = pde_fields.frag_size;
 					/*
@@ -751,7 +801,7 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
 								pde_fields.pte_base_addr,
 								pde_fields.valid,
 								pde_fields.system,
-								pde_fields.cache,
+								pde_fields.coherent,
 								pde_fields.pte,
 								pde_fields.frag_size);
 						memcpy(&pde_array[pde_cnt++], &pde_fields, sizeof pde_fields);
@@ -817,14 +867,8 @@ pte_further:
 					return -1;
 			}
 
-			// decode PTE values
 pde_is_pte:
-			pte_fields.fragment       = (pte_entry >> 7)  & 0x1F;
-			pte_fields.system         = (pte_entry >> 1) & 1;
-			pte_fields.valid          = pte_entry & 1;
-			pte_fields.prt            = (pte_entry >> 61) & 1;
-			pte_fields.further        = (pte_entry >> 56) & 1;
-			pte_fields.page_base_addr = pte_entry & (pte_fields.further ? 0xFFFFFFFFFFC0ULL : 0xFFFFFFFFF000ULL);
+			pte_fields = decode_pte_entry_ai(pte_entry);
 
 			if (asic->options.verbose)
 				asic->mem_funcs.vm_message("%s %s@{0x%" PRIx64 "/%" PRIx64"}==0x%016" PRIx64 ", VA=0x%012" PRIx64 ", PBA==0x%012" PRIx64 ", V=%" PRIu64 ", S=%" PRIu64 ", P=%" PRIu64 ", FS=%" PRIu64 ", F=%" PRIu64 "\n",
@@ -901,12 +945,7 @@ pde_is_pte:
 				va_mask &= (upper_mask & ~pte_page_mask);
 
 				// grab PTE base address and other data from the PTE that has the F bit set.
-				pde_fields.frag_size     = (pte_entry >> 59) & 0x1F;
-				pde_fields.pte_base_addr = pte_entry & 0xFFFFFFFFFFC0ULL;
-				pde_fields.valid         = pte_entry & 1;
-				pde_fields.system        = (pte_entry >> 1) & 1;
-				pde_fields.cache         = (pte_entry >> 2) & 1;
-				pde_fields.pte            = 0;
+				pde_fields = decode_pde_entry_ai(pte_entry);
 				further = 1;
 				goto pte_further;
 			}
@@ -928,12 +967,9 @@ pde_is_pte:
 		} else {
 			// in AI+ the BASE_ADDR is treated like a PDE entry...
 			// decode PDE values
-			pde_fields.frag_size     = (page_table_base_addr >> 59) & 0x1F;
+			pde_fields = decode_pde_entry_ai(pde_entry);
 			pde0_block_fragment_size = pde_fields.frag_size;
 			pte_page_mask = (1ULL << (12 + pde0_block_fragment_size)) - 1;
-			pde_fields.pte_base_addr = page_table_base_addr & 0xFFFFFFFFF000ULL;
-			pde_fields.system        = (page_table_base_addr >> 1) & 1;
-			pde_fields.valid         = page_table_base_addr & 1;
 
 			if ((asic->options.no_fold_vm_decode || memcmp(&pde_array[0], &pde_fields, sizeof pde_fields)) && asic->options.verbose)
 				asic->mem_funcs.vm_message("PDE=0x%016" PRIx64 ", PBA==0x%012" PRIx64 ", V=%" PRIu64 ", S=%" PRIu64 ", FS=%" PRIu64 "\n",
@@ -953,12 +989,7 @@ pde_is_pte:
 			if (umr_read_vram(asic, UMR_LINEAR_HUB, pde_fields.pte_base_addr + pte_idx * 8, 8, &pte_entry) < 0)
 				return -1;
 
-			// decode PTE values
-			pte_fields.page_base_addr = pte_entry & 0xFFFFFFFFF000ULL;
-			pte_fields.fragment       = (pte_entry >> 7)  & 0x1F;
-			pte_fields.system         = (pte_entry >> 1) & 1;
-			pte_fields.valid          = pte_entry & 1;
-			pte_fields.prt            = 0;
+			pte_fields = decode_pte_entry_ai(pte_entry);
 
 			if (asic->options.verbose)
 				asic->mem_funcs.vm_message("\\-> PTE=0x%016" PRIx64 ", VA=0x%016" PRIx64 ", PBA==0x%012" PRIx64 ", F=%" PRIu64 ", V=%" PRIu64 ", S=%" PRIu64 "\n",
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
