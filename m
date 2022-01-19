Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA0EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 17:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 552F610E3E1;
	Wed, 19 Jan 2022 17:10:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0A3010E3E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 17:10:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzD5mhAcHCfwDJPrjXOOXX3dqpegwWOCx/Bv9IvxrCRVxJIDg5CZNl/Hwh06ksSsN44O15jkC1XM8rox6gX6WLPUWeRsV05/8lNusFydqAT0IqHKLThyXy4XW9bjbqtEkBw1ovKxr0hJ5pHAReT1rcas6BLsmThq+NRUL7FN27jJYJJVRJyuwBVzEVZekJXsspznwa5uwrWPUJWgixyrzJIJM7+tld7og9y8KLXD9xfUm9A/qOl62qgfAjVxz8YvrCixTSAqrlBtnwmHvIWbXF2vRivEwH8pbrN1qhpPs37BWQZHE3d4JVAE5hiNYfbpBof0mhwPWpP3dJTVWWgMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKivIxa3JWA8+WEwgA2IxBUj7IA5+Y8Rty2x3MzXgGA=;
 b=mWlrA5Q4Mu85kWgFeagQ3elR0+/gjyKx2An4FShKso/EiPdpEcrQPBB8GI694mz/naMjMF9Al1mqtP3BvFAoXxUENBj89k6ea/cyZZLI1H+H5710Jfh85oGpSSyuZYJS+J+DGm7iu7yuT8vsMALQvvRorqwUdt/EDmG56gWBab8k+P3Y6CgLAPYY/z69Iqz3+AzW90a5SHVOPB+j2zwAyCBfGnWIXoF96zDZBSPoujn2E6AaPpC4S97VcHA3hZ1vD7MOixW0OgO5627hpB39LsPMRFTcyKtWon+mVaf+eJ2E9AX7Oc9HVjO1oEWzwIwnInq9KDVNEqhCNqJNXw0QqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKivIxa3JWA8+WEwgA2IxBUj7IA5+Y8Rty2x3MzXgGA=;
 b=m/RYVeyHF6LpvScmj8jh4tVIaHeTZePyPB+MPgUB4UfL3nabp4mi57tWnetgTcvTNChudLGtdb1uOCoIthD25Kf2VqPpw2ELKRVcVCsnL9JzoJQxK5lI59qyCAzAdefgqeoLNv8TcukpzGBO1q5Cl1oFD8He96JCwoZ3xpYGZxs=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 17:10:55 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%6]) with mapi id 15.20.4909.008; Wed, 19 Jan 2022
 17:10:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] amd/amdkfd:Fix the return value in
 kfd_process_queue_manager
Thread-Topic: [PATCH] amd/amdkfd:Fix the return value in
 kfd_process_queue_manager
