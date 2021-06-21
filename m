Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D9AC48BE5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143A460FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143A460FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA896E21C;
	Mon, 21 Jun 2021 17:12:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7D826E235
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZS6OfHiY69oy69vkFM/xu9JAGI0+8w3QMh1b8yhn0y6uX5ciq/k3TABY9//zHmX0xUuedgzscjW3jTzjlbEFDlbqr+QnXkf/CvXw+VdTXEp845oHTDjeALRF2kYP6epBE+zGbKl9TWdz62UqQR/37FD4DBJbVHLxhWD4HDyKS02R4sE22kFmIwD3260DHWR4VjapRSU92fhO7SVrqNu/94eFEPvJXBJk9vN3IPVp9yIIiRwBDCZ1dAJMHPiG/pfMop9wD6GYki3gdw1uZBpcnzEcD1LwKWBGib4lWoYREalyS1MDFcceFapPkJQUZOpdRNiWphJtE1OYpawxY6vVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+8zk/P6R4u7sVpI6s9747l+dyTCn75U+g97uujZzMw=;
 b=nZ8RuBiP9pFxnpY1dKNRXddQglgFkAt9QufU6eXpcsFRJ/7OP5d57AGqim3ymeOQsFPwsQoqms+wgqJ3w/lSx317j1q19KjHxa1chOqV+473TE0jlPsqs7NRwkusmQfqjsCKY7whBjSiep5ZFkclKzOXKvf6zpGksSCxWaH3vSJ1m0pLJLEs+b20zmMgFvZcC0ML7sAoca4PA7TPtwfI1WqV9dFB1Gstyreghil3BAqsXGS4WNc7DIs+xDEbeA7g/j/iVt2aAWBY7DV7ieAfw14z1G+Mro8Ec5ytmpo5iJbbVcD21dmC/EYBa5eqkgl/hKI3LYTI7uP8XXTJVymaGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+8zk/P6R4u7sVpI6s9747l+dyTCn75U+g97uujZzMw=;
 b=YCr7kbh46EdtSmOsdvxn0nXvbGTxr0ovxgntUDtxh+wDDSUlapAfYO8ig3GM5ZNWusaaQ+99DY67niuyqGq7eRezSaXecGoU+/AkFgZk3Pk5WVHnuwuualo83qxaMI49ksVxe/LyLtZaMd5xHK6qKEEK5I5x54/ALckORLiSAG8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:12:47 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:47 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/43] drm/amd/pm: SMU I2C: Return number of messages processed
