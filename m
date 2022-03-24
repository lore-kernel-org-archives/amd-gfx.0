Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD1FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 01:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83BB210E07F;
	Thu, 24 Mar 2022 01:28:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5390E10E07F
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 01:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hERxchuqBigjPnK8+VSrtdHBYZVTlTUq8KtjRDFhAkYwUYJ+h8BazhuKsqhYCQIv07UDcem8cme6eB2MaxdimdG5rHznxEuQClt9eagCzw6jFOUD7BrHp4nodOP/i8vnlIhjBThoibTWVp5+VzPVVM1VSJwX/aj4YuKQkeiYUt8c+txQ1Q3O8fcBUqB7sWcZeVnBSPdYOiaVfuK4w+dR3jEM232Qgg2GbP2ojBhtWR09IQCKsJZEmB4OxsYHMgM3biLat65R+VVz6cMa3gp2Py1YE7FlyMKxENDH6YGw1HNeazufwa12nW3L8Ie4sui8R1qg1jcaupcVEKFrS3AZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXNWuh1ipjD5WiNtfR2KzRQVBJfeEU8y29bRNtxCoIs=;
 b=Cr6mjjqNsBxH5YOO2xd14kIi+JZ2DsCr/zIs2Tg1lGYmXGHPw0QV1s/OZmzNEZETw8x/Hz/0iUke645ccT8e+hm1Tx3gDZz8hKv3OrqXvmj7nlyrzY+2wx7Fq7BM4Bn5mhfJgPdHpXrsWcSHXmx3jqq3graMvJQ5Sd8wWe5iNZC6hiVq26fUuuHYWYTl8QY6Q5CT2NJHqOYZxR8zFs833ODYoq6qtZ5H67gMUJE6FZvg8xXiMBkI80C90prZFTwpUrpwSSwBROum0SbcE/4AoMY5qcndmDSZ0IvkLNbYWuoid+L8osdhPV9223K1WisH07jqBhh0YJzLUqY3N7mhbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXNWuh1ipjD5WiNtfR2KzRQVBJfeEU8y29bRNtxCoIs=;
 b=Z3uv/An165ZUzH67a97JE0Vcyaxgt5v4U1bVqZiVKoxpC52OGhVP6pSKPTRB7uAD+3MF3rTEWX8yMRXJ+ll6ZSWMzu2Aug+erueMFJK89q0njAwW1sAUrueJOTlBURxjs8LFF+3x8NZ/3ZSWnG13z5IVc/QIRjNjMzsNr2F8HXE=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by PH0PR12MB5468.namprd12.prod.outlook.com (2603:10b6:510:ea::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 24 Mar
 2022 01:28:48 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::408b:3c55:a3cb:6f4f]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::408b:3c55:a3cb:6f4f%3]) with mapi id 15.20.5081.022; Thu, 24 Mar 2022
 01:28:48 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: set noretry for gfx 10.3.7
Thread-Topic: [PATCH] drm/amdgpu: set noretry for gfx 10.3.7
Thread-Index: AQHYPo4YoDti9V+oQE+YVGQ5eot9MqzM9JcAgADJzzA=
Date: Thu, 24 Mar 2022 01:28:47 +0000
Message-ID: <BYAPR12MB32382469B2A84DDC3FAA5CF1FB199@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1648023118-29619-1-git-send-email-Prike.Liang@amd.com>
 <CADnq5_MPoeFHW+894ysW916rby=imyMPemwsvABx_oXZoAtz2w@mail.gmail.com>
