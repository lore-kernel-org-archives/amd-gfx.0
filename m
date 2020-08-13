Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A7CC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 02:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31E320716
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 02:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ypXHbjqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31E320716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D1B06E02E;
	Thu, 13 Aug 2020 02:47:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B54D6E02E
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 02:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFWhIv82AYua7msIetgG7TnxIMh45VqiWawr+Hm6jNWUON3uLXq26R1u7TNCjW0PRnL2vcNeYmmYrjw4LPtv/QPoW1Pf39ChAJQFjpkLDEvn5OE3vu8sXyxJwxH7Ta8D5o8Szs8K2n70owl43fM7B67mKuvR/5Pa3koEA1L2gYv+/Cu0LMTkwj1DHmh6msyGQkz1yT4l2QgnblLyxmr7qeAZRX+p3OHR6zAgrSTWXrqr71Amba4IfmMl6HIK/Lr5VnD47vja3gRcVo0D7TE9dbHTAmMlU5F7i5ViBaTwyAVvRYM8J3tyFvoJUBYHqfiS4VSspA21r1SWBkU3d6AbYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Bq7iJqhP9q3Fpq03YLgdbRjeWi7cL26hgaByp33a7g=;
 b=CJNawGwftSjumgo5qeNftQtTEo6riPQGGeVVTW9U9979TjLhgYZ1RTJmQpsNLMgagQu+Xfplmy3eSj3WgJEr881VoRs2ZtsZfXKDuhGDbBwvCpr7qUl+LNQuyCHpy4ItNuu7Vdse69fUDnLxjHuJi4KZlYpz91ZpZMKesFSYQmcme1JZWSzRs0OSBiDGXh8/jdqISOQb62OXhlmryA65KFVgyM7Fm2gXKFDpqxvL0w8EhCAX31ApaEH6vlOO4Pu0EcWgBGAQjqjKuXZhJn9dIAhZV1hTPp/Vcurn/k1TzJZYWRpgGNRBiugHvRh/r1tEICGOZ/CoHb8N7fIXCE2drA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Bq7iJqhP9q3Fpq03YLgdbRjeWi7cL26hgaByp33a7g=;
 b=ypXHbjqLMR3xOg7hTxDtz0Sfunch6JQUOf5d560S0AiWpsKgqKBal32v3ql2DYuxEEcYrY3gzfNgNnvJ2vy2fo8k1fYOaIDHtQxhNuWKHvL1uRmlwovP0147PbUBk3/8xs7d4/ZroIvGZ44MglYpoKhXPK4Nc+4EEFhddfKGNAw=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3040.namprd12.prod.outlook.com (2603:10b6:208:ce::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 13 Aug
 2020 02:47:34 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93%4]) with mapi id 15.20.3261.025; Thu, 13 Aug 2020
 02:47:34 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "StDenis, Tom" <Tom.StDenis@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: Fix uninitialized warning in arcturus
 ppt driver
Thread-Topic: [PATCH] drm/amd/powerplay: Fix uninitialized warning in arcturus
 ppt driver
Thread-Index: AQHWcKMH80p+CItntEuLKOAa6tJ0o6k1S9SAgAAKswQ=
Date: Thu, 13 Aug 2020 02:47:34 +0000
Message-ID: <MN2PR12MB3022A54F624AF49FE9B2C9CDA2430@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20200812122030.215907-1-tom.stdenis@amd.com>,
 <DM6PR12MB2619E6D6AD9439DDA1FB72B6E4430@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619E6D6AD9439DDA1FB72B6E4430@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-13T02:49:10.024Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91ed981c-455a-492e-2f44-08d83f333b26
x-ms-traffictypediagnostic: MN2PR12MB3040:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB30407EC2D517D9DB765AE002A2430@MN2PR12MB3040.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:142;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(478600001)(6506007)(71200400001)(53546011)(966005)(7696005)(33656002)(8676002)(52536014)(5660300002)(110136005)(316002)(66476007)(8936002)(2906002)(166002)(45080400002)(86362001)(9686003)(19627405001)(66556008)(55016002)(186003)(26005)(66446008)(66946007)(83380400001)(91956017)(64756008)(76116006);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ed981c-455a-492e-2f44-08d83f333b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 02:47:34.0445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zXgdz3UvBVs3Hbq2aL9929ED8p57xKFTWFPzcc9E97pXLF6xMfG5pe95Su7+WOyh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3040
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
Content-Type: multipart/mixed; boundary="===============1019997409=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1019997409==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3022A54F624AF49FE9B2C9CDA2430MN2PR12MB3022namp_"

--_000_MN2PR12MB3022A54F624AF49FE9B2C9CDA2430MN2PR12MB3022namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Tom,

