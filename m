Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344E3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 22:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C49EC10EF76;
	Fri, 18 Feb 2022 22:45:35 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54E9610EF76
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 22:45:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zx0SATbTgQRnWQ6zxPcqVcm+VZOtBT/In41jageUYs3DDAOOBl1ZreL5hr4TEpdGjEmI1VIzhVa4NySpTspb/pu7ArmdDEhcxg8u+GuBuFd8JAPwiM7RQBknBjYKrH2SvFjPJns3HK/AObz0SwCOJIG5wu63EKBXRtFsuV7qU+FVM0wyTzQwgKbv8pXTW36usuZIhVWy+L9TeA6kRxdpoSSciwRDzN4wskh33aiRJ7KQiqYRQhTYfDl6zLs62K69qEEMxSWUAoSgi7S7APxva/BovZLSlWSw9LsALglaJ1yLnD1AlZ3uz8q56rRb+R3umckPr+tLClQ8YJSntAGb9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDi1q04XFf/JbLMJk6ZRslzIYtBynJ0BOxrOkJOV2MA=;
 b=hFoebvXluhHIIDXrG11H5HnuWTn0+DcfgnpxbNgivhw1eDRiEZh5WYJNOKS/r5t7ilc0a+qvlwfHDQVoGRXMJ0ZaO4Szbgg+Mx2Et189v5mvzMaLqT8TNO5qZ/apWKAJufuqmuTUPpR9jNXRunTWTSEpTpoz5iWmfMe0KpOcezQ5SwgcipHmWrmDCwteifeqQU0GgWWH0tc94Tyb/Y/Qi6dIqm3nEx+A4LzyMb2kyXFmaq5WmuTglFSi2B8d3tiAbYJNLcBDYvsKwtjTM9ihTexxP/1vOnf1aJTaL0qO3rzmdsM/nE97O6d2TsF62+TZUNVNmI1dmoapIH5q26kqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDi1q04XFf/JbLMJk6ZRslzIYtBynJ0BOxrOkJOV2MA=;
 b=y70UyYNzTLBu6aq7cHFcALXADXNRlbCVmOTa6sZwfnJPHOcBLp49Zqs/QY9AbAO2WiZiUi9vls63HoRTs2QltDBG94iAfD0C7mF9MkckY6EOBQ0RDnVPt6S+jPor0WkFEhXE1jAfxSWCMglJM7AmuMbCyCR0Tygi1MFcNCiAIQo=
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 BN7PR12MB2753.namprd12.prod.outlook.com (2603:10b6:408:31::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.17; Fri, 18 Feb 2022 22:45:32 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::3896:be71:4770:3b0]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::3896:be71:4770:3b0%6]) with mapi id 15.20.4995.024; Fri, 18 Feb 2022
 22:45:31 +0000
