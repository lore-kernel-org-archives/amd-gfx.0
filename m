Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD96C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 02:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 851DB10E333;
	Tue, 20 Dec 2022 02:36:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55E1410E333
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 02:36:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwbzwEnL65GMo9gNpFRnLJ/NTmfQ6MwWDsYLr23o9gYarhbSJQgQ7ofP1jTilk4w6+fM40WLG1Kqj1c0o/6URCzFGh1YO+4H0CX+NhnPtE/as06krFmxbdp/wXXt0O+42m0daJE79Yb/+a3A7WhnYqxnIZd8NMO9UafCH9/DNN+lZPASwYkKY6ZMAjEBikNWrPvhzJ2MRlP1knLqaVXNAoN2gqtOCEYbSLj93Eel3sHAkopz4RXKiC9dKHom5RE46O1jZFWhiMALJfAGoSH1jpw6tBYMVkE0S8NhnLeRicqVK5+NuZC20uEjRt5Ecs2ZBUugW8w1L1iBaiQxWqTLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCRUKoo5e+jxQlSh2Vz3ZB0akF3UurX3TiAPzQLrLf4=;
 b=JDkIw9g1ce2w+T73i58vdoNNdfWa6vehARkUp7GI7OUtrIbxojmhhxgqdOfAo7vL76jLWteMRWhbU0Si1dOgDdt4Kll2ecAD3BalkIicxO3ZIPY5b7pMAtm0KAUsOi6FKsoxDsdjh49Ll4mWjdpf0hrisIU4L/U3hba2n9g+95OtHal4u/xdoQjnoHDDQkU3o4YUJyC4qZWnFamfN0lktN3LgT7IIL96FQI1oI+NCGqWAPKTYjRbZVVRl5s4dAD723iz+tZfEGI/r6Q9V15pQDhQ+6HkkjaH8MqvtftakXLJp0QKxTW2nb1RS2nvFpTvIfyr2BEtuw6lS77TxRxDpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCRUKoo5e+jxQlSh2Vz3ZB0akF3UurX3TiAPzQLrLf4=;
 b=An/VS3iINr4eC7jkU8LjihJPGjx+FtuzZIoE3Rzzw3d107ixglceaArhWA2j3vpv8KiRr1OLDK45yYmpRlegdePihbdiGs0g+6IIfu4Lb6++uHjODes9Lfl11zkc9AwaEEan9Nxj6X+kavwUEUDBr7qdq1bQqnMT/7gTntNb3ik=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 02:36:21 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::4f1e:aef7:ec11:e1f1]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::4f1e:aef7:ec11:e1f1%2]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 02:36:21 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: drm/amdgpu: skip mes self test after s0i3 resume for MES IP v11.0
Thread-Topic: drm/amdgpu: skip mes self test after s0i3 resume for MES IP v11.0
Thread-Index: AQHZE72WD4APFB6HRkmovzEbywejia52DyQQ
Date: Tue, 20 Dec 2022 02:36:20 +0000
Message-ID: <BY5PR12MB3873B32F8845FCFECC2B69E3F6EA9@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20221219121252.2567663-1-tim.huang@amd.com>
 <b9a7bd1b-2bea-b9a4-ff80-86872c47c599@amd.com>
