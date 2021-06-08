Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179FAC4743D
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC8C610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC8C610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D04316EC46;
	Tue,  8 Jun 2021 21:40:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A49D6EBA0
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+6RuhQsqbb2I+Ohr3OT5wNeBauaxUsowIKcFT7uy2BzZpWRAaqvmpWCqJq2w7T02Lj8m9GlOkaWqrujRXzPDEqoID7BBF6ceh9upAeOMsdswQazUv2QF+A1CNB7S4gRkBC1X5d1xf32M/Y+24joHzGC86sZEzo3nZr0LeNfZ21KA54uPlDWUDgCLqVChs7BJdKLTbN2TgCjSguvQgY+CMy78lnRP8MAecDPF3pe6rQdxIow2ZiERVhLPTQC6DV8cI+5ycDcFlInQ88WYkxV8A8gFcJFZfJX/B+lJDpXrEDQeAKDVYSsIKzg4xiES8/rx2gAEV+V8qFzvLj3KYvXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soLR1fEYBtA/S4tN3t0P23Vn5mV8kZRzRFf8kPPLRfg=;
 b=PI13cZmsUSi+Sva5QbXA4R8Ewg/L7MRYsuhQlNByS5EXMCnmfotCSH2+CDLUm0UuUG9Q68TSyOR6GzvXSEZOqOXQWAIm7kGLFmwjIMMXnNisIew2W9xOwowkj8XWZ8Kdy3FU88GVDWti2ytR31ugMlkm/7KiYFb/mPtIRPNiB6orLifmGEwVHeKYL8z1yMTlDLJmWA3ClF5J1fdxGzn55LIGCHz06DfOgdDf79GcFeH0BoZBuq/UpWZsVhQvXpCN8Eby6BjAKxXJdzkfDIgC+BAbd5dDcUjX6WJXZeNJ35DC0ItP1WsPHaQwklVExKXOVXP2fwqygPDg1eqnwIelIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soLR1fEYBtA/S4tN3t0P23Vn5mV8kZRzRFf8kPPLRfg=;
 b=qe6d1cigkyBd6MovTO33Ii+rj3ow1euxj/MdHTJ8chod17imvXrutTwKEE/c1PCIC9uL8cMsqbfMERcjuaNo/RrpAeS/TeY+M4izkAfhvzVIS5TNaaOdC0GKgaAGh+CYVHEVvNuRWMAueJc7NpR24aY2DRT+94e90UENo/is3Rg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:23 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:23 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/40] drm/amdgpu: Drop i > 0 restriction for issuing RESTART
