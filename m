Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5654FC4743D
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2820F610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2820F610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57E606EC4E;
	Tue,  8 Jun 2021 21:40:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 256636EC49
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWqX6M2RHGVdJO6IY67UNFhisqY/Yh7BmYA6rXdWTdRzW+ZS3o8cIa+bLBS93ncmjCLRy8M4e7fgD70t+xOwemRmCTi2aY2h1Ynq+IqsxrHsXvaay/CMF4y8qxzSmY2fKqvkmdluSARR1+IR2g4MrwzvbQ5LTExL6qIu2LVACElfH3D936ISq3wsK8tOWmFqeSc/5bbnHCs2zZpj8IVdcYdXSejpPDuY1y3EoWZ0CJDx3if1NVGuoDNWUGy6z7dixHMk8JP8RppR6QQvrkNvZff16/jOb2jzIhJ43K3tZgsUWfe5GFVXBaQ/HsrMmS1aNKBP78cLwsTAavGktAfNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efNCVx6j/1UdaYqxI3xDViZC62vm6hI0ynxAlWgIpr8=;
 b=FmuOeZ/+f22vARuYWSlr9MtwslmaHxCTmKiBT8aX7FKq+bxlJQ/qtXx0KPCnUKG/hA2eFqA74On45moLEPOywYtywApAkJY8gP5zFLAiHXkdr7TZy1csyNoSBtoeDNd5TXb27lAunG7u7amX0jZNaqM/8B8SxQC2c/CY/Sb/F+vwDCvRwH1TGL+C6jpOEEV4kJ/tQ0dOeqA2eCKC3dK69e6FpGEiPdP0ZQpnwcCq5gr6MgDuKHG9RHu8Xa90BA8jjplZ90Wsuu2J6/xX5i6Q0l8B9QSM8p6aUH6T9rgo5Nc6Ik9Aj1cg6Lc4YSHq699fPDZpLk3HQn6/s0YoHmopFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efNCVx6j/1UdaYqxI3xDViZC62vm6hI0ynxAlWgIpr8=;
 b=DBYh5jOxPfwvEM3YemI+2+wezB47OFbnQu6jpjrLuunm88rJew4gs/wdRWpfFb5CujW+WsjcuX1sqw+ADJkM87OpdSx1YMSQq+ZkHBjESVrpkG+GOq8tSeKVLn+Z5x379c3mDaqyNYXRoPva+HP6GkvmhYkW58NZXpc8tJzxjkg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:30 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:30 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/40] drm/amdgpu: I2C EEPROM full memory addressing
