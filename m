Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC79C48BE5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8785960FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8785960FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4811D6E04B;
	Mon, 21 Jun 2021 17:12:40 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B740389FCE
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbQLaG9nKnn46wkIImqwxkX5qPyX22q9a8WZCFQwYJX37SMC0Zq2UhQohNPkgPb3MiSU7BptVKznee/VnMQ9oQuH19uTjzSRCpYggNhQ6p0z3c/hvfgC9erj+Sc8EUrcqfZhfI8lec/ZwYpM6/SZ3VYEsfHWHgrSV6rm47GE1i+rnmVbJv5kL/9yn4S1iAbF2WUpvMKw/YPONFdxeBeFuE923IR34/4vsRZjxKkgQklWDR4YFtBk+tLA5A/o2moOODVv9PBfF3QE66lPnltpoErJIIhpyj8Mr90SW8MvZnSwmx++3lFMQRCrF4J1lM3BMoUxfUxwy3Utv5ZnxVPD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDawO31SHvSmO/+9E3e818K1ynoVSMho2U81di1jNCU=;
 b=SCr3AH0BGvtZ7DzYhtPNcNhPIFwMGhQlqCqbOd1qjCRusJjgHHuD69EaGtovZ0PW8rQI7SB2TUZUq8ZKQzG2ck3f+qudZQ8igB2R4X0w+sVPkeVLcMj6/xzGSldIAAHOZfjEe3TzvrkcUfuoxTa/XqNdGr3NgKMS0GJDRz9kJf7PpsNkmXhrVf1zCI4qDT+I/OcQNFpKN73GCsjfJ1iER5jy5GIqjxjB2yH/PR/kes8haj8oEEuTEX29rTwDsyBbPgmLFotJwQd5q6iA8f2zhnaavAWXrKwFAsWj6Xg6q42MAOCKpua7y59FJ2zFSAnnJ61b6Srtpw6WVDNKeEF8YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDawO31SHvSmO/+9E3e818K1ynoVSMho2U81di1jNCU=;
 b=VSEoUv+LN/kLlMstM8pjfALXjcP4EvytZLy666Paw4RBpW4CsobYJ0I+lUbL7claxnTSbtQ59CgT+qBEOIDubDjFxkbqeNON8zq7mUtkFOIb/sHOqJFDCE/0PeFGFyfvxQFwbOCrXuYCCfwOElYexDMHrO2qhznouTjOOSQmIcs=
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
Subject: [PATCH 03/43] drm/amdgpu/pm: rework i2c xfers on arcturus (v4)
Date: Mon, 21 Jun 2021 13:11:41 -0400
Message-Id: <20210621171221.5720-4-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f5dcdec-2652-4139-73b3-08d934d7c468
X-MS-TrafficTypeDiagnostic: DM5PR12MB1258:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1258CB9DD06F9DFD77043184990A9@DM5PR12MB1258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAjX9+feMaJLS1rLe4q5KgubxIbOX33qxl+yl8Sl2P0ay0243kTmhp9UdMp/XV3ryQ8CVVtdMeD2ILpgpPQmQiXVvs+hN4vZvOh7J5NkP/awGB4RJDC5HKnFMQ0iA127nXPhnjA17xdiYzmQ7Nvk+zJd0fpPwnr386k1HNmwhvhPEDPYp1p9VZgLGWeG155KT6dmRsVEndXuekxocaXMe7kP91ace5RWFH2JzdQog3ur7iPc0wh5wb93k6+g3KiaylVyWUiR3cD592fgpy0ZyCIYBm/U0RMNSkfRAaWjDmXWMKgOZHafdx1C6jsDrz7HWi9Em3Tde7PyR0OIEIzSuAM3J7gNHzAo/gVYE/G35sd2YbMztdGJcJeqbUZjbHBGEcMxV0CBaTtplgSwbl8HK5bpmBc8JJjdoPxcQbiE+CP6gjwdtebaLnbICVw+Eyga6e5KiGhlhhMsnKbL+5NR+WD7ghMUxq2k+CWoKdn6ignSn5mo/ifYw4Co9cvMdw+a+Gth6cgE3GtLMFRLsT3mIKNQJHkpEgxtPYSp40rK/XMn/zUlMgITuaDmkiuYohln0Aoe8vRN8YeAwSMqm71Dkwv2WuwZHniTYr6m1synJsPkmdIWedZVVVT2mlwcAWxsXOq5Ah+fXJlZYZDWjkEojgDxyyVCO5RELMJg8B4Y/4dCWzgEneHIxLtmr9efcVXt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(2616005)(55236004)(956004)(478600001)(8676002)(8936002)(54906003)(44832011)(6506007)(38350700002)(38100700002)(36756003)(83380400001)(2906002)(6916009)(6486002)(52116002)(6666004)(86362001)(316002)(5660300002)(186003)(66476007)(66556008)(6512007)(4326008)(16526019)(66946007)(26005)(1076003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0i8pVN5fTWZQHxpyRlfRzvzXBoQFWg+iI0GOkRH9bjY65+6FKRSyb5trx995?=
 =?us-ascii?Q?RG+CNNuO8aehM1dJWFhgI/ISvNzX3bhE/0RalowX4vVkLOFr8JM3yir7Rh2N?=
 =?us-ascii?Q?4JaiEXG6qGrtDapD1mRxi0v6qIQ32CP11auzmzM3Ulz2+axaYm/rCRHlOktZ?=
 =?us-ascii?Q?6DuqTdCz+f3NkN7URSvWhM3khZuvW8CW+kU6S9ejIZSJCEyN5+Eu305bw2VA?=
 =?us-ascii?Q?WD2hg92fPuZ9EDVaF5hSu8gM4QaVpk9s7iQrjtBRwL7AOSyzfoLmdJjXEOlZ?=
 =?us-ascii?Q?u9vmkbMi0Iwk337dEGSfwi38bX2Ysa+c+MQLo3Stfce+T+qR18mwcuB6l+k9?=
 =?us-ascii?Q?eYOm1lkPmESs6cfpucOy+/bayBYSq7nJGpKX/8BkTI/xWrPPffH/92vo3nUs?=
 =?us-ascii?Q?iqY1/JDTn9GFY3w4vnKMYO2WewtXWfmENqdgyN/t1Y4v3oqqyi4RB/6jL+lZ?=
 =?us-ascii?Q?2vWFhJSeaL+UOjzMB5FNRbLCZEcO8xS6m1BorgD8tC20jaQ+Sdx6VoOGS0Ji?=
 =?us-ascii?Q?dumPw6LoBoAqTdSpfWSYr8V7B8lukgpZr3aP4mpBmn6XuJHserQ99Wj8Wznw?=
 =?us-ascii?Q?iYNWX8C4kOwvTvIaBJfA902YpEjQPj0u9n1LK0VRZyduD4W0ygja6bbH6jKH?=
 =?us-ascii?Q?ak0UBic9boYl8hOFLgQOEG16dJ68/E5Kg+J1LmE0bUv6105GaBf2xYueAdJm?=
 =?us-ascii?Q?9yRoRQ6Bba7Eir0SSIsqNGWu4RPppFzcSxI8gociQZxhSX94f6eMdkfDZIz1?=
 =?us-ascii?Q?S3HSdQEcJvc/vsrKM6hyfWepXojZ9MPNa4jDPHh+3eP9L/YUG1qNQN6lULDk?=
 =?us-ascii?Q?ngZkECGY3i7jpJSMH+8qkULCAdeRH/ol96sNThpYYntmHtuOfEI7UP3TXQ88?=
 =?us-ascii?Q?WYJwzW+MLEaFQzU6Lbnrz1kkyA5LPdhmMmFYY+hQeBAefPvTXcYy47/+AEeB?=
 =?us-ascii?Q?5rZ01THC25m7PEmJEitKzikmKKPHywWiLBFPAW20ruxMAF1TRB2T9lZYZsDA?=
 =?us-ascii?Q?kKOhg4oVu0Grq1dQhUs2vfC83jn1eTgIiyUzKrxHENoNaVfXDlKvSkcwKyNM?=
 =?us-ascii?Q?GYyPS9GUIK7dLpdnRtRIjj2A37iu7gwMXEunY1ZrPJeEuCMznz7iwqUrz826?=
 =?us-ascii?Q?gx+wMUcWPli/Lc1VpvwuZUjlYXqifUD3JiwWVaovMALYlX13C9ONFy8BG6Jq?=
 =?us-ascii?Q?bc+gf2xF9gjAK0TsPPsx5LlpgTJVicfSlsn+ngvrSqAxDrSAZ930PsRP+iTX?=
 =?us-ascii?Q?pTiUFMW9h1SyoDZPS6D2Ov/jLloEYGp86JDYuXMVdShtJSQ+CP2xXNiqsFXF?=
 =?us-ascii?Q?W5nyQzfnBNFj+zsFpxEybzOa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5dcdec-2652-4139-73b3-08d934d7c468
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:36.8777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFvSdnvFXx0/8AF2h3P2pS4lL2VvV9SFlLsHE4UivlDm3UFLTv8sGy1zU3f5/O+7
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

Make it generic so we can support more than just EEPROMs.

v2: fix restart handling between transactions.
v3: handle 7 to 8 bit addr conversion
v4: Fix &req --> req. (Luben T)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 229 +++++-------------
 1 file changed, 58 insertions(+), 171 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 094df6f87cfc41..a6447822deb09f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1936,197 +1936,84 @@ static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 	return ret;
 }
 
