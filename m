Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D237C2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 07:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B14A42080C
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 07:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YHLL7RTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14A42080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4521C89BB0;
	Mon, 28 Sep 2020 07:34:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6023789BB0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 07:34:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmhNrQVMcA79DufLlMQ3nK3XI4APmt4aDx07giH/VQ57D+MX4Cm3FL1gg4+sIAYUPeDeSCKwlB/HFHv95dgLRW8UI9iM9fyyAQE9IdH4AeeAckqKAGZ2I8JZixrWq+wPx3rC9Hwrz4dYcEQSdx0r1QYryrxP99R1rBLf4zto4NjuXKq6GnlI0c/Igt1j6cdnOnDsk/zK7ZBl0jR0ZKHMoazI/rbbFcVsWNboaZCO1LZio8W6LVCTvxWHfC1Shg/+EqUTKGnaB9BDaJYcQujCEreET1ws/BNbP+UMacpRDQDzj3Huexr1hlWEkW689PXmWekkLGQlXxuXQk6OKctyLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrzvKJnDyCvjS07LBsSIvXqT1yap15BTN3e9WZe/AiI=;
 b=mvHwMTFVkklLeaAZH170licahPdu7ajVV3Xvgh5qWQ/3upW/Z2ZLSd74CnG7ATBC/qHU93c91Ak9STIJJWp2IlpqMm8GDmhDlyVHIa+K2DCzYQv00CJ1TYHkbmyTJ9tqV1/GCE2scR9rlQF0s4wKvavXaF+SJTun4Q4DxasXQc7Q0Xm8f1WYsyugqpPVe9sp9GlpmjP/AR47hfP1qf0pSVpg1oGdTDx9E6ntAtfwQfKMbinE59qH/r8T4IcgstxnezjoXe2daJRRL3pLaGz5p5FzUvczpcTt7Bf2IzZXpuHdtFCJ4AbPCQriSQs5kXuTInWu774YqvxI1WHug2SbdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrzvKJnDyCvjS07LBsSIvXqT1yap15BTN3e9WZe/AiI=;
 b=YHLL7RTOipb29QBk1E/Nc4tOSxdZ1D88420OOAiQVz2BcHIcaxIWxy0wIFLI5guH8+eZktsBiFSVlyvRvL64Es0Q6OZUyybFVgenf/njNmSbhkqA1t9l9HJPFJce7GfuHxxU90mYqveZl43k7D3opKxLPelS1OEaAIZ8yE3LD5o=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3165.namprd12.prod.outlook.com (2603:10b6:208:ac::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Mon, 28 Sep
 2020 07:34:20 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93%4]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 07:34:20 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: add one sysfs file --
 "pp_od_clk_voltage"  to support the feature to modify gfx engine clock(Mhz
 units) on Raven/Raven2/Picasso APU.
Thread-Topic: [PATCH] drm/amd/powerplay: add one sysfs file --
 "pp_od_clk_voltage"  to support the feature to modify gfx engine clock(Mhz
 units) on Raven/Raven2/Picasso APU.
