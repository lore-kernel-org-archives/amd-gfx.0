Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31034C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 03:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC4C6610A5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 03:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC4C6610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0786E4B0;
	Fri, 13 Aug 2021 03:29:33 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2047.outbound.protection.outlook.com [40.107.212.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 073706E4B0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 03:29:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUrY2y2wlnACAJlHgE3PeVFHf34NHPmz1SG57ZViXPYOAUMbqB6XGOx9QIZNXbGSQUWpDMxwOyr2xA5S1pt8bSAfI32GvG0b9/dv2WyQ1EIOSdoIPL4otovxxDeBDhqyGZH0A/QvtKouUOU2pN7VUOOm3rIeEZc2Sk0C3QelgT1+QOUJThzFN8ESddVkkX9cKHGU8gAaCDiCTa7q+SEpnI2QaMz6aezOgp49GXB+4lwxT9+Y64W2SeDqxFd6LhaORGdLyjN58KDl8TtjbIV8oLClBhQl+Zqf4MUkwAg/llNK0+m7SVDrxvKE4+GKO8pCDS9LiQjqLCe+8d68Akvh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTNDD7euUPcnW69qwGcRnkWxhF03mukiJThf8AyRQo8=;
 b=bAeWhokQvxg8StnhNHgPMFy65hZm0uXaKXyVim8M1/a6hPC1soCFa+viKKZNJ8IeWoT6Xnm5uYNJpZhoSNjq8Fa0N7ddkOsvtYiH3vni9Nh6MsSwwEdiO8xePnk2B+NJ9K1bIL7rLtMu+9O3sAepPqN/P2ZomeCvPImAdqBLX6MmWArYtSUZHXjWuudzjlUHilyfydmGtkPLZul2jlQvbYG7hRvrsFEBwYMIo04RlF4pgnw1CRLOqIXK4IBskXyK1xfDxp5lEKvsyR2ExPMmc0l7BxX6sYwRtvx0MzCnpYoMQOFQkQ1Bxm1pZCrz3qw2Y0IkYVRSI5e2XsQi9WW/rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTNDD7euUPcnW69qwGcRnkWxhF03mukiJThf8AyRQo8=;
 b=rdC2gYRwew4MZugVatqKTGitEq4ga53S3vLzyX7z86/wN6xpqCrWmdXMyF1zRl4ciDaM6vBigGQYBzUzX5IA5SZXMrcp0Mo6VgF+Vdr2z4F66gBLuZ6pSI62cyCzy/Q1BYV8VlQMaRORamgx3QDfBZcgZZE39fXhqYTGEcX729E=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.15; Fri, 13 Aug 2021 03:29:29 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4415.017; Fri, 13 Aug 2021
 03:29:29 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "nils.wallmenius@gmail.com" <nils.wallmenius@gmail.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>
Subject: RE: [PATCH V3 2/7] drm/amd/pm: record the RPM and PWM based fan speed
 settings
Thread-Topic: [PATCH V3 2/7] drm/amd/pm: record the RPM and PWM based fan
 speed settings
Thread-Index: AQHXj10dQ6MlPUlqn0CxaN8iTnzSNqtvn7KAgAEoRtA=
Date: Fri, 13 Aug 2021 03:29:28 +0000
Message-ID: <DM6PR12MB26195B75C1B25D8679BD7B35E4FA9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210812093308.1322342-1-evan.quan@amd.com>
 <20210812093308.1322342-2-evan.quan@amd.com>
 <6bcfaa06-182f-9f19-f3f8-ab16b9265efb@amd.com>
In-Reply-To: <6bcfaa06-182f-9f19-f3f8-ab16b9265efb@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-13T03:29:26Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=eca093c2-58de-4ebf-9012-be1f0494dfec;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f4aeb46-bc02-46e7-b8bd-08d95e0a8eec
x-ms-traffictypediagnostic: DM6PR12MB4155:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4155ED48A1CAFBE1A2C8A21BE4FA9@DM6PR12MB4155.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5lj32XUT6nfUI6f3h/FRxFTGoKpoX3rADVT8/YYzBNfrrLfTXuIskFuyNbQcFTzfsSW6GTZrGyt/HnyWSHQEgktDvL1T0FGn2D8h67lLX4fqTl5zWVm2DWFb4C8kqqppfODmJ/oUJOFm9javbbGjJLDNuz758lnHNOT71HatdzrS5D6oomdXJP/ZBnGb+/thVjXTj8iqwOEQmAa9cu1jsfD+4ZYDQEfpSIV+/jIcQI1tXtOeUUrJ8v3QxkcItnMLgUqULDkZ2odcgqIrcYZcgF0fWboyCsF4bHBCMRrxpj/IHpU0uAZwlpcKKPfZgO0qVkA2YhJ5B5vpj6lB1LYQm2E9apjYjjiWP3EStIbVsrmHC+ZoUriYhSFaU77z80gFKSs8l3sA+SLrBhNY919NECKUAprlCEl117AQoLemvGSv6WwLDNf5hrqyykaUJTgO2ow2W/BPfQ9ffC1WUbwKmTCy8WStiRKw+I5+Gkvfa3YnTZyEYJ8b+HTY+qFFIEZWYOVUzg2J1aRX43rCj1kJE/leht65W128SFS8dyGPd5vmnVUuocVW3BBLlLyACU07SMrPtHPi2HngyBJYoUrfAPszqAG8UoBV/UKdFMhpm8B8QrtxsGdKHYTKgm1pmxXyhTNTcUgyGCjY2Ft4o4rXBJva3v8xK/u6kgh26EFwE+ajH6C5kRhhe+r2r28wjmWhnnj2y5j7a96ebsSNdMEjqw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(66446008)(66556008)(64756008)(55016002)(5660300002)(186003)(66476007)(38100700002)(8936002)(8676002)(478600001)(52536014)(86362001)(9686003)(53546011)(2906002)(71200400001)(6506007)(26005)(122000001)(83380400001)(33656002)(316002)(4326008)(110136005)(54906003)(38070700005)(66946007)(7696005)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WncvWklJSHFzR090U0F0MmUxNk1xdXFyL3BoaUtDeFRpTmRWMUNhUURtU01B?=
 =?utf-8?B?eEpzUjFnc0lHYXdhekdTcVZCZE0zcnlmRUVWRU5BRjd3ZTFIMDF1V2o3RUVR?=
 =?utf-8?B?Nis2WUs0SjVacjBzeTVMMzBXYVh2eHh2ZXVqeWltOU4vVnFqYzJBWXduR0RB?=
 =?utf-8?B?L0tMSGQyUTFoc2ViSTJEUzE0Vk5vNXR5RkZvcDM0L0szS0w2dEU2MjM1NDRV?=
 =?utf-8?B?UmNQS09JaVNneGV4dTZaL3k1OStwNm9YNkhrSGZsRVZTcDZIeGlpVW10d1l4?=
 =?utf-8?B?Mkd0Y0xGTndaK0ZKbUJaaTVLY29RSzJiYU5aL1FrWTV2eGNMS2tIK20vdXAx?=
 =?utf-8?B?ZzRsS3dQM3JrV1RJK2JjUW9NSEF6MlBxTFZVUlQweXM3dGRYc3E1K1h4akpa?=
 =?utf-8?B?WHM2MzJsWEhjNUErWjdiVlVFS0JWenVnWU02R0JjcCtYcWQ3d25zS1VFTW51?=
 =?utf-8?B?SDVoOU5QUWFqeWhHRVJnOEVHK3p5UHFkWHpBTVZKeFQ1OVVzcFVrSE5FeXds?=
 =?utf-8?B?a2lHRE5UUjhnQXErdGxZcHVtNWpOOXdpcEhGOVV3d0ZVdXpyejNKMWlrNENI?=
 =?utf-8?B?TzRVc1JqejU2YWtaNnUyVElKaERXVWkrNlZkYWpQaExYc2xQRlprRjBRaENX?=
 =?utf-8?B?Nnc5TElVWVNQYUdDZUwyNk9BYldPc0dROVpza1p1amUwajRzVzVwVkMxN0tU?=
 =?utf-8?B?d0Qya1IwT1FPN2xTUzN5UVZhNjJQcG16a3BDSW1WRmd3MUxhUVRpVTRkUEFx?=
 =?utf-8?B?UkwwQkh2Nm9aNEFmMjhjbHJQZ3puZjJrNFVMK0wvTU9FNFZkUmp1UlNwV25r?=
 =?utf-8?B?SW52Q0RBOGRaa3JWTE5HUzdoNkVTaVd3L013TjdyQkFieFhFSFl4RThwcGI4?=
 =?utf-8?B?OXVPUkE0SWhsWGM5MW9oZEdoa0lsWkdjaitNRXhvQ09uQ2o2c0MyRzFrUlp5?=
 =?utf-8?B?TnA1Y2x5TmdNQmN1SzYzckZjS3p6dWdNc08vb0o2TktVbEV4cFZET3M2Ui9w?=
 =?utf-8?B?NlVLM0lvMlV0aWhabFJiRS9GVGoyVEVNcURMQXlGWFljWUhpdzJvY2JSVkNs?=
 =?utf-8?B?Vis0NEh1VHZUT2pXMjQxYlpkVjNDbjJKMVQweUJQK00zbHJTeUtQM1hadXNp?=
 =?utf-8?B?YTJhRm95MVhHK3dKZTFybWUyZGZwamFsRi9Vb2NKQjgxMS92dnJyUzRJYW84?=
 =?utf-8?B?aVhZUUF3Q0FBVGJlSHVXRy9BZ3VkaUpKK2I4YVRxd01Mb011MTYrdExDY3ow?=
 =?utf-8?B?ZnF5Z0tmL0k4dHd4MWo3MXU5SElGVmExdFNndFFCTHBlZ2JKR1VNTUVDZFEv?=
 =?utf-8?B?Tk1NTGRBZnV2a1IxT3Joa3UwcEVVUGJ4YXl4dUJhZXU0cXVUT3lST0ZzbkNp?=
 =?utf-8?B?UGJjK3REbDdGek9BSStNUjFQZ3NSRDJLQkY1eVRGS0xkeWlQOUVCUlYwSk00?=
 =?utf-8?B?VC9oTVphSko3b2s4d2wyNFByb2xjQnpyY3pZRW1SZzdlWmZKWmpkc0VvOGhy?=
 =?utf-8?B?Wkw4UEh0ZG5VU0IrSDQvTzNqTGhFWVNxOWhYR1BJL0M4MWNkUkp5UjVDMm1k?=
 =?utf-8?B?Vy9QWGRNUmN0RVZIR1B5RVEzVDdwdElFenFuYUo2QTRZQ0E4czVXQXE1WTh6?=
 =?utf-8?B?WlJrcGpWVXVnZWZEZjZ3VGJFRHF2ZXAyeDZVRFhHQUF4YkpHSnVJc2ZPa0pX?=
 =?utf-8?B?UFl0eUpHTUJMK3krbmROT0s2UnB0WjJwdUxENkNCUUJyWklZbjBPQWt6M1cr?=
 =?utf-8?Q?kG4AJzwyYomvO041PKPeCMr5z7xaqh9yABnRTqB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4aeb46-bc02-46e7-b8bd-08d95e0a8eec
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 03:29:28.8639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qHxS16tqf9+36l1lj0j14wYJdKyTkGtc/vEybsAPQHtHtCIcRJ74vWuC7RPR9IZN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIEF1Z3VzdCAxMiwgMjAyMSA1OjQ5IFBNDQo+IFRvOiBRdWFuLCBFdmFuIDxFdmFuLlF1
YW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBuaWxzLndh
bGxtZW5pdXNAZ21haWwuY29tOyBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMi83XSBkcm0vYW1kL3BtOiByZWNvcmQgdGhlIFJQTSBh
bmQgUFdNIGJhc2VkDQo+IGZhbiBzcGVlZCBzZXR0aW5ncw0KPiANCj4gDQo+IA0KPiBPbiA4LzEy
LzIwMjEgMzowMyBQTSwgRXZhbiBRdWFuIHdyb3RlOg0KPiA+IEFzIHRoZSByZWxhdGlvbnNoaXAg
IlBXTSA9IFJQTSAvIHNtdS0+ZmFuX21heF9ycG0iIGJldHdlZW4gZmFuDQo+IHNwZWVkDQo+ID4g
UFdNIGFuZCBSUE0gaXMgbm90IHRydWUgZm9yIFNNVTExIEFTSUNzLiBTbywgYm90aCB0aGUgUlBN
IGFuZCBQV00NCj4gPiBzZXR0aW5ncyBuZWVkIHRvIGJlIHNhdmVkLg0KPiA+DQo+ID4gQ2hhbmdl
LUlkOiBJMzE4YzEzNGQ0NDIyNzNkNTE4YjgwNTMzOWNkZjM4M2UxNTFiOTM1ZA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQo+ID4gLS0NCj4gPiB2MS0+
djI6DQo+ID4gICAgLSBjb2Rpbmcgc3R5bGUgYW5kIGxvZ2dpbmcgcHJpbnRzIG9wdGltaXphdGlv
biAoR3VjaHVuKQ0KPiA+ICAgIC0gcmV1c2UgZXhpc3RpbmcgZmxhZ3MgKExpam8pDQo+ID4gdjIt
PnYzOg0KPiA+ICAgIC0gZGlzYWxsb3cgZmFuIHNwZWVkIHNldHRpbmcgdmlhIFBXTSBhbmQgUlBN
IGF0IHRoZSBzYW1lIHRpbWUNCj4gPiAoTGlqbykNCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMgICAgICAgIHwgIDMgKysrDQo+ID4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL2luYy9hbWRncHVfc211LmggICB8ICAzICsrKw0KPiA+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMgfCAzMA0KPiArKysrKysrKysrKysrKysr
KystLS0tLQ0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCA2IGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1k
Z3B1X3BtLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCj4gPiBp
bmRleCAwNGM3ZDgyZjhiODkuLjExMmVlNWY1ZDg1NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9wbS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9hbWRncHVfcG0uYw0KPiA+IEBAIC0zMTc0LDYgKzMxNzQsOSBAQCBzdGF0aWMgc3NpemVf
dA0KPiBhbWRncHVfaHdtb25fc2hvd19tY2xrX2xhYmVsKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4g
PiAgICAqDQo+ID4gICAgKiAtIGZhblsxLVwqXV9lbmFibGU6IEVuYWJsZSBvciBkaXNhYmxlIHRo
ZSBzZW5zb3JzLjE6IEVuYWJsZSAwOiBEaXNhYmxlDQo+ID4gICAgKg0KPiA+ICsgKiBOT1RFOiBE
TyBOT1Qgc2V0IHRoZSBmYW4gc3BlZWQgdmlhICJwd20xIiBhbmQgImZhblsxLVwqXV90YXJnZXQi
DQo+IGludGVyZmFjZXMgYXQgdGhlIHNhbWUgdGltZS4NCj4gPiArICogICAgICAgVGhhdCB3aWxs
IGdldCB0aGUgZm9ybWVyIG9uZSBvdmVycmlkZGVuLg0KPiA+ICsgKg0KPiA+ICAgICogaHdtb24g
aW50ZXJmYWNlcyBmb3IgR1BVIGNsb2NrczoNCj4gPiAgICAqDQo+ID4gICAgKiAtIGZyZXExX2lu
cHV0OiB0aGUgZ2Z4L2NvbXB1dGUgY2xvY2sgaW4gaGVydHogZGlmZiAtLWdpdA0KPiA+IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X3NtdS5oDQo+ID4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL2luYy9hbWRncHVfc211LmgNCj4gPiBpbmRleCAxODM2NTRmOGI1NjQuLjI5OTM0
YTVhZjQ0ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRn
cHVfc211LmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfc211
LmgNCj4gPiBAQCAtMzQsNiArMzQsOCBAQA0KPiA+ICAgI2RlZmluZSBTTVVfRldfTkFNRV9MRU4J
CQkweDI0DQo+ID4NCj4gPiAgICNkZWZpbmUgU01VX0RQTV9VU0VSX1BST0ZJTEVfUkVTVE9SRSAo
MSA8PCAwKQ0KPiA+ICsjZGVmaW5lIFNNVV9DVVNUT01fRkFOX1NQRUVEX1JQTSAgICAgKDEgPDwg
MSkNCj4gPiArI2RlZmluZSBTTVVfQ1VTVE9NX0ZBTl9TUEVFRF9QV00gICAgICgxIDw8IDIpDQo+
ID4NCj4gPiAgIC8vIFBvd2VyIFRocm90dGxlcnMNCj4gPiAgICNkZWZpbmUgU01VX1RIUk9UVExF
Ul9QUFQwX0JJVAkJCTANCj4gPiBAQCAtMjMwLDYgKzIzMiw3IEBAIHN0cnVjdCBzbXVfdXNlcl9k
cG1fcHJvZmlsZSB7DQo+ID4gICAJdWludDMyX3QgZmFuX21vZGU7DQo+ID4gICAJdWludDMyX3Qg
cG93ZXJfbGltaXQ7DQo+ID4gICAJdWludDMyX3QgZmFuX3NwZWVkX3BlcmNlbnQ7DQo+ID4gKwl1
aW50MzJfdCBmYW5fc3BlZWRfcnBtOw0KPiA+ICAgCXVpbnQzMl90IGZsYWdzOw0KPiA+ICAgCXVp
bnQzMl90IHVzZXJfb2Q7DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9zd3NtdS9hbWRncHVfc211LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dz
bXUvYW1kZ3B1X3NtdS5jDQo+ID4gaW5kZXggZTMzZTY3MzEwMDMwLi4zOTM5MGJiYjc5ZTggMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMN
Cj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYw0KPiA+
IEBAIC00MTMsNyArNDEzLDEzIEBAIHN0YXRpYyB2b2lkIHNtdV9yZXN0b3JlX2RwbV91c2VyX3By
b2ZpbGUoc3RydWN0DQo+IHNtdV9jb250ZXh0ICpzbXUpDQo+ID4gICAJCWlmICghcmV0ICYmIHNt
dS0+dXNlcl9kcG1fcHJvZmlsZS5mYW5fc3BlZWRfcGVyY2VudCkgew0KPiA+ICAgCQkJcmV0ID0g
c211X3NldF9mYW5fc3BlZWRfcGVyY2VudChzbXUsIHNtdS0NCj4gPnVzZXJfZHBtX3Byb2ZpbGUu
ZmFuX3NwZWVkX3BlcmNlbnQpOw0KPiA+ICAgCQkJaWYgKHJldCkNCj4gPiAtCQkJCWRldl9lcnIo
c211LT5hZGV2LT5kZXYsICJGYWlsZWQgdG8gc2V0DQo+IG1hbnVhbCBmYW4gc3BlZWRcbiIpOw0K
PiA+ICsJCQkJZGV2X2VycihzbXUtPmFkZXYtPmRldiwgIkZhaWxlZCB0byBzZXQNCj4gbWFudWFs
IGZhbiBzcGVlZCBpbiBwZXJjZW50XG4iKTsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCWlmICgh
cmV0ICYmIHNtdS0+dXNlcl9kcG1fcHJvZmlsZS5mYW5fc3BlZWRfcnBtKSB7DQo+ID4gKwkJCXJl
dCA9IHNtdV9zZXRfZmFuX3NwZWVkX3JwbShzbXUsIHNtdS0NCj4gPnVzZXJfZHBtX3Byb2ZpbGUu
ZmFuX3NwZWVkX3JwbSk7DQo+ID4gKwkJCWlmIChyZXQpDQo+ID4gKwkJCQlkZXZfZXJyKHNtdS0+
YWRldi0+ZGV2LCAiRmFpbGVkIHRvIHNldA0KPiBtYW51YWwgZmFuIHNwZWVkIGluDQo+ID4gK3Jw
bVxuIik7DQo+ID4gICAJCX0NCj4gPiAgIAl9DQo+ID4NCj4gPiBAQCAtMjE3OSw3ICsyMTg1LDYg
QEAgc3RhdGljIGludCBzbXVfc2V0X2dmeF9jZ3BnKHN0cnVjdCBzbXVfY29udGV4dA0KPiAqc211
LCBib29sIGVuYWJsZWQpDQo+ID4gICBzdGF0aWMgaW50IHNtdV9zZXRfZmFuX3NwZWVkX3JwbSh2
b2lkICpoYW5kbGUsIHVpbnQzMl90IHNwZWVkKQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBzbXVf
Y29udGV4dCAqc211ID0gaGFuZGxlOw0KPiA+IC0JdTMyIHBlcmNlbnQ7DQo+ID4gICAJaW50IHJl
dCA9IDA7DQo+ID4NCj4gPiAgIAlpZiAoIXNtdS0+cG1fZW5hYmxlZCB8fCAhc211LT5hZGV2LT5w
bS5kcG1fZW5hYmxlZCkgQEAgLQ0KPiAyMTkwLDgNCj4gPiArMjE5NSwxMiBAQCBzdGF0aWMgaW50
IHNtdV9zZXRfZmFuX3NwZWVkX3JwbSh2b2lkICpoYW5kbGUsIHVpbnQzMl90DQo+IHNwZWVkKQ0K
PiA+ICAgCWlmIChzbXUtPnBwdF9mdW5jcy0+c2V0X2Zhbl9zcGVlZF9ycG0pIHsNCj4gPiAgIAkJ
cmV0ID0gc211LT5wcHRfZnVuY3MtPnNldF9mYW5fc3BlZWRfcnBtKHNtdSwgc3BlZWQpOw0KPiA+
ICAgCQlpZiAoIXJldCAmJiBzbXUtPnVzZXJfZHBtX3Byb2ZpbGUuZmxhZ3MgJg0KPiA+IFNNVV9E
UE1fVVNFUl9QUk9GSUxFX1JFU1RPUkUpIHsNCj4gDQo+IFNvcnJ5LCBhbm90aGVyIG1pc3MgaW4g
cmV2aWV3IDopIFRoZSBhYm92ZSBsaW5lIHNob3VsZCBwcm9iYWJseSBiZSAtIGlmICghcmV0DQo+
ICYmICEoc211LT51c2VyX2RwbV9wcm9maWxlLmZsYWdzICYgU01VX0RQTV9VU0VSX1BST0ZJTEVf
UkVTVE9SRSkpDQo+IHsNCj4gDQo+IEZpeCBpdCB3aGlsZSBzdWJtaXR0aW5nLiBBcGFydCBmcm9t
IHRoYXQsIHRoZSBzZXJpZXMgaXMNCj4gDQo+IAlSZXZpZXdlZC1ieTogTGlqbyBMYXphciA8bGlq
by5sYXphckBhbWQuY29tPg0KW1F1YW4sIEV2YW5dIFRoYW5rcyEgV2lsbCB1cGRhdGUgdGhpcyBv
biBzdWJtaXR0aW5nLg0KDQpCUg0KRXZhbg0KPiANCj4gVGhhbmtzLA0KPiBMaWpvDQo+IA0KPiA+
IC0JCQlwZXJjZW50ID0gc3BlZWQgKiAxMDAgLyBzbXUtPmZhbl9tYXhfcnBtOw0KPiA+IC0JCQlz
bXUtPnVzZXJfZHBtX3Byb2ZpbGUuZmFuX3NwZWVkX3BlcmNlbnQgPQ0KPiBwZXJjZW50Ow0KPiA+
ICsJCQlzbXUtPnVzZXJfZHBtX3Byb2ZpbGUuZmxhZ3MgfD0NCj4gU01VX0NVU1RPTV9GQU5fU1BF
RURfUlBNOw0KPiA+ICsJCQlzbXUtPnVzZXJfZHBtX3Byb2ZpbGUuZmFuX3NwZWVkX3JwbSA9IHNw
ZWVkOw0KPiA+ICsNCj4gPiArCQkJLyogT3ZlcnJpZGUgY3VzdG9tIFBXTSBzZXR0aW5nIGFzIHRo
ZXkgY2Fubm90IGNvLQ0KPiBleGlzdCAqLw0KPiA+ICsJCQlzbXUtPnVzZXJfZHBtX3Byb2ZpbGUu
ZmxhZ3MgJj0NCj4gflNNVV9DVVNUT01fRkFOX1NQRUVEX1BXTTsNCj4gPiArCQkJc211LT51c2Vy
X2RwbV9wcm9maWxlLmZhbl9zcGVlZF9wZXJjZW50ID0gMDsNCj4gPiAgIAkJfQ0KPiA+ICAgCX0N
Cj4gPg0KPiA+IEBAIC0yNTUyLDggKzI1NjEsMTEgQEAgc3RhdGljIGludCBzbXVfc2V0X2Zhbl9j
b250cm9sX21vZGUoc3RydWN0DQo+ID4gc211X2NvbnRleHQgKnNtdSwgaW50IHZhbHVlKQ0KPiA+
DQo+ID4gICAJLyogcmVzZXQgdXNlciBkcG0gZmFuIHNwZWVkICovDQo+ID4gICAJaWYgKCFyZXQg
JiYgdmFsdWUgIT0gQU1EX0ZBTl9DVFJMX01BTlVBTCAmJg0KPiA+IC0JCQkhKHNtdS0+dXNlcl9k
cG1fcHJvZmlsZS5mbGFncyAmDQo+IFNNVV9EUE1fVVNFUl9QUk9GSUxFX1JFU1RPUkUpKQ0KPiA+
ICsJCQkhKHNtdS0+dXNlcl9kcG1fcHJvZmlsZS5mbGFncyAmDQo+IFNNVV9EUE1fVVNFUl9QUk9G
SUxFX1JFU1RPUkUpKSB7DQo+ID4gICAJCXNtdS0+dXNlcl9kcG1fcHJvZmlsZS5mYW5fc3BlZWRf
cGVyY2VudCA9IDA7DQo+ID4gKwkJc211LT51c2VyX2RwbV9wcm9maWxlLmZhbl9zcGVlZF9ycG0g
PSAwOw0KPiA+ICsJCXNtdS0+dXNlcl9kcG1fcHJvZmlsZS5mbGFncyAmPQ0KPiB+KFNNVV9DVVNU
T01fRkFOX1NQRUVEX1JQTSB8IFNNVV9DVVNUT01fRkFOX1NQRUVEX1BXTSk7DQo+ID4gKwl9DQo+
ID4NCj4gPiAgIAlyZXR1cm4gcmV0Ow0KPiA+ICAgfQ0KPiA+IEBAIC0yNjA0LDggKzI2MTYsMTQg
QEAgc3RhdGljIGludCBzbXVfc2V0X2Zhbl9zcGVlZF9wZXJjZW50KHZvaWQNCj4gKmhhbmRsZSwg
dTMyIHNwZWVkKQ0KPiA+ICAgCQlpZiAoc3BlZWQgPiAxMDApDQo+ID4gICAJCQlzcGVlZCA9IDEw
MDsNCj4gPiAgIAkJcmV0ID0gc211LT5wcHRfZnVuY3MtPnNldF9mYW5fc3BlZWRfcGVyY2VudChz
bXUsDQo+IHNwZWVkKTsNCj4gPiAtCQlpZiAoIXJldCAmJiAhKHNtdS0+dXNlcl9kcG1fcHJvZmls
ZS5mbGFncyAmDQo+IFNNVV9EUE1fVVNFUl9QUk9GSUxFX1JFU1RPUkUpKQ0KPiA+ICsJCWlmICgh
cmV0ICYmICEoc211LT51c2VyX2RwbV9wcm9maWxlLmZsYWdzICYNCj4gU01VX0RQTV9VU0VSX1BS
T0ZJTEVfUkVTVE9SRSkpIHsNCj4gPiArCQkJc211LT51c2VyX2RwbV9wcm9maWxlLmZsYWdzIHw9
DQo+IFNNVV9DVVNUT01fRkFOX1NQRUVEX1BXTTsNCj4gPiAgIAkJCXNtdS0+dXNlcl9kcG1fcHJv
ZmlsZS5mYW5fc3BlZWRfcGVyY2VudCA9DQo+IHNwZWVkOw0KPiA+ICsNCj4gPiArCQkJLyogT3Zl
cnJpZGUgY3VzdG9tIFJQTSBzZXR0aW5nIGFzIHRoZXkgY2Fubm90IGNvLQ0KPiBleGlzdCAqLw0K
PiA+ICsJCQlzbXUtPnVzZXJfZHBtX3Byb2ZpbGUuZmxhZ3MgJj0NCj4gflNNVV9DVVNUT01fRkFO
X1NQRUVEX1JQTTsNCj4gPiArCQkJc211LT51c2VyX2RwbV9wcm9maWxlLmZhbl9zcGVlZF9ycG0g
PSAwOw0KPiA+ICsJCX0NCj4gPiAgIAl9DQo+ID4NCj4gPiAgIAltdXRleF91bmxvY2soJnNtdS0+
bXV0ZXgpOw0KPiA+DQo=
