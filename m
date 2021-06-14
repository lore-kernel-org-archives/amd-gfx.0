Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEFFC48BE8
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3DA061378
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DA061378
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FE8D6E118;
	Mon, 14 Jun 2021 17:47:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4476E0F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpEQG5ZXrwzCm9rNVyO2o18GkcYTRlmqpuDotFaYY9GmVIp6mq/TeZAXIiAyf/hjVhKlYOw8lI/cNgObOW0Lu5OSlJF9VDsCvyxPAnVsJF8EW9reOtLbKkZpZyfXrsbdKfANNSRPgqmQWU+PsSNPrKGlTshEHMPnEnGGmOqWnZxUB1vz1likeZ5CPtAsUgHkOiFc2+bbtv1gHRfgivhIpBbA+vp+kWjr5+mNf2CkITmkZ1BiKRvbuNz1miSVjqN52NYK9nXDEn8wd6XAzQHBhHUupdd9F5O4Ga36uCU5/jTztDjmELus489o+3rW5yN+A5A8wjrShGoJZFVZE3j4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTKGP4G9pNEbR8mwToLCY8wds3uceWZyCRpE8c3vyAk=;
 b=KJeD9Raoci+N/JkpzVsTWPdBiQ1sbigJ1raAtdudMP0YhdBq31swU/8TjgcjTfMZs5O5/fGLn4ZDRS/d1Frk9tOtqIyl+DwDvH+pgyzK2Hi2Z+w2k88a6wIbUiYUSP4w1maKAePEKiin6HRIcBCOFGNl/pfgbx5nHts1PM7EBDhlINFdD3n5t8+9Jt4x/g8ZYyIbm1gwXf6SzNUbKNSUq7IpehFfXeEE2FAECDvZlvXspvJA47SpsvVhvObtkGcFgkHPGMJsrwYr+dPNYXkaccsBjCGN0hdNn6mLcUZY+rxjO3CGdO/FUYDOPYQUrZHLGFHRhLgcvHsFYUPgLtegyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTKGP4G9pNEbR8mwToLCY8wds3uceWZyCRpE8c3vyAk=;
 b=QMNJgzd/eEAIuUsJwyDuj6JXJ5s1OAzX66zRm4sGn2LD80STw2CTHbMvcVFsDfSYRoCveDM8GtbMLZ7qLr3vuVRXPojn+es5lT+2pRfuN1VcO/VGAcK4KnSzgaTs8f4Ak/TOP62Rzzn5Obkm5tgzUbE4Wrf4tXF8VVy+MumCDJk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:47:02 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:02 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/40] drm/amd/pm: SMU I2C: Return number of messages processed
