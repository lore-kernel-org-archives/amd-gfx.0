Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C936DC47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ABD6610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABD6610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B2906EC4D;
	Tue,  8 Jun 2021 21:40:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A64646E595
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVz/E0U130ODe921MfRC6boQDQ8dNyAi8z3qhVw8YqJHFXs4HwKewIMgdxeRuZHiK2nb+RB8G4jMpYEm4em66IUUBzxCLDu7ksbODyZiLXvbLLWu40nqgjKZ9wScX/1vUVztSCeysqOl2Gz/qDOEDq6A7maJyC2dUc7uJi4MKFT9ckgVb49owfCF8TCKM38JaOTjRYes7l97ERwk2+Wz/kb655NnzHiiFfyTYskNOFcSXc/ucjakuuK41qlMjxvRyNRGeUav5EUaRhnyzWwFRXXbeCFZ5c+nSz0S0v3uaR/sLB+VKIVa8DiiqedZL0TPnvItisImGsCxcs0Uw3w7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjLzMTpwm0cG1SgYohdJt6m/ee3dY01+3ka0yRM1SiE=;
 b=UAqFVls6rmL7EH5QjoFa2NMAQFGLrxv3UCLQmFt95LylcS4VAs9Fy9NpD/GQM9a2nwaWPaCqW8/CUcK8Al+da6Co1n2NCLKd6DkH6mXyOvidXylDY6sCHByKQ20ZexuAH/XxrIaW0T/FOTcxWCUPczHW+bTbx8wFO0Wo0DwH7i7h/nuZcPd6uJ5J+THJT2W9bMPu4IyKY4S2pUMlErJ3RS1ukmHdED2U8KzKAJ/nM8Eufkq5hZ4U62+0n+EFc3oeGWVXFFPdms44YCeOlfeGOLs3Q2ueyjIYR+7eBcr0XSIrIesxzHv2Kr1K3s2uReI1+hl3FfRp2XF9mUbt6RlsVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjLzMTpwm0cG1SgYohdJt6m/ee3dY01+3ka0yRM1SiE=;
 b=fpxNkl3HhrDqvWf+qfEWFgXY/ciSwzYYBAMa+0NC26Q1UayRrTv3j7CqS8DH+7WT7b8+Koere/52GmWdmW3Htc+kHr7zMG4Q0M5Cy/RfbrrObpPox41/DVwDwUVZwB323kbEFgAH9eR6vckSHPvZZy84LKM91tvpM9qcTx54ecU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:28 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:28 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/40] drm/amdgpu: Fixes to the AMDGPU EEPROM driver
