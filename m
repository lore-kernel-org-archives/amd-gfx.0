Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CC3C2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F47611EE
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F47611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6CFA6E116;
	Mon, 14 Jun 2021 17:47:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90A4A6E0F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSX3vCOrawGyOW1DazCgrGUihKUj33jsFwEhHfldqP4NUVJo7Ac0AhhA0IEGsjNQafugBy3aEP+/ydNr4nqOLc81qNLRkG2bWk4vF+g+CpY7Tl40v8eeJkLQG07BYfP3/ZIQdVmGY79B0++uDCvrLJ+41mtNRRPWZHLt1aOFGu8vBNwgPS5bd8Rnzdvc2YtROoKA447z3ognlxGCtEL4/fkORBRd5HrLVKMf+HdFko/rmddfBcfMNlQ65ESf8P1wfb3OYeY3h8o1H4WAdU1U2t5/oCaFbk4p8Ni12p2QdELwSA9RY5n6+qnpUTN2Aeiu35kFstxMOzlu4kIqJe6ibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dtVm3KyAG1Qhue9zgecpG0+V8hSRF7WVt6FqvmlDlc=;
 b=RMvJ9csrtPZXYL0Zx5/+xGeQZfzS8E3brOR1vfHU8/a7BCEOWwSovRtHKcUaVSvR6KV/Lt0T9np1inh24wXlxNC7kpDL+U2WBVX8HeFDXxvHkBVR03GzuBPuuIV80yTDhb4HOoEdViEj2GJ3x/sH9dRpxyI7x+9M2bVwLXqFOduTzrE8n5mYxha+lfDDCcH7I0KCw0gBP3tEF75Ui/eEd74NZQAg+sExuhw2EceYUGbKhue80fkxUXsCYJFX59ztLZ9/LrPiU4mLMjiji4uigCvuJGNvXkbGFpN3ogU/rDSzAPrKmjnBgx3PYOCCj8eeUgSnSaauGy6G3YA9hnMFzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dtVm3KyAG1Qhue9zgecpG0+V8hSRF7WVt6FqvmlDlc=;
 b=mld6Q6qYY1QvtVZCNpcIIO+UNfq+0+fqvrF8Vb9Gde/3aiqVPX3TAT5bzqpQ58ppaaltYNhKAvOLRxphyEm3gWKUIuptLAZ3gZ71JN3/zhE3GSUycWGcyP2PVKb8ztE9Hre/jNUIZzeSMtSgOVvU956xWr0bnNsuPZ+UHbekqaM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:47:01 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:01 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/40] drm/amdgpu: Drop i > 0 restriction for issuing RESTART
