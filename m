Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE122C49EA2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04BF60FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04BF60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FB5B6E2B4;
	Mon, 21 Jun 2021 17:13:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B64BF89E36
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:13:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iN+wcqXwHvqJXTIifv7rWZpihRcJPw4o9NNOj20wxBmpwQ3Ue9PScQ8gUcDDybvRla4Kg0tmtraEiVWznPSLi6c2uLB1deXRfMjWYG278rCY78LymKcZIB4RJB/ibHTWxUrPHqWXR5bMxkIYNeEIBkn8B1kYej3qH2H0XXoC5tK3l+CGrt5R1X2X3vCAg9b3Q5NgzhJEOJiYRzS+0jUA6Q75a1ZEHvbHMUXr0S59s77dJt8muZlkiQm2x1LLUFLoB6L8YYr+nBGuE+UV6XBIAKUlVetIiRLcmYeNcyO7Y67fpLD/gRULUHaVzaH0HOIXXNSeznVI/HoYntz8kdcqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdbLY06QsABawIZfLTQakvclgyBrTY3vo1zY4l8IcA8=;
 b=bggpGeUqtEiJSB2XANRVqA/fzJ4RHAlWjzaoU3idtseKFCShB0vIyvRYFwAv+q7BpaPeFuY47c2+GcUP9G41Y6p6MCYcZ6OednB5ZfjyGHea7gLD3GC3vgFzWvRd3nLjRgIspKKC0gbl4rFMRAIV6A7HO1Q6GGPRx+nAcmYnAZXJ5RUJ7E0n1ZjACEogi3ICEhRqxYxFZMAxkDrlykmMpcSFzLEk+g98i/8QyP/EjuJ/9olD21ACZrKcVvWclyOnORStPT2Wc7a6B8CNcvyr4+JjVwRGtOQznxlbEDNiG/c8GpqsfLfqJYlMt+I/uI25nLXodZY8IcI/M/ojm8dExg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdbLY06QsABawIZfLTQakvclgyBrTY3vo1zY4l8IcA8=;
 b=FzNac/bH8K3v5qwqIlDD5TzSYa3M2XXT45r8Iffu029YiGBRC1DHu6wdcCf9GLI6pqeBCTmSNbLXfee37vDKyAAb2f2XMi6wNUPEh6RC5ggGtq2ZZ0R5CVnq798ll9+kAlTvbyeRveiQqeh+dTKZ2sXenE2L2le+kByrVR+98x4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 17:13:30 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:13:29 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 30/43] drm/amd/pm: Simplify managed I2C transfer functions
