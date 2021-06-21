Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A6AC4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A116102A
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A116102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9806D6E2BC;
	Mon, 21 Jun 2021 17:13:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D42376E270
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWU9cQgtql99pYOka2+W3YyXTIMUo0f4fq1Y+hVCBxL3kPFZBmoRlqyTpyj3jYQjf9zSn8xWKGLmws++IrtfV8r2QxiDvY3UKrLXZc4tHg1QiOwXgPzRtAroJLw3KPKD4OuKf6VTDvJCyIZeA++FvgWTS/KRegYg6HrPotzUw3YbT2yjVBMGHOdu9zzrxFKj0raTh8XlhirKlWLBeZn8WeDOp27+hrfKcif2O9Apkp1zja0KXqlEvEYmdvnBv0lRj0wpSL+URip62JIC6Hi2cJeOg5JlPC0zMaY9weH8Vs/vanitkVGNHBGDfH5DTtUt2m3ixTWxncAIoX+hokMVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flB+eerWLqEvet0b6gwuywejJV8yGcduNDiqLYfHdiY=;
 b=mhwYe6KGK3WIOUc+ZxPoZBnimXUgwSmvt093JEcZ2q7g5XW9rw+1yqqvtIDDzfEYCLPGygai9XDEt1HdMDMap+HRjFMrqWHEkXPJYK/e69j675b3EnszQW481j5WhssKbONeJtBlYnG/TPsobxhOz+v8aldFyjfU+c/xyVcJuggQz6UM7i0wMd8cACgQ8R02QLHPD55VkGoSappkoSHl19hYV0pB1nUJVcRIH3QaLdfcw6FqfTxGp0afi5BTQO0fgjRQlc1ztljnCqvkGb4fQ8wVE0YFRV0mbJ/3gONllniHchQamFu3IVKwVuJleAPqPG1D8rKx0anVGxnAUG9Uzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flB+eerWLqEvet0b6gwuywejJV8yGcduNDiqLYfHdiY=;
 b=tCqedueXM3gg2u3jLVlhi8vyD6d7JxxWkagMGD8jeWsZeDwXQBcetYs859WqmehpoQ0Mk0KJEVaNPagmJnhFO8eobvApN2PcAgqRR4I+qPWl91t4owVOxAKaCwtS8P7PNO+wvZf2l/abrjcW4P99VTCE2CU0r81sLgvDELQdr/Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 17:13:40 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:13:40 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 43/43] drm/amdgpu: Correctly disable the I2C IP block
