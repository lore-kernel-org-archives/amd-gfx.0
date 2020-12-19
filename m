Return-Path: <SRS0=C/bZ=FX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E83C4361B
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Dec 2020 00:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50712343F
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Dec 2020 00:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50712343F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1263689C03;
	Sat, 19 Dec 2020 00:48:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C31989C03
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Dec 2020 00:48:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGDv9DPYXuzLcMHHQ8VaTVAaWdGGZSNAmi77qjG75SPEqI+qw64tED/T+eqbCR3Ua+tdzJc1wxQnKPTlbrUlw6r2OcgQJnCKzF0mb+OrZbzdODFS9w+QiWmYKcD6j9uZz6X6qlFr6T2ZgH/LrpEmavALJGCeV8sLWtREUvYtRihXD3XRrki9nXsLbvKlLmFn+C9nMgstg5LDV3FeRJhtJhRZWgbyGIT3X9zhzUOVxYlnoB55P2CTNDaFbNxBt2DhswZOb6bIlVYbdIqkR2fIAnjyh37ch0bS9osEemSboWF2LFCN1AWTWvWlg7XOD6v8uHlrKyqaY2OdjfW7clC/Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVUMI7YO+r/RRex6Eq0xbpl4XIQjE5AE1MuDwlrw60E=;
 b=AjjLm6Cu9LzeAknnw/9AhwfenFHF0MLjMZegYNCzEJL+p5r3qpgOXNm40vKxY57dwCBdJRejkebxUKZXJKSnh+HCNUrQ9UIjaaEv88XeOv3WlkGyiRMZZCj7k3Y9XH6EhaHWynTiuVtu4ERG8lsHnd8olFvSpNUqM/OSuCNMBzOttFJT3wFpA5JCcC2PoXsHlxQG64Or18Kw3gYPftjhGa/9VDvi4WfVIGm/Wnnt4eYVYaVS5Tp9UMmP1rbDHPwKuG9qzNLc1mvI9To6HaZNE1OTkKuOtOYEIiZrelpusUZsGaipp1P8P62ECTuX58u5qUI67qSmqGsEIbAnhJJudQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVUMI7YO+r/RRex6Eq0xbpl4XIQjE5AE1MuDwlrw60E=;
 b=wvas3rvMcHsyeVRMag5pBY0a4MTZVgUPrvtZLfQOW+hfGvHFKOhh22nFX4glFHdEWMMqsLrSFf4TvaaT/G4r/aZs+eoh0tEKYvd5DP6iFgrhvYwGkrFn21I7lKG8Kc4ftA/lf6mmv2DeQ1+TqXZovJyNrlDwaTXEy+LCgTXXXjg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2959.namprd12.prod.outlook.com (2603:10b6:208:ae::29)
 by MN2PR12MB3279.namprd12.prod.outlook.com (2603:10b6:208:105::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Sat, 19 Dec
 2020 00:48:49 +0000
Received: from MN2PR12MB2959.namprd12.prod.outlook.com
 ([fe80::dd1e:ce4b:cd7e:2804]) by MN2PR12MB2959.namprd12.prod.outlook.com
 ([fe80::dd1e:ce4b:cd7e:2804%7]) with mapi id 15.20.3654.020; Sat, 19 Dec 2020
 00:48:49 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/8] amdgpu/pm: Powerplay API for smu