Thread-Index: AQHWlWdLC66qD6Xx8EqA8WGcUf/H2Kl9pk7u
Date: Mon, 28 Sep 2020 07:34:19 +0000
Message-ID: <MN2PR12MB30225B0D0BA9B4E9B813D5CFA2350@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20200928071530.20244-1-xiaojian.du@amd.com>
In-Reply-To: <20200928071530.20244-1-xiaojian.du@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-28T07:34:19.128Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.246.142.102]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a9a08aa9-3a00-4e58-d3db-08d86380e9a9
x-ms-traffictypediagnostic: MN2PR12MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3165DD2B4BB38EA9FD6AAE2FA2350@MN2PR12MB3165.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BbTQ+eZiGGMUPKLL8Bzmt+oolUrAtAEgqxKtazRbRTz8zWgT8XVrcfOhWyJEbawsEHlDkod4sawwuHtcQj+u3ips7TEa0v5GFBUM40ieF/kMCIoYhj4nqYdIM2a3E2tFO9ZRE0sJWIbZ63MgSb2sbtxWzir8PaDmvG3Z8rpx+vDVki72uBX/OlUYwYYZgg5TYyhcfKeWoF/44dZvAxAzZEVyMmR5JDCtGppS/BJyRdDUEvowUiDbAjJwZtOK/+QaFu4knuv2jbRaaFjwcx3T9yNUDSaOqkLbSO/RpZVYq7xHxzIsoWvWMeKpMUC9WAba52RuTmqevHziGm0M4ZUI/2l9aJnfjysTwOPENVd4Xh7NeUAvgQp/Zab6eij1sg0+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(66946007)(2906002)(33656002)(83380400001)(55016002)(8676002)(4326008)(8936002)(478600001)(5660300002)(30864003)(19627405001)(86362001)(52536014)(316002)(54906003)(110136005)(66446008)(64756008)(66476007)(66556008)(7696005)(76116006)(53546011)(186003)(91956017)(9686003)(19627235002)(26005)(6506007)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: X9+DGd1cVamssh75BJc7MayJ/WrQu+fjdX0jPkWYScPuA5gQ7opvBsMaAWAzpI4d50qzQggtoNyWdBm4aTkFNwuBtqIhsTtLx/Sde4PqcFW9gsz285y6xliv8+6AoIhFg0L0UaZ9Eod/97SBW5F1D2oIj15tSEBqj6iFieQKgtbTAAjtzhQW1F+0NjVCCETpWV3bQ9XXluh7eZ+o9+uEUKfYbMMr/nQvi3VRC3tAPP5xuwJWFelOgEuNzn2QQ3D6CwELsFEVDs6RmnrPCzWw7ayfHFC76X89o4PzoE+4Qkr1rBRQ4qH+WVq4SgnLu+aLBUShMY2B22RAChtmVjd4X7jp2siE6biGlEO5pdPTFzpTfFETLp+I9qTb3yWVouvMWLfl94BgrqxNT3w77NuOnDuOabFzOHCgslDsF4ZHjPUIfBRXxO7vnXqHnXTcb6uiPfBLjsSKah2vPI3ReJWBSSWeBPnZAL8zmzxXyS2bIeiKHTpXmjF6kBH0D3tbMVGfTNZ/Z7I4YkZy1Qdg5TYFBo7CvMBv93Ysc//BJl20i1sFf3NHpXOn1kIeDqmfsXKWZYKy+Xp1EcvrAXfpAHQYkGNJr9JGPJgNxmHBO5/WwJkgoXGXF7i8ty86uqSF31xdJ28rgwCbcDpUwOAOyLMOVQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a08aa9-3a00-4e58-d3db-08d86380e9a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 07:34:19.8710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qW6LGS+qJp1JFlFD5BbIlljpxbH5SxpLcV8u7PYdxuj9dN+5TIb3lxbcG9uT25/U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3165
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Shimmer" <Xinmei.Huang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: multipart/mixed; boundary="===============1024889068=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1024889068==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB30225B0D0BA9B4E9B813D5CFA2350MN2PR12MB3022namp_"

--_000_MN2PR12MB30225B0D0BA9B4E9B813D5CFA2350MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

comment inline.

after fixed, the patch is
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin
________________________________
From: Du, Xiaojian <Xiaojian.Du@amd.com>
Sent: Monday, September 28, 2020 3:15 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Huang, Ray <Ray.Huang@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>=
; Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd=
.com>; Huang, Shimmer <Xinmei.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd=
.com>; Du, Xiaojian <Xiaojian.Du@amd.com>
Subject: [PATCH] drm/amd/powerplay: add one sysfs file -- "pp_od_clk_voltag=
e" to support the feature to modify gfx engine clock(Mhz units) on Raven/Ra=
ven2/Picasso APU.

From: Xiaojian Du <xiaojian.du@amd.com>

From: Xiaojian Du <Xiaojian.Du@amd.com>

[Kevin]: the patch title is too long, please simplify it.

This patch is to add one sysfs file -- "pp_od_clk_voltage" for
Raven/Raven2/Picasso APU, which is only used by dGPU like VEGA10.
This sysfs file supports the feature to modify gfx engine clock(Mhz units),=
 it can
be used to configure the min value and the max value for gfx clock limited =
in the
safe range.

Command guide:
echo "s level clock" > pp_od_clk_voltage
        s - adjust teh sclk level
        level - 0 or 1, "0" represents the min value, "1" represents the ma=
x value
        clock - the clock value(Mhz units), like 400, 800 or 1200, the valu=
e must be within the
                OD_RANGE limits.
Example:
$ cat pp_od_clk_voltage
OD_SCLK:
0:        200Mhz
1:       1400Mhz
OD_RANGE:
SCLK:     200MHz       1400MHz

