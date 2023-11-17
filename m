Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218F3C072A2
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 04:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741E510E5A2;
	Fri, 17 Nov 2023 04:25:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B2EE10E5A2
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 04:25:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G59hOkvQHdFHNqeS/OmX2y4YIoEcmn0Rjov7o68yiJY6uYjouPWSkcLaoLnBli9xnCH1OGXvkXFg7W3xBNr04BLWwqaP7Ztt1Vv+EkXfScSQB/fswOmMwP0PKJqeTuvOluKmOPv7bVj/8aVuHXfh2C263ILOo0YiMpSjKa6t83DP8hA/QDsEiFKWnugPvNOJoXMXijxsfJg9LtYZkBt+h+CFHff0wyJmwCgBvx6kGibEcb0yVdaJ6ztqmnT2z8iTSOYEnY5G/+/82xfdlTtFcelvdNm3RH2ghGzwVlZIuSoNUcRQC+crkUomlsj3Im3FGvMvhS8X8lAGRbJp6AUJIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5pCMaGXaCVdL1WOHO3j0pEaLRjJ5+KbU6+LCxUPtIs=;
 b=Rvkh19pRaS1cspKgFaQdqDyQLiqizRfEoqFdizgd8hI3jaAn+wvxcURNkZLKzVAyhFHaNpm62SDZusEbrnPuzqoKpTO31PS6jfZX90c6AhnqfZ/MOA/cpyo1tGMKIpg5hvsb1HWUWFXawHGv4aosNHFcH1SfLom67lhV2eYAtTbMTBoloHl3SKJbMTLVt6ngpU7H/7F/5EBxt1vmzt8idcQPrzejbVGr5mRFB4x29xxQIUm80UtqI+l+IIcCdttLKNgaIyhVcNFC2LFTfrP94tuLlUKiLOGCHEqUCNtt/oTZtfX26obOqFB2NWHAC1LiKsOcHcoe2ZxjmScrEOjldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5pCMaGXaCVdL1WOHO3j0pEaLRjJ5+KbU6+LCxUPtIs=;
 b=mgQAibcNJIGods4jpC89oISJQQYSk/nc5IoZJdn4aA0Nv6zsuy4TLSGJd5tzjB3SHnwQgnyq+aqQcZhHyN9qXdHkPD4vEf4uk6omgcbovOUm/I7z89Kjg+Y5KEcaUaFBx5ofeUUlMB1i6JVoYrmslSa7WRKPhp2dYcZnCZGNdnc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 04:24:59 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010%3]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 04:24:59 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdgpu: correct the amdgpu runtime dereference
 usage count
Thread-Topic: [PATCH v2] drm/amdgpu: correct the amdgpu runtime dereference
 usage count
