Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B733C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 14:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D92923E1F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 14:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y+FZByU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D92923E1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C901E89C1B;
	Mon, 29 Jun 2020 14:37:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6352989C1B
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 14:37:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRa43Ga3jPLDZEfmnD+0OoDTazpteILb2RqqYfv59Cy7sLOM15/QNKGwQEfuA94njNsznpI21fYCJOF9SP8o/iNim9utCBsebnWQAGo7LpAJTprqSj+eUEhIdL1ytzg3m8lH5Cal7bGiCDyzW3Fm4AnbQKzTczC0iOfir3dlneYOBTeBBieVh0afSBdptNb3GFNpwCFLvCUfwtPBvd1eMuC+qKi+YJVG82MQSAYvvO85mDL5g0lJ36d2K6EvcNInpvh9LtwE/5KKHL6nm1DwyDDvsjTddApOp9soczHEpYQuc9OgCmwwQWchD/okDv5JPMb895VBQH3oPdBnYvGGdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNuyIJp4Mz0QbqnSpc2HC6dtFtPXCKH1wATEt73EPQg=;
 b=XFdRjmX077SRXUHKWsi63BbCXprGc9X64k4g/eTWujar/OlysdSFO+T3XZW/freMu+vHMFyo3lo8HSS6ZwmXrBg4Vjn3ljREuCRBrd+BNUvrCMms8WPkoXX3d0BFo5fBqzhwQEDNQMmlM5k/GX2lgpJe7dietXVTpz7jJ0WY2ANOQ5wH9/4uaaYWvQfTPmiTb7IupsTHxWGUA/PSC06Bdo8IzNws7300K8amwH9vLsXZH2cfaRofK65wGQdEFDc2zxBRe9sJb0mSFBri+cWvTfPbHzcVTBTO6J4DIIjpdS6sDpD+sXagPDTfrlHasQIjfcRmjgI5TNUePqjz+hrgdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNuyIJp4Mz0QbqnSpc2HC6dtFtPXCKH1wATEt73EPQg=;
 b=Y+FZByU6Qxgs0kBW2bmzzHF2ipglJpxXsqn26GfFPZQ7c9SajTlrdnyNya0r9s/HvLyZQZUnMUOExxTEJy+aTrp+zu41hFQdq5uDhAcqaiwrPk80rJGzBflszBlsy283Dea9/TEL+Di0GA1TCnL7bGSQWBlp7YIeSWKtu94RWtE=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Mon, 29 Jun
 2020 14:37:04 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72%4]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 14:37:04 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: correct discovery_tmr_size init val
Thread-Topic: [PATCH] drm/amdgpu: correct discovery_tmr_size init val
Thread-Index: AQHWTdvQnLCfpzwf70e5qwOZpX/7oajvqaZi
Date: Mon, 29 Jun 2020 14:37:04 +0000
Message-ID: <MN2PR12MB4488237C351C569CBDDDEAA1F76E0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200629060746.21697-1-Wenhui.Sheng@amd.com>
In-Reply-To: <20200629060746.21697-1-Wenhui.Sheng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-29T14:37:04.088Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.51.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 424c2559-a2f1-41bb-44f9-08d81c39e498
x-ms-traffictypediagnostic: MN2PR12MB4158:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB415800F60DA37EDDFCF07B07F76E0@MN2PR12MB4158.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EiVB13AVNq041IrAM5PsKdglvvwUMclrTtQUKJ9TeZg8qkVIxvtdK/jbMAdcPUC19UByZ1ws4zbhQrl3qUmgbrkl46R8LAB+0Db9BiP3ouI9mpnNVva8bbJ5CPw40aNv51ZnCVMEZPUrjJPi9q5HomwE/mfbpbCCsxq/mVdo2LvMOntGs8NnXZFD39fdxuxdjIp6W60NdOMLeadK/uXg6PkExmG6kyitAtAHEkbsdJ7XI/EoEYPPJdKnI06BqitojBU1VLOeiKPjQw++KG1+wOOhxRtRLmgQIo+ki65KPkWzc6S1OehOTzeBKGYTY8cKrXU/nk0ibcnoYtslsJRViI95dYPMWx6AKGsOV9yx2oQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(19627405001)(83380400001)(33656002)(8676002)(166002)(316002)(110136005)(45080400002)(966005)(478600001)(6506007)(66556008)(186003)(76116006)(64756008)(26005)(66946007)(5660300002)(9686003)(7696005)(66446008)(66476007)(2906002)(86362001)(8936002)(4326008)(52536014)(71200400001)(53546011)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: IKtWo3d9J564t9L75mOY/N1UtV/ocDp9Ib6zq7ilkq8vJ9zfUqzMErhhqkQh7xOvk5RtecyPbFLzWUioQDrqrhxxLs4gFdHARu2Z1ob7xXJ8w/nlTY+cpu+TCkl9sXUnNVmpz5JWqoNI815gB+yCWU7krdn6H1tdctMdbojnz306Gapu3iFdhMmPMueRKM+sx4Trwvfe+pe7y520xNn3bi6KibIyfwnsCeqokiR+5ThpTwv2gQWakeUjBv9NGfNM7DStT2ox4tBzAmZLHRWEgyUuJaRC9taZaHbvGs88Yim+JFXuBwb75oDlqUrPRKbu2MVDfcvdeXMLT+DowEsO3cVBZrPR6HOraeqZ/qdOC02OTN+vELnnGVR82HLpv8MQICpLYD8LDxKVoiTPNdowvXF7H1HqOye63D0x86zd9U336Z1JEYZX585yeUV/lKYqVerWPB1W/XdELXrgSyG1UxQukY4dNq8Q/3p1wDEc9hgzNAmFmcuvu/0qTtDURWLV
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424c2559-a2f1-41bb-44f9-08d81c39e498
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 14:37:04.6086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4parKbLttdDUsWanNoNkvY9Ps4PKkEetHHHnKnC3u0lOFvkoNR5od6dOKbkTVCelkYZB+S1g7c29SaxmGZ3u3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1116493760=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1116493760==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488237C351C569CBDDDEAA1F76E0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488237C351C569CBDDDEAA1F76E0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

