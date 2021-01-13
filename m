Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58208C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE74D22EBE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE74D22EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D26F89B4D;
	Wed, 13 Jan 2021 03:28:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2015E89B22
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 03:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlfMr5Uose4O+2TYDiGkXPVbPOn6HjYM6RAjqNlPwuZNCt9WtxQCq2rUyM0XOPWZrhLgmgJFms4d6DBoab8FCOOpVsf0qaZxQBs6Wxa1udbeIfOqk5l7oH8A0kTWCNVBY48w/rS5VUfj9emykNdC4lnwL0uce777jGBxRhatQLyhKCtb917KLZDZNl5yskszd0AkIESFXS68/q8hZTi9Hp3nEaKiASJOXf0dhzKO4jvrqD9YSYS7e+Lq7H+0IROnrQ/ZDz4wRycJNLFKAFT6gtE+gTg8Gc4rO3xoMwXo7sGTcSzoAdq5C0PGC6fifUvhjyD60hR9SrCKfV/lvTUJDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qa0pt5EK3ZjBjOiSn1YhfSMXs0IIKsDmjrzQoUNXIXg=;
 b=k3oNVcviqstrNM8mDU8PWhM4gys+4xroRkvmdijV0DGh3FBpftXTrocwYN9+M5oD7R9+ljWbRrF3sRNnVHEHFYL9lBcvMtIwiFYksyANMp28OqAQJFU8mrGBMVOBgusz4PX9FYFxjvys3HEcG0Qw4ljPMUOVlucqt8LYTgAvXxFZKupx7U3GITFtwW29qhziQLabqYEO51abiQkcUefvBmsxbYR1+0huiT1v0/233nHGRGMotybXaAJsA5F0FR1LBqm+buNE8v3SVKSLdIArPR1OOIFNg1RqMEs1d3KM7imyNXbsadWE7wErTh/K6KjiG3xSM8l74SJpfiC2/Fyn4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qa0pt5EK3ZjBjOiSn1YhfSMXs0IIKsDmjrzQoUNXIXg=;
 b=laYTEv1sT8Fga8RZ7IsNR4O/KZCt/fDIwkP4VQ762juNxjt3dHcNNUps7lkcecUvPemSDXj9aoeoV37df0iqG4v24gPw3WB3v/PWrcRgKOD4YeMAWLDDxGrdiKA/PO8vCm20zRawRA8Q1AkqZM1m7Z0qtlC9Efq4tNZa/12lEkE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB3817.namprd12.prod.outlook.com (2603:10b6:5:1c9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 03:28:03 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1%3]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 03:28:03 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/8] amdgpu/pm: Powerplay API for smu
