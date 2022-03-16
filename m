Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E553EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 13:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69C2610E59F;
	Wed, 16 Mar 2022 13:22:55 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACCDB10E59F
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 13:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhzMNWw2k3cvYNImgEzYIc5M7C5YGSdG52Dv2hBAzrDpPn1BWS9+s2TSaunIdU8cKVtUcKWWki4qTkPEvPA5IPokVsrGujP30P8EPxc0spI9sOJYINVLiPKBiDBJ+U3abBjQI3tmETaP8eT8FPqHXb7aFwx/Zxuk9PowY76EsouzwthZuHu/W6j46ZGslnFqCnqV+Cm/E5U98cdHydBSeW4LzTDF/nW0O/hQ60GhEl1Ka2uxT2Ag572EunQQ5s8LRqfY/jX4skCjRhh1ldA1Pu0drTrDOd6iWyGsmS8SLuMkxdvWvDAo1GkmmCu1Bj3Acb7E5nY1Xky5q7ksUWXWrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reAvxrGQMW58Xm31o8f6k7TrKA/6X+RpyI3pT0YU4hY=;
 b=HYK48f06wBpOmQslfhE0omNxlA8IY4tOXG2rQbgHELOOyFNGnSlfRmw58Ypsuky4pq87fLBHXiFKETJHuXGGjJUa0NxRoBHjTHhLoSosB/6MXYsflkm7MvoBB9qNpKMAvx6mE7IgTOTcemODZ7LFWOaFNLe+EQTTyUaXKMvfQdqYxh5jvXjjJPGS11EBlUq0zJFUcbwfhsOQ1mXQwz+320CUVMzN5DBh8Ol6Vjpc4wDy+SDqfYRZ2JXeG8iuCjWcC/ztwZcHciU/DupiJhlvX6T4p981pQvHY/5atxA7GBC/qazDJA0caV6YRcDUGL6YhhRT8GEYd8VfaMyKxhU9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reAvxrGQMW58Xm31o8f6k7TrKA/6X+RpyI3pT0YU4hY=;
 b=0IfZ9E203oXhK94xEOsA/oFe07QsFieQoVPEzwqjW+Gp0QHz2KlKXmobrPAbjcv87gXpX//oATQ3rE3zJZb+muKkgeWf1U5LVEy6wZVZtrxeQtT0iytWN9IyvovEQUzyDDqVgYLoWK21Gc+Bo45uYWUZNTushwjWt3z1pvzJSm0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 13:22:52 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf%7]) with mapi id 15.20.5061.028; Wed, 16 Mar 2022
 13:22:52 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: drop redundant check of harvest info
