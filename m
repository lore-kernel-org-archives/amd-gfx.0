Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50176CA9EC0
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 08:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2434520679
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 08:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2434520679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC8126E8BC;
	Wed, 30 Oct 2019 08:33:54 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680048.outbound.protection.outlook.com [40.107.68.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C2F66E8BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 08:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W83R7lH+7tv8dn7fE/b0BSbBMJChemneE9SSd9u6TxLRszzGTT+NkyeW4d+yOwxATlCESASqZULr9oslo5oRTNMTIgexJr7+ChTzeQbnJm7DJ0CUnsGZbpy98EmCvw+7MRQ0N6EoXDD71ZgXYvEbyIgD2EtDOXmO2dDUVjyHurgU/uT2cD1yplBksEoLCD6Ell56NVEHBnYnqrQOBizwYztz45N+md4+iNyBbJSBPZKm5h/KNZGv5pfDfexvSjQx+Obl9fJa1AF5oTyHf8gOHstD9TJB3KJzCXAONAxm5I3+nIAOFI39TrrER9F2SYjHovMUxjFZaJvy/rDbfxDIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt7j59YTjox3FrbK3AMrnOV54kw5wrSkjx8EAn0sF2c=;
 b=a5bekOALegeVNXNZVBNKjp3Bj4Fu45KEQhdQASq1PDbn0elPm8eligVXVvwCR96BT0TxrwuVj2njDWN7nrBL4EysdH5+xn0FJXPL/chkG79SXyTUhmVd7KZFkdJmoysCTlv9EjGTGJwyyzCfTYrR9w2eXk7UNDLmDfWIjGQLoKHQJBR8hTjEopiNBaa21t97T8B80ThA+3PgiWDdHVJ40bEW1Lmv+jeOJnu6md1c1NotCqf5qpg27LbVcPAK+LfYqHxnOuQy60hu/ht2vdfNliBqJ78RA/Z5P4krkwCSXWcxJ27/+5LmyN8e8D4/1HMtS+L3nW/Vs9owpJ1+PVbXiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3296.namprd12.prod.outlook.com (20.179.80.139) by
 MN2PR12MB3150.namprd12.prod.outlook.com (20.178.241.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Wed, 30 Oct 2019 08:33:51 +0000
Received: from MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::3db4:a949:8b89:33be]) by MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::3db4:a949:8b89:33be%7]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 08:33:51 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: print the pptable provider
Thread-Topic: [PATCH] drm/amd/powerplay: print the pptable provider
Thread-Index: AQHVjvq3p/kOuy2k70OsNJT+A/PoQKdy2y3K
Date: Wed, 30 Oct 2019 08:33:51 +0000
Message-ID:
 <MN2PR12MB3296FAC894DCC2E9D13466AEA2600@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20191030081858.2807-1-xiaojie.yuan@amd.com>
