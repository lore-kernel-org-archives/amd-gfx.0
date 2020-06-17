Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89051C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 21:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35C082166E
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 21:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4JkffX96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C082166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D75EE6E1B1;
	Wed, 17 Jun 2020 21:23:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CF5C6E190
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 21:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlZZeJKp2CPH9Y5LvnOuoI92XLcaSY+4ntKrKRJ9pTSPnLtd2GbI92EhcQUOYY+65JFgFnnFCgrRsTSbGWG1nCuky/Uz0dNy+VwWCBbStfMnZjuAGnHe1Q07cZolZLR0irMXgdJj6sZpve2OdjSKM4vRI28vcUNEIKT1Me9HCzH79L9yzbj2LPNcznvMEa46ctJsIai7VNahbCcgY8jHTqT6rX3NQf182SmvnfnqLWQkK0Dmpr3GmBpzDxxI3mvX2+l+PmZJygU3FEpFxsrYLxsxkuVvGsfGBKxjm2WG3g6W5qFhquGm/UjfuGGE9ZluC6M1CIjdS82AitK5qzhGuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+G0RZhLjLQkF4OXMnJvyHbtP1qHF70w0Rr7s76gKlI=;
 b=MOQuroDzzkuxrHCNQ3Ca26dMEOqXntG29+IQMVCQVe/VLc87o4yyx3iMpmk/fcj5O0YrI0o0+lAqYfLm1pJgFuXQnucH2Bq9iRXpnUU3l90hVbrL5259gRvmX5kH3UGOrh+kWKb6Qv9hgCZukq+rJbsz6jUwzMsJM+6+Ued+eZvuw6VIOlAPEn6VsGx+qDEkLwpNeo+t+O8ENd0g4wksgkNhlkydsSfxwojepE9VhDsbZfO0E5V57wAphvQ1t+haq3F7+Z7cNJqb97lPXANLCN8YK5qlQkUTVFTZ2As1OPJEK7d5SPban7cLyZPlRZ9Dtpz+Ju2AKP0TnZxPOTlm7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+G0RZhLjLQkF4OXMnJvyHbtP1qHF70w0Rr7s76gKlI=;
 b=4JkffX96qR5jBoJieLZJFe8tOx2PDVETrBsf6B8YGI/PbvYlxYYBnDXkkl7aZWLm4YUx3/9LkNk3ZbnxF9pACeGRbM/vtxXfiKOiCJyuec2MV5lDMTes+Cfc39VO+SVwis7Go7Cj+eaPVswB18z0kJ89JgrwnHgeJEwshQFw3hU=
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.23; Wed, 17 Jun 2020 21:23:34 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1c50:44e9:a4a2:2828]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1c50:44e9:a4a2:2828%6]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 21:23:34 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: vcn_v2_5_mc_resume_dpg_mode() can be static
Thread-Topic: [PATCH] drm/amdgpu: vcn_v2_5_mc_resume_dpg_mode() can be static
Thread-Index: AQHWROfD3LQi8CURgEq+QehOhCMVpKjdSQAAgAAIR4I=
Date: Wed, 17 Jun 2020 21:23:34 +0000
Message-ID: <DM5PR12MB25177405F2C3A749DC8C5F2DE49A0@DM5PR12MB2517.namprd12.prod.outlook.com>
References: <20200617204154.1199-1-James.Zhu@amd.com>,
 <MN2PR12MB4488D7A36893FEA8407114C6F79A0@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4488D7A36893FEA8407114C6F79A0@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-17T21:23:33.793Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.137.28.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8d31734d-2605-46bb-2933-08d81304b10c
