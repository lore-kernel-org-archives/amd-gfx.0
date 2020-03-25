Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB16C43331
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 14:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BBA82070A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 14:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FoXbOgT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBA82070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15D226E86A;
	Wed, 25 Mar 2020 14:30:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 850266E86A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 14:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gi3L+tebDkQeq+4ow8lfjlZuybgolM7Kq0xJhiPRE7tx3Z3ocYDCWUTseMeS6aG2gD4GgQcdKa48S9HsbfHYDeaXtIEWY4jCgD/X45wuyMxMXeAQCs1JVMqrd7aZZGnUYxRT2WhHsbEfvM1RhhUmE6cgmNaeb1jGyc4c3CPRGJ9dUJwmJ9ktqUDYRWbHVGYr4i2cWdvB7FnY78Izh042Tywb2uPhP1lYSE9rLhc8osg4bU1NzkwIT4Zd1nCkuuN/x1dAj7af24TuenMakiedWV8fykXD0YdS4CWYNmpSD7xJ3ADHYHyjjlvA6qJvwvtJTY5WEtT0/QiQtVC2nJAwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fmY9fPCRFv13U62+x28Tif6ho4Z255C3/E7i7rjEpQ=;
 b=KiHGPCsttVIH4X2Nl5ptwSjTJQjWYCovvXR7RxBKN4r+SBENkLntKCy3ytf69wKiKG8RAkZaGUBm8MzOjOimQ7tR6AOAs1eKO1OeRhnSvXttz3LerKn1tQHNORxC0WN/z8zNG/9Zt7f61pYyYQlm1BR+TjelPAuT9bHFkYlfVLJC0A67fwbD/25VzzJbMkpWzBNy3GIOowdlAHOIsuS2qAGeu9YUfyHZU25gMiWz63SECazLBpctyO3OgQuITlXScOFFizE/v6g5h20hB8QZZLeNlMGI3ZButD0HCTr7JnNC7NaQDRn2HvTLjjsxf18W7505P/K94dS++jZJTYgi5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fmY9fPCRFv13U62+x28Tif6ho4Z255C3/E7i7rjEpQ=;
 b=FoXbOgT9Pgtr0dLF1y+RtvJUefMQ7qVLm/Hex5opZFAV40ZEhyID2xkq8UGDvbhBQcUox0ccV3E43FSPh30+XtcgDf2XL/S7hP/lyt7nBwxYVRmjmLQn2Gk8lDi5Fja8iBdBAAS9FORcDrSLLmjELcKY06x1R7bVephY8vgqN5Q=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4581.namprd12.prod.outlook.com (2603:10b6:208:260::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Wed, 25 Mar
 2020 14:30:39 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2835.021; Wed, 25 Mar 2020
 14:30:39 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix hpd bo size calculation error
Thread-Topic: [PATCH] drm/amdgpu: fix hpd bo size calculation error
Thread-Index: AQHWAo7kiyq/fjPcyUCcrFMcrnGVs6hZGyoAgAAEXgCAAD8hpQ==
Date: Wed, 25 Mar 2020 14:30:39 +0000
Message-ID: <MN2PR12MB4488C9BAA9CF0906E4F8C178F7CE0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200325101848.8524-1-kevin1.wang@amd.com>,
 <ddf95fc7-daa7-4df4-8610-bc6b1f5b6125@email.android.com>,
 <BN8PR12MB3283615631DFCA853AB574E4A2CE0@BN8PR12MB3283.namprd12.prod.outlook.com>
In-Reply-To: <BN8PR12MB3283615631DFCA853AB574E4A2CE0@BN8PR12MB3283.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-25T14:30:38.536Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a330e6fe-2cb3-4e85-7b23-08d7d0c91746
x-ms-traffictypediagnostic: MN2PR12MB4581:|MN2PR12MB4581:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB45815AA9DD5B160D5687E20DF7CE0@MN2PR12MB4581.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(316002)(55016002)(33656002)(86362001)(8676002)(8936002)(186003)(71200400001)(26005)(81166006)(81156014)(478600001)(6506007)(19627405001)(66946007)(2906002)(76116006)(7696005)(53546011)(9686003)(110136005)(4326008)(5660300002)(52536014)(6636002)(66556008)(64756008)(66446008)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4581;
 H:MN2PR12MB4488.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CYqPkvTeACtuBFX9WFMIkGjhYuty8dDJfoSi5fBK8YSYpSn1ndeR3eDfCu50hFh2kAesrcGcZV7Xey5b/B53jHxJR+bFA8NnkaSy+8pVZXyiN1n0IClc5zmSPpyeJNRog6/NGMgdMVRh2eQo1sNwp9gAIt+ZIMc2hmQxooN+Leaw6Kaio0+eZCksAmZGV1un3uyfZ1XvBI1krAjvRLqRm+8+TSdVUc5fEGXV6Nood8LQ00Qg1JKXaQ3sX7jmZIMVz6e3kBloCKFS5D+Pq6WzNa1shfb9OB0/qI2ieuUyHPZFTlHZS6yQaNhB55GdHURmq8f7f5ysh/8eWI2DroHxJYcDeZPyhMuMSgnaczI6Z58Pm1K1jzcNFoDjllgfqYcyf3OYI6gAryZMYj3r3KPfFnRtUPa3J2RDdb7KjbzPmWswBDLHcWpulqespCXndTML
x-ms-exchange-antispam-messagedata: a40G8oeYPfRqj8sOb4vbhIzAKT/yH5Xv74QjnC2/Gfwf7JmsQrXC05GZ8XPtcFv76INhobHYY2WtNXxiaUvLJj3GsU+Tbr0xnMV7q9Qyf16olN4sBX0bTvb/x9MCLpgZLafLYsrHN3B0orip0CVybg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a330e6fe-2cb3-4e85-7b23-08d7d0c91746
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 14:30:39.1294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0RZP2LLlSOKK7jC3bZEEmYNXzCPDRueuTQ9WWE+3zLL9OgkYyH6J9YCk9uYnsrrDW4U0KUlp+p6LN4HpAegxgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4581
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1271019108=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1271019108==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488C9BAA9CF0906E4F8C178F7CE0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488C9BAA9CF0906E4F8C178F7CE0MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Wednesday, March 25, 2020 6:44 AM
To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix hpd bo size calculation error


[AMD Official Use Only - Internal Distribution Only]

thanks chris.

@Deucher, Alexander<mailto:Alexander.Deucher@amd.com> @Zhang, Hawking<mailt=
o:Hawking.Zhang@amd.com>
from the view of driver, could you help me review it, then give me a RB.
thanks.

Best Regards,
Kevin

________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Wednesday, March 25, 2020 6:28 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Feng, Ke=
nneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com=
>
Subject: Re: [PATCH] drm/amdgpu: fix hpd bo size calculation error

Good catch! mem.size is actually the backing store size (usually in pages).

Patch is Acked-by: Christian K=F6nig <Christian.Koenig@amd.com>

Am 25.03.2020 11:19 schrieb "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>:
the HPD bo size calculation error.
the "mem.size" can't present actual BO size all time.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 7f9ac1a14e6f..91c82383b016 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1113,7 +1113,7 @@ static int gfx_v10_0_mec_init(struct amdgpu_device *a=
dev)
                 return r;
         }

