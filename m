Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DF3C2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F05160FDA
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F05160FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F3C96E10E;
	Mon, 14 Jun 2021 17:46:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDC436E0F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2tQxkZDPYtWCeR3+BSFXB0PiSHyiYE4E2bK/byH+QN/zYzf/DSONC4vyOA39fLqyGYenJukhFiayUp28fl9p2hjgyJjBbdU6DTWu48oHbM+SGhmyfmKb4nHGdzH4Hjja9QARAPlaJbmdRx687TKJYZ0/XZran1tFHS0l34tKPpXuXwUttQwA7uKwY96scWEXkwyP7sLr9DHE7NVl54MIvC5Zn2ghphfZAKs0fHpHDBtwqJh+nIf9jcMjSVqrDTVcUyQHE/jFzHuSecgIzWLwdcphPuUg3ypQhygTWYYW2alqCZMJAzC+odK8ig7n6XqF/agsbzR/1bkAcz/Hdr8Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyhKK1+o1MXMEqceLq44MUx8MpjZj3Tt3EYcfaPyga8=;
 b=HEZtF3Uv7OxTH6QVyvn3EgQCSh6SJZAZTGbDuT/QvbQ6vJ6JoMbxC4KAoXZayPCfuSJDs7IjTf0Km4i4OTEP8iv+rEoIhsTqrFuKSdQyL/FWhFkS5mBpajfymx/TjyKb851R/6PRrWuAxZopvcoxQjwMI129g9Q5GvSaxotvjR91eY+7K9v0jYSxDT6Gm/tWzZVbMVd26IL4q2Qn+W4ody4UTLe3EokYmL6kQ8g65QBNljIY+VHNOoJ6CDADdajqS5/HDNHpRFgTsZxa8rd53KlDmTDBWQbIsYRlBzH8qbjBQ8AUJcSbvpKZvdE7q+ixB7fQEm0ZRwKuJcLdDVJFew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyhKK1+o1MXMEqceLq44MUx8MpjZj3Tt3EYcfaPyga8=;
 b=4Nbo9M/8k0b5tJJ+J59tBGBt8ok+WvHEVYU0x4UzBR6KfzhsI8/w8Pak6izYCTjvEFQsgwrg7/liNU7dpIo4AXDkLoSMbOLjAYVgYChpnRDGaN6M6H9ODFnMUPHDIdRf0TntgNy/cKh5mdptZ/jBgPcvH3KpF5wHcjMcaxzvPYM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:46:54 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:46:54 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/40] drm/amdgpu: rework smu11 i2c for generic operation
