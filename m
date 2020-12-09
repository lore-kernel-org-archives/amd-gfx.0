Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8682DC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 12:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17888238A0
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 12:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17888238A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A3FA6EA38;
	Wed,  9 Dec 2020 12:50:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE0FC6EA35
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 12:50:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFqm1KWC6C6qQhx4dXunNbhaOdspHPjhmYlXjwGSMm7oMAqXADQKjOCms5cdtNRspDoE9//R8g2c5LGQAtr96cNziUy7SMMcEcsf8HAr5HzpgBJ0Te9B9caffHFYWoilJiO2ysruyuZWvx8xsLyAbEon/Z/PBt8LW4P9DWLgSowV6voqhpm6Y1UT73kToChygzmyhysZ3JStfTr0ErTc/FVgx6d8FfPHrM2CymCm73zWzv/5GzsJw59wLoQDvN8sHBh8cKcZXeY7aoD0PJlpUqrd0IbczmNzloGzo36nkzBfgGKjSTz9PCq8PPpPvLd46Q19MY4hI3aUqNzTyayWyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QWFFYZkOMOS6N6uwLIGOMhQRlfe+lHpem6ITbC25tM=;
 b=GySBer5FhsFDcLzE+1/seNTGt2SYzcnvOZtSFNOkC8cz9In6uFDUs5iDbxzhJq/cLLSNe/6DBj8kExoAI/PJkoUYI/Y4e4Tsi/5NB16k3leP9IdeUvFNonHhsTroNp4XNmSfdwebrjjP2MIBPlBr/fHw4x8E+5ZkZvUyol6wqkLc04OOggd6vFseCD+iQJYB5csDGSStc5TbcY1+DhBO6m9nyb3bGoiNc/M4LT2oUoB/VbnMx8q9xDZ/V69/ZReNdRdOy4Jh2Lr2khWVQOE+zpLbR2Uo52EjV0DtrOg3fifGTTyAl0RSh7An/uVUb3JW7ma6GfLzWWwHv12A3tI1CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QWFFYZkOMOS6N6uwLIGOMhQRlfe+lHpem6ITbC25tM=;
 b=Sl8/ZOyVTAnLd+FsIbn2P79lwhqtfadsxEG3RPU0yHr9pH+WpJIEAqwliqWWb0LTIVAW2B8RYhrJYUqRT5d9kFfQ5WMUcPUynAKF7JpdQ1Jd7n6NqsTgdpWCiZlTljY05C8DxO5bc5rqcm3F9KcKdeU6hHlWyOeh8aXp1Xw/Hxg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Wed, 9 Dec
 2020 12:50:09 +0000
