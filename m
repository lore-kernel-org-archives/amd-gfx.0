Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EE8C48BCD
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466F5610E5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466F5610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 432F36EBA0;
	Tue,  8 Jun 2021 21:40:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C2496EADD
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2ultxUyzLtrb0ma8KfxCpwgJiAoq/hWWt/FMy1iN0qliCfIzS+3nWYe0cbH0L/WEJRABJYwxfv+J5//60nTP60yw3jG2HWNgTKZRUQT3m32/KhajXEzAVBKNhdN1TUVcg9zA9eV9dI+pu84EgAwaV3TgJVbV4NrCmgbQsFdaBCARlGPxd3zcuFAf2w6KQIvkGFgjosRhqALZqqTikNwO3LMtNbLFfyf9StErH0VcGzLM1n0toE8kxSfgAn0X4N+enHcWmjRd7gqNdgxZI0e+AlYfevo/EgHCOBMeJPueV7vYH260mwGNNtswJPaTcr1H+5Iptnuk2nN9yiKzlgx2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzAJTYuhASlMUu4jH9uHQxrCtZ67Yoj+Lj/4oQYye7A=;
 b=cyRbP+g90fngDK2hL5e60tvcKDOScsnjCtWiAzoMClgAO8vIVAQB9pPVUHe2HWSC4UMPJGVa7lU7s7sY9UHnv5ysDf1CMu1pAUlGWYbJ6J12ICFxFW2aEld3dSRENqTMoWJpzwW7L9Iedw9vXVYhG48dUtWvXIqQFtMNSAZbProEDCUrE7p8t5bdsm7I0U0HbpCzlitqey0PEZ9/Q0e3ZMHiRFAbh385ggnLHkVwAIz4iH7ZnNOKfIQqLzoOkei3n0/fYIEtmNbifIgAPAfJ0h6Y8BvBhEUS3MWs8dSe9weFijyrTNa4IKRKoYviozAZ0KDRVlXiSDBomom6Yc4/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzAJTYuhASlMUu4jH9uHQxrCtZ67Yoj+Lj/4oQYye7A=;
 b=J95hE54IA+uVOUZmObFgyRl+qF34dqRWeW6o6F5S/aCSKsVXZRirviRhwEtOD6ZfZvnZnrWPEfzHKiq7aObfa4woy5zF0r63jx3m3CLZ7CptuTFccdTHkEwGip7wBooFy9pi7o15XC6V3RMQI64jNxe8Skt0Ru2KdgSE908LKrs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:20 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:20 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/40] drm/amdgpu: only set restart on first cmd of the smu
 i2c transaction
