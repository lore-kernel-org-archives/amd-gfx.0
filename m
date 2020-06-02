Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9034CC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 10:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A05206A4
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 10:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AZz6X8wl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A05206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D966589D57;
	Tue,  2 Jun 2020 10:50:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F049E89D57
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 10:50:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/hzX2owVN8tGpS2vzFsHZq9uyqIxBC/mHOJsZbq73PIakT4OOC55BTW0pvT7OvrDWnzLsJG+AdHg42EVKvTU/RPWsUoA6uEq6KQBJDQIvYg46azhWXVPpCPuOQ8BiLTVqY7FrTJrXxYth9BTxbJaSKtynsNKHr0kHviF7zNyjt0d/adTIFYAXZkQzWAviu6P9TxVRpRdgRs81lMZaY/qYQIp7bTZ2dlVMwPtcb4mDr9h7/0hqDCSdJbl6AEflDGrU+FUjhhs5JKu2I4sIv0cw67Un58Q39WV4JUtzv9HBYbVeu5ODLU857imq+WdnpP6QrZnxMPiTmzRvJeAciX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAWtPLZhhKwUBXosSfU/BUo3Lpn+gnDjzhyXj5ZAVE4=;
 b=jeZQOYYSagrecjB51rRleE5zx3aeiFolrX5eOs2pBC2NWEqtdVt9Stf2O6xu64xW4Q50jAEvFpqxcDYd61CNOHQq22B4CSbuptk/1+mp7FbKrN9YZzpE17SYC+VvTxUfCyH4i1INhhGhZzAvIfqOSbvJWdGgnVFfIdIQ/KAYVQqp+hrCewROujlCn5Tdy0TmK3mxJX+03xuCozQ0w4L2Toa2vT324KEiIvYt6vQrtKMPZVZy6c2aDU23/qpnXZl9FnD7lBD/2fwshyqT7zUo7hWU1Ktjs0du1fHbDE5dgQSxB30qazjDPUycbLtJOEUbpTYnEMzjUcCPlmlExHfG+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAWtPLZhhKwUBXosSfU/BUo3Lpn+gnDjzhyXj5ZAVE4=;
 b=AZz6X8wlJxUyvLycKFbwXEUZE7/0Ij5LK1vcUuIaOAuuQsmGX1W7Hprm3Wp6HpiZ634KA28v82e8ZFNvrKOg/wEaFhfZmXgJvRqQiF8qsB5gbhdNtnk2BgLmLBvztV2kcv6odeXetVNoLI59XVbE7snRuk0slTWAfs+UEphCa+M=
Received: from BY5PR12MB4068.namprd12.prod.outlook.com (52.135.52.204) by
 BY5PR12MB4145.namprd12.prod.outlook.com (10.255.126.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Tue, 2 Jun 2020 10:50:09 +0000
Received: from BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c]) by BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c%2]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 10:50:09 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: move powerplay table operation out of
 smu_v11_0.c
Thread-Topic: [PATCH] drm/amd/powerplay: move powerplay table operation out of
 smu_v11_0.c
