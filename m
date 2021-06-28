Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C4EC2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 17:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACCBD61C31
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 17:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCBD61C31
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F74A6E4EA;
	Mon, 28 Jun 2021 17:26:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C5556E4EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 17:26:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/omCuO2DtlYZgs4/PcKHnm+cdNZML2CvOBUjAMAVu0TDFNdcCXu/zGdreV046wqlos4cnVVmOpeWnhJX8a1HgpleL8+3n6TbVogLLKA7KWvSlLSpbO1EL1mKo8+0rhz2e6S8j8tN8O8nCNAcxHsiuZOIGPyNgs0F9BayPeMNLYw3RGEM1hlrqU4JAfQZT/DBv0YX3lHcsryZyYQX9f7E0opBULM4OxdF6hVUKl+ad5dEjvelkiqxMrVneZ6vh7IBiTPzb7yTjDXAlM0+gOyA8/fJCIBMVsTwyDVbLEJAPYP1DY75oeHSMgDMWBqn2WS713OYs+EcPRc0yY2CfoykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZ4M1aNSzTsyMxgsiw7LUOLV5Sr4sERFwKzetGED3C0=;
 b=e1vlAJx889t1CqkiIJ4nmG4GWW1++TbcrpjHSy8mC9DzEAfUNIh/ovhadMfKdJ7/DQfvH3KYrHqbnHraRr30Wi9KQGEE1+QbI576ZRRXNMZ8wimi+P9YIQp9HyIIsLePNU5uaA37lOZoHiG45OhsJ/R/gWbERDDNquChJKQsgOHkB2EYY8vBxqIu+aZVyy56EPGuZciWuqvzX2crCuBbcGk9MP6BoeJto73+P3SY4SpFQHWsQ9S3ZYuytilAKF9LEORcuDQHXMlHZAmv0250PXGQy0LSCsb3h/UbFZD10ZRK+p5hkjMzLPDDXWmSirNF6UUJnz7lbxpSEnfA20EaKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZ4M1aNSzTsyMxgsiw7LUOLV5Sr4sERFwKzetGED3C0=;
 b=sHjDbSluTrNmlH+frrIGmOOcLSZejCAYGsXZX8iNbM7QngfUCJC+vVDSYWIqlCbkk2EmV9gaYJKrFzy/+77DkviET1K1whJp/qwcPhh4XjsVllSSmSSjIaM0gZLuxGmMCYSl3O+u4DjYf3vSwFCCogXCm58Prhw9sicA+n925r8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Mon, 28 Jun
 2021 17:26:01 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::6034:e3a9:274c:33a4]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::6034:e3a9:274c:33a4%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 17:26:01 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amd/pm: Simplify managed I2C transfer of Aldebaran
