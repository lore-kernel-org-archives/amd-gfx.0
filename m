Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40886C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 16:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4BE52168B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 16:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BE52168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71DFB6E2DE;
	Tue, 12 Jan 2021 16:03:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C9F76E2DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 16:03:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6EZL4Jk7BpvqIGtv//yXKib0o2FThpnPyu5bUI1D/1JLjEty7TbCG6qWnjrylUbSgiSkRdv+RxG3rqhQ/M+A3bjRo+KYZp7rrNIVKVV7SQvDVvD6G7WagdkcAoHWfd0dM/UxkAjvIB3/9k/3FFi0U0JJYCwNJkb7S3+ihMKca67wbJPXQebtFjOxOj6E771kthxw+b/Wjvk2kl98A5YOIWH2SHX8Rce4Iu4tKgUAWee1TPEBFajMHrwfU2u/yaZdT+D4RjSfXmzM6OtwEKwi1MWbk7w/MbkROIk3BcJpNo6BMFKcMIZLQZoX+M8RTcS401kLhcYnA6rJYAEox/10Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhkLK+QG4m+KFWqKuwm5TKib4qZ/gNuGQ0vitkihxmQ=;
 b=bcOoDLUSBxcbpS2vvdtZVFrN74npMI1u1DeGfRhxPLwt/WMF+EYAH8K9zwuWz1rrP0tdBYyAvN3nZjw9mnoHFZ3HHnT2bXoZGjx2tYFnSmy3OAslzQHAb2i6pZva6zpD4AFm745sQbnUwTC2j8K8U2rvXwLJMrQe8k6w6uhGYgXQxZ0Gugq7e5VsIb2OLIdL22JLLvVWSluJH6oM5j6GlRtR7xiaZyywXk2B2ppTOwSwsvxvM9Z3L0EogI4qhd4CVXdL5cR8yhtifw6KF1c2ohSvPvdrrF7MRZ1ut2FAq2GffSkc5N4KtaeUK1cTuvFuP8xx/PLuouufqnejzOUlUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhkLK+QG4m+KFWqKuwm5TKib4qZ/gNuGQ0vitkihxmQ=;
 b=udo59eOKYoXRugIYuWrVHMMwvwZgAJRzyw0L0rtKe6O5LQc175ekdjty6DQYu8Aawf6G/b46TLAKkXUpqBHmdlWkaNZab+4RWB+aCYUTDehK3b2nRjY1bDHKgrouIhIcTNgvBEuENkV6GJcul9B3Tb4Vfnj1lQftQ1PooL0jEaQ=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MW3PR12MB4441.namprd12.prod.outlook.com (2603:10b6:303:59::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Tue, 12 Jan
 2021 16:03:38 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::858e:d929:4fab:5ac3]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::858e:d929:4fab:5ac3%9]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 16:03:38 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix deadlock during gpu reset v2
Thread-Topic: [PATCH] drm/amd/display: Fix deadlock during gpu reset v2
Thread-Index: AQHW6F0dxqWT8H9lTkW2+SxUxNeUtqojTa0AgADaQFM=
Date: Tue, 12 Jan 2021 16:03:38 +0000
Message-ID: <MW3PR12MB4554808C9AA46660B75DF722F9AA0@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20210111210236.2376738-1-Bhawanpreet.Lakha@amd.com>,
 <CY4PR12MB1287CCD6B57FD4F7AF025520F1AA0@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287CCD6B57FD4F7AF025520F1AA0@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-12T16:03:37.629Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0261cc6d-abb3-4ade-7971-08d8b7139f7e
