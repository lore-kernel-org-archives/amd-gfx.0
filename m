Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261EAC49EA6
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE65260FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE65260FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C13B96E25A;
	Mon, 21 Jun 2021 17:12:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CAF989FCE
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXo10SszEV0j72W3C7w16D9jCwfY/8RFHnFQgGwxLlTmtRokYCtX0XcLkYh01WFvlZr7t/cMM08TFqxWzzR2NlxKnPq75gi6mkrE1Z5YDZcT1Rd5mp6h5UxhQS9IJy+/1R2LvBzKZV1gpn5Ahm12NVm1q0QRa4ehgyy1DFNERbS7cMX6BIzVpAaLjVP2LD2JU+ifDXyh/D3ct3yI9kIEukDcQnDzYtSc9AfF+IYqGNZ0JBitVnE1PuNd3ay2aXdRe6wONLzAuLSS23DmK+Ow4sTVSscF+EyvyunMQCEQII1IXjgrnyzrT07q6zB2KhjZINVNHFbEwLikCM95CebrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Clk2kT7v3e5+PcwMsmsHbWUMkd9Zj+G0jmLcYv/JcGY=;
 b=Ya2LI01P5UReBlUor6DblSTD9t6GfPXVzwP8soIxzmHD7Z7KNRtyXJNLRmbWM3xLC6QfE1HDgRmi+Kdp0Pk9u34I0JXC5qM5A99kTDFF+ZaeBtJESa58Qwby1qCx/EW0EI8XoxMXodxBsbEdm1AmRCzZBSkKCD4KfHWOM0DaMpKAuwxxGIVmAaUm+VlpnJ9kz03yIZcgEf0b6MTWXNv5wkyG5VCCZzbl+tmJqsgcrNFfObXPXzdKGd3Tt8/5C4tSa0DkIYpXATSZCzW8QspRxf0wbf1uKj7sm+3shapv8iO2cl0A8osfsINSuX3O7W1buW3r28WvJsICUEQc5MXy4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Clk2kT7v3e5+PcwMsmsHbWUMkd9Zj+G0jmLcYv/JcGY=;
 b=qfnxfKHlAoOuIFB3drZIGYNmE7bPob8c+gslCmWechv6iDMhoK+HzIXO24MXRJprhj0cO4hSpGHpEvBZdO9I6hMN9RN9imjgubOf8gvt8zFnNWlGH3DyIxjtpCDMDVDNN1sgdVs4pr2XPN3+lv/Hx/deREtlZ+VZ9ffRdJ8zE5Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:12:49 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:49 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/43] drm/amdgpu: Fixes to the AMDGPU EEPROM driver
