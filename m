Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF18AC2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 08:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F6E223BF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 08:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WPuXS08Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F6E223BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B761B894DD;
	Tue,  3 Nov 2020 08:19:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B18DE894DD
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 08:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lm4HQ50yVRP+pFS5My8ghb7L84LX0sU/P9osDS8ud5EwVcp2u06eD886Sl2hwToEwe8oJH+M9JuZNVs7HV5rwl5RX7TqJunRuzZLP/W6sHNr2GQmqbI5bn01ZBHVPiC5fl97ABqRItR4qMhQEQ2aFZh98ZYVWNUtNk9dRSDXOTKyco2LlcOcIIamEqULwR5Sy457iXjWtyWq9RwuQlFYn+9juQTBUIVQGNYdeMrTAmQiB16jIA0MUW1XZ9vg9Iba1yDJMGggYLifkgkLlAkfqGnXjF7TCnNf6pVBRFE44RvS315TED/klu+RmeEHayPBMBs/Jk4pPlLcctSxEaGkEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0EPZbrqqx/7WOT6O9KEysfuard5iD81hgub7L1pz+Q=;
 b=mPEnEhyWmhG14P10cCYCTij2VMXMZpywqJlSTOukB8SafoAfNU2YkFSULqdDewySTTtbn6mxhUguMKxxfYqdP+KJFHc/LBOxjLbJFZC49dGn3tehyH+tOwdzoh/M7aGk02zxnYtNLptzgeYfG8D/UDHwOKtdqCMwpxCaVU4Jj7zEmQ4u2pb+lbj6ltrJe+C/f42nJ7Nzly5Te/OlC7FwA2NROSQF2t3L9ZhpHK3FoHuHbJ/lu9atsgLjWqBGB2iAwIfz4HbgScvXe7TodSU8FYQ4iw4N6s+wWxkdcIO77qPxzQsd6SCa8h7U1PCVhzfYjY12n9uM4Zcv2r8jHT209g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0EPZbrqqx/7WOT6O9KEysfuard5iD81hgub7L1pz+Q=;
 b=WPuXS08YBD0pquFDCUteSpKxygV/W5IP2W+DdStIiJvbdUeYw2mFIElHRTlCG34/ixCQUs7hQDUZ+h1f54lLZoCMLFS4xqBRBtZ9zJGKGlbYDp0CbLxYKKO7i6II0ucCaFJ9oY22dAjlxskSKphp3XGK8DiR0O34xy1ITwybrRg=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3407.namprd12.prod.outlook.com (2603:10b6:208:c5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Tue, 3 Nov
 2020 08:19:30 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362%4]) with mapi id 15.20.3499.031; Tue, 3 Nov 2020
 08:19:30 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: specify the power strategy for vcn use
