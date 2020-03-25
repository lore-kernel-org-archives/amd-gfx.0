Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA7DC43331
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 10:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3326206F6
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 10:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KF8FWZBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3326206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A80496E7DC;
	Wed, 25 Mar 2020 10:44:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 459996E7DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 10:44:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBndTNoTJchN2LtQSOZVHowBakokYa4lwQYQAy6OkLYMgiMkbaI4HyXlTnrhHL27hC+/fXdDxFjDeC1FG9yuMzaKNvZOYfMPPjLbuJxfpvE4AocSI6dVD+o4Be6dmS2NIbMBV9UCFH6cNO6wQJKsztJII7ChJc0UoF5srVTx9Jic42GOMTocfwDdycKJgCEMonb7GWhm4QCfJdXkp/xY5o97yGccR0jyT4ca5UstN4kRbvGH+AsU5VtAsWuxewdT7j61cq+WEeRsvrAWrxpBB3lP5QrN9N73qUECHd1Idoa/tmhGkS1Uc8OS0wtrk4i9VeStAFKbZVsoh2Dob2FwIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DZejPogMgiH8PIRrWCF4ANqisT8BsoDdMNXD2VANOM=;
 b=mpfVP0hJeh+1WRHw1cX71GBUF0FufxX/pmtXjySQgVtuwwq1w32fenPJPgINQ6vfUTZiKLcdeSuv803cRyvee9es0O1tyJ7vjAS9OVN00eOedbjItGzvKX+fNisQPUb5ZhZcWISy5rVcUn0wq3kSx9NmbRkMiBBeASEYmOY1GCs7U3qJPwsRw8rCPSSI9khiDvwdoBCjD7ZRDhSbd5VVKK7XJhaAhC+m32O4Zp6PUJZ+9fcW1u4ZnnANFrhBilPXxInIuJ2S5cMCVzBLZHJTKwNu89emr773aFqUNw3mcnNs1ZmrnQhjpeVD4jQJpkUnqWQ8aVCKjNQxESOZKBr/OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DZejPogMgiH8PIRrWCF4ANqisT8BsoDdMNXD2VANOM=;
 b=KF8FWZBiCLpdwL1YFbVpy9BbJWU78J8991H1ES7Cm0ZrcMxSrPfco5MfoTOSIC+CP6cFejUBAovPOs91bacyWJUflRBir/bHOuKM9f+K8aoY8liMJsYS/TL8xjQtOaHsV1sAKc51LDdh8JK30yHeIznvqHNp8t0wQ6PU71UpbWM=
Received: from BN8PR12MB3283.namprd12.prod.outlook.com (2603:10b6:408:9f::28)
 by BN8PR12MB3073.namprd12.prod.outlook.com (2603:10b6:408:66::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 10:44:14 +0000
Received: from BN8PR12MB3283.namprd12.prod.outlook.com
 ([fe80::f4b1:f244:5157:d457]) by BN8PR12MB3283.namprd12.prod.outlook.com
 ([fe80::f4b1:f244:5157:d457%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 10:44:14 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix hpd bo size calculation error
Thread-Topic: [PATCH] drm/amdgpu: fix hpd bo size calculation error
Thread-Index: AQHWAo7jo42vHHVMjkCC3oWE5+0s7ahZGyoAgAADlLM=
Date: Wed, 25 Mar 2020 10:44:14 +0000
Message-ID: <BN8PR12MB3283615631DFCA853AB574E4A2CE0@BN8PR12MB3283.namprd12.prod.outlook.com>
References: <20200325101848.8524-1-kevin1.wang@amd.com>,
 <ddf95fc7-daa7-4df4-8610-bc6b1f5b6125@email.android.com>
In-Reply-To: <ddf95fc7-daa7-4df4-8610-bc6b1f5b6125@email.android.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com,Hawking.Zhang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-25T10:44:09.973Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kevin1.Wang@amd.com; 
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a8f8c2c-3d71-4fd0-2ee0-08d7d0a97622
x-ms-traffictypediagnostic: BN8PR12MB3073:|BN8PR12MB3073:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB307344D441415449778BB9B5A2CE0@BN8PR12MB3073.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(186003)(55016002)(478600001)(4326008)(86362001)(5660300002)(316002)(2906002)(81166006)(6506007)(26005)(52536014)(110136005)(33656002)(8936002)(76116006)(8676002)(9686003)(7696005)(6636002)(66556008)(64756008)(66446008)(66946007)(66476007)(53546011)(81156014)(71200400001)(91956017)(19627405001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3073;
 H:BN8PR12MB3283.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Cdo/yCbqrNS9Q0OMzpomW8hEzJ7pt5dYot91+wdtU7aV4OAwYQc5B0kyLFZuLoRSVY33TdBJVD/EybNUebXfSlI155/xuPgSo6CgUd51aXdOqrZ7uXQJZv2Bp1LElmfRjxajMfhATo+n4TW9BSGWUpe29bimzWYGNoNTaoB0OyTBzuaKpUBZyZA6FxBE6OBFHCwTmfPhb1N+zO7u/ZuT4l86wOOOA9sL2HMoipme0OukSRC4wcDAKwVEbryMbrpGpJE5kwfVSMBm5IvY5KEZZm80k+KLYc/s1TFfp+nZ3Uy8vzPqQFnru+9usSj4rqmVNq37QPjOUn/df/F89pbByYDDhF+A5sCccbZlqcwvlbVnFObmdlQpfqEQtsjzngsx3V+4zo2RMIf6Pw9qLZOZaCfKrfT1rrrvdrnjeREYVpo/OiUrf/wx7+f6BJCnAbL
x-ms-exchange-antispam-messagedata: qj2ZSvCLJ1jZsUG4fqpTyNhorlya2Cp9ibJFTkG/Fc1gI0XtBwhoI1gilffiCjKv1JogHjFv8+NPMJ5Dw+KvLRz892ZuvDpD081x2wRdMKRGIh6+1Ji7ZNNw+mcSkaOeCxYgF6ofhGwYXEZTv4HMRA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8f8c2c-3d71-4fd0-2ee0-08d7d0a97622
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 10:44:14.4567 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HhTr3Fdsb3UQ9evnLmIBrQ9lpVU5QbbKfkELYmvQgWEAQwd6gUcEODWSHsLz/s8B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3073
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
Content-Type: multipart/mixed; boundary="===============1342294297=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1342294297==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN8PR12MB3283615631DFCA853AB574E4A2CE0BN8PR12MB3283namp_"

--_000_BN8PR12MB3283615631DFCA853AB574E4A2CE0BN8PR12MB3283namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

thanks chris.

@Deucher, Alexander<mailto:Alexander.Deucher@amd.com> @Zhang, Hawking<mailt=
o:Hawking.Zhang@amd.com>
from the view of driver, could you help me review it, then give me a RB.
thanks.

Best Regards,
Kevin

________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Wednesday, March 25, 2020 6:28 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Feng, Ke=
nneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com=
>
Subject: Re: [PATCH] drm/amdgpu: fix hpd bo size calculation error

Good catch! mem.size is actually the backing store size (usually in pages).

Patch is Acked-by: Christian K=F6nig <Christian.Koenig@amd.com>

Am 25.03.2020 11:19 schrieb "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>:
the HPD bo size calculation error.
the "mem.size" can't present actual BO size all time.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 7f9ac1a14e6f..91c82383b016 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1113,7 +1113,7 @@ static int gfx_v10_0_mec_init(struct amdgpu_device *a=
dev)
                 return r;
         }

-       memset(hpd, 0, adev->gfx.mec.hpd_eop_obj->tbo.mem.size);
+       memset(hpd, 0, mec_hpd_size);

         amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
         amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index fb567cf5671b..01b22dad52fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1946,7 +1946,7 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *ad=
ev)
                 return r;
         }