-       memset(hpd, 0, adev->gfx.mec.hpd_eop_obj->tbo.mem.size);
+       memset(hpd, 0, mec_hpd_size);

         amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
         amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index fb567cf5671b..01b22dad52fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1946,7 +1946,7 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *ad=
ev)
                 return r;
         }

-       memset(hpd, 0, adev->gfx.mec.hpd_eop_obj->tbo.mem.size);
+       memset(hpd, 0, mec_hpd_size);

         amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
         amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
--
2.17.1


--_000_MN2PR12MB4488C9BAA9CF0906E4F8C178F7CE0MN2PR12MB4488namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wang, Kevin(Yang) &lt=
;Kevin1.Wang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, March 25, 2020 6:44 AM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix hpd bo size calculation error</=
font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#0078D7=
; margin:15pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
thanks chris.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<a id=3D"OWAAM471300" class=3D"x__1OtrSZdhKXVv3UhaivrdJ4 x_mention x_ms-bgc=
-nlr x_ms-fcl-b" href=3D"mailto:Alexander.Deucher@amd.com">@Deucher, Alexan=
der</a>&nbsp;<a id=3D"OWAAM172244" class=3D"x__1OtrSZdhKXVv3UhaivrdJ4 x_men=
tion x_ms-bgc-nlr x_ms-fcl-b" href=3D"mailto:Hawking.Zhang@amd.com">@Zhang,
 Hawking</a></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
from the view of driver, could you help me review it, then give me a RB.</d=
iv>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
thanks.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Best Regards,<br>
Kevin</div>
<div id=3D"x_appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Koenig, Christian &=
lt;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Wednesday, March 25, 2020 6:28 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Deucher, Alexander &lt;Ale=
xander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix hpd bo size calculation error</=
font>
<div>&nbsp;</div>
</div>
<div>
<div>
<div dir=3D"auto">Good catch! mem.size is actually the backing store size (=
usually in pages).
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Patch is Acked-by: Christian K=F6nig &lt;Christian.Koenig=
@amd.com&gt;</div>
</div>
<div class=3D"x_x_x_gmail_extra"><br>
<div class=3D"x_x_x_gmail_quote">Am 25.03.2020 11:19 schrieb &quot;Wang, Ke=
vin(Yang)&quot; &lt;Kevin1.Wang@amd.com&gt;:<br type=3D"attribution">
</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt">
<div class=3D"x_x_PlainText">the HPD bo size calculation error.<br>
the &quot;mem.size&quot; can't present actual BO size all time.<br>
<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp; | 2 &#43;-<br>
&nbsp;2 files changed, 2 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 7f9ac1a14e6f..91c82383b016 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -1113,7 &#43;1113,7 @@ static int gfx_v10_0_mec_init(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hpd, 0, adev-&gt;gfx.mec.hpd_e=
op_obj-&gt;tbo.mem.size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hpd, 0, mec_hpd_size);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_kunmap(adev-&gt;=
gfx.mec.hpd_eop_obj);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(adev-&=
gt;gfx.mec.hpd_eop_obj);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index fb567cf5671b..01b22dad52fd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -1946,7 &#43;1946,7 @@ static int gfx_v9_0_mec_init(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hpd, 0, adev-&gt;gfx.mec.hpd_e=
op_obj-&gt;tbo.mem.size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hpd, 0, mec_hpd_size);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_kunmap(adev-&gt;=
gfx.mec.hpd_eop_obj);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(adev-&=
gt;gfx.mec.hpd_eop_obj);<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB4488C9BAA9CF0906E4F8C178F7CE0MN2PR12MB4488namp_--

--===============1271019108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1271019108==--