Thread-Topic: [PATCH] drm/amdgpu: drop redundant check of harvest info
Thread-Index: AQHYOQKdrP/FcUmLl0KiF8IoBuMUpazB/8BR
Date: Wed, 16 Mar 2022 13:22:52 +0000
Message-ID: <BL1PR12MB51441FAC299111CF8C929333F7119@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220316065342.1141-1-guchun.chen@amd.com>
In-Reply-To: <20220316065342.1141-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-16T13:22:51.892Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: d2e86c0e-0c34-ee8d-2b13-01bcd0afbe8f
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82b92b23-cb12-42b5-8100-08da07501337
x-ms-traffictypediagnostic: BY5PR12MB4035:EE_
x-microsoft-antispam-prvs: <BY5PR12MB4035A1C8BCB2174257484A2DF7119@BY5PR12MB4035.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yQ+bzsjg+dgG3K+7pe283d5imSSePr2GgeJSC4wRHq5d98HbCIzXSKaud1/Htu2m3eee87Yjl4+E0xVlQo280YFfMFD8aIl0xT8XhOrE+sH1ZcNWv33xMsG8uZ0GK403poUZMtOifIJsvhjgT+owsHNcJy5qtjSFTxZNoQtWpkJJHJyTgk/ud6VPcBxr6wzdVaFCwztdfRrE6M9GmCUXSfmCS2ZKKZ3fe3rwCQXI1UKiNxKqd+NXjG1BwbnKrWn/Qcxb0ay4vZY1sW7KomeICUcrvvurMBCjkcihv5MddP3vIl2wFaOlP+piR6oQMY4k/lBR35yRhiAYCjA5e/qo/9UBkRAeXMLDsu85BIZ2VbyswrTewziVPQ/Eks33oIaMfdbJVO1FI2Zke7ioqTKUKwl6rQBJeNXo+KMe+J54Wer71q+CA21aNmC51d5Zs6DJd9Hcmg3o10zfZNssGyCbegviZvhaw72wARYLeWSNQhZDasbK5FXACNcKbf6rcvpGZ+CdY7Z3eDiMxjIJKEoBtjD03vrUTedZ3SHcmV0u6u7yu/i+m6YtqwFTCwC4VU45FmY11l8uhSadu0zkiNhSW9x/6eJnvcbJ6U/DY8OaPceyQZk5ogomiCjQRAl/eWdPGNWtPsLhbvHrmQBxLRh1KZzqyN0ZKhSQX4yTvtyXWLJUqPYm0rJfTXUQgsGVjhyVRDE7A4R76R9U3k2DUABKJg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(38070700005)(2906002)(7696005)(6506007)(38100700002)(122000001)(83380400001)(8936002)(5660300002)(508600001)(86362001)(52536014)(66476007)(66946007)(66556008)(66446008)(76116006)(64756008)(8676002)(71200400001)(9686003)(26005)(186003)(33656002)(55016003)(316002)(19627405001)(6636002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KL4OA8AmNZmPPkW0Q9ax2gpTXNc/seXihgWb7hi51yl9CN+v4k6LFVp6ZZPc?=
 =?us-ascii?Q?0ErH0L+bsJpwwOxTSBOx3Txp3DwwZHVPANWNqOkdcVc0gPyrq/5Bxn5rooyf?=
 =?us-ascii?Q?8imbsqwYD/OKCaqvjiqhgAjXkpD9/SnNsAuh/o3t+b7hOhraqY30JzujhDoD?=
 =?us-ascii?Q?ensN9u7ex+1BbWq6nBzj6Y10l17nMhm3nEfF1EzdykVKjAvCmKtTGfmhb+gN?=
 =?us-ascii?Q?psBwI8/8K01ywrtplJkzYFChXDeFz4VoQZoGIFF3jKSprY/7sfp2Ku0QOIZM?=
 =?us-ascii?Q?/aqGjQV7XtxTjoxxLxW2imzHudtFuKeCdGWxsOmC16l8JF5dvGhSEGWJfNEx?=
 =?us-ascii?Q?n5496o4ut3CLqWJ5PEPsaHtgPR6w8/iLcUfaNfGT9hucGuZbgjzYHI0kFk7J?=
 =?us-ascii?Q?dY3VKcZvZDZdhOOaYFZ33MdlPQIdDgY1jYAwNfMqIAVN0aU7e9v6F4gt0DAT?=
 =?us-ascii?Q?/J6FQp1NVDJEPjTRcGG2qa31RANuEmrm5aQuwxMoq/qnEuzKaEuCtK8E/4xM?=
 =?us-ascii?Q?vEDmZ/ZULWV7a3W7hP580JS2FgjZlofpwVg0ztEkWANWA/oxEn9PvbC2yr18?=
 =?us-ascii?Q?319EABFcQvDyiqEq7BN7JSI7+WFFmAirz38f0bMfSc/lgMWm3qDNXwApR0wL?=
 =?us-ascii?Q?8Ps/P5i+3QHNfBGReXmp3gCs3/649DwjUFFGUgSeSrUZ5108xzeIjideCvkP?=
 =?us-ascii?Q?NzwGCM+zizH0x5Tl1tjcRbdt+J4Jqv8UXkdrsEkqJKvvdY5GMQW3ohVCHIHK?=
 =?us-ascii?Q?CiKhQYlAAzMo3aUCz/goWxUG494WyoPhpt1NFcZPktx2ZmG3tkxtE89Zi9Uy?=
 =?us-ascii?Q?dIgdABiDvpl5qg0+n2W/z7ZC/JI5Qzk0Aqg5K2f153WvRx43mSj3sz3CaqV3?=
 =?us-ascii?Q?s0y1gbl073QpJTJ39UEAvndga0cbEmibKwYeZ882Ak0LOGyMAKWkSK230FqO?=
 =?us-ascii?Q?NGyGM8tOlX1QsvWqJbvEY4FTSyA6qYDrIl1URgsNuNL6nUAbHGZPbaI2W/UE?=
 =?us-ascii?Q?9efvnxdkIjHFUGsjQN4H05myuAo3osoAIb73Uyhag5LSagJyWDKfB4/BkTs+?=
 =?us-ascii?Q?SbnKlICXpOMRg7SuP5aTCovoHwgANlRscM7NTX/PEzHhYNmtNmmJ34xnMTkG?=
 =?us-ascii?Q?WK1uBiboQPvi1hLgoi3icGOmQqgBEmzdln8kItpeYzlmPcSNXb3Mg1ruFBh+?=
 =?us-ascii?Q?VeCruDtaTZq9ZWCZwCiqjoA+EojgDALjU0wlI2ktyUwA6a7cFldVjhj6bO58?=
 =?us-ascii?Q?TPYnWNKml4CPubxI7cE1SPBQDetlMosYedRiXM6HFarndOhkmOu9Thc/t7bs?=
 =?us-ascii?Q?yPp49BiQrH5qdJ5GPcNdC/Sly9c0ds71UAlt/xfbpemiJfDnxkQc3jqbORni?=
 =?us-ascii?Q?G473OYU6xi8pmAraqJB/MvuioSabtFpiGp/xMKlhOwis7QgCVTI8nvWvWrsg?=
 =?us-ascii?Q?0b0+7tRSgenR2AqTmvEaqO/rR+joIbeI?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51441FAC299111CF8C929333F7119BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b92b23-cb12-42b5-8100-08da07501337
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 13:22:52.5017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FWA6Vx/1wEj03ft9WuauOVXubyLkDUqNc3Iv2b5b4hkhmW2nZwAg653SkfI1QW2K3Y+KMxo+zq0k8eOxwQHKHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
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

--_000_BL1PR12MB51441FAC299111CF8C929333F7119BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Wednesday, March 16, 2022 2:53 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Zhang, H=
awking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com=
>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander <Alexander.Deucher@=
amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: drop redundant check of harvest info

Harvest bit setting in IP data structure promises this,
so no need to set it explicitly.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index e4fcbb385a62..5a182288391b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1150,13 +1150,6 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_devic=
e *adev)
                 adev->harvest_ip_mask |=3D AMD_HARVEST_IP_VCN_MASK;
                 adev->harvest_ip_mask |=3D AMD_HARVEST_IP_JPEG_MASK;
         }