Thread-Index: AQHWOL14G6NJCPcMK0WK2Y3Hb+BeKKjFJYZ9
Date: Tue, 2 Jun 2020 10:50:09 +0000
Message-ID: <BY5PR12MB40684E08B8DC08DE99BF9B5BA28B0@BY5PR12MB4068.namprd12.prod.outlook.com>
References: <20200602090840.3318819-1-likun.gao@amd.com>
In-Reply-To: <20200602090840.3318819-1-likun.gao@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-02T10:50:09.439Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.246.142.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ba3d4b79-30d6-4191-ea07-08d806e2b7fa
x-ms-traffictypediagnostic: BY5PR12MB4145:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4145A9EEC3784A0EE870674AA28B0@BY5PR12MB4145.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3RLyM5/VQpE1LoU4GmR4LrBvH6AbgQMieXtKPYvigadHWyWQZnT5Ct3WI04f1RpISTiRkQvGGveIp3iBVRoBn/nRZexY28lzHChxHvS7Wry0YCTqk5DpK8GR6QCl6rcodwVnwtZyPLSdSAqD7WOmGhuoL4fj9Gfa7cTv+83ruCXRn+zkym1g2bKtpPch11bexvNp7tiWf/PAoWJn8Hk6Njl7IrgZEOVOiL6Rf4xhPcaLNJTG7bdcJ1iAlOi0Epg8UFjvbqRklos6UzQowHVxlFRsG86sqzVZHaauu76p4CUylcLva2fbw4zDDO2YotAa
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4068.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(52536014)(9686003)(55016002)(53546011)(110136005)(54906003)(8676002)(7696005)(6506007)(316002)(66574014)(83380400001)(5660300002)(4326008)(30864003)(19627405001)(33656002)(66446008)(66946007)(66476007)(66556008)(64756008)(76116006)(91956017)(478600001)(86362001)(8936002)(186003)(71200400001)(2906002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: UWOJVaL1OvLv0ubyDadQyelori91uZzI/eFMFJyKaH4mfcq+lHroCUlW4gJxBCQbaH3IP52hT+pae/xnROfAqb9FOxgqAqlo1u9NJRGk9w0E6hm37oXXbB+RWmDpd7aqG54WqmWxx5lV+JEOOv0BQ5mfJuFZAkTDyCfYB0P/iwNddRBJM5y0OPtn5TBL2G+0q6AYUGgIiieT2q9dB+SsSHfSHY5+7/BPP+yScbUgXu/LK3k0Yi1IN4x9rLhzRJP8OSKvmGe+sCjMZNpnyup4+ZChuQwHFC6JXZGB5Kme10Yco9ffU7r1DF49h6Gg+lKobOMEhMpzOcC5/92TlfTlaXOIkcmqZfdSfeTOly0422PTlUC3H7LiMSENPAWWpMisuGxia6TXwphvSuDdVtdWGucmNtOOwVm3jpEkMj6WK9a2SKsfgdPKOKss6WKWiA0PIpm19nKSQSADLanuJIaTBjzxSTzEWyjpdsEydukupRo=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3d4b79-30d6-4191-ea07-08d806e2b7fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 10:50:09.0382 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzucSAmkujkLZOD9TwLXY1GTwdicRr5xuZkaGfVLkoY9T2NBq2tSBOz7hmHTlxnO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: multipart/mixed; boundary="===============0564018153=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0564018153==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB40684E08B8DC08DE99BF9B5BA28B0BY5PR12MB4068namp_"

--_000_BY5PR12MB40684E08B8DC08DE99BF9B5BA28B0BY5PR12MB4068namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin

________________________________
From: Gao, Likun <Likun.Gao@amd.com>
Sent: Tuesday, June 2, 2020 5:08 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>; W=
ang, Kevin(Yang) <Kevin1.Wang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amd/powerplay: move powerplay table operation out of s=
mu_v11_0.c

From: Likun Gao <Likun.Gao@amd.com>

move smu_v11_0_get_max_power_limit and smu_v11_0_set_thermal_range
function from smu_v11_0.c to asic specific _ppt.c to avoid powerplay
table conflict with different ASIC with smu11.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I194f44e9f59daf19fa4758ed746fa13ccece4308
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 64 ++++++++++++++++++-
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 -
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 64 ++++++++++++++++++-
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  5 ++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 63 +-----------------
 6 files changed, 135 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index 1c66b7d7139c..d5527e834a8e 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -37,6 +37,8 @@
 #include "arcturus_ppsmc.h"
 #include "nbio/nbio_7_4_offset.h"
 #include "nbio/nbio_7_4_sh_mask.h"
+#include "thm/thm_11_0_2_offset.h"
+#include "thm/thm_11_0_2_sh_mask.h"
 #include "amdgpu_xgmi.h"
 #include <linux/i2c.h>
 #include <linux/pci.h>
@@ -1324,7 +1326,7 @@ static int arcturus_get_power_limit(struct smu_contex=
t *smu,
         }

         if (cap)
-               *limit =3D smu_v11_0_get_max_power_limit(smu);
+               *limit =3D smu_get_max_power_limit(smu);
         else
                 *limit =3D smu->power_limit;

@@ -2286,6 +2288,64 @@ static int arcturus_set_df_cstate(struct smu_context=
 *smu,
         return smu_send_smc_msg_with_param(smu, SMU_MSG_DFCstateControl, s=
tate, NULL);
 }

+static int arcturus_set_thermal_range(struct smu_context *smu,
+                                      struct smu_temperature_range range)
+{
+       struct amdgpu_device *adev =3D smu->adev;
+       int low =3D SMU_THERMAL_MINIMUM_ALERT_TEMP;
+       int high =3D SMU_THERMAL_MAXIMUM_ALERT_TEMP;
+       uint32_t val;
+       struct smu_table_context *table_context =3D &smu->smu_table;
+       struct smu_11_0_powerplay_table *powerplay_table =3D table_context-=
>power_play_table;
+
+       low =3D max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
+                       range.min / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
+       high =3D min((uint16_t)SMU_THERMAL_MAXIMUM_ALERT_TEMP, powerplay_ta=
ble->software_shutdown_temp);
+
+       if (low > high)
+               return -EINVAL;
+
+       val =3D RREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL);
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1=
);
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH_MASK, 0=
);
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL_MASK, 0=
);
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (h=
igh & 0xff));
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (l=
ow & 0xff));
+       val =3D val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
+
+       WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
+
+       return 0;
+}
+
+static uint32_t atcturus_get_max_power_limit(struct smu_context *smu) {
+       uint32_t od_limit, max_power_limit;
+       struct smu_11_0_powerplay_table *powerplay_table =3D NULL;
+       struct smu_table_context *table_context =3D &smu->smu_table;
+       powerplay_table =3D table_context->power_play_table;
+
+       max_power_limit =3D smu_get_pptable_power_limit(smu);
+
+       if (!max_power_limit) {
+               // If we couldn't get the table limit, fall back on first-r=
ead value
+               if (!smu->default_power_limit)
+                       smu->default_power_limit =3D smu->power_limit;
+               max_power_limit =3D smu->default_power_limit;
+       }
+
+       if (smu->od_enabled) {
+               od_limit =3D le32_to_cpu(powerplay_table->overdrive_table.m=
ax[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+
+               pr_debug("ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", o=
d_limit, smu->default_power_limit);
+
+               max_power_limit *=3D (100 + od_limit);
+               max_power_limit /=3D 100;
+       }
+
+       return max_power_limit;
+}
+
 static const struct pptable_funcs arcturus_ppt_funcs =3D {
         /* translate smu index into arcturus specific index */
         .get_smu_msg_index =3D arcturus_get_smu_msg_index,
@@ -2379,6 +2439,8 @@ static const struct pptable_funcs arcturus_ppt_funcs =
=3D {
         .override_pcie_parameters =3D smu_v11_0_override_pcie_parameters,
         .get_pptable_power_limit =3D arcturus_get_pptable_power_limit,
         .set_df_cstate =3D arcturus_set_df_cstate,
+       .set_thermal_range =3D arcturus_set_thermal_range,
+       .get_max_power_limit =3D atcturus_get_max_power_limit,
 };

 void arcturus_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h
index 928eed220f93..0453482fb748 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -574,6 +574,8 @@ struct pptable_funcs {
         uint32_t (*get_pptable_power_limit)(struct smu_context *smu);
         int (*disable_umc_cdr_12gbps_workaround)(struct smu_context *smu);
         int (*set_power_source)(struct smu_context *smu, enum smu_power_sr=
c_type power_src);
+       int (*set_thermal_range)(struct smu_context *smu, struct smu_temper=
ature_range range);
+       uint32_t (*get_max_power_limit)(struct smu_context *smu);
 };

 int smu_load_microcode(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h
index 1f5830bbcc3e..4ad3f07891fe 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -262,8 +262,6 @@ int smu_v11_0_override_pcie_parameters(struct smu_conte=
xt *smu);

 int smu_v11_0_set_default_od_settings(struct smu_context *smu, bool initia=
lize, size_t overdrive_table_size);

-uint32_t smu_v11_0_get_max_power_limit(struct smu_context *smu);
-
 int smu_v11_0_set_performance_level(struct smu_context *smu,
                                     enum amd_dpm_forced_level level);

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index 0c9be864d072..3641f059186e 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -37,6 +37,8 @@
 #include "smu_v11_0_ppsmc.h"
 #include "nbio/nbio_2_3_offset.h"
 #include "nbio/nbio_2_3_sh_mask.h"
+#include "thm/thm_11_0_2_offset.h"
+#include "thm/thm_11_0_2_sh_mask.h"

 #include "asic_reg/mp/mp_11_0_sh_mask.h"

@@ -1841,7 +1843,7 @@ static int navi10_get_power_limit(struct smu_context =
*smu,
         }

         if (cap)
-               *limit =3D smu_v11_0_get_max_power_limit(smu);
+               *limit =3D smu_get_max_power_limit(smu);
         else
                 *limit =3D smu->power_limit;

@@ -2253,6 +2255,64 @@ static int navi10_disable_umc_cdr_12gbps_workaround(=
struct smu_context *smu)
         return navi10_dummy_pstate_control(smu, true);
 }

+static int navi10_set_thermal_range(struct smu_context *smu,
+                                      struct smu_temperature_range range)
+{
+       struct amdgpu_device *adev =3D smu->adev;
+       int low =3D SMU_THERMAL_MINIMUM_ALERT_TEMP;
+       int high =3D SMU_THERMAL_MAXIMUM_ALERT_TEMP;
+       uint32_t val;
+       struct smu_table_context *table_context =3D &smu->smu_table;
+       struct smu_11_0_powerplay_table *powerplay_table =3D table_context-=
>power_play_table;
+
+       low =3D max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
+                       range.min / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
+       high =3D min((uint16_t)SMU_THERMAL_MAXIMUM_ALERT_TEMP, powerplay_ta=
ble->software_shutdown_temp);
+
+       if (low > high)
+               return -EINVAL;
+
+       val =3D RREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL);
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1=
);
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH_MASK, 0=
);
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL_MASK, 0=
);
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (h=
igh & 0xff));
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (l=
ow & 0xff));
+       val =3D val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
+
+       WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
+
+       return 0;
+}
+
+static uint32_t navi10_get_max_power_limit(struct smu_context *smu) {
+       uint32_t od_limit, max_power_limit;
+       struct smu_11_0_powerplay_table *powerplay_table =3D NULL;
+       struct smu_table_context *table_context =3D &smu->smu_table;
+       powerplay_table =3D table_context->power_play_table;
+
+       max_power_limit =3D smu_get_pptable_power_limit(smu);
+
+       if (!max_power_limit) {
+               // If we couldn't get the table limit, fall back on first-r=
ead value
+               if (!smu->default_power_limit)
+                       smu->default_power_limit =3D smu->power_limit;
+               max_power_limit =3D smu->default_power_limit;
+       }
+
+       if (smu->od_enabled) {
+               od_limit =3D le32_to_cpu(powerplay_table->overdrive_table.m=
ax[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+
+               pr_debug("ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", o=
d_limit, smu->default_power_limit);
+
+               max_power_limit *=3D (100 + od_limit);
+               max_power_limit /=3D 100;
+       }
+
+       return max_power_limit;
+}
+
 static const struct pptable_funcs navi10_ppt_funcs =3D {
         .tables_init =3D navi10_tables_init,
         .alloc_dpm_context =3D navi10_allocate_dpm_context,
@@ -2348,6 +2408,8 @@ static const struct pptable_funcs navi10_ppt_funcs =
=3D {
         .run_btc =3D navi10_run_btc,
         .disable_umc_cdr_12gbps_workaround =3D navi10_disable_umc_cdr_12gb=
ps_workaround,
         .set_power_source =3D smu_v11_0_set_power_source,
+       .set_thermal_range =3D navi10_set_thermal_range,
+       .get_max_power_limit =3D navi10_get_max_power_limit,
 };

 void navi10_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm=
/amd/powerplay/smu_internal.h
index c97444841abc..093b63d405e5 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -208,6 +208,11 @@ static inline int smu_send_smc_msg(struct smu_context =
*smu, enum smu_message_typ
 #define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap) \
                 ((smu)->ppt_funcs->update_pcie_parameters ? (smu)->ppt_fun=
cs->update_pcie_parameters((smu), (pcie_gen_cap), (pcie_width_cap)) : 0)

+#define smu_set_thermal_range(smu, range) \
+               ((smu)->ppt_funcs->set_thermal_range ? (smu)->ppt_funcs->se=
t_thermal_range((smu), (range)) : 0)
+#define smu_get_max_power_limit(smu) \
+               ((smu)->ppt_funcs->get_max_power_limit ? (smu)->ppt_funcs->=
get_max_power_limit((smu)) : 0)
+
 #define smu_disable_umc_cdr_12gbps_workaround(smu) \
         ((smu)->ppt_funcs->disable_umc_cdr_12gbps_workaround ? (smu)->ppt_=
funcs->disable_umc_cdr_12gbps_workaround((smu)) : 0)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c
index 4c2d98becc16..5133110dc5c8 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -32,7 +32,6 @@
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
 #include "smu_v11_0.h"
-#include "smu_v11_0_pptable.h"
 #include "soc15_common.h"
 #include "atom.h"
 #include "amd_pcie.h"
@@ -1093,33 +1092,6 @@ int smu_v11_0_init_max_sustainable_clocks(struct smu=
_context *smu)
         return 0;
 }

-uint32_t smu_v11_0_get_max_power_limit(struct smu_context *smu) {
-       uint32_t od_limit, max_power_limit;
-       struct smu_11_0_powerplay_table *powerplay_table =3D NULL;
-       struct smu_table_context *table_context =3D &smu->smu_table;
-       powerplay_table =3D table_context->power_play_table;
-
-       max_power_limit =3D smu_get_pptable_power_limit(smu);
-
-       if (!max_power_limit) {
-               // If we couldn't get the table limit, fall back on first-r=
ead value
-               if (!smu->default_power_limit)
-                       smu->default_power_limit =3D smu->power_limit;
-               max_power_limit =3D smu->default_power_limit;
-       }
-
-       if (smu->od_enabled) {
-               od_limit =3D le32_to_cpu(powerplay_table->overdrive_table.m=
ax[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-
-               pr_debug("ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", o=
d_limit, smu->default_power_limit);
-
-               max_power_limit *=3D (100 + od_limit);
-               max_power_limit /=3D 100;
-       }
-
-       return max_power_limit;
-}
-
 int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 {
         int ret =3D 0;
@@ -1128,7 +1100,7 @@ int smu_v11_0_set_power_limit(struct smu_context *smu=
, uint32_t n)
         if (amdgpu_sriov_vf(smu->adev))
                 return 0;

-       max_power_limit =3D smu_v11_0_get_max_power_limit(smu);
+       max_power_limit =3D smu_get_max_power_limit(smu);

         if (n > max_power_limit) {
                 pr_err("New power limit (%d) is over the max allowed %d\n"=
,
@@ -1186,37 +1158,6 @@ int smu_v11_0_get_current_clk_freq(struct smu_contex=
t *smu,
         return ret;
 }

-static int smu_v11_0_set_thermal_range(struct smu_context *smu,
-                                      struct smu_temperature_range range)
-{
-       struct amdgpu_device *adev =3D smu->adev;
-       int low =3D SMU_THERMAL_MINIMUM_ALERT_TEMP;
-       int high =3D SMU_THERMAL_MAXIMUM_ALERT_TEMP;
-       uint32_t val;
-       struct smu_table_context *table_context =3D &smu->smu_table;
-       struct smu_11_0_powerplay_table *powerplay_table =3D table_context-=
>power_play_table;
-
-       low =3D max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
-                       range.min / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
-       high =3D min((uint16_t)SMU_THERMAL_MAXIMUM_ALERT_TEMP, powerplay_ta=
ble->software_shutdown_temp);
-
-       if (low > high)
-               return -EINVAL;
-
-       val =3D RREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL);
-       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
-       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1=
);
-       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH_MASK, 0=
);
-       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL_MASK, 0=
);
-       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (h=
igh & 0xff));
-       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (l=
ow & 0xff));
-       val =3D val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
-
-       WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
-
-       return 0;
-}
-
 static int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
 {
         struct amdgpu_device *adev =3D smu->adev;
@@ -1244,7 +1185,7 @@ int smu_v11_0_start_thermal_control(struct smu_contex=
t *smu)
                 return ret;

         if (smu->smu_table.thermal_controller_type) {
-               ret =3D smu_v11_0_set_thermal_range(smu, range);
+               ret =3D smu_set_thermal_range(smu, range);
                 if (ret)
                         return ret;

--
2.25.1


--_000_BY5PR12MB40684E08B8DC08DE99BF9B5BA28B0BY5PR12MB4068namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,<br>
Kevin</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Gao, Likun &lt;Likun.=
Gao@amd.com&gt;<br>
<b>Sent:</b> Tuesday, June 2, 2020 5:08 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Quan, Evan &lt;Evan.=
Quan@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; Gao, Likun=
 &lt;Likun.Gao@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: move powerplay table operation o=
ut of smu_v11_0.c</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">From: Likun Gao &lt;Likun.Gao@amd.com&gt;<br>
<br>
move smu_v11_0_get_max_power_limit and smu_v11_0_set_thermal_range<br>
function from smu_v11_0.c to asic specific _ppt.c to avoid powerplay<br>
table conflict with different ASIC with smu11.<br>
<br>
Signed-off-by: Likun Gao &lt;Likun.Gao@amd.com&gt;<br>
Change-Id: I194f44e9f59daf19fa4758ed746fa13ccece4308<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/arcturus_ppt.c&nbsp; | 64 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;-<br>
&nbsp;.../gpu/drm/amd/powerplay/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp; |&nbsp; =
2 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |&nbsp; 2 -<br>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp;&nbsp; | 64 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_internal.h&nbsp; |&nbsp; 5 &#43;&#4=
3;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp; | 6=
3 &#43;-----------------<br>
&nbsp;6 files changed, 135 insertions(&#43;), 65 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c<br>
index 1c66b7d7139c..d5527e834a8e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
@@ -37,6 &#43;37,8 @@<br>
&nbsp;#include &quot;arcturus_ppsmc.h&quot;<br>
&nbsp;#include &quot;nbio/nbio_7_4_offset.h&quot;<br>
&nbsp;#include &quot;nbio/nbio_7_4_sh_mask.h&quot;<br>
&#43;#include &quot;thm/thm_11_0_2_offset.h&quot;<br>
&#43;#include &quot;thm/thm_11_0_2_sh_mask.h&quot;<br>
&nbsp;#include &quot;amdgpu_xgmi.h&quot;<br>
&nbsp;#include &lt;linux/i2c.h&gt;<br>
&nbsp;#include &lt;linux/pci.h&gt;<br>
@@ -1324,7 &#43;1326,7 @@ static int arcturus_get_power_limit(struct smu_co=
ntext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cap)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *limit =3D smu_v11_0_get_max_power_limit(smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *limit =3D smu_get_max_power_limit(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *limit =3D smu-&gt;power_limit;<br>
&nbsp;<br>
@@ -2286,6 &#43;2288,64 @@ static int arcturus_set_df_cstate(struct smu_con=
text *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_send_smc_msg_wi=
th_param(smu, SMU_MSG_DFCstateControl, state, NULL);<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int arcturus_set_thermal_range(struct smu_context *smu,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; struct smu_temperature_range range)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D sm=
u-&gt;adev;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int low =3D SMU_THERMAL_MINIMUM_A=
LERT_TEMP;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int high =3D SMU_THERMAL_MAXIMUM_=
ALERT_TEMP;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_c=
ontext =3D &amp;smu-&gt;smu_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_11_0_powerplay_table *=
powerplay_table =3D table_context-&gt;power_play_table;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; low =3D max(SMU_THERMAL_MINIMUM_A=
LERT_TEMP,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range.min / =
SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; high =3D min((uint16_t)SMU_THERMA=
L_MAXIMUM_ALERT_TEMP, powerplay_table-&gt;software_shutdown_temp);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (low &gt; high)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D RREG32_SOC15(THM, 0, mmTH=
M_THERMAL_INT_CTRL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, MAX_IH_CREDIT, 5);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, THERM_INTH_MASK, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, THERM_INTL_MASK, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, DIG_THERM_INTH, (high &amp; 0xff));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, DIG_THERM_INTL, (low &amp; 0xff));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D val &amp; (~THM_THERMAL_I=
NT_CTRL__THERM_TRIGGER_MASK_MASK);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmTHM_THERMA=
L_INT_CTRL, val);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;static uint32_t atcturus_get_max_power_limit(struct smu_context *smu) =
{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t od_limit, max_power_limi=
t;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_11_0_powerplay_table *=
powerplay_table =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_c=
ontext =3D &amp;smu-&gt;smu_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; powerplay_table =3D table_context=
-&gt;power_play_table;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_power_limit =3D smu_get_pptab=
le_power_limit(smu);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!max_power_limit) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; // If we couldn't get the table limit, fall back on first-re=
ad value<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!smu-&gt;default_power_limit)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;defa=
ult_power_limit =3D smu-&gt;power_limit;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; max_power_limit =3D smu-&gt;default_power_limit;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;od_enabled) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; od_limit =3D le32_to_cpu(powerplay_table-&gt;overdrive_table=
.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_debug(&quot;ODSETTING_POWERPERCENTAGE: %d (default: %d)\n=
&quot;, od_limit, smu-&gt;default_power_limit);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; max_power_limit *=3D (100 &#43; od_limit);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; max_power_limit /=3D 100;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return max_power_limit;<br>
&#43;}<br>
&#43;<br>
&nbsp;static const struct pptable_funcs arcturus_ppt_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* translate smu index int=
o arcturus specific index */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_smu_msg_index =3D arc=
turus_get_smu_msg_index,<br>
@@ -2379,6 &#43;2439,8 @@ static const struct pptable_funcs arcturus_ppt_fu=
ncs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .override_pcie_parameters =
=3D smu_v11_0_override_pcie_parameters,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pptable_power_limit =
=3D arcturus_get_pptable_power_limit,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_df_cstate =3D arcturu=
s_set_df_cstate,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_thermal_range =3D arcturus_s=
et_thermal_range,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_max_power_limit =3D atcturus=
_get_max_power_limit,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;void arcturus_set_ppt_funcs(struct smu_context *smu)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h<br>
index 928eed220f93..0453482fb748 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
@@ -574,6 &#43;574,8 @@ struct pptable_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t (*get_pptable_pow=
er_limit)(struct smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*disable_umc_cdr_12gb=
ps_workaround)(struct smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_power_source)(st=
ruct smu_context *smu, enum smu_power_src_type power_src);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_thermal_range)(struct s=
mu_context *smu, struct smu_temperature_range range);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t (*get_max_power_limit)(s=
truct smu_context *smu);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;int smu_load_microcode(struct smu_context *smu);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h<br>
index 1f5830bbcc3e..4ad3f07891fe 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
@@ -262,8 &#43;262,6 @@ int smu_v11_0_override_pcie_parameters(struct smu_c=
ontext *smu);<br>
&nbsp;<br>
&nbsp;int smu_v11_0_set_default_od_settings(struct smu_context *smu, bool i=
nitialize, size_t overdrive_table_size);<br>
&nbsp;<br>
-uint32_t smu_v11_0_get_max_power_limit(struct smu_context *smu);<br>
-<br>
&nbsp;int smu_v11_0_set_performance_level(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd=
_dpm_forced_level level);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index 0c9be864d072..3641f059186e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -37,6 &#43;37,8 @@<br>
&nbsp;#include &quot;smu_v11_0_ppsmc.h&quot;<br>
&nbsp;#include &quot;nbio/nbio_2_3_offset.h&quot;<br>
&nbsp;#include &quot;nbio/nbio_2_3_sh_mask.h&quot;<br>
&#43;#include &quot;thm/thm_11_0_2_offset.h&quot;<br>
&#43;#include &quot;thm/thm_11_0_2_sh_mask.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;asic_reg/mp/mp_11_0_sh_mask.h&quot;<br>
&nbsp;<br>
@@ -1841,7 &#43;1843,7 @@ static int navi10_get_power_limit(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cap)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *limit =3D smu_v11_0_get_max_power_limit(smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *limit =3D smu_get_max_power_limit(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *limit =3D smu-&gt;power_limit;<br>
&nbsp;<br>
@@ -2253,6 &#43;2255,64 @@ static int navi10_disable_umc_cdr_12gbps_workaro=
und(struct smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return navi10_dummy_pstate=
_control(smu, true);<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int navi10_set_thermal_range(struct smu_context *smu,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; struct smu_temperature_range range)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D sm=
u-&gt;adev;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int low =3D SMU_THERMAL_MINIMUM_A=
LERT_TEMP;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int high =3D SMU_THERMAL_MAXIMUM_=
ALERT_TEMP;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_c=
ontext =3D &amp;smu-&gt;smu_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_11_0_powerplay_table *=
powerplay_table =3D table_context-&gt;power_play_table;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; low =3D max(SMU_THERMAL_MINIMUM_A=
LERT_TEMP,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range.min / =
SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; high =3D min((uint16_t)SMU_THERMA=
L_MAXIMUM_ALERT_TEMP, powerplay_table-&gt;software_shutdown_temp);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (low &gt; high)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D RREG32_SOC15(THM, 0, mmTH=
M_THERMAL_INT_CTRL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, MAX_IH_CREDIT, 5);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, THERM_INTH_MASK, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, THERM_INTL_MASK, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, DIG_THERM_INTH, (high &amp; 0xff));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, DIG_THERM_INTL, (low &amp; 0xff));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D val &amp; (~THM_THERMAL_I=
NT_CTRL__THERM_TRIGGER_MASK_MASK);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmTHM_THERMA=
L_INT_CTRL, val);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;static uint32_t navi10_get_max_power_limit(struct smu_context *smu) {<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t od_limit, max_power_limi=
t;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_11_0_powerplay_table *=
powerplay_table =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_c=
ontext =3D &amp;smu-&gt;smu_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; powerplay_table =3D table_context=
-&gt;power_play_table;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_power_limit =3D smu_get_pptab=
le_power_limit(smu);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!max_power_limit) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; // If we couldn't get the table limit, fall back on first-re=
ad value<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!smu-&gt;default_power_limit)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;defa=
ult_power_limit =3D smu-&gt;power_limit;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; max_power_limit =3D smu-&gt;default_power_limit;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;od_enabled) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; od_limit =3D le32_to_cpu(powerplay_table-&gt;overdrive_table=
.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_debug(&quot;ODSETTING_POWERPERCENTAGE: %d (default: %d)\n=
&quot;, od_limit, smu-&gt;default_power_limit);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; max_power_limit *=3D (100 &#43; od_limit);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; max_power_limit /=3D 100;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return max_power_limit;<br>
&#43;}<br>
&#43;<br>
&nbsp;static const struct pptable_funcs navi10_ppt_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .tables_init =3D navi10_ta=
bles_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .alloc_dpm_context =3D nav=
i10_allocate_dpm_context,<br>
@@ -2348,6 &#43;2408,8 @@ static const struct pptable_funcs navi10_ppt_func=
s =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .run_btc =3D navi10_run_bt=
c,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_umc_cdr_12gbps_wo=
rkaround =3D navi10_disable_umc_cdr_12gbps_workaround,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_source =3D smu_=
v11_0_set_power_source,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_thermal_range =3D navi10_set=
_thermal_range,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_max_power_limit =3D navi10_g=
et_max_power_limit,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;void navi10_set_ppt_funcs(struct smu_context *smu)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm=
/amd/powerplay/smu_internal.h<br>
index c97444841abc..093b63d405e5 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_internal.h<br>
@@ -208,6 &#43;208,11 @@ static inline int smu_send_smc_msg(struct smu_cont=
ext *smu, enum smu_message_typ<br>
&nbsp;#define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap)=
 \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;update_pcie_parameters ? (sm=
u)-&gt;ppt_funcs-&gt;update_pcie_parameters((smu), (pcie_gen_cap), (pcie_wi=
dth_cap)) : 0)<br>
&nbsp;<br>
&#43;#define smu_set_thermal_range(smu, range) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;set_thermal_range ? (smu)-&gt;ppt_f=
uncs-&gt;set_thermal_range((smu), (range)) : 0)<br>
&#43;#define smu_get_max_power_limit(smu) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;get_max_power_limit ? (smu)-&gt;ppt=
_funcs-&gt;get_max_power_limit((smu)) : 0)<br>
&#43;<br>
&nbsp;#define smu_disable_umc_cdr_12gbps_workaround(smu) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;d=
isable_umc_cdr_12gbps_workaround ? (smu)-&gt;ppt_funcs-&gt;disable_umc_cdr_=
12gbps_workaround((smu)) : 0)<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c<br>
index 4c2d98becc16..5133110dc5c8 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -32,7 &#43;32,6 @@<br>
&nbsp;#include &quot;atomfirmware.h&quot;<br>
&nbsp;#include &quot;amdgpu_atomfirmware.h&quot;<br>
&nbsp;#include &quot;smu_v11_0.h&quot;<br>
-#include &quot;smu_v11_0_pptable.h&quot;<br>
&nbsp;#include &quot;soc15_common.h&quot;<br>
&nbsp;#include &quot;atom.h&quot;<br>
&nbsp;#include &quot;amd_pcie.h&quot;<br>
@@ -1093,33 &#43;1092,6 @@ int smu_v11_0_init_max_sustainable_clocks(struct=
 smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-uint32_t smu_v11_0_get_max_power_limit(struct smu_context *smu) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t od_limit, max_power_limit;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_11_0_powerplay_table *powe=
