Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79623C3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 08:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 041A910E176;
	Mon,  8 Jan 2024 08:13:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEA3B10E189
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 08:13:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8e0uLkR5ua7C0qCaviZHNX8EQJmgv1rxj9oegcB0wH+aJHZqe8uSSz6DZtHNhz9I0ppn+ybt+t9jScWSrf8HxVSzIr3ZG1ARaTcz1ZOGlhSySUs1QYltaK57XFM6+roAHq854UjvWYNsk16lEZKbRphoiHAAPJUQ6vAhqqD8Mgticf6UQqvVtMsjk8EeoxCgPAPl4VIUAmKz/vfhGbbFSEHlFWd+m+PdfElM9wengznJncoNQCl8VBb9lXYzUft5yNaMca9PGVvWrAvNpWk2urKTTUMU7feNRiLWSpqNx/gfzlhmzgxLg+e2t5rDPGNnS3/Oz+BSro+YpwE/cygug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ANcmg/sDuoVnzG+eR1qCMa5mEW7TwkGMxUVNqAyEUw=;
 b=bzrLK+wc9Wm8fCfhrVXY674JoNU3N1crUmmChRYn6hshGz9GC47efeCeig8UYqOV7XN70FDzZCQkJjCm+qNg0RjodlKxXv1quoli0Cp5vaFIThhpICkIeQoMiw5pcWfmXYtuHW1F4a1HbvZHLnIqP7l2aT01VLR1ygK/IYGrspA5RjBn3bCiWCZiS7pXO9aVXawkTYidKXXcU8sAo/vQIwK8zEabsmjhAGGxtyP7S97+JxWT2pneZfgy4mHKFu0X1LxAJSLJjP5ll0eIPO8HrQYm69NH7hvtqch0fpLyk0yyF2uTjGBtbMTN90dNdBcfvNW71+JK7tdytXls+YWojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ANcmg/sDuoVnzG+eR1qCMa5mEW7TwkGMxUVNqAyEUw=;
 b=dcT8+Xk4JKK8LLKyc3Gja1kWOSNRT9nUxw0Mo9N3yrdF2oE862liNQUh99+dzeavv2u3OfopkHHziHX9WjwGmbg2vpIFE7Bqz082/SnVrpEOZBmUo+/jMROUE8duaw1pH5X4uaAiIDFzInOisBjprCs9IuFfqwMXiFL93EKJLh8=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 08:13:23 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::3487:6cb4:7065:cdaa]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::3487:6cb4:7065:cdaa%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 08:13:23 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Update irq disable flow during unload
Thread-Topic: [PATCH] drm/amdgpu: Update irq disable flow during unload
Thread-Index: AQHaP+rwDFPcVk9JP0S4blSYfVfVgbDPkliAgAACXIA=
Date: Mon, 8 Jan 2024 08:13:23 +0000
Message-ID: <DS7PR12MB60714005DFBD7DFF9754A23B8E6B2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240105152100.471494-1-asad.kamal@amd.com>
 <5c1863cb-a528-4c12-9ad7-3c9589088863@amd.com>
