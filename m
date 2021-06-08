Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B04C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E298610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E298610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2789F6E811;
	Tue,  8 Jun 2021 21:40:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D78C96E5B9
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5DETu2t00RqxGayzpZkkfIWWXiKgFwIrKQe8mIP0QqLem/KEkNcOmTOZUU464XAEhg3EVjFKReRr3ZogUDTUly3FzGa0/e8Aif+PYj5PJ8YBdcylYKjIz/Jk01DWF+ZJWXvJUEvfN2ZMEEGpYylJhEQnQa3HALSB9RwG60RBJkbsvVZ4lqE6ppkClf2bSFuo/BDrk2HaImaKivsSkWAmEa5muUyp/Bn+TGmqvi/ZHvV4tUtDL3qmztTH8y7dwh06BduACDXnaYf0WJbHuYF8qciH+oRA+1YWcxAZpwN6WXjYhKHRKQxsT2v9n7vVVgcJSXmtlEEeSeEtwcmEkNjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyhKK1+o1MXMEqceLq44MUx8MpjZj3Tt3EYcfaPyga8=;
 b=hz0ok9q+p/fvdRKRzZXqzivNN91DetlvU/S5uwCl0u4To7M129osP1W1iftvuMhL5di44Ku9cbpXC+rw5CHbCgT8K4w7AzH7hS+ZQidN9seiywGfvdWk6Hy56RSKCy9tfkxWTdAnj5Udz9A5QiUdQ9ZoVzP4WYxHjjt4bKJ6HdZarS12oycOnr8d9PHPZltnyanPiQcbMXXAxyFCIj2rDZeZm1zFCCR4d442dRjNeZtfPXIzXBtKA7HBYcS4vGecoaugX5USLn11GgEbtm3xwwEOYRW5KuH2UoD3L/bnNDI7SAP252ZWtQ0yMBjRj5w8H+8jd3C7+GzKVw2JI2YkHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyhKK1+o1MXMEqceLq44MUx8MpjZj3Tt3EYcfaPyga8=;
 b=ob63MBT8m15Cb/jqoaQHgIMphxmCx6oKNHfID8iyhWBWHsEpsOfJSTe1BeWTizh8im78TMjZBS1WgovKTVfZpphBBJ7ClZ/pwZytW6Pll4X0Bhqo9FmRQrc8u3yas5W0OVtTLtYfmE0M1Kqf33w5SUBaNnR+V66IEZjrWD+U9xw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:20 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:20 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/40] drm/amdgpu: rework smu11 i2c for generic operation
