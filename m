Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D46ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 21:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043E910E6FD;
	Thu, 27 Oct 2022 21:51:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3793910E6FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 21:51:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAqgeFJ8eRgg+hsJMwLPJA8RQmWF8URcjxI+EWt7HNIKENa6dTk2RL2VB5mw0xwnbWpDUGgqdX8Zq92ym0chwTMhjAjzhVxI5HY2afWBrej5lwHOVZwxeTlBF39xZGIm1x4AtPz63sY5jO5Epy60Za5K7UrJPigmWao9vdKQRCbzhVhJGUilHywhmZh7NiEWh6RJTgCiNyY1gC+IMLHGYjpAV1d/qSg3rZgRUL0EAV8tvFz0Qtx5clGPpsFlozrB3JKku5s1nphaKHmdKMzsdN5rQDHLOb4T4Lc12ITPsxFc1LxaziRgeRS+/x0L8AffpbFR/X8Klhd8pWafLzDNJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhDZJi/Xeg0Ce68/B3xjOWXwLrOWh0OSkmkAIm3mvE8=;
 b=ghtgb5glyhXTleeWYIGav/LsaU+NLnQM/vTaO5RLMT9B9iT3443kK52mknSDEM3KdLzNgFY0DvVGDImf962bEB92i/qR4e2zjGjMGhghINp8VQAnkixupZlb1Lqt1/t/iRU/itMlJPILdxC7e1Dqg/dAIlLt3SckW0n1UePId2Hi+fK6a0FvqVdHm/XpWKZpozsC+YiYdVK+9NgNKyLePAMGuTRY85tjDS3YX69SaBu+mc2/81mW9VmOrCFlYG13mTcCMwLSQcqFVzqOQhaZy0AvcoPr3J0AiPLBHWwpw1eCMK2NMp2VWh1r3+OLacpB79ntLYXqww4kzGc1Z46+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhDZJi/Xeg0Ce68/B3xjOWXwLrOWh0OSkmkAIm3mvE8=;
 b=MnuibnGrty4nKcJwfyWbXMtS7zMGoxsojN8EgU0oKt4099CvFV9oiIZWQ+ng+q3gquM6ZwI3ID3YCySrKxEQb4eWs021+w06HNTaw2LD/8ye7zkNgv8NspmOPcBE/UfeXv5LQXwVtJ9JqSra+pT7+inkBRXauN3N/NBdF3YgFO4=