In-Reply-To: <20191030081858.2807-1-xiaojie.yuan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 537e0506-6a83-46ce-3f7c-08d75d13e4a5
x-ms-traffictypediagnostic: MN2PR12MB3150:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB31503BD48FB0B6551A5087C7A2600@MN2PR12MB3150.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(99286004)(53546011)(9686003)(54896002)(6246003)(66476007)(6506007)(486006)(66556008)(66946007)(64756008)(66446008)(76176011)(71190400001)(71200400001)(102836004)(55016002)(74316002)(7736002)(33656002)(3846002)(6116002)(2906002)(19627405001)(91956017)(76116006)(7696005)(4326008)(86362001)(2501003)(8936002)(229853002)(316002)(186003)(5660300002)(256004)(6436002)(66066001)(110136005)(105004)(446003)(476003)(52536014)(81166006)(81156014)(8676002)(26005)(25786009)(14454004)(54906003)(478600001)(11346002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3150;
 H:MN2PR12MB3296.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zhZrmDKOSRj1DPu+qMo06xXKeSS65AMsZoVUCbAC9r92RSpss//rP/gZEkQ7EjU5P8FPztYgbBe1INkNuLRD7nGb17wxPk3vMUZ9/Eu0+7J7j4QrEY6kgddOKD/bwTCxsUlqn0qwKHzoxX5wKyyFbMqsJ7x/yChuG0vPmH1K+dFIgRHgdpma4cNwz6Rh1E9ivZN8UuqJBTuVhKWH7GJUp0SrkFAZ3Jkdqr6H07AADnh2qTYFJQiOekfFv65R5dSCs17wVebIUFx2qjQNoxh/Aum9cIalEdCRLxKXbYT6mZetzEAcoia0Jdws9ezBxhySqSJjGdG7dKOfEAbFz1mZET0N6yNxyLPPFTGtONVPEKC2QMZ8abbiCOCdYvwfRv+RynKIeEkCbG0htFrIudaGeEW/8RTJYLPPjcbJ9fKgZ7Zzn7fd0qStKKd/bi7VtTB6
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537e0506-6a83-46ce-3f7c-08d75d13e4a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 08:33:51.6821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 081A35kzwdI0PrcuVtwZ25HrIhZ+UdQNUY7ugmaJvdx3OfTQR9EgkW7M5zZMISEO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3150
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt7j59YTjox3FrbK3AMrnOV54kw5wrSkjx8EAn0sF2c=;
 b=TsbVRRejrHzk9lR6s/mJmR6QREZlhBZ2NzkmcfZBMZ6amJjlUwMpnyIFJBloV+XdQ7enGw74Np3IXRCbN1vozytkTv94/+YCXwfl1lKBY+4K6V3fD3N7m+25pvDdKBdsKxhc5kS0PmlQUKSPtfQEmcfv7IrkCkic2ovCBL18Vl0=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kevin1.Wang@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: multipart/mixed; boundary="===============1285182126=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030083351.TBzhf0T7A2Uc_SGr65RqBBb6KFK9oErb0Lnn_5xFKnE@z>

--===============1285182126==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296FAC894DCC2E9D13466AEA2600MN2PR12MB3296namp_"

--_000_MN2PR12MB3296FAC894DCC2E9D13466AEA2600MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

also you can put this information in sysfs "amdgpu_pm_info" .

Best Regards,
Kevin

________________________________
From: Yuan, Xiaojie <Xiaojie.Yuan@amd.com>
Sent: Wednesday, October 30, 2019 4:19 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>=
; Feng, Kenneth <Kenneth.Feng@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com=
>
Subject: [PATCH] drm/amd/powerplay: print the pptable provider

Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c
index 7e882999abad..0f7504ae2395 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -368,6 +368,7 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
         version_major =3D le16_to_cpu(hdr->header.header_version_major);
         version_minor =3D le16_to_cpu(hdr->header.header_version_minor);
         if (version_major =3D=3D 2 && smu->smu_table.boot_values.pp_table_=
id > 0) {
+               pr_info("use driver provided pptable %d\n", smu->smu_table.=
boot_values.pp_table_id);
                 switch (version_minor) {
                 case 0:
                         ret =3D smu_v11_0_set_pptable_v2_0(smu, &table, &s=
ize);
@@ -384,6 +385,7 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
                         return ret;

         } else {
+               pr_info("use vbios provided pptable\n");
                 index =3D get_index_into_master_table(atom_master_list_of_=
data_tables_v2_1,
                                                     powerplayinfo);

--
2.20.1


--_000_MN2PR12MB3296FAC894DCC2E9D13466AEA2600MN2PR12MB3296namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
also you can put this information in sysfs &quot;amdgpu_pm_info&quot; .</di=
v>
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
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Yuan, Xiaojie &lt;Xia=
ojie.Yuan@amd.com&gt;<br>
<b>Sent:</b> Wednesday, October 30, 2019 4:19 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevi=
n1.Wang@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Yuan, Xiao=
jie &lt;Xiaojie.Yuan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: print the pptable provider</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Signed-off-by: Xiaojie Yuan &lt;xiaojie.yuan@amd.c=
om&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 2 &#43;&#43;<br>
&nbsp;1 file changed, 2 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c<br>
index 7e882999abad..0f7504ae2395 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -368,6 &#43;368,7 @@ int smu_v11_0_setup_pptable(struct smu_context *smu=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; version_major =3D le16_to_=
cpu(hdr-&gt;header.header_version_major);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; version_minor =3D le16_to_=
cpu(hdr-&gt;header.header_version_minor);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (version_major =3D=3D 2=
 &amp;&amp; smu-&gt;smu_table.boot_values.pp_table_id &gt; 0) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_info(&quot;use driver provided pptable %d\n&quot;, smu-&g=
t;smu_table.boot_values.pp_table_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (version_minor) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case 0:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D smu_v11_0_set_pptable_v2_0(smu, &amp;table, &amp;size);<br>
@@ -384,6 &#43;385,7 @@ int smu_v11_0_setup_pptable(struct smu_context *smu=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_info(&quot;use vbios provided pptable\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; index =3D get_index_into_master_table(atom_master_lis=
t_of_data_tables_v2_1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; powerplayinfo);<br>
&nbsp;<br>
-- <br>
2.20.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB3296FAC894DCC2E9D13466AEA2600MN2PR12MB3296namp_--

--===============1285182126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1285182126==--
