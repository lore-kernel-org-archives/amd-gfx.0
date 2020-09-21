Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18963C4346E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 18:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80FEC20888
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 18:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FQbD2jrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FEC20888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE6FF6E50C;
	Mon, 21 Sep 2020 18:55:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46DF16E53E
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 18:55:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjLggB1RiLYwGyvyG4cZ6kI/k9abo51RMY51lNwylzR4l2kN5+27TvTngZUjpyvVG7r8ZZ3PPvY6lqi7KA/Vh0Yl1WNw0HgY95kHYzfN6pTSEKNNg4Is4eDWXiZCzzuDMi9865N66kIss/qiisDBfjSirpSvi5M98gnWFiAz6kjChvVUVEZBmObADgz0/8a4TLOM+0AX5UYMWBTCm4XirwryMTme17X8fpkg8wFT/YYWYDJNVilfX5BRvnKkflr849GUr63wstJP1o6/pUptMvKCqvJSx13+IEZ0fjs1OLlBpJZJ1fmfpl5uAVs0tu3PJ8UzHdRtn0wyEow3AYGTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FR3EI8z4A9TMnbYsHEJYzM6JFH7JC2P6RPpjnJ+gbE=;
 b=BDBxRMCQw0IuMZu8S3C7AWij1lFVsA+8IYzyNiTAYbXk75/vNALqdk49MIgYKOe0Fj6HcYDL/YXmXLYr1nwL94oTfliDsApyZcMcxPoBigbpc66tOyod3goEjmMm0XqnEv09listD10ZW+VAKlGkK13IJzoSJiXOTZXdw3jZ5yxDP8iKFypnW5IEdVVTlNHparJ/azFzLwDHCWcznVIMMKaGPqZhiCmEuc4AJzdtOLQCsjERJGegvMoE6geqxs0t/Z99IQxZ4CfTUwAIpaLhxXQSShflH8eIWdXJtM+AGnhXkKBcV5FnYpiDOSOdwxL0lgcMecPm4nkJKXqM+Lznqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FR3EI8z4A9TMnbYsHEJYzM6JFH7JC2P6RPpjnJ+gbE=;
 b=FQbD2jrvTfz6yrKPhl8iGwvyvxUWqJReJuG91Mu+hbsV3B0LJEaeuT6hZBAmxW1OOSSoMFliLxZNBhTsw9oIyLufCsasmb7R9rsunJUd+0wdAm0L9gOyEzDG2nV9aKaMCYV75YO3OlwA8ue8LdH0r/GZ22X4JCulwkwCh0qLL1Y=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 18:55:23 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3391.019; Mon, 21 Sep 2020
 18:55:23 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/pm: drop redundant watermarks bitmap setting
Thread-Topic: [PATCH 2/2] drm/amd/pm: drop redundant watermarks bitmap setting
Thread-Index: AQHWj8HwcibzuPwQvUqTOiBsUgu8w6lzcfbx
Date: Mon, 21 Sep 2020 18:55:23 +0000
Message-ID: <MN2PR12MB44882DFF88E30623FC5E994FF73A0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200921024948.15164-1-evan.quan@amd.com>,
 <20200921024948.15164-2-evan.quan@amd.com>
