Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144C3C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 06:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D601A20818
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 06:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D601A20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 665656E130;
	Mon, 11 Nov 2019 06:34:32 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730043.outbound.protection.outlook.com [40.107.73.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DF606E130
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 06:34:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iD3C4cW6nbhjZUFPD8GlYX6SbhJ4sifzR7BLCe5gW6cFz5H8eQaH0IlKf4UQJlpP0LPTd4DuJH0MNXoRX5R7+c8l5Z3QMS5ZbzywigX99opF1mYeLTeGfcsqdo/yMtlDqRfjrsZU5rNNmYNvwADN6UfaehFxprqndUcupPlxbhthuXDSNW5N8xOHv6vt2D8bhgUj+Zke8oCWUAQSWr6U0hYm8fTXri8Nz3x0cCbAyW7ltygZc5bCTeZC54+jZmJ9JSMwkyJdOmiqR1mD0dHiUjl8fO/CV4QQQnE8N1bVSwFqzhZR8olQCjnQQIS6V5h70kLEJOW9KiYof0Hk/3ZwFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aLvAVoc+hl0dbAo3Z0qV++GPXYbwkFXkdm+CCqQJSs=;
 b=HNsNqxTDZzBuA41gGs6usgwjUwn3i/40WfwYt5Ng/7TXD8aHDV9921WiKT1npKZOj8FJeUCy6YGZTZ5THq+y5WbOBTmAvtahGSFkDxcpIjuGyrmfGoFHPPg8MteCuMOWEctj501ucrSjNvZmb14e7s0fIgfWEIzhqbcZEf0IYy9bTWD2Qq76fo3VcOeKeewmYokUR1b5Ic0QvOX5o6ROqsvT4lzn1+r9lKgP5WU4AORcGD1WhlV6RX81B86M+jdWdit9NgtWgG7ClIdHybnTRFurPWgLPl9t1jW245UwZEGZxXUEJbP5esXJwkpU1dMy3HJ9M+zOUB7oUyijbFHH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3983.namprd12.prod.outlook.com (10.255.238.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Mon, 11 Nov 2019 06:34:27 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::111:5294:f151:3846]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::111:5294:f151:3846%7]) with mapi id 15.20.2430.023; Mon, 11 Nov 2019
 06:34:27 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/powerplay: dynamically disable ds and ulv for
 compute
Thread-Topic: [PATCH v2] drm/amd/powerplay: dynamically disable ds and ulv for
 compute
Thread-Index: AQHVlfdgsieb5wqXckyUshndqOwiO6eBWigAgAQsPpA=
Date: Mon, 11 Nov 2019 06:34:27 +0000
Message-ID:
 <MN2PR12MB3598E632B3CC0520FB24B08B8E740@MN2PR12MB3598.namprd12.prod.outlook.com>
References: <1573191771-8071-1-git-send-email-kenneth.feng@amd.com>
 <DM5PR12MB18204B23450D8B0E427E4C8AF77B0@DM5PR12MB1820.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB18204B23450D8B0E427E4C8AF77B0@DM5PR12MB1820.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 982a91bf-de95-4279-4f28-08d76671336b
