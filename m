Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B4BC48BCD
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7480C610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7480C610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB0FB6E5CC;
	Tue,  8 Jun 2021 21:40:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94CFC6E1CF
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXe1LZwLgha60Y4273XErqQH3VO1TVCVDR9EsX1DOECuwxGMac0JzT0BCAPgyc12vHpp7aAkovyBf03qglKlVx8/7ixtR0fw8t5xoaJLMyxlR8MClvHaFyvOGB5NjWCBpjNzUzO6Ud8JIGJKHKjiX1r2EwifK19zSqtvLMkitD2/1Ib3b9XCXiD5bFSq0uiZWvlTpg656bfwj9ClCo5+sAJQhwtn8Y0oEsKIbFvZEamXA+LDvuGeSFzLMuxqmd3eQHlwlUToyKCmi2DCojQKRC2ZhJ3LU2CnQdSgjJ+jbsWUwHjsVkUK4IS0l8NETPAmA0LOnEY6EMWmDth6s86lOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNb8vTHJgvv9KIiIbo460KDrlT8m617ck5HKfZ+rWsU=;
 b=THAPzrOYA2uWOsl3ChZ3/xu9jVt6DiYV+b0f77jiUtlWI20gbZV6IDliDFsumYN8pyNl5xBG+WkbddhCc84OadwYaDO1e7SIvIpJbeCK5bhtXvVmZiEFtimx4lU9ConntwZkDedrZ4KOuq980TBIdtbuWUpOIsW8sZoreA8snpWI1AZSgs7Bk00ucTO0Dt1MSxd5+F20cmPGFY6HRZL7J+d0l3V2Def8bEEJvql13kX00jgG8OsiQhllXT3R6/R/GAuccmvz/0/Qmy0DEEKxRkmhRglXTZeGgfVyAcZ+7dO+rHLY+aieFlDGDsJIaDOZRB62LayyQtYUqw/UpMFWSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNb8vTHJgvv9KIiIbo460KDrlT8m617ck5HKfZ+rWsU=;
 b=SGpxCPdrU+84lgenEFGRvwjkSs88vbr16TqOdenVTccXgVN/daXKIo6ixOOQwCnX8qiOvLEj2BqufarXEncORCbdw5Onu21Ea2G/IDjgi8hNSCNjyusesRwQvB0SdItCsPYnWAFo5UhKUOGQvzxkpSOdyKG9weMexsNLOknyYwo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:14 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:14 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/40] drm/amdgpu/pm: rework i2c xfers on sienna cichlid (v3)
