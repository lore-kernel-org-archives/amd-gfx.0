Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D3CC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 07:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D85B610E212;
	Mon, 30 Oct 2023 07:32:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 270E710E212
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 07:32:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/0GdSkkW9cBRbfcHBR8G+a6Bn+CbS4Wgwsj8wuzWSZ27Igd5Cegis5d4aDO519kMKtJKaUHTlHLhU+0LGr1VNpOMocnMZLaO658V1NalZ8fOuw7RpmbZ9FfS8W+p4eH+zCF1yeYzlITJIk3qKCLkDX4p72M/PnHf6T9H/av8WtDmVfi1RqJeHKFDNmj1Qv1aGYESfboo1V0275j7jIDw3dFzNPILTm8LZBEyj95bYIytwzBtOgT8GDPZQla2xQEevMTGj2GdkLLBgxquXuEZV++hl3yOIKRPkgUYUH5U/b+2AV4jcGxb0+mzLx4+qe9qGq7KKOB6YO48nUSTbpvAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGoAitd8IxfxkBulfz2PMzhRfYH5EIGNYP2fJevX5mY=;
 b=AGFo2u1dur3vCZyLiKUZZIL7DtHhNBYTQf98sn6NnI1KBNgpdIa+AN2otox4O7IVCXlm1/oBxsd5C7gYePxu5Jp0q81hiV3mSj5E7/WW5dkGR+383GBPDd9B5gb89GlYeIzuPCDVvAHOVhHMUeQUQ4mEz0TeGnVPq4yBAYh8R3fhkeR07pOLvwF7NBnpVpnRDpF1/yp87f8M3m61+ABWLjIjMf91y3FH2JiM2WCGY7BIIeR39WCTolm5toLoEUI9bgj5x+qF7JkquoioB65wrBMRKTNRdP/Q9R1x5k0HEMv+a2Kr1CeQIuLFTAxZ1bOBqfZd7tDQCxyw92gUVix6OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGoAitd8IxfxkBulfz2PMzhRfYH5EIGNYP2fJevX5mY=;
 b=g0sIWOPs453RANm8ek3Ry8u2NZEXBDC0BiGD+cNm5gPjR82K8g8rDG67/HOZ17AS/0eygFrw/FPhzYdyEb5rz+K2mj9xs4akNdVwfFHKWeNKbh71/UP1mjHO11EW9MqCo2F3bCzz1VlLNYMEKl8zGGiVXnYN7sAGf9QelmVjdrs=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SN7PR12MB8433.namprd12.prod.outlook.com (2603:10b6:806:2e5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Mon, 30 Oct
 2023 07:32:14 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.6933.025; Mon, 30 Oct 2023
 07:32:14 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH Resend] drm/amd/pm: only check sriov vf flag once when
 creating hwmon sysfs
Thread-Topic: [PATCH Resend] drm/amd/pm: only check sriov vf flag once when
 creating hwmon sysfs
Thread-Index: AQHaB7dEvxPK2qnvf0eztJpsn8O3vLBh3/oAgAADBACAAAgNgIAACnQQ
Date: Mon, 30 Oct 2023 07:32:14 +0000
Message-ID: <PH7PR12MB59977F140C88B01C3F1BC60982A1A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231026025033.1469231-1-Jun.Ma2@amd.com>
 <c82e4cb7-627c-a356-5659-0eb63a3e1a2b@amd.com>
 <PH7PR12MB599761E6CD88B0D38BD9927382A1A@PH7PR12MB5997.namprd12.prod.outlook.com>
 <eaa02377-9bee-bf37-d394-556727649665@amd.com>
