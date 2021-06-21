Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC9AC48BC2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E716860FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E716860FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 912C16E270;
	Mon, 21 Jun 2021 17:13:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67BA46E270
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YItqBkbAsw71rWpge1Tbw+UFGH1b7VYzyaHXM0KGgDkt0Zv+tRCBXFEyNKGl3x58wdC2YvIgwPYNOald8d/VRjQb20nBIvWY2TtMTFqZKSLhOzNNdpICSQ89vU6ahuSqNw89nJENvgOgyrVVr/JKfMdfuhdLhIUp17irwQcTEHKdJd2FA242u+ZNEIKA8Q2A0S8sXNEGv10aSkU26taGUp6TYHaMJx7lu2E4uMlw+koo0BZbO/s+IO/CytYddzLaHF0fAEthRo797nSHc4DZamBtjZ3HrzIMYypYlV/NSLw9iaDd8RaFKgR05G4crGP6JRKO7tKAxjnKRC39llBVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wDHqnmP9DYQpAmVvuqoRMatR+WdN+Yq77IgmWJnpTQ=;
 b=Mh4J6wxlKo+QOjSNZNrfxR3pcXCQZjjXguiow02OCZW/3pNGdNQFN91Fsz0u3cn5ZiHEuvD2pzXMnEBvCJSvqZjx61W71t3sJpkFRPZ/zXxREbqd7kYdrUemli9KJ/rrSgu+dYP11NqqKPBltVWAWhKXeIz5r5sjoBkxFhWk4ITxnm9w4CZp4L0PpujHsGZpCX4s1ZOurdit+XyU5u8f+wrIKK6YecwUZfvUUz8qkHD2qxrMKURRC832cvCdcQZXVDm7KB73ju95OncK5PJ60R3KV+Z6VR4Xmlo3TYisGu0QRhbO8rj5i+QApWv1npYLQns8l9CPafO5eokt1x4U3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wDHqnmP9DYQpAmVvuqoRMatR+WdN+Yq77IgmWJnpTQ=;
 b=3OhsOUUPtbfhGRztc/YDiJypZWuj8StxaLsx9jvct1fsnLFMPvOW0TuhIiMJJMls7BWygNqBPtlloyjqnbdJEwwuZPChtDhNhYwHIh5eaQ1dhNZRVbRtxkF6zLX7iUqQSc0859ErhLFdFQZ8I3pHXZ87dQGSu5412LQfBgobJvI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 17:13:39 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:13:39 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 42/43] drm/amdgpu: Use a single loop