In-Reply-To: <CADnq5_MPoeFHW+894ysW916rby=imyMPemwsvABx_oXZoAtz2w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b7bbea98-a0a0-4147-b050-98f7438f0ed5;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-24T01:23:48Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e53ea826-36b1-4b1a-9134-08da0d35a52c
x-ms-traffictypediagnostic: PH0PR12MB5468:EE_
x-microsoft-antispam-prvs: <PH0PR12MB5468F7203B848A1722F468A0FB199@PH0PR12MB5468.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Jh2szB4S6yaBHbmZ9GcMONiFcyiflbHsuhrzEwu4S5VywGqDDEwQkxyESXRX2Qk8RtdcTMby49UoJslkHor8KF50+HSw2kDlNRJZQ6n63KhK3ls+3SFCa9X3IETAtCIxXw9urYD4vFHT5cFKOQC9e2dWWVkPJJF61WuJpB53W9dD6m8PsU6raBQx3Yij/lN1R6FvNgZokOMPnbODsAVWYZBjO5kZpZxxCyXzV3P79o0yoldrFfOCWvU9crEhAu1BuWDUPvlgfI7+FNZXV352yFbNEETjnw1tlOhxUhEQJ9mnrfVw/FcLwlgRhF+Gxs8dk5U1kJhyekoSqyCTxJo9xC90TrFknvdLItx4AkUh51jH7EPt56WWhTgJ6w6arLhIIbVILFHIlrq+VCpuoQ6Yp2zA2IYJjvjLMRVx2oZTAfsv8HJFRQbcJKy/vlyRnddz84Q0CMjUl5E15VUZD4HxxwBO7Ytrz+T4LjVt6Dzyo1VOPZj+wsXO56YlKGV37ZqC38j3YLF8CLUi124oItYyUZu/HFQKU3Z7YGCsfeI5dAoQhrZGttsEqT5MucQ4lGAP+Zkz/X0P91D2GdGYTtfbKL7TdqXZRP3lpjTOWLsaXQf1rRL6ABX2HhwXgp00A/2lBT6kJvkFKMetZElpsamq2ITWuT7G7EcJDEPOSWdYBybbFt7P8NbB49VKVk0EcCNhl+7G2T/p6NrK2qv7NB59w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(33656002)(122000001)(38070700005)(38100700002)(186003)(26005)(6506007)(7696005)(9686003)(2906002)(55016003)(53546011)(83380400001)(5660300002)(6916009)(508600001)(52536014)(71200400001)(54906003)(316002)(64756008)(4326008)(76116006)(66556008)(8676002)(66446008)(66946007)(66476007)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWFMMVhRaFliSzRiR2crem9NYStZaGd5QVZSS2ZSVHcrN01WeXhEdnMxeXhN?=
 =?utf-8?B?dUlSUU5lakxGWjZIV3puMVc2M3NBR09IM2lnc0xjQ1BwWktJT1kySG1GUGd2?=
 =?utf-8?B?bTlQcVdCK1UwbG5uUlpEaFlhNHZhZkE0NmdaTXZCUmxYOHBLalBMTDl0UW92?=
 =?utf-8?B?Y3lFbTN6VEJaMm00N0ZwNy80cGljU1JXVmtDbjgyN3h2eFNQNFN6VCt2Ykth?=
 =?utf-8?B?OWJDbWVNNjMxeVJIQXlXOE1RZG9HeVJDcDNQMGRjek5GdHdQaXZnRzdXYkgy?=
 =?utf-8?B?RUJwRHJWRDRYR0drYUU4MkdLTndUTVlzYkZ6Y0JJRlZZd0Y0c25RRHJYUGZ1?=
 =?utf-8?B?WkFWMmZ2clhHcGtDaFk0YW1KOGxTNjlSajNkeHljTEtzcXZDV2w3QzAzcUhP?=
 =?utf-8?B?Nk5DdmNROU14eUNwdjMwQ1BwZmFsZmY0Y3NyeHFWTCt3Q3dHZmR1S3p5RzJC?=
 =?utf-8?B?MFJYZzlJWGtxdWdUL3M5Tm9tVDFaMU92TTJ5TTdNcE1TWWFTOEx4eU1DTjlh?=
 =?utf-8?B?RkVmTENYeGNPaStiemEyemFEL1FkM3NDSGlPTytNSlIzM1pxdis5dXJVYWlZ?=
 =?utf-8?B?dUh4VnZ6N1JGcGprSGZOVUVnT2tRUkZCL0N0QVNQdFc4L2pOVHRrYi8rZTda?=
 =?utf-8?B?aER1RXNESlB3eWh3VTlRT205Z25vQ3ZFVWl2QjF2ZzJoeFFqYk41dDZFUjhh?=
 =?utf-8?B?UXhOQnY3K3lNV0dEZmdhc21hZ1dNTyt6aFpVY0FZWjNNZThlVmR1K29tSnp2?=
 =?utf-8?B?bFRucnJGWnM1M095Z3lPRnlyQlF5L09PcjZHTHArNzdkMlFFaTA2VmM4amJr?=
 =?utf-8?B?YURuc3hXL3ZIUnhwbEhkcnJMVDl4dkRjVU9TdUdEdHNyL0lPRUlwYTVkL25m?=
 =?utf-8?B?NHhUMFhUa3dUeHd4bmplWHRuSjNpSEFzSXgwM3RDeTJpTUN6UG5GS3FjNFpp?=
 =?utf-8?B?SzU4QzJobHR4Y1VGZE1Sb3RHNCtncHFjbkVjclNScHJMc1dROEx6ZUprYTZN?=
 =?utf-8?B?bklzTE5TSWV0Tk0rbGRXdjdNbFRJZ1FJd3ZKSTllS3BhNjZDelZGRDR4MitC?=
 =?utf-8?B?VUd5ZklkSTVnY2FNc3NPQ3p3WXFMekhaaXFVZlJvRkhkb2RHTTBnOEhVTVhj?=
 =?utf-8?B?ZDVLaHlkZW9BMmM0UlJvZEdhYktiVUtBcTFuZ3RSSUZYYTJ0TFYweklEZ1Yy?=
 =?utf-8?B?TmtGb3lGa09ZdnZkU1FQSUdHSE5iYjgraU1KWXBMZWZOWUpJK1JIV3kxQ3h4?=
 =?utf-8?B?RXJtU3B4VTRycEwzNEZzM1JuY0EzUzE3QzRMSUh6VDZqRENoWUwzMzdkbmd0?=
 =?utf-8?B?bjhQTWxYaW92ZC96ekRRWUxkdVFtdElmVUMyNndTVm0xN1lYRVEzTDhjSUpr?=
 =?utf-8?B?TS9VOERMSHN5RHp5cnQ4NGpyUFdvdUN0WkYrd3NMcFROZWJRbXFpN2JWb0Fz?=
 =?utf-8?B?MGVFWXNEbFpYM3RQQjFFK0VIUXVkRVAxekRCaDdmZVhwUkR1RGFIR1BYcTNk?=
 =?utf-8?B?cTJsRHNMY2JWWXEya2E2VGgyV1ZJaXE5SmNOSE8ranFRNlNtVTA2eE9YK0VF?=
 =?utf-8?B?VUxLOHVBV0FBb2NsZWpCeWthREl2aUNwRHhrMzNyNTQ4bGNTZ2N1NC9ERzAy?=
 =?utf-8?B?dzdCVXJKbjNoTU1SRjZobldXaEZ1eDA2WFc4TzRVaTNvdEM4S0Irc0YrS3pE?=
 =?utf-8?B?K0oyTGhNaW5BT1RpeG5YMnExV05pUGlQRStNU0NXMVNGOXhJWWRCWkVYd3dn?=
 =?utf-8?B?dDVQV3dOU3plNEFOT1BhUUFDYnVjRVNtNGwrOVlpNXdsYmc5WlBTWFNBN3M0?=
 =?utf-8?B?cTJQdnVpaSs4RVdEd1gwWEsxK1ZpdC9rbzhDdEhxZ05PLzR1ZVF2SHE3aFpR?=
 =?utf-8?B?a1QxajVYUTMwbWdMaWRHa1lMY0ZrTWlLY3lkdUtYWFRiU0xnOTRZeTVNNkEv?=
 =?utf-8?Q?ynmFHKKrCsM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53ea826-36b1-4b1a-9134-08da0d35a52c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 01:28:48.0373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UE+WBD/akDvakkm8T8v67qIhcTzpbwRD4ykDFQSKoJfquOfkpwRbbDbaeIWwtD+n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5468
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
 Yifan" <Yifan1.Zhang@amd.com>, "Huang, 
 Ray" <Ray.Huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LiBBY3R1YWxseSwgdGhlIGNvbW1pdCBo
