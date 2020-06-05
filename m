Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3408C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 14:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B6F20663
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 14:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="G+ZRb6Yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B6F20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BBF76E902;
	Fri,  5 Jun 2020 14:05:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 296066E902
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 14:05:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFzpqOYOyaIral3ZAxjZzOrjHEIPFzPvY4gpUq9QYznMsUtqDjWjb9AP//udAPMBDxmi/jdoyADtx5iej/G2XyJKfXZ7Pr377b5V0qBXSMdY9ipj2OG3zJ7LpQRx/9dCCe7R67TG05wO96BhuBd1ObYYdrlksf2mBBZeMDSb+LuW7lU2v11MTwGQBeJCPg7pZINIc1P11zTp7sCy2Zrk/WUu+5a4R3vt/Nd/FTyOHAeRDoeytc/XUmGWzypED54OSzmAeX1g/Q8NqHLnb1XwHCS/LmBmRPM4LC9v/M+bWlMBPp91gFQgA7Kt1YeTTf1vB8+YyrV2RLgc25edfIs5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8v9StmI4tuc2ncpwMrdpCt72UJIZ4kv7gvJrn5IxVU=;
 b=AbjREfcq3arYftE1qisji9wnbkmWtgAfV6c8DbbgwUe3nhn3CiroLBhkK+FVFFikypGhRv9hz/aRz2Ae3fug81QcFW5Zi6IYGqAf7jQ72BxiQrYel1CslQg0WBmq6GLlFJGLTzZc3l7df6lmlhzUuyEqYIdExaznqL1kGQXXno3wRjlJoF1l4X3h/nSumg7YumB1q4okpRbG+Fis5sL5RsBQj/SeCTexwBF3XzEFyptsbnga+RtfjYm+ms8wZ4RHm5PN1KCD3kRFW4wv22GRvM9u6TIOIRQMvwFXwUdKB1TEHoSB0oBBLR5Wv0lDV0sPSfqFKslvsM5aipjDadfIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8v9StmI4tuc2ncpwMrdpCt72UJIZ4kv7gvJrn5IxVU=;
 b=G+ZRb6Yl416KSLZX1fa28JFFylESl6OONf8+kkz/IMXlgw7JPRPSsk92ngYVH9Humr6LM+Oqeh1ttRjassd6CtnDKv3zBAKoiF5/73jaFsXMQTJqdD4KnLP2ZEGqWuFGmo2a6tJg5Rlkve7qzZHMBEPV/COvtMw/QlHbfWXlFvo=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3182.namprd12.prod.outlook.com (2603:10b6:208:107::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 14:05:46 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72%5]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 14:05:46 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 4/4] drm/amd/powerplay: use the same interval as PMFW on
 retrieving metrics table
Thread-Topic: [PATCH 4/4] drm/amd/powerplay: use the same interval as PMFW on
 retrieving metrics table
Thread-Index: AQHWOv+xjsmGruTMhEy5RA9ToDNKxqjKDrkF
Date: Fri, 5 Jun 2020 14:05:46 +0000
Message-ID: <MN2PR12MB4488FEB8AC74FB400ABC97C8F7860@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200605060741.5280-1-evan.quan@amd.com>,
 <20200605060741.5280-4-evan.quan@amd.com>
