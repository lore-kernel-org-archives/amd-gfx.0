Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BE6C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 08:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0FBF10E8CE;
	Thu, 20 Jan 2022 08:42:29 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC6B110E8CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 08:42:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwcgnSLEbFQNycfFhcNWxloHFolr6VHiNV1nHuDGNzydEzxwlme4dTwQD/VVJnRQZLy2zPNE2luMQJjOEQdisD7fWqZdKaa2HfCI71CSTEs5QsJPkz9sJGJ4VaJYryEJpKC5ut7TkWNNnWhJmmd6lw+SYuIk41/o+u7EhsoDsOLimvwwSYnIg/JeHuCsQfziKf+rY+x7DCMg9wpdtn0BbcMRCuK5ZIfll3DCNv3TnGASYK4n8vhZlPEib1V5O80160s74sR5YXmDmrnn/4Mfdhz6BqfhnXizKgAY3FAUM16Cbf/wZM33te4Ib2zQ2GvnfoumNjYbXovcIjp3cci3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lu7vvTiBEMmXuRhMV6z54uCTPoOaSVFGAUY1AypRXng=;
 b=hWJFw75VGFHjrLp70/gBwkfFhLgKKbT7gwJuZaqiHvitQtZ+M7fKxKQCLR2p0KQsMQdnalWA18Y76FWCMZWELWT7vd/qHbFCpxQbs+ge+irQ6Lrax4bXeQPX1sdLDqXWNdFfZxXvWnts3VrTju7xK7+pu1PUiAZjoWDO/+rNeUe+LnF2Z7E+T87ElfR6mliPrwyxYUXOypGv40YEz1Ehv/ifm9hT1dmDBNOFL4ah2AB6TKCWewrfup4eXKp8OeKN9WFR9mSzDAxdjfV6feKWtwEyYXlrxxHxbkIsIlfUxT7VXwhKYdfPhXiES7qdRIK9x5Ncmh83SDPozou0K6hPog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lu7vvTiBEMmXuRhMV6z54uCTPoOaSVFGAUY1AypRXng=;
 b=oemlipTYsu3Ddrj9FvNW5NcRrO+W5kAmIC49JlOt20u37xDYqIxAYCXErYExKPIIa4ZNywqetOwQ1z8k1eggF/p1J31FOVCTAnNQdWPTTMWvjpfAzRrmwBL5aTKD7/49/4FXMDlsQCUU7BBYZwu92U90l5gLxGVhW/oBl8J8/j4=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5475.namprd12.prod.outlook.com (2603:10b6:5:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 08:42:22 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::b49d:d2e4:875b:e881]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::b49d:d2e4:875b:e881%5]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 08:42:22 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/admgpu: fix the page fault caused by uninitialized
 variables
Thread-Topic: [PATCH] drm/admgpu: fix the page fault caused by uninitialized
 variables
