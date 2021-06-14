Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D691CC2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB06F611EE
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB06F611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5716B6E12C;
	Mon, 14 Jun 2021 17:47:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC7776E122
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bqz9+WbEt6VVMfDKWkVm2b03plcQgDGstiMOUA1DXxpOeVwKb8f1L6XfnK1kgpoC7O6R618ls9Pvrz1g3nxW0id2JyGMI21IGnf03IzMQXvX/mL6HVq/8X1y3hx/ZmEpHHCxAXO+sSDIoy9IiOoV9/ZLglAjf8DghiKXL+w0YPvRaX0BcQQF1fZUarbod5Qrzh3+wGfPnId7j9YTMstpEsuEzLL/2UfYgKSiqSGeWS2TMI7EnfeKaSBHDkq46YsxsMux2U1d4DnIxPIvnlbK9qCrL3NeVv/yQdyWyrNwUH8iAVSKAKw+F1nykNA8cxHUC/zv+8QyLLGmPx7VLSXBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viOrTLzaDzuEsGPjo5JWL1nH71S5qAuohpg8S9TDhjM=;
 b=YxWxsbNURM3toVLOwx0YqxcYcLy7bWrMrIuwaCrps0rXl+zjNxuUSzxv5XAHwdsi4QYZxhJIX4fRnvhyoGv0SmvYo+KfEOe7HJ8SVn68SFgaT7lM+WQ4xFigbL8TmIOWxdjjHduJqYz6pa3KZK57bZfVt25tvYmmxIczBcAjgtY6moXuhje+4DzEOpTs9ixb6M741/ADuL2mZm59rYkl/sAYCA5ZPHnljkM7hwZfETOVMUaKm1H4E3LlUvQb59ubfI7qGi20HbuNIEJNcZJv+i7GDKW2uTF9TS3gH5nH2mNDlxPd810Rpxv1JF4KK0GQhh/nI9hWStpPC13eSaQB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viOrTLzaDzuEsGPjo5JWL1nH71S5qAuohpg8S9TDhjM=;
 b=wNT1RAE0NLwWZ2D+mbUaEREIUx6fUymkdiI/7zOWmWPBiwtiSDQnDCFRWsj0cjz7squY+sf7gN3AYy0dvOjSpGIqDTqSvOmaJakWlfw7VJ97tIbN/+XKU2Bi6eOiXo0rQ0kjwTYXHG0WlzcwBe0ptITAZ8IQHRKD5OUneUPc2IQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:47:05 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:05 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/40] drm/amdgpu: I2C EEPROM full memory addressing
