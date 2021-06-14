Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61544C49361
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB76611EE
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB76611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E7D76E158;
	Mon, 14 Jun 2021 17:47:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9D9F6E14B
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVSNyRIYcVTkUwND/6rz8niodNIrWIENMxculkszGUPOrKFo0/OiyOVlYzHWM4MVcGUiyXrzgFKdRmgVW/hJ5P3iQPNta7ruu9Gwp8GXX7XH8XZeG/wEjJJl5fBPKPkHg7Bf2Rl4xoeFHm4iq21BIYyydCTjaDLaA6Pab1LCpI2Fio5llINUesMP1/Zlu9zq5As3z3liN2RJrZwJJJd0+hMfMv7jX2ZpP2ljSKPxxbKikq5Q+SDRieNwX3k0PPYTaBtO5AebitY2uf6E3R8oge/wO7urBj5HmpfDnNHRnr+73ihhm9mAHyVBfW9SVywePmM7Ul2r5BtuGqokRfPcdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4T/ryjnQiJyTM9VmNSlG4uXhnsF3JyJOVKFNtFRKYI=;
 b=OsuzfpSJl4E/a7EyGBEVVrHsRsfNz6ZcZY57Cq51PcSRyh1Gw8cTQPrcdQXBaegM0qv/OoqzkK+vX7BkXYCqZQTl9cWsfq7RE+avwRi6R6UgzYSKvb/wTi0uqJrFBXwa9evurF6miYjLkq1cRYjD8gVHDd9P6TEwBui+yeu9s04LDLEqUpqm1Mu3E61dMW2pQLObI4sGtLBsWypqHV2JfhIT5cwxvvG9ABPEtg9z8r0AaGBaASdxk/8vCcGC7ubpHZZ0JDCuU4ZhUo7tY40+ZaRcS0uZvPYIjtsa0TMrExoe3QE/H1gYx8gK1C+1Ez47EhpAPxBjGd483BHvxRgeVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4T/ryjnQiJyTM9VmNSlG4uXhnsF3JyJOVKFNtFRKYI=;
 b=b/ozJINhM7zcUtcSroJevS500Sr47k7fhxZeon7rfJ3Ze4QjRefJQRSwz3Y8Ea70NACJndyMl2AGohB+2lyvCIC3zCgbaoDUfbiMDkH0JO0GeGXYEIFJrfDHtCawMdWSCQfaqD1xziGvS2pP3prMdy9ybroNvl0zwdzH54frTDc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3577.namprd12.prod.outlook.com (2603:10b6:5:3a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Mon, 14 Jun
 2021 17:47:49 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:49 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 40/40] drm/amdgpu: Correctly disable the I2C IP block