In-Reply-To: <b9a7bd1b-2bea-b9a4-ff80-86872c47c599@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bb43fa83-b155-4ad6-a79e-d94bc9bebfe0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-20T02:32:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|SN7PR12MB7953:EE_
x-ms-office365-filtering-correlation-id: 5a5f011b-5c45-4636-505c-08dae232fac5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z0EaFlXwBmGBdaoi+GQ974zxvZCDX7AFq/FrQO63k1xhsVAL+Bu7gjgL9UMe/hYUV+uxIu55CHyAUgC+FGi5mW7olPoH2D4m+hc/1EE//Mq2r9y3V2TE8ZbTckRjLYvw9AyA8TFLEO7ovNrUWttTU+kvSuvAwwvpSulBmEPO6X3GYzYRapmyUEGhq/mNdYHEX4oAgpXGnbkhpO9Nltta3VJ7/h7oXPahDe+GOyzYGPoJtrqvSYfQTEFyGus9bMuWaP8w9QE0YItqqJRSRVAjRgVr8FRDzN/zJ0f4GQKLGAZBvdsA07UNv2zg26uAWVPs7sfWU8O2vslt+0WQnq6yjcoXKOceioQY+VTbKhYtEBhJntnzfq0p5RdJAyn/wCtcv4BvEkHn9ZujpVdS/DHXVZzzA12YXRpg1Xs44Da39ePhSAF7YEFvfTGemP/6IiOKTyUtk3Cds2hjFsfuIRAcDUPNQBG5K902Xe1NBYapjsDGi8/3T43ChJzY6LIOU6O9PG3ExnErfz0FoAZPsv3aPkQwVs9bcgsQSd46+gBRoh/Dv6OZuprY3p5GGjXwXGbbOsvKnWM4bCyNORuqCXO2Psh0vCJ3jEejNddWKHb4pn48hFcZ8B706YB3gSoZzs7KS1A8ZLlUM1+5gCw7eIZ4/A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199015)(2906002)(186003)(9686003)(6506007)(26005)(53546011)(71200400001)(66556008)(66446008)(38100700002)(66946007)(66476007)(64756008)(38070700005)(5660300002)(86362001)(52536014)(41300700001)(83380400001)(316002)(54906003)(55016003)(33656002)(110136005)(8936002)(8676002)(4326008)(122000001)(7696005)(76116006)(478600001)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czE4YjN0Wk9RVVBNTSs2SXEvTWY0dXMrdzBmcHpiNTRyWmZqNTBqVUs2T2lZ?=
 =?utf-8?B?M2pqSEFCa2h6TVVoRmxwaWsvSmh6WUVZYTdEcGZoWndXMEVXeVZkK21jUkpV?=
 =?utf-8?B?OGR2blZ2ZzhJUWc4K1UrMUtxcVhBSkE4MWdoODhBUVVIYk9nbTdkRmtncDZr?=
 =?utf-8?B?ODFvUkFyQ3YwNndiZHpyVTVVNFdpTVM1dGZPL1RXUksvbno4LzBIUTl2V2Y4?=
 =?utf-8?B?N000enZBOVBpYVRqbDBFalBhTmhzMUloTjJZeWhLdDgzTU50VjBORlVqam91?=
 =?utf-8?B?QTJqQisvRUorSU90elR1ZWZRWisrWHFSRk1MSFcwR29oUTMvV0RNeU9YN2sw?=
 =?utf-8?B?NGZQNSs2WW11dnJsUUJVait3Z0hSVkFZRkVncVB1RE9LTFJxZTl1anNOTVBD?=
 =?utf-8?B?MmJDanJIVDlISmw0aXVBUmN0b2YxcFU0RHJ2ZzBOZWlPSEFkMnErSDBHRGZB?=
 =?utf-8?B?QlJQZko0NTZScmRLYVhTOC83bTQ3dVFhNGdweVEyNldDRVBiMklKbUV5NGM1?=
 =?utf-8?B?WUJlNnAzeU5YckFXZE1hODhwYXp1OGh5V1NHVHhoM0x6U05lQ05Cdys5THFJ?=
 =?utf-8?B?M1RZYlVuNGRiYnJaZzVwK2lrSHEvRFFoMXBmbVdaK2xONlpNeWRHc3VtTm5Z?=
 =?utf-8?B?ZGdMblJtMlBOdnVXZmloU044UFloampVaTN2MUZPU1lYNGlmUWRQNk83OTBL?=
 =?utf-8?B?eElxY2xxbnNBWnhSQVdLQlVrUVVLV0VLeDcvRk9wWmlzNlU1cXlha0dDOFk1?=
 =?utf-8?B?ZU9Ta2lIUytaK2thVTdERnpDcUl2YlBkKzcwOWRaYWZoZWFCakdoS2N2YndO?=
 =?utf-8?B?MDJrUFVENzB4Uy9jZ281eWkraFdIKzV3MzY3L3V6VFd3c0thLzA0aDViT1Bz?=
 =?utf-8?B?WExTa0lycFdBK0RvbVp4cXEvSkhDQ3RQMGVzQjR2dkJOTDNleDQrY0IvOGQ4?=
 =?utf-8?B?cDVWK2RkdlQvUzFRcU84WTROUkVmOFh3WTd6aXVSSXpwNENLMVg3WEpucEpR?=
 =?utf-8?B?K1N1Mk04V0hHLzM3blIxQ0Y3RTJrNkRLSEUyMU43VjVLSWpiY3RVK1ZjU0Fp?=
 =?utf-8?B?YStoSldlZUhEWnFUb1R5YUJpSUNLalFOMEl1ejNlaVlSNXZLYkhteG4rbGhh?=
 =?utf-8?B?K0Z0d3h4SWVBaEsrUkdWdVpvMVV3ZHVLQVpLNVRWek1HaHgzQ2RNcXdRUmxa?=
 =?utf-8?B?ZGYvSEdqRllBMnh3NjRhN0xhWkF3aWRpS0RUb3E5WVNLY05CYzV5U3daM2NQ?=
 =?utf-8?B?US8wZWVOTDE0elhOb1ZSeEtjOFhXNEhZaTNGS0U3Q1VmU3docXpJa3RhV0tp?=
 =?utf-8?B?blpRSmFXeXR3YkU4TDNEQlhwdHZ6eWpmVjliSXM0ekw0VFRNSjZqNFBSdTlp?=
 =?utf-8?B?ektEVHNZME5lcm9sdFFSWEhRTktIUlA4SVlWemFBSDdWQmRVaVRiU3JxUWlL?=
 =?utf-8?B?eENuRTJSZ2F0a011VUppV1R5SHhvYjFmY2JxVWdkZm5kR3FDQTZGMHNNWFhN?=
 =?utf-8?B?WUd0T1NRUmRHMko3RUt2SmRWd0MzMjNrZElkQzRlbWVhOFNiVmd3MExjZHRp?=
 =?utf-8?B?bS9yT211RkN1OXZ2dVlRNmNzK3IxUTgxdkVNYkZPMDR2VzlsbEhpQmNvMWFM?=
 =?utf-8?B?T3VtclN4TWNvUnpKVmRTckgzZFpjdVhQUmNhNzNJRWI3V3pJcmZ6NnRUT2xn?=
 =?utf-8?B?dHFRZmJ1K3F2R2JCdDRVTCtNWnVQU1VBN0pnREpBMy9jNlVZVGxoLzg1OTRK?=
 =?utf-8?B?SWN1T3UzOGpiLzd6RjhGVTMvUDBIdnZqckxpb1JaMCtqRUxhbUJ2cktnSFpp?=
 =?utf-8?B?TVlrZElydHdKN2FWR0tLSG5EYnV5cEowR01PQjZmd3FjNmJ2clNNKzNOZUZx?=
 =?utf-8?B?VGlhVUZLa2lsWXZvM1YrYkkyUk1NMWlsVjVORUs2RU53NXFFZVVHNFNWL0hi?=
 =?utf-8?B?MTNhT08rc1owTlNscmpvYjZ4SUtoaFlua09KYzJ2RFZqYjJWd3N5YVdDWFVj?=
 =?utf-8?B?SVkvS1A0aVpxaFhDTzBKRUY5ZVUwZGtZSXc2V24yUXdQVGFXZG5UYm9YT3hr?=
 =?utf-8?B?UTc0YVVXYjlXTkxPZ0tlRENTQzVrQ0FlVUJHSkU0M2xzY1o3M2hrYjN1MTV0?=
 =?utf-8?Q?vYDkl7F5+jgCvguC0M0q4q1Tg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5f011b-5c45-4636-505c-08dae232fac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 02:36:20.9198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MKrRy75TpFyENdf8E1k2zZFj7UmftQOPtUnTjjBheFsVfXWRY/S49FfwhSAKmpKuq2l8YhUIdANdj6csKL4gdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953
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
 Yifan" <Yifan1.Zhang@amd.com>, "Ma, Li" <Li.Ma@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hcmlvLA0KDQpDb21tZW50
