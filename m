Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94022C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 15:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58839206C3
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 15:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lyc8AQde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58839206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DFE76E8C9;
	Mon,  8 Jun 2020 15:01:48 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680073.outbound.protection.outlook.com [40.107.68.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 151366E8C9
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 15:01:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmbDZvL4N0IMiDG7IGj8iD/Apegxx2E1Dxeg5zN767Sz0HL/lXtEwMvSajvHpVIHUy5Sj/Ml72k71B3f++nxvrTgLDyUHRH4sRRjbYt6wnG/Cv9xNv/mo7mrR8XP91kfFdHqEtWpglZH5RDrnZd5XyBJz5m0tEQ/+7Mr+AOwLlXBgXINFEz9HsF+Xz+q5ySdTEY9Tg5r9A+ZejuJasS5aHBdtLNlaU2gCGUtxijH9EykbsJDLx4Z7l0l5Vsv8eUCCAy6a2A9Umi7cizwVevaBS96/71CcuERqgv4q+P7NwtcNpICT4F8o8ToB2bQc2hOcgOrMZsQQmifey+7Lfgzww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GitEn4o0FRL2eEJh4FKuZDSf7OkfVt60imsXWR+uYtE=;
 b=dQfW6uYCx/6KdG+6lvyfqOtPw97dyAUAWgpYsm/1zja8PHtwfdEtX7JG55UtNdc7yctd07B0MC3J/8tKCdVKo173W9ztAQABfuwD4EnLVKXXAY8xEr6iWhuFYbF/Z7FodS/TqXKFab2Psid8vgeTIQDE3m/2N/GNHOLxcPUUQF+wK/xeyWgEJETxuip8pmNTceHpYqIagKMZOHtvlF/LiH0LiHH8+F2zCtxIpWz32BXhJA5q3+Hbx2Pvy1jSfy9Y8T1jtSG3C5ZLfDuV2savgdApL4UKIy1K9h0wNT6iUgIn4lKJJsRFr0zHG8b2y9pPbmvbglrkyjzDrAg6Wfy3Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GitEn4o0FRL2eEJh4FKuZDSf7OkfVt60imsXWR+uYtE=;
 b=lyc8AQdenesCWTnmbMrV7tLE8xPV5BazRQpS4bT8gPkTth5r+f7nNHpbV3DrtISAQ0ILc2Ve/4UtlBqMX89S+r5CX9fSV/pYxDF/ZYBOrOSKPf7TqYd3OhOC+fYkry3vqDUN6zg0ft/KVopXVjk70WHeuSS1D7bUfYcyTzke7oU=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3934.namprd12.prod.outlook.com (2603:10b6:208:167::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 15:01:45 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72%5]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 15:01:45 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: move maximum sustainable clock
 retrieving to .hw_init
Thread-Topic: [PATCH] drm/amd/powerplay: move maximum sustainable clock
 retrieving to .hw_init
Thread-Index: AQHWPYIlL/nBggQ/+U6Xs6YWymcx3ajO0FN3
Date: Mon, 8 Jun 2020 15:01:45 +0000
Message-ID: <MN2PR12MB4488A422C4B2769AB7B65EF0F7850@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200608104627.29595-1-evan.quan@amd.com>
In-Reply-To: <20200608104627.29595-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-08T15:01:44.696Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [172.58.222.239]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b67e651-28a6-483c-2d71-08d80bbcdc75
x-ms-traffictypediagnostic: MN2PR12MB3934:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3934EB0B0CCFA2C473BEC1C9F7850@MN2PR12MB3934.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oyvxFbTHt0wTGpNSQt4EqZS+qw1Z8+I0ViivyDk+kSV1vPHA7GYdIIJLSYl9cS4gilRVPlfEfTJjYjtie1+Dp16mMbhaGB2OCHsIZ1q5oBIQrgGX9sQLr32JCGrdZmuLCwNiJ1MKe0GWXIeNn7tZEcvrf3d4dHTCk81FgMCtebjn9qFvIjXI+TbHFIarkZ4elndcVULiV+muFL8yn6cgovIl8ZejzulaqbDHYpdHLVL17rKoqp10lzbobDVSbuSV+eWHktc9sNi95swguF2PLJkaXv57ZKxNv8zcnWPFbGfkULOSLsMOn9T1KUv1Zom9/WSte7mQnkf3LRnTlKmVnYVEAL4VgkvuHkhWLJ2BYzdgVcKn+/8+DZQ7/jU8113u
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(76116006)(26005)(19627405001)(8936002)(66946007)(66476007)(52536014)(4326008)(66556008)(64756008)(66446008)(5660300002)(2906002)(86362001)(7696005)(9686003)(8676002)(55016002)(316002)(83380400001)(110136005)(6506007)(71200400001)(186003)(33656002)(478600001)(53546011)(142923001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 9R9QCSPZ84y6wtz79tsBHD5psGmri31LvtIykY2FwSSiOSs4Ep2L93x5lEk9NToj4Rb7wAZEdZ3UzRdmfZtJNvJyOJJqxtm8HH3Wcg2jBrha0b9J6DOwNaYVRsYKqBXj+2SJtqN/c+5+9piIVTkVaqqQnQ77kqk8CXFVQoj0b4Y9huHAGuShe8FIn26i4DxZIc1jtXdrYurK55qszRuLR2YpH+mVW0tQrJo02gvNRaGZbHYMTwnn1Raet8Kwg5dyrrXyk0u0mV6aSbohufV0odnxCwPqVPFxPVvM9KD7lrSYVp2hrf+wEKUDyW5chFuH1QfejKO6BA8oQoKn14CHuCgS3ZxuikmWpJgRl2Gm65aKiTbbV4dl+INEFOiFykfM8tlZIvD5SI5nTeY1/HQ4Xai+cp1Pu/3qxJrzpvY/OWP7JRlJCOOWzlrX/mB672ZwNn1X+B0jummD7Yrbxz9ePLITkIwTmR9Rif46uDlMGzgDo8tZU4SzVizTgeq3lKu8
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b67e651-28a6-483c-2d71-08d80bbcdc75
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 15:01:45.1865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uyABzo/HkhJgyaeI32VPyjoLqSd7K5CJKbcMabSm1JO6KK1qBEX7EsXScQRK8M0s1vmzHWP/3x62ISHJOOfpLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3934
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
Cc: "Cui, Flora" <Flora.Cui@amd.com>
Content-Type: multipart/mixed; boundary="===============0149605583=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0149605583==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488A422C4B2769AB7B65EF0F7850MN2PR12MB4488namp_"

--_000_MN2PR12MB4488A422C4B2769AB7B65EF0F7850MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Monday, June 8, 2020 6:46 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>; Cui, Flora <Flora.Cui@amd.com>
Subject: [PATCH] drm/amd/powerplay: move maximum sustainable clock retrievi=
ng to .hw_init

Since DAL settings come between .hw_init and .late_init of SMU. And
DAL needs to know the maximum sustainable clocks.

Change-Id: I0702b7332a0d7c0b29dfdf4999c18efb588b8862
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reported-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 725ac90c0f36..6beae3b496be 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -819,12 +819,6 @@ static int smu_late_init(void *handle)
                 return ret;
         }

-       ret =3D smu_init_max_sustainable_clocks(smu);
-       if (ret) {
-               dev_err(adev->dev, "Failed to init max sustainable clocks!\=
n");
-               return ret;
-       }
-
         ret =3D smu_populate_umd_state_clk(smu);
         if (ret) {
                 dev_err(adev->dev, "Failed to populate UMD state clocks!\n=
");
@@ -1364,6 +1358,19 @@ static int smu_hw_init(void *handle)
                 return ret;
         }

+       /*
+        * Move maximum sustainable clock retrieving here considering
+        * 1. It is not needed on resume(from S3).
+        * 2. DAL settings come between .hw_init and .late_init of SMU.
+        *    And DAL needs to know the maximum sustainable clocks. Thus
+        *    it cannot be put in .late_init().
+        */
+       ret =3D smu_init_max_sustainable_clocks(smu);
+       if (ret) {
+               dev_err(adev->dev, "Failed to init max sustainable clocks!\=
n");
+               return ret;
+       }
+
         adev->pm.dpm_enabled =3D true;

         dev_info(adev->dev, "SMU is initialized successfully!\n");
--
2.27.0


--_000_MN2PR12MB4488A422C4B2769AB7B65EF0F7850MN2PR12MB4488namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Monday, June 8, 2020 6:46 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;; Cui, Flora &lt;Flora.Cui@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: move maximum sustainable clock r=
etrieving to .hw_init</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Since DAL settings come between .hw_init and .late=
_init of SMU. And<br>
DAL needs to know the maximum sustainable clocks.<br>
<br>
Change-Id: I0702b7332a0d7c0b29dfdf4999c18efb588b8862<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
Reported-by: Flora Cui &lt;flora.cui@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 19 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;------<br>
&nbsp;1 file changed, 13 insertions(&#43;), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 725ac90c0f36..6beae3b496be 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -819,12 &#43;819,6 @@ static int smu_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_init_max_sustainable_cloc=
ks(smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to init max sustainable clock=
s!\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_populate_umd_s=
tate_clk(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to populate UMD st=
ate clocks!\n&quot;);<br>
@@ -1364,6 &#43;1358,19 @@ static int smu_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Move maximum sustainable =
clock retrieving here considering<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 1. It is not needed on re=
sume(from S3).<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 2. DAL settings come betw=
een .hw_init and .late_init of SMU.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp; And DAL=
 needs to know the maximum sustainable clocks. Thus<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp; it cann=
ot be put in .late_init().<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_init_max_sustainable_=
clocks(smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to init max sustainable c=
locks!\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm_enabled =
=3D true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &qu=
ot;SMU is initialized successfully!\n&quot;);<br>
-- <br>
2.27.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488A422C4B2769AB7B65EF0F7850MN2PR12MB4488namp_--

--===============0149605583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0149605583==--