Date: Mon, 28 Jun 2021 13:25:44 -0400
Message-Id: <20210628172546.65492-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: YT1PR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::22) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 YT1PR01CA0083.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 17:26:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 485c35a7-18f8-454b-1211-08d93a59cccf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4958:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4958D0A4B7480BD58BE0090299039@DM6PR12MB4958.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9QM26KPcz7zRnuDSK4lFzDlJcvGemx3sOlnNZjTrhGiHxYlyeFrHGaysawxUXTeNTaxMzkqJN8YGTB48mr1vLz/klDjgA1mM/9XxyzvoM5WIrbfaKRGAzLRp5H3Ghw5x5ZNrv3/b2a833YQIpU0pQ7Tw8XMWZMy/Zwtg45qZTdShzFjAIUreJruLBFy4lsy1X8GjNt+fcnJdtyDxbRTOTrDCKr7d6u08rn8moe+KuFKsUF1ir7tFi3iqU36YSbWSb1uQ5GTD2Cl/JXBE72K/pwmUeJPB/5NhyaaR2dgTWFI9ZTT6/IShV0ivQ71cXUA80Q57BOeiPJDVWdmWSywqBr+2NrYhO7fwrMfeHdkE0Nh46q8ggnxkfGtlT88WbkepZQC0AdTeE09UOX0Ok1iDcqUvtT816XNNkqO1+D5ex3yL0pG1oep6BFn1MNxBTlhactiW7gYpVcoinOCjT05VfSIzel6rj1sKmHyX1Gax0yGAL+iP86jlJ13N30Yg4l5M0mcWplnNJd+V/BtsfzID4e/FChTGSidOu3NCkT9Dpo5y8MgypLKgzTugtAd5yTQpdHWdaIGcrnI1mXTlzuuHOJdrHSUbOOIJFgSCN0Bd9rNyUUweK1RV9q3MDCFf/5N2kYZS5EPZ+FWl79AkJ97QM7w9a+IS6Yu3zszOFOgCipzkrSqbaYezV9wXlhAXscOF9HThaIEdxTb+q2a8Ib9L+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(2906002)(1076003)(6916009)(83380400001)(4326008)(6666004)(66556008)(8936002)(66476007)(66946007)(8676002)(6486002)(54906003)(86362001)(186003)(16526019)(44832011)(38350700002)(478600001)(26005)(38100700002)(52116002)(36756003)(316002)(5660300002)(2616005)(956004)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4yNqxzTGdjJcS5yl0LNsfNwAVoRqzpb45tZPW7Mo2ZaQTuhirQtqJR3EuJ7a?=
 =?us-ascii?Q?1sW+AYE3dcWxZw6KKCUW+mIP0qn51VhECXOw342+B6cAAC0dtOeKQK1z6EmT?=
 =?us-ascii?Q?mJ/SZ+BfVUbZJnCIPqlmXhiW+JBUAXXFZe0na9ccJFwsHQcoAf3F5i/HJbUz?=
 =?us-ascii?Q?e/vhypHWRyx9qEZCfyWOYVzuwe2eKex/0oCaVfCXBXAFSaEggZmdVTkCxzcR?=
 =?us-ascii?Q?gqCyJxueHGgYsxzIK8+rxER/k51f9HbZBZee5DmnX/KZZYmLAd3us5oQ1hfg?=
 =?us-ascii?Q?Lc0SoAiTzznXn3YLzVFxaEtjOALt3rDG2kYFy3GGwcUJzNsHyYPG79hbqBTV?=
 =?us-ascii?Q?5SKEugm7uzl7PZbitvMgr3x2AznBkTsmCdCTxe3uOV0vSXafT3paY9nZmJW1?=
 =?us-ascii?Q?h5yVtGaoeyUqkwEucJjTnTRi6w0l6sW6vUwrPMRKl0REB1GcWMnnwzLVrkGD?=
 =?us-ascii?Q?3FpHZ9YT0vhNVVkmXvd0rjqbNZlr6pC0oq4cWXW+83PvhCrbzPLbQNPQQgO/?=
 =?us-ascii?Q?yoaaiVag2vG4aUaMpbJR2NDnGKM7KwJ2Rmnkog5GasP39wPpl+1b8KQUW4dY?=
 =?us-ascii?Q?ND2/Fe2AqeCocynQfnsJ2DfJIjRz4a/YTUJGaTmRX+29GtG2jro4ZYFLm13s?=
 =?us-ascii?Q?q2J9WahUGLXWqIPhakQ/JuEIj4eE4O3vVMlVeklcBVES4Est7TKXPqxqhT3J?=
 =?us-ascii?Q?qWM/Rn5oK8xN5np+N9CdlBOBHuNO4KFS5fxs60E85LYk08OSFgitmTr1o55r?=
 =?us-ascii?Q?WE0Q//+VzoXZvBYIXfZzUv0mtTIOtWlgvw5mhIf2/OpKgCjxQ5Z4Vca2PpgU?=
 =?us-ascii?Q?2Yo88/7BICXoGQXLxKQ1FW6tnyod6TAWcWx1rAGwzzK7aKJMUjLwz6W5RvPZ?=
 =?us-ascii?Q?x9Pqj3s3HIdbPnW2CDyBYPDC1NU14KJ6rBj3OSx1NxUVZL2QSa8nJQ/mu/37?=
 =?us-ascii?Q?AW2TJE8FgpgGzTwh/4m/ik46vNR0Vvl9/v0kcC/7iKxEJdmo+9rXLW85sDr1?=
 =?us-ascii?Q?gKrFv250VBFTjBENYVhM7vC9E5nRP4up0pQqoklZq4GE6mcIo4dAZdbXW0nJ?=
 =?us-ascii?Q?xj7Xk6sF4zznPjTILVn9xMewhxce7hY6jHzFiEphN9Hyx+HEl72oLto28QI8?=
 =?us-ascii?Q?JDvj97C2zhUbuUtfXO0IQ8HGIZfssoy8u0w5KOorl5qbVBxosOrB7TTnso5e?=
 =?us-ascii?Q?41B0V3p+h7yq1fSlaZ/7p3gMujDl4V8Kd038lmQpR7KLgOCKGwiw5SOdGvZw?=
 =?us-ascii?Q?Q5S/tPEF9cigimIw7ypILOoXIy+MwppfbXrcgZnt7z31Q/LKXYd3WpSS2O+V?=
 =?us-ascii?Q?wDXFdvPyPdpLH38ApYziRwYK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485c35a7-18f8-454b-1211-08d93a59cccf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 17:26:01.6356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/XFt5EorNTP8JUggp3K2sseAThtmUPrgC84cnqLz7eYM33srFerhsOYQIw5MrVZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4958
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Simplify Aldebaran managed I2C transfer function
to correctly play with the upper I2C layers.