Thread-Index: AQHYDdQc/RdiNH25DE+dfwDM6zzgc6xrl33x
Date: Thu, 20 Jan 2022 08:42:21 +0000
Message-ID: <CO6PR12MB5473E9A8CCAEFEA46C695759825A9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20220120080220.27663-1-Xiaojian.Du@amd.com>
In-Reply-To: <20220120080220.27663-1-Xiaojian.Du@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-20T08:42:20.815Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 710df73a-adb1-4a0b-ae09-08d9dbf0c69b
x-ms-traffictypediagnostic: CO6PR12MB5475:EE_
x-microsoft-antispam-prvs: <CO6PR12MB5475F7FA3A00BF05AF04497D825A9@CO6PR12MB5475.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eH7iYDGB7ewn6WCSImL0U8y6YYFjqxnrP9YDnsJ7KhcWikbT6tR1UmK2AdqfAIK4IJaOXvhNp+tNxIloX4/ThrnFWZOPcvgZa5uLJfSt3klZieq75rK8pH0Xx15MLq2aFp8smtN/oiwLciHWCwHbg+j35jVLqiA5Ndi7zqAlQxgJp5LAAbhqSq2PXkqGcNZu4f/VWxFyZci/mD87GWW2IOrbENRvMoXnLFHQ9ip7ccAr8seJT8Zk5ZAGodarCfyv8MEwKLHyTFHD9EPto+rqfYMatFR0/qNLrWvvlxl/o/cAR7D6v/sXpEiWKsz7l/oWoOz/uOdy4YJkYEB/edqSdi2JQab/QTimfuR4YFXZFzUvcI7P8Eje19noBp/pXg3WRB7+CrFdhiAM/QVAEFyBpbVoL65wRAO4skQ+6T1neNAwIv+98sAaOjX1WPMiyj1JCexx4wVxilw8Ap77TMrav9hTVgLVSZ4cwRwFOWKpGqZO/3EUbV1iiFZSbUn85QUfbeSzYuu5mRGTaw4LmQkTQVQXb0dCrcYmmr4Brhy33aPXyldSRMEvpQvtVqW/eUpGC5hZZxhNsTFhBayg+zmSbEtozJMTpeZB276ZiV3/7IEDGIOHPuO03vpeCOXZ94SsYLf4Lm65AgBn5kamoobt4PNjoN53DtCVSFFa2uAJfF6OebCvI+J3LkNpDiHRFDJIVV6/n7hLsTUUgGHuvBF+EQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(83380400001)(19627405001)(33656002)(38070700005)(86362001)(71200400001)(91956017)(76116006)(55016003)(8676002)(66446008)(64756008)(66476007)(66946007)(4326008)(508600001)(122000001)(38100700002)(2906002)(6506007)(53546011)(5660300002)(7696005)(316002)(110136005)(66556008)(9686003)(8936002)(186003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4B6GDhCuo00wGvPzprsPvB7CDl7DyNAXkgpSDSJyEgKY/ZbvIBHYG+QmTy?=
 =?iso-8859-1?Q?gY7DW4wbyPwBe0MFLN6+AUhdMHykYOSV9gFeaY34mqg2YIDH2U9+++Orlc?=
 =?iso-8859-1?Q?39BLc45MnSbIQjl2OQqkSYi2hI1jUkSLjeU4M1TdKxuH/kKhHixlvI6xbZ?=
 =?iso-8859-1?Q?6oOMU/JU+uCXGp5woqCf5pIl/kl0KHbwyy1AEIdTyi1ZPWgDzGVhk1xKtr?=
 =?iso-8859-1?Q?GCqUkmBn0g0TdTL3XSxgIZSBN3JpW2WWCr0GwOaWn7ESi51aLJ5FV4gkLB?=
 =?iso-8859-1?Q?gEnSiT84enXyikfUr7Sh1iYCsf+9yoInf1LJggz/mMzAxmoO8HUYnbNjrC?=
 =?iso-8859-1?Q?WnjZsPQJffJmhYd4+pasaozfP7jqh0VVWBVnnF6cjWX5QmaiCw8vhz8jGH?=
 =?iso-8859-1?Q?nFocbJsmDU68qgNzN/h+dBRhUK5LQTrU/9BxJsuah1UyeXDjQ57tK6Zw4o?=
 =?iso-8859-1?Q?HHJ77cf5xLkBTFi+PF6cQLcR3cQufPhaxPghbIPeKNigluqQ0t9ZE7BuNr?=
 =?iso-8859-1?Q?1ocMRC6hhm+CPy3AfdzTStVdJoj9ybMYVn+2W+Yy4NeWmYfOZGUz2x48AW?=
 =?iso-8859-1?Q?DQupOnZEBCJXRFcdj12aQgVOAUEXBJuOPI+Wdw8+KBar+Cgx2ZTmDdHD9z?=
 =?iso-8859-1?Q?yHu/+mh+BJwxVK2UsdhtdezsN+xtR5vPNlHquk6DHJbcIzCZqghWb0J4oi?=
 =?iso-8859-1?Q?Tt+6jocPrZ8e2beAInOPJv8s3hjbTSqRIxe+kD7EsG/4T4PYHSEYJpyFgf?=
 =?iso-8859-1?Q?WpkkFIKW2Sc1rg9KIFMLxOIyArl6Ikzhk2MW3ve3OXd1g4zp7jy+kM+ol/?=
 =?iso-8859-1?Q?bhvfr4wTIzSpPt5s/mcGYEXbDIHnVghxWzDB2gHLQlrBfekLeejJ1QTPoP?=
 =?iso-8859-1?Q?+PNdCtOAUZ8mNgTnBsUm/PC9tXwJBUBhYDsnBgWxQpjqWJqm7p4MDQ6MYS?=
 =?iso-8859-1?Q?4S8YkqIA8ljhQNzHphpxqTEjW0p7U6qw9OrYyzR4BeWDyBIGVVnuxDdYL3?=
 =?iso-8859-1?Q?voj/Cn7BakCOMJ8Hc/5aq8VRfQ9X5N/0mC58XLhezUO9Zml+HmhBSm7GGC?=
 =?iso-8859-1?Q?fTbIl0tqn7TBNTceyWwChs3Ea+qgXgXRp4jy9eeYfRxEJSz0Z71lkm67ZQ?=
 =?iso-8859-1?Q?IBydbZzxw78F5S3iM4zDOFzJHU38u72FAkeC4VqHeDvvRyF174u1cFVx6I?=
 =?iso-8859-1?Q?4U21D84p5/rqh1qGGIlHBEBPfdD62tOxUS3H3qfQMNXQzWnasbwlsxNpqF?=
 =?iso-8859-1?Q?B4oNgSFu8otdI3l/NC58BNgzqy7r//zac6tJYJF7sO1AiIBjxuu1sNg3OH?=
 =?iso-8859-1?Q?LmQLG2dJT8NBQkBXS4nb1A3H0/IWCMMU2JNAWjU5VvOulVQFwiS6Jrd78h?=
 =?iso-8859-1?Q?/6VbrK7n45dT/rs0qhozspl/6FEgmKEoAAYhzI9ah71DOIkntI5H8NXUh/?=
 =?iso-8859-1?Q?mFh9l312VkmXhIG0CxjQtzVcmKDm8GMuf+07C8z6B9U6Znz/KwI3gm0dsY?=
 =?iso-8859-1?Q?hBodaCxDA2ohf1RD0AjNOBRhp/lXiQ0UwaA42/6eKa+YbUMLQinGh54SaO?=
 =?iso-8859-1?Q?089en15z2KVBLDe85o6Bg032har6Jzd+PR3cQRFzsgwTtxz7xYuXWNH3MG?=
 =?iso-8859-1?Q?gkBkKDap8Esm8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB5473E9A8CCAEFEA46C695759825A9CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710df73a-adb1-4a0b-ae09-08d9dbf0c69b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 08:42:21.8642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kJuF3EMsC7NR8EBLqgLrEWH+4cPfqIzBgPIn6G6BE5QLeM2cCBAeFH4JCXYjgfzw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5475
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CO6PR12MB5473E9A8CCAEFEA46C695759825A9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Xiaojian=
 Du <Xiaojian.Du@amd.com>
Sent: Thursday, January 20, 2022 4:02 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Huang, Ray <Ray.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>
Subject: [PATCH] drm/admgpu: fix the page fault caused by uninitialized var=
iables

This patch will fix the page fault caused by uninitialized variables.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index c65d82301bca..09780a0f874a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -828,9 +828,9 @@ void amdgpu_gmc_get_reserved_allocation(struct amdgpu_d=
evice *adev)

 int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
 {
-       struct amdgpu_bo *vram_bo;
-       uint64_t vram_gpu;
-       void *vram_ptr;
+       struct amdgpu_bo *vram_bo =3D NULL;
+       uint64_t vram_gpu =3D 0;
+       void *vram_ptr =3D NULL;

         int ret, size =3D 0x100000;
         uint8_t cptr[10];
--
2.17.1


--_000_CO6PR12MB5473E9A8CCAEFEA46C695759825A9CO6PR12MB5473namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;</div>
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
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Xiaojian Du &lt;Xiaojian.Du@a=
md.com&gt;<br>
<b>Sent:</b> Thursday, January 20, 2022 4:02 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; Du, Xiaojian &lt;Xiaojian.=
Du@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/admgpu: fix the page fault caused by uninitiali=
zed variables</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">This patch will fix the page fault caused by unini=
tialized variables.<br>
<br>
Signed-off-by: Xiaojian Du &lt;Xiaojian.Du@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 +++---<br>
&nbsp;1 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c<br>
index c65d82301bca..09780a0f874a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
@@ -828,9 +828,9 @@ void amdgpu_gmc_get_reserved_allocation(struct amdgpu_d=
evice *adev)<br>
&nbsp;<br>
&nbsp;int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *vram_bo;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t vram_gpu;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *vram_ptr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *vram_bo =3D NULL;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t vram_gpu =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *vram_ptr =3D NULL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, size =3D 0x100000=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t cptr[10];<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473E9A8CCAEFEA46C695759825A9CO6PR12MB5473namp_--
