Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716F0C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 20:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20BA021582
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 20:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="laVAycH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BA021582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E37BB6E116;
	Wed, 17 Jun 2020 20:53:54 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770055.outbound.protection.outlook.com [40.107.77.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A62B6E116
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 20:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKBcigdDH361jGFDguixM1HjUYmR9H5pNWFwA6RQWIfLlgnYNRm5GWF/mjahd7tTvWWlqDzmyBMolUZnnX3dC+yikUoi7Ky9t6jxP6xFuTJJwYPOmNXgZwquCvi5xgJ92WHnCKSuVCqQwnZVnz5hGpgOB6LZlcvYh6dGTbmezvo/CmhDUkoxhnh22kXp9cgfxaKpDU3mLO9QsG1B/fhRh/ezBIgsEzGFwZ+BBvIjHFR2z6raUOSQLYolKtMiDEn37EE+jbnH2OcfhVe4U1Emu0KEhqoJN6E/zZxmOOYQgbpzIlq/bpctlI/lgbk8DcUudlmpxjiN1dMnpNf0dMPVWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9yI/93qH9xusjvVFhuf3blh+/PGFkb9HAJ9Tex+7rg=;
 b=DC4KT5bdHpOQm+DWaLNjRb6tSf2J/UYjN3xI0i341kxHuPFT0OqvmRVpWyY8kevDkaCOZ++L15ovSP5aQQWs3YF5H3vdJ6aNPuaNWp1C92RX99n1Yq8ONuDFfed2QvmdNu4hqqy3qcu+EiA6DMm3Cq6o3TKigR1Cqo6gvgF2xs18hUS56DwcQPRTws1Ae8vEVrFkbtQe+0LLxR63d1cTkOAb/7Pv06q7p7DCWIN5KWZrOQMNJfmOyv4zGF2ua287CDy19NIz5nCOnXsRvE54kulpndoAu05SsQeLSicHfnDWA225IYQTnqc7F4QtdZZ+8HuI9IS/RT+e+dHXjnxusg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9yI/93qH9xusjvVFhuf3blh+/PGFkb9HAJ9Tex+7rg=;
 b=laVAycH2WGSa4hTcWLjKD6axqOQM5a+dqavCuHR0pWhdHEtK5DeW0kt4uAOP21wquHDrQrdJ+AjO2wYeqRGYY1Mkm/oA7mnFENHjIa3wIDtSXTzAybc0NoS810nVwJwto5e8QiEbo62e0eoKDybC+52mfbLYnN9J3mzuiDgMROc=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 20:53:52 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72%5]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 20:53:52 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: vcn_v2_5_mc_resume_dpg_mode() can be static
Thread-Topic: [PATCH] drm/amdgpu: vcn_v2_5_mc_resume_dpg_mode() can be static
Thread-Index: AQHWROfJKts7eXiWukulI0jgMhDe06jdSNv/
Date: Wed, 17 Jun 2020 20:53:52 +0000
Message-ID: <MN2PR12MB4488D7A36893FEA8407114C6F79A0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200617204154.1199-1-James.Zhu@amd.com>
In-Reply-To: <20200617204154.1199-1-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-17T20:53:51.817Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.51.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 26b83c91-cc58-4ddd-feac-08d813008aec
x-ms-traffictypediagnostic: MN2PR12MB4376:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB43765E5BAB0AFC7FBA5CA663F79A0@MN2PR12MB4376.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +leFs9QMhXqy40iIFD6jE1TKgBkaeNJRIRf+bClDSyXeZlTkwSjnfF1QdhsZzHoIS3Nk+TdFVIA5injbUjzYwHYHHwoYxptgEd7rJ/UflZEiDiGmwGFRHWSrJQ+zu8pU68L8/1AnRBXnQfwQxuzLznvgP5PrCswJ2OeKryELuefwERyS4gesWBIGhp6OacMdmB9IAfAxzf7+aZmS0PJ0GoSJ6Vtn91JFyjL8qrMQ6+RXQVmJWT/e0gvkjbfyCZ6ho4Wn41XIav8EKwEeKVYpoVdofi/qh58+TQOSZNQLs2GOVHB2Id3qWvNxbr6tLKfnxEXLbOezjLtqkkXRdliUODARRiPc3xvRtxcQeN6gr8Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(52536014)(9686003)(966005)(45080400002)(55016002)(26005)(2906002)(6506007)(53546011)(478600001)(4326008)(5660300002)(110136005)(71200400001)(19627405001)(8936002)(8676002)(86362001)(316002)(186003)(76116006)(66446008)(66946007)(64756008)(33656002)(166002)(83380400001)(7696005)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: FSm9PIq4k3mn4vDPh57dUABFppjyUfqiMXyBJzTIQY3wnaWdkZkeEph868MBoo3SGz3OKL8EQwV+QHy/qBx64KagY7uzxi2t0CgBuS1YenU9Fc8nz7V4Kt2y9RGv1B4I8LGlkz6pBh1Vp/l6kB+9HHRabN/2oWxK5+g/M17pOxIXggGK6WlArmYLKt3hMVz0Yibq2BLZg4+nirGS97dLOxBtEErps7lX13m+cAbpFrGXnVBmg86QCVqLJRPm8hqVgdmVAk7vsWnn9uwvKKZq2jtbuBtdU9jAIw4Dqx45uMI9bot0cWyGbD/7BiNwJDH2nVnmwSeI5dE+73+9B8/3sz2zsXin0RHwen/r2BLA5339bGxaDdwk/RQlKI3rklonrxhYP1b1Aba74VC68SCexoUTM00tMpIjZnzR2IXqcmLS/JOQuiGk4moqbQ/w9+24/4Ur1UMyoSF3nbRsbHWao5U6W1UY0a/oVTxfJUB03vAOwkihgL/12JDrEvTY5Nqa
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b83c91-cc58-4ddd-feac-08d813008aec
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 20:53:52.4242 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FGetTB/tT0b6kXT7uRalMFK0IQfh91xZfgvH6svfQUEyBfia+OvQTPzhxF/MZgHPOO+s0FWri3z+OvbFlLZulg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
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
Content-Type: multipart/mixed; boundary="===============0923998485=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0923998485==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488D7A36893FEA8407114C6F79A0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488D7A36893FEA8407114C6F79A0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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

--_000_MN2PR12MB4488D7A36893FEA8407114C6F79A0MN2PR12MB4488namp_
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
James, please feel free to commit this.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of James Zhu &lt;James.Zhu@amd.c=
om&gt;<br>
<b>Sent:</b> Wednesday, June 17, 2020 4:41 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhu, James &lt;James.Zhu@amd.com&gt;; kernel test robot &lt;lkp@=
intel.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: vcn_v2_5_mc_resume_dpg_mode() can be st=
atic</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: kernel test robot &lt;lkp@intel.com&gt;<br>
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
</body>
</html>

--_000_MN2PR12MB4488D7A36893FEA8407114C6F79A0MN2PR12MB4488namp_--

--===============0923998485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0923998485==--
