Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C57C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 08:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D7823A5B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 08:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D7823A5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 698C96E0A0;
	Tue,  8 Dec 2020 08:27:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AABB06E0A0
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 08:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUPfzbHeWVrWyeu3+/nNJMLJ4RgtvfwP7CTmI998xm6k7LFu1j2xJJ92Zbc5TdI4KETCSRM7XbKueA0T83i7URbTGDk2478+mn3nxAd1m75jaw1/42S+uhKd9rhN3MZW69DUSeZIpbNPaTYbRxe3S7Zm4kLk4NdDcRBMilQr9Tx22sXWNMKJ/tB99brc6jm8xm0lPbUEQF1d8N3dJuOJiEY50ECAYrxLFzjEaz9u8HJPMfMOzIVx5QEYZbWQpmkJNSGnwoVwj7bwmWdPm5OEFhkBEWisaAaRNYozzeDg7gE0UnNElAHYW6zKuQ6zkP2TIvZxRrfUvVkEXxOEZWHtxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slLWgRUYpsmr1heBln+gvWpOhM1N8gXFhM70YJhO0/I=;
 b=lHK2toZrZ/qv0aNHR/9TDblXqYkC2SZadvNNTTfBra5463VeUlgdp/oRSWhjQnZkefzKJ1yi+/XjntqZJE9PWI25fInmfWK+GC+62FLjPcXY+cBfmxOvkxwhb1QlDephtaOzY9f1ddKLPMaZzC8OKHKDJGNBESml/mD+8KaOc0gyzxCsh79f4OvPPi+USJLiMweuEFu27bEdGtTT3X9oVG7TXSXtc+zCindezbcM26SoVES6mrf2nCZeZp753Kmh6y5CM2qYx7+7mGydn+dqHJ56Ge44aPC2lSGRmwik36sGL2H3jnTd5txF63AZpMQNyeNz+Lx1VG1K+aQSPMRsgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slLWgRUYpsmr1heBln+gvWpOhM1N8gXFhM70YJhO0/I=;
 b=fiaryNNAV4PjKZDaPFO229uvqnrz+R6EHEeCzCQ52k2D0Rc1JGN2XYIT0dcjNZztvRlc4V4xAHLqA/UJKMgS6RX5pvt/CngL27w70e6HVbNkBYAPhQGEJCnWPyryBZiPoaQGUPpaE90u0BK1T3d+heVi1AV+/T8mQ2kpE9m7o/g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB2507.namprd12.prod.outlook.com (2603:10b6:3:e9::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.18; Tue, 8 Dec 2020 08:27:53 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 08:27:53 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/6] drm/amd/pm: correct the gpo control for sienna cichlid