Date: Tue,  8 Jun 2021 17:39:35 -0400
Message-Id: <20210608213954.5517-22-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64645848-7249-4770-099d-08d92ac6096f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435BDC4823DC87B217CBF2099379@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7HK4dWgZbWDv+A/q3JLP9HaMWAvBIlhyycxC4eJ9dyDYH1dDMxj+pJ9nYi6S4KWFMtEnu9fAVPsg+lhSWCfL7eUgkVWP78T9kqPvUYhzeu26u/ERh5S9OT1iNzW2Ubvb6dMbnIvxYPk/2TKW+tq6LwV4gZJbqMimns58eCOtAVTiK8D3MjduuUZ5r44UXmbd9MGMFEGMUhQiLfPLwpVui+j+4tS87dhUBtCaWimhAcmjNA6YZRnf0NQfYjk/pcLf6lqq71JctRyl3tmHOnG256eCAHd9eT2NQh/pAtBl+UtyZto4HupyeKHwyhVhpsqfaYsNOhjGvyQYumJgHfaPXuNh6VbXCoe4n2kgpnB5zrP4pYHmCz0dCm/Rq8hlahxZmknm/NRzPsxcw/X73TqKRhvJXt1Bqx5hYlW6x1uSXot83M1a80cA9W4D1b0ln7KMMjrG3MGDXCPL9Ot6Y63t73pusnodODzY+oMEBJAzkhyaSRUwUkYFLliPtPY5JHTJ6iJ6sYhqiKUEyuWDVvVNthLQfzXUPePFH64LihRR/ZZrNBDp7IQgR+HNCFeB75tA2jxF6+WWLNVzr7BKracp9OV8RNybyo8KAm66iW1n9TNHgpQ9Sy08GVembBrSV3zRaQooju+bsINdovxEcUjT58L/Q3ZTGlfS0Phq/ge+PsyAFd9Rs20cQ8Z4MJTGnsK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39850400004)(6916009)(8676002)(6506007)(6512007)(36756003)(6486002)(66476007)(38100700002)(38350700002)(26005)(6666004)(16526019)(1076003)(8936002)(2906002)(54906003)(316002)(4326008)(66946007)(186003)(5660300002)(66556008)(83380400001)(52116002)(2616005)(956004)(55236004)(44832011)(86362001)(478600001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aP2rjhFDvy2O7PxNVNn6cu+PDAPhORBK/SHmfT8G0mQywNIHrMYwTk1OS34/?=
 =?us-ascii?Q?CiOfa3XForfozzJ9mhEgE45/CiJqnvyS8H3Wf4RpRTxm+ETRm+ASJkeccC2h?=
 =?us-ascii?Q?7ByLfGrimuXBQ35/nRN+pKGumXTBa1sifsplwUuxoU6GptpfZir8TAw8Q0ry?=
 =?us-ascii?Q?K6d4o/yw2KvKqiz88G7xK48fq3Y36OzSRWZfEj6fqIPU7wVAp7XB7pS8B/ca?=
 =?us-ascii?Q?2OVuuiBMk5I4bhNTN2s35q7wNKPLBWccwhy0Be5y1YIqwE0Q/26JvDcNnNYI?=
 =?us-ascii?Q?QyrQp6OOm3wMxLM/3JoDYAUo0GCkH4qPKXxS0b9xy4Yxe4m3tJCKcTmLt4AI?=
 =?us-ascii?Q?Jk8F6ukln4bFzxOfAPx8e7sJ7bm+ssjSPDTtEZg8zSUJxuquVrBVN8eKJvct?=
 =?us-ascii?Q?3RR1RnKFHSGSiQ4p4LQg95jn6CJUA50eVMbodyha/CZcg/a7vkpLtQ19M79H?=
 =?us-ascii?Q?cwjSGNw2FzIDRVnUn7C3V4/gADw1QJ1fNIRHYjI/NolRrymc4Rrcuh0vwEge?=
 =?us-ascii?Q?TuOy+PgMfl7USuygg5nRMs3y3UDwGINXYv7Tp2e8hwCpUppWTBgMTK+9C8jq?=
 =?us-ascii?Q?Cb6u64FXTOHQW6uC5lZBebk7SophQasCzFvx3y3+3A/FGsWegO8tWmg+Kcm/?=
 =?us-ascii?Q?pb64GMOLDc6FbTbN/FAkf44vpOIH1u1xQtdv7vX6xx6/i/J6y2Fb/1Oh6XMh?=
 =?us-ascii?Q?iNOtDiL0RMmoYWB/5SCl9YYYoH10C6Ick4gkN4cAT0PwIAsVWpOko5sbPlAI?=
 =?us-ascii?Q?o/0VpHOejxXvyJwxKrkLdLbw0F/jQgWcyBvP03gjZoQyrFf1+ZKAGeLW8vit?=
 =?us-ascii?Q?SWDzDz+wsszgVxsJuywfuXBQtXnQKVfj3fwQ5vUFDTA3N2faVSE+/pf8kZ8x?=
 =?us-ascii?Q?xa/n5pFhfpwCehnaV8CdBluZsdrNwN8emZsDg9tJtInandJ0QMKTB3i8To4X?=
 =?us-ascii?Q?rawpoTHfE456uFLPc8lNn/AHPpQejcDykrPMV4AfKmbRPBIFpz/eZRSGdiPQ?=
 =?us-ascii?Q?RxdxdCefO0jTUmuukzU8235OcPEwXjS1FtX9DJChzHuiAuz6loBqo7C0u/Tk?=
 =?us-ascii?Q?xOBPRdzrZ6FMjNlaRjCxMY30gxYmO2uIFrA8qF2YpTgLO6vQZnnvi3zSvtQu?=
 =?us-ascii?Q?MBnNUUdCMKRs1ONAEZlmkcppJj4Yw/VAToXgNnk9f947BOBeUgoZhddtTpRa?=
 =?us-ascii?Q?m9GrlJqnOefk9eiMOwgb3HGMkJuFMygoK6FNDlgAP5lKCTabTD8zLq0Dd8Pv?=
 =?us-ascii?Q?hVhLZzNuMWxk4S/obwWGCNwP0CnJlbbPBziJt1/y+sH82rQAa/49xVAYkpCw?=
 =?us-ascii?Q?bmGIlwxlwnY1FE4foDbxymzX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64645848-7249-4770-099d-08d92ac6096f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:30.1158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUkPn1q76ZErEqg6TtfwruAk6UtOgwDR9IgJhAZQqVmPf5cWVJkjsIUNZSPtyjdk
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
