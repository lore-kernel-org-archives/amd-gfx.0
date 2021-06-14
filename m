Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B6BC47094
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD09A60FDB
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD09A60FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B2FF6E153;
	Mon, 14 Jun 2021 17:47:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 674726E158
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNmlHCItgkL3kcbD+6sU3fg4zElZ24tyuAxnNwKaJgAVEnfbQoL80U1eeNNyDQ9pls00gaOeHiWBD4DahQJZ4tf0HCm2+sK/p6umSOo+pIPSe/iLPWdv6GhZZde9fMNeCEHgXeCfSA1ypQFiFs3zpnAcK2ljG+LQqwtFjuCUhcKSjxuOGTClBkCT2krdKp48oEt4H5Nsi+0y3AExEX6cL7jqgVwSnU5ymyRgqVxupm99pgBmp4tAhBS8dSfqrRsdMuMf8YZ6YNEAq52GKevFy6oXgOsaJ8oPKjfs5XS4syFNVrjXBxHMe14EFw7OkVgfhmWDKMsFENqB0s+i9GFs/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wDHqnmP9DYQpAmVvuqoRMatR+WdN+Yq77IgmWJnpTQ=;
 b=AngwRds4DE6NH4w6y2FcEzlWZR0hP8YOf6oeEPLPgcvKe8WKfIocrNsmNjaVT5LsmZ5BPusIbT71g2a6Z/ftGHCGtRUgkxvCHZHxJk1evRZnka7r4cLoVJnzFF/zsJBxIfpEQ+agJHgdM2dfWTCamThrPmFKzjYmpjr/bKRhr5ZKKl4l3jUwGFfVjWv0Pn5r9+xRQz57lVaUYxvpBgZkO+x+Hdaa4tms5vCVTMiWB/uYnVKyUo3k5/Fx4EcCDpqc83ZddvKVVbQbFs3wjOCHDbQA9IAJwQ7HH9nOEquvht0lv4f4slN8NLp2HZ7l+N9yliHck3p3IXlx9zvDrfrfuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wDHqnmP9DYQpAmVvuqoRMatR+WdN+Yq77IgmWJnpTQ=;
 b=wbMMzqBlVw/0yzpu3NpKywpGCNhaawHfO9U3shomRbPdB+2+o/fB3orC6aEMc0vfrhYJZkZ8l5T53HNKnDvfOLlzMlLVAmxYOKLtU0gMm6jnR/6wAkPQ3TL5csKkkg2hsfhz7N1L0ne6dIJmplXz4CB3n9lawZ46J0u7zzpkW0E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3577.namprd12.prod.outlook.com (2603:10b6:5:3a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Mon, 14 Jun
 2021 17:47:49 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:49 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 39/40] drm/amdgpu: Use a single loop
