Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA1EC48BE6
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C52460FDA
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C52460FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D47DD6E0F1;
	Mon, 14 Jun 2021 17:46:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5978D6E0EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obte6zd4HoaiCsMY0JJH6RPQ9Nw2CwYc1fSbGF5/9GVfAXq1AtHUdo5uLPaqkpSJ48I4o/Pd9pamws5umf2C50hcXPJ4BiKXIYEb1+HbgHMwRHbEo0e567WxTGsaLH+mVMc4AH0JOQ+n409g+t2llDSp5bpPw86dr1DpRiE2ikifk2DzDlUyvdmZeomsMVP0QPXtmirLVSVi48MChKSnnkbcjLlvSFnEOYeSF7jwSymWgxhA8mldv4K6ANhhwk0AybGm0yi6QM4HBxvu2Sg4LGEx3hRrXAMLgDnjkL9dpPECh7TI1ee5GZX05Ux+4pVznuctQvuwTN/pkzNI590Qtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8Bri4FBWYcc4NpwSeaK6ClT3lMR13plY77ozmruhjg=;
 b=ahlWgPPh8foDnFLFskCjIauHwE/t1fVD4TklDOigh2ioC//PljwL0L50IjBqtkhZk3jZL7mCz+pxdyAUdX+3CDaXkDpprnJdZ0+i3q5HUXyE8wecFX7kJSJkgeciDkm6X4/TJLga7UTKTIqJ/rwWesm4pbgtdlRwiyaC3/AhnAXFGSPW0WDQnaCE+LWNt1oVNHKMDzNUT0wdU2QpF8u5fVip8F8K7n2P6Cs8CaZCtZbMmR/XpY97T+bQNeE1UqwRHxEjyU3FqRCt819C4LORXo5YSksiRIaZoEC5DiZmdxXmGhstU2c/BD32vMBizz6i0qXKD78q5dGD4XWTOYp65g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8Bri4FBWYcc4NpwSeaK6ClT3lMR13plY77ozmruhjg=;
 b=jBqo5yfxKlnzojE3KKChrk4y9QqmilgJBSF+0TduvGy/97Gm4+4r+e7d3QZVG9JjkdQV+EeDaXOne4N5Egc1wd7dGocnxIRpsEThpRDTjCbQyOU8BefE22WVt/GxYv+LwFRP8q1mJgflQSUu7hCjFEPmYRg5aeXVqIKQPXUD0c8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3690.namprd12.prod.outlook.com (2603:10b6:5:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Mon, 14 Jun
 2021 17:46:49 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:46:49 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/40] drm/amdgpu/pm: rework i2c xfers on sienna cichlid (v4)