Thread-Index: AQHYDTQ1opiPQ0SE90iFrnh++vhMxKxqlJHM
Date: Wed, 19 Jan 2022 17:10:55 +0000
Message-ID: <BL1PR12MB514415F9B1DAB5370CC2952FF7599@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220119125721.278221-1-majun@amd.com>
In-Reply-To: <20220119125721.278221-1-majun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-19T17:10:54.542Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: dd85edee-b1af-c914-148c-39716ea5fbf8
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdf06795-6cd0-487c-885c-08d9db6ea779
x-ms-traffictypediagnostic: BL1PR12MB5173:EE_
x-microsoft-antispam-prvs: <BL1PR12MB51737EA23E6485E741ADF67CF7599@BL1PR12MB5173.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AOJ4NXNJSa6+l4S3IOMMWr5j20cb1RrDXTO3e4bqswrx9uNF66REe3Ebb8Y7suc7t9uglDb6zIOcA+ijSWpgP24/W4hgld7+VKOLtPkDEOeXPaiZ6FduMRwD63nZpCyOPZKoR7zhFJPSNrdvLJ3VjiouJ4pxYyIGHJkHk3OwD45Jx2L2qP7xzao6pdVrzDuwMDO2BiWX1TNxfQuSN7/4W8FKvc99vVUYVX9FEwlxg+Z00EIEGZr1cy8fMWlc+05EJbk7+cgq6Ctd6jH4k7VW15C/5pcVAR1/giWe4Ej5bdwa91EcSmB2AXz/HPJSl4YWxRjAMiT+lTBjtX16iyaNWwE0d1VP/oIv9IsRZJLHLULWdpCRTs9eP71gbF4y7gQdzMipjmB2l7bWW2z5K5ALwic1gqwVYFSIzVu60aB2yJjem6uVRzR7bWhdatjwwweG8Th21C0vJrsrLHds/mY7u2ipm/K9oDF90J9seP1JLYEjvvfDZM80feWSZN0O0PrDpaZNoGQoY7dXyvoSWWRhWnuKSOIWdrMbyUiPGU9EfwRexe2GEzRitV/YRO2qv3WM+i9cJdw88O1H0VYEsmjvge7JxbGcaHaQP9P2AKdSncYrz8ReiR++0ls+Eb77AXzTR3fLz1y0x/RuBIxi1mR0V5F+jZtB+loDCdqjkJ8w6oZMc+EqNTU6hCZQkQlha0Bpfbk331npNm5HZqCtR0UvbA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(5660300002)(9686003)(66556008)(38100700002)(52536014)(2906002)(66476007)(33656002)(7696005)(8676002)(316002)(83380400001)(6506007)(19627405001)(53546011)(186003)(76116006)(38070700005)(66446008)(64756008)(26005)(66946007)(55016003)(122000001)(110136005)(71200400001)(508600001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lLXsTpNZKzn0WJp2rFmSREyZSE0vFb6rQ75gsGvD5BHvvpJDZCwwdYamQQCj?=
 =?us-ascii?Q?sS02g+ZTS7PvS11CtOMvv6OOCOhsRO1reUHJttT176gf4y/YpP2lDPC01QG+?=
 =?us-ascii?Q?GGeTKpTyfWmg0uRgBp1ycTB9ryGxMy/DqjeEs8PZ+s/xNW3q0g5B6mjmnCSt?=
 =?us-ascii?Q?f1dEaIgL/MQ/tcjhZbADh1TyBcPpO1tn6cozbCj0ol9SZghFaRMau60LA4KB?=
 =?us-ascii?Q?EZwqWI+aoTncNoZDKJKyN6pc+W6m1wXS1tbhnpyvkw83iBKbyenhArpRLIsd?=
 =?us-ascii?Q?bmm3hqO586a5GkvwsuosvwKx50fNI+CHT5VZTsrMdxqulhTPBS2sj9xUaqMw?=
 =?us-ascii?Q?/jRS1DjhkEj2ljmoxbaOfDuPA7qKAYeEKt6uc6PemTIYdT/eDSWwrhbW7jm0?=
 =?us-ascii?Q?fHbAHnRXEOgD+KEwwW/3Lqhn1V+108+Hui2lSrGGrb1CxJoY9DhDt5mFxiJU?=
 =?us-ascii?Q?4fuw/V8i8xwKXJKt+qPxGdLlqimFWP9fL9iDhNejRSfLnh0P2n3Mu+DxdujI?=
 =?us-ascii?Q?pTRGHD22ZEBYfepJKfwmEbO6wGPXtHWuQeQIQSHgqiqd7xss6aTzhl5Tpa2q?=
 =?us-ascii?Q?LBJTJoxWcdGFuIiIk0RjF1gYme3IxZyEu+FOAF+H4sDc8/K3lNMiE8Yb/GWK?=
 =?us-ascii?Q?4RpalE+y3DktsJYGRbk9vyD4ygWiI9+Ks6Y0/E0FejWV3McQXsBLxOTWHYQu?=
 =?us-ascii?Q?K7oRYj8VK0DnNKwCNmVH9AnesvN/vvFwYzx3nXaC+ZVMEMtKrZHcLvlQ0gni?=
 =?us-ascii?Q?bVtoST+QYEN1hbNfzPQF3ElVrVX/QtvSHJTCJR+cg5Gks4oSs0gnTgByEEk9?=
 =?us-ascii?Q?2fI8ubdWjN25cTTEk3F69uE906rM24AOUWpLx1chh3fq4N5HlYmeYl/eRgTv?=
 =?us-ascii?Q?BQK18BHPvXYANDJZCD8g6iK2aXxGBwKBqN1kzyQYp4KDOmbyOk5WkONi1RPM?=
 =?us-ascii?Q?86+bH0dWOEInmHOxexTKZbTClBnpUgT1SYq0RXFeQQKFkJdIeqZef9aCaih3?=
 =?us-ascii?Q?0dpBmLT9zJQvwwd5bE+f+lVpKf+xSloLc9c/8P/WduwUeV1TQz4eOvbyYsAQ?=
 =?us-ascii?Q?+9yTGIDE5P4GjhyfQPbR+dFDY2C5bTpz61q1yK1KPfCFkdJa7I0Y7Rb08e6C?=
 =?us-ascii?Q?vS19jqJuHwo0r0PnlcN/jyvhh1IobvxHbggftsBfSwQpss4HI2ldySfwmSls?=
 =?us-ascii?Q?h7Ih4uHFjNiiDz/Q88NUee5TGiGOCaV4qplJZndqb9S4mfqDCRzMp9/refbE?=
 =?us-ascii?Q?vmDkC4V4gRyshJ1bZoUfJWq3H2+eHCYLe9P9lF7WThlYsXdYPOZRkQVyT9UF?=
 =?us-ascii?Q?/QAL/kVMgXvzDQEILPyozzoVafrCaojOMFuT5nQlcmQ1JBPzDPe4L7HsyqjT?=
 =?us-ascii?Q?RBVOsDA/KGFo/Lz8yDISLqfSMvgKwSf8PhlmPFgx8B4gGyCHYQf5ZgVByNzR?=
 =?us-ascii?Q?ypqbWC5Am5HWmh1fjU7gSrQtk29nGnFMzJRUbmHuigfNkroSvlJWB8djdINK?=
 =?us-ascii?Q?OZ6PnQANbk+A+isvmVo3JVOP//0SunY3ABbUmK4hQBuEsfSVC/2HgsoApyuC?=
 =?us-ascii?Q?PX29I/PTKPm+U/PwXZxuZgacNqSBdYeSWdWqQrMMBP+aXQ+2f6sH0h6d+6h1?=
 =?us-ascii?Q?KR/JsQur7J6MhdsP5KEd9nw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514415F9B1DAB5370CC2952FF7599BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf06795-6cd0-487c-885c-08d9db6ea779
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 17:10:55.0875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gyQf9KTkLic3k5gbJhHmZtBCmNPwKrk+//SrGi+lo0NazRnLI7sRnhBLQZ5uiTRHWqyBsp0HcgxD0Oztifk5Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
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

--_000_BL1PR12MB514415F9B1DAB5370CC2952FF7599BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

You can just drop the whole line.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of majun <m=
ajun@amd.com>
Sent: Wednesday, January 19, 2022 7:57 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amd/amdkfd:Fix the return value in kfd_process_queue_manag=
er

Change the return value of set_queue_properties_from_criu()

Signed-off-by: majun <majun@amd.com>
Change-Id: I11362eb76eee84e64c5207c24a2b78141f62e63a
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index ec62897914da..f70e972d1d33 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -826,7 +826,7 @@ static void set_queue_properties_from_criu(struct queue=
_properties *qp,
         qp->type =3D q_data->type;
         qp->format =3D q_data->format;

-       return 0;
+       return;
 }


--
2.25.1


--_000_BL1PR12MB514415F9B1DAB5370CC2952FF7599BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
You can just drop the whole line.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of majun &lt;majun@amd.com&gt;<b=
r>
<b>Sent:</b> Wednesday, January 19, 2022 7:57 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> [PATCH] amd/amdkfd:Fix the return value in kfd_process_queu=
e_manager</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Change the return value of set_queue_properties_fr=
om_criu()<br>
<br>
Signed-off-by: majun &lt;majun@amd.com&gt;<br>
Change-Id: I11362eb76eee84e64c5207c24a2b78141f62e63a<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c<br>
index ec62897914da..f70e972d1d33 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c<br>
@@ -826,7 +826,7 @@ static void set_queue_properties_from_criu(struct queue=
_properties *qp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;type =3D q_data-&gt=
;type;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;format =3D q_data-&=
gt;format;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514415F9B1DAB5370CC2952FF7599BL1PR12MB5144namp_--
