Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19471C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 03:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E5A6109F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 03:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E5A6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D27C36EB45;
	Wed, 12 May 2021 03:31:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8190B6EB46
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 03:31:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sl6qWV5Tu5eaOe4Fs0zvcAR5OpQavxj8N77Ek1B7BeF4AsTTVIYmLrGrk9/0Q1cn8ii59WR6oUcuuIkWBNjDMe4jg5rMI/C07WYshWtus4ZXo4fUldfPEdJ5zqaaBq/f3zvd/+H90GzoG8BOvzAaIZ0fUP1r42Jh5SMV/qiOHa6BIvOpRcO4H5IrSGfTD6eopnG5j2fUxF1Fpf25rMW9KUDi7klB8qO6xgI18P3bBBoUVOkk2nSNM07BOWO/v4Wo9+tAJpSu3JpiF4R5stXwPMZA8CWqF2rsMu03g2QYE56n1v9xFoFflUGRhNjwQM2+1rgy6clpaMrUbBj1fx8Npg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmpu0oiZ/0Gxj/ypQOFqWCUDXb5AQJv6NJ1FFWt5NwU=;
 b=cXu/vyFEKq5J84vv/CLWKl1b1rndX3jaOYEKPoIYtx+mZj09AmAZnP8Rxfcc1MNz4ZS8XqKvW62baJcA/tU9X0NaAma0YRIg6oj7KqMEzk9gAVVQTkKg+PM1p6zy7fM7ZOkVTj83YRf9ucX7F0bMokSANQQtB3jYeGPYTEP6nYLASqOowNe0JJ1W++2RYFcPEzRwfOop3Xi18HtF3I3AmJEXdK9qGm69lkEVBRKFIxlWuisxL/HufOuGzFGbKLtPXalyr3J0113Z4qVLz0gd9X8E0UC7ArfmumjjKwJfP/ADI3aTor3V2+CgqC8HocwKId35pKD3Ki1CuFfreI1Cjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmpu0oiZ/0Gxj/ypQOFqWCUDXb5AQJv6NJ1FFWt5NwU=;
 b=UYjtwVkI1rwYqRpxujB77+W9POLUtuCxacDzNRa23t//OPlznspWI7seZ5HeVSDkRBzzjB3dY7vr4XFikIPl/9xjXGKtRvqEKMm4YA3rHm0+K4L79Q5E5s/iRfZ76koC5YhSwWY7e8aKFCAqowthUE2I5taTVLtRYKpc9I1mkfI=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3854.namprd12.prod.outlook.com (2603:10b6:208:16a::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Wed, 12 May
 2021 03:31:27 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 03:31:27 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Add compile flag for securedisplay
