Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6290C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 22:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F25DC10E20B;
	Wed, 28 Sep 2022 22:02:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F99510E20B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 22:02:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbQLuIK+VIUI9VqAKn9OyWAdZObbOSz/2rX4oT46VUyxUs8wj7zgFkfaN/8x/wodZCTPHFPC2IU57yKunW9NEg4WWaN9lhClXHHfL8XZf8lI7i+DtAvlBbCsSqf0kJA96nalIXDUCdIMtzpiDB00mUWRawtyHUcZjjX1lmKHcItkmTbgIF/15OCanZG50MagrbeKDj4f/8RsgirbtgVhFZyqitlkmeXm2zF15vEAXBCMfsyN9eV57e5QCop8BgloJRy4mv5wO9IY2pVAk9+dOiWOgdRlIp88G8ui3tAHRnJ6fn+nnp2jOSGR4WGGX2zI1qB57G+fqtrRWvHITOfROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2a6TdkxiEwytvgPdsZ6oDHdHAwLzI3txy+xLb0DDKo=;
 b=Pi7XAVdbH/YK1Zg2if7+59RUGdSo7o8dhRG/YT3XtI7IwqOSOf5H5cBcQnaWdzfwxn/0B2e36Lrp9RzGbVsdKotZmRvZGKprStV1hbqF0QuR0aW1I03864B5mQOxyW5dOIhFKLGx3xCRZ5+UCfKTO7fcVDeDvYJabrInNDXwPa9ISOEbF5d7da8D/Hy7TP+SkrH/RuKWbbO4QIJNxgWYQHm2CqvFRKSfrPa7iUhJ4Guf5cW4q9E42WCv4g5HS6kTfjGh1Gl9k4JS+BQv8vU4u9ec8QQR7rGN9YTUjBfnnki7PYZIAUlzAd4Td+1uE2MU9edUM4W/pMeO5kQdI6ZaOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2a6TdkxiEwytvgPdsZ6oDHdHAwLzI3txy+xLb0DDKo=;
 b=uSwySxFJZWpK5pDB3rcmjvWA/NF2Yr452oi+3v5yMw8Za7SLUYzRMhilqnVVvlAzZGZoeHyYJ3NPAxCDlH/BNTYGbkRhqeaIGOW7OrzVNV0lDFogP6Kp9wQsjCW40wj8Jf0nT0kvcoVti47kNuCXpaizjyCAt/f8dZdp8YD9t3c=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 22:02:13 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::e11a:acb9:a1d0:e3a4]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::e11a:acb9:a1d0:e3a4%8]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 22:02:13 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Chander, Vignesh" <Vignesh.Chander@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Skip put_reset_domain if it doesnt exist