You might want to add a comment to the code here.  It looks wrong to use th=
e OFFSET.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Wenhui.S=
heng <Wenhui.Sheng@amd.com>
Sent: Monday, June 29, 2020 2:07 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Sheng, Wenhui <Wenhui.Sheng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd=
.com>
Subject: [PATCH] drm/amdgpu: correct discovery_tmr_size init val

From: Wenhui Sheng <Wenhui.Sheng@amd.com>

The legacy way to initialize discovery_tmr_size
is using DISCOVERY_TMR_SIZE, while after we reduce
DISCOVERY_TMR_SIZE from 64KB to 4KB, variable
discovery_tmr_size is also reduced to 4KB, this is not
correct, it still should be 64KB, discovery_tmr_size
will be used to calculate ip_discovery reserved mem's
start address and size.

Using DISCOVERY_TMR_OFFSET to init discovery_tmr_size instead.

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 7d51768684dd..56beafbd3ab9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1872,7 +1872,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_devic=
e *adev)
         adev->discovery_tmr_size =3D
                 amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);
         if (!adev->discovery_tmr_size)
-               adev->discovery_tmr_size =3D DISCOVERY_TMR_SIZE;
+               adev->discovery_tmr_size =3D DISCOVERY_TMR_OFFSET;

         if (mem_train_support) {
                 /* reserve vram for mem train according to TMR location */
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Cba68c480e1fc4e73952408d81bf2ca8a%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637290077543935012&amp;sdata=3DR0g%2FzsOg%2BoH5%2B=
ccXgnGAhRd0JfMgCTuXlv6yuIQSVuY%3D&amp;reserved=3D0

--_000_MN2PR12MB4488237C351C569CBDDDEAA1F76E0MN2PR12MB4488namp_
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
You might want to add a comment to the code here.&nbsp; It looks wrong to u=
se the OFFSET.</div>
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
ounces@lists.freedesktop.org&gt; on behalf of Wenhui.Sheng &lt;Wenhui.Sheng=
@amd.com&gt;<br>
<b>Sent:</b> Monday, June 29, 2020 2:07 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Sheng, Wenhui &lt;Wenhui.Sheng@amd.com&gt;; Zhang, Hawking &lt;H=
awking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: correct discovery_tmr_size init val</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Wenhui Sheng &lt;Wenhui.Sheng@amd.com&gt;<br=
>
<br>
The legacy way to initialize discovery_tmr_size<br>
is using DISCOVERY_TMR_SIZE, while after we reduce<br>
DISCOVERY_TMR_SIZE from 64KB to 4KB, variable<br>
discovery_tmr_size is also reduced to 4KB, this is not<br>
correct, it still should be 64KB, discovery_tmr_size<br>
will be used to calculate ip_discovery reserved mem's<br>
start address and size.<br>
<br>
Using DISCOVERY_TMR_OFFSET to init discovery_tmr_size instead.<br>
<br>
Signed-off-by: Wenhui Sheng &lt;Wenhui.Sheng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index 7d51768684dd..56beafbd3ab9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -1872,7 &#43;1872,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;discovery_tmr_siz=
e =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;discovery_tm=
r_size)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;discovery_tmr_size =3D DISCOVERY_TMR_SIZE;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;discovery_tmr_size =3D DISCOVERY_TMR_OFFSET;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mem_train_support) {<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* reserve vram for mem train according to TMR locati=
on */<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7Cba68c480e1fc4e73952408d81bf2ca8a%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637290077543935012&amp;amp;sdata=3D=
R0g%2FzsOg%2BoH5%2BccXgnGAhRd0JfMgCTuXlv6yuIQSVuY%3D&amp;amp;reserved=3D0">=
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calex=
ander.deucher%40amd.com%7Cba68c480e1fc4e73952408d81bf2ca8a%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637290077543935012&amp;amp;sdata=3DR0g%2FzsOg%=
2BoH5%2BccXgnGAhRd0JfMgCTuXlv6yuIQSVuY%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488237C351C569CBDDDEAA1F76E0MN2PR12MB4488namp_--

--===============1116493760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1116493760==--
