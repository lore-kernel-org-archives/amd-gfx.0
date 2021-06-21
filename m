Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44B4C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B42C06102A
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42C06102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 970FA6E22F;
	Mon, 21 Jun 2021 17:12:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D1566E21D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3Xji5PTZOKJDsXmE7/80JU7zl2QfQv7/mT2O58NkYhbkcCIiGT9jzq6pth/pfw67Kxkk95tE1XHygraEAEDpsYLA7tvr+jnJ2MWHugbgbLG8qg2tCbQ6iWw79E7NNV7AYdxbOklt6BwRC2X6J2t+rG+K3h1DqzZnyuQvY4wCXXZO6c9eGarFJ3JQ4psrgpU2D6108E79zhgsOOcYwR3o6OWNP4CIh9yrqvzb9C4LCoYR0UsA0qpogo/+jNJauRAZxuE86XdwQN5jE9CnD1VnPXR9Q/kU2RZBKphZaituz1wmErYJxOXiJc9JSo8RIekh0BthdTtTyVOjQIIyv37qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40j2KeMd3wFd9AC/jHDFW/zjpbQiGerYj57hg4oNKrU=;
 b=Y6kJF2WJrbliUYD7B8CUXVQ9i6XvBueJwZSBRVug551t+9MLlPfEo3abiLw4S16LM7yAPlVMBq7HwvnpiX2/UAwjdv12axz15i2MmFmbRIoLZmAOIPORgTSS/2M9mL73tvehBjQhwojLWaB0lUmVNZAW+wv3XE3FFL6QlMxxEyX1dJKngIXMZKr7DQTjcwkrWIGG3rL/5E1EhyN2ZyOVR64aAeGCAqDkCqJ7iVh5a5fDSPewFAWmMrKZaUg98dviKui0KraueI7fqA4VA9PPw1t4c0wM54TrjwSZKQbGaPsj1oKNutN5+wZuLIvs9mC43oSpz4bdo+WWpnJWn6Ii1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40j2KeMd3wFd9AC/jHDFW/zjpbQiGerYj57hg4oNKrU=;
 b=zZieppVFmlA42Pvb7L7pjL7/sAEzR3hjgXY74VV3A3ShI+e6kcLfFKdHBX+NqiPpF/UOKCA7p5tnIEHY4qLs1DJP6r7F3UXouxzNjLnAm2oOUUBJK5JLyGcPiVpQD4uownJhsILsIAwdcf5Ybjg0xztez33ZSWlYKizmd005wOM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:12:43 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:43 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/43] drm/amdgpu: only set restart on first cmd of the smu
 i2c transaction