Thread-Topic: [PATCH] drm/amdgpu: Skip put_reset_domain if it doesnt exist
Thread-Index: AQHY020Qya9HEctUMECSuQS5nA1YJq31ZMlT
Date: Wed, 28 Sep 2022 22:02:13 +0000
Message-ID: <CH0PR12MB5372DCCC7FDBA85EA7378683F4549@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20220928190357.16117-1-Vignesh.Chander@amd.com>
In-Reply-To: <20220928190357.16117-1-Vignesh.Chander@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|DM4PR12MB5939:EE_
x-ms-office365-filtering-correlation-id: 9ecad66d-677a-447f-ed9e-08daa19d1931
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +x8fx7FFpv+m8kTuoLnE8rTIn3ejx3+Oz2+vKQ7zXDRqthTU7v6wPvrdgRJBzy8Tb3ddbR1rGgq2eqcp62lgyJhcCpbMr5kRW21fOKGoF+c6BCDaMItyjt5BMonKX2QPFR2DaSM3V4oSxodoVie1yUHtEjUJvMciu3Y4+S1eFGMdBxdIOq+/ZrOuoCO6+Un8KJPOByMfELYYt8ryNcOVcY/esQ5lRrl4CKMcvpBiiayzU/eCbTRr+hdCdWjan6hKyaNOSu8GNXB8aKHdwqBmUB/MNbYywjpKJA3w2YdUM7HUNeFY/eXvbyulg1jgfFDKqRV+zATyWCF3JT7mqPhzowCSjzdRfFP/FqAxFRx4JdsehBrJJpstu47WK0IyUOK90KFkqdhmDDi+PGG/joeTyZuF+69mBWGg+0OL6dQs/O2UOhV0F8OWSayzCkxaIER5EkQ3qW5goOcltSu0T66HohitTcBYZfkKW4ukzNqJbZ7KW5UumtIKOi/l1dag84m1JXjzH4RIUpQ7d8nm8B1lJ76fD5AZ++X5LpCTp8Aq+ugXYkT964Zqmsx5M0TUZib0QE94ZrnDPor+68I6A6iRATacq3av1SvrghUoJu+CvsF3CnHh4y0VKT4X4V7NMlyhQu/uNA+SV7cMeDCbWkiV9Hx25ILUy5UzKXbKWfI6/XNFdZOpnOUWFo1nWTQhZoolK6Gj/c4jbXcWVRNa22gscbdaEx88denMYaMlzR4auqvg9dexdvr/6AJC0y9c2+hmfqakADj9RoQyfHepT35XKw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(66476007)(26005)(9686003)(186003)(478600001)(6506007)(7696005)(38100700002)(316002)(38070700005)(83380400001)(2906002)(53546011)(71200400001)(66446008)(33656002)(8936002)(52536014)(110136005)(122000001)(5660300002)(91956017)(76116006)(66946007)(8676002)(66556008)(64756008)(55016003)(41300700001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aPWBtkyFXV6wR2XXZVDrhb7GvNmZ471QYk3jKZRJzdC2Xs709b6FKmB8rx?=
 =?iso-8859-1?Q?bChw/8OM//2mL3ZuZLghvWse3hkY0q2gmDmoEYxzK9tjKJvhEsKH2RZ05f?=
 =?iso-8859-1?Q?FsnOR/cLMDEBh+qh8/WJ3PGkuniB704ShOXBudiLA/so35WCHx+lOATxHB?=
 =?iso-8859-1?Q?NjTjsE+Ze3nRt4VoJZZe/Yk2bzNFdZkaHHkIHUw+bgkwv2vmr3DVBSyAF1?=
 =?iso-8859-1?Q?cL66Wma+ufld1CEGhS8TSF6qzqXuJEX3wtQpsGRwJGdV9Tm3GBZYytXu4u?=
 =?iso-8859-1?Q?qf3siaKx8cuGiCbWsCg01tp4NZCIwA6ahJccclKS8+T5XlEuGeJ+AqeITW?=
 =?iso-8859-1?Q?6LpNJpW9V9aTZsvwSoUWXgufeei7y3/vlnJdxCnWcjlOpcpkThDOCdYiqC?=
 =?iso-8859-1?Q?02trWJ/tokH4YFZzhnPILL8BjsE9AEhy6gxn2bGiOj7SRe5q4lKbqXp3Y/?=
 =?iso-8859-1?Q?PlYj2aWNATmhVIkYNJbY/6vjb5atDZxLMq4rjG3E5tJGQrA0Xxcg18HZ8K?=
 =?iso-8859-1?Q?sWdM5a8UbI7mItbm07wMxwOPNtpaiXlgwvgwcvHjucoh2qPghJxe7/TjRA?=
 =?iso-8859-1?Q?8NqA1rjeWVZQ4Cg3ckZgZHSLXdYa7pEWGRY6XmZ1sOQnvZFA8ODEMtu6B5?=
 =?iso-8859-1?Q?DqfI7MCiVb5FZwbjkGvbPOhTRsK+8js3IERY94vp8LjvX9c30ddZRLbdEf?=
 =?iso-8859-1?Q?oHJbX5yqC4O1RvzehsTsCJPTFPhXM+RfHzsueOPoJuK+2DRQsSLQdG4b7X?=
 =?iso-8859-1?Q?f1rGm5OgGeHhuq4oavBBWMIAqib8skTEJCc0VoI9emQ0QNMBqVYKFygX9y?=
 =?iso-8859-1?Q?bqQiHTN6r6cZyGpAdOj4oWNhaJHsHMxBT6JWBZYXMyT4TW84zVjZhC8pOX?=
 =?iso-8859-1?Q?Hf2Fe7CV2aLshI1j3ozMLkM0WqS+QO0li0Ld1nSCwHlemit0gFwK9h6jxu?=
 =?iso-8859-1?Q?CELOugUqddIVFzo4KpOyaL2PiHOtztP1Nal91k1QV5zhnqQO8FT08Cv1tl?=
 =?iso-8859-1?Q?f8wPv5Kboyb4eV3iIopeVeKFhQ7o8Vx6ofF7H3vPS/QJLfPGHfAYZzvLbA?=
 =?iso-8859-1?Q?Q5xah547SuWVGGFty0ftfRtpXKeApeAOvwgkVRdZP1+YZo4wkSc+B9lRrF?=
 =?iso-8859-1?Q?YrFmqQneq9JqjDd0rDOPNGMzgJZUvyXoicdMNrEd/OraHp9dG8B1lshxgg?=
 =?iso-8859-1?Q?rq5hmiZoWNpRtQigYVkhIYoQxbV6nFaZUCo40NbAB3xJ+uc7bSYNXUoXf7?=
 =?iso-8859-1?Q?pBd7Vmvej9Ec99EUeOX22z06TWaVHqUIyUJ2AB8BBKOXZbmtmH35t1pMmi?=
 =?iso-8859-1?Q?O9PI8L4DuxVYuZjMEMgFcyIVCfyAUUzfQ5oyf0RIT26G83oZBHnIJ6c0Dq?=
 =?iso-8859-1?Q?NZ/8lCixMSr0Izbd+Gh5kKpWztK0MrHDJq51WVsA2Z/NOBuZcw410ynVzi?=
 =?iso-8859-1?Q?o/lmX2v3CqvBFoFiUnUGtLzYe9s1yadd3CYo5QugBsGiaQDW161YFiupT0?=
 =?iso-8859-1?Q?50JV0967eem2tCdgiZbI3BkBAoNykLur1OBMjfFI9aPAJ07XKmCUFN1R0L?=
 =?iso-8859-1?Q?5C2ngKhqcfQh9MVifbhZxsa7OSmh7BQQeH95+RQpCI/wK7LohN9nLe53l7?=
 =?iso-8859-1?Q?Uo9c5Jv/TW2iQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5372DCCC7FDBA85EA7378683F4549CH0PR12MB5372namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ecad66d-677a-447f-ed9e-08daa19d1931
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 22:02:13.0517 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CwumbpwFVO/KIHU4dNpRePUJlm3jWZEmanBF2J1WRKc0Nba66e+iq10XBTmlirVzvfvnCkPZTRinBm1rSU1dIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB5372DCCC7FDBA85EA7378683F4549CH0PR12MB5372namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Looks OK to me.
Reviewed by : shaoyun.liu <shaoyun.liu@amd.com>


________________________________
From: Chander, Vignesh <Vignesh.Chander@amd.com>
Sent: September 28, 2022 3:03 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Chander, Vignesh <Vignesh.Chander@a=
md.com>
Subject: [PATCH] drm/amdgpu: Skip put_reset_domain if it doesnt exist

For xgmi sriov, the reset is handled by host driver and hive->reset_domain
is not initialized so need to check if it exists before doing a put.
Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.h
index dc43fcb93eac..f5318fedf2f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -113,7 +113,8 @@ static inline bool amdgpu_reset_get_reset_domain(struct=
 amdgpu_reset_domain *dom

 static inline void amdgpu_reset_put_reset_domain(struct amdgpu_reset_domai=
n *domain)
 {
-       kref_put(&domain->refcount, amdgpu_reset_destroy_reset_domain);
+       if (domain)
+               kref_put(&domain->refcount, amdgpu_reset_destroy_reset_doma=
in);
 }

 static inline bool amdgpu_reset_domain_schedule(struct amdgpu_reset_domain=
 *domain,
--
2.25.1


--_000_CH0PR12MB5372DCCC7FDBA85EA7378683F4549CH0PR12MB5372namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div style=3D"font-family: inherit; font-size: inherit; color: inherit; bac=
kground-color: transparent;">
Looks OK to me.</div>
<div style=3D"font-family: inherit; font-size: inherit; color: inherit; bac=
kground-color: transparent;">
Reviewed by : shaoyun.liu &lt;shaoyun.liu@amd.com&gt;</div>
<div style=3D"font-family: inherit; font-size: inherit; color: inherit; bac=
kground-color: transparent;">
<br>
</div>
<br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chander, Vignesh &lt;=
Vignesh.Chander@amd.com&gt;<br>
<b>Sent:</b> September 28, 2022 3:03 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; Chander, Vignesh &lt;V=
ignesh.Chander@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Skip put_reset_domain if it doesnt exis=
t</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">For xgmi sriov, the reset is handled by host drive=
r and hive-&gt;reset_domain<br>
is not initialized so need to check if it exists before doing a put.<br>
Signed-off-by: Vignesh Chander &lt;Vignesh.Chander@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.h<br>
index dc43fcb93eac..f5318fedf2f0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h<br>
@@ -113,7 +113,8 @@ static inline bool amdgpu_reset_get_reset_domain(struct=
 amdgpu_reset_domain *dom<br>
&nbsp;<br>
&nbsp;static inline void amdgpu_reset_put_reset_domain(struct amdgpu_reset_=
domain *domain)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kref_put(&amp;domain-&gt;refcount, am=
dgpu_reset_destroy_reset_domain);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (domain)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kref_put(&amp;domain-&gt;refcount, amdgpu_reset_destroy_reset_do=
main);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static inline bool amdgpu_reset_domain_schedule(struct amdgpu_reset_d=
omain *domain,<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CH0PR12MB5372DCCC7FDBA85EA7378683F4549CH0PR12MB5372namp_--