Date: Tue, 12 Jan 2021 22:27:18 -0500
Message-Id: <20210113032726.2475-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [142.126.168.115]
X-ClientProxiedBy: YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::34) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.115) by
 YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Wed, 13 Jan 2021 03:28:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82efc2ea-7cb0-43a2-57a4-08d8b7733c1c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3817:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3817933D53BD75A86DA3F3F6F0A90@DM6PR12MB3817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m74kRnutTujMN3mBDrI4KnCdFLm1alZCWypAHTYSZ1KdoTO43vGjNl7xJaXxuYrQXcKchIJ5VgTpFWFSBF3PazYsKspSlUh3rsdJA+PIEQ7GKP14LOPg+sRQav6ZgY/igDk9FGOuLuvezTPBRiY1fe+Sv550sk6U1AJx6/J0zphHEmM+KnBe2Y0NSzEj4q315BIQ21siR5zffWq0zb2gZheE3VaVXMy2fT6ZXrZaHjQ0HHRlK2stuvA9bJAc4VWLIW+X75C5duYap8Jnzd25LG4S4mCEZPMxhdQXq7VTDyRTW4mRl6hFAhKs4luAh0AJPBXvC50Pf9lziBs1jbNi6XgXICBc5LzK1xedRN2Q6PR9rN0nG4AA8crK5Xt6lZmjdFvbC3jJEPEY8d9k3181P07pBEyOEc5rTipUO2dXUWEpXfzTG+/RtsnD0lUhLxc76Y2KW/peRwi6bqzHlockPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(5660300002)(69590400011)(66556008)(4326008)(6506007)(8936002)(36756003)(8676002)(6512007)(6486002)(6916009)(66476007)(186003)(44832011)(66946007)(86362001)(1076003)(26005)(956004)(52116002)(478600001)(16526019)(316002)(2616005)(6666004)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?J5Lg1T8L1aSNl16nivycZrQiCq0wCp61/YFlOs8J9zKquMw6IDMyGZUsJtHc?=
 =?us-ascii?Q?CsM0fqAOM5Q9W2k7AVsnUgTGFeboY3qZy/ffmRvyjNhMqjyHmoojAb7Hj0Yv?=
 =?us-ascii?Q?wHgTx4RZnVwaeqgZg0NdgToH/L+QM4dHl6kzl96COs0WcoKYnSX2nVLl7s0t?=
 =?us-ascii?Q?TwgbB/H+yyuGIXL4ZE4u7e1JNKdVtJxZl6CZkOax9qttu3cinU2xlBoY/LxJ?=
 =?us-ascii?Q?79/BbTZGa9ihLMjwX2sZ3nUJehghOS37DfV3usnFTbtyLUrX5p5tYGDy+XbI?=
 =?us-ascii?Q?AV6Am8JFxISpMKIR2r/3PB26n9ozELvRAu2bJTQLfbLJ/ZoITB4KxLFKLVQN?=
 =?us-ascii?Q?2ObiNnruyUhU5uYNH5nwmT73lC73VX8YeqJOUys0qtm8lFU3T8WEAK7Hi+fB?=
 =?us-ascii?Q?3Q/BsTIvaObp524I/1+mb4KaaCGyR1Gg1OBSj6+mFv/gOlXshG262u57JZqS?=
 =?us-ascii?Q?iXIFHOMFS5oWEjv8CDB/FyjDqPIFTClL5doyLhkhKRf2cXj4HTM6LAZkjeRi?=
 =?us-ascii?Q?v+k7GgmXULN+fpIyyIfP87hkzY+V03Uy1FE3j/5bcwTbOMSYlSTl7atuanGN?=
 =?us-ascii?Q?4Sk1VjB7hLxW+pLk9eCAdiKDEFJmcIwcJhrXjnnWX2RKYRbRzeQoutcaiB6y?=
 =?us-ascii?Q?2p17Z3CHcEdY2DX3NOAagSA985uzWjGW5CKhTkjIQ5RA8QSIcD+fdqbGuKnM?=
 =?us-ascii?Q?Lvp81mx22qPBwphLWKk//PntEmfRjoQlt4sT5tGboNDwhsJ2PuQ+03eiI5Fj?=
 =?us-ascii?Q?F64aamztPdky7oUuJd6uHhRHJdNTxrMA7lXmalVPTsL/v9d88wV6yIJ8g1Ud?=
 =?us-ascii?Q?aG73h2Es0n3T1ST9LFSQ4G50T2Nup1A6sQLrFyUm4CPQTM/qBDrgv2KEY2qG?=
 =?us-ascii?Q?ag/wXupq3rfsz4taWAKC+i3Qpk7kXDENx85I/S7y131YBjCNHYRekOTrkSwI?=
 =?us-ascii?Q?upUUdlaUd8BQ+sb1SdXXw+FLxHd4DVpbVBxNY8z/o7T3jd0LYdb5BOb8DMeb?=
 =?us-ascii?Q?zSTf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 03:28:02.9708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 82efc2ea-7cb0-43a2-57a4-08d8b7733c1c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYm9Ko62HEp6ZtcATfrtiPFxnDz2gaMlQIYWO+QmnUxh/7b0nsuiE3QJ0vKFGnEHZqJ2An5Ms13re5pRVY0ddA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3817
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

=== Description ===
Patches to add the Powerplay API to smu and simplify dpm/pm calling code

* Version 2 Updates 
 0001: updated the structure name to swsmu_pm_funcs
 0002: No Changes
 0003: changed error return value of smu_get_fan_control_mode to AMD_FAN_CTRL_NONE
       fixed type in amdgpu_hwmon_get_pwm1_enable() print statement
       fixed indent flagged by checkpatch.pl
 0004: remove check for error during swsmu amdgpu_dpm_get_pp_num_states() call to match previous powerplay behaviour
 0005: add comment to highlight assignment that changes uint32_t value to int
       fix errors flagged by checkpatch.pl
 0006: fix errors flagged by checkpatch
 0007: fix errors and warnings flagged by checkpatch
 0008: No Changes

=== Test System ===
* DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
 + ISO(Ubuntu 20.04.1 LTS)
 + Kernel(5.9.0-rc5-custom-pmcallback-00865-gd3b9ec1a13c9)

