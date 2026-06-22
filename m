Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF43CDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 09:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD1A910E5B1;
	Mon, 22 Jun 2026 09:31:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qbBYa1ms";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013009.outbound.protection.outlook.com
 [40.93.196.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2878B10E5AA
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 09:31:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWI2j7RucddCi10wPSl4PnKZeVbI2cyZq6GkUZDg18ahXOZ1iNJP1WbPPgCKNgTbl1ZSpGovOoFiLKt5JBtGEj7ZNtVPFu/YlxQCZwdkXZ7Uib6rRfRQ1G84K2CsI+9w+Zfh/JDUmtxMbqX1A/NaUCgPS5eFDKonUFTY64+oLFIXnTptbN0dfA90pTHYK36qIVORVcvMmJyS0WRxq9ifwIr8qOcUmXc184//d/r+vyyCGF5y/RELeoZH1DU0iJIovO1mrS5fvUlgfpMH7lUufHQe4OYsubyMqsZ0IpqDt5OyJjEuKuuTPgE6fIcCNtWl0GtNKfqnuMVacKpsRf9XFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9DsqdA70wZrnLnWbesV5+bW0ewiidehU0c/swTYRAk=;
 b=gIiTN7TPPHWiZLNeoWqJORGitnb8zsodMVYmVKq7OgkJNOniuVOkx9erXrBqcMqKbFNLBbpD2HJCbnYLKyT4c+cqCRqZyYy89T46Pi7UL7G4y7lzmK+RmNyIKw2ZALb47LZexAgRrl50yOkFKvF1pZ60KUES+RlZ2YvqDfxzzfc0GSu9KUKwcg06gE8iU3lAVrY/obejXArr1FIkcMKcaP+1zpr52DMvQjJuwGIIL448o/dKAzBBRRZ+IJRd+fB0/6SESrbd1+4YAn4N6tVYKXj+qlkI0YCqPLOxigVV9WER8Swu7sXsEfjrT1McGKvoY1m1Jo/vZmDzPZvgyzFBjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9DsqdA70wZrnLnWbesV5+bW0ewiidehU0c/swTYRAk=;
 b=qbBYa1msmxOG9ocjlqfMFjNbxpryjGa/+iUoBGScI2iQMkzbHRXmqHNqmHcF/42xx0SqKXTfTcJ6b0zBZ8e4PCZBRzk8UCDb3zM1VwhqMThS0aK8WbUq9l2INY04O8Fg7OBli8FmNIZd90INTwnT7hXkfkfv68oNQlO5467f+bs=
Received: from DS7P220CA0086.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25a::12) by
 PH7PR12MB7841.namprd12.prod.outlook.com (2603:10b6:510:273::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 09:30:56 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:25a:cafe::11) by DS7P220CA0086.outlook.office365.com
 (2603:10b6:8:25a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Mon,
 22 Jun 2026 09:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 09:30:55 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 04:30:53 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: bounds check atom indirect io method
Date: Mon, 22 Jun 2026 15:00:37 +0530
Message-ID: <20260622093037.1311370-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|PH7PR12MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: f64bdbac-7511-4287-a4f4-08ded040f5f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: miJc5dbp7XFu4OYPbRxFZ31ZlqveGt/D4pAnADKlbUUK9VnF/OpribmLvucLeLQp7yGXcgrkTrm/EpTH6KErmougS8uTjALaRpABPkaviXUnS3qQmqesJW635flfYFXzjwsrpNYLfjr8KmME3lVYLxIkdYHBwLfnA1xylKWRL8YkSCnrNjlN5QJZrmw7Kjy1BklXAzyKyo1JG46TFXngzT5e1w9XvYy5AzC3GZ2vtfi/e58TKwyvmbrwq9RLd75x8aMzdraOEl4AW5/0txy9lEaC2jnZbnADdxnR4GgFk0ei6BrBUyVjSQNXXeKWodY5m3sUjJVtTT1rM5nrwIz0b8F6i9sSPLLOaR8JywXW7bDu2tOw94DxWblOqYJFMemZ/UulFCMJs9f2cadVYwGD3XyOnxprssHhQoSYO9myydg/sJsYzssthr3jOJeFCzmxJOyvaXfd3nEbU2HCT6AmCQEDJ237xpjUpqEejTRsxQBN+rcyoSey6dB+A67mfr2VDgE7x25XWPyaKlESG5yL4RwZ+vgJvoNtqIxWgSWMi9pilmghPBowpYBYKy6WYmHl92YFo44M7qFApEmTDONcSiNwIkKcXcbl8elk1Q6wBWScfbs6dqXEMKJ5Si+IsnVEqEoSo6fMRGxZ6UnH4wHVxOBtKvqU7/itYOS305f+AA244/x+gsFz4/7PtL8viHO7lHwWsiGqJpizX9dWnJxBug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t4yaQ4n9xoaZICxMlbAkAut/HfjvPabMbeOCaS3aCMe8JAgYZo+FXQIhPd+iNOeFITu9uejLu3IcRSEWr6UBrslcmsbf5PqFr4dZSi9yEZ+UDExaNS1yb9p9/c+EbUmsp1FQBSBY7FnLCFuFYl6ch4IQFvjtnYzt/9OY9L/pqvfjuWCC77tkrcVGzjGzjFwcrxWKfBnpR+hP/rpzNNWe6YD9l4zZuZstrX+9rlyKrthnfqtDNIWv26JfyMDKpNDma5LVLr+xU4QjdeA5jUhQlxp0Ow8L5xoGf86Mqfms+ennpnMmSbrOvlW97YHt3C5iiYAuM61wQnIFYezAJhG+LJrWmYk+PUgIxTdh24o14BPfzaXvHxtypf25iFt9/c/0VbJiIyiMcoPL+3TlIhFheRPJw96h1eFo9lhiOTVWouenY3Pz958FrFWxGTguN2SC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 09:30:55.5649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f64bdbac-7511-4287-a4f4-08ded040f5f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7841
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

Bound indirect io method execution by the BIOS size to avoid
out-of-bounds reads.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 0d5be1795972..d4a652d2b453 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -114,8 +114,10 @@ static uint32_t atom_iio_execute(struct atom_context *ctx, int base,
 				 uint32_t index, uint32_t data)
 {
 	uint32_t temp = 0xCDCDCDCD;
+	int start = base;
 
-	while (1)
+	/* IIO opcodes read up to base+3; keep within the BIOS image */
+	while (base + 3 < ctx->bios_size)
 		switch (CU8(base)) {
 		case ATOM_IIO_NOP:
 			base++;
@@ -180,6 +182,9 @@ static uint32_t atom_iio_execute(struct atom_context *ctx, int base,
 			pr_info("Unknown IIO opcode\n");
 			return 0;
 		}
+
+	pr_info("IIO method starting at offset %d runs past BIOS image\n", start);
+	return 0;
 }
 
 static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
-- 
2.49.0