-       memset(hpd, 0, adev->gfx.mec.hpd_eop_obj->tbo.mem.size);
+       memset(hpd, 0, mec_hpd_size);

         amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
         amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
--
2.17.1


--_000_BN8PR12MB3283615631DFCA853AB574E4A2CE0BN8PR12MB3283namp_
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
thanks chris.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a id=3D"OWAAM471300" class=3D"_1OtrSZdhKXVv3UhaivrdJ4 mention ms-bgc-nlr m=
s-fcl-b" href=3D"mailto:Alexander.Deucher@amd.com">@Deucher, Alexander</a>&=
nbsp;<a id=3D"OWAAM172244" class=3D"_1OtrSZdhKXVv3UhaivrdJ4 mention ms-bgc-=
nlr ms-fcl-b" href=3D"mailto:Hawking.Zhang@amd.com">@Zhang,
 Hawking</a></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
from the view of driver, could you help me review it, then give me a RB.</d=
iv>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
thanks.</div>
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
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Wednesday, March 25, 2020 6:28 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Deucher, Alexander &lt;Ale=
xander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix hpd bo size calculation error</=
font>
<div>&nbsp;</div>
</div>
<div>
<div>
<div dir=3D"auto">Good catch! mem.size is actually the backing store size (=
usually in pages).
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Patch is Acked-by: Christian K=F6nig &lt;Christian.Koenig=
@amd.com&gt;</div>
</div>
<div class=3D"x_x_gmail_extra"><br>
<div class=3D"x_x_gmail_quote">Am 25.03.2020 11:19 schrieb &quot;Wang, Kevi=
n(Yang)&quot; &lt;Kevin1.Wang@amd.com&gt;:<br type=3D"attribution">
</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt">
<div class=3D"x_PlainText">the HPD bo size calculation error.<br>
the &quot;mem.size&quot; can't present actual BO size all time.<br>
<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp; | 2 &#43;-<br>
&nbsp;2 files changed, 2 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 7f9ac1a14e6f..91c82383b016 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -1113,7 &#43;1113,7 @@ static int gfx_v10_0_mec_init(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hpd, 0, adev-&gt;gfx.mec.hpd_e=
op_obj-&gt;tbo.mem.size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hpd, 0, mec_hpd_size);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_kunmap(adev-&gt;=
gfx.mec.hpd_eop_obj);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(adev-&=
gt;gfx.mec.hpd_eop_obj);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index fb567cf5671b..01b22dad52fd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -1946,7 &#43;1946,7 @@ static int gfx_v9_0_mec_init(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hpd, 0, adev-&gt;gfx.mec.hpd_e=
op_obj-&gt;tbo.mem.size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hpd, 0, mec_hpd_size);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_kunmap(adev-&gt;=
gfx.mec.hpd_eop_obj);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(adev-&=
gt;gfx.mec.hpd_eop_obj);<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN8PR12MB3283615631DFCA853AB574E4A2CE0BN8PR12MB3283namp_--

--===============1342294297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1342294297==--
