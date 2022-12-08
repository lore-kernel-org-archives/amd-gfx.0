Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404A1C3A5A7
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 04:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4769310E1BC;
	Thu,  8 Dec 2022 04:11:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E93BF10E1BC;
 Thu,  8 Dec 2022 04:10:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aipd1YLYoAoRTcIuon2yhKP4qeLieEnSWQfJF9EspDBbeSRI3QJBN0voSKBtWTCn8A/jQp6SFQlFEGRj210gEOYzE2NfT3eCy9ukNtAdK3lqEvuwYDZ5fodzdDMRUzIfbTDUAZYPNasNNYhj2xVWpf/b0zH0SUqvIjKT8s3+qHnhq4VernCye8NcpkaKQmp2C07hbR3K34bi7ASL3IOLxCOjKR9cxt6CrGglPDiVpnxbqJuXnf7sFkTTWbZHqg+iM29jiBOjCZhsMB65eEsWJ8S4mdLbXgNsMG3Eyhm9s4n/CrQNkF2LqZf9OG9XRzEVyk81xpO0yyxKSEN0fcBsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYpIuxdkSWXuRcHvXaMaM3h80H0DMU8zbXv9Tt5ZDso=;
 b=PqhEs9hryGX7RuL2P7aAbDi9ApA3naM2ccWvc1dSOs+9elfnSyFzbd51DFsQjKxtvBchvBAcOx05VimLUeM32RESH/+TJilBGZOvkGTpcdQBlPJpNLKVKisrjxaJrZvNgy3n8C8XFZJJUlFAKC2pXuV0YI9CsBqLiolaSmwN2nGy5ER/L9gJu5M/nsW2xM9dQ2ys2g4l5mlpULlQC/bv9yzVxR47goRoiet51i87FUuOtD+sxe2D9U5Lqr705Q4AgOkR4u5bcUyaRcstW75vXxsB4r24YS1vX4Il8L+VXKoyNTM3jGHmauTndx/DaAuKYSObk5jX918wMLWmz9pDBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYpIuxdkSWXuRcHvXaMaM3h80H0DMU8zbXv9Tt5ZDso=;
 b=Y6oIqVwN9/dDro+5mvnxG3oUHBUBFEBDSwDPpLU0XKFZaqC+4zdpfsbyoGSE/4U3ELGP/0YCfkw4tLpV2zpJk8lL7OmCedYcbjckt/qzl6gAHscFfPFFgRIvrokunRaouSeDTTgS4DV53XUNGVb5FyeWzTrEpPaI+aLUrqsuEyg=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by BN9PR12MB5051.namprd12.prod.outlook.com (2603:10b6:408:134::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 04:10:53 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::863a:8b00:6eae:5276]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::863a:8b00:6eae:5276%3]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 04:10:53 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
 <ckoenig.leichtzumerken@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer failed
Thread-Topic: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer
 failed
Thread-Index: AdkKDSDFxSlpkC5gTnSZE4zebcKC0wAQPv2AAABvKoAAAIkXgAAAfQYAAACNQwAAABRqgAAAW36AABiUhGA=
Date: Thu, 8 Dec 2022 04:10:53 +0000
Message-ID: <CY5PR12MB6369519F1EABAE9A86957850C11D9@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <DM4PR12MB51524585CEC4E2B4B8370874E31A9@DM4PR12MB5152.namprd12.prod.outlook.com>
 <CADnq5_NWr9SAzcQ=x-UVXWHDBci6f_pg-sRj3AD8q5GWYbBJOw@mail.gmail.com>
 <4e415872-3fcf-27b9-dc74-b3e86f171e1c@gmail.com>
 <CADnq5_PShNRZUwvnsTawW1OaCOjK73rdKTxxQhA=Znf2gqbJ=Q@mail.gmail.com>
 <ce75ecb5-1d07-d8a6-2722-59da84c22c10@gmail.com>
 <CADnq5_Mo_hmc7SCYJxQHc-TgdzXS7+YD-SUt9aF-Gx2AovriRw@mail.gmail.com>
 <581403d1-f5f3-72a6-5447-6deef4405d47@gmail.com>
 <CADnq5_OtFeSYKKjniNXuXUmX4WgXw1+hN-3YoRpBh-Ytjosv5g@mail.gmail.com>
