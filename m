Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5E1C48BE6
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A3360FDA
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A3360FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE906E10A;
	Mon, 14 Jun 2021 17:46:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A76856E0F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:46:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0Lp+2nIJyEYnjHPpyZ1QhQc20z5AxfYg7JOO6YBuhdciftEFMaeOroG7KOQTF7lzDbgavPD6xU0x0d5McqWhhwgC7mJQdz3uCjZIgzOYZmhxqUw9ZuyHHao5hapbLwfoEbEmmeRyV9UxKIgL7Cmr1pbKPfRalrQ4mYtHaVDWm12yCtmLUDgFrRH9rvRoOWHLaH1nVGHev/A7HiIHpZdOwf2Y3qQh9JRlgofxYRuZrhrJblzBlxF+ODNFKilfOTlnryAjaczqTeH2qF5REZdFVn8CJiR3AQnnLi6Vjf2nW7H2UESnkAYTkBmxbitSG0xaDD23ny5NnJgDU9ALrrI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9K48DY7x74vo6C4NYV4Z/6SvU9EfeHMIclh6zDogfg=;
 b=TWsIP1NRhJkXJx0hDQ8ibX5YcR0PzJq84WuA9k1mchOd7143bwPQfH90SC0v74qEIM3C/rHBcfYK9K5sPOXzkILMlOI7OIVpqiDmVeKKko4uQH2F51D5kekrhAJAQaPrvb5EFpnK8Bi6SkaCm9OPJhHQWS180SaeHTbHiUjYERWNpbjxWaspL/p2V70sJM0wvw3HKjN20sf7NHPbJ7t6ni/z9vAb4uV6WpYvJTjT1xkL+mEF8ep9si72YUGRnqmBrdZQMoX38X3EJxxDBs/HBnFCnXaue9VLxtbceGsxP6DgywFzSIm/JOH6EzoEVcEonqjkxDKKlGQnThD8Sghgxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9K48DY7x74vo6C4NYV4Z/6SvU9EfeHMIclh6zDogfg=;
 b=l5SiXfwd1dNZnXK7S44PScFSGmbmC0TpiXl8aGzGjb/4olhfsNI1vCdOQf1Q09yoQSPXTdPDL/FDOBPRT5BL0T73QI2QQ1+D9Vx4UHaiWT0qBqvpyPwIzNn55gQ5e+IKI1gNL+PQboV2hOp/R3eYRvgi8DkOKbdf6zlwcXsk6hk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:46:55 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:46:55 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/40] drm/amdgpu: only set restart on first cmd of the smu
 i2c transaction
