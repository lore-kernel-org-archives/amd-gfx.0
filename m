Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89F6C49EA2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA6C6054E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA6C6054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F8C06E283;
	Mon, 21 Jun 2021 17:12:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFADB89FCE
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeBhf1SQKIvFDkHovMbalqujMK9A5MUHvRcNTeZHgyPIfOj86nl8jY9nW+7sSCo4sGAKPqwnMfKMD2nVwRayV3fl4x4VMTv6Fv14AZMu+x5TLBKb2sFlit7XdHdpHZsnLjbF874cbiIdGGROnY7mUUbVmVy6eY1+s/cTRMqmPQESGv0rjNsWWAh2ulDist7Jl5iOtyCIWbMDg+pepWX/cikUp2je9kQxAtOXvsM4CAeBklqtj2bPVnB4m+osOa27oHilL5LJYO3wg70M3w3FeepgOZCsKLYYJJPTU7V5+MxqkJrMF9kVdV+JGRGwklOSyKGgqRJ5mCfgm6Z1qYqRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viOrTLzaDzuEsGPjo5JWL1nH71S5qAuohpg8S9TDhjM=;
 b=eU0IsTx9sJK7xSlCsO/Ln5iDLX6aP0Xc9tFk/f7uaM6QTlUdYLJYFn02iNbielVCt3aBz+CiaDn3yoSHYzmK6dUe8lkhkrBsK9z7iaVN+RCByO4tAD76dl0XPtBM1+dRWlK85BbZ86GOednvRJtM1lPrluLLWHp7qkz3jfxFK8mXmQArhRvhTjWFPIn9nD5AoEkuqJY/CjEUS7FLaZtZCtm4Q/XsfTnMnDgjlPD/xoLRYWUbh9pi3qQ8ngiBKIelmK7GzJAlRKh27amIsu+rF6umj8OFYQP9meBbxQ2rCxaUfiM0FGtk74oKYLvixj4Qqu6cDZ1hhMuqFnFRq/TL2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viOrTLzaDzuEsGPjo5JWL1nH71S5qAuohpg8S9TDhjM=;
 b=axu13hs1Lb7VAiMZTR3cU4GgH9wkCgt2YPSRLLKUzzZHyJyWFPTpaO9AdW7SPffQyqhxVKV9p9lijoR+1J4WKR9s1hLpK2sv0C2fQyaaqsf/LUXUjV0PtfMdn9kJ/flxmXALkPDkVxkKMfZ84m2jGwwNrXpfNTyKwErvPtk5RG8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:12:51 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:51 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/43] drm/amdgpu: I2C EEPROM full memory addressing