Date: Mon, 14 Jun 2021 13:46:31 -0400
Message-Id: <20210614174632.20818-40-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:47:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29042fd4-615b-4df7-6cfd-08d92f5c7517
X-MS-TrafficTypeDiagnostic: DM6PR12MB3577:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35779F1E87A21FCFD848636699319@DM6PR12MB3577.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szJYmodJxJ9GLFFo13aUBj45rqiNQVmaAmqGUUK6X4hixzpdeEXxowcyoFhOrAbS5OFaDaKCJJyLt1DHfcjeubu3nvo13LcoJFMit2bWm9P5MdZZtFZXfL3cT4SCdg2x4klrS7xBeVtboddM8RIwhUWR5hwbskeSApn2Xz94CWUfkMmjwmgJUH43Gua29Dw7I/2jOwTl5S44IWDOI0kOucvCnrUoRpxMcaYaTP1YkKpfzisngDgqlxrMzicJnhWwnHXNIUIH2JEEKxV1IaI38zpbpXua7oOPA7K9jWTnkt+N22xABeqH/7ZlvjFveLGjCdkHEk5PyEvPx8tW2JHYFSAxstX4ptn2RP37dsBiz8TZ0aJWkhUn/l0NItmrTAgzxiTYywNXot54uShtN8ha1l490xkiI4fDeE73rwfpVuhg+1YaMePY/4Q0gjd51L2/M3kcSAQ9FS2Y5GZHTiay+qbZRRWFPB5NP3UhxMvDwysUtjG/KWdRPocHK3qKFcN7I9Kv4mVNGTQvNslgXbM1zy85PA259c1Xv5bWfIA9ybjRguoLjHfxfj3Hjgp+StK6rZRqcJ/8/mmXc36DYVTXN6jcWa5A0YAJL3LbaMOtGw8shPWeP543j5A5S/GMZN5AQXTEZw3pkn5bmsePnBNSD3EiQEPp2b3X7XgEOJ7jsDd9zE1wkughfqjzDqjsplku
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(44832011)(6512007)(36756003)(6486002)(16526019)(186003)(86362001)(52116002)(38350700002)(38100700002)(8676002)(2906002)(5660300002)(8936002)(478600001)(316002)(54906003)(66476007)(6916009)(6666004)(66556008)(26005)(83380400001)(956004)(55236004)(1076003)(2616005)(6506007)(4326008)(66946007)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AtUQXE0LPwMM5kM0wKFubfE2lvbm9UZ38BKlc69dQjdsdLJc5heIN0QgfWHr?=
 =?us-ascii?Q?/mTAgkDjmzjE+vqjQyZmfzTC8Ko4+qsYmMYw8p3C2YVsmLT4eeJ4CS0lCyct?=
 =?us-ascii?Q?3A9UqvzSo2AgrRf/qfQNHivvE5n59j2p+0ipmDo/HR/BrmusI5oQtuF1L9zD?=
 =?us-ascii?Q?veSjHU3XDhMvWijJ3GbW3HZLjVNScAAHnVLiPeEyEpRawPzOtn940zbKw2Zm?=
 =?us-ascii?Q?cc6w4/W1SDdKvHSybnlK/HWcc8tfywqDfXAd2wJcKheU56T1eLdOx049Yhqr?=
 =?us-ascii?Q?jImISCoOoK8n9t90FxknAg7czYIvUFAz9XY+VJYwPf/sMBQbTC4onT8V6Wqo?=
 =?us-ascii?Q?osEY9J7TnBEX+NjjFY0e1XP3vkeHj8NWnUBjKn7eLK97OnliEAUHpl0cIjtm?=
 =?us-ascii?Q?Mf5TUMi8v9nzLBWbmkCQZ1M3q1iZgQyDWjDESjkeuNvqL2c7Y+boKt5ATTSo?=
 =?us-ascii?Q?CP7LOh579PYkt2nRLwUF7x1n67ihBJ1ikJb8VS5wB9E3zqa3oof7rzGBay7v?=
 =?us-ascii?Q?zN+0YSeelw53IX8zzanfhYIBOs/WAnBnhcFRgqKLpWE7vVuQN0ySr3FLy3g2?=
 =?us-ascii?Q?1u4+gbjJDirP4mN1kEIYE6Iouj3h0GAOmNOCO9E6vOVBOV4wwoaqE6ZMJh84?=
 =?us-ascii?Q?PmYdBf7pD/UavYbxRwr0Iq95OYVb5bqlbW1Q6HBDSbtHl0fr/KWxz1Wr15Lo?=
 =?us-ascii?Q?AGkjbZAqgthLviGQh5pbgHHuZbPjpiJWP3NJp/aRlvGQtcQcvIoCLo3m3cgi?=
 =?us-ascii?Q?QBkl5OeizseCbvsJ22dqXS3mKC1c4YiysQ7qQJFkkuszaFQwR0734+j7S4/A?=
 =?us-ascii?Q?IrOjWVKJNjfR3Qso9YkNh4vRJRHxUb5475ZQJbPuhW+NeUngheiatNlXtyzn?=
 =?us-ascii?Q?9dQUXTt7frp32Q8hXumbnIb+TVrAvHx03AbJvOP4GTZ9vNkHWeljloWQ5FBJ?=
 =?us-ascii?Q?mZCEc0bYt6c1es4Jh4LkIb1XLiB6Hac1kRc+MheLAJeysKgiWv4sY90xmIPi?=
 =?us-ascii?Q?oyLyU0ODdfLvuOyw5pr2onC3JGS1qW1B1y1Pm7D6lsrC9ep1hxCZMW+T4qxU?=
 =?us-ascii?Q?TshQiYhA+1lAcSG16xkNqGfKCy1MzfKl5wJrz8t+4p/yjWBcJUkvGMllA1rm?=
 =?us-ascii?Q?9wpNtnOnbYvpzHrW0eR17mEZeBgYWkYoMSAnbZ6gubInBX7xwiAxErUTuhJO?=
 =?us-ascii?Q?TRRKgO6nIi53QPG2EohtavwRAGlVlN9LFSCd0PX6oiajJE2GtvxiO1kJr7az?=
 =?us-ascii?Q?uv2eTlkKHsPOw/cuaBalyMzSP7y1IgQOkzIsMFH1wxWyHvej5dY6bO7aAjBj?=
 =?us-ascii?Q?FwZvZoQn/v5sJwYYawBjZn4j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29042fd4-615b-4df7-6cfd-08d92f5c7517
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:19.8481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrXrbn1xUnkVIzrPKwBumVCTpM9zWzJcHzcwNPkaYgjC0ClzLG77kgowonJj6On0
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In smu_v11_0_i2c_transmit() use a single loop to
transmit bytes, instead of two nested loops.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 72 ++++++++++------------
 1 file changed, 34 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index 7f48ee020bc03e..751ea2517c4380 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -243,49 +243,45 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
 	/* Clear status bits */
 	smu_v11_0_i2c_clear_status(control);
 
