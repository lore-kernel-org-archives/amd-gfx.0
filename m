Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D71DC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 04:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA90564DF3
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 04:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA90564DF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 177B189D58;
	Tue, 23 Feb 2021 04:21:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 873E789D58
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 04:21:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKjm4oLqyFej8rK7zYVfvKCJYYUxg9kvw5d8yjeNzIhoHVheC58NZMVGVL0zBTjaEccyMOrQZNeoQTfVW1J/zkQJWHAzPjfUdaeBLfhPpDdr5DwdxHQirRJDTdz3JKlomlSYmYByQQkaG8bfiBwHzx/cgWxIOcCAvWz2fp7GgeawvqGvrWjmGoNsezMVF3QZ03EoX10SYqSpBNCSqaOMqRoRg1rAQkRQllEG9/2eYjTj/8Jxl41fuYQ01wH1LzzkkUF8vNoKty5G1QG+cxxGEHsMsGjAEqit+f0D9LdWCHxiBgBfvjceoSywtHihTJ0ScX/pRLFecPFBEid33I1b/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSWeNZVmwjnbIKuPy0+1qr+uTfjkO+2H20bx88cLb4Q=;
 b=BNk5XHgVGgyfxhY46vP7TwWdPKpQDOj/ojWgvH9f2JWk0Zo0eKTP7PEP7Z6CwlAAHa5sCW2nWobbdl6Sew2JPgPwz3e4CNLuUkrrIwS6QVdQ7ImOFMNSUvts5zcPlzf/USPJSSkkxKAAPxwiOOxSmQj2mi3LQEp270h8mk1eyuUT+oVB4Ul1rKPp1FE1jYAkH2+r3s+U/2QTHsPcJX5G9jImokM6CIeMD/8/A1aO6sZcFK1fxrVTep6h2NT9kaTT/Ws8GhWyhdo/idkEkvNaxgHtFVnwQc6diEm7XOjxbkUgbzrDgCeAX/ehst8HgXaLu6yUJmumchD9Qal8HqigLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSWeNZVmwjnbIKuPy0+1qr+uTfjkO+2H20bx88cLb4Q=;
 b=AYG5xfOBfA7d6SQ+qyrqqDMel0y3pu6tlHhRf6GNcfraqJyD7ynFQHZ18yHHoOiWP/HBNuyK9sN8uLGSQUpjgkLZKl2zakDjYhD4M9kVuHUjGKj52YPMr2IXIWDb1JYJCxzKS99jsb4pHyjDf7RfG/K1BX7XHrkDaiXoOtQV+e0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Tue, 23 Feb
 2021 04:21:17 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1%3]) with mapi id 15.20.3846.039; Tue, 23 Feb 2021
 04:21:17 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/8] amdgpu/pm: Powerplay API for smu
