Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8863C48BCF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BABCF610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABCF610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0555B6EC36;
	Tue,  8 Jun 2021 21:40:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 704DC6EC46
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/FvuUfc+gHF8XXrGtIC4mBgZPzpe/IZbuj+NB33HiflReqJ8IlKisShzGj2RjsIG+whcw4DmvKuYZPvIrlJXFYarLv+1Ken+MLwboSfMUE2p/JzT2d6aQsNNCw6bNm0JTy0DimQwGJkO1TyZQ3C2VAIMPqLfavCxpgxbGf5XaWkoQSRDrfPr6M0UyqCnhfnj7/jRPLaGVX/IBEA6L51AMKdmofSdbyftnIyx2/9WdCdGzZQRU6MdhZ9NWg4/j8HsKsfJcWPK6W9Hqyl3J70rf062OzR+ISvW6D+Q6eqf1a6PdN38SqciBKvKUcU3f8NgoktN+4ClEfhFbCJgmD7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EM9bwK1EUjIWRfFRI3a5V1u16eM+BiZNrY+VgpbxL4=;
 b=VnuLE4okWObq9gMieG01RPMhR5kV+E8+A7s1hvFNQo3XOKL5jTh/FD+KaGJpqsvWa65M++QA1H+ZkYVH+5tes/6JQQYA8LejKRhBzUI8FvQ0IAylfNXS9cjw0uRsAZhDaYf53ruG4+yndIficVtCTDX6AvbXFBx6jQ4B9QTZ25UvaTaSTOi7TRZOnIHAbld+3Dl7LB6TEp+OgPtKEniP/o6X4kq17pC0wmy7MMo5G8IMcyI4DcM6FbeGEUQXdfQwVMmt2GTy1ovL8lDcLKG+HR38VXz6hhgot/UMlB9SMXtW9yq/ID2Sj/2yqrRF2BsFYUIwmPPd79jeb49tS5uvpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EM9bwK1EUjIWRfFRI3a5V1u16eM+BiZNrY+VgpbxL4=;
 b=oCmJd1jYHe3yHDPWpUKRIJ3Ckpv7WXoQgswjMKg0iiByovqCWWq1luOTIGG9zi0TD6eWXiqt+FXpidAfL0hBIDzx4KWkSq1ZpGb3vMtXxiB64mY4SNtVpK2q0vETnl2PbgPc190NRTMlyiA6AxdoNqvz/VikeoAfw4kd21x2o8Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:27 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:27 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/40] drm/amdgpu: Fix Vega20 I2C to be agnostic (v2)