-static void arcturus_fill_i2c_req(SwI2cRequest_t  *req, bool write,
-				  uint8_t address, uint32_t numbytes,
-				  uint8_t *data)
-{
-	int i;
-
-	req->I2CcontrollerPort = 0;
-	req->I2CSpeed = 2;
-	req->SlaveAddress = address;
-	req->NumCmds = numbytes;
-
-	for (i = 0; i < numbytes; i++) {
-		SwI2cCmd_t *cmd =  &req->SwI2cCmds[i];
-
-		/* First 2 bytes are always write for lower 2b EEPROM address */
-		if (i < 2)
-			cmd->Cmd = 1;
-		else
-			cmd->Cmd = write;
-
-
-		/* Add RESTART for read  after address filled */
-		cmd->CmdConfig |= (i == 2 && !write) ? CMDCONFIG_RESTART_MASK : 0;
-
-		/* Add STOP in the end */
-		cmd->CmdConfig |= (i == (numbytes - 1)) ? CMDCONFIG_STOP_MASK : 0;
-
-		/* Fill with data regardless if read or write to simplify code */
-		cmd->RegisterAddr = data[i];
-	}
-}
-
-static int arcturus_i2c_read_data(struct i2c_adapter *control,
-					       uint8_t address,
-					       uint8_t *data,
-					       uint32_t numbytes)
+static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
+			     struct i2c_msg *msgs, int num)
 {
-	uint32_t  i, ret = 0;
-	SwI2cRequest_t req;
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
 	struct smu_table_context *smu_table = &adev->smu.smu_table;
 	struct smu_table *table = &smu_table->driver_table;
-
-	if (numbytes > MAX_SW_I2C_COMMANDS) {
-		dev_err(adev->dev, "numbytes requested %d is over max allowed %d\n",
-			numbytes, MAX_SW_I2C_COMMANDS);
-		return -EINVAL;
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
 	}
 
-	memset(&req, 0, sizeof(req));
-	arcturus_fill_i2c_req(&req, false, address, numbytes, data);
-
-	mutex_lock(&adev->smu.mutex);
-	/* Now read data starting with that address */
-	ret = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req,
-					true);
-	mutex_unlock(&adev->smu.mutex);
-
-	if (!ret) {
-		SwI2cRequest_t *res = (SwI2cRequest_t *)table->cpu_addr;
-
-		/* Assume SMU  fills res.SwI2cCmds[i].Data with read bytes */
-		for (i = 0; i < numbytes; i++)
-			data[i] = res->SwI2cCmds[i].Data;
-
-		dev_dbg(adev->dev, "arcturus_i2c_read_data, address = %x, bytes = %d, data :",
-				  (uint16_t)address, numbytes);
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
 
-		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_NONE,
-			       8, 1, data, numbytes, false);
-	} else
-		dev_err(adev->dev, "arcturus_i2c_read_data - error occurred :%x", ret);
+	req->I2CcontrollerPort = 1;
+	req->I2CSpeed = I2C_SPEED_FAST_400K;
+	req->SlaveAddress = slave << 1; /* 8 bit addresses */
+	req->NumCmds = bytes_to_transfer;
 
