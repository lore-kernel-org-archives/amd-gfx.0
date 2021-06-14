Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082ACC2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C089560FDB
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C089560FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2586E147;
	Mon, 14 Jun 2021 17:47:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DB616E141
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSYIlekb63tRzrC9/LUFOhicdVVifxu5LFZMHQNQD/emQi5aIXESQM7uPEIXhD2oNapw10eO78pjeHmWO0dTyLOgDFhKirbIGVi3QpkzlD01jRlxeu7N6HxzbTLbMgC6TxV5+Ggf0HHT8dSWRWlO7VgJ6hoVxkjSlPWvhlNAqoU+rJNv0CLW5nmXlUXhTlvFw3XoshJ3AjBxIv0O3e+yIGdCv5kyCZ7ogQazaOeRNgnqQrmIeNE4sMRUONP/sQYFxB6P7hh8dnmFXk0Na/ZDnr0lHpUiA9tqdVD+C9LkzxCmHvPkPM8i/qr2v16m3MRR5UrjW3ZLj9p/CdBN1BO2EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yC/tVt5TtWiGxrO7q5aeOqiEneX2WedDFLpzS+NmMh0=;
 b=CDCJtp1S7grxqx1JSCbKgPNospeIeuyVItUS/PwzqZS6MLKwEnGcwfuBrhvYKKiM31jPtQ12KwOcXFRdVardVnW+4986IR4yJ1oxFp3UyJ8xzw64+AKCQEnTuJL2zIBa7YwKRtI86uhBLxPFfddUgO1Be9jnevDwsMKI2Mju0g0oVFq99mxMXfsjwJ8+RzxdE+kd5dHvX2NP6KHeoNPQDrlAAHhwoBhQp/NyKZtpWZZAJxau490Rg0A3JXyz4sUvabgc2qzvtDt3LAwvTSuJnsaRPEKWOW0bjGeBAJN/i9b9bWp0P+XiPBHg0Ah92J5dXAd3dU0Pw7UJ/o1p/71hPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yC/tVt5TtWiGxrO7q5aeOqiEneX2WedDFLpzS+NmMh0=;
 b=CjlwrPXwUBCpUG3OZpKB82EpKoHYlLV/LsZ3gq3x91X4YLqJf0tB1sglH9ZrY8eEqBuWf2L3js9V/VOAkGbBt/iLqIBdzHjMtE4BNZwiyDWcEbgFpXtO8A0BVml5CibPTQ3lWYHwhxejVmKCwQpXXeLlyMplvEepTHdB3q6I1RQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3577.namprd12.prod.outlook.com (2603:10b6:5:3a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Mon, 14 Jun
 2021 17:47:43 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:43 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 30/40] drm/amd/pm: Simplify managed I2C transfer functions
