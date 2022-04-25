Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFBDC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 21:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C23CD10E355;
	Mon, 25 Apr 2022 21:39:46 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2078.outbound.protection.outlook.com [40.107.100.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8966710E39E
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 21:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8VPFxn9yazNw9Keo/x5kKA3UN8YkJEHgnXwiDwQS/HzeGvdGsI8MwwT2xWWemLN5IfmA2hqb2m6XRZsOgYddFBxwUM/LBR30+lwfRcUj0WEjtKRtc1yKAzp9EeRTjtq+Z4OENNVjdULCGyCdJODHSCoWD+0yCNrG+pyzOjNJRaHMK/UQFzwNXYCtbBXkwAk8Uxpmj2MjPoiAUqKetkKnJH+aRH9pO49scHSaD3/ZbDgh443SUygWF1MRXDXolljm67aQ9O5CJZq1ly/MF//3f3abpdQ4Z+OpsjRab95l0kT0UfrlXw0w9gSASXZ5kgQmXXh+Nd1L8kIX+jnPvL3wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyyT5RWGIGxYSDbq5g72I5dG8eQcxq+TdHtovzCuqvE=;
 b=DdAOTBwA/TmUng5c+Zpnsb06xOn5wOws2bOPAaxHps3V6djdbNku2JJqRfpAqVQs22GYdgy1hLD6mBqMVD4nGk2NNvatAPJH3oVtzirU6ETQl0emM2O+2FSQq8DoTbwhYfeGnYp9YvwwteNwR8cTB0PkTrRLICvfKDJmGCO4Izc3lpGYPBwwwsxKo4ndCD8df1/I1h7nmcgwJ577SR01a8r5Zth0tAJYVjiUiVQ2WUQhOQY50EYxq8hz+J8Osu/Uc/XsSAcMu124n9h0Iua50jZtO3TFTdVmUOod2l6OfkVUkaFlCK3xcyHDXKRVh26bqiINdzhTeBmYYvrJOpcECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyyT5RWGIGxYSDbq5g72I5dG8eQcxq+TdHtovzCuqvE=;
 b=ImptzAB3rygw2xoSWHxRSz5491uokaaeXn9+NMUE3Xrqb41sGWyJXXe4Yx6+mDSkJoxH6oHRr5Av6O6wK9UK97PK+f3tStRaqiC37aqOAmGMIqjmsRp5BoF2yc60/oL35bfXrpzQ54tL9A73odqwt3cYyfS92epL48J9MMZPZ+o=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 21:39:43 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::98b8:8b06:2069:c838]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::98b8:8b06:2069:c838%7]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 21:39:43 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: keep mmhub clock gating being enabled during
 s2idle suspend
Thread-Topic: [PATCH] drm/amdgpu: keep mmhub clock gating being enabled during
 s2idle suspend
