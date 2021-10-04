Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFDEC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 01:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F88260F9C
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 01:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F88260F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E0FC6E8D5;
	Mon,  4 Oct 2021 01:15:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A9A16E8D5
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 01:15:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfvNyKqmvWqJSZzIWRLtZGynoXJEhCbjzKYdU5KcpJDvvPvsF7pQu7hgMM0GRi07IpNPXawy6294FQLd5E5QkunjlqhLjw26zoM23oAoZE+fJtjTWHgplmzeYNj/fGEGdCgaXd06SQEcdNNDc4KZt2Kmrdcwj+ngi3YbMww+5nUM8wMVXaDvQdXpfcKxlvaTuj7kYo8AGfalgtVblHXU3puge2+lk/N+30SElpDL1FKNDoD7/GG+o3gvKvHzDEj5Izy+YjZ0LccFVVpAGz9PhKzV6yMBkUosY4NJFL939BtGo7YSOLXSF7vn5QyahnPun1wWKBha1PN+AmqDCN2gmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vr5oOWETfsj3ml86OV3Yes+qbD9pj6C1LZQYYcGMqOo=;
 b=WzkdlssSUa09feNW9xsqOXc24PVNM2oRxoKcVdjycCPhWyBha3/N8Dg3gnULA6EIV9pR73oQX8jcZC3/EmTJtzon5GYLvddRThTrbq0oize3hg4ScYDjbqLn9vqye4scli6ihAaCIcS7JYS585k6QCzf5OR4kEWhilyLBrvjvvKDYWezpAy6Geg9smQZbfO+IZeDR0gz8O9VrH/q4yGmxfR5Ceiv2vfwNwDQKJLxRALfSU4VrJMJ37E+PXlM9+KgVkR7Ij1JaOkJ8HpPhcSQo+CvrL6oI9J2KA309Cl8YN9r1MTyFOskjx3f2MbKXmjnIYmqjW5LRQjsxvQvnvH/ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vr5oOWETfsj3ml86OV3Yes+qbD9pj6C1LZQYYcGMqOo=;
 b=O+5JMzh8tELUBRgBBbViJWVMMt6gU+8vifvclZ6xjPkL1a1YvMekKr91zIv17ACZPX1zMx+u/7NNWckNoH4E+D52Kw6OZTydinXiYUKaTgwu7a8jXCqchoiqG8G8bv2oGAl4AlyIbEATnIzGDNRts5q+T14UilhUHUeQggtYBl0=
Received: from CH0PR12MB5387.namprd12.prod.outlook.com (2603:10b6:610:d6::17)
 by CH2PR12MB5561.namprd12.prod.outlook.com (2603:10b6:610:69::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Mon, 4 Oct
 2021 01:15:06 +0000
Received: from CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::5ba:1c46:d9ff:d07b]) by CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::5ba:1c46:d9ff:d07b%3]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 01:15:05 +0000
From: "Powell, Darren" <Darren.Powell@amd.com>
To: =?iso-8859-1?Q?Nils_Wallm=E9nius?= <nils.wallmenius@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/3] drm/amd/pm: Fix incorrect power limit readback in
 smu11 if POWER_SOURCE_DC
Thread-Topic: [PATCH 2/3] drm/amd/pm: Fix incorrect power limit readback in
 smu11 if POWER_SOURCE_DC
Thread-Index: AQHXuBHJwaluD6Mc9UGsWalvDSMwmqvAv5CAgAFJLkM=
Date: Mon, 4 Oct 2021 01:15:05 +0000
Message-ID: <CH0PR12MB538776FD2668249C166A0C9BF0AE9@CH0PR12MB5387.namprd12.prod.outlook.com>
References: <20211003044658.29238-1-darren.powell@amd.com>
 <20211003044658.29238-3-darren.powell@amd.com>
 <CA+nq7DtKPwnQNEMy+jacOtN4JqwQnKb7LFb-XODuN5exxA3fhQ@mail.gmail.com>
