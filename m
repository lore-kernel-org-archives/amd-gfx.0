Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72B3C47094
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B6860FDA
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B6860FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D9026E0FF;
	Mon, 14 Jun 2021 17:46:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44F946E0F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:46:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5tQnzkSU0VTxPmgnR7HaLHxYUFEOeQZCm54bAlKFcdJFUn+nFMV54y1r4iHik6iXfl87tKa+bbq8yjwvQPI/7IFdUWmDO4wCgKosx1FvN5VJKDi2LSRtRxloZb80rlsAg2Us9RyVqG8RJ3PU5mkuilGd+TpXIltZipxVas5W4jywfXLuKvzLWUDI09ZBVz8TC5R2KjL7DaE8PVjPxaO6EWVcweoeLxg+0neYK6QROrc8KfLZbPDTARtl2Iwb03KnJQr0NvIKnG/5f/69SdBqEeyjr46oNygRo1RYs2U5rN4Ekx3mNP0LsoO9aILxFwNrGo7xqubWfWcnNMIpAJ6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LICU2zenGgiNh38gp69IBappllFJUhPAL4WT/9ifayE=;
 b=bXOpuGHcAhv+uNTjd4xHdzkpeolt24B2s2Ppy7ilyb0SXHJSSqqdOyPIZqwu6ydVHLxRpIWtzJgoa6c1WmLWctw3PejZ4d3hA/5gs0hPFmKNuJOlB2+4CiROO8LtV6fJiMvP2phHhGG5YMRrrfsEKSDrrFlvkqmpLk+lX76xuLY8GPknlAgWnbot6tkWholxilQDkXumYg+DD/qJSFE+r8T5gSQvw6jOGPpaxRynXSlRteVmIRAKyK3o01usVBhbflYOCOVmQJyxh4p+rNr9VuG1HUrJkdwd14pjUeKKMGuQ5vi9V+8ctaFSHx5/+P2a1zRdXVojukkcHspbMkr8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LICU2zenGgiNh38gp69IBappllFJUhPAL4WT/9ifayE=;
 b=B9tNplG54l5vxZPvrqJJebDBHbNvfyQmu+f3kJTM4jB9uPKghd8sSKPRnz5jColdpw4FLBQgFh54+xaOkn/Hp7N7n/92MXYvXHiq0ZZrCnu6eaZylh/Mbrt9IXL7Nm8M0vLWxCDBrlu/iJKdKS0W5u+KiFbmKxMQth9SbuaPLRg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:46:51 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:46:51 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/40] drm/amdgpu/pm: add smu i2c implementation for navi1x
 (v4)
