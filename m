Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D161C4708E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 15:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB06810E0CD;
	Wed,  7 Dec 2022 15:51:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 624EF10E0BD;
 Wed,  7 Dec 2022 15:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bx//Zx6Rs5SzYNH8cc8eErR3gVnGB4VmtZckxq3LkuZm7S8gHXhBK2Dgxbt2NPLkiS7sc/dPUdFbUVhVhQUIxB9sCqbbWJhwwKEjDswiS7+HZwV3D/PaYKyHuAmgRR5RpfJAKf/TMUYfvz4QJYfZELOoTIspS4g+mtZVthZj1wG7nyksepHH+gv8/K5E2QVMsZDXkEE6+lMBbrbqTVZJDrkXw8iE1tKtKIQLwPnZ3iUunN+lpFp0f1EFnOavI3cllDijb7ts+LBd1MA75b+qpyU9jwmLZDShkHwFCfjN4e1hGXh4DKX5+SDlaC32SQPvRhSp9fftscCuGZ3Z9aDC4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsuo+2PRi+QKUlavBjpbot59IONAe7ptXI44HdEHq0o=;
 b=SrgJKmIE64Kbd9wlHKm0G453+igAmK2Be5GVRNTxk/2c4Y62ACWI9xKsicxvAUsi1qoipkafymBs8r0/AgV2gnn7bKLdTHufLOFdoNwkLkxoP2evdfrdVSHPrqi9Of7iD+Lg7Azojl+gRNw6G0mFKhUHnEWRbHTGqkept/qfFIAHcVfUvW/W5zCiLjpKCKx0TmYIvxM+xp4QTeZUzCZt8cYbrwr2KBdlkvmzyDhBFJRxvomgMgFL3+DiJSRY9F3DK1XUTFzKYbZp+wdpnul2hMwOonGixPYkCgGKIMWagBonv45kjh+G51G5TT3beeLa2vFkTfOHtaG/9QM35dn73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsuo+2PRi+QKUlavBjpbot59IONAe7ptXI44HdEHq0o=;
 b=f1Sr9Z5QDtNLq4rD21iAnGYeEDAqcLgld0/rzB9nwmyVVfbhhibKCXjQQja8PVFve6PBu6sM0AjelTbH5HxTj764RU5dvX2mvY6OEWgFSpt1hGxqsWnF+ujfZK5gyGR2yxx+QiK68mAnaMyJQqiaCH+rVm4AIcj2UXCjqM7kYVM=
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 15:51:09 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::6755:9455:2407:ea3e]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::6755:9455:2407:ea3e%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 15:51:09 +0000
From: "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer failed
Thread-Topic: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer
 failed
Thread-Index: AdkKDSDFxSlpkC5gTnSZE4zebcKC0wAQPv2AAABvKoAAAGUbBQ==
Date: Wed, 7 Dec 2022 15:51:09 +0000
Message-ID: <MN2PR12MB434256B06E42B489C6EE808CE41A9@MN2PR12MB4342.namprd12.prod.outlook.com>
References: <DM4PR12MB51524585CEC4E2B4B8370874E31A9@DM4PR12MB5152.namprd12.prod.outlook.com>
 <CADnq5_NWr9SAzcQ=x-UVXWHDBci6f_pg-sRj3AD8q5GWYbBJOw@mail.gmail.com>
 <4e415872-3fcf-27b9-dc74-b3e86f171e1c@gmail.com>
