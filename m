Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B4BC33C9E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 02:38:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238D0206ED
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 02:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pOxkBhuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238D0206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D50A66E384;
	Thu,  9 Jan 2020 02:38:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63AC46E384
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 02:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1n0dVgxWD3iav4o3N1i1VkeCJle5+Z9dI5mpMc1QGgsr6q7B0kZ4foBvnOXj75EFaxMHMts4tdJasmaZSZTlmHhYgl8q/4JPXHEu2pP24H+OdndNvEiebSzptX3j6/GRBQqIq4FCziTDlPjEpJ+PW1MfJuaCGjU+VIWV5Hlk3+SktsZy5iOPLMsuuoULnsy5X8gcBRrE6V+9JqloKgyxV8Pirx+SISo2j3bX2xU/bnp42jEpJfALjaBzCIZYTsdlugWn6B0o7TgSlQJvI0BECYjeG+XtYQYSd1FSfQ3aijQrts0Zgdy4wjV4mDFiyKWPhFf6PlZopipwfMXfQ663w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t19dd+vkHRMIsKv3eix+R2YSjiCqOXckUvwN8utyqTw=;
 b=Tp2e8S5DKhrSY5JYrTyduT24kvaVH5peZ2F3AXnQM8xy56W/XYvBQ2VNWTjkbxyVhIiIi/HH2Q07b5WewJYbzFeQp09fkWDgh38SAn/gzWLOlR73qNBVgl+wd5s8b0lqwg1lCaccBHaZdR1TDmYKBuMEY8HxDKBV6xsAm9rKqXyIPJp9KQFaJn/+cEy9d+jP/BhbWM8IqGAtoeI+uD3xhpUHmmI06atcaZHYK7N83VRnr38nA+NziHTnXWU5K/U5EeJLXuM9fe6yNzp0jSLFWVqWtZO/jek97THlDbZ+3OKQWxFo/5WenFPsTZGOWzFwbKkfhAfiEOaqMisVCMWpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t19dd+vkHRMIsKv3eix+R2YSjiCqOXckUvwN8utyqTw=;
 b=pOxkBhufL2qzK1ocvVICXqqFx5U5i5N6LOXSHEnWFUH3d4ah5bBp7+Jji+FTFgkob5+tOHjfmYR88EKp/wIoB9Nz/VBvkL3G2hcYJ6fvNYGUiEN5cVqS3hsfZqNdVd2+rhbtSEQ11Ct54kvRXmCX2t5JYJ2LxCm6NObb3Mv7w2M=
Received: from MN2PR12MB3296.namprd12.prod.outlook.com (20.179.80.139) by
 MN2PR12MB3712.namprd12.prod.outlook.com (10.255.236.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 02:38:38 +0000
Received: from MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::90a0:8353:690c:1751]) by MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::90a0:8353:690c:1751%7]) with mapi id 15.20.2602.016; Thu, 9 Jan 2020
 02:38:38 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: sw ctf for arcturus
