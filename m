Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA1FC7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jun 2023 14:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7577310E5D3;
	Thu,  8 Jun 2023 14:31:14 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B63C610E241
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jun 2023 14:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0AUORPDgXSk3sEljdgKb6ChqJ9Rb5bH4Z5ZZu3cCRVTtVILT896o1z+kBNDgVH+ZCrdvBLwwFhHzLb13+ZBCim6IkxhFY5vuSl7CmPzzCf2DItMp3QHywStJupsi/ku0868rbNbhlzevpLObcpTNu5aahkzJ/dRc7aXx4VfWKZAFw476MICApJYFOPnB96e56F7bU32XF31fqwKtxgNMy2hHjS2NVSsp9ZFhbUMndk204vPMBQ5o1+sTrZWQAUSg0qOYXdrPk6nt2brJ9uLtBrDVPr0l8qtW87DaLa/7SRso50EpeXJNf7HLJZ0SHCv3bz8KyaxqoDpKSedkdVFsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP8sJQe+0e5eY/wNdIjgV7XLjklj2puNnEnzQuR3uLY=;
 b=B619yLQ5fg+ZbUBMSRxnRyDGzl/VG1RBTMeaIJ3YN3qv7gAfSUSYIg0SnkUb78f9FcAY/Aw04z02CAb9N1ZN24uTNkcZff9iTitxvp4eXGmZPgSD08jlVeW/z7G+EFWlCYpFPtFKlQMfQNaMaQYKQVbK/XGPEAL45PukCrOucxECd2goZ2TN/GZlZmuGzpiCdZ9oeMoZE5N3G+alVYGc8wph83VL+ZXgN0/L7JCIHSlC+45OxitEkib7SyBEuccCWtiNpeI3xqW88v3axdmCRjKNj3DFTFElpz9h92unPppcdvnv/7x6cqXax8sFn10tsq03S5CMs9dI9CBzaMXMyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP8sJQe+0e5eY/wNdIjgV7XLjklj2puNnEnzQuR3uLY=;
 b=zRJupqgwVjErvS/gfmuQajglTFNI+9qq6SrJqpOdgoHbpLUo35b1bXTTHN4l1pmW29BNI/dtK0ClNi1frLY/iTjVsxLQDSyUx6jXpO2PbsBH/D/N8j4vLj3ARtoDtz4X1Vrdw9BaQuzk9TUBpKRNrCQLrEI/7F39xtJ12fEhSNA=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 14:31:09 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::e02a:b0f7:e051:10cd]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::e02a:b0f7:e051:10cd%4]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 14:31:08 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, "Zhuo, Qingqing
 (Lillian)" <Qingqing.Zhuo@amd.com>, "Chalmers, Wesley"
 <Wesley.Chalmers@amd.com>
Subject: Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit
Thread-Topic: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit
Thread-Index: AQHZmE+p2kFzkjFxL0CbkqT2G2DnrK9+CffjgAGIgQCAAAYZqoABX4oAgAABSOc=
Date: Thu, 8 Jun 2023 14:31:08 +0000
Message-ID: <CH0PR12MB5284FFF8F26F8ACD7838BB6B8B50A@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <bc662b83-f117-2f61-c580-086c3f404086@daenzer.net>
 <ec919f31-2f33-f085-dfdd-25360b5e082c@daenzer.net>
 <CH0PR12MB528496B026471110065187488B52A@CH0PR12MB5284.namprd12.prod.outlook.com>
 <df1dde7c-f789-97eb-5b67-266bbb95c1e1@daenzer.net>
 <CH0PR12MB5284C88ABA0C45CD177F9C5B8B53A@CH0PR12MB5284.namprd12.prod.outlook.com>
 <f7c2a548-3154-c163-bf73-19a8c2939447@daenzer.net>