Thread-Topic: [PATCH] drm/amdgpu: Add compile flag for securedisplay
Thread-Index: AQHXRtFfREsbJCVTRk+gZDlnUQxuZarfMN03
Date: Wed, 12 May 2021 03:31:27 +0000
Message-ID: <MN2PR12MB4488134CB3D018426CB4F831F7529@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210512015121.2122807-1-Jinzhou.Su@amd.com>
In-Reply-To: <20210512015121.2122807-1-Jinzhou.Su@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-12T03:31:27.238Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bec0355f-388a-4b68-2bd6-08d914f66d47
x-ms-traffictypediagnostic: MN2PR12MB3854:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3854B8111DDF004E48906964F7529@MN2PR12MB3854.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vvgnvX1jl6P8iOYFggVyS5JLzcfsZT2ImTcAQt5DXW7/PoPCmsVdezloYgzgpTvFbQgIOqwMmqcpDmBXV+uWVHBs2gUL0WKVDMRWTh/HW7OntxziZ6qoOxtO1zPTWksQ+tFvvDdMQUIFEcl4DIClZ45HANO0pxHJpEhiePj4N4ZmWX4ZXeKnhrTGfUVbKKOhB8AKk9PqVsKuAvwoCq2TjG+aNjyamrOUaNmu1oqmanlKmb8azN+PNJUJmEe7DIkCpHlkdxqnUaMmsjzHbUkiEmjVUdP19GeH1ffQP3n9ctEs+Px2FRxNXhSdJziIJIMZTfwrHr+vOPnVpOcLDjRqD/9NvNobPLnOwXdmgm5yH0G9cekvwWg0L09WxjDNdO4rxVQARXRvaVodY0Yiaaww5v9H42P8DIbHfQ2Fgw8KP8ZnjHL3tkGq48NsUej0+/PGEAqN/o2/sx7rIMATNN1nyZ04GN0m2hj6rlmnr0qp39xf9y8db3tpdRpCtF3Y65ZN2wntIrKWSdR/bLcAp5WB8529AiJLxSRu8HejGquksySgK7/by2GwLfEJjebd6vN/euptxOEUJTjfO84m4alY1YacnzXBS8swMzbIjgBjI0PKT423A3au5/alejPo3uCOyUm62tLTfnsCoaO8ZRX97g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(4326008)(66946007)(45080400002)(52536014)(966005)(26005)(55016002)(2906002)(66556008)(66476007)(66446008)(64756008)(53546011)(83380400001)(9686003)(86362001)(122000001)(316002)(110136005)(7696005)(186003)(19627405001)(6506007)(5660300002)(166002)(8676002)(71200400001)(8936002)(478600001)(38100700002)(33656002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MLDV8y2YDvyx4za+mHnmW789pP2SiFmMtj8ZuWrSdY3NX5JFb2xbmGkdLpdn?=
 =?us-ascii?Q?40a/3QozyPV30ZuF0uGclEEr4TSWAu7DQOHwexM4oIFw0wVyDAM5bZjjoY8W?=
 =?us-ascii?Q?ojPmKp2Ylm+qDvlK7Ra8/RQX161QGwObp1n4/OL1TzwiyKVtA2wYCbW5T6eW?=
 =?us-ascii?Q?h9LsuHmuZPxDhfuu5E9HLCM3jBAu5Go9Bdt2qPEpTTK7A9S7Aay6OD4KdKFf?=
 =?us-ascii?Q?845p5HQErz1QNqFEcXQeJUEd1F/Cu7ZE/aYgOCCPavXfBRBKD0fI/g/CAuVc?=
 =?us-ascii?Q?ScgS/yKKk3AeXdJGJbi6KwbbcnnuxXvS+XbQrIDaCPodBVv2IKSfXoZAZF1V?=
 =?us-ascii?Q?RoKjGhIEZRfffDQ05eGlv3sstE93DZHyL3wpf3DjIOIWYjRJ37jHlGIa399G?=
 =?us-ascii?Q?e6J0GixHyNbIM87yj/+5QWag8uO77VEWr8kuY+qytEd0VB9VRFwW42xNNLaQ?=
 =?us-ascii?Q?I61Hz7QeQFw4Z9+YzO5ZIgRYT9kSSsWT7KlpqIMBhoaQWK9uDADibV60bo52?=
 =?us-ascii?Q?3w22dRlfNXgtfeQeI2MmwBe5BibusXTCCUsqLPClZR3F8XJgZgPC+uQVWnIR?=
 =?us-ascii?Q?PYhhpUb1QdARbgI9pie83lWBRPXB43mfL9DxjKLXgA45/JDzZEfCEkCtQjfz?=
 =?us-ascii?Q?yaqSyLL+sjvGTs3J0u3xCoRvHgeQ7zGLyi4PpcvN2qfeD8BgwBrTjCfTvg6S?=
 =?us-ascii?Q?Zvd/rLlImP7DliFouc5D+5hxuV9bjUUyEL7YgKX7sKhIyincvxZD3SxNZjlb?=
 =?us-ascii?Q?n+zABL+ZdX8FFcLHb9Pj51OGaBtuewEpnzqOfjEXqa/2XUCxcZA+S05ruuin?=
 =?us-ascii?Q?hhkq4cvPAikSf+MNVhgaSy2j1fCE8/feJXiXcijMMH5wN611f5zigN3a1VTs?=
 =?us-ascii?Q?bMU/LreEAFdrlO2rMyqE5RwM5CW767DplAqwPVL+xAMSuMq3/4Iaop+Fj8MU?=
 =?us-ascii?Q?S4o+fSuzb2UGkL+QEm69qhdYsjvpHRpqMBxkik5DFHICKaBG4z+hpnziFbbD?=
 =?us-ascii?Q?QhQgDMULLeGcrPVmB9yiwTiZNHSg2XqJdflYAbfDx++SPCPTd655i64ggWJP?=
 =?us-ascii?Q?yL0kOj3qw472nchxv2hBqBnKdtttuTWSsO2d9faa5nmnK7Za8Wj3OsdxzcEp?=
 =?us-ascii?Q?44TZYX7coWc6Av+q2PdU9Jcx0DdYfmBzwhosL3l87gXbq1oatR7qG87G7yfH?=
 =?us-ascii?Q?GX+mF1EcRd718393WDhEsIM9mHGzAVZjZk6gI4Tj3jFzd2eME/grGYek/DTi?=
 =?us-ascii?Q?r84S6H7damaO3gr+LDsx/J3gSujsuxyq8DaMXamFmCzQh2mxhYayQU9GevSm?=
 =?us-ascii?Q?QLYib9MKEg9itoUe7DACrA+N?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec0355f-388a-4b68-2bd6-08d914f66d47
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 03:31:27.6949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGHJCO2XWMvF93kLk9Zy8eDesyKlxXGN05nnHpmzATnC2QkERPKStP7kf+6WmSfWxCEZQEUCNNsNwhkDgmAS0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3854
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
Content-Type: multipart/mixed; boundary="===============1835355704=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1835355704==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488134CB3D018426CB4F831F7529MN2PR12MB4488namp_"

--_000_MN2PR12MB4488134CB3D018426CB4F831F7529MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Jinzhou =
Su <Jinzhou.Su@amd.com>
Sent: Tuesday, May 11, 2021 9:51 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: Add compile flag for securedisplay

Add compile flag CONFIG_DEBUG_FS to clear the warning:
unused variable 'amdgpu_securedisplay_debugfs_ops'

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_securedisplay.c
index 5369c8dd0764..123453999093 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -86,6 +86,8 @@ void psp_prep_securedisplay_cmd_buf(struct psp_context *p=
sp, struct securedispla
         (*cmd)->cmd_id =3D command_id;
 }

+#if defined(CONFIG_DEBUG_FS)
+
 static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const ch=
ar __user *buf,
                 size_t size, loff_t *pos)
 {
@@ -162,6 +164,8 @@ static const struct file_operations amdgpu_securedispla=
y_debugfs_ops =3D {
         .llseek =3D default_llseek
 };

+#endif
+
 void amdgpu_securedisplay_debugfs_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
--
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C14fa5aa45bb3405a908508d914e880d0%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637563811100744522%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D1lE%2FskHrU0TkqeNBL%2Fnl%2B%2BHOECO5gSFmPM7nrUInV3Y%3D&amp;reserved=3D0

--_000_MN2PR12MB4488134CB3D018426CB4F831F7529MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
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
ounces@lists.freedesktop.org&gt; on behalf of Jinzhou Su &lt;Jinzhou.Su@amd=
.com&gt;<br>
<b>Sent:</b> Tuesday, May 11, 2021 9:51 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Su, Jinzhou (Joe) &lt;Jinzhou.Su@amd.com&gt;; Huang, Ray &lt;Ray=
.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Add compile flag for securedisplay</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add compile flag CONFIG_DEBUG_FS to clear the warn=
ing:<br>
unused variable 'amdgpu_securedisplay_debugfs_ops'<br>
<br>
Signed-off-by: Jinzhou Su &lt;Jinzhou.Su@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 4 ++++<br>
&nbsp;1 file changed, 4 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_securedisplay.c<br>
index 5369c8dd0764..123453999093 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c<br>
@@ -86,6 +86,8 @@ void psp_prep_securedisplay_cmd_buf(struct psp_context *p=
sp, struct securedispla<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*cmd)-&gt;cmd_id =3D comm=
and_id;<br>
&nbsp;}<br>
&nbsp;<br>
+#if defined(CONFIG_DEBUG_FS)<br>
+<br>
&nbsp;static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, con=
st char __user *buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size_t size, loff_t *pos)<br>
&nbsp;{<br>
@@ -162,6 +164,8 @@ static const struct file_operations amdgpu_securedispla=
y_debugfs_ops =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek=
<br>
&nbsp;};<br>
&nbsp;<br>
+#endif<br>
+<br>
&nbsp;void amdgpu_securedisplay_debugfs_init(struct amdgpu_device *adev)<br=
>
&nbsp;{<br>
&nbsp;#if defined(CONFIG_DEBUG_FS)<br>
-- <br>
2.27.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C14fa5aa45bb3405a908508d914e880d0%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563811100744522%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3D1lE%2FskHrU0TkqeNBL%2Fnl%2B%2BHOECO5gSFmPM7nrUInV3Y%=
3D&amp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?ur=
l=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;=
amp;data=3D04%7C01%7Calexander.deucher%40amd.com%7C14fa5aa45bb3405a908508d9=
14e880d0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563811100744522%7C=
Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL=
CJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3D1lE%2FskHrU0TkqeNBL%2Fnl%2B%2BHOECO5gS=
FmPM7nrUInV3Y%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488134CB3D018426CB4F831F7529MN2PR12MB4488namp_--

--===============1835355704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1835355704==--
