Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF46C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Mar 2022 00:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4356F10E075;
	Sat, 12 Mar 2022 00:52:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DAB410E06A
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Mar 2022 00:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkRzDXociYzwJkeOSwHH4is68ehCAs6WDy9fiaVK5HUKFkabQqOn+Ipby2r9h+dQkdCRZHpx4pWTyyQXgZ6dT/KBpOAvlp6dipQhrB2x6/uyro0K7WJWRkMtl6tFL2+d84aRdcrC7WlhHuBeLBsCZXDhbKsbep/6G4eRU34XHY58eqlRXy20Tqm87RVWT8g/vny21uj9E/wvklwJyULJ4qVdxjTWqssb8/a9bbfRC+suo/22nP5YIe1hwAB3kFzELCpYMr5nQuusYoIqROZtrwinXOGQ9sdgIL2+bApavrXx+BaiS1NtovZWQWRdLHKEuCal1GLip/TkdSLkt1arOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EazR4teuiRuqTHD2p8tqcfa5AUN4caAZYJDUO8Ekso=;
 b=W20MnQtqjFINpzWF3o4vYQPXwyr0fsvLQSqOaC7zp1mJ/fdE+k1cWzBZg3NlGDsLeGtIYU8MU6ZH7O9XGT2diylRl52VdxSoF6Vx8+WUsKEyOGf/xhU7fi/VFiuwVhitluI12o5f+spSGBPgW/OlhHAjz8ZmGKtIQef+lLpQD1vSXW5L+xigdicdSOoKyAJYjtrTXQfHuJgrnuCqh0+Dq5jYPr3XGXODtUnPEGDHWZCJvR5LvZzOzwCdw3jWhsvAVWNZtBSEjGvbmD0cpQ3EciBWoh1YZRF3I7I4a8McqF4LZa9YSUe+U/DY9dwOIDPxb2IMmlLBtfifUM8Ln7KKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EazR4teuiRuqTHD2p8tqcfa5AUN4caAZYJDUO8Ekso=;
 b=mukIidmOpT3F0/nflhrcWiZdFKrIW+nFOqDSVdjUyi5ciifshqWzoTC+HpNCQ9QPeMOPzLjLlL62d4QNcewOyj9A1Ccwknhw/qrRc7WmSrxbndzZf9QEMkO66+otGCqt5am57TqP9N3p2lApDV03xWT4wDK29kWm0QB+lb0DrIU=
Received: from DM5PR1401CA0023.namprd14.prod.outlook.com (2603:10b6:4:4a::33)
 by BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Sat, 12 Mar
 2022 00:52:39 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::f7) by DM5PR1401CA0023.outlook.office365.com
 (2603:10b6:4:4a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Sat, 12 Mar 2022 00:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Sat, 12 Mar 2022 00:52:39 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 18:52:36 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v1 3/4] umr: Consistent indentation in switch
Date: Fri, 11 Mar 2022 19:52:05 -0500
Message-ID: <20220312005206.26588-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.291.gdab1b7905d
In-Reply-To: <20220312005206.26588-1-luben.tuikov@amd.com>
References: <20220312005206.26588-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c13a5c83-40c6-4e3b-bf5c-08da03c29b7d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5259:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5259CF514B8197F08A722519990D9@BN9PR12MB5259.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ROAcEDuiWIm91gp+0eKbvxgaHJ6KgwnYFdRXlG2i3teq6fy+8WRu1NWnIeVKOOFHWazdPlTSDxd2M1J5XkRB55JGyfNlSYaWqSzOKgFcxGgSOpvoGx+RETSmeNooQpucyzsnTdQWuzaN3SoAGxwSwG9+os5FD1EOoB0KbF/HGmxYaZG3drvXcDqJNt39gZjNPP/jT+3X+QoT45rDiTr5xQZcp8CZjiVbmAgpN5CTtr49H4dwxLTyNjVV7cintjE42tOLhq7FoalovnJlRRVlz35HZxNVlXO7H7A1bN9sg6kIO8hhqrPAzCmfy4B9USQ8TxzLVaLax7aDK6GiMJ9fSr9Mdz9PqGLAc9z3uBfCxCenaMR8d72Ai/1W6DgmlEvwzJL9PTT7U1OWjdEJfximL0mcAgQQqIzAUW/DwHirAHu+4FxInW91fsuXhFgVWVxAxVMoXjzveohtSQPLjptZSYviwB2S4S4PLxGMPACbgLh6O3K1ZvdHHWi8Vfptq+uiBgeSU9EjKQOfybLZM/1zGUQOxY7gkJ5CgzzdmnymcO5vtJTBEMuQQVYGSRbadhuO6jqwxcVhsgSPyL62AaC64QELRbdd0nHk6o0gQ9t2YI4rJd3NOZfFVUl4BI5D/Z2HkE8NQ5vU5XP5iKWPjBu4q9OlR9s3nk4ZfcHc1SwTV1Z3M5LhrNdekDu4D3XxAxPwzkkXfXs4IqLSK3Txxq/bVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(86362001)(4326008)(316002)(70586007)(8676002)(70206006)(36756003)(82310400004)(6666004)(7696005)(5660300002)(40460700003)(508600001)(6916009)(54906003)(426003)(356005)(186003)(26005)(1076003)(2616005)(81166007)(336012)(16526019)(2906002)(83380400001)(47076005)(8936002)(36860700001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2022 00:52:39.2501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c13a5c83-40c6-4e3b-bf5c-08da03c29b7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5259
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
Reviewed-by: Tom StDenis <tom.stdenis@amd.com>
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

