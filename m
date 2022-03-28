Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD73C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 14:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF4F610EC7B;
	Mon, 28 Mar 2022 14:57:46 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58DC810EC7B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 14:57:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hi1l69xYgkIgrT1/+ZyBtVdbtJ1q84qJET/6GtqkePqF8RtQg+RQA4DoUowiSV2O7TuK3p07v3hFvYXDqN4oFMKjk/S9IaGyAJouoAu73547wAEL/r+MYYdt7mmQrEK45888tynbSK0iyOWBkCcqa+5CLCFN1X3fxNH/+viH4VGsjjH0wKf3FoklF8VWzzCJ9Dv3XCRTwIhJQHGk1j4dtWZJC5LgqVfPSR0wuT0eS8tsI2LXLQtQkuP1WdB7+lb4y7BqGJCF8NYyoPi4dtgUov43KfuBtmohl1E/M1H0c+tyb6xUWMaJRI4c904zvizH3aAEDU5lXG/hGuI0mauEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGuo0jefmImixUc2q4S06+DeRufxZHJSqM461tKgSJo=;
 b=DLXeS1uR7vVtabo6T+wxsMODeRHpb4ClN3r6xr6WdCItbwzleRXNx2As8ZNoJhU2kTqJDb0ZNQNzZiIFS+1pocynyGhoYs5HHeFaIDalV6SXHqIdk+IEdQJxiAdw3mno32D+/zOtetQzlMV33cZEJraUGFBW4YscDHD/CZLrEOoOyqKGPs+YYprPS49HOw2hecl5jefO/oyKntpa1Nb3BvYoJj2GPVj41oHCvs+VAk2La2ftuc2ezAm4anipqp9owkcXXQ2K0GP86Wq+ATe51web3UTSAlvDfT8zL+8sqxt0J1xdR5C26/OQ3FOpIKd+3i8apBJ4ixed7yYIUBQhPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGuo0jefmImixUc2q4S06+DeRufxZHJSqM461tKgSJo=;
 b=QgylAT3wSJyyjLpYErcTjxgfLjRkuRiV+CFuA+tlWE2qQ1IAcep5Qsagq4jbq+3g5FmmEPGxdDq1b9PoPPfhb0bdLGbzsWRzm4eJxRIncN/mXMJeFJa1uMTc6LxtM6na6ONj+EIepEHuhTARgVN6A0WVz5tH5SDGisSdPXMnWV0=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by MN2PR12MB4550.namprd12.prod.outlook.com (2603:10b6:208:24e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 14:57:44 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::1cd6:26c2:47da:bfb3]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::1cd6:26c2:47da:bfb3%4]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 14:57:44 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Use switch case for unique_id