Date: Mon, 21 Jun 2021 13:11:57 -0400
Message-Id: <20210621171221.5720-20-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3054264-b14b-44f2-c85f-08d934d7cc21
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3865DEC965B3BC54060FF048990A9@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v2gILsoXzqzEF3IzLvJfAogsbUPSjFJ2bUnSXzvc/OsyktaYszCLbndxSJstuDhV7gPaND3CTVGe151EU57F7UbYilLACSZfG8zJrVSzNKHUWrqcETakbC74Uv8aLE8Ez1E7m6hHeg5h7tI+JH0fbIBU2PoGR3ceImNorm8I2ACJjWItQFBTTAufaP5YA2yLBkzmDZj4YYTT5GH23KtIbOOjA3h3ENjPVwT7AC4iVJ1MQuqTCaJhbnV6WduVlqwZRh5VMwW942C57P8eCmRskISS/RvC5cdwpkx0J3G/Bh65ZWVsZAUQjdQnTQix0VXqMLl3r5c8+DA1jSF3aUKbXt0/8XEslugLGySzAv/QscT7WSB7eF4sm6VMzZdwrrMeo2JZxrts+9LrtcxrjxrNpo358HrWZxoUyjtv36IjrfFX22ar6d8SlPoeDr7AaiLZ74tc/FswRoIm8Gp1dgXjSLCj3UZ2xYk4PcmoHEHdO2uIXeJph/AtM2ogeeTX7wSEinjGldwZMHrbtztM8gYMD+npPziQbk9yTX7KdBO62Q+aSJq1xX66yy9LKg6XPgmm5t0iaMb0o4RtIBGmrUVHbjcDVRhtvOqXOhCr7wmbESU1JtlOaWI0uAuDfRIz5/KTavSH2eOc56o1a7AlN+RticH1yuHKnNvMJ+pBPs17+SM0SjeUzlCBwQz8HKzzQMRX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(478600001)(44832011)(54906003)(52116002)(316002)(66556008)(6916009)(66476007)(66946007)(8676002)(2906002)(5660300002)(956004)(26005)(6512007)(6666004)(83380400001)(1076003)(8936002)(38100700002)(38350700002)(186003)(6486002)(2616005)(16526019)(55236004)(36756003)(86362001)(6506007)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pnAvOF/8WJLcH5wbSM/xnNhQn0XNPsrkeVfz7OE1YhNLRrPjPbvzPrvmEhk7?=
 =?us-ascii?Q?I+TBprEvpWyXxAR/YUoLuAhNV5iQkUtDT3PwD6T0hRhlNAKyuXRnJdMxff9R?=
 =?us-ascii?Q?TF+vvzlFtIxUfZSF/gZYodoJBzdZZFFbsDiI/rDXG9d9KFOYKgz3dEc+ncYT?=
 =?us-ascii?Q?XDNtmDojLp1nmBBV0mzNHucUqHukWVmkZCJni8i537EZaLZFEnftCdUrfcUy?=
 =?us-ascii?Q?gp1spH2inGS0Bhk5CAKy7vv8nVNvgvM+GmOH9PVtL3Vsb7XIsL6m5P1Yo4s4?=
 =?us-ascii?Q?HDZtGIGLHeTxbZSs75OdeA0i6cm4VvckSXXPQ5TGuRdGCRB8Lv87jolTzPfp?=
 =?us-ascii?Q?rP/G8ogWkm9MNqsVeArf0qgs0IBDzBoHXhg0uanDt/kEKmICdMxfSKV8K6Jm?=
 =?us-ascii?Q?dDRT+NVMmibhiPrixwu0sPSTj2LOWKFlJYSpXsTM6CYsWY8FLsWsOHSCBRDv?=
 =?us-ascii?Q?yBwo0szBn0h7+TzMBLK0/W/zSFuuExiFoRnyKX7Fq2drfIFfY/5V5DIjRBIa?=
 =?us-ascii?Q?2/jCOB9EabmhjGR8iJwMs6zh9LS/4PGFH2666xUKoSgXW1BJwMdOUYsAwAOL?=
 =?us-ascii?Q?P6jna8jbmAxgXzRsSyT4m3p+IUApRNme/Eej147J2/uWqf0q7koYNZxP1DFC?=
 =?us-ascii?Q?lSpSDneUBoVVEsCH6FtA6me/92gaMpI87I6ftuh7iyaU68e//kx0uLkjSMCe?=
 =?us-ascii?Q?JV7+YD6brnq+6KIf91w8PtzWbuBWiKotoClNbb8cyKG6KOAyXUvRmS+AMI95?=
 =?us-ascii?Q?ILssWUvqwpH3C2uV3H6wRamRFKSWJBudHLr2TZp0OHcGCjuW3vXKZnHMuXcw?=
 =?us-ascii?Q?gP+zauAcN/ITrwYMy1IShVi9c8e4Wwb9lQFl+5s2Y7asvXnewAD8SwDegwbo?=
 =?us-ascii?Q?TR4gsd027gp0PXB4JwooDGAT/wFTC+uZ4iGz5oLkYJXxyiouM5zJ0wsPJG5/?=
 =?us-ascii?Q?SAfcsWBoEKcfU/+UEZ1YfwKItPsan4qEjpSjO8niNsxf7v2d21zEbwXHh9t9?=
 =?us-ascii?Q?Y/ujlkMZZPdaiwPdNuMmr7UeK3cEihZtHLdSdDTj05ciiFHLT84DbHn75jYw?=
 =?us-ascii?Q?48P/NKt+CJKUlPTZWlLuovlbiSoAssSRlUpgjLM8fDKhaZ0eoL3L9Uz0sTUE?=
 =?us-ascii?Q?ImZQTK1kMLXa3gfMVgvYRVrEsgpUkGUUXv+EXBIhxTFMbkJc6aE9N4oosCiY?=
 =?us-ascii?Q?1PpBAoerPdwA8uz13iUIenVSbvCfrHDDnFT7Ti3lOw7DdyVS2UYP3v4sBnfC?=
 =?us-ascii?Q?u2sSr7pfwawbTHifWlnB6+udPYNCsZhnB4uMUh5AxT/Hk2s/QnnixmI5h2yh?=
 =?us-ascii?Q?Gulxh7/cQXYUWHiEbqEDXEJH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3054264-b14b-44f2-c85f-08d934d7cc21
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:49.8424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTA8/aL2jdiaQdJqn5+mb+gKitJBlt4iH/YWwe5qOetF8ZzXdzJxWDQLbVGZBg9v
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

* When reading from the EEPROM device, there is no
  device limitation on the number of bytes
  read--they're simply sequenced out. Thus, read
  the whole data requested in one go.

* When writing to the EEPROM device, there is a
  256-byte page limit to write to before having to
  generate a STOP on the bus, as well as the
  address written to mustn't cross over the page
  boundary (it actually rolls over). Maximize the
  data written to per bus acquisition.