$ echo "s 0 600" > pp_od_clk_voltage
$ echo "s 1 1000" > pp_od_clk_voltage
$ cat pp_od_clk_voltage
OD_SCLK:
0:        600Mhz
1:       1000Mhz
OD_RANGE:
SCLK:     200MHz       1400MHz

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 12 +++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  4 +
 drivers/gpu/drm/amd/pm/inc/hwmgr.h            |  5 ++
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 17 +++-
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 79 +++++++++++++++++++
 6 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 0aec28fda058..94132c70d7af 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -281,6 +281,7 @@ struct amd_pm_funcs {
         int (*get_power_limit)(void *handle, uint32_t *limit, bool default=
_limit);
         int (*get_power_profile_mode)(void *handle, char *buf);
         int (*set_power_profile_mode)(void *handle, long *input, uint32_t =
size);
+       int (*set_fine_grain_clk_vol)(void *handle, uint32_t type, long *in=
put, uint32_t size);
         int (*odn_edit_dpm_table)(void *handle, uint32_t type, long *input=
, uint32_t size);
         int (*set_mp1_state)(void *handle, enum pp_mp1_state mp1_state);
         int (*smu_i2c_bus_access)(void *handle, bool acquire);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index b5d2f30043ad..fe0de00f56e2 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -827,6 +827,18 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct dev=
ice *dev,
                         return -EINVAL;
                 }
         } else {
+
+               if (adev->powerplay.pp_funcs->set_fine_grain_clk_vol) {
+                       ret =3D amdgpu_dpm_set_fine_grain_clk_vol(adev, typ=
e,
+                                                               parameter,
+                                                               parameter_s=
ize);
+                       if (ret) {
+                               pm_runtime_mark_last_busy(ddev->dev);
+                               pm_runtime_put_autosuspend(ddev->dev);
+                               return -EINVAL;
+                       }
+               }
+
                 if (adev->powerplay.pp_funcs->odn_edit_dpm_table) {
                         ret =3D amdgpu_dpm_odn_edit_dpm_table(adev, type,
                                                 parameter, parameter_size)=
;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_dpm.h
index dff4a5f99bb0..f6e0e7d8a007 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -349,6 +349,10 @@ enum amdgpu_pcie_gen {
                 ((adev)->powerplay.pp_funcs->set_power_profile_mode(\
                         (adev)->powerplay.pp_handle, parameter, size))

+#define amdgpu_dpm_set_fine_grain_clk_vol(adev, type, parameter, size) \
+               ((adev)->powerplay.pp_funcs->set_fine_grain_clk_vol(\
+                       (adev)->powerplay.pp_handle, type, parameter, size)=
)
+
 #define amdgpu_dpm_odn_edit_dpm_table(adev, type, parameter, size) \
                 ((adev)->powerplay.pp_funcs->odn_edit_dpm_table(\
                         (adev)->powerplay.pp_handle, type, parameter, size=
))
diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/in=
c/hwmgr.h
index 1b3529efc91e..3898a95ec28b 100644
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
@@ -340,6 +340,9 @@ struct pp_hwmgr_func {
         int (*odn_edit_dpm_table)(struct pp_hwmgr *hwmgr,
                                         enum PP_OD_DPM_TABLE_COMMAND type,
                                         long *input, uint32_t size);
+       int (*set_fine_grain_clk_vol)(struct pp_hwmgr *hwmgr,
+                                     enum PP_OD_DPM_TABLE_COMMAND type,
+                                     long *input, uint32_t size);
         int (*set_power_limit)(struct pp_hwmgr *hwmgr, uint32_t n);
         int (*powergate_mmhub)(struct pp_hwmgr *hwmgr);
         int (*smus_notify_pwe)(struct pp_hwmgr *hwmgr);
@@ -347,6 +350,8 @@ struct pp_hwmgr_func {
         int (*enable_mgpu_fan_boost)(struct pp_hwmgr *hwmgr);
         int (*set_hard_min_dcefclk_by_freq)(struct pp_hwmgr *hwmgr, uint32=
_t clock);
         int (*set_hard_min_fclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t =
clock);
+       int (*set_hard_min_gfxclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t=
 clock);
+       int (*set_soft_max_gfxclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t=
 clock);
         int (*get_asic_baco_capability)(struct pp_hwmgr *hwmgr, bool *cap)=
;
         int (*get_asic_baco_state)(struct pp_hwmgr *hwmgr, enum BACO_STATE=
 *state);
         int (*set_asic_baco_state)(struct pp_hwmgr *hwmgr, enum BACO_STATE=
 state);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu=
/drm/amd/pm/powerplay/amd_powerplay.c
index a6321f2063c1..bb8d077d3f05 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -911,6 +911,20 @@ static int pp_set_power_profile_mode(void *handle, lon=
g *input, uint32_t size)
         return ret;
 }

+static int pp_set_fine_grain_clk_vol(void *handle, uint32_t type, long *in=
put, uint32_t size)
+{
+       struct pp_hwmgr *hwmgr =3D handle;
+
+       if (!hwmgr || !hwmgr->pm_en)
+               return -EINVAL;
+
+       if (hwmgr->hwmgr_func->set_fine_grain_clk_vol =3D=3D NULL) {
+               return 0;
+       }

[Kevin]: don't need '{}' if the code only have 1 line.
+
+       return hwmgr->hwmgr_func->set_fine_grain_clk_vol(hwmgr, type, input=
, size);
+}
+
 static int pp_odn_edit_dpm_table(void *handle, uint32_t type, long *input,=
 uint32_t size)
 {
         struct pp_hwmgr *hwmgr =3D handle;
@@ -920,7 +934,7 @@ static int pp_odn_edit_dpm_table(void *handle, uint32_t=
 type, long *input, uint3

         if (hwmgr->hwmgr_func->odn_edit_dpm_table =3D=3D NULL) {
                 pr_info_ratelimited("%s was not implemented.\n", __func__)=
;
-               return -EINVAL;
+               return 0;
         }

         return hwmgr->hwmgr_func->odn_edit_dpm_table(hwmgr, type, input, s=
ize);
@@ -1645,6 +1659,7 @@ static const struct amd_pm_funcs pp_dpm_funcs =3D {
         .set_powergating_by_smu =3D pp_set_powergating_by_smu,
         .get_power_profile_mode =3D pp_get_power_profile_mode,
         .set_power_profile_mode =3D pp_set_power_profile_mode,
+       .set_fine_grain_clk_vol =3D pp_set_fine_grain_clk_vol,
         .odn_edit_dpm_table =3D pp_odn_edit_dpm_table,
         .set_mp1_state =3D pp_dpm_set_mp1_state,
         .set_power_limit =3D pp_set_power_limit,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 9ee8cf8267c8..791db107d51a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -242,6 +242,34 @@ static int smu10_set_hard_min_fclk_by_freq(struct pp_h=
wmgr *hwmgr, uint32_t cloc
         return 0;
 }

+static int smu10_set_hard_min_gfxclk_by_freq(struct pp_hwmgr *hwmgr, uint3=
2_t clock)
+{
+       struct smu10_hwmgr *smu10_data =3D (struct smu10_hwmgr *)(hwmgr->ba=
ckend);
+
+       if (clock && smu10_data->gfx_actual_soft_min_freq !=3D clock) {
+               smu10_data->gfx_actual_soft_min_freq =3D clock;
+               smum_send_msg_to_smc_with_parameter(hwmgr,
+                                       PPSMC_MSG_SetHardMinGfxClk,
+                                       smu10_data->gfx_actual_soft_min_fre=
q,
+                                       NULL);
+       }
+       return 0;
+}
+
+static int smu10_set_soft_max_gfxclk_by_freq(struct pp_hwmgr *hwmgr, uint3=
2_t clock)
+{
+       struct smu10_hwmgr *smu10_data =3D (struct smu10_hwmgr *)(hwmgr->ba=
ckend);
+
+       if (clock && smu10_data->gfx_max_freq_limit !=3D (clock * 100))  {
+               smu10_data->gfx_max_freq_limit =3D clock * 100;
+               smum_send_msg_to_smc_with_parameter(hwmgr,
+                                       PPSMC_MSG_SetSoftMaxGfxClk,
+                                       clock,
+                                       NULL);
+       }
+       return 0;
+}

the  unit of varible 'gfx_max_freq_limit' and 'gfx_max_freq_limit' is diffe=
rent, one is Mhz and another is 10Khz.
we'd better unify it.
+
 static int smu10_set_active_display_count(struct pp_hwmgr *hwmgr, uint32_t=
 count)
 {
         struct smu10_hwmgr *smu10_data =3D (struct smu10_hwmgr *)(hwmgr->b=
ackend);
@@ -527,6 +555,8 @@ static int smu10_hwmgr_backend_init(struct pp_hwmgr *hw=
mgr)
         hwmgr->pstate_sclk =3D SMU10_UMD_PSTATE_GFXCLK * 100;
         hwmgr->pstate_mclk =3D SMU10_UMD_PSTATE_FCLK * 100;

+       hwmgr->od_enabled =3D 1; /*enable the pp_od_clk_voltage sysfs file*=
/
[Kevin]: please move this comment to a new line.
+
         return result;
 }

@@ -947,6 +977,26 @@ static int smu10_print_clock_levels(struct pp_hwmgr *h=
wmgr,
                                         ((mclk_table->entries[i].clk / 100=
)
                                          =3D=3D now) ? "*" : "");
                 break;
+       case OD_SCLK:
+               if (hwmgr->od_enabled) {
+                       size =3D sprintf(buf, "%s:\n", "OD_SCLK");
+
+                       size +=3D sprintf(buf + size, "0: %10uMhz\n",
+                       (data->gfx_actual_soft_min_freq > 0) ? data->gfx_ac=
tual_soft_min_freq : data->gfx_min_freq_limit/100);
+                       size +=3D sprintf(buf + size, "1: %10uMhz\n", data-=
>gfx_max_freq_limit/100);
+               }
+               break;
+       case OD_RANGE:
+               if (hwmgr->od_enabled) {
+                       uint32_t min_freq, max_freq =3D 0;
+                       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkF=
requency, &min_freq);
+                       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkF=
requency, &max_freq);
+
+                       size =3D sprintf(buf, "%s:\n", "OD_RANGE");
+                       size +=3D sprintf(buf + size, "SCLK: %7uMHz %10uMHz=
\n",
+                               min_freq, max_freq);
+               }
+               break;
         default:
                 break;
         }
@@ -1348,6 +1398,32 @@ static int smu10_asic_reset(struct pp_hwmgr *hwmgr, =
enum SMU_ASIC_RESET_MODE mod
                                                    NULL);
 }

+static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
+                                       enum PP_OD_DPM_TABLE_COMMAND type,
+                                       long *input, uint32_t size)
+{
+       if (!hwmgr->od_enabled) {
+               pr_err("Fine grain not support\n");
+               return -EINVAL;
+       }
+
+       if (size !=3D 2) {
+               pr_err("Input parameter number not correct\n");
+               return -EINVAL;
+       }
+
+       if (type =3D=3D PP_OD_EDIT_SCLK_VDDC_TABLE) {
+               if (input[0] =3D=3D 0)
+                       smu10_set_hard_min_gfxclk_by_freq(hwmgr, input[1]);
+               else if (input[0] =3D=3D 1)
+                       smu10_set_soft_max_gfxclk_by_freq(hwmgr, input[1]);
+               else
+                       return -EINVAL;
+       }
+
+       return 0;
+}
+
 static const struct pp_hwmgr_func smu10_hwmgr_funcs =3D {
         .backend_init =3D smu10_hwmgr_backend_init,
         .backend_fini =3D smu10_hwmgr_backend_fini,
@@ -1388,9 +1464,12 @@ static const struct pp_hwmgr_func smu10_hwmgr_funcs =
=3D {
         .powergate_sdma =3D smu10_powergate_sdma,
         .set_hard_min_dcefclk_by_freq =3D smu10_set_hard_min_dcefclk_by_fr=
eq,
         .set_hard_min_fclk_by_freq =3D smu10_set_hard_min_fclk_by_freq,
+       .set_hard_min_gfxclk_by_freq =3D smu10_set_hard_min_gfxclk_by_freq,
+       .set_soft_max_gfxclk_by_freq =3D smu10_set_soft_max_gfxclk_by_freq,
         .get_power_profile_mode =3D smu10_get_power_profile_mode,
         .set_power_profile_mode =3D smu10_set_power_profile_mode,
         .asic_reset =3D smu10_asic_reset,
+       .set_fine_grain_clk_vol =3D smu10_set_fine_grain_clk_vol,
 };

 int smu10_init_function_pointers(struct pp_hwmgr *hwmgr)
--
2.17.1


--_000_MN2PR12MB30225B0D0BA9B4E9B813D5CFA2350MN2PR12MB3022namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
comment inline.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
after fixed, the patch is&nbsp;</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Best Regards,<br>
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Du, Xiaojian &lt;Xiao=
jian.Du@amd.com&gt;<br>
<b>Sent:</b> Monday, September 28, 2020 3:15 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevi=
n1.Wang@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; =
Quan, Evan &lt;Evan.Quan@amd.com&gt;; Huang, Shimmer &lt;Xinmei.Huang@amd.c=
om&gt;; Du, Xiaojian &lt;Xiaojian.Du@amd.com&gt;; Du, Xiaojian &lt;Xiaojian=
.Du@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: add one sysfs file -- &quot;pp_o=
d_clk_voltage&quot; to support the feature to modify gfx engine clock(Mhz u=
nits) on Raven/Raven2/Picasso APU.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">From: Xiaojian Du &lt;xiaojian.du@amd.com&gt;<br>
<br>
From: Xiaojian Du &lt;Xiaojian.Du@amd.com&gt;</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[Kevin]: the patch title is too long, please simpl=
ify it.&nbsp;<br>
<br>
This patch is to add one sysfs file -- &quot;pp_od_clk_voltage&quot; for<br=
>
Raven/Raven2/Picasso APU, which is only used by dGPU like VEGA10.<br>
This sysfs file supports the feature to modify gfx engine clock(Mhz units),=
 it can<br>
be used to configure the min value and the max value for gfx clock limited =
in the<br>
safe range.<br>
<br>
Command guide:<br>
echo &quot;s level clock&quot; &gt; pp_od_clk_voltage<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s - adjust teh sclk level<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; level - 0 or 1, &quot;0&quot; re=
presents the min value, &quot;1&quot; represents the max value<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock - the clock value(Mhz unit=
s), like 400, 800 or 1200, the value must be within the<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; OD_RANGE limits.<br>
Example:<br>
$ cat pp_od_clk_voltage<br>
OD_SCLK:<br>
0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 200Mhz<br>
1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1400Mhz<br>
OD_RANGE:<br>
SCLK:&nbsp;&nbsp;&nbsp;&nbsp; 200MHz&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14=
00MHz<br>
<br>
$ echo &quot;s 0 600&quot; &gt; pp_od_clk_voltage<br>
$ echo &quot;s 1 1000&quot; &gt; pp_od_clk_voltage<br>
$ cat pp_od_clk_voltage<br>
OD_SCLK:<br>
0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 600Mhz<br>
1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1000Mhz<br>
OD_RANGE:<br>
SCLK:&nbsp;&nbsp;&nbsp;&nbsp; 200MHz&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14=
00MHz<br>
<br>
Signed-off-by: Xiaojian Du &lt;Xiaojian.Du@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/include/kgd_pp_interface.h&nbsp;&nbsp;&nbsp; |&nbsp; =
1 +<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 12 +++<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 4 +<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/hwmgr.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 ++<br>
&nbsp;.../gpu/drm/amd/pm/powerplay/amd_powerplay.c&nbsp; | 17 +++-<br>
&nbsp;.../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c&nbsp; | 79 +++++++++++++=
++++++<br>
&nbsp;6 files changed, 117 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h<br>
index 0aec28fda058..94132c70d7af 100644<br>
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
@@ -281,6 +281,7 @@ struct amd_pm_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_power_limit)(voi=
d *handle, uint32_t *limit, bool default_limit);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_power_profile_mo=
de)(void *handle, char *buf);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_power_profile_mo=
de)(void *handle, long *input, uint32_t size);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_fine_grain_clk_vol)(void *h=
andle, uint32_t type, long *input, uint32_t size);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*odn_edit_dpm_table)(=
void *handle, uint32_t type, long *input, uint32_t size);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_mp1_state)(void =
*handle, enum pp_mp1_state mp1_state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*smu_i2c_bus_access)(=
void *handle, bool acquire);<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index b5d2f30043ad..fe0de00f56e2 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -827,6 +827,18 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct dev=
ice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;set_fine_grain_clk_vol) {<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_d=
pm_set_fine_grain_clk_vol(adev, type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
arameter,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
arameter_size);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev-&gt;dev);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ddev-&gt;dev);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;odn_edit_dpm_tabl=
e) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D amdgpu_dpm_odn_edit_dpm_table(adev, type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; parameter, =
parameter_size);<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_dpm.h<br>
index dff4a5f99bb0..f6e0e7d8a007 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h<br>
@@ -349,6 +349,10 @@ enum amdgpu_pcie_gen {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;set_power_profile_=
mode(\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev=
)-&gt;powerplay.pp_handle, parameter, size))<br>
&nbsp;<br>
+#define amdgpu_dpm_set_fine_grain_clk_vol(adev, type, parameter, size) \<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;set_fine_grain_clk_vol(\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev)-&gt;power=
play.pp_handle, type, parameter, size))<br>
+<br>
&nbsp;#define amdgpu_dpm_odn_edit_dpm_table(adev, type, parameter, size) \<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;odn_edit_dpm_table=
(\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev=
)-&gt;powerplay.pp_handle, type, parameter, size))<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/in=
c/hwmgr.h<br>
index 1b3529efc91e..3898a95ec28b 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h<br>
@@ -340,6 +340,9 @@ struct pp_hwmgr_func {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*odn_edit_dpm_table)(=
struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum PP_OD_DPM_TABLE_COMMAND type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; long *input, uint32_t size);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_fine_grain_clk_vol)(struct =
pp_hwmgr *hwmgr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum PP=
_OD_DPM_TABLE_COMMAND type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long *i=
nput, uint32_t size);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_power_limit)(str=
uct pp_hwmgr *hwmgr, uint32_t n);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*powergate_mmhub)(str=
uct pp_hwmgr *hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*smus_notify_pwe)(str=
uct pp_hwmgr *hwmgr);<br>
@@ -347,6 +350,8 @@ struct pp_hwmgr_func {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*enable_mgpu_fan_boos=
t)(struct pp_hwmgr *hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_hard_min_dcefclk=
_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_hard_min_fclk_by=
_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_hard_min_gfxclk_by_freq)(st=
ruct pp_hwmgr *hwmgr, uint32_t clock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_soft_max_gfxclk_by_freq)(st=
ruct pp_hwmgr *hwmgr, uint32_t clock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_asic_baco_capabi=
lity)(struct pp_hwmgr *hwmgr, bool *cap);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_asic_baco_state)=
(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_asic_baco_state)=
(struct pp_hwmgr *hwmgr, enum BACO_STATE state);<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu=
/drm/amd/pm/powerplay/amd_powerplay.c<br>
index a6321f2063c1..bb8d077d3f05 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c<br>
@@ -911,6 +911,20 @@ static int pp_set_power_profile_mode(void *handle, lon=
g *input, uint32_t size)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
+static int pp_set_fine_grain_clk_vol(void *handle, uint32_t type, long *in=
put, uint32_t size)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =3D handle;<br=
>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr-&gt;pm_en)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_func-&gt;set_fine=
_grain_clk_vol =3D=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[Kevin]: don't need '{}' if the code only have 1 l=
ine.</div>
<div class=3D"PlainText">+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;hwmgr_func-&gt;set_f=
ine_grain_clk_vol(hwmgr, type, input, size);<br>
+}<br>
+<br>
&nbsp;static int pp_odn_edit_dpm_table(void *handle, uint32_t type, long *i=
nput, uint32_t size)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =3D=
 handle;<br>
@@ -920,7 +934,7 @@ static int pp_odn_edit_dpm_table(void *handle, uint32_t=
 type, long *input, uint3<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_func-&=
gt;odn_edit_dpm_table =3D=3D NULL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_info_ratelimited(&quot;%s was not implemented.\n&q=
uot;, __func__);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;hwmgr_fun=
c-&gt;odn_edit_dpm_table(hwmgr, type, input, size);<br>
@@ -1645,6 +1659,7 @@ static const struct amd_pm_funcs pp_dpm_funcs =3D {<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_powergating_by_smu =
=3D pp_set_powergating_by_smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_power_profile_mode =
=3D pp_get_power_profile_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_profile_mode =
=3D pp_set_power_profile_mode,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fine_grain_clk_vol =3D pp_set_fi=
ne_grain_clk_vol,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .odn_edit_dpm_table =3D pp=
_odn_edit_dpm_table,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mp1_state =3D pp_dpm_=
set_mp1_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_limit =3D pp_se=
t_power_limit,<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
index 9ee8cf8267c8..791db107d51a 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
@@ -242,6 +242,34 @@ static int smu10_set_hard_min_fclk_by_freq(struct pp_h=
wmgr *hwmgr, uint32_t cloc<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int smu10_set_hard_min_gfxclk_by_freq(struct pp_hwmgr *hwmgr, uint3=
2_t clock)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu10_hwmgr *smu10_data =3D (s=
truct smu10_hwmgr *)(hwmgr-&gt;backend);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (clock &amp;&amp; smu10_data-&gt;g=
fx_actual_soft_min_freq !=3D clock) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu10_data-&gt;gfx_actual_soft_min_freq =3D clock;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smum_send_msg_to_smc_with_parameter(hwmgr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; PPSMC_MSG_SetHardMinGfxClk,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; smu10_data-&gt;gfx_actual_soft_min_freq,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+static int smu10_set_soft_max_gfxclk_by_freq(struct pp_hwmgr *hwmgr, uint3=
2_t clock)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu10_hwmgr *smu10_data =3D (s=
truct smu10_hwmgr *)(hwmgr-&gt;backend);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (clock &amp;&amp; smu10_data-&gt;g=
fx_max_freq_limit !=3D (clock * 100))&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu10_data-&gt;gfx_max_freq_limit =3D clock * 100;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smum_send_msg_to_smc_with_parameter(hwmgr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; PPSMC_MSG_SetSoftMaxGfxClk,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; clock,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">the&nbsp; unit of varible '<span style=3D"color: r=
gb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West Eu=
ropean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Rob=
oto, &quot;Helvetica Neue&quot;, sans-serif; background-color: rgb(255, 255=
, 255); display: inline !important">gfx_max_freq_limit'<span>&nbsp;and
 '<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (Wes=
t European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont,=
 Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color: rgb(255,=
 255, 255); display: inline !important">gfx_max_freq_limit' is different,
 one is Mhz and another is 10Khz.</span></span></span></div>
<div class=3D"PlainText">we'd better unify it.</div>
<div class=3D"PlainText">+<br>
&nbsp;static int smu10_set_active_display_count(struct pp_hwmgr *hwmgr, uin=
t32_t count)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu10_hwmgr *smu10_=
data =3D (struct smu10_hwmgr *)(hwmgr-&gt;backend);<br>
@@ -527,6 +555,8 @@ static int smu10_hwmgr_backend_init(struct pp_hwmgr *hw=
mgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;pstate_sclk =3D =
SMU10_UMD_PSTATE_GFXCLK * 100;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;pstate_mclk =3D =
SMU10_UMD_PSTATE_FCLK * 100;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;od_enabled =3D 1; /*enable =
the pp_od_clk_voltage sysfs file*/</div>
<div class=3D"PlainText">[Kevin]: please move this comment to a new line.<b=
r>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -947,6 +977,26 @@ static int smu10_print_clock_levels(struct pp_hwmgr *h=
wmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ((mclk_table-&gt;entries[i].clk / 100)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =3D=3D now) ? &quot;*&quot; : &quot;&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case OD_SCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (hwmgr-&gt;od_enabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D sprintf=
(buf, &quot;%s:\n&quot;, &quot;OD_SCLK&quot;);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D sprint=
f(buf + size, &quot;0: %10uMhz\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (data-&gt;gfx_ac=
tual_soft_min_freq &gt; 0) ? data-&gt;gfx_actual_soft_min_freq : data-&gt;g=
fx_min_freq_limit/100);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D sprint=
f(buf + size, &quot;1: %10uMhz\n&quot;, data-&gt;gfx_max_freq_limit/100);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case OD_RANGE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (hwmgr-&gt;od_enabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t min_fre=
q, max_freq =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to=
_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &amp;min_freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to=
_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &amp;max_freq);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D sprintf=
(buf, &quot;%s:\n&quot;, &quot;OD_RANGE&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D sprint=
f(buf + size, &quot;SCLK: %7uMHz %10uMHz\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_freq, max_freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1348,6 +1398,32 @@ static int smu10_asic_reset(struct pp_hwmgr *hwmgr, =
enum SMU_ASIC_RESET_MODE mod<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; NULL);<br>
&nbsp;}<br>
&nbsp;<br>
+static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; enum PP_OD_DPM_TABLE_COMMAND type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; long *input, uint32_t size)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;od_enabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_err(&quot;Fine grain not support\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (size !=3D 2) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_err(&quot;Input parameter number not correct\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (type =3D=3D PP_OD_EDIT_SCLK_VDDC_=
TABLE) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (input[0] =3D=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu10_set_hard_m=
in_gfxclk_by_freq(hwmgr, input[1]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (input[0] =3D=3D 1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu10_set_soft_m=
ax_gfxclk_by_freq(hwmgr, input[1]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static const struct pp_hwmgr_func smu10_hwmgr_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .backend_init =3D smu10_hw=
mgr_backend_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .backend_fini =3D smu10_hw=
mgr_backend_fini,<br>
@@ -1388,9 +1464,12 @@ static const struct pp_hwmgr_func smu10_hwmgr_funcs =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .powergate_sdma =3D smu10_=
powergate_sdma,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_hard_min_dcefclk_by_f=
req =3D smu10_set_hard_min_dcefclk_by_freq,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_hard_min_fclk_by_freq=
 =3D smu10_set_hard_min_fclk_by_freq,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_hard_min_gfxclk_by_freq =3D smu1=
0_set_hard_min_gfxclk_by_freq,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_soft_max_gfxclk_by_freq =3D smu1=
0_set_soft_max_gfxclk_by_freq,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_power_profile_mode =
=3D smu10_get_power_profile_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_profile_mode =
=3D smu10_set_power_profile_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asic_reset =3D smu10_asic=
_reset,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fine_grain_clk_vol =3D smu10_set=
_fine_grain_clk_vol,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;int smu10_init_function_pointers(struct pp_hwmgr *hwmgr)<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB30225B0D0BA9B4E9B813D5CFA2350MN2PR12MB3022namp_--

--===============1024889068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1024889068==--