Date: Mon, 21 Jun 2021 13:11:59 -0400
Message-Id: <20210621171221.5720-22-luben.tuikov@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0e0d9ad1-0a88-4b3b-adfb-08d934d7cd21
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38650C0D6E78FBD7045AE73E990A9@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nV+rhACxmXd38KauRICX5K1fGqp6Pf+DillNNguxz6AXlKijEfnC5t6YfkUxtl8Dd5cd/Lzx55r8mK/x9lBFf2v1494aoS7aWvwMfM+wd/FtjTiz5lmpNVcOKFHmy67mPl9H1UDwjJ0r1K/HRTsTdU0d9qoz985/e0U957ycJp8Y2VIjxhQS2xQUlZ2ys6XCHtVKSbG/GBGRyUlS4j2MoxQ0zGx4BmVZA/3VbGTIkNuAB979iJVLZO/0RXs6xFRrK6+rYs4bCXqpwslmzyZDiUP/tvrYPPNYg3qBIVC2x22ct0zgxFIzC97xOh3MBS2Wi6zuQQgl+5M0/43oK84f8QqCVYHoIJpXCrxCQtBO9pAAg5UnzmMHf3O7k9tbg9J5WBKaK6mAel7BU2X0uyo4cnR3y0TCtSqwRgZaC6JF5HKFJTg80yFZLCet2TMQMvazsMDrL3Cs9AukATyWBcyp+molE/JcMAkAQYNZq7u6sVQVEqAHHwnOeY0IM6ucuMOsuwEd3SgQoZpOkshPRGPB+V4VlCO3VooBB2tLqN1SVI+zu6pwBPymIuDz/x0AFp2wtR55Qrr+eOR5ZjPkfdGXzPBl8j1/UZ4jFznEnJwFCH9hfCDb3BuxXNUPp+/BXfrRQFxOIxcqMp2gpmqY4zOTjDVTEdjedWW/eoApGU4H++yTctlaBZDtHtua4prGzR2s
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(478600001)(44832011)(54906003)(52116002)(316002)(66556008)(6916009)(66476007)(66946007)(8676002)(2906002)(5660300002)(956004)(26005)(6512007)(83380400001)(1076003)(8936002)(38100700002)(38350700002)(186003)(6486002)(2616005)(16526019)(55236004)(36756003)(86362001)(6506007)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2moCy7T7gtxKwRQIRzRdVpHn2Y4c5Tqb9a3wr6XWBE3+YSrDNEdadr5jvTZN?=
 =?us-ascii?Q?aNYU5H/aYGICZqTx+auPyvLD4nmdnyMZ5QufhBIMOQoEWK56Zm8X78AFG2bD?=
 =?us-ascii?Q?IhIr79iln6/1ErDBxSMPbZl8hG5Jx42XuQcw00PIVZceoGJr+SRVQ5mc1/XL?=
 =?us-ascii?Q?5Zws+QQdKSR26Ufu2PT5NNaTlH9cz0teqxYqNIIsvTrf0YEztNinFBas5fiJ?=
 =?us-ascii?Q?T40MbcYvqP71ee/Db6sHzsutLF6f9lGHBkrb0RtFblIii8U4kQvb1D1HlOQB?=
 =?us-ascii?Q?oHhHKvi6PpJIbmhHeA1sL2bO1EnK7MkpT+HdCU1wF8QoQWE187shG2ahYcbY?=
 =?us-ascii?Q?nasvMPikdKjlKYsZo+9ixTWneHroEPCgUyEwH9pFGVSxnKqG03BEV0HXojKC?=
 =?us-ascii?Q?8WX0GxfjQiRQRKF1rfkW6wyAaeTbXYu+0dMs9d+hgDbzqK6dH+qMz4gUHBP3?=
 =?us-ascii?Q?HAHSQc86VnBZi4T0YRUmcUwK1TiGOPnwCU+2FeW7tsB5IDhmXikAyHJd1c+o?=
 =?us-ascii?Q?gnvchP3dXyLGpdLLvY2S44Hddtay5WHlSg18kko83YT+pO5eSa/VhPlwRHrf?=
 =?us-ascii?Q?TYNOFh06O4l24YENi1dFPCd6N0l1Y/QaWKVO8N3Aj4dDi5LdGjJu3HDX6ncR?=
 =?us-ascii?Q?e/0ujFDl8sVbPdVbbKgcG471c+fue7BaSYCOKTp7CBnWm/YKPWP8xrbPmqWF?=
 =?us-ascii?Q?GVZTfDPSnzB93TkPzmwQaWJUyppXGUOYPeJl8yuSa6rQlnaYVCA13oZB2vJW?=
 =?us-ascii?Q?TGhpKfSVd5JEMvdB7BxttGRd0NdulXjgIerAb5xGbtljJuh7Uhf8LkJMGzIo?=
 =?us-ascii?Q?5tPK+RiLaOfMUB6PG1uFSor4y14Cf1AmIqsylG5MmHJAA8fuiItwVBBxcc7y?=
 =?us-ascii?Q?o2svpm6Wks7iVphzyMxZ23CXF0Kv5rXw+YgeNXNLxINYfX91xgcteDWVXsxa?=
 =?us-ascii?Q?4g7P0HcMM0rmlvMMBuF2qmQW+ceipXWDCmKCQnjQR653/WwjxP8UIhV2I4+Q?=
 =?us-ascii?Q?rvHS0sh9phsM8DMDn5iynmLS8hNkfumpa0In/96rkxHRx2VOBR2yKdzsBo+t?=
 =?us-ascii?Q?HN6drnilZkxjt4XG1h7rkWB6+9D3opfjwvrBWUQf9oSVAZDqfErC0Olj2H71?=
 =?us-ascii?Q?d1BvsyEFVbNpOZc59f7o3K8GTwI3fjWmlPzGMbxqzLLjrtdTkjJ6/DYfsWAj?=
 =?us-ascii?Q?Ez7uWUGHBwLuD8XFw/yj9HSKyShDC82Lmbt+D/K+e789NarPFqch7FLlnBiH?=
 =?us-ascii?Q?hDK8Y/cCV5XBwio4zpCZ8zS3qnSB62OaUiWYCeFMQsmcTmlORWuB98qFIlqv?=
 =?us-ascii?Q?ue85SUAj58lqFcFE2IfTiIcz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0d9ad1-0a88-4b3b-adfb-08d934d7cd21
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:51.4874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1IPDn//WZhjTFWDSWwstcLQW3AXT3RZPFZn9UKusz+v6oFl0LrwR2sh0U8IPe69x
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