Date: Tue,  8 Jun 2021 17:39:32 -0400
Message-Id: <20210608213954.5517-19-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc2d970d-d4fc-4756-3bdd-08d92ac607d0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB443510928A65F4A91E0F318799379@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1RSNFMLNJ1UYGg+lbr4xH2mgwB8IKJ3Yvfd5eAVvYXhF+Azac7eWJDmp+ByMx4e4FiOqr06Mwd7sR/r440euml6/ijcRQB/MAXmQD+l8SbF5N7dVgC1EwQYoyQIc/EM1KHYYOZLKw/HsznSQCMTnWAPEhLpkw2jwEf9kfYgUnOZuFHnTs4lzjk3bI9RN6DhsPIfliU0EZ6r+1E0uyWMwAP46S+uCzdwsOKC3+WGnLC1hEVaKOPnezaSsB0GqKPM+4XaqeR0wqOC+I2DVv3s5mq0hgXRsbNBquePLLkkNN9niuXgH4Db680Za5wzpsXqNiEHMSKRdRAzc+GPESgIF410e01ir50Uy1kVvSE8nZtxyabFctngNOX5XZYUsUwPjxv/edvtUc4hbv/nygmKE5SsKWJsbTBS23kbMlWmR4JTELtrn9z+FLhV9468kvm1mttchrN6CcpRYcleNGBl6N/e8W2wEMCRgs14QmdIitwxa7DLO5ozMdEPAEqg5jeHFy2UR3q2TEe29WNgW9zI8VNbArorujbhz+90j4b9fPqCsYd2HXTOjW+ZAawNzJ31E/vU0kcLpM0+LeNZ2JYjmFj21+5pkcmBAsaRh7f/1mEeSVLhNsPGg9d0o1Emzs9BAvIIBC4jlLSDAOcdEqI8J5GGPMY2dyFBY6D9PGisqQrhD+J0RTJvs+RVA/NZiCZ4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39850400004)(6916009)(8676002)(6506007)(6512007)(36756003)(6486002)(66476007)(38100700002)(38350700002)(26005)(6666004)(16526019)(1076003)(8936002)(2906002)(54906003)(316002)(4326008)(66946007)(186003)(5660300002)(66556008)(83380400001)(52116002)(2616005)(956004)(55236004)(44832011)(86362001)(478600001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PyzUQOPErsMchYq0kluzFDXLgwjavPpgKJ8igypFZcoP4Nm3bayHTsaE/nyj?=
 =?us-ascii?Q?AfSG6eJcDs80f559lq0MKbwK4IhDhpIzCi7dc97y+fLllnqo4kZX7ZNDPw0A?=
 =?us-ascii?Q?vlqI3uKkkdEaiaSkQqOc77moLUca3e/kC2DFhK9rHy1wRsGL/9MYis3jnbkm?=
 =?us-ascii?Q?VLppAispUC2uWYoCYFVSp2tOwwYXKbzu4bRm5K+Wu4y/m3CnQ7B/wrm/isIw?=
 =?us-ascii?Q?zAS7pb969Cxg4XiSj/vBse5y0XvFhCSO0WiuPoTbYGNORtJtxwl/1Lp03rcE?=
 =?us-ascii?Q?Mf/tAr82MlKvKT3T390lwRBX0SJx+yOb7nxB/yLs6p+rXdfGF2GQuEZwR01C?=
 =?us-ascii?Q?ZDKdZUIsunwlU4kPRtMAB+AesP6I1zbErayMH0ChGmI1+Ic3o9d8k3+xVwk+?=
 =?us-ascii?Q?su0Q+3nnAfZQ4r+KJAIEXpMOR9RqNxOX9WIxp/mbPzWztqNHgwXs+FYA5TVG?=
 =?us-ascii?Q?Ivnv+JXEtlIlMfO7Ht4EmLVnzGWa5NjCA6x7yCARqOomeE+HvGEO5ZUVe4OU?=
 =?us-ascii?Q?1jAyoP+uU4+iFIVZEgzdf9w+f3Wq5OZYJXglCo6z8ftSTR0b9Zn6B/7LP5rI?=
 =?us-ascii?Q?8H1ff/EqOcmZDC2OzNOglqEfY2y655Pt+lIqP87CnDN0j6p44qwnlKtp1XWr?=
 =?us-ascii?Q?KTSENhiqpdpKh25Hm9Fq6aaKYKE3nmqG+C3ut9AS9x+BvxgSODuZrqhjMRKb?=
 =?us-ascii?Q?8eF8VTaKOcFKKJ2aR+11b2fJqiTM93UzRXBg4TIaPssqgPcQ2I/CyO8VcYvX?=
 =?us-ascii?Q?StkP61bkMNQ/t477+0IaIK7aWRW2bBks+c1U2IW10TFaDrWtNhciXCbt62Nu?=
 =?us-ascii?Q?LCIE5JI9/qUeebhpU1qMuw32O4GYcGRt+mP7IxOZLv4N9wCSRp4Ye/mYdLRa?=
 =?us-ascii?Q?s6lHbU/sJmEMW1OJjUPd4Yhzsecq3M71pPimceIJmklxNNjS1/GutxFCMY6+?=
 =?us-ascii?Q?Twg+DX+QvqOUSpYsuMPWtqTda0gtcIdk0rWme2Fb152ub3fVhfrgffvldp9Z?=
 =?us-ascii?Q?Vrzmg2ZTzNXAF3NWxaEkMY6sAaMF39342REVWvK88bnfZv62TnPcsHOPJWro?=
 =?us-ascii?Q?wO5kYtm/8gd53lFSKkhH4VvnyfSgl0EAcELRtDuf/cJvQR2xncDgjbynOtJC?=
 =?us-ascii?Q?HyT8Mrfmdv4Pw48p+xjXJwEsJOXn+lnKe49g0kG+JDo6o43Sytx0yI4CI47E?=
 =?us-ascii?Q?Wh8NfigtbiJ9wlnliTCTXceKVNSydQ9a7fYiIQxK75k75RuNLjM9lBzlz01w?=
 =?us-ascii?Q?9q1dRUk+HeZdQWvmwy4Hbb+xzDNmfOOvyEyLoBQ2WsXueBF5ORHd674bS1Px?=
 =?us-ascii?Q?AC2SE+5twJNsxTmh0uazYbYy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2d970d-d4fc-4756-3bdd-08d92ac607d0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:27.4363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfTJJriwN67vmA8z0FQiC9UVf6K/xjR32IYgj5f3yhz4ZpduDd5m2yCzOkuswWR8
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

Teach Vega20 I2C to be agnostic. Allow addressing
different devices while the master holds the bus.
Set STOP as per the controller's specification.

v2: Qualify generating ReSTART before the 1st byte
    of the message, when set by the caller, as
    those functions are separated, as caught by
    Andrey G.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 105 +++++++++++++--------
 2 files changed, 69 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index fe0e9b0c4d5a38..d02ea083a6c69b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -41,10 +41,10 @@ int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
 		},
 		{
 			.addr = slave_addr,
-			.flags = read ? I2C_M_RD: 0,
+			.flags = read ? I2C_M_RD : 0,
 			.len = bytes,
 			.buf = eeprom_buf,
-		}
+		},
 	};
 	int r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index 5a90d9351b22eb..b8d6d308fb06a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -41,9 +41,7 @@
 #define I2C_SW_TIMEOUT        8
 #define I2C_ABORT             0x10
 