drm/amdgpu: fix uninit-value in arcturus_log_thermal_throttling_event()

the fixed patch has been merged into drm-next branch.

Best Regards,
Kevin

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Quan, Ev=
an <Evan.Quan@amd.com>
Sent: Thursday, August 13, 2020 10:07 AM
To: StDenis, Tom <Tom.StDenis@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: StDenis, Tom <Tom.StDenis@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: Fix uninitialized warning in arctur=
us ppt driver

[AMD Official Use Only - Internal Distribution Only]

[AMD Official Use Only - Internal Distribution Only]

Your change below should be able to suppress the compile warning.
-arcturus_get_smu_metrics_data(smu,
+ret =3D arcturus_get_smu_metrics_data(smu,
       METRICS_THROTTLER_STATUS,
       &throttler_status);

+if (ret) {
+dev_err(adev->dev, "Could not read from arcturus_get_smu_metrics_data()\n"=
);
+return;
+}
+
Setting *value as 0 may be unnecessary.  However anyway this patch is revie=
wed-by: Evan Quan <evan.quan@amd.com>

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tom St D=
enis
Sent: Wednesday, August 12, 2020 8:21 PM
To: amd-gfx@lists.freedesktop.org
Cc: StDenis, Tom <Tom.StDenis@amd.com>
Subject: [PATCH] drm/amd/powerplay: Fix uninitialized warning in arcturus p=
pt driver

Fixes:

  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_typ=
es.o
drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c: In function =91arct=
urus_log_thermal_throttling_event=92:
drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c:2223:24: warning: =
=91throttler_status=92 may be used uninitialized in this function [-Wmaybe-=
uninitialized]
 2223 |   if (throttler_status & logging_label[throttler_idx].feature_mask)=
 {

by making arcturus_get_smu_metrics_data() assign a default value (of zero) =
before any possible return point as well as simply error out of arcturus_lo=
g_thermal_throttling_event() if it fails.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index 8b1025dc54fd..78f7ec95e4f5 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -551,6 +551,9 @@ static int arcturus_get_smu_metrics_data(struct smu_con=
text *smu,

 mutex_lock(&smu->metrics_lock);

+// assign default value
+*value =3D 0;
+
 ret =3D smu_cmn_get_metrics_table_locked(smu,
        NULL,
        false);
@@ -2208,15 +2211,20 @@ static const struct throttling_logging_label {  }; =
 static void arcturus_log_thermal_throttling_event(struct smu_context *smu)=
  {
-int throttler_idx, throtting_events =3D 0, buf_idx =3D 0;
+int throttler_idx, throtting_events =3D 0, buf_idx =3D 0, ret;
 struct amdgpu_device *adev =3D smu->adev;
 uint32_t throttler_status;
 char log_buf[256];

-arcturus_get_smu_metrics_data(smu,
+ret =3D arcturus_get_smu_metrics_data(smu,
       METRICS_THROTTLER_STATUS,
       &throttler_status);

+if (ret) {
+dev_err(adev->dev, "Could not read from arcturus_get_smu_metrics_data()\n"=
);
+return;
+}
+
 memset(log_buf, 0, sizeof(log_buf));
 for (throttler_idx =3D 0; throttler_idx < ARRAY_SIZE(logging_label);
      throttler_idx++) {
--
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7Cf47512097dfc40168e1a08d83f2db359%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637328812813110771&amp;sdata=3DxedbRrZeOi0PK3EM%2FKBYhfX=
xdfpOkocXPjQjcQ5ErI0%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7Cf47512097dfc40168e1a08d83f2db359%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637328812813110771&amp;sdata=3DxedbRrZeOi0PK3EM%2FKBYhfX=
xdfpOkocXPjQjcQ5ErI0%3D&amp;reserved=3D0

--_000_MN2PR12MB3022A54F624AF49FE9B2C9CDA2430MN2PR12MB3022namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
Hi Tom,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<i style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; background-=
color: rgb(255, 255, 255)"><u>drm/amdgpu: fix uninit-value in arcturus_log_=
thermal_throttling_event()</u></i><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<i style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; background-=
color: rgb(255, 255, 255)"><u><br>
</u></i></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
the fixed patch has been merged into drm-next branch.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,<br>
Kevin</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Quan, Evan &lt;Evan.Quan@amd.=
com&gt;<br>
<b>Sent:</b> Thursday, August 13, 2020 10:07 AM<br>
<b>To:</b> StDenis, Tom &lt;Tom.StDenis@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> StDenis, Tom &lt;Tom.StDenis@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: Fix uninitialized warning in=
 arcturus ppt driver</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
<br>
[AMD Official Use Only - Internal Distribution Only]<br>
<br>
Your change below should be able to suppress the compile warning.<br>
-arcturus_get_smu_metrics_data(smu,<br>
+ret =3D arcturus_get_smu_metrics_data(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; METRICS_THROTTLER_STATUS,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;throttler_status);<br>
<br>
+if (ret) {<br>
+dev_err(adev-&gt;dev, &quot;Could not read from arcturus_get_smu_metrics_d=
ata()\n&quot;);<br>
+return;<br>
+}<br>
+<br>
Setting *value as 0 may be unnecessary.&nbsp; However anyway this patch is =
reviewed-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
<br>
BR<br>
Evan<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of To=
m St Denis<br>
Sent: Wednesday, August 12, 2020 8:21 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: StDenis, Tom &lt;Tom.StDenis@amd.com&gt;<br>
Subject: [PATCH] drm/amd/powerplay: Fix uninitialized warning in arcturus p=
pt driver<br>
<br>
Fixes:<br>
<br>
&nbsp; CC [M]&nbsp; drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_=
dm_mst_types.o<br>
drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c: In function =91arct=
urus_log_thermal_throttling_event=92:<br>
drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c:2223:24: warning: =
=91throttler_status=92 may be used uninitialized in this function [-Wmaybe-=
uninitialized]<br>
&nbsp;2223 |&nbsp;&nbsp; if (throttler_status &amp; logging_label[throttler=
_idx].feature_mask) {<br>
<br>
by making arcturus_get_smu_metrics_data() assign a default value (of zero) =
before any possible return point as well as simply error out of arcturus_lo=
g_thermal_throttling_event() if it fails.<br>
<br>
Signed-off-by: Tom St Denis &lt;tom.stdenis@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 12 ++++++++++--<br>
&nbsp;1 file changed, 10 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c<br>
index 8b1025dc54fd..78f7ec95e4f5 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
@@ -551,6 +551,9 @@ static int arcturus_get_smu_metrics_data(struct smu_con=
text *smu,<br>
<br>
&nbsp;mutex_lock(&amp;smu-&gt;metrics_lock);<br>
<br>
+// assign default value<br>
+*value =3D 0;<br>
+<br>
&nbsp;ret =3D smu_cmn_get_metrics_table_locked(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false);<br>
@@ -2208,15 +2211,20 @@ static const struct throttling_logging_label {&nbsp=
; };&nbsp; static void arcturus_log_thermal_throttling_event(struct smu_con=
text *smu)&nbsp; {<br>
-int throttler_idx, throtting_events =3D 0, buf_idx =3D 0;<br>
+int throttler_idx, throtting_events =3D 0, buf_idx =3D 0, ret;<br>
&nbsp;struct amdgpu_device *adev =3D smu-&gt;adev;<br>
&nbsp;uint32_t throttler_status;<br>
&nbsp;char log_buf[256];<br>
<br>
-arcturus_get_smu_metrics_data(smu,<br>
+ret =3D arcturus_get_smu_metrics_data(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; METRICS_THROTTLER_STATUS,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;throttler_status);<br>
<br>
+if (ret) {<br>
+dev_err(adev-&gt;dev, &quot;Could not read from arcturus_get_smu_metrics_d=
ata()\n&quot;);<br>
+return;<br>
+}<br>
+<br>
&nbsp;memset(log_buf, 0, sizeof(log_buf));<br>
&nbsp;for (throttler_idx =3D 0; throttler_idx &lt; ARRAY_SIZE(logging_label=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; throttler_idx++) {<br>
--<br>
2.26.2<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7Cf47512097dfc40168e1a08d83f2db359%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637328812813110771&amp;amp;sdata=3DxedbRr=
ZeOi0PK3EM%2FKBYhfXxdfpOkocXPjQjcQ5ErI0%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40=
amd.com%7Cf47512097dfc40168e1a08d83f2db359%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637328812813110771&amp;amp;sdata=3DxedbRrZeOi0PK3EM%2FKBYhfXxd=
fpOkocXPjQjcQ5ErI0%3D&amp;amp;reserved=3D0</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7Cf47512097dfc40168e1a08d83f2db359%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637328812813110771&amp;amp;sdata=3DxedbRr=
ZeOi0PK3EM%2FKBYhfXxdfpOkocXPjQjcQ5ErI0%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40=
amd.com%7Cf47512097dfc40168e1a08d83f2db359%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637328812813110771&amp;amp;sdata=3DxedbRrZeOi0PK3EM%2FKBYhfXxd=
fpOkocXPjQjcQ5ErI0%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3022A54F624AF49FE9B2C9CDA2430MN2PR12MB3022namp_--

--===============1019997409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1019997409==--
