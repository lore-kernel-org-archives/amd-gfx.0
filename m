Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2496C47089
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 15:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 780786128D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 15:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780786128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 387066E0B8;
	Thu, 27 May 2021 15:03:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 614EB6E0B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 15:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+7egg3HChquXWr9eZrZRUeQ/zr1KiN8j+6KM7zvlnR8G9STneR1ZQEIBA9fy5FB6ZwDw+RKB8eQYRhNyoFO3VFaXlR2k9my72bO8tCQdsiswhVrefePRaImsT7c7HyKGIhNNdM9q35+XXU1ysZ2nNZc3/w19nVwt/H5imR8kdrGyvPK+gRm8c2BBUFNhObFTc1mTFITh8U63vS9LbBeEd6JytDMJhogO+7LoLK7m7uX7L++Fe0elCcAfBvtT9OvBk9u0HXSwi0YfSmaY5CdSXW3J+DfwzTn/yje5fJHQr+vRR+0Qz9+l6J15ETKwuqIaN0J1D8eS3akpXFp4nW+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5UjbrHWrCRbiQgzLA+ZlOqoAa3EVc7RXR8H+HgbWKk=;
 b=M55ehD/3PJPTr90v8AZa568wqQkSp9nQCo4zK351qvkE6FQfrVWqGHAGYWTUBYLXOJBEHmTzzpHuF+9JMkXQfBYj5Am+pwlJNw6DYXQF+yXri10TWRt7DENTFtuzHWCWXHJHyZSyYwGKT5vC1+0/Z6GThRthI0JP9WfjnpETknUH+MC6G34jOr9r7IqJk8IDC1ZgqKgJEVV7biT/C9Sw2ExhQNnS1bE9+15+XT8/y7xKIHXReFZ6xTXvGlxES/F1hrtHQC3o4rUN6fieGlRT7jjfhDqh+DcKxZ/S+IVRgs5j+F+EsL5MvBh/PNrgn427e/Kxfdz2U6r9L+sbfx0ExQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5UjbrHWrCRbiQgzLA+ZlOqoAa3EVc7RXR8H+HgbWKk=;
 b=sDiZ33lAvkctEdy6WmpG0qp73pt3vpZLgCcmMeXsIVSEXFIM7UBJiK6nUBpza2oZIxxq892LH5uOMK2EWEY44Bif8aJgXdEDKIPnyOlmH7oZBTLIIhMjVP/uTQjIJ1YxNjvv+bLGEaCH2R6FV6LOxnpJ2ECZcx3hI+9YWincjbk=