Date: Mon, 14 Jun 2021 13:46:13 -0400
Message-Id: <20210614174632.20818-22-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614174632.20818-1-luben.tuikov@amd.com>
References: <20210614174632.20818-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:47:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2551e69-1e64-40d7-a9a5-08d92f5c6c06
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4748D7084342731C984984EB99319@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8kaRvV3lHPcdpIn5Uq0GUV1NvuZPOgVlVFIfPvu7wxvtN+X2sPNSBOqMyZ40M6fA1i7UF0FAz26gVsPlcJoR52WRHp2cO4pOwpcomYaQyyX2mkBaQ1rNZGc1b4FwB+qLL8RLoQ5BvJDrHkTpISS2sC2PZiGapp7kNmZnWHVeaxaOfTsA5lWMNi3W9bvB8qNI0ReRbHVRIZUjeLlIifafJQ0RZQOSnlX+unkl5LRHqm5MAmePNmOXkzaeuht6Rnu9YqhoRoKsTNVVIcAx7OGNNsWdRfMS1YlInW6VftMQ/bTe1yMidZIScB2XSETkea5IVxpCPfW7reVRp0G63JKxK7nLXlL1Xsf+TQt5z/IN1J3RjCp7DNoZlGH6defKoYWdULWThJcHoBZPsL1Y/UcfPfoyszMpAEdMxrFFHQeKxeSKBqvK6bb9uoztC8dpozgwEGkWvj4QsTtWxStzmiubp4LVbztMFFaAGiXFHc8tgZ6YfNsbAcnoHwUyw88hlllkDHb/cFT8X57d/fWvo0ZNxzZ4VUNb+hiOC1budv7R7dtySkf6fxXd7lv9V+M8Dh0NJwna48jm8jlYDbRgczKjuNBw2jzySKWDAsG4t7A159m/yJ+TBStYmuNsui+uKbmqmVOWO720P3N9g/c7IzIDoMHtGGEkLJW4nU7QrECroHta3I5vjWCjM7s1vjokOV+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(1076003)(26005)(6512007)(16526019)(186003)(4326008)(6666004)(38100700002)(8676002)(54906003)(2616005)(956004)(2906002)(8936002)(66946007)(6916009)(38350700002)(478600001)(83380400001)(6506007)(5660300002)(52116002)(44832011)(86362001)(55236004)(6486002)(66476007)(66556008)(36756003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KaPVFSDfkGQshfJ2KF6DmZmxz5z6kOgo69tcrNRpKRPOrG20Fo9HHzpW4mr3?=
 =?us-ascii?Q?nB/ItPBCB9NvGTcVjGwJYU3Q6jKy7HSs/lTHBNyoA4A9VBH8sR5u6P0p3x9x?=
 =?us-ascii?Q?O77RRfAAdyDPBMJrFpfmsWmoeHsrtXig86NYjCyAbb1SadpL3wOacrTjeV3j?=
 =?us-ascii?Q?qmAfg+KR6tvGcIYNKF4HBtc/tA7ersz4EeHdFYlCXSLEAQh5SE5zA58x87Uf?=
 =?us-ascii?Q?YTlL2C0+LAMY/cElNlc5yhIPO3ZXEXBmt+JsP96gR42PWi85H5E6rSwkJd3s?=
 =?us-ascii?Q?qXF9CRk9zjOkYlxBPW3qaKHb0kUBKxJ1HJ01mP/7f7BcUl/7dVGcNMRv6XtJ?=
 =?us-ascii?Q?GQtZxX7P2R0rppBNRdOYf4GrEGC8/0hANV99Spntm0p94YZxYvAeWtrxrewm?=
 =?us-ascii?Q?8MBRZG82HwCRMZJbMf5UjLm+RKxV3QaQr25CF3ZA5Z/xsqJGgefWbWY/6n2f?=
 =?us-ascii?Q?fM+qPEkOpMPMVrl4RNoaKcH6VNwreWH35wea/qNQZQ7iNOcdSEIbKSnVNOVX?=
 =?us-ascii?Q?VrVH/EWwblVOGNASVxYy0EXYeozJfubAY79XM9v4Bb9Zdf2HIC5htxMdAWWQ?=
 =?us-ascii?Q?uPTZlSeFIUPZcdxy+Xl4b863eBn3C67BGgod1t8uFd14vFElam1hf1HHQOJd?=
 =?us-ascii?Q?IXGgw+2K0gWOHp+pYk8KiI+eP0kAADmv6t2pcHasxW3TqBBK8Cand296DQqw?=
 =?us-ascii?Q?mEeDcmJya750IFwLiofqXOagmAYZnWmYRy5ieTClN5iZiISYwQoB1guSKTf+?=
 =?us-ascii?Q?JKgv0hYf1p8Ub27ebuLIR2MRIGHhITj5RrhFvaPcrzrXJ6RzfWDJROH07JTR?=
 =?us-ascii?Q?/4AxfLKT4P9ftbpxjiRrgkMTlvUrQgTPZl9oUGGYdQtKHSQwod9gXp1aZ2qt?=
 =?us-ascii?Q?mExOXIFuqFhtwU1dmInNRuHBWggRonz86EgnTaAFBb2zpHjArmUWkM+jVAf9?=
 =?us-ascii?Q?h/q26SZpti3ZkCr+6EeOJ6B2/ov8GHW03rdrjlZcUwAuBsAGq33LJJRGMMKz?=
 =?us-ascii?Q?x7EgKZ3Tg/j4PhhRlg0/wGnOaiK/+rB/P+lGeXi/e8S0b17YNn7YE+G+b7R6?=
 =?us-ascii?Q?Kmex+IQPfpcpHWW63/oGWTj5sVWU6fhG5CD/0YYPtyOEx/aBDofkMsZrCG9X?=
 =?us-ascii?Q?BEgBL9dGgWzFoKCWtC/SZRbl0d2KygXQJWAisLv6GOT1QQz0OB7waZ4c39k/?=
 =?us-ascii?Q?OKXY1ylLZcYhhOLtIwi4XNxC1dlpnXB6FZSYX6K093mxfxdlXFkQu8bXh0I7?=
 =?us-ascii?Q?SyDfup6bJ48+DaaqYflqHsGZvQi6gvzFe5I9D/IUq1oOA+7mrhA5xnhB/eoA?=
 =?us-ascii?Q?BmHn2SDrrM2xA8xOL5+arj3x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2551e69-1e64-40d7-a9a5-08d92f5c6c06
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:04.6467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2RGV4kqZzogbedDOPTsLVvUmQAsRnVhYPVH+jwqwcefytqRXcE+h7wUf+EfLb6A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4748
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

* "eeprom_addr" is now 32-bit wide.
* Remove "slave_addr" from the I2C EEPROM driver
  interface. The I2C EEPROM Device Type Identifier
  is fixed at 1010b, and the rest of the bits
  of the Device Address Byte/Device Select Code,
  are memory address bits, where the first three
  of those bits are the hardware selection bits.
  All this is now a 19-bit address and passed
  as "eeprom_addr". This abstracts the I2C bus
  for EEPROM devices for this I2C EEPROM driver.
  Now clients only pass the 19-bit EEPROM memory
  address, to the I2C EEPROM driver, as the 32-bit
  "eeprom_addr", from which they want to read from
  or write to.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 88 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h |  4 +-
 2 files changed, 72 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index 94aeda1c7f8ca0..a5a87affedabf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -24,7 +24,7 @@
 #include "amdgpu_eeprom.h"
 #include "amdgpu.h"
 
-/* AT24CM02 has a 256-byte write page size.
+/* AT24CM02 and M24M02-R have a 256-byte write page size.
  */
 #define EEPROM_PAGE_BITS   8
 #define EEPROM_PAGE_SIZE   (1U << EEPROM_PAGE_BITS)
@@ -32,20 +32,72 @@
 
 #define EEPROM_OFFSET_SIZE 2
 
-static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
-				u16 slave_addr, u16 eeprom_addr,
+/* EEPROM memory addresses are 19-bits long, which can
+ * be partitioned into 3, 8, 8 bits, for a total of 19.
+ * The upper 3 bits are sent as part of the 7-bit
+ * "Device Type Identifier"--an I2C concept, which for EEPROM devices
+ * is hard-coded as 1010b, indicating that it is an EEPROM
+ * device--this is the wire format, followed by the upper
+ * 3 bits of the 19-bit address, followed by the direction,
+ * followed by two bytes holding the rest of the 16-bits of
+ * the EEPROM memory address. The format on the wire for EEPROM
+ * devices is: 1010XYZD, A15:A8, A7:A0,
+ * Where D is the direction and sequenced out by the hardware.
+ * Bits XYZ are memory address bits 18, 17 and 16.
+ * These bits are compared to how pins 1-3 of the part are connected,
+ * depending on the size of the part, more on that later.
+ *
+ * Note that of this wire format, a client is in control
+ * of, and needs to specify only XYZ, A15:A8, A7:0, bits,
+ * which is exactly the EEPROM memory address, or offset,
+ * in order to address up to 8 EEPROM devices on the I2C bus.
+ *
+ * For instance, a 2-Mbit I2C EEPROM part, addresses all its bytes,
+ * using an 18-bit address, bit 17 to 0 and thus would use all but one bit of
+ * the 19 bits previously mentioned. The designer would then not connect
+ * pins 1 and 2, and pin 3 usually named "A_2" or "E2", would be connected to
+ * either Vcc or GND. This would allow for up to two 2-Mbit parts on
+ * the same bus, where one would be addressable with bit 18 as 1, and
+ * the other with bit 18 of the address as 0.
+ *
+ * For a 2-Mbit part, bit 18 is usually known as the "Chip Enable" or
+ * "Hardware Address Bit". This bit is compared to the load on pin 3
+ * of the device, described above, and if there is a match, then this
+ * device responds to the command. This way, you can connect two
+ * 2-Mbit EEPROM devices on the same bus, but see one contiguous
+ * memory from 0 to 7FFFFh, where address 0 to 3FFFF is in the device
+ * whose pin 3 is connected to GND, and address 40000 to 7FFFFh is in
+ * the 2nd device, whose pin 3 is connected to Vcc.
+ *
+ * This addressing you encode in the 32-bit "eeprom_addr" below,
+ * namely the 19-bits "XYZ,A15:A0", as a single 19-bit address. For
+ * instance, eeprom_addr = 0x6DA01, is 110_1101_1010_0000_0001, where
+ * XYZ=110b, and A15:A0=DA01h. The XYZ bits become part of the device
+ * address, and the rest of the address bits are sent as the memory
+ * address bytes.
+ *
+ * That is, for an I2C EEPROM driver everything is controlled by
+ * the "eeprom_addr".
+ *
+ * P.S. If you need to write, lock and read the Identification Page,
+ * (M24M02-DR device only, which we do not use), change the "7" to
+ * "0xF" in the macro below, and let the client set bit 20 to 1 in
+ * "eeprom_addr", and set A10 to 0 to write into it, and A10 and A1 to
+ * 1 to lock it permanently.
+ */
+#define MAKE_I2C_ADDR(_aa) ((0xA << 3) | (((_aa) >> 16) & 7))
+
+static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
 				u8 *eeprom_buf, u16 buf_size, bool read)
 {
 	u8 eeprom_offset_buf[EEPROM_OFFSET_SIZE];
 	struct i2c_msg msgs[] = {
 		{
-			.addr = slave_addr,
 			.flags = 0,
 			.len = EEPROM_OFFSET_SIZE,
 			.buf = eeprom_offset_buf,
 		},
 		{
-			.addr = slave_addr,
 			.flags = read ? I2C_M_RD : 0,
 		},
 	};
@@ -58,6 +110,8 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
 	      buf_size -= len, eeprom_addr += len, eeprom_buf += len) {
 		/* Set the EEPROM address we want to write to/read from.
 		 */
+		msgs[0].addr = MAKE_I2C_ADDR(eeprom_addr);
+		msgs[1].addr = msgs[0].addr;
 		msgs[0].buf[0] = (eeprom_addr >> 8) & 0xff;
 		msgs[0].buf[1] = eeprom_addr & 0xff;
 
@@ -71,7 +125,7 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
 			 * over).
 			 *
 			 * As per the AT24CM02 EEPROM spec, after