Thread-Index: AQHaGQdHqcNUBenQMUG6q967sDNJ/rB96eif
Date: Fri, 17 Nov 2023 04:24:59 +0000
Message-ID: <BL1PR12MB51440FC93FC9CC5A6FA58515F7B7A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231117033557.1820476-1-Prike.Liang@amd.com>
In-Reply-To: <20231117033557.1820476-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-17T04:24:59.020Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MW6PR12MB8708:EE_
x-ms-office365-filtering-correlation-id: c5d9cdd3-7803-431e-93fe-08dbe7252936
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EauZiS/A6smPS/hd6ILtixwhlYp2RfxO/Fl6008dvPT+Tzzpolg47rm13W/YJfaBygbEaw/bFsCWq1IcjtY7pqcZd3uzVaOpRYxEUsmGo6cfczW0eiylfS1eqHXHZ9E9cd+OOJG9pGyOX1jvPB+xoctqnr9jp1bsrf9hUm0yz7Aia7hJJGEw4ETvc1hJjkGS17JxjN5y8B+4mvoZj3wB90FFgPopjVBaWX/oDBTi72Od/Q2IWnpC0HYVdC/xH1oQYcv7jQzrM7ZI4/VwwwANFHJ/8InOzTNwfR2b28FGQQCyK5dlnb7BmQ45+lTw1fCiLSxYpUn1p7SnNhA2BnForvwrSwMUIkp433Gtn/eDcRtJo4y7Y5bsUXypTwxZUfH+DLo0ONWW50ICRNSi2S2WiKeWLOefUwg9EY8+dEBhwLmKICwTN0C5DFP1YRPN+MYxfy0Sgt2kEAlC86MAB0TvDrTVh4oSos0uA+ZRgXv0XP2W3QDlYIzjGDZCQRpPmaMVcoYtXEitNbKjNxzdw27F9bMwcyP4/5d4nsNoupVjO7/9bNfIoJM8IZD0YcFiNxcwbL3AQkYcBF+siRSPZVpATepmwpsBffd3NdxOIcWE4RRDmEeBc2D7jsRzMYD4X+9w
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(83380400001)(316002)(76116006)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(8936002)(4326008)(8676002)(5660300002)(52536014)(9686003)(55016003)(478600001)(38100700002)(33656002)(41300700001)(122000001)(19627405001)(71200400001)(86362001)(53546011)(6506007)(7696005)(26005)(2906002)(91956017)(110136005)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zq6j0MbmqSb66xhrEJN3YRR1ttqfrZ9Rqtg3IFmVYG+C93lFRfRlJGkRd/yQ?=
 =?us-ascii?Q?jvHxq0Q5KySxxEqyLi54b99vEiNewjGRDzmxyiyQuvbuhNko81uenQznfTCC?=
 =?us-ascii?Q?J7DzYU7Dkf5lQZNBqrrwPRo9yB8gKuhtVIHc9VmTqQNwiuHPtKCxUnBbouz4?=
 =?us-ascii?Q?oTTiWI2rd8j+OBRMEopHCXn/0XpD29BOyZnnahgO4zdvM4IH6VzCg+OGvPlM?=
 =?us-ascii?Q?50WLUHxZEfM58xvgtK48YC471dzrjKG+JoeCYoGmOnWXv8MkWlQe9+OSgcOu?=
 =?us-ascii?Q?+LLvNdSytunbjA9Oszij+uQ6AkA1MLG6omIWMSRDBE+qvnEOo/QpyNdu+AsA?=
 =?us-ascii?Q?HEfkUSXkcxPOjaOYB7XUZy94Pdipjei2TQ2j1vFMF80TD+t8XjYsC74zm7r7?=
 =?us-ascii?Q?O2AHEbDwppvQvt4uV8+ZQ85zJjVZR2nIBC+Y9dvpVEaZNtmLAbbRQI/6fS+7?=
 =?us-ascii?Q?hElWcnka6/pjRT73Vw9THeAoh7GAyxFnqK9BxEEBmsO/QviWTBjHr69h4PDQ?=
 =?us-ascii?Q?zaZ/xjAezJct615fiF1Yc7Wkv97Gydr0fwV/OKtKehnxlLaoJ2U7W4RXXRc8?=
 =?us-ascii?Q?bTsjxloAUFE6/rhIAw3zVadjLJza4ox56RglWtRs5LmpKDor4TK79cSY0NED?=
 =?us-ascii?Q?aTDdlLYtLsR9lRdYOQ3bdBnz+Vl2X1482scIEUfmQArwojKU/oKeTg/nnTrH?=
 =?us-ascii?Q?fMLcvA3vdAztXG2NocL7fhq2XOcyMn4cxucWbz76FFqhJXsWaAdLl2EhERAG?=
 =?us-ascii?Q?pErXVz+l+kjYRe3yp3CEoMcdsAx8JOTUCSInsSAQ83zXYC0x53dV4qYgun3V?=
 =?us-ascii?Q?8pTzP1ocmLOz4Q+URLz2KLMA9ifG2jQ0FQDdORGIuOQsymVoAgWUCyOdfMrA?=
 =?us-ascii?Q?IVDUCM54jzc2SNyOdGiKTVZXEhxwiwbJ+fMNqPaS8tKZMrA0ewx8A41q/zz1?=
 =?us-ascii?Q?do01pKb1X04XJqfabfDh4uknYkg1p+WpUBIxPqiScvxePB2ebyTOj5nKIpZv?=
 =?us-ascii?Q?Ap3599zAv89VtUpR8GnGOm8kg6JRWqxp2KOqeehHxvtRzI+orabJvh1khGW3?=
 =?us-ascii?Q?Pk5e6LkkugXyGZFRtgTvUW3JXDNs3ouhOA2uLCcrEKSfD/WTT4eqxNm8GR3s?=
 =?us-ascii?Q?KTv/hUXb6UDt/lFVxV4o0zUA7JStU4ZcFZZUm3NCa8ukhDHtoEJ96MMQwCTv?=
 =?us-ascii?Q?4fpSrNGDgZwczhYl6tINnrk4lG4VgUi937ZiR/kqxPcFy7KeeLp0ntALHV/t?=
 =?us-ascii?Q?e5mgbgNpKYvnHDEQRPhWhHHYGvXcW6MVVbzEgyOVNRxaDpyNF4sdzrRGEo7e?=
 =?us-ascii?Q?jJiVqYbISe4PtVI/T9fD5l1RXeCrUSqbzElG50M1kDaLEOHai9QcF/zq5qxp?=
 =?us-ascii?Q?P06rCTx8BAtQ3dF3UFeulyDY3vQ3c57T5nS5ktZEr0Qoz07bhDwcB+hJn9Mn?=
 =?us-ascii?Q?psK3NZtJmO0sYhfbTSnPjxbNIJwr32ssnm/PGJSwYoGurpyr1e1zk5SSz893?=
 =?us-ascii?Q?s1AeWJsV6pf/4AFEH3bSOTWO2gXbX6H1+7raHyYI9r+Nw+KyipgTWNysqaG4?=
 =?us-ascii?Q?CN9IHE3EMuyvAqlwlCg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51440FC93FC9CC5A6FA58515F7B7ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d9cdd3-7803-431e-93fe-08dbe7252936
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 04:24:59.4135 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G2ulJpJMNVAtNmITYkXfZvksfq0W2sOPOygo1chj+8nvyeIsrPlKNGD/qKCyRwP4XeLE/E+K6Daxlq+qDYlCGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51440FC93FC9CC5A6FA58515F7B7ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Thursday, November 16, 2023 10:35 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Sun peng (Leo) <Sun=
peng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Feng, Kenneth <=
Kenneth.Feng@amd.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH v2] drm/amdgpu: correct the amdgpu runtime dereference usag=
e count