In-Reply-To: <f7c2a548-3154-c163-bf73-19a8c2939447@daenzer.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-08T14:31:07.157Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|BL1PR12MB5778:EE_
x-ms-office365-filtering-correlation-id: 715c022e-78c4-47f4-01ce-08db682d0016
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sXxPb058sa957ZdlLZ59TcghSxDnvC+RA3nQA5mxxXcV0hzoJg4h/58ZshlAw9SqALNetyQw9ChI98ShvedpRKrKm2E0MFT+1KE7m4fKTXbbfedQA2OZDpBS1ej9StW+5H+pbgl5/K/qfuGVmBvs1C6qU/iDN18Q7uTUkpi/hpkX2Q7zN4Go7WdjIlVEQeNEmCzmpHNmV5vZ4Tr4VTDYBvx2yIiNWdQKr3Bhjm5c6M4Vqg8tyIGIPT03sfkmKx0S1NKgnboQbtvH27W8qLc2UiCxlMUANiu2uBwOoBeRnASoBASsehzb2bGpl8rEW87xbxHCZHh9CO/GkvW7omckcMLuXR2phMh+ewnaKQfWJtQ5sldKllXvR2HU22xkGxuGF0vTsTTrcuDk2c7cg3lwLvAB0tD2Bx0qxIWpGRA7zO4khp4u7NfYgvRGQ8fIJlI4Hbryr7PvSgpOPZ01mno/iqBDlOQ4qUfB3wQzZXd7CR+4K6kr6wGwrFAZtek3BRba5MuUWXAc4k5d+1SW7sYRZ7Db/uApwJ2tLuzCE7Z70JSLKIlLUtts2U/S708va6O01EzIeOQFJ7aSWzvaOkL4nmo82E0VKPLrGSQiN/1sGWU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(9686003)(53546011)(6506007)(38100700002)(41300700001)(66574015)(7696005)(19627405001)(26005)(186003)(83380400001)(966005)(71200400001)(478600001)(110136005)(54906003)(64756008)(91956017)(66476007)(122000001)(66446008)(4326008)(55016003)(316002)(166002)(66946007)(76116006)(8676002)(66556008)(6636002)(52536014)(8936002)(2906002)(5660300002)(33656002)(38070700005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PI9SLbisYxZ5SBkPwkTNoUY/+yiBskKkDAs601+SE3b3NBzIz8DCbgwPw/?=
 =?iso-8859-1?Q?BhxUL9rzNy0USoVd6lCfk/YhzfHw5CdaP8Dbv/JJndoDl0y10E44e7p5qq?=
 =?iso-8859-1?Q?fbLRRLAs4VVv3ALLAj5qxE72HlPgUP16qA5X3twDLd642zgAc+kEsNWVAF?=
 =?iso-8859-1?Q?DamLTMq7KmXXq1KxeETadtuEktpzG+AOlnNTfNq4R+MIIXdTkQnnuB+29E?=
 =?iso-8859-1?Q?a/XqBrWpKXsrd/7/nrzIQJzZwbhoUf/DI1rGqNdz9xnjmKvhFMQAbFRDUH?=
 =?iso-8859-1?Q?4sLY3hTse3nCJCIWghE3SXN1sNxh21pr1gxsnyncMp7JjCUKFn559ahKQ/?=
 =?iso-8859-1?Q?w9MU+WT3r595sxwo+aFOyDBJPjq8/uH1/Qved15JtN1GEmCUrSK+gNPWQ9?=
 =?iso-8859-1?Q?6emAJs7aSISUySszVJ3KcFNHwlayDVfp9dB5rRFQ5+bqAZPMyJBBjvVP2S?=
 =?iso-8859-1?Q?SwM6tt50FEjvwwhtd8mLsDX1lltT2OB8LIWBlFsiceVTa2EWoT9OLn4aew?=
 =?iso-8859-1?Q?5gqHm7vJW7v358Oke47vavPuWYq4kBN3UEXIW7GoTmVrXSGNh/WuTVYOL+?=
 =?iso-8859-1?Q?uLYCeTwK/fbi8Xwu0U6bt5EGn6LDBN94eTMmWrdxA0Qad1RRo8l+y0pkga?=
 =?iso-8859-1?Q?WOMVC7CYCW1IL4cbxUsV3Qz1PQ+ZAVMcKWjPHLwLj9ETmqUYTE8eNk5B8G?=
 =?iso-8859-1?Q?6/e8dFqL0nYqQJYyEUrw2ZXKYQ+9p7e4c93M+QMUAflCJWRdusqfY+u2Y0?=
 =?iso-8859-1?Q?5v9LlNgrzreoBGbmwyVIioO9uWhMXFuIkvt2nPHOAb4brNuqkRQdopwfm1?=
 =?iso-8859-1?Q?6urRlm5V15G2fx15Kz7lmI/y5u9we+3CchbRTIDeaR/m9WS+FTQUlb/0HV?=
 =?iso-8859-1?Q?praXt+IQsCQiFK2bWdY1bIxVHcEHLXSlw+L8vGIT6bNzA9LW7XHLjgLk5K?=
 =?iso-8859-1?Q?j5CpaLD0Fesyq8cdPcGS7r9ftb0XOVuWJEML3Oxi80rA8Z5w759eP7IYla?=
 =?iso-8859-1?Q?Kf6y7aKb5SHWvbXnsLAMas2txn3+2DRtmmWeZvwxu8wVVeyC+nG21ngU77?=
 =?iso-8859-1?Q?iKNqrJbjsqjSsXZvvS0AI+BKYEVC8dyvY5OEe6AyLcMJ9dp0RxizUNXkIv?=
 =?iso-8859-1?Q?dmI8ldSFQBpk7gyqvt9P9YBbLp3VtgJ3a5fjMyA3jbCIlmVe9sUSkrEVfk?=
 =?iso-8859-1?Q?WCo2efzRXqq1SyXt/1r8s/zENkCSXUhGzOPoAEF0sPPSVdPOKi3zanRFWQ?=
 =?iso-8859-1?Q?rzkhHtGVAJqYWm0kTQIDq2tJKA3RV0cddbw+8kLaO06UJCAL9GYO+urRrR?=
 =?iso-8859-1?Q?b8Px/MeWYU+9eVEiWROH4rv5b6KkmOvik3NhRSy4+x1cQ50aX5UqM7uO8b?=
 =?iso-8859-1?Q?W2eLGJw4v4aO/QiE1R9SbpNEvVDco+OOqmM0V9m8SltrZslQs0eXcoelbO?=
 =?iso-8859-1?Q?ePh4q354Arj5NdqHley1jz/BofwnlAgVf+1a38Lmq0Uk7COdtZkJG9X6F0?=
 =?iso-8859-1?Q?LkpWeotmDVRBTMZtSBrHvYqob1S+lZw5SgH9BwY68HKcx+Z2nbuY+ltt7W?=
 =?iso-8859-1?Q?MPfV3eLU/8OAFnMcGTLTvcKBaC6rSVhS7iSmKmdI6hh3SDab6MdqliZERR?=
 =?iso-8859-1?Q?WQbP9MWftbW0k=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284FFF8F26F8ACD7838BB6B8B50ACH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715c022e-78c4-47f4-01ce-08db682d0016
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 14:31:08.7019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCquDKT4UNdB3ene5KKg0yITwSX3nr3nKNeMiVRU7F8PnNXk+7mldjfX3Kld0INhJNrBMkuxu5J8P2iBwcsfvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB5284FFF8F26F8ACD7838BB6B8B50ACH0PR12MB5284namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Thanks Michel,

I reached out to windows driver team, and they have a monitor specific quir=
k to disable FAMS on this model. I suspect the issue is only present on cer=
tain fw revisions on the monitor which is why we cant see your issue.

Unfortunately, having the patches in question reverted causes hangs with 3 =
monitor setups. So I will push that monitor specific quirk and bring back t=
he reverted patches.

--

Regards,
Jay
________________________________
From: Michel D=E4nzer <michel@daenzer.net>
Sent: Thursday, June 8, 2023 10:20 AM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Zhuo, Qingqing (Lillian) =
<Qingqing.Zhuo@amd.com>; Chalmers, Wesley <Wesley.Chalmers@amd.com>
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, =
Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; amd-gfx@l=
ists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Chiu, Solomon <Solomo=
n.Chiu@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wentland, Harry <Harry.Wen=
tland@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pa=
vle <Pavle.Kotarac@amd.com>
Subject: Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit

On 6/7/23 19:35, Pillai, Aurabindo wrote:
>
> Do you see the issue if you force disable FAMS?
Neither hang occurs with FAMS disabled.


--
Earthling Michel D=E4nzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer


--_000_CH0PR12MB5284FFF8F26F8ACD7838BB6B8B50ACH0PR12MB5284namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks Michel,</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I reached out to windows driver team, and they have a monitor specific quir=
k to disable FAMS on this model. I suspect the issue is only present on cer=
tain fw revisions on the monitor which is why we cant see your issue.
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof ContentPasted0" style=3D"font-family: Calibri,=
 Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Unfortunately, having the patches in question reverted causes hangs with 3 =
monitor setups. So I will push that monitor specific quirk and bring back t=
he reverted patches.<br>
</div>
<div class=3D"elementToProof">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size: 11pt; color=
: rgb(0, 0, 0);" face=3D"Calibri, sans-serif"><b>From:</b> Michel D=E4nzer =
&lt;michel@daenzer.net&gt;<br>
<b>Sent:</b> Thursday, June 8, 2023 10:20 AM<br>
<b>To:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Zhuo, Qingqi=
ng (Lillian) &lt;Qingqing.Zhuo@amd.com&gt;; Chalmers, Wesley &lt;Wesley.Cha=
lmers@amd.com&gt;<br>
<b>Cc:</b> Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; Li, Sun pen=
g (Leo) &lt;Sunpeng.Li@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakh=
a@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Li, Roma=
n &lt;Roman.Li@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists=
.freedesktop.org&gt;;
 Chiu, Solomon &lt;Solomon.Chiu@amd.com&gt;; Lin, Wayne &lt;Wayne.Lin@amd.c=
om&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Gutierrez, Agustin =
&lt;Agustin.Gutierrez@amd.com&gt;; Kotarac, Pavle &lt;Pavle.Kotarac@amd.com=
&gt;<br>
<b>Subject:</b> Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe c=
ommit</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">On 6/7/23 19:35, Pillai, Aurabindo wrote:<br>
&gt; <br>
&gt; Do you see the issue if you force disable FAMS?<br>
Neither hang occurs with FAMS disabled.<br>
<br>
<br>
-- <br>
Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://redhat.com=
" data-auth=3D"NotApplicable" data-loopstyle=3D"linkonly">
https://redhat.com</a><br>
Libre software enthusiast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mesa and Xwayland de=
veloper<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5284FFF8F26F8ACD7838BB6B8B50ACH0PR12MB5284namp_--
