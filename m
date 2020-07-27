Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02233C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 08:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C049420672
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 08:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YzokQrGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C049420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7064A89BF6;
	Mon, 27 Jul 2020 08:40:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C780C891DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 08:39:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kxwd04mTH0Cbg59bxECv7gQun/f3JQwTlripivBNowozjQRfN0QG/9nVPt+m+VmlUQX3v3sZROOv9wpC6MrXbPsIUzBttPO0HEywCG6/3+KdPsdSFSYkAgaTHzs++LKwiRLAZXUjau/F3wXqfUa8I5T7pg4kZvrK38FfyqfstsW4Yon7xeT2amx+EqiNJSggbVMbkTqCLVjEGdhRDmpZhHlBgpNkDWU8O1MJGq7/GlitRd6yNPuohdBN3r/QKDrcNVLwQgXemLYYp8UsK2wUnAeLXShi9G2q/LUtmhbMr8UI+NjpHFdzBfGUwtUBgmef18z8tReNlxGWnYrivbIJ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rH9T4PiZzKVnGik1Ok2uxLw438cZbTODaKDiMg1JfYo=;
 b=KxNQq7gUiU+jTHVe4AKID9/nKbkIDyCM+G/sDkX/YuUlEfONhxdlDHhukqDsDuBYzBwAXF1zAbn7EMy/ip5jWXKRsSq2r80jv1Q1ghtEzBMq/Jgao+n4SvY7233lhSIUbVE8rNp5OXCuw+yt6fsC7Kuvqc3yMvdZI+bp0C5rF5vT2ku78sjr4YIBfxb00Z+Bl43KihtnYefoE1SNkYlfihceJJ1OYgNMDlW2FnwomqJlBcXArTqbpDtMG1kJkIALl64lJ1B32CDtUpUjvsktWOtGdTRQldm9wEhNT1f7lT0z3d4q8myV7UNPzPvl4KupUJkvGZlEeNXz9Si3iMCWFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rH9T4PiZzKVnGik1Ok2uxLw438cZbTODaKDiMg1JfYo=;
 b=YzokQrGiK14vmGM+9FLftjxbMOr4xxxCojcluNe31bFh5HEln9kKDO0/rpWhC/WXsjQaU80/lxvqilutkFE47HlE8mqJlqUQwLTCMgv5sB/nPtFcvVj8oFb2uk7f2VSRPRlmpyvc/p4ye7I7/yY2aGbXfib1OnJjU8EcZ24+W+I=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3263.namprd12.prod.outlook.com (2603:10b6:208:ab::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.27; Mon, 27 Jul
 2020 08:39:57 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6%3]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 08:39:57 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: skip crit temperature values on APU
Thread-Topic: [PATCH] drm/amdgpu: skip crit temperature values on APU
Thread-Index: AQHWY+9eFyC80nPJ+06xCXx2AoLkKKkbGwEE
Date: Mon, 27 Jul 2020 08:39:56 +0000
Message-ID: <MN2PR12MB3022828CB1930F9FF620ABC9A2720@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20200727082358.1242582-1-ray.huang@amd.com>
In-Reply-To: <20200727082358.1242582-1-ray.huang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-27T08:41:16.487Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ebf18469-3b8e-4547-a53f-08d83208a44f
x-ms-traffictypediagnostic: MN2PR12MB3263:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB326321550495794E098A3123A2720@MN2PR12MB3263.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uEzr154lAS3JGe+6RxR+EDQz/EB6I4scNid2bixSCXlMQAJRJhEn4dhDKCG4c6CZPM+YsGygIxveTMmWyt5RjOJ6XTIHjOtpkzuM1HpblgfWt0djFDJEv2t11LhbQ0gGj9x6CcdmWpVRTkoHHWs+OEN7OswEkFA5zLo1/Ln9H4G91mesriqRxpEoqL9xA21mjHRZjVzlC18kvWxkJDHyt259rgIwcP0kR4nFOfKA8rpSDTctuvTyDiqLvoLteGQh31YT7VryAoLW4MJKUwPv6SyQSaUQWTSYqHzPD22dK8gKHgcCJmgIz+hVD/6L8echcU/di2Vxy5yfZ7R8k5DSoJA54Bbj4JClykI+6Do9l3k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(8936002)(55016002)(71200400001)(316002)(8676002)(52536014)(91956017)(33656002)(9686003)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(478600001)(7696005)(5660300002)(83380400001)(45080400002)(2906002)(166002)(6506007)(53546011)(186003)(110136005)(26005)(19627405001)(86362001)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: hAoery9hrcq5kfgSORo9S9b+2hOvuyN3ycowu6SayPSAJ0gRF56f8lv3jLytb91zWHmTbHsvKEEEqDMET5iTwvMhBHaw+iEpav+ktP2XRLJvPtA7QcBL4gb9Sr9TPEZrM/crvmKVFux4ngmS77DJLLsd3Wtf7z9kSXyTM9wOum2lvEMJ1tF9U3Ub5M5CK6lTst4u1V8iOW2irwPnIF9wZf63+gS7orlhfHXrN+hX1MIJFP1V0OQGbV/FNVVMqR846nU9WYpulZtk9vmzlNIjv3dxMnn8HoaOkvhOmXJe4TvBZWzQ+J2CyYfY6mOfPH41f44RBP9mAYBqtZE6zTOtY3z+tciu7DloZUBbWFSKyqlM65M7Obrc5vT6JBjZJaqkCLGMOyR1msTqaldP83hFNulau+WTbGqhZPB0TgZ2RQjUBCo2A3yOhhtevlGVnR7NnAXZuZDWZRQRWzet+xMMxegcUf4R0wgpflLdhaLy2a9/9XrQzwXU0Bg2tc5ND5og
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf18469-3b8e-4547-a53f-08d83208a44f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 08:39:56.9566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TCMNktyni4Xeq00RlnG9vo4M7YCfJyg1FzHalHUazxZYUPmUAQDyfbkqR5GFr01Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3263
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
Content-Type: multipart/mixed; boundary="===============0878787377=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0878787377==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3022828CB1930F9FF620ABC9A2720MN2PR12MB3022namp_"