x-ms-traffictypediagnostic: DM6PR12MB4316:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4316064326A4143ADE4E7D40E49A0@DM6PR12MB4316.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rQ0v0XUfqWsE7KrLW8vRbramKOogflTHsx3fqmpH5pA+9rOspukTLSxWsZOSamKiQXJO5GZDLOa5e5ut6v7T6uz/JlkHR6wpsNjAI2m2JYuyBM5kR9WaL6rHXFeCSfzroqci3or6Tq41KS4fiI0mmtAd3BeaOgwTBWWuWV0rA58/Y8jwjKo8S9MPQKLwb1eHlaBImmx1+vb7pAwxn89OTlu+aTKw3YbpAEVTXrjuUcIwx097Orgo9Tl5GLDaxff7vV8un8YvxnBzoM0fwM0S85aL4Lp0g0dWCjiL+/OlhhVo4OMzG0MWxaIY1vPc+pAon5cH8SIdW/gBx58jTg8MkRsyBLV9OpweLWy3pRClCww=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(7696005)(83380400001)(53546011)(478600001)(110136005)(316002)(45080400002)(52536014)(19627405001)(6506007)(86362001)(76116006)(5660300002)(8676002)(186003)(4326008)(55016002)(33656002)(9686003)(8936002)(66556008)(166002)(26005)(66946007)(66476007)(66446008)(71200400001)(64756008)(2906002)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: NYNSTSCBKjbp2+MXiOebmBiT6L4t5BxVRtVPjPd4W8RTwZacfp2FBhHpGjrpkyC9o8XRFYACFq+qYkjUJyBq2P72LXeAhhtNKBZOiDtXtFRjmPKysLi7XMFY+0F+X6VpX8UE66QIES5EQ7IDWPCsewK1omXO3cygS/Mz+2AhcXMnXGVNLr6eg3nO4D83TkzfdxJWCysgy+VfyGgnN8Vbv7HQ/7fZha3jvzonXmkm3G55YCMLVSfqe8ywPZ69eDkCKsBulrXcFkO4QA9hfY1J/LSS7kTvozoM9RbrvIWwC5mFruysddxLImx8A2P+ah3406lau6wWCMeA27cFrPAfwEkyu7p2bXjLkxknumQYO7rmHriVjfzFTfytUH/by13LjflU9lgGOKt5AmRLP0ngLR+lx/gBdRoFpBNC0QraTToe1BUCzvgxdY7xXPkMPRs/5vrtef1d5DKAsk3kSsZkoV0oJ4mBrdsJRqkb0RowHGE=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d31734d-2605-46bb-2933-08d81304b10c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 21:23:34.3476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKLr9CWuk2bq4eUg75mSfkYrGa8ElICZvy4LGo6AWsi7YJIfR31rj37fiaYEvV4W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
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
Cc: kernel test robot <lkp@intel.com>
Content-Type: multipart/mixed; boundary="===============0806031664=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0806031664==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB25177405F2C3A749DC8C5F2DE49A0DM5PR12MB2517namp_"

--_000_DM5PR12MB25177405F2C3A749DC8C5F2DE49A0DM5PR12MB2517namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

sure


Thanks & Best Regards!


James Zhu

________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Wednesday, June 17, 2020 4:53 PM
To: Zhu, James <James.Zhu@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Cc: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/amdgpu: vcn_v2_5_mc_resume_dpg_mode() can be stati=
c


[AMD Public Use]

James, please feel free to commit this.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of James Zh=
u <James.Zhu@amd.com>
Sent: Wednesday, June 17, 2020 4:41 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhu, James <James.Zhu@amd.com>; kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amdgpu: vcn_v2_5_mc_resume_dpg_mode() can be static

From: kernel test robot <lkp@intel.com>

Fixes: c422a628925d ("drm/amdgpu: rename macro for VCN2.0 2.5 and 3.0")
Signed-off-by: kernel test robot <lkp@intel.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_5.c
index 261afbb504bd..ba1c4fbc19dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -443,7 +443,7 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *ad=
ev)
         }
 }

-void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx,=
 bool indirect)
+static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int in=
st_idx, bool indirect)
 {
         uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
         uint32_t offset;
@@ -657,7 +657,7 @@ static void vcn_v2_5_disable_clock_gating(struct amdgpu=
_device *adev)
         }
 }