Date: Mon, 14 Jun 2021 13:46:02 -0400
Message-Id: <20210614174632.20818-11-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:46:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 186126a0-fcc3-4e95-97d6-08d92f5c65ec
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4748634453F1C91F1C6F583799319@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:113;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/OZefE3kT6xTMy/cEcagYNtNQYFfe5jbTTc6VqjOW8H2TBxVTElIT4xv8SVDZRvMbnpn6CJttxNxnHb7w16/f5LwoMX9fQ42KarnXkbCQXdj4WFHQf7CmoQwQfNPudBlezHl7yzTAKwkJJyJd3glCQKn7WK3dBQi3XncBfShQ1hO+Bnk90ZmzKGsbTUZCEVjrZ3c1azny8MpxXn0IfGuPpCvowGdBei3JzZJ2xZ9Tm+ukZLsvTSfDEwKSD48JMQXrdnMouPBA2XcFcagK0vP+SXd3nunvYANLivg2YmYATxUQMKIUK0MFlobgno573FQE8+b6jnQm+VIC3jagFXsbJ0Jd0/cWhFhYuQ7Kvo38RCZTxsikPeQs6qxE7blM+MX3K/R0jq/voYzPV/AMQOuJvJl//ANMBcicm2rpkfHnkm/n2pg60Ow7mCzHAX1UIZq4IHaNF1roYFMdh0UhNOlxeZJs5KAg8G/q6hUVfizFF30cEjv/t7b51xqcgJpK/qMUFkvkWIeB7WUO4s091VBX1dDXTV1igAtLypeRVj+107If6Fv1bwx+uF1+IO6Sek4w52WRDc++S+IDoOPw52qDhwzCQ1laC0GVEnFxJlqfNThhXRwtRZJ/duz0iK42dkLt8NLkPgLgD+HkJArzNbDI+Iti9i6369xEs+Nfm/rYJA8h9F9FjkwIuFHZMj511LRmRrLsooIsE4hm9A8FpTwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(1076003)(26005)(6512007)(16526019)(186003)(4326008)(6666004)(38100700002)(8676002)(54906003)(2616005)(956004)(2906002)(8936002)(66946007)(6916009)(38350700002)(478600001)(83380400001)(6506007)(5660300002)(52116002)(44832011)(86362001)(55236004)(6486002)(66476007)(66556008)(36756003)(69590400013)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+IOJH4drhQrPKseEcJtnt/1C3dS6IswNWBm7T2uqW4nWIrKHQ4bf29kO7PH2?=
 =?us-ascii?Q?9zz4z1TFyq9+WKnSQyR8QB+m8Z9toC6xE52ssgx06Qsos2As7zonObTIkx5r?=
 =?us-ascii?Q?iCqjFFLZkMUR7n0cJ7YZbwMi/ofonNRbc5BD3G/c477cV/qy1KTHgMmhuqFB?=
 =?us-ascii?Q?oCn5TdsnXyPNZBCuDN9WqaEhpwhqk3ZTwwZ/rSQCitfrJJev95k9x/fqLq/6?=
 =?us-ascii?Q?fd+urbohlEDHSMr1ooSXM/ca1Cu/QgK5bwU/ukxgC5RFO3tER05C5INTLqTL?=
 =?us-ascii?Q?9ewJv3T6vbvufjJpsZIxLjS2RPtsMVHHxrBS4L8HZzMHrEnTmq+/e2k3NgIi?=
 =?us-ascii?Q?SZ2pIRZ28EtNMlNtsMymQIBUtWNTcpUF6oAoENSYxBerhCEtdgvMgOyjRAeq?=
 =?us-ascii?Q?ioRZW/wbJr52g8TY4UCalLBdy0y3tRpfqgAYmT1u8p5TyPno1YM3XZa4IRwU?=
 =?us-ascii?Q?wb6HVsfHzNhCs+XCN0KZRFINBL+Xtyn9uY+nkAw1YmuVjrMQbbKzylTAXw+S?=
 =?us-ascii?Q?XBd3q7Xb6uUIquAQUn1BhsiI7J6ZQzjW7/kNqq0PbLYXW7WgjNNmeg6UWjuG?=
 =?us-ascii?Q?kBU2ryKdS207IsxnpfwpNgNH9b/P1xKtnvamVob+DmNzU43mqecTuO6BzaHu?=
 =?us-ascii?Q?YLIow2KbfJg+DqwZO0zHhNdrCI07PR5yU1VQcztlIRTCb1l+je+MB5QSj7Md?=
 =?us-ascii?Q?+k0NLEo4amc8y0wmJVp5sgVN074I/XA59olNjgm3CD6dOC7P9In2SXIJivNA?=
 =?us-ascii?Q?Mvbh0a+zCKwsk/zONh67YthJEmyx3oqg+38UkPl5uisz5h1HWUj3tEtOJBoe?=
 =?us-ascii?Q?a1cUeYf1HmTjV+k/xaEEm/rvMorG8LVU5JMOEr8Pr9E8zj3Wp0XMZ33G32Q2?=
 =?us-ascii?Q?2yBUjBcRuOioce0tGoV/GApNU6mSfg8mZUkqyF4ZczHy5aqcfXqrJbvjixJE?=
 =?us-ascii?Q?M3FHj4QCV10gF7BJ0PZRowqXqm7QGo+TlW4ggHAMrYBLyC++m42eEJ4mcvPa?=
 =?us-ascii?Q?UUGnOhpvKQqmCNhO3eDyBTHrrpgF+lD5StXP3/HnYLem6lmrJVN4JNozp+Yw?=
 =?us-ascii?Q?6PVgmcn8+lOTWTt7LkchfSbpb497y9tkhsJc59pLlnx+o9leVFojHTp4b9vZ?=
 =?us-ascii?Q?KyPZKu5OWXCamkd7dFkJRzC+fp0aIKI5w91gQlDADVuuVYkeJfcRhFlvs2Re?=
 =?us-ascii?Q?6DmGVl3oef7BuR8m9U8f8WTdmUU6I+prMvDPhe4iPi30FryysxxPswFcEk5B?=
 =?us-ascii?Q?tR2ry01D6k02ntmyFhh2VCJdSV8e5UAxPV00x8zbCCqEqzu6zSGCEdLNSjZC?=
 =?us-ascii?Q?Z7YaPi52Y+KgtuRFtEjunNX0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186126a0-fcc3-4e95-97d6-08d92f5c65ec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:46:54.6834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hJFZ2NL8rXPlN1hEkmSlKbhJ/f3gxwf+Bjo1FTjSv4kKC5HpCw5ULXnfUsMltkU
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
