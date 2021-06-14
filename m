Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3F6C47094
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D015613B6
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D015613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F35C76E125;
	Mon, 14 Jun 2021 17:47:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D0FD6E110
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/knhClIisOQ65GR5J8NsRkqRCUQH5VwaeliwjGf4uIIKK5eTxnaff4LpTA1wDXXjeorP3dDkrlnyoCxsH1xBv47EP+pn1Vf7iQhDyHjrivd6FOPfZWnryMph913LpdEOlD+5W1sYOF2bXmn2xqpRU48htlem6Osicd7UWIFlKO4jCpbjPyJfQ6DEBTAfP11uFyvwO7WpdsCu2mAOyQyvazN5Bzf31f0NxpaeRdvpeANUQs4fW0D+2pwGzGlfpWLyvQLfTnJjDnwPY2unO89/NQwe6uWMbG0NecUl3WoyIGwbh8CK7gP0FkuqKmF8aQ1woz+DhC0c/Qan6pvICvJzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Clk2kT7v3e5+PcwMsmsHbWUMkd9Zj+G0jmLcYv/JcGY=;
 b=Wh7arm77HlIorCKj1X8uhsGzViOoOY+gJNe1wXxZPi4+fGPwZ9tTx7sgqRVquNoH43eaaxDY3eg96G+uBAkLox9TffEaOrgnmeaZzP4ReboIxay/q3PiDyI2l7zY5NsoRXWQD9LGsukPm6ih8TaaNU9/A5DpseHhtR1XqvH5rDNWK8yNpivkL/FEDLGre97a3/KgaoK0YwlkzbpwhaIEtpbPVFr3ffUbp8G7pLsvlrU3S+2iFjLi/o6ibMERXbx3UDJSjNoW60yhA60GMSeiZhHgADfGe4Jd8BuxBZQFRZ67c9sMiT2yxUsPBSOJ0lkr9U2W4LiwYV9IO9BZmd3VhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Clk2kT7v3e5+PcwMsmsHbWUMkd9Zj+G0jmLcYv/JcGY=;
 b=p+1DKF/foc/kjbeIFV3XKGQgIu6OPx3gjIN90vZvj1VFDPvswYahYdCwdxujAxKuudiW3ZGeSKBcti9D3hndjcE/iLkB8WPWqrzqJYxhjt3irdyiW09odvj7kqpzMvS1+Ku6FD2cuxC+uNuHl5GSTJbqKrDGpIRbePOlqk7zecY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:47:03 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:03 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/40] drm/amdgpu: Fixes to the AMDGPU EEPROM driver