rplay_table =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_conte=
xt =3D &amp;smu-&gt;smu_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; powerplay_table =3D table_context-&gt=
;power_play_table;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_power_limit =3D smu_get_pptable_p=
ower_limit(smu);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!max_power_limit) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; // If we couldn't get the table limit, fall back on first-read v=
alue<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!smu-&gt;default_power_limit)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;default_=
power_limit =3D smu-&gt;power_limit;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; max_power_limit =3D smu-&gt;default_power_limit;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;od_enabled) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; od_limit =3D le32_to_cpu(powerplay_table-&gt;overdrive_table.max=
[SMU_11_0_ODSETTING_POWERPERCENTAGE]);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_debug(&quot;ODSETTING_POWERPERCENTAGE: %d (default: %d)\n&quo=
t;, od_limit, smu-&gt;default_power_limit);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; max_power_limit *=3D (100 &#43; od_limit);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; max_power_limit /=3D 100;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return max_power_limit;<br>
-}<br>
-<br>
&nbsp;int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)<br=
>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -1128,7 &#43;1100,7 @@ int smu_v11_0_set_power_limit(struct smu_context =
*smu, uint32_t n)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(smu-&g=
t;adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_power_limit =3D smu_v11_0_get_max=
_power_limit(smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_power_limit =3D smu_get_max_p=
ower_limit(smu);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (n &gt; max_power_limit=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_err(&quot;New power limit (%d) is over the max all=
owed %d\n&quot;,<br>
@@ -1186,37 &#43;1158,6 @@ int smu_v11_0_get_current_clk_freq(struct smu_co=
ntext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-static int smu_v11_0_set_thermal_range(struct smu_context *smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct smu_temperature_range range)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int low =3D SMU_THERMAL_MINIMUM_ALERT=
_TEMP;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int high =3D SMU_THERMAL_MAXIMUM_ALER=
T_TEMP;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_conte=
xt =3D &amp;smu-&gt;smu_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_11_0_powerplay_table *powe=
rplay_table =3D table_context-&gt;power_play_table;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; low =3D max(SMU_THERMAL_MINIMUM_ALERT=
_TEMP,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range.min / SMU_=
TEMPERATURE_UNITS_PER_CENTIGRADES);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; high =3D min((uint16_t)SMU_THERMAL_MA=
XIMUM_ALERT_TEMP, powerplay_table-&gt;software_shutdown_temp);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (low &gt; high)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D RREG32_SOC15(THM, 0, mmTHM_TH=
ERMAL_INT_CTRL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_THERMA=
L_INT_CTRL, MAX_IH_CREDIT, 5);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_THERMA=
L_INT_CTRL, THERM_IH_HW_ENA, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_THERMA=
L_INT_CTRL, THERM_INTH_MASK, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_THERMA=
L_INT_CTRL, THERM_INTL_MASK, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_THERMA=
L_INT_CTRL, DIG_THERM_INTH, (high &amp; 0xff));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_THERMA=
L_INT_CTRL, DIG_THERM_INTL, (low &amp; 0xff));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D val &amp; (~THM_THERMAL_INT_C=
TRL__THERM_TRIGGER_MASK_MASK);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmTHM_THERMAL_IN=
T_CTRL, val);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static int smu_v11_0_enable_thermal_alert(struct smu_context *smu)<br=
>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
@@ -1244,7 &#43;1185,7 @@ int smu_v11_0_start_thermal_control(struct smu_co=
ntext *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;smu_table.ther=
mal_controller_type) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_v11_0_set_thermal_range(smu, range);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_set_thermal_range(smu, range);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR12MB40684E08B8DC08DE99BF9B5BA28B0BY5PR12MB4068namp_--

--===============0564018153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0564018153==--