Thread-Topic: [PATCH 1/2] drm/amdgpu: Use switch case for unique_id
Thread-Index: AQHYQrEZUMO7rqnERU2kzUtx0LXxC6zU4vY+
Date: Mon, 28 Mar 2022 14:57:44 +0000
Message-ID: <CO6PR12MB547328382CF2D9DCA6DDF5D1821D9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20220328143518.1253762-1-kent.russell@amd.com>
In-Reply-To: <20220328143518.1253762-1-kent.russell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-28T14:57:42.427Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9fdc926-0481-48c2-7b1d-08da10cb50b1
x-ms-traffictypediagnostic: MN2PR12MB4550:EE_
x-microsoft-antispam-prvs: <MN2PR12MB45508F9D0613C10E2F5F0AF3821D9@MN2PR12MB4550.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RbQbJxm5TwWo2i7sYLJiDtoFP3EZ1ncLXahVJ0vOd4ywDm3b/UPeFPij9xI7g3gQLl4/QkWwkyZghxGIIcxO2lAGCE1MjWcvyeNTVWi/sKejLO42NR71/SrSGEFf37/XhSh2EzqjZstPFT0l5bnuneXk9OTh3VJ9Oj5dFwHTlZVuS2Zf+6QX25LsfPdkeXMedoc+BL02pBtzYnSWPcYTVPJ5WOVgjgN09p+f6VHggQWSjHJP9GJXOF+g8wl0f70AYsW1k60gtmLgDZGXm8YMpp2YrSLyl2PEJnK3UawXkl3kQD0g6XYQ/dfH+ldfnQtw4BMEVtYHlA51bs6YY2pPlBArkahreGOUrq6DDBW9qiaDCFACEp0LPxv0eImH1h2ooLY0RPDibsybjfeSUKdiHiEhjrCXj+HmEwM25sGCLO7dIWhbOfFZInndZSnuISpJZno/ooFU+a86CrmfAKHKjkVolTYIdzUbk4mO4olgNm8XnNzxS2Nfkcqq55ybFa1l0xWEsocBLccAF5H4amzgbhBUWUSS3oX2y22yA+EdXlYUR2ocyRtCNm9l8Qin1RnHb3TkioTXNEHsAVAlNAWxa5CxNRQvVTaAa9xWp1fwE9k4+LXPf1ii1YcGAul7Fh6zpre14z3ArBcszN2wxWi09yzBcxRAyUEocFt2TQjC0+fI+x1Nz6dg/cxQcmhbN/jrpPGoY8k8DDirRj3Sa6nFMQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(33656002)(558084003)(9686003)(4326008)(6506007)(19627405001)(38100700002)(38070700005)(5660300002)(186003)(8936002)(26005)(508600001)(52536014)(66476007)(55016003)(64756008)(66446008)(122000001)(91956017)(66556008)(76116006)(66946007)(86362001)(7696005)(110136005)(8676002)(316002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tnGWSg50hej0r+FUVxXN7hFr2TznYRb6G7q7z6uwb3nQ5hGCquLfzXIjm3?=
 =?iso-8859-1?Q?8iq0IP+hGgIqXU2bteqnx5BBrGYJC6T6b3KSDxHhdyKMko+cTLAOAGO4Y6?=
 =?iso-8859-1?Q?pt2zbB5XqYHRVyg/bHB/hetqgdRwNSjoVpPwFI51RprAzt3/MEqvMG4A5e?=
 =?iso-8859-1?Q?inAvGCF7EATtVsbLb6z57XamBH5corTZZzA0UC9ykwWixWWuTyqGmh4yc6?=
 =?iso-8859-1?Q?amh2KPGuHuNmPeog/2CCKZmo8c/SDNuwemCDLuwesYya9LopKxShAx/kF0?=
 =?iso-8859-1?Q?j9MhE4kNOXueVTiSgyepibTqk88hQFe5GkMlD5+wopjetDBK0uQrafRJpd?=
 =?iso-8859-1?Q?HAoVIIM9v6EgElGBcuQ7RZ7KV9POWLoOuAnHZ6HG5SJjX5NVfVDRdWglDj?=
 =?iso-8859-1?Q?4eG3rp4Xj+ppEsr47dowKmnHxSlHtDJZ7Gs6ssG7LWyC9cdgwlceiUsdO4?=
 =?iso-8859-1?Q?w8QVWs/9B+6Q2r/mNurBB94bYuuoDzmZPLEezjGcz+pOiG6aLhww0y+DfR?=
 =?iso-8859-1?Q?CZXW7ko0rKxp2xZxtRJOvNbWRMKPEqINpvICFskWJRBXvazqeW7ebnTq83?=
 =?iso-8859-1?Q?3S+6KVc/QfMTASUJwmJ7vNV5eUyAuYSvln+JU8KBOegf124/0IDwdGN1Pd?=
 =?iso-8859-1?Q?UU7CnHQDA5FqwcDv/RdBfaPVtRJfj+d3af4WyhKfnFnv2pBOwyY2/uBt9I?=
 =?iso-8859-1?Q?Egce6DmpcDAmGbR4zwpYt6VO8GlKBZP/hLdBkFSiW6VW9joSEZjAVochze?=
 =?iso-8859-1?Q?djMhrKGIISEIeQmcZkBDLeYJuwJIShJwxjdhlRyuygdgHfq5Qq4/Nx40UE?=
 =?iso-8859-1?Q?cSGaE+yJoD5jvWXeU6axjkePlAjRbhqEJzV8tcXa7cH9ZXDeY5tHWTj2qN?=
 =?iso-8859-1?Q?2Ff2xWeXlCcoIkBwvt/CrH8/kwpyLiDQkF/JlUt2ZiZMYmgAFpz4bGAs5/?=
 =?iso-8859-1?Q?oFrN/wElAGxlzjOJ4wpg1R+3/d9qOTcS1VJOF9/mnG44AyW2SdEftvj/fb?=
 =?iso-8859-1?Q?QrbQ95B54CZAwrXg1EwQyphDt4mhhShD4sF5ihQM+FI2/KRfDsUND4L5SD?=
 =?iso-8859-1?Q?ItucmB2rp7xgwa8E+XJAki6CBsDNoezI4AV9rvilgO8DGgDpf82AMhZw+r?=
 =?iso-8859-1?Q?Qs/8eKsdx22M34AXhsAzSiOOE/n8JBrquVsioBhWwwxDT9kIk6bUQTJcnL?=
 =?iso-8859-1?Q?ZZhRpjXEyHK/jtdnkUM28K8u6QbmnSQ/hNEoPa3hmGpgrkRCasLfft606m?=
 =?iso-8859-1?Q?4lbf8E3oQ8iOfXH1z4mc2BesigNZ/Mlt1N/xbo42sxQsdRBAwA3qZrDOcN?=
 =?iso-8859-1?Q?gi8ZGMbEmOn4bd+75YlcBDuLtBaGjpTJ8VmMyTh6Waku1pfGlliI3X41+r?=
 =?iso-8859-1?Q?5wb/1/I7558+bJGRkBxq6fLj/uV1AvFHQRpJEWpmYad39RtGnQ5oIobP5W?=
 =?iso-8859-1?Q?3+FvW0Aiyp/Df9rCsBLAUtOFbkMDyIs87eJ7GeN0rdEDyqmFIVa+ZhGRIA?=
 =?iso-8859-1?Q?OV6PJoKehThkpwOECH8MGq12QPL5pQUPNYoBKXvDRkYFQuAlz7Q/ORfmzE?=
 =?iso-8859-1?Q?Uwm+rSeLSNJxcoESpWz/UXiOpbNf0x4n2jRYhYsbG6lStsiZ0G7N8TeDaK?=
 =?iso-8859-1?Q?S7adaoTeuzh9klC9ksMvxaE7nbCXhLBq+dflBYg4cVDXUSagNuT1VKwpXR?=
 =?iso-8859-1?Q?aRi5r+DVFKeTqXyW14uvTExilTGK1culwno8UasOjayGZS00k2oaQmOAk+?=
 =?iso-8859-1?Q?/tcvxc2GzcSid41ShRjlHaiNvOZudf6O6nClPa0qyU+RTy?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB547328382CF2D9DCA6DDF5D1821D9CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9fdc926-0481-48c2-7b1d-08da10cb50b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 14:57:44.2842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHAvfrqUyogJz4TD6hUmumtrQmcTdMmERBurLvp3hmTCMAA+r6NRG7CgCIwCGwYG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4550
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CO6PR12MB547328382CF2D9DCA6DDF5D1821D9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Series is
Reviewed-by: KevinYang.Wang@amd.com

Best Regards,
Kevin

--_000_CO6PR12MB547328382CF2D9DCA6DDF5D1821D9CO6PR12MB5473namp_
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
Series is&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: KevinYang.Wang@amd.com</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
</div>
</body>
</html>

--_000_CO6PR12MB547328382CF2D9DCA6DDF5D1821D9CO6PR12MB5473namp_--
