Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EC4C4743D
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDBA8610E5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBA8610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 798426E1CF;
	Tue,  8 Jun 2021 21:40:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D686E19A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcvev3t1lB2BzSAt2+8fnrTxFYyRENmaOmjRvNYYqmnQlxZ+HQT9B+ZJCoA1f5Nj8pDyBwa8fojvuIyCkocL2BJB1U37SMm79Tr/Lop8KLlO7oXpGbDiSkBxba+/awzSwaf9ideeh1nO3wPu7BbY6G1GCxG/GhnvEz/3d4P0dChVvCv1xMN0Y3TNXQv+Fbn3z5Fqz1lbs3CdxCa9/0u/ltQREyLgl31QbsZUjUORi5/OPSYfVnwQfZ/rsHGhku7+wM0RurdDR7Ldb25EAPTrq17JP/PSZpzPRs8SkLH/noxe4/mDPlweAei0Sn/ViVNM2Hbs617jWhm1XNdiCg50Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21tmZSbH8thrKtBXRHaXCcScTabF5DOqIb2MiYpr+hc=;
 b=AKAobHqQjsfiHv73856ZpYxf8SE06Nu+6YOrq3V0JHz9uC8T4xNbteaf4EAFAUuQg97HBtqgFoJz4gk5b0hedaff6WXtX/I+LppJ6b7xCXnWlmnQiI9/dv+vYnuD8GJZbXhyquhVDR6Y32f8++n4cpU3wqcu8Qex6jx9xNd03OFdCyJGOopUvaCJDjGzVrpfvo8pz+eRNtORdTSIiS6FVKBM4ABrLGCX9LlUE3R35NoqdZPcYipoG8lHLCl5JIzetkIAbLgsSjZHVWZ990Q0viFeM64eD/ZD0m7zaTZO73IudLuuyPAOMf9ORr9EhwEX2FYAwjs8m5pxHPmJOkqrDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21tmZSbH8thrKtBXRHaXCcScTabF5DOqIb2MiYpr+hc=;
 b=CiutI9KcjojqBsBRTgnS2Jqz+TTUfSWbAqCFVsEe5rcFd5r5dTy/Jv091u21Bk3aSC7/fV+TSTEdkmLmjHDg+WBCkYU58USvki2m8CACFfRH3Z8XpW4O6JWzEb0M8VAOYOmAea6IhTf8Q0axsoWWw+3KcL/vNDPMBTneB9ycrcg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:15 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:15 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/40] drm/amdgpu/pm: rework i2c xfers on arcturus (v3)