-/* I2C transaction flags */
-#define I2C_NO_STOP	1
-#define I2C_RESTART	2
+#define I2C_X_RESTART         BIT(31)
 
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
@@ -205,9 +203,6 @@ static uint32_t smu_v11_0_i2c_poll_rx_status(struct i2c_adapter *control)
 	return ret;
 }
 
-
-
-
 /**
  * smu_v11_0_i2c_transmit - Send a block of data over the I2C bus to a slave device.
  *
@@ -252,21 +247,22 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
 		reg = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_STATUS);
 		if (REG_GET_FIELD(reg, CKSVII2C_IC_STATUS, TFNF)) {
 			do {
-				reg = 0;
-				/*
-				 * Prepare transaction, no need to set RESTART. I2C engine will send
-				 * START as soon as it sees data in TXFIFO
-				 */
-				if (bytes_sent == 0)
-					reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, RESTART,
-							    (i2c_flag & I2C_RESTART) ? 1 : 0);
 				reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, DAT, data[bytes_sent]);
 
-				/* determine if we need to send STOP bit or not */
-				if (numbytes == 1)
-					/* Final transaction, so send stop unless I2C_NO_STOP */
-					reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, STOP,
-							    (i2c_flag & I2C_NO_STOP) ? 0 : 1);
+				/* Final message, final byte, must
+				 * generate a STOP, to release the
+				 * bus, i.e. don't hold SCL low.
+				 */
+				if (numbytes == 1 && i2c_flag & I2C_M_STOP)
+					reg = REG_SET_FIELD(reg,
+							    CKSVII2C_IC_DATA_CMD,
+							    STOP, 1);
+
+				if (bytes_sent == 0 && i2c_flag & I2C_X_RESTART)
+					reg = REG_SET_FIELD(reg,
+							    CKSVII2C_IC_DATA_CMD,
+							    RESTART, 1);
+
 				/* Write */
 				reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, CMD, 0);
 				WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_DATA_CMD, reg);