x-ms-traffictypediagnostic: MN2PR12MB3983:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3983C0CE6D5173A6CB7451778E740@MN2PR12MB3983.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(199004)(189003)(66066001)(99286004)(74316002)(446003)(229853002)(7736002)(55016002)(6306002)(476003)(11346002)(54896002)(9686003)(236005)(966005)(6436002)(2906002)(33656002)(256004)(606006)(14444005)(110136005)(316002)(790700001)(14454004)(6116002)(2501003)(3846002)(486006)(86362001)(71200400001)(71190400001)(6506007)(9326002)(53546011)(81166006)(66946007)(76176011)(26005)(76116006)(66446008)(66556008)(64756008)(66476007)(7696005)(81156014)(186003)(6246003)(102836004)(52536014)(8936002)(8676002)(478600001)(25786009)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3983;
 H:MN2PR12MB3598.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O+zMmJhMJnuX8hSgk27K8Dj60IwBbyb9coA7zJOjdrIdhCI1pMdpkvLiR19Un/Zp64GOczzrPTfVPMIb72I9JCxt/gjMIBKHigyEttwM/xBMr/mdMAYCM8qICqBW0SK6NnneUOHFynrb3TcQLvdvMTc0ZimzMfKo9K2iQnfevddpvS3dK765HUz02YcDSa30JwNS3pUAqABV9AGur3gl4dB0YT9hJ+nnSxbjzXElzbVFGFV96rAMRQg4tsTt6KVswuacwQ4Swslnu7AFG7P5ejdReH5LdgEfO2nhG9Xah9CXBpjlBeDf9jaga4f7TZw8gpygl1VRuQ/5dc/h333ru44iA8Rp7vOhryaQlYv+EKXAWgym2F8tVcBd8sHB6VyUz+qI6Z9mKaUbTFPTLtesVlABTW0NGOHDIzMzxbJOnwrPoiW+UOa5aApAzOsD36CCcQTHr0DJ4ClJBAAqW/jKsuUdQV/vnUGzh0zleEtTEmk=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982a91bf-de95-4279-4f28-08d76671336b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 06:34:27.4953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rs085unzb0NWMH86+fq9ONUEYn1Mon3dS1lHgrmJ3SozNo8JgjykH+o1+nqmTKde
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3983
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aLvAVoc+hl0dbAo3Z0qV++GPXYbwkFXkdm+CCqQJSs=;
 b=z0gb2HKPeBTGaMFTCVmR+xB4BU8OY7MotLgk8RWw9xBU1iX1k95hKWXZowaoknsgDJFBea5cMhRmzBIdhrWr+sAteMDpLSqCVTP1w/eXCFlB04eBY707x4abYIyEYR7a8qRZYgvoUR9DT5LVA+jq5lsou+UuUBIwY/s1qvtD4DY=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kenneth.Feng@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0242833439=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111063427.JaNmbZxsQcSJ8Up_4zc6KES8zKXwJE0bW3fqjf9chF0@z>

--===============0242833439==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3598E632B3CC0520FB24B08B8E740MN2PR12MB3598namp_"

--_000_MN2PR12MB3598E632B3CC0520FB24B08B8E740MN2PR12MB3598namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Alex,
We have confirmed that the performance on Vega20 in the compute mode is exp=
ected and doesn't need the similar change.
This is because that  by default on Vega20 all the deep sleep features are =
disabled, and ulv feature doesn't involve reducing mclk in Vega20
while it does in Vega10.
We then need this change on MI100/MI200 since these deep sleep features are=
 enabled by default.
Thanks.


From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, November 8, 2019 10:45 PM
To: Feng, Kenneth <Kenneth.Feng@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/amd/powerplay: dynamically disable ds and ulv f=
or compute

Do we need something similar for vega20?

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Kenneth Feng <kenneth.feng@amd.com<ma=
ilto:kenneth.feng@amd.com>>
Sent: Friday, November 8, 2019 12:42 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com<mailto:Kenneth.Feng@amd.com>>
Subject: [PATCH v2] drm/amd/powerplay: dynamically disable ds and ulv for c=
ompute

This is to improve the performance in the compute mode
for vega10. For example, the original performance for a rocm
bandwidth test: 2G internal GPU copy, is about 99GB/s.
With the idle power features disabled dynamically, the porformance
is promoted to about 215GB/s.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com<mailto:kenneth.feng@amd.c=
om>>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      |  7 +++
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 55 ++++++++++++++++++=
++++
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |  2 +
 3 files changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c
index 0314476..bd35f65 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -969,6 +969,13 @@ static int pp_dpm_switch_power_profile(void *handle,
                 workload =3D hwmgr->workload_setting[index];
         }

