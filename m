Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD7BC5DF60
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 14:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91AF7214DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 14:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AF7214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ADCA6F9B2;
	Fri,  8 Nov 2019 14:37:43 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A109B6F9B2
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 14:37:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLAtJK6xR8htDl2+KW/3LjOckaws9+NbAo0EpoYsMu3lQKeHWOfgroISLMzRqhJTmu/jTnYXhJ+Oz5I2n//2p7M4RF9IvfLGEeaAiW6fG1HrSWjWWlcSUyO+CIFnH60oiACfJSxt9x2hJS5lRaph5G/J/Jqy9YU7AHWXtleAS6qd2SR3PugwNZ0mBck3azdwzsLjEqjQny5955n0i3FHnXwbB5AETstkOYV/mzl6tw8XzoU/pqg4+FGbsE0WHB9WoeF06GKGKPabAljO6TE+bo5X98iJ3nPNc3+dCT3os/lQ0hp3AgTjTeeMcbD01eFVdUcZLWyt4rpsz9opKxaPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iigVyx5WDm7o1xcQaUbLW2VsCemsROgRaXx9YhD3ais=;
 b=Smhh6vN7mKx7MnRBc8WkeatST6qt/QIhCLTCkdbiiLEwi8OIzQNfAh1XzEcMUpCl0p5zEIHxZ46G0I+nGgOUid4MhqYBVJyRmLNC30KYm2rpO3ywhNtwZtGApC8rIR0tYr/zd9BRIlVKn2XgLNDlHPBvGYL6vCM/TYL1/jk2ZATEKvc4twCEJyKpuDqp2aj2KaR+sIPmkeqCJ9Y9T5XgjxMnMI/idUE+UQhAP1hNEqh3LE59xjQ0y1E9/3JktLPXzPWJtcwB6WxKgm+mXbqkTpqah4HpeIL+JTgyL2kYV93VOYCGFNK79B1GEBl15oNjBnylc2sJTdSIrqYIi+Mitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1820.namprd12.prod.outlook.com (10.175.88.143) by
 DM5PR12MB2485.namprd12.prod.outlook.com (52.132.208.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Fri, 8 Nov 2019 14:37:39 +0000
Received: from DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::a0bb:dcbd:9ae:7807]) by DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::a0bb:dcbd:9ae:7807%5]) with mapi id 15.20.2430.020; Fri, 8 Nov 2019
 14:37:38 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, 
 "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: allow direct upload save restore list for
 raven2
Thread-Topic: [PATCH] drm/amdgpu: allow direct upload save restore list for
 raven2
Thread-Index: AQHVldeFrE70cIKU1UicTyTAEATq36eBWFQR
Date: Fri, 8 Nov 2019 14:37:38 +0000
Message-ID:
 <DM5PR12MB1820D10E9175BBF6E25A931DF77B0@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <20191108015432.11840-1-changfeng.zhu@amd.com>