-	return ret;
-}
+	remaining_bytes = bytes_to_transfer;
+	c = 0;
+	for (i = 0; i < num; i++) {
+		struct i2c_msg *msg = &msgs[i];
 
-static int arcturus_i2c_write_data(struct i2c_adapter *control,
-						uint8_t address,
-						uint8_t *data,
-						uint32_t numbytes)
-{
-	uint32_t ret;
-	SwI2cRequest_t req;
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+		msg_bytes = min(msg->len, remaining_bytes);
+		for (j = 0; j < msg_bytes; j++) {
+			SwI2cCmd_t *cmd = &req->SwI2cCmds[c++];
 
-	if (numbytes > MAX_SW_I2C_COMMANDS) {
-		dev_err(adev->dev, "numbytes requested %d is over max allowed %d\n",
-			numbytes, MAX_SW_I2C_COMMANDS);
-		return -EINVAL;
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
 	}
-
-	memset(&req, 0, sizeof(req));
-	arcturus_fill_i2c_req(&req, true, address, numbytes, data);
-
 	mutex_lock(&adev->smu.mutex);
-	ret = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
+	r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
 	mutex_unlock(&adev->smu.mutex);
+	if (r)
+		goto fail;
 
-	if (!ret) {
-		dev_dbg(adev->dev, "arcturus_i2c_write(), address = %x, bytes = %d , data: ",
-					 (uint16_t)address, numbytes);
-
-		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_NONE,
-			       8, 1, data, numbytes, false);
-		/*
-		 * According to EEPROM spec there is a MAX of 10 ms required for
-		 * EEPROM to flush internal RX buffer after STOP was issued at the
-		 * end of write transaction. During this time the EEPROM will not be
-		 * responsive to any more commands - so wait a bit more.
-		 */
-		msleep(10);
-
-	} else
-		dev_err(adev->dev, "arcturus_i2c_write- error occurred :%x", ret);
-
-	return ret;
-}
-
-static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
-			      struct i2c_msg *msgs, int num)
-{
-	uint32_t  i, j, ret, data_size, data_chunk_size, next_eeprom_addr = 0;
-	uint8_t *data_ptr, data_chunk[MAX_SW_I2C_COMMANDS] = { 0 };
-
+	remaining_bytes = bytes_to_transfer;
+	c = 0;
 	for (i = 0; i < num; i++) {
-		/*
-		 * SMU interface allows at most MAX_SW_I2C_COMMANDS bytes of data at
-		 * once and hence the data needs to be spliced into chunks and sent each
-		 * chunk separately
-		 */
-		data_size = msgs[i].len - 2;
-		data_chunk_size = MAX_SW_I2C_COMMANDS - 2;
-		next_eeprom_addr = (msgs[i].buf[0] << 8 & 0xff00) | (msgs[i].buf[1] & 0xff);
-		data_ptr = msgs[i].buf + 2;
-
-		for (j = 0; j < data_size / data_chunk_size; j++) {
-			/* Insert the EEPROM dest addess, bits 0-15 */
-			data_chunk[0] = ((next_eeprom_addr >> 8) & 0xff);
-			data_chunk[1] = (next_eeprom_addr & 0xff);
+		struct i2c_msg *msg = &msgs[i];
 
-			if (msgs[i].flags & I2C_M_RD) {
-				ret = arcturus_i2c_read_data(i2c_adap,
-							     (uint8_t)msgs[i].addr,
-							     data_chunk, MAX_SW_I2C_COMMANDS);
+		msg_bytes = min(msg->len, remaining_bytes);
+		for (j = 0; j < msg_bytes; j++) {
+			SwI2cCmd_t *cmd = &res->SwI2cCmds[c++];
 
-				memcpy(data_ptr, data_chunk + 2, data_chunk_size);
-			} else {
-
-				memcpy(data_chunk + 2, data_ptr, data_chunk_size);
-
-				ret = arcturus_i2c_write_data(i2c_adap,
-							      (uint8_t)msgs[i].addr,
-							      data_chunk, MAX_SW_I2C_COMMANDS);
-			}
-
-			if (ret) {
-				num = -EIO;
-				goto fail;
-			}
-
-			next_eeprom_addr += data_chunk_size;
-			data_ptr += data_chunk_size;
-		}
-
-		if (data_size % data_chunk_size) {
-			data_chunk[0] = ((next_eeprom_addr >> 8) & 0xff);
-			data_chunk[1] = (next_eeprom_addr & 0xff);
-
-			if (msgs[i].flags & I2C_M_RD) {
-				ret = arcturus_i2c_read_data(i2c_adap,
-							     (uint8_t)msgs[i].addr,
-							     data_chunk, (data_size % data_chunk_size) + 2);
-
-				memcpy(data_ptr, data_chunk + 2, data_size % data_chunk_size);
-			} else {
-				memcpy(data_chunk + 2, data_ptr, data_size % data_chunk_size);
-
-				ret = arcturus_i2c_write_data(i2c_adap,
-							      (uint8_t)msgs[i].addr,
-							      data_chunk, (data_size % data_chunk_size) + 2);
-			}
-
-			if (ret) {
-				num = -EIO;
-				goto fail;
-			}
+			remaining_bytes--;
+			if (msg[i].flags & I2C_M_RD)
+				msg->buf[j] = cmd->Data;
 		}
 	}
+	r = bytes_to_transfer;
 
 fail:
-	return num;
+	kfree(req);
+
+	return r;
 }
 
 static u32 arcturus_i2c_func(struct i2c_adapter *adap)
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
