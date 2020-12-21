Return-Path: <SRS0=mahE=FZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A41BC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 03:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1CF22EBD
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 03:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1CF22EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EB5E6E448;
	Mon, 21 Dec 2020 03:04:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 431996E448
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Dec 2020 03:04:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1/oSboS1IhLkMmgk96bqL368c7MBkTdlBbqkUIONLl3IKMYeRj+u0Ps4b8z7UAABMRc5OuzC8nPp7n+rTjS9LFgU0Wlmrqx/+QuVtARtxzGGD2IRn/URtLchpqJwbJGLkYaVhNr/f0zervkUwUZECYexQmuT39p6l2DuLkBMwzUNs8Szu60SwI1Sho1xzGRSIYOEXuuZ/XTlfVdCTPSs09fCwwWwtt2ielg2f6MbTJWvSpIIPPeb+YyMyWd4fTrskgfn7qnmOxxsJHKOaNIG7ASjoU4onpYuEeyNCLNheWYSNb98mV+n1SPKVWYXpB3lT5GvmPt6QLQfAnJthvwvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fidnAcxxUJalhAS2jrf+wZYCXkhnf97KaX2pHvSb8e4=;
 b=mjgdSySiHX70ST51E6BdZmrFpzi/9KRGXju1equb2wVfiZ6HZB5eZCFg4W21krLxMvsQ8pTmPQvQFtFilJ8BVjNrgit1wp6pQGEwyckw+WCLNCSPHlm23MoHLLUHMryyH5j0RD3qYOlc3UQGwUBdGTw8SbqLVNulJO494bSuO/GEU2wDjh3QBHPLmSrFiUKb6kssNBALs//5i8eNkRtRuVjx9hJotVVlI1xbUfwIz4oWYDvuz4xOzaGtxj8L/1eZaN6dh3mWVHC2FF6QGqg1RhxSpT5MM4AfaORxEIoQ1y7+8wY5qiylvkmE6byVN4jXk7oJ5qBxeOh1SgH8d3sZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fidnAcxxUJalhAS2jrf+wZYCXkhnf97KaX2pHvSb8e4=;
 b=QBQXYZE9hiDBrk7fx+MDSC5jYwTai0jSDgJQgPnaoVj8caylfWnB9URGwYNdUcVDVUbJ/t7nnJmur9s0+ejyaGC4A+UZz1NmbTWc9ci5ubP9Jm9haf3md0SHEC9a4IWlDlJB+A4i/OM6ja2dWNLZ9OvMnJouGhzI5v3Ur3X07MA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.25; Mon, 21 Dec 2020 03:04:13 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3676.029; Mon, 21 Dec 2020
 03:04:13 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 0/8] amdgpu/pm: Powerplay API for smu