In-Reply-To: <20191108015432.11840-1-changfeng.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6cb3ea5f-3fa0-49c8-e171-08d7645933ef
x-ms-traffictypediagnostic: DM5PR12MB2485:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB24851100958964075B17194AF77B0@DM5PR12MB2485.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(189003)(199004)(8676002)(229853002)(476003)(25786009)(3846002)(6116002)(102836004)(53546011)(6506007)(2501003)(76176011)(81166006)(11346002)(446003)(55016002)(606006)(6636002)(81156014)(316002)(7696005)(110136005)(33656002)(86362001)(54896002)(9686003)(236005)(6306002)(52536014)(26005)(66066001)(66476007)(966005)(64756008)(66556008)(66446008)(99286004)(8936002)(19627405001)(186003)(66946007)(76116006)(2906002)(71200400001)(6436002)(105004)(14454004)(5660300002)(7736002)(71190400001)(478600001)(486006)(14444005)(6246003)(256004)(74316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2485;
 H:DM5PR12MB1820.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: leW9Uvjt5NeWmmCbLo7MtjStYwokTjotSiIhWsO3/EzMncc/bpVRksZMRLDHlpMn+sphl5pzEGmqpsfM8oq+xdy2oUURU8bwqU6YKYbY9qUrwx+22N5K2lcRIFGqT+03sGYHrXqliCREfoycmpCEhC3toK3qcat7fvUOPrtiX8mEIS926jcfCc087tN9Cbj6iW0W3mYlQwxYidAcO2LXGWdVh5JpjF7P7fd14XHY5GSRNLoBeYf0RrTuHBZL/4IdUxziOzNUT5DOLXndDQiMqXPPexJAzCuEgnghJeqF4Okic9W/K0nIOyceiu35tI6DtSZJkB8hQYWMh3N8eHLLGQLyR66SqkM6dxuUbdT8HNMgVmA8I8EADxsFCPZD+eyNTm/ELkzLunjRIQmH8Spkfmmx76N0yvOhow76ghVZQJ1SnFf0ZUjFir7XwQoHH3Y5ipVYl0qr9KDXd78FBxEW7JLxMPJBvWYHJqgdN4s/0ok=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb3ea5f-3fa0-49c8-e171-08d7645933ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 14:37:38.1260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5BJuVbYaLtuMEd1SvFWsHTyZv6WSHAG/EIzWUKlbt2qHWw4abYZUx7Za7X1B8JwHL/CsvsZozHHl4mKB7u35PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iigVyx5WDm7o1xcQaUbLW2VsCemsROgRaXx9YhD3ais=;
 b=rhrm2cFZHnAz/XTkHkC/rRUCoNDwro+ipeBZIf5imqAnIUSeV7eFl/C4JxiVfUAK/C+eDVWJZiZeLxg1R6mRiqIIGafV+2OjESwX6pUKu09KDKsx23M9cPKfdfKfrYEvGIPmBktQ9y5eOwpv4+VzqESQxiImeKpV/k8Ca8vQZU0=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
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
Content-Type: multipart/mixed; boundary="===============0338956958=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108143738.LVZovB1LdTwuLG98pVQQnJhOKujrl9zO6uQQMfhLD_Y@z>

--===============0338956958==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1820D10E9175BBF6E25A931DF77B0DM5PR12MB1820namp_"

--_000_DM5PR12MB1820D10E9175BBF6E25A931DF77B0DM5PR12MB1820namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

What about picasso and raven1?
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Zhu, Cha=
ngfeng <Changfeng.Zhu@amd.com>
Sent: Thursday, November 7, 2019 8:54 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Zhang, H=
awking <Hawking.Zhang@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Cc: Zhu, Changfeng <Changfeng.Zhu@amd.com>
Subject: [PATCH] drm/amdgpu: allow direct upload save restore list for rave=
n2

From: changzhu <Changfeng.Zhu@amd.com>

It will cause modprobe atombios stuck problem in raven2 if it doesn't
allow direct upload save restore list from gfx driver.
So it needs to allow direct upload save restore list for raven2
temporarily.

Change-Id: I1fece1b9c61f7a13eec948f34eb60a9120046bc2
Signed-off-by: changzhu <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 4ed31e9a398c..dde9713c1d67 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2729,7 +2729,9 @@ static void gfx_v9_0_init_pg(struct amdgpu_device *ad=
ev)
          * And it's needed by gfxoff feature.
          */
         if (adev->gfx.rlc.is_rlc_v2_1) {
-               if (adev->asic_type =3D=3D CHIP_VEGA12)
+               if (adev->asic_type =3D=3D CHIP_VEGA12 ||
+                   (adev->asic_type =3D=3D CHIP_RAVEN &&
+                    adev->rev_id >=3D 8))
                         gfx_v9_1_init_rlc_save_restore_list(adev);
                 gfx_v9_0_enable_save_restore_machine(adev);
         }
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB1820D10E9175BBF6E25A931DF77B0DM5PR12MB1820namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
What about picasso and raven1?<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Zhu, Changfeng &lt;Changfeng.=
Zhu@amd.com&gt;<br>
<b>Sent:</b> Thursday, November 7, 2019 8:54 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Huang, Ray &lt;Ray.Huang=
@amd.com&gt;<br>
<b>Cc:</b> Zhu, Changfeng &lt;Changfeng.Zhu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: allow direct upload save restore list f=
or raven2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: changzhu &lt;Changfeng.Zhu@amd.com&gt;<br>
<br>
It will cause modprobe atombios stuck problem in raven2 if it doesn't<br>
allow direct upload save restore list from gfx driver.<br>
So it needs to allow direct upload save restore list for raven2<br>
temporarily.<br>
<br>
Change-Id: I1fece1b9c61f7a13eec948f34eb60a9120046bc2<br>
Signed-off-by: changzhu &lt;Changfeng.Zhu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 &#43;&#43;&#43;-<br>
&nbsp;1 file changed, 3 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 4ed31e9a398c..dde9713c1d67 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -2729,7 &#43;2729,9 @@ static void gfx_v9_0_init_pg(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * And it's needed by=
 gfxoff feature.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.is_rl=
c_v2_1) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_VEGA12)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_VEGA12 ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_RAVE=
N &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;rev_id &gt;=3D 8))<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v=
9_1_init_rlc_save_restore_list(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gfx_v9_0_enable_save_restore_machine(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB1820D10E9175BBF6E25A931DF77B0DM5PR12MB1820namp_--

--===============0338956958==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0338956958==--