Date: Mon, 14 Jun 2021 13:46:08 -0400
Message-Id: <20210614174632.20818-17-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:46:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55b4e4d7-7b30-4a73-aa30-08d92f5c694c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4748E52577BE3BA2AB44CDEF99319@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XG4NTOXVPaUi1sM+5Nn9ntPGDiGFAJPg7e8MuhSWd4mS/iPI4w4Vr5BcuVtSLi+QPbsyc06O1DRgyyj1vSAXEjx1EkFpIXvyHJWlryK0s7zDWYxdAY5hiPiTYhyo1yFZxTutJz+HYTrbyWsKxFXUTKCI//FU1MYCEH4uvBini8Yw0qEgII7U3dEeT/wiypj2ZHblsC0sMJvaiXp0QZ2kqwitotsXtDSqriPPvImjZ46u/5Pd6aAM7ybkPvRzbR3K+6jSebboJS0uixNMxubRkIJLiX4X3V4CR35Sq1CsDfstl0too6WR4PDQgLnzQMO8PbAfHd3UyJaKvrpwBigNi5GECEqGbivpOq45JTW/H78wQfTDAXpvr/h7apEaNHaPC3vqaUBsM24oa2zKdflaiEyeDIiVeFxE/ChTFo3yZsbRkSqWhRftYccoKMuxCffDuvCvQXpmcWfDUM6qGgnKWAovQw3rlp3xvogDhjdWd4PQ5/iuNyF8BAYiex2O2yzj8ZIsmlwrUUiPhJI1ZwyAVm3ga9PdsxtY7EUNjVxsiF8WvIURKKcAKpzIrOL/xF12QaAQEk8fgzHTmYXQfTkazJczYksbbdH4YQzRdLxYTWeepOps5jcs+ZdyONMBlgNvTY/EI2tG7ZfILfBmBgQUJduVNhKQOK3UoYIsF19FIA7eKGhRifzMVcBNael/kDU9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(1076003)(26005)(6512007)(16526019)(186003)(4326008)(6666004)(38100700002)(8676002)(54906003)(2616005)(956004)(2906002)(8936002)(66946007)(498600001)(6916009)(38350700002)(83380400001)(6506007)(5660300002)(52116002)(44832011)(86362001)(15650500001)(55236004)(6486002)(66476007)(66556008)(36756003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h/ePN51mFIzNICeJE04P3E/Oc6H9cC8pwIzBKuGZKH1VwSVwgkQhvi4bpzgV?=
 =?us-ascii?Q?DGbwloOyhgbwUMmGIWXshvHKmAhfMCuVAdHo38edKgKiw6B/z0qpJJdrX3+D?=
 =?us-ascii?Q?+dJ1reyv/M6bbpZDZo+b8Sk6w3srAHOi0vgigphdrtcmri+RYHFwMLhdD3Q5?=
 =?us-ascii?Q?Dw606vfe2ZFwKgDrZOObtLZ1FUu1XN0RWuR3y26puiOCKNhGlQVsLlcSoQTX?=
 =?us-ascii?Q?spyi9X/3PNSGFrOKOWFEdodz8/vpuojsdOLRyB2jSoxprCOnW0MR/9d9qYOe?=
 =?us-ascii?Q?TsRki9J+k5buX2uDXhsMYCaOBX5Hhr4u/dIHtTm6Ew0uDeVKlJMTyNcojVTI?=
 =?us-ascii?Q?uIGgTpBjOgX1Hc/BMLajWo9xNni9TfA5KVbbKE3Ly/NnVfKid/lISbJD1ort?=
 =?us-ascii?Q?LBd+YNLbidI7zvD8GwzoHJE4d3sAiz/58Z0gXBbphsQsKkN1aPW0Hi5DYHYt?=
 =?us-ascii?Q?GEo5c2QROqJyx9w3HY5y2DWQGTUKKlGyi2QxU8u1y3tqURJNu3Jx2a/qR5zp?=
 =?us-ascii?Q?RoOV9/xkBBFR//2en0bzUI0HoHEQ7D6cnxpUIvyqTpE7G5odbFLrWWQTXoLs?=
 =?us-ascii?Q?2hcPiww8NHyTo2KWZD1hSBtZ8pIXg4kfkGjw6Lete6kK3lZXTadqyb5t6lM6?=
 =?us-ascii?Q?61dyyH1S4d/mo1AUvmkuQsCrQD2ggKLifpc7gSzi8CryiGzAIIelTh/wIBw9?=
 =?us-ascii?Q?DhK1WnF8GUuPjlEr3efxbmoqdS7Bi3AQOHEwQTmjCOriJEr7uabvFHRBx3lk?=
 =?us-ascii?Q?5Z7dEMRB3FecQTX6+ZM40KZptOlj+YGDED91bqQy5f+3PSvPlPhqvfnE+v/2?=
 =?us-ascii?Q?rUV+9R8qQmEu9f3DbCrcstCQWGrQjUP8SsVRYp+kdyC8xKr8k7PYs33QlJzb?=
 =?us-ascii?Q?8yBspTU/6zjwPTAuh/0mz4oFgOCiiDdk5N1JCBsKQpq7EV/14eTu5dzIwiQV?=
 =?us-ascii?Q?4RcFcb1eipTPQlz88RFAvJ751B3Ch4HTjxUX6fnUszICc331Nzt8jxN6eu9m?=
 =?us-ascii?Q?asYEMTUoEWrM/eqJ1DU4kzxmdcIOUkwvfQVZ6wSB9+4XAUqvoaaZB8fz2OSj?=
 =?us-ascii?Q?ASTL1hADjf9kTujNpao/fXqCYIZScTT+BviywWQkmZnvJ7oi2URo2yrdr+NQ?=
 =?us-ascii?Q?fZZpInYTu8RdbH0fTOW9ERZE8M5K1t2hynovYKG9rgFDbC2K+f/A7NGWDdbD?=
 =?us-ascii?Q?JWTSITyWNvpZ+oTB4p4VC2HBpjt6ib/PwfaPMEwRVTY2s75gi07NowgDV1FS?=
 =?us-ascii?Q?QaYkDaKq95dxHlmCoeooLwLKge04v7U1fDw8akZBeeRy4k3lIRgBz3+e02D3?=
 =?us-ascii?Q?B/IystPleMi48BkVP3PhzBeM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b4e4d7-7b30-4a73-aa30-08d92f5c694c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:00.0983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDKKISSAl5NLYmLn1G8ygJ9JmDGyhJ1Z2jEFzPXyVZMy9iqQSnvdYk5Idwe8lPVp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4748
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Fix from number of processed bytes to number of
processed I2C messages.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 43 +++++++++++--------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 43 +++++++++++--------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 43 +++++++++++--------
 3 files changed, 75 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index fde03bb6ffe7c8..c916ccc48bf67f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1943,9 +1943,8 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 	struct smu_table_context *smu_table = &adev->smu.smu_table;
 	struct smu_table *table = &smu_table->driver_table;
 	SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