In-Reply-To: <20200605060741.5280-4-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-05T14:05:45.514Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.51.180.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0bded33f-4768-4155-57cd-08d809598b04
x-ms-traffictypediagnostic: MN2PR12MB3182:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3182A889802610DC6835ED10F7860@MN2PR12MB3182.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RtKUh8uGF75+OFbpEHpwCbw2hyNNFafxQ6i5Ot1jjNhcGoDZK4Rjbf6IYS39j5RgQB5k8CRM7F+AuYf0CrSzlGthEqIeBtzb23iiDZZYFOa0kF2fdpmcy8MYa1VqfqRXF0Zbmqhp8Is51JMNn71yhD/wcQ9LqMDpF5Gox6bXNpDr2rgv/nBSMzKgo/XIqn+WYE622JK9Y+0fxFAa9TOh/vpe53aJ/cX6K2MyoMHdA7lPOFtiOGtobRsjyHikeylC3MyLPnBxOoGuMQfJpaAaXoRHWnAvc/l/mhzATcQuuhjp8vHTY5GGExXUFAa4VZ441FgPUCgbvCmpnKR590gVeg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(86362001)(8676002)(55016002)(110136005)(316002)(6506007)(478600001)(53546011)(33656002)(83380400001)(7696005)(186003)(76116006)(52536014)(26005)(5660300002)(71200400001)(8936002)(19627405001)(66946007)(9686003)(66476007)(64756008)(66556008)(2906002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 7uktr92aOoLpyjkQpvtm70iqviKgY4XF8yYEkGaw2m+S5+K7OIeUhcQbltCnyye+F0oEPmkNVvY+hLxsv9TRYb+cOhjb9VVHsQl32Jx6fjFfqPZ74648OxiDDC8rrMddYPfu3MSFh+D5VvvHiH0dJpXpVvtPQ+w+tbzlqtvaNR9EygomPq51yb4RxLeq3BM4B/qaRetlzrSWeNwLXQFQhwxVFtL/080+38yt8qFshPrWgY982+Nwm03XNPpUURMgLnIqtNJAs26KOHrlZJS0p3X4rVkRQQMjhabP2SD8Zrf9YI461oSl1eGHLhc9LUeR9y9lZWWETvJx2u+12bz6iJPFCwTQDTqtDg48AYheo8K5DEvujJdj+naTeplpojjbqjUl4sg0agFG4Hjr2AB/oy2xerUkQ2SiNZmbTw5+oeGgzP5kz2Dpkvz3kF8eEYJHvg2tRjq4G+DcvMhj/NDhot7IOcTgZ24cwLGx6mN/8x1hi0ADF8uzMnPKAa8y5SYD
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bded33f-4768-4155-57cd-08d809598b04
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 14:05:46.0219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XoR2uwa3prHkCa1xo/TAwVv1BbJKOc+yd3v5mHOtC8biCk/+Se6+smjWGQ5uNeydMZMT7TenngLfaqNFXykmHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3182
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
Content-Type: multipart/mixed; boundary="===============1256767825=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1256767825==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488FEB8AC74FB400ABC97C8F7860MN2PR12MB4488namp_"

--_000_MN2PR12MB4488FEB8AC74FB400ABC97C8F7860MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Friday, June 5, 2020 2:07 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH 4/4] drm/amd/powerplay: use the same interval as PMFW on re=
trieving metrics table

Current 100ms interval makes no sense. User gets outdated
data due to this.

Change-Id: Ie1d950285460443d493f1647463b68cbe4a5ec67
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 2 +-
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index 25653f5f8d16..4cfb1efbc541 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -571,7 +571,7 @@ static int navi10_get_smu_metrics_data(struct smu_conte=
xt *smu,

         mutex_lock(&smu->metrics_lock);
         if (!smu_table->metrics_time ||
-            time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies=
(100))) {
+            time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies=
(1))) {
                 ret =3D smu_update_table(smu,
                                        SMU_TABLE_SMU_METRICS,
                                        0,
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/g=
pu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 13ec103575f9..78657696b427 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -557,7 +557,7 @@ static int sienna_cichlid_get_smu_metrics_data(struct s=
mu_context *smu,

         mutex_lock(&smu->metrics_lock);
         if (!smu_table->metrics_time ||
-            time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies=
(100))) {
+            time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies=
(1))) {
                 ret =3D smu_update_table(smu,
                                        SMU_TABLE_SMU_METRICS,
                                        0,
--
2.27.0


--_000_MN2PR12MB4488FEB8AC74FB400ABC97C8F7860MN2PR12MB4488namp_
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
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Friday, June 5, 2020 2:07 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH 4/4] drm/amd/powerplay: use the same interval as PMF=
W on retrieving metrics table</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Current 100ms interval makes no sense. User gets o=
utdated<br>
data due to this.<br>
<br>
Change-Id: Ie1d950285460443d493f1647463b68cbe4a5ec67<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 2 &#43;-<br>
&nbsp;2 files changed, 2 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index 25653f5f8d16..4cfb1efbc541 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -571,7 &#43;571,7 @@ static int navi10_get_smu_metrics_data(struct smu_c=
ontext *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;me=
trics_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_table-&gt;metrics=
_time ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; time_af=
ter(jiffies, smu_table-&gt;metrics_time &#43; msecs_to_jiffies(100))) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tim=
e_after(jiffies, smu_table-&gt;metrics_time &#43; msecs_to_jiffies(1))) {<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_update_table(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; SMU_TABLE_SMU_METRICS,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/g=
pu/drm/amd/powerplay/sienna_cichlid_ppt.c<br>
index 13ec103575f9..78657696b427 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c<br>
@@ -557,7 &#43;557,7 @@ static int sienna_cichlid_get_smu_metrics_data(stru=
ct smu_context *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;me=
trics_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_table-&gt;metrics=
_time ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; time_af=
ter(jiffies, smu_table-&gt;metrics_time &#43; msecs_to_jiffies(100))) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tim=
e_after(jiffies, smu_table-&gt;metrics_time &#43; msecs_to_jiffies(1))) {<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_update_table(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; SMU_TABLE_SMU_METRICS,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0,<br>
-- <br>
2.27.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488FEB8AC74FB400ABC97C8F7860MN2PR12MB4488namp_--

--===============1256767825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1256767825==--
