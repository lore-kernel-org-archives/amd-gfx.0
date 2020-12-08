Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27658C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 08:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D06E723A5B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 08:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06E723A5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D4DF6E94E;
	Tue,  8 Dec 2020 08:28:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 668AB6E94E
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 08:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRcu56om1tCq1uxJSDFTb9SOFsOwpMPXUVStpmN9n/3c7L/MWnQAXVJe3eS/vlJxLFBGnwDE8Ae7K7aIk5HmYJHUagdc1uAUCdqNrrKJzcGoLevV0E0Rup9QklckGzIQnU2I9vyp3jVet/Dq0WJaT8niekxxrBYw9FIAK3Rr2/Axmte4SvmbIeAxV23V4IYtegsJZGn2UhSn304vfXbD8Ez+oIBdLAlNEvrGuUjzIYBstrk3cFqPwSCuMC2BWJDNk9xYfNMtoJ+rXQiZ0eMOC/Ki9qw21km7Me42VsSxWJJNXkjP8EGcRFa/mBaz7+QPmfSOuSGtRvFA/8txTyUqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vL95kw658FozOAAXYgGXGHoRJ1Dfhc3Hxs67OC3n7M=;
 b=hc3tyboqF1lqzlYMAyI4ifq786CydEluX5DFMXGg9UilBs/Xz9IQdEJPDfVgeUA5GX9K7ARKwFufjYzaAORH0XDWC4DbAatRY2T9MqDloyIQ0W4gWdFgeXk0+oaSXB+lHufbiYz5tmb9Eu7VRMFwZsDfNDr+UzRMIgkaVgwJR1Po04L6Q3gp/DjP218utObtQ2K+zc9fqSSSffadxTX1+hq20XnSqEImJH8Uq3ySgwY1nMHMLPKzfvSviiM4MRpoeApv6bpIfp2GTk/kGMQd2bvgC5apO1TgZzXah5HepdxbHN/C8PJNxCAWvFFiVx8IN4QyLyEzJSM4JllYHkMCig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vL95kw658FozOAAXYgGXGHoRJ1Dfhc3Hxs67OC3n7M=;
 b=huUtYkvd4l2K1AFCirGDQq4z8Hwa1h8sGDwvJNHzLKWq+vgXznnPG5DGpQyTe+53LTqUpnoah6F71Z/dMOeIxAOIoG9VXfFQ4zBXLHEiXrbZMDtVZldKvrTIXnT0u8VlyWh0xKGVeDAo9wruUD7ivv7eEQAFjS8WV6hzaS6RTOs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB2507.namprd12.prod.outlook.com (2603:10b6:3:e9::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.18; Tue, 8 Dec 2020 08:28:05 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 08:28:05 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/6] drm/amd/pm: new SMC message for 2nd usb2.0 port workaround