Date: Mon, 14 Jun 2021 13:46:32 -0400
Message-Id: <20210614174632.20818-41-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:47:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d86025d-eab9-4286-fe73-08d92f5c7573
X-MS-TrafficTypeDiagnostic: DM6PR12MB3577:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35776D1666440E2A47C89A8E99319@DM6PR12MB3577.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uq9HienlJDWCnOug/TI6EGs8sklsm3Mvwf6GJHW/RgpPvobTd9zdY7MlkOBYOqtsWV57pA53ABXzIGP+6OyaxYXIepAHPkXJ4INFJ/7p0dJByUrsuSQuGLVsWJdusHxDRJ0PCV/nVyHOHeBPcegXGak9fMYwwMVkLIgDH1dGwqhSNhpH40ZF0Zu6RWsQ7Z9Ueq8xkRKgmQrJnAlrp2Y/oN7pGYlVper7+1n8nn+hhFQ4MZ32uea7xxFljchHKbzVGno57waKxFxidtPvYMJNFYhlFgnDePrwJfBUqI5vQmmRKyq1h7gagb1pKEKw0o6IQtcfolZZ+9B+7LTdBZAyf4cQXrV6X+xfp/cNtnWqaTt8jGmcfpLHJ/DalRM9VhCRr+AojDGl/1x2K0BUgsJR9Lfqtp2vmqxEs4HHI6fM9tK5ozvvUlbOGikgXQB5uHQgCPeWF+O5F53qA2aazEmMEy7dUQu2gzUpyEqFwOvsubFjupTbADlp4rnbtKVadTTvmMLeMjlI3BK6PDWqcGLY+SLXh0RMZeIiNakIXrIaOgK7Fltl7a0VfDKxlKpJ9feSLO0uPDre3QcU+8j4FjGsXYKOMQFCD1hure5J8TFb4g3r07AHW68P8QMj8lrHljJum16+hAc57YtWNhtYACZfTXtHdYea8Fj/0Ek3s9Meqpxc62mZ8tfPQ5nTYWcOLnwW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(44832011)(6512007)(36756003)(6486002)(16526019)(186003)(86362001)(52116002)(38350700002)(38100700002)(8676002)(2906002)(5660300002)(8936002)(478600001)(316002)(54906003)(66476007)(6916009)(6666004)(66556008)(26005)(83380400001)(956004)(55236004)(1076003)(2616005)(6506007)(4326008)(66946007)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G9FSZEZDagQpDx8CRVr4gROMpABHGBOpQ2OW1Pw9aHZBhH8DeBMFurkdnDW7?=
 =?us-ascii?Q?A2BqTDt4tIucR46LjjpAOa0dLvqgwY7TGoO4y0A7SXJGVv7ZDyhvpH0NR5tk?=
 =?us-ascii?Q?xKP7cocUFuRxJNMTOdv7bSzZfq6nvw8eslCMFankazcQHRRfEMhcWmuU9n3j?=
 =?us-ascii?Q?/f26uzLYHvRZ2IzQbari8p286ACjkmlY8L+sIsHn3gxeQykq1IweuMoXmPXs?=
 =?us-ascii?Q?XmHNW4IimKBLGo4KzlvvXUFpLhiq2A9bwf24YiPaRotUtBj5kVM0T8EL/Q4M?=
 =?us-ascii?Q?XOHbenReGqr/9QYB4iLGF5dF+81/4jdRWgAnGEUHFipkpWjRJA+5FP6aItnv?=
 =?us-ascii?Q?tw9rhawPt6M31YqKUV/iOTtLxpmVw+1AvoiEt+hifmq4VeKXXqX6hBkDs3VP?=
 =?us-ascii?Q?i9u6ENAsDYZffrBk3DL6WcQjOuUJ8sJjvj8VyVnimLY5TNpA75gQRda7UhIy?=
 =?us-ascii?Q?/jptkKajuotuDcnWb2yxx1ZLGEhfqZH9tpL7bIkdv4KHKSuu8VmeiAzQT7O7?=
 =?us-ascii?Q?YOUF9nt4G4d1P4Eb9+c78+wgSD9+M3JgrGiFS0zpDLYXktmnfZYy0yESQtKh?=
 =?us-ascii?Q?mfA/Brz9l7gp/NqzGMKV3zIsx4WZrURBbYOlowqkbxhezCD6JA2XzDCnjG5O?=
 =?us-ascii?Q?d1ZIN5k/dBeHq1YDdFa8/AXbRgfL0cBnpptOjvpa/kjg3XDIC0pHQS1wtsLA?=
 =?us-ascii?Q?PSApPiXR58qmNhM1dysvAzaJC4AuiRLbsRKcV0GoLWZTlh6VQTMv8ozEq7h2?=
 =?us-ascii?Q?ZCu9eIZrpv1EJd7JkjjLGCUGFcTU9MYhjmGaYw8jlyWCkjo3CXUcEpykoFZD?=
 =?us-ascii?Q?4TKZnVNgR6kSkz55jc4ie7hTrIwtO/3qEzikjZA0fE7nBKnZeTulwmUsPyNC?=
 =?us-ascii?Q?MV6+OIZlAEZPvsTUQKOzQVoFSLrfsCRF5iX0IgrwaulmwhcbZ95DeX/rF+F/?=
 =?us-ascii?Q?MGLbUf4T5ftSsBr/WkO1F3I4k3NuhBdtNXVo/c1yLjJOqy/tDj9vkMv8rfdp?=
 =?us-ascii?Q?LPmWQq+AodJNz1+/vaNhjmGNjv/NX5ayhF51sam95yq+AXgtZ/Hb22ldDZWe?=
 =?us-ascii?Q?SO3TQhj8NvxD53NC04pq9e5fZ935zvjEfrvn9160fPz7AgK6YfHUh9oq9KaG?=
 =?us-ascii?Q?79F9K9jL/ZD3BfVw0mTZ2WXaDlFkvsW5EgwvtMONqIfrW+cLFJVfpBZYOQbb?=
 =?us-ascii?Q?fscUykhUEPrGnYKr0ggrQZ2kw3d1MfOJZ3ujZiBBCG/63fua0x1zJWUYsbzD?=
 =?us-ascii?Q?lYUONSu/2gj5J5uD48qnYjDdOr+yeXZmvwsElPYdw5d1d50fVUgkXz5js8Lf?=
 =?us-ascii?Q?aVsDZ0MlUbJtge2Dfxabd+sH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d86025d-eab9-4286-fe73-08d92f5c7573
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:20.4528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEiT/xTQeXWX3Amh04nzDpzg+HKwDdPZ5TC986bJcAIytRQcS9Kz3YNcX8c8QKgH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3577
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On long transfers to the EEPROM device,
i.e. write, it is observed that the driver aborts
the transfer.