+       if (type =3D=3D PP_SMC_POWER_PROFILE_COMPUTE &&
+               hwmgr->hwmgr_func->disable_power_features_for_compute_perfo=
rmance)
+                       if (hwmgr->hwmgr_func->disable_power_features_for_c=
ompute_performance(hwmgr, en)) {
+                               mutex_unlock(&hwmgr->smu_lock);
+                               return -EINVAL;
+                       }
+
         if (hwmgr->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL)
                 hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, &workload=
, 0);
         mutex_unlock(&hwmgr->smu_lock);
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 4ea63a2..d3229c2 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -5263,6 +5263,59 @@ static int vega10_get_performance_level(struct pp_hw=
mgr *hwmgr, const struct pp_
         return 0;
 }

+static int vega10_disable_power_features_for_compute_performance(struct pp=
_hwmgr *hwmgr, bool disable)
+{
+       struct vega10_hwmgr *data =3D hwmgr->backend;
+       uint32_t feature_mask =3D 0;
+
+       if (disable) {
+               feature_mask |=3D data->smu_features[GNLD_ULV].enabled ?
+                       data->smu_features[GNLD_ULV].smu_feature_bitmap : 0=
;
+               feature_mask |=3D data->smu_features[GNLD_DS_GFXCLK].enable=
d ?
+                       data->smu_features[GNLD_DS_GFXCLK].smu_feature_bitm=
ap : 0;
+               feature_mask |=3D data->smu_features[GNLD_DS_SOCCLK].enable=
d ?
+                       data->smu_features[GNLD_DS_SOCCLK].smu_feature_bitm=
ap : 0;
+               feature_mask |=3D data->smu_features[GNLD_DS_LCLK].enabled =
?
+                       data->smu_features[GNLD_DS_LCLK].smu_feature_bitmap=
 : 0;
+               feature_mask |=3D data->smu_features[GNLD_DS_DCEFCLK].enabl=
ed ?
+                       data->smu_features[GNLD_DS_DCEFCLK].smu_feature_bit=
map : 0;
+       } else {
+               feature_mask |=3D (!data->smu_features[GNLD_ULV].enabled) ?
+                       data->smu_features[GNLD_ULV].smu_feature_bitmap : 0=
;
+               feature_mask |=3D (!data->smu_features[GNLD_DS_GFXCLK].enab=
led) ?
+                       data->smu_features[GNLD_DS_GFXCLK].smu_feature_bitm=
ap : 0;
+               feature_mask |=3D (!data->smu_features[GNLD_DS_SOCCLK].enab=
led) ?
+                       data->smu_features[GNLD_DS_SOCCLK].smu_feature_bitm=
ap : 0;
+               feature_mask |=3D (!data->smu_features[GNLD_DS_LCLK].enable=
d) ?
+                       data->smu_features[GNLD_DS_LCLK].smu_feature_bitmap=
 : 0;
+               feature_mask |=3D (!data->smu_features[GNLD_DS_DCEFCLK].ena=
bled) ?
+                       data->smu_features[GNLD_DS_DCEFCLK].smu_feature_bit=
map : 0;
+       }
+
+       if (feature_mask)
+               PP_ASSERT_WITH_CODE(!vega10_enable_smc_features(hwmgr,
+                               !disable, feature_mask),
+                               "enable/disable power features for compute =
performance Failed!",
+                               return -EINVAL);
+
+       if (disable) {
+               data->smu_features[GNLD_ULV].enabled =3D false;
+               data->smu_features[GNLD_DS_GFXCLK].enabled =3D false;
+               data->smu_features[GNLD_DS_SOCCLK].enabled =3D false;
+               data->smu_features[GNLD_DS_LCLK].enabled =3D false;
+               data->smu_features[GNLD_DS_DCEFCLK].enabled =3D false;
+       } else {
+               data->smu_features[GNLD_ULV].enabled =3D true;
+               data->smu_features[GNLD_DS_GFXCLK].enabled =3D true;
+               data->smu_features[GNLD_DS_SOCCLK].enabled =3D true;
+               data->smu_features[GNLD_DS_LCLK].enabled =3D true;
+               data->smu_features[GNLD_DS_DCEFCLK].enabled =3D true;
+       }
+
+       return 0;
+
+}
+
 static const struct pp_hwmgr_func vega10_hwmgr_funcs =3D {
         .backend_init =3D vega10_hwmgr_backend_init,
         .backend_fini =3D vega10_hwmgr_backend_fini,
@@ -5330,6 +5383,8 @@ static const struct pp_hwmgr_func vega10_hwmgr_funcs =
=3D {
         .get_ppfeature_status =3D vega10_get_ppfeature_status,
         .set_ppfeature_status =3D vega10_set_ppfeature_status,
         .set_mp1_state =3D vega10_set_mp1_state,
+       .disable_power_features_for_compute_performance =3D
+                       vega10_disable_power_features_for_compute_performan=
ce,
 };

 int vega10_hwmgr_init(struct pp_hwmgr *hwmgr)
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h
index 40403bc..af97767 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -357,6 +357,8 @@ struct pp_hwmgr_func {
         int (*smu_i2c_bus_access)(struct pp_hwmgr *hwmgr, bool aquire);
         int (*set_df_cstate)(struct pp_hwmgr *hwmgr, enum pp_df_cstate sta=
te);
         int (*set_xgmi_pstate)(struct pp_hwmgr *hwmgr, uint32_t pstate);
+       int (*disable_power_features_for_compute_performance)(struct pp_hwm=
gr *hwmgr,
+                                       bool disable);
 };

 struct pp_table_func {
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB3598E632B3CC0520FB24B08B8E740MN2PR12MB3598namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Alex,<o:p></o:p></p>
<p class=3D"MsoNormal">We have confirmed that the performance on Vega20 in =
the compute mode is expected and doesn&#8217;t need the similar change.<o:p=
></o:p></p>
<p class=3D"MsoNormal">This is because that &nbsp;by default on Vega20 all =
the deep sleep features are disabled, and ulv feature doesn&#8217;t involve=
 reducing mclk in Vega20
<o:p></o:p></p>
<p class=3D"MsoNormal">while it does in Vega10. <o:p></o:p></p>
<p class=3D"MsoNormal">We then need this change on MI100/MI200 since these =
deep sleep features are enabled by default.<o:p></o:p></p>
<p class=3D"MsoNormal">Thanks.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Friday, November 8, 2019 10:45 PM<br>
<b>To:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Subject:</b> Re: [PATCH v2] drm/amd/powerplay: dynamically disable ds an=
d ulv for compute<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Do we n=
eed something similar for vega20?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Kenneth Feng &lt;<a href=3D"mailto:kenneth.feng@amd.com">kenneth.feng@amd=
.com</a>&gt;<br>
<b>Sent:</b> Friday, November 8, 2019 12:42 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;<a href=3D"mailto:Kenneth.Feng@amd.com">Kennet=
h.Feng@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amd/powerplay: dynamically disable ds and ul=
v for compute</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">This is to improve the performance in the compute mo=
de<br>
for vega10. For example, the original performance for a rocm<br>
bandwidth test: 2G internal GPU copy, is about 99GB/s.<br>
With the idle power features disabled dynamically, the porformance<br>
is promoted to about 215GB/s.<br>
<br>
Signed-off-by: Kenneth Feng &lt;<a href=3D"mailto:kenneth.feng@amd.com">ken=
neth.feng@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amd_powerplay.c&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 7 &#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 55 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#43;<br>
&nbsp;3 files changed, 64 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c<br>
index 0314476..bd35f65 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
@@ -969,6 &#43;969,13 @@ static int pp_dpm_switch_power_profile(void *handl=
e,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; workload =3D hwmgr-&gt;workload_setting[index];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (type =3D=3D PP_SMC_POWER_PROF=
ILE_COMPUTE &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;disable_power_features_for_compute_=
performance)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&g=
t;hwmgr_func-&gt;disable_power_features_for_compute_performance(hwmgr, en))=
 {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&gt;smu_lock);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level !=
=3D AMD_DPM_FORCED_LEVEL_MANUAL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;set_power_profile_mode(hwmgr=
, &amp;workload, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&g=
t;smu_lock);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
index 4ea63a2..d3229c2 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
@@ -5263,6 &#43;5263,59 @@ static int vega10_get_performance_level(struct p=
p_hwmgr *hwmgr, const struct pp_<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int vega10_disable_power_features_for_compute_performance(struc=
t pp_hwmgr *hwmgr, bool disable)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_hwmgr *data =3D hwm=
gr-&gt;backend;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_mask =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (disable) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D data-&gt;smu_features[GNLD_ULV].enabled ?<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_ULV].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D data-&gt;smu_features[GNLD_DS_GFXCLK].enab=
led ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_GFXCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D data-&gt;smu_features[GNLD_DS_SOCCLK].enab=
led ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_SOCCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D data-&gt;smu_features[GNLD_DS_LCLK].enable=
d ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_LCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D data-&gt;smu_features[GNLD_DS_DCEFCLK].ena=
bled ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_DCEFCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D (!data-&gt;smu_features[GNLD_ULV].enabled)=
 ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_ULV].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D (!data-&gt;smu_features[GNLD_DS_GFXCLK].en=
abled) ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_GFXCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D (!data-&gt;smu_features[GNLD_DS_SOCCLK].en=
abled) ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_SOCCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D (!data-&gt;smu_features[GNLD_DS_LCLK].enab=
led) ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_LCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D (!data-&gt;smu_features[GNLD_DS_DCEFCLK].e=
nabled) ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_DCEFCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (feature_mask)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!vega10_enable_smc_features(hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !disable, feature_mask),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;enable/disable power features for=
 compute performance Failed!&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (disable) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_ULV].enabled =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_GFXCLK].enabled =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_SOCCLK].enabled =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_LCLK].enabled =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_DCEFCLK].enabled =3D false;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_ULV].enabled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_GFXCLK].enabled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_SOCCLK].enabled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_LCLK].enabled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_DCEFCLK].enabled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;}<br>