cyBpbmxpbmUuIFRoYW5rcy4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExp
bW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NClNlbnQ6IE1vbmRh
eSwgRGVjZW1iZXIgMTksIDIwMjIgMTE6MjIgUE0NClRvOiBIdWFuZywgVGltIDxUaW0uSHVhbmdA
YW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIFlpZmFuIDxZaWZhbjEu
WmhhbmdAYW1kLmNvbT47IE1hLCBMaSA8TGkuTWFAYW1kLmNvbT47IER1LCBYaWFvamlhbiA8WGlh
b2ppYW4uRHVAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBkcm0vYW1kZ3B1OiBza2lwIG1lcyBzZWxm
IHRlc3QgYWZ0ZXIgczBpMyByZXN1bWUgZm9yIE1FUyBJUCB2MTEuMA0KDQpPbiAxMi8xOS8yMDIy
IDA2OjEyLCBUaW0gSHVhbmcgd3JvdGU6DQo+IE1FUyBpcyBwYXJ0IG9mIGdmeG9mZiBmb3IgUzBp
MyBhbmQgZG9lcyBub3QgcmVxdWlyZSBzZWxmLXRlc3QgYWZ0ZXIgUzBpMy4NCj4gQmVzaWRlcywg
c2VsZi10ZXN0IHdpbGwgZnJlZSB0aGUgQk8gdGhhdCB0cmlnZ2VycyBhIHdyYW5pbmcgd2hpbGUg
aW4NCj4gdGhlIHN1c3BlbmQgc3RhdGUuDQo+DQo+IFsgICA4MS42NTYwODVdIFdBUk5JTkc6IENQ
VTogMiBQSUQ6IDE1NTAgYXQgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVj
dC5jOjQyNSBhbWRncHVfYm9fZnJlZV9rZXJuZWwrMHhmYy8weDExMCBbYW1kZ3B1XQ0KPiBbICAg
ODEuNjc5NDM1XSBDYWxsIFRyYWNlOg0KPiBbICAgODEuNjc5NzI2XSAgPFRBU0s+DQo+IFsgICA4
MS42Nzk5ODFdICBhbWRncHVfbWVzX3JlbW92ZV9od19xdWV1ZSsweDE3YS8weDIzMCBbYW1kZ3B1
XQ0KPiBbICAgODEuNjgwODU3XSAgYW1kZ3B1X21lc19zZWxmX3Rlc3QrMHgzOTAvMHg0MzAgW2Ft
ZGdwdV0NCj4gWyAgIDgxLjY4MTY2NV0gIG1lc192MTFfMF9sYXRlX2luaXQrMHgzNy8weDUwIFth
bWRncHVdDQo+IFsgICA4MS42ODI0MjNdICBhbWRncHVfZGV2aWNlX2lwX2xhdGVfaW5pdCsweDUz
LzB4MjgwIFthbWRncHVdDQo+IFsgICA4MS42ODMyNTddICBhbWRncHVfZGV2aWNlX3Jlc3VtZSsw
eGFlLzB4MmEwIFthbWRncHVdDQo+IFsgICA4MS42ODQwNDNdICBhbWRncHVfcG1vcHNfcmVzdW1l
KzB4MzcvMHg3MCBbYW1kZ3B1XQ0KPiBbICAgODEuNjg0ODE4XSAgcGNpX3BtX3Jlc3VtZSsweDVj
LzB4YTANCj4gWyAgIDgxLjY4NTI0N10gID8gcGNpX3BtX3RoYXcrMHg5MC8weDkwDQo+IFsgICA4
MS42ODU2NThdICBkcG1fcnVuX2NhbGxiYWNrKzB4NGUvMHgxNjANCj4gWyAgIDgxLjY4NjExMF0g
IGRldmljZV9yZXN1bWUrMHhhZC8weDIxMA0KPiBbICAgODEuNjg2NTI5XSAgYXN5bmNfcmVzdW1l
KzB4MWUvMHg0MA0KPiBbICAgODEuNjg2OTMxXSAgYXN5bmNfcnVuX2VudHJ5X2ZuKzB4MzMvMHgx
MjANCj4gWyAgIDgxLjY4NzQwNV0gIHByb2Nlc3Nfb25lX3dvcmsrMHgyMWQvMHgzZjANCj4gWyAg
IDgxLjY4Nzg2OV0gIHdvcmtlcl90aHJlYWQrMHg0YS8weDNjMA0KPiBbICAgODEuNjg4MjkzXSAg
PyBwcm9jZXNzX29uZV93b3JrKzB4M2YwLzB4M2YwDQo+IFsgICA4MS42ODg3NzddICBrdGhyZWFk
KzB4ZmYvMHgxMzANCj4gWyAgIDgxLjY4OTE1N10gID8ga3RocmVhZF9jb21wbGV0ZV9hbmRfZXhp
dCsweDIwLzB4MjANCj4gWyAgIDgxLjY4OTcwN10gIHJldF9mcm9tX2ZvcmsrMHgyMi8weDMwDQo+
IFsgICA4MS42OTAxMThdICA8L1RBU0s+DQo+IFsgICA4MS42OTAzODBdIC0tLVsgZW5kIHRyYWNl
IDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KDQpJcyB0aGlzIHN0aWxsIG5lZWRlZCB3aXRoIGh0dHBz
Oi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9wYXRjaC81MTUyNzgvID8NCg0KUGF0Y2ggNTE1
Mjc4IHNraXBwZWQgdGhlIE1FUyBzdXNwZW5kIGFuZCByZXN1bWUsIEJ1dCB0aGUgc2VsZi10ZXN0
IHN0aWxsZWQgYmUgY2FsbGVkIGJ5IGlwIGxhdGUgaW5pdC4gIFBsZWFzZSBnZXQgZGV0YWlsIGZv
ciBwYXRjaCB2Mi4NCj4NCj4gU2lnbmVkLW9mZi1ieTogVGltIEh1YW5nIDx0aW0uaHVhbmdAYW1k
LmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMV8wLmMg
fCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjExXzAu
Yw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTFfMC5jDQo+IGluZGV4IDU0
NTkzNjZmNDlmZi4uODBlOGNmODI2ZTcxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9tZXNfdjExXzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9tZXNfdjExXzAuYw0KPiBAQCAtMTM0Miw3ICsxMzQyLDcgQEAgc3RhdGljIGludCBtZXNfdjEx
XzBfbGF0ZV9pbml0KHZvaWQgKmhhbmRsZSkNCj4gICB7DQo+ICAgICAgIHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOw0KPg0KPiAtICAg
ICBpZiAoIWFtZGdwdV9pbl9yZXNldChhZGV2KSAmJg0KPiArICAgICBpZiAoIWFtZGdwdV9pbl9y
ZXNldChhZGV2KSAmJiAhYWRldi0+aW5fc3VzcGVuZCAmJg0KDQpJIHRoaW5rIGluIHRoaXMgY2Fz
ZSB5b3Ugc2hvdWxkIGJlIHVzaW5nIGFkZXYtPmluX3MwaXggaW5zdGVhZC4NCg0KWWVzLCBhZGV2
LT5pbl9zMGl4IHNob3VsZCBiZSBiZXR0ZXIsIHRoYW5rcyBmb3IgcG9pbnRpbmcgdGhhdCBvdXQu
DQoNCj4gICAgICAgICAgIChhZGV2LT5pcF92ZXJzaW9uc1tHQ19IV0lQXVswXSAhPSBJUF9WRVJT
SU9OKDExLCAwLCAzKSkpDQo+ICAgICAgICAgICAgICAgYW1kZ3B1X21lc19zZWxmX3Rlc3QoYWRl
dik7DQo+DQoNCg0K
