Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E48C2BA83
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 14:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14DB2187F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 14:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FbwIc0Jo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14DB2187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 992F26E804;
	Fri, 14 Feb 2020 14:41:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990A96E804
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2020 14:41:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAN1grX3MWo/YP+a5iiFaUPZz8I254onSqgfN2fR//Qn6vo4uqdLVHMls3I7JLjQWN4U4OPqdGKVX4wRJLtAu6grAzrzf1LwTNOBUaQK/45IokZpoe8MbV6ZX1FNvg+S5HfWD2hwwsFRMJh8sIdpLZhsiEoqYuPHlbjxoeSEYlIqRtJSGWXpIAzWJTxlpbdR3Ea4ejovJYmVhYM8e8EtKpUEqAbx0rhhaaYW04l9efhhA28YB0mwOTm0aOmrGpuUB3i/Xo5EwWiy2ZMF/POHKjQSX1uy33NxqPG3TICSbfozNgBUr+YpA80scXodXlB5lGEQ9D6qE6s3IhgtZkXjLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/og0F2fpTcMjDmo3p3j00Ur9Sw/hlvQUzUBlky/iNVs=;
 b=KWqzwNYVCwDthPhMR0kX9d0XD2KN+qfwcNhcWSL0LmJrBD02tA/fDZJ3fbqJ9Eh9HKyeDhehP0OShtje1HA/9DhA3jCzWAxDktxqTP/XkVrE8B69LmV3CmTOFUw6QnoyL5dgI3oSQmJF9WBo7PZgHmQj4B1/9zxd5ybA0sgsDDRVM5oh1SQlApmBd12qNjzvI4o1VIM7cl8mupD3SnqNFFlcvyrg+vHiqU/ZW9wnCmSEQ4iW0VhPwP8DIa7v0270i/Nfhnrs0tHPCwaoYyaS1okwTLWeumiU5mDTI3n0KdcqWFK5NJbPBknyqbhU4HqpeZNdHtERAeGg2nLRwvNMrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/og0F2fpTcMjDmo3p3j00Ur9Sw/hlvQUzUBlky/iNVs=;
 b=FbwIc0Jo8eeLxmiJ3K6if5ILADFfzj2U93lUjsB3KFejNc5LrPmCIXEBT7SthiAk8kq/nKBn/IzT5vatk+PZVP3+9kHeghS35USjf7kF9iuNnRC4s28HdvuHSqPEiRblpLoOwNWvZ3vZuUITSV6yMK9HvgmRiyWUYKRiN5K3Sfk=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (52.132.246.86) by
 CH2PR12MB3814.namprd12.prod.outlook.com (52.132.245.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Fri, 14 Feb 2020 14:41:35 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2707.030; Fri, 14 Feb 2020
 14:41:35 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: add is_raven_kicker judgement for raven1
Thread-Topic: [PATCH] drm/amdgpu: add is_raven_kicker judgement for raven1
Thread-Index: AQHV4uvcC2bHTe5gxkuIYD6Q44DJiagaw8VV
Date: Fri, 14 Feb 2020 14:41:35 +0000
Message-ID: <CH2PR12MB3912E8CE15ADA5E4859E749AF7150@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <20200214040358.27771-1-changfeng.zhu@amd.com>
In-Reply-To: <20200214040358.27771-1-changfeng.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-02-14T14:41:35.277Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8499974a-eb0d-40b6-8801-08d7b15bfe14
x-ms-traffictypediagnostic: CH2PR12MB3814:|CH2PR12MB3814:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3814809BE4664711B5F768A6F7150@CH2PR12MB3814.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(189003)(199004)(5660300002)(33656002)(2906002)(81166006)(7696005)(316002)(8676002)(6506007)(53546011)(110136005)(26005)(186003)(478600001)(45080400002)(966005)(8936002)(81156014)(9686003)(19627405001)(86362001)(55016002)(71200400001)(66946007)(66446008)(52536014)(66556008)(66476007)(64756008)(76116006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3814;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FXC7ypChHxPghs751ZTdzc1jf5M7ffGPkX3L+p0N0+pZcB92PL6S96A1Ky3DCNwb2x8QeKjHx0bV25UySyjsiMj8LIgSI2e9G6sQHlfX18eLs6+x96O7mMTMj8A+/MRMCEP5bTSbTQ/OW87tKwpUvsOfhfCn6/9XEUoyt1PtsiLRFzOHJBS5o05e+rLafnQx5tWx/fuLue4/vgL1kfYTiWTSBcKhcTsjHa2c36CV+Rn4oCz1ZyrHHLyZfWdnCvBIWvF/n2BGZBOLpJ6k5mUTbxrnaUlvvf5cF7TjFRfJwF3JU7jDY5SOxHRi02li6E7stSfBmTrpwt8mfb+9R36Hg0QyqeI3XN/fZGG3qkA16K2gHhKc7lr1k6nbuGiKgUQH2LJa1ekSL/h1kishNztMbnwEfgznBnJ6F0tnOu3MN/lQZgxXVeL+jWNKeDfowdtOZxpouBKnBVDsXhwopcznKAMsvU+durYXrWwGdum89QlxUEoBohO1CMajsUxztTrqceQrFSKW2+J/WyfTbsgRcg==
x-ms-exchange-antispam-messagedata: 7rp2yynfR2XIx7/BBeHtdGjrvJvnRqxc9nb/3HpoJVr19X4vpZPHTeHgXo3IwsFLD9JRfmXBNFRUYeeYT5z7qdlhaDXIQB6nakGyEXPu9HBwAQv05quJf8SthP72g8ONtI0P8ceP/eliRqTgonXn/w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8499974a-eb0d-40b6-8801-08d7b15bfe14
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 14:41:35.7634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+deaqI/3PSmjObqDCk+vS0XFHfG2CtWygoHAgJ/Jq4bV5GoDaIa/FuAQS5lGmqTE17kUTG3mWwQt99wqyNBGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3814
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
Content-Type: multipart/mixed; boundary="===============1036795670=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1036795670==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB3912E8CE15ADA5E4859E749AF7150CH2PR12MB3912namp_"

--_000_CH2PR12MB3912E8CE15ADA5E4859E749AF7150CH2PR12MB3912namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Changfen=
g.Zhu <changfeng.zhu@amd.com>
Sent: Thursday, February 13, 2020 11:03 PM
To: Huang, Ray <Ray.Huang@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Cc: Zhu, Changfeng <Changfeng.Zhu@amd.com>
Subject: [PATCH] drm/amdgpu: add is_raven_kicker judgement for raven1

From: changzhu <Changfeng.Zhu@amd.com>

The rlc version of raven_kicer_rlc is different from the legacy rlc
version of raven_rlc. So it needs to add a judgement function for
raven_kicer_rlc and avoid disable GFXOFF when loading raven_kicer_rlc.

Change-Id: I00d726cc39eae4ea788c1d5faeb8ce75ec0b884d
Signed-off-by: changzhu <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 4d8b58e9d0ae..9b7ff783e9a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1193,6 +1193,14 @@ static bool gfx_v9_0_should_disable_gfxoff(struct pc=
i_dev *pdev)
         return false;
 }

+static bool is_raven_kicker(struct amdgpu_device *adev)
+{
+       if (adev->pm.fw_version >=3D 0x41e2b)
+               return true;
+       else
+               return false;
+}
+
 static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
 {
         if (gfx_v9_0_should_disable_gfxoff(adev->pdev))
@@ -1205,9 +1213,8 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdg=
pu_device *adev)
                 break;
         case CHIP_RAVEN:
                 if (!(adev->rev_id >=3D 0x8 || adev->pdev->device =3D=3D 0=
x15d8) &&
-                   ((adev->gfx.rlc_fw_version !=3D 106 &&
+                   ((!is_raven_kicker(adev) &&
                       adev->gfx.rlc_fw_version < 531) ||
-                    (adev->gfx.rlc_fw_version =3D=3D 53815) ||
                      (adev->gfx.rlc_feature_version < 1) ||
                      !adev->gfx.rlc.is_rlc_v2_1))
                         adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C5839d10e3a0e4c5615ac08d7b102fbc3%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637172498725043115&amp;sdata=3D3D1zzp0A4FGFntc4f%2=
F4K3u%2FB4wYKtTtwDsPJkYoIslo%3D&amp;reserved=3D0

--_000_CH2PR12MB3912E8CE15ADA5E4859E749AF7150CH2PR12MB3912namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Changfeng.Zhu &lt;changfeng.z=
hu@amd.com&gt;<br>
<b>Sent:</b> Thursday, February 13, 2020 11:03 PM<br>
<b>To:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhu, Changfeng &lt;Changfeng.Zhu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add is_raven_kicker judgement for raven=
1</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: changzhu &lt;Changfeng.Zhu@amd.com&gt;<br>
<br>
The rlc version of raven_kicer_rlc is different from the legacy rlc<br>
version of raven_rlc. So it needs to add a judgement function for<br>
raven_kicer_rlc and avoid disable GFXOFF when loading raven_kicer_rlc.<br>
<br>
Change-Id: I00d726cc39eae4ea788c1d5faeb8ce75ec0b884d<br>
Signed-off-by: changzhu &lt;Changfeng.Zhu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 11 &#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;--<br>
&nbsp;1 file changed, 9 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 4d8b58e9d0ae..9b7ff783e9a5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -1193,6 &#43;1193,14 @@ static bool gfx_v9_0_should_disable_gfxoff(struc=
t pci_dev *pdev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static bool is_raven_kicker(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.fw_version &gt;=
=3D 0x41e2b)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&#43;}<br>
&#43;<br>
&nbsp;static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)=
<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gfx_v9_0_should_disabl=
e_gfxoff(adev-&gt;pdev))<br>
@@ -1205,9 &#43;1213,8 @@ static void gfx_v9_0_check_if_need_gfxoff(struct =
amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;rev_id &gt;=3D 0x8 || adev-&gt;pdev-&g=
t;device =3D=3D 0x15d8) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev-&gt;gfx.rlc_fw_version !=3D 106 &=
amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((!is_raven_kicker(adev) &amp;&amp;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc_=
fw_version &lt; 531) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;gfx.rlc_fw_version =3D=
=3D 53815) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;gfx.rlc_featu=
re_version &lt; 1) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;gfx.rlc.is_rl=
c_v2_1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;pm.pp_feature &amp;=3D ~PP_GFXOFF_MASK;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C5839d10e3a0e4c5615ac08d7b102fbc3%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637172498725043115&amp;amp;sdata=3D=
3D1zzp0A4FGFntc4f%2F4K3u%2FB4wYKtTtwDsPJkYoIslo%3D&amp;amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7C5839d10e3a0e4c5615ac08d7b102fbc3%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637172498725043115&amp;amp;sdata=3D3D1zzp0A4FGFn=
tc4f%2F4K3u%2FB4wYKtTtwDsPJkYoIslo%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB3912E8CE15ADA5E4859E749AF7150CH2PR12MB3912namp_--

--===============1036795670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1036795670==--