Date: Mon, 22 Feb 2021 23:20:24 -0500
Message-Id: <20210223042032.3078-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [142.126.154.129]
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.154.129) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.30 via Frontend Transport; Tue, 23 Feb 2021 04:21:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 137e8299-8336-4946-936a-08d8d7b276e1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB45153CD59B6B6F5037EDB3E1F0809@DM6PR12MB4515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ut7788fzm5dYEzA7mKYk004VGoRFv19+w+tN6rN5RQ91zArWCaGUOvNQ1Gp5i3mUNfNHyqz5C3tSLAawbBC8WCZMA1jqS8zwyT3OCWecM5dTM89/KCl4pgMrQtRCI7or6HqWIFZOPdcr1AmxpDKwyCO6h9gGhv0loocTWYgS/bwkJqGMV0OAorkKEwiQn3C6fFPzQS7pRzN0fiCW8U3VavL4Zz8kxWjM5AzyMD9x+YxmCRPT6B+FZnl/OinMo+JClCY2tYE8FaEpm+lbib8siLAx5vTS7myz84aGknM+y+VgaUdUBWx5LDNDQ3RiMV1+Eq/rO2wM9sPt50a/0k347I69sgQXxvdXbtUSZ210Dy6+QW5V8fjzUBELQjZYLDoueMLZwZThGZPhS8v3aY69KzvKFEJx5mAZv0OVoM18sNXq5AaEDfHzT7bB2UJbKevsx9yvYgGCb/iOhqVBHhlg0tiTp/rPE8n/HFqV/FdjmfxeX5ywnf3vLqmxi2gAoFVc1kymzKpZ6Q9pMixytKT+5qlVs87HZ3O3mT4+UyierKnlY4wFGF9a/YHrT5JoOvpiAH+G8CdEJCrLqsHWAQ2clA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(83380400001)(26005)(86362001)(52116002)(5660300002)(66476007)(6486002)(66946007)(66556008)(69590400012)(478600001)(36756003)(1076003)(16526019)(186003)(6512007)(2906002)(6506007)(6666004)(8936002)(4326008)(316002)(8676002)(44832011)(956004)(6916009)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zdC58occIWbYRC4xBwMqFk1PfxGw0lkmpK7aFqnagC1umggT1h6kWpEaH5PE?=
 =?us-ascii?Q?82oBNMI5GYIhEkk23ISDJ1vmpOqCaw5lMZvDvBmA4v8ADW4hFt1pTqBIx0fl?=
 =?us-ascii?Q?jAc7L3WR78cC1I7eGI6LEGvZQQdk4ldlcshfs/2H4ytTpSnWVoC93sfQ+tLS?=
 =?us-ascii?Q?4RxKkBN2v7ZMlV3vNHPfXODITYRezFhMALcBqUc57NAYA8bpLoPllKfSclXX?=
 =?us-ascii?Q?fpw1zjQk3xN8x8Iehz8G77sQRMX74Ezl1vjbZFtrrQhG5YEqJOuj5wuQ+QK/?=
 =?us-ascii?Q?uKKx1W2I815w63+b0bwaTl7s3fS+YKo66Fp9mrbh5dFPAXdlwzCv/d2NR1Ca?=
 =?us-ascii?Q?QaVQbBQtXNWwxn7/TLSIKj1Aj6ehBw9aEIFVQ6/j5GCAk82i1CMxbbyelWSm?=
 =?us-ascii?Q?ncuRjVZaYwfsA/nb0NNeiu1HBgEzNtZsD+sCgZNvW0f8W2bxlFl35CXcDahr?=
 =?us-ascii?Q?LTpq8EEJ95rcOpYy6awU78zdIC4C37B5vUBp1obUr4CK4vDUsZWiu47jx6m+?=
 =?us-ascii?Q?DmLnM6MXyDsqRg8KaspuYKoeu6EUD6vaOysVFKpQ8PYKhPCrElfisVIt4cHt?=
 =?us-ascii?Q?VseZJme4TKzAzxcnDMaE1DasvP/JotgSLbcn9yMXgBnb7ZTYFVvwEatehFS9?=
 =?us-ascii?Q?pjql9SuBg/mAEp4BjxHxMGeBgIm4r4m/TrfJhK+WBnogwhdoJMmvoGEk61SM?=
 =?us-ascii?Q?PyahY/ufoUFHRD53RXiT4uYMu9ANXZy20+qfA52xHTQK7N1KesJWmJK4T6gl?=
 =?us-ascii?Q?EdHk6YYqw4c1yITu5vGiMxhCDnptt+Hhcc/W9f6Pj5bHMQR5bLR7ItHK/Zjq?=
 =?us-ascii?Q?3Jzloay/SIxjVN5+tBV+CNFNgOaThaf0NtScfjOaRK/ma4PLbRiqDCDFEvAt?=
 =?us-ascii?Q?mKwfYkIXVx0t4VJBDis/hrZY5j6akacxzW6/rtWGcvvzrt2yKnVBRBtHyLk6?=
 =?us-ascii?Q?oNz1Mje0iRS5CpwZP0w2wGhhnqkoCkRKvZGVP657gJyftRSRaP+XSEwF6scG?=
 =?us-ascii?Q?AuRvlTxvFcdXlPklan20Z6TulQZ8+W81zKFcJ1hYasV/hQQGDaiwDyc7X0J5?=
 =?us-ascii?Q?dbwhEnld++OJFch+A3FeXkd9M1ve5Pou5MAVNRuoFBtwLFpeGFATKnC7b2fI?=
 =?us-ascii?Q?w6oaBJDj0J4UkvtGD7+1JzNtuAUmyOmwgAHnWmyTmYqSD8LWY07Ihybbbtxl?=
 =?us-ascii?Q?EnrKtmqkKKcJ3fN7Mz9DyRG2kobW168Sr88wgyXWXABawmpc5lhYHTf78qiF?=
 =?us-ascii?Q?tMMbfVLeOiLbDhfQCUjuR12BgbIdMDFODKX4Yay4lcLDfdmjGqkMyQTxIaVW?=
 =?us-ascii?Q?583ElFdpuBhgIeCezrB8dQiq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137e8299-8336-4946-936a-08d8d7b276e1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 04:21:17.5518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRB7laMeA1R1wg2bATdjqpuu0TXrw9yv8UmJAdYPr3Hh1SthLfe2yLB7r7JvtnNughiqEGGSklbaQ+TAKSU0gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515
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