Date: Mon, 14 Jun 2021 13:46:03 -0400
Message-Id: <20210614174632.20818-12-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:46:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 028eae4f-8a53-4696-9e8d-08d92f5c6686
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4748FD20E615A6152CC7F91099319@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJy+fDtpI9IAJHf656wPkMIWZGyCTwF/csEgqigH3LgzI8lReUpW30zOrcmJlSWGEMrXFbOZndArOWqcSNEuyflRLNxjCN/MCHlvNiB55D+pDdXuNR0ad8MqPCIwMOuPvQciQrYyC5N4FlUxyooNoYgJVpSvLJ2WY55+hcHbxNtrp2uPTo5mPDQbCnln6FJdU0IyfZ1/7SB7poOVQwBW60Wqq3IjrvKeAgBurM7ywsdqTnKBKOP6wAxAFcXJPtNpUt+InVAvrYpSYUdfhAtfaadv/YjAs3Sqsw/QAqUn+/r1s+6s/OMGtzqJpuYBJdJBd0dmOFsNB3e+GSEi/IvHwpz233BL2XdOCFrj4eYRopnBjh1psA2g/4/3j2GSn2AIwOoVy/wPKyQLz5u4VyFb0YtmmiiU+loPk4vuG7ddQ87/3eTyDVFK+E8vZjOMIg+A0n4x8Y9g/uLdE3TnSv82bg97mS5hhl0VbKrE6bbHvHr/bIIeTG/S9RgkNDNscN2RkLwzaHBPP3EA+7nm20ObXG5a0D8k9FoCaPGvEqHbQrAU+8hMwu6Vy/pH3kP9f7UdzYY/VuNpSWnnUr8o72izNx7gFdk55OYMT6O1nBKq8E2DY/vIwYKeuyADW2olz0bKGPZV/7E6kuvOo4sn7pI536teKzOM8xMxaDPJb3o5BNKcMQA/9Qp7C6U0r+DQaIoQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(1076003)(26005)(6512007)(16526019)(186003)(4326008)(6666004)(38100700002)(8676002)(54906003)(2616005)(956004)(2906002)(8936002)(66946007)(6916009)(38350700002)(478600001)(83380400001)(6506007)(5660300002)(52116002)(44832011)(86362001)(55236004)(6486002)(66476007)(66556008)(36756003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wueL1WPjrE5eoEkgIYjCoW3mC4lUXJlhVD7ggAKzQWP0unHJYQoADNFAt5IU?=
 =?us-ascii?Q?81rdLPVstUBZ9hlQFIxeBwUMHbA8/+6qgByw4E8Onc/foQ4QP0edC4VH6rwu?=
 =?us-ascii?Q?Nd4+LJnVwdU6q72kURZrlnxNh8Qse12vRqZ2XYyNpBoV4C4CXNVSpvFqpMJ3?=
 =?us-ascii?Q?ZVItBWQ78tuIlROHM4VaOh3Xo07QDHxOUbq28ndh4AK6B1NcLXdLSxaP+CVS?=
 =?us-ascii?Q?FMmGKupnoZp5NKFfhFJkjEfCXHKIkmIMIBT6Uhxj9H88WuW997DR0c3ZBWTx?=
 =?us-ascii?Q?9uQAJaownFGM+drBWyG11YeocDOAnXWKt4SOHO67xFTLvXsOpcNXcffzw9Wd?=
 =?us-ascii?Q?d7e5dKrfkKJZgjWK8aeouzGq9o/ponkzIcMpcM/H5QKH1jNHC0jkLtu9BMjT?=
 =?us-ascii?Q?HQ5Ck2dmKrNN5tWtOpn0yWDLOX87ToeJFgGmzksWj0umdWvK7QeEi+dRqEah?=
 =?us-ascii?Q?OaO49RZF/ERPi+gQ58aMdt4rB+nAbhR+3HN9W/PA2YS4WTovN+YRHi5IugSS?=
 =?us-ascii?Q?t6003eb/ca91ujiya+o3KtsFsebtb2liSAkvlWyQ2Hvtwp7rZwg3O1HW/bc4?=
 =?us-ascii?Q?tM/hZp+U42bLDD0nwA5O0WeYal3HqW7wV2GSmvqb4/09NzFxbF5myC85klvL?=
 =?us-ascii?Q?HjQPYeVnzQNNCB00hA6Bf3xXpwuED4drA65ohydFOTz+vBBi/stn84JmacIE?=
 =?us-ascii?Q?LoZHtMaUpr/kpUotxAQI90wkG2OqIB81KkVH6/EQBYwVeo3gzAwK55Myv0PL?=
 =?us-ascii?Q?6GyYcqfbVleEQ0c4eUpRb9a6sD9t+5bpKQ20xfG9uaHGUMe8E/WskY8DDLuR?=
 =?us-ascii?Q?7zjmeBIwI3MBRHuBgAtKKZC2K83HLMCTBysO6hfLO3svJ91YbxucE4yv+XDq?=
 =?us-ascii?Q?ZdV2Wo4bc/lEvlJ8lQXCGrkcYydUXze1Qi5XbmUYw9+74dFJQayO3QhRz51h?=
 =?us-ascii?Q?t6GPWNkXw2WxDHbz61vkl9gGwe826vD3sFRq/d8/qkBd/PBH/Za7TAcCEkMV?=
 =?us-ascii?Q?7j1ijzrFIkWLiiKbKcHVxMaSpQ7xpIU4ngHFYC8XNvJpe5H+XUAEJsz3xg6V?=
 =?us-ascii?Q?FqV/9rpuYqQwJUbatnE3/MVW20gyUj9UGLJe4Rp6RNK8rJ/QjhsSeiTTiGlb?=
 =?us-ascii?Q?katziikyP5qYHnQ4E31gBykKPFZJIVctArUIxogTwsXk+4P5NaFNbPq1IXRL?=
 =?us-ascii?Q?ce+4jdm8bwY8YW4L9fFgwI/17bUu7MKSdduOMzft79FUZoqEhFQxHOCIWJE/?=
 =?us-ascii?Q?Pc0uNvBb5XmJL6qSDiKGJtRTLtVPkFan6YZNqKhIrpgiVCvxkYg/An5nWlVj?=
 =?us-ascii?Q?gFCHZzAlElatfxN9DjhvgwVD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028eae4f-8a53-4696-9e8d-08d92f5c6686
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:46:55.4570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgJfPoBpjzs2q1LHiAt+JIKFm3wSI0dOXfFr7ZZMcuVg3gtJl6O4Jnu0VTxkQUq7
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
index 404afc9979c69b..843eb2357afaaf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1984,7 +1984,7 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 			if ((msg[i].flags & I2C_M_STOP) ||
 			    (!remaining_bytes))
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
-			if ((i > 0) && !(msg[i].flags & I2C_M_NOSTART))
+			if ((i > 0) && (j == 0) && !(msg[i].flags & I2C_M_NOSTART))
 				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index d3efe897ebbb2f..f8219e9ef5c62d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2783,7 +2783,7 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 			if ((msg[i].flags & I2C_M_STOP) ||
 			    (!remaining_bytes))
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
-			if ((i > 0) && !(msg[i].flags & I2C_M_NOSTART))
+			if ((i > 0) && (j == 0) && !(msg[i].flags & I2C_M_NOSTART))
 				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 1d06641ad87890..9e49505a6ac109 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3490,7 +3490,7 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
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