Received: from MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 by MWHPR12MB1150.namprd12.prod.outlook.com (2603:10b6:300:f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 15:03:44 +0000
Received: from MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::4458:fc8b:a960:6d44]) by MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::4458:fc8b:a960:6d44%7]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 15:03:43 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>
Subject: Re: [PATCH 1/1] drm/amd/display: do not dereference on NULL
Thread-Topic: [PATCH 1/1] drm/amd/display: do not dereference on NULL
Thread-Index: AQHXUvDqnvlIr8a/NE6mCFY3XP4zv6r3bPyI
Date: Thu, 27 May 2021 15:03:43 +0000
Message-ID: <MW3PR12MB4491703ED10631CB99A69E77F7239@MW3PR12MB4491.namprd12.prod.outlook.com>
References: <20210527120737.25409-1-nirmoy.das@amd.com>
In-Reply-To: <20210527120737.25409-1-nirmoy.das@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-27T15:03:43.259Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ac0aa7b-5404-4803-e308-08d921209efa
x-ms-traffictypediagnostic: MWHPR12MB1150:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1150174F0E3A6945087BEA89F7239@MWHPR12MB1150.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:46;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f7lYaIbTBZyoiLovJUAw2+7/UmYbcLWecquSshBBh0tyvx2wJv+QZZG8voEGLh08Eq2OuNc2rJ5CsbAq9zVUdbr0EVZnvdsn7woZeJry7VhRzi4yDYqEyqlAiUujvd/4TQGLcU985Jd7EJH+g3XsKwAVn1NbHRd3prHf7DCbSHZqm59HZz6jEPlvMG8+sDqh4pL8HIC7FKRslF0XdETvS85NOaQAykogCHdIEUuQa3bvAqTDdH/CZV1iWoZdBb7RceSqVVMgUfNmefnf1Z+zGVFupeoAwZhUgSUkCEMc+zz6mq00MU1nRJFBvhZcbKdv68cLqUli+hgjZZMK6+SV30d6yNtO2HbqG1p5mRSc9A3fUIKoHbAotye8IfZ1YNhsr7XmQGjFvjn5Uu3hZE7VS7dMYQGc0QaVQHxqjo3YHtTvWFno6gsMavA9yXbChbfGSiI1TuJWTATNc8GLFZNiYTlfuJgPZaTWuyvtpszC0rj3mXkmc5lMiyDaiy7BXKBMtetik19ipP46+y2TxPIg5tvjH0K91kSjwwJtnCjziJFYL4KYc5u7Vh02XVyE5HV+UjXVwSf9w4cSoYX+aSbW+fB1GlyxMCUql7ABDXIIbZc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(478600001)(83380400001)(86362001)(110136005)(54906003)(2906002)(6636002)(8676002)(8936002)(316002)(38100700002)(76116006)(5660300002)(19627405001)(66446008)(66476007)(64756008)(66946007)(66556008)(122000001)(91956017)(186003)(9686003)(53546011)(6506007)(7696005)(55016002)(52536014)(33656002)(71200400001)(26005)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pLd6ip5B07xlXHg/Y7ppre14duw8eEfcMoDnaECyC+zZ5V+y/VVj9zlcrDBC?=
 =?us-ascii?Q?tpCh2trhMf4wQ4ZRvO8QuYP+hyUFWl5+vTs5uyuULEhxl2p44IJnuVPjZbF7?=
 =?us-ascii?Q?CGG2VbujAZrUFcr9bx79nQ05Zx54MnCJL4A4W3abg4PCrLDdULcV9fX+2QDd?=
 =?us-ascii?Q?xyjUkm1/xe54rnaqPdyWiGFI8leClQ/Vk6FgTG3dACpNlIjOAHUuvujrYAKa?=
 =?us-ascii?Q?1vTk/L+faCaPnEynBcDs5gnRO/O1esnhOEZz8kpPMuXQ45/umsnrVR6G0rbG?=
 =?us-ascii?Q?D8GACDGJZmZzeBizzB8p3t9MQA9svQD5x1vvMJwY9hzFsrAepOnU+uOE5j9y?=
 =?us-ascii?Q?Ckbf1QSf7PWJBAKvx7ed4QFNO5hm3WNgv2nKCtyeTYloKcDuPmq8dr17kl5B?=
 =?us-ascii?Q?zjrtj5h/pMAPyFFy7Y4RkItKe07QROn2aXNRjhrm55dKIWC0uRk3xZeJb7UC?=
 =?us-ascii?Q?F4vwTc/J1xr9Y5uU4Vn+/sdjPuy5owbS7sa3I/OP1QIF0KmIIVZJpMzzmLJF?=
 =?us-ascii?Q?z1a2fmwL5IBmphH3xHbEp4c79upHqu3K0zdoEFE8gXi0hLB5bSHm0sd+/Rph?=
 =?us-ascii?Q?OUsnhb7ExMxnnzCejF4U3QStpB2HCR9e3fi8YN0gg4SKxV/B4IFzqLw1ppY8?=
 =?us-ascii?Q?Q2HB4z8z8fGjIP7LjpL9sCgxVcJMt5AlUeZUdYaFKvw8Q4NlFx7wZGc/O2eG?=
 =?us-ascii?Q?6kRGW4OS7uak5K2jHC8Pqm4jYKbMI2xML7UAnma2nx1aBKctrXJKgqwBxuuI?=
 =?us-ascii?Q?2MjgUhkNT1NAT5sk2Vpd+WUatE97kDyQTm2lOqbc266CwGgJAiHKV0nJdgB0?=
 =?us-ascii?Q?X3aI5ItGsCzknugonk0ertQAxdwmAapj/1WFWkrgcZoz2aT1Og1jGXOk8q5u?=
 =?us-ascii?Q?6VCpufDXB3yDN+pnN/ex6QoUMMHENZDm/td27O9kHOHW/B//c1JOrDDiPxVj?=
 =?us-ascii?Q?0KIGftpG5VfM/E4ubIhHQrF7aoBcaKiLDL3tQ50lzVynUHTiOeTlilfGkh6v?=
 =?us-ascii?Q?wG0dhOUaSGg9cPeOIDvIfJKG/GMjyyu2x3hgr4OTGRochnVohd4UqccdrhYy?=
 =?us-ascii?Q?wsMjAvL7maX33y3lGnkte4tq+uurCmaMgGTKTmh0jhwcMvbwjIbqxtvSLJQ3?=
 =?us-ascii?Q?uMZvVXjZAHZhWKF0udW/8J1hROYuySaQGzzKrl4bRWydYP4GUQ2oLpUHJFkX?=
 =?us-ascii?Q?4Wx/XadUon3jwRZbluievnX+LM3IqElFciF37VMeZDXMrSxAOEV66y+QdBTn?=
 =?us-ascii?Q?3GDyJKzuqsWMtEuuaFA3pRnhHnjvYFOQ5hjJFGtaE9p+WqHVoenQDIMcMiQy?=
 =?us-ascii?Q?0ETeMUJrN+yyq0yDIq4Ghzfa?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac0aa7b-5404-4803-e308-08d921209efa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 15:03:43.8253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0PUz8Fiby07aXEWygnOY2BeK76lWLSqEZ6GuoVcEN0Na+aPMYvWLjhq9buedpBEjmUJaeucWFJTfGiqtXed3Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1150
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1084519725=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1084519725==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB4491703ED10631CB99A69E77F7239MW3PR12MB4491namp_"

