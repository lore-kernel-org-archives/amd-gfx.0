Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66465C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3902760FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3902760FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B1A26E23F;
	Mon, 21 Jun 2021 17:12:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08D1589FCE
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izm8zUle9GzSoQp1DWUNsC4KYyBtMgJjVHj4OOssckowowWLt60SjigSKZMFgkWjWkJrgGefNqj7oJEtNdYz7jmEXADHem/ICZrxCrE4A3YtXnWU97R918NTEPEegQ4NtwqBLxlHmEX19QWZ4uBUOqsAb2MxC4ID01pDZlHzVJhjmTkIZtBx8I5PtX8T6/zSqDEXUBICBgFpuG7cCkiVTBchHwbbvgQ2YRscNTEzUUpAX/zwRY8nP6SYUqy2IkeinsnFSaErbCSYhysygAoTiewLAI2Os9IpKqPfeCkfjIcinFKuX59zNTVzpfPrrtnNmtmoGLB3WBTt7CfvgIHygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4XwjAzYvhnKFhhtD1GlkOqQPmIL+KAMJpXFhNINRBI=;
 b=DaEWc0Tn4xW5nl9NugURy5xcvLHTv/JB0LzBlw00aI8V1vIKNSnxQ2Okjazl9jK5me2jFA6z8loQP9k7DTBkNC4Hv18C3zXMpAz9RPIvAkSuhtMiPhh5vMFvdXNn68RgFARJc3IY6Lj63WMDJ1vNSwtlAF3w0l3zV3Z5LAoC6cavhGJMeVYeQqyw08VkaY4YQmJfGwYov7im/uAihi2RMu2okFxmhLtB7zn1bbXhNIJRMIuZi/rJlU/wt9MDN+Mr79jyFw4+TSW3adyCB+so9IGaZRcCfjCz6oyzf+ldxaFgtpv2cfA/u3mawm/VZ7wGSX9b4cScUNEViYAPZJd0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4XwjAzYvhnKFhhtD1GlkOqQPmIL+KAMJpXFhNINRBI=;
 b=Cm8L3hYUI6KgQbE8aEBdUh63mV/3i3bveRgKyC3l+pPrB0YStupDxsEx+v0U2gUSDCyojFoaeGG/FwHwrGgjNtt6GGw0OdBHnijhXAEGsIKSCrAqQUPsFBdkF8YaJBoRoP0i6mUhXEDgqYY3hWXZIFigqVtEOwErvfmERTQqx5Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:12:50 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:50 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/43] drm/amdgpu: EEPROM respects I2C quirks
