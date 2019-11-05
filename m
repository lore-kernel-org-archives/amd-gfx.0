Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A0EC5DF60
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 16:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0040321882
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 16:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0040321882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA24F6EAF3;
	Tue,  5 Nov 2019 16:39:42 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790048.outbound.protection.outlook.com [40.107.79.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC9A06EAF2
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 16:39:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRFAC0a97K7DwpdbiIDvgmUmNU9EnpKx0Q3ohqhJ5gf8VbyCvW4K6KkNEhHhSVV6RVy9i3fIlBzeKmGvgHVC81bhIp7Z4QvLaxO226ngpP9zPjf38ulMDvD+jwFyRHxW/OapMiF+yg5VLbGj4tb9J5h+CLDfjCTl4RpZGgzRYkE4PVBcGM/F8N4MVM6G0ZKhtImS5zHPQL8To4rSaYiSjVIEDB0csjfWispl09YnEcwsOVzg1tsr1U3B/PKAgQyrGrQ7MsogN0qM9INT8tsZUQvqT+Hpv2WC2a9esqTr2mgn5mWlpTTtlFuk11lC6uw+q1Bc3uTdoihQ8EJnYt3/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdzntQtJPwETWAadz7w2L3ol6fPj6rc+txhqcFt2fqk=;
 b=Po109Z7c0lpBpWaH33ErmaIN4SR4gLdDJ7H8s2MrGCeumrbSc2lqwsPqXhSInPK93fW0b0DjZ0b+LH0GNRIP72uF/8lIyKK+89kJbtAjMwdZ+uBg/qcVpn3I/F9wtOFxp6HtgpXy1zpepz0gWkcsj2up63h6bVSs8uhiedtB1tasahd8NFKhwzTtys/bm05l13kwyfTjXcxioiYTaUGNRHUX4aKNEBtVxQOIID4jaG9o9IUsi1gb84e4CtfCp7zlFqFpYsUtycORAbPjhFTFLm7KDmBH3wILejHRmIAUH/lYD+rcn9SS7QGyv6UviT/EhdQ76grZ4HDsrCLI4HBBFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2486.namprd12.prod.outlook.com (52.132.140.32) by
 DM5PR12MB1515.namprd12.prod.outlook.com (10.172.35.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 16:39:38 +0000
Received: from DM5PR12MB2486.namprd12.prod.outlook.com
 ([fe80::68dc:4b60:6a28:37d6]) by DM5PR12MB2486.namprd12.prod.outlook.com
 ([fe80::68dc:4b60:6a28:37d6%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 16:39:38 +0000
From: "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: perform p-state switch after the whole
 hive initialized
Thread-Topic: [PATCH 2/2] drm/amdgpu: perform p-state switch after the whole
 hive initialized
Thread-Index: AQHVk8MYA5aZlR3Kn0iJS//jkkMD5qd8xcyAgAABntk=
Date: Tue, 5 Nov 2019 16:39:38 +0000
Message-ID:
 <DM5PR12MB248696FDB2D0E563221E7CDFE87E0@DM5PR12MB2486.namprd12.prod.outlook.com>
References: <20191105102310.16657-1-evan.quan@amd.com>
 <20191105102310.16657-2-evan.quan@amd.com>,
 <CH2PR12MB3831CEABDD4CBA2FEB8DEFEB857E0@CH2PR12MB3831.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB3831CEABDD4CBA2FEB8DEFEB857E0@CH2PR12MB3831.namprd12.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 40cbfb49-324a-4d22-375f-08d7620ec026
x-ms-traffictypediagnostic: DM5PR12MB1515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB15158F6EBE1883907255AAAEE87E0@DM5PR12MB1515.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(13464003)(110136005)(33656002)(19627405001)(64756008)(316002)(81166006)(81156014)(74316002)(8676002)(66946007)(478600001)(99286004)(76116006)(91956017)(66446008)(66556008)(7736002)(66476007)(25786009)(26005)(2501003)(6116002)(86362001)(55016002)(7696005)(76176011)(6436002)(102836004)(53546011)(6506007)(14454004)(2906002)(8936002)(6246003)(71200400001)(71190400001)(3846002)(446003)(105004)(9686003)(54896002)(11346002)(476003)(486006)(256004)(14444005)(5660300002)(186003)(229853002)(52536014)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1515;
 H:DM5PR12MB2486.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2zjcnv9Q1UzGmUGjed5i3F36dhrSeuCk4p0mfIIUevd9ngdfp/zgc1BDMqo3k2op/U55zOREIIlYymnoSxYtM3g9Wbu2DfVD43Ztu1wwJClFinHXfYPNH3M6PEpln061x6vnoCEWaAeXkBBFHMsDegs7pW/S9/rj47zT1SLMFq/+DfgiXsHlVgdfOrrfiSyHAl/wZGJdpRxsnwcIg0KtX98taZfQQf/dVeAMEJGu/cQwg2A1yCSq3+mv+YvzTJtVt3bWccs9F+AIrx9lu49x/t0q1ebrPHmCCBa0tPbWRGr/fxL8e+RAGzLIKvboWuFTog2BJUdHxXROD0tipNXLMd0tVDTRJt+oQDzak5lfuueKxbNTv0bX/bA16hgu3R3a063hu05iuONMCIV8E885CIKFZDsBUX+9MnICm5SjcqV2e11+5XYnycojTvqh4kyu
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cbfb49-324a-4d22-375f-08d7620ec026
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 16:39:38.7439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /5ImNFdJ97H1Y7ht09rCQr0p8HXpryC1c/mTNTgIyXX2gYH4U1NtU/Bxo/CGI36HI+nyi5L8Z1D+RCpqbOB0YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1515
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdzntQtJPwETWAadz7w2L3ol6fPj6rc+txhqcFt2fqk=;
 b=vcDQ/Lqtyqr5zmukorsz3nhV2WDDDTrlQlXE5B1wZVegFuACUj5d8Y7xcwK8jX782PutTcUJzJYq8//t1WIzfmjHacBelIrtVBb3FpXSHk8oHd3qn4pOxV8LzDrvfwnFv3kwvlr5kUXdJFZzVgHE23GAf/8FYzFahxr9u0d+Zg0=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michael.Strawbridge@amd.com; 
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
Content-Type: multipart/mixed; boundary="===============1068518782=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105163938.pHi3kH481nkkuh9FUXxAvucJdAIvVWXNSPupEXzXyFI@z>

--===============1068518782==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB248696FDB2D0E563221E7CDFE87E0DM5PR12MB2486namp_"

--_000_DM5PR12MB248696FDB2D0E563221E7CDFE87E0DM5PR12MB2486namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Jon,

Does that mean we can simply use this instead?

+               if (mgpu_info.num_dgpu =3D=3D adev->gmc.xgmi.num_physical_n=
odes - 1) {

Thanks,
Michael
________________________________
From: Kim, Jonathan <Jonathan.Kim@amd.com>
Sent: 05 November 2019 11:32 AM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Cc: Strawbridge, Michael <Michael.Strawbridge@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: perform p-state switch after the whole=
 hive initialized

Please see inline.

Jon

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Tuesday, November 5, 2019 5:24 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Strawbridge, Michael <Michael.Str=
awbridge@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: perform p-state switch after the whole hiv=
e initialized

P-state switch should be performed after all devices from the hive get init=
ialized.

Change-Id: Ifc7cac9ef0cf250447d2a412da35d601e2ac79ec
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 ++++++++++++++++------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index e6ce949670e5..2d72d206cead 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2090,6 +2090,7 @@ static int amdgpu_device_enable_mgpu_fan_boost(void)
  */
 static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)  {
+       struct amdgpu_gpu_instance *gpu_instance;
         int i =3D 0, r;

         for (i =3D 0; i < adev->num_ip_blocks; i++) { @@ -2115,6 +2116,40 =
@@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
         if (r)
                 DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);

+
+       if (adev->gmc.xgmi.num_physical_nodes > 1) {
+               mutex_lock(&mgpu_info.mutex);
+
+               /*
+                * Reset device p-state to low as this was booted with high=
.
+                *
+                * This should be performed only after all devices from the=
 same
+                * hive get initialized.
+                *
+                * However, it's unknown how many device in the hive in adv=
ance.
+                * As this is counted one by one during devices initializat=
ions.
+                *
+                * So, we wait for all XGMI interlinked devices initialized=
.
+                * This may bring some delays as those devices may come fro=
m
+                * different hives. But that should be OK.
+                */
+               if (mgpu_info.num_dgpu =3D=3D adev->gmc.xgmi.num_physical_n=
odes) {
[JK] This condition will never succeed.  mgpu_info.num_dgpu is 0-indexed wh=
ile num_physical_nodes give total nodes.

+                       for (i =3D 0; i < mgpu_info.num_gpu; i++) {
+                               gpu_instance =3D &(mgpu_info.gpu_ins[i]);
+                               if (gpu_instance->adev->flags & AMD_IS_APU)
+                                       continue;
+
+                               r =3D amdgpu_xgmi_set_pstate(gpu_instance->=
adev, 0);
+                               if (r) {
+                                       DRM_ERROR("pstate setting failed (%=
d).\n", r);
+                                       break;
+                               }
+                       }
+               }
+
+               mutex_unlock(&mgpu_info.mutex);
+       }
+
         return 0;
 }

@@ -2227,18 +2262,6 @@ static void amdgpu_device_delayed_init_work_handler(=
struct work_struct *work)
         r =3D amdgpu_ib_ring_tests(adev);
         if (r)
                 DRM_ERROR("ib ring test failed (%d).\n", r);
-
-       /*
-        * set to low pstate by default
-        * This should be performed after all devices from
-        * XGMI finish their initializations. Thus it's moved
-        * to here.
-        * The time delay is 2S. TODO: confirm whether that
-        * is enough for all possible XGMI setups.
-        */
-       r =3D amdgpu_xgmi_set_pstate(adev, 0);
-       if (r)
-               DRM_ERROR("pstate setting failed (%d).\n", r);
 }

 static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
--
2.23.0


--_000_DM5PR12MB248696FDB2D0E563221E7CDFE87E0DM5PR12MB2486namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Jon,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Does that mean we can simply use this instead?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; backgr=
ound-color: rgb(255, 255, 255); display: inline !important">&#43;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 if (mgpu_info.num_dgpu =3D=3D adev-&gt;gmc.xgmi.num_physical_nodes<b> - 1<=
/b>) {</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"color: rgb(0, 0, 0);"><span style=3D"font-size: 14.6667px;">T=
hanks,</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Michael</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kim, Jonathan &lt;Jon=
athan.Kim@amd.com&gt;<br>
<b>Sent:</b> 05 November 2019 11:32 AM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Strawbridge, Michael &lt;Michael.Strawbridge@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: perform p-state switch after th=
e whole hive initialized</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Please see inline.<br>
<br>
Jon<br>
<br>
-----Original Message-----<br>
From: Quan, Evan &lt;Evan.Quan@amd.com&gt; <br>
Sent: Tuesday, November 5, 2019 5:24 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;; Strawbridge, Michael &lt;Mi=
chael.Strawbridge@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
Subject: [PATCH 2/2] drm/amdgpu: perform p-state switch after the whole hiv=
e initialized<br>
<br>
P-state switch should be performed after all devices from the hive get init=
ialized.<br>
<br>
Change-Id: Ifc7cac9ef0cf250447d2a412da35d601e2ac79ec<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;------<br>
&nbsp;1 file changed, 35 insertions(&#43;), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index e6ce949670e5..2d72d206cead 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2090,6 &#43;2090,7 @@ static int amdgpu_device_enable_mgpu_fan_boost(vo=
id)<br>
&nbsp; */<br>
&nbsp;static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)&nbs=
p; {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_gpu_instance *gpu_i=
nstance;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i =3D 0, r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;num_ip_blocks; i&#43;&#43;) { @@ -2115,6 &#43;2116,40 @@ static int amd=
gpu_device_ip_late_init(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;enable mgpu fan boost failed (%d).\n&=
quot;, r);<br>
&nbsp;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.num_physica=
l_nodes &gt; 1) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mutex_lock(&amp;mgpu_info.mutex);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * Reset device p-state to low as this was booted with =
high.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * This should be performed only after all devices from=
 the same<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * hive get initialized.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * However, it's unknown how many device in the hive in=
 advance.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * As this is counted one by one during devices initial=
izations.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * So, we wait for all XGMI interlinked devices initial=
ized.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * This may bring some delays as those devices may come=
 from<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * different hives. But that should be OK.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (mgpu_info.num_dgpu =3D=3D adev-&gt;gmc.xgmi.num_physical=
_nodes) {<br>
[JK] This condition will never succeed.&nbsp; mgpu_info.num_dgpu is 0-index=
ed while num_physical_nodes give total nodes.<br>
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0=
; i &lt; mgpu_info.num_gpu; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_instance =3D &amp;(mgpu_info.gpu_in=
s[i]);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_instance-&gt;adev-&gt;flags &am=
p; AMD_IS_APU)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; continue;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_xgmi_set_pstate(gpu_instan=
ce-&gt;adev, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; DRM_ERROR(&quot;pstate setting failed (%d).\n&quot;, r);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mutex_unlock(&amp;mgpu_info.mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -2227,18 &#43;2262,6 @@ static void amdgpu_device_delayed_init_work_hand=
ler(struct work_struct *work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ib_ring_tests=
(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;ib ring test failed (%d).\n&quot;, r)=
;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * set to low pstate by default<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * This should be performed afte=
r all devices from<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * XGMI finish their initializat=
ions. Thus it's moved<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to here.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The time delay is 2S. TODO: c=
onfirm whether that<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * is enough for all possible XG=
MI setups.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_xgmi_set_pstate(adev, 0)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;pstate setting failed (%d).\n&quot;, r);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void amdgpu_device_delay_enable_gfx_off(struct work_struct *wo=
rk)<br>
--<br>
2.23.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB248696FDB2D0E563221E7CDFE87E0DM5PR12MB2486namp_--

--===============1068518782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1068518782==--
