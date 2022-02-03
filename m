Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43324C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Feb 2022 22:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADF3510ED4C;
	Thu,  3 Feb 2022 22:18:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 798F310ED4B
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Feb 2022 22:18:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WThCQJVEbQcWsRYK2NdPUROZwfnbR8m9+fCTMwoNA5acYlo2OSY45bJdwXCql8Fo5ZxL8Q+iv+aGAsMAEX3kE3t2qgsJgLYmbBUGuv7OMNjIdwmPYEIRKtQtUvK3nDQ+aDWKDau0BhGI84FZnuqs+v14jW/Zm+H8AfhqGeN+zDuharQhvBHdRShxGxlStmj9+ECdx3yZ4aoJTSSS96kLIvmmfxvsJHcPWc7FQ89NN9QKsFaSc9vQe5+kstBhU+m8CJe+RGHGb6l/EEQw+HeAB6bkAhQmZir6Jpf/OJ+SrM9CwsIAkGYepVizSFhG1w5MCoQqzp/fB3Y9QIH5FA5Otw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1OYyb3TJVeFGCQpf9Ur4AFFsph+FLv/HAqDh707VUQ=;
 b=nZQQIkgiKDTaCZqFT41+ujoX6kmMpIWsaYZjcyxNOGjMGj+gt/QV7SSvACxuZI4z5XBxb3bvNoUnaGOIGO9YJ79HCyhtRSJfLJuPCI7z5nUJRV5wWz9HXR1bMA3BG9zhxp5BIGEFIZCikoWcFS8YKIdDSXNWaGJ19HFJqxMrv3lXjWg34VJyMA/6A5z7CIeyLqEumTy3geRSpem+4GOfEm6zrbBle6FGYmV3BpYx36WnA/+VdDBD6WUgAC5fC5BrIR741xwjfTOyxF6bOhzdJgtNmP2iywrqydPhca+wOXYhesGL6CERHiWpbtpzJ4X0Thi//3nEVZBACCD4Q0p4Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1OYyb3TJVeFGCQpf9Ur4AFFsph+FLv/HAqDh707VUQ=;
 b=AN9t2WaBRvYwBFmBr+nJuLqZfro4gdPRzQLOnK46ke911rNMqfAEdYLMQ6UEHb1UKos9aVZIJa2kQQkBlHBiyrGgeWJGI+8fXUUPC3P5R5casgpz8Xoji02z8O1MlTDw+9g2hP235QcBj9JOnQWtO5DBDii42RKb+u1gKPctuJc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BY5PR12MB3921.namprd12.prod.outlook.com (2603:10b6:a03:1a2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 22:18:28 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%5]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 22:18:28 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Print once if RAS unsupported
