Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC95C10F27
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 13:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A206F20873
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 13:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B8mBuNhm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A206F20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7240A6E97B;
	Wed, 11 Mar 2020 13:35:17 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700076.outbound.protection.outlook.com [40.107.70.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F1189C6C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 13:35:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYaXbNZCdwocn/DUSiKFTdiTvHifwfaBNu5yOyImB11QpwHS2O/l7egMyu29Cv/SZAY6JV3WT1cv3O2m9zDAoPIPihX9zN+3BVoWVUVkWvS/zcrU8u3vmcyMn7dbsQ9Zqc0kTUU5C/Ch8ndRABnezOIXUxL+BmNC+Bv16AAxHi6r2WZy92ph038hp7Jt9KbeyYAdFckLTJL9eBTkMw5rVSl7ytvaejQH32x0lcbfX+PQEE5ceQ4Za1lU6/KG87hfQ3nqf8j8DfCdgXQ1oo/G0kQ8HpPn1NGQ+Hr+Resac5eEOGTweQ2YI/QKemC2G6zR+gPWG8VNpXW5ENK99KCjyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOMruEncACrO+abDqNggelGkwTGjc9ot375S4H6huWs=;
 b=GpACvPL1NPLPd0f/1IJMJk2RggeqHtiZwblrLe4/35fkXhHtahKB4Z9N9TM5DDDPQyB606Snq0i8kNTc0C/n/OTfj1UbafMM5sLil3jb8AF8le7YMbaWjYoKJqO5EaZPpNaS/PftRkMMYBJn3QEIYFIWmKQjqMMziHgqvDJ/6UGUP4pWucw7534CzPLtRjOV97GLSSdr9wjvT4mhHqc5aM8hk/logIGwhiXPuAJ1fgcGYhZ3Jo6UtH6xhCUdhW5hsxjk3Xz1keB+yP4QbXm0pXjeiv/qobKa//QcFzhSj5IQAhaZmjaHjjJTZ+qaPpjCedzlCghbbmLEhhZgg1tFeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOMruEncACrO+abDqNggelGkwTGjc9ot375S4H6huWs=;
 b=B8mBuNhmf1AvTvQZUFsnXpbGZvnjoyhv7N1KMONJ+GpHlJ7pDgVDHvscTK7ri/t1okbHFpR5IFlrOwnkVPHu8vZeISLA99AxNeRzlnjJE4b7VgE7C8O4bdh8Ed2Qv+aMN0SkDyVct0+eKp5LoDf6GzOcXMAbyFYPu3N4yun/2xg=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3887.namprd12.prod.outlook.com (2603:10b6:208:168::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Wed, 11 Mar
 2020 13:35:13 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 13:35:13 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: add fbdev suspend/resume on gpu reset
Thread-Topic: [PATCH] drm/amdgpu: add fbdev suspend/resume on gpu reset
Thread-Index: AQHV933Xo2joSqKP1kKhywydJkQYF6hDZH85
Date: Wed, 11 Mar 2020 13:35:13 +0000
Message-ID: <MN2PR12MB4488E518F55ED00D6DE0D4F1F7FC0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200311081853.25274-1-evan.quan@amd.com>
In-Reply-To: <20200311081853.25274-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-11T13:35:12.601Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 861464d3-5b82-4345-4dba-08d7c5c10722
x-ms-traffictypediagnostic: MN2PR12MB3887:|MN2PR12MB3887:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB38877F2DF339024423E03533F7FC0@MN2PR12MB3887.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(199004)(9686003)(6506007)(7696005)(316002)(19627405001)(110136005)(45080400002)(53546011)(55016002)(52536014)(478600001)(8936002)(71200400001)(966005)(26005)(66946007)(81156014)(66446008)(5660300002)(2906002)(66556008)(64756008)(33656002)(15650500001)(86362001)(66476007)(76116006)(81166006)(186003)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3887;
 H:MN2PR12MB4488.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: myqmo+rFrMjCvAyt7LHWIi+BZl1aht+cCgUbNk3ALGyf90s6rcdPi435h+GVg4DIdQ83pGwjVcP9wJdqan9xekJ9MISG4o9eZcs57ficynQUrWzWy/dYrBbAKP3j9awtXlDI3+MQpVUDYfy5jwoc7SHvM2qTHct4f3yEnqfcYeV5+8EJJjiZwzsS2bWZEyfcOlydgQTedyt6drzgdwzCIGb0jkv7wvc2+agzus6GJEiRat5UXJ+0MKkOzd4w8gBT9dduvGZ/aIItTtL2J+mG7qcgFkLmk5R5k6ZiWjqhUgIN7BoE8Tdb1sRfA+m3K+106WZYYRVoCo3wxTkY7D1vlvDW7D5nxCE0n5BN3S4CLoM4nrcLHR++MqKW4ozOQ/Jp70MA79tRT4s8bluk1tTwEBhEY3aCNPvO1xcTvfpK4Crwt8FNDWn9UHdsIpAYN1PmJn4NyVjBdo1tJjbMuGdvdiTmYvjRa6AvoYEeVOtrZ5pC3kQfuHMGznVhnjL4X+/rGQO9ticGCZeOVHyrAbGFCg==
x-ms-exchange-antispam-messagedata: X+JMvqSqOn/ZuINzsh4F0TMT34VTCCawffoDyO2jBrQ+fa94VFIGiHdEwWO+S3wj/VsGkxlQE9SaiMLLUMLF18hFPWtUVrcbVWlOpi1ug2VIFEVRUneXQAw/m5gSm2Ax2x7UsyfJ2GqhVvxVtVz0Ow==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861464d3-5b82-4345-4dba-08d7c5c10722
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 13:35:13.3560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jO96hbkzEPmG//npdwuJuoHsmFklTwUDgro5R3RbGHojl8xPJR4M/MPfdJA2yPS6qHG8cENh/JlF4qSG4z3nnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3887
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
Content-Type: multipart/mixed; boundary="===============1328035057=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1328035057==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488E518F55ED00D6DE0D4F1F7FC0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488E518F55ED00D6DE0D4F1F7FC0MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Evan Qua=
n <evan.quan@amd.com>
Sent: Wednesday, March 11, 2020 4:18 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amdgpu: add fbdev suspend/resume on gpu reset

This can fix the baco reset failure seen on Navi10.
And this should be a low risk fix as the same sequence
is already used for system suspend/resume.

Change-Id: Idb4d02c5fcbbd5b7817195ee04c7af34c346a053
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 572eb6ea8eab..a35c89973614 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3935,6 +3935,8 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_in=
fo *hive,
                                 if (r)
                                         goto out;

+                               amdgpu_fbdev_set_suspend(tmp_adev, 0);
+
                                 /* must succeed. */
                                 amdgpu_ras_resume(tmp_adev);

@@ -4108,6 +4110,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
                  */
                 amdgpu_unregister_gpu_instance(tmp_adev);

+               amdgpu_fbdev_set_suspend(adev, 1);
+
                 /* disable ras on ALL IPs */
                 if (!(in_ras_intr && !use_baco) &&
                       amdgpu_device_ip_need_full_reset(tmp_adev))
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C3eace080fd0b4f67337e08d7c594e441%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637195115932121013&amp;sdata=3Dmy797McW90E%2FJKHa3=
0fYgLlzHvnN%2BYQ3%2BqBLwllajJ0%3D&amp;reserved=3D0

--_000_MN2PR12MB4488E518F55ED00D6DE0D4F1F7FC0MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Evan Quan &lt;evan.quan@amd=
.com&gt;<br>
<b>Sent:</b> Wednesday, March 11, 2020 4:18 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add fbdev suspend/resume on gpu reset</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">This can fix the baco reset failure seen on Navi10=
.<br>
And this should be a low risk fix as the same sequence<br>
is already used for system suspend/resume.<br>
<br>
Change-Id: Idb4d02c5fcbbd5b7817195ee04c7af34c346a053<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 &#43;&#43;&#43;&#43;<b=
r>
&nbsp;1 file changed, 4 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 572eb6ea8eab..a35c89973614 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3935,6 &#43;3935,8 @@ static int amdgpu_do_asic_reset(struct amdgpu_hiv=
e_info *hive,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto out;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fbdev_set_suspend(tmp_adev, 0);<=
br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* must succeed. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_resume(tmp_adev);<br>
&nbsp;<br>
@@ -4108,6 &#43;4110,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_unregister_gpu_instance(tmp_adev);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_fbdev_set_suspend(adev, 1);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* disable ras on ALL IPs */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!(in_ras_intr &amp;&amp; !use_baco) &amp;&amp;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_=
need_full_reset(tmp_adev))<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C3eace080fd0b4f67337e08d7c594e441%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637195115932121013&amp;amp;sdata=3D=
my797McW90E%2FJKHa30fYgLlzHvnN%2BYQ3%2BqBLwllajJ0%3D&amp;amp;reserved=3D0">=
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calex=
ander.deucher%40amd.com%7C3eace080fd0b4f67337e08d7c594e441%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637195115932121013&amp;amp;sdata=3Dmy797McW90E=
%2FJKHa30fYgLlzHvnN%2BYQ3%2BqBLwllajJ0%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488E518F55ED00D6DE0D4F1F7FC0MN2PR12MB4488namp_--

--===============1328035057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1328035057==--