-	u16 bytes_to_transfer, remaining_bytes, msg_bytes;
-	u16 available_bytes = MAX_SW_I2C_COMMANDS;
-	int i, j, r, c;
+	short available_bytes = MAX_SW_I2C_COMMANDS;
+	int i, j, r, c, num_done = 0;
 	u8 slave;
 
 	/* only support a single slave addr per transaction */
@@ -1953,8 +1952,15 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 	for (i = 0; i < num; i++) {
 		if (slave != msgs[i].addr)
 			return -EINVAL;
-		bytes_to_transfer += min(msgs[i].len, available_bytes);
-		available_bytes -= bytes_to_transfer;
+
+		available_bytes -= msgs[i].len;
+		if (available_bytes >= 0) {
+			num_done++;
+		} else {
+			/* This message and all the follwing won't be processed */
+			available_bytes += msgs[i].len;
+			break;
+		}
 	}
 
 	req = kzalloc(sizeof(*req), GFP_KERNEL);
@@ -1964,24 +1970,28 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 	req->I2CcontrollerPort = 1;
 	req->I2CSpeed = I2C_SPEED_FAST_400K;
 	req->SlaveAddress = slave << 1; /* 8 bit addresses */
-	req->NumCmds = bytes_to_transfer;
+	req->NumCmds = MAX_SW_I2C_COMMANDS - available_bytes;;
 
-	remaining_bytes = bytes_to_transfer;
 	c = 0;