ZXJlIG1lYW4gZGlzYWJsZSB4bmFjayBvbiB0aGUgSVNBIGdmeDEwMzYgZm9yIEtGRCB0ZXN0LCBi
dXQgaXMgc2VlbXMgbW9yZSBjbGVhciB0byB1bmlmeSB1c2luZyBJUCB2ZXJzaW9uIGdmeCAxMC4z
LjcgYW5kIHdpbGwgdXBkYXRlIHRoZSBjb21taXQgaW5mby4NCg0KVGhhbmtzLA0KUHJpa2UNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1
Y2hlckBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMjMsIDIwMjIgOToyMSBQ
TQ0KPiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiBDYzogYW1kLWdm
eCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz47IERldWNoZXIsIEFsZXhhbmRl
cg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpo
YW5nQGFtZC5jb20+Ow0KPiBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogc2V0IG5vcmV0cnkgZm9yIGdmeCAxMC4zLjcNCj4N
Cj4gT24gV2VkLCBNYXIgMjMsIDIwMjIgYXQgNDoxNSBBTSBQcmlrZSBMaWFuZyA8UHJpa2UuTGlh
bmdAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBEaXNhYmxlIHhuYWNrIG9uIHRoZSBpc2EgZ2Z4
MTAuMy42Lg0KPg0KPiB0eXBvOiBnZngxMC4zLjYgLT4gZ2Z4MTAuMy43DQo+DQo+IFdpdGggdGhh
dCBmaXhlZDoNCj4gQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1k
LmNvbT4NCj4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFu
Z0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ21jLmMgfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5j
DQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jDQo+ID4gaW5kZXgg
ZTE2MzVhM2YyNTUzLi5hNjZhMDg4MWE5MzQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dtYy5jDQo+ID4gQEAgLTU2OSw2ICs1NjksNyBAQCB2b2lkIGFtZGdw
dV9nbWNfbm9yZXRyeV9zZXQoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gICAg
ICAgICBjYXNlIElQX1ZFUlNJT04oMTAsIDMsIDQpOg0KPiA+ICAgICAgICAgY2FzZSBJUF9WRVJT
SU9OKDEwLCAzLCA1KToNCj4gPiAgICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMCwgMywgNik6DQo+
ID4gKyAgICAgICBjYXNlIElQX1ZFUlNJT04oMTAsIDMsIDcpOg0KPiA+ICAgICAgICAgICAgICAg
ICAvKg0KPiA+ICAgICAgICAgICAgICAgICAgKiBub3JldHJ5ID0gMCB3aWxsIGNhdXNlIGtmZCBw
YWdlIGZhdWx0IHRlc3RzIGZhaWwNCj4gPiAgICAgICAgICAgICAgICAgICogZm9yIHNvbWUgQVNJ
Q3MsIHNvIHNldCBkZWZhdWx0IHRvIDEgZm9yIHRoZXNlIEFTSUNzLg0KPiA+IC0tDQo+ID4gMi4y
NS4xDQo+ID4NCg==