Date: Tue,  8 Jun 2021 17:39:17 -0400
Message-Id: <20210608213954.5517-4-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 181f2e94-3f0f-458d-9488-08d92ac60080
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43556A6067C9C2A77B80EC6B99379@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0gfiyUZxnGezsjRXsLczT8iJYSODriNJ6SRYNhK3aY/MfovhJi2WcEJEJqeaQ5ZEPF2Ol9a0xAyd/PmX/azZ7emBYuCToi8pioUDdDmD4BjsDb6FewBsCouSwC9MF1v7atp/EOLbjzSG1ErtY8UfiuIXyBaHC9D6Zh2VTg8IJwVEx4AR3Z2jphXzbNaLFkTw6v/0mo1OXyvUidKB/neXBcxOJ3+OSlViLQhUiDWeFoMpeBmSc0HFdpmecn5XjidpU0X4wFfHS2o/MY/WkdwA8clSFpccbAmZflcDhzkKTjI2lwCnIISWyh/0Qhi66BY8rM+vsuqFoYbL0HH+KFf6ZYaDcG7KLRt54dtOX54ytNzBRe9FjkL5WXsGzQXQBUXKrK25Tjyf34zwyDa5edK0lDhF9s0XdDm/OdSDh/Oyf+A7pYB4bArHULtK/4HNv1vbLyuVppfCEabWkrcLGf6YVrIlpjbvSSpkPf6nVaWGpfI7SwFaObzhRx0IuyKNI8UI6/SbuvpvR18S4rRgLryFvdl8iLjXgscLjTiDIAGgK5QwbrvqXobNAj0hKX4TYmSQGaSyPN4r0jHFmPBBEfuAlETe5Z09OUO20+OOiuhevlUDfKGo3LAu+Sqf6Tudbph01YhRcX2X4kGQL9wglV+hbKGxWxWbKTlflafEpjiN4sFhgNYLargjsiycxtnvECA1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(376002)(39850400004)(346002)(44832011)(6512007)(66556008)(66476007)(5660300002)(38100700002)(956004)(38350700002)(6506007)(478600001)(66946007)(8936002)(36756003)(55236004)(2906002)(16526019)(6916009)(186003)(54906003)(86362001)(316002)(6486002)(83380400001)(4326008)(26005)(8676002)(2616005)(52116002)(1076003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Aa2gd/zimrvQE2hsKXh6YmtmQz+ymJ5HQOiAd1s9BZDMLcA5cw0Hi3qSoWRG?=
 =?us-ascii?Q?aHojQ61aorD1yS5GJ0s6Q6eHARDgj/bKLVOleOe22inbz0Km8JFbBrZ1UN2B?=
 =?us-ascii?Q?nWhIIEMV56sD0//Bhy7lyAkXx6JPyhptlqntPiVu09qmDPSPNASsKaAYIic4?=
 =?us-ascii?Q?o7hN5BDvWEO1fucuDp+IWpm/8yAehOukftDNsYHU+Uo8bp6/y8s3P8B8A5+Z?=
 =?us-ascii?Q?E5g3sv8f6HF9Sr4eWww1cjd3v0hlbiPr5XbOgN8YVEAQpSqkE+D/0onDjkZd?=
 =?us-ascii?Q?Yg/a2+6ZmP203cOsT3CoNC5QezoRFpJvPrhirG//dO7JVZBGJUMMZrsMA41f?=
 =?us-ascii?Q?IKCYZKRKYMBF4zLUPjLfPtX0LvV4f9ZLR+Jb7cdicLPJqpIxGcoRuFPZbqbh?=
 =?us-ascii?Q?aiiGH9rKKYMOUd4L57MyLMWcoV7rAINvBb189JzP/JZTpXmzn+9XimB/b9OO?=
 =?us-ascii?Q?4WAhuFRQyLlKRBYkZW04EapGjyiVRq/SWw4HZq5t/YR5LV8R8znozAeFto4e?=
 =?us-ascii?Q?LSbe/wSYsRwDbU+cnCxpLSTT49n5NyEZUgR+EO2duUXToTgNA5sKszCqfOYy?=
 =?us-ascii?Q?efYvKNIcLfSJYwsm83CEBa7OsbK5B45ax88x30dYL4K9Y2aRrH6bGIjZQ7YH?=
 =?us-ascii?Q?66JjCKlMX9A2rNLKG/OP07+SDXqYWiDIGNhYPZ7jUh/uWseJkMP2WJEU03dF?=
 =?us-ascii?Q?5JK1EGKq4eo9uWvn/EbOElysVs4CrGQuqwMxOGgmTku//6bjjgPNozhz7RBj?=
 =?us-ascii?Q?VkRMsauBItOpGsPvStye4EbGbXn187bEZMYDwIEMW+piWiU7bBFOHCR3BZOg?=
 =?us-ascii?Q?V0XTYE+vR1Vpwdiv2+B4lVx/t9rQCc3dGMz+HTs0+MsBu+A3Vilm14/rjYY6?=
 =?us-ascii?Q?ADxLxT2yUUXdozF/FrC947cDL19xSwv3uTNNH/NxGeK0IwpnMeKDbG/KdIa2?=
 =?us-ascii?Q?GMxYP6Wr+fohDtsj2V/9TdQwxYzYPCt45YZyNz+WeGxlZqmuDCqjKJJXKJ32?=
 =?us-ascii?Q?FuQCJ9SGrsY6sxyMfp4L2xyFXhnmAu7TvW4BYGVNkNVbNrteZ5+vny/jD216?=
 =?us-ascii?Q?T5q3nlmyqLJi7Nz/2mJAv736jRWkxSV96puF+ZHJvQmvE0zfspgWIT64IqhG?=
 =?us-ascii?Q?2p2oQiLQEyCG8OS8ucKl9aBlhmLGckhM4bGAd29jGZhjtrcPwuVSla01FIRP?=
 =?us-ascii?Q?uzoW8WTYXfrcL9H9GoL+HAF+dijZhwz1GM9mfiK9aFivxTFNgiH+2nogsfIl?=
 =?us-ascii?Q?j9QBsQBgxormv4dzIjwI/QbwVErHs9RvEKCbCdkoWUZyN9ALvSPA++60UG+D?=
 =?us-ascii?Q?a0eaojqs0LowVWiDgUbH8Qg/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181f2e94-3f0f-458d-9488-08d92ac60080
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:15.1752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxWPjG2zMui9u/93BbzJCle51gQ7Reu9l+oOBrmAMcPOZ0O0BT50TcF/tptgfXAj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 229 +++++-------------
 1 file changed, 58 insertions(+), 171 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 5959019f51ad66..e1f7607302ba6c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1906,197 +1906,84 @@ static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
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
+	r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
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