Date: Tue,  8 Jun 2021 17:39:24 -0400
Message-Id: <20210608213954.5517-11-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75551d9a-626d-42b4-82d0-08d92ac6037f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4355B42324F9E7FF3399C16F99379@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:113;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2XAz1v/g1+3nAsQ43hbbTpWeFOQ33eCWW1yfKljUesnfSAJrHl8554KvQtXa6p+UujCfOJP4LFc6CIi3gyAc5SuzCGtC0JGRzY5og7LI3Hx0nyNocqcsaDWm0dX6Zy/RHW8m3kTL0Ym0X8QSIDpJPUgzgvuiMzzsP6Gjw/azBcJPa5IeqasBeAdsBIr4BvNQUonGELqDi0B2cRg2rLYE36jT/Qh8IgalUsloDwAmPVPK2ViNJzKIxcZU6BcFnHvFUMuLbmfUBYMZVkmO3j6bCme7O9sW1EduC5iYPzR8JNneQQa6Dy++9Nu+dGWrkaSXg6LcGt8vALA1cySa2JGQTXvDcZ/xknbj2lJaL4pPbzVcBuaTrlI7z9IM3ueJduQlKoL1ZfHP/J5Im6amQw2CplPzznc49W0YbFGjJ7jWPEaGJt5ylZZ0yb0K9Uc5nbfzwB/Ss2/ZL4UBAQF1r2uOtYUtB36XML2hiUuxC+EZ5ZMITfSjZg/gfhlzjPEsygopX3ATcXIGxqx2kFKdHiF9aBUfydfUJuK9VZGhyVdShx6HVeCrUJ574mFCM1I4mzd6USs5CbFOAyyCN/N0U8ID7JGvBK4XiejgDntVv7QREWbflt3QeHn2wNJwKQge/wMOxsszR9vfjfGgo+c2s2010wdyS4aU5B3OaOlSWxLdA8AJo9dEs9z3KxwyLMFkCS+1cdK8f8R3gICNdq9tmnYMZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(376002)(39850400004)(346002)(44832011)(6512007)(66556008)(66476007)(5660300002)(38100700002)(956004)(38350700002)(6506007)(478600001)(66946007)(8936002)(36756003)(55236004)(2906002)(16526019)(6916009)(186003)(54906003)(86362001)(316002)(6666004)(6486002)(83380400001)(4326008)(26005)(8676002)(2616005)(52116002)(1076003)(69590400013)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wnj7N6NJTXxZymuX3K4ER2gPuZg1RNwJaUPj3pSoKbRAJ64Cwq3yyrFx41BN?=
 =?us-ascii?Q?jX1DG2xp2gGnbyE9q1qzH2/9RlGRr1cuBsJT5PhXotcxaY1lX8VElM4OTrxy?=
 =?us-ascii?Q?Qvm8K7kGPioBCr716K11QR//q7guscSlXX7EG3VoL9J4c5BE6ogHaMUCYoUd?=
 =?us-ascii?Q?yhdT8Bpwi2sschZJnAsOiBjfCNTAswAbHnI8Ol2e/wzUGnR0CgYVdfbFINVH?=
 =?us-ascii?Q?ekMmj4MTL1q8UM0J/3YqRVzERR/inFLBDZqOFBOfrhmqI568JSgIK2PFrbZp?=
 =?us-ascii?Q?JxGVl7cJ/4rdJXFmaj8fiM/WElyCwI11fD3/oT7y94ihdPl3quu1NMJ1d71t?=
 =?us-ascii?Q?hywIhIwOjZ9dsK+htHYIGpi+w8MSOiDgU+6LdfKOC9QrT1XytN+JtZk5xZuY?=
 =?us-ascii?Q?2ngF81w/6Vh7r2U0lTek3yZokJlYpQbUwpHzwMMsRcBlLkqGE+YGw/ZvOL4w?=
 =?us-ascii?Q?qrmrjdSU7LksjTvLTqRqueEtGHfhQbZuGs0S+wGRcsRErvXB4otgpMRkXe1w?=
 =?us-ascii?Q?bG1/ZzakfHEuUEI1fjeyN+bRA1vrB7kwQy4w7mGPD1es/wr93fo6j3p5nRbO?=
 =?us-ascii?Q?YctJDEhIqdeGJH9Iogfd4Fw7wCMOIrhLL0thpu+KgKJkGHevtCQ4I90Q+GCD?=
 =?us-ascii?Q?lXfekHWn7CRXadkVmXeYBlT3LIy+EazqkvT0QRbboCHcjzHZ4A3wW3gN8joI?=
 =?us-ascii?Q?BnFYyOQhc3/bqDrH/n6II7F6CXvsPtPV4rKwEaVOcuEx84TSSUbEPXRhm9nG?=
 =?us-ascii?Q?yeTMYSxOAT7WZS4A1HXGCjNRNEEKhuDb7T4VKBhEzkKdQEoPF6783PdyFQOV?=
 =?us-ascii?Q?n+WRQr+zVAlMds7OG4kuLH8K0p5pbLm8i4yfbULXOB/Ov7L4uyuhsTxg3ljO?=
 =?us-ascii?Q?RxgIIaYm8RdJ+PEG1nr4r37f/zbsNCf6o2tXxuVPUFGigU8jw0c6sVa13iw0?=
 =?us-ascii?Q?hO79xwl7L1WjMB0su6FW3Ij5hAKgF8/gCYNiKpNcMlST8jciuf1lUyClKW6N?=
 =?us-ascii?Q?iUB7PcZ61tj/Ma+lcHq2AWTzoQaJkqKaE7TGdKZBsxBhj6qAskiNX/AamKvA?=
 =?us-ascii?Q?exPEQj/hgxJ3sLrkZMY+tyS4TfevMqcOa4Kvnw+N9n6R1copGBPsfPnLHFgY?=
 =?us-ascii?Q?YkihsZziv4h2+EQTArZfvylh8Wc7p0R58+DJxBlp1izwZHkUqofXyI6pRiy6?=
 =?us-ascii?Q?4OzlA30hN5HCPJmuu1XDdRDNWvCpUhlXs+Lv8ZIjY/w+Ot1QQNA4trCIsiDG?=
 =?us-ascii?Q?uGToaqWm7RCnUgLeTfnCN7UDYVIzoTh9XRFF8quQlFyNLQYZxuoC4TRSXmdz?=
 =?us-ascii?Q?7gy8T7qwFwCaXjNsH3e1Tm09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75551d9a-626d-42b4-82d0-08d92ac6037f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:20.1614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHVDJ68eZB7YTPIJPc/2aa7AbsGFkUDoJcVY5MpYMuXil3p1q4AtfS6T66j/AoGo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Aaron Rice <wolf@lovehindpa.ws>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Rice <wolf@lovehindpa.ws>

