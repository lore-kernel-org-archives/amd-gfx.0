Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042E3C48BC2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA1C60FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA1C60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D02C66E11E;
	Mon, 21 Jun 2021 17:12:41 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8370A89BFD
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIhxGicFp0YRjWr0lRY2ph2ghvIbp5LN1Q4+qp7LedPBlEAwgFXurEYg/D9/Mn3N83DFvFinvSthw4JvZ/R6V1jtJD4tkVXJrA7RSFgKPRWht4sKDIufIyhCLoAzciFOVh+5EhBySu4nz991gM1sn9pZzaizYTqiAE69n+XZsvAclBUYeHchjNxhe95waojz53CfAedkhf+xe0maFjAqybsAhslU6qK9hIrC0Reb6diOqwGyFbld7/yO9FiNCUCTcqV6ojHW6PRWp5NHr7b9U2+iUCmaORg8CxMR1f5CP4W1rKDT4L7YKqEtWDhuTJbt6cuDteC4V1aKIpht6xJ8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8Bri4FBWYcc4NpwSeaK6ClT3lMR13plY77ozmruhjg=;
 b=FJ/7WL9Z7Je3oL20VCLKnw22FYEexCCCiuqq80d/IjLNlHeaLEGI+G9ICFKqBQE2vfFXgzxke5IorXyi6he+bWOU2FhOtdi9Q357g272XTzqOty5JwAnwk14vdtbz/b21pUMDtfQisP/ovHNLgMtypi1FH/lV/CvN/tLP4O86f7dSizfpvIqzcReIv213mOODsbsKXSLe0N///GtkOqOYyaLzvcOskiHgZby1PytOl+RhIfm+bzAuz3iOV5S3SGHbf2FwMiaeQjQfAPp/LNrbrXBSVRuFxpzJcix1cPhxXRkd1AVGWOFOkFu4MufSF4jF1mIxHDhOxEWixAimzsn2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8Bri4FBWYcc4NpwSeaK6ClT3lMR13plY77ozmruhjg=;
 b=MEZjqLGN5OsenPExK0bWUirK1v1B0N7PfNvJ9LC0HdUOYLwwZHvltL/FZkH6o2wddatMMKzcHEYu/VQMtra8zvtJtzyyUPKh6EoHvUl7b+U3UOMt113+NivTuxU3hnFlsG6iu502SVQqriarsK6yQumd39P3ufv7aUJwLAUz6HY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1258.namprd12.prod.outlook.com (2603:10b6:3:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 17:12:36 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:36 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/43] drm/amdgpu/pm: rework i2c xfers on sienna cichlid (v4)