Date: Mon, 14 Jun 2021 13:46:22 -0400
Message-Id: <20210614174632.20818-31-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:47:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 637b6aa4-d9b5-4294-390f-08d92f5c7129
X-MS-TrafficTypeDiagnostic: DM6PR12MB3577:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35778A8BFC2FBCBC3F80300999319@DM6PR12MB3577.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cz3kFHKUVGlpshusiXp3U21fDkPf9JazZRKrSELs+6S1ZUo4UQYuKxP8gSiMY0cdls1WeUXkO7EVUuJoFsAD38uZWAITF016b4ysmzFInuMb6llDuWddH5tHE7yuMe3vmTlXUKZPYiu5ieDj0fWYQqXYw9U9yd8GkJXR4IYCNhhTwg68d2JYgj56uvGFT2h3D5B1yzigUHEreuDgTKfStbf0JyZ9AXWBgRm6E0eNFNNmfyuGqhKOkaNAO1O3TDXXRcoPdzM0MeuX8/MPQOSQ+QRF/d/NMYpK/NHVloYk2PtzZdX2yxOzsrk+zUyTCWsahq9fGqo2sy6uBEVjGU94WLhlYrnWqTWY9pNpzfp4Ns3hIQ0hI+Pb8X0ZualPhj4C6mBVZMkL7sHJNepNjztgJ8dL8Oypf+t9wKH+zfhJajl9DMBvwxQqX8fBKTn6qJlAeF+6R8CDzYwqVGm0JIgezIC/Ncr8izc65UKlGeGiFtg5oDo+sLdBLqgpIiMF+e8CO9iFsd/lz94MQuW4pbF7uwFF9QcN+kFHio5WpyNIZVzarePQFqYDds2u/CIQ/+K9wTn75VeSVIZ+XQwZb4/QryLyve2mvsdPI39nriIqdcYbT6AUxpwYkvOZXYndaa7qCUII7k7C1IWCjy8d2PWmNLJ1vRe1A7BcNWrTe6mIkwSii+auaw7g5bz8ARJ+MmGt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(44832011)(30864003)(6512007)(36756003)(6486002)(16526019)(186003)(86362001)(52116002)(38350700002)(38100700002)(8676002)(2906002)(5660300002)(8936002)(478600001)(316002)(54906003)(66476007)(6916009)(6666004)(66556008)(26005)(83380400001)(956004)(55236004)(1076003)(2616005)(6506007)(4326008)(66946007)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lx9ExPBzrr5FBBFGiwu4nipb5Kvq2JtuIrL4rPlTTSH9ubsg0QGROK0U4Bgp?=
 =?us-ascii?Q?379hpdgl5RJNCabVv8Jc9Kyh3CyzqleX+HbincJUDz+o7e1RDQ17ZlX4G0wF?=
 =?us-ascii?Q?Xwa8GdAEA9F6gsoX0MU7J6dTRN6u8E23dnF/i7oAfD9cC/tdv1s5MT9f7nPH?=
 =?us-ascii?Q?lGsiom5Y0Tx/jDdAjM77q9FTlvD8t5af5i5JsoawXcMwqVPPJz0++nxlWwyB?=
 =?us-ascii?Q?5dnVY2Qjm2ye8JrbsKJxpPQyEGytAjHy+/2seiNp6JOVZK0dWL1z4cAKifho?=
 =?us-ascii?Q?OxoEkI76eXTdxWn8Uh6K9FVrYk7AqEKZjcqJ5+vtm1u2AyYln1ftt1MAqxKi?=
 =?us-ascii?Q?PcdEWp1bQu+XlHRrksfpR9uzjJ8nUwscdaIAlG7juXsBjGuRsFY+/ifqwi6w?=
 =?us-ascii?Q?m72reTB7S8rXeQ0uIji8NFp7rotGGWWpkE19TJuE3HsgcxmoLzpDiAq/nfzY?=
 =?us-ascii?Q?dEEuf4j+mAuKXG7orXoZ1iOOJzytzfU/JyKhjxkjo9YEe1uZfHzVoInCArOw?=
 =?us-ascii?Q?AokD3UJaSlTQWO1Bo+ZCofr7oFCq3gjMiaGhvxoEmwbKQQ2WfiEzYt1P1+Jj?=
 =?us-ascii?Q?L9ud1S4aVXzGyCMQPsfl4qcgwtrMUTXd+1qA/WeOmPijsXkzfhSKGg3KSItu?=
 =?us-ascii?Q?gZu6WA1btheFxBcWMM6avfumwlG39PN47aLkaFUjjFOphwf7W7eh2x/zLWw5?=
 =?us-ascii?Q?2yw1VOWLkHFwli/NhY/2QDgmRe3Cxn4h7unoi7yBPtobCAYJOCOTrOyqg4gN?=
 =?us-ascii?Q?TbZ5iE6bLJAVPIS2AUeHV84/hU462+by0qOQVr4Nziro4GgVwOOoRP9S9FXy?=
 =?us-ascii?Q?VWDvkwFAHIhdJ4gI+kjCQqd+wQ9HNUF6YzMZNd6uwsP2Eidh2mE+IgUd9t+i?=
 =?us-ascii?Q?23YUDsyGWFyLE4BhuJeXd8KfpGoucfz2JAX/Hn9iRxf2uNrjL4AuQvNwUj/R?=
 =?us-ascii?Q?oHZgo+Cd01d3ghIG/FDDpLxvtu/tOhyYRstGQtBdwF6+I2HQnr5nRfAag3wh?=
 =?us-ascii?Q?dbuLTo3BiGZimJBByZfzrVrn9AqZpkONemmeiV0+eactdvYdEiTPkL2V6pMn?=
 =?us-ascii?Q?joK2h1Q0ZtJ6312y0t5KqqCLwdDr6qqkEpl9TRSwM+j7RATSQOE1W9E5gN+U?=
 =?us-ascii?Q?7CHMTeAovecOmnbnIvyETLw/vZzPw6lKqWzpdA61TSQp/8q+9KHEL1GGoZs+?=
 =?us-ascii?Q?LGOAAddKib+hbAU8u70nSyFe2WmomsEN0bggBoiq+7VTkt6qsP9EK1IUm89b?=
 =?us-ascii?Q?WjR7V4ETB9N6ZC58DJw7dfWZ+Kge4wIXJK54SXY8Tf0I/zM7eDCHL/UQJ6Rq?=
 =?us-ascii?Q?X9m/pKdZOAOp5tLyVbqZl0XI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637b6aa4-d9b5-4294-390f-08d92f5c7129
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:13.3248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzYztaMaCKBF1F2l3dq/1t6uLnU363Bl4YSQYL3J9sOvP7ejabAV49uFXWiWoVIO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3577
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
index e9c14ab7699502..86f8aab9c28d5f 100644
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
