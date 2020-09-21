Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD0AC43466
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 15:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A41F20888
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 15:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VGZnyyaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A41F20888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E7616E05D;
	Mon, 21 Sep 2020 15:36:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 306AA6E05D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 15:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYty34T+zzVHFlMcwG5ghM7AOz/igsZEkkxfvHE5YxkdikV/k8+LWWhPGJ3YZ7laoc2oJlVWo/7L1navWfUFWZBM5gkg6KdFZFHKb669JX8AO0ycWdbJEEskKIklQB3qzvYP6iDLjStJkCDdSeWGg7wbFUxFFgfSsIbkLjnfUt1AlLwcOaP1J8KPvt0dRR8cZtRtGzIEx8qQxbJ3n6GqrKbUOUr7lkXFX8pV+yqrwivIuaZZ2X5o1vePpXf9fexWwDy9vIM3ZDzSgXcquC+xChhekovMIJeGGvZuxzVMWI1/UT2EgVTqzP8LV9HxEfw3/jsgvNRMODh1KcNq98nxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RluMV3hVqFVYLj6i/IUC6V55EZhO+GLEZSAP6ulhiMY=;
 b=IuJTysTI2kak/kmSi42HIbpGQl/zK/9H1EsUaI4jeKH6gKuOyjsrGw2Yak/kBPcFgXAcVWoUInfPWcMIcQ+LJRCvCbeYlDSCcITt5cZ3pDEbELMHND2tvg8RL5TrbMxzQck837rluz67MZ20+6LboSQYt7CHY3Kx/DA2XbQnF9ZfBoOqyTGe7RRFE07+8xDWf8JsYYNfEoEyVIBiB2a4/HLZYZQhabGmxIam5JVZE2VAkV0ZRS8NPhvcX131XrPZIKSTMRXszTMpfUGJpfAefCogSkmOg0gcbpupXefn/jjfRdtpzzLXW5YZagpRirvkbGRGCdissh4JxzUUQHuoCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RluMV3hVqFVYLj6i/IUC6V55EZhO+GLEZSAP6ulhiMY=;
 b=VGZnyyaNYPgZ2VdLCh2C2PhDmwRxfddAzPGsn6nPIDMyKVTTw7ZmShOriw9iZNZ2R+MybhmxEWLFssUfC46CY+mocmQyAY9X1KYoWRwAdvSf3UATSM9veB6JMcRS6mXGONlc7KnZVFmGYoJLO6Hazr7OHDGY7wbx7HGqKdKDx5c=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2404.namprd12.prod.outlook.com (2603:10b6:207:4c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Mon, 21 Sep
 2020 15:36:17 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3391.019; Mon, 21 Sep 2020
 15:36:17 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Use kvmalloc instead of kmalloc for VCRAT
Thread-Topic: [PATCH] drm/amdkfd: Use kvmalloc instead of kmalloc for VCRAT
Thread-Index: AQHWkCNrKAYwNP0LCEuFd4i6EV3P3KlzOW3o
Date: Mon, 21 Sep 2020 15:36:17 +0000
Message-ID: <MN2PR12MB4488CD351F6ED46DD0979577F73A0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200921142713.27791-1-kent.russell@amd.com>
In-Reply-To: <20200921142713.27791-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-21T15:36:15.663Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09b451d4-7569-445b-d67d-08d85e441516
x-ms-traffictypediagnostic: BL0PR12MB2404:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB240459BE027623B540FD2046F73A0@BL0PR12MB2404.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gzhzDOqvgVKUj5p2bw6U09CixJCSyRMNLvRs5NSKqCcQWIwL4IooWS8YIuwEonnKAv9xWiiCtjcn4EirdtYJYLarcCH6pSFanYD73Jl4tcXYqqKkoIG2RcmXrT1ECNoqzveLKzbm5ascRaWChSmSU+I72RS6sCMAP23xEqISGlYpHgEQbzPp3M9PMmqiyV7y7EgbfOYx0dUBetjFIP26/M1yaju3HAKHfEGNw+uKj+urkRgpCsvi+6HdBjW5ol7bm4R11CHR8PPQ09l0JCx/f4WV464n9Doh8zoE+tttFoBhqmvm0Ddi+Mu+020ZqsCGcS5UW9nX01oSpD2qhH3YYLY0bda3FuwyP3s695OMcraQKts5WT4L/KY/oK6LI9R+ECurraQ2pPE5DVN2ULL1L+UVnPO298xiqQ00JT76gkI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(55016002)(64756008)(66446008)(66476007)(83380400001)(7696005)(6506007)(53546011)(9686003)(76116006)(966005)(5660300002)(2906002)(26005)(186003)(110136005)(166002)(8936002)(316002)(33656002)(66556008)(66946007)(45080400002)(478600001)(86362001)(19627405001)(8676002)(52536014)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: c+EMyKhKnqmQNh/MM8+eGFQ9hJ5VFIVm2aBrO+SjflSjZ+84VEyYGPVqXrrnnSQ83nND1ss1B5wdGJI9Hk2ldoWYzNpKZZ1Z8Axy8ncyHnLggDxtwkBXlFaMk2KcQI4gY2IsHYGUtwOCqtz4QB4BTCk/Owk9HoYsyXMWoAPS9+F1yZs7seIN6UW6pd4L8VFoNHthLk3HCtJV75i1WJ2Tl1vRu3HFL+ZNKqr514twZfn8lC452OSeSjh/RSMa5GPRveFBN+rfgayjR9Obw3K7tCe5Yp2GD16FSkz4Od2JGEQuY+vzT9ygQ1+qEBRyJf5B6bdabcsH29qgdF0IqyU4MwKrOjY6Z6nrHKwRbWm/g9Pt8oPqqFUZ+S5yDjcPXp8cvTDYZf5wIZiieENU4ie3Z51LciZ39xGqpLEe/pEJSi4w+yilA78vbqunqABY/2evKK8VpjZXwh5DUwGLlS2pyaoheVTvT7SCr1g32s1mtn9CGgtQnoeLZfLZOEozlfNZ9M0br0wzQg9onR33TwvQNYzcpZrzNnIcceZbZix53Yuzba/3OQR2l/k4dwhniBRgrpqPd5zqAQxZatH89YRJle5QM7rXHi8UX2PrvPlW0w8lmVYfWPA+1ONTVoO0p8XQ3X6Ktf6rRnUtBfQRu+oqRg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b451d4-7569-445b-d67d-08d85e441516
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 15:36:17.3796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07SlbVuFTAxED1Xfn2oaYpTqAeUTGEMY0Km9vgtL9arJCHN3IBwxKBGHWZaHSlbiuJjSacFz/KLcMI2zoZDA+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2404
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
Content-Type: multipart/mixed; boundary="===============0183144029=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0183144029==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488CD351F6ED46DD0979577F73A0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488CD351F6ED46DD0979577F73A0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kent Rus=
sell <kent.russell@amd.com>
Sent: Monday, September 21, 2020 10:27 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH] drm/amdkfd: Use kvmalloc instead of kmalloc for VCRAT