Thread-Topic: [PATCH] drm/amd/powerplay: sw ctf for arcturus
Thread-Index: AQHVxo+szEnPnLn8xEm3ngan0rsFCafhnlBM
Date: Thu, 9 Jan 2020 02:38:38 +0000
Message-ID: <MN2PR12MB32961AAF9753281213A9D31AA2390@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <1578534830-24419-1-git-send-email-kenneth.feng@amd.com>
In-Reply-To: <1578534830-24419-1-git-send-email-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-09T02:38:38.333Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kevin1.Wang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a92590d-948f-4432-74a5-08d794ad0887
x-ms-traffictypediagnostic: MN2PR12MB3712:|MN2PR12MB3712:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3712A58DEBC837EDD8B1AE80A2390@MN2PR12MB3712.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(110136005)(8676002)(81166006)(8936002)(66556008)(64756008)(66446008)(66476007)(5660300002)(81156014)(7696005)(316002)(91956017)(53546011)(76116006)(6506007)(66946007)(4326008)(71200400001)(86362001)(19627405001)(2906002)(55016002)(9686003)(52536014)(33656002)(186003)(26005)(966005)(45080400002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3712;
 H:MN2PR12MB3296.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3hyKFoVtijK2gs4RBJr8Qi9LNPamLtEDYsuSHXeXkj662EsbIiBhj6Ve9O6wbTSXvhp3sEfDW6jaayE4YY+ohrN4xWkdlZNluOOau8ygvvGxWcbH3WR1nRD0Km5bScwR0gYNF8k4XPQaNY15uV8ZHiRDarGRQ8sDtZtQh6FwsZb/Gv+vz3fIHOLweXZ3kDglhKNzauWJyGR+LWnQWRwT4REOfMuAriis/fn1rvoHnA586OAN1D4tPWP961F3gEcfzSOl+6Fj3zjuh9ExFOgpmTiXuxuM8A/4Uhmj1Dw0X5uqqGNiKCsjhCv8ASKWzdjx2aIgvz2qlOGiD1G5k6hQx+XU2Kl8ZE4p3aYVWc5rVUQqOQvxl9zyfWeyWMETvPMenDZfKDC/4C0v5pGIvkdvwMRiJBLuU0OjN39fxiLXGI42Gn7Zwx3Cj3v7sPgsNejYfL4BcyjtDQieoFc13oKTWrrS234kSzh6iwjHsp+II4o=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a92590d-948f-4432-74a5-08d794ad0887
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 02:38:38.8213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rck1cgVCtY1sqWsxIIC8M5RxlGllhXAoXqsnhNSJfggc6hahy+2ICsWIG7aQ+Ixt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3712
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: multipart/mixed; boundary="===============0685074589=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0685074589==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB32961AAF9753281213A9D31AA2390MN2PR12MB3296namp_"

--_000_MN2PR12MB32961AAF9753281213A9D31AA2390MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

fine for me.

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kenneth =
Feng <kenneth.feng@amd.com>
Sent: Thursday, January 9, 2020 9:53 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/powerplay: sw ctf for arcturus

software ctf implementation on arcturs.
has been verified on the system by setting a fake software ctf
temperature limit like 40 degrees centigrade.
then the interrupt is triggered from ih ring and
the warning can be observed from dmesg.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index 50b317f..330d5f4 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -846,11 +846,13 @@ static int arcturus_get_thermal_temperature_range(str=
uct smu_context *smu,
                                                 struct smu_temperature_ran=
ge *range)
 {
         PPTable_t *pptable =3D smu->smu_table.driver_pptable;
+       struct smu_table_context *table_context =3D &smu->smu_table;
+       struct smu_11_0_powerplay_table *powerplay_table =3D table_context-=
>power_play_table;

-       if (!range)
+       if (!range || !powerplay_table)
                 return -EINVAL;

-       range->max =3D pptable->TedgeLimit *
+       range->max =3D powerplay_table->software_shutdown_temp *
                 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
         range->edge_emergency_max =3D (pptable->TedgeLimit + CTF_OFFSET_ED=
GE) *
                 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7C4895e14d1c14407add8208d794a6ccdc%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637141316451781456&amp;sdata=3DLJLHaR5O38HuI%2Bu0KZEkoCJ=
cejrqNcZcUDV6w09pVyk%3D&amp;reserved=3D0

--_000_MN2PR12MB32961AAF9753281213A9D31AA2390MN2PR12MB3296namp_
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
fine for me.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,<br>
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kenneth Feng &lt;kenneth.feng=
@amd.com&gt;<br>
<b>Sent:</b> Thursday, January 9, 2020 9:53 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; Feng, Kenneth &lt;Kenneth.=
Feng@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: sw ctf for arcturus</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">software ctf implementation on arcturs.<br>
has been verified on the system by setting a fake software ctf<br>
temperature limit like 40 degrees centigrade.<br>
then the interrupt is triggered from ih ring and<br>
the warning can be observed from dmesg.<br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 6 &#43;&#43;&#43;&#43;=
--<br>
&nbsp;1 file changed, 4 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c<br>
index 50b317f..330d5f4 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
@@ -846,11 &#43;846,13 @@ static int arcturus_get_thermal_temperature_range=
(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_=
temperature_range *range)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *pptable =3D smu=
-&gt;smu_table.driver_pptable;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_c=
ontext =3D &amp;smu-&gt;smu_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_11_0_powerplay_table *=
powerplay_table =3D table_context-&gt;power_play_table;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!range)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!range || !powerplay_table)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;max =3D pptable-&gt;TedgeLi=
mit *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;max =3D powerplay_table=
-&gt;software_shutdown_temp *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;edge_emergency_m=
ax =3D (pptable-&gt;TedgeLimit &#43; CTF_OFFSET_EDGE) *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7C4895e14d1c14407add8208d794a6ccdc%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637141316451781456&amp;amp;sdata=3DLJLHaR=
5O38HuI%2Bu0KZEkoCJcejrqNcZcUDV6w09pVyk%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40=
amd.com%7C4895e14d1c14407add8208d794a6ccdc%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637141316451781456&amp;amp;sdata=3DLJLHaR5O38HuI%2Bu0KZEkoCJce=
jrqNcZcUDV6w09pVyk%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB32961AAF9753281213A9D31AA2390MN2PR12MB3296namp_--

--===============0685074589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0685074589==--