Date: Fri, 18 Dec 2020 19:48:23 -0500
Message-Id: <20201219004831.13527-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [142.126.168.115]
X-ClientProxiedBy: YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::23) To MN2PR12MB2959.namprd12.prod.outlook.com
 (2603:10b6:208:ae::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.115) by
 YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.28 via Frontend Transport; Sat, 19 Dec 2020 00:48:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aea9ee27-0dae-40ff-c411-08d8a3b7d93e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB327956F3BAAA1222F4711EA5F0C20@MN2PR12MB3279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rtsubE0Tyy/oTXs0BI0z29jtU4sk5CxXKj+DiyU07JKfP8n3Kpy8/bqK91ziDheHwWsnjER5htFMDXXn8W9eWfsUIALLhdeXPd7yrCFX43MdC8KXPRQRzWycVwu4qad7DsRyLtWZS/+yTH2MDEj6UX+awLmY1WKpOAnyu5UQFObXtgd+ySDdZn3xcYBAFLVykATeDXFVdIEPaEmXudQUrhxRC7U/7se5C9k7Hi/DSmYfDyjpOtmPBAlFXZ7Jf4CwHcTj7Ow58POHZwsrN7hK0kulred/NAebDcbTMZF+QedwQciDf+5RKw2b0e3826OuElmMEeGqZe3289bdhphbqg90DUq160BSuSFZ1a7Xd7F+JgrmCkBo/DunL//siRE0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2959.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(956004)(2616005)(44832011)(26005)(66476007)(66946007)(6506007)(6666004)(86362001)(66556008)(5660300002)(69590400008)(36756003)(1076003)(83380400001)(186003)(316002)(16526019)(52116002)(6916009)(2906002)(4326008)(8936002)(6512007)(8676002)(6486002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cregK00c+4IyqC0Bvr1U5D9IRn6JlT0hPWSJ4YKBxpbyl7CVuJrU/l3NqfiU?=
 =?us-ascii?Q?7NLCunTAI4i6INip0NsObfABGuopYdm8Tyx4x0cq43cGUd0E6QeEP0w8HJr3?=
 =?us-ascii?Q?PWfAiY1pFqLxpkcwXzOBnp/uXDF1ZpFqwL/65tufp4NvhEUcsmLUFmhqi1Sj?=
 =?us-ascii?Q?72eFdtxwtpe2+N9PUcES3c8DzEUsgXO8XKpk2d2ACG9GbdRuhfH9kRnkwNhF?=
 =?us-ascii?Q?Qsk5UViB/0SvHz5GWAPG8zrybZ6jYKv/EKYKAmOSJWRhce2puirkhnaPktRe?=
 =?us-ascii?Q?3IWzMx1IpDRZQ+s5K+wnVCws9Q5Oy9i3jx8GjKGHzg4NNtzuk0boNmA73lRh?=
 =?us-ascii?Q?EDUE6ki6tMSSAekYzahvo6AGV6Iw1slQcoD2Xtfobu9Wljtf4v8/C+2S3QIC?=
 =?us-ascii?Q?pi3MC9G2vOvuksvmmkAnD39vL2tSOKLk7vbLYn+SQ1iY5dbyRUSaOeMBC0MH?=
 =?us-ascii?Q?wTAlIazXfid5gSGrcN1g0XqtdO5XUX+xmVrF1gxDJ1tW9yllsnCYXULJN4bZ?=
 =?us-ascii?Q?ZZR7Z3I0cQustKYc6E7TbqsuaWLO14C/ikSsJxBJpJRKmwXJAoB6umUkoVB7?=
 =?us-ascii?Q?YEuFj3iuzUSB8AK9goLDdJ0d37GpYrGuJAGFsC7ZlZ+IBJp/bO8wgiL7X8NM?=
 =?us-ascii?Q?eh4DGgT5RPwLZ/Wi0qQ8hZvdTh0TXzOqLL8nctjrZrweAjcp2hsXgyGueaGA?=
 =?us-ascii?Q?YkfCLk6Y4vnCaH0fPs+Ht49sayWNy0guVfmTNpzd0ZTGiwWkgR/hnmLN+/sn?=
 =?us-ascii?Q?EjcPLx4X6FnCMLSqVW6F8W/8lxiAvTF9uL4q9Uou4Ue0iYW/gLUrB9y6pF42?=
 =?us-ascii?Q?pX0DMWbCXJYwByFN+ra47T0RbEnJLvxhWTTF/+/FRjdXOTZyfIkSFP82IHNh?=
 =?us-ascii?Q?OoWfHVXCi1IuNJtSxMFp0LuLGcjbgTX8CXhwo77XXpwj6RHfevGB2a/SBWrn?=
 =?us-ascii?Q?gl3l2lY6+TQJuwhya0nwuLB2h0hLbNjiS0mIelJrt0NKZ0o+PYa/2XMOMR9E?=
 =?us-ascii?Q?22DN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2959.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2020 00:48:49.0617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: aea9ee27-0dae-40ff-c411-08d8a3b7d93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sz2Ao9LH0DMCwan72i31EutPv8nxrK/D0+Yh9ko0lA/ET7nkTTtTuluqyDpOwQgzMYLlG8LClSTHks6QmWhMzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3279
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

=== Test System ===
* DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
 + ISO(Ubuntu 20.04.1 LTS)
 + Kernel(5.9.0-rc5-custom-pmcallback-00865-gd3b9ec1a13c9)

=== Patch Summary ===
   linux: (git://people.freedesktop.org/~agd5f/linux) origin/amd-staging-drm-next @ d3b9ec1a13c9 
    + 05e1d87d1cb4 amdgpu/pm: Powerplay API for smu , added get_performance_level
    + b9e2be067f01 amdgpu/pm: Powerplay API for smu , changed 6 dpm reset functions to use API
    + 9add1d6485a4 amdgpu/pm: Powerplay API for smu , changed 6 pm hwmon fan functions to use API
    + c02b35074f14 amdgpu/pm: Powerplay API for smu , changed 9 pm power functions to use API
    + 483bd1207f2c amdgpu/pm: Powerplay API for smu , changed 5 dpm powergating & sensor functions to use API
    + f91c1665e30e amdgpu/pm: Powerplay API for smu , changes to clock and profile mode functions
    + d1400afa4785 amdgpu/pm: Powerplay API for smu , changed 4 dpm functions to use API
    + 2f12f7afa690 amdgpu/pm: Powerplay API for smu , updates to some pm functions

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

 drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 226 +++-----
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 596 +++++-----------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  79 ++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 334 +++++++++---
 4 files changed, 511 insertions(+), 724 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