From: "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/amdkfd: Fix criu_restore_bo error handling
Thread-Topic: [PATCH 1/1] drm/amdkfd: Fix criu_restore_bo error handling
Thread-Index: AQHYJRdt9OPB0mVAfE+ayHxH2qzgn6yZ56XN
Date: Fri, 18 Feb 2022 22:45:31 +0000
Message-ID: <DS7PR12MB5933324DE755A72DCFC33093FE379@DS7PR12MB5933.namprd12.prod.outlook.com>
References: <20220218223218.1548615-1-Felix.Kuehling@amd.com>
In-Reply-To: <20220218223218.1548615-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-18T22:43:14.0402692Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cfbfe26-0699-4164-f4e9-08d9f3305e69
x-ms-traffictypediagnostic: BN7PR12MB2753:EE_
x-microsoft-antispam-prvs: <BN7PR12MB2753E3C0AD1F8E53FC257D74FE379@BN7PR12MB2753.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pyKIrN3miphhNb80Byb007PgjG7kxHJKOdHJcTVTZPTww11tMrbgNR7klpfuDQ9IAw3gtbtD38Br/YxbgtQtcvIFndlOaUEexbsMUZowAFuj0r/drUogx3VG5kow+UVA5PX1Dpud2GA/qs9DhIEGMQ52ZoUazql/A+9m5VUYKO60zM2pyzeBgZBl4DljqSUN4TC9vgZtIC3WJ3ktFBkpx6Eo7j8ILpIZNVRv/zZl5m2xvd7tA2sNaxui65vjVCl/pQiGvr6s6b4JSsASBmJDEWUznaByJ8NhYou2t8LCk+87sMivsK/z6tH/4xRe8s19+mCumN50yPJFGLoUh9fDHyCo1c9jhIOHLuoFzxFsDe4Qlks8FLYIE5EgRMR/nleG2KS5wPmWFggFW963h5PsHfT3d5M5BKBMtM1ZebJaGivSSuXfO/LdAiHER7Kh4swWjL2Pt3kw7Fi9s5PrHXVt3wCospwuzIF1IPK7o41lm5q/UHsG49P1uX04UDBwOLFRsmXUr06B2YawSMj0nSyD/ddT+OgnPx/WJQ3lRGDaTOYeyiot0ZAIpGAho0WMToYNWUwk5Byi4Pf3dn24dD18kj0eWhUz51Idp2fYZLNzUYG09gvMfIdQp9YRXUg6wMTKeBOGz5OXjl9DXbSl9IIiJzYPOThBwU1Lil1HyvmPViJBeHyPrRuglkUD8vvS6wnndBQ5GHbOnCWgzRecUMU9kw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(186003)(66556008)(38070700005)(83380400001)(33656002)(8936002)(52536014)(55016003)(5660300002)(2906002)(110136005)(8676002)(122000001)(64756008)(66446008)(7696005)(6506007)(9686003)(91956017)(53546011)(66476007)(76116006)(66946007)(4326008)(316002)(71200400001)(86362001)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kxPUtU4+oU6p7utyTgBy/nYiMe9s3vnTmqTlMszQ5MyZWcZ1RI20kG43ySk1?=
 =?us-ascii?Q?+a/ucJ2Rz9w/76eW9hwCQTOMXvrwDH/nPJh4kFK021oV0fQZBYAVtnDNN6k+?=
 =?us-ascii?Q?KIMao+GRKZzHD+yuGhiLWsr8QehBzWTbr8Aq7yeq5cjB2IRU+nO8SbQTo8Dh?=
 =?us-ascii?Q?cQEYod5mnRC5axZqWWdFOoUkUxzRfv84hbPhpMsINtTQap9jUb/g3bJ7cDMg?=
 =?us-ascii?Q?uyUTFfNqT3pGzBp4AsecZtS0W+OZb7PvDmlcvpsgQzJ1J5wQl5mc4IAt5Ev8?=
 =?us-ascii?Q?kSLvQEya6Nf/L/zUhC6fnLH/voR8dEFKW1FkLcSOB2mq96dHNZ4KFw08HZn1?=
 =?us-ascii?Q?hFwDg8FL8zaDLWkriQJ0cwUnJ19wMq9+WzBBNDP3HQszgja4rnE1Pnf7v3S8?=
 =?us-ascii?Q?IIv43r7/7f2uFjbED/uV2w7UpnWOhXFZmUVeGnc+2Gq4OXxKN6PB1ncPSQBl?=
 =?us-ascii?Q?MJXROpRR/Uz8oLxuEOqp1FfzL8zZNJMNMv9q8JKdIzACtMfeKXoXyR+YYF98?=
 =?us-ascii?Q?2tq7J3Ab15IsLxblYU08vR/7f7SNYcuW8kD6MRrFFR7WLd0cfWYASl6EEILN?=
 =?us-ascii?Q?44e/ZJK49ov6IpW0wuikvXueBLQkYA2plYRMdA9vnrhs/ngXsjen1kfRpprd?=
 =?us-ascii?Q?hB8URq/e/BjTHaqJmX65x3PD43BQrfKPgYtcrowaM3QhRgoSObEvEBxb/J9m?=
 =?us-ascii?Q?d4aRzqd5TiX8owrZeYvzXpHN3fq7TuIe25Kv/2YQdYvtrZ95/9a4fdk+Mx+l?=
 =?us-ascii?Q?qMmh/uaOkx1g3faNNDdAzaIQYO6pm1iw/Mn4ZNQKh/3zC7wdhaPT1irVKxk5?=
 =?us-ascii?Q?wDDZi29kyqhTubi+55yBDzzhxRuCG2eMDWTzpl0lbwzL11KgopAn7eMdMiHB?=
 =?us-ascii?Q?CiMMDLqSO34s8aYCO3bhQIasNzVfNKgRYC1laP3IDy5XbMuCDhIlsHuk/PbQ?=
 =?us-ascii?Q?JgTnCEVHWtqEKCEWGvV9wpvJW/ayOj7fcqcXHATqSu4H+eJ6PYw3FXx+a0o8?=
 =?us-ascii?Q?F9Kq8EDhy+mXJJsPneHeWFxH0ASpp0kh8gwE3V1/hEa4lVfv4mUKQOiIV1ap?=
 =?us-ascii?Q?+U1l2ayPAshGIWZGauns40dpCPwsrO9TRgnsgFwRMFToMSmfrNZL4FHQC/bJ?=
 =?us-ascii?Q?myJsGsdjCeidrC/UH4U1toeJZ7UyYzevHfyc+eIpcYx0w9mI1yahgcQvS25n?=
 =?us-ascii?Q?1ytDvaVXKKFfpunJC0wNv1InuTRIa6vD9yuq313JdaOEGf3TIB3M5jBkKfF6?=
 =?us-ascii?Q?tosAeCJaEfuRrC9jPohkPlRKok3cb62T/MkHhG8v/LV5WYry2R/72Ze7+cWc?=
 =?us-ascii?Q?QjgsQwXOkye6x7DxIIq3BA9OyoquNGLxVr0+vdCb/l0diwr3ZPmvVuRArLD/?=
 =?us-ascii?Q?42r74qa7ROvQPatAVXX+Xvo7qnmDaVILjI7di6r+QaH475bB1Z8zV4KDF3KC?=
 =?us-ascii?Q?LKlfXLc2cmHVMQu9PtNehB8jf/Ly3LM5e7t8VLP7PIoJEl2i+DVpU6y73oj6?=
 =?us-ascii?Q?vx5t+vDVpyucyN1+XboRzdQRDesELpscx2aS9ewxFoRRDCgC+9OzTfyyE9t+?=
 =?us-ascii?Q?R/GleU3RcImmg/SdWuDTX2eT1RIMX93uU2uSQfqOcNAnSIdTQHxGXoHP+SYS?=
 =?us-ascii?Q?PTi/8nQltFev7f6CDAgC9ikYnsncKPCURAUK0d+EFh9nTZ4pt+s+rYGz0lCD?=
 =?us-ascii?Q?HteDZczu9gm1p0G/f7jf3s0UzYXbbXUY2uLhDVwmu2vq2ccA?=