--_000_MN2PR12MB3022828CB1930F9FF620ABC9A2720MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Huang Ru=
i <ray.huang@amd.com>
Sent: Monday, July 27, 2020 4:23 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: skip crit temperature values on APU

It doesn't expose PPTable descriptor on APU platform. So max/min
temperature values cannot be got from APU platform.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---

This patch needs to backport to stable tree.

Thanks,
Ray

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c
index 5f20cadee343..65ddf575ccbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -3212,6 +3212,12 @@ static umode_t hwmon_attributes_visible(struct kobje=
ct *kobj,
              attr =3D=3D &sensor_dev_attr_fan1_enable.dev_attr.attr))
                 return 0;

+       /* Skip crit temp on APU */
+       if ((adev->flags & AMD_IS_APU) && (adev->family >=3D AMDGPU_FAMILY_=
RV) &&
+           (attr =3D=3D &sensor_dev_attr_temp1_crit.dev_attr.attr ||
+            attr =3D=3D &sensor_dev_attr_temp1_crit_hyst.dev_attr.attr))
+               return 0;
+
         /* Skip limit attributes if DPM is not enabled */
         if (!adev->pm.dpm_enabled &&
             (attr =3D=3D &sensor_dev_attr_temp1_crit.dev_attr.attr ||
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7C73c50b729f024e67b23c08d832067d7c%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637314350778753140&amp;sdata=3DD3wb3uQxXJJkj%2Bb4XuBxrb2=
oYnTUq9jHQNiAe4ctSlU%3D&amp;reserved=3D0

--_000_MN2PR12MB3022828CB1930F9FF620ABC9A2720MN2PR12MB3022namp_
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
ounces@lists.freedesktop.org&gt; on behalf of Huang Rui &lt;ray.huang@amd.c=
om&gt;<br>
<b>Sent:</b> Monday, July 27, 2020 4:23 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: skip crit temperature values on APU</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">It doesn't expose PPTable descriptor on APU platfo=
rm. So max/min<br>
temperature values cannot be got from APU platform.<br>
<br>
Signed-off-by: Huang Rui &lt;ray.huang@amd.com&gt;<br>
---<br>
<br>
This patch needs to backport to stable tree.<br>
<br>
Thanks,<br>
Ray<br>
<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 6 ++++++<br>
&nbsp;1 file changed, 6 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index 5f20cadee343..65ddf575ccbc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -3212,6 +3212,12 @@ static umode_t hwmon_attributes_visible(struct kobje=
ct *kobj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; attr =3D=3D &amp;sensor_dev_attr_fan1_enable.dev_attr.attr))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Skip crit temp on APU */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;flags &amp; AMD_IS_APU)=
 &amp;&amp; (adev-&gt;family &gt;=3D AMDGPU_FAMILY_RV) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (attr =3D=3D =
&amp;sensor_dev_attr_temp1_crit.dev_attr.attr ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr =
=3D=3D &amp;sensor_dev_attr_temp1_crit_hyst.dev_attr.attr))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Skip limit attributes i=
f DPM is not enabled */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabl=
ed &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
ttr =3D=3D &amp;sensor_dev_attr_temp1_crit.dev_attr.attr ||<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7C73c50b729f024e67b23c08d832067d7c%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637314350778753140&amp;amp;sdata=3DD3wb3u=
QxXJJkj%2Bb4XuBxrb2oYnTUq9jHQNiAe4ctSlU%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40=
amd.com%7C73c50b729f024e67b23c08d832067d7c%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637314350778753140&amp;amp;sdata=3DD3wb3uQxXJJkj%2Bb4XuBxrb2oY=
nTUq9jHQNiAe4ctSlU%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3022828CB1930F9FF620ABC9A2720MN2PR12MB3022namp_--

--===============0878787377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0878787377==--
