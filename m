Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EC6C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7409E610E5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7409E610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13D216EC4A;
	Tue,  8 Jun 2021 21:41:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB916EC4A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:41:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkQMZ6i+M/1tlqgU4hbIE0BWoToUhNYb65to9ZKC50Emw/AZjFfndj0TDkKqe4j7iv78XfTtv7gMK1eqllM4gB9y6dFyYjYznbbCdE4Stt2+A2cBFwgs+YCSKDxRhLnWu/QvNl3a2xfEoPrpOeZNZJ7P/+3tUga4PVT1xQ12g+FID/9RDSd3IzQWp6Ij+q17mY16jaopG3Epn4HwqG2HhbRsS+t7rWIJ8KFazNVbSQr9awlnQTnxcW/P8wEV5maUQ4HYdx90xZA2zZCSssAlD12kJDKAseCka59aUUTRTbp8cTe5CUSQMUz5SU19VCrYQVap+hFtyeR0R/LBdiYVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouETkX8LOy2s3Yxn4/QAQyJ9rh3rAF6jxcRgLs/1xT4=;
 b=gBERwfXWYrsU4MjO+E0owzmXeFhrUkVRdapRAOTMiooVy5S8QmPB5OoPeOVQGjnU0Kc31HPcARQRNVaeSA+xSjz+Cy5+pLH3a0RLySM/3POuMT7B1t0cF6M/rhR+swZACYCeCiM9UgpgZcLkwnAOcm7mzZUytoh5C4sxbu5kn/Z97+BbRVuKO1tHOOP3kGt7BJ+IkUWj7wNObsaTnlZTUbGxtsppu0Y60jRP9VnzSjYtQcHfeu7IAPBnEvXDsiYikXr931ih9MBQ/+KK6fv9hRbXvoyrLBUyg8BGGQmy5GLymm3oLQLmdRkDwkbCxgyVkI2/HAWHa9ubH9AQy2Yiiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouETkX8LOy2s3Yxn4/QAQyJ9rh3rAF6jxcRgLs/1xT4=;
 b=S7BYVqJKOQ+teMtJnfIl2o1tLbs+8EyMHVDwsT7t4FhBdWIR3j+U/RORnUz8MucmPLDnvcWo3eIMfCASJe8EiaFSBGQTNTdOMFPBK03EA8bHDr/EJeh5XBZIdBNVTkB+kAs3NoPl3Nixmh5n2uvg3k3uTVfxXfYLGrGj6LhrO8E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2780.namprd12.prod.outlook.com (2603:10b6:5:4e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 8 Jun
 2021 21:41:09 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:41:09 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 30/40] drm/amd/pm: Simplify managed I2C transfer functions
