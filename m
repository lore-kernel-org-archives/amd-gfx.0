Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73855C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 15:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8A5110E701;
	Mon, 13 Dec 2021 15:06:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5EEE10E701
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 15:06:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRtA6hD0BNxeO5c+JjbsR0eP5QTktKRxBIrKy9fVs/tKSW8YY+vs3L9T1PA/eDNZ8DGv1eXrZqJaPlrSmRf/ojUWgMEKl5R+stUqJIB0xrysIz9Viixnyqbop6W7yjxphPUVYIzCZbK4NYJ8xEmNbwnRsMn3IZhPcNyE+bvV7lFLBuK+vArIx6VBeHjv0NeRk14zW8UqXhfRQu0EAk0XuQfeHQl6vYJkgEu6vJXyjXUlpuUdy9ni9lL1Aao/Bw1hzyLEiU3kqZD9MoPJTbfjphjWakIDiSZHWo1q0cLDgJIY9HoiFrmWmpiaYBRh9Sgbotb6TucV85Wny0JaZbJC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heJ++oTSPaZ4iebBa6z/tj5PI2bnwBcAlg2BXsJ3Pxo=;
 b=mZUAOjIuvk52PicZ0ezQfUCpJfDJ/S1Ie+NRKZ0//wJ7Y4YL5YMJ3I8OorPV61QAnNM/qrJCrKbokPjpQNJhyHdM1M7QE8vomjOzamTMBXhsJy2puVr31Wt39iTajC92Ln1n87YiA8BYzvpsst1+LhhUYww9VUsXu8PO9+vOdSe+UK/mcUzeCOs52GwUHPSPS5w0D7l/GQiNSvSOFMJ0sAzrUxBDNSrFNSqP6lOTErCPJ8VVtOKzM1wvIaKF224RRANfXqoeOi6KEfux3AGtsf7tT7qLohS6dVKwTAW4EudlomOUuP+LWgT7H/Qoza2uoqO9S1jdxPZoESZYTb1C1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heJ++oTSPaZ4iebBa6z/tj5PI2bnwBcAlg2BXsJ3Pxo=;
 b=SkrmX9fgcJjjDIEYfI/n3ZU57/K3aZJhL+Z+0b9yIFA3Hpewr+jODYgTl4feTH1VruotlsL8O00V1xvpAJyju3iWWueEr/w3A6otM38yg2E2RUmqYTVdGqxlCqKyIluVO5d+oEz7h01/WnhhS96dsdjeuROcpoF+De9Uwyua/3k=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Mon, 13 Dec
 2021 15:06:47 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65%6]) with mapi id 15.20.4778.016; Mon, 13 Dec 2021
 15:06:47 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Yu, Lang"
 <Lang.Yu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: use adev_to_drm to get drm_device pointer