Thread-Topic: [PATCH] drm/amdgpu: Print once if RAS unsupported
Thread-Index: AQHYGUtxanvHuI7ZRE+3AHY7u9Dq2KyCZSis
Date: Thu, 3 Feb 2022 22:18:28 +0000
Message-ID: <BL1PR12MB5144C64B0B4E525FC97EB522F7289@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220203221421.93557-1-luben.tuikov@amd.com>
In-Reply-To: <20220203221421.93557-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-03T22:18:28.261Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 86c0983f-7850-b702-7cc2-5823291f2392
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16dc411d-e7cf-43e5-7857-08d9e7631ae7
x-ms-traffictypediagnostic: BY5PR12MB3921:EE_
x-microsoft-antispam-prvs: <BY5PR12MB39215CAF06548351BE56D976F7289@BY5PR12MB3921.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:98;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OW1+jZFGBq7KV9csfT6kw5LPkb+Ts0HDYE/6cMoEReT5ng9xlQDg/aX2/3ex3fL2MBENYdT8RYV866Pa/+KvA0uEi9oV4TR6mOIPbKoW/HfxYhOJFpEv3LwqVWNE0oLXLHrKcKTu7/HzLSBo8TKMFG6PVuN8uh0+0JhuB7zhD2Yh4GxrvpS3MgM/ulIrHm5FrFSkJIjj1ZBlzROS+xVBYTXrGdpTJsnpqAgpS+IictS0hmNr72jWFezSt7B9pJVD9uFANVcyjHS0avsE23YS7V5Dd33hrLeeJVeT2+KovdPuS3+zZ/TwC3nPO/XVGhjgiDjtUl4W51p9cIlYrsbMUSGOA3Cfhvje5rQQWitekp+CvjsvOihznU5l8ef9/FqbtQVaAR0aa0l5jFw9lNafT1qzm0Gsg4y6Q7ovQkdV+UEBd1zZ6VErxXDmKUdfiuk7hme4vE3BsBlMqXuArLwJ+9p/ieRJOTrLOHDDaAAWWkek24VjUYV9zIggXR+83WHKwLO4/yuymcfrMXYPWLmf2hwTy4NndTfG1zcBg2E9TsgC587UH82rZfdRfqlYpifzsrVhcFyy5yJuIHLhDKQA7WhDk+FgjRMFZJo10Llu5TqNpxRSS0vO8/HSJFmQndoB78jtawQsI1WlkvjrRe7triLerqqCI9xNAR9VUFqeUJZj3wBhkcMs7ITguWvs9pbn7KMMlZAw4ZrinW7GIXhSsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(7696005)(9686003)(53546011)(186003)(26005)(83380400001)(55016003)(54906003)(71200400001)(110136005)(52536014)(8936002)(33656002)(122000001)(86362001)(4326008)(316002)(38100700002)(38070700005)(2906002)(5660300002)(508600001)(19627405001)(66446008)(66476007)(64756008)(66946007)(76116006)(8676002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FX4jQF3EwAba4nasB5Z6XdRs0E0INrRp/1teGa/BmX/LVtGoMy/g1ZrjrthW?=
 =?us-ascii?Q?G+8pdb/pZs5X884VqHb1mx3T2FwRVZQHhXx9E7i3CH+GUAlJBR4JvSKkEh4A?=
 =?us-ascii?Q?hXc2Z/qD2UvhUUZF6eegTNyrGF5awoL3gdLWfsgc8Co1MEune9G2ebrdyCM2?=
 =?us-ascii?Q?lba05pUuD9pBHqpVLQvP90FWAuycLtegofMJV4NsPRrrttssAoCq7jUJBwWu?=
 =?us-ascii?Q?389BUqZOK1BqVKWkOAs0ynjsg7zUbHgUPqdLckc9odtB03YeYSCD1riLPWe2?=
 =?us-ascii?Q?wVhxko+6m9HIjlQwMQe50YvS8nz5XLA+O637ZCCguV/c6KfNWDswTDBIwBjJ?=
 =?us-ascii?Q?k7Kz/HLnCozz6HnrHYR67auQ8WqY6U5mHXWDUY/2Uh6PpRL28xGeNFK1JYfj?=
 =?us-ascii?Q?11ZwTdqKlj6ZbeHNgdN5w5fafLhFmA+jMF9g6qmfiK2njC2AVMc5EYHygSHB?=
 =?us-ascii?Q?bLzWicDJHhgh6PrytglW3PztXStt+o5HVzu8iwHCOLbLL2z67Yfw3shN+Kcg?=
 =?us-ascii?Q?WlZ8VpCefwFsHIEoO9wjqa8a5SCEmKwz+sjTo/0udLkrI5x1faDffLE0Z7H3?=
 =?us-ascii?Q?KUWvKNq3NI3xQzj4pTcDNVIq8UBL9DNlnpCjAw4lCGZk1iqZRZwDfkEI5525?=
 =?us-ascii?Q?HHjH44K5AUVYd3QFwXVsYXdsdwr9Q6h42eF+VCicikR8prYvfV+50TwGUdFw?=
 =?us-ascii?Q?KXRrhixTe1Vd6oFDIyjzo/AePYPrRde8ixDiVzgcTeh8O2e98PqF+ydcUvAd?=
 =?us-ascii?Q?0HItQrFZIXDNnecXN5ig6ncB6i7PGNWzwf00b2NvNz4POGfPgT+t1uMd6TpF?=
 =?us-ascii?Q?6SK1mW8ioyXTSS/KAYPjGaRdLNpwAo0P5jtThDcdStQ7zQo/dUyfVy2X3Yty?=
 =?us-ascii?Q?kLhzM4oHYpT0hOPAPzJiEMy/Gq/y6BRQbEel8BGAUqVURTzOfCEXktar/1Ni?=
 =?us-ascii?Q?5iEIdmTiSohTzH1gM4+u+hCsDLXXkHcAykngKLiiVDKB0x7Z0Bao7sFuWR+B?=
 =?us-ascii?Q?VBBWszk5DVjVJMNFox+M5NKR8pyiIjNN3n9p2iERma7XzuxRSZxTmvMIHoUJ?=
 =?us-ascii?Q?nu0FpvlbmDKAcM3e9hlgj61q/076A4jhCSlpE78CYWSiyNxUpU758686i1/s?=
 =?us-ascii?Q?PcxsVauGBeNRuqatyopz86dFPdVfFTy6UqDtc2nvwoAHJJQJYAHCbtRORVqC?=
 =?us-ascii?Q?V5n1PxoIo9qYPjMNvu2dgl1tX20b4ov36oliiH0S1DMnyfVIEK/qvrIcBiBJ?=
 =?us-ascii?Q?q1PbfGugFMMoIheqORpY9jdyp49PwHmtuRhzrdCt1UgtbA9qMTFSxjiCgAip?=
 =?us-ascii?Q?UvhjOYj1S91xPmbtcFI4tLBdkIPcOO56MMI5TUki9NA5ALo6Ir5UvRefmrqI?=
 =?us-ascii?Q?IjXaqoNuywgAeTFqG+3BMcS8pfpSPr0n9sbm0cLPc9vWdmci2GxUBRFHeVpe?=
 =?us-ascii?Q?RyTx6KsVdHFsW2VS99g09FnIOXK/En2DgAYyTuZ4NaEfUpQ6MyNthb2/t3MQ?=
 =?us-ascii?Q?U6Atye0V/9ODyRQ8St+xNl0DyLth2y5epCxwEHPty3ALRfIY3T8BrN2Y++oI?=
 =?us-ascii?Q?/Foq+dK/0knikF6GDVe7zKW0YxesjPz2adUO81CSiKGlPkHYEEUWsRtixm5E?=
 =?us-ascii?Q?F7+xral4dYBil7OP9slyHh8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144C64B0B4E525FC97EB522F7289BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16dc411d-e7cf-43e5-7857-08d9e7631ae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 22:18:28.7228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YnXc+RfAzCV1iy/KvyiUICC81Kvxdf0az9nNfTuEtIGFbO6canv3IkCYiFzSdVb9RTAxu1UK1bSaOpt1cF4Egw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3921
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144C64B0B4E525FC97EB522F7289BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

We can probably just make these dev_dbg().  The vast majority of cards are =
non-RAS.  No need to print this at all in most cases.

Alex

________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Thursday, February 3, 2022 5:14 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John=
.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Ch=
ai@amd.com>
Subject: [PATCH] drm/amdgpu: Print once if RAS unsupported

MESA polls for errors every 2-3 seconds. Printing with dev_info() causes
the dmesg log to fill up with the same message, e.g,

[18028.206676] amdgpu 0000:0b:00.0: amdgpu: df doesn't config ras function.

Make it dev_info_once(), as it isn't something correctible during boot, so
printing just once is sufficient. Also sanitize the message.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: yipechai <YiPeng.Chai@amd.com>
Fixes: e93ea3d0cf434b ("drm/amdgpu: Modify gfx block to fit for the unified=
 ras block data and ops")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 9d7c778c1a2d8e..cddbfbb1d6447a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -952,8 +952,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_device =
*adev,
         } else {
                 block_obj =3D amdgpu_ras_get_ras_block(adev, info->head.bl=
ock, 0);
                 if (!block_obj || !block_obj->hw_ops)   {
-                       dev_info(adev->dev, "%s doesn't config ras function=
.\n",
-                                       get_ras_block_str(&info->head));
+                       dev_info_once(adev->dev, "%s doesn't config RAS fun=
ction\n",
+                                     get_ras_block_str(&info->head));
                         return -EINVAL;
                 }

@@ -1028,8 +1028,8 @@ int amdgpu_ras_reset_error_status(struct amdgpu_devic=
e *adev,
                 return -EINVAL;

         if (!block_obj || !block_obj->hw_ops)   {
-               dev_info(adev->dev, "%s doesn't config ras function.\n",
-                               ras_block_str(block));
+               dev_info_once(adev->dev, "%s doesn't config RAS function\n"=
,
+                             ras_block_str(block));
                 return -EINVAL;
         }

@@ -1066,8 +1066,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device *ade=
v,
                 return -EINVAL;

         if (!block_obj || !block_obj->hw_ops)   {
-               dev_info(adev->dev, "%s doesn't config ras function.\n",
-                                       get_ras_block_str(&info->head));
+               dev_info_once(adev->dev, "%s doesn't config RAS function\n"=
,
+                             get_ras_block_str(&info->head));
                 return -EINVAL;
         }

@@ -1717,8 +1717,8 @@ static void amdgpu_ras_error_status_query(struct amdg=
pu_device *adev,
                                         info->head.sub_block_index);

         if (!block_obj || !block_obj->hw_ops) {
-               dev_info(adev->dev, "%s doesn't config ras function.\n",
-                       get_ras_block_str(&info->head));
+               dev_info_once(adev->dev, "%s doesn't config RAS function\n"=
,
+                             get_ras_block_str(&info->head));
                 return;
         }


base-commit: cf33ae90884f254d683436fc2538b99dc4932447
--
2.35.0.3.gb23dac905b


--_000_BL1PR12MB5144C64B0B4E525FC97EB522F7289BL1PR12MB5144namp_
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
We can probably just make these dev_dbg().&nbsp; The vast majority of cards=
 are non-RAS.&nbsp; No need to print this at all in most cases.</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Thursday, February 3, 2022 5:14 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&=
gt;; Clements, John &lt;John.Clements@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1=
@amd.com&gt;; Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Print once if RAS unsupported</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">MESA polls for errors every 2-3 seconds. Printing =
with dev_info() causes<br>
the dmesg log to fill up with the same message, e.g,<br>
<br>
[18028.206676] amdgpu 0000:0b:00.0: amdgpu: df doesn't config ras function.=
<br>
<br>
Make it dev_info_once(), as it isn't something correctible during boot, so<=
br>
printing just once is sufficient. Also sanitize the message.<br>
<br>
Cc: Alex Deucher &lt;Alexander.Deucher@amd.com&gt;<br>
Cc: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
Cc: John Clements &lt;john.clements@amd.com&gt;<br>
Cc: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
Cc: yipechai &lt;YiPeng.Chai@amd.com&gt;<br>
Fixes: e93ea3d0cf434b (&quot;drm/amdgpu: Modify gfx block to fit for the un=
ified ras block data and ops&quot;)<br>
Signed-off-by: Luben Tuikov &lt;luben.tuikov@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++--------<br>
&nbsp;1 file changed, 8 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index 9d7c778c1a2d8e..cddbfbb1d6447a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -952,8 +952,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; block_obj =3D amdgpu_ras_get_ras_block(adev, info-&gt=
;head.block, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!block_obj || !block_obj-&gt;hw_ops)&nbsp;&nbsp; =
{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&g=
t;dev, &quot;%s doesn't config ras function.\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; get_ras_block_str(&amp;info-&gt;head));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info_once(ad=
ev-&gt;dev, &quot;%s doesn't config RAS function\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_ras=
_block_str(&amp;info-&gt;head));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -1028,8 +1028,8 @@ int amdgpu_ras_reset_error_status(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!block_obj || !block_o=
bj-&gt;hw_ops)&nbsp;&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(adev-&gt;dev, &quot;%s doesn't config ras function.\n&q=
uot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_block_str(block));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info_once(adev-&gt;dev, &quot;%s doesn't config RAS function=
\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ras_block_str(block));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -1066,8 +1066,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device *ade=
v,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!block_obj || !block_o=
bj-&gt;hw_ops)&nbsp;&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(adev-&gt;dev, &quot;%s doesn't config ras function.\n&q=
uot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; get_ras_block_str(&amp;info-&gt;head));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info_once(adev-&gt;dev, &quot;%s doesn't config RAS function=
\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; get_ras_block_str(&amp;info-&gt;head));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -1717,8 +1717,8 @@ static void amdgpu_ras_error_status_query(struct amdg=
pu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; info-&gt;head.sub_block_index);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!block_obj || !block_o=
bj-&gt;hw_ops) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(adev-&gt;dev, &quot;%s doesn't config ras function.\n&q=
uot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_ras_block_st=
r(&amp;info-&gt;head));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info_once(adev-&gt;dev, &quot;%s doesn't config RAS function=
\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; get_ras_block_str(&amp;info-&gt;head));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
<br>
base-commit: cf33ae90884f254d683436fc2538b99dc4932447<br>
-- <br>
2.35.0.3.gb23dac905b<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144C64B0B4E525FC97EB522F7289BL1PR12MB5144namp_--
