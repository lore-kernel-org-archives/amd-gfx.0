Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CC0C48BD1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD09610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD09610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 717DB6EC4B;
	Tue,  8 Jun 2021 21:40:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C61616EC36
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIqdHkT3cLOu8+wqdksu2M2jQ68qrIfVYR3N+oplUZwYKPdsvcxKX4YCKqQ+cCdeFhz11gIDBCRHgcnT1w7NrctlgrW0c+FnbYc45CFpBk0Syjh9g3670TtUnU9YHlcG5J7S861MEnJKNI1y/4mQPBdXZorQlouIztlPGmhgOw0h7Rw/euQ2XfCqJt7kEhQC8y2htZ9vpOQo8x8RcsmIn1cDlKHdcK8afKNhZWBHJXxzMLWK3SGnazX7HeVGUg00xhF1LV2J3YwB+qYlBmMrjgC6FaFjUw1TAJ+bo443cUAjJ9UwxYiHS/Pnrh9INUv7uSh2sbaeD3jdPVkvoDleGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flvg+CsscdxJIX+2kgoFPtu0wFCFyS5qzB81Zvug1Sw=;
 b=EZThq73Qb1Hgvz/QTjL7wIhVicNJ/YyNYsHaqEicOuCJBnEXRoBvFlVpaHIUm9P4AFWSGSur9bBA9cLBKNiwUEEXmI5JnqvG5pfDGzqqLQzPHrmOMqpj3T5n9vRFkdEfMeNqF9cQ0qJTeeUaNtZOTi8cGGFB6Qk+HfhtknB5rNhhF/uB7jAD7A1uCbQHUcyzrTmGFX5K5HX31AMCWjzmwzxI8WaV8ijyFIy+BXqHf1oSf9lmKUAzvvDEasbCY9jnqI3r9utk73TWhmuH8BEJeDY+BrKdyuZM7bhHGYPDYYweDdG4vLAuyqHwMNjrrxc3qnCjTaPd1zDSw/i4LVmtaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flvg+CsscdxJIX+2kgoFPtu0wFCFyS5qzB81Zvug1Sw=;
 b=lMLrSQL2y30uBSmZqHG3t8bJHRg4KJsJgQgT82G8W4Fua7AWgdBYxLsTnfAjKAIOEZPFhEJe8egHAOj0Z0WlD1ZFbk8PtyLlkbgVjitz6HUm4FWi+vs5pxHEGM/6VSKM58YRRbi4K3bBdojBtoO07E50YOaek4ZPp5ZzbfXNF2I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:29 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:29 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/40] drm/amdgpu: EEPROM respects I2C quirks
