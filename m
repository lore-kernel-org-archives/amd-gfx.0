Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C343FECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Oct 2022 13:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FDF210E616;
	Mon, 24 Oct 2022 13:11:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA5FC10E615
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Oct 2022 13:11:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sh5vJ7C+X+uBAF+1NeaEpmbo7owNUNdJ3dvfJZ45uxqYmjDwOzHOKauPvLevGzm9dERCcxEWWsliNWFa47eaQbzB/zcSjy1joHTXyVbODJpS7u4Kq5U1EQFh6jY9vUzVtAaVr4JkN0jhxF46qgcyvXFdSCBjFrSVgaIt4Jnr+Lu+RYzjk/SAqUSSPqCnlPyWbEd6W9fg5MNyFpQOEsy4G/G5zxxuybYdTfYvFPzl2J3dJB5WYB+vPVfaVNnE1A4c7xhi870tTA9uyQB+mDwcXCLU4bJxF1+P+skoV64RYJonulgOtNWm3euvtjy9Rnzv1MXcOiGSVuLm/keDzsq6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOfIyUpXokEH64OtErqIx6ZIlgCUOXzvb7C8WDy7+ns=;
 b=F6tArW2GXrnNeThVczwb8+Fn4LJ/oN0C7o919YcsT1Nbr3jey0rcm63GgNxSYQEMO+OcHc/V5PDnMTF7vGDBEWxtLHYBGTGgycpnjpPnzT5Aaqz/YDyAlTvo34vCjrWUZZYo0OuVFpZOAuIzXXJFKG4h1AcAIrNtgp9zy7jOrARMD37jnQLlX4Ft4QnX0ncg5oZDdPFYWZHU9iUgYJrkpWknembKzc+KIp+qiKm8IXOWgKcidlnCMpO4KDGmjWWh0SqzbzoaxgwCtyo1IEUZJBr/JSAr/z96M/QO6phlF4rTlE6YxnyB9pnit7XDzY5OcTowOdlc8yAcNBaOHQlesw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOfIyUpXokEH64OtErqIx6ZIlgCUOXzvb7C8WDy7+ns=;
 b=Ty6T0HfHE9EJI6Bf9lJg/3+IufMSilclayITG7m+lUgg8wWUy42waAtAFS/KsaVz/JoYCZObaejyEQQsQWWroJWUrWXPP0sBiikOneV9GgOwsv7rvocsIutJtw1aI6gdnY4/XxKw/Bz0xwLu9ObMn3IHQ0yEoizdCe6AMNd5N1U=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.30; Mon, 24 Oct 2022 13:11:20 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::922d:e78b:3a15:9098]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::922d:e78b:3a15:9098%5]) with mapi id 15.20.5723.033; Mon, 24 Oct 2022
 13:11:20 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdkfd: introduce dummy cache info for property
 asic
Thread-Topic: [PATCH 1/2] drm/amdkfd: introduce dummy cache info for property
 asic
Thread-Index: AQHY5GR9Vo6yRCqP5keeMsOeNXWKUa4XcgGAgAChV/CAADreAIAAglGggACFA4CABDRiAA==
Date: Mon, 24 Oct 2022 13:11:20 +0000
Message-ID: <DS7PR12MB6005D46CE032EF40FE90246CFB2E9@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20221020091515.2758445-1-Prike.Liang@amd.com>
 <e92f2184-73bc-eb3c-d903-5a46c5c34ac0@amd.com>
 <DS7PR12MB600544275C2AB15530224DC5FB2D9@DS7PR12MB6005.namprd12.prod.outlook.com>
 <016ec155-12da-5a2d-9395-6941e332833d@amd.com>
 <DS7PR12MB60059C77644EA8907AFDC775FB2D9@DS7PR12MB6005.namprd12.prod.outlook.com>
 <5c9c6edc-0b6a-7bf0-6ec3-9916a339b8d0@amd.com>