@@ -341,23 +337,21 @@ static uint32_t smu_v11_0_i2c_receive(struct i2c_adapter *control,
 
 		smu_v11_0_i2c_clear_status(control);
 
-
 		/* Prepare transaction */
-
-		/* Each time we disable I2C, so this is not a restart */
-		if (bytes_received == 0)
-			reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, RESTART,
-					    (i2c_flag & I2C_RESTART) ? 1 : 0);
-
 		reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, DAT, 0);
 		/* Read */
 		reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, CMD, 1);
 
-		/* Transmitting last byte */
-		if (numbytes == 1)
-			/* Final transaction, so send stop if requested */
-			reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, STOP,
-					    (i2c_flag & I2C_NO_STOP) ? 0 : 1);
+		/* Final message, final byte, must generate a STOP
+		 * to release the bus, i.e. don't hold SCL low.
+		 */
+		if (numbytes == 1 && i2c_flag & I2C_M_STOP)
+			reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD,
+					    STOP, 1);
+
+		if (bytes_received == 0 && i2c_flag & I2C_X_RESTART)
+			reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD,
+					    RESTART, 1);
 
 		WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_DATA_CMD, reg);
 
@@ -591,23 +585,59 @@ static const struct i2c_lock_operations smu_v11_0_i2c_i2c_lock_ops = {
 };
 
 static int smu_v11_0_i2c_xfer(struct i2c_adapter *i2c_adap,
-			      struct i2c_msg *msgs, int num)
+			      struct i2c_msg *msg, int num)
 {
 	int i, ret;
+	u16 addr, dir;
 
 	smu_v11_0_i2c_init(i2c_adap);
 
+	/* From the client's point of view, this sequence of
+	 * messages-- the array i2c_msg *msg, is a single transaction
+	 * on the bus, starting with START and ending with STOP.
+	 *
+	 * The client is welcome to send any sequence of messages in
+	 * this array, as processing under this function here is
+	 * striving to be agnostic.
+	 *
+	 * Record the first address and direction we see. If either
+	 * changes for a subsequent message, generate ReSTART. The
+	 * DW_apb_i2c databook, v1.21a, specifies that ReSTART is
+	 * generated when the direction changes, with the default IP
+	 * block parameter settings, but it doesn't specify if ReSTART
+	 * is generated when the address changes (possibly...). We
+	 * don't rely on the default IP block parameter settings as
+	 * the block is shared and they may change.
+	 */
+	if (num > 0) {
+		addr = msg[0].addr;
+		dir  = msg[0].flags & I2C_M_RD;
+	}
+
 	for (i = 0; i < num; i++) {
-		uint32_t i2c_flag = ((msgs[i].flags & I2C_M_NOSTART) ? 0 : I2C_RESTART) ||
-				    (((msgs[i].flags & I2C_M_STOP) ? 0 : I2C_NO_STOP));
+		u32 i2c_flag = 0;
 
-		if (msgs[i].flags & I2C_M_RD)
+		if (msg[i].addr != addr || (msg[i].flags ^ dir) & I2C_M_RD) {
+			addr = msg[i].addr;
+			dir  = msg[i].flags & I2C_M_RD;
+			i2c_flag |= I2C_X_RESTART;
+		}
+
+		if (i == num - 1) {
+			/* Set the STOP bit on the last message, so
+			 * that the IP block generates a STOP after
+			 * the last byte of the message.
+			 */
+			i2c_flag |= I2C_M_STOP;
+		}
+
+		if (msg[i].flags & I2C_M_RD)
 			ret = smu_v11_0_i2c_read_data(i2c_adap,
-						      msgs + i,
+						      msg + i,
 						      i2c_flag);
 		else
 			ret = smu_v11_0_i2c_write_data(i2c_adap,
-						       msgs + i,
+						       msg + i,
 						       i2c_flag);
 
 		if (ret != I2C_OK) {
@@ -625,7 +655,6 @@ static u32 smu_v11_0_i2c_func(struct i2c_adapter *adap)
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
-
 static const struct i2c_algorithm smu_v11_0_i2c_algo = {
 	.master_xfer = smu_v11_0_i2c_xfer,
 	.functionality = smu_v11_0_i2c_func,
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
