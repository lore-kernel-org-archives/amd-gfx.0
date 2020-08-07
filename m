Return-Path: <SRS0=Hu2c=BR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE48C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 15:28:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D3F21744
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 15:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4FWCGMqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D3F21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 537716E081;
	Fri,  7 Aug 2020 15:28:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0476D6E081
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2020 15:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSxOLK/sVS1qESR+p+rQkxqGtY0A3KD/QvudNIX8YyItOwUn3ofjVebdk4Cnofnszr7QXMziQdjVPZQbkMO6lX0oNw6hS0AmiV8w961LLQcGvRpjzY7Ap+iVYNu3oP6TvJqw0f1uAiQntN5ub01fKgU6uRc5/TOvbRw6H3W2/i59eAEGZdNLNOLL3Zdf/bKxVGbyzMPqL/695g7+0DVrwQ+dRJBQxkcs66brYYed6ofA/5e6fjPbD4dZQCV7DMqT63KVwJigwmO/a3PwiiDdC+f6hJSKhsEgJYyg1weoiK2fwtt/UDSFhLETYvrt+5NoGOtX7tbspmJyg8TVLY6IMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FN5s2w8GJq73FpWkM+mgWlBX7s6TsYtQ8F+fCKHO0EI=;
 b=XsaQ2tz7GcTKDv4+Bf2WoYAXQiipV/4+95kBJ/NCFOb0zUy/rwm6YrCeIr4u5Yt7wtAPpzjFvrQskcVihVyKIlc7Sn7nO+9J0blKllJVu1DnRH2xIogSodm/1zCGxXTfPRBE2jhNt4USS7hZSKrtcQR6GXkcbx+I+LJW5x4APJUzQZ7X+qpezmJtVqCMWv1lU0bi5RD1PxD4VnpACDyvj4FDWAyVUJtIeXCE/2ZF5gYedAwhxN+JModJ+boO2UJ1URdPU/25MfBleW28+uWXooXjJkUfjhaouSss2gRIQwhqJ7lirBhufMJjetYahYpzwdMKInE0DHDpfcbuV7yiOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FN5s2w8GJq73FpWkM+mgWlBX7s6TsYtQ8F+fCKHO0EI=;
 b=4FWCGMqq7p0GYMOLai0Ah3Li9MN31Fe4tc72pRPjQjdIqwOulqu28YmavA+pXpT5v6kOyiV8Myfey/yWpgrBFmTxiz5g8mx2uGf1F6vRC089Tx+zTUf3sIu0sGw6c/stdrRYK6BhlYpYXQbJxH7kc5HAzh1GEYes/r6QCCK4MRE=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4014.namprd12.prod.outlook.com (2603:10b6:208:16d::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 15:28:31 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3261.020; Fri, 7 Aug 2020
 15:28:31 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: correct Vega20 cached smu feature state
Thread-Topic: [PATCH] drm/amd/powerplay: correct Vega20 cached smu feature
 state
Thread-Index: AQHWbJ1wRiU+hf0xqUi4pZ0ZWrA9UKksxXx0
Date: Fri, 7 Aug 2020 15:28:30 +0000
Message-ID: <MN2PR12MB44889D2F60F9E0BBD412B54AF7490@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200807093027.479-1-evan.quan@amd.com>
In-Reply-To: <20200807093027.479-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-07T15:28:30.391Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6086f98c-aa97-4bde-43f9-08d83ae68a51
x-ms-traffictypediagnostic: MN2PR12MB4014:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB401497C1DD009C338524EA52F7490@MN2PR12MB4014.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hn4ysENxoSXiMbzDMRt0XBfzNzCiUJRX+E17dCeUEpicXfC11xo+gq5EGEViCPzfEJF4v+1NR9XOCUQvBnXWnEbn1eGjcsd/zu7NUxtjcAF8FVw6vnlfhDZBbNn33KOL5jJyFA4jIi2CYyGp/SB8mc21e2cyHJ3xtpqCdstWpaKT22+LT157gyMLUoHLlcRUuyOi3/KhNoGfCaEYmvn+B5ihbGFabr9poze9d9l7cXr3Rah8HNcLTltCL8JM6hzW5RMKi6AYsT+eSVKJAbnK68G5CacW9CdxR68MJKjjdZtslEdOSaTZsVz7dOJDlq0Xbt/yVE6DkLqLNnc/rA7jpQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(66556008)(64756008)(66446008)(66476007)(52536014)(66946007)(4326008)(186003)(8936002)(8676002)(76116006)(478600001)(110136005)(5660300002)(19627405001)(26005)(33656002)(6506007)(53546011)(9686003)(7696005)(316002)(55016002)(71200400001)(86362001)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: OvTcaXf+qKC/h6kXxZfQKytoy7iHWkS90bq/v4QzaXEA1mRg58DZw4TpVPo3JBLFvjT3tm+9KZLQBW8e0jkGtWkOkzqQNWRRhXQ/PsQYGinwE/2WyZIcd9iApexTSpZAwvR43pR4ipvTJHVJHIPKoJTArtKhTca3M7tWyhrckzRxhBziOn7AhZlrQCuM/r91pMb4v7zUHBjbfhCyZk9erheaVKK/S0c46XIbBe07JNHRumA0IWQzfxaeJRsiwCPDdfJJc1BZ+9owgN5Ulp5vxP2Z3z2DDB1C7nRa/oojAUkNfh6VsB0uMaGhF3QI1641oSwcbM7THU/IRjiBykCFSUTgHtvbq9ps2z6AlzTI/3X501sxts91TCF1cmn+L0ZHpWAxcjoW7FrWO2aHO9tI/sjT6GtGNec3BemLPLVJtilfpzAmBR2gLO92W+lRYj1PRcKsembZmDZh1c0k2zWzBQISkrZFR1Y7OLqOgK+VXQW82Za4585QnVJzCHFmS9tIuB+dg+XOBe3yU8VLJZ3Ho9mNu/vec/G7fQ5jXrDQZ8Qs7t4CxowFtRC29MVhSI5IRuBQQqtFBka6LUc68yf5P/vaowEPpsg/tb5OOm7YhzbNxOCgFBj5DX9NJTBi4+umJ8NzvjYx87i63gL0I27R7A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6086f98c-aa97-4bde-43f9-08d83ae68a51
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 15:28:30.8713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIvgF77r7jdd0B9Nheq4tebEfEFD0yzT8T8SG8GYLZw6lPvXqra66JqRv4iQQq1WDDoixii1Lmsfjkg5zCJFbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4014
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Type: multipart/mixed; boundary="===============1464449795=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1464449795==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44889D2F60F9E0BBD412B54AF7490MN2PR12MB4488namp_"

--_000_MN2PR12MB44889D2F60F9E0BBD412B54AF7490MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Friday, August 7, 2020 5:30 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/powerplay: correct Vega20 cached smu feature state

Correct the cached smu feature state on pp_features sysfs
setting.

Change-Id: Icc4c3ce764876a0ffdc86ad4c8a8b9c9f0ed0e97
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c    | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 90c78f127f7e..acc926c20c55 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -984,10 +984,7 @@ static int vega20_disable_all_smu_features(struct pp_h=
wmgr *hwmgr)
 {
         struct vega20_hwmgr *data =3D
                         (struct vega20_hwmgr *)(hwmgr->backend);
-       uint64_t features_enabled;
-       int i;
-       bool enabled;
-       int ret =3D 0;
+       int i, ret =3D 0;

         PP_ASSERT_WITH_CODE((ret =3D smum_send_msg_to_smc(hwmgr,
                         PPSMC_MSG_DisableAllSmuFeatures,
@@ -995,17 +992,8 @@ static int vega20_disable_all_smu_features(struct pp_h=
wmgr *hwmgr)
                         "[DisableAllSMUFeatures] Failed to disable all smu=
 features!",
                         return ret);

-       ret =3D vega20_get_enabled_smc_features(hwmgr, &features_enabled);
-       PP_ASSERT_WITH_CODE(!ret,
-                       "[DisableAllSMUFeatures] Failed to get enabled smc =
features!",
-                       return ret);
-
-       for (i =3D 0; i < GNLD_FEATURES_MAX; i++) {
-               enabled =3D (features_enabled & data->smu_features[i].smu_f=
eature_bitmap) ?
-                       true : false;
-               data->smu_features[i].enabled =3D enabled;
-               data->smu_features[i].supported =3D enabled;
-       }
+       for (i =3D 0; i < GNLD_FEATURES_MAX; i++)
+               data->smu_features[i].enabled =3D 0;

         return 0;
 }
@@ -3242,10 +3230,11 @@ static int vega20_get_ppfeature_status(struct pp_hw=
mgr *hwmgr, char *buf)

 static int vega20_set_ppfeature_status(struct pp_hwmgr *hwmgr, uint64_t ne=
w_ppfeature_masks)
 {
-       uint64_t features_enabled;
-       uint64_t features_to_enable;
-       uint64_t features_to_disable;
-       int ret =3D 0;
+       struct vega20_hwmgr *data =3D
+                       (struct vega20_hwmgr *)(hwmgr->backend);
+       uint64_t features_enabled, features_to_enable, features_to_disable;
+       int i, ret =3D 0;
+       bool enabled;

         if (new_ppfeature_masks >=3D (1ULL << GNLD_FEATURES_MAX))
                 return -EINVAL;
@@ -3274,6 +3263,17 @@ static int vega20_set_ppfeature_status(struct pp_hwm=
gr *hwmgr, uint64_t new_ppfe
                         return ret;
         }

+       /* Update the cached feature enablement state */
+       ret =3D vega20_get_enabled_smc_features(hwmgr, &features_enabled);
+       if (ret)
+               return ret;
+
+       for (i =3D 0; i < GNLD_FEATURES_MAX; i++) {
+               enabled =3D (features_enabled & data->smu_features[i].smu_f=
eature_bitmap) ?
+                       true : false;
+               data->smu_features[i].enabled =3D enabled;
+       }
+
         return 0;
 }

--
2.28.0


--_000_MN2PR12MB44889D2F60F9E0BBD412B54AF7490MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Friday, August 7, 2020 5:30 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, =
Felix &lt;Felix.Kuehling@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;<=
br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: correct Vega20 cached smu featur=
e state</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Correct the cached smu feature state on pp_feature=
s sysfs<br>
setting.<br>
<br>
Change-Id: Icc4c3ce764876a0ffdc86ad4c8a8b9c9f0ed0e97<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/powerplay/hwmgr/vega20_hwmgr.c&nbsp;&nbsp;&nbsp; | 38 +++=
++++++----------<br>
&nbsp;1 file changed, 19 insertions(+), 19 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
index 90c78f127f7e..acc926c20c55 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
@@ -984,10 +984,7 @@ static int vega20_disable_all_smu_features(struct pp_h=
wmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_hwmgr *data =
=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (stru=
ct vega20_hwmgr *)(hwmgr-&gt;backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t features_enabled;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enabled;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE((ret =
=3D smum_send_msg_to_smc(hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC=
_MSG_DisableAllSmuFeatures,<br>
@@ -995,17 +992,8 @@ static int vega20_disable_all_smu_features(struct pp_h=
wmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;[DisableAllSMUFeatures] Failed to disable all smu features!&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_get_enabled_smc_featur=
es(hwmgr, &amp;features_enabled);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;[DisableAl=
lSMUFeatures] Failed to get enabled smc features!&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; GNLD_FEATURES_MA=
X; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; enabled =3D (features_enabled &amp; data-&gt;smu_features[i].smu=
_feature_bitmap) ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true : false;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;smu_features[i].enabled =3D enabled;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;smu_features[i].supported =3D enabled;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; GNLD_FEATURES_MA=
X; i++)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;smu_features[i].enabled =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -3242,10 +3230,11 @@ static int vega20_get_ppfeature_status(struct pp_hw=
mgr *hwmgr, char *buf)<br>
&nbsp;<br>
&nbsp;static int vega20_set_ppfeature_status(struct pp_hwmgr *hwmgr, uint64=
_t new_ppfeature_masks)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t features_enabled;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t features_to_enable;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t features_to_disable;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_hwmgr *data =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct vega20_h=
wmgr *)(hwmgr-&gt;backend);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t features_enabled, features_t=
o_enable, features_to_disable;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enabled;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (new_ppfeature_masks &g=
t;=3D (1ULL &lt;&lt; GNLD_FEATURES_MAX))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -3274,6 +3263,17 @@ static int vega20_set_ppfeature_status(struct pp_hwm=
gr *hwmgr, uint64_t new_ppfe<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Update the cached feature enableme=
nt state */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_get_enabled_smc_featur=
es(hwmgr, &amp;features_enabled);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; GNLD_FEATURES_MA=
X; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; enabled =3D (features_enabled &amp; data-&gt;smu_features[i].smu=
_feature_bitmap) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true : false;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;smu_features[i].enabled =3D enabled;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.28.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44889D2F60F9E0BBD412B54AF7490MN2PR12MB4488namp_--

--===============1464449795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1464449795==--