Date: Mon, 21 Jun 2021 13:12:08 -0400
Message-Id: <20210621171221.5720-31-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0d8292d-382f-4674-98e0-08d934d7d201
X-MS-TrafficTypeDiagnostic: DM6PR12MB2985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2985D628FF556F783739214D990A9@DM6PR12MB2985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zMzVHW9zEGTa9t45t8YvXDniPwSUqlL9ih/uCjAcyyraKJ4OvERE5d+AtsXHGv0vt9MY7+i1xm7Ui0g3FpnKWMrwFrReqrEVREdG7nGIh/x1NTso6pLFpK/xhBJ4gKjGC5fWv2u8086HkFDvFe+WQIGmCgmOemdQv61NDV28hHuTwIueYP5hMI69Sf6VnziEy19dTi7AKtZi/QbUBNmKRuFgutN8CmOn92EmqmN1rQna7COf8o7kx2S2wxhlnKIfxq5i1K3NHv0f4v+70Nz5pwkozoZUPSXVyXUwNysEF3hLVtUVV29ZNX9PeZQkiHuH8pwZc84aV7qz8ftHWknJ02qz1nAhEvpAs5j1TJWtEwJhXStM7cDlKCWPcVA01wH6dPf1X6ydJ+dhspL0QNIDjk5Twjo8244yd6BPJOOpSqDOMyDBo+w0cTlgyeeeVIrWnyibHwMUVfbOtr+u5PZLeK8BFKbhG7nuw/o5sucZqyuor3Uzbgc9Jx7NffnWKuGGCtTD372Um7sIEp48v7t2aIwPhdvMlyP72wHzfo7sB6mhKlup7YGP8gNHeyif1CakrZ5LGXiPqpSD51FG+bbj4qLrStQzXCQ65C1nrit0aLAI+1p2wHaDw1umwGnM1/vRsNaLVIEUCm4AQy+Z+oFfkAsOnxPjK3kJ4R3DmEETzE3KOWlEYwOdq3+rkQzuVbI+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(6666004)(55236004)(8676002)(316002)(6506007)(6486002)(54906003)(44832011)(8936002)(478600001)(66476007)(66946007)(956004)(2616005)(6512007)(66556008)(2906002)(52116002)(36756003)(30864003)(38100700002)(38350700002)(86362001)(5660300002)(186003)(4326008)(1076003)(83380400001)(26005)(16526019)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ko68uufkPWgikv3xIbTsRbQGTKEH14zgrp3imLhHUcKWp8mmrT/Fdf2IyE9u?=
 =?us-ascii?Q?UheCxYjQjnG1VXneI20SPlmZot2Fbpy4j8J5VZeX078LNxMrvFGPDf1RtDmf?=
 =?us-ascii?Q?bDcdBn+ugoT7lA406pHbBOeZGQHQZZd4wDGCXB45dGZwm7UjljwGep6z8e09?=
 =?us-ascii?Q?KrAo2WRAIr5hyyDzcKS/6BKYnno0/F8weZgLwnl7hhStu44svfG4UBN16TPS?=
 =?us-ascii?Q?rUB+Dt0P1ZKyU0XMav7YnAEUxZKqSFbxyE4YBzHGoaBiqALgLg0yw8/WiqNn?=
 =?us-ascii?Q?QMm5B/bUwqRlNyrVfiyLmPXW16Wr0GmIFvPAUo9F99txLVc/MAetY3Chp6tN?=
 =?us-ascii?Q?o/96gLSJZeQv6Sr2Vf00dDa25O/2LYVHbHA8aPNMtfk9MP0YYAvvpVv/p3aU?=
 =?us-ascii?Q?/QRCY58thMafUFHGvD6dzGbruJpQ3HIZn2fcVj+G6ln2HozarQVljL3/6OhM?=
 =?us-ascii?Q?HBA3mQ86yPDVSmKdVS0SuA54rT7Fm7YhmxuSTMcQq0hsN2xNoasyS51d1XeJ?=
 =?us-ascii?Q?xkOFA0scmvgayIf3L8DuFVR60rbQEPe/L5ek9HOCkDTRc3QPLgiy9aR+0RtJ?=
 =?us-ascii?Q?HB3ggqnA6ELRt+XE2EKh26xgrAfRqD4vrKaoT324Zg15I9Ef9/ITkYUowm7o?=
 =?us-ascii?Q?dgaN+bT6saJexwzhjI5XukemMBYtjGkQpymirbQ1ze+uD1dvwhQHxD6Pdy/q?=
 =?us-ascii?Q?U3bLmDTZGWPi4ulBcM/ZaSny8TcAc77+jhnlpu2Oo8vdkFMwRpyE9EC8djak?=
 =?us-ascii?Q?qXTwBebX1WxDXIk6BRraYeaH3g0urpHFGcRq8/O+yMOJAYCsqljIzkBGSg2E?=
 =?us-ascii?Q?1NKq1K4v4nEIlLo7N9oPmP0Zh+Dg2TuzePqr+1ZG8oVOVli0PRPUsYi1Epqy?=
 =?us-ascii?Q?rygbqlDe39r5XmQSDTD3J7s1hzHPWDobP8SU5f/6V27sc3bftmgehLZpHdGO?=
 =?us-ascii?Q?O8VXtSl4Z5JWZZUg5TTMttM5NNNTgymt5B2fjiS8Kfu5qlEtd8c01vEganFV?=
 =?us-ascii?Q?osYoA7ZOFgK72iQPKirB+VyXEAYiRTqFAmDUKlFxLFn/aRDmHnSlk8b7ZxYw?=
 =?us-ascii?Q?KrqKpSydJcg6xnObgpEfWGiIM1YdME4u+OnD52d8nN+Z+mN++Sy4CaDqYRRS?=
 =?us-ascii?Q?PFxT6w91dczvA7OxDn1/zUDL64xr+avFHEoWZL/k03p3kZaWnsZys7/dBk+i?=
 =?us-ascii?Q?li1tPJBLOFNF5yMJ/X92Pb9lnLUjD9dP6RhcmtiCBHaGyDtNPoCPn+z92aFQ?=
 =?us-ascii?Q?xJ2fplzSMqkC9HHqAeubakX9Lla9+1QC6ci1D3ooC0YHOxwbEPZqCXkueDbP?=
 =?us-ascii?Q?d6W3bN8TkhgnH4OoKRPamOg1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d8292d-382f-4674-98e0-08d934d7d201
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:59.7377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzwoDtgCqFaSXmNk75NcQLusfZk5Ljh3v/O014OLN/dcxjgNC4WwAMdlpc4vNRFk
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Now that we have an I2C quirk table for
SMU-managed I2C controllers, the I2C core does the
checks for us, so we don't need to do them, and so
simplify the managed I2C transfer functions.