Date: Mon, 14 Jun 2021 13:45:54 -0400
Message-Id: <20210614174632.20818-3-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:46:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 231a0bc5-ea6a-42af-0e86-08d92f5c62a7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3690516F1F7464F59A4926FE99319@DM6PR12MB3690.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: neA92Uf2lIzppt4ZAIGObEvmjteR6RrZo2347OnwWoOsl5woh345GcY+spPOZ1OzsmIlAfYUKnQVDMDv6dmotxgLggM0yA0kCvjX/ZqNU5i1MFAl2rFS0n+y7jwt2yaDjoig6pX38kHA6qbnYVn4nKr3VANejQRvjbd8KmPxDgTEEnHIeze2l0DTJGBNICA63LOMRP7KI/uJB2NASI7ARuH82ihcyhDjE51tjboeM28puzOrzNmL6Xl4tX8pM4Q4rG37+vVrSiwKlLsYxlQxcPkMODDoGxU3jffZTTyNROSUbfm8BX02RhePEQzAdrzxug9pi2c86m+Y23E790hcLKKr8f6nJRhFcIuFukZH5It7Z1vj7cB7/bKkqoseljetELqzjij+DVPOZoSQKk8+wLKq39Zf1IpN6AxBN5vMS4dw812bcJ7Mv2IFZiryAxZjcPtmvQTGYygbB9jR3ugQSSveLH3KtQrwU7bshxBEfE5mwkpL2/1eQj1h2UuIX9OeA0EEujZ0jKnhWFWoJ2oRvxN5JW68p/dBgb+2ITCgNfeQ+ugjrkTnk+hoBUn5EwD6DOI/2lCFqJUYqTeMhDe0mJiLcbAgFypt38Rw8KXt9f8p0jepzb4DOT4HU/6Q7v8UvKXkLJjlXjnE/C9VrqjEOMVi42O3QllKDrQ6fQ0Lh8ZRbveGlGIa1WvQblB6O+CV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(66476007)(54906003)(6916009)(66556008)(6666004)(316002)(478600001)(66946007)(4326008)(83380400001)(26005)(55236004)(956004)(2616005)(6506007)(1076003)(186003)(16526019)(6486002)(52116002)(38100700002)(38350700002)(86362001)(6512007)(44832011)(36756003)(8936002)(8676002)(2906002)(5660300002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pDY0iMmiQbfLGxPmh6hmG8zEOyyIGPF07RbsmwdWXus8eUuJXBVMdN78da3r?=
 =?us-ascii?Q?86ExbWaEFxJ6dSTyvl9Bdl8zSGRNzxEOdrEts1IFmAcbcczySjgHX28FVc8T?=
 =?us-ascii?Q?X/b1uNCtg+yq0FvLcb4Wr0y88WxGtiZ+bIQE1bH9zaXbtUfMq7DWlGX3D+cZ?=
 =?us-ascii?Q?DPj6/XlPhdCqV/VI0YUtjZNhXcvkjMxG7StfenmdSh3xxShEaGjAQ/RxOaGc?=
 =?us-ascii?Q?qg3Pyk0/osfQnme2EhAEDHYqfsE6k7oLSosT2oRek9cFumil89c/iulWUXNZ?=
 =?us-ascii?Q?T6x9i9X7NDy5+SI/L1ncMyaWSxmaFA+FWaD63Rmv1hCFLxnIW1tQQlO+ufnq?=
 =?us-ascii?Q?DRUBoE4zMZQXh6DRcBmw/kFOSQkY95g6rRP6HG7kaAWd/5U4JJzmw2hiWVZx?=
 =?us-ascii?Q?hrvvG/Lcnba8m7ZmxH4HpDh3lMNawxV3OQwVqrrgeiO1Dt9C5vbdTYqY9VUO?=
 =?us-ascii?Q?ESrrq7EY5hmxpO+fOOlThAm4DP11QVbiUCvwWqCeAeUxpa1F7iewdlbDJTuy?=
 =?us-ascii?Q?f4MTKZP51uVM23MDlI25XyF8b9i8/EeKTYF16K5sSbw2oBDRqDeXiDehcbhc?=
 =?us-ascii?Q?yRLesNS/9FNU/VYBqH8IiVdxctu0DrwnDgPBvbEn4e3FXXxvymgSoU1016u+?=
 =?us-ascii?Q?HMu8ACEshbhptseRa9Yp7jhnmb5axP4Zttmksp/UdIdHm//GnRHpcgxs8CJL?=
 =?us-ascii?Q?54Qk9SeE/hbG4L+Pbx9FeNr7SecdbDXyRiltB8Pfmv4HGI7tmApVU9Y3hZx3?=
 =?us-ascii?Q?NAzeyXtzb4zi4JAwq2kOTF06PeFo6gU0Zepgu6MOel4rhD2uKVdxmV42Tr3R?=
 =?us-ascii?Q?MiA+x91KQ6ER3xUDjOYzP2I5/ClhFKa9kZAtmtdfimH4wFcxKtSs3ByEb831?=
 =?us-ascii?Q?aeXyNaLGM0L2YEjAJE/BArfh0QET3dmCu+OKeaUD9FJVsnodlPFSwD2vWCkb?=
 =?us-ascii?Q?tEFeO1WJ1b+Zu5NsUdFqfM5cuUVA0SZacmjqLac5T2whT5XkFYEJOKt6Qyn9?=
 =?us-ascii?Q?Rqcwm2Sec31lCm8TPphmsuJsqmjp581Sw+qNX00TRNA9Sh679q+xahO5fuzs?=
 =?us-ascii?Q?ZJQjTyrBccxyeXacYPuS3bEGwtpG1FOQwK/KNMj0enfBP/gCsWBJljxlsqmk?=
 =?us-ascii?Q?Ejw0rftrN28bSN/w96FpQ7yghxN/A5yAq5zVb/lozmy1m6Oe/+OQXxGfThgf?=
 =?us-ascii?Q?m/DQwF/v6mLKHx1ygcIZuYfEwqrCLnFrb7a5cdT+fHcWtKI/wuVKaRkcxmzg?=
 =?us-ascii?Q?W+jlUI27gb65wDNNd+uphhYm/y2V7G1sC2das6v/D+JRq1bnOUtzpbZ1BgHP?=
 =?us-ascii?Q?+8ff+qqsPY2pL346cuonpSse?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231a0bc5-ea6a-42af-0e86-08d92f5c62a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:46:48.9787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56I6xc/AkJ2OxeRq9RUrTxpcU5U9tmjXgCZol37CfX38yjLA2rn6CtFfXbL1AAtG
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
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 229 +++++-------------
 1 file changed, 58 insertions(+), 171 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index c751f717a0daff..b4aa489e4a431a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3442,197 +3442,84 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 	dev_info(smu->adev->dev, "MmHubPadding[7] = 0x%x\n", pptable->MmHubPadding[7]);
 }
 
