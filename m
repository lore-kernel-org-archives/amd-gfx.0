Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7973AC7618E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 10:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE8410E48A;
	Mon, 24 Apr 2023 10:30:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7973E10E485
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 10:30:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHxIAVa6jxQi7kqYly0TJGZPOsSslqMky4QZmVw+d+MRWZVSoDvgDrXIm8qJZNzEh5KWEMPX0D7kfD01aCaNzF+e/mvPkzkgyBMSoJ5TzXNdCl4dYD6ZemFh2tb9OAxGYAAq8Pyno3UOOF8jek0RfAfqatQeJJ9fpPO46AyNWqfb2UaITwSG3CfZOHOcfZTtF+LawElOtw/N7YHKV5/BP1TYbUPkPkarvQH99iMk6fdExBf6tsHLdwTO2dvellr8UBYAlJfSqrZkQRjTH14wg6pBxO+J8U67sH/VI4WlzhbezvuxqcvhBIUfKMaeh9Pa3R+JI2O0y5h1nhLdT7PLGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Spx+7Ci39zOlH+TAHXlw78ClbbxF2tp5eXoXPm9fp00=;
 b=PtSuAN0GAu8C2gOx8RuuxFdFR+pATRKlGf14oE2+kun4Jn8Xc0UrUUE2BUydvo5saJtxGNn+q7H74Df1g1nuaIIEXBnp2iRLBEk8PjW89hxAd1SWGbmHcKX0GYEcXk6+ISNaaN7Lfvmrjct5Di+kucQv7J+fpAQZPVu74xFyv6IF6S+xShR5nLTlg8PIfkWg2Hl2woGqIael9pfg+bNMD8nHKFQZYdLF5PdNnfx7Lt3vwtzExxU58/be50oJ45y4hiy97hd35MS+aRK7yB4pBqcCn3Zbg0SzjMyg/aD3BQxy3TGh+JpvcqB/1YbPhqyJGBJfPKceN1IsFHwiCekFVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Spx+7Ci39zOlH+TAHXlw78ClbbxF2tp5eXoXPm9fp00=;
 b=aUVqNFHqXpe8mJZfI5ZWzohwoDBpROxO63lYbjtMxmJmxZG8Eyb9Bw2iKTOk9rdkiAKbBeIzZAM60UbOHCacxZq9B3/5Qjmz/WnkSzBmJ3cXuiHVHE366Kchimmu2Aokcbo+qJrAM8FwwVQ0CWTdLp9ZsWrxKgMAQXqitCs/VUA=
Received: from DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22)
 by CY8PR12MB8315.namprd12.prod.outlook.com (2603:10b6:930:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 10:30:35 +0000
Received: from DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::5cad:78df:6b83:6127]) by DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::5cad:78df:6b83:6127%7]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 10:30:35 +0000
From: "Xiao, Shane" <shane.xiao@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Enable doorbell selfring if resize BAR
 successfully
Thread-Topic: [PATCH] drm/amdgpu: Enable doorbell selfring if resize BAR
 successfully
Thread-Index: AQHZccK2PHIdMCo/skGPhrTuoVhwe686NNYAgAAKOyA=
Date: Mon, 24 Apr 2023 10:30:34 +0000
Message-ID: <DM4PR12MB5261E710B9A6F7BA6BF52F009D679@DM4PR12MB5261.namprd12.prod.outlook.com>
References: <20230418065443.878721-1-shane.xiao@amd.com>
 <9885713a-b424-dddc-f891-ed7d622c5b91@gmail.com>