Date: Tue,  8 Jun 2021 17:39:34 -0400
Message-Id: <20210608213954.5517-21-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608213954.5517-1-luben.tuikov@amd.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd2e5c96-7fbc-4ec6-519c-08d92ac608de
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435FB784B66DC05F459D94799379@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VUMa5IvOSAXF1IWtoBqEZtB4dfy9I5UO1SpPdyMu28v9VCjig5mHBAsmA5wB/eWb9tuZcqHhNmxi/znVX97WnPCXbQSQ371aU1KNo50s9Rcu5nRtl/G+fJkbwjqNhwb8JKORY0lg48NO1IpV0gk5K3T8m8To4jeXP9p2FUYox89IqPp6krqm4Tn8+kWgtJewjm1SrWCb8fAcgtiIfpNgMzdZ1owiJPqUd15B7F4Osy7GyCJJeduEr7MLOGDZM9kvcjovyLDqph8BqJYsWIWCDqmWLaKnV/7oj13RKdt+N5sfzV0H3DzeMKxj+U/N8J2ylnIId4BW5srMPplsf+gUkmoOCBatYER4k4V2KK+WCoXqWOu0RH+Ay/8Lpwzhowummh9aRUV4ovhwMu3MMYbJ4t+oN4T8vNaQ70yZzTcyWnucwsx3+9Npy/M4s+C3JCed0ARUhQ3VgxuvNY3z6P3aF+meYHGgZWnz+F3697ZyiM2qmiwsRGgcYEXHoJrltyyz4XBQOhGTLkI1+FyL2HQQP1dw2WoGAxDfddwvwjj6RAKhOXIMPamMyVz2dc3kCwmzh0WzI1mnxdWU0QLVOB6Q9ShdSRxXXAb/Lsn6Gafz6k+Cm4tfR6KID3o9OUcYW18PFg1sc1Xync3EC0hxKVmau3XmJpd+1feUa2dBfXNgsljOZfdJZ3inXutkNYrY4Q3r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39850400004)(6916009)(8676002)(6506007)(6512007)(36756003)(6486002)(66476007)(38100700002)(38350700002)(26005)(6666004)(16526019)(1076003)(8936002)(2906002)(54906003)(316002)(4326008)(66946007)(186003)(5660300002)(66556008)(83380400001)(52116002)(2616005)(956004)(55236004)(44832011)(86362001)(478600001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6qnResFICIPXt3gmBpg8o18dP8vpNMaWrDgtK2JaYiCmVFr9BmNOyv6+v42z?=
 =?us-ascii?Q?99OM5kfFEpS/eWbM8KMlmo4kEIGKJMlhmFWYE4PlHgtDX9vSZpi4BVXn0jk+?=
 =?us-ascii?Q?MBCTJCkbT5rBGa3RPcD7mOd8BG/CM3krENC5nDbVBZkoaFMAWhlYS5dlDvuf?=
 =?us-ascii?Q?lgWTZb51VdH9WTBQ6w8NX8ztVUwA2AxDEu95KxFNi2a5VPxcFTYBTRxdHgZH?=
 =?us-ascii?Q?Ymt2+PnmisFSc1nNGrfOTR0XizvBJT9qRlTddPwL/INyZPkHBAGDsF37qX71?=
 =?us-ascii?Q?+n/xQ8JgEYonPLGnTap+Nk2Vn5pcfywkjnMW56f6c12U9o2iLIJLzN1YFjoL?=
 =?us-ascii?Q?BNoR0u6MMRRrqG4b3qQDxfHO4NuwLsfJ9uXcKPkgF9mZfi1NiOoI5om+FpG/?=
 =?us-ascii?Q?bMD8deeDJ4a2ZOvad8DUrvZEjDzT6cHIguYKFnSiJ5uJ4DwF1NS6vcmGS/Jr?=
 =?us-ascii?Q?niI6AgKeHcygYwwauMpbZn1+/i/HpNG34j1CSWMr0wSimHf1Sv3Epya5e5Fj?=
 =?us-ascii?Q?i/xaNfTAzlP1AjAw2QkghUm0BLEVbp0qONk5NG6Q+fGtfc8Fc6Qhlu5CGR+n?=
 =?us-ascii?Q?9+V4oNtfjj4tVIEBDR9JVhwWBEWkTJPPuZHanMdzjTPa/sItZkX26auQemNk?=
 =?us-ascii?Q?qRK+3IoIa1PaDUB4ZQjOkKJHo3uRL2+eNx2veWFq6IUxgj3OLnuA2cjpg4dX?=
 =?us-ascii?Q?3JDfru2q8Lto+aFms6Hb8ZUrc+rjXr7CJQv03U+A4IgnY3slUQ/ZNf6Bbpvi?=
 =?us-ascii?Q?WSniC2n5wIJGVmx1tU9OwtLOnjv57G4EcLaGGI5bdCpR2yCMcl9WrA5eQWWz?=
 =?us-ascii?Q?PllZbWDNolZwKImYAG3np+jzMm0YZ5FiMv4iuaL21lXEfAQ2nEGVbJ/1bbPm?=
 =?us-ascii?Q?f0qG52AWYmC+X3J7SWbLYcY8jjwdq4zvteil0x6QMG5Zhi87z7j4564WSv8b?=
 =?us-ascii?Q?Us86CIjB/cNAsrgYfkhX8CStTuRd1K6LO2TD1/QmmKT+QJqebiIn4U5Byaii?=
 =?us-ascii?Q?ONJ2Tzj8gzhhwqmrNnEaq8d9qUdfY+8UGejrIQwosHi7M5JRKWM6qeH88bOs?=
 =?us-ascii?Q?y+QpbPZLIySbkFcFvKaVOuzbts6Un0ZnoRa5JpbJv95eMw70Q/NDHOYNg5iS?=
 =?us-ascii?Q?+snMlfCWeqttt/VyYC2QzIqmYgHM2AWWtN22Fo4P5WEienHjdOuNj6H7W6zA?=
 =?us-ascii?Q?bUhZWL9J/wnz2CMtdVb94oD7TZLdqkoAbPJ6rWlr7GDXU0r8koDRHxa2V2rf?=
 =?us-ascii?Q?u1nJc1KxIM+sGP8Epkq0Ib0BuxUTuKIfnfiZow4vAEIAdGlj5ydHzNvsnO6N?=
 =?us-ascii?Q?J6TZytvyUxaHu37nw9g4OjNo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2e5c96-7fbc-4ec6-519c-08d92ac608de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:29.1644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUzoCAqiSoeyQ/a2+gj9WTY7Dv1zUno0m+KUxv3g65UzNkttM7CXV8HSQ8CKgqcg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
