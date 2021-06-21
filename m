Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0743C48BC2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2F16054E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2F16054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAACC6E21D;
	Mon, 21 Jun 2021 17:12:44 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE6989BFD
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mw+BOL5Ca+BW7PCEhTtnDkzQ3agMRpJZ4e7ATpthJgnjRKnfnd+A/rjoqaKS8+HQOT3fy9MOUl4UzjMZl3mB6+RRiknoWaufn0pCAvSBiy7c0qkMzikITnKtKyAQi8y3BikwAXDxq/xNkuMgrzSyB0FC6KZsLO05TMpsU8XTb0yHESBHgRNurqDGeYxtb6gnzVFle/6TQiQsOmvam6hVmlZjuUTLfMK5AVACTAUcHcCVgea98G09FegwykvPbh+fur5eg0tCnIIAlxfSWy/DpVf1spN/HoE4EeIJV3rBmsKMTO9GQRsaslgdOsxDo7GBok3KcYcHH1/qGF04+3qprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dh1G7BJP6p0SOI+NU+122a0gQO04PTRjimFBRA4SR0s=;
 b=mYpmQojhhS3O5XXiZ3jT7N+UGFID9DToNQ283wp6Gr4xNMUjIO8pApZKTJl2zU6vbQWpKCYrl78ZscQgFhCv8beo6ZAC4nPIB+27mIO2o5bXRLcOGRYqcjlAWQZ6ne0pfWIE2sx+smulZQKsFVWo0GgnPJruuDAA2SBbtp5KiQFfBdGE+6JfFggb8aebOrV2whLYWGweRpwKA52LabcNQu/JxS1oVptImFdik0PN1XCWxVwSg9U8c2RNhPK7f1nH2cTZ7pfjVmXzo5u4/hYebOtLlArt0O3mAIOWccCmUQ1Dr861BhcqP4YCcTXl/UJxVHPHxX0boJYlYtYXz4mZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dh1G7BJP6p0SOI+NU+122a0gQO04PTRjimFBRA4SR0s=;
 b=F0+zpzu5ulV1n5CBSndgkw/73lV5coMR+ndoruSW5VISmJsuW76HTs9+Z5qzvLTD9rkPJ/ljMuhQzM6uxGHrnZfz793uPYz33w9Mzfg8Np6uYn7PMfkgd0l5DjZxVGIiY6/JTmI+R4E+nBL1DzhTBB3cg85VZPNnRv1AMUQkQUk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1258.namprd12.prod.outlook.com (2603:10b6:3:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 17:12:37 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:37 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/43] drm/amdgpu/pm: add smu i2c implementation for navi1x
 (v4)