Date: Tue,  8 Jun 2021 17:39:28 -0400
Message-Id: <20210608213954.5517-15-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a77a7c19-1bc1-43f9-f813-08d92ac60579
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435047FC608F7B57DDBA5B599379@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:183;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DKMPomAVMU+HHFISsbCQvQ9g/p3s+Z59uSnnKDPp/BFedUevjjXqSJ3rcvEOXRwoYUYBd2r8Ajjg6Cn3eNYMjpewXE/AMUBSalZmENap5fmI9COaPqxUIO716TpDyPlPzHlZf71Q9gd6xmIW7zvVJjKKDqTn8tP/LO6hMIm9wRbWLZ83IZ0Pnp2M5SKYOuwAf/4/Ryv/kK7fOMOeLaIh0d2DKlrjWiXfvm0b0tc4C+MFilS+9tI/y/d6HLxC9X8pI23h6YCXe/PKlog+Jym00JmEjuBTd2avMzj3pXq95WHou/m4m49x2ZYJt/TJkpiFZ/8N6w8mbp5Ze6olEG6bzh1rhKCh4jNDvm9GEredgDoDZ1IjFh2dmQ2y1YWSXN29QIBTwHtqGqg9BQcykb3y2Q5L/7szF6ZK1r3NJ2+IA7uo7+NsdNq29MtJQYT/ZkBt7bnFKV9RCXZ9ziejO61wOPbFym3uHs6yGUOBtFGHRrerwusphOKCvwtqDVRpM+mOqHEU1lptPAFiyxajcREq603b4ujWLPCIboazoSeui5Jbi/IJQV6XqqxeZbDdT87TwXkz1BwFIZhEgB/l3Ir0nhvSwZMLpDv6CquJzHVlXRxosQVCwDQJmCXdhVVk3ebRMk4mry17v+acxjE6aDhpjkpE0AxXuNDRULEOY/Kdsl3PgKLz2Lyf8irV9j70R2OM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39850400004)(6916009)(8676002)(6506007)(6512007)(36756003)(6486002)(66476007)(38100700002)(38350700002)(26005)(16526019)(1076003)(8936002)(2906002)(54906003)(316002)(4326008)(66946007)(186003)(5660300002)(66556008)(83380400001)(52116002)(2616005)(956004)(55236004)(44832011)(86362001)(478600001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Okl1I4tzK3UyKUpXKfw/FfjbSv+YVlgeuFcBCtDuuoA7Sm8ntDxcjoeDx3rk?=
 =?us-ascii?Q?YQ/hCDX2eLuhDx828syxlWE4+Ay7MC8Sivsqp7ZRBd2blgAmxZx7DMNuNb5U?=
 =?us-ascii?Q?ObRQw8jBCqFCQyg3MUH+s8/7Kp14aJrhlgY+UtP7fHy4j9ZqutkgUvV3aT9G?=
 =?us-ascii?Q?Y7f0wmacyAn2AZrFZOwXRYpBcoZGtX+XQDq270JIHj6ZhS0QkI2BEHWR/lXq?=
 =?us-ascii?Q?0XlNw4RlRkwvKN/m3AwvozFt63vNx0gP9KLhvDNxNmH5IJGsQCLJjGfSvyeJ?=
 =?us-ascii?Q?AZ4ihLX1XIjw0jOb7AlvNsDh8UJbLhig4oLyLGsnXBP8XYTBI8YjxdgMhhil?=
 =?us-ascii?Q?+gQWzH+j0ohe4o9OtX9QymjMXG3fgkngeGZMJglCfBvtShrUOqhPDsJDNY18?=
 =?us-ascii?Q?HE+bsVMG9Saxz9sc6EWZt/8KvSw5YkU1jc52A46cqqEMSEsBMdGQEZK9wanr?=
 =?us-ascii?Q?CNEpb+Rz2ZANjdumucUz9GZOg3qTYNskQLntwWvMKYkgo+SjHk2Ldk3lhFnC?=
 =?us-ascii?Q?5cyAgbNMG21R/sZdjKV483CRo8bH5tY9beDaCy8W1x5hZqRHrHfO6m0OU3na?=
 =?us-ascii?Q?KsJfqV5GLlW0BUtbgHb9WKcFeK5xMJoLKm+a7lLbIEnI3qIIR9Lw8lKb93Td?=
 =?us-ascii?Q?eFdexwDFFTvRQbjtt8C9TVSMonkWo3YtEQSycFK+SMcVUv0vg6XjiyH/RyRK?=
 =?us-ascii?Q?zqTXlANdJEz5jZFUpWt5E1lLYCyqb2nTeBEDXd3kCuusR5UEXgoRTP0ZsvFr?=
 =?us-ascii?Q?DwrPuWYTrDlhGyjtPz6IY0knVrR/PQM7ih8aDa1Sj3asDtrHN9Q7HOUGwkIU?=
 =?us-ascii?Q?Uz6sTPzDinNVa3aUW1hGQSQy/E+HXxtVN2ZB0/jtVTngRaMEfffSSOVc9RrI?=
 =?us-ascii?Q?fyC0yLywJhYeLv8d3UUHdgR9qVzlQYH5GIAZjeaVHmn5hE63W62rI7P9nKpc?=
 =?us-ascii?Q?Tf2H57gk/RHI8W/LGIH2YU+AM740eaf+OQt1Yrtg7dTBNrMiYm9dR9rl27dY?=
 =?us-ascii?Q?faGHH49SR/YqfqLyzH3YAX0mwKyve9utFy1jq8RGKa97gEZAHw2Y6/qqYxYt?=
 =?us-ascii?Q?7US1FP22y5pfbLUYNEFnx6niTN/7XevNM+3mKxGEWOvVA9Y81fO+dxxBzEFH?=
 =?us-ascii?Q?uE4q1Kgi30CByx3byumKHHkwticY3+LQMiLOQ7QW8PYyKndAf1o8EEDOaRRy?=
 =?us-ascii?Q?ohmCaLmGlvHWE/2K4M1dlFLp4qGybwz6UoUYVymtdSdECWD9qn/6T/N6Wger?=
 =?us-ascii?Q?x6UEUHRgsP62to9DRm2SQX6I9jiK/EEB9UWrVi3A/DkWyEal4UaDUu7WrycN?=
 =?us-ascii?Q?5XBbc6wfl1IYc7sIAmoleEOs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77a7c19-1bc1-43f9-f813-08d92ac60579
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:23.5195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qz5I+9zsCdev5bWkFuR5pT2TbRlxMPjFZS/vLA/XW0mew/oGYDrBbQHWBSw169D
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
index 73e261260b76e6..72b02025b07e06 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1954,7 +1954,7 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 			if ((msg[i].flags & I2C_M_STOP) ||
 			    (!remaining_bytes))
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
-			if ((i > 0) && (j == 0) && !(msg[i].flags & I2C_M_NOSTART))
+			if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
 				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 5dc48e557c2bad..289d09a5d711b9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2749,7 +2749,7 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 			if ((msg[i].flags & I2C_M_STOP) ||
 			    (!remaining_bytes))
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
-			if ((i > 0) && (j == 0) && !(msg[i].flags & I2C_M_NOSTART))
+			if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
 				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index fdbc54622dbfbf..e8e57462ce9d64 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3437,7 +3437,7 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
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