Content-Type: multipart/alternative;
 boundary="_000_DS7PR12MB5933324DE755A72DCFC33093FE379DS7PR12MB5933namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfbfe26-0699-4164-f4e9-08d9f3305e69
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 22:45:31.6055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6fT31cpLjSZrMeEjd7TEpkt30Ii9CX1J50s+XGXCvH/f+Uno2OtupVcXzERuKbXNMl1ls5fOX97JlNS3u98ofw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2753
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
Cc: Tom Rix <trix@redhat.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DS7PR12MB5933324DE755A72DCFC33093FE379DS7PR12MB5933namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Regards,
Rajneesh
________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Friday, February 18, 2022 5:32:18 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>; Tom Rix <trix@redhat.co=
m>
Subject: [PATCH 1/1] drm/amdkfd: Fix criu_restore_bo error handling

Clang static analysis reports this problem
kfd_chardev.c:2327:2: warning: 1st function call argument
  is an uninitialized value
  kvfree(bo_privs);
  ^~~~~~~~~~~~~~~~

Make sure bo_buckets and bo_privs are initialized so freeing them in the
error handling code path will never result in undefined behaviour.

Fixes: 73fa13b6a511 ("drm/amdkfd: CRIU Implement KFD restore ioctl")
Reported-by: Tom Rix <trix@redhat.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index fead2ed46dc6..ceeb0d5e9060 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2092,8 +2092,8 @@ static int criu_restore_bos(struct kfd_process *p,
                             uint64_t *priv_offset,
                             uint64_t max_priv_data_size)
 {
-       struct kfd_criu_bo_bucket *bo_buckets;
-       struct kfd_criu_bo_priv_data *bo_privs;
+       struct kfd_criu_bo_bucket *bo_buckets =3D NULL;
+       struct kfd_criu_bo_priv_data *bo_privs =3D NULL;
         const bool criu_resume =3D true;
         bool flush_tlbs =3D false;
         int ret =3D 0, j =3D 0;
--
2.32.0


--_000_DS7PR12MB5933324DE755A72DCFC33093FE379DS7PR12MB5933namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div>
<div>
<div style=3D"color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" d=
ir=3D"ltr">
Reviewed-by: Rajneesh Bhardwaj &lt;rajneesh.bhardwaj@amd.com&gt;</div>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Regards,</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Rajneesh</div>
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Friday, February 18, 2022 5:32:18 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Bhardwaj, Rajneesh &lt;Rajneesh.Bhardwaj@amd.com&gt;; Tom Rix &l=
t;trix@redhat.com&gt;<br>
<b>Subject:</b> [PATCH 1/1] drm/amdkfd: Fix criu_restore_bo error handling<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Clang static analysis reports this problem<br>
kfd_chardev.c:2327:2: warning: 1st function call argument<br>
&nbsp; is an uninitialized value<br>
&nbsp; kvfree(bo_privs);<br>
&nbsp; ^~~~~~~~~~~~~~~~<br>
<br>
Make sure bo_buckets and bo_privs are initialized so freeing them in the<br=
>
error handling code path will never result in undefined behaviour.<br>
<br>
Fixes: 73fa13b6a511 (&quot;drm/amdkfd: CRIU Implement KFD restore ioctl&quo=
t;)<br>
Reported-by: Tom Rix &lt;trix@redhat.com&gt;<br>
Signed-off-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c<br>
index fead2ed46dc6..ceeb0d5e9060 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
@@ -2092,8 +2092,8 @@ static int criu_restore_bos(struct kfd_process *p,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; uint64_t *priv_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; uint64_t max_priv_data_size)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_criu_bo_bucket *bo_buckets=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_criu_bo_priv_data *bo_priv=
s;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_criu_bo_bucket *bo_buckets=
 =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_criu_bo_priv_data *bo_priv=
s =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const bool criu_resume =3D=
 true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool flush_tlbs =3D false;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0, j =3D 0;<br=
>
-- <br>
2.32.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DS7PR12MB5933324DE755A72DCFC33093FE379DS7PR12MB5933namp_--