&#43;<br>
&nbsp;static const struct pp_hwmgr_func vega10_hwmgr_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .backend_init =3D vega10_h=
wmgr_backend_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .backend_fini =3D vega10_h=
wmgr_backend_fini,<br>
@@ -5330,6 &#43;5383,8 @@ static const struct pp_hwmgr_func vega10_hwmgr_fu=
ncs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_ppfeature_status =3D =
vega10_get_ppfeature_status,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_ppfeature_status =3D =
vega10_set_ppfeature_status,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mp1_state =3D vega10_=
set_mp1_state,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_power_features_for_compu=
te_performance =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_disab=
le_power_features_for_compute_performance,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;int vega10_hwmgr_init(struct pp_hwmgr *hwmgr)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h<br>
index 40403bc..af97767 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
@@ -357,6 &#43;357,8 @@ struct pp_hwmgr_func {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*smu_i2c_bus_access)(=
struct pp_hwmgr *hwmgr, bool aquire);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_df_cstate)(struc=
t pp_hwmgr *hwmgr, enum pp_df_cstate state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_xgmi_pstate)(str=
uct pp_hwmgr *hwmgr, uint32_t pstate);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*disable_power_features_for_=
compute_performance)(struct pp_hwmgr *hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; bool disable);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct pp_table_func {<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB3598E632B3CC0520FB24B08B8E740MN2PR12MB3598namp_--

--===============0242833439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0242833439==--
