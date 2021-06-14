Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B494C2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20DD460E09
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DD460E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5D4C6E0FB;
	Mon, 14 Jun 2021 17:46:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5DA56E0EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDKb2Ezfajdo8RFzKaUUhnlMy3Ca4gTJi/3pMBQCObywXKpQoSafLn/x1+JFPrZdza9msQQGipOjukE/pATdTljsEdVke+PJtvSKTEEiOgVg2t1PutefImX9V3QOgO68s2NXm1KiJP/Z7omJY/C4yWudEYBdfXGE1b78nATPpTpgGBhI0Ovv4lFRYrlzTNYln/z7Xr+wgJQX9m+DFmeoAS+qw2tXhVWZVoO1y1WwVGsyPpBe2ZQiMasCve60JD+oO+4kJlpUnajlFOgSR3qHmpQRY+6NnsLfKdMtrjzsqQ78HnfM/ZbNJosvkCmYN1hRnOk0HbQBVlpUt9unr8Htmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDawO31SHvSmO/+9E3e818K1ynoVSMho2U81di1jNCU=;
 b=IJRUQ3E9JsN//lVF/IhtEcj69f1PY0ry4939uRO4wGN+v2eDoxtWofaXYGLaxtQQiLFiyEOAYEc4Alkq/F7DLAz5Roe47SKGuDFOr0xw5VIAi4WYF9WIxXj6D8SCHUdUkjogJRvKQ2O9g+aCsdk+S2iXnXRQzAbiX3mGJWnBy3hwmoShf9H5KINRGiUMuN92bnMBQZeYZkvp0aaNzfivyc3oMvAh8Of7h0+r5lZEbksz0i6l8jD+k3mLoBlGzfJWqMnpZVXJgvd5W6uQFaHXWNuNLzT0DTHEo4MOtRWK2ElLZN5FFBjiffAmn8QAM1VmIhDTr7zhPX2l+ZLZqBIUSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDawO31SHvSmO/+9E3e818K1ynoVSMho2U81di1jNCU=;
 b=DqOY0u/NM5y34GbL0KAV+RRB3Jc6i31M9qFaIH95MKkLvu/H+QHrsbHuXImCmR9GSZgKp7I5//P+JCY/Rp5wXzjEo91mk4ZT7T/u0WRQrKuheM+ZwTQz4fTgMEY7tKB1KtDgI2WY31GeUrUjfnNQsWeBRZv6L0wMj09K2QpVXx0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3690.namprd12.prod.outlook.com (2603:10b6:5:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Mon, 14 Jun
 2021 17:46:50 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:46:49 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/40] drm/amdgpu/pm: rework i2c xfers on arcturus (v4)