Thread-Topic: [PATCH 0/8] amdgpu/pm: Powerplay API for smu
Thread-Index: AQHW1aC+t6vT7EYS4USuFHMV3iMAdaoA4Gcg
Date: Mon, 21 Dec 2020 03:04:13 +0000
Message-ID: <DM6PR12MB26192CED8019CC89D4459A2CE4C00@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201219004831.13527-1-darren.powell@amd.com>
In-Reply-To: <20201219004831.13527-1-darren.powell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ca37f401-7d2d-4168-adea-b40b1b6ea1ff;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-21T03:03:16Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 07dd4b24-2a0d-4565-f7cd-08d8a55d187e
x-ms-traffictypediagnostic: DM6PR12MB4484:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB448417D69B18916BBE2055E5E4C00@DM6PR12MB4484.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vTJoGbuZUJo4ZRUoNjY+krBiypoyJrVFHYdGIOgmfnUBHWTaTkIVjp3OMnDuo5Zz4J6lqKnJUkJO+pYYQF6VqXTQ/a78nlOgqxDN19mqFZ0Lca0OG7fUcuK2SJEQaQHaBMGSKjAB6dUXzyisHFj+eQZVgbjA18ePHZ+smmZofz8Tv+VhVb8fBiS3RkTBW8xh2BQ5bLfzg7AfTFAQM7pYl7YGzRtOkOsdHh+6ztGBjGK0whB0T7Y2KGjSkz7XHSWdfqdyPbbGCoVCHCiBb3JljttkYH6jghWaPOkARGeQRfJ1ZCOx+1o+tD2ahXM2hb04eWO8rf9tTo49u6YjGS5DJB21CWmafnalqGM4ml+iYOX67XASpCMrIrsp1PA5zwxoxxvUQ/Tvn6lbW1k/c8Geks/waPrxByDEFfW/GVFdP2g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(6506007)(71200400001)(53546011)(478600001)(83380400001)(55016002)(4326008)(2906002)(76116006)(966005)(186003)(45080400002)(8936002)(8676002)(7696005)(9686003)(5660300002)(52536014)(26005)(64756008)(66946007)(66556008)(66446008)(110136005)(316002)(86362001)(33656002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?oRhv2zCHb2Budt6ADDsB/9EPH7Ha4zbR3/7FJVRNUwL1GEgr8ogKejCmfAFp?=
 =?us-ascii?Q?yz4lwwuGq34KIRMQbp6kOgljQ9jiXzQg1z5fpYUnUnoWLIzWIKCKbdKRHR4J?=
 =?us-ascii?Q?d8YSl2X88qGiBxSDSy1UKZTfpyQKOdA9dpsVTdq8EVSRha+59tGKtZOtCf5P?=
 =?us-ascii?Q?cZ4ksCHCsdbJgyzdA8GhWakVO9Zz5lHp8/1UAbuAc2H43Xj2vjkpOY4Sn7gU?=
 =?us-ascii?Q?0YU3VmifCaCbSpLLnOemt6aF7KzAzlKoZ6jRxAiSDc6XX2Q+xHsq2R0R9t3k?=
 =?us-ascii?Q?IsB5eZQPfAFU5UH602z7iqjZLeyEC7ILVknmtTyrSPeRd4xhBRIIuJRkfLrz?=
 =?us-ascii?Q?6GZsxYyh1SVJK0bmdfz5K8FMJXh3VWhN6pQmSP+tImxq1+If0T66cxX1lDPK?=
 =?us-ascii?Q?0Zc5v72Mg8i82ZDL+NtwIswyoRRSD8FI3haTRTQ1h6e8UskQJ5Cznl9PNx6L?=
 =?us-ascii?Q?D54teC/qsSezFb2BOt+KHjQ5ku4ZY8cJ98Q9eJG5s+iquGv0KDT3n2wyuinX?=
 =?us-ascii?Q?TSN3wc1LGFBbOhV4ACVTWdX3zUYdBUCxMOQs3DZTAc5lkTGvZeG4byLIdB4q?=
 =?us-ascii?Q?UBBkelWXXm4rBsnwuOoobBclTYD0mYC6asVWqHHLsmOgTIEzzlFfjfxs1VWL?=
 =?us-ascii?Q?f5WOHLA88d5UDs0gUwNUswNIITrWnmxsTGAbWLsHjKvhPqlZBVOvyvDJMAH0?=
 =?us-ascii?Q?Fop2kq+ZsEVSv+PN/a6J4j7iTakXNBEJ1usHLbgQKmUvRyg1XfN2E3H/NcJB?=
 =?us-ascii?Q?AzKQr2q3SCll7AuQ353HHbyCvB9ossB9ZbSYSy+lyMEcJgwwhpJLLtMkolQ5?=
 =?us-ascii?Q?v72G+LL1ZdovXA8/bfGKzWlI1dDSbN/haq/g+o+bCE9au5VaXnZ+NTPibRlc?=
 =?us-ascii?Q?MiweiV2u4cfBeHkLZ6LgquNCaqKBoVzZ0gsL8NYzr5zil0l+Jr+JGsJkGFpF?=
 =?us-ascii?Q?V282lhPL7J/yHWFLfY7C4RjMq3Dhd3HYfqsHx9Lgiao=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07dd4b24-2a0d-4565-f7cd-08d8a55d187e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 03:04:13.4051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OpzT+olXw6xOvqj50Fh7FZkdOsqMRerW86hyWjY4xLMDGZ53oGcjqOU2K54PNIjh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
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
Cc: "Powell, Darren" <Darren.Powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Thanks for these cleaups. The series is acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Darren Powell
Sent: Saturday, December 19, 2020 8:48 AM
To: amd-gfx@lists.freedesktop.org
Cc: Powell, Darren <Darren.Powell@amd.com>
Subject: [PATCH 0/8] amdgpu/pm: Powerplay API for smu


=== Description ===
Patches to add the Powerplay API to smu and simplify dpm/pm calling code

=== Test System ===
* DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)  + ISO(Ubuntu 20.04.1 LTS)  + Kernel(5.9.0-rc5-custom-pmcallback-00865-gd3b9ec1a13c9)

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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C35efd75734c84eae04bf08d8a3b7df1a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637439357421991565%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=cvVKTf%2FK%2FNuC2SE7H%2F88DRRfWmxVFqETJ%2BlROM6JSGs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
