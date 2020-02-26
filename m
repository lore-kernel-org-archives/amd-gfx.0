Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B90DC4BA18
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 17:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1589824681
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 17:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rv3sCYQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1589824681
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED1E6EB47;
	Wed, 26 Feb 2020 17:44:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2877D6EB4D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 17:44:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOubHH7HIenA9bcQGk4pzd5zAAMbxAdEIZ52g7RNmm4osr+XdCV2qPmSNUnOGZvjsTAOH+bPM4wPEq2116ayFtoMTPiWx78J5bnHS8PBdJVMgBGifm3xLOO/WLgIqlgbx/YyT+XmJGJ5fkc/Q690DLMkkRdKkFafc2pgnuE28GsIJ1NfBx7zh7qu+Spn+McnDy7ul4xsEbKYe2HO4TFgeqtb0CHZdJIb6geQNz/wrDSztyvd0ntipLUFMRm1pelBEL+ZaKlgQnFLTa6SW7X58QBi7SBmK1dUajPrbjH9iv77E3RmWwSTRw3sPHdTewxhz34/yz6X741TRSf5+1hL8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEVlRRbKeZ1X0yjlsJ08Q3gRZATYpzm7XCwwk3vB3Jc=;
 b=KI+Z2AbZOlHKGyAO+GlLrmvJSj0AUFXXKlKXWQxf373Xht5cVdrSB0QKVpq1PJ28EdyAoSn4hvK1BvEkrBp3AEI1lP3pBVvIXakNpsQS9V2ozl7jbe7VqJCQQE/YIK+jTydWl3RKImGvjd+nckO0wBTJrQoEV42SSfHzGUNeym4zZqru1zl3Z1xrCH2QS57w8lDFOpFczi9ovsjJs5hrg510c2wx2nCLVVmRpePuO5vJN2sHDDpE61zinXLfwAszWtHc5SoXLT+Z/UXmC3P10WnlgVsEOCA4qpJzqk9GgmLymo7h8NL+GgekDke0El6huMRPnPQ7uwjjGeBG1Fh93Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEVlRRbKeZ1X0yjlsJ08Q3gRZATYpzm7XCwwk3vB3Jc=;
 b=rv3sCYQgRmSZYFX6iBx8KY1QL8GpfBZz3DZCBu7+wB8JmQ8o2xlN/H6VjBrcvX09DulFmt10i6U98D2a9qgpwCiMxgR1KjvKst6YTFYPALlbq3A4i7wBqXL3P1/Frh/k661KUDSgdPoz+5jgLL/CwtGq/Z0Kd52wl6LfvxF4Wfk=
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2PR12MB4005.namprd12.prod.outlook.com (2603:10b6:610:22::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Wed, 26 Feb
 2020 17:44:16 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 17:44:16 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: Fix 32-bit build
Thread-Topic: [PATCH 1/1] drm/amdgpu: Fix 32-bit build
Thread-Index: AQHV7Mf9e/d5z2xSJkWjKNgwaXJzgagtvw28
Date: Wed, 26 Feb 2020 17:44:16 +0000
Message-ID: <CH2PR12MB39268A92224C20A1A8BD011BF0EA0@CH2PR12MB3926.namprd12.prod.outlook.com>
References: <20200226171210.24347-1-Felix.Kuehling@amd.com>
In-Reply-To: <20200226171210.24347-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-26T17:44:14.688Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 23847f4a-98a0-4395-81ad-08d7bae37fdc
x-ms-traffictypediagnostic: CH2PR12MB4005:|CH2PR12MB4005:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4005EDF0026A116A0261310EF0EA0@CH2PR12MB4005.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:80;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(199004)(189003)(110136005)(5660300002)(7696005)(966005)(66556008)(81156014)(45080400002)(478600001)(64756008)(76116006)(66476007)(91956017)(66446008)(86362001)(66946007)(33656002)(81166006)(8676002)(6636002)(71200400001)(316002)(4326008)(52536014)(55016002)(19627405001)(9686003)(53546011)(186003)(6506007)(2906002)(8936002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4005;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f9oJNiB4Kna8m006uTeeu7ksNqtsH87Pk07ulh14lPL4UA4U5mwQY33sxFZjB/F82TndHqwVdaSgbUE1DOojrTQpfNn7ZX5McH0Hxu8ExZR7ztZ6vBfQqxj1ZpC6P04eceEvTmxFmxTg5+bG9ieMxPvzt2gUZRGYiXvk5oiBRYr9x1Olw0DkkE5lgYwjKwMx//uK3+fdCjp4Rj+wJB7SYBFCRePEAGqz2YwwQ+xuBbwPEouEtN4nuDIGCa/xr5+NkJbafVyTHx5y/VgyzE7u2wkvPrtvQjji/hzrxI5YMF5MIjc79aAoLvrIQEFzVC1JSYyVXzPd97OQISbQD2eGh4zqsdlKZ548J95Ulug4xVDwYteP1uIWX8OV5R9puozDOvuymLcf/9IsSvfrt7JFIDZ277kPAyfuIurqdGSO4jvTbHUrAs2HZv6nyE6qYQhvZZLCrM0hMh2ynSGoX4ODdfFsD3a+wYO2xyGpaPi+QE97b9DLmi/I5ry3J1Od53scPM7fSQQfbeMp4074jSCecA==
x-ms-exchange-antispam-messagedata: Hj15pYHxEM/DWSxP0uyvFDL8r3TYWO4aVEmT+ti5XcrGF2TxFiqg0HTHqVi/ci1EcjCCJ38A0X4V263yd7MXUIYZmn17znivlS07jOIeuHQ0gnYidgZ9R6nlyyNZDLu6gCe510EiA0+mBd5U/SDahA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23847f4a-98a0-4395-81ad-08d7bae37fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 17:44:16.0585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KQPTqLI3rl0tXGZtTKJVgSgphnxQSqmg+tA8XGrjVeDuWD3gfilfcBVzWVOx8AKX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4005
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Content-Type: multipart/mixed; boundary="===============0347742586=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0347742586==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB39268A92224C20A1A8BD011BF0EA0CH2PR12MB3926namp_"

--_000_CH2PR12MB39268A92224C20A1A8BD011BF0EA0CH2PR12MB3926namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Yong Zhao <Yong.Zhao@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Felix Ku=
ehling <Felix.Kuehling@amd.com>
Sent: Wednesday, February 26, 2020 12:12 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Cc: Pan, Xinhui <Xinhui.Pan@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: Fix 32-bit build

Add a dummy implementation of amdgpu_amdkfd_remove_fence_on_pt_pd_bos
for kernel configs without KFD.

Fixes: be8e48e08499 ("drm/amdgpu: Remove kfd eviction fence before release =
bo")
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index f30375c1b40a..bc2e72a66db9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -681,6 +681,11 @@ void amdgpu_amdkfd_unreserve_memory_limit(struct amdgp=
u_bo *bo)
 {
 }

+int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo)
+{
+       return 0;
+}
+
 void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
                                         struct amdgpu_vm *vm)
 {
--
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cyong.zha=
o%40amd.com%7Cdd32602c073d476434c408d7badf1ef7%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637183339778815696&amp;sdata=3DXa3G3wzAYp47cG0fEVW7G9pzgB4=
qfodkpcAG9dnNBOo%3D&amp;reserved=3D0

--_000_CH2PR12MB39268A92224C20A1A8BD011BF0EA0CH2PR12MB3926namp_
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
Reviewed-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Felix Kuehling &lt;Felix.Kueh=
ling@amd.com&gt;<br>
<b>Sent:</b> Wednesday, February 26, 2020 12:12 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/1] drm/amdgpu: Fix 32-bit build</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add a dummy implementation of amdgpu_amdkfd_remove=
_fence_on_pt_pd_bos<br>
for kernel configs without KFD.<br>
<br>
Fixes: be8e48e08499 (&quot;drm/amdgpu: Remove kfd eviction fence before rel=
ease bo&quot;)<br>
Signed-off-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 &#43;&#43;&#43;&#43;&#=
43;<br>
&nbsp;1 file changed, 5 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c<br>
index f30375c1b40a..bc2e72a66db9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
@@ -681,6 &#43;681,11 @@ void amdgpu_amdkfd_unreserve_memory_limit(struct a=
mdgpu_bo *bo)<br>
&nbsp;{<br>
&nbsp;}<br>
&nbsp;<br>
&#43;int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&nbsp;void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_vm *vm)<br>
&nbsp;{<br>
-- <br>
2.25.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cyong.zhao%40amd.com%7Cdd32602c073d476434c408d7badf1ef7%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637183339778815696&amp;amp;sdata=3DXa3G3wzA=
Yp47cG0fEVW7G9pzgB4qfodkpcAG9dnNBOo%3D&amp;amp;reserved=3D0">https://nam11.=
safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org=
%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cyong.zhao%40amd.co=
m%7Cdd32602c073d476434c408d7badf1ef7%7C3dd8961fe4884e608e11a82d994e183d%7C0=
%7C0%7C637183339778815696&amp;amp;sdata=3DXa3G3wzAYp47cG0fEVW7G9pzgB4qfodkp=
cAG9dnNBOo%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB39268A92224C20A1A8BD011BF0EA0CH2PR12MB3926namp_--

--===============0347742586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0347742586==--
