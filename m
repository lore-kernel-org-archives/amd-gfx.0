Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7C4C43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 12:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81512245C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 12:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81512245C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91D076F4E7;
	Thu,  5 Dec 2019 12:56:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBD776F528
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 12:55:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XANyj9MA+awcjkjRzXpHYhqnaJmwuD3G2+0QeBcAo0H6E6mm0eLlOC9GZ8hotMRLPFbOJgqPgZEO/u/W68d+mbV0jzaVvOR3utDTbPE+WDsbGpuZ2FJ2+Q2G/pEkG7V6MPafdwy00/6LPTKaaMMwtt1oRc4MEW3izefOjm5oiXBbqqpilv1sHQHJ8UJ8BiFloM3wfd1EoDXO64TYobC96oCYzuNDe03yWiH8uc/rvQET9wNhjI0Tjqu2SS419N5tsf7TmNyV6SGME9b46PslvadnniPq9ZXbrnEwBFlySQ5/eBYkRVVwlATON32GPfPx7eH6J0Od8MDMBI6UwImiNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJVwXs894uiGOkCnD33847gdju6Rvth5sm0r23tg8cI=;
 b=ZWA8LdXbfZE/w6D7Q31NGkSveLSOsrtFPYHDyshUGNB1ixCb9kiNAh1oLYhF8eMj//XcNsLEa/73wUOOVDhjn5GG/aVgSpamD0KJFWtsHr7nhmdiK+R1gymShqmYv52Fo+vnk8n0tj2fNBhVrUaF28dIOnFjcHCWrrPmPpwGRxxh2LCTUBdvl+XSSuqnJCeHO9Ov8f6rilXTUVlG/mJXW15aR5bWrFUQ6AQYBFXzdhVxQUQRS99gc8m/swwGf+euwU8fxXtGrtCPCw87hn4uD9ZePcb/e21yjvqaLoKjVgNMROi4QKB9i7ngwNhab9wkOdWWThZ6D0NlJnIT+j9NUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3296.namprd12.prod.outlook.com (20.179.80.139) by
 MN2PR12MB3039.namprd12.prod.outlook.com (20.178.242.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Thu, 5 Dec 2019 12:55:58 +0000
Received: from MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::b02a:3af3:a3c2:61f3]) by MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::b02a:3af3:a3c2:61f3%6]) with mapi id 15.20.2495.014; Thu, 5 Dec 2019
 12:55:58 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/4] drm/amd/powerplay: implement interface to retrieve
 gpu temperature for renoir
Thread-Topic: [PATCH 1/4] drm/amd/powerplay: implement interface to retrieve
 gpu temperature for renoir
Thread-Index: AQHVq2KbsCi0/1LcMEqruA+iz6+o9Kerf8DH
Date: Thu, 5 Dec 2019 12:55:58 +0000
Message-ID: <MN2PR12MB329672AB53AAD19118DEDF64A25C0@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20191205115031.3822-1-Xiaomeng.Hou@amd.com>
In-Reply-To: <20191205115031.3822-1-Xiaomeng.Hou@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-05T12:55:57.919Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
x-originating-ip: [58.246.141.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b531678f-f041-4946-5bb5-08d779827951
x-ms-traffictypediagnostic: MN2PR12MB3039:|MN2PR12MB3039:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB30396C99429283BB41268583A25C0@MN2PR12MB3039.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(199004)(189003)(25786009)(478600001)(45080400002)(86362001)(966005)(53546011)(6506007)(9686003)(110136005)(229853002)(14454004)(33656002)(316002)(55016002)(11346002)(186003)(26005)(2906002)(76176011)(102836004)(66446008)(76116006)(8676002)(99286004)(19627405001)(5660300002)(74316002)(91956017)(52536014)(71200400001)(71190400001)(7696005)(8936002)(66556008)(81156014)(64756008)(66476007)(81166006)(54896002)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3039;
 H:MN2PR12MB3296.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XJ0ohmmeQwOg1yzIwekbSKhALHA1PZGu4FxS9wnkWNY1VKPFfMBwVSTgWprbCEdQrtOPIhu+zVP8xVu6UC2XvbF7zmHRW6ZDkzXPRfv2ZiZrlvYIxD8zwr0XksnJyOpP8unLHw7W3nHjUQB1gkQB2hJflHboIsG2PG7XbO8wCm84z4MR84fX2V2hlxlunyQqRjTtKHAQDmOQ6GTzQWlnd3AM2zYi/32uT4ZZYU6c4k7QZDmNDKsdr2uqN4qNmuPYIoj/wCZUOY6i9sVjHzWjBTeD/3ap1NvpL9LktFvXrZnlxsxcDEWYzYQnZ0UJrYrEEVUGa62+zVtZ93zWUDemE3gpUeBdx8SNb1eqCm5xv3robEo4aoFveuegbGBi7R7Nq2vfW/4JmLIeAvD31iY/0ci/tVs3PpxBWFMq52R/4CbR/iTiAqffd1Ad2rH4ZIJWo1vVkWLpZI1Jz8ZjsrigKrmdNxdQu/q8U5dWEWWSfkQ=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b531678f-f041-4946-5bb5-08d779827951
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 12:55:58.3249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQgrrO8wx1fMyCdOcd60stVINhwcavTs011MxYByAlr+mHC8tfjMIjQUbITw93+q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3039
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJVwXs894uiGOkCnD33847gdju6Rvth5sm0r23tg8cI=;
 b=BG1XzWevwnuDtQxSBqYJvjOY+Fup+dQe6zcNUsrXXb9XGrl7j9rLy3HPa++W26RxGQEigjCo8eS9nWmS/dRHJTcPaWDC3PO6+tO+DM1VjucKP9MIfz3j4+sIy1YX9hureFrzl+hsC7XOn0Qav4Yqs/cH1aieHAknF21AccvGsbE=
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
Content-Type: multipart/mixed; boundary="===============0101046576=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0101046576==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB329672AB53AAD19118DEDF64A25C0MN2PR12MB3296namp_"

--_000_MN2PR12MB329672AB53AAD19118DEDF64A25C0MN2PR12MB3296namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Series are Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Xiaomeng=
 Hou <Xiaomeng.Hou@amd.com>
Sent: Thursday, December 5, 2019 7:50 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>
Subject: [PATCH 1/4] drm/amd/powerplay: implement interface to retrieve gpu=
 temperature for renoir

add sensor interface of get gpu temperature for debugfs.

Change-Id: I2499b6652fad6d5d776b6ed4cd5157636583ed39
Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c
index 3788047bd704..3f6f0ebf1fbe 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -429,6 +429,24 @@ static int renoir_get_gpu_power(struct smu_context *sm=
u, uint32_t *value)
         return 0;
 }