-	for (i = 0; i < num; i++) {
+	for (i = 0; i < num_done; i++) {
 		struct i2c_msg *msg = &msgs[i];
 
-		msg_bytes = min(msg->len, remaining_bytes);
-		for (j = 0; j < msg_bytes; j++) {
+		for (j = 0; j < msg->len; j++) {
 			SwI2cCmd_t *cmd = &req->SwI2cCmds[c++];
 
-			remaining_bytes--;
 			if (!(msg[i].flags & I2C_M_RD)) {
 				/* write */
 				cmd->CmdConfig |= I2C_CMD_WRITE;
 				cmd->RegisterAddr = msg->buf[j];
 			}
-			if (!remaining_bytes)
+
+			/*
+			 * Insert STOP if we are at the last byte of either last
+			 * message for the transaction or the client explicitly
+			 * requires a STOP at this particular message.
+			 */
+			if ((j == msg->len -1 ) &&
+			    ((i == num_done - 1) || (msg[i].flags & I2C_M_STOP)))
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
 
 			if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
@@ -1994,21 +2004,18 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 	if (r)
 		goto fail;
 
-	remaining_bytes = bytes_to_transfer;
 	c = 0;
-	for (i = 0; i < num; i++) {
+	for (i = 0; i < num_done; i++) {
 		struct i2c_msg *msg = &msgs[i];
 
-		msg_bytes = min(msg->len, remaining_bytes);
-		for (j = 0; j < msg_bytes; j++) {
+		for (j = 0; j < msg->len; j++) {
 			SwI2cCmd_t *cmd = &res->SwI2cCmds[c++];
 
-			remaining_bytes--;
 			if (msg[i].flags & I2C_M_RD)
 				msg->buf[j] = cmd->Data;
 		}
 	}
-	r = bytes_to_transfer;
+	r = num_done;
 
 fail:
 	kfree(req);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 666b090e663894..d734f51b1cfaa4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2742,9 +2742,8 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 	struct smu_table_context *smu_table = &adev->smu.smu_table;
 	struct smu_table *table = &smu_table->driver_table;
 	SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
-	u16 bytes_to_transfer, remaining_bytes, msg_bytes;
-	u16 available_bytes = MAX_SW_I2C_COMMANDS;
-	int i, j, r, c;
+	short available_bytes = MAX_SW_I2C_COMMANDS;
+	int i, j, r, c, num_done = 0;
 	u8 slave;
 
 	/* only support a single slave addr per transaction */
@@ -2752,8 +2751,15 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 	for (i = 0; i < num; i++) {
 		if (slave != msgs[i].addr)
 			return -EINVAL;
-		bytes_to_transfer += min(msgs[i].len, available_bytes);
-		available_bytes -= bytes_to_transfer;
+
+		available_bytes -= msgs[i].len;
+		if (available_bytes >= 0) {
+			num_done++;
+		} else {
+			/* This message and all the follwing won't be processed */
+			available_bytes += msgs[i].len;
+			break;
+		}
 	}
 
 	req = kzalloc(sizeof(*req), GFP_KERNEL);
@@ -2763,24 +2769,28 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 	req->I2CcontrollerPort = 1;
 	req->I2CSpeed = I2C_SPEED_FAST_400K;
 	req->SlaveAddress = slave << 1; /* 8 bit addresses */
-	req->NumCmds = bytes_to_transfer;
+	req->NumCmds = MAX_SW_I2C_COMMANDS - available_bytes;;
 
-	remaining_bytes = bytes_to_transfer;
 	c = 0;
-	for (i = 0; i < num; i++) {
+	for (i = 0; i < num_done; i++) {
 		struct i2c_msg *msg = &msgs[i];
 
-		msg_bytes = min(msg->len, remaining_bytes);
-		for (j = 0; j < msg_bytes; j++) {
+		for (j = 0; j < msg->len; j++) {
 			SwI2cCmd_t *cmd = &req->SwI2cCmds[c++];
 
-			remaining_bytes--;
 			if (!(msg[i].flags & I2C_M_RD)) {
 				/* write */
 				cmd->CmdConfig |= I2C_CMD_WRITE;
 				cmd->RegisterAddr = msg->buf[j];
 			}
-			if (!remaining_bytes)
+
+			/*
+			 * Insert STOP if we are at the last byte of either last
+			 * message for the transaction or the client explicitly
+			 * requires a STOP at this particular message.
+			 */
+			if ((j == msg->len -1 ) &&
+			    ((i == num_done - 1) || (msg[i].flags & I2C_M_STOP)))
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
 
 			if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
@@ -2793,21 +2803,18 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 	if (r)
 		goto fail;
 
-	remaining_bytes = bytes_to_transfer;
 	c = 0;
-	for (i = 0; i < num; i++) {
+	for (i = 0; i < num_done; i++) {
 		struct i2c_msg *msg = &msgs[i];
 
-		msg_bytes = min(msg->len, remaining_bytes);
-		for (j = 0; j < msg_bytes; j++) {
+		for (j = 0; j < msg->len; j++) {
 			SwI2cCmd_t *cmd = &res->SwI2cCmds[c++];
 
-			remaining_bytes--;
 			if (msg[i].flags & I2C_M_RD)
 				msg->buf[j] = cmd->Data;
 		}
 	}
-	r = bytes_to_transfer;
+	r = num_done;
 
 fail:
 	kfree(req);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 7c266420e31cc7..8f8e5c7df44a12 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3449,9 +3449,8 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 	struct smu_table_context *smu_table = &adev->smu.smu_table;
 	struct smu_table *table = &smu_table->driver_table;
 	SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
-	u16 bytes_to_transfer, remaining_bytes, msg_bytes;
-	u16 available_bytes = MAX_SW_I2C_COMMANDS;
-	int i, j, r, c;
+	short available_bytes = MAX_SW_I2C_COMMANDS;
+	int i, j, r, c, num_done = 0;
 	u8 slave;
 
 	/* only support a single slave addr per transaction */
@@ -3459,8 +3458,15 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 	for (i = 0; i < num; i++) {
 		if (slave != msgs[i].addr)
 			return -EINVAL;
-		bytes_to_transfer += min(msgs[i].len, available_bytes);
-		available_bytes -= bytes_to_transfer;
+
+		available_bytes -= msgs[i].len;
+		if (available_bytes >= 0) {
+			num_done++;
+		} else {
+			/* This message and all the follwing won't be processed */
+			available_bytes += msgs[i].len;
+			break;
+		}
 	}
 
 	req = kzalloc(sizeof(*req), GFP_KERNEL);
@@ -3470,24 +3476,28 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 	req->I2CcontrollerPort = 1;
 	req->I2CSpeed = I2C_SPEED_FAST_400K;
 	req->SlaveAddress = slave << 1; /* 8 bit addresses */
-	req->NumCmds = bytes_to_transfer;
+	req->NumCmds = MAX_SW_I2C_COMMANDS - available_bytes;;
 
-	remaining_bytes = bytes_to_transfer;
 	c = 0;
-	for (i = 0; i < num; i++) {
+	for (i = 0; i < num_done; i++) {
 		struct i2c_msg *msg = &msgs[i];
 
-		msg_bytes = min(msg->len, remaining_bytes);
-		for (j = 0; j < msg_bytes; j++) {
+		for (j = 0; j < msg->len; j++) {
 			SwI2cCmd_t *cmd = &req->SwI2cCmds[c++];
 
-			remaining_bytes--;
 			if (!(msg[i].flags & I2C_M_RD)) {
 				/* write */
 				cmd->CmdConfig |= CMDCONFIG_READWRITE_MASK;
 				cmd->ReadWriteData = msg->buf[j];
 			}
-			if (!remaining_bytes)
+
+			/*
+			 * Insert STOP if we are at the last byte of either last
+			 * message for the transaction or the client explicitly
+			 * requires a STOP at this particular message.
+			 */
+			if ((j == msg->len -1 ) &&
+			    ((i == num_done - 1) || (msg[i].flags & I2C_M_STOP)))
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
 
 			if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
@@ -3500,21 +3510,18 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 	if (r)
 		goto fail;
 
-	remaining_bytes = bytes_to_transfer;
 	c = 0;
-	for (i = 0; i < num; i++) {
+	for (i = 0; i < num_done; i++) {
 		struct i2c_msg *msg = &msgs[i];
 
-		msg_bytes = min(msg->len, remaining_bytes);
-		for (j = 0; j < msg_bytes; j++) {
+		for (j = 0; j < msg->len; j++) {
 			SwI2cCmd_t *cmd = &res->SwI2cCmds[c++];
 
-			remaining_bytes--;
 			if (msg[i].flags & I2C_M_RD)
 				msg->buf[j] = cmd->ReadWriteData;
 		}
 	}
-	r = bytes_to_transfer;
+	r = num_done;
 
 fail:
 	kfree(req);
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
