Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9A9C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 12:13:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D9B22202
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 12:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D9B22202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D9416E19A;
	Wed, 20 Jan 2021 12:13:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF52C6E19A
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 12:13:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEL0kYcLzNyiUmLYUTCdiZ8IbAghbsqu0DJV0krJaRsMivZsVyApLr/PNTLjJlckUp08rxTfviwWBhW6Yc0rjA3lCchBxPaIaINNfGeQfYdTULueZRnVW6Vo0zsisLCEtObrABv3zw8y6UhRuoDlKWxMVCB7eRiQWu8tTbJPgSakcVcXN7c6bfY8eYy5NrchT9liwTSKl+cFOvbup+QpwGLofXOpzu6w/pUvvpJWGmkeObxvNOuzlqEcAmO+I7BYTnEhHNDzcVQO8Fts8zEEdHAp1FXO4a4AZs2iLQ00JqaR6ms0ZWpMSGP2lrIxn2V5QlzeXjQggnPqGDakxESZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEI9/dHu7UKNfgOv+DF/VpNX82vogjaFjgeZIQUxI+E=;
 b=buZWA3tQFmWMD2m9YmLE6m/88B0tJ1sj2KcBtxuz/RdJvcv13Yne67rXSnpIyJZucsM9Z1/moLwE+ptIfXOsSPy5P8ko1WccdIotHfFXGmgZWZR+y3t2X4gfNELAZE+9zEA5XGLAscOcXH8uQ4OXVYE5RaZReuIT05c5PnnHfNOqV1EaiRR6fbxpr4HGx4TCcptw+Dt9EJ+Snm4NrHZTp9PMj18usBRSOqqnoK2qu1qkD6Fgq0L1hg5F+hpuXxoUZPunV+kXQHA8FZc1tbE98kaxj1q6WpPdRSsIbhYFjkDe+GuRuI/UIRgZdcrn5jb15UbcqmyWaWgvB3amuNwJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEI9/dHu7UKNfgOv+DF/VpNX82vogjaFjgeZIQUxI+E=;
 b=CekYuooC4U2RecWZxWdwiRKiGOkn79YONvFf7h/2OFJ9D9MCq9m9Ghzr6CKHjuq7L2UvLUi6RM/d8G2FZq0zYc0dtQ3D1MG5S2Z6thZpzgiO7iJyj1cChmHgGlIgO1Vy2Co3mDLXANALM7QHM918jPct5o3i3rLBdcX0ADQrohw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 20 Jan
 2021 12:13:39 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 12:13:39 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: print the timeout of smc message