Date: Tue,  8 Jun 2021 17:39:33 -0400
Message-Id: <20210608213954.5517-20-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85de793f-af09-4bf5-43bd-08d92ac60858
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435DBCA1ACE2D950CE460E399379@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ejhSJTzhKTd066sEx0qz501wtdRZ8Q+jbZutmN4v6gN+eDy9RbhZiyXck1rZq7WPXXeJmVtTw+LaRWUovGVkJYu9vl1YaA1EU4opt2WsADcMNGUK410dblfFbnXuxbSyJlbNyQHka/FRL/rjuWA/dLpxE8Xn81X0CHIacLillElNQOdQU88g5Not3RNPN2LHhbI6oou0VRAUaNhabN/Ht+USNLCtwNuRp8slqz9IjfgLnRK/eRmct94+aYv9aJGvH/3GGGJVSKiV0yeJk0U+alnyYkE7ilih6j4oq8xvMjJtLTRyy1QkcUjLPm3Y/64gHlHVK7BjBsX7m8tc/K6/efHM2h6O3qAcx4a+rbBUQRy8bKEXNH2f78ltcVVq6VLhOkeoUE5Tbr+Q8WfJbMC6CMjhqHVhv4cVag6sN4kAGtj5oWr73R/Rzfr92F62v+VvzDnhMxYNLzPWh/lrOJNPMGgeDDoMeVgJaSaBNcP5zl+HxyUurb615QNQM7q2d74CA6/eExxJM6YVVS91NqCQAOYe77rFfTCAi2wb0oNlW6w81Iu32voAD16sqtru1Ht4OGgJQH+ojiLfUHOEL0kjMjlXKZWHlqdq31i4gSgDN7/HFMI0taweB9BHcN5rkSM/o4a3voXGL/UgK8E5bhjspgYWVLsE4zcA9tlcvnLC2mX43h++nuEL931JUbp/APuk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39850400004)(6916009)(8676002)(6506007)(6512007)(36756003)(6486002)(66476007)(38100700002)(38350700002)(26005)(6666004)(16526019)(1076003)(8936002)(2906002)(54906003)(316002)(4326008)(66946007)(186003)(5660300002)(66556008)(83380400001)(52116002)(2616005)(956004)(55236004)(44832011)(86362001)(478600001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zli9A0hJwGFaU6CTNE1mvJ4t4jQlw/Uw4DGj8ILNJuFVDz1+KE94woENzWYZ?=
 =?us-ascii?Q?8f4IM51OsJB7obxDFZf9MAWUeyMxeLsxKPaDR8KOOoWj0cxAU5o+brKqa26Y?=
 =?us-ascii?Q?hDcpt+xRwEH6eiM+lhsaeCnQfoYREbk+KDGVS81VgK8qeQeICrwLKjW7MntQ?=
 =?us-ascii?Q?Egj2HpCHU/n7BXYTWYbQNZ8/v/YNcdTLM+7j50y4QaXu1f0Yf39WN14ev7mp?=
 =?us-ascii?Q?AS8KICa3xRQbP7oDD3+5oOCWJSBPwdi8fvVUchwcZiNpnuvWBmGOCwvRek0U?=
 =?us-ascii?Q?gX3Pvp/PU6KSCBJo75KF02FEDTrPCp2yuOST1nhoflJ4RiClFXb51ebPv9OT?=
 =?us-ascii?Q?ZQD8Ksmddubmi4nEX+o3ByUYcJOkYQuxWxeiICNO8K+NDQTmKFTEt7MOW2J2?=
 =?us-ascii?Q?+N47NFV/RX/0IWV7zb9Yu5WFGnJfHm8fdKFLeRYGx++QdQUVmV5ce7GMwguQ?=
 =?us-ascii?Q?rOKtFt5xmZSvF07xEg8Z2tMyQhR75zk2cFhqMud8vkjoF46gON/jc6iaE6v9?=
 =?us-ascii?Q?Pyg7UajkDyAorZPV3g8X2QNPU0nGLVmrf7fHpjHnMzqSI1S2CNqNMuc9eu50?=
 =?us-ascii?Q?t7Jk9PURu8wGW5joQdnldnB2ed1iyoTzPzSk2uYTcBf97SfuwtKvF9Lac9im?=
 =?us-ascii?Q?QEusfq1658jhBrr0fCA4chHU0bUIg++Sn70mj7oz5+SbkkZYmP+XlZSpJn0n?=
 =?us-ascii?Q?63qQGxzzqwP5ntLGz2N9v2x10WK8CyyEHdF0+3oJEBRyEdZ2fkIe34UB3jCD?=
 =?us-ascii?Q?umhFfc7riIIpX5fSq1ToJYu9+p7/VkR5S1JiKHNS43IKK7QGRZ+2FAiAnmrq?=
 =?us-ascii?Q?LpHBztwxNGm1qbzwXFpyu9Aa7OFcE6PcjATyuyQn/OsKPlWddE1zN030FPXZ?=
 =?us-ascii?Q?k1hVGD2pepw3Fk/K+PBL86JuHQGF+5A0BUqppJOAKa+NENjIgfUi+Ohq+/rM?=
 =?us-ascii?Q?EorhGXUBw6om9r78rbI6oy3V7ihzHt+NDQTzRK3KWzCaLlUxqkcDUrdURZzh?=
 =?us-ascii?Q?6zSZhmLD9wXHES8Ak47wtHFOtKJs0L4yPSiftp/rnhJV7z7CJz/QaAcG/LwB?=
 =?us-ascii?Q?x+PkqZ3Bur2VR5DJ0CesVyaV+VLkDSkLPsRhwhkJH1xzPHzRXgrfy0pyzQ7E?=
 =?us-ascii?Q?JXUNCq1H7cJL5H98XZRAxuD0FBxKADBvTO2HkR1CxeGLlsKRo1NCztnF2Lms?=
 =?us-ascii?Q?8lHJZhenbRLdmgfyHkDj2TKOn24JQXN07OcFt145wtt533ZAwjTmUaJCV/jK?=
 =?us-ascii?Q?f9maNjnptGpEUzL41yWPgzdXc6ecmH0fXz+Re1CxlezWRRYq/KHzZjRVSfl6?=
 =?us-ascii?Q?ZEpbeyjr2jgammYY8w81PQUy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85de793f-af09-4bf5-43bd-08d92ac60858
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:28.3148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7kqGWRAFYjanWLA92DkJx+6GV4MsR4vrjEvkc++gxQqI3CTevpDRnrUb2bDneSC
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