Date: Tue,  8 Dec 2020 16:27:31 +0800
Message-Id: <20201208082733.126647-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201208082733.126647-1-evan.quan@amd.com>
References: <20201208082733.126647-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0061.apcprd03.prod.outlook.com
 (2603:1096:202:17::31) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR03CA0061.apcprd03.prod.outlook.com (2603:1096:202:17::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.7 via Frontend Transport; Tue, 8 Dec 2020 08:28:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dfb0c3a4-fdff-482b-22b5-08d89b532fbb
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2507:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2507FB1721645C7D08CFB579E4CD0@DM5PR1201MB2507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:363;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FT/qvXyKnv8qkYkMALrl/LEjHW2MJcAzy2MxLdGBrp8pLyaL4fI3BROYlh/wTxALP/jZecyastH33VWloHLOONSJX+iat/0Iyt/b5hRg2iCHTeUwtYrOCIX5sVMaPZR4vGspRg6wB0dyWqBOtV7nZzsmLCk+lhC630SKD/llXPhLI4xhTRYthJgeR3oCFO8fTvinrQuoA+XRG1PjX5LoCIyr0fZ6LLOXE7Nyh27gEm//eus6v5jGbmkTvQyPxt1TVecfNbJObskkgVDIbmygH6i6GinCyZV1sCYe5TgOncm5bE2WNKJMH45/oLvYeYDA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(2906002)(4326008)(8676002)(52116002)(66476007)(66556008)(7696005)(66946007)(2616005)(83380400001)(478600001)(316002)(8936002)(26005)(44832011)(956004)(186003)(36756003)(6666004)(16526019)(5660300002)(6916009)(6486002)(1076003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5rnqfoCFvNBNtEf7DQcxUVN4Fuc1hPvRSWN/NV4dI1yihr3tisGsu2sSvlzC?=
 =?us-ascii?Q?Cju3NbmiPrZjip4lJP0s5GoYTNdVcxU6VNDmg4grE7KuLU8itbBYvIO6+wOR?=
 =?us-ascii?Q?n6DchqKh4xM+UC+T3qTXD+G90mPOfcNocExv1c/z5rR/WWq04M4tvNOS8tV1?=
 =?us-ascii?Q?K31ZQQC+oQAzkzOwD3bawzua+WQ2ZWCqCJJwsUoxaEQDwaJCPEDfkhMCAnGx?=
 =?us-ascii?Q?qjri53Zo9qEoPGqV6dqRMji+JiQ+dtEGfEyzd1w7Wl+Hm/yJDHaR1uh2tsim?=
 =?us-ascii?Q?zgRQeYI0t+RxFdvqvITR9ElLGAi2M11Ddup2tQEgm7Qpu7Q7Zp5ScSM073fp?=
 =?us-ascii?Q?0JC0hQXse+8cy9ZEVN+WRPB6FJd0gZ1+Py9qD6nJS41k31/6Ab+EiemhAsSB?=
 =?us-ascii?Q?Ugx4vvAaxLOCXxZQGxJ5AFOMoLKGqbQ8nRAVY1JA8aXV67dmK5mf2ypvgAq1?=
 =?us-ascii?Q?ifHymqal5VckxrMzZHlvzTfRe6BAZ3eDCBQ+WEjCRTAMW3TOSGdqPzTa2u77?=
 =?us-ascii?Q?scBfjh2vIEKfN/CkA3s2wUXTTOXjIJA9InU4l61XEKb3iOJscs6ZmtfR3Kh8?=
 =?us-ascii?Q?TvRlhPYT6PpQbCFQ3YDVCcRkgdQZfADMnjgIyB0YtG7nHICDm3bq6CXHyiod?=
 =?us-ascii?Q?QtxFuJXLoLZDEyFjXptn0lxCC2ibQ3HXIe7wXjXDtNVdTngcAmr4ohu8BNYJ?=
 =?us-ascii?Q?XwS7V03lnTF1UWxAT06wWC86XhcDti8i7Uv/CulphUhqQUvztVwn/2yGsIxf?=
 =?us-ascii?Q?6gp7X2lltojMAlX2WQn5Ac1hvGmpugstF2C4uOE/fQelH47oSCxylIh6XP4J?=
 =?us-ascii?Q?WyVeWlKvvMpW/TAbLsoOZh743OzD9a7FAI58hJj8aGsMOEGPBIr4DxA/CwwP?=
 =?us-ascii?Q?Ci8JA9YsIc4xfFqOx9R0+GZorJ8AaANUlZ95J0JjAro6C2cwl1i6LcodV4nK?=
 =?us-ascii?Q?7AEoLYdbWhbSaZXsvQY6BLlcYXKeu8LtRexhvtmC+7w2aOFaMtVOnIUSSnT0?=
 =?us-ascii?Q?6800?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 08:28:05.7299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb0c3a4-fdff-482b-22b5-08d89b532fbb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0tQrAJs6k0bDc64aZJLkz0tuHtwd6ZXcZ5oAjoyaPLTjuJS+X+MMEjvBVSwJ8gn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2507
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
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
