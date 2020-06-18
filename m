Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_LOW_CONTRAST,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1A6C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 08:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF38D2085B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 08:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uUwN5m6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF38D2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4B4E6E3A6;
	Thu, 18 Jun 2020 08:25:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF8FB6E3A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 08:25:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+0LZoVGXEz+4FcAtIwkqAoZR0AGroZ+vz5vju18sFtI/YSxGL+37zPUJcEyAhQvG02tIRQPtYKoo/h1BMdaek+c69hb6NZlTCk58t2XJU1oj4QHt2+Pw30uStBBBg/4rkMFt/GoXtCFZOB/eomI/wvQ6s1gdRxYpg1nG7rWYzrOiqDcwnahcQgeZafRzHw7eF7EpATAQmtD6ksCUZ+i8+ZKxTRmNnugLTiU5/yETAZ9RyKP0HeJL5YkOdaYsF5QqLhjNtKkWSLw+cklUtn2yMnh4D3ZKjE7EnpndoeRY7EmSiwqEoKVhREhse+8Y7iM35nPABl7UZ50gvJGnsOVaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zv1VmAwvS2Bj+hVm6dfWiI4ZNebI4cA7ANEbDA/cYNk=;
 b=dwCHPDHdDVUt9AvUA9MLnoJXr08iBAzoo3vaViPxrTQjOhDp1L2/lG0bzTCYci4RGF5q0LOEqIztwlKgTsGCO26bXqVNq+kuZDZVA9rKZzZjodXnFWY4KmKBZ63JqCEHWmI0M+7oNYuCcFfo7TAhNdUVgdcE3MvSGOpTv4BUckq2b7SI2AdL40MkKOsdC05vvLT++afza4XmlkjsCioXM1HHjDQOjFslQOCIPoy9AqKU1oUWFHjComSnG5cuAVWLqNpGV91RLfDlPDsivYjQX6AA5NJVTcH9qwLXl8WcD2hVPWlzDzZ0bcSTgJC7IWt8vJqEqAuXJ24hFohSNLbBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zv1VmAwvS2Bj+hVm6dfWiI4ZNebI4cA7ANEbDA/cYNk=;
 b=uUwN5m6j9/7aw/coZoK9i1RHiMu45/hk530Y6KPPPNGOCDxVjzcCB8u8ALbw6F/Nm5siR9WiVAffC1gooYh9JyM7KYLzHkaPG62rW4635o31eO14keIwYPPsWnGn7pkB7FtEkZaO75TJpRCwxZ6AfTOw3UQbi6AI1tsKB2QJTW0=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3200.namprd12.prod.outlook.com (2603:10b6:208:102::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 08:25:10 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6%3]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 08:25:10 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0
Thread-Topic: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0
Thread-Index: AQHWRUWyyxt0twhDmECVwlQ36PPmrajeCMCJ
Date: Thu, 18 Jun 2020 08:25:10 +0000
Message-ID: <MN2PR12MB3022D32C41B32F413AEFF151A29B0@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20200618075307.3721-1-Wenhui.Sheng@amd.com>,
 <20200618075307.3721-2-Wenhui.Sheng@amd.com>
In-Reply-To: <20200618075307.3721-2-Wenhui.Sheng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-18T08:25:09.544Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.246.142.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 424b107c-b73a-4c55-e232-08d813611daa
x-ms-traffictypediagnostic: MN2PR12MB3200:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB320079750993814C49939CF8A29B0@MN2PR12MB3200.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bQexLnZBX4ipjHTnrE2eKMOM+GEjvvxywO8GNuzFUzdupLEtVo/6AwsXQg/BL0HNMqfLlQ+ExExdy6D4RUTC6xuWQ0Sn44tMBP4c6++zButhHHuLZ4jSBqhitb2EqmAHZ2go6haUaLwJeBF0Jy7WQXbcay2mRJbd+DF4Y9D4JLXTZt9jnCULHme4SHgI3Bj9dU3kDZfz3A++jpRhBgsf+sM/bwUOrpDHIwMpnKqCoZfYpPoRjpbNmgyqBHzgfB9LmlXbpbG05kPcMacJFrJateqMc7HXrLgRNG4zOP37C3Bl4eY0lAIQLAlBRq708k9TlvPXLeVpK6MizWru+MHk/jF/dQDW3MjqB7Krstcg9O8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(2906002)(26005)(966005)(7696005)(55016002)(186003)(66946007)(33656002)(110136005)(5660300002)(316002)(76116006)(66476007)(91956017)(64756008)(9686003)(66556008)(66446008)(53546011)(6506007)(478600001)(45080400002)(52536014)(166002)(83380400001)(8676002)(8936002)(71200400001)(86362001)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: lezXad+d3yvx6V7gMCA9t339ZLutmZ8BlU+ESr5v8V/vWmfEMP/K0nrSrEpU53VOUf55+pkpa+6eGag5X4YvA5oAhqNN9lA/GjtjhP+SP3RCpcdJOXQ5OpFZNzI2Q37D2XGxwpF7sRy+Z4gEsIExMxifYqJdaiBisjK7A7ssROL4J7bbySWoxFAbBgev1U3X+0mWVUhUUG5JKXyrryUC0a13Qybf34+LmE+vOYSMl83aUr74ux+HWN8qN2JmRUQ26sa34hz1VosUbLs3wpmCGCMlhfd320Gfjuuw8UUgWUvHftyPcVP1PhIcRCrgNKcbwbKB1fzOXh0UXcV5EzyQ0HztyLrLRp2QqyJJ3JJEiCTyJE70s5lpgrrwni7OAy4k62jpGxIAnb8pr3vzfxuRdm02l0H0iNcTXkuj991avStPV+hn9STdnkSEGTw3YBU9rkBsfjaYwR6BXwpTo38ZXTcVFZ2hqKsDDK3cQQ9fMB0=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424b107c-b73a-4c55-e232-08d813611daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 08:25:10.2129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 21851qsFTbmW2DG27vvtYPnLX+eHYA++ieXKndBIanpMQP6S0iPuNooAYeSbnQ9i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3200
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
Content-Type: multipart/mixed; boundary="===============1706938194=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1706938194==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3022D32C41B32F413AEFF151A29B0MN2PR12MB3022namp_"