Fix the amdgpu runpm dereference usage count.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
v2: remove goto clause and return directly(Alex)

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c
index 0cacd0b9f8be..b8fbe97efe1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -340,14 +340,11 @@ int amdgpu_display_crtc_set_config(struct drm_mode_se=
t *set,
                 adev->have_disp_power_ref =3D true;
                 return ret;
         }
-       /* if we have no active crtcs, then drop the power ref
-        * we got before
+       /* if we have no active crtcs, then go to
+        * drop the power ref we got before
          */
-       if (!active && adev->have_disp_power_ref) {
-               pm_runtime_put_autosuspend(dev->dev);
+       if (!active && adev->have_disp_power_ref)
                 adev->have_disp_power_ref =3D false;
-       }
-
 out:
         /* drop the power reference we got coming in here */
         pm_runtime_put_autosuspend(dev->dev);
--
2.34.1


--_000_BL1PR12MB51440FC93FC9CC5A6FA58515F7B7ABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">Reviewed-by: Alex De=
ucher &lt;alexander.deucher@amd.com&gt;</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liang, Prike &lt;Prik=
e.Liang@amd.com&gt;<br>
<b>Sent:</b> Thursday, November 16, 2023 10:35 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Li, Sun pe=
ng (Leo) &lt;Sunpeng.Li@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd=
.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Liang, Prike &lt;Prik=
e.Liang@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amdgpu: correct the amdgpu runtime dereferen=
ce usage count</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fix the amdgpu runpm dereference usage count.<br>
<br>
Signed-off-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
---<br>
v2: remove goto clause and return directly(Alex)<br>
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 9 +++------<br>
&nbsp;1 file changed, 3 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c<br>
index 0cacd0b9f8be..b8fbe97efe1d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
@@ -340,14 +340,11 @@ int amdgpu_display_crtc_set_config(struct drm_mode_se=
t *set,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;have_disp_power_ref =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* if we have no active crtcs, then d=
rop the power ref<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * we got before<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* if we have no active crtcs, then g=
o to<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * drop the power ref we got bef=
ore<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!active &amp;&amp; adev-&gt;have_=
disp_power_ref) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pm_runtime_put_autosuspend(dev-&gt;dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!active &amp;&amp; adev-&gt;have_=
disp_power_ref)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;have_disp_power_ref =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;out:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* drop the power referenc=
e we got coming in here */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend=
(dev-&gt;dev);<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51440FC93FC9CC5A6FA58515F7B7ABL1PR12MB5144namp_--