-       if ((adev->pdev->device =3D=3D 0x731E &&
-            (adev->pdev->revision =3D=3D 0xC6 || adev->pdev->revision =3D=
=3D 0xC7)) ||
-           (adev->pdev->device =3D=3D 0x7340 && adev->pdev->revision =3D=
=3D 0xC9)  ||
-           (adev->pdev->device =3D=3D 0x7360 && adev->pdev->revision =3D=
=3D 0xC7)) {
-               adev->harvest_ip_mask |=3D AMD_HARVEST_IP_VCN_MASK;
-               adev->harvest_ip_mask |=3D AMD_HARVEST_IP_JPEG_MASK;
-       }
 }

 union gc_info {
--
2.17.1


--_000_BL1PR12MB51441FAC299111CF8C929333F7119BL1PR12MB5144namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Wednesday, March 16, 2022 2:53 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Koenig, Christian &lt;Ch=
ristian.Koenig@amd.com&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;; Deucher=
, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: drop redundant check of harvest info</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Harvest bit setting in IP data structure promises =
this,<br>
so no need to set it explicitly.<br>
<br>
Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 7 -------<br>
&nbsp;1 file changed, 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index e4fcbb385a62..5a182288391b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -1150,13 +1150,6 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;harvest_ip_mask |=3D AMD_HARVEST_IP_VCN_MASK=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;harvest_ip_mask |=3D AMD_HARVEST_IP_JPEG_MAS=
K;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;pdev-&gt;device =3D=3D =
0x731E &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&=
gt;pdev-&gt;revision =3D=3D 0xC6 || adev-&gt;pdev-&gt;revision =3D=3D 0xC7)=
) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pde=
v-&gt;device =3D=3D 0x7340 &amp;&amp; adev-&gt;pdev-&gt;revision =3D=3D 0xC=
9)&nbsp; ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pde=
v-&gt;device =3D=3D 0x7360 &amp;&amp; adev-&gt;pdev-&gt;revision =3D=3D 0xC=
7)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;harvest_ip_mask |=3D AMD_HARVEST_IP_VCN_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;harvest_ip_mask |=3D AMD_HARVEST_IP_JPEG_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;union gc_info {<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51441FAC299111CF8C929333F7119BL1PR12MB5144namp_--