Date: Mon, 21 Jun 2021 13:11:58 -0400
Message-Id: <20210621171221.5720-21-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621171221.5720-1-luben.tuikov@amd.com>
References: <20210621171221.5720-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c36a97ea-10a1-471a-0d1a-08d934d7cca9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3865C11BEE670343A15410D5990A9@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kroqjMu7jpsrnWz3ejel3GnfKjgCYoq1yVLYpa5eqnvryfiw6a/eeaCbfRCmtp2etL6vCIEWETwEVI7nZVlg0/k1CMoEkSd+CyhtBqzYcHUqjwG2/LWnBwdgs6xBR0v5s2MO9TP9/JpCwGScHz0QHWjbJoE5FhpkRHu9S0o55Pqkhl02mPnxs54hgn6ObKNtOZILsqvkjwctQ1mMi2+U8AZooUecLuS83xS3zQnViFNJBeecTUZ3vMquiIYuanZAJxkLjGy2Kzlel2WxMe5YzBHXkLmPTKiZZMTry4LqyNeaXoZsnf8C85frMJnUXzTfT9faEl4bCXGb31Ky+3cXf9jS0mH1tm5y+t66WzFBqRIbNIjVubfuBNiuOTWoT2RtyEZe4y11TjTytZJAAc+fO3wimSStijTJK4sDU4U290Mllqre3zO85CZhY8jvhuuWUb4k2cVfivEToTT1ryuv2jThFWauWtW05p6UfwRchp92jsszvSVAL1DNeDLh22udQt/KmtQaAzsoTvF8XFTWcYYFP4fhxULp/PQszzAAiucmVzEm491DiBsCSITPA2/1aQOD68Ic+ITDaomcmbFROvaF9+KloNZ6DwCUrJhmjnnlviRsqdkgmATiomcrvCeHTAwxK2pk7HeTbGSaex+gBSM13Y2+euoZ9ZsCLtgWuGmurwJFS6KCWUjIaHu1pYP6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(478600001)(44832011)(54906003)(52116002)(316002)(66556008)(6916009)(66476007)(66946007)(8676002)(2906002)(5660300002)(956004)(26005)(6512007)(83380400001)(1076003)(8936002)(38100700002)(38350700002)(186003)(6486002)(2616005)(16526019)(55236004)(36756003)(86362001)(6506007)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xje1fG4I/OZigRJ3GTu/si2kzmkCcUJvjh1sovrz8CHYADMOehR4ITCFwsJ5?=
 =?us-ascii?Q?oyH5L+UUfPjvUClDlaTFEuGdHoIDjpwdLlUokt+nrBrhxPsMW9pn36Zyi03c?=
 =?us-ascii?Q?PyAuj/iMey7nLMoY5x7GXm+h7W1f2JHxKIOEoZV5EFn8DUB3u+cN3rifRJaP?=
 =?us-ascii?Q?f+VbZxEAzJ5WQod/2/IvnIPl3s7OX31/7zpZnzOBDY4zUNz0FgWL/1nDJDjX?=
 =?us-ascii?Q?8Bc1MB6iiItVHIljG0L183Uww4aKaqxm2XQLyKQu7RMeqQB0FQFJ6r84/d9n?=
 =?us-ascii?Q?UZENQ/tN1RuLzUlFIxibWWQILJWpwibt1X7g2xSBMVTaAg9W4+3OZ6Ei9j5U?=
 =?us-ascii?Q?lxJ8H22DEpgDi4Z9/5bnYqCbYGJMwse5XQQRw9fE3SN1pupcXl4/BEK7uDY0?=
 =?us-ascii?Q?9sZu4X1T1uIMQ57elbADHzNvHcxuDo7+ehhLHAXtSRSsaTJ0QZ+T0v4nsIFB?=
 =?us-ascii?Q?gjjbZdHwZ/LmINQevyM7LgdKRUdYhbbadQnJTY9DD6vvr6i7Dxs90D5yVPY2?=
 =?us-ascii?Q?KPleLAAhV+MrZOrgDPH1ig4rJ5VCc9CNlMeARaUbugPxxiAYq9GZbGaMccL1?=
 =?us-ascii?Q?nKnFIR2eb/RsWn8Mb0GpguOeYIaLyUYsegS8AtEO7WKTCw/thRXH9gOMBEMT?=
 =?us-ascii?Q?ESb3hnzDa+5BXX2mEqTq5sacwUDFFBLLPiz05CB6gOE+Q6bzZR1vYrnYFgnl?=
 =?us-ascii?Q?Oh+/a7/OMXIVnOIM6Oo1KAQz9H6KSi21+tzbD3tFo43zYwR+1isx1geg+FcT?=
 =?us-ascii?Q?Yw+sI0sibNNGltTv1EBecC/FS5TiOKtTZ3nY3hJdJMRRmVxM7/SfOQviQ39N?=
 =?us-ascii?Q?nLS2TtrSgfVLfk9J1ZIQ4ItWb7T7fgNHjVd4fm/mb8o3ShcpBbzinyOFd3/T?=
 =?us-ascii?Q?o3gkgbVkJKfD/iEXXQtQyxmFKm4Dih8Tg3MJHiOxFBZOUDJ0U9d/tY+gjjOK?=
 =?us-ascii?Q?LD/wQS9Cz6pD0UFAGZYQOqBNMHVWl8u4lm/2bViFasTCsZQwBBCpjx0Guy2f?=
 =?us-ascii?Q?qVqSMKODBpaas7ChP31sg+VcqKrJ9BIkkIy6Zvd7rQVAOdE6m635/p5V4Q3D?=
 =?us-ascii?Q?Oq1JEU0q02keVKSoxa1khn4w7vRgjk33BsuIRUdkUki5U/HHviyqLUbKdLR4?=
 =?us-ascii?Q?LTUMYvPHs++FJivKsmtG4TqAqNEA1RE4hH4OgKCjSRPB5so6CWI7uJ+51CXk?=
 =?us-ascii?Q?G/ssW25ektfeJmxY2RvnbwbWWzqtdD7blUPD9obVLg55XLlL2H+rKFJ5SzIe?=
 =?us-ascii?Q?0O+NeSpP0qrwa16mqnzuHhXfy/jgPOId2I9wKyDTZy+pbNCcHir7N6kQYCdA?=
 =?us-ascii?Q?k7xoPwSPsBIj3VO/kM95p33A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36a97ea-10a1-471a-0d1a-08d934d7cca9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:50.6959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psSvOlV50SH69bYdjt5YRqNI0aB+k0ZhwnPk/O0DKBfa+yrT8wVbfzLcWhDSGXYw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3865
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Consult the i2c_adapter.quirks table for
the maximum read/write data length per bus
transaction. Do not exceed this transaction
limit.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 80 +++++++++++++++++-----
 1 file changed, 64 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index 7fdb5bd2fc8bc8..94aeda1c7f8ca0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -32,20 +32,9 @@
 
 #define EEPROM_OFFSET_SIZE 2
 