Also, for Arcturus and Navi10, fix setting the
command type from "cmd->CmdConfig" to "cmd->Cmd".
The latter is what appears to be taking in
the enumeration I2C_CMD_... as an integer,
not a bit-flag.

For Sienna, the "Cmd" field seems to have been
eliminated, and command type and flags all live in
the "CmdConfig" field--this is left untouched.

Fix: Detect and add changing of direction
bit-flag, as this is necessary for the SMU to
detect the direction change in the 1-d array of
data it gets.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 78 ++++++++-----------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 78 ++++++++-----------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 76 ++++++++----------
 3 files changed, 95 insertions(+), 137 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 3286c704bd08df..dc884b719717ad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1937,31 +1937,14 @@ static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 }
 
 static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
-			     struct i2c_msg *msgs, int num)
+			     struct i2c_msg *msg, int num_msgs)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
 	struct smu_table_context *smu_table = &adev->smu.smu_table;
 	struct smu_table *table = &smu_table->driver_table;
 	SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
-	short available_bytes = MAX_SW_I2C_COMMANDS;
-	int i, j, r, c, num_done = 0;
-	u8 slave;
-
-	/* only support a single slave addr per transaction */
-	slave = msgs[0].addr;
-	for (i = 0; i < num; i++) {
-		if (slave != msgs[i].addr)
-			return -EINVAL;
-
-		available_bytes -= msgs[i].len;
-		if (available_bytes >= 0) {
-			num_done++;
-		} else {
-			/* This message and all the follwing won't be processed */
-			available_bytes += msgs[i].len;
-			break;
-		}
-	}
+	int i, j, r, c;
+	u16 dir;
 
 	req = kzalloc(sizeof(*req), GFP_KERNEL);
 	if (!req)
@@ -1969,33 +1952,38 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 	req->I2CcontrollerPort = 1;
 	req->I2CSpeed = I2C_SPEED_FAST_400K;