-
 	timeout_counter = jiffies + msecs_to_jiffies(20);
 
 	while (numbytes > 0) {
 		reg = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_STATUS);
-		if (REG_GET_FIELD(reg, CKSVII2C_IC_STATUS, TFNF)) {
-			do {
-				reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, DAT, data[bytes_sent]);
-
-				/* Final message, final byte, must
-				 * generate a STOP, to release the
-				 * bus, i.e. don't hold SCL low.
-				 */
-				if (numbytes == 1 && i2c_flag & I2C_M_STOP)
-					reg = REG_SET_FIELD(reg,
-							    CKSVII2C_IC_DATA_CMD,
-							    STOP, 1);
-
-				if (bytes_sent == 0 && i2c_flag & I2C_X_RESTART)
-					reg = REG_SET_FIELD(reg,
-							    CKSVII2C_IC_DATA_CMD,
-							    RESTART, 1);
-
-				/* Write */
-				reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, CMD, 0);
-				WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_DATA_CMD, reg);
-
-				/* Record that the bytes were transmitted */
-				bytes_sent++;
-				numbytes--;
-
-				reg = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_STATUS);
-
-			} while (numbytes &&  REG_GET_FIELD(reg, CKSVII2C_IC_STATUS, TFNF));
-		}
+		if (!REG_GET_FIELD(reg, CKSVII2C_IC_STATUS, TFNF)) {
+			/*
+			 * We waited for too long for the transmission
+			 * FIFO to become not-full.  Exit the loop
+			 * with error.
+			 */
+			if (time_after(jiffies, timeout_counter)) {
+				ret |= I2C_SW_TIMEOUT;
+				goto Err;
+			}
+		} else {
+			reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, DAT,
+					    data[bytes_sent]);
 
-		/*
-		 * We waited too long for the transmission FIFO to become not-full.
-		 * Exit the loop with error.
-		 */
-		if (time_after(jiffies, timeout_counter)) {
-			ret |= I2C_SW_TIMEOUT;
-			goto Err;
+			/* Final message, final byte, must generate a
+			 * STOP to release the bus, i.e. don't hold
+			 * SCL low.
+			 */
+			if (numbytes == 1 && i2c_flag & I2C_M_STOP)
+				reg = REG_SET_FIELD(reg,
+						    CKSVII2C_IC_DATA_CMD,
+						    STOP, 1);
+
+			if (bytes_sent == 0 && i2c_flag & I2C_X_RESTART)
+				reg = REG_SET_FIELD(reg,
+						    CKSVII2C_IC_DATA_CMD,
+						    RESTART, 1);
+
+			/* Write */
+			reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, CMD, 0);
+			WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_DATA_CMD, reg);
+
+			/* Record that the bytes were transmitted */
+			bytes_sent++;
+			numbytes--;
 		}
 	}
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
