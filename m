Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1183C38A2A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 15:10:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7AA92083B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 15:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="15HNfzn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7AA92083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8778A6E9E6;
	Thu,  7 May 2020 15:10:00 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750073.outbound.protection.outlook.com [40.107.75.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BE9A6E9E6
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 15:09:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnczCzcTVXCNgcP/xGY39FPGa+JxBucdSqRMnH24pOq+6V5+h54DsYlgQIOCkmooYueTjO9mJNtQqCZLeEWFRVNDUaQcXJBJTUta4qY/WUOOXaT3s9Pl6heXZ2Bc43wGoVYB0pytiAnSLL1pEPb9v9+zSfRd6AkrMS6f9ylRM4q33cdoqDndCtFWoLi5yVIEuFeCAApczoBX8kudI21bAVEXMMYD4pPnJ1GGf0qNjNdPKW8RfKsHINODzqzeSHe9Fzylc6zLVuadIGDqdzcdWUI4zHn82gt85CTDem9u+vJbFbbZfemoyDDD6hf0XQF/o5vhMXcxoyCQRSwOsb3qzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPiDsr9KuDUeD8XL5fpgMxn4R8KYiQFH9bgJmQk9m/c=;
 b=Q97boxWZGCY4y7f/noBjajCZ6MgJYqoQ9tF1wBdMXwdoHM1C0azkLPBWKcFw9E/f8rXAfnxcm40loDkZInnB0pioYR6Umhk3qCQZG6tC5gh/4AguiUmlYNWZoRLfOVlFlXXfG5XvV1Dlq2ZK98cBRvG6rN03wx6aAJWSoajiAWZIN7DxVTiRkBxHa6lXD/x2sLUKQvJEC1vz3qeyITP8J9kdkbBOBPqDU5JBs0Ki35p7ojs5S9TVVFPuROofcYAtbB13Iu0anMtJAy+7rmIuCqtEDcxZIebM4nyhcMej7SJb3n0A/U+fWd26AJg46EzZ0EjKEdUh3+lEEZ1M5kOxqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPiDsr9KuDUeD8XL5fpgMxn4R8KYiQFH9bgJmQk9m/c=;
 b=15HNfzn3lQEX4v/hvlKd/hMYdpDiASaWRIdcZC/Z/yw9EyVbMGipHKsVL1CDZNFB6tgZEJyZikotmaTABy00VyfpF6D/GM+uuC4GfYo+BiY6d1lvlI2hL1SDxrWOWFODeZ87Lmo3sv/YwNPRbizz0N7yvtte0GSTbW8LQiezRuI=
Received: from MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 by MW3PR12MB4506.namprd12.prod.outlook.com (2603:10b6:303:53::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 7 May
 2020 15:09:57 +0000
Received: from MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::b167:4305:a89:ede6]) by MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::b167:4305:a89:ede6%3]) with mapi id 15.20.2958.030; Thu, 7 May 2020
 15:09:57 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Don't report unique_id for Arcturus
Thread-Topic: [PATCH] drm/amdgpu: Don't report unique_id for Arcturus
Thread-Index: AQHWJHcBAJy+nTBd+EOBAlae6UMXyaicugms
Date: Thu, 7 May 2020 15:09:57 +0000
Message-ID: <MW3PR12MB4491A6D219680EF962771399F7A50@MW3PR12MB4491.namprd12.prod.outlook.com>
References: <20200507135359.18138-1-kent.russell@amd.com>
In-Reply-To: <20200507135359.18138-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-05-07T15:09:56.899Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.37.167]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad03ead4-33cf-44f0-6a0a-08d7f298b49c
x-ms-traffictypediagnostic: MW3PR12MB4506:|MW3PR12MB4506:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB45069DC649306C7A1789C807F7A50@MW3PR12MB4506.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:499;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QKIdy9OfpuZ91Lsts0CdOsj+6kjbRJc5f+uNfYrMvGvMrQ60I00M677m8PoSgSgyehUPiuTbXcicZScbJ1JhSeAYwXVvA4Wup0Aa9aA2ddPWD7y56h7CKzTGQoCR3wEz6Z8DbZ8SxOzopl+BNYKBcxQgFbtt5EMtVREDN1kRtqVaNjokmuQPL1c0yWMvPN14CCr+SfVbpsThAz89Qo+n9lNbzeCCkGXBHpaQodwqMHWgclcucRzTNhU91XdvACrg6knbFX/VnAJVJ7MCDdvf1rDJytjXHTmbX9ZS+6kpfIy0HfXeT9zvQJ0W0hf6QbCOmdDSuY1wCq9KVIuXe+eMUWdyOYLv+/Qrpy6K3gU1Sbq+PAqQzHmnk0sx+uM49T6a0zxZZip3rOQyXivejVPEFSX3Sbcr2GMyQvbqv32FM/0fTS8RFlE7Uj9hMU0ViyqDRAOwVKkJsw/Wfh6ZXmkEir4uxJShUBFfAkppfTSSMh736Yim3tdJWGMmEkbw1/kEEJz1nE7zQi2IOyx3nlDZ+PlASVv1dK8+Y+Nki+5sz+OigtEgteYKjeu7DfQPKfXH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(33430700001)(8676002)(9686003)(86362001)(110136005)(966005)(33440700001)(19627405001)(55016002)(83280400001)(186003)(316002)(166002)(45080400002)(5660300002)(83300400001)(478600001)(83320400001)(83290400001)(83310400001)(33656002)(6506007)(52536014)(53546011)(8936002)(71200400001)(2906002)(66446008)(66556008)(26005)(64756008)(66476007)(66946007)(76116006)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: FHlNBrwQr7omRfamZBWV914qM/ps6EmQ4qnEm7pse/yAMGvjahpv/aI2DDCxspjpKJQxxvT1EyQLgkNrg1Qi4QJNuRC0rBWSt/FVofPCCgOR/Oqhvz7lUezmib/gvWPlRKFM1NNGfD48iG6A6wPWU78scVTlf0BIIeb3bIipcUoWcAw+hzhLIrlmHx/hBqY216W6lLSV7pzUR+z29S0cynUsXz+pDK/7sKETeanVhgrKeLWDOM1/53cmSyFIDomoULbLV8oHsOXk/obXwgvTRb4W+93wSdRSZHiKeEZ+uZ3DxZxPD1ATXaCLIi/0Z6w611YvB0rolagFaFXYJfgUPaAnfjgEmoF2k6DfCjvuB1MCH6uNZutrt9w/883bnCEO1hgD/SFRxStcK73lecX/i+7CZi/OEBW+34zR0ruLnJycOp+mKA+h0e8Xh3kuVVjMY1xuxZHQ2OUmXWlUpbFQediyeGLXqySrjtt1/9sDSGrjZ6v7uswtgfQcoN47YSdyQOQjJ55cxutT0ubPLFjJCXHyk7B8A+0azyF199Y/QkLTufGcO2C4FCfRn93Z6VDGqIpnLsGkb1LEaryURkHqNZ8FpjC6aV4DQ6CaqA3eo/ErxZPrjXEXH4goji74Vwzxy1eQxge/KnFLUZmYoOjMenqmtEl8rvzQGmOyPUhKhMP/D/dA8rCErQ92soF4lwR46+9VgvgscmH/N1tiIX0NPK3yyNjbupE19rch4B/S0nkF2A9Qrn9fxMA9Ds5bVcIVUXbplZkgRN3JYXxKVrFri1uI2Cy99mmOHRb9VkSWAFc=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad03ead4-33cf-44f0-6a0a-08d7f298b49c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 15:09:57.4150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XLgGkcW0xkn5yKX5o/5SVaDjy2Ef5NhI6ZdtnuseOUqhWeL9ZEmXJwqCEhYfJBiUCB+ZfB4DvzEiLOx5r6auLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4506
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
Content-Type: multipart/mixed; boundary="===============1983790856=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1983790856==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB4491A6D219680EF962771399F7A50MW3PR12MB4491namp_"