-	req->SlaveAddress = slave << 1; /* 8 bit addresses */
-	req->NumCmds = MAX_SW_I2C_COMMANDS - available_bytes;;
-
-	c = 0;
-	for (i = 0; i < num_done; i++) {
-		struct i2c_msg *msg = &msgs[i];
+	req->SlaveAddress = msg[0].addr << 1; /* wants an 8-bit address */
+	dir = msg[0].flags & I2C_M_RD;
 
-		for (j = 0; j < msg->len; j++) {
-			SwI2cCmd_t *cmd = &req->SwI2cCmds[c++];
+	for (c = i = 0; i < num_msgs; i++) {
+		for (j = 0; j < msg[i].len; j++, c++) {
+			SwI2cCmd_t *cmd = &req->SwI2cCmds[c];
 
 			if (!(msg[i].flags & I2C_M_RD)) {
 				/* write */
-				cmd->CmdConfig |= I2C_CMD_WRITE;
-				cmd->RegisterAddr = msg->buf[j];
+				cmd->Cmd = I2C_CMD_WRITE;
+				cmd->RegisterAddr = msg[i].buf[j];
+			}
+
+			if ((dir ^ msg[i].flags) & I2C_M_RD) {
+				/* The direction changes.
+				 */
+				dir = msg[i].flags & I2C_M_RD;
+				cmd->CmdConfig |= CMDCONFIG_RESTART_MASK;
 			}
 
+			req->NumCmds++;
+
 			/*
 			 * Insert STOP if we are at the last byte of either last
 			 * message for the transaction or the client explicitly
 			 * requires a STOP at this particular message.
 			 */
-			if ((j == msg->len -1 ) &&
-			    ((i == num_done - 1) || (msg[i].flags & I2C_M_STOP)))
+			if ((j == msg[i].len - 1) &&
+			    ((i == num_msgs - 1) || (msg[i].flags & I2C_M_STOP))) {
+				cmd->CmdConfig &= ~CMDCONFIG_RESTART_MASK;
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
-
-			if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
-				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
+			}
 		}
 	}
 	mutex_lock(&adev->smu.mutex);
@@ -2004,22 +1992,20 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 	if (r)
 		goto fail;
 
-	c = 0;
-	for (i = 0; i < num_done; i++) {
-		struct i2c_msg *msg = &msgs[i];
-
-		for (j = 0; j < msg->len; j++) {
-			SwI2cCmd_t *cmd = &res->SwI2cCmds[c++];
+	for (c = i = 0; i < num_msgs; i++) {
+		if (!(msg[i].flags & I2C_M_RD)) {
+			c += msg[i].len;
+			continue;
+		}
+		for (j = 0; j < msg[i].len; j++, c++) {
+			SwI2cCmd_t *cmd = &res->SwI2cCmds[c];
 
-			if (msg[i].flags & I2C_M_RD)
-				msg->buf[j] = cmd->Data;
+			msg[i].buf[j] = cmd->Data;
 		}
 	}
-	r = num_done;
-
+	r = num_msgs;
 fail:
 	kfree(req);
-
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 9c171122384336..205dc2e56ab199 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2736,31 +2736,14 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 }
 
 static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
-			   struct i2c_msg *msgs, int num)
+			   struct i2c_msg *msg, int num_msgs)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
 	struct smu_table_context *smu_table = &adev->smu.smu_table;
 	struct smu_table *table = &smu_table->driver_table;
 	SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
-	short available_bytes = MAX_SW_I2C_COMMANDS;
-	int i, j, r, c, num_done = 0;
-	u8 slave;
-
-	/* only support a single slave addr per transaction */
-	slave = msgs[0].addr;
-	for (i = 0; i < num; i++) {
-		if (slave != msgs[i].addr)
-			return -EINVAL;
-
-		available_bytes -= msgs[i].len;
-		if (available_bytes >= 0) {
-			num_done++;
-		} else {
-			/* This message and all the follwing won't be processed */
-			available_bytes += msgs[i].len;
-			break;
-		}
-	}
+	int i, j, r, c;
+	u16 dir;
 
 	req = kzalloc(sizeof(*req), GFP_KERNEL);
 	if (!req)
@@ -2768,33 +2751,38 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 	req->I2CcontrollerPort = 1;
 	req->I2CSpeed = I2C_SPEED_FAST_400K;
-	req->SlaveAddress = slave << 1; /* 8 bit addresses */
-	req->NumCmds = MAX_SW_I2C_COMMANDS - available_bytes;;
+	req->SlaveAddress = msg[0].addr << 1; /* wants an 8-bit address */
+	dir = msg[0].flags & I2C_M_RD;
 
-	c = 0;
-	for (i = 0; i < num_done; i++) {
-		struct i2c_msg *msg = &msgs[i];
-
-		for (j = 0; j < msg->len; j++) {
-			SwI2cCmd_t *cmd = &req->SwI2cCmds[c++];
+	for (c = i = 0; i < num_msgs; i++) {
+		for (j = 0; j < msg[i].len; j++, c++) {
+			SwI2cCmd_t *cmd = &req->SwI2cCmds[c];
 
 			if (!(msg[i].flags & I2C_M_RD)) {
 				/* write */
-				cmd->CmdConfig |= I2C_CMD_WRITE;
-				cmd->RegisterAddr = msg->buf[j];
+				cmd->Cmd = I2C_CMD_WRITE;
+				cmd->RegisterAddr = msg[i].buf[j];
+			}
+
+			if ((dir ^ msg[i].flags) & I2C_M_RD) {
+				/* The direction changes.
+				 */
+				dir = msg[i].flags & I2C_M_RD;
+				cmd->CmdConfig |= CMDCONFIG_RESTART_MASK;
 			}
 
+			req->NumCmds++;
+
 			/*
 			 * Insert STOP if we are at the last byte of either last
 			 * message for the transaction or the client explicitly
 			 * requires a STOP at this particular message.
 			 */
-			if ((j == msg->len -1 ) &&
-			    ((i == num_done - 1) || (msg[i].flags & I2C_M_STOP)))
+			if ((j == msg[i].len - 1) &&
+			    ((i == num_msgs - 1) || (msg[i].flags & I2C_M_STOP))) {
+				cmd->CmdConfig &= ~CMDCONFIG_RESTART_MASK;
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
-
-			if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
-				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
+			}
 		}
 	}
 	mutex_lock(&adev->smu.mutex);
@@ -2803,22 +2791,20 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 	if (r)
 		goto fail;
 
-	c = 0;
-	for (i = 0; i < num_done; i++) {
-		struct i2c_msg *msg = &msgs[i];
-
-		for (j = 0; j < msg->len; j++) {
-			SwI2cCmd_t *cmd = &res->SwI2cCmds[c++];
+	for (c = i = 0; i < num_msgs; i++) {
+		if (!(msg[i].flags & I2C_M_RD)) {
+			c += msg[i].len;
+			continue;
+		}
+		for (j = 0; j < msg[i].len; j++, c++) {
+			SwI2cCmd_t *cmd = &res->SwI2cCmds[c];
 
-			if (msg[i].flags & I2C_M_RD)
-				msg->buf[j] = cmd->Data;
+			msg[i].buf[j] = cmd->Data;
 		}
 	}
-	r = num_done;
-
+	r = num_msgs;
 fail:
 	kfree(req);
-
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 37cfe0ccd6863b..0c3407025eb29f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3443,31 +3443,14 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 }
 
 static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
-				   struct i2c_msg *msgs, int num)
+				   struct i2c_msg *msg, int num_msgs)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
 	struct smu_table_context *smu_table = &adev->smu.smu_table;
 	struct smu_table *table = &smu_table->driver_table;
 	SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
-	short available_bytes = MAX_SW_I2C_COMMANDS;
-	int i, j, r, c, num_done = 0;
-	u8 slave;
-
-	/* only support a single slave addr per transaction */
-	slave = msgs[0].addr;
-	for (i = 0; i < num; i++) {
-		if (slave != msgs[i].addr)
-			return -EINVAL;
-
-		available_bytes -= msgs[i].len;
-		if (available_bytes >= 0) {
-			num_done++;
-		} else {
-			/* This message and all the follwing won't be processed */
-			available_bytes += msgs[i].len;
-			break;
-		}
-	}
+	int i, j, r, c;
+	u16 dir;
 
 	req = kzalloc(sizeof(*req), GFP_KERNEL);
 	if (!req)
@@ -3475,33 +3458,38 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 	req->I2CcontrollerPort = 1;
 	req->I2CSpeed = I2C_SPEED_FAST_400K;
-	req->SlaveAddress = slave << 1; /* 8 bit addresses */
-	req->NumCmds = MAX_SW_I2C_COMMANDS - available_bytes;;
+	req->SlaveAddress = msg[0].addr << 1; /* wants an 8-bit address */
+	dir = msg[0].flags & I2C_M_RD;
 
-	c = 0;
-	for (i = 0; i < num_done; i++) {
-		struct i2c_msg *msg = &msgs[i];
-
-		for (j = 0; j < msg->len; j++) {
-			SwI2cCmd_t *cmd = &req->SwI2cCmds[c++];
+	for (c = i = 0; i < num_msgs; i++) {
+		for (j = 0; j < msg[i].len; j++, c++) {
+			SwI2cCmd_t *cmd = &req->SwI2cCmds[c];
 
 			if (!(msg[i].flags & I2C_M_RD)) {
 				/* write */
 				cmd->CmdConfig |= CMDCONFIG_READWRITE_MASK;
-				cmd->ReadWriteData = msg->buf[j];
+				cmd->ReadWriteData = msg[i].buf[j];
+			}
+
+			if ((dir ^ msg[i].flags) & I2C_M_RD) {
+				/* The direction changes.
+				 */
+				dir = msg[i].flags & I2C_M_RD;
+				cmd->CmdConfig |= CMDCONFIG_RESTART_MASK;
 			}
 
+			req->NumCmds++;
+
 			/*
 			 * Insert STOP if we are at the last byte of either last
 			 * message for the transaction or the client explicitly
 			 * requires a STOP at this particular message.
 			 */
-			if ((j == msg->len -1 ) &&
-			    ((i == num_done - 1) || (msg[i].flags & I2C_M_STOP)))
+			if ((j == msg[i].len - 1) &&
+			    ((i == num_msgs - 1) || (msg[i].flags & I2C_M_STOP))) {
+				cmd->CmdConfig &= ~CMDCONFIG_RESTART_MASK;
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
-
-			if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
-				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
+			}
 		}
 	}
 	mutex_lock(&adev->smu.mutex);
@@ -3510,22 +3498,20 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 	if (r)
 		goto fail;
 
-	c = 0;
-	for (i = 0; i < num_done; i++) {
-		struct i2c_msg *msg = &msgs[i];
-
-		for (j = 0; j < msg->len; j++) {
-			SwI2cCmd_t *cmd = &res->SwI2cCmds[c++];
+	for (c = i = 0; i < num_msgs; i++) {
+		if (!(msg[i].flags & I2C_M_RD)) {
+			c += msg[i].len;
+			continue;
+		}
+		for (j = 0; j < msg[i].len; j++, c++) {
+			SwI2cCmd_t *cmd = &res->SwI2cCmds[c];
 
-			if (msg[i].flags & I2C_M_RD)
-				msg->buf[j] = cmd->ReadWriteData;
+			msg[i].buf[j] = cmd->ReadWriteData;
 		}
 	}
-	r = num_done;
-
+	r = num_msgs;
 fail:
 	kfree(req);
-
 	return r;
 }
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