The reason for this is that the driver isn't
patient enough--the IC_STATUS register's contents
is 0x27, which is MST_ACTIVITY | TFE | TFNF |
ACTIVITY. That is, while the transmission FIFO is
empty, we, the I2C master device, are still
driving the bus.

Implement the correct procedure to disable
the block, as described in the DesignWare I2C
Databook, section 3.8.3 Disabling DW_apb_i2c on
page 56. Now there are no premature aborts on long
data transfers.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 80 +++++++++++++++++-----
 1 file changed, 62 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index 751ea2517c4380..7d74d6204d8d0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -54,12 +54,48 @@ static void smu_v11_0_i2c_set_clock_gating(struct i2c_adapter *control, bool en)
 	WREG32_SOC15(SMUIO, 0, mmSMUIO_PWRMGT, reg);
 }
 
+/* The T_I2C_POLL_US is defined as follows:
+ *
+ * "Define a timer interval (t_i2c_poll) equal to 10 times the
+ *  signalling period for the highest I2C transfer speed used in the
+ *  system and supported by DW_apb_i2c. For instance, if the highest
+ *  I2C data transfer mode is 400 kb/s, then t_i2c_poll is 25 us."  --
+ * DesignWare DW_apb_i2c Databook, Version 1.21a, section 3.8.3.1,
+ * page 56, with grammar and syntax corrections.
+ *
+ * Vcc for our device is at 1.8V which puts it at 400 kHz,
+ * see Atmel AT24CM02 datasheet, section 8.3 DC Characteristics table, page 14.
+ *
+ * The procedure to disable the IP block is described in section
+ * 3.8.3 Disabling DW_apb_i2c on page 56.
+ */
+#define I2C_SPEED_MODE_FAST     2
+#define T_I2C_POLL_US           25
+#define I2C_MAX_T_POLL_COUNT    1000
 
-static void smu_v11_0_i2c_enable(struct i2c_adapter *control, bool enable)
+static int smu_v11_0_i2c_enable(struct i2c_adapter *control, bool enable)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 
 	WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_ENABLE, enable ? 1 : 0);
+
+	if (!enable) {
+		int ii;
+
+		for (ii = I2C_MAX_T_POLL_COUNT; ii > 0; ii--) {
+			u32 en_stat = RREG32_SOC15(SMUIO,
+						   0,
+						   mmCKSVII2C_IC_ENABLE_STATUS);
+			if (REG_GET_FIELD(en_stat, CKSVII2C_IC_ENABLE_STATUS, IC_EN))
+				udelay(T_I2C_POLL_US);
+			else
+				return I2C_OK;
+		}
+
+		return I2C_ABORT;
+	}
+
+	return I2C_OK;
 }
 
 static void smu_v11_0_i2c_clear_status(struct i2c_adapter *control)
@@ -81,8 +117,13 @@ static void smu_v11_0_i2c_configure(struct i2c_adapter *control)
 	reg = REG_SET_FIELD(reg, CKSVII2C_IC_CON, IC_RESTART_EN, 1);
 	reg = REG_SET_FIELD(reg, CKSVII2C_IC_CON, IC_10BITADDR_MASTER, 0);
 	reg = REG_SET_FIELD(reg, CKSVII2C_IC_CON, IC_10BITADDR_SLAVE, 0);