This gets it in line with Navi10, Acturus, and
Sienna Cichlid.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 230 +++++-------------
 1 file changed, 55 insertions(+), 175 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 9316a726195cc0..f30edf862b86d1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1425,197 +1425,77 @@ static bool aldebaran_is_dpm_running(struct smu_context *smu)
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
-static void aldebaran_fill_i2c_req(SwI2cRequest_t  *req, bool write,
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
-static int aldebaran_i2c_read_data(struct i2c_adapter *control,
-					       uint8_t address,
-					       uint8_t *data,
-					       uint32_t numbytes)
+static int aldebaran_i2c_xfer(struct i2c_adapter *i2c_adap,
+			      struct i2c_msg *msg, int num_msgs)
 {
-	uint32_t  i, ret = 0;
-	SwI2cRequest_t req;
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
 	struct smu_table_context *smu_table = &adev->smu.smu_table;
 	struct smu_table *table = &smu_table->driver_table;
+	SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
+	int i, j, r, c;
+	u16 dir;
 
-	if (numbytes > MAX_SW_I2C_COMMANDS) {
-		dev_err(adev->dev, "numbytes requested %d is over max allowed %d\n",
-			numbytes, MAX_SW_I2C_COMMANDS);
-		return -EINVAL;
-	}
-
-	memset(&req, 0, sizeof(req));
-	aldebaran_fill_i2c_req(&req, false, address, numbytes, data);
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
-		dev_dbg(adev->dev, "aldebaran_i2c_read_data, address = %x, bytes = %d, data :",
-				  (uint16_t)address, numbytes);
-
-		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_NONE,
-			       8, 1, data, numbytes, false);
-	} else
-		dev_err(adev->dev, "aldebaran_i2c_read_data - error occurred :%x", ret);
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
 