Date: Mon, 14 Jun 2021 13:46:11 -0400
Message-Id: <20210614174632.20818-20-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:47:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3964b1a5-37ee-4461-9f76-08d92f5c6ae2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4748C86DED44F1922CC741A399319@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWypJavmNnBgbEq0trfTheObd5Qy2uLJM9lRi0iusmq56k58Z4XACgi0XStblvsUn5f8P1mWcsBaBZH14FUcfphwj7Ny7xkKBFu2vda5Fa74vxkZt4MtUA2zU2eOLXdn5jOZp+ZqnKuUIuqDTEcz/QkHPqKgrBJvVcGUowFBQYQ0anIoW9BpVuWA9e5fQpKhtWll23phqELh5qZPb40sjzcruU9FYzCOD9a2SrTf+A6TSj2PblwLYOcuKpBbukMal6C/lFSEFD/opBepjaP2eFE7taU5/++hCHYPZQeJS/qRsHeC1uKquqYkkTF6Ff3eaYL/KEw8Q6Qxj1W3e7oOUt/PBMFM0k87WvL4cGphlnvvOG/6N7oDH/dC5F/+4V05P9fK60uXWsTuPVs8XNTJlp/xNQcpsWrToTGT/478S4F8IIruCLLmR/tFEF7PjM293E2A4jtRWZJRrz6h40Wn8yP39ifzNhyZIPe2/yImFM1Z82id5prUgb2FJdDPA4+dYrU0/ZvTqte6Cup+ldpQ7hG4VXnHcpelnCwtn70B4NfDFkJtV78luACZyt5G/owTsAeig1g622yYpTDC7gT6S7SC7tERqfyu4jTNGQrZ8krekq2Q+SlRLzsXVa9628M2uY8tknMV6n6WfxZLV+9DxatyWEEs/u3+UG5SrKH2lyq/izlb2w4hVuq/7Qx14xhz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(1076003)(26005)(6512007)(16526019)(186003)(4326008)(6666004)(38100700002)(8676002)(54906003)(2616005)(956004)(2906002)(8936002)(66946007)(498600001)(6916009)(38350700002)(83380400001)(6506007)(5660300002)(52116002)(44832011)(86362001)(55236004)(6486002)(66476007)(66556008)(36756003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ds0uUGIYULepxnWrqmroiNCOC1FP2y0g2lqxfoZ0DX5m6mNe9CP0yjgtIk6q?=
 =?us-ascii?Q?9tm7q2V6VSxu27rFO9oq9RDJUwYjijs1/igdebqn69inEbZcAwn7SgZZaf0T?=
 =?us-ascii?Q?/ygMWxX36asIpvMqQMHwv8r+aZVJHm6O5lDy9M47/TIiQCHyuD2a2AroL9hf?=
 =?us-ascii?Q?mzDvuVi7JKekZvJxLE05ifHMIsuLaK2a4seud56WvuaJDK41AdwcBBsiJXix?=
 =?us-ascii?Q?tsLaQNaU9+Vkw0WYl7LJETyuh+UEAcKEWUoIv+p82KTCjac1R/qFokcw4Dm3?=
 =?us-ascii?Q?tfdmVwZQo3848ey56VavTTvvEuDVu4kbv4qtvTebhmdlEKkGeMd24Dad92it?=
 =?us-ascii?Q?QflEtXYQf8DpiW3yTR64hYzxIQJhMGcnOxcijJeCzwdyObXzv4b2LpJ5ymEG?=
 =?us-ascii?Q?4eJcTV0ndrYZQWz8IbprvDqeWY95e3Ck4fgd421OPicGfdi+FflBsZTuh0g8?=
 =?us-ascii?Q?Ll9Nq7gykr2CrrlRluYNVQEG6vh7ZbsOdiLTTnkSeIjAa7YRGWOdDtSUMOag?=
 =?us-ascii?Q?dCqx/tM2xKKPPdLkr+WOeE6YL1RN4rUctosPLsFfHeFZBG/UtzJbzxrGdITk?=
 =?us-ascii?Q?xyubRUnbFzOM6DpMs+R/Xc4qaVakmu5td7woLmemSGGsX9MbbhjassfQI6Ph?=
 =?us-ascii?Q?CcYLG7nLPHSgwyt3gO+ux5X7iHziM3WWyQN03sMj6jw+41gIYMhl6FQlV5QW?=
 =?us-ascii?Q?DYsR4IldVTKPRXJ1+8QIhwOn/sRPvJY1Jev1cnERUSaFmGiIB1Pgnrv/9aLU?=
 =?us-ascii?Q?GHyn8TX9TLDcKuaEdcnBPElA8PphwI4n0QdSwDgf3veGK8eLsoO6T2pu/9yx?=
 =?us-ascii?Q?K2Mmj2OnGAIx9V7VQGW1LvxkmhNILk3NxPwTxIcRhu29Hg4b6WfFLDb58Du+?=
 =?us-ascii?Q?i5E90twclVPdNgp7ms7RCAdx/Y6JZs05kd5NwvxWSJQdWKhRDdBJ0M7/8Ft+?=
 =?us-ascii?Q?0ZKGagqYZgjGddjeV+tzbMwf6C5o4VDQCKpVC8aUlltW7BhKPsPig0tB6SKJ?=
 =?us-ascii?Q?YzUPiNFWlddL5gxtPcpZU2HQ6DjpH2rdEnkeo2Rp/JYG9cD2ipGyBb7bVU4B?=
 =?us-ascii?Q?7sPW0yK+5qqlWOEbhWItIwKIOBqNITjvlyX9NY95YHsIZSg8Ynuc7MqIvRMq?=
 =?us-ascii?Q?umnr1UKGIWt+JAhPkI2+vVjAJXQ7CosELRZzfFEd59Vj7Yl2AH0fsRn2/Lue?=
 =?us-ascii?Q?h3p0aaLMSm1ipbKDghYyEgVUBxuDsJN10UscH/Xbrq9Geb1A7X6kXP+VaVvP?=
 =?us-ascii?Q?tVoJgHjWkZybuAVUYJ+1/bcPRKImABvY6fAPhM5xOLQIYhp46eNJo5M55u3w?=
 =?us-ascii?Q?oNSHo+Q1i0gLqLACXPkT8BMx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3964b1a5-37ee-4461-9f76-08d92f5c6ae2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:02.7448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3OArQMr8iMDmMXR1TSbYkyh+6eDOQR6Wu4M9dNei1hwnLo99wrioxHLumK3cf7p
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