In-Reply-To: <4e415872-3fcf-27b9-dc74-b3e86f171e1c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-07T15:34:43.4234211Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4342:EE_|BY5PR12MB4114:EE_
x-ms-office365-filtering-correlation-id: dd82edf4-4a3c-4583-50f6-08dad86adbc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W8SYGzG1BIPT99AhQ1tr0LlevR7O+BV7J2Za8akYmpvxi2fMiq8g6j1EGXnVfEXUHCbVg33EaRGVrYoY7BJXQWTvhQiP5jQeccn2aKsIq+XHJLMBPI9XFPdkBE1cUnuOxs98pXWEcCSypQ47t9pqQ11qNjXwRh4uVJgL+TxLbawgPCUaQH+uBDzAvVqDayGn5RdS75SMJXZ5lQguQNM/ELv1sttxSOdi2k6NCP0H+9ugGqVTtpW79PndOcVZq65of1X141S5N8JDx2uIFpAmWALTXZ+ttJLXJ9I9+fAszI/35D+BDG7fvQK3h1K8EC2UR1EWHiq258aqRtzBLq/F0DbzWZWUudTlHQvymCQmjtteNO/cPUceqo8Ll2L/sEe4On16Zg0ZEhIUkG47hXJmP5KgEQWeGWXQXQHK8iYwjVScWGDO40F+HTNjWvZzqCz43vnwS/ROH2QrolN5kA2xJ5R4CV8nu69oMN1HiFOjzTakOrkeVWcbV2hKQAwjuxKLridfOfrbmQGijnm7KbimWEKL/GRvfBcWZdT9BQk2MHr1lN1x9PcNc24W1TRoBJCi9i+BVsVDfdVpQCUb5Hm8LY+EJPMBm4LIsbqEjDVjS3PqEJr0YQ00m8JhNm6ygVN26O8z51mrf3grMp81BnV8bJieWSYd/szlAkwdOxfqxnrVkWlNFlDjkrQnUQicle+brmTrLN/d3pw+YJipkGy0MENhpoRYXE1NuJJl4cPTdMk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199015)(122000001)(558084003)(33656002)(86362001)(5660300002)(166002)(4326008)(41300700001)(2906002)(8936002)(38070700005)(76116006)(8676002)(45080400002)(55016003)(26005)(6506007)(7696005)(9686003)(186003)(64756008)(55236004)(110136005)(316002)(54906003)(52536014)(66556008)(6636002)(91956017)(66446008)(478600001)(66946007)(66476007)(71200400001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sAc6NBdEQW2XZcZop2cyiFinbdEh96O0WqJhlOca4uPH1ZUfgKNCJGsIrB?=
 =?iso-8859-1?Q?Uaz66aL4n6wBg4cyqbYWqoy3kxnnWJt+Lma40SUZV9BR34AvtsGnjnbi0C?=
 =?iso-8859-1?Q?LJY/XoRrWnKzATAvu8AcxllGW71SzzXVe1jTtYXL56FSI6dLNDD/D4drpd?=
 =?iso-8859-1?Q?XS+JeyuSAZ0cTRM+lKmAAwgl9UWtI7hssFB12SD0TOdqJYaNdOhGh6F1ye?=
 =?iso-8859-1?Q?L62VX1kH5UB8KlsmZXHv0gUbqZ6hlVXIAh9QHFxY7Ws5t8Opx9Mu/9ULB/?=
 =?iso-8859-1?Q?5fJd3X5juIMbJd1ZRrmYvArg144pAUxBSuYBvj+ZLYHWTEH0gAehP0ne+J?=
 =?iso-8859-1?Q?HW0VJ2z+c6fv26S6nue/rjdpi3BM+1n9CVKWTWQxAClsaxjdv+LnHNJdAE?=
 =?iso-8859-1?Q?F9nHXttrS7LvemTCVvE+nh8TGKfFex/8IpXTz0dGbRVnael/rRCNmblFjM?=
 =?iso-8859-1?Q?74blo2gM8trId7/LEv4wCtHyb4My+v32MEIi9LF1zW0C0S6/nBhaiP5RZ8?=
 =?iso-8859-1?Q?/KHqtzf9/Es67a7GvOMUuif9lG4YvnJ8LEZ7/NH+bwZhCHnNNO18cc6spt?=
 =?iso-8859-1?Q?0ysNMeHWRhG2HWYUDH8Cf3psCIrq6chI3SZp2OsKg0VqnhdpxuojzyZOWZ?=
 =?iso-8859-1?Q?TwzJuk2H5I5pIgua+PBpdDpg9iONZLI+zRkh/2OpoKHLODIG3SZFBD6j3L?=
 =?iso-8859-1?Q?9rYzAcKYnTOeGmcmI7sbgkGunDRw0jeNyPEuCUG6tEYHeTu2/RJ9rQmS5n?=
 =?iso-8859-1?Q?XGaUiFqwj1cv4eRydRDy8zmpZmLSspj2UNO2bOJWex0MUmTNYAagbXDpdm?=
 =?iso-8859-1?Q?WSKC+14G/ncsEeJIZ305IPJBTyweD0ppj/ElizVIAOA4SutE9HrC0N6H/a?=
 =?iso-8859-1?Q?l6ypwum7hkpijbvx/oHIjk1+/aUOBKkTy/WJB0xj6hKNmt52evWVGMp/QR?=
 =?iso-8859-1?Q?h6+sAKfpnDCOJTLBja2EecF9zZjHsFEHFV4B9LDBmHfcXfQGycpGWyGE3k?=
 =?iso-8859-1?Q?PDzLRY1Lsb3lPV3N21x5jqf/h4e30uDxkeCvAMc/MRT1P9L/2lRLyNPKny?=
 =?iso-8859-1?Q?xDiTKGMCGuCw2Z3evKglKO3siBq/Z9N66JMyQQwo11PYdfRDuHLW8TdDoX?=
 =?iso-8859-1?Q?sCbOUnE/idGQ8Q7xeGe/zV+njIydepKzIpPEYOFqMTX7/YFpJ9GFNEvaay?=
 =?iso-8859-1?Q?P6l/AHiaEgYvgcdv259IRmenoiTPEdpQmuFgWhwFd418zcN/zeGfwp3ykC?=
 =?iso-8859-1?Q?3OdWfanslSWHBGkqlBmov4ZXgxC9Q1mvpBZUFPIVM0uSc+d0BCjC4sZNS/?=
 =?iso-8859-1?Q?r2p+AE3eNx+dGpUyYlUnKpG9Y8Yr2oJ3mVFb5nWwJ4D5vW7pyrdPHZNtgz?=
 =?iso-8859-1?Q?ZwWA/LMxncvbPvl2hhLlnf8hZWkwwuFh/wru/BNDo7tQy1C7piTw+5hKs8?=
 =?iso-8859-1?Q?ZXPOF5sTnnh1Gi+LJswaqdtcR65tV+O8hwPUjezvShOv0fREYRC18T8Xz9?=
 =?iso-8859-1?Q?VtasPEzd+iu4bpaiZ+PyIMNIPIbHN+R1lXnS3YE0487iF2MdP0D6d9vKoH?=
 =?iso-8859-1?Q?LUVXze8PBwMIDR4UNzweZYpDzTa7uZmoSP5D90bKxE7kEfByfgxwfT2mxq?=
 =?iso-8859-1?Q?NsatYYttMfYRe4Jz1CKgqEpclbPfeimnAYX+iM97fSPZeFKbyff2uzkw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MN2PR12MB434256B06E42B489C6EE808CE41A9MN2PR12MB4342namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd82edf4-4a3c-4583-50f6-08dad86adbc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 15:51:09.1177 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xgKUwtr8RVwc+q/dKgGe/JFkLq6DXBGhdg8/KVJOLSefT3VE/LizYWoMoKb3RNRsP81TrMFmcKH+7lk4HmNDIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, amd-gfx <amd-gfx-bounces@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_MN2PR12MB434256B06E42B489C6EE808CE41A9MN2PR12MB4342namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Hi Christian,

If this change is possible, I think it would improve the performance by eli=
minating the frequent BO eviction when there is a memory pressure.

Thanks,
Arun.

Get Outlook for Android<https://aka.ms/AAb9ysg>

--_000_MN2PR12MB434256B06E42B489C6EE808CE41A9MN2PR12MB4342namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Hi Christian,</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
If this change is possible, I think it would improve the performance by eli=
minating the frequent BO eviction when there is a memory pressure.</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Thanks,</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Arun.</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
Get <a href=3D"https://aka.ms/AAb9ysg">Outlook for Android</a></div>
</div>
</body>
</html>

--_000_MN2PR12MB434256B06E42B489C6EE808CE41A9MN2PR12MB4342namp_--
