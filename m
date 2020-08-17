Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D42DC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 14:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37E8204FD
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 14:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WfB+0sfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37E8204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F41C96E0EA;
	Mon, 17 Aug 2020 14:50:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09FA46E0EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 14:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCgUskvGcBEulcajm61gAtx8qeXwAynEMR2p8ZEvO/JmZd+wcpaZFstopXcSs8DUWjIt/+Zjv+Md7o3Ne4/vrOx581M/sPFTVpXfj0ipSCGoXMlHmAb9Bo9anHj03NDzu5bgJlSfedIDWUtgPaAN/9ET/wfbElkhb0d2pObapGZo2qp9QUvapF9tbfK5A+DqhNRuuIjfSSsfJN6KCN+Y15HgHZXdxH5uTK6E/N78MZnqh6Ii0eGIpJx/cXT1/UqL5HuBgSeQbdpAk73MYCTTrmWxUcTXN4I3S8YCVBi1M2FpZS8Q2+eM/1CI5uRVGJ2mQqExW+Ws+AwepRpwYpWaJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6W5Qs/PWBa/tAQxTnltjODrsSrB95vFqjtcd3scBtA=;
 b=TWchOQ/fFfKEYYqKShoELV2+CUSflhNoMhma+ecxCCvPl3MQYs6wqD2aYUhRZoIWAJYXNXp34hfd8OTS3Z/ZEvRb86QlP+380kT8IphNbEekQ7N2OZHIxnoMqVWDd/YTWyZ3IEnP+GgJmVNy1J1qni5tcHg+GhSredIMsOmIk8gEZLR8hPrJCRluAyYXZ2lu/CHhsctIYCTqhSKVQ2RmTWApEcS+AIW1K3QfULkV1bI5X0UllMk7wFcrvSgHT+5z4sr3hE2htWq2qM6nwy6/Jnb4+5sXkDk4jEsLOF9iI/zSPifH6gJtpzEd7Bw4FRwkaXdCijI4cBphsHwkumm0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6W5Qs/PWBa/tAQxTnltjODrsSrB95vFqjtcd3scBtA=;
 b=WfB+0sfJzxVfX6Qswo8hb+9YIp3+StiSMMvi5Oq/zP0GM/98VXxswOPaEKqbB7/yX6SkF2Vj2ldLSmtMJaXNzNbzeQKElOFWI08d4lcbcukf5OxDQUuS5NP+Mym6nEoffFa2bDUN2MJUnj9tlLINjZEyg2raXvrEcoSpV0iDOZs=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Mon, 17 Aug
 2020 14:50:37 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 14:50:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] Revert "drm/amdgpu: disable gfxoff for navy_flounder"