Thread-Topic: [PATCH] drm/amdgpu: use adev_to_drm to get drm_device pointer
Thread-Index: AQHX79cxwxLckAP5S0CUUjU+Aq+FDKwwhlfM
Date: Mon, 13 Dec 2021 15:06:46 +0000
Message-ID: <BL1PR12MB5144A6BB1B30936364E27032F7749@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211213040856.2059-1-guchun.chen@amd.com>
In-Reply-To: <20211213040856.2059-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-13T15:06:46.364Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: f069145e-e7f6-1b4d-f039-3d7c2f3c6ce5
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45307fad-3d28-4efd-f800-08d9be4a2ed0
x-ms-traffictypediagnostic: BL1PR12MB5142:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5142093DAD40C88AB5C56399F7749@BL1PR12MB5142.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OTlPC6Ch1szJrMUnIvuNdFKxxsmlgv/UzC3gqIYCPu5eA8wT4DejCMqd8d2adlMyGDm8Cw+M/JItsm6MSF9VDK4otZIoSrSxE+uwcbIFowJCDAcvqyc+E40xnBKAlaVZeuiiMEQ1iIHmETjF9JThTMgkmiq0ZQx9r3puaeP+K6m6Ist4SK7scSZAvP88v9whaTT3nUiI6MotsO5Y/iEKPrbqusfzIAZXQkWCrRYWIIIQci3qdyBspC0tjSpRXYbjVOA4LpVOCMj0hfI9Ig3VGcCnE1Hi7kbU2yIshO+YTU+f049503FvlOTjC7jDC3ggFjJDIrgk5nC42oNM04JUFwcCjorNbRSSZuFkTHLtZW1T6hEPIuaoQHeYpQGHnx5hfzSY4LnvGyRJYr0iig9Dk+DxVdiKyA3IU6LtBlLIqDtpv5xQtARjCgBSorf3z+UO8Re+uKJy5RCyghs6RXhn2UsspjUr1Oi18AuAyH99xWOAElnnG4C7NuCD/9F2+FwH58NzvHEsUk0e55H+u5kB/Z2nNjGcTYt6d5daNbZK/jkKu64yk3I20vFJ0VP+ctQ0SzU0ISb5EZFBM35WiG+TdqVWToqYkmhv/794hJGG71elUI3vWdW1X0DA2AMiEbeCzxJXu3EbOY8K90LB9xGAMZD/tFl4F8mK74rcDDEKd1KD2IEo6ojoD/SX6ePugLOVSynYEotOjKQQviQXBauOnw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(19627405001)(38100700002)(38070700005)(66556008)(2906002)(8676002)(8936002)(7696005)(66946007)(76116006)(64756008)(26005)(55016003)(6636002)(66446008)(508600001)(66476007)(53546011)(71200400001)(316002)(33656002)(9686003)(86362001)(6506007)(52536014)(122000001)(83380400001)(186003)(110136005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dKJ/eZuNjTorzxZWIJifpWaAc713JkiB8nmAdO7i4QMynH2IJ3EkuX7/EZ8N?=
 =?us-ascii?Q?oWmtBOG41+IqNa+vLc9wQqXDT9d6of6Gzga9NVDDhDPHb30Ntlgo60tzM/cM?=
 =?us-ascii?Q?67Nc77saTkQDF14Ll5Qk+AbjT3roQ06jn/Z0/mLobcpB+6fdrEAlwzVP3J1Y?=
 =?us-ascii?Q?V5YMFdRg3brvrob1j7VpxeZ+P+EPFoCsNzaZhRfexJuHcYqsas6+b21Wq+0S?=
 =?us-ascii?Q?XjB2AyCEapIMwLAEwGd5mw5mvocXdsQGl0d+k0fvSFUrQkTpmmjIyCujq4vY?=
 =?us-ascii?Q?bwjSvsmZyuZVgKD8LXsdduxQkyT3Jpw0e++58+OKLHth7k1bn2Xf0o/yNEv5?=
 =?us-ascii?Q?Z+sC3u0o99ZJ0wlx04OEois3cS/gUsJr5c5ivhp+qmXY+LTrSi27Xx7WbeEI?=
 =?us-ascii?Q?j5VW9RI/Iq2p6Ezc841xSsHp36RwNKIfTUFI+nsBgVVIj4NRwuqwT7806It0?=
 =?us-ascii?Q?WrGhXjWwoZSPPXngzhlYQ1bD5EP0PSXR8Xm0KNtCLjX9LaVG9zuIS+VpFpTZ?=
 =?us-ascii?Q?rW4BRPnEB3kQ6+Aa6UVwNgG+DZ6NiDbnvf8SlEEDnAy6bZXwOMKw8ixrPqrr?=
 =?us-ascii?Q?452Fb/hP1/UHp6JY3HrShsgef3HufVyLYVc343aNyMaOmPnx8/+8ABdu8wog?=
 =?us-ascii?Q?Bupx3mIi+XKBta4pSHQgYZ4TYmYosLHrQyYWkh7ApAd2jdNYUJqddbViyoLA?=
 =?us-ascii?Q?GhA8/H0SLf4xzTZdkUGfDm6Q+tOjd8VhSTAuQux8rLioT/D7j5dAtKaLg1Z2?=
 =?us-ascii?Q?x1uLFD0+0hjzV9tFlfDFwAL5W8GzEm4qEhVTacLoJppTorATdEYtvQtQnix1?=
 =?us-ascii?Q?3Tr+iPBneUDogI24g7CTKZjUvqo+gUsBuESX+tuvjAX7ylZ6CB1n+drAqj7d?=
 =?us-ascii?Q?8dcQFvRJ+wQ1iwfrJ45CsxjLlMhTCf/sCZLpkl8dr8CZVoqAqPQxubgakFJf?=
 =?us-ascii?Q?SebPsRm9EMBpGa28aetIc48c3ZOwypxVUipRKlnOdTacuYcsGuxE2UMM3X01?=
 =?us-ascii?Q?6KWreSzIF5WDLVKQ3uI00ZifPcwuKxy+GvdUvSh4EQBgpMckLyKoRC8m7MNO?=
 =?us-ascii?Q?RpXZcrKyB0J0U0W4Og38XX4+OuTFHuc1/UCTvzkWAZ7jwjsSyxoXhvxInp4w?=
 =?us-ascii?Q?5JW1B5PQoyc+5PbOEMptbzinlbpym2AwqUA3EgkQYGtqYoxV8jxUOBSl6sYi?=
 =?us-ascii?Q?95/uiuYRCsBJfTuAtVuyU4Xzskqnn4m61/7YohT1+Z8WnU7puccNOhU2UBLZ?=
 =?us-ascii?Q?LHwqDkq71GBh+xjmkJXwwRSyEgoO39VOAJOU35lmuWVaVNDIsWCKUyyqgX5t?=
 =?us-ascii?Q?sKwoq8p1vPJcEeYt0YzwgDxTH2ZPAXoyM43cKKBwrCVuWeUIluPF+Q07/DdC?=
 =?us-ascii?Q?OveCGlOVNAf13xLP64Mj0efj/q4dge06IfxvkvkoBmV7gumX0QVtr+GMQMe8?=
 =?us-ascii?Q?jh/mAf2vUIEzIGKQsJMxFhvz1++oRFFSo2B+28DgENG3ZXeEjwZ40RQ3dsn2?=
 =?us-ascii?Q?fMRXLCcRzyHI1apv1KXAb1nUn1uIwCPAoDGNN7aqfVAkymjcXqxLcqvZDDpU?=
 =?us-ascii?Q?56RqTSjoYdpuSFQshEg9spFTmVv7A6qRJPypn8NJiHbVirHEFRk6GqpaqOa7?=
 =?us-ascii?Q?gw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144A6BB1B30936364E27032F7749BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45307fad-3d28-4efd-f800-08d9be4a2ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 15:06:46.9271 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c7ajOrDWyJpk40pqViUkwVxI7oUEMp2s+d5JtFz/ki1cSoaa8DqfjMboy3Wh+73PCnqx2Bl6H0LxtMpLNFM3GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
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

--_000_BL1PR12MB5144A6BB1B30936364E27032F7749BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Sunday, December 12, 2021 11:08 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig=
@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Yu, Lang <Lang.Yu@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: use adev_to_drm to get drm_device pointer

Updated for consistency when accessing drm_device from amdgpu driver.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 48aeca3b8f16..b2c3892e8e7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5705,7 +5705,7 @@ void amdgpu_device_invalidate_hdp(struct amdgpu_devic=
e *adev,
 void amdgpu_device_halt(struct amdgpu_device *adev)
 {
         struct pci_dev *pdev =3D adev->pdev;
-       struct drm_device *ddev =3D &adev->ddev;
+       struct drm_device *ddev =3D adev_to_drm(adev);

         drm_dev_unplug(ddev);

--
2.17.1


--_000_BL1PR12MB5144A6BB1B30936364E27032F7749BL1PR12MB5144namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Sunday, December 12, 2021 11:08 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Christia=
n &lt;Christian.Koenig@amd.com&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;;=
 Yu, Lang &lt;Lang.Yu@amd.com&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: use adev_to_drm to get drm_device point=
er</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Updated for consistency when accessing drm_device =
from amdgpu driver.<br>
<br>
Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 48aeca3b8f16..b2c3892e8e7f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -5705,7 +5705,7 @@ void amdgpu_device_invalidate_hdp(struct amdgpu_devic=
e *adev,<br>
&nbsp;void amdgpu_device_halt(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev *pdev =3D a=
dev-&gt;pdev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D &amp;adev=
-&gt;ddev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D adev_to_d=
rm(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dev_unplug(ddev);<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144A6BB1B30936364E27032F7749BL1PR12MB5144namp_--
