Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9055EC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 00:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B119110E3C0;
	Thu, 10 Mar 2022 00:42:58 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2083.outbound.protection.outlook.com [40.107.95.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CFA710E2F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 00:42:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grEAjpb4NPPvv6jNW0+uM87Y971SpFcgYgNLF7P3nZCkh2i/Jhu24PXhp6taE3JZj+CBPqz5l8AX7OpKGEuTiwKhhjRPf2903kps1u8pQE9rFAy/9iyrpb9/ke1Ee/ywP/kyk0UGvwdNIYhM71USMsKD38zaJKPnOFhnamoTEG0d2gZpqvMHIHll2Yyp/t8qnvGx/0fVylTiWdS0Iu9TxsUIkp18elcGk5aHbnFBT3kwKaesHE16AANHcB0BbNEFLmO7dz2b+rm5YZrwfLeRCHg/ko4S5yI3XQMSIDOva5SUtkHFbesZ6Zc6ryqH4gOCb5XnqM5wsN9T4MzXqxG3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8Syj4RXiyjoCvONtg+PAsJviYPtDqugLeP6zmTrubM=;
 b=ChylqS0O+lwevPQj4hsfHGLQGEcp/XIiEMNeKR858NBZkI0vioyKiTS2AIXBqWdh6n8LVMtJ+ycoKObf8V8daIybbBQHug/YVN1ErWF6VWsM7ZFeIzTz6okm/3roSw4DS6Dpixt6KGKXBsFndS5z4eivvdLUyw3e3jOCd0R0ic30M8FX37vjUI+y/3agwOg0EwCI6njcE+KfySgthODiWV7UFXkjyrryE4OYPAZeum0ZnBK8LwaSQU/A+hiEbj13OjkzmY7KJn8+PAudyvXjMpbclxZkgNi3jMcBLv7vjXhwnLAuz3MCk4Z5FNEOGc5aefMEKwaF2A7HIFCNJUXOcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8Syj4RXiyjoCvONtg+PAsJviYPtDqugLeP6zmTrubM=;
 b=if5WFWvdjOTnHZmOMp4nJsjAXNiz1F5e3LpGQEU+UGA2RFZ2KuNeFyRGII9kRCnPGTKPBkSqtdKlj3JnY6LHmM7YcY7CnXfNqKsGwk+XOWK7AhuHl6Aw86sy7lhsqSpNPK0LezVLeYFoMf1VhsEa6zWnBuYlCXVmfGu9A97iImc=
Received: from CO2PR05CA0072.namprd05.prod.outlook.com (2603:10b6:102:2::40)
 by BN8PR12MB3044.namprd12.prod.outlook.com (2603:10b6:408:45::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 00:42:53 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::75) by CO2PR05CA0072.outlook.office365.com
 (2603:10b6:102:2::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.17 via Frontend
 Transport; Thu, 10 Mar 2022 00:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 10 Mar 2022 00:42:52 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 9 Mar
 2022 18:42:49 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] umr: Consistent indentation in switch
Date: Wed, 9 Mar 2022 19:42:25 -0500
Message-ID: <20220310004226.50895-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.291.gdab1b7905d
In-Reply-To: <20220310004226.50895-1-luben.tuikov@amd.com>
References: <20220310004226.50895-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb359e41-ffa2-47c9-104a-08da022ee8ff
X-MS-TrafficTypeDiagnostic: BN8PR12MB3044:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB304438AFB9A3697C32525F9D990B9@BN8PR12MB3044.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fgcrkQ9X1rubkCw6/NnAImnDAlAhNmxixn0kz0DGfw/MnZYCTWZ717jv+r60tUEa8Jd7p58wXgU4Ea5CsIbLLB2d0aH/VUDIkBQ5NLLrVT7Q7d6tLU2Br0seiEPqLUdxyTwlfu5aVGBgYl5Pc7TsfklHvTlVg5IXFXgd1kn2e+yXE1Hjy+clHE1g482CkAaLt3aqffASvMKGNfROPSqh0QP8FAJzQaDVwvBvDmvbIfMPEYnbO/lg1uO9UEazFSQKt+Nf6IzBxfu6q9v70IZdmdzHd7khCFSMOIJbTBPyrW/d0uclEtNMZH/vwBugONUHSyDr0XBSUoN1A/CLAv94WKMTmQUd7uKgtC7LoRvHHyeT71TbNWndp2l9Vr7jlrsE3IsLyAtcrmUQxyfvIB0r3QiMZbchsCV/3db2WOZZOCSc1bX19gVIuimdbR6+3ymBuS6/D1Z5rczN+8no6IYzggcWHaVKn3dClCwfJLEB2PrX37JDbtclt8m59s+m65gXOOTNXr/W5g57YyB0UwUjMTgLujnfBRlpgS5OnYjbPHS3zp9OxwV+bvnikqqjh+QtzLemxu3z3cu5CGOTycjKkul02AK1uX7mUXPM/W52aGJsmab9jRwptnpqaEhrItko3VjamqB1EMMj3Ap5v2U24HaFznmRFRie+zN4p8snVl4/tRVjzlXnwgnbJzLkLpn6BiDmfovGEEXWzCZkXtao1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(508600001)(54906003)(40460700003)(6916009)(26005)(186003)(336012)(426003)(1076003)(16526019)(2616005)(82310400004)(86362001)(7696005)(47076005)(36860700001)(6666004)(83380400001)(36756003)(8676002)(4326008)(44832011)(5660300002)(2906002)(81166007)(70206006)(70586007)(8936002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 00:42:52.5252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb359e41-ffa2-47c9-104a-08da022ee8ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3044
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Tom StDenis <tom.stdenis@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A mix of multiple spaces and TAB char was being used in this switch. This
commit makes the usage of indent chars consistent, i.e. leading-TAB only.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 src/lib/ih_decode_vectors.c | 80 ++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/src/lib/ih_decode_vectors.c b/src/lib/ih_decode_vectors.c
index bb9764bb01783d..ed5705059c542f 100644
--- a/src/lib/ih_decode_vectors.c
+++ b/src/lib/ih_decode_vectors.c
@@ -41,48 +41,48 @@ int umr_ih_decode_vectors(struct umr_asic *asic, struct umr_ih_decode_ui *ui, ui
 	uint32_t off = 0;
 
 	switch (asic->family) {
-		case FAMILY_VI: // oss30
-			while (length) {
-				ui->start_vector(ui, off);
-				ui->add_field(ui, off + 0, "SourceID",   BITS(ih_data[off + 0], 0, 8), NULL, 10); // TODO: add ID to name translation
-				ui->add_field(ui, off + 1, "SourceData", BITS(ih_data[off + 1], 0, 24), NULL, 16);
-				ui->add_field(ui, off + 2, "VMID",       BITS(ih_data[off + 2], 8, 16), NULL, 10);
-				ui->add_field(ui, off + 2, "PASID",      BITS(ih_data[off + 2], 16, 32), NULL, 10);
-				ui->add_field(ui, off + 3, "ContextID0", ih_data[off + 3], NULL, 16);
-				ui->done(ui);
-				length -= 16;
-				off += 4;
-			}
-			return off / 4;
+	case FAMILY_VI: // oss30
+		while (length) {
+			ui->start_vector(ui, off);
+			ui->add_field(ui, off + 0, "SourceID",   BITS(ih_data[off + 0], 0, 8), NULL, 10); // TODO: add ID to name translation
+			ui->add_field(ui, off + 1, "SourceData", BITS(ih_data[off + 1], 0, 24), NULL, 16);
+			ui->add_field(ui, off + 2, "VMID",       BITS(ih_data[off + 2], 8, 16), NULL, 10);
+			ui->add_field(ui, off + 2, "PASID",      BITS(ih_data[off + 2], 16, 32), NULL, 10);
+			ui->add_field(ui, off + 3, "ContextID0", ih_data[off + 3], NULL, 16);
+			ui->done(ui);
+			length -= 16;
+			off += 4;
+		}
+		return off / 4;
 
-		case FAMILY_NV: // oss40/50
-		case FAMILY_AI:
-			while (length) {
-				ui->start_vector(ui, off);
-				ui->add_field(ui, off + 0, "ClientID", BITS(ih_data[off + 0], 0, 8), NULL, 10); // TODO: add ID to name translation
-				ui->add_field(ui, off + 0, "SourceID", BITS(ih_data[off + 0], 8, 16), NULL, 10); // TODO: add ID to name translation
-				ui->add_field(ui, off + 0, "RingID",   BITS(ih_data[off + 0], 16, 24), NULL, 10);
-				ui->add_field(ui, off + 0, "VMID",     BITS(ih_data[off + 0], 24, 28), NULL, 10);
-				ui->add_field(ui, off + 0, "VMID_TYPE", BITS(ih_data[off + 0], 31, 32), NULL, 10);
-				ui->add_field(ui, off + 1, "Timestamp", ih_data[off + 1] + ((uint64_t)BITS(ih_data[off+2], 0, 16) << 32), NULL, 10);
-				ui->add_field(ui, off + 2, "Timestamp_SRC", BITS(ih_data[off + 2], 31, 32), NULL, 10);
-				ui->add_field(ui, off + 3, "PASID", BITS(ih_data[off + 3], 0, 16), NULL, 16);
-				ui->add_field(ui, off + 4, "ContextID0", ih_data[off + 4], NULL, 16);
-				ui->add_field(ui, off + 5, "ContextID1", ih_data[off + 5], NULL, 16);
-				ui->add_field(ui, off + 6, "ContextID2", ih_data[off + 6], NULL, 16);
-				ui->add_field(ui, off + 7, "ContextID3", ih_data[off + 7], NULL, 16);
-				ui->done(ui);
-				length -= 32;
-				off += 8;
-			}
-			return off / 8;
+	case FAMILY_NV: // oss40/50
+	case FAMILY_AI:
+		while (length) {
+			ui->start_vector(ui, off);
+			ui->add_field(ui, off + 0, "ClientID", BITS(ih_data[off + 0], 0, 8), NULL, 10); // TODO: add ID to name translation
+			ui->add_field(ui, off + 0, "SourceID", BITS(ih_data[off + 0], 8, 16), NULL, 10); // TODO: add ID to name translation
+			ui->add_field(ui, off + 0, "RingID",   BITS(ih_data[off + 0], 16, 24), NULL, 10);
+			ui->add_field(ui, off + 0, "VMID",     BITS(ih_data[off + 0], 24, 28), NULL, 10);
+			ui->add_field(ui, off + 0, "VMID_TYPE", BITS(ih_data[off + 0], 31, 32), NULL, 10);
+			ui->add_field(ui, off + 1, "Timestamp", ih_data[off + 1] + ((uint64_t)BITS(ih_data[off+2], 0, 16) << 32), NULL, 10);
+			ui->add_field(ui, off + 2, "Timestamp_SRC", BITS(ih_data[off + 2], 31, 32), NULL, 10);
+			ui->add_field(ui, off + 3, "PASID", BITS(ih_data[off + 3], 0, 16), NULL, 16);
+			ui->add_field(ui, off + 4, "ContextID0", ih_data[off + 4], NULL, 16);
+			ui->add_field(ui, off + 5, "ContextID1", ih_data[off + 5], NULL, 16);
+			ui->add_field(ui, off + 6, "ContextID2", ih_data[off + 6], NULL, 16);
+			ui->add_field(ui, off + 7, "ContextID3", ih_data[off + 7], NULL, 16);
+			ui->done(ui);
+			length -= 32;
+			off += 8;
+		}
+		return off / 8;
 
-			case FAMILY_CONFIGURE:
-			case FAMILY_SI:
-			case FAMILY_CIK:
-			case FAMILY_NPI:
-				asic->err_msg("[BUG]: unhandled family case in umr_ih_decode_vectors()\n");
-				return -1;
+	case FAMILY_CONFIGURE:
+	case FAMILY_SI:
+	case FAMILY_CIK:
+	case FAMILY_NPI:
+		asic->err_msg("[BUG]: unhandled family case in umr_ih_decode_vectors()\n");
+		return -1;
 	}
 	return 0;
 }
-- 
2.35.1.291.gdab1b7905d