-static void sienna_cichlid_fill_i2c_req(SwI2cRequest_t  *req, bool write,
-				  uint8_t address, uint32_t numbytes,
-				  uint8_t *data)
-{
-	int i;
-
-	req->I2CcontrollerPort = 1;
-	req->I2CSpeed = 2;
-	req->SlaveAddress = address;
-	req->NumCmds = numbytes;
-
-	for (i = 0; i < numbytes; i++) {
-		SwI2cCmd_t *cmd =  &req->SwI2cCmds[i];
-
-		/* First 2 bytes are always write for lower 2b EEPROM address */
-		if (i < 2)
-			cmd->CmdConfig = CMDCONFIG_READWRITE_MASK;
-		else
-			cmd->CmdConfig = write ? CMDCONFIG_READWRITE_MASK : 0;
-
-
-		/* Add RESTART for read  after address filled */
-		cmd->CmdConfig |= (i == 2 && !write) ? CMDCONFIG_RESTART_MASK : 0;
-
-		/* Add STOP in the end */
-		cmd->CmdConfig |= (i == (numbytes - 1)) ? CMDCONFIG_STOP_MASK : 0;
-
-		/* Fill with data regardless if read or write to simplify code */
-		cmd->ReadWriteData = data[i];
-	}
-}
-
-static int sienna_cichlid_i2c_read_data(struct i2c_adapter *control,
-					       uint8_t address,
-					       uint8_t *data,
-					       uint32_t numbytes)
+static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
+				   struct i2c_msg *msgs, int num)
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
-	sienna_cichlid_fill_i2c_req(&req, false, address, numbytes, data);
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
-			data[i] = res->SwI2cCmds[i].ReadWriteData;
-
-		dev_dbg(adev->dev, "sienna_cichlid_i2c_read_data, address = %x, bytes = %d, data :",
-				  (uint16_t)address, numbytes);
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
 
-		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_NONE,
-			       8, 1, data, numbytes, false);
-	} else
-		dev_err(adev->dev, "sienna_cichlid_i2c_read_data - error occurred :%x", ret);
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
 
-static int sienna_cichlid_i2c_write_data(struct i2c_adapter *control,
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
+				cmd->CmdConfig |= CMDCONFIG_READWRITE_MASK;
+				cmd->ReadWriteData = msg->buf[j];
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
-	sienna_cichlid_fill_i2c_req(&req, true, address, numbytes, data);
-
 	mutex_lock(&adev->smu.mutex);
-	ret = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
+	r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
 	mutex_unlock(&adev->smu.mutex);
+	if (r)
+		goto fail;
 
-	if (!ret) {
-		dev_dbg(adev->dev, "sienna_cichlid_i2c_write(), address = %x, bytes = %d , data: ",
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
-		dev_err(adev->dev, "sienna_cichlid_i2c_write- error occurred :%x", ret);
-
-	return ret;
-}
-
-static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
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
-
-			if (msgs[i].flags & I2C_M_RD) {
-				ret = sienna_cichlid_i2c_read_data(i2c_adap,
-							     (uint8_t)msgs[i].addr,
-							     data_chunk, MAX_SW_I2C_COMMANDS);
-
-				memcpy(data_ptr, data_chunk + 2, data_chunk_size);
-			} else {
+		struct i2c_msg *msg = &msgs[i];
 
-				memcpy(data_chunk + 2, data_ptr, data_chunk_size);
-
-				ret = sienna_cichlid_i2c_write_data(i2c_adap,
-							      (uint8_t)msgs[i].addr,
-							      data_chunk, MAX_SW_I2C_COMMANDS);
-			}
+		msg_bytes = min(msg->len, remaining_bytes);
+		for (j = 0; j < msg_bytes; j++) {
+			SwI2cCmd_t *cmd = &res->SwI2cCmds[c++];
 
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
-				ret = sienna_cichlid_i2c_read_data(i2c_adap,
-							     (uint8_t)msgs[i].addr,
-							     data_chunk, (data_size % data_chunk_size) + 2);
-
-				memcpy(data_ptr, data_chunk + 2, data_size % data_chunk_size);
-			} else {
-				memcpy(data_chunk + 2, data_ptr, data_size % data_chunk_size);
-
-				ret = sienna_cichlid_i2c_write_data(i2c_adap,
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
+				msg->buf[j] = cmd->ReadWriteData;
 		}
 	}
+	r = bytes_to_transfer;
 
 fail:
-	return num;
+	kfree(req);
+
+	return r;
 }
 
 static u32 sienna_cichlid_i2c_func(struct i2c_adapter *adap)
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