Thread-Topic: [PATCH] drm/amd/amdgpu: specify the power strategy for vcn use
Thread-Index: AQHWsbh7gvG9bq6P6UOqLCY/+vx7pam2D5eT
Date: Tue, 3 Nov 2020 08:19:29 +0000
Message-ID: <MN2PR12MB302226FDFE5AE8C9579D0E6DA2110@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20201103080749.14197-1-kenneth.feng@amd.com>
In-Reply-To: <20201103080749.14197-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 823aa36e-b027-4bfc-c5b9-08d87fd12fd5
x-ms-traffictypediagnostic: MN2PR12MB3407:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3407B63E03A7FE9CAED56AA7A2110@MN2PR12MB3407.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nb1SHXz3E6DyVyUAMw9duOxtYizD92eehNyclWhk5g2EvknV7zEwR0a497xkXfUknAE/i6eoBt51+zdAZ8OmdOVC0gnRkPVikMOcL4RS/vFPVcsG0hkbngAGR9uMSBhynuG7kIr6q7/eFexudI1hZ6Y/B/GDKFhosDlNhs4mtpH0gbSNab/fx2pqdE2U5kuZQbB1hLYZX0BDsPE8B1e+utdHtUBW+irp77+rzcABwCiTMoEd0ITL69PVgNqQ6YcwHipSP9ivrz1BaVtunvRMFKnqRNYXxAjzyY2Hq6955PVVo0bRhaTaVwfMfH0FU8rddNjBDDYGKzp6mlWFJ7/dXh9G40JB8tKMITO6faDcRZY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(5660300002)(966005)(45080400002)(2906002)(91956017)(66446008)(316002)(64756008)(478600001)(66556008)(26005)(66946007)(76116006)(19627405001)(110136005)(66476007)(71200400001)(186003)(8676002)(83380400001)(8936002)(33656002)(86362001)(7696005)(55016002)(166002)(52536014)(9686003)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: OJexHkIBUJhox1Qsi6X7vzQs+H3iOx0LVhC0Igina2wxc8VRjNFeScdiv1KHU6IBLqmhHPUP1js1lqBXTJAlrvFJUmgdbZA/bIQBiWDnf53gzISf/G5AjCTagmGvUGpl0kF1SoP/xrksz2dPAu8I27GRXQpTJQOyDUNYsVuIt9TUgNl0p+UhdoRg762kR8FnbeLuGDvCjg+Upl4pG4MLOyWiEffQxWKeJVxC2ztm87R7naIPr24Q+6EsxCC3n+Tz3WxoGy0NkyKkIr3amkQqz+K50/uq4v59xG1d58lCdbSG9pHVqbeo74lqpFGyNmz+5BHuox+7XHCeSjZi1Z8WSOKQIfS4i1sqZcMFIFvK6HnILW6GiFvB2KNOnY9uMtd7xhgiToQ9CXM2pfNFli92GHxr0dXAgHOe6I9i8JmGmEhDZ1/Cp5ORHgLl/BOFCMxt2BheyVRvfYwKW5VKeZEVTuQw7rUa5s5MHn4+7q+Y+qQ9qsI9WLd0YiPg2AkzSR6ALK0DWQq/SkqdW9O5mIeS416HMF5cwmpUZFgeZ5Oo4JQrIN1o8mvVuiOg/P74JoOHqud04Bs8A7dCQ7Y9XA3L3e6it9vp+ZuYTlAna+1fHynTZQTu3bWxSYRUImyHJ9uO8Yj2T85bcPRyBlRF8AwmDw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823aa36e-b027-4bfc-c5b9-08d87fd12fd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 08:19:29.9527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VgZ2P4CfWiToZEAg+Qgk0ylwb54halOvQOq6shPtnhjriy4+YIhyw3gJabLL9FFo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3407
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
Content-Type: multipart/mixed; boundary="===============0955351467=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0955351467==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB302226FDFE5AE8C9579D0E6DA2110MN2PR12MB3022namp_"

--_000_MN2PR12MB302226FDFE5AE8C9579D0E6DA2110MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

comment inline.

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kenneth =
Feng <kenneth.feng@amd.com>
Sent: Tuesday, November 3, 2020 4:07 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/amdgpu: specify the power strategy for vcn use

The power/performance control strategy is specific for vcn use case.
Then this can optimize the power/performance when the workload is on vcn.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 0145504e408b..2c3e111bab43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -361,6 +361,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_st=
ruct *work)
                 amdgpu_gfx_off_ctrl(adev, true);
                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_=
TYPE_VCN,
                        AMD_PG_STATE_GATE);
+               amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_=
VIDEO,
+                               false);
[kevin]:
we'd better to check the return value here, if we really don't care the res=
ult, we can print a warning log for debug later.

the patch is:
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

         } else {
                 schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIMEO=
UT);
         }
@@ -372,8 +374,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *rin=
g)

         atomic_inc(&adev->vcn.total_submission_cnt);

-       if (!cancel_delayed_work_sync(&adev->vcn.idle_work))
+       if (!cancel_delayed_work_sync(&adev->vcn.idle_work)) {
                 amdgpu_gfx_off_ctrl(adev, false);
+               amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_=
VIDEO,
+                               true);
+       }

         mutex_lock(&adev->vcn.vcn_pg_lock);
         amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN=