Date: Tue,  8 Jun 2021 17:39:25 -0400
Message-Id: <20210608213954.5517-12-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 589d934c-bd75-45f7-2203-08d92ac603e8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435ADA351200BA59307D8DA99379@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +h2ahfuONik+dvow6qIBDhxpm/gLzwUlw/t5GadSz1K/8bY+RaY/JgPSTfHpdNBZhEUEoh5mgOI/EbjLNWnBdZEkmq17Mp+FcLeXJwYMiv0qaIEAcghJyQNLoItP8H431fCfX8MD3YCbrDcianATu9ToWnqyzKE66mDTwzoZciduEcvFnqBO74z0fImbrZw31KtrvuXdG8Es348iZehWQG3Wh9V0UQp4QEonjWki8pz0l5PehOjoHhLjpvlGpSTVY0rAJG1leaMKaN5uPzx8UcY5TyA9u3pWR9z4khUGjYRw1wi2p2dVHG3klNIUfeTbJn8JdFMzl98yS3vAm6q9iN3/RvmGJGMMbXkBtQpFN824SAKvANersdTv/0WW/DL4XSknM7S5Qnsj0GZyt3cStgY+3irm1avbitIapnYIXiWnOLRXDP+fC65kHbmxHJ3OTtmFqEi9sw4X31/SJAGVPox7g5gd30KN5AFARle1KtiNKXmx3lz4mtg8yieAMWGbB5rZquikKnXBeGOjpLYEDFzpeABwd2aL9RaBUH5gOY8ecTGow74BLxFrgktfJ+qal7keeJRPkkHaxsUC+pLUtybSpOfow6zE7cHMxoOThCvrgXMlmli/eDdeRI/FQD1eRDoGpvUZEdw2mD/ZyueqoM4uzUKa+oDArY//Jp9Xs/5ZssAyk1/qO8GmQBue8VY3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39850400004)(6916009)(8676002)(6506007)(6512007)(36756003)(6486002)(66476007)(38100700002)(38350700002)(26005)(16526019)(1076003)(8936002)(2906002)(54906003)(316002)(4326008)(66946007)(186003)(5660300002)(66556008)(83380400001)(52116002)(2616005)(956004)(55236004)(44832011)(86362001)(478600001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sqlicInoYJXAE7pDPtL2QmwJcxdbwxsEoluyx33SrmAYgB8u0VCgTaCAWz3n?=
 =?us-ascii?Q?KBPWgri8PQX6M7KjQy/x6UZ6FePsuBYV4gz2AE7Qxcllb3ypa1CRPz+uEG4w?=
 =?us-ascii?Q?hQo+nxz6Chbj8Qb/UuG4/lSHnW6jkRHxo0tAIrMmU7Cd7l/Fb/H05D5U0vCD?=
 =?us-ascii?Q?4EdTmyLKXISkhcKY/QUz0hre+Na1BeYIti3EHKO36jNt4cQiXUDN3c77V5+O?=
 =?us-ascii?Q?sCRhDgx5/Muc0/AWXgdvw/Zv0s9sGq8LfXply1oFV6aHHaIrssNHtMbgze1/?=
 =?us-ascii?Q?I2AV1uKfx8KRcWdzBeSZYBKrNH2hJly3DsdxP0JwwOnP/+q8EsrR2S30lP1R?=
 =?us-ascii?Q?SLO8L2Ff+R32HIqFU1iwW11IQamGJBA+Yj2w4pjqZAFvW6IvAqxiBW/Plt0H?=
 =?us-ascii?Q?1j4PhrAMUMNJA9MY3d3oTAaQD+SRgdOVZ8M+Tqq4BMaKG5is4gllXrxnH5Mw?=
 =?us-ascii?Q?F/gwAP726E18FbGelp3WlaGcLaGWIjA5YaRntkUEhCQQBIIsjkR5Fa/OAyy/?=
 =?us-ascii?Q?TjAjEBhM/a4gHvu2eURPkFIRiYVZNS/WukXXBJUK1GVnHrbYRsZpNUk4b2s8?=
 =?us-ascii?Q?W6rs80ICnTfgAC1Wk0iQ8xVEDJ9/ZHIwsXRpBmhV4L2dCZKtVOWHdXJRHW2S?=
 =?us-ascii?Q?UEdq1s3QMj0D3m8FUKjtj/elBnLLn0uOItRi6y43yez+tH/JY6XSoUsy9YUo?=
 =?us-ascii?Q?qejF9vdbapeWecVS3L26ogG1bMCucH3M5nAdQKP6U8fY3xDMpeO1s6RpBPxI?=
 =?us-ascii?Q?X5jOtflektntudegVNLHluM9f6to7VejhEu73Rj2eLbgWqLLhMAbTamva6Qr?=
 =?us-ascii?Q?RXdSCGNAXDplVb3qQ5ZFBI3T0lpFso68FhSp9n0RU71A8/KdhyKZJXey11rX?=
 =?us-ascii?Q?R01wdVH5Ql/ko/NegyXSOmBP3kPNwWKlz/F7ZvHM6QRzjHl214JatqFVpISl?=
 =?us-ascii?Q?1UP3hB0fFDPe4uTFv71cpTggZ6XBRngtsmtBD7sUPz9MzOhcw8Jse4SlcKs0?=
 =?us-ascii?Q?yVFe6eNqk/1rjVrzGAqDoNepFZZT4ce6eYWdLwQ/MXs6hjOe6Y1QEZQintxd?=
 =?us-ascii?Q?P7Jsl8Jz2tJGYKnZegh6noZsu0Pft4mT9Uti4zWy7+t2SdMwdcG05A98ea63?=
 =?us-ascii?Q?GTyaDrqhHEC5+/asAWIjT1lMuJgwpwUykMioYiQ+TS60jQKQdaBz64JFzEuC?=
 =?us-ascii?Q?oqRssHnA6dP4lrC0+EtgKyRlxdsJDv1slm03aVjxwmuo+hZwb2aVBuvSds2X?=
 =?us-ascii?Q?B3Ih7HtzwHh1YEGCiLAsYM7yPjwa+HgOEWBeN4g50W+Cq8zwDqpW+zjUEg1S?=
 =?us-ascii?Q?d9BOtMSHu3LKD+us5/99lcQS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 589d934c-bd75-45f7-2203-08d92ac603e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:20.8291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++F0rfIeOYBVy6roIFq4MrdtK6G4N3TBpfBYd4pTdwebaY/tJSkGY55sHPWGZVd9
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

Not sure how the firmware interprets these.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index a8249ee354572c..73e261260b76e6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1954,7 +1954,7 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 			if ((msg[i].flags & I2C_M_STOP) ||
 			    (!remaining_bytes))
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
-			if ((i > 0) && !(msg[i].flags & I2C_M_NOSTART))
+			if ((i > 0) && (j == 0) && !(msg[i].flags & I2C_M_NOSTART))
 				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 644b4821220ede..5dc48e557c2bad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2749,7 +2749,7 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 			if ((msg[i].flags & I2C_M_STOP) ||
 			    (!remaining_bytes))
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
-			if ((i > 0) && !(msg[i].flags & I2C_M_NOSTART))
+			if ((i > 0) && (j == 0) && !(msg[i].flags & I2C_M_NOSTART))
 				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 10eb7d6f48fcac..fdbc54622dbfbf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3437,7 +3437,7 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 			if ((msg[i].flags & I2C_M_STOP) ||
 			    (!remaining_bytes))
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
-			if ((i > 0) && !(msg[i].flags & I2C_M_NOSTART))
+			if ((i > 0) && (j == 0) && !(msg[i].flags & I2C_M_NOSTART))
 				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
 		}
 	}
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