Date: Mon, 21 Jun 2021 13:12:20 -0400
Message-Id: <20210621171221.5720-43-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:13:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87e1f0f7-e1f3-48f9-aadc-08d934d7d71e
X-MS-TrafficTypeDiagnostic: DM6PR12MB2985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2985A9EDFC983B3D337348AD990A9@DM6PR12MB2985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+ahEJ9d61vNlUBN0db9TkUX0Yac33Fu1IyJwyRpdSwIcxKFpyqJsybqiYqp8XTZp095DxEDHLVe3s9gg/VkoDuFLbdveg5gptNd5/s3t3rKn0QbjJX3ms/p18WJQKOwk0/GwENwVLLc5rKB5r2ZG8BkT2E4PJH35oWoA7YltUB6lErlqczz9zLpH/MSSC4J4oWmY7lQN54Ni87gqU3qGChTTsRtjzrPOvy/F0O6s803/g+uzSHrp5sgmXp0F/eyEA79XbWsUHSNDSLJ3f2PvmkkvBZqCTayN89hhbA4K4//Fno6LHp5U/3dxvHYbETF42jy7ZZFzs+7VIzSpajXRIBeDdTVCLQ3PZYDmIHV1DLmYJzIk2jRPKvv3sET0iAH2QrKZfpl8DVXyz6AUTpeGtmk3kgC0VaH4Xtr8cH7TmnziwFTcfMpQRlXN3eqbrsr8CvA8IT65+Jotzwku4UlwtENXR+irD5RNyUVURQvLpeWxlFQpLbOprmXmWvMXoGQvOiLNqOTvaDLp4vuxtDsv34sVU6y8/T7dNrJKz7C/QuPY5zx1qZ9/lWtBNI6N0H4uHpUYar7zJAimNFMzZ98TxFROSnng21GVE6EhNqNC101QFasNBOMYumBls5gyYtbSW+3nE9QsWNbO8RMrohhM1X1tcvFwp5y9GLt7cqYuidLjXk/rzKunnj7W4w6ZYdN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(6666004)(55236004)(8676002)(316002)(6506007)(6486002)(54906003)(44832011)(8936002)(478600001)(66476007)(66946007)(956004)(2616005)(6512007)(66556008)(2906002)(52116002)(36756003)(38100700002)(38350700002)(86362001)(5660300002)(186003)(4326008)(1076003)(83380400001)(26005)(16526019)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QPn+lrQ7QnW8lZ2N/Kr0o9EwaWosPjPwEoPSwllqOuwFAZM8uvpnRNz/3Wdm?=
 =?us-ascii?Q?fmTw8I52GpuoOgNZXT9L2Ce0skQ9iQRMcVioXTZ55c7ktTGSgxgH5fKdfyey?=
 =?us-ascii?Q?/8TQJR2JzR0jteyuO38gqufm9tnhR9RqxfrIvy7noALj65odckd/lLShNlSE?=
 =?us-ascii?Q?xqvyDX+SQMvZtF0fR+bd3zSyrilc0Ln8ljBmVbf8quZE4Kujs6tRNL9/ykku?=
 =?us-ascii?Q?28FeJGH+5nC9G3yVCGbIVhQWaOmPx1FlijeOrPdMFEdLNP7PXdGF9BVAu1Zp?=
 =?us-ascii?Q?GH90eojNYwZ8AM0tpSSeOFyzYb+HGP8PunVQJxAQon6MntpUZHUmVA5YXqN6?=
 =?us-ascii?Q?LrsHFp2U7Z+dJiDxFCczQQ+J4pN9brOLy484ThNug7vTpK3VIhQdMb9RwJby?=
 =?us-ascii?Q?Bv5PbH8ScA9keVk4BK3MOn8xxUEqXz+qGjPyZGhpZfDJ35Hn9By/eSUcCRvx?=
 =?us-ascii?Q?KHcC0D0qy5TdLfuSnIXaF7Sai6w9kEhu0ckv4ytzFG8pNkF+v4Cq68vw+LuV?=
 =?us-ascii?Q?K4dX5qzkkx9ob/KFIPdPSsnRPk6G80RGo10IiapDBroGrF2sbvHUVJ+UVCIk?=
 =?us-ascii?Q?5spAgkmad+W5zhb1lB+ig4WBIj+EknP8x2GLpz7zpIp3BYm7YJePMQiI7A/k?=
 =?us-ascii?Q?FCQvhUp1T2pjHdQcoBu5jm7BsVVPf2JvTTbYhmf6Dkr7K+MXIiIkvyzVPsoC?=
 =?us-ascii?Q?8M9hTi0h06EWWC1ynpVbObswI2sEnhieU0ztgxvQkyWLM39q2N+BPF5NUIsG?=
 =?us-ascii?Q?NnesCpd8VYxFVIxZ66LfC+90Cb+BYKCo3LsIDkw60J1cJOLTA0cVx3TbDJkF?=
 =?us-ascii?Q?714sRcbSY4x+nW3ZQlJSZwDhWjQn+BIC7d1W6vgHcq1Yia1xueQQQMuTbnGx?=
 =?us-ascii?Q?2sAJxPbDEsPBnDGP7w7mxX8PMVvDMxB1og58isFqJQ+ckLm2b/LobXp7WOTa?=
 =?us-ascii?Q?BlIDeZePtgE67eRwJOBBnWrTNZiRz//URHPQbHPluArJhK8W+LbS/2vDjTeH?=
 =?us-ascii?Q?x0AEDkT7zAxYxLno7NWkJSnxc9KrmT3jp4u2mZrGNqCvuJMWhldJ7ty7nR/N?=
 =?us-ascii?Q?vhOKGmHTcjc4v3UHncY+be+jzdmGnTJ4421DTJUCNv2gMy3x6MbybXpneQIf?=
 =?us-ascii?Q?xSzCnL7v3cpJSijN3lzhG0rF0W6/EFc/mOzrRWNxz3pSVBc0hv5PzRXrQeFT?=
 =?us-ascii?Q?6D5gE0hehRto1mz9s+gn46sr6EgF6tUsEKNPPuPgGmxX4hUrWVzs8d3MJ7Qe?=
 =?us-ascii?Q?Lvda4h7kOwHMVLCgX/styPOaBTIpgKXFaF2v2GVwyCE/ltRQ7fYkxsHe6+P9?=
 =?us-ascii?Q?b28ag7TsBVjopXWyp7jzB6a+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e1f0f7-e1f3-48f9-aadc-08d934d7d71e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:13:08.2229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wk/6eSgrWy9DjkdZlnZH+3pTPFfx0SmR9pOy0IC7J2aSmQ9ozmANQQRBRL95RIz/
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