Date: Tue,  8 Dec 2020 16:27:28 +0800
Message-Id: <20201208082733.126647-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0061.apcprd03.prod.outlook.com
 (2603:1096:202:17::31) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR03CA0061.apcprd03.prod.outlook.com (2603:1096:202:17::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.7 via Frontend Transport; Tue, 8 Dec 2020 08:27:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff42abab-4a45-48de-2e09-08d89b532886
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2507:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB250702E4C4C07ED71E104BA8E4CD0@DM5PR1201MB2507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKZDT5yNhlC7KbhJEL4meEypjfFZSjxzX2SoDWnb6b0SVnwJd5rR1tpC/W8QX2lou9rJHCzajfi7P0yQ9WOiHJ+oiOORvvTCb0BhMpjs2iP5g2ZjPSSE5icDN2+KdfIl+5/75yAwrXPcuOSbq6N/99nlcs7ADAw0ZoG8Y+e7MYqu5+4vHFhCoYlXot7hj+OhHd9/KvF96xEbk1dvvtbr3YH+hrbV9soxkZp27Ej2sxIGq6qmIeUX7fuGaCwm+nGwd70nZrEd/D2h1sG+QFNQLtvP4DoEQ0/oJO6rck5WpqLv/VoiMJpBekST6GF7HMeXSTRPHhWyWMXLu2ZwgLyVJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(2906002)(4326008)(8676002)(52116002)(66476007)(66556008)(7696005)(66946007)(2616005)(83380400001)(478600001)(316002)(8936002)(26005)(44832011)(956004)(186003)(36756003)(6666004)(16526019)(5660300002)(6916009)(6486002)(1076003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eQQ2jcgznBNebiHux6uqs1+lTuiYH9ikXxQ35jV0kREezmuQ/wwCtrHN2f8u?=
 =?us-ascii?Q?bsZtjpdvZqjyjuJUEBzmTmyLuEaizSSGHa8dyZvE8qtMsT4Uo4ubv7pEQt1M?=
 =?us-ascii?Q?YeV5C5qFyTXGLs+6LbTU9Ruu4Gby1NRaF1vaQvUnPPyxnX/4hwDj7zCbx+IA?=
 =?us-ascii?Q?bEjmklMsUVCOsw1hE8WtHL2KxrUbAbGytcCvpLmou69gIOV6lbGi068smOvv?=
 =?us-ascii?Q?LKgRztAKKbDw6VMeaxOHuFM7B72x8lB5KjQu72B9NHSaxjMcmg+xLGaqCNW4?=
 =?us-ascii?Q?WBZmi2XYGMdu0OhAshNss8FR74xOpjMwE+B+tmr5k/pun/V/OhUnXUc81c8U?=
 =?us-ascii?Q?g8pPZIKmb5YLYNbwNfRRgAIpiKu0K8f/DgnYtC+NSIGSftGpiPqFhCzQdkpK?=
 =?us-ascii?Q?Ctt1/XX2bH9NQwvcN0tRlDZz1aJN7uykADR2OUWQvfFQ+tSNe6VEKYNlczcK?=
 =?us-ascii?Q?H/vS8kVPUR58h9mXhXDcxnDRMQP7/xresev/phsEA2rpdIZYtzaJXx/dgmiA?=
 =?us-ascii?Q?c9Bo29Zdm8yyP8oBL42lWHYaS2R8AaxdSrjeqf7bj0J6RiG6ztEQZT+Mg4IR?=
 =?us-ascii?Q?DJrU/tuOsQwda1pChCgYBGZympbqt2Qgv3+hlhTD09+DtoZ7XgetS5JcMlEn?=
 =?us-ascii?Q?fd1yM/Fa6U5ARqZ/zuK86ZkHqWiLQnZzQ9XBXnkLz3pShe0vW5V15ASpp2e0?=
 =?us-ascii?Q?J33B9A8A2uderKiREMjEXnS8iu5Vt65JJirzK+nbzaDOZ9hikdc2mFRMUP8B?=
 =?us-ascii?Q?jSSyAIoEJKhUIUuL8MnWik47fEkMTpDsCkFRCM1Uee/EaUP3z38O3/uVOKY/?=
 =?us-ascii?Q?WLtwjm4YxrQ+8i1BS91pI0oZ7SimDPsAD/2M02sOGsB6pqRDLJj+n8I9d/jL?=
 =?us-ascii?Q?JSN4HG96NMnY6BXmeB6QwJZrBRaOpnOx2NjssSJJVZ8PYgIM7iFbCjlmglgk?=
 =?us-ascii?Q?7NgaDwe0Z0XQFZtWBIHuT+rIk4StnbeMbhs81bU7ODb24awYIslC/uILrCdX?=
 =?us-ascii?Q?PQS9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 08:27:53.6508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: ff42abab-4a45-48de-2e09-08d89b532886
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YY2jVI5oVfF3i5c9K1yyL4jWty6T+UqldLLgBUtizLfFrpgEHD8kAb/w8vaU8XUP
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

New SMC message was introduced for gpo control on sienna cichlid.

Change-Id: I6f09ae96e9dd7a290c9975564740f597a08ff2fa
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h        |  1 +
 .../gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h    |  4 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 42 ++++++++++++++-----
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index 745b04730428..c79ad184503e 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -209,6 +209,7 @@
        __SMU_DUMMY_MAP(SetSoftMinCclk),                     \
        __SMU_DUMMY_MAP(SetSoftMaxCclk),                     \
 	__SMU_DUMMY_MAP(SetGpoFeaturePMask),             \
+	__SMU_DUMMY_MAP(DisallowGpo),                    \
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h
index 35dd6072cc45..dad2832ff3b1 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h
@@ -134,6 +134,8 @@
 #define PPSMC_MSG_SetGpoFeaturePMask             0x45
 #define PPSMC_MSG_SetSMBUSInterrupt              0x46
 
-#define PPSMC_Message_Count                      0x47
+#define PPSMC_MSG_DisallowGpo                    0x56
+
+#define PPSMC_Message_Count                      0x58
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 822ddfc42360..7e8aa5f7c0c9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -128,6 +128,7 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(Mode1Reset,                     PPSMC_MSG_Mode1Reset,		       0),
 	MSG_MAP(SetMGpuFanBoostLimitRpm,	PPSMC_MSG_SetMGpuFanBoostLimitRpm,     0),
 	MSG_MAP(SetGpoFeaturePMask,		PPSMC_MSG_SetGpoFeaturePMask,          0),
+	MSG_MAP(DisallowGpo,			PPSMC_MSG_DisallowGpo,                 0),
 };
 
 static struct cmn2asic_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = {
@@ -3207,19 +3208,40 @@ static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)
 static int sienna_cichlid_gpo_control(struct smu_context *smu,
 				      bool enablement)
 {
+	uint32_t smu_version;
 	int ret = 0;
 
+
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_GFX_GPO_BIT)) {
-		if (enablement)
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-							SMU_MSG_SetGpoFeaturePMask,
-							GFX_GPO_PACE_MASK | GFX_GPO_DEM_MASK,
-							NULL);
-		else
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-							SMU_MSG_SetGpoFeaturePMask,
-							0,
-							NULL);
+		ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+		if (ret)
+			return ret;
+
+		if (enablement) {
+			if (smu_version < 0x003a2500) {
+				ret = smu_cmn_send_smc_msg_with_param(smu,
+								      SMU_MSG_SetGpoFeaturePMask,
+								      GFX_GPO_PACE_MASK | GFX_GPO_DEM_MASK,
+								      NULL);
+			} else {
+				ret = smu_cmn_send_smc_msg_with_param(smu,
+								      SMU_MSG_DisallowGpo,
+								      0,
+								      NULL);
+			}
+		} else {
+			if (smu_version < 0x003a2500) {
+				ret = smu_cmn_send_smc_msg_with_param(smu,
+								      SMU_MSG_SetGpoFeaturePMask,
+								      0,
+								      NULL);
+			} else {
+				ret = smu_cmn_send_smc_msg_with_param(smu,
+								      SMU_MSG_DisallowGpo,
+								      1,
+								      NULL);
+			}
+		}
 	}
 
 	return ret;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