Handle things besides EEPROMS.

Signed-off-by: Aaron Rice <wolf@lovehindpa.ws>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 47 +++++-----------------
 1 file changed, 9 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index 3a164d93c90293..3193d566f4f87e 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -117,8 +117,7 @@ static void smu_v11_0_i2c_set_address(struct i2c_adapter *control, uint8_t addre
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 
-	/* Convert fromr 8-bit to 7-bit address */
-	address >>= 1;
+	/* We take 7-bit addresses raw */
 	WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_TAR, (address & 0xFF));
 }
 
@@ -531,22 +530,14 @@ static bool smu_v11_0_i2c_bus_unlock(struct i2c_adapter *control)
 /***************************** I2C GLUE ****************************/
 
 static uint32_t smu_v11_0_i2c_read_data(struct i2c_adapter *control,
-					uint8_t address,
-					uint8_t *data,
-					uint32_t numbytes)
+					struct i2c_msg *msg)
 {
 	uint32_t  ret = 0;
 
-	/* First 2 bytes are dummy write to set EEPROM address */
-	ret = smu_v11_0_i2c_transmit(control, address, data, 2, I2C_NO_STOP);
-	if (ret != I2C_OK)
-		goto Fail;
-
 	/* Now read data starting with that address */
-	ret = smu_v11_0_i2c_receive(control, address, data + 2, numbytes - 2,
+	ret = smu_v11_0_i2c_receive(control, msg->addr, msg->buf, msg->len,
 				    I2C_RESTART);
 
-Fail:
 	if (ret != I2C_OK)
 		DRM_ERROR("ReadData() - I2C error occurred :%x", ret);
 
@@ -554,28 +545,16 @@ static uint32_t smu_v11_0_i2c_read_data(struct i2c_adapter *control,
 }
 
 static uint32_t smu_v11_0_i2c_write_data(struct i2c_adapter *control,
-					 uint8_t address,
-					 uint8_t *data,
-					 uint32_t numbytes)
+					struct i2c_msg *msg)
 {
 	uint32_t  ret;
 
-	ret = smu_v11_0_i2c_transmit(control, address, data, numbytes, 0);
+	/* Send I2C_NO_STOP unless requested to stop. */
+	ret = smu_v11_0_i2c_transmit(control, msg->addr, msg->buf, msg->len, ((msg->flags & I2C_M_STOP) ? 0 : I2C_NO_STOP));
 
 	if (ret != I2C_OK)
 		DRM_ERROR("WriteI2CData() - I2C error occurred :%x", ret);
-	else
-		/*
-		 * According to EEPROM spec there is a MAX of 10 ms required for
-		 * EEPROM to flush internal RX buffer after STOP was issued at the
-		 * end of write transaction. During this time the EEPROM will not be
-		 * responsive to any more commands - so wait a bit more.
-		 *
-		 * TODO Improve to wait for first ACK for slave address after
-		 * internal write cycle done.
-		 */
-		msleep(10);
-
+	
 	return ret;
 
 }
@@ -618,24 +597,16 @@ static int smu_v11_0_i2c_xfer(struct i2c_adapter *i2c_adap,
 			      struct i2c_msg *msgs, int num)
 {
 	int i, ret;
-	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
-
-	if (!adev->pm.bus_locked) {
-		DRM_ERROR("I2C bus unlocked, stopping transaction!");
-		return -EIO;
-	}
 
 	smu_v11_0_i2c_init(i2c_adap);
 
 	for (i = 0; i < num; i++) {
 		if (msgs[i].flags & I2C_M_RD)
 			ret = smu_v11_0_i2c_read_data(i2c_adap,
-						      (uint8_t)msgs[i].addr,
-						      msgs[i].buf, msgs[i].len);
+						      msgs + i);
 		else
 			ret = smu_v11_0_i2c_write_data(i2c_adap,
-						       (uint8_t)msgs[i].addr,
-						       msgs[i].buf, msgs[i].len);
+						       msgs + i);
 
 		if (ret != I2C_OK) {
 			num = -EIO;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