-			 * writing into a page, the I2C driver MUST
+			 * writing into a page, the I2C driver should
 			 * terminate the transfer, i.e. in
 			 * "i2c_transfer()" below, with a STOP
 			 * condition, so that the self-timed write
@@ -91,17 +145,20 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
 		msgs[1].len = len;
 		msgs[1].buf = eeprom_buf;
 
+		/* This constitutes a START-STOP transaction.
+		 */
 		r = i2c_transfer(i2c_adap, msgs, ARRAY_SIZE(msgs));
 		if (r < ARRAY_SIZE(msgs))
 			break;
 
 		if (!read) {
-			/* According to the AT24CM02 EEPROM spec the
-			 * length of the self-writing cycle, tWR, is
-			 * 10 ms.
+			/* According to EEPROM specs the length of the
+			 * self-writing cycle, tWR (tW), is 10 ms.
 			 *
-			 * TODO Improve to wait for first ACK for slave address after
-			 * internal write cycle done.
+			 * TODO: Use polling on ACK, aka Acknowledge
+			 * Polling, to minimize waiting for the
+			 * internal write cycle to complete, as it is
+			 * usually smaller than tWR (tW).
 			 */
 			msleep(10);
 		}
@@ -113,7 +170,6 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
 /**
  * amdgpu_eeprom_xfer -- Read/write from/to an I2C EEPROM device
  * @i2c_adap: pointer to the I2C adapter to use
- * @slave_addr: I2C address of the slave device
  * @eeprom_addr: EEPROM address from which to read/write
  * @eeprom_buf: pointer to data buffer to read into/write from
  * @buf_size: the size of @eeprom_buf
@@ -121,8 +177,7 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
  *
  * Returns the number of bytes read/written; -errno on error.
  */