x-ms-traffictypediagnostic: MW3PR12MB4441:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB44419DE835A9410D5082594DF9AA0@MW3PR12MB4441.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rcUOziblmQjnW50Fof9T4pH9hN3qO0qH7hiBbBlfyDPmi6z7a9vV/VO3D0tviXB1JenKvDzFj639KHSYRJfnw8mdUkZaZFT0ChHseEDy5sh6sj7Aa91bT+1gRoVAVb8WYtwPkhp8Y/8L6gMExNpP76IzTS1kBdpZQEwGGtmGfukPuKQW6BbH8Kl4NuOalOGMTsRoze3i7y+qXb8vS1rLBFQwHFer9sCSZthrg2iWj8nGf3cxvKYA3RBr/KlL42HALDzWN1rAG5FySDVd13a9PBHcmCAkCSywEmsIZ+NiZORzOnCMP3XaeKHPlWiCNNng3KgIlNmAbHsO2Os5Z0KaF9HbDFla1phRJWrByM47rHuSloTjJ2Jputn2VMafF5On/vCEhyLEunwiSKFUQ60XKw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(86362001)(478600001)(64756008)(6636002)(2906002)(5660300002)(66556008)(83380400001)(8936002)(52536014)(55016002)(71200400001)(4326008)(76116006)(6506007)(19627405001)(53546011)(33656002)(8676002)(9686003)(66946007)(186003)(26005)(110136005)(66446008)(7696005)(316002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nPFPZOnO/UeKqbvkecUG7sFzuSvakkFCHpw2UzPthFCsXY44PUK3r1oyxHX7?=
 =?us-ascii?Q?EO/hMFhd28E+Zt+b+4nbxhqcZym8J+Ee2h3iiujZ5jkP5gkUWNSPZiYdJtst?=
 =?us-ascii?Q?plkNMLOX/ixfe53KM6/NIuq1UHYBl7UM9l3XbfCdYRlrQb+xuCMu2SffXUGR?=
 =?us-ascii?Q?CmoeaEOTh06VeUTgU1x4TNPXfJLKTcSj86lRp1qAjjGgkP/wbKCnGP3kz5Zp?=
 =?us-ascii?Q?pR0fKa5bS0ge9Pf1wRp6DkkQYkoeKkIqZodCU1DP/qsmOoV7Tc/S3HFj8GUO?=
 =?us-ascii?Q?iGquDpmQ0zojWzet5X3iFs2ghhFIBUS8a+wzqFv4XdAktl+G0uF+AkKc0+Te?=
 =?us-ascii?Q?giTQugcsosdA94VBu+jzwVzQ/vj/84sKziwUbzQNSRj6KqckVfikduKcrxXT?=
 =?us-ascii?Q?b35KjoGYfqZR4tM5I3k3y4jZlJnSG5z6dgUl0kpXmG/Alk1PFRxUx3EnEYlR?=
 =?us-ascii?Q?T4XpnJddleqWUl2GHoV8fOumqdmgu5D7rXkFPQ+nG8Lp3aLimQ11FGJmWpMd?=
 =?us-ascii?Q?jOcJJBS5Mkf8g4yYr5RMl9wDe5DeHGAqgmw+yorADFb/ZU9MoViuOVRV4URf?=
 =?us-ascii?Q?5W1oMIMtBDL7N4LQEbb9njKV1Pv2RSDDgsKHEOzXX+aXrMdO69h4LqOfIaHh?=
 =?us-ascii?Q?TfakBag9D9fDZq6vCEzooRAfX6I4AQBJxKA1XM/CFnDIBYWl7hq18zp+3WAt?=
 =?us-ascii?Q?Ur+oWAZ7v6My7nv5QunTgqbv+5u+DDhr5xmNnE/N9ehstQSeu1KbZ98P3h0n?=
 =?us-ascii?Q?kP3HFhzdbed+ampoilddk+Mhak4OOyRGUdXmJWEzqbVaxO/Lh/2kubo3dm9v?=
 =?us-ascii?Q?FVv/Z/cVNQ/7NbaypGOEbrZjv02DPhL/DIwLHeoXcUAWb5gLIdiPvQTOP/jy?=
 =?us-ascii?Q?lB86aCrps8kAu5f7Gg74AYE+P4CeyKgERAx4tJejnsQGTFvzEU1K3bgNE4D1?=
 =?us-ascii?Q?UOirXDjqeSnEEA+fE1HXbMsbA7jqIgTgwZ4N8wlvsUg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0261cc6d-abb3-4ade-7971-08d8b7139f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 16:03:38.0335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ChyTn/p0VWaJi9wpWNB7Li0Fl9k4k1BdCzjgJ/LALJy8rQppRtavP0yTU/pGcDVX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4441
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============2085409600=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2085409600==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB4554808C9AA46660B75DF722F9AA0MW3PR12MB4554namp_"

--_000_MW3PR12MB4554808C9AA46660B75DF722F9AA0MW3PR12MB4554namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

No need since "dc_allow_idle_optimizations" will not do anything for asics =
below dcn3

Bhawan
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: January 11, 2021 10:01 PM
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Kazlauskas, Nicholas <N=
icholas.Kazlauskas@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Lakha, B=
hawanpreet <Bhawanpreet.Lakha@amd.com>
Subject: RE: [PATCH] drm/amd/display: Fix deadlock during gpu reset v2

[AMD Public Use]

When using dc_allow_idle_optimizations, should it be guarded by CONFIG_DRM_=
AMD_DC_DCN?

Regards,
Guchun

-----Original Message-----
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Sent: Tuesday, January 12, 2021 5:03 AM
To: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Chen, Guchun <Guchu=
n.Chen@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Lakha, Bhawanpreet <Bhawanpreet.Lakha@am=
d.com>
Subject: [PATCH] drm/amd/display: Fix deadlock during gpu reset v2

[Why]
during idle optimizations we acquire the dc_lock, this lock is also acquire=
d during gpu_reset so we end up hanging the system due to a deadlock

[How]
If we are in gpu reset:
 - disable idle optimizations and skip calls to the dc function

v2: skip idle optimizations calls

Fixes: 06d5652541c3 ("drm/amd/display: enable idle optimizations for linux =
(MALL stutter)")
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 99c7f9eb44aa..858c6ff173ba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1816,6 +1816,9 @@ static int dm_suspend(void *handle)

         if (amdgpu_in_reset(adev)) {
                 mutex_lock(&dm->dc_lock);
+
+               dc_allow_idle_optimizations(adev->dm.dc, false);
+
                 dm->cached_dc_state =3D dc_copy_state(dm->dc->current_stat=
e);

                 dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, f=
alse); @@ -5556,6 +5559,9 @@ static inline int dm_set_vblank(struct drm_crt=
c *crtc, bool enable)
         if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
                 return -EBUSY;

+       if (amdgpu_in_reset(adev))
+               return 0;
+
         mutex_lock(&dm->dc_lock);

         if (enable)
--
2.25.1

--_000_MW3PR12MB4554808C9AA46660B75DF722F9AA0MW3PR12MB4554namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
No need since &quot;<font size=3D"2"><span style=3D"font-size:11pt">dc_allo=
w_idle_optimizations</span></font>&quot; will not do anything for asics bel=
ow dcn3</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Bhawan<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> January 11, 2021 10:01 PM<br>
<b>To:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Kazlauskas=
, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; Deucher, Alexander &lt;Alex=
ander.Deucher@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/display: Fix deadlock during gpu reset =
v2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Public Use]<br>
<br>
When using dc_allow_idle_optimizations, should it be guarded by CONFIG_DRM_=
AMD_DC_DCN?<br>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt; <br>
Sent: Tuesday, January 12, 2021 5:03 AM<br>
To: Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; Chen, Guchun =
&lt;Guchun.Chen@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.c=
om&gt;<br>
Cc: amd-gfx@lists.freedesktop.org; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha=
@amd.com&gt;<br>
Subject: [PATCH] drm/amd/display: Fix deadlock during gpu reset v2<br>
<br>
[Why]<br>
during idle optimizations we acquire the dc_lock, this lock is also acquire=
d during gpu_reset so we end up hanging the system due to a deadlock<br>
<br>
[How]<br>
If we are in gpu reset:<br>
&nbsp;- disable idle optimizations and skip calls to the dc function<br>
<br>
v2: skip idle optimizations calls<br>
<br>
Fixes: 06d5652541c3 (&quot;drm/amd/display: enable idle optimizations for l=
inux (MALL stutter)&quot;)<br>
Signed-off-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++<br>
&nbsp;1 file changed, 6 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 99c7f9eb44aa..858c6ff173ba 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -1816,6 +1816,9 @@ static int dm_suspend(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev))=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;dm-&gt;dc_lock);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dc_allow_idle_optimizations(adev-&gt;dm.dc, false);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dm-&gt;cached_dc_state =3D dc_copy_state(dm-&gt;dc-&g=
t;current_state);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dm_gpureset_toggle_interrupts(adev, dm-&gt;cached_dc_=
state, false); @@ -5556,6 +5559,9 @@ static inline int dm_set_vblank(struct=
 drm_crtc *crtc, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dc_interrupt_set(adev=
-&gt;dm.dc, irq_source, enable))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EBUSY;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;dm-&gt;dc_=
lock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
--<br>
2.25.1<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB4554808C9AA46660B75DF722F9AA0MW3PR12MB4554namp_--

--===============2085409600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2085409600==--