Date: Mon, 21 Jun 2021 13:11:49 -0400
Message-Id: <20210621171221.5720-12-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 015a199c-1355-4edf-3366-08d934d7c78d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3865CC416CCB715EC481D1CB990A9@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5vyWVTrdf41j6g1pWUrRL2kouv83WC5jYBDE4RSZtRK8OU1gKSAx81ZyUkZPK/X2GJy9TOJb7aWTnwuq6p1RLW8ONOoj7V92+NspO/wTAvJBU72dPOllJBhJIebjpJvQQDtDj2meEF3CAapI3Bv5DvK+Gc5Bx0w61F3cP+rWi/SHK6+8cNpllRn6u276DcNHBdUGliwkaMWdigEqi/G0jJ50BFQw4hYpl6OENJNwlNH36H7tf/F67lRvzpk8b6DB43ka3GZ+4BK+ML//DZbBeSBqwknUT+QWcmdXCj1Asye/KedRXefr6Xd1werdOYBuSzbfPvZtUG/55JBUzGejQp/GR3TjxUCzIs3Dy/I7Zrwf4SMbOBkbBjZUdAWijywyDIx14ENLPTOOwpqrd5zGkBlehgFhvQ5KBP35JLPmvtBNM22jm1rH43DiDaBWUIPQEOyTTQOpnhQAcqXIP4eaHrtYAvlu0CrAt2oT0bZpRwbYG8R4n45W/89K4TLSsO61cPdhhdFGaQWwY8fRoMVWthLp83/jbJB3TS8dpj4Lyc3+QLvTy5kQnBsv+T3L0nbvN/C6aaMF8e/ECEvBS6OVImN0NfoOeuK+913D+/x83UzU8w67qj/aFqiE9PMYosri0ILzZEFCpg4/F53EbqQ+/KXbN3tSJJ66LWuT3GqTgk1Cn6jr5gy4Uy/gwa1t79Wz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(478600001)(44832011)(54906003)(52116002)(316002)(66556008)(6916009)(66476007)(66946007)(8676002)(2906002)(5660300002)(956004)(26005)(6512007)(83380400001)(1076003)(8936002)(38100700002)(38350700002)(186003)(6486002)(2616005)(16526019)(55236004)(36756003)(86362001)(6506007)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z7d9v4B5/iw8E/lFXKFpOPnzd2+AbJh/wdzwaMpu+zgXisfzbLsF2t166h20?=
 =?us-ascii?Q?MmAG6Hxw66y4wTzin4w/B2Ljq6qnJoJ3kl0++8Ln5rBX0wZquR3odBgdLsiB?=
 =?us-ascii?Q?RbhPC84d6LmI9d0rDFHtbnykykeIsxdGz6jrbE65Ar1Dhzap/3MV92KAAqMF?=
 =?us-ascii?Q?HD/2M7DbMfOg9E3Ac1dOe8qckhVmkUQk6JPZTYRSaCR7f7UxETRL/4MlG7Q5?=
 =?us-ascii?Q?zCH5yrHGuECKAd5MAxb0V9UAsixOPeW7MxmbNbgSnO2IJP9XstCjfN7X/DAW?=
 =?us-ascii?Q?6mpopXfMKYeUzk8dPjTaDJNsQloaCOBweo7rbM44xkgUNPNke4G1+Nwf/PI2?=
 =?us-ascii?Q?shjDIqHktpuaF6UtNcZE/meVRR3PfGJ8e1NNBlTJC/ccXBkc/BjiJXmpiePA?=
 =?us-ascii?Q?qIsSM1C+Mm2flHoXYFjaYx6W2SPyjjgnXID4qj4TBFGeKNJja6aMQf7l+4/H?=
 =?us-ascii?Q?LTQqAj7KYttkqGp5n+4l3N+z9drgbMtSANKL0khJoIC7gYGZJuHMaM4KtZI4?=
 =?us-ascii?Q?O2MnO9TPJencJGRocJyDfYPEqO0eFIfIjJj3XSfr7lwxkT5cSOEUb8PG9gQr?=
 =?us-ascii?Q?b3aWV8Em1xbek/ifj+uSZ1+cygabfcaYI+/ymI6MaaLMI4rVNFD7DzumuAQh?=
 =?us-ascii?Q?372fF6Lo6jslHkIDgFvB+ibW8T2vKCgy+Hqyh+83itp1mKO3nDS0+sjPwgfL?=
 =?us-ascii?Q?XteaR9QtKb4AjZqlfPjOQLeHRMo9KiszM14/GBL7DJsLUnRFm8672nIntiP0?=
 =?us-ascii?Q?DJEzxaU55AjSlTdZyMbDF0ILmUxg4EgoHed6GjdlpDpDX9eRXd8HaVM5LPhA?=
 =?us-ascii?Q?v/FlWH03KBP1gkQmFFK0x27kR0StguXMzJ2c8okrStr8ZQCCUTLX2pV8OK0W?=
 =?us-ascii?Q?Axezd5jbWaN+KvvwO0VXdATo/X6W0cNblObK0dXZHGS05oebC4Kqdt4hAQrT?=
 =?us-ascii?Q?yK95QJ+1Bx6t9UQMdbwm7l0s76pGUbX3ckKbVymdYAmA1BNcMwMPwa0jq3Lm?=
 =?us-ascii?Q?j6xZf/GzLbYuX6sHupDmNMrrjCo4bcJdvyj4FMoipHH5ZOwjkiWKIHVfoBV7?=
 =?us-ascii?Q?f93iBn9+KkMQOfce7PUq1ZjSVIRxucfTe10ev71Dm3r4K0dqoXxAQ6tSpbpJ?=
 =?us-ascii?Q?/IrsebQcdD5uRRpojBkw7UAN5ajgD2A1xTKm5Zj9PB3QfG4JAxs1pavoMu3G?=
 =?us-ascii?Q?yjOgSbaeCzYFkjwCwmHkc2GbvUNaOb0kjlZHJf7L1vnSzfjB4Trbmu7NFy1P?=
 =?us-ascii?Q?Ly48Aw+hMUn5n7alzefhFDbX20ARwtsUZoaNPCQAxZijJHGY8+X2aKzyqhid?=
 =?us-ascii?Q?LmrDpIRtwWyN8y4YvcbyguqX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015a199c-1355-4edf-3366-08d934d7c78d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:42.1407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFSiFGpWVYB/fvpaUFyvlVLvMYvQ7N57kH6CokTN8YEL0H+83ERf2Pc/VITs57N4
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
index 3303830afac7d0..abb3647ea0a892 100644
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