In-Reply-To: <9885713a-b424-dddc-f891-ed7d622c5b91@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-24T10:30:31Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=021fc304-1e6e-4e38-ad60-5a9fc54c9446;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-24T10:30:31Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 4303717c-25b6-4eb3-b6da-e24a3aa8d6e9
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5261:EE_|CY8PR12MB8315:EE_
x-ms-office365-filtering-correlation-id: 767a6abd-f5b5-4d96-ab50-08db44aef05a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h0RFGbeVQO2UTkSbrRGA3ZGzXUmjPr7Ofvsb/OVsVpMOoGgdUmyp21+/zCY1+i3/RKqDbGIkm71wkOfXpwrxVlAE5zarnYhww7lTaj4Ty3IOtRpp+JESFZp5szIHg+tP9962OCTq6JwvwLhFNsMFR20Xy1xg4pff/eOhrX6/YNx6YnWP6e/83JoyYLsRoguXciM/X7wCCerVwkuQiP7QWUTbATW1EAoFh/fkjz9yvje9IUvzt1Rg9M9EAOh29bci46nV9fnRDOT4sbJmIHx/+a7apfi2/Djfqqjj9dI875YOXWE1evdD+7dOpBhZ8USEygxxq4gph8cfXXLn4TRVztQDrqNvkTdh8E7VrxLE7z/97HB5DzkDMoeCL1flRtTtEsTbIPCxqQdr9A6n5a6UHZtHpipY8E05TPRAY837ceRSe6aNFvfNlw+iZhzf+QUbbqQpqrpBamnsCGaRTncwM3tdqfh+i3LP3sy42EZiAglRHQVvY3UQ+qIYsUc3sVLUR2LYs4w0neMBDUaqY3/P4TQIVXiiV4t/Fp0Xx0zvEiK1Otu0LEkzdgE3I3igy8z6OSN2lqXVyv3Fp5PCRYhN6CIEe1n/UiAX46uVomhhwJcAgZ4rEO2U5WrFCPfIpTDR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5261.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(9686003)(53546011)(6506007)(26005)(38070700005)(55016003)(83380400001)(186003)(38100700002)(122000001)(66946007)(478600001)(76116006)(86362001)(64756008)(66556008)(66476007)(66446008)(8936002)(8676002)(6636002)(54906003)(110136005)(52536014)(5660300002)(71200400001)(7696005)(41300700001)(2906002)(4326008)(33656002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elZMcFJXblRFNzJQa0NhQ1lwS004Y0ttSno4TFJDRlJJMnorRkdHOXR6ZmNa?=
 =?utf-8?B?M0Rrck8vMUFzQjAwQkNIN0FBenEzNktyNS9Ia3RvQm5xaHU3U0xBS24yck14?=
 =?utf-8?B?a2lUYmliUU1neWdQeEdaTmFOdFYzTytQQWszcktHZ2VHZzdHcU5jaFJzK2pI?=
 =?utf-8?B?UWl4RVovQU4vTkZxNVBleHZIdDJSdG43bGk3SGJlbC9yTWswa2pRV3o1NFJs?=
 =?utf-8?B?bi80NFBVMys3S1ZuTTY4MHFQYlluRE1LWDh4NnBOZkdBd3NqMnZ6Nm9iUmtv?=
 =?utf-8?B?MVVGQWFSckxVL0tPd2l2L2h3VWdXMlNrWFFNcFBJcXJGYUZqd3JWeEdlRXph?=
 =?utf-8?B?dStkdWVOZFl3S2lOUlVXZ3ZIcmpyRkY0MW1zWkhUVjJUK3NQVW1HUitpMEYr?=
 =?utf-8?B?c29JcVVVSytqMVhOejRjektPRFRDVE1nK0lPVU9pdEpzSGQxRlpDSG1qbW1p?=
 =?utf-8?B?TUs1bVFIUkgwQWNYZlVGVG1Mb0R3WDBYMEQrSHdaTlFqMkFJVUtHelZCQjhp?=
 =?utf-8?B?LzNrbWgvVmI5Q2lyR2ZvaWdYMUR4NjNLZU5pN1UxWnNFL0hjQkZoUkUxQ1F5?=
 =?utf-8?B?K2pCTk1aeEFWb3Bxb2pXU084bThvRys3REpDeExDVVFyRzM4b1BITmFNUFVZ?=
 =?utf-8?B?R0dqc1BtcTR3Z0tEak5yZ01Uc08rb01OWjBsWmhaUHRUMFlkeGhla21mWE53?=
 =?utf-8?B?VG04YkY4a1NNWHVmK0RGU0lKbFpwT2o1VzY4YjNtVWxkV1ovREErbGNKUEx1?=
 =?utf-8?B?Wk94elhsclFGc3ovelIyclFWYWcxTzA1aFFudUlJd243TW1McnFLd1NjaWhH?=
 =?utf-8?B?bTVxRzVVOGpVSmxJR2VHSVNkcjFRU2lYMS9TRndRVHA3Uko3SGdKay8yUXM1?=
 =?utf-8?B?RDBDZnd6WTdiSk5HM0txbDJYZnpscHQ3VWZPcW1uM0dFbnVzL21uZ0FJd21R?=
 =?utf-8?B?SFovMGlTQVh4VGx2cGZnUXg1WkJNTG1PbnAyQTJUMi9HNFQzbUQyN0xjTmZ4?=
 =?utf-8?B?Q2R2SnBDOTZ4ekErSDB3cFJtMm9ZNmJ0aTh2SmhLVHdHakgyNkhlejdqMk5i?=
 =?utf-8?B?M2hDQlZlOXczRjNtaDN4RTdCT2dPRktlWlU3bmlwL0pCM28zWXRsUDNFRHRr?=
 =?utf-8?B?QmFRL3Z3SWQ4VmkwZ0xMbm8yNHp0dnZyLzNGdi9qV0dCSDBmcnBESHhVNllo?=
 =?utf-8?B?Vk9ndWl3VW0rOVJwNi9pdFZzeG5tRnl6WDF3L242aklXbzZSMFhUTXlqSFlO?=
 =?utf-8?B?ZWxaVXp3QXNnNGp3Z2RDN0FWTHZqMFk4N2d0c2hCdDExUHRseFFaMkUyY01W?=
 =?utf-8?B?c3o3bHZKV3VqV0NjYjV0OWxaWFVHZUxKV0JYNTBlbVA0Z3BsL0F0ZGtGTDUr?=
 =?utf-8?B?SDUyRlkzSVVRZkppWTNzSEtDVWQ0aDRNb1p4OEhuMEpGMUYvMGt3NEw1VUdi?=
 =?utf-8?B?Nno3Wk5LWk9ZL0RSRERBU0dBQUkrQjAzT3IwK1Z4RkhDb2R6dGdieUJiQW5s?=
 =?utf-8?B?NDZJL0xac0VSeEk1MkRwa0JJaGJxd29vVjZyMHVNVjdNb3ZPZXJhaVhydUdl?=
 =?utf-8?B?Z1gvdkdtNldJN1QyR0RXUWFkTFhkeVB3M1I4L3gzYTdEWm96N1pOVHM4bURQ?=
 =?utf-8?B?aTlFUXo2Nm1RbjJlRHF5Zmh4aGVxS1IzbjhXYTVpZFo4blZLNUVqY0Z3VFBr?=
 =?utf-8?B?d2l6VXNzb3FUU1dOaW0yeDl6T3o1UUoxREpOREtUc3ZSYjZxVzlBdlRMZlhv?=
 =?utf-8?B?MkkvZmRzcm9oV1VGazY1TFpsNzFWZjVTd3o1SFF0TEZ1dHJaVDVpdFpOMVhn?=
 =?utf-8?B?ZEN3YjFHemdhYWF6Qmh4bll5VlFHLzRtRnhQS09TWnhRZkhKU0xVTFRVWW1k?=
 =?utf-8?B?SXB0dHhUSEhVTHQ3SS9MTVBUWkdCQXhoMjdsYUJOcHJBQURlMHd4TDY4aUoy?=
 =?utf-8?B?M1FidzJjT016a1dMdWRZU1RDTUJuUUxwSmduTGh5cmJidEtBd0RVcDZkekZp?=
 =?utf-8?B?U3l5aTNRSThTZW5sbHl6MnVqMUdVcHBPMzlsUWVTTnhDOXI1cDk3NHczVGhW?=
 =?utf-8?B?WUNoN0FSc3RUcWJNdmp1RjhmZW5EY291bHNHY1ZPNGZHNVZoSmZVNllHUTNJ?=
 =?utf-8?Q?nxgk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767a6abd-f5b5-4d96-ab50-08db44aef05a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 10:30:35.0029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CAC62CdlMvTktGia3chIW49ZOGai0431va8FmVD3mdyhvmfDrE06YIelz4bN/IGq2xZTOfdaoV9RBL/n2Dcg5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8315
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
Cc: "Hou, Xiaomeng \(Matthew\)" <Xiaomeng.Hou@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVt
ZXJrZW5AZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIEFwcmlsIDI0LCAyMDIzIDU6MDcgUE0N
Cj4gVG86IFhpYW8sIFNoYW5lIDxzaGFuZS54aWFvQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzsNCj4gRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgWmhhbmcsIEhhd2tpbmcNCj4gPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IEt1ZWhs
aW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4gQ2M6IEhvdSwgWGlhb21lbmcg
KE1hdHRoZXcpIDxYaWFvbWVuZy5Ib3VAYW1kLmNvbT47IExpdSwgQWFyb24NCj4gPEFhcm9uLkxp
dUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBFbmFibGUgZG9v
cmJlbGwgc2VsZnJpbmcgaWYgcmVzaXplIEJBUg0KPiBzdWNjZXNzZnVsbHkNCj4gDQo+IEFtIDE4
LjA0LjIzIHVtIDA4OjU0IHNjaHJpZWIgU2hhbmUgWGlhbzoNCj4gPiBbV2h5XQ0KPiA+IFRoZSBz
ZWxmcmluZyBkb29yYmVsbCBhcGVydHVyZSB3aWxsIGNoYW5nZSB3aGVuIHdlIHJlc2l6ZSBGQiBC
QVINCj4gPiBzdWNjZXNzZnVsbHkgZHVyaW5nIGdtYyBzdyBpbml0LCB3ZSBzaG91bGQgcmVvcmRl
ciB0aGUgc2VxdWVuY2Ugb2YNCj4gPiBlbmFibGluZyBkb29yYmVsbCBzZWxmcmluZyBhcGVydHVy
ZS4NCj4gDQo+IFRoYXQncyBhIGdvb2QgY2F0Y2guDQo+IA0KPiA+DQo+ID4gW0hvd10NCj4gPiBN
b3ZlIGVuYWJsZV9kb29yYmVsbF9zZWxmcmluZ19hcGVydHVyZSBmcm9tICpfY29tbW9uX2h3X2lu
aXQgdG8NCj4gPiAqX2NvbW1vbl9sYXRlX2luaXQuDQo+IA0KPiBCdXQgdGhhdCBzb3VuZHMgbGlr
ZSBhIGJhZCBpZGVhLiBJbnN0ZWFkIHRoZSBmdWxsIGNhbGwgdG8NCj4gbnZfZW5hYmxlX2Rvb3Ji
ZWxsX2FwZXJ0dXJlKCkgc2hvdWxkIGJlIG1vdmVkIGFyb3VuZC4NCg0KSGkgQ2hyaXN0aWFuLA0K
DQpZZXMsICBJIGdldCB5b3VyIGlkZWEuIEJ1dCBhcyBmYXIgYXMgSSBjYW4gdW5kZXJzdGFuZCB0
aGF0LCB0aGUgZ2Z4IGh3IGluaXQgd2lsbCB1c2UgZG9vcmJlbGwuDQpJZiBzbywgd2UgY2Fubm90
IGVuYWJsZSBkb29yYmVsbCBhZnRlciBnZnggaHcgaW5pdC4gDQoNCkJlc3QgUmVnYXJkcywNClNo
YW5lDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4gDQo+ID4NCj4gPiBUaGlzIGZp
eGVzIHRoZSBwb3RlbnRpYWwgaXNzdWUgdGhhdCBHUFUgcmluZyBpdHMgb3duIGRvb3JiZWxsIHdo
ZW4NCj4gPiB0aGlzIGRldmljZSBpcyBpbiB0cmFuc2xhdGVkIG1vZGUgd2l0aCBpb21tdSBpcyBv
bi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW5lIFhpYW8gPHNoYW5lLnhpYW9AYW1kLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBYXJvbiBMaXUgPGFhcm9uLmxpdUBhbWQuY29tPg0KPiA+
IFRlc3RlZC1ieTogWGlhb21lbmcgSG91IDxYaWFvbWVuZy5Ib3VAYW1kLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgICAgfCA0ICsrKy0NCj4gPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgfCA0ICsrKy0NCj4gPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmMgfCA0ICsrKy0NCj4gPiAgIDMgZmlsZXMgY2hh
bmdlZCwgOSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L252LmMgaW5kZXggNDc0MjBiNDAzODcxLi5mNGM4NTYzNGE0YzgNCj4gPiAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jDQo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYw0KPiA+IEBAIC01MzUsNyArNTM1LDgg
QEAgc3RhdGljIHZvaWQgbnZfZW5hYmxlX2Rvb3JiZWxsX2FwZXJ0dXJlKHN0cnVjdA0KPiBhbWRn
cHVfZGV2aWNlICphZGV2LA0KPiA+ICAgCQkJCQlib29sIGVuYWJsZSkNCj4gPiAgIHsNCj4gPiAg
IAlhZGV2LT5uYmlvLmZ1bmNzLT5lbmFibGVfZG9vcmJlbGxfYXBlcnR1cmUoYWRldiwgZW5hYmxl
KTsNCj4gPiAtCWFkZXYtPm5iaW8uZnVuY3MtPmVuYWJsZV9kb29yYmVsbF9zZWxmcmluZ19hcGVy
dHVyZShhZGV2LCBlbmFibGUpOw0KPiA+ICsJaWYgKCFlbmFibGUpDQo+ID4gKwkJYWRldi0+bmJp
by5mdW5jcy0+ZW5hYmxlX2Rvb3JiZWxsX3NlbGZyaW5nX2FwZXJ0dXJlKGFkZXYsDQo+IGZhbHNl
KTsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgY29uc3Qgc3RydWN0IGFtZGdwdV9pcF9ibG9ja192ZXJz
aW9uIG52X2NvbW1vbl9pcF9ibG9jayA9IEBAIC05OTksNg0KPiA+ICsxMDAwLDcgQEAgc3RhdGlj
IGludCBudl9jb21tb25fbGF0ZV9pbml0KHZvaWQgKmhhbmRsZSkNCj4gPiAgIAkJfQ0KPiA+ICAg
CX0NCj4gPg0KPiA+ICsJYWRldi0+bmJpby5mdW5jcy0+ZW5hYmxlX2Rvb3JiZWxsX3NlbGZyaW5n
X2FwZXJ0dXJlKGFkZXYsIHRydWUpOw0KPiA+ICAgCXJldHVybiAwOw0KPiA+ICAgfQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCj4gPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCj4gPiBpbmRleCBiYzVkZDgwZjEw
YzEuLjAyMDJkZTc5YTM4OSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zb2MxNS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUu
Yw0KPiA+IEBAIC02MjMsNyArNjIzLDggQEAgc3RhdGljIHZvaWQgc29jMTVfZW5hYmxlX2Rvb3Ji
ZWxsX2FwZXJ0dXJlKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+ICAgCQkJCQkg
ICBib29sIGVuYWJsZSkNCj4gPiAgIHsNCj4gPiAgIAlhZGV2LT5uYmlvLmZ1bmNzLT5lbmFibGVf
ZG9vcmJlbGxfYXBlcnR1cmUoYWRldiwgZW5hYmxlKTsNCj4gPiAtCWFkZXYtPm5iaW8uZnVuY3Mt
PmVuYWJsZV9kb29yYmVsbF9zZWxmcmluZ19hcGVydHVyZShhZGV2LCBlbmFibGUpOw0KPiA+ICsJ
aWYgKCFlbmFibGUpDQo+ID4gKwkJYWRldi0+bmJpby5mdW5jcy0+ZW5hYmxlX2Rvb3JiZWxsX3Nl
bGZyaW5nX2FwZXJ0dXJlKGFkZXYsDQo+IGZhbHNlKTsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgY29u
c3Qgc3RydWN0IGFtZGdwdV9pcF9ibG9ja192ZXJzaW9uIHZlZ2ExMF9jb21tb25faXBfYmxvY2sg
PSBAQA0KPiA+IC0xMTI1LDYgKzExMjYsNyBAQCBzdGF0aWMgaW50IHNvYzE1X2NvbW1vbl9sYXRl
X2luaXQodm9pZCAqaGFuZGxlKQ0KPiA+ICAgCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpDQo+
ID4gICAJCXhncHVfYWlfbWFpbGJveF9nZXRfaXJxKGFkZXYpOw0KPiA+DQo+ID4gKwlhZGV2LT5u
YmlvLmZ1bmNzLT5lbmFibGVfZG9vcmJlbGxfc2VsZnJpbmdfYXBlcnR1cmUoYWRldiwgdHJ1ZSk7
DQo+ID4gICAJcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjEuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc29jMjEuYw0KPiA+IGluZGV4IDUxNGJmYzcwNWQ1YS4uY2Q0NjE5MDg1ZDY3IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jDQo+ID4gQEAgLTQ1NCw3ICs0NTQs
OCBAQCBzdGF0aWMgdm9pZCBzb2MyMV9lbmFibGVfZG9vcmJlbGxfYXBlcnR1cmUoc3RydWN0DQo+
IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4gICAJCQkJCWJvb2wgZW5hYmxlKQ0KPiA+ICAgew0K
PiA+ICAgCWFkZXYtPm5iaW8uZnVuY3MtPmVuYWJsZV9kb29yYmVsbF9hcGVydHVyZShhZGV2LCBl
bmFibGUpOw0KPiA+IC0JYWRldi0+bmJpby5mdW5jcy0+ZW5hYmxlX2Rvb3JiZWxsX3NlbGZyaW5n
X2FwZXJ0dXJlKGFkZXYsIGVuYWJsZSk7DQo+ID4gKwlpZiAoIWVuYWJsZSkNCj4gPiArCQlhZGV2
LT5uYmlvLmZ1bmNzLT5lbmFibGVfZG9vcmJlbGxfc2VsZnJpbmdfYXBlcnR1cmUoYWRldiwNCj4g
ZmFsc2UpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gICBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2Nr
X3ZlcnNpb24gc29jMjFfY29tbW9uX2lwX2Jsb2NrID0gQEANCj4gPiAtNzY0LDYgKzc2NSw3IEBA
IHN0YXRpYyBpbnQgc29jMjFfY29tbW9uX2xhdGVfaW5pdCh2b2lkICpoYW5kbGUpDQo+ID4gICAJ
CQlhbWRncHVfaXJxX2dldChhZGV2LCAmYWRldi0NCj4gPm5iaW8ucmFzX2Vycl9ldmVudF9hdGh1
Yl9pcnEsIDApOw0KPiA+ICAgCX0NCj4gPg0KPiA+ICsJYWRldi0+bmJpby5mdW5jcy0+ZW5hYmxl
X2Rvb3JiZWxsX3NlbGZyaW5nX2FwZXJ0dXJlKGFkZXYsIHRydWUpOw0KPiA+ICAgCXJldHVybiAw
Ow0KPiA+ICAgfQ0KPiA+DQo=
