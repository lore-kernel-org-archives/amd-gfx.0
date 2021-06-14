Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839E5C48BE6
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 523F0611EE
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523F0611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD86D6E122;
	Mon, 14 Jun 2021 17:47:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 174A36E110
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1rY8hhpr0XR+MP2N604Kwh0bog9oA/wVK+X8obHLxz/sxCBW2bJpji6GWN3F5p3P7anHOBCMMof3zzedfXyH3kq9R4WUctdkdtRyCIeK0KCGx9GolnD31sJ6UZoWMvsKjNA0cDUwcd0E/eGsMGDEc1oNSakYJe7VlwoxO8As1Mxyqm6Kr0FQBg2CYBFScUBWohamLKQ6iTyGVFb3zptoaBOq8Z2ZpIhHhmV+vlkQ5LSWAGt4Ppb4VllLrXonZo1RV2w+0Wu13V261eiGrmrMLLPvqi2exlGQfdRi+zHRrIsmWA1tUYlfoCoIrJ/uuXE3m302ELq4LesKkHf6TE0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flvg+CsscdxJIX+2kgoFPtu0wFCFyS5qzB81Zvug1Sw=;
 b=DNV+e80qq0h9neriZm4rGXTpQLWoLwyjCxcLjL/PVw6xXA26w/xgiHm+Sp0T0Um4b/HmTxhNglMrYzq1nMCL5kd/e+uFGPqPYIPXHnfn4xApqd9lVV+AIN59AGTkaiBPzuPmkx5f9Hx3lJP3Kh4xlRxrqXp5w6vmkLcm/ja+FUdRkb3JA6cE5acLM/wCaZFn9+wPOyWL57byGNvk6lIyQw+HA8ctZnvsyYw+AzM6eD9giRJE/I4V6/lH9uBA/JfArkFWqA+ajjJXWFgE6yM78L0Y4YRqj3FEftHOumPdKoP7mj4Ux3VK8cqDRKeDh4PhaPh/TUJfkepFmXg/9htCkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flvg+CsscdxJIX+2kgoFPtu0wFCFyS5qzB81Zvug1Sw=;
 b=IFMUNKen+VRVi1uHiYl09z8LyRH0j9Uk1KrNLhzlqC+c7bs3gtixfh68Z3EPasBYPLhTxkr1GTA5fSfgcJQtYvCKtS63Fw+cLry46u7K2alp/e9o1E0YQ+g1Vnh3HxZNPru/iPPdR5UtzNio7mSZhynMmnokCn8MuKNr1ek6cdQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:47:04 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:03 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/40] drm/amdgpu: EEPROM respects I2C quirks