In-Reply-To: <CA+nq7DtKPwnQNEMy+jacOtN4JqwQnKb7LFb-XODuN5exxA3fhQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-04T01:15:05.355Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: e023b753-24fa-b146-a033-a636cc363b0a
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e503756e-b119-435e-8456-08d986d46672
x-ms-traffictypediagnostic: CH2PR12MB5561:
x-microsoft-antispam-prvs: <CH2PR12MB5561BD8CEAF54BF5627F9EE2F0AE9@CH2PR12MB5561.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 35z7TSG9u9yf0zbi25u5PIpXsuQXR6yDsaMO7v9qnlZ+FKOg4n5cLs0rLc3YYre9hxIiOZJDnB4ip9f4l5VnCKQ5wLaGN0haJuqlfcJREgjGxCdlZe8ppxLXLQpaR4+r3qZoh94Z7zhtOQY03X3VNlcnkZbu247HvxrwcH4PIBb4PzlK0l845dKnYcP+5wOB5b49ozLaxb/utGAF42RKUgaXu0lf+Fno4cIft3Ak9jT5UL6NbDQ9PFq55aTx/bkCtiqhQmhfGCmj0/GbBcO6S3cy4VKBYmm7gxFN8te0nnF1Qxy/dfnIWQKg0OOF/zaBJsabJUxP+ICen/XOQ/5rA8RL99/G962vXgYf++S/QpnY3GfTyv25be64kQaA71d7FFnXBu6eoTof78bTEOiPn5RJn5ps0VGqbD+twUCbN4dridEcX1uDXI0LUDluPoEV2ash0Bt/0vSEQ2RaNdsHkMQ+7Q4kTWL0TlMwx0vKS0AfqhoC5BUvy03xVK/F3ZLTn/K+WWKDUUIHNbDlOwME2QeV6cHxMwyFswEmWAnXZUHnkkrrhqyTWxFFv7UfAhckqN3Bv9hFGKH9XUL9olmDD+0fv/Z79f1WxGfg+pt0+n7ZXpHaWn7XglZHLPNi3peye41gcgV1y/IXuGaoOKrh5UBV1BlOkZDA/e6odi1qk5uqJZjTelUtzMBYFtuadk8++1BnqRcZG8RuPSrSrdynzg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5387.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(53546011)(66946007)(6506007)(2906002)(38070700005)(7696005)(66556008)(64756008)(66446008)(66476007)(55016002)(4326008)(91956017)(76116006)(9686003)(66574015)(508600001)(83380400001)(122000001)(52536014)(71200400001)(33656002)(8936002)(6916009)(5660300002)(19627405001)(186003)(8676002)(316002)(38100700002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yUI28fCm4Itlo4wOHuOkVT/vwJydPQdn5600CqWBvnNRooFYKpqXaP+gOp?=
 =?iso-8859-1?Q?sx5PWIqoOl0UNK8IGIv/qtHIoDRn6EUJdJX8O7wHAcszTKW/vYw1WxbHEX?=
 =?iso-8859-1?Q?FzKS5198gbSQBzH/cFkp9gyBfcl7jg89HvhD96u25Q851c6H4GE2Os6I4f?=
 =?iso-8859-1?Q?ECvlt6IwKW/8n4FuhjIounpYDEBT8LCqW7SfMD3nOpgyWE+Q8VbhE2KZVZ?=
 =?iso-8859-1?Q?2qK4oJ4PqPET21XsuWhITq8Vnr95KKRBUlqz2npukFA/Mj48s2/TcM87le?=
 =?iso-8859-1?Q?Uo52irgw2gtU+tEd35FoU6fXmtyRZbyHmX1XrGfeKNwV6bjFxa/AByHkjB?=
 =?iso-8859-1?Q?KJ5HvXTraoj/w6+wqnUQGPV5zbBFE9qQ8aSf6frcjxxuMnkcNJ19/vPef6?=
 =?iso-8859-1?Q?QreHUhefUs3P10sq/6AUW6yXE2WIl7c32g04tT0uPFKdnZVjBL3s0AAjeV?=
 =?iso-8859-1?Q?SV2zBQhHg+dYCOKom/siMQwwHHzgYAJqvuzsrB+dKPzktnCRU1i+U/0taG?=
 =?iso-8859-1?Q?ELC0hKbVPdtn/OkIGbcVGC7deZPHH5D0f/BA8r9kxjZ+VYTwzNuTo5TGzi?=
 =?iso-8859-1?Q?S4xKc0O4gSsc4Cov1ODVFW7MMJVwTlT8EutEeRVDeFmEJixcd38RMbq6GN?=
 =?iso-8859-1?Q?yMQ1IwHOWXpzkTFWa57cAya2/MpM/ubM2N14LEnhH8bfkPeQ4dE4YJ88Ly?=
 =?iso-8859-1?Q?nJSm/hEPxCYzsS1GRr5fUT+oWafhWa4dw2sQ73oDUrgKZEJ7MPVUTg2R+1?=
 =?iso-8859-1?Q?yVd492dfSp0YcmXJcEAHCp7+zZRwJGJkFG1T//BN120SvomxIMKfiJ3KVl?=
 =?iso-8859-1?Q?lbDgii0Wn4Hcj9bbcC0/QA4gGMxvMqQE+U1hQTeaiwFZYMIIelx2BaUDvq?=
 =?iso-8859-1?Q?uWiqMaFeEco0g7nCLAJkVk+Bm6iH1DIDeA/qDXQ1Vvpv9CGi9PF5mW07Vy?=
 =?iso-8859-1?Q?rDarSfY3CVLiC5xBIUai4GExukX6AnIsu65AkofafkdZlffYHy5rW1Hn9B?=
 =?iso-8859-1?Q?YnivFjZrMZxupDzECJfEV7N6TbE3KX8wNDvBnz11hmvTa/eSkrWZeTuGMV?=
 =?iso-8859-1?Q?6PinQi3y/uF/OL+q9s66Lf4bjOq15gkKHCRYHRVlE8rNYOPe2R27qLCAwJ?=
 =?iso-8859-1?Q?rptJiBWLQk9OwauxNRyYeR0GQXkAvcd86P7qRe3q7Ke2EYwTrTG9L0Iaxk?=
 =?iso-8859-1?Q?zzZFKBKU8KuiQDmQ8VepSma9q0gk4Dsei3BA0i8T3jNvboiR7AHwRpS5N8?=
 =?iso-8859-1?Q?cnxuX9dtakmcpktA/DSKOz3qzC04mrv0fYMo3OH1FGaNai5DBrh9+o2C5f?=
 =?iso-8859-1?Q?oyPyDpXOep06Sr5w4u7zS1uQ+EpN9BJEzxTjykPO7pvql0xFtrDBQARsEi?=
 =?iso-8859-1?Q?Ou4f7jhvmf?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB538776FD2668249C166A0C9BF0AE9CH0PR12MB5387namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5387.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e503756e-b119-435e-8456-08d986d46672
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 01:15:05.8749 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3jlPFK7ljJaQxzK2tPjTL8IHn3qjuQgQZOwZKpQLSJnbh/QrW0C9m3TWxx1isRjtgZLZqn/NLy23qHCn6EOoAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5561
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

--_000_CH0PR12MB538776FD2668249C166A0C9BF0AE9CH0PR12MB5387namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Yup, agreed, but I rationalized that it:
 - minimizes code changes, leave existing code in place
 - reinforces the comment, which states that only 0 is supported in this bi=
tfield at this time

Thanks
Darren
________________________________
From: Nils Wallm=E9nius <nils.wallmenius@gmail.com>
Sent: Sunday, October 3, 2021 1:31 AM
To: Powell, Darren <Darren.Powell@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/3] drm/amd/pm: Fix incorrect power limit readback in =
smu11 if POWER_SOURCE_DC

