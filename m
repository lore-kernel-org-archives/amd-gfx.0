Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AF0C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 15:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B81B206F8
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 15:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UozPDoFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B81B206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0CEC6EC1E;
	Fri,  3 Apr 2020 15:52:40 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700045.outbound.protection.outlook.com [40.107.70.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FF626EC17
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 15:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAOT21imDuNmNA9uDp4W97H797jMrnanfijHum1jp3okrZdzZEV6oiV3n7Ft3Ja1mmp3lZtQxLFSrZg+OmojRnApK5jaMRVsZyraYkDUuSqpO3kSv7/OVbLyVEI22jdyZlB4z71qu8KV4JiMddh3KjwWom2V+UC5y5uqxYcg2bEedobCyb/eQIrHelsPcF7Ma8Opx68cqqVG1H0ouCVjzyMwVsvVdD5zXnyfN3i8JZa/likYO6EYUxhKv2dlmaAiiCKJ48473e8cKGIXUosagV+2O9pRMckcCTLZa6SHhwqWQw6ZPADtVOVAXnWqAkhb0HOX5mTEjov3K2kiOE/afw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEKmGSakkpDl4CPlTsQw4z007cxPASGTz5/VJry7ZPw=;
 b=NmS5P4M/Id/lZCGrKHjCusQsFJ+eAIBiN7dHZkg6blOfOYRVaTIIvOQ9f5OotQqR+EO57sd4ek06TdyGvDcbN0yzrvGf8ktRyGHWM6wFs4jwAazZg4A0inh7t+LVNP4YLs+zK4X/M8/ZanjeVMeR1jwqZyxDEk9p1aArdRE2kOS1ZPbbrKaonQXRhQ4N1/uXEotUOAXjbg8hD5RLsmQrViQ3hS97sfeDuWqUVOsvf8jP8QmKY3Ti5XqM/yvGEBvy9htF20GjoVpkcal6YgI5uK2/vGAWE4rLoh2NToCqyrA0reQMGdqueD4K9sUwZkCi3apqcqs6NgMCQ0uLtsOqGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEKmGSakkpDl4CPlTsQw4z007cxPASGTz5/VJry7ZPw=;
 b=UozPDoFL4ej0liI5od1Q4XCraqKq9s1Taayp44M6jTWm6oevw5fPbPR6Y5PzObzWAbW2ThLPVl/SsLD2/5eTKypZx+mUBAUVroI+8Xhxe5sQotJzzaQWOLTDJJD/6yD0TcvAMZ2dn9nUXoBg+ZRm1noSaHZ4FX592GwdkyIjj/I=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3631.namprd12.prod.outlook.com (2603:10b6:208:c2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Fri, 3 Apr
 2020 15:52:37 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2878.014; Fri, 3 Apr 2020
 15:52:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Re-enable FRU check for most models
Thread-Topic: [PATCH] drm/amdgpu: Re-enable FRU check for most models
Thread-Index: AQHWCcZL7hiObKPXmEShY1d3Vy0yQahni49R
Date: Fri, 3 Apr 2020 15:52:37 +0000
Message-ID: <MN2PR12MB448829E6575102EB81E95690F7C70@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200403144329.30127-1-kent.russell@amd.com>
In-Reply-To: <20200403144329.30127-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-04-03T15:52:36.539Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df705037-cac0-4689-580e-08d7d7e7084d
x-ms-traffictypediagnostic: MN2PR12MB3631:|MN2PR12MB3631:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB36314A8EE1F93121CE499FCEF7C70@MN2PR12MB3631.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(7696005)(45080400002)(33656002)(55016002)(81166006)(8676002)(2906002)(9686003)(81156014)(76116006)(66946007)(8936002)(966005)(478600001)(66476007)(66556008)(64756008)(66446008)(53546011)(6506007)(19627405001)(316002)(71200400001)(186003)(110136005)(26005)(86362001)(5660300002)(52536014)(170073001);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 43nmapGVoS4wFjZi/VMqE21Pt+aGYbEhnMtn+4D9iAbuAs1fR/F7pNmOj7A5pKDPsvOJL1bVsRLO6cCb1jqHS5PoS024UTbvM6vEHj5S5YyDzTK7LGeok7Lypv1fVwFoiYr6ZAZ4DTTAfhySd/z2aUnS5zElNf+987yFxUi1C9jjYk8mNZGfKV1MeiWpaFXR1yqjbvBQTS/wjkdVoWWo1pLlaA6urzLrehZMgep5KepfdNFWOvM70Gk/fRxs5P7EdtmuBUBxdeVLj6yktVPw1EEYN6rO3llvJpCyu0u5vl7nXSGE5Da9P05RStCwACatTs+8XxE6aDMsG39/KN/IXC67Xs0N21bc1J5hmYtjqw+sDmcri02cHZkCFpLmqAtznndZPLhZiGRiEeY5iTVVpnCF/j0+ahHjzgDsH1zMFv82/zLEwXZVaw6SKg1tZJTXUyyzbtbsZzDLklfdGha12bG3tk++nDQvMZb1uW71B/eEmkbWu8nSpp1IqnHgozSs7uTYUOSS7deohiRYN1OTNw==
x-ms-exchange-antispam-messagedata: 69wALXYVBU7IkAnBdQUIra6x/vjJtaJAFz7eo6GJRvD0yPqEHLDeWfAkDj6JWdqnNwKSjxqnGhFglpj63FctAfR4FhZd1twHflEYZ8KtBOLs/nolWOJz5Tqin8/vpzNACtVjVGB7DAHGqspXUa7tvw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df705037-cac0-4689-580e-08d7d7e7084d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 15:52:37.1932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xgETwN2pXuEEEpnZ0ClWSo7n/kCIrYdpjeH/pFsdqFgo9F4eb5OznP4XRj7iKnl6FhKuXzvz6HVOPXvv76nn3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3631
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
Content-Type: multipart/mixed; boundary="===============0363884596=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0363884596==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448829E6575102EB81E95690F7C70MN2PR12MB4488namp_"

--_000_MN2PR12MB448829E6575102EB81E95690F7C70MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Does this need to be protected by a asic_type check as well or is just the =
vbios version enough?  Will we have other asics with D360 in the vbios vers=
ion?

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kent Rus=
sell <kent.russell@amd.com>
Sent: Friday, April 3, 2020 10:43 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH] drm/amdgpu: Re-enable FRU check for most models

There are 2 SKUs that do not have the FRU on there, and trying to read
that will cause a hang. For now, check for the gaming SKU until a proper
fix can be implemented. This re-enables serial number reporting for
server cards

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c
index bfe4259f9508..281bdfd4630a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -31,9 +31,20 @@

 bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 {
-       /* TODO: Resolve supported ASIC type */
+       struct atom_context *atom_ctx =3D adev->mode_info.atom_context;

-       return false;
+       if (!atom_ctx)
+               return false;
+
+       /* TODO: Gaming SKUs don't have the FRU EEPROM.
+        * Use this to address hangs on modprobe on gaming SKUs
+        * until a proper solution can be implemented
+        */
+       if (strnstr(atom_ctx->vbios_version, "D360",
+                       sizeof(atom_ctx->vbios_version)))
+               return false;
+
+       return true;
 }

 int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C97d3aa4c34464592264508d7d7dd69a0%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637215218317453581&amp;sdata=3DABysYVGVyaYWc2Huebw=
GNdPbOkvC%2Fmmduk4EMROoDfw%3D&amp;reserved=3D0

--_000_MN2PR12MB448829E6575102EB81E95690F7C70MN2PR12MB4488namp_
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
Does this need to be protected by a asic_type check as well or is just the =
vbios version enough?&nbsp; Will we have other asics with D360 in the vbios=
 version?<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Kent Russell &lt;kent.russe=
ll@amd.com&gt;<br>
<b>Sent:</b> Friday, April 3, 2020 10:43 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Re-enable FRU check for most models</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">There are 2 SKUs that do not have the FRU on there=
, and trying to read<br>
that will cause a hang. For now, check for the gaming SKU until a proper<br=
>
fix can be implemented. This re-enables serial number reporting for<br>
server cards<br>
<br>
Signed-off-by: Kent Russell &lt;kent.russell@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 15 &#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&nbsp;1 file changed, 13 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
index bfe4259f9508..281bdfd4630a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
@@ -31,9 &#43;31,20 @@<br>
&nbsp;<br>
&nbsp;bool is_fru_eeprom_supported(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: Resolve supported ASIC type =
*/<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_context *atom_ctx =3D=
 adev-&gt;mode_info.atom_context;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!atom_ctx)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: Gaming SKUs don't have t=
he FRU EEPROM.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Use this to address hangs=
 on modprobe on gaming SKUs<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * until a proper solution c=
an be implemented<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (strnstr(atom_ctx-&gt;vbios_ve=
rsion, &quot;D360&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(atom_=
ctx-&gt;vbios_version)))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrp=
tr,<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C97d3aa4c34464592264508d7d7dd69a0%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637215218317453581&amp;amp;sdata=3D=
ABysYVGVyaYWc2HuebwGNdPbOkvC%2Fmmduk4EMROoDfw%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C97d3aa4c34464592264508d7d7dd69a0%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637215218317453581&amp;amp;sdata=3DABysYVGVyaYWc2H=
uebwGNdPbOkvC%2Fmmduk4EMROoDfw%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448829E6575102EB81E95690F7C70MN2PR12MB4488namp_--

--===============0363884596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0363884596==--