In-Reply-To: <eaa02377-9bee-bf37-d394-556727649665@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SN7PR12MB8433:EE_
x-ms-office365-filtering-correlation-id: 27d5105e-00c4-4808-683f-08dbd91a5640
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: egHDOyi5TOdOl8eBLADxAuGdAb4rJgNXP97uS7OWY6vrKntUSRmExBsr+V1sCI0YkcmaAtHFCGW5yYPNZ3d2EaT7vKeNnSffs7lEWVNnOWUcO7UCpLKoOo0McTsagrDNtRyiY19mSgCg6NnXLy9KYBncPXIrGFtbJ2UCJIQcK092Dl9uBHHamU/HdOAbLWLbxePbAczZcQRQu2cEAhgxSDuRemVM+mufBuBmuKogvEZXvyHb8vSN09yZ76VorA7sNK/7LUd0ccl9kJgWcSiv92+iQsfClYrPPo3VVf3X7u42s2oBeprvLpUFRVJGQZF98G2HYqiJBwdFev84Gng66B4AjwsBws7mLLZwNkUNuoZPsIMITmQigfZMru/AGBJo+b0oB9ZD5buyNSX7+W6pw0x84TNzG4fo9ahYOoWW7clv12nrkW2IXb+2FW5J8oLhBYsoFMBx8IzqSMIUiuCSZ/qzfPfziaO0Dh1zgqZoYwOOFT0eqt1aisja6oRL/zC5bYSqCPVUQ0GD//6/XZSLadZAUvD6kdrS9sRJLkUdps9zPFtP14arhj1kupIj6Dx/w3UKrv4N2HTZmTi1V234soY0aTXUNiyVh+tcLwqvbmUOIGUuvejxLP0EliVai8Vm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(366004)(376002)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38100700002)(83380400001)(53546011)(6506007)(7696005)(71200400001)(9686003)(64756008)(76116006)(110136005)(66946007)(6636002)(122000001)(478600001)(26005)(316002)(66476007)(66446008)(38070700009)(8936002)(66556008)(5660300002)(55016003)(41300700001)(2906002)(52536014)(86362001)(8676002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWNQTFFOb2tycjBXU1ZCeWRkSytFbXo0dC9leTVXcytkMDBWYkovVWdtd3ZP?=
 =?utf-8?B?cmtiY1l1RzdTUUkyak1xblRLbEE4cGRMSG5CV1NFWm54V2RlSUY0dzlxN1lZ?=
 =?utf-8?B?NkpkUFBEZ1ZIQk5zQ3l6Y2swREdLVjJpTjdpRE9RdVpFMUErU09ERDdzYno1?=
 =?utf-8?B?R0o1Nk43UzFjbkhmNWRDMzR6TDN2VXUxN0g2cVVpdThMdFBqd2h0SWk5bWRG?=
 =?utf-8?B?by96RlRpMnNRQmd5ZXRMUnJSek01RVFTOEpEb0hIU3oyVW9ZMWlRYzRFeVRE?=
 =?utf-8?B?RWFibVRkRWhRQTFmaFV5UmIyR0RaZWxJZER0aFpzaUJadnlMSGluL2RwR2cr?=
 =?utf-8?B?OVJWWnpWbDdhejZhNWJ3UHo4VGF3MzlsN3VOejllWjlLeFVoZkF5cnp3c1F0?=
 =?utf-8?B?aFd4Nm05MzgzbEZoTzNPblVKRUgwN0J6Q01ac00yTHJKQjF2QzJaZnptN3hh?=
 =?utf-8?B?WVNwV2N0MWJsTW9FSHc1dmVpc01oV1F3eHI4dlZScDUvTGtyKytIV2pQcVUy?=
 =?utf-8?B?cTVDa01HOTZGMXJDRElCWTJIb3RjZk13MCs1NVBRaUF2U0krcGxXNVhsQytY?=
 =?utf-8?B?RGg4OEE1RTNoYmY2R3BHWDdPSE1jTlN0aHQ0dFRKaEQ1NGR5UTlQRW9pNmVJ?=
 =?utf-8?B?ZFJMejRsbkVTc2t3RWFSdTVEMUtFNWZxNlE2OGZiWXhTaThkSmVLSGFTZHl4?=
 =?utf-8?B?T3NDOWZvN2lTb3ozb2czd1NSN1c5TTlUWXB4NEFKM05sNTVRbHRkYjd6VXFL?=
 =?utf-8?B?RlN5WHVYU242ejNNeFh0M2pkV2hHMmF6cERiYVc3bVI0NndleUVZdVdabGZM?=
 =?utf-8?B?dkxxVkJQRUlOWHRlMG1lc0NzMTMxMVU1WmhHYjVLSVg4Zzl4OGNIODlIUUZO?=
 =?utf-8?B?UEZUQWVkeUlBSStvM3VaQ3J2ZnE0NmF0RkIzNEV5NU9veGZnVUYzNFAvcmpl?=
 =?utf-8?B?MTVvejhlSTRRQnhkNFhnUFF2K2dsNHFWdHRwdGZobko0S0NVYkQ5dEp2VkV0?=
 =?utf-8?B?ZE55Z0ZVc0M5b0FDUVRwWjdURFdNTFF4Qk5FMmxLZGJ2RTJGVDVhcWl3dyth?=
 =?utf-8?B?VTBSbTIwMzAyemg4czZzanhFOGU5cGdRQW5oYzZVRkZRMzBOOVlBc3A3WGx4?=
 =?utf-8?B?R2xJeERJMyswOSs4UWJ1azZoN3FFSVlKTFpmMDhUSE1wSnEyVUR2dkVOcUoz?=
 =?utf-8?B?QmVXOStvWCtMZEJyMmRJdkRpdC9PemJGSjBIRm9pcGxUTkprMFVFTEZ5eHYx?=
 =?utf-8?B?ckV6Rk5LR0NQcmNHOTNTOEljdVNRZXA4akVZak5vSjBob0dvSE1PdHNuTGha?=
 =?utf-8?B?eGJ5Y294OEtUbEpsZzVCZk9PTEJzNDRFQVpOZVVKME02amhYcFplQUF1TU16?=
 =?utf-8?B?MjJIa0t2ZVhQTTdQOG9NcGdaZXlVbExtSkZ2aHJ0NGxNS2hiaXBlTWRSRzZn?=
 =?utf-8?B?UDhFUGIzc2lxYnJXeE9iUXV1OEZ6V2J0SkJZUlpSdXgrVkJjbmt4UDlOREpP?=
 =?utf-8?B?RlhYSlluMkVmUmJObGpqckhFdkRuMFZGSEJTZy83WHZQaWU5dlB3K255T281?=
 =?utf-8?B?Q0tJK2dCd3ZTeFdmNmJPbGd4dXJXQ3dDVEF5Mm53ODVhOGJBUXVRbERnRW1z?=
 =?utf-8?B?YThPT0Mwd2QxSWdNM1FKMm1yVFJ2b3NycGtLUld1UmhDTE1ycGJDZ0Jqalpn?=
 =?utf-8?B?OEpHaEJ4SEpUQ3hrNW04aGxnd0VKTDZXSW5veFRPaWdVSDFIWnRlKy9HOVhR?=
 =?utf-8?B?Qytkbmo5Q3J6V1l6b09zc0EvNnNmSlNITzdvVEU0Ny9kU1Rqc0pnTmpyN2di?=
 =?utf-8?B?Zlc3TWZ1N1gxdkFjNFVRTUUwMFNBSHM1V2pNZzhIdjVmTUYxbmg0MWUzTjYx?=
 =?utf-8?B?ZnlrcXc4QURKZlRrdG5aaXV4MTNhWnErR05EY0dyWHNsSEtwY0UzMmNTL1VZ?=
 =?utf-8?B?MHNjUDBGejhtTm9LTnhkM21iOCtyWUxvUkZicHRMUHFIODVyTFNXZnBBbHZY?=
 =?utf-8?B?VmNwZDROK3ZvclZvenZQelNqbkZMWFBVdXRQSkYxODQ0RkhBcnNLUHNZNFlQ?=
 =?utf-8?B?TndTL2tJdldZYVdCNXowWHgxcDNNRHlkT1JMQUVzNDdZYlhGT2VtL1ROTmUy?=
 =?utf-8?Q?/n2U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d5105e-00c4-4808-683f-08dbd91a5640
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 07:32:14.2415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z1ooT601P+0hMRbPkyKLFoaJn+nfWo1ka2rb2/TFUn4/l8J8gbS22YVElcXrbAD/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8433
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