-/**
- * amdgpu_eeprom_xfer -- Read/write from/to an I2C EEPROM device
- * @i2c_adap: pointer to the I2C adapter to use
- * @slave_addr: I2C address of the slave device
- * @eeprom_addr: EEPROM address from which to read/write
- * @eeprom_buf: pointer to data buffer to read into/write from
- * @buf_size: the size of @eeprom_buf
- * @read: True if reading from the EEPROM, false if writing
- *
- * Returns the number of bytes read/written; -errno on error.
- */
-int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
-		       u16 slave_addr, u16 eeprom_addr,
-		       u8 *eeprom_buf, u16 buf_size, bool read)
+static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
+				u16 slave_addr, u16 eeprom_addr,
+				u8 *eeprom_buf, u16 buf_size, bool read)
 {
 	u8 eeprom_offset_buf[EEPROM_OFFSET_SIZE];
 	struct i2c_msg msgs[] = {
@@ -65,8 +54,8 @@ int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
 	u16 len;
 
 	r = 0;
-	for (len = 0; buf_size > 0;
-	     buf_size -= len, eeprom_addr += len, eeprom_buf += len) {
+	for ( ; buf_size > 0;
+	      buf_size -= len, eeprom_addr += len, eeprom_buf += len) {
 		/* Set the EEPROM address we want to write to/read from.
 		 */
 		msgs[0].buf[0] = (eeprom_addr >> 8) & 0xff;
@@ -120,3 +109,62 @@ int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
 
 	return r < 0 ? r : eeprom_buf - p;
 }
+
+/**
+ * amdgpu_eeprom_xfer -- Read/write from/to an I2C EEPROM device
+ * @i2c_adap: pointer to the I2C adapter to use
+ * @slave_addr: I2C address of the slave device
+ * @eeprom_addr: EEPROM address from which to read/write
+ * @eeprom_buf: pointer to data buffer to read into/write from
+ * @buf_size: the size of @eeprom_buf
+ * @read: True if reading from the EEPROM, false if writing
+ *
+ * Returns the number of bytes read/written; -errno on error.
+ */
+int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
+		       u16 slave_addr, u16 eeprom_addr,
+		       u8 *eeprom_buf, u16 buf_size, bool read)
+{
+	const struct i2c_adapter_quirks *quirks = i2c_adap->quirks;
+	u16 limit;
+
+	if (!quirks)
+		limit = 0;
+	else if (read)
+		limit = quirks->max_read_len;
+	else
+		limit = quirks->max_write_len;
+
+	if (limit == 0) {
+		return __amdgpu_eeprom_xfer(i2c_adap, slave_addr, eeprom_addr,
+					    eeprom_buf, buf_size, read);
+	} else if (limit <= EEPROM_OFFSET_SIZE) {
+		dev_err_ratelimited(&i2c_adap->dev,
+				    "maddr:0x%04X size:0x%02X:quirk max_%s_len must be > %d",
+				    eeprom_addr, buf_size,
+				    read ? "read" : "write", EEPROM_OFFSET_SIZE);
+		return -EINVAL;
+	} else {
+		u16 ps; /* Partial size */
+		int res = 0, r;
+
+		/* The "limit" includes all data bytes sent/received,
+		 * which would include the EEPROM_OFFSET_SIZE bytes.
+		 * Account for them here.
+		 */
+		limit -= EEPROM_OFFSET_SIZE;
+		for ( ; buf_size > 0;
+		      buf_size -= ps, eeprom_addr += ps, eeprom_buf += ps) {
+			ps = min(limit, buf_size);
+
+			r = __amdgpu_eeprom_xfer(i2c_adap,
+						 slave_addr, eeprom_addr,
+						 eeprom_buf, ps, read);
+			if (r < 0)
+				return r;
+			res += r;
+		}
+
+		return res;
+	}
+}
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
