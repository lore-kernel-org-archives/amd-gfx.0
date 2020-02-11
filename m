Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DABC352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 14:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74FB42086A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 14:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3FiQwSwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FB42086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2726EE64;
	Tue, 11 Feb 2020 14:17:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E366EE63
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 14:17:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSqIkhq4VdBLOK8tsqNFUHNunwY33coiYN/aCuJd/JUj9Kc0gjq7xzThve+Ap1O/Jo5e9GXrzZ87ETiOTTfqeDRxDqLbrQOP5BSFAZ4INTT33d45PoHKBTNIM5GLid899+4sggNLqGZwZR+Y30BIiFLOsisrI7YI9KNHXbpo9nxPHMVnC3kbBvHQZWydctfp9zjVh2suDxMxkX97r2iK/aEpB8n7Tgm/+Vl+UM6ml2jjR6XtlHnYZDtR3yv3l8pPTB+KBZLL2vEsiK6LYTOBQi+dcJVB4kaA2aZtBd3Dfg9lR2202eTFzQIVnn7BdZ43FPpbDaXlVee9h49I83k3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ej1/oI5Ctg+BVuCcUS7XxiVyyF5QqrKTKUi0B1nfFY=;
 b=QBIEdWt4ywIXzxdBNGEFUGq0T2hoMj983hX6zabWOcxr7Cd0XwxohPj6rVtUTF8uT5KXDd40+rbI4D/gckYOTvndhDzLAryY2n7xptckocyuvPbyp9r9Fl1fQjObCBgnHCKh5HEkg2uxzHtFzR1tyZu56j6gkFvqWbZ6RCpa8sCDyVsa10+dVau7gExwPGFi836cOPkVZzp3sGppd1EgFW3JPCnhgGV0kwVQUWPdc3/+N+W+Ncy4X3UrOHWPx5na18tlfGgEN4bEsqhVjlPieMoL5TeFBFAYH94psipMeCm0cEpoZf0N7GIauuuL1dSm57Jv9GN1IPJ6gTPmwOI8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ej1/oI5Ctg+BVuCcUS7XxiVyyF5QqrKTKUi0B1nfFY=;
 b=3FiQwSwizzqxnbPZag9JpZhPpaBTaOk8UfaDwSQVHROunjbHUaJtLgNkhiQpV7fWalgMY3vtUfmJoBHh/ec27T5wzD4MYNLEegKpxjoPx2hEplb960bMkDbuUf/jBEUZYZMTSSdDHv4NjdPoLlSK/qodBOeyubtUDWBofTaGxRc=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (52.132.246.86) by
 CH2PR12MB3750.namprd12.prod.outlook.com (52.132.247.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Tue, 11 Feb 2020 14:17:18 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 14:17:18 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: always refetch the enabled features
 status on dpm enablement
Thread-Topic: [PATCH] drm/amd/powerplay: always refetch the enabled features
 status on dpm enablement
Thread-Index: AQHV4J30BOHyHw3Y30qYPsStzxM+aqgWCpou
Date: Tue, 11 Feb 2020 14:17:17 +0000
Message-ID: <CH2PR12MB39126909C9F6D8A956EB9A54F7180@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <20200211054121.32154-1-evan.quan@amd.com>
In-Reply-To: <20200211054121.32154-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-02-11T14:17:17.214Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1260d8b2-b4c8-43f5-a20b-08d7aefd19e6
x-ms-traffictypediagnostic: CH2PR12MB3750:|CH2PR12MB3750:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB375033B210EB2823CE2332D0F7180@CH2PR12MB3750.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:551;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(199004)(189003)(66946007)(76116006)(66476007)(5660300002)(186003)(55016002)(71200400001)(8676002)(478600001)(52536014)(81166006)(45080400002)(86362001)(33656002)(53546011)(8936002)(6506007)(2906002)(66556008)(64756008)(66446008)(81156014)(7696005)(966005)(316002)(26005)(19627405001)(9686003)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3750;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9hnjyrpksNifeQNzC80OmSsvjOOENaIHbwSGKcS9ufDRVt8j63u583hLLEaQyGk/y57McqHQHrQR6UNSOVISp3nKAnPZjTgbbkEd2vuMPInNXnC1Qbtu0MZEiKQE2YcbgADvm4u3v9Ws8XZmi5LFQ1aKmoVFBKaYTnMu2ltPPqksRDGjKtrheqDMZk8dcWyRGGpDsL6fqL4wlHd2VeL2bZwIouxLJrWwDl9iTDHf7JXty8+gjNvKHfi3Cay5L+Jezi5MoDGafiV3Btpjc1Uqen9QffTyjpgBPKo/LnyEOZpj5SuYb5MQQG57GhaecpBPXjMf7H9YP6RKMWdK7dFK/lD5aMtwe7O9vn910CVH/c96eQPT75/rVWgs8QX49v9LmAgTLiS2tF2OFS/tVNU7dAVDJTO7Df98WKrZ3Km0Wir/1oqXAYoAtu27eLm6EPriMtEetFzX7Cs6wMpZ8q0WBrokzXyIp44AeY2q5oqPwWvojbArxQvzfBT4QLt1o/W3Zb1Thly0I71bQsmhAosDNw==
x-ms-exchange-antispam-messagedata: jT8UwWkh8GYUbYtg8/h8uYpmumDCbkklHM+wViO4nwrYgrqyYEppp3n4Zj1YtRXGFezaEuLDuOUqMKV04c/q7Lw9QJjSZOJ/NNwVy9olJUyKt0FnkZWR1EIaRJrMxnERAyYEo1h9Ltvs1gfVZ7Z8jA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1260d8b2-b4c8-43f5-a20b-08d7aefd19e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 14:17:17.9269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5OFyA7Ato8ynbasVXFr7HOsq6gdFvDEmeL2rV6URtiyQ2n/Ea7Ltk88FM3zUYbnGxvPiR1u+85EXaENhCOwGjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3750
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
Content-Type: multipart/mixed; boundary="===============2101894996=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2101894996==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB39126909C9F6D8A956EB9A54F7180CH2PR12MB3912namp_"

--_000_CH2PR12MB39126909C9F6D8A956EB9A54F7180CH2PR12MB3912namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Evan Qua=
n <evan.quan@amd.com>
Sent: Tuesday, February 11, 2020 12:41 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/powerplay: always refetch the enabled features sta=
tus on dpm enablement

Otherwise, the cached dpm features status may be inconsistent under some
case(e.g. baco reset of Navi asic).

Change-Id: Ia7d7089e82cbe4ccaa9fadce1f2f0043c42c73df
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c
index 0dc49479a7eb..b06c057a9002 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -898,6 +898,9 @@ int smu_v11_0_system_features_control(struct smu_contex=
t *smu,
         if (ret)
                 return ret;

+       bitmap_zero(feature->enabled, feature->feature_num);
+       bitmap_zero(feature->supported, feature->feature_num);
+
         if (en) {
                 ret =3D smu_feature_get_enabled_mask(smu, feature_mask, 2)=
;
                 if (ret)
@@ -907,9 +910,6 @@ int smu_v11_0_system_features_control(struct smu_contex=
t *smu,
                             feature->feature_num);
                 bitmap_copy(feature->supported, (unsigned long *)&feature_=
mask,
                             feature->feature_num);
-       } else {
-               bitmap_zero(feature->enabled, feature->feature_num);
-               bitmap_zero(feature->supported, feature->feature_num);
         }

         return ret;
--
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C8aeb99fc3dd046dbbaa208d7aeb51500%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637169965095304122&amp;sdata=3DQeFFA07xzLC07niJ9fi=
BG7g5cxN99GcXHnnM%2BK4PiWg%3D&amp;reserved=3D0

--_000_CH2PR12MB39126909C9F6D8A956EB9A54F7180CH2PR12MB3912namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Tuesday, February 11, 2020 12:41 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: always refetch the enabled featu=
res status on dpm enablement</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Otherwise, the cached dpm features status may be i=
nconsistent under some<br>
case(e.g. baco reset of Navi asic).<br>
<br>
Change-Id: Ia7d7089e82cbe4ccaa9fadce1f2f0043c42c73df<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 &#43;&#43;&#43;---<br>
&nbsp;1 file changed, 3 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c<br>
index 0dc49479a7eb..b06c057a9002 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -898,6 &#43;898,9 @@ int smu_v11_0_system_features_control(struct smu_co=
ntext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(feature-&gt;enabled, =
feature-&gt;feature_num);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(feature-&gt;supported=
, feature-&gt;feature_num);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (en) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_feature_get_enabled_mask(smu, feature_mas=
k, 2);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
@@ -907,9 &#43;910,6 @@ int smu_v11_0_system_features_control(struct smu_co=
ntext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; feature-&gt;feature_num);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bitmap_copy(feature-&gt;supported, (unsigned long *)&=
amp;feature_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; feature-&gt;feature_num);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bitmap_zero(feature-&gt;enabled, feature-&gt;feature_num);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bitmap_zero(feature-&gt;supported, feature-&gt;feature_num);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-- <br>
2.25.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C8aeb99fc3dd046dbbaa208d7aeb51500%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637169965095304122&amp;amp;sdata=3D=
QeFFA07xzLC07niJ9fiBG7g5cxN99GcXHnnM%2BK4PiWg%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C8aeb99fc3dd046dbbaa208d7aeb51500%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637169965095304122&amp;amp;sdata=3DQeFFA07xzLC07ni=
J9fiBG7g5cxN99GcXHnnM%2BK4PiWg%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB39126909C9F6D8A956EB9A54F7180CH2PR12MB3912namp_--

--===============2101894996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2101894996==--