--_000_MW3PR12MB4491703ED10631CB99A69E77F7239MW3PR12MB4491namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Das, Nirmoy <Nirmoy.Das@amd.com>
Sent: Thursday, May 27, 2021 8:07 AM
To: Wentland, Harry <Harry.Wentland@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedes=
ktop.org>; Das, Nirmoy <Nirmoy.Das@amd.com>
Subject: [PATCH 1/1] drm/amd/display: do not dereference on NULL

WARN_ON() will not kill the process so the second WARN_ON()
will try to dereference NULL pointer.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1134cf6eac82..f2ed51484980 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9108,7 +9108,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_=
atomic_state *state)
                 }

                 status =3D dc_stream_get_status(dm_new_crtc_state->stream)=
;
-               WARN_ON(!status);
+
+               if (WARN_ON(!status))
+                       continue;
+
                 WARN_ON(!status->plane_count);

                 /*
--
2.31.1


--_000_MW3PR12MB4491703ED10631CB99A69E77F7239MW3PR12MB4491namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Das, Nirmoy &lt;Nirmo=
y.Das@amd.com&gt;<br>
<b>Sent:</b> Thursday, May 27, 2021 8:07 AM<br>
<b>To:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt=
;amd-gfx@lists.freedesktop.org&gt;; Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;<=
br>
<b>Subject:</b> [PATCH 1/1] drm/amd/display: do not dereference on NULL</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">WARN_ON() will not kill the process so the second =
WARN_ON()<br>
will try to dereference NULL pointer.<br>
<br>
Signed-off-by: Nirmoy Das &lt;nirmoy.das@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-<br>
&nbsp;1 file changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 1134cf6eac82..f2ed51484980 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -9108,7 +9108,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_=
atomic_state *state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; status =3D dc_stream_get_status(dm_new_crtc_state-&gt=
;stream);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WARN_ON(!status);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (WARN_ON(!status))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WARN_ON(!status-&gt;plane_count);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /*<br>
-- <br>
2.31.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB4491703ED10631CB99A69E77F7239MW3PR12MB4491namp_--

--===============1084519725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1084519725==--