UmV2aWV3ZWQtYnk6IFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCg0KQmVzdCBS
ZWdhcmRzLA0KS2V2aW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IE1hLCBK
dW4gPEp1bi5NYTJAYW1kLmNvbT4gDQpTZW50OiBNb25kYXksIE9jdG9iZXIgMzAsIDIwMjMgMjo1
MCBQTQ0KVG86IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPjsgTWEs
IEp1biA8SnVuLk1hMkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEZl
bmcsIEtlbm5ldGggPEtlbm5ldGguRmVuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KQ2M6IE1hLCBKdW4gPEp1bi5NYTJAYW1kLmNvbT4N
ClN1YmplY3Q6IFJlOiBbUEFUQ0ggUmVzZW5kXSBkcm0vYW1kL3BtOiBvbmx5IGNoZWNrIHNyaW92
IHZmIGZsYWcgb25jZSB3aGVuIGNyZWF0aW5nIGh3bW9uIHN5c2ZzDQoNCkhpIEtldmluLA0KDQpP
biAxMC8zMC8yMDIzIDI6MjMgUE0sIFdhbmcsIFlhbmcoS2V2aW4pIHdyb3RlOg0KPiBbQU1EIE9m
ZmljaWFsIFVzZSBPbmx5IC0gR2VuZXJhbF0NCj4gDQo+IFRoZSBkcml2ZXIgYWxyZWFkeSBoYXMg
c2ltaWxhciBjb2RlIGluIGh3bW9uX2F0dHJpYnV0ZXNfdmlzaWJsZSgpLCBTbywgDQo+IHdoYXQg
aXNzdWUgeW91IGhhdmUgbm93ID8NCj4gDQo+ICAgICAgICAgLyogdW5kZXIgbXVsdGktdmYgbW9k
ZSwgdGhlIGh3bW9uIGF0dHJpYnV0ZXMgYXJlIGFsbCBub3Qgc3VwcG9ydGVkICovDQo+ICAgICAg
ICAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJiAhYW1kZ3B1X3NyaW92X2lzX3BwX29uZV92
ZihhZGV2KSkNCj4NCg0KVGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgZm9yIGVhY2ggYXR0cmlidXRl
IG5vdywgc28gdGhlIHZmIGZsYWdzIHdpbGwgYWxzbyBiZSBjaGVja2VkIG11bHRpcGxlIHRpbWVz
LiANClNvIG1vdmUgdGhpcyBjb2RlIHRvIGFtZGdwdV9wbV9zeXNmc19pbml0IHNvIHRoYXQgdGhl
IHZmIGZsYWdzIHdpbGwgb25seSBiZSBjaGVja2VkIG9uY2UuDQoNClJlZ2FyZHMsDQpNYSBKdW4N
Cg0KICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gDQo+IEJlc3QgUmVnYXJkcywNCj4gS2V2
aW4NCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFt
ZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBNYSwgDQo+
IEp1bg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMzAsIDIwMjMgMjoxMCBQTQ0KPiBUbzogTWEs
IEp1biA8SnVuLk1hMkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEZl
bmcsIA0KPiBLZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRl
ciANCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
UmVzZW5kXSBkcm0vYW1kL3BtOiBvbmx5IGNoZWNrIHNyaW92IHZmIGZsYWcgb25jZSANCj4gd2hl
biBjcmVhdGluZyBod21vbiBzeXNmcw0KPiANCj4gcGluZy4uLg0KPiANCj4gT24gMTAvMjYvMjAy
MyAxMDo1MCBBTSwgTWEgSnVuIHdyb3RlOg0KPj4gVGhlIGN1cnJlbnQgY29kZSBjaGVja3Mgc3Jp
b3YgdmYgZmxhZyBtdWx0aXBsZSB0aW1lcyB3aGVuIGNyZWF0aW5nIA0KPj4gaHdtb24gc3lzZnMu
IFNvIGZpeCBpdC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBNYSBKdW4gPEp1bi5NYTJAYW1kLmNv
bT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMgfCAyNyAr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0
aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRn
cHVfcG0uYw0KPj4gaW5kZXggMzU4YmI1ZTQ4NWYyLi5lZTQ2ZDA0NTQ5ZTYgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9wbS5jDQo+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9wbS5jDQo+PiBAQCAtMzI4OCwxMCArMzI4OCw2IEBAIHN0
YXRpYyB1bW9kZV90IGh3bW9uX2F0dHJpYnV0ZXNfdmlzaWJsZShzdHJ1Y3Qga29iamVjdCAqa29i
aiwNCj4+ICAgICAgIHVpbnQzMl90IGdjX3ZlciA9IGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIEdD
X0hXSVAsIDApOw0KPj4gICAgICAgdWludDMyX3QgdG1wOw0KPj4NCj4+IC0gICAgIC8qIHVuZGVy
IG11bHRpLXZmIG1vZGUsIHRoZSBod21vbiBhdHRyaWJ1dGVzIGFyZSBhbGwgbm90IHN1cHBvcnRl
ZCAqLw0KPj4gLSAgICAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJiAhYW1kZ3B1X3NyaW92
X2lzX3BwX29uZV92ZihhZGV2KSkNCj4+IC0gICAgICAgICAgICAgcmV0dXJuIDA7DQo+PiAtDQo+
PiAgICAgICAvKiB1bmRlciBwcCBvbmUgdmYgbW9kZSBtYW5hZ2Ugb2YgaHdtb24gYXR0cmlidXRl
cyBpcyBub3Qgc3VwcG9ydGVkICovDQo+PiAgICAgICBpZiAoYW1kZ3B1X3NyaW92X2lzX3BwX29u
ZV92ZihhZGV2KSkNCj4+ICAgICAgICAgICAgICAgZWZmZWN0aXZlX21vZGUgJj0gflNfSVdVU1I7
IEBAIC00MTYyLDYgKzQxNTgsNyBAQCANCj4+IHN0YXRpYyBpbnQgYW1kZ3B1X29kX3NldF9pbml0
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPj4NCj4+ICBpbnQgYW1kZ3B1X3BtX3N5c2Zz
X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpICB7DQo+PiArICAgICBlbnVtIGFtZGdw
dV9zcmlvdl92Zl9tb2RlIG1vZGU7DQo+PiAgICAgICB1aW50MzJfdCBtYXNrID0gMDsNCj4+ICAg
ICAgIGludCByZXQ7DQo+Pg0KPj4gQEAgLTQxNzMsMTcgKzQxNzAsMjEgQEAgaW50IGFtZGdwdV9w
bV9zeXNmc19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPj4gICAgICAgaWYgKGFk
ZXYtPnBtLmRwbV9lbmFibGVkID09IDApDQo+PiAgICAgICAgICAgICAgIHJldHVybiAwOw0KPj4N
Cj4+IC0gICAgIGFkZXYtPnBtLmludF9od21vbl9kZXYgPSBod21vbl9kZXZpY2VfcmVnaXN0ZXJf
d2l0aF9ncm91cHMoYWRldi0+ZGV2LA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBEUklWRVJfTkFNRSwgYWRldiwNCj4+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaHdtb25fZ3JvdXBzKTsNCj4+IC0gICAgIGlmIChJU19FUlIoYWRldi0+cG0uaW50
X2h3bW9uX2RldikpIHsNCj4+IC0gICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihhZGV2LT5wbS5p
bnRfaHdtb25fZGV2KTsNCj4+IC0gICAgICAgICAgICAgZGV2X2VycihhZGV2LT5kZXYsDQo+PiAt
ICAgICAgICAgICAgICAgICAgICAgIlVuYWJsZSB0byByZWdpc3RlciBod21vbiBkZXZpY2U6ICVk
XG4iLCByZXQpOw0KPj4gLSAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKyAgICAgbW9kZSA9
IGFtZGdwdV92aXJ0X2dldF9zcmlvdl92Zl9tb2RlKGFkZXYpOw0KPj4gKw0KPj4gKyAgICAgLyog
dW5kZXIgbXVsdGktdmYgbW9kZSwgdGhlIGh3bW9uIGF0dHJpYnV0ZXMgYXJlIGFsbCBub3Qgc3Vw
cG9ydGVkICovDQo+PiArICAgICBpZiAobW9kZSAhPSBTUklPVl9WRl9NT0RFX01VTFRJX1ZGKSB7
DQo+PiArICAgICAgICAgICAgIGFkZXYtPnBtLmludF9od21vbl9kZXYgPSBod21vbl9kZXZpY2Vf
cmVnaXN0ZXJfd2l0aF9ncm91cHMoYWRldi0+ZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBEUklWRVJfTkFNRSwgYWRldiwNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdtb25f
Z3JvdXBzKTsNCj4+ICsgICAgICAgICAgICAgaWYgKElTX0VSUihhZGV2LT5wbS5pbnRfaHdtb25f
ZGV2KSkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIoYWRldi0+cG0u
aW50X2h3bW9uX2Rldik7DQo+PiArICAgICAgICAgICAgICAgICAgICAgZGV2X2VycihhZGV2LT5k
ZXYsICJVbmFibGUgdG8gcmVnaXN0ZXIgaHdtb24gZGV2aWNlOiAlZFxuIiwgcmV0KTsNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKyAgICAgICAgICAgICB9DQo+PiAg
ICAgICB9DQo+Pg0KPj4gLSAgICAgc3dpdGNoIChhbWRncHVfdmlydF9nZXRfc3Jpb3ZfdmZfbW9k
ZShhZGV2KSkgew0KPj4gKyAgICAgc3dpdGNoIChtb2RlKSB7DQo+PiAgICAgICBjYXNlIFNSSU9W
X1ZGX01PREVfT05FX1ZGOg0KPj4gICAgICAgICAgICAgICBtYXNrID0gQVRUUl9GTEFHX09ORVZG
Ow0KPj4gICAgICAgICAgICAgICBicmVhazsNCg==
