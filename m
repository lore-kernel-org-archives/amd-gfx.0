Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717AEC4361B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 04:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 336B42389E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 04:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336B42389E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBBE16E0E7;
	Wed,  9 Dec 2020 04:19:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E6B36E0EB
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 04:19:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8yOrLN9od5wRbxYL2Pr2dzR1AEOGp+A8eRoce1+Pe5BgLV81gs8uh9gtcOPllYnvVtT9wJcjyUVZgy6DisxfhiEdE61nScQHMbKOhGHQyO/NkUC5WNFZu58U4uPh8G/dTe3pw879iR1dmHQ4DZajti6hQHrNpnudTNNB3JH5XdZVfxsNmgGVsT2zLThAkkmMR/EcKl6rbP5OBThyUL4fgXjlfCzamRCvG/N+RXanIphnfA8igGvmTkRv3LxtIvQVnwzaxvCFP16iWvbrAJHoTtahZLB8KXhHYNXibacHXGkA22w2gXE8V0hveyqy06S1J/ENX/W7TeYQFdXtg0oAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vL95kw658FozOAAXYgGXGHoRJ1Dfhc3Hxs67OC3n7M=;
 b=NFxXTuqkEWSiWHA3rChdYLGYuPcY38QYrLXtRR68gqkSZfCZNHPfuN95XnchY+8ZCmGczRC2uoC+M8ytSBgiIws2VHwO5BqazOQNbwmFvydrVtixBfOqVEtzBHKpkC5oMgO3erC8SRepNIn/KN3uayTGcYMA8YS+GAd8GhhLscYxkLTZnBCGdU8wX5hvFA+t1LQU547b93v9fj+pmDbJaEqKOcbt7YzlnePM8Al6HmQ2TICFjpnTODsSiu4s//B3M6dY6Q8JdqOXTt/Y8CRHjibHjaz2ZddphBVqyI6V/4XA0tTeitFvPpVtcACCG/CyXaooPLcUwtrwH+tf/oQqbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vL95kw658FozOAAXYgGXGHoRJ1Dfhc3Hxs67OC3n7M=;
 b=qZDLCgYQtoyA3O0EHEGr8MOWfkH/Y1yrTYKv7eQDQBRLfXGLoo3pEVxR5HGMtUtUzn3jlAreCkUGyzz6LaeACcORTXWdOfNy7BXS2cM04Iz9D0wc+BOTvDOUOEbm5N3RLvHoY5YMDO4MCJFRbz1vAQwTOA49HB5IN4QZdZ2hhug=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB2505.namprd12.prod.outlook.com (2603:10b6:3:ea::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Wed, 9 Dec 2020 04:19:09 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Wed, 9 Dec 2020
 04:19:09 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amd/pm: new SMC message for 2nd usb2.0 port workaround
Date: Wed,  9 Dec 2020 12:18:35 +0800
Message-Id: <20201209041836.143264-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201209041836.143264-1-evan.quan@amd.com>
References: <20201209041836.143264-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0024.apcprd03.prod.outlook.com
 (2603:1096:203:c9::11) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HKAPR03CA0024.apcprd03.prod.outlook.com (2603:1096:203:c9::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.5 via Frontend Transport; Wed, 9 Dec 2020 04:19:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eae90a8b-f65c-4361-38cb-08d89bf9938d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2505:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB250507C89EFBD096F61806FDE4CC0@DM5PR1201MB2505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:363;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GHFV4qXiwqtHHKHW2k4VyLp5fSF9ZaFNpEUN5TCQR5ISt9F+l7ZM/25DNe2Ag69JVEwHeJC0+SmF92oUK2zSVmKqRY8I9KGO8DpNEuu080v4mxNIp8tesbJdTJfiYUffFgJrp4oZpS0TE9EkJIxoMvANY6b3IDe29luxSHO5DJjopkRmydeTeML0qKP7P/vmE83cXEQ0Q9he4jnAAW4ODWIjg5i3ev9c2bzegEqseUSQIl7IdFlOTNMqrTEUeVEN9otgR7BGQVhjRtszR67LY8qw4ouoLpIRsewjZx8JuHGgp8Q6iTVROSkOVdYInMAWrZ6bN2hR7j7YiyGJdiEwWtboHM/Mmr0cdoVOvqvZ7LB4BRFj0VTv2hhKla55/um3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(8936002)(7696005)(66556008)(66946007)(66476007)(52116002)(508600001)(186003)(16526019)(44832011)(6916009)(8676002)(6666004)(1076003)(36756003)(83380400001)(26005)(86362001)(2906002)(34490700003)(4326008)(6486002)(5660300002)(956004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ps+OiM1kJpwojEfQjr3CLWrbG2JV+YjjAz8sckE40D7xZNwLqnFF5jHIyiSK?=
 =?us-ascii?Q?1KmPCx9cTlfg6mTSSzyobZcpBgrn7Z9Axnm8qGkworNdmV+gTRqTQRuExBcM?=
 =?us-ascii?Q?kdQwxgRLLEt6XrNsuG1oSiCZ8OVcQ+jSanQ1HEla4hIkUaZXcBSbUhqXanIn?=
 =?us-ascii?Q?r7LqhaHr8QG8zcFlwDanlyBjPHxO+8tAOhI16wQcc2HWHk6lu4yzMocN1BfT?=
 =?us-ascii?Q?exhvoqEUjtG7oZwB+glVaNtfu7kgk7KSYCVxzTLToTOBlVNf/mca47wGcs6L?=
 =?us-ascii?Q?BZJ4OY8Pj9lxPp+wkDjIidXbHJox+S83KK+5TV/DjDlXetvQSYWRT6g8y/tk?=
 =?us-ascii?Q?7F1FeB9za9GMclAreXSLnYOqoobZ5H17qaouKhJlm8/A8kgv2GRvInJXszdF?=
 =?us-ascii?Q?QmfCGrEbl2p+0A3iYuU7CIWIojILVVeUHLOwTCIpf3yu3o/GSMBDcvERfxg3?=
 =?us-ascii?Q?x5Hod0uY+r9lPn1d+CyY/GMu/oVa4GFyJE7C/9YfegMfzaJdTQQ06AjUTkO2?=
 =?us-ascii?Q?uWKjHdAFZrjwBGNmmxRThrP4QPUwemcMCOJIYend89MTwmjMbsuzt1aGoDlf?=
 =?us-ascii?Q?NnDGgbkfEVb/G7V6mYBA/zTxOCaFc3++/s5bs/daIMOI39WIjc4dn0FA2dK5?=
 =?us-ascii?Q?DJF1IwnOKI9++/qI5yJ04GzPvSK4CWYSNIkiQ+kfU5tIqpWdImMDZEwes+9p?=
 =?us-ascii?Q?fQeKO2AGzaGkp+xxEqVLckvmt+DJPJyNyW3ADzBB5zp84HHM0Q0kZQcz602K?=
 =?us-ascii?Q?7LmTU0Ev45j2OFkFEq76pg18ct8L30xDPv6KYoLSN3wvbNkdPfoB7jEVQSLs?=
 =?us-ascii?Q?fTHGatM9ePCsHSg2GWPWZxaZ+984hEs1RW0e3+pL0PPkK8UaSHqhVldXw4t9?=
 =?us-ascii?Q?W9fc6jehUSLK+VpJm1t+f/ciEdHiA/bE4sjRbK0zMMc2VakYr5SVqLqugtfz?=
 =?us-ascii?Q?N7BXE07ubeUfZCQY+rUtlShvy3CY5ucoBNOZvE2UqV7wxCE4PquBeaGF5w1m?=
 =?us-ascii?Q?JtjN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 04:19:09.6493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: eae90a8b-f65c-4361-38cb-08d89bf9938d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZdWOnEclQ5MauufEsit18G7qXhNrFvuZnOBbtP+ztsh5exM5yVOG/xPZX+SaXvw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2505
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The workaround is needed by sienna cichlid.

Change-Id: Ib3d065b53dcb331d085e9bb9eeda99021a212206
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h                  | 1 +
 drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h          | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index c79ad184503e..13d332a175fd 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -210,6 +210,7 @@
        __SMU_DUMMY_MAP(SetSoftMaxCclk),                     \
 	__SMU_DUMMY_MAP(SetGpoFeaturePMask),             \
 	__SMU_DUMMY_MAP(DisallowGpo),                    \
+	__SMU_DUMMY_MAP(Enable2ndUSB20Port),             \
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h
index dad2832ff3b1..d2e10a724560 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h
@@ -136,6 +136,8 @@
 
 #define PPSMC_MSG_DisallowGpo                    0x56
 
+#define PPSMC_MSG_Enable2ndUSB20Port             0x57
+
 #define PPSMC_Message_Count                      0x58
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 7e8aa5f7c0c9..47d4f92d5ead 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -129,6 +129,7 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(SetMGpuFanBoostLimitRpm,	PPSMC_MSG_SetMGpuFanBoostLimitRpm,     0),
 	MSG_MAP(SetGpoFeaturePMask,		PPSMC_MSG_SetGpoFeaturePMask,          0),
 	MSG_MAP(DisallowGpo,			PPSMC_MSG_DisallowGpo,                 0),
+	MSG_MAP(Enable2ndUSB20Port,		PPSMC_MSG_Enable2ndUSB20Port,          0),
 };
 
 static struct cmn2asic_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = {
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