In-Reply-To: <5c1863cb-a528-4c12-9ad7-3c9589088863@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5b42bf2f-a177-4fae-b8db-f7ad9c1a8c22;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-08T08:11:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|CH0PR12MB8485:EE_
x-ms-office365-filtering-correlation-id: 9c0f644f-c94a-425e-959a-08dc1021af2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6mkemKrsuYpDUs6C5DpVfCZ09aWEZ8vexnQHbVFyxAQ9cm6W4ZFgL+RRhQVw7YhjyGi4pPsM6w6mG0Rqsf8Uquz7CKJpWurhl62UaurBIZ+sh7iqXT6SbLkWEH5vTY1nZVoNB4nfMzURWzNMKH69MkbKOxrEgocfv6QGXroFnRuJknaQtrxjIg9i0HZkKAAodW9m7nrho4rvPsTMHdm7ZwU6eSPWnE+mtS7/9VE6wV1FAGbK7HrbTYN86GW/oJrDxpFUMC4rMNlS17P8hsp5Hg6boQLUHzxUeXYqV+5zKDNAVjfFDT/X+OF5HMVwija9o4oOGAF276E3JavpZ7+ScFTK7MBIRwDfc+oL7aFKeCsisUfhCwbpRYfSlKQqkKKtUsLaliB+a/cH/pkPWuXzv4vVTc2ZjtagL2BI3Zi1WhU8m82q3nusy1hldTFyibhCq10LK/LUKfj4o5D1RIi8jvIVpuJB6oPOEsBNwG0wcA78F6QBqYGdp1/Y9k92qFGvRZkxpI24eUNiQoPyX9naBbIwi5lwUhmnaRQzUvS6DgFrrnfx0L7O+QsM0rQfoEzjR2GRADKV5FCsSm7acfJVD7RPD8XZh1EUsrOSuBP7sHdioRy1Z2jkqL1Odw2/3d+K
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(15650500001)(38100700002)(5660300002)(122000001)(7696005)(71200400001)(478600001)(6636002)(66446008)(64756008)(2906002)(6862004)(33656002)(4326008)(52536014)(55016003)(26005)(8676002)(8936002)(6506007)(316002)(9686003)(54906003)(53546011)(38070700009)(41300700001)(86362001)(83380400001)(66556008)(66476007)(76116006)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDIwK0hoODNBYlp3TjhwOTRZbmMyRDF5Z1N6YzEvSmpTaXEraFZOME5UdU9B?=
 =?utf-8?B?WGhUQll1WjFpVVpUdlVSY2dsZmxsYWswSG5teE8vYU5zS25rNUtjWVZQc3d6?=
 =?utf-8?B?SEx3c2drajZpVGNIbERFbDlYVGZhS05xbUNLRi9BUlRJT3NiL2xpZzh6VmhB?=
 =?utf-8?B?NitsWGpWMnF3OWhRam5VQkxpV1hiV0pDejJhVjRobDZTc2pyYi9PZjE4dmkw?=
 =?utf-8?B?TG5yS29kaHZkMHRPODd4SHZ0UnRiOHZBaFBxaUtBazBnZ3FHUlJFZWFYN0NM?=
 =?utf-8?B?WVVpbnB4NXhDQWVNdDVBSWU1Y21NYXIyVW4weUJvbTVlY0h5UlRway9MaUVV?=
 =?utf-8?B?TytmZ3BhV3RNUkpCdlRQVHVIK1hzeHZrUWxwZFMvbzFzenlqSEdQbVlwcmNC?=
 =?utf-8?B?QkJjdFJHV2VWSjkyY3l1dURXT2RNMkNmNW9abGRmWjJuNHlXWHVGQ3hERVdv?=
 =?utf-8?B?amNkVld4RWp3dVFCRzhPMTdNbWFxZnkyNkdkM1VmSHROTUovcXpkODFDNURz?=
 =?utf-8?B?OXZYRFpZVk5qYVA3eGxUUVYrb1ZQWmlXN3M5d0ZxUVNaVXd4Uy8zUGx5czZa?=
 =?utf-8?B?Y3JrWXBrL2svU1dQMlBsQURTMlBteXROR09Pb1NnaTdYZzdMdEszaGlqcFVx?=
 =?utf-8?B?bEFicnY1UmZ4cWtrL1dra3d1amRBYkJ5QnZLU2ZGQjZVK2ovYjdsY2R1T1Rl?=
 =?utf-8?B?bnRON2FwVDlRdGFKeXBUTjRvY1lDVkNpNjNxNEN6SE9jajJWQWtxL1JtR3py?=
 =?utf-8?B?eklGaU9wQUoyTmpVMDRYOWQwUlhpY3BzR0FVeGJ3Yk5qejRkRjkrTE16Z0Nk?=
 =?utf-8?B?UzdzZm9ORWVnZ2htanI2czRvUDZRQ1VhMkxwY0Vid01CaEhCVjZKdG5yaE9u?=
 =?utf-8?B?dnAzK21ua2JBT2ZXZVZmTzE3elNsRGVWOXJ4MjJMN2FpU0cyNUJRZlBIc2ha?=
 =?utf-8?B?T1h3dFdOeUpYNk9zRTl3KzdGRmMzdllaUnRGQlp6UUhVQUVOZEl2VHhrSHdX?=
 =?utf-8?B?WWZvczAvNERzb010Z3VIblE4dVdpMzhxL3FrTjFVbVJyUEx0MVRlNHo5eW1R?=
 =?utf-8?B?dGp1RXk0NUlwWkIzUm5wZVd4V0haNjUxL1lpQks0RzVjQUd5cTJrd0lWMDds?=
 =?utf-8?B?d1BNNXNDLzNKM3ZuWDlZWHpLOHgyS1VQaVE0ZjAyOHpsdGExN1E3VXJNekJh?=
 =?utf-8?B?bnhOaTNoNzZzNGhTcVFwSzY5bU9jems4TU9GbGtaSGdFNnJtYkFlem5wWGow?=
 =?utf-8?B?aUpXeWpDVVhVR3Iraml4UDFvT1Zaa1JUekE2MWphN0kzaXhVRlZpZFJKWXJ1?=
 =?utf-8?B?djJmYkRhZ0dKOFU4bGU4WkdoVGsrNndSa0xxY204alBSbjcwbXB1VS9USXBw?=
 =?utf-8?B?bzZiVzNsUENsS1hGUjdkcnBzb0ZLNjVmZS9ISGdZNEZWUENsUnFUWFJGc2py?=
 =?utf-8?B?RU1BYTZRT1NGUjk5QVhFamFvTHJ4YS9EcXB2SHQxNUM2d0hmd0JCV1R6TTg5?=
 =?utf-8?B?U0Y4aWUxQTVQdVZGWm43bHpDZXVJcTZDUU0rQUNtK1VaajRzZjNieWt5dUFx?=
 =?utf-8?B?c1ArZ3VHREJhSU1Xb1djdVR1ZmRPeHJ1eEVUUDgxaCtFUGxvMmJ6ODRidXZY?=
 =?utf-8?B?VmxOazdmWStjNk56NkV0ZUhhdGZtNm1WcDE3UG5PQVpJOXYwK0taSkt4eFhQ?=
 =?utf-8?B?SDArSVFZNjRBOVBpNkdkazUrRUt2SkNXMXljT2VnZ1FtMTk4MU9mV0hXWlFm?=
 =?utf-8?B?cmQ4Rk1xZ3VDaWRoUFRGeGxRVHRyRTd1bkJjNGtuRUkrYW9HekxKdDdYVk41?=
 =?utf-8?B?Mnd6UU9mcWtob1FNSzJUTTJWUTBXdm5oemVkOTlUZXhoTHprMWZNNEpIQUNU?=
 =?utf-8?B?aEpOazh2WUovMW1sdmZCTHZsc21oMk5MVzNMdXRqYzNQdkRWbmxicFFyWC9H?=
 =?utf-8?B?bXVaQXJ5dFN6akliWnlHTkJJZnpROGhGcVJqdDB2dDFUYnQ0dlBiK1N3N2Ju?=
 =?utf-8?B?Q0ttMDlHM3crc2dCd1JiR2ZKdDhQeUlWdHBIenJRMVMrSC9uU2tmSHkyMHFT?=
 =?utf-8?B?RStYaStQTHdaN2FvR2dxbE9BRDNZS2tLTWdpaUd0SURCUUJOZTQ2L1V3N3BC?=
 =?utf-8?Q?x6fk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0f644f-c94a-425e-959a-08dc1021af2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 08:13:23.8258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+1WyYbrUK6ztxs0vuX38mVKpEPvwaYnPfVUARs9aCVTzPdsn489f+A+epI+69LOSmjnjhnlQ+iOuZ6zjo1Ctg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIENocmlzdGlhbiwNCg0KVGhh