In-Reply-To: <CADnq5_OtFeSYKKjniNXuXUmX4WgXw1+hN-3YoRpBh-Ytjosv5g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-08T04:04:53Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d54dd691-19fe-4fdc-834c-bb20f1421c79;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-08T04:10:49Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: ea7a2d33-3885-4b63-893b-fe03e973c72c
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|BN9PR12MB5051:EE_
x-ms-office365-filtering-correlation-id: e0e63915-825b-490a-c907-08dad8d232c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ijzhkdkwcLlKojihVI2ZZg5dCN9Sbbkn9XkHU540It26xjR7I03RyyQ6Y5U1E1L8nXga5rDStqF9fYxZf/+BAvM90HaEHeEq3/vYnhB2jxjWgKkgJ6EnyN67jwKE0rhMOuZzFyBg9g3VvSmJsSJVxxaoa8D1keizQj4oPEuGEUMmCsK8TyuJ56a5/rFZ/sqS/GHMuaaOrpobqMx5GulAAYXDzK7QXqD5Uk8ZtTCY65cgcwanc+1I5IM7POQ/3Syd3Ed39ICk1HGeQ83ITG5jXBS6lyp/PX8b3JRQFb57eevB7HB/J5NY7+3KrHBjIQR23WvJIyuOsRLgoFDrjQ8tsXcJikMFQFa5pGPFkYFO2L1WtetsoYE42+921bolR4j1TBYd7NupdZGdJuHWCnCuXDodGuW/GFR/PWxXFyZRzJQXz2l9mm15VMrkDC30rjyy1bnHzU4PaeL6BzZaOKHpHmJ5i05QCw3fAlkr7S0pK0Pj91yTBD7rL17x2FvHvrkIfWNI6RGsgb8lfXX+yETMhN3aCB42+5NMichxR7I7nonYN8mqBfqi6Ue51wTz3Bl552XLw4YE2zpejDzhQCVgQdkheiuHL5r+byJ1ww48ZKHRNCpmdx9AnM2IG6IPxQZYRwr+ql13+DD0sfzS4XH4ztcnKdHvixg6d+dCNGscV6xnl7mgotszuDIffLXm3WE45uCZzP33yCFANxHhsdOcATgI3yvLzxj+AZZi5EMz78Iilq+HxEKld6OmuIM0Mct
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199015)(316002)(110136005)(38100700002)(66446008)(54906003)(38070700005)(122000001)(8676002)(99936003)(76116006)(66556008)(66476007)(66946007)(64756008)(4326008)(9686003)(33656002)(53546011)(66574015)(86362001)(41300700001)(83380400001)(478600001)(2906002)(5660300002)(26005)(7696005)(8936002)(52536014)(55016003)(71200400001)(186003)(6506007)(414714003)(473944003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUNvcVhVM1I0eVR1Nm1HWkQvRjJWK3dIcmMzeDdtdGhPQkdpRzBvQ2JhellD?=
 =?utf-8?B?d2E5QWxDQWJJbi8ySzJEVVM4ZkNzMXFiYkNOOUVoOE1iSy9DeU56WEFXaUl3?=
 =?utf-8?B?eFJSdG1rdGI5Y3hhZzhvMlAvNWFucWJCbkFOcnZ6akZXeXZNMFFjR3JOcUsx?=
 =?utf-8?B?UGhQd3kvcWEyMFZpU25HSDVTSUxxaDJqVmR5aDN2aS9CM0cvbjY4bFMyWFZr?=
 =?utf-8?B?RzBBa0g3MkxZN3ZoTzczQ2hrOUdIV2cwclJtKzkzaFl6Y1NwTU84NGdmZnUx?=
 =?utf-8?B?V2VkVVpNcDg2cEszQzBRSWFnWjVobExxczBUL1RrVXR1Y2QzUGlSajZ5d01j?=
 =?utf-8?B?ZnRqRTU1VHQ4bXpDTVdzbGIxdHV4d3BmWkVoNGppdnF5RndnSjRtRk04Vk9E?=
 =?utf-8?B?WFkxYW54ZEt6U3UwUlE5dHhjUWRaVWxXMmxnTmtEYXJEMHhEcEVXNXk1RnlR?=
 =?utf-8?B?MC9yMXBLOEVoNW1KcGY1TEhWbnY3RmhPb0c4SEFEVVZ1SkxoRG1HWnp2Qk9l?=
 =?utf-8?B?SVZKclphWlMySG1pcGpmc05ha0tPNDBJeTA0d3dmb0c2Mm9ieXdsbDN5blUy?=
 =?utf-8?B?VlRabkhZeW1OR0tJbS91UCtBSUxsbmIvWjFPbGlWOWIxZ3ZySE1xN2d5U2I3?=
 =?utf-8?B?bFlrOS9HRUN5VXUxcWFLQy85dDNkM2RvMkVQOVQ5LzZ0Q2JCd0tKWlFSZFFJ?=
 =?utf-8?B?UGVqZVI5OVl5V2pvTHY1b2lYQThjbDB5dmR6ZmRacGRzOFJHTXVlQUMwY2E0?=
 =?utf-8?B?QjZVN0tjbkZyb3h4YWlPZ0oxcHl3VHYrcnYzREJWa21lbTBhTlRCL2xRZG8v?=
 =?utf-8?B?THBJMzBQQW5wak1tVG44T2xIa09JRXNWY0k2aFE2MmNDM3dIbysxWjE0a1Ns?=
 =?utf-8?B?MFlIUlRaTkVud3VlbWFVblMwOVBQSU9OZ0FtQ0s3YkpmaWZJdmZ2a1lsaUZT?=
 =?utf-8?B?SUEvS2xpc2dybGtwRXdFTS8wLzdtQjNscXZlY0NnRzhwQjMxTlJ2UUZNRTZX?=
 =?utf-8?B?YnlETE00dmhmSkdad243b2hwUmdiajNyaFl5OGJ4K1hzeVVPd2drSTFxNHVa?=
 =?utf-8?B?UDEweXZBNlNSSjZlcVN0SWtNQlJzNWlyWTBxemZyUmNLaVlURVFFSVVKNTB6?=
 =?utf-8?B?cm1seld6TmNILyswLzNJSmg5WVRyT1dydXpNZFhUQ0JmUjVtSUlpN2tueDM1?=
 =?utf-8?B?SEVnUmRLc0NVMFA2Q0xCZVRuL2kvTU5oZklqM0Fmai85YXNUaUtKNmNnbUdC?=
 =?utf-8?B?bzRvQUVQR1IvbXBhT0g4V1YzQnJGL2lzUUNueHNwdWw5SVYyTDBreU1IWFl5?=
 =?utf-8?B?VzI4d1dqU2F6czI1Rk9kUFFFUjFaSmtmVzkraC92T2taWUNacGxXTG5DN2Q3?=
 =?utf-8?B?bmF2djdNUk1hT1U0MWpYMHE0YWJUU2FVRzdMQ05zbzVZVWgyeTFORmNzSzk2?=
 =?utf-8?B?UHQ5WXVpTG9md0FMWHBRZ3pqeHk5amo1UVZBVkRPWWlRVGxNeS9yRW8rTlZp?=
 =?utf-8?B?Nm4xS0NIcE9wS0hEczl4bTRlVWNFd2lwSUdoSE1Qd2dCbHBUN3JQM3p5OWwy?=
 =?utf-8?B?c0FBTUVJSXFYWFErWTZ6WmZiRkRBQVN1TXhBSXFKRHUyc0k4MGZjcmZ6NnZ4?=
 =?utf-8?B?ZC8xOE1mVGpicVUvZTcrNjJyOEZteGJLSlFGbUdLK1YvNmhqL2pCcHROM1Vq?=
 =?utf-8?B?MnNlemkxOE05ajhFYXE5K0Vta2VnUkFYaVYxcEZkZVBCMWFxVUtzZWxua002?=
 =?utf-8?B?d3pPMXd5SXExVlNWRDBiSXZpamp3SUl4STlkY01IZG1VNnpiQkhVcUlJcGFa?=
 =?utf-8?B?cjc1bk03cllJZmlERWN2SC9QdFpvTENYTHplUHZWeFlGR0JTUDAwWEpUKzdS?=
 =?utf-8?B?NUZ0bDFlNGNIZGQ2UFNjbjI5Smw2ZGxEVGVnNWxHMzViMXpPRUFXd21PNUw2?=
 =?utf-8?B?NmVkRDhtY3hKMHVJTVh3VGIvOWR6ZGJwR1lnUDFjNjJvcEV5NzEvRmxORGhn?=
 =?utf-8?B?ZTAyTzNneVN4aTc1RGc5aThNaXpHZ0FnSjdaK0NNWUtzc013bHIrT25jdWg3?=
 =?utf-8?B?SEZSUWJHRHc1eFBRbVlZK2NCUjk1WkpYMUxjejlmS2cxb3RTMWQ5Z0dOYytY?=
 =?utf-8?Q?pJTI=3D?=
Content-Type: multipart/mixed;
 boundary="_002_CY5PR12MB6369519F1EABAE9A86957850C11D9CY5PR12MB6369namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e63915-825b-490a-c907-08dad8d232c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 04:10:53.2089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i3FwolyKWsVzY3QS0QoU1LuVZ4Kw4IOIJ0tCzc4IXjyoLX4bN9sizRx10MDSbfBC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5051
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
Cc: amd-gfx <amd-gfx-bounces@lists.freedesktop.org>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>, "Zhang,
 Jesse\(Jie\)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_002_CY5PR12MB6369519F1EABAE9A86957850C11D9CY5PR12MB6369namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEFsZXgsDQoNCldlIG5lZWQg
dG8gYWRqdXN0IHRoZSBBTURHUFVfU0dfVEhSRVNIT0xEIGFzIHdlbGwgc2luY2UgcmVjZW50IEFQ
VXMgYXJlIGNvbmZpZ3VyZWQgdy8gNTEyTUIgVlJBTS4gUGxzIGNoZWNrIGF0dGFjaGVkIHBhdGNo
Lg0KDQpCZXN0IFJlZ2FyZHMsDQpZaWZhbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IA0KU2VudDogVGh1cnNk
YXksIERlY2VtYmVyIDgsIDIwMjIgMTI6MjEgQU0NClRvOiBDaHJpc3RpYW4gS8O2bmlnIDxja29l
bmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4NCkNjOiBaaGFuZywgSmVzc2UoSmllKSA8SmVz
c2UuWmhhbmdAYW1kLmNvbT47IFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFtZC5jb20+OyBh
bWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsgUGFuZWVyIFNl
bHZhbSwgQXJ1bnByYXZpbiA8QXJ1bnByYXZpbi5QYW5lZXJTZWx2YW1AYW1kLmNvbT47IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQu
Y29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogdHJ5IGFsbG93ZWQgZG9tYWlu
IHdoZW4gcGluIGZyYW1lYnVmZmVyIGZhaWxlZA0KDQpPbiBXZWQsIERlYyA3LCAyMDIyIGF0IDEx
OjEwIEFNIENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29t
PiB3cm90ZToNCj4NCj4NCj4NCj4gQW0gMDcuMTIuMjIgdW0gMTc6MDggc2NocmllYiBBbGV4IERl
dWNoZXI6DQo+ID4gT24gV2VkLCBEZWMgNywgMjAyMiBhdCAxMDo1MiBBTSBDaHJpc3RpYW4gS8O2
bmlnIA0KPiA+IDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+
IEFtIDA3LjEyLjIyIHVtIDE2OjM4IHNjaHJpZWIgQWxleCBEZXVjaGVyOg0KPiA+Pj4gT24gV2Vk
LCBEZWMgNywgMjAyMiBhdCAxMDoyMyBBTSBDaHJpc3RpYW4gS8O2bmlnIA0KPiA+Pj4gPGNrb2Vu
aWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToNCj4gPj4+PiBJIHdvdWxkIGdvIGEg
c3RlcCBmdXJ0aGVyIGFuZCBqdXN0IGFsbG93IEdUVCBkb21haW4gb24gQVNJQ3MgIT0gDQo+ID4+
Pj4gQ0FSUklaTw0KPiA+Pj4+IHwgU1RPTkVZLg0KPiA+Pj4+DQo+ID4+Pj4gSSBjYW4ndCBzZWUg
YSBnb29kIHJlYXNvbiB3ZSBzaG91bGQgc3RpbGwgaGF2ZSBhbnkgbGltaXRhdGlvbiANCj4gPj4+
PiBoZXJlLCBWUkFNIGRvZXNuJ3QgaGF2ZSBhbnkgYWR2YW50YWdlIGFueSBtb3JlIGFzIGZhciBh
cyBJIGtub3cuDQo+ID4+PiBXZWxsLCBpZiBWUkFNIGlzIGF2YWlsYWJsZSB3ZSB3YW50IHRvIG1h
a2Ugc3VyZSBzb21lb25lIHVzZXMgaXQgDQo+ID4+PiBvdGhlcndpc2UgaXQncyBqdXN0IHdhc3Rl
ZC4NCj4gPj4gV2VsbCBpdCBzdGlsbCBnZXRzIHVzZWQgd2hlbiBpdCdzIGZyZWUuIFNvIG5vdyBw
cm9ibGVtIGF0IGFsbCBoZXJlLg0KPiA+Pg0KPiA+PiBXZSBzaG91bGQganVzdCBub3QgZm9yY2Ug
YW55dGhpbmcgaW50byBWUkFNIG9yIEdUVCBhbnkgbW9yZSBpZiBpdCdzIA0KPiA+PiB0ZWNobmlj
YWxseSBub3QgbmVjZXNzYXJ5Lg0KPiA+IFNvIGp1c3QgdGhpcz8NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jDQo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMNCj4gPiBpbmRleCA5MTliYmVhMmUz
YWMuLjhlOGYwN2ZhN2E5MyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfb2JqZWN0LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfb2JqZWN0LmMNCj4gPiBAQCAtMTUwNiw3ICsxNTA2LDcgQEAgdTY0IGFtZGdwdV9i
b19ncHVfb2Zmc2V0X25vX2NoZWNrKHN0cnVjdCBhbWRncHVfYm8gKmJvKQ0KPiA+ICAgdWludDMy
X3QgYW1kZ3B1X2JvX2dldF9wcmVmZXJyZWRfZG9tYWluKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVp
bnQzMl90IGRvbWFpbikNCj4gPiAgIHsNCj4gPiAtICAgICAgIGlmIChkb21haW4gPT0gKEFNREdQ
VV9HRU1fRE9NQUlOX1ZSQU0gfCBBTURHUFVfR0VNX0RPTUFJTl9HVFQpKSB7DQo+DQo+IFdlIHN0
aWxsIG5lZWQgdG8ga2VlcCB0aGlzIGNoZWNrIHRvIGF2b2lkIHRyeWluZyB0byBhZGp1c3QgVlJB
TSBvbmx5IA0KPiBhbGxvY2F0aW9ucyAodGhlIGN1cnNvciBzdGlsbCBuZWVkcyB0aGlzIElJUkMp
Lg0KPg0KPiBBcGFydCBmcm9tIHRoYXQgSSB0aGluayB0aGF0IHNob3VsZCB3b3JrLg0KDQpBdHRh
Y2hlZC4gIFRoYW5rcywNCg0KQWxleA0KDQo+DQo+IENocmlzdGlhbi4NCj4NCj4gPiArICAgICAg
IGlmICgoYWRldi0+YXNpY190eXBlID09IENISVBfQ0FSUklaTykgfHwgKGFkZXYtPmFzaWNfdHlw
ZSA9PQ0KPiA+IENISVBfU1RPTkVZKSkgew0KPiA+ICAgICAgICAgICAgICAgICAgZG9tYWluID0g
QU1ER1BVX0dFTV9ET01BSU5fVlJBTTsNCj4gPiAgICAgICAgICAgICAgICAgIGlmIChhZGV2LT5n
bWMucmVhbF92cmFtX3NpemUgPD0gQU1ER1BVX1NHX1RIUkVTSE9MRCkNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgZG9tYWluID0gQU1ER1BVX0dFTV9ET01BSU5fR1RUOw0KPiA+DQo+ID4N
Cj4gPg0KPiA+PiBDaHJpc3RpYW4uDQo+ID4+DQo+ID4+PiBBbGV4DQo+ID4+Pg0KPiA+Pj4NCj4g
Pj4+PiBDaHJpc3RpYW4uDQo+ID4+Pj4NCj4gPj4+PiBBbSAwNy4xMi4yMiB1bSAxNjoxMCBzY2hy
aWViIEFsZXggRGV1Y2hlcjoNCj4gPj4+Pj4gRG9lcyB0aGlzIHBhdGNoIGZpeCB0aGUgcHJvYmxl
bT8NCj4gPj4+Pj4NCj4gPj4+Pj4gQWxleA0KPiA+Pj4+Pg0KPiA+Pj4+PiBPbiBXZWQsIERlYyA3
LCAyMDIyIGF0IDI6MjcgQU0gWmhhbmcsIEplc3NlKEppZSkgPEplc3NlLlpoYW5nQGFtZC5jb20+
IHdyb3RlOg0KPiA+Pj4+Pj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+ID4+
Pj4+Pg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+ICAgICAgICBkcm0vYW1kZ3B1OiB0cnkgYWxsb3dlZCBk
b21haW4gd2hlbiBwaW4gZnJhbWVidWZmZXIgZmFpbGVkLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+DQo+
ID4+Pj4+Pg0KPiA+Pj4+Pj4gICAgICAgIFtXSFkmSE9XXQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4+DQo+
ID4+Pj4+Pg0KPiA+Pj4+Pj4gICAgICAgIGluIHNvbWUgc2NlbmFyaW9zLCB0aGUgYWxsb2NhdGUg
bWVtb3J5IG9mdGVuIGZhaWxlZC4gc3VjaCBhcyBkbyBob3QgcGx1ZyBvciBwbGF5IGdhbWVzLg0K
PiA+Pj4+Pj4NCj4gPj4+Pj4+ICAgICAgICBzbyB3ZSBjYW4gdHJ5IGFsbG93ZWQgZG9tYWluLCBp
ZiB0aGUgcHJlZmVycmVkIGRvbWFpbiBjYW5ub3QgYWxsb2NhdGUgbWVtb3J5Lg0KPiA+Pj4+Pj4N
Cj4gPj4+Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gICAgICAgIFNpZ25lZC1vZmYtYnk6IGppZTF6
aGFuIGplc3NlLnpoYW5nQGFtZC5jb20NCj4gPj4+Pj4+DQo+ID4+Pj4+PiAgICAgICAgQ2hhbmdl
LUlkOiBJNGI2MmUyZmYwNzJkMDJjNTE1ZjkwMTAwMGE1Nzg5MzM5ZDQ4MTI3Mw0KPiA+Pj4+Pj4N
Cj4gPj4+Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyANCj4gPj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gaW5kZXggMWFl
MGM4NzIzMzQ4Li4wNWZjYWY3ZjlkOTIgMTAwNjQ0DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jDQo+ID4+Pj4+Pg0KPiA+
Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jDQo+
ID4+Pj4+Pg0KPiA+Pj4+Pj4gQEAgLTM5LDYgKzM5LDcgQEANCj4gPj4+Pj4+DQo+ID4+Pj4+PiAj
aW5jbHVkZSAiYW1kZ3B1LmgiDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gI2luY2x1ZGUgImFtZGdwdV90
cmFjZS5oIg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+ICNpbmNsdWRlICJhbWRncHVfYW1ka2ZkLmgiDQo+
ID4+Pj4+Pg0KPiA+Pj4+Pj4gKyNpbmNsdWRlICJhbWRncHVfZGlzcGxheS5oIg0KPiA+Pj4+Pj4N
Cj4gPj4+Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gLyoqDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gICAg
ICAqIERPQzogYW1kZ3B1X29iamVjdA0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IEBAIC05NDIsOCArOTQz
LDE0IEBAIGludCBhbWRncHVfYm9fcGluX3Jlc3RyaWN0ZWQoc3RydWN0IA0KPiA+Pj4+Pj4gYW1k
Z3B1X2JvICpibywgdTMyIGRvbWFpbiwNCj4gPj4+Pj4+DQo+ID4+Pj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBiby0+cGxhY2VtZW50c1tpXS5scGZuID0gbHBmbjsNCj4gPj4+Pj4+DQo+
ID4+Pj4+PiAgICAgICAgICAgIH0NCj4gPj4+Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4NCj4gPj4+
Pj4+ICsgICAgICAgcmV0cnk6DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gICAgICAgICAgICByID0gdHRt
X2JvX3ZhbGlkYXRlKCZiby0+dGJvLCAmYm8tPnBsYWNlbWVudCwgJmN0eCk7DQo+ID4+Pj4+Pg0K
PiA+Pj4+Pj4gICAgICAgICAgICBpZiAodW5saWtlbHkocikpIHsNCj4gPj4+Pj4+DQo+ID4+Pj4+
PiArICAgICAgICAgICAgICAgLy90cnkgYWxsb3dlZCBkb21haW4gd2hlbiBwaW4gZmFpbGVkLiBq
dXN0IGEgd29ya2Fyb3VuZC4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiArICAgICAgICAgICAgICAgaWYg
KHVubGlrZWx5KHIgPT0gLUVOT01FTSkgJiYgZG9tYWluICE9IA0KPiA+Pj4+Pj4gKyBiby0+YWxs
b3dlZF9kb21haW5zKSB7DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgYW1kZ3B1X2JvX3BsYWNlbWVudF9mcm9tX2RvbWFpbihibywgDQo+ID4+Pj4+PiArIGJvLT5h
bGxvd2VkX2RvbWFpbnMpOw0KPiA+Pj4+Pj4NCj4gPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGdvdG8gcmV0cnk7DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gKyAgICAgICAgICAgICAgIH0NCj4g
Pj4+Pj4+DQo+ID4+Pj4+PiAgICAgICAgICAgICAgICAgICAgZGV2X2VycihhZGV2LT5kZXYsICIl
cCBwaW4gZmFpbGVkXG4iLCBibyk7DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gICAgICAgICAgICAgICAg
ICAgIGdvdG8gZXJyb3I7DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gICAgICAgICAgICB9DQo+DQo=

--_002_CY5PR12MB6369519F1EABAE9A86957850C11D9CY5PR12MB6369namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-make-display-pinning-more-flexible-v3.patch"
Content-Description:  0001-drm-amdgpu-make-display-pinning-more-flexible-v3.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-make-display-pinning-more-flexible-v3.patch";
	size=2109; creation-date="Thu, 08 Dec 2022 04:04:32 GMT";
	modification-date="Thu, 08 Dec 2022 04:10:52 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwNmMzOTNlN2UwODEyMWViMjRiMDM2YWNhZWQ3YzI4ZmE0NzMxYWY3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFdlZCwgNyBEZWMgMjAyMiAxMTowODo1MyAtMDUwMApTdWJqZWN0OiBbUEFUQ0hd
IGRybS9hbWRncHU6IG1ha2UgZGlzcGxheSBwaW5uaW5nIG1vcmUgZmxleGlibGUgKHYzKQoKT25s
eSBhcHBseSB0aGUgc3RhdGljIHRocmVzaG9sZCBmb3IgU3RvbmV5IGFuZCBDYXJyaXpvLgpUaGlz
IGhhcmR3YXJlIGhhcyBjZXJ0YWluIHJlcXVpcmVtZW50cyB0aGF0IGRvbid0IGFsbG93Cm1peGlu
ZyBvZiBHVFQgYW5kIFZSQU0uICBOZXdlciBhc2ljcyBkbyBub3QgaGF2ZSB0aGVzZQpyZXF1aXJl
bWVudHMgc28gd2Ugc2hvdWxkIGJlIGFibGUgdG8gYmUgbW9yZSBmbGV4aWJsZQp3aXRoIHdoZXJl
IGJ1ZmZlcnMgZW5kIHVwLgoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBZaWZhbiBaaGFuZyA8eWlmYW4xLnpoYW5n
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggICAgICAg
IHwgMiArLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIHwgMyAr
Ky0KIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKaW5kZXggNmI3NGRmNDQ2Njk0Li5mMjMzZjFmMTk2
OGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCkBAIC0yNDQsNyArMjQ0LDcgQEAg
ZXh0ZXJuIGludCBhbWRncHVfbnVtX2tjcTsKIGV4dGVybiBpbnQgYW1kZ3B1X3ZjbmZ3X2xvZzsK
IAogI2RlZmluZSBBTURHUFVfVk1fTUFYX05VTV9DVFgJCQk0MDk2Ci0jZGVmaW5lIEFNREdQVV9T
R19USFJFU0hPTEQJCQkoMjU2KjEwMjQqMTAyNCkKKyNkZWZpbmUgQU1ER1BVX1NHX1RIUkVTSE9M
RAkJCSg1MTIqMTAyNCoxMDI0KQogI2RlZmluZSBBTURHUFVfREVGQVVMVF9HVFRfU0laRV9NQgkJ
MzA3MlVMTCAvKiAzR0IgYnkgZGVmYXVsdCAqLwogI2RlZmluZSBBTURHUFVfV0FJVF9JRExFX1RJ
TUVPVVRfSU5fTVMJICAgICAgICAzMDAwCiAjZGVmaW5lIEFNREdQVV9NQVhfVVNFQ19USU1FT1VU
CQkJMTAwMDAwCS8qIDEwMCBtcyAqLwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X29iamVjdC5jCmluZGV4IGIwYWRiMmIwMzBiNC4uZWM2MDEyYmEwODExIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCkBAIC0xNTEyLDcgKzE1MTIsOCBAQCB1
NjQgYW1kZ3B1X2JvX2dwdV9vZmZzZXRfbm9fY2hlY2soc3RydWN0IGFtZGdwdV9ibyAqYm8pCiB1
aW50MzJfdCBhbWRncHVfYm9fZ2V0X3ByZWZlcnJlZF9kb21haW4oc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsCiAJCQkJCSAgICB1aW50MzJfdCBkb21haW4pCiB7Ci0JaWYgKGRvbWFpbiA9PSAo
QU1ER1BVX0dFTV9ET01BSU5fVlJBTSB8IEFNREdQVV9HRU1fRE9NQUlOX0dUVCkpIHsKKwlpZiAo
KGRvbWFpbiA9PSAoQU1ER1BVX0dFTV9ET01BSU5fVlJBTSB8IEFNREdQVV9HRU1fRE9NQUlOX0dU
VCkpICYmCisJICAgICgoYWRldi0+YXNpY190eXBlID09IENISVBfQ0FSUklaTykgfHwgKGFkZXYt
PmFzaWNfdHlwZSA9PSBDSElQX1NUT05FWSkpKSB7CiAJCWRvbWFpbiA9IEFNREdQVV9HRU1fRE9N
QUlOX1ZSQU07CiAJCWlmIChhZGV2LT5nbWMucmVhbF92cmFtX3NpemUgPD0gQU1ER1BVX1NHX1RI
UkVTSE9MRCkKIAkJCWRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlOX0dUVDsKLS0gCjIuMzcuMwoK

--_002_CY5PR12MB6369519F1EABAE9A86957850C11D9CY5PR12MB6369namp_--