Date: Wed, 20 Jan 2021 20:13:19 +0800
Message-Id: <20210120121319.662069-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0057.apcprd04.prod.outlook.com
 (2603:1096:202:14::25) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (180.167.199.189) by
 HK2PR04CA0057.apcprd04.prod.outlook.com (2603:1096:202:14::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Wed, 20 Jan 2021 12:13:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cbf2ab53-2215-474c-df16-08d8bd3cd1bb
X-MS-TrafficTypeDiagnostic: MW3PR12MB4364:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB436489EA725A57DD35FE90F1ECA29@MW3PR12MB4364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TI0YA9k7mKt1H54/jY2g1zN2/948z/9USbgiBCOQU4py7CQBYe5vaHNna6NBxeGqjiYtlkcXL6q+OssDadsvTnU/zD4O1TETjpFiVYVrU+mRgE4tvhkjzCvGC7AuFHojvCXiv8a74oM+w0rRfMilx9R4BXuqh0nqC/5fuerCT66Y06WUlZZR1GC0jXccGH5Nie63KD9W8dDziDFxRlIh3FGGW+0U8kj+Ddo/xdekPxq1f7VHPPl0Gr8VrFpztGWP84yVdSsCzaGd68xTWto7awbo/AOMAKtALcWCUWLtv0cIJwdVXdlfgze/jX5x3x9G8JtLvExVnEHxprHj7xGL4tvaKgEnDcNXDZkAO+AmGZFSIXq1mjWbuX7oNOVh6zb0UTUVmXI3g73Hr+dlIYAxzrQ81s04xpYhEeF2D/iDceBq9Lv12R34X0Rws2VzhvPStvgtH+H57jeIbrRZJfcbo3tmlVuPh4wDNLAkFlXz51IrnKxMbJO0D8Q3icNikVKAW0QVd7WwbZje36c+Gcu09w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(36756003)(2906002)(6666004)(316002)(5660300002)(478600001)(6916009)(186003)(16526019)(52116002)(7696005)(26005)(8936002)(66946007)(66556008)(1076003)(54906003)(956004)(6486002)(83380400001)(66476007)(86362001)(2616005)(15650500001)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tdKnqe/+9uNaXaishNvVqhf1uttxT3MNPvuljwUbe3L2UMSZW7wW/gJL7Dvz?=
 =?us-ascii?Q?GpH0IKaPatdbk2JfXC/hwbahgf9CBmC6yF23a/MUy2GM7KGdHQQZEChgq/iu?=
 =?us-ascii?Q?LvepZ/0wyWj1WdLOTQID/J/17XnrP5CYZoylgP9XsK/3IlH1mvv1jDO2nLUP?=
 =?us-ascii?Q?1hdUc/FnfBL12fnV/S+vpDbF7SCw1ld0JcxiofqPfXxpC6xxfXZjNQWtbrqs?=
 =?us-ascii?Q?e2u9WMA0CHtMmwDQ+vi099XYBWJlBNClZrnngSnqJHB1nTGmyqXU92wRtdMy?=
 =?us-ascii?Q?LLmmE+j4RU8nosynvN23nAuaNRfXpzNFTymohDKszV5vSzUbk6E/FtfXq1vz?=
 =?us-ascii?Q?/1uWI9+egJspWgWISb2WbDq3lWEJUgkjMIxtp56y9Ms4qfwS6bYjH6U+ZLWs?=
 =?us-ascii?Q?ndSUHbBx4FDHszsyNHGM9LvcdUuBMuPOp1NzMLS/yxvRMrGl1R2iK4wczlJR?=
 =?us-ascii?Q?/MBdeBI/tGZzrUvfOtmGLejt7aZhwugO6TvnnnRdzyVD6a+PvAyR3qyuO2pw?=
 =?us-ascii?Q?M7IFRmVJDoMtsN0WFFfxSPiLIhrytLA6kwr3xocVTXmGGXcen28WbVNcX+4j?=
 =?us-ascii?Q?ZiweKHxvxt1D+tdnAixBy+k48pikl/g0OYDsGUCq6CquU/lYaQobV2rmBen5?=
 =?us-ascii?Q?uPuI3lXlyJXWe16EAhgfC+ybeCauVJPaU2aW0LZCO6b+GSKh2LWt4Wnay6vm?=
 =?us-ascii?Q?TzSVrxsuFrJNqHKz282KaaQX+fVv1mPlne5MaLwHjhkGDz1c5QIksLHF71oC?=
 =?us-ascii?Q?2ugiOnDAxeIFU0rD5ykwYQNrJ1xVFa+9CEXRAvTE4YlLP4I/XV1QGTOCUv5H?=
 =?us-ascii?Q?dcia4ptR2OlzJtRenHkdIMgHOsE03wMSbiSBjW6aau/gUz25CR14BDCjYH7x?=
 =?us-ascii?Q?8RIUUviSAf3yAiqcVuS+thLE+bC9Qjtly/HAcaa2xyqA2J8juofuxVEtJcTX?=
 =?us-ascii?Q?BwQLdcz7gso66abDu2LN/oqrWxgJdxqN/ju8tZIlvVrUWFDZfQYIbEwOKWWm?=
 =?us-ascii?Q?lPCg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf2ab53-2215-474c-df16-08d8bd3cd1bb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 12:13:39.1221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4b/+msFJiaveOmhHrVNwJ+ifTe1nynFWIVO/iTPp2YfWoWgFOj99ry1CgxQB03z7phHC9b4Q4et/WSEbU0j/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to help firmware designer to know the smc message timeout
status.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index e4eff6d9f092..ffd373e63f0d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -142,10 +142,15 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 
 	ret = smu_cmn_wait_for_response(smu);
 	if (ret != 0x1) {
-		dev_err(adev->dev, "failed send message: %10s (%d) \tparam: 0x%08x response %#x\n",
-			smu_get_message_name(smu, msg), index, param, ret);
-		if (ret != -ETIME)
+		if (ret == -ETIME) {
+			dev_err(adev->dev, "message: %10s (%d) \tparam: 0x%08x is timeout (no response)\n",
+				smu_get_message_name(smu, msg), index, param);
+		} else {
+			dev_err(adev->dev, "failed send message: %10s (%d) \tparam: 0x%08x response %#x\n",
+				smu_get_message_name(smu, msg), index, param,
+				ret);
 			ret = -EIO;
+		}
 		goto out;
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