Thread-Topic: [PATCH] Revert "drm/amdgpu: disable gfxoff for navy_flounder"
Thread-Index: AQHWdKUjBifuVZ/TkE6rgI0/Y/4uzak8Yijv
Date: Mon, 17 Aug 2020 14:50:37 +0000
Message-ID: <MN2PR12MB4488DCAE0DA354452D42C65FF75F0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200817144549.16407-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200817144549.16407-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-17T14:50:36.853Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aff25be4-ccec-425e-bbc8-08d842bce74b
x-ms-traffictypediagnostic: MN2PR12MB4501:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB45018D509A849EBF026185A2F75F0@MN2PR12MB4501.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:189;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TIberszly+nmEaFU8MURX8Bnv2r8ExsBpsm1gev/fKrIB3Q4yU9P7ykc+cxo9y8aOn9mdINcrdtaPrYJluNhEdIsKwDsaYQu7kvMPsMr9r6Wd9rKx+nmgse3xzVO4354Jy3v8YfW7P+shxOAx5T5whWQesXtyqKRK4j20IQJ7trvQbMugwZkBfyce9nnqV9exoh5Nvn4kG+iOW2iCbsi5ir64khTt7Bkfw/xMf9/M1ox6fiCnKFbO0/i02pzLKbD4q7vG06KMrhhHu8vC4ehzxLP//Dhedev+MgSo/R4XQHk62CtcItgv8CJ50b1B6RTHXJoRIfEo6KdjwSmOVYEmJ2n0CY+KGurRpYlK9fOSWQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(55016002)(71200400001)(66446008)(54906003)(86362001)(45080400002)(110136005)(64756008)(66476007)(7696005)(19627405001)(76116006)(66946007)(66556008)(9686003)(8936002)(966005)(5660300002)(33656002)(52536014)(316002)(478600001)(8676002)(6506007)(83380400001)(166002)(53546011)(2906002)(4326008)(186003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ZCwFU0kPa+4kmyUYumfUp207GrKvZuE3DpC04obG/pdfalEAyxfSY6VurNhrUSayxaHT9l0tkmW6uwRq4ECWFloL/kQTgxwLmyZLNx3wHZlSbTf1vukG6s9wWwPhcKrPJUCO6LMwyIQSRntP8qsT41O/GCvdnFEUku13OBe//MT0p50yWSNhdvtzUOyZcyfu49Mpraz3K7/8YFjVhlovRnwP0AEOXfnYj7rLQGSm7WhDKk4uX2was81b5Swe8SWFmA6nXU+9pKXrn4wTAQqfGSuvo2oBObn9SLZmHTpSqBH1RBXvT+RHZ9cVLtMFjaW6+kYk1i+2K5CrQ0XbDNtKSebSSxmw1A8Ms1n/xQRrVHrVfOvqPyU389XatuVM5eeYCoIy75YeDSbpKpNgNx3TUSelwxS8OcEcH1EbuOJZ3izIRHjZ/8Q22hHIhcyUP66b5RcRUz+qVfc7N6v7qGChlzab4DHTBwWfFBtO3fvfVY868rsDfQ33msw5xHeL+1FmbFaWZHDo/CPERqPWHY2ktzM0HuQR6QPFUdU2RdfjtOLL8Tz/YUm0dkzPJv3m32jVcKcs+Krea7e7Yl3bvm1UqtxZOaXRpWJGodlZGWRtJ3ebzkc2U/oBL5JSntb/nDqgiVwCvR7P1xq1jroQRak/MA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff25be4-ccec-425e-bbc8-08d842bce74b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 14:50:37.3147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qlPEpakey/x+3c1VbwTa0OaSX2/KjbCFpjm9K0zoyaakSbyNmO4pPtOe+TmwzY4ebxigAkYlD8sHrW8cAiSAmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: multipart/mixed; boundary="===============0863493573=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0863493573==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488DCAE0DA354452D42C65FF75F0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488DCAE0DA354452D42C65FF75F0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Jiansong=
 Chen <Jiansong.Chen@amd.com>
Sent: Monday, August 17, 2020 10:45 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; C=
hen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: disable gfxoff for navy_flounder"

This reverts commit 6a72ad7e387c6fec821c230fda3460f79fc0f877.
Newly released sdma fw (51.52) provides a fix for the issue.
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index e87d43537013..e527be22a3d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3610,9 +3610,6 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu=
_device *adev)
                 if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))
                         adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;
                 break;
-       case CHIP_NAVY_FLOUNDER:
-               adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;
-               break;
         default:
                 break;
         }
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Cfe56ae8b28a642d0860008d842bc43e4%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637332723663638132&amp;sdata=3DxMP4WmjGoryNjXtsOAa=
Oe%2FmzdL%2FWe1BEvOJ0DOAUAWo%3D&amp;reserved=3D0

--_000_MN2PR12MB4488DCAE0DA354452D42C65FF75F0MN2PR12MB4488namp_
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
ounces@lists.freedesktop.org&gt; on behalf of Jiansong Chen &lt;Jiansong.Ch=
en@amd.com&gt;<br>
<b>Sent:</b> Monday, August 17, 2020 10:45 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Feng, Kenneth &lt;Kenneth.=
Feng@amd.com&gt;; Chen, Jiansong (Simon) &lt;Jiansong.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] Revert &quot;drm/amdgpu: disable gfxoff for navy_fl=
ounder&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This reverts commit 6a72ad7e387c6fec821c230fda3460=
f79fc0f877.<br>
Newly released sdma fw (51.52) provides a fix for the issue.<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 ---<br>
&nbsp;1 file changed, 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index e87d43537013..e527be22a3d5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -3610,9 +3610,6 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu=
_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;pm.pp_feature &amp;=3D ~PP_GFXOFF_MASK;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVY_FLOUNDER:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;pm.pp_feature &amp;=3D ~PP_GFXOFF_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7Cfe56ae8b28a642d0860008d842bc43e4%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637332723663638132&amp;amp;sdata=3D=
xMP4WmjGoryNjXtsOAaOe%2FmzdL%2FWe1BEvOJ0DOAUAWo%3D&amp;amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7Cfe56ae8b28a642d0860008d842bc43e4%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637332723663638132&amp;amp;sdata=3DxMP4WmjGoryNj=
XtsOAaOe%2FmzdL%2FWe1BEvOJ0DOAUAWo%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488DCAE0DA354452D42C65FF75F0MN2PR12MB4488namp_--

--===============0863493573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0863493573==--