Received: from BN1PR10CA0016.namprd10.prod.outlook.com (2603:10b6:408:e0::21)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 21:51:40 +0000
Received: from BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::f4) by BN1PR10CA0016.outlook.office365.com
 (2603:10b6:408:e0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Thu, 27 Oct 2022 21:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT069.mail.protection.outlook.com (10.13.176.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Thu, 27 Oct 2022 21:51:40 +0000
Received: from MKM-L10-COLIN38.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 16:51:39 -0500
From: Colin Lee <Colin.Lee@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] Update and refactor PTE/PDE decoding
Date: Thu, 27 Oct 2022 17:50:26 -0400
Message-ID: <20221027215024.21982-1-Colin.Lee@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT069:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 7348de29-39d6-435b-68cf-08dab8656dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WSf7ladmCzAw1Mvpv2hTO8rmL4hqgSLwuba+7exYLX1xu1ZVD3gxgfqs+7KpSsaOCnADKxwGwjGGc1xmYfUqM+UpueRIp0j0AzR2X048EZbZZBqFRVk3WcNDaSibKBPkN8PoTQYM+Q8RHOXY0ITaqMleAgnMmTzujDFJjTIcpY0Vm5cDCBb12JfvlRn9lvQAFPdgN2EOCo+S89wp6BTd2iXeAXOKDED0PstaWCM0bGaeqWrm+i2cZtIsIlznPXr6R250isc/6IVuXkDObluzyZcogtEogqeYYnhmaJMQUwHistDpgDcTGlg2UIezvZG7XuCVPYLW2AzEgWTNZsEUHxpIraK351Y4OMDImbV0V7vHGSaRt3Zx1IlR22bW4HLy6t+joLSJIodMFwjlZy6cCGzBT/09aJ2mZyucL34ISecc0fwpufHo309XM2CDgGzQ/dGvQ0cTYoaJmSKoFmpfsYKV7jlvWdE3fZHcWueyiJnXXAZZYLKmqfvlzyWLFcZj3Hu56qUXzz8XqZj1Y2UaH5bvN3V2ACrRLBAk/+Poo7tOCTxzPdIT0iVBsor+2Pqh9iNcVR4hm9Xc4emQ4H1FNWIxJstWL2ru8OeqAqVGLZ0B1beKU0zzljfo2HShP1N2s8lpv07+CR+0YNLfM75Ianva8nwpS7t7USj50w2w9c6hyAS+YOSJwdYVAdLgzxIPtgFcNkHMWkBbW5VfFon8JXR+Pxwb106J7QCKkUq1hN09QXmuHOFagKWn6oQHS6FwKgkY1V8R3vBWLaAl5xxvkSNFBxNa4s6IShAeakZICVsqEqx+dnAMlSMkqdQenXxV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(478600001)(316002)(26005)(82310400005)(54906003)(6916009)(4326008)(7696005)(8676002)(70586007)(6666004)(2906002)(36756003)(36860700001)(186003)(40480700001)(356005)(70206006)(86362001)(1076003)(81166007)(336012)(40460700003)(2616005)(426003)(83380400001)(47076005)(82740400003)(16526019)(8936002)(41300700001)(30864003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 21:51:40.0050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7348de29-39d6-435b-68cf-08dab8656dd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368
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
Cc: Tom St Denis <tom.stdenis@amd.com>, Colin Lee <Colin.Lee@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Newer generations of hardware encode the PDE and PTE
bitfields differently. This patch refactors this decoding
and printing.

gfx11 hardware introduces TFS addressing relative
to PDE0 which this patch also enables.

v2:
	* Add PTE software field and PDE mtype field
	* Include MC offset in PTE-as-PDE lookup case
	* Check valid before entering PTE-AS-PDE case

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
Signed-off-by: Colin Lee <Colin.Lee@amd.com>
---
 src/app/server.c    |   2 +-
 src/lib/read_vram.c | 399 ++++++++++++++++++++++++++++++++++----------
 src/umr.h           |  16 +-
 3 files changed, 322 insertions(+), 95 deletions(-)

diff --git a/src/app/server.c b/src/app/server.c
index 820d914..aac52ed 100644
--- a/src/app/server.c
+++ b/src/app/server.c
@@ -644,7 +644,7 @@ struct {
 } page_table[64];
 int num_page_table_entries;
 
-static void my_va_decode(pde_fields_ai_t *pdes, int num_pde, pte_fields_ai_t pte) {
+static void my_va_decode(pde_fields_t *pdes, int num_pde, pte_fields_t pte) {
 	for (int i = 0; i < num_pde; i++) {
 		page_table[num_page_table_entries].pba = pdes[i].pte_base_addr;
 		page_table[num_page_table_entries].type = i == 0 ? 0 : 1;
diff --git a/src/lib/read_vram.c b/src/lib/read_vram.c
index b6e92c1..c62717a 100644
--- a/src/lib/read_vram.c
+++ b/src/lib/read_vram.c
@@ -336,16 +336,44 @@ static uint64_t log2_vm_size(uint64_t page_table_start_addr, uint64_t page_table
  * 1 system
  * 0 valid
  */
-static pde_fields_ai_t decode_pde_entry_ai(uint64_t pde_entry)
+static pde_fields_t decode_pde_entry(const struct umr_asic *asic, uint64_t pde_entry)
 {
-	pde_fields_ai_t pde_fields;
-	pde_fields.frag_size     = (pde_entry >> 59) & 0x1F;
-	pde_fields.pte_base_addr = pde_entry & 0xFFFFFFFFFFC0ULL;
-	pde_fields.valid         = pde_entry & 1;
-	pde_fields.system        = (pde_entry >> 1) & 1;
-	pde_fields.coherent      = (pde_entry >> 2) & 1;
-	pde_fields.pte           = (pde_entry >> 54) & 1;
-	pde_fields.further       = (pde_entry >> 56) & 1;
+	pde_fields_t pde_fields = { 0 };
+	struct umr_ip_block *ip;
+
+	ip = umr_find_ip_block(asic, "gfx", asic->options.vm_partition);
+	if (!ip) {
+		asic->err_msg("[BUG]: Cannot find a 'gfx' IP block in this ASIC\n");
+		return pde_fields;
+	}
+
+	switch (ip->discoverable.maj) {
+		case 9:
+		case 10:
+			pde_fields.frag_size     = (pde_entry >> 59) & 0x1F;
+			pde_fields.pte_base_addr = pde_entry & 0xFFFFFFFFFFC0ULL;
+			pde_fields.valid         = pde_entry & 1;
+			pde_fields.system        = (pde_entry >> 1) & 1;
+			pde_fields.coherent      = (pde_entry >> 2) & 1;
+			pde_fields.pte           = (pde_entry >> 54) & 1;
+			pde_fields.further       = (pde_entry >> 56) & 1;
+			if (ip->discoverable.min >= 3) {
+				pde_fields.llc_noalloc   = (pde_entry >> 58) & 1;
+			}
+			break;
+		case 11:
+			pde_fields.frag_size     = (pde_entry >> 59) & 0x1F;
+			pde_fields.pte_base_addr = pde_entry & 0xFFFFFFFFFFC0ULL;
+			pde_fields.valid         = pde_entry & 1;
+			pde_fields.system        = (pde_entry >> 1) & 1;
+			pde_fields.coherent      = (pde_entry >> 2) & 1;
+			pde_fields.mtype         = (pde_entry >> 48) & 7;
+			pde_fields.pte           = (pde_entry >> 54) & 1;
+			pde_fields.further       = (pde_entry >> 56) & 1;
+			pde_fields.tfs_addr      = (pde_entry >> 57) & 1;
+			pde_fields.llc_noalloc   = (pde_entry >> 58) & 1;
+			break;
+	}
 	return pde_fields;
 }
 
@@ -368,25 +396,76 @@ static pde_fields_ai_t decode_pde_entry_ai(uint64_t pde_entry)
  * 1 system
  * 0 valid
  */
-static pte_fields_ai_t decode_pte_entry_ai(int is_gfx9, uint64_t pte_entry)
+static pte_fields_t decode_pte_entry(const struct umr_asic *asic, uint64_t pte_entry)
 {
-	pte_fields_ai_t pte_fields;
-	pte_fields.valid          = pte_entry & 1;
-	pte_fields.system         = (pte_entry >> 1) & 1;
-	pte_fields.coherent       = (pte_entry >> 2) & 1;
-	pte_fields.tmz            = (pte_entry >> 3) & 1;
-	pte_fields.execute        = (pte_entry >> 4) & 1;
-	pte_fields.read           = (pte_entry >> 5) & 1;
-	pte_fields.write          = (pte_entry >> 6) & 1;
-	pte_fields.fragment       = (pte_entry >> 7) & 0x1F;
-	pte_fields.prt            = (pte_entry >> 51) & 1;
-	pte_fields.pde            = (pte_entry >> 54) & 1;
-	pte_fields.further        = (pte_entry >> 56) & 1;
-	pte_fields.mtype          = (pte_entry >> (is_gfx9 ? 57 : 48)) & 3;
+	pte_fields_t pte_fields = { 0 };
+	uint64_t is_pde = 0;
+	struct umr_ip_block *ip;
+
+	ip = umr_find_ip_block(asic, "gfx", asic->options.vm_partition);
+	if (!ip) {
+		asic->err_msg("[BUG]: Cannot find a 'gfx' IP block in this ASIC\n");
+		return pte_fields;
+	}
+
+	switch (ip->discoverable.maj) {
+		case 9:
+			pte_fields.valid          = pte_entry & 1;
+			pte_fields.system         = (pte_entry >> 1) & 1;
+			pte_fields.coherent       = (pte_entry >> 2) & 1;
+			pte_fields.tmz            = (pte_entry >> 3) & 1;
+			pte_fields.execute        = (pte_entry >> 4) & 1;
+			pte_fields.read           = (pte_entry >> 5) & 1;
+			pte_fields.write          = (pte_entry >> 6) & 1;
+			pte_fields.fragment       = (pte_entry >> 7) & 0x1F;
+			pte_fields.prt            = (pte_entry >> 51) & 1;
+			pte_fields.pde            = (pte_entry >> 54) & 1;
+			pte_fields.further        = (pte_entry >> 56) & 1;
+			pte_fields.mtype          = (pte_entry >> 57) & 3;
+			is_pde                    = pte_fields.further;
+			break;
+		case 10:
+			pte_fields.valid          = pte_entry & 1;
+			pte_fields.system         = (pte_entry >> 1) & 1;
+			pte_fields.coherent       = (pte_entry >> 2) & 1;
+			pte_fields.tmz            = (pte_entry >> 3) & 1;
+			pte_fields.execute        = (pte_entry >> 4) & 1;
+			pte_fields.read           = (pte_entry >> 5) & 1;
+			pte_fields.write          = (pte_entry >> 6) & 1;
+			pte_fields.fragment       = (pte_entry >> 7) & 0x1F;
+			pte_fields.mtype          = (pte_entry >> 48) & 3;
+			pte_fields.prt            = (pte_entry >> 51) & 1;
+			pte_fields.pde            = (pte_entry >> 54) & 1;
+			pte_fields.further        = (pte_entry >> 56) & 1;
+			pte_fields.gcr            = (pte_entry >> 57) & 1;
+			if (ip->discoverable.min >= 3) {
+				pte_fields.llc_noalloc    = (pte_entry >> 58) & 1;
+			}
+			is_pde                    = pte_fields.further;
+			break;
+		case 11:
+			pte_fields.valid          = pte_entry & 1;
+			pte_fields.system         = (pte_entry >> 1) & 1;
+			pte_fields.coherent       = (pte_entry >> 2) & 1;
+			pte_fields.tmz            = (pte_entry >> 3) & 1;
+			pte_fields.execute        = (pte_entry >> 4) & 1;
+			pte_fields.read           = (pte_entry >> 5) & 1;
+			pte_fields.write          = (pte_entry >> 6) & 1;
+			pte_fields.fragment       = (pte_entry >> 7) & 0x1F;
+			pte_fields.mtype          = (pte_entry >> 48) & 3;
+			pte_fields.prt            = (pte_entry >> 51) & 1;
+			pte_fields.software       = (pte_entry >> 52) & 3;
+			pte_fields.pde            = (pte_entry >> 54) & 1;
+			pte_fields.further        = (pte_entry >> 56) & 1;
+			pte_fields.gcr            = (pte_entry >> 57) & 1;
+			pte_fields.llc_noalloc    = (pte_entry >> 58) & 1;
+			is_pde                    = pte_fields.further;
+			break;
+	}
 
 	// PTEs hold physical address in 47:12
 	// PDEs hold physical address in 47:6, so if this is a PTE-as-PDE (further), need a differnt mask
-	if (pte_fields.further)
+	if (is_pde)
 		pte_fields.page_base_addr = pte_entry & 0xFFFFFFFFFFC0ULL;
 	else
 		pte_fields.page_base_addr = pte_entry & 0xFFFFFFFFF000ULL;
@@ -394,25 +473,78 @@ static pte_fields_ai_t decode_pte_entry_ai(int is_gfx9, uint64_t pte_entry)
 	return pte_fields;
 }
 
-static void print_pde_fields_ai(struct umr_asic *asic,
-				pde_fields_ai_t pde_fields)
+static void print_pde_fields(struct umr_asic *asic,
+				pde_fields_t pde_fields)
 {
-	asic->mem_funcs.vm_message(
-			", PBA==0x%012" PRIx64 ", V=%" PRIu64
-			", S=%" PRIu64 ", C=%" PRIu64
-			", P=%" PRIu64 ", FS=%" PRIu64 "\n",
-			pde_fields.pte_base_addr,
-			pde_fields.valid,
-			pde_fields.system,
-			pde_fields.coherent,
-			pde_fields.pte,
-			pde_fields.frag_size);
+	struct umr_ip_block *ip;
+
+	ip = umr_find_ip_block(asic, "gfx", asic->options.vm_partition);
+	if (!ip) {
+		asic->err_msg("[BUG]: Cannot find a 'gfx' IP block in this ASIC\n");
+		return;
+	}
+
+	switch (ip->discoverable.maj) {
+		case 9:
+		case 10:
+			if (ip->discoverable.maj == 9 || ip->discoverable.min < 2) {
+				asic->mem_funcs.vm_message(
+						", PBA==0x%012" PRIx64 ", V=%" PRIu64
+						", S=%" PRIu64 ", C=%" PRIu64
+						", P=%" PRIu64 ", FS=%" PRIu64 "\n",
+						pde_fields.pte_base_addr,
+						pde_fields.valid,
+						pde_fields.system,
+						pde_fields.coherent,
+						pde_fields.pte,
+						pde_fields.frag_size);
+			} else {
+				asic->mem_funcs.vm_message(
+						", PBA==0x%012" PRIx64 ", V=%" PRIu64
+						", S=%" PRIu64 ", C=%" PRIu64
+						", P=%" PRIu64 ", FS=%" PRIu64 ", Y=%" PRIu64 "\n",
+						pde_fields.pte_base_addr,
+						pde_fields.valid,
+						pde_fields.system,
+						pde_fields.coherent,
+						pde_fields.pte,
+						pde_fields.frag_size,
+						pde_fields.llc_noalloc);
+			}
+			break;
+		case 11:
+			asic->mem_funcs.vm_message(
+					", PBA==0x%012" PRIx64 ", V=%" PRIu64
+					", S=%" PRIu64 ", C=%" PRIu64
+					", MTYPE=%" PRIu64
+					", P=%" PRIu64 ", FS=%" PRIu64
+					", A=%" PRIu64 ", Y=%" PRIu64 "\n",
+					pde_fields.pte_base_addr,
+					pde_fields.valid,
+					pde_fields.system,
+					pde_fields.coherent,
+					pde_fields.mtype,
+					pde_fields.pte,
+					pde_fields.frag_size,
+					pde_fields.tfs_addr,
+					pde_fields.llc_noalloc);
+			break;
+	}
 }
-static void print_base_ai(struct umr_asic *asic,
+
+static void print_base(struct umr_asic *asic,
 			  uint64_t pde_entry, uint64_t address,
-			  uint64_t va_mask, pde_fields_ai_t pde_fields,
+			  uint64_t va_mask, pde_fields_t pde_fields,
 			  int is_base_not_pde)
 {
+	struct umr_ip_block *ip;
+
+	ip = umr_find_ip_block(asic, "gfx", asic->options.vm_partition);
+	if (!ip) {
+		asic->err_msg("[BUG]: Cannot find a 'gfx' IP block in this ASIC\n");
+		return;
+	}
+
 	if (is_base_not_pde)
 		asic->mem_funcs.vm_message("BASE");
 	else
@@ -420,17 +552,25 @@ static void print_base_ai(struct umr_asic *asic,
 	asic->mem_funcs.vm_message("=0x%016" PRIx64 ", VA=0x%012" PRIx64,
 			pde_entry,
 			address & va_mask);
-	print_pde_fields_ai(asic, pde_fields);
+	print_pde_fields(asic, pde_fields);
 }
 
-static void print_pde_ai(struct umr_asic *asic,
+static void print_pde(struct umr_asic *asic,
 		const char * indentation, int pde_cnt,
 		int page_table_depth, uint64_t prev_addr,
 		uint64_t pde_idx, uint64_t pde_entry, uint64_t address,
-		uint64_t va_mask, pde_fields_ai_t pde_fields)
+		uint64_t va_mask, pde_fields_t pde_fields, int was_pte)
 {
+	struct umr_ip_block *ip;
+
+	ip = umr_find_ip_block(asic, "gfx", asic->options.vm_partition);
+	if (!ip) {
+		asic->err_msg("[BUG]: Cannot find a 'gfx' IP block in this ASIC\n");
+		return;
+	}
+
 	asic->mem_funcs.vm_message("%s ", &indentation[18-pde_cnt*3]);
-	if (pde_fields.further)
+	if (was_pte)
 		asic->mem_funcs.vm_message("PTE-FURTHER");
 	else
 		asic->mem_funcs.vm_message("PDE%d", page_table_depth - pde_cnt);
@@ -441,44 +581,102 @@ static void print_pde_ai(struct umr_asic *asic,
 			pde_idx,
 			pde_entry,
 			address & va_mask);
-	print_pde_fields_ai(asic, pde_fields);
+	print_pde_fields(asic, pde_fields);
 }
 
-static void print_pte_ai(struct umr_asic *asic,
+static void print_pte(struct umr_asic *asic,
 		const char * indentation, int pde_cnt, int page_table_depth_count, uint64_t prev_addr,
 		uint64_t pte_idx, uint64_t pte_entry, uint64_t address,
-		uint64_t va_mask, pte_fields_ai_t pte_fields)
+		uint64_t va_mask, pte_fields_t pte_fields, int was_pde)
 {
+	struct umr_ip_block *ip;
+
+	ip = umr_find_ip_block(asic, "gfx", asic->options.vm_partition);
+	if (!ip) {
+		asic->err_msg("[BUG]: Cannot find a 'gfx' IP block in this ASIC\n");
+		return;
+	}
+
 	if (indentation == NULL) {
 		asic->mem_funcs.vm_message("\\-> PTE");
 	} else {
 		asic->mem_funcs.vm_message("%s ",
 				&indentation[18-pde_cnt*3]);
-		if (pte_fields.pde)
+		if (was_pde)
 			asic->mem_funcs.vm_message("PDE%d-as-PTE", page_table_depth_count - pde_cnt);
 		else
 			asic->mem_funcs.vm_message("PTE");
 	}
 	asic->mem_funcs.vm_message("@{0x%" PRIx64 "/0x%" PRIx64"}",
 			prev_addr, pte_idx);
-	asic->mem_funcs.vm_message("=0x%016" PRIx64 ", VA=0x%012" PRIx64
-			", PBA==0x%012" PRIx64 ", V=%" PRIu64
-			", S=%" PRIu64 ", C=%" PRIu64 ", Z=%" PRIu64
-			", X=%" PRIu64 ", R=%" PRIu64 ", W=%" PRIu64
-			", FS=%" PRIu64 ", T=%" PRIu64 ", MTYPE=",
-			pte_entry,
-			address & va_mask,
-			pte_fields.page_base_addr,
-			pte_fields.valid,
-			pte_fields.system,
-			pte_fields.coherent,
-			pte_fields.tmz,
-			pte_fields.execute,
-			pte_fields.read,
-			pte_fields.write,
-			pte_fields.fragment,
-			pte_fields.prt,
-			pte_fields.mtype);
+
+	switch (ip->discoverable.maj) {
+		case 9:
+			asic->mem_funcs.vm_message("=0x%016" PRIx64 ", VA=0x%012" PRIx64
+					", PBA==0x%012" PRIx64 ", V=%" PRIu64
+					", S=%" PRIu64 ", C=%" PRIu64 ", Z=%" PRIu64
+					", X=%" PRIu64 ", R=%" PRIu64 ", W=%" PRIu64
+					", FS=%" PRIu64 ", T=%" PRIu64 ", MTYPE=",
+					pte_entry,
+					address & va_mask,
+					pte_fields.page_base_addr,
+					pte_fields.valid,
+					pte_fields.system,
+					pte_fields.coherent,
+					pte_fields.tmz,
+					pte_fields.execute,
+					pte_fields.read,
+					pte_fields.write,
+					pte_fields.fragment,
+					pte_fields.prt,
+					pte_fields.mtype);
+			break;
+		case 10:
+			asic->mem_funcs.vm_message("=0x%016" PRIx64 ", VA=0x%012" PRIx64
+					", PBA==0x%012" PRIx64 ", V=%" PRIu64
+					", S=%" PRIu64 ", C=%" PRIu64 ", Z=%" PRIu64
+					", X=%" PRIu64 ", R=%" PRIu64 ", W=%" PRIu64
+					", FS=%" PRIu64 ", T=%" PRIu64 ", G=%" PRIu64 ", MTYPE=",
+					pte_entry,
+					address & va_mask,
+					pte_fields.page_base_addr,
+					pte_fields.valid,
+					pte_fields.system,
+					pte_fields.coherent,
+					pte_fields.tmz,
+					pte_fields.execute,
+					pte_fields.read,
+					pte_fields.write,
+					pte_fields.fragment,
+					pte_fields.prt,
+					pte_fields.gcr,
+					pte_fields.mtype);
+			break;
+		case 11:
+			asic->mem_funcs.vm_message("=0x%016" PRIx64 ", VA=0x%012" PRIx64
+					", PBA==0x%012" PRIx64 ", V=%" PRIu64
+					", S=%" PRIu64 ", C=%" PRIu64 ", Z=%" PRIu64
+					", X=%" PRIu64 ", R=%" PRIu64 ", W=%" PRIu64
+					", FS=%" PRIu64 ", T=%" PRIu64 ", SW=%" PRIu64
+					", G=%" PRIu64 ", Y=%" PRIu64 ", MTYPE=",
+					pte_entry,
+					address & va_mask,
+					pte_fields.page_base_addr,
+					pte_fields.valid,
+					pte_fields.system,
+					pte_fields.coherent,
+					pte_fields.tmz,
+					pte_fields.execute,
+					pte_fields.read,
+					pte_fields.write,
+					pte_fields.fragment,
+					pte_fields.prt,
+					pte_fields.software,
+					pte_fields.gcr,
+					pte_fields.llc_noalloc);
+			break;
+	}
+
 	switch (pte_fields.mtype) {
 		case 0:
 			asic->mem_funcs.vm_message("NC\n");
@@ -512,7 +710,7 @@ static int umr_access_vram_ai(struct umr_asic *asic, int partition,
 		 va_mask, offset_mask, system_aperture_low, system_aperture_high,
 		 fb_top, fb_bottom, ptb_mask, pte_page_mask, agp_base, agp_bot, agp_top, prev_addr;
 	uint32_t chunk_size, tmp, pde0_block_fragment_size;
-	int pde_cnt, current_depth, page_table_depth, zfb, further;
+	int pde_cnt, current_depth, page_table_depth, zfb, further, pde_was_pte;
 	struct {
 		uint32_t
 			mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_LO32,
@@ -535,14 +733,19 @@ static int umr_access_vram_ai(struct umr_asic *asic, int partition,
 			mmMC_VM_AGP_TOP;
 	} registers;
 
-	pde_fields_ai_t pde_fields, pde_array[8];
-	pte_fields_ai_t pte_fields;
+	pde_fields_t pde_fields, pde_array[8];
+	pte_fields_t pte_fields;
 	char buf[64];
 	unsigned char *pdst = dst;
 	char *hub, *vm0prefix, *regprefix;
 	unsigned hubid;
 	static const char *indentation = "                  \\->";
+	struct umr_ip_block *ip;
 
+	ip = umr_find_ip_block(asic, "gfx", asic->options.vm_partition);
+	if (!ip) {
+			asic->err_msg("[BUG]: Cannot find a 'gfx' IP block in this ASIC\n");
+	}
 	memset(&registers, 0, sizeof registers);
 	memset(&pde_array, 0xff, sizeof pde_array);
 
@@ -712,7 +915,7 @@ static int umr_access_vram_ai(struct umr_asic *asic, int partition,
 	}
 
 	// get PDE fields from page table base address
-	pde_fields = decode_pde_entry_ai(page_table_base_addr);
+	pde_fields = decode_pde_entry(asic, page_table_base_addr);
 
 	if (!pde_fields.system) {
 		// transform page_table_base (only if first PDB or the PTB is in VRAM)
@@ -777,9 +980,10 @@ static int umr_access_vram_ai(struct umr_asic *asic, int partition,
 		pte_page_mask = (1ULL << 12) - 1;
 		log2_ptb_entries = 9;
 		further = 0;
+		pde_was_pte = 0;
 
 		if (page_table_depth >= 1) {
-			pde_fields = decode_pde_entry_ai(pde_entry);
+			pde_fields = decode_pde_entry(asic, pde_entry);
 
 			// AI+ supports more than 1 level of PDEs so we iterate for all of the depths
 			pde_address = pde_fields.pte_base_addr;
@@ -803,7 +1007,7 @@ static int umr_access_vram_ai(struct umr_asic *asic, int partition,
 			va_mask <<= (total_vm_bits - top_pdb_bits);
 
 			if ((asic->options.no_fold_vm_decode || memcmp(&pde_fields, &pde_array[pde_cnt], sizeof pde_fields)) && asic->options.verbose)
-				print_base_ai(asic, pde_entry, address, va_mask, pde_fields, 1);
+				print_base(asic, pde_entry, address, va_mask, pde_fields, 1);
 			memcpy(&pde_array[pde_cnt++], &pde_fields, sizeof pde_fields);
 
 			current_depth = page_table_depth;
@@ -851,7 +1055,7 @@ static int umr_access_vram_ai(struct umr_asic *asic, int partition,
 					}
 				}
 
-				pde_fields = decode_pde_entry_ai(pde_entry);
+				pde_fields = decode_pde_entry(asic, pde_entry);
 				if (current_depth == 1) {
 					pde0_block_fragment_size = pde_fields.frag_size;
 					/*
@@ -869,13 +1073,14 @@ static int umr_access_vram_ai(struct umr_asic *asic, int partition,
 				}
 				if (!pde_fields.pte) {
 					if ((asic->options.no_fold_vm_decode || memcmp(&pde_fields, &pde_array[pde_cnt], sizeof pde_fields)) && asic->options.verbose) {
-						print_pde_ai(asic, indentation, pde_cnt, page_table_depth, prev_addr,
-								pde_idx, pde_entry, address, va_mask, pde_fields);
+						print_pde(asic, indentation, pde_cnt, page_table_depth, prev_addr,
+								pde_idx, pde_entry, address, va_mask, pde_fields, 0);
 					}
 					memcpy(&pde_array[pde_cnt++], &pde_fields, sizeof pde_fields);
 				} else {
 					pte_entry = pde_entry;
 					pte_idx = 0;
+					pde_was_pte = 1;
 					goto pde_is_pte;
 				}
 
@@ -935,7 +1140,7 @@ pte_further:
 			}
 
 pde_is_pte:
-			pte_fields = decode_pte_entry_ai(asic->family == FAMILY_AI, pte_entry);
+			pte_fields = decode_pte_entry(asic, pte_entry);
 
 			// How many bits in the address are used to index into the PTB?
 			// If further is set, that means we jumped back to pde_is_pte,
@@ -972,24 +1177,41 @@ pde_is_pte:
 				va_mask = va_mask & ~mask_to_ignore;
 			}
 
+			int pte_is_pde = pte_fields.further && pte_fields.valid;
+
 			if (asic->options.verbose) {
-				if (pte_fields.further) {
-					pde_fields = decode_pde_entry_ai(pte_entry);
-					print_pde_ai(asic, indentation, pde_cnt, page_table_depth, prev_addr,
-							pte_idx, pte_entry, address, va_mask, pde_fields);
+				if (pte_is_pde) {
+					print_pde(asic, indentation, pde_cnt, page_table_depth, prev_addr,
+							pte_idx, pte_entry, address, va_mask, decode_pde_entry(asic, pte_entry), pte_is_pde);
+
 				} else {
-					print_pte_ai(asic, indentation, pde_cnt, page_table_depth, prev_addr, pte_idx,
-							pte_entry, address, va_mask, pte_fields);
+					print_pte(asic, indentation, pde_cnt, page_table_depth, prev_addr, pte_idx,
+							pte_entry, address, va_mask, pte_fields, pde_was_pte);
 					pte_fields.pte_mask = va_mask;
 				}
 			}
 
 			uint32_t pte_block_fragment_size = 0;
-			if (pte_fields.further) {
+
+			if (pte_is_pde) {
+				// If further bit is set, PTE is a PDE, so set pde_fields to PTE
+				// decoded as a PDE.
+				if (ip->discoverable.maj >= 11 && pde_fields.tfs_addr && current_depth == 0 && !pde_was_pte) {
+					// When PDE0 had TFS bit set, real address of PTB for PTE-as-PDE
+					// to point is PDE0.PBA + PTE-as-PDE.PBA.
+					uint64_t tmp_addr = pde_fields.pte_base_addr;
+					pde_fields = decode_pde_entry(asic, pte_entry);
+					pde_fields.pte_base_addr += tmp_addr;
+				} else {
+					pde_fields = decode_pde_entry(asic, pte_entry);
+					if (!pde_fields.system)
+						pde_fields.pte_base_addr -= vm_fb_offset;
+				}
+
 				// Going to go one more layer deep, so now we need the Further-PTE's
 				// block_fragment_size. This tells us how many 4K pages each
 				// last-layer-PTE covers.
-				pte_block_fragment_size = (pte_entry >> 59) & 0x1F;
+				pte_block_fragment_size = pde_fields.frag_size;
 
 				// Each entry covers the Further-PTE.block_fragment_size numbesr
 				// of 4K pages so we can potentially ignore some low-order bits.
@@ -1008,10 +1230,9 @@ pde_is_pte:
 				pte_page_mask = (1ULL << last_level_ptb_bits) - 1;
 				va_mask &= (upper_mask & ~pte_page_mask);
 
-				// grab PTE base address and other data from the PTE that has the F bit set.
-				pde_fields = decode_pde_entry_ai(pte_entry);
 				pde_cnt++;
 				further = 1;
+				// Jump back to translate from PTB pointed to by this PTE-as-PDE.
 				goto pte_further;
 			}
 
@@ -1032,12 +1253,12 @@ pde_is_pte:
 		} else {
 			// in AI+ the BASE_ADDR is treated like a PDE entry...
 			// decode PDE values
-			pde_fields = decode_pde_entry_ai(pde_entry);
+			pde_fields = decode_pde_entry(asic, pde_entry);
 			pde0_block_fragment_size = pde_fields.frag_size;
 			pte_page_mask = (1ULL << (12 + pde0_block_fragment_size)) - 1;
 
 			if ((asic->options.no_fold_vm_decode || memcmp(&pde_array[0], &pde_fields, sizeof pde_fields)) && asic->options.verbose)
-				print_base_ai(asic, page_table_base_addr, address, -1, pde_fields, 0);
+				print_base(asic, page_table_base_addr, address, -1, pde_fields, 0);
 			memcpy(&pde_array[0], &pde_fields, sizeof pde_fields);
 
 			if (!pde_fields.valid)
@@ -1054,11 +1275,11 @@ pde_is_pte:
 					return -1;
 			}
 
-			pte_fields = decode_pte_entry_ai(asic->family == FAMILY_AI, pte_entry);
+			pte_fields = decode_pte_entry(asic, pte_entry);
 
 			if (asic->options.verbose)
-				print_pte_ai(asic, NULL, 0, 0, pde_fields.pte_base_addr, pte_idx, pte_entry, address,
-						~((uint64_t)0xFFF), pte_fields);
+				print_pte(asic, NULL, 0, 0, pde_fields.pte_base_addr, pte_idx, pte_entry, address,
+						~((uint64_t)0xFFF), pte_fields, 0);
 
 			if (pdst && !pte_fields.valid)
 				goto invalid_page;
diff --git a/src/umr.h b/src/umr.h
index e959d0c..54c9bf4 100644
--- a/src/umr.h
+++ b/src/umr.h
@@ -364,8 +364,11 @@ typedef struct {
 		system,
 		coherent,
 		pte,
-		further;
-} pde_fields_ai_t;
+		further,
+		tfs_addr,
+		llc_noalloc,
+		mtype;
+} pde_fields_t;
 
 typedef struct {
 	uint64_t
@@ -382,8 +385,11 @@ typedef struct {
 		pde,
 		further,
 		mtype,
-		pte_mask;
-} pte_fields_ai_t;
+		pte_mask,
+		gcr,
+		llc_noalloc,
+		software;
+} pte_fields_t;
 
 struct umr_memory_access_funcs {
 	/** access_sram -- Access System RAM
@@ -422,7 +428,7 @@ struct umr_memory_access_funcs {
 	 */
 	int (*vm_message)(const char *fmt, ...);
 
-	void (*va_addr_decode)(pde_fields_ai_t *pdes, int num_pde, pte_fields_ai_t pte);
+	void (*va_addr_decode)(pde_fields_t *pdes, int num_pde, pte_fields_t pte);
 
 	/** data -- opaque pointer the callbacks can use for state tracking */
 	void *data;
-- 
2.25.1

