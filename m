Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CB6C48BCD
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63DBF610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DBF610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C3706EC42;
	Tue,  8 Jun 2021 21:40:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 696C86EC42
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oe+yP0Tvi5FItcFfBzWjRZwAWF279mhamaUV3T++RjkxYPXcqcWz9GgPOCSgtMt9KCB9xO2bEKrMOs1FF6IbmZzhojxbYhlgGkfwLc52hkaqIc59wdaDFObuB8pNpMMWcZ2AFeGKPJecraaeoab0g9hAComGT317zGo/AIvSBsoYk7hKuMH5bGv+448XFVAvnKTnQbtTWsPhIkrV2jIM+9iVn5ggoKYvlHNiZ0w1pkGVHO7Qg++xZ7Kr9hJsT+XkqtD+1Jm+VZi0rLP5+aK7RuOEZ9ULwB2//mHInhoatHZciFbcPKYQYSRC+VcBjs7wCJHBmd7xfxYxv3AlJ/WBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwQ5zqqXSksgrFXJy7VbzrVZ8oYIbWHnNFoy4P2w17s=;
 b=nPZ8r/ZQuBJ4skrBVBTLuxYqeM45X2zYjbOtjcdnT6Xp4y/wormgr/3NmlB2n5vkK5wj5huXeM0RAi366EfVufEPXGWwvEBFQq7CDMoUTo73d5c6NLrYi4C3u7IMyYLNRG3Sfxn7WOCxYMZ7s3NoTCJg8JmPm1WQBPNnjgqNlnEfwQVv+/eYT4QrmiwnkNWPX8Kwsf7DRxwHKFh0ORY+46KeOaAaBaleShlT9jO1E8iz+szVMF4Zl2hCRNLMHTeDuZDkAElWp5d7oTaOvYwlXDMVkSr3fYBlkCJI05+3a4skQSscgOv0uRugH+8Ebem0nJoDtY3j9Z4HNqt107zy9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwQ5zqqXSksgrFXJy7VbzrVZ8oYIbWHnNFoy4P2w17s=;
 b=m7v1B3r/6VJgp4QEI3d/Lyc3bb4jga/W4yDRWNmkeMCZwaWJ4ltYghG3/WOSHqfg7zoBkcnJ0BSoa7Xb3iAfH/6d9SnJjjn35rd08nzNpeJMnswqe5sG6zKBCHSAUqDxQHFNQZGa/YnQx9seuEX+ajJmUlMpfibhQUzGCDiAqUk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:25 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:25 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/40] drm/amd/pm: SMU I2C: Return number of messages processed