-int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
-		       u16 slave_addr, u16 eeprom_addr,
+int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
 		       u8 *eeprom_buf, u16 buf_size, bool read)
 {
 	const struct i2c_adapter_quirks *quirks = i2c_adap->quirks;
@@ -136,7 +191,7 @@ int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
 		limit = quirks->max_write_len;
 
 	if (limit == 0) {
-		return __amdgpu_eeprom_xfer(i2c_adap, slave_addr, eeprom_addr,
+		return __amdgpu_eeprom_xfer(i2c_adap, eeprom_addr,
 					    eeprom_buf, buf_size, read);
 	} else if (limit <= EEPROM_OFFSET_SIZE) {
 		dev_err_ratelimited(&i2c_adap->dev,
@@ -157,8 +212,7 @@ int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
 		      buf_size -= ps, eeprom_addr += ps, eeprom_buf += ps) {
 			ps = min(limit, buf_size);
 
-			r = __amdgpu_eeprom_xfer(i2c_adap,
-						 slave_addr, eeprom_addr,
+			r = __amdgpu_eeprom_xfer(i2c_adap, eeprom_addr,
 						 eeprom_buf, ps, read);
 			if (r < 0)
 				return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
index 9301e5678910ad..417472be2712e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
@@ -26,9 +26,7 @@
 
 #include <linux/i2c.h>
 
-int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
-		       u16 slave_addr, u16 eeprom_addr,
+int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
 		       u8 *eeprom_buf, u16 bytes, bool read);
 
-
 #endif
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