Received: from MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::40bf:bffc:e8b3:2067]) by MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::40bf:bffc:e8b3:2067%7]) with mapi id 15.20.3632.026; Wed, 9 Dec 2020
 12:50:09 +0000
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/2] drm/amd/pm: update the smu v11.5 smc header for vangogh
Date: Wed,  9 Dec 2020 20:49:37 +0800
Message-Id: <20201209124938.11680-1-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0022.apcprd03.prod.outlook.com
 (2603:1096:203:c9::9) To MN2PR12MB3807.namprd12.prod.outlook.com
 (2603:10b6:208:16c::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from code-machine.amd.com (180.167.199.189) by
 HKAPR03CA0022.apcprd03.prod.outlook.com (2603:1096:203:c9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.7 via Frontend Transport; Wed, 9 Dec 2020 12:50:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c865df19-d851-4d48-5ce2-08d89c40f618
X-MS-TrafficTypeDiagnostic: MN2PR12MB4471:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4471A4FBD4CDA245AD83BFB89FCC0@MN2PR12MB4471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EL3drWv2rpG7edTvQ0TJ8TE1XAU3r2PuOFet6qomPpwDiM6yuUWDDHvgZSj2C+MIDP25azodRiGLTuXo9DMYoVuKWP5mEj+Ul7LZ2xAFC/cNSpsbGb7rvyrmRQp0Jo6xbW7j+Uy8TdaBDQKosSOe6VkJXb+NEd5v4BY81z4vRcl05Zl5R5AFo4pC59TY2FxC9b5AMIJyh33B48AnSWAabcf8qzMy5PdGauigW/nLuIXQtQT6mLwvp39pjY6Bdp2KazzNMa4Si64gYOJ+cWloe/6ZE6YZYgUSY4HCZfZnQ84OAj+Ijq28pGC8APfPl9t+/ZQDzl+h7mcu/RbQAthTjMTSIkC0Nt2m3/8dD92dUzrd1nqUADjMAAt+j07zfOjK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3807.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(346002)(8676002)(6666004)(7696005)(16526019)(1076003)(2906002)(36756003)(186003)(4326008)(52116002)(26005)(8936002)(34490700003)(5660300002)(956004)(86362001)(6486002)(2616005)(6916009)(66556008)(66946007)(66476007)(15650500001)(83380400001)(508600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tY4dB9hAKwQdPBCpFWsZkOlQr+5Yczj9+To9KGmki9Z3D5UmrkGHtmCGUhhW?=
 =?us-ascii?Q?hiF06TeMaVuLoAlet/S88EzYLxWojYrBBZsql/zAzzGqOgr9Iio+gtQYu0Vg?=
 =?us-ascii?Q?nu97/rwxe+IOlVOOKJvQYMd60dN6dxsSrkdv+qXGJTunVsqrTk3+LLG4h95E?=
 =?us-ascii?Q?fZ0TAWhM4qYO4BZGEYRpsO+78wo+A+iulj9Hv2YzEHaraZX4plFwnXVZ3Jyz?=
 =?us-ascii?Q?3McrJe5uP/koK5sgg+NJ8k+Cy3ZCHYb6HRbhooaWwyPyEFSMLzIi4Jae8ShV?=
 =?us-ascii?Q?NSZkmD5mgAfvfVdV/0fXevhoWPVsWlTnOZGRBuzXSwPBDKlRCMuYP8K4qr5V?=
 =?us-ascii?Q?AzonS5kxg1rx8adgh1i4PTrltxmQAMlfV06KYOt1lxy3VMBNvyc+1UN8FL3S?=
 =?us-ascii?Q?arzGqoKeGF2vWqrgqSXafpC8sWffLpUl57nH9SwerlpQaGLze4Mz5l/orG4F?=
 =?us-ascii?Q?1o2USJqFppa4A4kYpym82LTjn4Yb/KKHIrwOm59ehY2/kTSxaEWXx31pGmuJ?=
 =?us-ascii?Q?RLNd5V/oWtWf6qnkfO8hGleY6gekxXXvt7xn6/y1yc7ZACpLHUExBjZdZi+M?=
 =?us-ascii?Q?5E2JgVPWua+l2c5/h1U8VWeud+UixsV9J0krRGhYBYeCrTzQeo9K29qiMsuX?=
 =?us-ascii?Q?j0qL9EhsivgLTivaKmhDhUdYPZbvkf7djsQX/uXQssMxB6XzUttgH5WRjP2l?=
 =?us-ascii?Q?Gd2H+Du4iiH/OtU5pKMOXflJOlGBT9bY04vIdsDaUjYq20/h+aFBkXUVJY0r?=
 =?us-ascii?Q?DHdyRZrWMaLm9CVws7HuU/Mto9LuUXkWnQ1ZO/maAjnPNQJsFuttuNM9eGYQ?=
 =?us-ascii?Q?iykFInExZwyiJC5u/uAv5HnqXnk57jh95+lPK2HWS2oa03vm/5Z3KDX+DCoD?=
 =?us-ascii?Q?Tk8/T9H4BSlCqc7GbaOH2pGZOwXp7jCcDSudjOKhZ+Nk64X+P4Bye4Pn3Sta?=
 =?us-ascii?Q?w++q8y4A3X4f8a738xclBZNuJTTmS8UTT2pHa0FDQjo/df7K8VxeIQ/3x/xn?=
 =?us-ascii?Q?JjMh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3807.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 12:50:09.2457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: c865df19-d851-4d48-5ce2-08d89c40f618
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mT+sEtNsGrTNGfd+NQEUg5vHjySjONH/eKm39JSwfsrxlM3fxrqn352g+EO1RP8reQ4cPdqIKj8qmu2yvfLOuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
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
Cc: Lijo.Lazar@amd.com, Ray.Huang@amd.com, Xiaomeng Hou <Xiaomeng.Hou@amd.com>,
 Kevin1.Wang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add new PMFW message to notify RLC engine status.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Change-Id: I7d714f8f245835cacb25e7cc4b248ddf183aebc1
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h       | 2 +-
 drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index 4a6d1381df16..41a49c1c0302 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -178,7 +178,7 @@
 	__SMU_DUMMY_MAP(SET_DRIVER_DUMMY_TABLE_DRAM_ADDR_LOW), \
 	__SMU_DUMMY_MAP(GET_UMC_FW_WA), \
 	__SMU_DUMMY_MAP(Mode1Reset), \
-	__SMU_DUMMY_MAP(Spare),                          \
+	__SMU_DUMMY_MAP(RlcPowerNotify),                 \
 	__SMU_DUMMY_MAP(SetHardMinIspiclkByFreq),        \
 	__SMU_DUMMY_MAP(SetHardMinIspxclkByFreq),        \
 	__SMU_DUMMY_MAP(SetSoftMinSocclkByFreq),         \
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
index 7e69b3bd311b..55d7892e4e0e 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
@@ -41,7 +41,7 @@
 #define PPSMC_MSG_PowerUpIspByTile                     0x7
 #define PPSMC_MSG_PowerDownVcn                         0x8 // VCN is power gated by default
 #define PPSMC_MSG_PowerUpVcn                           0x9
-#define PPSMC_MSG_spare                                0xA
+#define PPSMC_MSG_RlcPowerNotify                       0xA
 #define PPSMC_MSG_SetHardMinVcn                        0xB // For wireless display
 #define PPSMC_MSG_SetSoftMinGfxclk                     0xC //Sets SoftMin for GFXCLK. Arg is in MHz
 #define PPSMC_MSG_ActiveProcessNotify                  0xD
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