Date: Mon, 14 Jun 2021 13:45:56 -0400
Message-Id: <20210614174632.20818-5-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:46:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fcca148-807f-4a34-ac64-08d92f5c6389
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4748ABD77255DC4CC3528ECC99319@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 08OICBmdJ7uWYnMHxSz/LRdw4S5kpwLEgvEGrcX3a1/ElgYH8sqdv+WBZ6SNa1iubtFXvyZujHxS5rd3yK7YIQExyzVjEqUUmFg7rQ7ne2pT37gKFKKPQnDayxneNy1n/1i4Y6AqK+f9Hanhl64iixDk9ZvtQBROr7yON67dHI1/tF2IgeQSsUcCRs0nmOywApm4Sl3DR6teJhlcQ8doVwwCfIC+kaBLW8pkHnSOQoziZMmqSglXA2TaC7tAFO40xISEwVowfT3HmspsUb8N1HTYq8QSVcjjZSNtt/U6Fg0ggeicjVa0H4vvMG3eqth6+cI895zsNqmMkgQRNwthHluSZb6Li1tFeYOtGxCYmJCTOfCwz5XYxZriLrFXjIU89UjtU8sr1eqKZ5zLwJxyc9elXT/0MVbdqLG5qFhEu+VQkI2E7dCN0DmUpXkRw2s8/82SpvRTLXMxZd4jdW5J54hnDSdMExLlZFFWbxNrIwcDiPWUtK2okSR0pkAy8761VyoVPz1hSGHC9hu8vuHKgFl4ShZQY5lqiQE0SGPbzQ8WAdEeyTG5jf4kzIaUEk2lBVHHedTlPz+/CyvS13myjEJkHU1BOT4GZYQCRdlbPyNrwSUj56JjFqA9LhTwemIsUuSzg1/JiBpUsODTKdqCRHJz4etl/drucPinBS1/0wajo4r7CUJKPg5rANIlO7Kj70S+uBbTHiTOHnuEJIpuNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(1076003)(26005)(6512007)(16526019)(186003)(4326008)(38100700002)(8676002)(54906003)(2616005)(956004)(2906002)(8936002)(66946007)(6916009)(38350700002)(478600001)(83380400001)(6506007)(5660300002)(52116002)(44832011)(86362001)(55236004)(6486002)(66476007)(66556008)(36756003)(69590400013)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LIwPZrntLHSPy598NdRCQHs0t23eyLkNHtmgMlAWxVJs1/ySb8qEbfkWwW2J?=
 =?us-ascii?Q?fYZEEeV9O/ukReeFLeC5Y5q5S7wRjpkl5fbjk8NXVOTHbM6JqMKiRpf/l44a?=
 =?us-ascii?Q?7z8rSxfCswaJL0+jbAG7Zf954MJ6VZ+/cqmBr74IowqxW7uj2Ts8do58pBl/?=
 =?us-ascii?Q?o7euoRU8xOrSTCk+bvk05ULQSDBSwmQOHrCHaEqRDP37ikO0inUQCL703BP/?=
 =?us-ascii?Q?4l6XP7lq0dDThSYUuD6DwvxSceIu5pcoTO5H0Y5BwjpdIoVM3lsNRrYd3JWL?=
 =?us-ascii?Q?IrhB8Z98mI/0jj7vo3wimnn5xFVrSJiarB6uNtWv+mTDKiSGhzFyHidgfMq1?=
 =?us-ascii?Q?JLe0i2wOoTgbXWhw/oorZUUo2polvXARvbMDEVyjeuLSN6mw6hJ0FGW2zjJn?=
 =?us-ascii?Q?TwO8bHWN/BSzl2YYb81abxH/VNk9wfDYx98qVQdAiCMVgry3z2MI/KR76Pto?=
 =?us-ascii?Q?wbS/M/kAr49jDgsfSMz7qE7MHrXDgy8U9iF+qpC/1zcbapT+a/6u5ZgYQB+F?=
 =?us-ascii?Q?tzudlAOwiJbFL2DgZdhxiR4a7MbjCtGpFLrBhXFiuWJZgTAkvIGj79XSXZX4?=
 =?us-ascii?Q?Q+TDJUIXg7/jKRuIL+jQejsdypDRSyCCjhF5ZGKmYikCh0nfgoGFGDATjkZc?=
 =?us-ascii?Q?Sv0e0WLfHWUEU5nJL3mfEHGFpKHDVdUv+OaiznqT/OL1zvJVvDjtvJZ3ei1Z?=
 =?us-ascii?Q?6M4Yr1CXK3AlUI9KVdlj7s4R9Zb1oPertaYxZEXRLKfczcSwTscN/l3hCSNf?=
 =?us-ascii?Q?mXOyj1xCvBVyKgXcY+SDYnu7ZN+eEV1cfbf8/WG1CFYYW8belHF0b9/9YTGD?=
 =?us-ascii?Q?TefMVgM941B/K2T2S9cStd2nX5AAhgZyVwEbWP3ExKriRxr9SYoNV/R6xjKK?=
 =?us-ascii?Q?pBcGj/7pxjjOaYpcr5zDTYpheZvdHLLg3IOxhtHAJwnq7961S5z/PFJ9n1xn?=
 =?us-ascii?Q?6qUzEjfRAYpAcP1meZ/ekN1X6D0V0tE84UKcHq8l/6AcVFtf0MyfEP1kefyH?=
 =?us-ascii?Q?O0hHx7oWEvtZxd7ntpEPc3LJ4+rf1ZKmvxyQgbDQRkM8n5GLrv19cbcAdMkc?=
 =?us-ascii?Q?4xPOzwUN43Amj2QVFx0iOq3drXQS69L0bmwlX8sefd2Kc+pEU9mJI2DLq83w?=
 =?us-ascii?Q?gtfy0AEFCyCSyVA4IX+8LHFRj9f8deaMaJooSg9j5+OdIcoxMjyHkbRAm51L?=
 =?us-ascii?Q?btb/moGSJNAkw1BEdrMmRUrAkkxi9uMZPiFAqgkfr/h2h4DkSZXqvzCTEw/D?=
 =?us-ascii?Q?hL7+5kdbgwEFA3psJCWhrGwz6WB6q9FD59UIBxrn5w98nIiW5gSpbseMQ4F/?=
 =?us-ascii?Q?7gTU1ujsHgzmW4Wbih1NpLOq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcca148-807f-4a34-ac64-08d92f5c6389
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:46:50.4028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0d9cEUI/S8uzaKyWgv9162DTl0O34kzMO+uadvteFV71k0fvB3FA3YjJNH6EibQP
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
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