Date: Tue,  8 Jun 2021 17:39:44 -0400
Message-Id: <20210608213954.5517-31-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 672180e5-c11d-4102-0ad7-08d92ac60ed1
X-MS-TrafficTypeDiagnostic: DM6PR12MB2780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2780CA38389DF86CCD10B96099379@DM6PR12MB2780.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SW+DvpNCc3ukAVemr6TEuKn6X/bmKoP6IYDd+Hr+lI1ft833pk9qDP2UaSxNfmEr8qTCL0kn+EkD+7dLcg9tK8nm/7M01vdrT7T5THSp3LG8JS2d1Yn0a/RUTZ+ehDHootA6RWeoGUQmsAhrfvdevtZrMxpkO7DV555vOcvSybJkzyUQPfypiY34p5Xqw0hAtpaJt4LwCgjP218TC/8fkdPWgIHmxFFIvrcp4lLjMz2KKv7GNiLGdwF5P9K/z+9UU8tiNcxe5qyC5BNZ8Khm73STfpJ2rG8Hc7KhEbMxFDoD/jf0iqqtVDKIEEiPa+/7xrNIAlOL0B1zMGSvYH9Xry4HYaTCHDZ6X0fcmBS+LI9/xkMMjuVykkF5y/NrKod/hrKBPtoGVzuatPM7Yjnm+LRbbPfR3cB6pySq6XmNBPVCsH9L0kmoP1dAjhB6AH6FdSt5fweST9V5SQ7Inbjeujq1fGBWa+WllYyMTggnq1BQ0lN2QS14VugXRrSsNK3rmCCqp/rSbiqZpZTtvLfmtQfZ6F5zui6NCZLV+KqhEE/te3+qmjtyhiNej6zf7c/L97aB69CU1wRYY9U2cg/0Dfky2HGmIov4JNkcboceYBdX53xkMvA0eIn6bsh6zhaB1cC4uWGXyJ/Y/dnFfEIb9XxAMhKGgRhgmjv9NfTN2l5dgcew10n665NJY6jYebMI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39850400004)(376002)(396003)(136003)(66946007)(6506007)(30864003)(54906003)(6486002)(6916009)(86362001)(316002)(16526019)(478600001)(2906002)(38350700002)(38100700002)(2616005)(52116002)(55236004)(6512007)(8676002)(66476007)(26005)(4326008)(8936002)(83380400001)(36756003)(44832011)(1076003)(6666004)(186003)(5660300002)(956004)(66556008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AHh9Ve5vb+PwTTaqSF6H0DST4B3xjj4qtekN+Pd9c5JcLtMchfudn5dgcjRm?=
 =?us-ascii?Q?vjJcoaEe0dtGHfW/DjiBzYGXN/6NDvcySmCp1BEH972Zu8P5Ue9XVWzuqKM4?=
 =?us-ascii?Q?Paz2ydXarxkm7OZzwbuQjemI3ypfRdHL2ozj2Kg4mZdmmPSz9TLrqVkTskb4?=
 =?us-ascii?Q?340OMVd9yZrRrz+efZkVuuGL0j+NNG8qLHsypUrNCLHJ3HuMzp+UWWnkVBk+?=
 =?us-ascii?Q?8lBO7LWLPCS/QW+9/pPupG3yLDWpC5LgFWsOrQbfQKoHL3Rx+SSXZeKzRs/u?=
 =?us-ascii?Q?Tykj8UF7V+Xd0ID7q6wcge68Ef3NfzChSLnpDFHMUcApmlTps76yeGq+8FV1?=
 =?us-ascii?Q?ETDhV0gTGqqaIODI2JUboG+3szKeRvbJyAjOP/uHMzBFCtFQTW4v9agHq1Ay?=
 =?us-ascii?Q?yi8DYDSzGb4MdepEjEEQ6azV235eUIKkuw+q5NCX65o38n54wDEyJHlqzR4r?=
 =?us-ascii?Q?YlLWS/3sdCJ7OlxDywSS+OHS3ytWTtt6e0F87io5un8d8eFbP6gzEdeYTAkl?=
 =?us-ascii?Q?KcZ2f0osM3pSERk1+2SCZ4P640UhZnu2aIi1POnZBX8MPoIUZsRLDQbIK66A?=
 =?us-ascii?Q?Njza6XbxcDBCsVrcWsnRlU6qqVOUmkSOt2o/T8Np5SYu4SG1Wl4CqgGr10Vl?=
 =?us-ascii?Q?0DvwRq7X1zgb5U/U1Iz6+xwJduIDq4m++hyxQjJyfZgXnRrByVhbr42HiMYo?=
 =?us-ascii?Q?HDSnp59yetwJLQhse5fwF3Z4NfNZ6H5jtcENx9a9nv98X3X5H2CzVv7b+tKK?=
 =?us-ascii?Q?wX1chX9FY9bcCu9oFPfopKleVbT1dvgXOAAonnLvaId33co/X1by6bmgsCR3?=
 =?us-ascii?Q?wr3lHiM3oXndu8CPRuEooAm+esFU/R4wMK/F8GxM7EYVT2o+wkeO2tqkkkR6?=
 =?us-ascii?Q?1+wDMnqkCm8rVwelGkwq+P7kPCyHMv7lTbpQZH3EgqzA0ZGnKT4iDi4cX3gP?=
 =?us-ascii?Q?Zl4jGpWdwmWuvxUhO6khFVeJVTd2VyF+N/6Jo2GbG1Pwed7XtilsKvy8wV+b?=
 =?us-ascii?Q?+OTaHh3WC1TnGxcGAWoh+epAn2KVACJcWRNgycDi2Co9zJEu4CgPgXqWHMQA?=
 =?us-ascii?Q?5KBCGgFmO106fvzF8hYZ+S6EMQ9oXXkXhIH0ZD0cS93uel3mucyMIB9oMqGp?=
 =?us-ascii?Q?iApDYJqSUndmAK7RHTm3M6q/nMJr6bRankVrSMkqOeJVOW03ZsWjpcpA/CnG?=
 =?us-ascii?Q?3R2+Nr6aGe3lcAVopN4bBzcW464vEQHQ2jK3alKCFc4M8bnmVY+alr9FN80Z?=
 =?us-ascii?Q?ifltGAU08u3w0XeKhC6KH1kOnD3gcqgUlYzl1gWyxMB9ZYsO4PkM51UTOb+4?=
 =?us-ascii?Q?nwqY30fE3437bYeYG5utSlVF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672180e5-c11d-4102-0ad7-08d92ac60ed1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:39.2006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7ONs0qPArbX+InH+nT+a2ntDt766CMm1JGXrSGmqS5Hl2xQBzRQyfk4sErwFqUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2780
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
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 78 ++++++++-----------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 78 ++++++++-----------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 76 ++++++++----------
 3 files changed, 95 insertions(+), 137 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index de8d7513042966..0db79a5236e1f1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1907,31 +1907,14 @@ static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
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
@@ -1939,33 +1922,38 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 
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
@@ -1974,22 +1962,20 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
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
index 1b8cd3746d0ebc..2acf54967c6ab1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2702,31 +2702,14 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
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
@@ -2734,33 +2717,38 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 
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
@@ -2769,22 +2757,20 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
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
index b38127f8009d3d..44ca3b3f83f4d9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3390,31 +3390,14 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
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
@@ -3422,33 +3405,38 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 
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
@@ -3457,22 +3445,20 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
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