In-Reply-To: <5c9c6edc-0b6a-7bf0-6ec3-9916a339b8d0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e90d8817-a762-4a62-a192-9465011b9404;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-24T13:06:07Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS0PR12MB7630:EE_
x-ms-office365-filtering-correlation-id: 8a30999b-94c6-49a0-16c6-08dab5c13e12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K5gWnhNfrgtIza77Au6U9jcmyPkGmYaOeKLQi4jeEqmkpEmMncqYHlZTo4arOYgnLLh82gmTW0DtB/atlwnVwzB7Ix/6QddSZOEyKjKjH6NCyiyqsKr8q9vzFUm2856jBUDiNkD7532Ts5u7fFY9sISwzMoPlr9MXjSEFVdUVjRqNVI4Zr0tG3WXY00lYxkFaSxaXIsV0C/Elu54S1E3PZdeIW3dw3GvnoMsS5s2EJpNi4vlSCZPJ/mQH4omFkt7q5+V92iYJRiDGoIiBteX41erk6/vKUx/QIKPf5FsD5fDinNnGNnpD1fUT66CA1wj9hIoUleqvg6CJObkfqlmmXkpcyUAXicf0StKYQcf+Oadsin1CZaQIBZrYq6MOjFSyS8PbPGIJpcj5vFoWivy+jhOHQo0MiSk4oJXq2/LQBY8CsY1h+3nUffEjV/ULeANJbJVAbXH+uhe/CIq7v50yMwFk/xuYCkq0VMWb/G11a64X2XhN9gzD6mhV84elDkqmEampAnFSKrzBItMLT7sTu9yHhklPeAATvk2CI476Y+47F/QzMUXcZyjLc6zaIqJHH6mPbkCHzt6v0mDNIUlYoGFF6QH5M3lZKCMCc9mezEtffgoo4L6+dl6Ssh9eAYw3b4WQAXdYXHQtZLp7h6XeOB962fJgkZiPePuyf0vumK75UL80FrdburudA2M4C/0l4xYl9ckmdWlSI9amebi7YD4V4fQB2BF1EBh7aC5NKreiM6M2UTzeBBcUOIYZPQOsauLt7eAVit4bdqThzSkgg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199015)(8676002)(26005)(7696005)(83380400001)(4326008)(4001150100001)(38070700005)(186003)(54906003)(38100700002)(5660300002)(122000001)(41300700001)(64756008)(86362001)(8936002)(52536014)(55016003)(66556008)(53546011)(76116006)(6506007)(110136005)(66446008)(316002)(66476007)(478600001)(9686003)(71200400001)(66946007)(2906002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODRCVnBpT1VySW8ydGdUbFQvTndWOEk2SU1iMjZQc0hoZ1AzeDRaTzBpNXM4?=
 =?utf-8?B?c3pLVDU1M3YrWHFBRUFPeUd4bGRWSURSZUFSTmo4SkxoVnRtcis2Ym5kMUN0?=
 =?utf-8?B?bmRoclJQSUV2Z0FDcThxK0YyZXJmK044azhWSVVLdFlBaStwcjhnZGY3N2k2?=
 =?utf-8?B?WDNwb0xjdE5pNENjM0lvaVdyWEJSRHI4bmpod1k5cTZ1N0k1emtoTTBEamY1?=
 =?utf-8?B?UjNpZjUyRXBJREh1VFRNOXlSOUhYRUJPbk4vd1ZDemJkcUdwRWM1d2dsRzNS?=
 =?utf-8?B?L0wvVmw3MWJEbDcxaEJYbmx6WE93R3hUdTE3UnduRXVBMlZ6OEhoUDdqTGM5?=
 =?utf-8?B?U3JSU28zbGJSMVZMTHdvL3Y2aktqUlZTOExDNzVRb2E1ZCtPWUZSQUJHR3lL?=
 =?utf-8?B?TnhvOS9EcFFPNWpYV1BNcWt5UU5wWU9CUlR5alcwc3R2OWhnMUdOcUs2RUg0?=
 =?utf-8?B?MkJVZ3M4STF0bUVhVDMrUG53YTVmM1NtZE9ja2liY2VWTlpXclorSlo2LzFz?=
 =?utf-8?B?VlV4bzd5OHNkanExTWQ1S1ZibU1YdjA4MFFxUnUzMitPdkZ3cUdhd0w3Uldw?=
 =?utf-8?B?Z0k5QWlIWjdJem5HanVFcHVKVXVzQ0JqTll2eW1rRDdwTGk4dGg2c0x6Ly9C?=
 =?utf-8?B?WU9zNmc5Zm1peE4rd3k3Y3I2Z0ozcy9CYUFUN0tCS1BJck9PaHl3OG43Y1VX?=
 =?utf-8?B?aFoxaDVxVkk3K3Z6VjNkckJid1psNkk1QVNKR2daT0ExUDBZUnE5Wm5SaTJp?=
 =?utf-8?B?WUVzYWF5a3RHdThNbzl5SVBaNXdkRlltRklVT3M2djFSQnVhZGVzOG9DRDBo?=
 =?utf-8?B?RVk3NFB5OS9vM1FKM2hENlZNbTRLWnpHcE1tMFFtbk9GUjZseUw1dExYRjVJ?=
 =?utf-8?B?UWZTc201d1AwQWF0aHB4UkZlOUJMb1N1WVZoakphbUkyU3JyTWgvdWdYUGps?=
 =?utf-8?B?N3ZXeVFQL0pXc2VENnFCVk5yNlBPbFdLdWo3R3hUUURKUmMreTAwNFkvNGl2?=
 =?utf-8?B?TUVXQjhEVExqWWE4amJHSklZR2c0Z1NiQ3c5d09jUlBzWHovN2pWazg1bzZE?=
 =?utf-8?B?WENQUGNCYmVHUzlSR1BVUGVOUU4yOGdvdWJySzBBY0JmNTltbE5CSVB6cTlx?=
 =?utf-8?B?SFg0ZFRjRHVsVFZPL1BHVkhiMjV2NXVVRkdVU2hXQkxWbjhpcFdMQXEyTkZO?=
 =?utf-8?B?TTZ4RVh1LzFMNkV4SHRUa1d0cEFrNXhOWGpDeFM3aklxUU95bkxZZ3VhK1VW?=
 =?utf-8?B?aWRnd2hDVzdZdGRvWE10bDZaU056VloyYk01bzdFbjlEaGsyOWFHSVRpbGdR?=
 =?utf-8?B?WmtKYUFpeXNiTTlibkljUlpJUjNnYzV2emE4SkM0ZnAzQXRzSktzYUFnMWd5?=
 =?utf-8?B?N3AxZzNkRnhBSjdxUFlDOEcrZU1IRmsxVXlBSFlMNGxNZ2xwSEVXYkI4NTk4?=
 =?utf-8?B?RkhrTWpZZzdWd1ljUjgzL2RQWm4xbm03ejlOOEZRYWl1OGQ3dUpqUEt5cld1?=
 =?utf-8?B?QmRvcGR5SndUUnB3c3AyOUFwc0dCOW5MUlI1eFF4WjRyRUUxSngrK0JrOTRL?=
 =?utf-8?B?eHF2dUp3VmkzNzhBdjBxTzJCVHNxYUJEQWFHZ05RTkRkbVQ5NUN0Z0k4Sngr?=
 =?utf-8?B?Uzh3UUNIbERHaDFGeExiNklEZ0FxMkVKdHJCTFFUTndISXlZd0I0Q012ZVlM?=
 =?utf-8?B?TWMvazgzeVlOeFNkZ3BJR1JDN0lJbi9SaWVOd0h0d09sZDMrblpyM1pjOTBU?=
 =?utf-8?B?RzNJYTc5OTBFcVRFOHdmQXJyNllGanBuUXNWYlRIczNWVHJsNGE0dzE0R1lr?=
 =?utf-8?B?WlNwZ2VlZFpJc0g0S2ZsZlZCQ1RITGwyYVNKLzd2NE0vZHV1OWhBcVk2Y0NY?=
 =?utf-8?B?bEFHeG5ZOTJjUk4zRE9UcklRd2xXemx4YXdIZE15ajZLV0hKcU1YSVFZU1E0?=
 =?utf-8?B?Y1d3cTR4bW5vY2dPRHlsdEZCYjgrWS96TGhhcnlNVEJWcENscVNkaXBNS1Zr?=
 =?utf-8?B?ZHhNTVIwYU9aaG5PenJqeTdVYnZNSlM4T2Z4L0FjOGpmbWhhVEttQ0gyVTRF?=
 =?utf-8?B?R1ovdWNqaERMNnp5UnlmZ0RTRUwvTHpRTjlhZHR4VXJCN1FsNXg1WlhzRzBY?=
 =?utf-8?Q?qdng=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a30999b-94c6-49a0-16c6-08dab5c13e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 13:11:20.0566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JiRvWarM3NBH1sbheHOjb5iEr7wCddZu8qI3kMaJjv1EVGQJT18vgGSAeiBQlnE0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630
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
 Yifan" <Yifan1.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEt1ZWhsaW5nLCBG
ZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NClNlbnQ6IFNhdHVyZGF5LCBPY3RvYmVyIDIy
LCAyMDIyIDQ6NTMgQU0NClRvOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFtZC5j
b20+OyBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47IExpdSwgQWFyb24gPEFhcm9uLkxp
dUBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGRybS9hbWRrZmQ6IGludHJvZHVj
ZSBkdW1teSBjYWNoZSBpbmZvIGZvciBwcm9wZXJ0eSBhc2ljDQoNCk9uIDIwMjItMTAtMjEgMDk6
MDUsIExpYW5nLCBQcmlrZSB3cm90ZToNCj4gW1B1YmxpY10NCj4NCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQu
Y29tPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMjEsIDIwMjIgMToxMSBQTQ0KPiBUbzogTGlh
bmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47IFpoYW5nLCBZaWZhbg0KPiA8WWlmYW4xLlpoYW5nQGFtZC5jb20+OyBIdWFuZywgUmF5IDxS
YXkuSHVhbmdAYW1kLmNvbT47IExpdSwgQWFyb24NCj4gPEFhcm9uLkxpdUBhbWQuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZHJtL2FtZGtmZDogaW50cm9kdWNlIGR1bW15IGNhY2hl
IGluZm8gZm9yDQo+IHByb3BlcnR5IGFzaWMNCj4NCj4gQW0gMjAyMi0xMC0yMCB1bSAyMTo1MCBz
Y2hyaWViIExpYW5nLCBQcmlrZToNCj4+IFtQdWJsaWNdDQo+Pg0KPj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4+IEZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4NCj4+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAyMSwgMjAyMiAxMjowMyBBTQ0KPj4gVG86
IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+PiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgWmhhbmcsIFlpZmFuDQo+PiA8WWlmYW4xLlpoYW5nQGFtZC5jb20+OyBIdWFuZywg
UmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47IExpdSwgQWFyb24NCj4+IDxBYXJvbi5MaXVAYW1kLmNv
bT4NCj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBkcm0vYW1ka2ZkOiBpbnRyb2R1Y2UgZHVt
bXkgY2FjaGUgaW5mbyBmb3INCj4+IHByb3BlcnR5IGFzaWMNCj4+DQo+Pg0KPj4gQW0gMjAyMi0x
MC0yMCB1bSAwNToxNSBzY2hyaWViIFByaWtlIExpYW5nOg0KPj4+IFRoaXMgZHVtbXkgY2FjaGUg
aW5mbyB3aWxsIGVuYWJsZSBrZmQgYmFzZSBmdW5jdGlvbiBzdXBwb3J0Lg0KPj4+DQo+Pj4gU2ln
bmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+Pj4gLS0tDQo+
Pj4gICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMgfCA1NSArKysrKysr
KysrKysrKysrKysrKysrKysrLS0NCj4+PiAgICAgMSBmaWxlIGNoYW5nZWQsIDUyIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pj4NCltzbmlwXQ0KPj4+IEBAIC0xNTI4LDcgKzE1NzQs
MTAgQEAgc3RhdGljIGludCBrZmRfZmlsbF9ncHVfY2FjaGVfaW5mbyhzdHJ1Y3Qga2ZkX2RldiAq
a2RldiwNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGtmZF9maWxsX2dwdV9j
YWNoZV9pbmZvX2Zyb21fZ2Z4X2NvbmZpZyhrZGV2LCBwY2FjaGVfaW5mbyk7DQo+Pj4gICAgICAg
ICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+Pj4gICAgICAgICAgICAgICAgIGRlZmF1bHQ6DQo+
Pj4gLSAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4+ICsgICAgICAgICAg
ICAgICAgICAgICBwY2FjaGVfaW5mbyA9IGR1bW15X2NhY2hlX2luZm87DQo+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgIG51bV9vZl9jYWNoZV90eXBlcyA9IEFSUkFZX1NJWkUoZHVtbXlfY2FjaGVf
aW5mbyk7DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgIHByX3dhcm4oImR1bW15IGNhY2hlIGlu
Zm8gaXMgdXNlZCB0ZW1wb3JhcmlseSBhbmQgcmVhbCBjYWNoZSBpbmZvIG5lZWQgdXBkYXRlIGxh
dGVyLlxuIik7DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPj4gQ291bGQgd2Ug
bWFrZSB0aGlzIHJldHVybiBhbiBlcnJvciBpZiB0aGUgYW1kZ3B1LmV4cF9od19zdXBwb3J0IG1v
ZHVsZSBwYXJhbWV0ZXIgaXMgbm90IHNldD8NCj4+DQo+PiBSZWdhcmRzLA0KPj4gICAgICBGZWxp
eA0KPj4NCj4+IFtQcmlrZV0gSXQncyBmaW5lIHRvIHByb3RlY3QgdGhpcyBkdW1teSBpbmZvIGJ5
IGNoZWNraW5nIHRoZSBwYXJhbWV0ZXIgYW1kZ3B1X2V4cF9od19zdXBwb3J0LCBidXQgaXQgbWF5
IG5vdCBmcmllbmRseSB0byBlbmQgdXNlciBieSBhZGRpbmcgdGhlIHBhcmFtZXRlciBhbmQgc29t
ZSBndXlzIHdpbGwgc3RpbGwgcmVwb3J0IEtGRCBub3QgZW5hYmxlZCBmb3IgdGhpcyBwYXJhbWV0
ZXIgc2V0dGluZyBwcm9ibGVtLiBUaGUgb3JpZ2luYWwgaWRlYSBpcyB0aGUgZW5kIHVzZXIgd2ls
bCBub3QgYXdhcmUgdGhlIGR1bW15IGNhY2hlIGluZm8gYW5kIG9ubHkgYWxlcnQgdGhlIHdhcm5p
bmcgbWVzc2FnZSB0byBkZXZlbG9wZXIuDQo+IEkgdGhvdWdodCB0aGUgaW50ZW50aW9uIHdhcyB0
byBzaW1wbGlmeSBicmluZy11cCBidXQgbWFrZSBzdXJlIHRoYXQgdmFsaWQgY2FjaGUgaW5mbyBp
cyBhdmFpbGFibGUgYnkgdGhlIHRpbWUgYSBjaGlwIGdvZXMgaW50byBwcm9kdWN0aW9uLg0KPiBU
aGVyZWZvcmUsIG5vcm1hbCBlbmQgdXNlcnMgc2hvdWxkIG5ldmVyIG5lZWQgdG8gc2V0IHRoZSBh
bWRncHVfZXhwX2h3X3N1cHBvcnQgb3B0aW9uLiBJIHRoaW5rIHlvdSdyZSBzYXlpbmcgdGhhdCB3
ZSB3b3VsZCBnbyB0byBwcm9kdWN0aW9uIHdpdGggZHVtbXkgaW5mby4gVGhhdCBzZWVtcyBsaWtl
IGEgYmFkIGlkZWEgdG8gbWUuDQo+DQo+IFJlZ2FyZHMsDQo+ICAgICBGZWxpeA0KPg0KPiBbUHJp
a2VdICBTb3JyeSBmb3IgdGhlIGNvbmZ1c2lvbi4gSW4gZmFjdCwgdGhpcyBkdW1teSBjYWNoZSBp
bmZvIG9ubHkgdXNlZCBiZWZvcmUgcHJvZHVjdGlvbiBhbmQgbWVhbndoaWxlIG5lZWRuJ3QgcmVx
dWlyZSBhbnkgcGFyYW1ldGVyIHNldHRpbmcgZm9yIENRRSBkbyBLRkQgdGVzdC4gQW55d2F5IGlm
IHlvdSBzdGlsbCBoYXZlIGNvbmNlcm4gb24gdGhpcyBzb2x1dGlvbiBJIHdpbGwgYWRkIHRoZSBj
b25kaXRpb24gb2YgY2hlY2tpbmcgYW1kZ3B1X2V4cF9od19zdXBwb3J0Lg0KDQpUaGUgaWRlYSB0
byBjb250cm9sIHRoaXMgd2l0aCBhIG1vZHVsZSBwYXJhbWV0ZXIgd2FzIHRvIGNhdXNlIGEgbW9y
ZSBvYnZpb3VzIGZhaWx1cmUgaWYgd2UgZG9uJ3QgaGF2ZSBjb3JyZWN0IGNhY2hlIGluZm8gYmVm
b3JlIGdvaW5nIHRvIHByb2R1Y3Rpb24uIEp1c3QgYSB3YXJuaW5nIGluIHRoZSBsb2cgZmlsZSBp
cyB0b28gZWFzeSB0byBtaXNzIG9yIGlnbm9yZS4gT2YgY291cnNlLCBpZiBRQSBnZXRzIGludG8g
dGhlIGhhYml0IG9mIHRlc3Rpbmcgd2l0aCBhbWRncHVfZXhwX2h3X3N1cHBvcnQsIHRoZW4gdGhp
cyBtYXkgbm90IHNvbHZlIHRoZSBwcm9ibGVtLiBZb3UgbmVlZCB0byBoYXZlIGF0IGxlYXN0IG9u
ZSB0ZXN0IHBhc3Mgd2l0aG91dCBhbWRncHVfZXhwX2h3X3N1cHBvcnQgdG8gY2F0Y2ggbWlzc2lu
ZyBjYWNoZSBpbmZvLg0KDQpSZWdhcmRzLA0KICAgRmVsaXgNCg0KR2V0IHlvdXIgcG9pbnQuIEFz
IHRvIHRoZSBLRkQgc3VwcG9ydCBvbiBhIE5QSSB3aWxsIGJlIHRyYWNrZWQgYnkgYSB0aWNrZXQg
d2hpY2ggbWFrZSBzdXJlIHRoZSByZWFsIGNhY2hlIGluZm8gdXBkYXRlIGxhdGVyIGFmdGVyIHRo
aXMgZHVtbXkgY2FjaGUgaW5mbyBhc3NpZ25lZCBpbiB0aGUgZWFybHkgQlUgcGhhc2UuDQoNClRo
YW5rcywNClByaWtlDQo=