-	return ret;
-}
+	req->I2CcontrollerPort = 0;
+	req->I2CSpeed = I2C_SPEED_FAST_400K;
+	req->SlaveAddress = msg[0].addr << 1; /* wants an 8-bit address */
+	dir = msg[0].flags & I2C_M_RD;
+
+	for (c = i = 0; i < num_msgs; i++) {
+		for (j = 0; j < msg[i].len; j++, c++) {
+			SwI2cCmd_t *cmd = &req->SwI2cCmds[c];
+
+			if (!(msg[i].flags & I2C_M_RD)) {
+				/* write */
+				cmd->CmdConfig |= CMDCONFIG_READWRITE_MASK;
+				cmd->ReadWriteData = msg[i].buf[j];
+			}
 
-static int aldebaran_i2c_write_data(struct i2c_adapter *control,
-						uint8_t address,
-						uint8_t *data,
-						uint32_t numbytes)
-{
-	uint32_t ret;
-	SwI2cRequest_t req;
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+			if ((dir ^ msg[i].flags) & I2C_M_RD) {
+				/* The direction changes.
+				 */
+				dir = msg[i].flags & I2C_M_RD;
+				cmd->CmdConfig |= CMDCONFIG_RESTART_MASK;
+			}
 
-	if (numbytes > MAX_SW_I2C_COMMANDS) {
-		dev_err(adev->dev, "numbytes requested %d is over max allowed %d\n",
-			numbytes, MAX_SW_I2C_COMMANDS);
-		return -EINVAL;
+			req->NumCmds++;
+
+			/*
+			 * Insert STOP if we are at the last byte of either last
+			 * message for the transaction or the client explicitly
+			 * requires a STOP at this particular message.
+			 */
+			if ((j == msg[i].len - 1) &&
+			    ((i == num_msgs - 1) || (msg[i].flags & I2C_M_STOP))) {
+				cmd->CmdConfig &= ~CMDCONFIG_RESTART_MASK;
+				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
+			}
+		}
 	}
-
-	memset(&req, 0, sizeof(req));
-	aldebaran_fill_i2c_req(&req, true, address, numbytes, data);
-
 	mutex_lock(&adev->smu.mutex);
-	ret = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
+	r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
 	mutex_unlock(&adev->smu.mutex);
+	if (r)
+		goto fail;
 
-	if (!ret) {
-		dev_dbg(adev->dev, "aldebaran_i2c_write(), address = %x, bytes = %d , data: ",
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
-		dev_err(adev->dev, "aldebaran_i2c_write- error occurred :%x", ret);
-
-	return ret;
-}
-
-static int aldebaran_i2c_xfer(struct i2c_adapter *i2c_adap,
-			      struct i2c_msg *msgs, int num)
-{
-	uint32_t  i, j, ret, data_size, data_chunk_size, next_eeprom_addr = 0;
-	uint8_t *data_ptr, data_chunk[MAX_SW_I2C_COMMANDS] = { 0 };
-
-	for (i = 0; i < num; i++) {
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
-				ret = aldebaran_i2c_read_data(i2c_adap,
-							     (uint8_t)msgs[i].addr,
-							     data_chunk, MAX_SW_I2C_COMMANDS);
-
-				memcpy(data_ptr, data_chunk + 2, data_chunk_size);
-			} else {
-
-				memcpy(data_chunk + 2, data_ptr, data_chunk_size);
-
-				ret = aldebaran_i2c_write_data(i2c_adap,
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
+	for (c = i = 0; i < num_msgs; i++) {
+		if (!(msg[i].flags & I2C_M_RD)) {
+			c += msg[i].len;
+			continue;
 		}
+		for (j = 0; j < msg[i].len; j++, c++) {
+			SwI2cCmd_t *cmd = &res->SwI2cCmds[c];
 
-		if (data_size % data_chunk_size) {
-			data_chunk[0] = ((next_eeprom_addr >> 8) & 0xff);
-			data_chunk[1] = (next_eeprom_addr & 0xff);
-
-			if (msgs[i].flags & I2C_M_RD) {
-				ret = aldebaran_i2c_read_data(i2c_adap,
-							     (uint8_t)msgs[i].addr,
-							     data_chunk, (data_size % data_chunk_size) + 2);
-
-				memcpy(data_ptr, data_chunk + 2, data_size % data_chunk_size);
-			} else {
-				memcpy(data_chunk + 2, data_ptr, data_size % data_chunk_size);
-
-				ret = aldebaran_i2c_write_data(i2c_adap,
-							      (uint8_t)msgs[i].addr,
-							      data_chunk, (data_size % data_chunk_size) + 2);
-			}
-
-			if (ret) {
-				num = -EIO;
-				goto fail;
-			}
+			msg[i].buf[j] = cmd->ReadWriteData;
 		}
 	}
-
+	r = num_msgs;
 fail:
-	return num;
+	kfree(req);
+	return r;
 }
 
 static u32 aldebaran_i2c_func(struct i2c_adapter *adap)
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