-	/* Standard mode */
-	reg = REG_SET_FIELD(reg, CKSVII2C_IC_CON, IC_MAX_SPEED_MODE, 2);
+	/* The values of IC_MAX_SPEED_MODE are,
+	 * 1: standard mode, 0 - 100 Kb/s,
+	 * 2: fast mode, <= 400 Kb/s, or fast mode plus, <= 1000 Kb/s,
+	 * 3: high speed mode, <= 3.4 Mb/s.
+	 */
+	reg = REG_SET_FIELD(reg, CKSVII2C_IC_CON, IC_MAX_SPEED_MODE,
+			    I2C_SPEED_MODE_FAST);
 	reg = REG_SET_FIELD(reg, CKSVII2C_IC_CON, IC_MASTER_MODE, 1);
 
 	WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_CON, reg);
@@ -404,7 +445,6 @@ static void smu_v11_0_i2c_abort(struct i2c_adapter *control)
 	DRM_DEBUG_DRIVER("I2C_Abort() Done.");
 }
 
-
 static bool smu_v11_0_i2c_activity_done(struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -416,7 +456,6 @@ static bool smu_v11_0_i2c_activity_done(struct i2c_adapter *control)
 	reg_ic_enable_status = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_ENABLE_STATUS);
 	reg_ic_enable = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_ENABLE);
 
-
 	if ((REG_GET_FIELD(reg_ic_enable, CKSVII2C_IC_ENABLE, ENABLE) == 0) &&
 	    (REG_GET_FIELD(reg_ic_enable_status, CKSVII2C_IC_ENABLE_STATUS, IC_EN) == 1)) {
 		/*
@@ -446,6 +485,8 @@ static bool smu_v11_0_i2c_activity_done(struct i2c_adapter *control)
 
 static void smu_v11_0_i2c_init(struct i2c_adapter *control)
 {
+	int res;
+
 	/* Disable clock gating */
 	smu_v11_0_i2c_set_clock_gating(control, false);
 
@@ -453,7 +494,9 @@ static void smu_v11_0_i2c_init(struct i2c_adapter *control)
 		DRM_WARN("I2C busy !");
 
 	/* Disable I2C */
-	smu_v11_0_i2c_enable(control, false);
+	res = smu_v11_0_i2c_enable(control, false);
+	if (res != I2C_OK)
+		smu_v11_0_i2c_abort(control);
 
 	/* Configure I2C to operate as master and in standard mode */
 	smu_v11_0_i2c_configure(control);
@@ -466,21 +509,22 @@ static void smu_v11_0_i2c_init(struct i2c_adapter *control)
 static void smu_v11_0_i2c_fini(struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
-	uint32_t reg_ic_enable_status, reg_ic_enable;
+	u32 status, enable, en_stat;
+	int res;
 
-	smu_v11_0_i2c_enable(control, false);
+	res = smu_v11_0_i2c_enable(control, false);
+	if (res != I2C_OK) {
+		status  = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_STATUS);
+		enable  = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_ENABLE);
+		en_stat = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_ENABLE_STATUS);
 
-	/* Double check if disabled, else force abort */
-	reg_ic_enable_status = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_ENABLE_STATUS);
-	reg_ic_enable = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_ENABLE);
-
-	if ((REG_GET_FIELD(reg_ic_enable, CKSVII2C_IC_ENABLE, ENABLE) == 0) &&
-	    (REG_GET_FIELD(reg_ic_enable_status,
-			   CKSVII2C_IC_ENABLE_STATUS, IC_EN) == 1)) {
-		/*
-		 * Nobody is using I2C engine, but engine remains active because
-		 * someone missed to send STOP
+		/* Nobody is using the I2C engine, yet it remains
+		 * active, possibly because someone missed to send
+		 * STOP.
 		 */
+		DRM_DEBUG_DRIVER("Aborting from fini: status:0x%08x "
+				 "enable:0x%08x enable_stat:0x%08x",
+				 status, enable, en_stat);
 		smu_v11_0_i2c_abort(control);
 	}
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