--_000_MW3PR12MB4491A6D219680EF962771399F7A50MW3PR12MB4491namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Shouldn't all of this code be moved later anyway to make sure the SMU is up=
 and running already?

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kent Rus=
sell <kent.russell@amd.com>
Sent: Thursday, May 7, 2020 9:53 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH] drm/amdgpu: Don't report unique_id for Arcturus

This isn't supported in the SMU yet, so just break early. This can be
reverted once the SMU supports the feature

Signed-off-by: Kent Russell <kent.russell@amd.com>
Change-Id: I09945613aa7400afdf3f9d5dc0ffb636ee2896f7
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index f55f9b371bf2..cb90825aacf1 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -317,6 +317,11 @@ static int arcturus_tables_init(struct smu_context *sm=
u, struct smu_table *table
         smu_table->metrics_time =3D 0;

         if (smu->adev->asic_type =3D=3D CHIP_ARCTURUS) {
+               /* TODO: SMU doesn't currently support this. Return
+                * early and remove this once SMU supports it
+                */
+               return 0;
+
                 /* Get the SN to turn into a Unique ID */
                 smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumTop32,
                                  &top32);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C2081bb617dd14d81e7a108d7f28e1f8f%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637244564588764106&amp;sdata=3DGevSmW%2Fgzq862kdiJ=
wcbGbCMHfboIGx77zfA%2FOuwhW8%3D&amp;reserved=3D0

--_000_MW3PR12MB4491A6D219680EF962771399F7A50MW3PR12MB4491namp_
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
Shouldn't all of this code be moved later anyway to make sure the SMU is up=
 and running already?</div>
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
ounces@lists.freedesktop.org&gt; on behalf of Kent Russell &lt;kent.russell=
@amd.com&gt;<br>
<b>Sent:</b> Thursday, May 7, 2020 9:53 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Don't report unique_id for Arcturus</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This isn't supported in the SMU yet, so just break=
 early. This can be<br>
reverted once the SMU supports the feature<br>
<br>
Signed-off-by: Kent Russell &lt;kent.russell@amd.com&gt;<br>
Change-Id: I09945613aa7400afdf3f9d5dc0ffb636ee2896f7<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 5 &#43;&#43;&#43;&#43;=
&#43;<br>
&nbsp;1 file changed, 5 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c<br>
index f55f9b371bf2..cb90825aacf1 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
@@ -317,6 &#43;317,11 @@ static int arcturus_tables_init(struct smu_context=
 *smu, struct smu_table *table<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;metrics_time=
 =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;adev-&gt;asic_=
type =3D=3D CHIP_ARCTURUS) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* TODO: SMU doesn't currently support this. Return<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * early and remove this once SMU supports it<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Get the SN to turn into a Unique ID */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumTop32,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;top32);<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C2081bb617dd14d81e7a108d7f28e1f8f%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637244564588764106&amp;amp;sdata=3D=
GevSmW%2Fgzq862kdiJwcbGbCMHfboIGx77zfA%2FOuwhW8%3D&amp;amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7C2081bb617dd14d81e7a108d7f28e1f8f%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637244564588764106&amp;amp;sdata=3DGevSmW%2Fgzq8=
62kdiJwcbGbCMHfboIGx77zfA%2FOuwhW8%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB4491A6D219680EF962771399F7A50MW3PR12MB4491namp_--

--===============1983790856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1983790856==--