bmsgeW91IGZvciB0aGUgY29tbWVudC4NCg0KVGhpcyBpcyBub3Qgbm9ybWFsIHJlc2V0LCBpdCBp
cyByZXNldCBkb25lIGR1cmluZyB1bmxvYWQgZm9yIHNtdSB2XzEzXzBfMi4NCg0KVGhhbmtzICYg
UmVnYXJkcw0KQXNhZA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS29lbmln
LCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClNlbnQ6IE1vbmRheSwgSmFu
dWFyeSA4LCAyMDI0IDE6MzMgUE0NClRvOiBLYW1hbCwgQXNhZCA8QXNhZC5LYW1hbEBhbWQuY29t
Pg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogVXBkYXRlIGlycSBkaXNhYmxlIGZs
b3cgZHVyaW5nIHVubG9hZA0KDQpBbSAwNS4wMS4yNCB1bSAxNjoyMSBzY2hyaWViIEFzYWQgS2Ft
YWw6DQo+IEluIGNlcnRhaW4gc3BlY2lhbCBjYXNlcywgZS5nIGRldmljZSByZXNldCBiZWZvcmUg
bW9kdWxlIHVubG9hZCwgaXJxDQo+IGdldHMgZGlzYWJsZWQgYXMgcGFydCBvZiByZXNldCBzZXF1
ZW5jZSBhbmQgd29uJ3QgZ2V0IGVuYWJsZWQgYmFjay4NCj4gQWRkIHNwZWNpYWwgY2hlY2sgdG8g
Y292ZXIgc3VjaCBzY2VuYXJpb3MNCg0KV2VsbCBjb21wbGV0ZSBOQUsgdG8gdGhhdC4gUmVzZXRz
IHNob3VsZG4ndCBhZmZlY3QgdGhlIElSUSBzdGF0ZSBhdCBhbGwhDQoNCklmIHRoaXMgaXMgYW4g
aXNzdWUgdGhlbiBzb21ldGhpbmcgZWxzZSBpcyBicm9rZW4uDQoNClJlZ2FyZHMsDQpDaHJpc3Rp
YW4uDQoNCj4NCj4gU2lnbmVkLW9mZi1ieTogQXNhZCBLYW1hbCA8YXNhZC5rYW1hbEBhbWQuY29t
Pg0KPiBTdWdnZXN0ZWQtYnk6IExpam8gTGF6YXIgPGxpam8ubGF6YXJAYW1kLmNvbT4NCj4gLS0t
DQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyB8IDEyICsrKysrKysr
KystLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgICAgfCAxMyArKysr
KysrKysrKy0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3Y5XzAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMNCj4gaW5k
ZXggMzcyZGU5ZjFjZTU5Li5hNGUxYjlhNTg2NzkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3Y5XzAuYw0KPiBAQCAtMjM2MSw2ICsyMzYxLDcgQEAgc3RhdGljIHZvaWQgZ21j
X3Y5XzBfZ2FydF9kaXNhYmxlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIHN0YXRp
YyBpbnQgZ21jX3Y5XzBfaHdfZmluaSh2b2lkICpoYW5kbGUpDQo+ICAgew0KPiAgICAgICBzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsN
Cj4gKyAgICAgYm9vbCBpcnFfcmVsZWFzZSA9IHRydWU7DQo+DQo+ICAgICAgIGdtY192OV8wX2dh
cnRfZGlzYWJsZShhZGV2KTsNCj4NCj4gQEAgLTIzNzgsOSArMjM3OSwxNiBAQCBzdGF0aWMgaW50
IGdtY192OV8wX2h3X2Zpbmkodm9pZCAqaGFuZGxlKQ0KPiAgICAgICBpZiAoYWRldi0+bW1odWIu
ZnVuY3MtPnVwZGF0ZV9wb3dlcl9nYXRpbmcpDQo+ICAgICAgICAgICAgICAgYWRldi0+bW1odWIu
ZnVuY3MtPnVwZGF0ZV9wb3dlcl9nYXRpbmcoYWRldiwgZmFsc2UpOw0KPg0KPiAtICAgICBhbWRn
cHVfaXJxX3B1dChhZGV2LCAmYWRldi0+Z21jLnZtX2ZhdWx0LCAwKTsNCj4gKyAgICAgaWYgKGFk
ZXYtPnNodXRkb3duKQ0KPiArICAgICAgICAgICAgIGlycV9yZWxlYXNlID0gYW1kZ3B1X2lycV9l
bmFibGVkKGFkZXYsICZhZGV2LT5nbWMudm1fZmF1bHQsIDApOw0KPg0KPiAtICAgICBpZiAoYWRl
di0+Z21jLmVjY19pcnEuZnVuY3MgJiYNCj4gKyAgICAgaWYgKGlycV9yZWxlYXNlKQ0KPiArICAg
ICAgICAgICAgIGFtZGdwdV9pcnFfcHV0KGFkZXYsICZhZGV2LT5nbWMudm1fZmF1bHQsIDApOw0K
PiArDQo+ICsgICAgIGlmIChhZGV2LT5zaHV0ZG93bikNCj4gKyAgICAgICAgICAgICBpcnFfcmVs
ZWFzZSA9IGFtZGdwdV9pcnFfZW5hYmxlZChhZGV2LCAmYWRldi0+Z21jLmVjY19pcnEsIDApOw0K
PiArDQo+ICsgICAgIGlmIChhZGV2LT5nbWMuZWNjX2lycS5mdW5jcyAmJiBpcnFfcmVsZWFzZSAm
Jg0KPiAgICAgICAgICAgICAgIGFtZGdwdV9yYXNfaXNfc3VwcG9ydGVkKGFkZXYsIEFNREdQVV9S
QVNfQkxPQ0tfX1VNQykpDQo+ICAgICAgICAgICAgICAgYW1kZ3B1X2lycV9wdXQoYWRldiwgJmFk
ZXYtPmdtYy5lY2NfaXJxLCAwKTsNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NvYzE1LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5j
DQo+IGluZGV4IDE1MDMzZWZlYzJiYS4uN2VlODM1MDQ5ZDU3IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NvYzE1LmMNCj4gQEAgLTEyNjYsNiArMTI2Niw3IEBAIHN0YXRpYyBpbnQgc29j
MTVfY29tbW9uX2h3X2luaXQodm9pZCAqaGFuZGxlKQ0KPiAgIHN0YXRpYyBpbnQgc29jMTVfY29t
bW9uX2h3X2Zpbmkodm9pZCAqaGFuZGxlKQ0KPiAgIHsNCj4gICAgICAgc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7DQo+ICsgICAgIGJv
b2wgaXJxX3JlbGVhc2UgPSB0cnVlOw0KPg0KPiAgICAgICAvKiBEaXNhYmxlIHRoZSBkb29yYmVs
bCBhcGVydHVyZSBhbmQgc2VsZnJpbmcgZG9vcmJlbGwgYXBlcnR1cmUNCj4gICAgICAgICogc2Vw
YXJhdGVseSBpbiBod19maW5pIGJlY2F1c2Ugc29jMTVfZW5hYmxlX2Rvb3JiZWxsX2FwZXJ0dXJl
IEBADQo+IC0xMjgwLDEwICsxMjgxLDE4IEBAIHN0YXRpYyBpbnQgc29jMTVfY29tbW9uX2h3X2Zp
bmkodm9pZCAqaGFuZGxlKQ0KPg0KPiAgICAgICBpZiAoYWRldi0+bmJpby5yYXNfaWYgJiYNCj4g
ICAgICAgICAgIGFtZGdwdV9yYXNfaXNfc3VwcG9ydGVkKGFkZXYsIGFkZXYtPm5iaW8ucmFzX2lm
LT5ibG9jaykpIHsNCj4gLSAgICAgICAgICAgICBpZiAoYWRldi0+bmJpby5yYXMgJiYNCj4gKyAg
ICAgICAgICAgICBpZiAoYWRldi0+c2h1dGRvd24pDQo+ICsgICAgICAgICAgICAgICAgICAgICBp
cnFfcmVsZWFzZSA9IGFtZGdwdV9pcnFfZW5hYmxlZChhZGV2LA0KPiArJmFkZXYtPm5iaW8ucmFz
X2NvbnRyb2xsZXJfaXJxLCAwKTsNCj4gKw0KPiArICAgICAgICAgICAgIGlmIChhZGV2LT5uYmlv
LnJhcyAmJiBpcnFfcmVsZWFzZSAmJg0KPiAgICAgICAgICAgICAgICAgICBhZGV2LT5uYmlvLnJh
cy0+aW5pdF9yYXNfY29udHJvbGxlcl9pbnRlcnJ1cHQpDQo+ICAgICAgICAgICAgICAgICAgICAg
ICBhbWRncHVfaXJxX3B1dChhZGV2LCAmYWRldi0+bmJpby5yYXNfY29udHJvbGxlcl9pcnEsIDAp
Ow0KPiAtICAgICAgICAgICAgIGlmIChhZGV2LT5uYmlvLnJhcyAmJg0KPiArDQo+ICsgICAgICAg
ICAgICAgaWYgKGFkZXYtPnNodXRkb3duKQ0KPiArICAgICAgICAgICAgICAgICAgICAgaXJxX3Jl
bGVhc2UgPSBhbWRncHVfaXJxX2VuYWJsZWQoYWRldiwNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAmYWRldi0+bmJpby5yYXNfZXJyX2V2ZW50X2F0aHViX2lycSwgMCk7
DQo+ICsNCj4gKyAgICAgICAgICAgICBpZiAoYWRldi0+bmJpby5yYXMgJiYgaXJxX3JlbGVhc2Ug
JiYNCj4gICAgICAgICAgICAgICAgICAgYWRldi0+bmJpby5yYXMtPmluaXRfcmFzX2Vycl9ldmVu
dF9hdGh1Yl9pbnRlcnJ1cHQpDQo+ICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVfaXJxX3B1
dChhZGV2LCAmYWRldi0+bmJpby5yYXNfZXJyX2V2ZW50X2F0aHViX2lycSwgMCk7DQo+ICAgICAg
IH0NCg0K