=== Patch Summary ===
   linux: (git://people.freedesktop.org/~agd5f/linux) origin/amd-staging-drm-next @ d3b9ec1a13c9 
    + b401b8ff07ca amdgpu/pm: Powerplay API for smu , added get_performance_level
    + 924fb45c2fc9 amdgpu/pm: Powerplay API for smu , changed 6 dpm reset functions to use API
    + 22459821a119 amdgpu/pm: Powerplay API for smu , changed 6 pm hwmon fan functions to use API
    + 9a1dff6ed4a4 amdgpu/pm: Powerplay API for smu , changed 9 pm power functions to use API
    + eeaf9dad054a amdgpu/pm: Powerplay API for smu , changed 5 dpm powergating & sensor functions to use API
    + c10bf38a4250 amdgpu/pm: Powerplay API for smu , changes to clock and profile mode functions
    + 73c150926ef3 amdgpu/pm: Powerplay API for smu , changed 4 dpm functions to use API
    + f840fb27c965 amdgpu/pm: Powerplay API for smu , updates to some pm functions

=== Tests ===
** 0001
 amdgpu_get_power_dpm_force_performance_level()    <- /sys/class/drm/card0/device/power_dpm_force_performance_level
** 0002
 amdgpu_dpm_set_mp1_state              <- systemctl suspend
 amdgpu_dpm_mode2_reset                <- untested: needs Arctic Islands Hardware (VEGAx, RAVEN)
 amdgpu_dpm_switch_power_profile       <- untested
 amdgpu_dpm_set_xgmi_pstate            <- untested: amdgpu_xgmi_set_pstate():411 pstate switching disabled
 amdgpu_dpm_set_df_cstate              <- untested: needs ras enabled hardware
 amdgpu_dpm_enable_mgpu_fan_boost      <- untested: needs multi-gpu hardware
** 0003
 amdgpu_hwmon_get_pwm1_enable                    <- /sys/class/drm/card0/device/hwmon/hwmon?/pwm1_enable
 amdgpu_hwmon_set_pwm1_enable                    <- /sys/class/drm/card0/device/hwmon/hwmon?/pwm1_enable
 amdgpu_hwmon_set_pwm1                           <- /sys/class/drm/card0/device/hwmon/hwmon?/pwm1
 amdgpu_hwmon_get_pwm1                           <- /sys/class/drm/card0/device/hwmon/hwmon?/pwm1
 amdgpu_hwmon_get_fan1_input                     <- /sys/class/drm/card0/device/hwmon/hwmon?/fan1_input
 amdgpu_hwmon_get_fan1_target                    <- /sys/class/drm/card0/device/hwmon/hwmon?/fan1_target
 amdgpu_hwmon_set_fan1_target                    <- /sys/class/drm/card0/device/hwmon/hwmon?/fan1_target
 amdgpu_hwmon_get_fan1_enable                    <- /sys/class/drm/card0/device/hwmon/hwmon?/fan1_enable
 amdgpu_hwmon_set_fan1_enable                    <- /sys/class/drm/card0/device/hwmon/hwmon?/fan1_enable
** 0004
 amdgpu_get_power_dpm_state                      <- /sys/class/drm/card0/device/power_dpm_state
 amdgpu_set_power_dpm_force_performance_level    <- /sys/class/drm/card0/device/power_dpm_force_performance_level
 amdgpu_get_pp_num_states                        <- /sys/class/drm/card0/device/pp_num_states
 amdgpu_get_pp_cur_state                         <- /sys/class/drm/card0/device/pp_cur_state
 amdgpu_get_pp_table                             <- /sys/class/drm/card0/device/pp_table
 amdgpu_get_pp_features                          <- /sys/class/drm/card0/device/pp_features
 amdgpu_hwmon_show_power_cap_max                 <- /sys/class/drm/card0/device/hwmon/hwmon?/power1_cap_max
 amdgpu_hwmon_show_power_cap                     <- /sys/class/drm/card0/device/hwmon/hwmon?/power1_cap
 amdgpu_hwmon_set_power_cap                      <- /sys/class/drm/card0/device/hwmon/hwmon?/power1_cap
** 0005
 amdgpu_dpm_baco_enter                  <- untested: called from runtime.pm 
 amdgpu_dpm_baco_exit                   <- untested: called from runtime.pm 
 amdgpu_dpm_is_baco_supported           <- untested: needs other Hardware(cik, vi, soc15)
 amdgpu_dpm_baco_reset                  <- untested: needs other Hardware(cik, vi, soc15)
** 0006
 amdgpu_get_pp_dpm_sclk              <- /sys/class/drm/card0/device/pp_dpm_sclk
 amdgpu_set_pp_dpm_sclk              <- /sys/class/drm/card0/device/pp_dpm_sclk
 amdgpu_get_pp_dpm_mclk              <- /sys/class/drm/card0/device/pp_dpm_mclk
 amdgpu_set_pp_dpm_mclk              <- /sys/class/drm/card0/device/pp_dpm_mclk
 amdgpu_get_pp_dpm_socclk            <- /sys/class/drm/card0/device/pp_dpm_socclk
 amdgpu_set_pp_dpm_socclk            <- /sys/class/drm/card0/device/pp_dpm_socclk
 amdgpu_get_pp_dpm_fclk              <- /sys/class/drm/card0/device/pp_dpm_fclk
 amdgpu_set_pp_dpm_fclk              <- /sys/class/drm/card0/device/pp_dpm_fclk
 amdgpu_get_pp_dpm_dcefclk           <- /sys/class/drm/card0/device/pp_dpm_dcefclk
 amdgpu_set_pp_dpm_dcefclk           <- /sys/class/drm/card0/device/pp_dpm_dcefclk
 amdgpu_get_pp_dpm_pcie              <- /sys/class/drm/card0/device/pp_dpm_pcie
 amdgpu_set_pp_dpm_pcie              <- /sys/class/drm/card0/device/pp_dpm_pcie
 amdgpu_get_pp_power_profile_mode    <- /sys/class/drm/card0/device/pp_power_profile_mode
 amdgpu_set_pp_power_profile_mode    <- /sys/class/drm/card0/device/pp_power_profile_mode
 amdgpu_get_gpu_metrics              <- /sys/class/drm/card0/device/gpu_metrics
** 0007
 amdgpu_pm_compute_clocks            <- untested
 amdgpu_dpm_set_powergating_by_smu   <- untested
 amdgpu_dpm_get_mclk                 <- untested
 amdgpu_dpm_get_sclk                 <- untested
** 0008
 amdgpu_get_pp_od_clk_voltage                 <- /sys/class/drm/card0/device/pp_od_clk_voltage
 amdgpu_set_pp_od_clk_voltage                 <- /sys/class/drm/card0/device/pp_od_clk_voltage
 amdgpu_set_pp_table                          <- /sys/class/drm/card0/device/pp_table
 amdgpu_set_power_dpm_force_performance_level <- /sys/class/drm/card0/device/power_dpm_force_performance_level

=== Summary of Untested Functions ===
** 0002
 amdgpu_dpm_mode2_reset                <- untested: needs Arctic Islands Hardware (VEGAx, RAVEN)
 amdgpu_dpm_switch_power_profile       <- untested: called during initialization
 amdgpu_dpm_set_xgmi_pstate            <- untested: amdgpu_xgmi_set_pstate():411 pstate switching disabled
 amdgpu_dpm_set_df_cstate              <- untested: needs ras enabled hardware
 amdgpu_dpm_enable_mgpu_fan_boost      <- untested: needs multi-gpu hardware
** 0005
 amdgpu_dpm_baco_enter                  <- untested: called from runtime.pm 
 amdgpu_dpm_baco_exit                   <- untested: called from runtime.pm 
 amdgpu_dpm_is_baco_supported           <- untested: needs other Hardware(cik, vi, soc15)
 amdgpu_dpm_baco_reset                  <- untested: needs other Hardware(cik, vi, soc15)
** 0007
 amdgpu_pm_compute_clocks            <- untested
 amdgpu_dpm_set_powergating_by_smu   <- untested
 amdgpu_dpm_get_mclk                 <- untested
 amdgpu_dpm_get_sclk                 <- untested
** 0008
 amdgpu_get_pp_od_clk_voltage                 <- file not found
 amdgpu_set_pp_od_clk_voltage                 <- file not found
 amdgpu_set_pp_table                          <- no binary data to test with


=== Cover Letter ===
Darren Powell (8):
  amdgpu/pm: Powerplay API for smu , added get_performance_level
  amdgpu/pm: Powerplay API for smu , changed 6 dpm reset functions to
    use API
  amdgpu/pm: Powerplay API for smu , changed 6 pm hwmon fan functions to
    use API
  amdgpu/pm: Powerplay API for smu , changed 9 pm power functions to use
    API
  amdgpu/pm: Powerplay API for smu , changed 5 dpm powergating & sensor
    functions to use API
  amdgpu/pm: Powerplay API for smu , changes to clock and profile mode
    functions
  amdgpu/pm: Powerplay API for smu , changed 4 dpm functions to use API
  amdgpu/pm: Powerplay API for smu , updates to some pm functions

 drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 228 +++------
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 597 +++++-----------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  79 ++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 358 ++++++++++---
 4 files changed, 534 insertions(+), 728 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
