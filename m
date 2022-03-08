Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B849C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 18:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A56C10E29E;
	Tue,  8 Mar 2022 18:10:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE44E10E29E
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 18:10:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WklhKVFWf+9ogZAROsd3fedYRZEG51UPOu42QPYuH61WujnQ6cenwi/D46YsrMPr6aHqz7nAq9W9SH3eFrCgLflkllC7tX/dMDgkF4yFzpQVtO1UP5RDG5rA/WWSQQiFbBwlrmwjclWP+x9XLEK1vANByVoxJVfyM2egak9UO20qCR5i81zBiGbpyCyXpsr4RQKVbF/D3sAynXH1d0Vh6Rr7v56LwmFY6718Fu3AMiX4ZWeUkEOtmrx9w/ZciSOaqqxRWagJOLV59Yh8yrFS65ILcHAIrNFU/jN6MOFwLW739vmJa26iips2WiXsPxRGboi2D7vw4YF0WgWcSydxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaF08192ZhyHrDWy0Q3IQfHgAnlH9oWacFbeOnN1pT0=;
 b=ft/L+rPJVUmqc6YQ+ggUcah6eVwO4/vTsZfpUyFtReWuigmhtqbneDEauNaYn8X1xnXWwDaOKLjnvCcpTwJLfQ+SYQiH+RYJLw3Tl1EOZyDX8b7uOAyKeUE00IirhgKG2vzhvPXeJqL3MTXt6giHfGuwvBTHc1K3pTPfKWoEOBW9VmcqqW9hP7AAx5RdaX9ttZFLvHPQSHu9apLbW3jfmBBjdPC93aMAImyb22tKPTETk6qoTON8gB4v45514jv3aNcjRkPJ6Uf4U5iiWaBpZzh5j+PQzd3u1gDbYDy5aA7zNyeFeonF7gqvb8h1IvZyVFO9fmFYsfTzqM9KwnJGVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaF08192ZhyHrDWy0Q3IQfHgAnlH9oWacFbeOnN1pT0=;
 b=EHUx/zZhv8nu5W6PqE/2kFdvVC75sOzTiJnbToio8UMR/so7xr3oz9PL/4shb6ioIn02fjO7eUggCv+syrMmn2iMipddGdh75+LdYacnQINXlUT3FapSt7T3d9OprRAjOiDhCERuFS1w12CW1LbNAI7/s4rcrQwECTiuIfCx5WM=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BY5PR12MB3937.namprd12.prod.outlook.com (2603:10b6:a03:194::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Tue, 8 Mar
 2022 18:10:48 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 18:10:48 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, Shashank
 Sharma <contactshashanksharma@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "S-k, Shyam-sundar"
 <Shyam-sundar.S-k@amd.com>, "Goswami, Sanket" <Sanket.Goswami@amd.com>
Subject: RE: [PATCH 1/2] drm: Add GPU reset sysfs event
Thread-Topic: [PATCH 1/2] drm: Add GPU reset sysfs event
Thread-Index: AQHYMlw/pR8PpMGkREWXHpTZc4X64Ky1rWiAgAACfhyAAAGqAIAAAcwAgAACiQCAAAC1AIAACFeAgAALdACAAABOcA==
Date: Tue, 8 Mar 2022 18:10:48 +0000
Message-ID: <BL1PR12MB5157E8997C71A29D00D6AA88E2099@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <1eff0822-f410-fd1b-b9c7-6a54862de74a@amd.com>
 <BYAPR12MB461498EFB1E9A3A76A38735497099@BYAPR12MB4614.namprd12.prod.outlook.com>
 <5c32f2d0-e278-529c-be53-ffd5603cd472@amd.com>
 <b16fa66b-2712-633b-ee00-27916dbd32b3@amd.com>
 <975f7416-2f32-3207-c118-cdb56d2bae7c@amd.com>
 <11183b53-bd53-7afc-2fdf-f46183044dd2@amd.com>
 <c7c3ec4c-5345-b8b9-486f-e3d15e19c452@amd.com>
 <163a02be-834d-2813-78dc-9533e37c230f@amd.com>
In-Reply-To: <163a02be-834d-2813-78dc-9533e37c230f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-08T18:10:46Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4be48e6a-a2c1-4d1b-9a96-fa117da2f19d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-08T18:10:46Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: c60a3749-8d50-413f-8b81-fc1f045a4496
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8ea953e-e47c-48cc-54e2-08da012ef91c
x-ms-traffictypediagnostic: BY5PR12MB3937:EE_
x-microsoft-antispam-prvs: <BY5PR12MB3937D30100A109DF98C4CC11E2099@BY5PR12MB3937.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EReO3mCF2nw5CrvHsdrhzDnu1+Vnv0W5pAA5fpOTv8Tnf68sp8/vYfcdRMZpMgLlo6QeZbd60AFyy/16ip48gcULmmSLrh3sISZUYkptUgeWg/QS1Mb+/FmElpVDdjZDd4GOp7jijCtMfhXm/WN0LxhQmQf15395DT2Y7zd82GAoF2OAHBBIDniidWDgJenoMb2m8cGw5zhyDG/A8hI3wcQY2yZI4JijUzjuwwTPaLKQ+9M8Sbzw5m1xAwTYQuy/uzGOmji84+2HHezc/mAWwrD6uRcR3h4H+SbJq4BoDHvm+vAbEuymd06yJqpF6A5vR2XdFORNzWlGNVEYx6EMoomS3guWHtqnJq/xbSfPucyIvoMFZLR9GnCYvsyDd1Ddg/ldycS+vcA+wK6BHgY0DPfmaN10WqXfCxz+r1vZgLN9FfBlHAwQjET8rvmACR1RAQMvXXi+EC9qvUp0URlaLIadWoRDuP5Fdl5kg+IjlkQZqTNwoh1VJz5lN8BqhMhoc0OR0jDDScYvELX3BG4Ou1c9SrMr6uUxXhjQCoV9QSogyEsSI0UTzUWsd4UwSS4LRsTqmXUGfWe5hv1/zRIBCoJUAUuDMWm+Dul7aaC2G0sqDah5F+smd09iGCnX/3aKWOOtPEHYOiVhv3DJCGTjSPIVhj3aDFtAvDL9d5PXqUP41o4XrpCbHPlXqiJktBwEn8V5EiMaEBJpVd5sKtiQYltjmH5V0qjQnPWJUswVTl0K0DWxJNcqhulHT4KJ1Z31XZG634ZeK9KTs3X9dCrd00fi4w3Dk0ZppUKSIpQWbNeu8DFnBOtDzU3YxKKw01t+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(316002)(122000001)(110136005)(45080400002)(55016003)(54906003)(6636002)(66946007)(186003)(76116006)(921005)(9686003)(66556008)(38070700005)(26005)(508600001)(64756008)(8676002)(4326008)(966005)(66446008)(7696005)(6506007)(53546011)(38100700002)(71200400001)(86362001)(52536014)(8936002)(33656002)(5660300002)(83380400001)(16799955002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d094VFozOHZXcUdWaUpKS1ZvN0NudmxPVFNoaG13TWxFM0w3NnBqRUg0RDQw?=
 =?utf-8?B?ai9Bc3pCNnpkQk03WHU5Z3UwQlhZbnFoVXZVV20xenZTWjBwd2hKOEJGQ3Zh?=
 =?utf-8?B?ZFJqc2ZlWStra1MydFBCNnlGczl1RFdBOXQxaUFCQk5RWURPYXlxckVmZktQ?=
 =?utf-8?B?NC9iSlRWbzJMa3k1U01EaUFiSEtXVDdZU2hNWDBkZ0NBZDZyRXZkWmxkSXRn?=
 =?utf-8?B?Ym51U3NUREF5YnFNbUxKdEtZMnE1SmlDZTZDTlQ5ZDVPQnhheVhuTXJFcmpz?=
 =?utf-8?B?TE5sUUFFWnk3SmhxQUNTVHlraExVNGxHK0pDUGQ2VE9mWXpxc0N5bTNFQ1Vz?=
 =?utf-8?B?d1Vlc2ZJNnhtNkp3Uld3M1Z2QWxOY2c4ME9kTjNtWS80Yzc2UGhTTDhFeHFM?=
 =?utf-8?B?Q2c2alhmdVFKaDFkcE9wamk1dnhHM1BrTmVYVkorWUVHTkE5WkRhRitZNWlw?=
 =?utf-8?B?WEZ5N0RVRGNrdW5OdEprRXdZZEdQakxUdk8rWmc2WDZhcHRNeFZuMVNoMkRz?=
 =?utf-8?B?UEE1SC9VU1o3cFd6cCtjdW9acS9aR0xXc3ozMEtoL2gyMjA3eXJDZmJORWo0?=
 =?utf-8?B?TEplTUh4NGdwNXJac1pVRlJDL2xVMGxZZFVEWHZIY3JWMVNjdThFTnZWMjh5?=
 =?utf-8?B?c0JFNXlRMFZ0VWNhKy9zdnFJTzNUR1UvRWVRS0dkQ3o4c3RKRXBVeHVwMHlo?=
 =?utf-8?B?MStPWm1PbitJbjJ5OEZwMlZZbXYvUitsaEZEbjNxeDF6c2NkRXBHYk1MQ3BF?=
 =?utf-8?B?OU5qYzBIVnFWdVhTZzNYYlUwclpjTGFHbng3Tk0zK1g3b29Ea0cxeW1hRE1F?=
 =?utf-8?B?RmtLZ3h2QkcvN25aY2VEaEdydFJkNWJmSXZqMEk4UVFyak9HT21LaGJKNlgr?=
 =?utf-8?B?dVk1ekg5VXYva1Z2cHJYNnVtUitpMS9ocFR3MTNabjIvK3BTL3lzMkk0bWxq?=
 =?utf-8?B?T0c4QmlCR3I2UXVENTV1RU1uVzZJK0I4clNTV0s3MXRZeVhLRGRNZFlhdWd2?=
 =?utf-8?B?RkpZUFNrdEd5YkFZZ1hFREdXTkVONmh1enYvZXZ0RkhUS3Y5SytZVkN2Wi85?=
 =?utf-8?B?Q2RzZnViSWhBdFpKeEFFNEFlbS9pUWRnY29DU1FPM3hENjZiSS90S1ZTVkd1?=
 =?utf-8?B?cVQ1dllaY09JUE1sRmdiYzFJRmdWWklSc3ZwRWFobEpqMXdDUVFCY0xzeXM2?=
 =?utf-8?B?dDFiRmtqSGEwa3BXTldOVTBuREZyRzFMMGxCeVRxdzBBNzJqYjRpV3VIMXU2?=
 =?utf-8?B?MFlzcTlNS3lHa2trMDlpWjlNcUJlM21iR21XR0xmSW5YZEdHWjEybTVaeHFV?=
 =?utf-8?B?UmNkZjRTUE4yNWQ5THIyRExwRksraEh0c1Z2Y3ZrQVRzWDZ2b3Bya1QzVmpP?=
 =?utf-8?B?dmxYTjQ2dEV0bEtsQitPc3ZBN25DazlpN1ZNaGRuNFFMRFpwcnlFeHRUOHpN?=
 =?utf-8?B?UXo0VWZmWjZwd2JFSkM1d1F3THkxL3lHdUwyTEV5YWJkblh4NVRIUVorUDh6?=
 =?utf-8?B?djNrQ2FCT01kS3ZWUll0NEpmVGRqOEJpM0NQUExNMXRodW51WWZKaUNtQ3Nj?=
 =?utf-8?B?V1pJTDM1YzFtbEVpRS9oVHZtSjI2a1p6LzFycEFkeXlSNThtLzFlZE5vc1Ur?=
 =?utf-8?B?YTlFZDQrVXQrRk9WZm9mdTY1SEVEbEw2dTd0V2JwZ29xREl3VWNLbWxPb2d0?=
 =?utf-8?B?NExyMWM3b04wQ3FqZnAxZnN5eWk0Snc3QkhqODdtcFJibDUvUnhFVVlhOTdo?=
 =?utf-8?B?SE9ERVc0TE9FYXpSbkhtVWc1WUIzNnd4dzlsWFZ2S2VmSTAvTURQMzhZcUJR?=
 =?utf-8?B?cTdnYm1hZUdyZ2RKQThCd1BqWldXeEZWcDVrWmhqbXBCN2VrVXRsNjhiTG9P?=
 =?utf-8?B?MG9FUU9STWJXT3BTY0s2Szg3WTFLNng4Zy9uMVQ4MHdCMVc4bFZlQXJQLzBW?=
 =?utf-8?B?YlJSL3FFMm51bmZleG85a3J4RWFpclpUdGNUNVUwYUJrTW83Q2Q2MWV1OFlp?=
 =?utf-8?B?YXQ4YlhWdG42L2FSQzlrZnBWQjFwaXhhT0JkSnozd0FMelFTOTRLVE44M3Qz?=
 =?utf-8?B?eGs3alpTTWN6N1B2WDQ1SFNTS3NCRVNkL3BiZGQzRWh6cTJXNE9NMWswR2Ew?=
 =?utf-8?B?VVBsbGxlRmwrbkovLzBNdmlPL0pQcDFEYXpNZlU1cXNJODVLYmhqYW5udWNN?=
 =?utf-8?Q?UNQmDf8nAI42xT3bj1qeVAE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ea953e-e47c-48cc-54e2-08da012ef91c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 18:10:48.2885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XdRkzQgsUcqSf/6JVQcXj8qBrcnESnqbWc6G/1Wy4CWo/rU3K7GQgra52yUXAnG/ye5M0e6REg0Z4mG5MN/RoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3937
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogU2hhcm1hLCBTaGFzaGFuayA8U2hhc2hhbmsuU2hhcm1hQGFtZC5jb20+DQo+
IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDgsIDIwMjIgMTI6MDkNCj4gVG86IExpbW9uY2llbGxvLCBN
YXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IEdyb2R6b3Zza3ksIEFuZHJleQ0KPiA8
QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT47IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5j
b20+OyBTaGFzaGFuaw0KPiBTaGFybWEgPGNvbnRhY3RzaGFzaGFua3NoYXJtYUBnbWFpbC5jb20+
OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFMtaywgU2h5YW0tc3VuZGFyIDxT
aHlhbS1zdW5kYXIuUy1rQGFtZC5jb20+Ow0KPiBHb3N3YW1pLCBTYW5rZXQgPFNhbmtldC5Hb3N3
YW1pQGFtZC5jb20+DQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+OyBTb21hbGFwdXJhbSwNCj4gQW1hcmFuYXRoIDxBbWFyYW5hdGguU29tYWxhcHVy
YW1AYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBkcm06IEFkZCBHUFUgcmVzZXQgc3lzZnMg
ZXZlbnQNCj4gDQo+IEhleSBNYXJpbywNCj4gDQo+IE9uIDMvOC8yMDIyIDY6MjcgUE0sIExpbW9u
Y2llbGxvLCBNYXJpbyB3cm90ZToNCj4gPiBPbiAzLzgvMjAyMiAxMDo1NywgU2hhcm1hLCBTaGFz
aGFuayB3cm90ZToNCj4gPj4NCj4gPj4NCj4gPj4gT24gMy84LzIwMjIgNTo1NSBQTSwgQW5kcmV5
IEdyb2R6b3Zza3kgd3JvdGU6DQo+ID4+PiBZb3UgY2FuIHJlYWQgb24gdGhlaXIgc2lkZSBoZXJl
IC0NCj4gPj4+IGh0dHBzOi8vd3d3LnBob3Jvbml4LmNvbS9zY2FuLnBocD9wYWdlPW5ld3NfaXRl
bSZweD1BTUQtU1RCLQ0KPiBMaW51eC01LjE3IGFuZA0KPiA+Pj4gc2VlIHRoZWlyIHBhdGNoLiBU
SGV5IGRvbid0IGhhdmUgYXMgY2xlYW4NCj4gPj4+IGludGVyZmFjZSBhcyB3ZSBkbyB0byByZXRy
aWV2ZSB0aGUgYnVmZmVyIGFuZCBjdXJyZW50bHkgaXQncw0KPiA+Pj4gaGFyZC1jb2RlZCBmb3Ig
ZGVidWdmcyBkdW1wIGJ1dCBpdCBsb29rcyBsaWtlIHByZXR0eSBzdHJhaWdodCBmb3J3YXJkDQo+
ID4+PiB0byBleHBvc2UgdGhlaXIgYnVmZmVyIHRvIGV4dGVybmFsDQo+ID4+PiBjbGllbnQgbGlr
ZSBhbWRncHUuDQo+IA0KPiA+Pg0KPiA+PiBOb3RlZCwgdGhhbmtzIGZvciB0aGUgcG9pbnRlci4N
Cj4gPj4gLSBTaGFzaGFuaw0KPiA+DQo+ID4gWWVhaCBJIHRoaW5rIHRoaXMgaXMgYSBncmVhdCBp
ZGVhIGZvciBBUFUsIGJ1dCBuZWVkIHRvIGtlZXAgaW4gbWluZA0KPiA+IGFtZC1wbWMgaXMgb25s
eSBhY3RpdmF0ZWQgaWYgQVBVIGlzIGNvbmZpZ3VyZWQgZm9yIHMwaTMuwqAgU28gaW4gdGhlDQo+
ID4gSVNfQVBVIGNoZWNrIHlvdSB3aWxsIG5lZWQgdG8gdGVzdCBmb3Igc2V0IGZvciBzMGkzIGFu
ZCByZXR1cm4gYW4gZXJyb3INCj4gPiBjb2RlIGlmIG5vdCBzZXQuDQo+ID4NCj4gPiBGb3IgQVBV
IGl0J3MgY3VycmVudGx5IGZldGNoZWQgb24gZGVtYW5kIGZyb20gZGVidWdmcy7CoCBJZiB5b3Ug
Y2FuDQo+ID4gImVhc2lseSIgZXhwb3J0IGEgc3ltYm9sIEkgc2F5IGdvIGZvciBpdCBhbmQgaW5j
bHVkZSBhIHBhdGNoIGluIHlvdXINCj4gPiBzZXJpZXMuDQo+IA0KPiBZZXAsIGlmIHRoZSBpbmZv
IGlzIGF2YWlsYWJsZSB2aWEgZGVidWdmcywgSSBkb24ndCBzZWUgYSByZWFzb24gd2h5DQo+IGNh
bid0IHdlIGZldGNoIHRoYXQgZGlyZWN0bHkgZnJvbSBpdHMgbG93ZXIgbGF5ZXJzLiBNYXkgSSBr
bm93IHRoZSBuYW1lDQo+IG9mIHRoaXMgZGVidWdmcyBlbnRyeSA/DQoNCkl0J3MgY2FsbGVkICJz
dGJfcmVhZCIgZnJvbSBkZWJ1Z2ZzLg0KDQo+IA0KPiAtIFNoYXNoYW5rDQo+IA0KPiBJZiBub3Qg
bXkgc3VnZ2VzdGlvbiBpcyB0byBzdHViIHRoaXMgb3V0IGFuZCBsZXQgU2h5YW0gYW5kDQo+ID4g
U2Fua2V0IGZpbGwgaW4gdGhlIHN0dWIgYWZ0ZXIgdGhleSBjYW4gc29ydCBvdXQgdGhlIGV4cG9y
dGluZyBpdCB0bw0KPiA+IGFub3RoZXIgZHJpdmVyLg0KPiA+DQo+ID4+Pg0KPiA+Pj4gQW5kcmV5
DQo+ID4+Pg0KPiA+Pj4gT24gMjAyMi0wMy0wOCAxMTo0NiwgU2hhcm1hLCBTaGFzaGFuayB3cm90
ZToNCj4gPj4+PiBJIGhhdmUgYSB2ZXJ5IGxpbWl0ZWQgdW5kZXJzdGFuZGluZyBvZiBQTUMgZHJp
dmVyIGFuZCBpdHMNCj4gPj4+PiBpbnRlcmZhY2VzLCBzbyBJIHdvdWxkIGp1c3QgZ28gYWhlYWQg
YW5kIHJlbHkgb24gQW5kcmV5J3MNCj4gPj4+PiBqdWRnZW1lbnQvcmVjb21tZW5kYXRpb24gb24g
dGhpcyA6KQ0KPiA+Pj4+DQo+ID4+Pj4gLSBTaGFzaGFuaw0KPiA+Pj4+DQo+ID4+Pj4gT24gMy84
LzIwMjIgNTozOSBQTSwgQW5kcmV5IEdyb2R6b3Zza3kgd3JvdGU6DQo+ID4+Pj4+IEFzIGxvbmcg
YXMgUE1DIGRyaXZlciBwcm92aWRlcyBjbGVhciBpbnRlcmZhY2UgdG8gcmV0cmlldmUgdGhlIGlu
Zm8NCj4gPj4+Pj4gdGhlcmUgc2hvdWxkIGJlIG5vIGlzc3VlIHRvIGNhbGwgZWl0aGVyIGFtZGdw
dSBpbnRlcmZhY2Ugb3IgUE1DDQo+ID4+Pj4+IGludGVyZmFjZSB1c2luZyBJU19BUFUgKG9yIHNv
bWV0aGluZyBhbGlrZSBpbiB0aGUgY29kZSkNCj4gPj4+Pj4gV2UgcHJvYmFibHkgc2hvdWxkIGFk
ZCBhIHdyYXBwZXIgZnVuY3Rpb24gYXJvdW5kIHRoaXMgbG9naWMgaW4gYW1kZ3B1Lg0KPiA+Pj4+
Pg0KPiA+Pj4+PiBBbmRyZXkNCj4gPj4+Pj4NCj4gPj4+Pj4gT24gMjAyMi0wMy0wOCAxMTozNiwg
TGF6YXIsIExpam8gd3JvdGU6DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gW0FNRCBPZmZpY2lhbCBVc2Ug
T25seV0NCj4gPj4+Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gK01hcmlvDQo+ID4+Pj4+Pg0KPiA+
Pj4+Pj4gSSBndWVzcyB0aGF0IG1lYW5zIHRoZSBmdW5jdGlvbmFsaXR5IG5lZWRzIHRvIGJlIHBy
ZXNlbnQgaW4gYW1kZ3B1DQo+ID4+Pj4+PiBmb3IgQVBVcyBhbHNvLiBQcmVzZW50bHksIHRoaXMg
aXMgdGFrZW4gY2FyZSBieSBQTUMgZHJpdmVyIGZvciBBUFVzLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+
IFRoYW5rcywNCj4gPj4+Pj4+IExpam8NCj4gPj4+Pj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+Pj4+
Pj4NCj4gPj4+Pj4+ICpGcm9tOiogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZz4gb24gYmVoYWxmDQo+ID4+Pj4+PiBvZiBBbmRyZXkgR3JvZHpvdnNreSA8YW5k
cmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4NCj4gPj4+Pj4+ICpTZW50OiogVHVlc2RheSwgTWFyY2gg
OCwgMjAyMiA5OjU1OjAzIFBNDQo+ID4+Pj4+PiAqVG86KiBTaGFzaGFuayBTaGFybWEgPGNvbnRh
Y3RzaGFzaGFua3NoYXJtYUBnbWFpbC5jb20+Ow0KPiA+Pj4+Pj4gYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0KPiA+Pj4+Pj4gKkNj
OiogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsNCj4gU29t
YWxhcHVyYW0sDQo+ID4+Pj4+PiBBbWFyYW5hdGggPEFtYXJhbmF0aC5Tb21hbGFwdXJhbUBhbWQu
Y29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPj4+Pj4+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5j
b20+OyBTaGFybWEsIFNoYXNoYW5rDQo+ID4+Pj4+PiA8U2hhc2hhbmsuU2hhcm1hQGFtZC5jb20+
DQo+ID4+Pj4+PiAqU3ViamVjdDoqIFJlOiBbUEFUQ0ggMS8yXSBkcm06IEFkZCBHUFUgcmVzZXQg
c3lzZnMgZXZlbnQNCj4gPj4+Pj4+DQo+ID4+Pj4+PiBPbiAyMDIyLTAzLTA3IDExOjI2LCBTaGFz
aGFuayBTaGFybWEgd3JvdGU6DQo+ID4+Pj4+PiA+IEZyb206IFNoYXNoYW5rIFNoYXJtYSA8c2hh
c2hhbmsuc2hhcm1hQGFtZC5jb20+DQo+ID4+Pj4+PiA+DQo+ID4+Pj4+PiA+IFRoaXMgcGF0Y2gg
YWRkcyBhIG5ldyBzeXNmcyBldmVudCwgd2hpY2ggd2lsbCBpbmRpY2F0ZQ0KPiA+Pj4+Pj4gPiB0
aGUgdXNlcmxhbmQgYWJvdXQgYSBHUFUgcmVzZXQsIGFuZCBjYW4gYWxzbyBwcm92aWRlDQo+ID4+
Pj4+PiA+IHNvbWUgaW5mb3JtYXRpb24gbGlrZToNCj4gPj4+Pj4+ID4gLSB3aGljaCBQSUQgd2Fz
IGludm9sdmVkIGluIHRoZSBHUFUgcmVzZXQNCj4gPj4+Pj4+ID4gLSB3aGF0IHdhcyB0aGUgR1BV
IHN0YXR1cyAodXNpbmcgZmxhZ3MpDQo+ID4+Pj4+PiA+DQo+ID4+Pj4+PiA+IFRoaXMgcGF0Y2gg
YWxzbyBpbnRyb2R1Y2VzIHRoZSBmaXJzdCBmbGFnIG9mIHRoZSBmbGFncw0KPiA+Pj4+Pj4gPiBi
aXRtYXAsIHdoaWNoIGNhbiBiZSBhcHBlbmRlZCBhcyBhbmQgd2hlbiByZXF1aXJlZC4NCj4gPj4+
Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gSSBhbSByZW1pbmRpbmcgYWdhaW4gYWJvdXQgYW5vdGhl
ciBpbXBvcnRhbnQgcGllY2Ugb2YgaW5mbyB3aGljaA0KPiA+Pj4+Pj4geW91IGNhbiBhZGQNCj4g
Pj4+Pj4+IGhlcmUgYW5kIHRoYXQgaXMgU21hcnQgVHJhY2UgQnVmZmVyIGR1bXAgWzFdLiBUaGUg
YnVmZmVyIHNpemUgaXMgSFcNCj4gPj4+Pj4+IHNwZWNpZmljIGJ1dA0KPiA+Pj4+Pj4gZnJvbSB3
aGF0IEkgc2VlIHRoZXJlIGlzIG5vIHByb2JsZW0gdG8ganVzdCBhbWVuZCBpdCBhcyBwYXJ0IG9m
DQo+ID4+Pj4+PiBlbnZwW10NCj4gPj4+Pj4+IGluaXRpYWxpemF0aW9uLg0KPiA+Pj4+Pj4gYmVs
bG93Lg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFRoZSBpbnRlcmZhY2UgdG8gZ2V0IHRoZSBidWZmZXIg
aXMgc211X3N0Yl9jb2xsZWN0X2luZm8gYW5kIHVzYWdlDQo+ID4+Pj4+PiBjYW4gYmUNCj4gPj4+
Pj4+IHNlZW4gZnJvbQ0KPiA+Pj4+Pj4gZnJlYnVnZnMgaW50ZXJmYWNlIGluIHNtdV9zdGJfZGVi
dWdmc19vcGVuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gWzFdIC0NCj4gPj4+Pj4+DQo+IGh0dHBzOi8v
bmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUy
Rnd3dy5zcA0KPiBpbmljcy5uZXQlMkZsaXN0cyUyRmFtZC0NCj4gZ2Z4JTJGbXNnNzA3NTEuaHRt
bCZhbXA7ZGF0YT0wNCU3QzAxJTdDbGlqby5sYXphciU0MGFtZC5jb20lN0M4MGJjDQo+IDNmMDdl
MmQwNDQxZDQ0YTEwOGRhMDEyMDM2ZGMlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgz
ZCU3DQo+IEMwJTdDMCU3QzYzNzgyMzUzNTE2NzY3OTQ5MCU3Q1Vua25vd24lN0NUV0ZwYkdac2Iz
ZDhleUpXSWpvaU1DDQo+IDR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3
aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCZhDQo+IG1wO3NkYXRhPTUzbDdLbFRmJTJCSUNLa1prTFZ3
Rmg2blJUamtBaCUyRkRwT2F0NURSb3lLSXgwJTNEJmFtcDtyZQ0KPiBzZXJ2ZWQ9MA0KPiA+Pj4+
Pj4NCj4gPGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwcyUzQSUyRiUyRnd3dy5zDQo+IHBpbmljcy5uZXQlMkZsaXN0cyUyRmFtZC0NCj4gZ2Z4
JTJGbXNnNzA3NTEuaHRtbCZhbXA7ZGF0YT0wNCU3QzAxJTdDbGlqby5sYXphciU0MGFtZC5jb20l
N0M4MGJjDQo+IDNmMDdlMmQwNDQxZDQ0YTEwOGRhMDEyMDM2ZGMlN0MzZGQ4OTYxZmU0ODg0ZTYw
OGUxMWE4MmQ5OTRlMTgzZCU3DQo+IEMwJTdDMCU3QzYzNzgyMzUzNTE2NzY3OTQ5MCU3Q1Vua25v
d24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DDQo+IDR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklp
TENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCZhDQo+IG1wO3NkYXRhPTUzbDdL
bFRmJTJCSUNLa1prTFZ3Rmg2blJUamtBaCUyRkRwT2F0NURSb3lLSXgwJTNEJmFtcDtyZQ0KPiBz
ZXJ2ZWQ9MD4NCj4gPj4+Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gQW5kcmV5DQo+ID4+Pj4+Pg0K
PiA+Pj4+Pj4NCj4gPj4+Pj4+ID4NCj4gPj4+Pj4+ID4gQ2M6IEFsZXhhbmRhciBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+Pj4+Pj4gPiBDYzogQ2hyaXN0aWFuIEtvZW5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiA+Pj4+Pj4gPiBTaWduZWQtb2ZmLWJ5OiBT
aGFzaGFuayBTaGFybWEgPHNoYXNoYW5rLnNoYXJtYUBhbWQuY29tPg0KPiA+Pj4+Pj4gPiAtLS0N
Cj4gPj4+Pj4+ID7CoMKgIGRyaXZlcnMvZ3B1L2RybS9kcm1fc3lzZnMuYyB8IDI0ICsrKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+Pj4+Pj4gPsKgwqAgaW5jbHVkZS9kcm0vZHJtX3N5c2ZzLmjC
oMKgwqDCoCB8wqAgMyArKysNCj4gPj4+Pj4+ID7CoMKgIDIgZmlsZXMgY2hhbmdlZCwgMjcgaW5z
ZXJ0aW9ucygrKQ0KPiA+Pj4+Pj4gPg0KPiA+Pj4+Pj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2RybV9zeXNmcy5jDQo+ID4+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fc3lzZnMu
Yw0KPiA+Pj4+Pj4gPiBpbmRleCA0MzBlMDBiMTZlZWMuLjUyYTAxNTE2MTQzMSAxMDA2NDQNCj4g
Pj4+Pj4+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9zeXNmcy5jDQo+ID4+Pj4+PiA+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fc3lzZnMuYw0KPiA+Pj4+Pj4gPiBAQCAtNDA5LDYgKzQw
OSwzMCBAQCB2b2lkIGRybV9zeXNmc19ob3RwbHVnX2V2ZW50KHN0cnVjdA0KPiA+Pj4+Pj4gZHJt
X2RldmljZSAqZGV2KQ0KPiA+Pj4+Pj4gPsKgwqAgfQ0KPiA+Pj4+Pj4gPsKgwqAgRVhQT1JUX1NZ
TUJPTChkcm1fc3lzZnNfaG90cGx1Z19ldmVudCk7DQo+ID4+Pj4+PiA+DQo+ID4+Pj4+PiA+ICsv
KioNCj4gPj4+Pj4+ID4gKyAqIGRybV9zeXNmc19yZXNldF9ldmVudCAtIGdlbmVyYXRlIGEgRFJN
IHVldmVudCB0byBpbmRpY2F0ZQ0KPiA+Pj4+Pj4gR1BVIHJlc2V0DQo+ID4+Pj4+PiA+ICsgKiBA
ZGV2OiBEUk0gZGV2aWNlDQo+ID4+Pj4+PiA+ICsgKiBAcGlkOiBUaGUgcHJvY2VzcyBJRCBpbnZv
bHZlIHdpdGggdGhlIHJlc2V0DQo+ID4+Pj4+PiA+ICsgKiBAZmxhZ3M6IEFueSBvdGhlciBpbmZv
cm1hdGlvbiBhYm91dCB0aGUgR1BVIHN0YXR1cw0KPiA+Pj4+Pj4gPiArICoNCj4gPj4+Pj4+ID4g
KyAqIFNlbmQgYSB1ZXZlbnQgZm9yIHRoZSBEUk0gZGV2aWNlIHNwZWNpZmllZCBieSBAZGV2LiBU
aGlzDQo+ID4+Pj4+PiBpbmRpY2F0ZXMNCj4gPj4+Pj4+ID4gKyAqIHVzZXIgdGhhdCBhIEdQVSBy
ZXNldCBoYXMgb2NjdXJyZWQsIHNvIHRoYXQgdGhlIGludGVyZXN0ZWQNCj4gPj4+Pj4+IGNsaWVu
dA0KPiA+Pj4+Pj4gPiArICogY2FuIHRha2UgYW55IHJlY292ZXJ5IG9yIHByb2ZpbGluZyBtZWFz
dXJlLCB3aGVuIHJlcXVpcmVkLg0KPiA+Pj4+Pj4gPiArICovDQo+ID4+Pj4+PiA+ICt2b2lkIGRy
bV9zeXNmc19yZXNldF9ldmVudChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB1aW50NjRfdA0KPiA+
Pj4+Pj4gcGlkLCB1aW50MzJfdCBmbGFncykNCj4gPj4+Pj4+ID4gK3sNCj4gPj4+Pj4+ID4gK8Kg
wqDCoMKgIHVuc2lnbmVkIGNoYXIgcGlkX3N0clsyMV0sIGZsYWdzX3N0clsxNV07DQo+ID4+Pj4+
PiA+ICvCoMKgwqDCoCB1bnNpZ25lZCBjaGFyIHJlc2V0X3N0cltdID0gIlJFU0VUPTEiOw0KPiA+
Pj4+Pj4gPiArwqDCoMKgwqAgY2hhciAqZW52cFtdID0geyByZXNldF9zdHIsIHBpZF9zdHIsIGZs
YWdzX3N0ciwgTlVMTCB9Ow0KPiA+Pj4+Pj4gPiArDQo+ID4+Pj4+PiA+ICvCoMKgwqDCoCBEUk1f
REVCVUcoImdlbmVyYXRpbmcgcmVzZXQgZXZlbnRcbiIpOw0KPiA+Pj4+Pj4gPiArDQo+ID4+Pj4+
PiA+ICvCoMKgwqDCoCBzbnByaW50ZihwaWRfc3RyLCBBUlJBWV9TSVpFKHBpZF9zdHIpLCAiUElE
PSVsdSIsIHBpZCk7DQo+ID4+Pj4+PiA+ICvCoMKgwqDCoCBzbnByaW50ZihmbGFnc19zdHIsIEFS
UkFZX1NJWkUoZmxhZ3Nfc3RyKSwgIkZMQUdTPSV1IiwNCj4gPj4+Pj4+IGZsYWdzKTsNCj4gPj4+
Pj4+ID4gKyBrb2JqZWN0X3VldmVudF9lbnYoJmRldi0+cHJpbWFyeS0+a2Rldi0+a29iaiwgS09C
Sl9DSEFOR0UsDQo+IGVudnApOw0KPiA+Pj4+Pj4gPiArfQ0KPiA+Pj4+Pj4gPiArRVhQT1JUX1NZ
TUJPTChkcm1fc3lzZnNfcmVzZXRfZXZlbnQpOw0KPiA+Pj4+Pj4gPiArDQo+ID4+Pj4+PiA+wqDC
oCAvKioNCj4gPj4+Pj4+ID7CoMKgwqAgKiBkcm1fc3lzZnNfY29ubmVjdG9yX2hvdHBsdWdfZXZl
bnQgLSBnZW5lcmF0ZSBhIERSTSB1ZXZlbnQNCj4gPj4+Pj4+IGZvciBhbnkgY29ubmVjdG9yDQo+
ID4+Pj4+PiA+wqDCoMKgICogY2hhbmdlDQo+ID4+Pj4+PiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2RybS9kcm1fc3lzZnMuaCBiL2luY2x1ZGUvZHJtL2RybV9zeXNmcy5oDQo+ID4+Pj4+PiA+IGlu
ZGV4IDYyNzNjYWM0NGU0Ny4uNjNmMDBmZTgwNTRjIDEwMDY0NA0KPiA+Pj4+Pj4gPiAtLS0gYS9p
bmNsdWRlL2RybS9kcm1fc3lzZnMuaA0KPiA+Pj4+Pj4gPiArKysgYi9pbmNsdWRlL2RybS9kcm1f
c3lzZnMuaA0KPiA+Pj4+Pj4gPiBAQCAtMiw2ICsyLDggQEANCj4gPj4+Pj4+ID7CoMKgICNpZm5k
ZWYgX0RSTV9TWVNGU19IXw0KPiA+Pj4+Pj4gPsKgwqAgI2RlZmluZSBfRFJNX1NZU0ZTX0hfDQo+
ID4+Pj4+PiA+DQo+ID4+Pj4+PiA+ICsjZGVmaW5lIERSTV9HUFVfUkVTRVRfRkxBR19WUkFNX1ZB
TElEICgxIDw8IDApDQo+ID4+Pj4+PiA+ICsNCj4gPj4+Pj4+ID7CoMKgIHN0cnVjdCBkcm1fZGV2
aWNlOw0KPiA+Pj4+Pj4gPsKgwqAgc3RydWN0IGRldmljZTsNCj4gPj4+Pj4+ID7CoMKgIHN0cnVj
dCBkcm1fY29ubmVjdG9yOw0KPiA+Pj4+Pj4gPiBAQCAtMTEsNiArMTMsNyBAQCBpbnQgZHJtX2Ns
YXNzX2RldmljZV9yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlDQo+ID4+Pj4+PiAqZGV2KTsNCj4gPj4+
Pj4+ID7CoMKgIHZvaWQgZHJtX2NsYXNzX2RldmljZV91bnJlZ2lzdGVyKHN0cnVjdCBkZXZpY2Ug
KmRldik7DQo+ID4+Pj4+PiA+DQo+ID4+Pj4+PiA+wqDCoCB2b2lkIGRybV9zeXNmc19ob3RwbHVn
X2V2ZW50KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYpOw0KPiA+Pj4+Pj4gPiArdm9pZCBkcm1fc3lz
ZnNfcmVzZXRfZXZlbnQoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdWludDY0X3QNCj4gPj4+Pj4+
IHBpZCwgdWludDMyX3QgcmVzZXRfZmxhZ3MpOw0KPiA+Pj4+Pj4gPsKgwqAgdm9pZCBkcm1fc3lz
ZnNfY29ubmVjdG9yX2hvdHBsdWdfZXZlbnQoc3RydWN0IGRybV9jb25uZWN0b3INCj4gPj4+Pj4+
ICpjb25uZWN0b3IpOw0KPiA+Pj4+Pj4gPsKgwqAgdm9pZCBkcm1fc3lzZnNfY29ubmVjdG9yX3N0
YXR1c19ldmVudChzdHJ1Y3QgZHJtX2Nvbm5lY3Rvcg0KPiA+Pj4+Pj4gKmNvbm5lY3RvciwNCj4g
Pj4+Pj4+ID7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZHJtX3Byb3BlcnR5DQo+ID4+Pj4+PiAq
cHJvcGVydHkpOw0KPiA+DQo=