,
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CKevin1.W=
ang%40amd.com%7C72db727fcede4117919008d87fcf9c39%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637399876957953297%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DFR=
DabYo1xJiS3agbO5a478%2FPO0cDrfcYMfLDS%2BudrX8%3D&amp;reserved=3D0

--_000_MN2PR12MB302226FDFE5AE8C9579D0E6DA2110MN2PR12MB3022namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
comment inline.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kenneth Feng &lt;kenneth.feng=
@amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 3, 2020 4:07 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: specify the power strategy for vcn =
use</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment">
<div class=3D"PlainText" style=3D"font-size: 11pt;">The power/performance c=
ontrol strategy is specific for vcn use case.<br>
Then this can optimize the power/performance when the workload is on vcn.<b=
r>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 7 ++++++-<br>
&nbsp;1 file changed, 6 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c<br>
index 0145504e408b..2c3e111bab43 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
@@ -361,6 +361,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_st=
ruct *work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_set_powergating_state(adev, AMD_IP_B=
LOCK_TYPE_VCN,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_STAT=
E_GATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false);</div>
<div class=3D"PlainText" style=3D"font-size: 11pt;">[kevin]:</div>
<div class=3D"PlainText" style=3D"">
<div style=3D"font-size: 12pt; margin: 0px; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west =
european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, r=
oboto, &quot;helvetica neue&quot;, sans-serif; font-size: 11pt; color: rgb(=
50, 49, 48); background-color: rgba(0, 0, 0, 0);">we'd better to check the
 return value here, if we really don't care the result, we can print a warn=
ing log for debug later.</span></div>
<div style=3D"font-size: 12pt; margin: 0px; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west =
european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, r=
oboto, &quot;helvetica neue&quot;, sans-serif; font-size: 11pt; color: rgb(=
50, 49, 48); background-color: rgba(0, 0, 0, 0);"><br>
</span></div>
<div style=3D"font-size: 12pt; margin: 0px; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west =
european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, r=
oboto, &quot;helvetica neue&quot;, sans-serif; font-size: 11pt; color: rgb(=
50, 49, 48); background-color: rgba(0, 0, 0, 0);">the patch is:</span></div=
>
<div style=3D"font-size: 12pt; margin: 0px; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: rgb(0, 0, 0);">
<span style=3D"font-size: 11pt; font-family: &quot;segoe ui&quot;, &quot;se=
goe ui web (west european)&quot;, &quot;segoe ui&quot;, -apple-system, blin=
kmacsystemfont, roboto, &quot;helvetica neue&quot;, sans-serif; color: rgb(=
50, 49, 48); background-color: rgba(0, 0, 0, 0);">Reviewed-by: Kevin Wang
 &lt;kevin1.wang@amd.com&gt;</span><br>
</div>
<br>
</div>
<div class=3D"PlainText" style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; schedule_delayed_work(&amp;adev-&gt;vcn.idle_work, VC=
N_IDLE_TIMEOUT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -372,8 +374,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *rin=
g)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_inc(&amp;adev-&gt;v=
cn.total_submission_cnt);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cancel_delayed_work_sync(&amp;ad=
ev-&gt;vcn.idle_work))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cancel_delayed_work_sync(&amp;ad=
ev-&gt;vcn.idle_work)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;v=
cn.vcn_pg_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_set_power=
gating_state(adev, AMD_IP_BLOCK_TYPE_VCN,<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7C72db727fcede4117919008d87fcf9c39%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637399876957953297%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DFRDabYo1xJiS3agbO5a478%2FPO0cDrfcYMfLDS%2BudrX8%3D&amp;amp=
;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7CKevin1.Wang%40amd.com%7C72db727fcede4117919008d87fcf9c39%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637399876957953297%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DFRDabYo1xJiS3agbO5a478%2FPO0cDrfcYMfLDS%2BudrX8%3D&a=
mp;amp;reserved=3D0</a><br>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB302226FDFE5AE8C9579D0E6DA2110MN2PR12MB3022namp_--

--===============0955351467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0955351467==--