In-Reply-To: <20200921024948.15164-2-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-21T18:55:23.340Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b6759d39-b1d0-4723-957f-08d85e5fe58e
x-ms-traffictypediagnostic: MN2PR12MB4093:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB40933359D46F6A9363694AE0F73A0@MN2PR12MB4093.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bOHam/BvSqYZOiBpxHI0aaZTCzthziAKOdaLhGUj5ig6YV5Q/eBjytxGl8Lj527rA9z4gToJnnalFEkImhRtVmPHinsq3dj3f47RNd5FsFAKH47umiq/V4nWJCd7KfG1IebDJqdbloKgqrpUzPkfXj+M9Ptc2yadHjRJfZJp+b3Bm4j1A240GdF382xyIN4WdDDSsD5VrwLbWYyqi9AiWDw4Lra6nMfKDNnsFnWiyoISUhV260eRxK4tLxcI8ltc9EacAZnQ7Bddh9V8QMx2wt0ORkrW4y+RsKcX5eVa3tRKo8rBAT4XL+iLLPC+gY+Uui+6RnzDOsK/jvL5/PVk8rIcOVZnV1alJNMFcaH9T17wlhr4QXGlZCoiFRqXQHlW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(86362001)(55016002)(26005)(19627405001)(76116006)(66946007)(71200400001)(33656002)(8676002)(66476007)(9686003)(64756008)(66446008)(186003)(66556008)(83380400001)(110136005)(2906002)(5660300002)(316002)(7696005)(52536014)(478600001)(8936002)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: wZtelOH3YK3p5sHHCAKxgAszJcdu259rPGEA3RYkxcCSj3gm2ElEdk85IMPR+4g/8oWKWUqRhugcUAR6mrvQSRDWUkkMPa51tmmkZ2Ct+npOTW6lvqwslKOlcXzsXkYylhT28YZLovyXvWiZ3REDPXmWqrst+Z9trsFEq6DC1vH0ssgLV4/HyA+0Uu3+KsddG4DsXfscHa9y+lmiUVnGSN4fA44mnI4eA9xy113l9YMy4AvGa6iciY7w2tMepJZ7NsoanmkrjrbHko0Z9FSi/fA83MSB/GIxHafq/AEfZXWAKxt0PDALp+AqOK4dXatrAFXNW80WczuPGY/Etz0+pXqmfTxnCtSWiNk44+zSIjnVzZPMkyrIl6a9DcJQqGXA4rCB1E5hTjvJBMCVmQR8n3knt04towRh56XdkFHq5oOFg0toWv5cfNrRC3LEIMex1/h3LTSxAhmWUF7uXyFTPSyxKvjJ4CTwHGDRKV4Hf+lbc1bjRbBOL21d+KmjWx66o3qRENbfp3Jx3NmCs08HjaCXHy6rZKTscmfGOwDX4Ofs+tigNge5eHTurv6NMgrMXo90XvvgUR6bJc32uXyWLQRBailMlnfmBoIdbwbKVMKErb+xcga2FzVFaR8GMqE2UMZCLFLHRVKNfohzqkVnog==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6759d39-b1d0-4723-957f-08d85e5fe58e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 18:55:23.8379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CmnnI7w0PsdZrL/mc/HWnRc24GpZCP3NdlAyGb6lLklZmonbsutz6EO88SYuYa8virqi0BNCH89ZOdGG1QjKlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
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
Content-Type: multipart/mixed; boundary="===============1342480426=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1342480426==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44882DFF88E30623FC5E994FF73A0MN2PR12MB4488namp_"

--_000_MN2PR12MB44882DFF88E30623FC5E994FF73A0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Sunday, September 20, 2020 10:49 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH 2/2] drm/amd/pm: drop redundant watermarks bitmap setting

As this is already set inside the implementation of
smu_set_watermarks_table().

Change-Id: I4d4d40855f0aad43f6d21d471b64f1c7e696f0e7
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 002bae81b856..ef10be599d37 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1838,11 +1838,6 @@ int smu_set_watermarks_for_clock_ranges(struct smu_c=
ontext *smu,

         ret =3D smu_set_watermarks_table(smu, clock_ranges);

-       if (!(smu->watermarks_bitmap & WATERMARKS_EXIST)) {
-               smu->watermarks_bitmap |=3D WATERMARKS_EXIST;
-               smu->watermarks_bitmap &=3D ~WATERMARKS_LOADED;
-       }
-
         mutex_unlock(&smu->mutex);

         return ret;
--
2.28.0


--_000_MN2PR12MB44882DFF88E30623FC5E994FF73A0MN2PR12MB4488namp_
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
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Sunday, September 20, 2020 10:49 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/pm: drop redundant watermarks bitmap se=
tting</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">As this is already set inside the implementation o=
f<br>
smu_set_watermarks_table().<br>
<br>
Change-Id: I4d4d40855f0aad43f6d21d471b64f1c7e696f0e7<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 -----<br>
&nbsp;1 file changed, 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index 002bae81b856..ef10be599d37 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -1838,11 +1838,6 @@ int smu_set_watermarks_for_clock_ranges(struct smu_c=
ontext *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_set_watermarks=
_table(smu, clock_ranges);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(smu-&gt;watermarks_bitmap &amp;=
 WATERMARKS_EXIST)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;watermarks_bitmap |=3D WATERMARKS_EXIST;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;watermarks_bitmap &amp;=3D ~WATERMARKS_LOADED;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;=
mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-- <br>
2.28.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44882DFF88E30623FC5E994FF73A0MN2PR12MB4488namp_--

--===============1342480426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1342480426==--
