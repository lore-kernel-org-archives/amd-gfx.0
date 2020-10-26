Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBB0C4363A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 14:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5444B21655
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 14:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mvRFyMhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5444B21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C270D6EA12;
	Mon, 26 Oct 2020 14:18:41 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750085.outbound.protection.outlook.com [40.107.75.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9118B6EA12
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 14:18:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdBTGdIXcyeIZGGEMy98G0w77Jjl595M6KzRI7PWY39o1SrTIg65/IKFgWr7CqDKHriJBTI2etyPZf7avclqx0xu8HUGHE24TUAJeMKLAtGRDQqMXeVgcvMlq8fEv3EoZguSVPhk8oa49yHtS3FHfRVQ9XHOcg4Ncd2/MugKoXYmIxKPfSQFsuHKHOE10F8WHLFd/oilDleNNC0pQH9p/jYA8u3geWSyp58t9VH4KsF6lun+VxdDY8K+QcwHEQe4mhA77qIqwuJcCS4/5zbbSOUm0784TUxDFWv4OqMD6UZEwm+dTMSxW5zwWADC1tGImtTvmD2eV2B6cFTLWwe+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcnoS5/bu9bviKyrCX95esEC2C6Pu3oP5RY9pHKg9R8=;
 b=Rm1a1gIxy46LXY6uZcpfNdDqPiarJA8vYGYoaiLCe4LNcjkSsGAo6OzHpdZa0J5QsnbNxmqyjXG3f8p0VNMmYqT3Hl2uk27lR1Y//rocyR9iFJTn80XbW3WKlwBktpyV4kNbivPMSiuB2faQzFgDn0QWycF6m1DL9SNTO2RWzKGk3/+QGCaQMejiks3JANWoxUlgfwmzpYjIQDU4laqxeBDKl2XiBhI/i1MU5rvqY8veEwzrHC6z15ldNL7L2ZL7V5djXcRz4Oqy0dNilHwzlpT00KG8PH3tTv1qqFJIwFIsubOe0X/mv18E1H3iYWNAmvP1xO8D0ssX38Uq8KSyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcnoS5/bu9bviKyrCX95esEC2C6Pu3oP5RY9pHKg9R8=;
 b=mvRFyMhph64ZBQJlRn9uf92FZLtgazWBDV6Vwj/tpap7xofEZITV1SRiCJ5sIlQLiMZQk9Jx3qLsBqNZ5aoXtfbM2He2qoGw99LaGSlm6+rRY88dOCgGmJtZJWobugE2QdcTwIvITVoJcW9fgmjLG249/bNcvcpUII8oiUzjUdU=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Mon, 26 Oct
 2020 14:18:36 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 14:18:36 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: drop mem_global_referenced
Thread-Topic: [PATCH] drm/amdgpu: drop mem_global_referenced
Thread-Index: AQHWq3p7qXxq5J8cYUqHCLkH5oNCFamp7sCL
Date: Mon, 26 Oct 2020 14:18:35 +0000
Message-ID: <MN2PR12MB4488CC65DACB4ABCC08DE7BCF7190@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201026092912.2488-1-christian.koenig@amd.com>
In-Reply-To: <20201026092912.2488-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-26T14:18:35.361Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9caf4118-c3b3-458b-703d-08d879ba06f2
x-ms-traffictypediagnostic: MN2PR12MB4488:
x-microsoft-antispam-prvs: <MN2PR12MB44889A249AA9D6F6432DB5BEF7190@MN2PR12MB4488.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:189;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CI2a9Csf8LI4TMmUOZWajDZGVhJC04Dkc4EfNRmfarrNMwY2nLvLaNIvHaI3Hue4+gPWuqCD2Zn6BpFXVPnDGX8sbmFlxZoum0/9M38YzEku8LaqPSkh1IIpUFzp1cmaVJir/CXXSsetXt+GWFjRqNz0KARe1jwuqpE62umXnurvhqCVnE9DOi8+rJ0crai+bCqP91SLhkuz7TRLy6iujbUKni45BYAd+/NvtZokaYcLoSuYmTzjD6l9QgR6dodykZMHkxAm2j3zYBOTDrZo1VDz8ZgIhSj8xHzivoHYCqhtipe3who+RRINiCSGJYjW3t1yRKlei6xVel0cp4HR4Z6SMxyKj7XqcfqgSG3fIoo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(86362001)(110136005)(478600001)(71200400001)(2906002)(9686003)(8936002)(66574015)(7696005)(19627405001)(66946007)(6506007)(76116006)(166002)(26005)(45080400002)(53546011)(83380400001)(5660300002)(64756008)(186003)(55016002)(33656002)(316002)(966005)(66556008)(8676002)(66446008)(52536014)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: TCYia6aEoMGljqhG0inHwPSZoOlTcDLd4xxnTgUIjNjkurEE7GIGgOFLFHlNrsE5yQ/p/iGwbspM7EAZONxEewPgxkt5elAkb3Y6mADU2J/cuT0VwhGVWmzGornBY0ifeJa8fr8XVsAh+lXH/blRb2TIohhXdz3poVRpL7U5RQTB9TbxDWoJMjsV6iFdkOEsZpS8PxURLE+LHT5AOwRzaFCE+9N+QOX0i/8wrwZNwqYyZngD2Uvrw4fdD+MkgnZWvAWmBZgkmseHcATDEAKL5L8Yei0IuSyPn74AKxYCWdB+cHXUMxJyvVlLtIhpocvN1MXJj3nYmn41//AeslmL+yDVs8IsYZY9Vvx8CgVvj6HBXr7dr3WXgKPRhuNH+JvAo3eIT19liBbtuqYKztY24q+JmQS00/9Lyrh+A96oBO1QusFpr710sr9q2tMcw6gZiXSgImW8xKHVoVxiMjZGZXPyWk8bhXn3WkRPckwLLPV9KN5GDhYfevNdRk3JaNLr996DNDI64tRbnNW15mdsrH3tMqj2G3+FxcM0/kcvaHKTcCQeLDwBMu//CAw+TYNa3UJaFGwzOH4VDvAMtQTooNJbjeKkAg8dkS5N4WoSb3cWy6MQ4aqKooxrUkFz27+lXCOGO3eM/rC8mGHdK/eOTA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9caf4118-c3b3-458b-703d-08d879ba06f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 14:18:35.8861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6B88QtsptdAL4ume9q6ZkEHNG0ZAeVIUSLXb6ZuOhLKqkRgEh526Sc4pWTStF1WuJToN+DLNRn1gTAGorWddSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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
Content-Type: multipart/mixed; boundary="===============1735324192=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1735324192==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488CC65DACB4ABCC08DE7BCF7190MN2PR12MB4488namp_"

--_000_MN2PR12MB4488CC65DACB4ABCC08DE7BCF7190MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Monday, October 26, 2020 5:29 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: drop mem_global_referenced

Not used any more.

Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.h
index 68c5e3662b87..d808b2a58b28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -58,7 +58,6 @@ struct amdgpu_gtt_mgr {

 struct amdgpu_mman {
         struct ttm_bo_device            bdev;
-       bool                            mem_global_referenced;
         bool                            initialized;
         void __iomem                    *aper_base_kaddr;

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Ccd8ff5e90c384fadb84308d879919c44%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637393013597084067%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DWaPRmdfK6tnkLkM2PqpEeTv86hilcxdSklXb%2FeloGso%3D&amp;reserved=3D0

--_000_MN2PR12MB4488CC65DACB4ABCC08DE7BCF7190MN2PR12MB4488namp_
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
ounces@lists.freedesktop.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Monday, October 26, 2020 5:29 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: drop mem_global_referenced</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Not used any more.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 1 -<br>
&nbsp;1 file changed, 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.h<br>
index 68c5e3662b87..d808b2a58b28 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
@@ -58,7 +58,6 @@ struct amdgpu_gtt_mgr {<br>
&nbsp;<br>
&nbsp;struct amdgpu_mman {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_bo_device&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_global_reference=
d;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; initializ=
ed;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void __iomem&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; *aper_base_kaddr;<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Ccd8ff5e90c384fadb84308d879919c44%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637393013597084067%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DWaPRmdfK6tnkLkM2PqpEeTv86hilcxdSklXb%2FeloGso%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7Ccd8ff5e90c384fadb84308d879919c=
44%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637393013597084067%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3DWaPRmdfK6tnkLkM2PqpEeTv86hilcxdSklXb%2FeloGs=
o%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488CC65DACB4ABCC08DE7BCF7190MN2PR12MB4488namp_--

--===============1735324192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1735324192==--