Date: Mon, 14 Jun 2021 13:46:06 -0400
Message-Id: <20210614174632.20818-15-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:46:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48306afd-5c6e-4bbf-80af-08d92f5c6836
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB474848D99D5BFA93C3605CEF99319@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PwqqyqMjC4pnAuw+yV9G4haIvgcp1MGf4k39A3PDCMt3ZQ63z2ADd3V7ZRz4XJkLbOlGQRosLcMYfiedQePzQBzAQeoQ/TSx1va8q4PGNyM8qt7xbdAnKtEcEzs+ZqyxGvV09wVfPdHf8fJbVFCkGYjNzD2xapqJtn3fNI1ABd1JFSWdr3hgKZAeUxVSjthmMXMHnfIhNyAm2u9JpqjXv1ANfbD1WuQ2L/pEH7j4h+VRzYUNhIgOaeexjgne4c2HEdeAxzPgD78Z9RrVdy9uLRF99rdkx7eThmjqTOQWA6W2n3RaRbUKszoUxSxAPqbQaB1f58a5ACe2z1QKlEVl1MSI6zTvzcvxfHKyIcy7oawEXj5eVQRB3eFU3jB4VKo72lQ5fjqrTIh4f32jEmEZ9VLNfu4dBsRF9PDVBXwfC87ewBleJMy1EUJEm+BzxeW6YbFVw/pq4nyGj7Kp+IlUrtwSXRNcH23vC2lS2TQZ5Qsv0wCOE28x90J/htZWvilE9mW3Q1z3/56iwb65wQQZMirg4TezwvbMvL32cUX6v1M1O1CaHb//Rco2xf5BggBhIv0l5ibuCKR9CLJwuCRP/DHjYHpxujjISdSpafJ7ypQOqNLMqMF6wUdCcnV2pSKHlVhvRV0LywCfTSBX7fMF4OxWzZ9RHec3W7QxjlEprsbxVnP+WsuHfR0cEocQ3Yfy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(1076003)(26005)(6512007)(16526019)(186003)(4326008)(6666004)(38100700002)(8676002)(54906003)(2616005)(956004)(2906002)(8936002)(66946007)(6916009)(38350700002)(478600001)(83380400001)(6506007)(5660300002)(52116002)(44832011)(86362001)(55236004)(6486002)(66476007)(66556008)(36756003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kWyYO/cnhOj4n0GRhbv/+E7+EZpK/MYpk1oo5unffB/0YPLI/moZQViqGbYK?=
 =?us-ascii?Q?s8f9eVdy6oH8ob+5E+SOOzGZWXngUc1EvsLleCQhlOsXUDkj2PVM0XqXFpP+?=
 =?us-ascii?Q?3rRAenLA5yfXTZZf8rBnpHUhVB/qbAEcMjYn+ZHhIT8AqcpCsRWMBBlEZ+9C?=
 =?us-ascii?Q?ryshAk8CPbluk5rgzA9tluwL7YwmtXT/foz4r5pS2BdTj/Lmn2FyUtDaAnwp?=
 =?us-ascii?Q?oD83w6cN4k2dGj0zyvUVU8T+LID2bamIoJ2wTZte9xherfrry9tdcf+2HaKI?=
 =?us-ascii?Q?WMRiLV6a1oLBjRC9aGPSsvxaGLKk6F3MPYWYSVntb5tCXe372CHL68YsyQmy?=
 =?us-ascii?Q?rMLz4PrjhbUqKG/gbMp4FDw4qtNQ2l8ra3To/pf4S2zq8en6sUJcwBC8Hpb7?=
 =?us-ascii?Q?MepFSqb0pACkKe1hU0YzxfPvorQ1svIvh8uV0AqGVX8Gog3zQ8CDiboVfWDK?=
 =?us-ascii?Q?8BFmbqwb/a4M6g3eV5ajjHA9sTyx1KA+8enTwk+F/xGKpexcneIoxE4fmyBT?=
 =?us-ascii?Q?0BWhpSoJS0Qp1/7ymGsA9gL3tTG99uqYjF4AdpyOeOJU+MLAg3/JpiCKzeJR?=
 =?us-ascii?Q?XE7i7Q394qENKfPnLm4g2XmKQd/0s2L/IRdgbeFU1Up8/I9EXP26jm0gpm9E?=
 =?us-ascii?Q?b8+sJsk4LVFlGFwS28r8wr53yz5DS3AV6rUTep/1LcD0VxdvwASSuKKV8zaA?=
 =?us-ascii?Q?47Wibc2Zu7ZGy59iU7BXqvTM5hyN63iz+AeI3rtk/Fk1LsQbvlDsmigkZFx4?=
 =?us-ascii?Q?AMo6qqjJwJGlOHshpVgysLNcfUPqU5i66LChUoyEu/XvIkpx85A1wX1AJ7Yz?=
 =?us-ascii?Q?M73OiJGRmntC4wn6+VMDMzjmiCg6Tdx+/0IIx2LQrtXIaXzTv0Dfj7Etw9du?=
 =?us-ascii?Q?3uA4rLKRV5CdXfhrXzV+FjenbXS+4WBNDx/JPyjvfuV6IkV6l91jkUCccyLI?=
 =?us-ascii?Q?nNPJBfRDqrBdgYOGg39gB0a6Cbs9HchSy6yr/Z+MFX2KYF7LtOxgSbVYEIk2?=
 =?us-ascii?Q?o/MifaHI2TsXCPsDX++2YJfTBhmL4Jh2QvVJik9lvwr5PGieSNhXmokPyRTY?=
 =?us-ascii?Q?65I5b/f4NKSl3HAN4iyPUI5LYMoZTu9kETljhlo7efHdlkaGWmOLakh9KVCp?=
 =?us-ascii?Q?6DicZ7r3E1Vpm6h52Dgl/sQ+3qGTkOKnl2qxaRFJb9Zm6brItkKStUgDkC90?=
 =?us-ascii?Q?/QiwhdYyMPJLGqJj3gETYUfR2UFpvWttokAa7BfxOrRCE3w3wI+Q4cnnXP6A?=
 =?us-ascii?Q?rxkASfxF3qcb0n54VKJePr8ceeXdq4InP57+ILYhou2zSi6tKFA646ptDFVQ?=
 =?us-ascii?Q?hkkl+6jFdAqA5beL+vh0p/jx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48306afd-5c6e-4bbf-80af-08d92f5c6836
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:46:58.2704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fxye5DCpa6n0FWEowRhzPtUK908Xiatsu2OxnfzEeqNQ4I4IB9qaULHvuOgOMEch
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

Drop i > 0 restriction for issuing RESTART.

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
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 843eb2357afaaf..a6d6ea1ef9e31b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1984,7 +1984,7 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 			if ((msg[i].flags & I2C_M_STOP) ||
 			    (!remaining_bytes))
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
-			if ((i > 0) && (j == 0) && !(msg[i].flags & I2C_M_NOSTART))
+			if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
 				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f8219e9ef5c62d..dad322f46db3c9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2783,7 +2783,7 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 			if ((msg[i].flags & I2C_M_STOP) ||
 			    (!remaining_bytes))
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
-			if ((i > 0) && (j == 0) && !(msg[i].flags & I2C_M_NOSTART))
+			if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
 				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 9e49505a6ac109..93acf3f869227a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3490,7 +3490,7 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 			if ((msg[i].flags & I2C_M_STOP) ||
 			    (!remaining_bytes))
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
-			if ((i > 0) && (j == 0) && !(msg[i].flags & I2C_M_NOSTART))
+			if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
 				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
 		}
 	}
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