Date: Mon, 21 Jun 2021 13:11:42 -0400
Message-Id: <20210621171221.5720-5-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a7db2f6-abec-44cc-41f8-08d934d7c4c4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1258:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1258CC3FC0C7D1BEC74F9B0A990A9@DM5PR12MB1258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 69NNBAndfhRfUL/mc9/kI/eKShFTPhkXKNhB2BuucJubGaOGC2yMJqI/2oavMaOeQlOqZ1rneV/udymY6CeAyAyTYNZg53ruMvGikDFT5pWNlFOteuDeetlk5DrnrdiQNpP6cavusYE/iM1+9jb1Ha7CTJMq9QcSFOot22/5NYI+LZ3NHj5G+FZKur5SS8AUy6QNlyC5l1Qwwhkb4AYXhk0p1j68/heQpSJgTYFWXy6Mu7fEgtXFvuCB7nBGF+MucIrkToWZLolTGkbjwcIjBQ9X2XTTlirsPxoFR0IXsQbMi5/Hy9Y+O+tVyn/kLckexyx7DiNJAxQqZSrA6Atl2HiwxuLu8AIztTvPfg1k88uhOHhXxv0nDBkL6Ke5EAONaPetJx5NTUKuKQ0JoTAAAGk5WzeHiN99RRPeRo44MzUjYYAnlmYuj3jNfqpCNTS7mjyKOVw++gKIsu4mz4POVROTv2eld9WnEHdtCbqBlsNtg8g9zAzYzwD1Gxauw0hNrGJ7o4stCItn0B3Je6oC++NhnAlr2DCidYrOL9osBoddqmTVeBQ9CGUQikrCpnmTSuMPVS3sAceCmt7cWrj1HsOsiKlBfDdeqZoUTUd7wrp18xD6H0gnLi0vJ/wJYZpCKtSsy1EIdQBcixUjNqspbWgKtrkqgqMrwVvMJXpf77LaPMNDnEowNgGpIm5qgkVQiGBHOc9+kS2e6btETAMaJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(2616005)(55236004)(956004)(478600001)(8676002)(8936002)(54906003)(44832011)(6506007)(38350700002)(38100700002)(36756003)(83380400001)(2906002)(6916009)(6486002)(52116002)(6666004)(86362001)(316002)(5660300002)(186003)(66476007)(66556008)(6512007)(4326008)(16526019)(66946007)(26005)(1076003)(69590400013)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4c6a2BhwUedOeUYzTU/W1dNNZLmOwFueZ1T0RaY4ctm8vhArUS82An3nvuvt?=
 =?us-ascii?Q?yYDiEGsspMPyfNsMK4sU6lO96UoNJ8DudQ8Uf6hP2+wwJMzolImMqYfDw6Wo?=
 =?us-ascii?Q?UzK2dZyc+EvIcAQTlNdRMbFglfS2KCnWCdC92P7VZYMiVV3C7QcZZJrON0FB?=
 =?us-ascii?Q?CDQZeabBfWFWlKwmWrFbF1RXoUa1kzcleVtbFjNZEUhvxLSVYBMIYWyQGqav?=
 =?us-ascii?Q?td+g/mzK/hO8hTmq4H6yxCihail+LfYC6FIHMC+vBnIBLWHMMG/XDLIXWRCY?=
 =?us-ascii?Q?TsEcXcfuIFX2rT5CatPDS5lBihAr7PHOyzI4j3V/1wcotjFC1R2znAjfZdIR?=
 =?us-ascii?Q?nOyrEaFfB2NLBArFZbt0HW6DovhCTuKkyUeNLKtCcblWbbSXv8BV3v1gJ8dY?=
 =?us-ascii?Q?7feHi/7aWBBwCjnGdQ3D49Lf2hTn3YYeEHkUCWrwHqNTbJTMjfkVfi6FIu1+?=
 =?us-ascii?Q?W1Bj1CJypRXMEbI7GdyQZmA+k2FGozQH+QTgywBPKO+lbl5du1DFTxD6vb3F?=
 =?us-ascii?Q?7Axv9yXrhz6SBkMnAQ7Yu6rCEmWvZqTcQmmQnmpKt2Kw3QPMP8kTY2MzeZbC?=
 =?us-ascii?Q?TjcCdrOyQZtSfH/1NIok+iP6CTlTO0RFbjX+SMcV/n1x1Ek7bHeelUubnriv?=
 =?us-ascii?Q?JdjdAcLaPGUIij/WZ3pobcHIO5ahPaLbd/EsDsTAiWTboa6CWsEbFHGAlT6c?=
 =?us-ascii?Q?XwSF+wbGsJwhKHpnF5O3YfWOrYJ/C6e1zYZMconIM8+w9i2M/fFtPnnlCAYf?=
 =?us-ascii?Q?5eR7IQbBCtWiA3w4vjweyMmLgWipai8PSiINxp6yV/YyU0REt8ub48/ae94G?=
 =?us-ascii?Q?ffdd6yb9212nOdFPWo6/Io5mH7cwWZApDlAC5rgZn2bWkZAUednpJIlsdxOm?=
 =?us-ascii?Q?UwdGh527/UNzk2oqdDTYP/Tvmi9Dbts3k+3I19iQGYVngDR8wneEoloe8sqg?=
 =?us-ascii?Q?eStC9J6GNmLeWXwYn+HdjLrCtBtEeR/zlD2/0Qqna0LeLDsmSlHIPiPDp4X7?=
 =?us-ascii?Q?IBONYI92Cfw6Z3CKlVgqRQlhSGxkBA9Dq9aJN61OLJMFNRsmqkwQCD4Uhv8k?=
 =?us-ascii?Q?lYypK2+bvyC308ciiMV4DjSvizL0xiiWUiqrVpLoitd747AK7+WVu5gsZgj4?=
 =?us-ascii?Q?6LLoadMpw7Ski1jM56EUy+lCNOg/N/ltmJ4gIPHeNI43x1yIWQUhBoztJg2i?=
 =?us-ascii?Q?QYaptcaRrrVLePWKPwuK9pK3+PqibBw5DSKs6GbB1jGGYCUbVuP7jTYJX1Qm?=
 =?us-ascii?Q?BVB/9aiUIKd+dU5gnSCMfw95qfWWfeZeacjg5/ZwMZcKUnlN35DMKTYrub0z?=
 =?us-ascii?Q?wPkDD6W5jJsKsLYWphmNNXof?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7db2f6-abec-44cc-41f8-08d934d7c4c4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:37.6053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJtkNIf+w2hxtm04LXss1zMMHLxAWhYCBwI2kRYAt+ECEq/we7fAAmgOsNRXsiay
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1258
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
index 1ba42b69ce7424..e02db86ced6108 100644
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