--_000_MN2PR12MB3022D32C41B32F413AEFF151A29B0MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]



________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Wenhui S=
heng <Wenhui.Sheng@amd.com>
Sent: Thursday, June 18, 2020 3:53 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Sheng, Wenhui <Wenhui.Sheng@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0

sdma v5_0 fw isn't released when module exit

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c
index 58d2a80af450..6751ad69ed90 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1299,8 +1299,12 @@ static int sdma_v5_0_sw_fini(void *handle)
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
         int i;

-       for (i =3D 0; i < adev->sdma.num_instances; i++)
+       for (i =3D 0; i < adev->sdma.num_instances; i++) {
+               if (adev->sdma.instance[i].fw !=3D NULL)
+                       release_firmware(adev->sdma.instance[i].fw);
[kevin]:
the kernel api "release_firmware()" will check argument (is NULL pointer).
i think the patch don't need to double check it.
+
                 amdgpu_ring_fini(&adev->sdma.instance[i].ring);
+       }

         return 0;
 }
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7Cd0b8b72e0be443a7343d08d8135cb093%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637280636699912801&amp;sdata=3DHrKVAmRO0HKFZBRG6oWq3thNl=
GBd0T9bMramDU1ijys%3D&amp;reserved=3D0

--_000_MN2PR12MB3022D32C41B32F413AEFF151A29B0MN2PR12MB3022namp_
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
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Wenhui Sheng &lt;Wenhui.Sheng=
@amd.com&gt;<br>
<b>Sent:</b> Thursday, June 18, 2020 3:53 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Sheng, Wenhui &lt;Wenhui.Sheng@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">sdma v5_0 fw isn't released when module exit<br>
<br>
Signed-off-by: Wenhui Sheng &lt;Wenhui.Sheng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 6 &#43;&#43;&#43;&#43;&#43;-=
<br>
&nbsp;1 file changed, 5 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c<br>
index 58d2a80af450..6751ad69ed90 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
@@ -1299,8 &#43;1299,12 @@ static int sdma_v5_0_sw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;sdma.nu=
m_instances; i&#43;&#43;)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;sdm=
a.num_instances; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;sdma.instance[i].fw !=3D NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firm=
ware(adev-&gt;sdma.instance[i].fw);</div>
<div class=3D"PlainText"><span style=3D"font-family: calibri, arial, helvet=
ica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-color: rg=
ba(0, 0, 0, 0);">[kevin]:</span><br>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: rgb(0, 0, 0)">
the kernel api &quot;release_firmware()&quot; will check argument (is NULL =
pointer).</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: rgb(0, 0, 0)">
i think the patch don't need to double check it.</div>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ring_fini(&amp;adev-&gt;sdma.instance[i].ring)=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7Cd0b8b72e0be443a7343d08d8135cb093%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637280636699912801&amp;amp;sdata=3DHrKVAm=
RO0HKFZBRG6oWq3thNlGBd0T9bMramDU1ijys%3D&amp;amp;reserved=3D0">https://nam1=
1.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.o=
rg%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40am=
d.com%7Cd0b8b72e0be443a7343d08d8135cb093%7C3dd8961fe4884e608e11a82d994e183d=
%7C0%7C0%7C637280636699912801&amp;amp;sdata=3DHrKVAmRO0HKFZBRG6oWq3thNlGBd0=
T9bMramDU1ijys%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3022D32C41B32F413AEFF151A29B0MN2PR12MB3022namp_--

--===============1706938194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1706938194==--