Date: Mon, 21 Jun 2021 13:11:40 -0400
Message-Id: <20210621171221.5720-3-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40e72f3a-67c0-4ca2-0192-08d934d7c3fe
X-MS-TrafficTypeDiagnostic: DM5PR12MB1258:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB12589C94A982C18F83CA020D990A9@DM5PR12MB1258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QpMIPvTodshz+je1bP7SilFdH4ViCLGS5moT/k+05JW/86Omh6MuVJo5LohD9aiFMvnAjljDUQyJTY6NcnJrp/C8dzUqlLF4PtYRJVL1uodR6mbRtFP73sZ3Y6huhx36YQwHkvE8G05SJFwEpBshAiFRgTB21MUWt4fr+/Gi9Qtk7U09orjotEydg2EA5hk46nD6KGO34BpFmofW1+F3mLD7bPp/7W8K38O1omfZC9MfyiY7m/6ave6tzx0+u1obrKcAJzklbOy22O122cINnCXwyL/BQZCKawZbBWlwhGQqlKKOACGtN7XY9qvdJNmS6fM26IEZ2u5/x/jHC/Fvy5BtVxUEpXgcdiSYXG9CRNIVGlTC2aM2NxU82npi40+jPViT2hGwf5tCnAHnww6Y6OfxfrvFBnBxmw/5KXFZshxPoVt3IRkYS2zRSJ9wjSnFZ/3ynYrQVZ+y6asBw/hFRzFyfxtLUhTL/BjAjIhQtja2mYqWg9nmDThdqtImPuMfqziEQHbqi+2D/i5qxJIYPr3dPTqHfGL38ssxOIviGw5Rlx2B0uLFkREmxS0tpDAvKw0DY9y0f3mRX3WaFIwWbvht6XzpSm8MXrTtLVGBqGplqTbDDLnYKcr+oswdtlW8+s/GvUVDrIiLda7ELXFMvcky632rSCzcJ2AnsU+z9OCcUJU00jO2SMoY7jkEZBL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(2616005)(55236004)(956004)(478600001)(8676002)(8936002)(54906003)(44832011)(6506007)(38350700002)(38100700002)(36756003)(83380400001)(2906002)(6916009)(6486002)(52116002)(6666004)(86362001)(316002)(5660300002)(186003)(66476007)(66556008)(6512007)(4326008)(16526019)(66946007)(26005)(1076003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iEbTwClOZu+NgxHtSNl4d8rotkFCu1WyIYIM2VQub4M9M6UaE0xCIKJBnzPt?=
 =?us-ascii?Q?21ZG4ZXRGqrov3YrskcTGXsx/vtVG3+ah9aoIrz8J59bR2EeOG7QdDM0MMo9?=
 =?us-ascii?Q?fsE7oV4c+e09ZIpA4E9CNPXz4SBS3QezSadyP4CYH4KOr3MplDmTBHk4QWtf?=
 =?us-ascii?Q?OC31rahD6jWXoI+udtRN6cdwDT+uZOx/Z8uS63GREBXVOlGz0excs4ukeMkh?=
 =?us-ascii?Q?xXPDH5OGzS4yMLvXZLIUvgarnIbp+xi2o+PvXBhpQt+1a4w5yb8GxS7nVzvG?=
 =?us-ascii?Q?gxLC2CJlMVz49rEndUjFfHkFKz+BGpKIcqYmdR7U6xRS9uqT9Ml7nr1MjOZq?=
 =?us-ascii?Q?lyen8yg9ftMV0YXTMzq/o01ckmsqYAYw+5RVJnsgZj1hH9Xqrld8RWzt2/z3?=
 =?us-ascii?Q?SUMGZcefkVU/ajpOKyVrwBccu3ge4Nj5HNdcrlvI2luwbwxh8enTtnLR9S9g?=
 =?us-ascii?Q?FsUVpVIKWCHNtCR8UPUkkZJs3mD0NN3ZKiHLE2eSAab6htZYZ7vg/xQtug3n?=
 =?us-ascii?Q?AG5gDDOWAHfLv0SNEWaZV6NWdtX4c9YpBW9eWc8UfB37zOe7bAuFr7eIxzdu?=
 =?us-ascii?Q?Vq9fapJK2l2dfytPNfBVfozDaUkfvQ563qem1IM5VucnY52igHQdvWre/r1m?=
 =?us-ascii?Q?NOnKAS4SvNaTQIadROh5zHtWZLTYWazFKd1kPMyr4jH8lTFHG3y11ul8jXKp?=
 =?us-ascii?Q?fmYpE8A1JCs2FbMWWPkbODdFLowRYkPJdu2pE6lmrqjc0NsChgTrQb2XpZ/M?=
 =?us-ascii?Q?e+I58lNANWfJmLTrh25NydjMiwIpe9PBADQCdG34aVJpGLiE8X1CHq6NTql2?=
 =?us-ascii?Q?2EQSOjb9G5rLSTlbNdocLhcGxMffDIX6xhFzVreX0W3z5mqnk7cvZDr0US6t?=
 =?us-ascii?Q?clyGlDC7c/BCquSXWGJQU65hRlD3CbgeKgHrpRhihBVQOx4l2esY3/31YlbX?=
 =?us-ascii?Q?sGQA4Rf1I27c7smwJ1m46U4ImytKSc7gSTBM9qVUi+j36RcDfrFQiSv3Fb9q?=
 =?us-ascii?Q?AgrLMq+Oe5HWP8fg2mYHrX29d0qHG3xi0ySmlF1o7JNgVJNlo8+78gXow9DN?=
 =?us-ascii?Q?YRqs9iaiRGx/km8QZ/vmaoKr32o+uqfQnkJRNhLpU6PTO6iBojibiWUKJJya?=
 =?us-ascii?Q?bxX8nnC3I3Kloit3BsGdqgR+E275X8KA9uHKqUBUebIQUgK1Iw2zZfca2jTn?=
 =?us-ascii?Q?900f/BZOJBBc9BFrhpEj/Sk7/530dIs+Hc2fd/i3alAX/ogZbDdOHL4XXx0L?=
 =?us-ascii?Q?9sBPhQuTOBkYpFBBt3A1OoQjmit9ZuqipfDlaqy+k520lZ2gkqIziSjfmYg3?=
 =?us-ascii?Q?9vSz3I8ro8PCugCagAvMWd4k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e72f3a-67c0-4ca2-0192-08d934d7c3fe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:36.1931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQrTg5LJkyecszBjFy8fs0O9k/IeMkZoYvSfWJRfXwcQj/gwm0unUgWYTz8+bzU2
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