=== Patch Summary ===
  linux: (git@gitlab.freedesktop.org:agd5f/linux.git) origin/amd-staging-drm-next @ 317990c7e076 
   +  linux-d0f58ed28940 0001 amdgpu/pm: Powerplay API for smu , added get_performance_level
   +  linux-967cbf5a4913 0002 amdgpu/pm: Powerplay API for smu , changed 6 dpm reset functions to use API
   +  linux-33609db56fc2 0003 amdgpu/pm: Powerplay API for smu , changed 6 pm hwmon fan functions to use API
   +  linux-b0fc029cae9a 0004 amdgpu/pm: Powerplay API for smu , changed 9 pm power functions to use API
   +  linux-652a3e289f65 0005 amdgpu/pm: Powerplay API for smu , changed 5 dpm powergating & sensor functions to use API
   +  linux-543e989b1fff 0006 amdgpu/pm: Powerplay API for smu , changes to clock and profile mode functions
   +  linux-d41572ad4199 0007 amdgpu/pm: Powerplay API for smu , changed 4 dpm functions to use API
   +  linux-6576162aaf40 0008 amdgpu/pm: Powerplay API for smu , updates to some pm functions

=== Versions ===
 * Version 3 Updates
  0003 Add a wrapper function to set_fan_control_mode for Powerplay API
       Resolved context clashes caused by commits cc8f099288eac, 9485ed36411b7, 66727e187083f
  0004 Removed smu implementation of powerplay get_power_limit, which clashed with commit dfb3bb7fccb37
       Resolved context clashes caused by commits 9485ed36411b7, 766e03739bce7
  0006 Updated to include new clocks vclk, dclk, od_vddgfx_offset, od_cclk added in commits 771fc82ffc710 & f40074fde207e
       Added forward declaration for function smu_force_smuclk_levels to resolve clash with commit 9485ed36411b7
       Resolved context clashes with commit dfb3bb7fccb37 and v3 updates to patches 0003, 0004
  0007 Resolved context clashes with v3 updates to patches 0003
  0008 Resolved context clashes with v3 updates to patches 0003

 * Version 2 Updates
  0001: updated the structure name to swsmu_pm_funcs
  0003: changed error return value of smu_get_fan_control_mode to AMD_FAN_CTRL_NONE
        fixed type in amdgpu_hwmon_get_pwm1_enable() print statement
        fixed indent flagged by checkpatch.pl
  0004: remove check for error during swsmu amdgpu_dpm_get_pp_num_states() call to match previous powerplay behaviour
  0005: add comment to highlight assignment that changes uint32_t value to int
        fix errors flagged by checkpatch.pl
  0006: fix errors flagged by checkpatch
  0007: fix errors and warnings flagged by checkpatch

=== Test System ===
* DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
 + ISO(Ubuntu 20.04.2 LTS)
 + Kernel(5.9.0-rc5-custom-01408-g317990c7e076)

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
 amdgpu_get_pp_dpm_vclk              <- /sys/class/drm/card0/device/pp_dpm_vclk
 amdgpu_set_pp_dpm_vclk              <- /sys/class/drm/card0/device/pp_dpm_vclk
 amdgpu_get_pp_dpm_dclk              <- /sys/class/drm/card0/device/pp_dpm_dclk
 amdgpu_set_pp_dpm_dclk              <- /sys/class/drm/card0/device/pp_dpm_dclk
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
 amdgpu_get_pp_dpm_vclk                 <- untested: needs other Hardware
 amdgpu_set_pp_dpm_vclk                 <- untested: needs other Hardware
 amdgpu_get_pp_dpm_dclk                 <- untested: needs other Hardware
 amdgpu_set_pp_dpm_dclk                 <- untested: needs other Hardware
** 0007
 amdgpu_pm_compute_clocks            <- untested
 amdgpu_dpm_set_powergating_by_smu   <- untested
 amdgpu_dpm_get_mclk                 <- untested
 amdgpu_dpm_get_sclk                 <- untested
** 0008
 amdgpu_get_pp_od_clk_voltage                 <- file not found
 amdgpu_set_pp_od_clk_voltage                 <- file not found
 amdgpu_set_pp_table                          <- no binary data to test with


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

 .../gpu/drm/amd/include/kgd_pp_interface.h    |   4 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 228 ++----
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 707 ++++--------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  73 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 366 +++++++--
 5 files changed, 557 insertions(+), 821 deletions(-)


base-commit: 317990c7e076a0f4e4f0c3878e7e74f267ee029a
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