Date: Mon, 21 Jun 2021 13:12:21 -0400
Message-Id: <20210621171221.5720-44-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:13:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3683595-bd78-4834-5b0d-08d934d7d776
X-MS-TrafficTypeDiagnostic: DM6PR12MB2985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29857E26DE49CFFF959B4C94990A9@DM6PR12MB2985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLRD1hhjVNFoZIzmUE0rUhEzQmIj35diP3b/RMu31hWW/xlY9pb/hfWY0yc33rJ8Qg8X3R+zCi8TdfDZFyglRllrpVHRW/0icvBB/2Xf+kP5Tk9UXZEav9fwtDjL+xwaBM30tA/pWEzgvyi1/hnXIgCQD2Ca0nB82C1GryAsHkZpYzQgfN+RZshqIs2fok0SWq2SxJdCjNf5oPW7HnAXlgWxkPmuCuC/z/oNDrpD/rUtmsve/BxoSeCsNm9PcF9RgPRvJ1xtw1PyUQmgnDPNyWBS/PA9QWclww0LSEjlVuG6SsAzBPjpmYgeGmlj7OkXuTTG63PYc3UKjWybrMuz5OtNejd/XOVesowGWjZNTXNDepOePAk8y3qEyJYUgP/vDIhw6gu8OUuUcQ+ul/vX+EC1RkFRvUGUIt5RjtlQmAv9dlY0lAH0fgJ8XVST9x82VzS+DlAHYNRWJwWl2oE1V60PCKRGwGMrYj7XPZI27CrlEedcXrST6ldqHqYD0Msa+9mVxtTdQGDpwLu16xni9k1RI4ziWZbdUGbujrCscAlBlL/C5ccJi1J/j/HhHJNS6Jr8sEM3wt1GG2eOaeVyG0Brd+uLdlQ2Joe9L7iwR6Oe2aOPjiHWFKNF+X0/HKLOaoGBKOAPixOKl7kyuWcIdIYEZZz26faYvk3J0sKo8RUAJ8dTYcoPaI2/474M/jVZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(6666004)(55236004)(8676002)(316002)(6506007)(6486002)(54906003)(44832011)(8936002)(478600001)(66476007)(66946007)(956004)(2616005)(6512007)(66556008)(2906002)(52116002)(36756003)(38100700002)(38350700002)(86362001)(5660300002)(186003)(4326008)(1076003)(83380400001)(26005)(16526019)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tfeV/B+sBe2Mehl19iEN/wr2FtEJj+XQCd+7wRT6hcyf3skRRjAVxT4cR51P?=
 =?us-ascii?Q?IjfRUVPU21QgSIUW0Wn76+bI4u57XVhZr6H6HBD1xYml6Fl15se5QLKgtFvC?=
 =?us-ascii?Q?jJqBENF6RHEzEenPWSdAo4mZoLpbUH9G30WRmbbxFkPz1PUSvKxe+d32HHiP?=
 =?us-ascii?Q?hIj5Oh5mfNyavdwjDx6Njdrwb4Md59KWP49c4/4rCUSk6WFBFwtjv1Zft76/?=
 =?us-ascii?Q?W6O4R7e1+thDUA0Ji52FdZxSwvfwHjFtKOMF4y6ddbHuF+o2MxlDLyVQWKg1?=
 =?us-ascii?Q?SPU+G4S2bgc42+3/yZhPeZWHv46wRjbLF7Jf4eH803vVM5Tv5rlutRgbESeq?=
 =?us-ascii?Q?RGin/j0fcHR249M2Gjy274z1XqneEsqO+eGxiLpUbkRCU7UpR0QdQ87aUym7?=
 =?us-ascii?Q?H0Btyz35nrkOdWMxFXq4SVkD19NYPw/lAh8/tIp4WgNERLeRjAYTaXxhM4gi?=
 =?us-ascii?Q?2fz/8q4jrh2DxwTFVN2GZfQwoPMK3VP3ESglLQV+Iv49fDOOn5rNp/OykErw?=
 =?us-ascii?Q?kcqIm0OcwRoS7Xd4QwFyzwjB+VYXNWjbHlV+Q+pFfR/BvdelJzAurHDGfZ4X?=
 =?us-ascii?Q?2gGOTEOGQg/4CeOZjk3dDk+1B0UO1BwHs7WSJjhnAzU3rRPFyAB63UiHyZbO?=
 =?us-ascii?Q?wx41gM5G82coN5W7DBvXnNkV5WUsu41mSKkdsSw0tpmqktFqSST25C2vji5p?=
 =?us-ascii?Q?LbNEyHBcyzxusfRKU1i3Vvl+8drexhgTeuG7da/lLHqmKg6JSWA8SeOkudJq?=
 =?us-ascii?Q?QCuM0XOm4dcG++YjendQ9k1ZsmgDezVSKo0NaF8t0gI3k7L43iJejAJoOVZA?=
 =?us-ascii?Q?Yav6MRXPABJTeW6i5rDXxylo3PMDDG4qAFTnQPjobU4VDU+3Slea+g02sSIu?=
 =?us-ascii?Q?1k9oePIZNQkYMva40MW7bypp05biLpeX+pApgwyLVfb+oWsf5fzUU2E3YMLj?=
 =?us-ascii?Q?GZGnDJaS0sMqgiN8SGmQXWXJ1wnLHcdtSzbUnoFNXiXVhijLrf6QJ1ggBnB+?=
 =?us-ascii?Q?ssjZqILyWiRTCruhh9rRCWB3b0C+cNE62yS6SFPi1ZC37Ya7lsvc3w6fAGBJ?=
 =?us-ascii?Q?5+F87R9gaafg+VsyY/zOkxSUEVlssEujPZ3Qx+nKgVo7JRLnr6tOzlor7YzA?=
 =?us-ascii?Q?MHlCHD0rVN6E0DY203vivngO0J9pRwYuBgjpC6nBVuVe4H9AGZt5iD43+L73?=
 =?us-ascii?Q?ANMSTmk6uY/JknU4nIe/JY8xJueGAhvjAECyQ6fx4HIJRA7ZWFZsUjPWuJT3?=
 =?us-ascii?Q?pig3VihUs2VQG71avOWl9IG5sEOdia+5U2CnnGEgpg6xLPxXBfiUz5rjN+/E?=
 =?us-ascii?Q?Vj/eFW31tJyldUMw1ID4T3h+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3683595-bd78-4834-5b0d-08d934d7d776
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:13:08.8076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3s/MQf/GxhFkIaBBTgN25WWSWxlrcJvILxKk9kO/D27wx0yFN39wzm5jpTJS/00B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2985
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
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
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