Since we're dynamically allocating the CPU VCRAT, use kvmalloc in case
the allocation size is huge.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c
index 99182b8e9152..c50e9f634d6c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -797,7 +797,8 @@ int kfd_create_crat_image_acpi(void **crat_image, size_=
t *size)
                 return -ENODATA;
         }

-       pcrat_image =3D kmemdup(crat_table, crat_table->length, GFP_KERNEL)=
;
+       pcrat_image =3D kvmalloc(crat_table->length, GFP_KERNEL);
+       memcpy(pcrat_image, crat_table, crat_table->length);
         if (!pcrat_image)
                 return -ENOMEM;

@@ -1383,7 +1384,7 @@ int kfd_create_crat_image_virtual(void **crat_image, =
size_t *size,
                         num_nodes * (sizeof(struct crat_subtype_computeuni=
t) +
                         sizeof(struct crat_subtype_memory) +
                         (num_nodes - 1) * sizeof(struct crat_subtype_iolin=
k));
-               pcrat_image =3D kmalloc(dyn_size, GFP_KERNEL);
+               pcrat_image =3D kvmalloc(dyn_size, GFP_KERNEL);
                 if (!pcrat_image)
                         return -ENOMEM;
                 *size =3D dyn_size;
@@ -1393,7 +1394,7 @@ int kfd_create_crat_image_virtual(void **crat_image, =
size_t *size,
         case COMPUTE_UNIT_GPU:
                 if (!kdev)
                         return -EINVAL;
-               pcrat_image =3D kmalloc(VCRAT_SIZE_FOR_GPU, GFP_KERNEL);
+               pcrat_image =3D kvmalloc(VCRAT_SIZE_FOR_GPU, GFP_KERNEL);
                 if (!pcrat_image)
                         return -ENOMEM;
                 *size =3D VCRAT_SIZE_FOR_GPU;
@@ -1412,7 +1413,7 @@ int kfd_create_crat_image_virtual(void **crat_image, =
size_t *size,
         if (!ret)
                 *crat_image =3D pcrat_image;
         else
-               kfree(pcrat_image);
+               kvfree(pcrat_image);

         return ret;
 }
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C2c0550686c55482e784108d85e3a79b9%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637362952855598708&amp;sdata=3DjuwKVfB3gvGU5TkLKf9=
KYPdy90sgT80810dh91hpZSw%3D&amp;reserved=3D0

--_000_MN2PR12MB4488CD351F6ED46DD0979577F73A0MN2PR12MB4488namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kent Russell &lt;kent.russell=
@amd.com&gt;<br>
<b>Sent:</b> Monday, September 21, 2020 10:27 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Use kvmalloc instead of kmalloc for VCR=
AT</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Since we're dynamically allocating the CPU VCRAT, =
use kvmalloc in case<br>
the allocation size is huge.<br>
<br>
Signed-off-by: Kent Russell &lt;kent.russell@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 9 +++++----<br>
&nbsp;1 file changed, 5 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c<br>
index 99182b8e9152..c50e9f634d6c 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
@@ -797,7 +797,8 @@ int kfd_create_crat_image_acpi(void **crat_image, size_=
t *size)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENODATA;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcrat_image =3D kmemdup(crat_table, c=
rat_table-&gt;length, GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcrat_image =3D kvmalloc(crat_table-&=
gt;length, GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(pcrat_image, crat_table, crat_=
table-&gt;length);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pcrat_image)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;<br>
@@ -1383,7 +1384,7 @@ int kfd_create_crat_image_virtual(void **crat_image, =
size_t *size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_n=
odes * (sizeof(struct crat_subtype_computeunit) +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeo=
f(struct crat_subtype_memory) +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (num_=
nodes - 1) * sizeof(struct crat_subtype_iolink));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcrat_image =3D kmalloc(dyn_size, GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcrat_image =3D kvmalloc(dyn_size, GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!pcrat_image)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -ENOMEM;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *size =3D dyn_size;<br>
@@ -1393,7 +1394,7 @@ int kfd_create_crat_image_virtual(void **crat_image, =
size_t *size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case COMPUTE_UNIT_GPU:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!kdev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcrat_image =3D kmalloc(VCRAT_SIZE_FOR_GPU, GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcrat_image =3D kvmalloc(VCRAT_SIZE_FOR_GPU, GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!pcrat_image)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -ENOMEM;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *size =3D VCRAT_SIZE_FOR_GPU;<br>
@@ -1412,7 +1413,7 @@ int kfd_create_crat_image_virtual(void **crat_image, =
size_t *size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *crat_image =3D pcrat_image;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfree(pcrat_image);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kvfree(pcrat_image);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C2c0550686c55482e784108d85e3a79b9%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637362952855598708&amp;amp;sdata=3D=
juwKVfB3gvGU5TkLKf9KYPdy90sgT80810dh91hpZSw%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C2c0550686c55482e784108d85e3a79b9%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637362952855598708&amp;amp;sdata=3DjuwKVfB3gvGU5TkLK=
f9KYPdy90sgT80810dh91hpZSw%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488CD351F6ED46DD0979577F73A0MN2PR12MB4488namp_--

--===============0183144029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0183144029==--