+static int renoir_get_gpu_temperature(struct smu_context *smu, uint32_t *v=
alue)
+{
+       int ret =3D 0;
+       SmuMetrics_t metrics;
+
+       if (!value)
+               return -EINVAL;
+
+       ret =3D renoir_get_metrics_table(smu, &metrics);
+       if (ret)
+               return ret;
+
+       *value =3D (metrics.GfxTemperature / 100) *
+               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+
+       return 0;
+}
+
 static int renoir_get_current_activity_percent(struct smu_context *smu,
                                                enum amd_pp_sensors sensor,
                                                uint32_t *value)
@@ -787,6 +805,10 @@ static int renoir_read_sensor(struct smu_context *smu,
                 ret =3D renoir_get_gpu_power(smu, (uint32_t *)data);
                 *size =3D 4;
                 break;
+       case AMDGPU_PP_SENSOR_GPU_TEMP:
+               ret =3D renoir_get_gpu_temperature(smu, (uint32_t *)data);
+               *size =3D 4;
+               break;
         default:
                 ret =3D smu_v12_0_read_sensor(smu, sensor, data, size);
         }
--
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7Ce7bc3a8c13f84bcaa6ea08d77979b491%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637111436075244006&amp;sdata=3DanmGwlHsOZyOTVshYgwg%2Bzh=
Avwg3MYPzRrCiHgSosaI%3D&amp;reserved=3D0

--_000_MN2PR12MB329672AB53AAD19118DEDF64A25C0MN2PR12MB3296namp_
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
Series are Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Xiaomeng Hou &lt;Xiaomeng.Hou=
@amd.com&gt;<br>
<b>Sent:</b> Thursday, December 5, 2019 7:50 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Hou, Xiaomeng (Matthew) &lt;Xiaomeng.Hou@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/4] drm/amd/powerplay: implement interface to retri=
eve gpu temperature for renoir</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">add sensor interface of get gpu temperature for de=
bugfs.<br>
<br>
Change-Id: I2499b6652fad6d5d776b6ed4cd5157636583ed39<br>
Signed-off-by: Xiaomeng Hou &lt;Xiaomeng.Hou@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 22 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;<br>
&nbsp;1 file changed, 22 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c<br>
index 3788047bd704..3f6f0ebf1fbe 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
@@ -429,6 &#43;429,24 @@ static int renoir_get_gpu_power(struct smu_context=
 *smu, uint32_t *value)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int renoir_get_gpu_temperature(struct smu_context *smu, uint32_=
t *value)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SmuMetrics_t metrics;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!value)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D renoir_get_metrics_table(=
smu, &amp;metrics);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D (metrics.GfxTemperatur=
e / 100) *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&nbsp;static int renoir_get_current_activity_percent(struct smu_context *sm=
u,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pp_senso=
rs sensor,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *value)<=
br>
@@ -787,6 &#43;805,10 @@ static int renoir_read_sensor(struct smu_context *=
smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D renoir_get_gpu_power(smu, (uint32_t *)data);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *size =3D 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_GPU_TEMP:<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D renoir_get_gpu_temperature(smu, (uint32_t *)data);<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *size =3D 4;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_v12_0_read_sensor(smu, sensor, data, size=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.24.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7Ce7bc3a8c13f84bcaa6ea08d77979b491%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637111436075244006&amp;amp;sdata=3DanmGwl=
HsOZyOTVshYgwg%2BzhAvwg3MYPzRrCiHgSosaI%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40=
amd.com%7Ce7bc3a8c13f84bcaa6ea08d77979b491%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637111436075244006&amp;amp;sdata=3DanmGwlHsOZyOTVshYgwg%2BzhAv=
wg3MYPzRrCiHgSosaI%3D&amp;amp;reserved=3D0</a></div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB329672AB53AAD19118DEDF64A25C0MN2PR12MB3296namp_--

--===============0101046576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0101046576==--