Thread-Index: AQHYWHGMfICNi4d7E022UH22sPqTk60BKO8C
Date: Mon, 25 Apr 2022 21:39:43 +0000
Message-ID: <BL1PR12MB5144E85AAA1350161E0018FBF7F89@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <1650869553-28976-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1650869553-28976-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-25T21:39:42.912Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90a9583e-c75c-4cdf-af1f-08da27041c52
x-ms-traffictypediagnostic: MN2PR12MB4342:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4342BD8604AC8A3EF287E6B3F7F89@MN2PR12MB4342.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5P/Bnna9UHvip94vqFjDUHMaj/dZ3mso+BBW/TNIzib46qRr5+Z7Q0k5qguppYAILCaGuaOuc0CbcSi0zhwLizQR6vFGT8z0tP5k4vrcr5o2gSOxHUDnvxvQ6Q59G6cafeaSNvvF6ihTH3Jt5R7NbP9bNh4FaO+akX+DCX2rid1AzB6Ic/drsmPDetZ8hA+vWLH25ZCDtN1sxdn8JSc14yxIUtLCAIds/DIo6gRgA7wTPOVMozEhfupUGNaUtAtCDzYicDj9Ew8lzqNe5+Xw+obKeN8Aq95+M2NCApDPeZJiefY6X9+DLHwroQ+JYB6rcyNxezwluy7FSzALAdjCDOo6anTw7Ea6adfXGTs1hHMf9u4m+fIMzqh5QITqM/NfOVlUfDfbnAcZq7lFupOdetJ2Ysr3cFOzoAk/bCGJnxzdSPyntBlD8Oz98Su77au6/Zh2HOtSpjDAfG6gSB72Gdwh16ZZh5EAn9O6YUNZ7HJgGk3vBgoVxR63I5k7HEvV2dHD42iZA2Q4HAo0ryly3ULtWEqXJ2kJA8a8vnaEMnCWuHPFO+K1i6NWzR7zy7S3kECrYyGm53lh0/btEvCrOhl4I1nY34SBNeocSY6hHNlqmi3biOgDiXpzeq3nUV9NdWSNwP2YS47sH7CDpQiqt6BZC5B6RaWhRYDi1Xgu1FszXRli4L4/XdFbkNL8q+PFCP05rm4H/Ik9IOnvqaV/Rw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(54906003)(64756008)(66556008)(76116006)(8676002)(66946007)(9686003)(66446008)(66476007)(4326008)(7696005)(26005)(316002)(86362001)(71200400001)(508600001)(53546011)(6506007)(110136005)(186003)(83380400001)(38070700005)(38100700002)(19627405001)(55016003)(33656002)(15650500001)(2906002)(8936002)(52536014)(5660300002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5zux4YFod6S56pPyZUQyM98dYJ/aTfed2BPp2CqzlAqLd4djmsYDy5HgwjfV?=
 =?us-ascii?Q?AMuUoXgWgZTfFDZCe2f+KNYIP7J0lGv4S7PMEwNVoFQ0exD/w9FInSFmYikx?=
 =?us-ascii?Q?2zNLu19J/5qlkOxgZ6A/hKYIeqJu1k8UZsxRYY+VbsAnEkMrWdYgD/aGaapD?=
 =?us-ascii?Q?Oh/GDlH4naDZYgD0uuv4h7tNxFeX/a5IlYGYUO/PBLl78hiYy6vXhSwbIAKi?=
 =?us-ascii?Q?pIiTab48pWr4NbB0Sq+FUWhHvWaIMMAhX1gjciJNOS2NpVKK8/CZAPowRgEP?=
 =?us-ascii?Q?Ipqe94XEV9Dd8iMXaKPPd3vnDzatB0isDlXlX5N16GWkA3SHPidMwIPwguGP?=
 =?us-ascii?Q?f3USArFLvTHFiNARuzpBMY/saNXFK5FOE67FBDclfB/N1hPQ1ujVNyPNgRf8?=
 =?us-ascii?Q?zdR/oxQEbKnEuGArGUvfaWV7ohtqDNQY7imzC36lJ9b/8EP3BduAyQxbutw1?=
 =?us-ascii?Q?tgZMDly2yfwvjUHgXqFpujmCRx9obYW07qPEVOdnEE2Pgs8Rw+pDvcANvNSq?=
 =?us-ascii?Q?gYHGqZO1vWZN6XWlJdsQ7r7aQymemI/aKr0IHma/o8+yxApa7N5uCf6F0zkI?=
 =?us-ascii?Q?zYbC4uKK1fc8sLQm4JaRA5LcPuWPfNJnA1dXg99I0y+y2VDXrwcUfNVS6Idz?=
 =?us-ascii?Q?xB5geMW15CcvBioQNAF4X3wgBB3yqlQN8MlRG8a16aRLibd/0jm3COA0cMiq?=
 =?us-ascii?Q?UwRCbLxb3OnnJDYZ2jKyrktpNKgoJ/qvtpJD2+YGDorPE+DKeS+4ZLoTJbTx?=
 =?us-ascii?Q?rEpuHrCaNnO9y9u1MCb5E3fRTATLVcVsV2iIhjU2cpj/uX8CCdvaGNfOaxpw?=
 =?us-ascii?Q?N5fzTTJnTxGsXhDnFTOoSyOg2pWJMKOx9eT5cfr9IScYN/vNshkOLNbtoVyv?=
 =?us-ascii?Q?GpaPszEsua3qxTgGmYkI6VrLwdzbBJ7jFt+xOwDZ5uSpefed3xNF7hjpwmsM?=
 =?us-ascii?Q?jU5vNoshPEbpXf2osrbKDeYvU4IXLcoH/PPvTIR/lKa16gYiwZop6TJnqaP6?=
 =?us-ascii?Q?oeFrQbtvvgjP7PEvRVMdSukDW+lNwRTwFqeDpLYCPKu0yLlwTQblpnHk2Yb5?=
 =?us-ascii?Q?kzWasyJau2DMeNlE1LZov5V87uPhWwJWLY3QBANe5tR8O+WBUblyNUAClc2I?=
 =?us-ascii?Q?ukDl7b/JOErt5rrLhO4qAqq1ndhm2Vi7e+UhQMweOckgSG8JgR1toHftmlOP?=
 =?us-ascii?Q?OEqb/CwMhkP8avnToQMQfVp6vZU8AI/ddh0hQsmPb8VuRUDHWxh06RJiEws2?=
 =?us-ascii?Q?dseufdE96AXm5zXNVYNmOrvAi5ZFeDAEGjX0/R61BZyUi2bizBwsSDL+AnLS?=
 =?us-ascii?Q?vH94LDQwvYAOnAqmwQjL/SI1k07B75+E/vI+IZBkXSPyl6z4hkhDJ+WhqnIG?=
 =?us-ascii?Q?VI+KG4nuE+2DpCQdU8ryKrUKKiuPmvzx3piSSrEKlnrCes+rQN8JgwkcHfdS?=
 =?us-ascii?Q?uJXTgZxoauS32VLCY4P9tfamQI3qX3O58iWcmQwIRMCy5ubjfjyU8yug3Le+?=
 =?us-ascii?Q?BoSQ1XEYTH7UKPXaT3fO+colfZW8cD6OmpCH5uyLSEzpqvuFfp+w3w9fi3XO?=
 =?us-ascii?Q?0vY0g9+53XIMhYI4s1iXQnCQbFvOZT2TaDbpIogIfQoq7A9OgU3V2/IQh8Kn?=
 =?us-ascii?Q?SUuDw2XZUrUApreCn0Zr/l7+qi81xj0uenpTiJ3TDwM+bEWIX+Xgq+9lx1gK?=
 =?us-ascii?Q?TsV79lBSJPO4xSUvJvYWNfW/oEmSoqoXDKnwvcDlDJXY9tsYoN8VZh3dgdOO?=
 =?us-ascii?Q?a0ZCRoFn3A=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144E85AAA1350161E0018FBF7F89BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a9583e-c75c-4cdf-af1f-08da27041c52
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 21:39:43.4567 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5FZUUmSLXBHIcpYrZxu/h4b7yzFH0RrnPwLrxZEi/+X1DXMAftLRUuYtUVV8yQ8D0Dy2uvscHYG+VzFrQH5Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144E85AAA1350161E0018FBF7F89BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Prike Li=
ang <Prike.Liang@amd.com>
Sent: Monday, April 25, 2022 2:52 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar=
@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Huang, Ray <Ray.Huang@amd.co=
m>
Subject: [PATCH] drm/amdgpu: keep mmhub clock gating being enabled during s=
2idle suspend

Without MMHUB clock gating being enabled then MMHUB will not disconnect
from DF and will result in DF C-state entry can't be accessed during S2idle
suspend, and eventually s0ix entry will be blocked.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index a455e59f41f4..20946bc7fc93 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1151,6 +1151,16 @@ static int gmc_v10_0_set_clockgating_state(void *han=
dle,
         int r;
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       /*
+        * The issue mmhub can't disconnect from DF with MMHUB clock gating=
 being disabled
+        * is a new problem observed at DF 3.0.3, however with the same sus=
pend sequence not
+        * seen any issue on the DF 3.0.2 series platform.
+        */
+       if (adev->in_s0ix && adev->ip_versions[DF_HWIP][0] > IP_VERSION(3, =
0, 2)) {
+               dev_dbg(adev->dev, "keep mmhub clock gating being enabled f=
or s0ix\n");
+               return 0;
+       }
+
         r =3D adev->mmhub.funcs->set_clockgating(adev, state);
         if (r)
                 return r;
--
2.25.1


--_000_BL1PR12MB5144E85AAA1350161E0018FBF7F89BL1PR12MB5144namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Prike Liang &lt;Prike.Liang@a=
md.com&gt;<br>
<b>Sent:</b> Monday, April 25, 2022 2:52 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Lazar, Lij=
o &lt;Lijo.Lazar@amd.com&gt;; Liang, Prike &lt;Prike.Liang@amd.com&gt;; Hua=
ng, Ray &lt;Ray.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: keep mmhub clock gating being enabled d=
uring s2idle suspend</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Without MMHUB clock gating being enabled then MMHU=
B will not disconnect<br>
from DF and will result in DF C-state entry can't be accessed during S2idle=
<br>
suspend, and eventually s0ix entry will be blocked.<br>
<br>
Signed-off-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 10 ++++++++++<br>
&nbsp;1 file changed, 10 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c<br>
index a455e59f41f4..20946bc7fc93 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
@@ -1151,6 +1151,16 @@ static int gmc_v10_0_set_clockgating_state(void *han=
dle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The issue mmhub can't disconn=
ect from DF with MMHUB clock gating being disabled<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * is a new problem observed at =
DF 3.0.3, however with the same suspend sequence not<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * seen any issue on the DF 3.0.=
2 series platform.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_s0ix &amp;&amp; adev-=
&gt;ip_versions[DF_HWIP][0] &gt; IP_VERSION(3, 0, 2)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;keep mmhub clock gating being enable=
d for s0ix\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;mmhub.funcs=
-&gt;set_clockgating(adev, state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144E85AAA1350161E0018FBF7F89BL1PR12MB5144namp_--