-void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
+static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
                 uint8_t sram_sel, int inst_idx, uint8_t indirect)
 {
         uint32_t reg_data =3D 0;
@@ -1300,7 +1300,7 @@ static int vcn_v2_5_sriov_start(struct amdgpu_device =
*adev)
         return vcn_v2_5_mmsch_start(adev, &adev->virt.mm_table);
 }

-int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx=
)
 {
         int ret_code =3D 0;
         uint32_t tmp;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Cd1a701be74ff4d1bdea208d812fee91d%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637280233359067907&amp;sdata=3DFvi%2FAILeziaKyd06O=
RW0tiscXDQy%2B8vOB6y0tqvmXaI%3D&amp;reserved=3D0

--_000_DM5PR12MB25177405F2C3A749DC8C5F2DE49A0DM5PR12MB2517namp_
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
sure<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Thanks &amp; Best Regards=
!</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">James Zhu<br>
</p>
</div>
</div>
</div>
</div>
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Deucher, Alexander =
&lt;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> Wednesday, June 17, 2020 4:53 PM<br>
<b>To:</b> Zhu, James &lt;James.Zhu@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> kernel test robot &lt;lkp@intel.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: vcn_v2_5_mc_resume_dpg_mode() can b=
e static</font>
<div>&nbsp;</div>
</div>
<div dir=3D"ltr">
<p style=3D"margin-top: 0px; margin-bottom: 0px;font-family:Arial; font-siz=
e:10pt; color:#317100; margin:15pt" align=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
James, please feel free to commit this.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Alex<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of James Zhu &lt;James.Zhu@amd=
.com&gt;<br>
<b>Sent:</b> Wednesday, June 17, 2020 4:41 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhu, James &lt;James.Zhu@amd.com&gt;; kernel test robot &lt;lkp@=
intel.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: vcn_v2_5_mc_resume_dpg_mode() can be st=
atic</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">From: kernel test robot &lt;lkp@intel.com&gt;<br=
>
<br>
Fixes: c422a628925d (&quot;drm/amdgpu: rename macro for VCN2.0 2.5 and 3.0&=
quot;)<br>
Signed-off-by: kernel test robot &lt;lkp@intel.com&gt;<br>
Signed-off-by: James Zhu &lt;James.Zhu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 6 &#43;&#43;&#43;---<br>
&nbsp;1 file changed, 3 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_5.c<br>
index 261afbb504bd..ba1c4fbc19dc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
@@ -443,7 &#43;443,7 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
-void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx,=
 bool indirect)<br>
&#43;static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, in=
t inst_idx, bool indirect)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size =3D AMDGPU_G=
PU_PAGE_ALIGN(adev-&gt;vcn.fw-&gt;size &#43; 4);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t offset;<br>
@@ -657,7 &#43;657,7 @@ static void vcn_v2_5_disable_clock_gating(struct am=
dgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
-void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,<br>
&#43;static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint8_t sram_sel, int inst_idx, uint8_t indirect)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg_data =3D 0;<b=
r>
@@ -1300,7 &#43;1300,7 @@ static int vcn_v2_5_sriov_start(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return vcn_v2_5_mmsch_star=
t(adev, &amp;adev-&gt;virt.mm_table);<br>
&nbsp;}<br>
&nbsp;<br>
-int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)<br>
&#43;static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst=
_idx)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret_code =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7Cd1a701be74ff4d1bdea208d812fee91d%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637280233359067907&amp;amp;sdata=3D=
Fvi%2FAILeziaKyd06ORW0tiscXDQy%2B8vOB6y0tqvmXaI%3D&amp;amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7Cd1a701be74ff4d1bdea208d812fee91d%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637280233359067907&amp;amp;sdata=3DFvi%2FAILezia=
Kyd06ORW0tiscXDQy%2B8vOB6y0tqvmXaI%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB25177405F2C3A749DC8C5F2DE49A0DM5PR12MB2517namp_--

--===============0806031664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0806031664==--