Date: Mon, 21 Jun 2021 13:11:54 -0400
Message-Id: <20210621171221.5720-17-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 343f5ca6-cbb9-413f-3aa4-08d934d7ca55
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38653295DA33CE037F5C216D990A9@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0r6ChZ21ZaIvhtBfB3B9bXTYenho07smjBSvElStALvlhPuoj1hyvnPoGnwUfP0I9PFOmb7B/n4TiuF8PRfOwzcicvvlK7Pawob8nherT/5rx/QoLmHyXOirub+whUhHmeTJUkJJDibZlNxw2PqkZBl36xQ8jVIC5XGLMy1KMg/KKrRGT376gO9E/8bmzu3mFLv1UcbFyjEQxaQh8+EVJEM6NVPJEeBE/XuB2wVShEiJWG7wvi38sYlGijjyctGfv/xWda2FQOJ7YEn/b8NMUfqjDBe4MknqXfFf6LHwmnpJgKVOmov10bA/NBJUVFPS41XdkHaWzmaqv/5b61nS/+4WldPZkIVTk+BrAgf8UeCR/MlETkXWv3KRwlql6J2rtw2OfCmI1Ejb86UKY+inEitERUKKEAZrMDBnlS+3NmMLVxv45trxPBr/sbRhA+IBhrqrFchvDrTBuPWpRjef5FmBrs2kA5B2XX8ysWsYxnOy4Nqd7rPOpm+IomQKUzIfh4UOcoIG9T8MlFbTHMw3b8XSpsMuoh4C6Ll11mzE7Sf5GlYQuTnlYR6T5VBKOwjQ1qKSzf3TDRCEtFOUeqltOwvim751Y6jvEsPIsFrqmZ5Wg6XDyhnrDTFzKU/6RrXnv4MKTl4qNQjMKlytgwEqKrq9buxcXjegE/69weCLySgIzLO38gLkHT4PZ9TstZb0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(478600001)(44832011)(54906003)(52116002)(316002)(66556008)(6916009)(66476007)(66946007)(8676002)(2906002)(15650500001)(5660300002)(956004)(26005)(6512007)(6666004)(83380400001)(1076003)(8936002)(38100700002)(38350700002)(186003)(6486002)(2616005)(16526019)(55236004)(36756003)(86362001)(6506007)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uCjBfZlVPZqYdrxG5IxOVMbschWI1HHiDEpERTgQ0XJ/Dd36g1kiyK+/9S0r?=
 =?us-ascii?Q?Bys6hH5sWf4jjS8Kx65qqYbXdUk83oWZN85OtZDdzluNjZyYS1DOjsI9iPZx?=
 =?us-ascii?Q?jL2z2Rs3mK2hSE8SFVq6zdM/F8dKYJiHCHuLLg3R849mCmWqnzXz4fWuXBVd?=
 =?us-ascii?Q?WK3dZlc21pojEezwncchkg9LJcyQtC0fRH4/e43CN5wsZzFfMlC/iQG9xgfR?=
 =?us-ascii?Q?w1Z/uLSxhSRI2Yr3AGOa1xoKc9pLhbjuvf3He/WSmyAtSaEr4o+44LjLskOx?=
 =?us-ascii?Q?Gjzpyd8m3IapD6EdNjCBmbbe5y4dilXAWfIauS/UEOpQV2qVVbsWtU3RjkkM?=
 =?us-ascii?Q?wPt47lsHU+rjwj+Xd7OSJaUs4+qu5zeFiW4Hy5cNT8v7tNWzlu3uXE+eUMwE?=
 =?us-ascii?Q?4gElTnlIwA4VdljXBeVHDTpU/4KtgLjsVprI2pBkZO9T9FJJxPvLXbDED+gb?=
 =?us-ascii?Q?ne7n6ELQDW0VG8Jt59rxgF4yf8p2FiuiiESVEoSpABXQulgS3M4Y1sttkAU2?=
 =?us-ascii?Q?yL1t+5O4/zpryzaZ83AnI/UC8YCGRN57Y06J7a4PztIsIsgmc4assKXvbegJ?=
 =?us-ascii?Q?AIrRnMFX9pGiwgiPg3d/YpZ3f1S07Kv/5JLQRtf040DY6G93MEnp8bcUC6yt?=
 =?us-ascii?Q?FRf9NsGIvwnlysVIULpPrTt/SEYoz1SO1akJ1j+6ePYnGyBWACyTGOGtGDvf?=
 =?us-ascii?Q?8K23g16rF2DrqLEyUqTbQ8OqbRZsGOZpC3MfY0t0QiefVYub7NjFqOH1w1Q8?=
 =?us-ascii?Q?jkbU+t2bm+4ONxTgvNrDxIrt/kDNRpq1pmcws8EsaBZm269MrZ4OtsVeM1Sh?=
 =?us-ascii?Q?ZO2L0FZX6eTh4CB/fhXAyIE76Xt+pPVPqAvKO6jvSECwhFWR76Je+YopXFfB?=
 =?us-ascii?Q?M2jK9WJvCoPuXBExy0bVqNEROKjYdsYCvllPchYUmgMqzOwGETwX/2c++c+W?=
 =?us-ascii?Q?MpR4n2RnyRZqoZkkFBjqnPZJYfln6tibqYlcmOLBk7A45dLzsue1KxwJRYfs?=
 =?us-ascii?Q?N3TNWijSHMm+nmeg56zrjGHPg2WNet2kfCqEuHoSflpLIw2Am7bappElKR/H?=
 =?us-ascii?Q?yFAPYB4SmV4v1u7GBybjQ1O2wiLIPRzfwqbnTSkKxzEnIbOtfu7kF4FLKTrN?=
 =?us-ascii?Q?byFEez4IWFHqixbHEqGH45W8rty6hFoeaa8qkHob0zd+2jtF4xoEZHgLJRPI?=
 =?us-ascii?Q?b1dQguA33GGOzPIr0q8o2t99ti+g1620jXRDUpijcD4QM/5vNhQXDItyf8Mb?=
 =?us-ascii?Q?taKnIZu2bLlE7qS8wvL8A7aObfDe4O/yxSOPaAOXOLv5zealFzMZF+bJi8Ib?=
 =?us-ascii?Q?kqwLl6oFNFeojJMX7zDrGg4g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 343f5ca6-cbb9-413f-3aa4-08d934d7ca55
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:46.8221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/kncrxDCCFVD+LVAfAVMKMweapSvjqNJAWhVuT6xdHmn1T0IuE3GYu9AaLprVMX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3865
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
index 8bd3fa2ef7efea..7018716b6c8585 100644
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
