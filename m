Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F142FC48BE6
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C791A611EE
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C791A611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F9516E110;
	Mon, 14 Jun 2021 17:47:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 279F06E122
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MND3N2FOQT457iY59iu/5TF47bfOrFNxzNv/FfNNNo71U5I2FJAly15hmb4KW870NWiZZdYhvMSWxGzA1dOWdbCGcwSXPc0xbuV8NjsPjP1flJuTpJzkQD+Cjy4K6ExUdunz7/Gfqv38ubTK1f1EV76vzi2QJUnLkPl1ofjjqmnjmT+897VTWClzK4XAN2ekm57eFPu3u2rHe+i5gbs90MwhCghh7vGy89Q9QDxSNzRETC0xso/v2EN3UBxgrVdVKvGR6CWm4TeF/MCr8O9oV8PVcor1nstYs0YCZHultbGjeuxHpEHW7WY8vA8RNiIhOJzvrmdouv6b9tk439lWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NznSkyMQxVL7iEPeEjr8tCXutlmrji1M/oJzdzaH4A=;
 b=OOWSx3/R7II/uKrMnFVqkqpDVtBV7xViZe24UJKUr/H0pPoNbUo9bQn/FflZs4cllJ/ilEWohPA+gQPEgXM8VgC6B4qS2RxFOsL8XFKJSxas0GhFflO2VJ9Uw6bN9F+gyoZy3JyYTjIUwwBI5+IZGlgp1A6m1m3YyniOGS8BFlQp1E/+U200rH9hBwUFetydSDuCrPU09z1JjIeU6tcXFhBIrwdKLGLiEq0LH5UIQewAuZKaHtUqHetnUvyzZaTfOtO5+Tyl/3EGNfQEfGIaNyTiVS+OgbDyelmpL8TgUPCkWrBax2MoDlo8o32EWoyG1N+vlBx3/rs31OPijBjrsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NznSkyMQxVL7iEPeEjr8tCXutlmrji1M/oJzdzaH4A=;
 b=dih8PVxd0jAm/q6TVvmVU1r8hIpIA7ruCaoLa13i0SxeFJU+Ax6wE7w78xB8b5jNg/ac4QaiYaFSifORkLlJ7fmTvq8eB4qb9ByKccKOgDWrPpHWYX4fGjlzVIOueEjo+U1eSV/7iNXy4nemzPnBIb3yMhLouwqM8LkK9ym+OfA=
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
Subject: [PATCH 18/40] drm/amdgpu: Fix Vega20 I2C to be agnostic (v2)
Date: Mon, 14 Jun 2021 13:46:10 -0400
Message-Id: <20210614174632.20818-19-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:47:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d90b05b-a003-4a36-edea-08d92f5c6a5f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB47484F72A0D66A4D233D3F0D99319@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8g1iRQqpi29qq5enOFt1MHhB9x/DFUsSIbwJILZ6jooKUk+kpaTSBBmciWu2Iv8f8E2X5WGmBV9dmn61Vh+bjCHRiHoj7thcfA4WZTaRGUpNicsW9o9QT1xl1ic4ABlGoH5zt0YC9pxvOTrtzT0owFhOZwIJQypXMsDJL/Jb5GsS84yVuC9QP1+XI7AYY+iUwm2vzXvep7rDcNvNVL2cgZGl2u2E0A2mz7zavXHKRdEcIbBos6RokEcPN60LVSGcm+6diGbPUIpPp5LIbKhWllVvPo7wl2oud5UzEYZdmejF6TcXEObMHfzYp5DPVgamfKBhw+eX0W5WlqKjjMAX4m93pLgvx4VobrS4Pwk09qTHpy4BmyMdxH2kcHB8gkZKdfkC5rJejqOX7BthRRWHfPFIKBtxNrtVXBEuTxvQgZloYEVsIBE2ME3a9CZaV27+TMQDTKHNyyMfvffaQ/2IIjSb8Ra2dWYsfVit/9Bdy9+tGe/pdKF+XAEnlb01k1esshJOOuqjTsjLOiHSc5jm9xEQaCYtzhd2HDCc1iqmp57r8EvTM1aiTAVeOW5O/Q3oMdhYKDT3QNQ3V4RDjB+lfFlbKZj/PlAF6KCcXjkPyZersqT6bYndbltAjtD8TGrn+/igcUkcz4uyPg9+yI2KRAKhldNn0YfuAJ7uM6uTGEV8zwS+OIoTYHlgwTS2yiRH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(1076003)(26005)(6512007)(16526019)(186003)(4326008)(6666004)(38100700002)(8676002)(54906003)(2616005)(956004)(2906002)(8936002)(66946007)(498600001)(6916009)(38350700002)(83380400001)(6506007)(5660300002)(52116002)(44832011)(86362001)(55236004)(6486002)(66476007)(66556008)(36756003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?byfZUY2hRMeQqlQG0q+ebPcfe1EexeYNe6O7U+eVt+FMsfP4To0LBpB+enEA?=
 =?us-ascii?Q?2cg722cjbp4EqDA6diTxYk5/OsMSAFX/dTwDJOOv66OYOJCriHCpbsD0b5Za?=
 =?us-ascii?Q?iVg8gJNxnBfB2cPs98txgQYgVxL4CnGGfLTiPw/ys/VgkdK7c1e3CTNXIN0h?=
 =?us-ascii?Q?XfKlqq1wuSuRJBS074KdZ0xAq47GNJ4xN3exMByPwkFaZ5nV59IfqzOQtQwh?=
 =?us-ascii?Q?KzNtGj1svpq6io/cuerXvafUgXwMC38D9qTGdnhO6Ory3xczdw9wlBUlZjkT?=
 =?us-ascii?Q?ngEH3Qkibng12PZltlcluVP6NEa+muVq/rWAztcBfkIj5GZC/PK1l3kl8slR?=
 =?us-ascii?Q?trojTBvjoavJ0dqFS1i+vbVzjgQnHNbm72cfKsDVncc+Hl8YwbUKdwOOPm/E?=
 =?us-ascii?Q?TxqGvlnuq2iGgp7MJ9brPyb6847mPuhPEOzMM0sj+KL1wrpqllVByepk1JFj?=
 =?us-ascii?Q?F1WWDsiN29z62PxUtIM0svig9z0+xJ/Bv45dbWs/s8Lgg9Y8IgZ7yd2Be04C?=
 =?us-ascii?Q?JatmWvkkJVBnQ6pmoP6MBjMykuob/heOe2m5+cGTE8Gj7BeviK976JqaLU6h?=
 =?us-ascii?Q?ju4XxNBBAVaBgQeFjOW03rUK1UpcKi3yUg4mqePNugGl94TjXa31ov3KBr5Y?=
 =?us-ascii?Q?79NalJD8AtbdGGQkzOmzvMTG+XBTs5xBnW6rozj+EsD86WVBml3fBx8Eq9rH?=
 =?us-ascii?Q?/qtNcnpceFVlfptZuawrdTn1K+m9vFJph896rNVy0CRUDCZYdC2FdVab0Pk6?=
 =?us-ascii?Q?YS5/v4O29hy2Sq4eXHA97QB0cC6nJqFaDpeS8kXflktki4skvwbzt2e7yad7?=
 =?us-ascii?Q?7HRBXRg7mI7yZAhnCi88Q9uOBjqsqvp0vRwCr3bkyEHEv1EBUXwTAA20qjD4?=
 =?us-ascii?Q?os7gJaggPGLUJIVhzhUyVAqWe1wG2qEBXqWzR2f7GYErbDWT4C0zPWxSBiUS?=
 =?us-ascii?Q?ylBYqEDtlrd0zKbJ8gpq0UWiIcvU36dvvu5qFcd8UyzBfDGlLSsiovuL4PCB?=
 =?us-ascii?Q?o5lm4WnRiQ0+uwwnrDfHodlEz+JpShaj8zdAtsylWlfoUu5xAA3ZNalPKQ5+?=
 =?us-ascii?Q?4lsUILmPjACRpMVgip8PreW+ouvja98eds7/XX2AA9NaRot6TxQrAY0Ga2qU?=
 =?us-ascii?Q?tcHr9wrGjuImNNej94mLsS96YiyZh5QpQ1qDJuTaJlmL/AgFzeesH+BwEmCD?=
 =?us-ascii?Q?W99s0uJCdPeMMtQyBqns0ek2tXU0YRHqgWaM6he5VbG3iZvlAhPJEMAmmqV/?=
 =?us-ascii?Q?Sz+CihS2Hall34T4jyw4sCw2HHJW6RzwW+0Re0vavhyAmqExAlb5fmmBv6MY?=
 =?us-ascii?Q?qct7jkzprfToU6e1ilkQaGRE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d90b05b-a003-4a36-edea-08d92f5c6a5f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:01.8813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icq8um7SmEl84Ul7EPeQdJ14Fk4RbpSV+DcoZvRpQcS7xWRwCr8s65+2lj5pZk8b
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
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
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