Hi, sorry for the drive-by comment but

limit_param |=3D 0 << 24;

Doesn't do anything.

Best regards
Nils

Den s=F6n 3 okt. 2021 06:47Darren Powell <darren.powell@amd.com<mailto:darr=
en.powell@amd.com>> skrev:
 when smu->adev->pm.ac_power =3D=3D 0, message parameter with bit 16 set is=
 saved
 to smu->current_power_limit.

 Fixes: 0cb4c62125a9 ("drm/amd/pm: correct power limit setting for SMU V11)=
"

Signed-off-by: Darren Powell <darren.powell@amd.com<mailto:darren.powell@am=
d.com>>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index aedaa4bb15c2..9bb6da99d5b5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -984,6 +984,7 @@ int smu_v11_0_set_power_limit(struct smu_context *smu,
 {
        int power_src;
        int ret =3D 0;
+       uint32_t limit_param;

        if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
                dev_err(smu->adev->dev, "Setting new power limit is not sup=
ported!\n");
@@ -1003,10 +1004,10 @@ int smu_v11_0_set_power_limit(struct smu_context *s=
mu,
         * BIT 16-23: PowerSource
         * BIT 0-15: PowerLimit
         */
-       limit &=3D 0xFFFF;
-       limit |=3D 0 << 24;
-       limit |=3D (power_src) << 16;
-       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, l=
imit, NULL);
+       limit_param  =3D (limit & 0xFFFF);
+       limit_param |=3D 0 << 24;
+       limit_param |=3D (power_src) << 16;
+       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, l=
imit_param, NULL);
        if (ret) {
                dev_err(smu->adev->dev, "[%s] Set power limit Failed!\n", _=
_func__);
                return ret;
--
2.33.0


--_000_CH0PR12MB538776FD2668249C166A0C9BF0AE9CH0PR12MB5387namp_
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
Yup, agreed, but I rationalized that it:&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
&nbsp;- minimizes code changes, leave existing code in place</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
&nbsp;- reinforces the comment, which states that only 0 is supported in th=
is bitfield at this time</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Darren</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Nils Wallm=E9nius &lt=
;nils.wallmenius@gmail.com&gt;<br>
<b>Sent:</b> Sunday, October 3, 2021 1:31 AM<br>
<b>To:</b> Powell, Darren &lt;Darren.Powell@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amd/pm: Fix incorrect power limit readb=
ack in smu11 if POWER_SOURCE_DC</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"auto">
<div>Hi, sorry for the drive-by comment but&nbsp;</div>
<div dir=3D"auto"><span style=3D"font-family:sans-serif"><br>
</span></div>
<div dir=3D"auto"><span style=3D"font-family:sans-serif">limit_param |=3D 0=
 &lt;&lt; 24;</span></div>
<div dir=3D"auto"><font face=3D"sans-serif"><br>
</font></div>
<div dir=3D"auto"><font face=3D"sans-serif">Doesn't do anything.</font></di=
v>
<div dir=3D"auto"><font face=3D"sans-serif"><br>
</font></div>
<div dir=3D"auto"><font face=3D"sans-serif">Best regards</font></div>
<div dir=3D"auto"><font face=3D"sans-serif">Nils<br>
</font><br>
<div class=3D"x_gmail_quote" dir=3D"auto">
<div dir=3D"ltr" class=3D"x_gmail_attr">Den s=F6n 3 okt. 2021 06:47Darren P=
owell &lt;<a href=3D"mailto:darren.powell@amd.com">darren.powell@amd.com</a=
>&gt; skrev:<br>
</div>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0 0 0 .8ex; border-left=
:1px #ccc solid; padding-left:1ex">
&nbsp;when smu-&gt;adev-&gt;pm.ac_power =3D=3D 0, message parameter with bi=
t 16 set is saved<br>
&nbsp;to smu-&gt;current_power_limit.<br>
<br>
&nbsp;Fixes: 0cb4c62125a9 (&quot;drm/amd/pm: correct power limit setting fo=
r SMU V11)&quot;<br>
<br>
Signed-off-by: Darren Powell &lt;<a href=3D"mailto:darren.powell@amd.com" t=
arget=3D"_blank" rel=3D"noreferrer">darren.powell@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 9 +++++----<br>
&nbsp;1 file changed, 5 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
index aedaa4bb15c2..9bb6da99d5b5 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
@@ -984,6 +984,7 @@ int smu_v11_0_set_power_limit(struct smu_context *smu,<=
br>
&nbsp;{<br>
&nbsp; &nbsp; &nbsp; &nbsp; int power_src;<br>
&nbsp; &nbsp; &nbsp; &nbsp; int ret =3D 0;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;uint32_t limit_param;<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; if (!smu_cmn_feature_is_enabled(smu, SMU_FEATUR=
E_PPT_BIT)) {<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_err(smu-&gt;ade=
v-&gt;dev, &quot;Setting new power limit is not supported!\n&quot;);<br>
@@ -1003,10 +1004,10 @@ int smu_v11_0_set_power_limit(struct smu_context *s=
mu,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* BIT 16-23: PowerSource<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* BIT 0-15: PowerLimit<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
-&nbsp; &nbsp; &nbsp; &nbsp;limit &amp;=3D 0xFFFF;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;limit |=3D 0 &lt;&lt; 24;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;limit |=3D (power_src) &lt;&lt; 16;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;ret =3D smu_cmn_send_smc_msg_with_param(smu, SM=
U_MSG_SetPptLimit, limit, NULL);<br>
+&nbsp; &nbsp; &nbsp; &nbsp;limit_param&nbsp; =3D (limit &amp; 0xFFFF);<br>
+&nbsp; &nbsp; &nbsp; &nbsp;limit_param |=3D 0 &lt;&lt; 24;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;limit_param |=3D (power_src) &lt;&lt; 16;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;ret =3D smu_cmn_send_smc_msg_with_param(smu, SM=
U_MSG_SetPptLimit, limit_param, NULL);<br>
&nbsp; &nbsp; &nbsp; &nbsp; if (ret) {<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_err(smu-&gt;ade=
v-&gt;dev, &quot;[%s] Set power limit Failed!\n&quot;, __func__);<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return ret;<br>
-- <br>
2.33.0<br>
<br>
</blockquote>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CH0PR12MB538776FD2668249C166A0C9BF0AE9CH0PR12MB5387namp_--