Date: Tue,  8 Jun 2021 17:39:30 -0400
Message-Id: <20210608213954.5517-17-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a2b5319-2073-4715-d6fb-08d92ac6069f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB443598FFACEE93A0C8719EAC99379@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hrUA4r7TlERzXqAPi4Le/oFQg/XJx/E6xrV0LI9joiKV63/X1keEfen97WrudjIvYi3V09Rgs4cPjZCQCsIY94u7R6HdCMBOQOecp8HIUG1L5YFO+Cneb5gd2at8CVNDeDQrvE7WE3p1sWM/c75132M0N11RmmhpZP5lR11yuCfKFaPCGez73msv11OBdSzA5uzC7GqgQzXOrgKDYxOiSOhZXLNZElHpImcFrzH9GtODEA2fcACoXTXNf737NwE+eFLVvdgAk4VkIUf5wfdcK+6igFr9oe02yq2h4MfyUb1Yj384dJxw4wWmcCRiN/PkKAmYKP2/jzXvaDAiviPxdkvXSYJUqqT4xiIbI9PYDBT7ubL8df8KAm6FmyTo6R2aUJRia3tgwXrNIBeS/3LKdj79zY6GnUGDGdX/X+XNmV8A7iZlAmJ4eQccWv0ikpyyMoKzIMuh+qXr3wRUR3DEMRPDbf01swaoFEt8tLmx/uKy2+IsXgpOozrUfn+RgAkse219bJFjSyhOgQWipzr/ix+YNuDUEszQNX7TQaABDeN0ljK2PIIvLBCndufPNtvlvVfHBx3kSA02ziMVCBL1v2ew9JyaV1D0L7FWUCTgoo28MvynwM8ZPC0fOEiaeEDVZ9xb4p6zIGTnO7Tiw9pE+TXxSLItL2inl8O8FfaGjXfVC55090iyF6UedB2iu5bw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39850400004)(15650500001)(6916009)(8676002)(6506007)(6512007)(36756003)(6486002)(66476007)(38100700002)(38350700002)(26005)(6666004)(16526019)(1076003)(8936002)(2906002)(54906003)(316002)(4326008)(66946007)(186003)(5660300002)(66556008)(83380400001)(52116002)(2616005)(956004)(55236004)(44832011)(86362001)(478600001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tl36oimS1u1gQtdK6Ir5I0vteLmE+IcmfG7ifKLye0NN/qJvgdwr2a4rlHY4?=
 =?us-ascii?Q?1qQxtRes3g1SI+RDDU0lrgmjp7luUGsSSKczQE8B+myfsSoFM25WTyy3CuEc?=
 =?us-ascii?Q?sWvmT40jaKkuhnBPaWjt4VC1+XDPjenEvYQ/WhqXyTouC6kD/xVKhJjVgx0r?=
 =?us-ascii?Q?UWfAt7jKXKMAdpHcj8D66ENwaLmIAGf+UVNbDbQaE76MK2syOVH+NIuLus7n?=
 =?us-ascii?Q?h4icAmxq5gtSQoTiZzvsPfC5ebeDn+vYO78ZPZWY43omZ94ClqzPISDQ1DiZ?=
 =?us-ascii?Q?gUEVW/AoiDJ8ce95nKkfMBup/SnLaZGTGYX00u1GiVzohKlSE7Oe2lO3Uyhd?=
 =?us-ascii?Q?1k/lIfYS+k0fxkljRReH3Bw24d1Qfye6f00GQidmKKviVCr0PEaEGyDfiMQx?=
 =?us-ascii?Q?uttCeUYdtkuba/xzBkE/JirzkkmqqEV0YL7kTQnbvGd2BVpVH4ZGv0DuW+g2?=
 =?us-ascii?Q?1agbZTbHRXIcZgUrYQNBiMJuZ9Ds++EM9mG29xe34oav+SMEIYcT8RFhIp1f?=
 =?us-ascii?Q?46S52tlEOQdM6gArT7aNwBuQ4sbRipXt7Hrhy5iw3xPAx8Gn2N3eVTmckntn?=
 =?us-ascii?Q?oIXWaRFVbubBEZWhFSPYaIlwedwZc3/w7Phxif20nFVigTXgBdwxldSBnvdx?=
 =?us-ascii?Q?SUbS/4gliRiWStizi0RA0v+bs/wQoOUr5CD5Ccsj/VNybiNbWr+xMWURtNXF?=
 =?us-ascii?Q?WICoIH5AdN4jbp2KOcpRfTG1UTcGpFX0Oc6r2muOewh5db3GxSTZRfIZzCZN?=
 =?us-ascii?Q?Z2WRJTEsvkIAOgcGbvzQpr9XjMmS8/D3/KOj5wuKJaRYY6az6/8kEq7siTGq?=
 =?us-ascii?Q?3qAUXkj1/xY7DveBaO6K3dvVTK9TII9O40TFBZ2hu/CCMrxFS7Y6M1UpTXFB?=
 =?us-ascii?Q?WVIbn/jC2PGLqMslznnVwJVgZ0jmH40klfNRzg9mg9NkP5/ACBDPvWyqoO8h?=
 =?us-ascii?Q?nB/63vmeF0D8rGodKiI3FpnVT9jmA73rw6g779fPVuCmwIFc504ZyANs8JVS?=
 =?us-ascii?Q?YeSy4GADCWYwkIv2JqUpv2PJWPS7G6dGX3iz1Df9sHpJjJLs4mcMrnDR6pGh?=
 =?us-ascii?Q?z4yOidOa/o9AAmTZVdYXQiVb+DJvUw9QoeWUWmPzV/F6/HysfWaTZZCjkxDf?=
 =?us-ascii?Q?QwnPll/APMVR2SCFzCqpGBSPPvOfk1CZy4HDTVuuJNKnSYlyOTie7DsHNue5?=
 =?us-ascii?Q?rU2RDZqECBKyGk+1CSYfKiIPtMZc1Bog305E3FOtsUuCiIa1Se5SvUfuz2Qi?=
 =?us-ascii?Q?nq1N3ocB33e41XfjtWUaPGG+JlXVBh+8dXCoxmFgPmiim4gUyo9fF9ZFvE5X?=
 =?us-ascii?Q?jkGGSQYsSlb68b57EXWnZhNa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2b5319-2073-4715-d6fb-08d92ac6069f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:25.3884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yr7rmq+nvkOgDzcQGnoTe/JmOjvoaQ8i5bTzS3Bp3OxDSfHiGYIHC2dCY5U2SlAt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 43 +++++++++++--------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 43 +++++++++++--------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 43 +++++++++++--------
 3 files changed, 75 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 235e83e9f0feb7..409299a608e1b3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1913,9 +1913,8 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
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
@@ -1923,8 +1922,15 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
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
@@ -1934,24 +1940,28 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
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
@@ -1964,21 +1974,18 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
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
index b94c5a1d3eb756..4010b891f25678 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2708,9 +2708,8 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
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
@@ -2718,8 +2717,15 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
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
@@ -2729,24 +2735,28 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
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
@@ -2759,21 +2769,18 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
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
index 2fa667a86c1a54..d5b750d84112fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3396,9 +3396,8 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
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
@@ -3406,8 +3405,15 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
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
@@ -3417,24 +3423,28 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
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
@@ -3447,21 +3457,18 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
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
