Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB7EC33CAD
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 14:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C612207E0
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 14:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BL2BBVfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C612207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F9526E0B8;
	Mon, 13 Jan 2020 14:12:22 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680044.outbound.protection.outlook.com [40.107.68.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A0EF89EA3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 14:12:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9XiLLq5LePP+pNXZWtg2KOv6UHuaT1zxvTGhkpixQUfa0K1YQxUbGYzMHmJ9Sf6HvSv60hlaE4sL4q6JQi5ujMhdUACyfX5TmunHZVVaksPqBzvKVqySgD3t7dTBqhEZKL5kRu+iykf0o20WC3F9YkskevqWSu9+N5OYPu7xbI+tvOlYn/ImwWJSqQZIDxi7eP0G7SeSF6dWUsCmVcTTKmflFpIst3RAZ5mmampmQfHd7WH5/k8RC1Ula82+RyxL3tog1pIrQnF+dXbnAjXHqBa03knk82iGQHFP0jb9ILMkGz84KlmcyHczbfq4/YK1IenB9vzoSGpW9yHXQwCOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXNuCSTmfEWWjy7Kd1d7E1OIlqo8+hM/FAUOa1SFvbo=;
 b=EiWMFdBl17CIP150OLT/qOH1Ibxzl33NUIgn5dJH4i3grAr5WJ3nE6mu0hOgKp6UBY/9xe7Ufb8f2sdg/OaMSVhZJLBEQvWdRZReF+FBrMsR433uOMzYpTpqrRrTTDEABQp3AFrwbS11G9RkYJCwZJB6GAJGOX+82FWRLAXYZ2QaBc1WiOGteDMSW4AFfGFH59wvOp+nsLCu/rvRw4Dj9ZSh9pcXD4HwcM9AkrttyqsGbss6TcDP05GIfaJlLt2aZloGOMM2ZB036mkZm+vOUSZ4C2K6eUlA6/CebrwywHr5n9vJ8PJOQ1I3hXDIKMk+Ynt6ohmsXqfR5TisXZF81Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXNuCSTmfEWWjy7Kd1d7E1OIlqo8+hM/FAUOa1SFvbo=;
 b=BL2BBVfjIVFhYwS2wdD7D85sFphglOuHb28FOmskDq1UEg4afEJrdKWIUjVgDyzMIVawQOYls+VRymFniLbBkTbJaaRvelpCOgxBXDoe1ADzf+cHEJRztzvLYZBLsZNj9JRYThggakKfMTTfa8eOTcqcERWiLFJe6Bfef0dXoMM=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (52.132.246.86) by
 CH2PR12MB4149.namprd12.prod.outlook.com (20.180.17.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Mon, 13 Jan 2020 14:12:04 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::4874:d6a2:6327:aa2b]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::4874:d6a2:6327:aa2b%4]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 14:12:04 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhao, Yong" <Yong.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Fix a compiling warning
Thread-Topic: [PATCH] drm/amdkfd: Fix a compiling warning
Thread-Index: AQHVyBfKElNCL0cImUea96K+qI5QzKfopppu
Date: Mon, 13 Jan 2020 14:12:04 +0000
Message-ID: <CH2PR12MB391284BE83C985A9AF79D4B8F7350@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <20200111004032.30224-1-Yong.Zhao@amd.com>
In-Reply-To: <20200111004032.30224-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-13T14:12:03.843Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 77e0ec42-f77a-4731-9eb7-08d79832912a
x-ms-traffictypediagnostic: CH2PR12MB4149:|CH2PR12MB4149:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB41491721E6F654C6D047ED75F7350@CH2PR12MB4149.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:187;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(199004)(189003)(110136005)(71200400001)(19627405001)(2906002)(8936002)(966005)(478600001)(316002)(5660300002)(45080400002)(55016002)(33656002)(52536014)(66946007)(64756008)(76116006)(66446008)(9686003)(66556008)(66476007)(81166006)(81156014)(8676002)(86362001)(6506007)(53546011)(7696005)(186003)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4149;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lr+e7Jhed10MN/hZnYzMVW4PpdSVQ3gyAWpufjhIS6qVxFNn8VMJMkEwiA5x38TcQ1MM4m3723nN9artcBPPukISOn4xEiXDREVWhTyym9y8KD1eU/7EdTrQ7EpM1pSmlXkqTrXxpamq/yXYfKKhN7KvBh2NudCo8F0A+eWA0ILdPv7NmrOPaEIeWM74i5ZQDAyhumAa5mbFqtzXNZ7S68efQUuy9r/K9r+xp9/V2YV15zKKPTzOsKkq5OuB6c8uUW65ZKZCcK4KPZ9JB7n3ogAqH4S9m/Qc4C2+vcVN937S1ZO+hE0Jieu5wHwsPw01wLcWS76zaGN6VG+PPKhAvc0j5TKTpSMGlFznXLSOokT1Rl3WHB/rhIZy8ecWhZISvwM+GLtBpO9Yvhu0XziL1qHQmt+NaEoAqYtw51uVUvyXq6Qr07oqFNMdnBmzqm+gIUhtx6nZZORX9zqqKIDvNvhpMzUL7CVjOeDzpJ5G2MU=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e0ec42-f77a-4731-9eb7-08d79832912a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 14:12:04.5891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOTOIuhotzbFd7bmYgk+rGYnPGePnU0kNTzgWMOpQtIz+7Fl31vngyTQa10fLbZGkpKryjxESFol+16LoUm8WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149
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
Content-Type: multipart/mixed; boundary="===============1418748542=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1418748542==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB391284BE83C985A9AF79D4B8F7350CH2PR12MB3912namp_"