Date: Mon, 14 Jun 2021 13:46:12 -0400
Message-Id: <20210614174632.20818-21-luben.tuikov@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3608e7e8-1615-4844-5616-08d92f5c6b5a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB474833335CBE1F940EBE1ABD99319@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Uoifr31t2yk9rs+kOvqxMwEymUfse35j+K2UJxkVb70Q8wF40CtCc4VdFC7ErVmFe2SUn76aOoeQUqPaBmU4P1K1WXZWvp+Kzqf+XHvrUb3BAYpg7t9JWaFDRJRxQWvwXtQt0J6WkmBkxeka7XhSUK07hlKLNEjwFXPeXjKR2w17r+vyljLN/eMmqURU6OsAJHbbPzYPlkWLpAiPf3z93Nmw7SLrDyQR9bZmufjhHrk4XLcnV5Q+Q9URcAJk8XLpF01VfN5iNq078DlNHpEfCd+LDhvFaphHKlwOhds15/lkCPGIOzxBsSCz5gtGEoC19NVcthdyLpLBjP2aEf8ivgc7/7kRzlU+IstszcxH8EnRhAzghMA2dJ2eTOjQxkGSaAUnj/j0iiUmYi3m2JuaX9r7gM3KmXIzWTCerN6cU442xXnxWeoHwrvWLcfInu+8Rq4GHQiX0Gb2Qv+b/Y3widIiHSnuaQb61+1dR29IAPQnOHiNrYXzT2pmTZ+99FVCop1/Tc/sCYJa8/7dAOmq+PyWLmBf9S97i4M60d0mr3zcRoBUS43Hg60GeWf7xDspMxtlkfKAdwV3BO9oMtn7u3/qIyCKxHSTMr1RbxLWiaEd8g1yupB59SqcTMTEyQW9u8jcTzk/FxERkfiNzsuOzC3YaH5uS9Uuekx8PCgbs860LYYsqbbU9dNzsyb8Ur4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(1076003)(26005)(6512007)(16526019)(186003)(4326008)(6666004)(38100700002)(8676002)(54906003)(2616005)(956004)(2906002)(8936002)(66946007)(6916009)(38350700002)(478600001)(83380400001)(6506007)(5660300002)(52116002)(44832011)(86362001)(55236004)(6486002)(66476007)(66556008)(36756003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/BsEwLD6fRxojEVhYQXMX2HokcnnyN4utFCtS1movrHRzZXPZY9MpJWDU7jR?=
 =?us-ascii?Q?Qk1VvVjoMGU5Is0fkJMWDZONkPX2QsNNCCItwOSLOrU/gf1uohll5Eh/PGUi?=
 =?us-ascii?Q?sTKeeDn1fPMZVumf5y001c8PziXamke/j9QEqqDDaBdJIVQ+qjGtd1pPQ5Jt?=
 =?us-ascii?Q?pPazuyiEFoQ+v/Z+YDELkVCL1I9nGmAfj8BmcmRSTY2/4Iz9aNaA8ww8y4q1?=
 =?us-ascii?Q?5nXptpMaRlTmHm8cbNR2jv4i+6/DH6oZ70ZgfWZrGaTuHM8uxuLAPr9swhKl?=
 =?us-ascii?Q?5UgQxbO5cAMZUqmUA3fEsMJxGUousP5+vZu0pAV1om7dPgGaL2c81GfdBhgI?=
 =?us-ascii?Q?4aLWq2B2UQf3SXYd0SrCsXo6OR4G5nw7qg78DOzS3gTmCKPmpx1MhiDQNMea?=
 =?us-ascii?Q?Ph2R1ym3DKMlwpPiI7o6emAoPpuov9rFEW2GiCXQvz1kLvj1FtMw/SYu6MAX?=
 =?us-ascii?Q?Kx6SqYq1iGa6XOa7YBALtOnd/CxSgeeT1B+smUXkjJY4AWezEzFt83g7lLVe?=
 =?us-ascii?Q?AxjJDusceC9wiT0xsHOH6qDNToLWp6kdH0eiwclQ4g02r26FyPSDF3q1jV9c?=
 =?us-ascii?Q?VeJNJxzMn5vTv5C1gL7Vipuc8GVO1/lqO2weYPDSJPfgKhSD1Jw1cwqZKg1m?=
 =?us-ascii?Q?EFNPW+FX21t/ioHDfElWbV6WXbrEGeUAKppW4Y9DtyWQrZBDtqpyhgsPtAnn?=
 =?us-ascii?Q?YeiuXAHRXTj3eCHIuhgLoaFQArfb/Zc0z9xvUuhDdS/2Z3JhTB0ZwZ0J82hS?=
 =?us-ascii?Q?/mHhpDPAFhd3iUYNbzrc6wyoGiNVRBDCwuqNFsCnUB2pXiV+fZVeAB4bLpPn?=
 =?us-ascii?Q?fkBLX3ehYzBSxnouJLaTokgKP8M+jEuMPfKT7xfTKvVgddMBlzijSVRlgS89?=
 =?us-ascii?Q?5BXJnedP73COp4+g9mlexv1trB8evdZYYy0WOx4ldEO/TnmwGjg72+xsczZk?=
 =?us-ascii?Q?uRsjh25GfxJMyHsBg6Z2D+J1x/RR0Sv19rmUEgYS+ccoI/K90EVvSkaxYYUl?=
 =?us-ascii?Q?MkFAmJ0amtlk/Ie1lbqmV3rjZukzH6JlVJdZKifOVM9J3iScbF3S/BQSZUEr?=
 =?us-ascii?Q?/mtJS0uA9Gl9ZrCjUDNpuObtcQLjwvinV1ZSr4YcQLqQHzL8TVYWvHQokFa9?=
 =?us-ascii?Q?kAuVFGJph7hpKbHZNuMbnJyL3a32LhSzWj50i3u5eW7LeXuZ4TPqJM0nATGR?=
 =?us-ascii?Q?6sSNWFrO3PZL7pAJEIqjBzD8lz4Hkt1jhSErbEAhp0ESaeonLUvV216UxmxA?=
 =?us-ascii?Q?bZ7pJsXS16aGu69WmFntCD/ppYjZKbR8RjrudySIepbxCtRSMNnVTVHd5zF+?=
 =?us-ascii?Q?eB31JZAoZNyJ5BQB9lA9vdCt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3608e7e8-1615-4844-5616-08d92f5c6b5a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:03.6153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIHVX4LUvrAHI6WdV1JFeoSxl0nPxP0/UpQxCay4NOwdWAbhvQbv/kI2iwWeD6Xq
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