Date: Tue,  8 Jun 2021 17:39:16 -0400
Message-Id: <20210608213954.5517-3-luben.tuikov@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: dcf97d81-493b-484f-157d-08d92ac60013
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43557CEC7EBEECF9C582028B99379@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jV1bGoTp6u0HGtTVfAKalR5l7yQcNm25Rrw7rEa0G8MhTy0RVzG2SIQxG9A0ModZ+XN4ReThh5zp2putp/b5TaVuBu507QDp5sRmmXs6oS/SCPJk5BPoBDSlgT78bFwpzx/HKFYs0UUH1evpq9Qg+8uNj//dZkAJnZXcHD6mq1R/bxjFfp7fXKdSaHPJo1IROOlI0poKXW4ShRGYispqwOIqlv9mcM7SZeZqT8uwGHu/1z5QQdS6s3xqCDDhm0GAJ87KJUbtzymHbi36STrA4GigHxo3jn+cMw7FuKrQRgVlkMjYXEjCkFhpFF1l2uvYHYEKcPYFmMccFC2ncr38VbeYILVm4fuOT/4EA2h7IMOCsjAUSEni+ODhCWaXlt1o8Mgyjt3MQNeruuYWeOYZA0LbjaVn9MNEnUCemlvzhBr1CvZA9jK3k0eRXF6FJvRbMm4A4TCaF3GbAaFKPk12BWZY83Elfw8WbL5r/KftCSIXAK57p13GQ4FjlXcBieET+wWwO6o9SLcxXNyC7UNXLFbGhSQr8/7MbfGYMQIxh6Jysdpq3qaGVMciN2+kJ5Nrv7ZyQtHfdQiIbN/WO3yd8vQAdDmtar4JgBAN0+sUQt7Qqz7whG60RwK4mawm0O54+7wM2sfIRmNA7JfYebs6/npuY6r0BwKFYjgQcnrW7JEdjXGzwjGgSFRxWOpa9LmH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(376002)(39850400004)(346002)(44832011)(6512007)(66556008)(66476007)(5660300002)(38100700002)(956004)(38350700002)(6506007)(478600001)(66946007)(8936002)(36756003)(55236004)(2906002)(16526019)(6916009)(186003)(54906003)(86362001)(316002)(6486002)(83380400001)(4326008)(26005)(8676002)(2616005)(52116002)(1076003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?szJ/ChrTU3MIGbJCwuP0kxkACzB2QRag+6xDE8BRMd68B2Hhfj3Y7TAYhegv?=
 =?us-ascii?Q?W1UB1OlqO7jCn9/3hEtnOTvVjYgC4xMrIWJbuXyIh8JmU6OKigHlWZGQc0+k?=
 =?us-ascii?Q?jL0bl32r6SPCEmkF72GOp5KeWJ/ggi77QKrTD6ErYXPfqHpvy8O88w8EDXkc?=
 =?us-ascii?Q?Bm7QAEuipt2p6LTNxWMzFRaQP/FuUJE15STC+RlVUjHDKTldGFYF36pceLmI?=
 =?us-ascii?Q?4s+spbckesathrIIvP6qpYh4v6UnXJJUiZi6+vyC+FxXW0jbcT5qWYkwvRhr?=
 =?us-ascii?Q?pxWDzKRPz4y5nI8LKN1GVbCH0uC9OTBoDoEwpityXauKkFxipn9vQvro8Nz1?=
 =?us-ascii?Q?/xgRwO2yYz41dZvxB9mO6pT34izv65aBLkfxTTCP1wAD1vkIWyOsGWU4svIS?=
 =?us-ascii?Q?IloElRRUDpyrJE/g7sGi2alLg/EITWelYHlUDBi0+Axxm09DWiJuEdLdX8o6?=
 =?us-ascii?Q?+0Qd5q3g+CkRutu8V2pomL0Crzq8cawKMybUmuYEczatNWNQvLB3gNq8H3ec?=
 =?us-ascii?Q?H6DlCPqbEo10IXYyeclOJ+G487OFnEgTXdUnNvjlwItRDWWSM/62i/F2XTxQ?=
 =?us-ascii?Q?xlO+kuxAkrj1dGk5lG+VJ/qwPlN9J6daAzedVFIfSCnRi1abiLp4M+o6SOjN?=
 =?us-ascii?Q?S0qVWxgS3+7Cyt/ELfZEpo0327YxtawTX+uEj/R8D2SFrXZL+o29nJNlCctb?=
 =?us-ascii?Q?GHePB+a5WutaUgb4Uk3NIglwRdxznElf5QIQSFeDZg6DJ7aPy06/+eykKsVm?=
 =?us-ascii?Q?qj3PtilepHiz8zg6MAsd116ddgEarXgxGoVqmofeEFj+FdmOroMolmcxThUL?=
 =?us-ascii?Q?G7/x4Ys/WLhO6x4GLFGFfHgmyPTgbY82oYyDwB7h0IZhw/mJLTVjPXoKhQaM?=
 =?us-ascii?Q?OU2B2Z64Vw6ambtah9b7Kurtz5yGtMc41gPRU/TC4skZ/zUsB0L/slyEAhEG?=
 =?us-ascii?Q?kHCV2L1OpofV+ZTf2jUR+mnKKPrOFJ8axewOC/FRrCPmcnC1wJNbqfSUcEu2?=
 =?us-ascii?Q?TpsCYxXPXU4UtGpirOfA5aMx5V5F0WHBf0nhHzyiwxCenbmoq8G8Nbbtsk13?=
 =?us-ascii?Q?Z5RyHfjokfisJHBrHI3VKsvn/7ckyY+qpQmfRNr61CBorQGsjb9TTGbMb6YK?=
 =?us-ascii?Q?CyFQyjow59T/FC2dlj9EUjNzVlKidyBbqqs8McnWPXwPxV0cx4lhyNfmTCR2?=
 =?us-ascii?Q?btwqH1EGzweNFGnJZzCSSguC3YPX0OduBBU+nVpSww3YXqqHSXlzftbEGfjJ?=
 =?us-ascii?Q?l72Xz+xauNgRwykAxYdTl4rX8TsX/InWdtVDnVyfKDOknjYUEg+Snc2hFdzH?=
 =?us-ascii?Q?Uq+VfD2swyYUCTY+942JxTfz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf97d81-493b-484f-157d-08d92ac60013
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:14.4906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VWqKEcFqwNbiFa1x6Z/GzLEC5pdb5ccw02/PdIQWV4hPYgwpv4bYvniBP3mV7Ls
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
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 229 +++++-------------
 1 file changed, 58 insertions(+), 171 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index f01e919e1f8988..499e1309d0f796 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3389,197 +3389,84 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
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
+	r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
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
-
-				memcpy(data_chunk + 2, data_ptr, data_chunk_size);
-
-				ret = sienna_cichlid_i2c_write_data(i2c_adap,
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
-				ret = sienna_cichlid_i2c_read_data(i2c_adap,
-							     (uint8_t)msgs[i].addr,
-							     data_chunk, (data_size % data_chunk_size) + 2);
-
-				memcpy(data_ptr, data_chunk + 2, data_size % data_chunk_size);
-			} else {
-				memcpy(data_chunk + 2, data_ptr, data_size % data_chunk_size);
+		struct i2c_msg *msg = &msgs[i];
 
-				ret = sienna_cichlid_i2c_write_data(i2c_adap,
-							      (uint8_t)msgs[i].addr,
-							      data_chunk, (data_size % data_chunk_size) + 2);
-			}
+		msg_bytes = min(msg->len, remaining_bytes);
+		for (j = 0; j < msg_bytes; j++) {
+			SwI2cCmd_t *cmd = &res->SwI2cCmds[c++];
 
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