--_000_CH2PR12MB391284BE83C985A9AF79D4B8F7350CH2PR12MB3912namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

FWIW:
https://patchwork.freedesktop.org/patch/347923/

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yong Zha=
o <Yong.Zhao@amd.com>
Sent: Friday, January 10, 2020 7:40 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhao, Yong <Yong.Zhao@amd.com>
Subject: [PATCH] drm/amdkfd: Fix a compiling warning

The warning was introduced in

commit b4267f2e687ff5e0402ab915c9a4d47f9a4eb73e
Author: Yong Zhao <Yong.Zhao@amd.com>
Date:   Fri Dec 13 11:31:48 2019 -0500

    drm/amdkfd: Improve function get_sdma_rlc_reg_offset()

Change-Id: I87da4f1ad8a190327a4a71f0ff78812cb942d6e0
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 2b26925623eb..f9011a07cb90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -71,7 +71,7 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_dev=
ice *adev,
                                 unsigned int engine_id,
                                 unsigned int queue_id)
 {
-       uint32_t sdma_engine_reg_base;
+       uint32_t sdma_engine_reg_base =3D 0;
         uint32_t sdma_rlc_reg_offset;

         switch (engine_id) {
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C6428020902c0464fb20408d7962ee8c9%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637143000578441842&amp;sdata=3DVP7%2FbA3lxSX2l9Hx2=
TySiChP4VKBch2SQRNOei2wElw%3D&amp;reserved=3D0

--_000_CH2PR12MB391284BE83C985A9AF79D4B8F7350CH2PR12MB3912namp_
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
FWIW:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://patchwork.freedesktop.org/patch/347923/" id=3D"LPlnk7476=
24">https://patchwork.freedesktop.org/patch/347923/</a></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Yong Zhao &lt;Yong.Zhao@amd.c=
om&gt;<br>
<b>Sent:</b> Friday, January 10, 2020 7:40 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhao, Yong &lt;Yong.Zhao@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Fix a compiling warning</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The warning was introduced in<br>
<br>
commit b4267f2e687ff5e0402ab915c9a4d47f9a4eb73e<br>
Author: Yong Zhao &lt;Yong.Zhao@amd.com&gt;<br>
Date:&nbsp;&nbsp; Fri Dec 13 11:31:48 2019 -0500<br>
<br>
&nbsp;&nbsp;&nbsp; drm/amdkfd: Improve function get_sdma_rlc_reg_offset()<b=
r>
<br>
Change-Id: I87da4f1ad8a190327a4a71f0ff78812cb942d6e0<br>
Signed-off-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
index 2b26925623eb..f9011a07cb90 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
@@ -71,7 &#43;71,7 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu=
_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int engine_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int queue_id)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine_reg_base;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine_reg_base =3D=
 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_rlc_reg_offs=
et;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (engine_id) {<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C6428020902c0464fb20408d7962ee8c9%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637143000578441842&amp;amp;sdata=3D=
VP7%2FbA3lxSX2l9Hx2TySiChP4VKBch2SQRNOei2wElw%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C6428020902c0464fb20408d7962ee8c9%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637143000578441842&amp;amp;sdata=3DVP7%2FbA3lxSX2l=
9Hx2TySiChP4VKBch2SQRNOei2wElw%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB391284BE83C985A9AF79D4B8F7350CH2PR12MB3912namp_--

--===============1418748542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1418748542==--