Date: Mon, 14 Jun 2021 13:45:55 -0400
Message-Id: <20210614174632.20818-4-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:46:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3629d020-78e5-40da-18f3-08d92f5c630b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3690A24E3B7472222B6258AE99319@DM6PR12MB3690.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A4hFtWPUCNFrD+ye+uKB/rqvT0xUlZQWjxPEOlXqS4Q4po4wyE8NfqH/Ne2qMj2l9OROX+T/8Am4Z6AyocBn4/oTuteZSFZq4JvdLbfdBPTQQmmE/LEW78JjMHg+JqlVibWYVOxAdxNWbMCrNjWPw0juzp19J+CKUH2WyPRCFbRnw34M13ym0w+ikEZwoWL4MFUMeKKPwbz95aEeObrvy5x0VtIBr+A+uF3sKt5b6QDkn6PIhY9+pp/gfkvw4j8TQSLU7anleuTWXEajtvD4BdJgOAU7xyPjq2i1L4vmMIt089GbXUzSWm7w+YdEBeLZSqh+opqLv4JNTzdZIEFQzdyzZiU12cmhU8JNEutJXq1fXZPrEKBYNqhZAYRjh/AljbY7/u6iLABt24qfamqL/jjElgc58nxISGt1cxVTRROZSrPt2bnMvi8IAxzmGU4N1FEX00zzwT9Sv9mHTOs9of8QbGy4XT1KFygZ6NtTCya8GPfpiSg0sWh/YVi1EwtHOCRwsmNdtB6UbW+w2zWL+GJEcRqtxe1kFUUcCJXKjSgW9XQGPk06onZG/ljP8SatDz0Z0mDfkB9ehSWhlM7ON3KRD6wf+kQ+gB9DpnB2GG54HgYzQq0yGmN9SlAl+0f8x8U2JMe1dCu02NmT3U/fz3DdFv/yVxHDthPHFkauKCRzBHb9/pBuCHWX58IC4pvA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(66476007)(54906003)(6916009)(66556008)(6666004)(316002)(478600001)(66946007)(4326008)(83380400001)(26005)(55236004)(956004)(2616005)(6506007)(1076003)(186003)(16526019)(6486002)(52116002)(38100700002)(38350700002)(86362001)(6512007)(44832011)(36756003)(8936002)(8676002)(2906002)(5660300002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?63GQpor++yeXarNxMnw6agcXmT/A7MqL5AGhcGR6KHF+jx/fpWmkubc8y8CH?=
 =?us-ascii?Q?IK5Iy45Ha0IsHLAwYoB9SDqIQ3qpWJ9VynhiK6KTw98fUwCoJ8eRnEsbl0LJ?=
 =?us-ascii?Q?+IRn5BGBBMsXSjt8JP6L+NRF6KZ17iJZrXbV5a73exDPXfOC8VthxpTMOz8N?=
 =?us-ascii?Q?+FOZ5HiXO3YESrbttXCXu+9GULVc9QHFGJN9e9tEayC6JhfO4q3dwBK0HJO/?=
 =?us-ascii?Q?i9LBzPRBU9+MiNncW/JA1X3e91V4wxiSR642p4fQKWYadgZ0qqDVoERCcntX?=
 =?us-ascii?Q?2vIjR93ZeMU98ForcD8c6lqjxawV2TuyoE9Q5FhOBaSVaK6Z/7LgQRG0bo9k?=
 =?us-ascii?Q?cApCj4A/5eCYMKC1vVvW3lAn7PPMSsuR0r6FfXYLnqPwV5gQM7J42svJwXuX?=
 =?us-ascii?Q?OZNePVlKnGCF92i+M//FSbcUQ3ByaCcPf7SYFvCnck3aX+Xwt+cbta7I8Los?=
 =?us-ascii?Q?BTIlrKPjkKs2Yi+LjulnOj/3KQMpsZTdfS3mIAAK2wp5wWc8ot2XQxYL5HEc?=
 =?us-ascii?Q?x3kAG2A85tBZ05KIos+SRKHX8IPfcRSqZfCu/LWZf0/DZAWWfJnBxyOsx9rn?=
 =?us-ascii?Q?ddk7iUinF3If4kEoSq3hPu1HAylM3tAYkrwBzIW9+G7gxMunITav/C5NASXB?=
 =?us-ascii?Q?YhLXCAcNphvRVqw0IaXdSCVaX8gJf97MymVHJHiJ22pnRSixH+Q1VPQ+Ivym?=
 =?us-ascii?Q?ianaPZ4pijXapy93YaXgQFMV7qSvEAaiAkZd03HWYZD4tH/09AGzb6gyLQM5?=
 =?us-ascii?Q?zIhCR0zReGl6/7izhTtw6P0zbye3dVPb42K5n7v1Do9nKaKIjlgPpx9rug3w?=
 =?us-ascii?Q?kHTm07ybtoe5othxH4wFwO1BN4Xn8Qare9/VrDwebduE8+CDCXd4VbvNEGb+?=
 =?us-ascii?Q?9HyEnBcG0VfgI97bz8P8fA5Pn1dgWs2CgGH1dzFhZSr2TQ1U9c9SRUxs2Kyd?=
 =?us-ascii?Q?YDE+IN5yaC0QinoYlRl5MbrBFUbvoQsqtyFDx3gNb4wB+ehk/jSwG7eRX7WZ?=
 =?us-ascii?Q?DjmRrHrXJUotlF2gc6wR+XRxs6Tj80ZWGUZLvSPG6+J34Xhlm2NQjJi5WOen?=
 =?us-ascii?Q?YSi+h4i6qaJnTZLVsXG0v2t8ySD3EQiYvv3KVOFKRfZwxGhzCJlKOhvZGWiA?=
 =?us-ascii?Q?blo6HV2XxjPXyFSa24PH5KDc/IlFDgenekkuSUMIhfC6FxNqpMawPBYhjji9?=
 =?us-ascii?Q?qbhicZcRYShrT5SJm26ik92fjgs+E9b8slXZUaTEoloRBuIHjHhTYfRkMSee?=
 =?us-ascii?Q?IGS69UjhUYGnTNgKegUan4e3/hW7BZS5OsGUn6d42Do31Cqefymf2VooMJft?=
 =?us-ascii?Q?mVRIqjqYVFxhaDGIZ6bYJYCk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3629d020-78e5-40da-18f3-08d92f5c630b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:46:49.6903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cN6Kw5CTSFm+9eVjcSE4Tn+7q8X0SaLkdZuJjeQp1JJ7l26RjAao5QfiPUFCVedn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3690
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