* Return the number of bytes read/written, or -errno.

* Add kernel doc.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 96 +++++++++++++++-------
 1 file changed, 68 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index d02ea083a6c69b..7fdb5bd2fc8bc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -24,59 +24,99 @@
 #include "amdgpu_eeprom.h"
 #include "amdgpu.h"
 
-#define EEPROM_OFFSET_LENGTH 2
+/* AT24CM02 has a 256-byte write page size.
+ */
+#define EEPROM_PAGE_BITS   8
+#define EEPROM_PAGE_SIZE   (1U << EEPROM_PAGE_BITS)
+#define EEPROM_PAGE_MASK   (EEPROM_PAGE_SIZE - 1)
+
+#define EEPROM_OFFSET_SIZE 2
 
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
 int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
 		       u16 slave_addr, u16 eeprom_addr,
-		       u8 *eeprom_buf, u16 bytes, bool read)
+		       u8 *eeprom_buf, u16 buf_size, bool read)
 {
-	u8 eeprom_offset_buf[2];
-	u16 bytes_transferred;
+	u8 eeprom_offset_buf[EEPROM_OFFSET_SIZE];
 	struct i2c_msg msgs[] = {
 		{
 			.addr = slave_addr,
 			.flags = 0,
-			.len = EEPROM_OFFSET_LENGTH,
+			.len = EEPROM_OFFSET_SIZE,
 			.buf = eeprom_offset_buf,
 		},
 		{
 			.addr = slave_addr,
 			.flags = read ? I2C_M_RD : 0,
-			.len = bytes,
-			.buf = eeprom_buf,
 		},
 	};
+	const u8 *p = eeprom_buf;
 	int r;
+	u16 len;
+
+	r = 0;
+	for (len = 0; buf_size > 0;
+	     buf_size -= len, eeprom_addr += len, eeprom_buf += len) {
+		/* Set the EEPROM address we want to write to/read from.
+		 */
+		msgs[0].buf[0] = (eeprom_addr >> 8) & 0xff;
+		msgs[0].buf[1] = eeprom_addr & 0xff;
 
-	msgs[0].buf[0] = ((eeprom_addr >> 8) & 0xff);
-	msgs[0].buf[1] = (eeprom_addr & 0xff);
+		if (!read) {
+			/* Write the maximum amount of data, without
+			 * crossing the device's page boundary, as per
+			 * its spec. Partial page writes are allowed,
+			 * starting at any location within the page,
+			 * so long as the page boundary isn't crossed
+			 * over (actually the page pointer rolls
+			 * over).
+			 *
+			 * As per the AT24CM02 EEPROM spec, after
+			 * writing into a page, the I2C driver MUST
+			 * terminate the transfer, i.e. in
+			 * "i2c_transfer()" below, with a STOP
+			 * condition, so that the self-timed write
+			 * cycle begins. This is implied for the
+			 * "i2c_transfer()" abstraction.
+			 */
+			len = min(EEPROM_PAGE_SIZE - (eeprom_addr &
+						      EEPROM_PAGE_MASK),
+				  (u32)buf_size);
+		} else {
+			/* Reading from the EEPROM has no limitation
+			 * on the number of bytes read from the EEPROM
+			 * device--they are simply sequenced out.
+			 */
+			len = buf_size;
+		}
+		msgs[1].len = len;
+		msgs[1].buf = eeprom_buf;
 
-	while (msgs[1].len) {
 		r = i2c_transfer(i2c_adap, msgs, ARRAY_SIZE(msgs));
-		if (r <= 0)
-			return r;
+		if (r < ARRAY_SIZE(msgs))
+			break;
 
-		/* Only for write data */
-		if (!msgs[1].flags)
-			/*
-			 * According to EEPROM spec there is a MAX of 10 ms required for
-			 * EEPROM to flush internal RX buffer after STOP was issued at the
-			 * end of write transaction. During this time the EEPROM will not be
-			 * responsive to any more commands - so wait a bit more.
+		if (!read) {
+			/* According to the AT24CM02 EEPROM spec the
+			 * length of the self-writing cycle, tWR, is
+			 * 10 ms.
 			 *
 			 * TODO Improve to wait for first ACK for slave address after
 			 * internal write cycle done.
 			 */
 			msleep(10);
-
-
-		bytes_transferred = r - EEPROM_OFFSET_LENGTH;
-		eeprom_addr += bytes_transferred;
-		msgs[0].buf[0] = ((eeprom_addr >> 8) & 0xff);
-		msgs[0].buf[1] = (eeprom_addr & 0xff);
-		msgs[1].buf += bytes_transferred;
-		msgs[1].len -= bytes_transferred;
+		}
 	}
 
-	return 0;
+	return r < 0 ? r : eeprom_buf - p;
 }
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