And handle more than just EEPROMs.

v2: fix restart handling between transactions.
v3: handle 7 to 8 bit addr conversion
v4: Fix &req --> req. (Luben T)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 0e67517682e319..f426f488c02561 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2735,6 +2735,120 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
+static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
+			   struct i2c_msg *msgs, int num)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
+	struct smu_table_context *smu_table = &adev->smu.smu_table;
+	struct smu_table *table = &smu_table->driver_table;
+	SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
+	u16 bytes_to_transfer, remaining_bytes, msg_bytes;
+	u16 available_bytes = MAX_SW_I2C_COMMANDS;
+	int i, j, r, c;
+	u8 slave;
+
+	/* only support a single slave addr per transaction */
+	slave = msgs[0].addr;
+	for (i = 0; i < num; i++) {
+		if (slave != msgs[i].addr)
+			return -EINVAL;
+		bytes_to_transfer += min(msgs[i].len, available_bytes);
+		available_bytes -= bytes_to_transfer;
+	}
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->I2CcontrollerPort = 1;
+	req->I2CSpeed = I2C_SPEED_FAST_400K;
+	req->SlaveAddress = slave << 1; /* 8 bit addresses */
+	req->NumCmds = bytes_to_transfer;
+
+	remaining_bytes = bytes_to_transfer;
+	c = 0;
+	for (i = 0; i < num; i++) {
+		struct i2c_msg *msg = &msgs[i];
+
+		msg_bytes = min(msg->len, remaining_bytes);
+		for (j = 0; j < msg_bytes; j++) {
+			SwI2cCmd_t *cmd = &req->SwI2cCmds[c++];
+
+			remaining_bytes--;
+			if (!(msg[i].flags & I2C_M_RD)) {
+				/* write */
+				cmd->CmdConfig |= I2C_CMD_WRITE;
+				cmd->RegisterAddr = msg->buf[j];
+			}
+			if ((msg[i].flags & I2C_M_STOP) ||
+			    (!remaining_bytes))
+				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
+			if ((i > 0) && !(msg[i].flags & I2C_M_NOSTART))
+				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
+		}
+	}
+	mutex_lock(&adev->smu.mutex);
+	r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
+	mutex_unlock(&adev->smu.mutex);
+	if (r)
+		goto fail;
+
+	remaining_bytes = bytes_to_transfer;
+	c = 0;
+	for (i = 0; i < num; i++) {
+		struct i2c_msg *msg = &msgs[i];
+
+		msg_bytes = min(msg->len, remaining_bytes);
+		for (j = 0; j < msg_bytes; j++) {
+			SwI2cCmd_t *cmd = &res->SwI2cCmds[c++];
+
+			remaining_bytes--;
+			if (msg[i].flags & I2C_M_RD)
+				msg->buf[j] = cmd->Data;
+		}
+	}
+	r = bytes_to_transfer;
+
+fail:
+	kfree(req);
+
+	return r;
+}
+
+static u32 navi10_i2c_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+
+static const struct i2c_algorithm navi10_i2c_algo = {
+	.master_xfer = navi10_i2c_xfer,
+	.functionality = navi10_i2c_func,
+};
+
+static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	int res;
+
+	control->owner = THIS_MODULE;
+	control->class = I2C_CLASS_SPD;
+	control->dev.parent = &adev->pdev->dev;
+	control->algo = &navi10_i2c_algo;
+	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
+
+	res = i2c_add_adapter(control);
+	if (res)
+		DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
+
+	return res;
+}
+
+static void navi10_i2c_control_fini(struct smu_context *smu, struct i2c_adapter *control)
+{
+	i2c_del_adapter(control);
+}
+
 static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
@@ -3078,6 +3192,8 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.set_default_dpm_table = navi10_set_default_dpm_table,
 	.dpm_set_vcn_enable = navi10_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = navi10_dpm_set_jpeg_enable,
+	.i2c_init = navi10_i2c_control_init,
+	.i2c_fini = navi10_i2c_control_fini,
 	.print_clk_levels = navi10_print_clk_levels,
 	.force_clk_levels = navi10_force_clk_levels,
 	.populate_umd_state_clk = navi10_populate_umd_state_clk,
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
