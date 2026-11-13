Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C138606A323
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YD9TeSti
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE1C510E544;
	Fri, 13 Nov 2026 15:12:35 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B91CC10E544
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 15:12:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liw87wrfLsH9AVsLx6TWnefHqY/qQi0bKo04mW+6d1nVJTks5+dMN1eibXJ/t22WHO+t5FoTqA0dDsqldGbS6KQS8rLgSELQPyK/ocWpSxGsud3/Qos0SOz11vYQ1ps/+HMbnIPv3eyn5WwpMYKbHUikoUw/BVde0qGHOraP9lUyJruNj1K3MQN/C2V73gbVmzb7XFk7PGjVUN5Zp+HgaJ0sWKCv0X7JghK6u08UtWhGiT5lij/gH1fIYlD+I0iHFImCeaU4t+vL+oSZXPOu7IP5rrmo6IFWWk0oFNjxPYy6O669/mPsquqJLw6RHIoH7ziiSXGTTbso0ONsSQGEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+8dbees3WOEMHC7dG6vadzfBOMdDEOlQr/wLAi70F4=;
 b=FLXsbbtZS5CwNLznr5kPy7MiRtLiyMT5pX6XJ1hcr2KFw72ZmjBBTKkk8+8xstuWE097qbLyoRKXNECDkq2U6b9Os57G7SjQSLPv16t+I3sLQvXrugsOIzPjqRP46fpNY51fx4bQFMS2zSeck00GmU0J5906McL1ze7OoGoOhSauZXz9hDo7WJpF0O6A57to8x0ssRguSr9uBo0filQ7DMfa5WjZ4E91N3LyUvPfxPXMTyHY9bzD3x1wha/y6BIXsxs5Lfb67GOMSaDo5XYHTTi9AQNQ7Qq+Ma4mH3W5IBD1WNgzSQWzhA9sz7Sx1hW4K0Pps3sawqwvY+D8wfcOAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+8dbees3WOEMHC7dG6vadzfBOMdDEOlQr/wLAi70F4=;
 b=YD9TeStizhjTgHdRgpuZZ8OTMJdowe8PQc0l5klGws9ly2ucGpaikFDc36Qbc2qQzrV0JAJLm696I+8VlcUNQJLZI7xszE4bOYvZiGgF9sIQ9zALeilocYvNnCISJTTk8QGw5DZiNYZFtbgtXBfXEbCNtukwBA42pxQPIckfKxE=
Received: from IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15)
 by PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 15:12:21 +0000
Received: from IA0PR12MB7505.namprd12.prod.outlook.com
 ([fe80::9012:fd0b:696:a346]) by IA0PR12MB7505.namprd12.prod.outlook.com
 ([fe80::9012:fd0b:696:a346%6]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 15:12:20 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Ba, Gang" <Gang.Ba@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: Run shader cleaner on all XCCs on faults
Thread-Topic: [PATCH 1/3] drm/amdgpu: Run shader cleaner on all XCCs on faults
Thread-Index: AQHdcqvb7aT+qW4bZUKmXJGF8bOsn7csG16AgAAB7TA=
Date: Fri, 13 Nov 2026 15:12:20 +0000
Message-ID: <IA0PR12MB7505F221FED6CF0F1375CBB8857F2@IA0PR12MB7505.namprd12.prod.outlook.com>
References: <20261112134340.4122401-1-kent.russell@amd.com>
 <b6ecf2fe-80bc-42f4-9b15-cbc7f2797306@amd.com>
In-Reply-To: <b6ecf2fe-80bc-42f4-9b15-cbc7f2797306@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-13T15:11:54.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7505:EE_|PH7PR12MB8039:EE_
x-ms-office365-filtering-correlation-id: 6dd34a22-c446-4a97-13ec-08df41988352
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|56012099006|4143699003|11063799006|261022105027099003|261022075727099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: AAi82VnB2acsTIjdk0aZJFIAE0Mw/jiYLHdRuWesHHb4A/9ypCzVdisBCd2AQymtt/7ijyjLXaZzi04FR/LqQGEUAa7Z1DOBINb9skp9dps06q6f1zgOiTiX25JeqA4YtBWr1gvpb7aIZuR5yIpBNCsAW4IS5Tt3/d0VE0VJ5fGLiqKRD4D/gf2GA06yPnosa2DZEpm5JBSEAX0lI7trKp8sZZk+eZcRTsCe86ktOsqTs7BECn2WxZ8Yywgr8/UJc9DvsCw4y65P/YHSPHDkR1b/1x3oo0M5JylD31SvP4Tz27+eigIDvSmkMAu8d3DYXbabayZfdgDxKjLBqA8PUgMFypG4HJ8elsAvjjXpqp3Z5+IhlgZAqAB1aJZbGD40Tv9wm8rtte/7stvi1KzNJbkbz9DQStpd4lxEXxCgY5KyDPmkkWyCHLbgeEmJpk6DFCobbmULbkWK9bVCkZi4NjOtLhMwo5K/nF+8ldR0MlGHSjqIdWeTNOQ1gCggaMGNqqjpnhI9dG9OBOzY/umqTVUYHMhq89rJ3GFuhhqy9k0s/FOnMLwdxQV3cBokcT8L7yJ05F218GpbdnVSb2ewc3S6F+kWL79bONMbNRbaROQnO0mJ44G3j/n9pOImfzcuWCtVZJQdhSKO9DgYAsMMVsfcGGoBZAqZzlClj6Z08hiVQFBdoHNJkaqnRZvPWznUooPokl300Af3nD5RgRdvtvZTnNIIG6gKG59U9v2R+nk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7505.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(261022105027099003)(261022075727099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGNrT2crc1pBMFR5TjV3U25FS0pyUkJxMDdQSXJBNzBkQkt2QUYxd1B5REx0?=
 =?utf-8?B?VTUvQnUvK0xnVWlQZ2dKcjFYS0RaWGpybm5FWkNycWJXVEVGUnlrVTVzL0N6?=
 =?utf-8?B?T3QrRGx6R2p3VUZiOTRLbk5nS0p0UUxpdEd1eHdIWGJCVHlFNFdtTEpYTWl3?=
 =?utf-8?B?WVNkQ1E5S3FLK1FyWHNvVmtTaUdabGY4VnVQNWZva000T3dkUkt5WVdjM2pS?=
 =?utf-8?B?Qlp3cFlXeSsrQnNaSlp3eHU2dm9wSHU1bVBhb2VtcUpiOEx5Rk8vMkI1Tldq?=
 =?utf-8?B?VmI3NkdJK1E4MFNWV1A1RGR2Uk9HNWFRTXdiUWdRL1pxaWtUSHFvMXNjOGkw?=
 =?utf-8?B?UHd1eE1jTG1wWDVNTXNWUGM4K0o0dDh6eGJVQzJKNlAvRG4xN1dVSVdvSkIw?=
 =?utf-8?B?RWMvb1ZhME4zWUk3b1FndklmNlVYY0QxQys3WUZ2bWpPOC9IMTNLRXpIRmRv?=
 =?utf-8?B?dkFIOTZHYXArYVo2OFhWcjUyZnJrV2g0YjNQcmJMZFRYNzMxSXNQV09FMEVC?=
 =?utf-8?B?TVBNY0NuZkVjWm14TXZMN1hXVVBoOHFPL0cxdWNsdVVWYnNHZFNqZ25vTldQ?=
 =?utf-8?B?OUZIa1BrWmdPcTZCYzh2bWRHaVI0T250bW1lMEsvSmMxbUVzamkwTHM3WjJy?=
 =?utf-8?B?UHYvYTFaQ3RaRGs5SFJHUm5Gdm1uT0xUSHQ5WHRkeWs2OGFLRi85L2FiQ2Zo?=
 =?utf-8?B?WEN3L3pJNEZFM3d2S0FWd3JzWmJkKzVydW1NMGFPVjNNUVIwUktjeXhQR3ZN?=
 =?utf-8?B?eUJ2Z2pOUWk2ejJqcTd2QkcvREpKYS9oamV5UzF1UzhyVFV3WU13UzJmVS82?=
 =?utf-8?B?dkd6WldLYmpTRXFhK0RSMVQ2SzBnUmNXZ2VsVlZibFRjaFZrSEdIOUx5ZElV?=
 =?utf-8?B?emNHQ3pVcmU2bkFUUUJoTDR4eVNndVRwck8yVWJ5QlVnUk1PV2RsdUF5eHlo?=
 =?utf-8?B?dHdwc1M5dGQ4eWtkVnFUN1QwemlLSjhlQm0rbWVHc1o1MEtrR01RenRUNUdX?=
 =?utf-8?B?aHJJNjFkNngvdHNFVkJTZFpXN3NrQWNGV296TExwYWUrb0liWDgzQVFMZ2tL?=
 =?utf-8?B?b1hJYllHUWtqeFl5aGd4YkxadDJMZzNQNXlXNDU4bmhJa2tTbmJaUG4rRUpu?=
 =?utf-8?B?alNxV0x3cUtMSDJhU1J1akNYMzRPbmV2ajV3QTVPSXJUU3VCeFdBa2hnWFpi?=
 =?utf-8?B?eUluUi9zbnJHd3lSekhxSXFlT0s1NHJFYTRFU1I3K3hLeXBxV0tRS3pxaWcr?=
 =?utf-8?B?TlVwbWJ4bEZwaFRUZ1NPOHBqbklpbE9XTnNRelR1b1R6WERrc3IrbEpDN08v?=
 =?utf-8?B?WjhheVMwK1ZIN203M2Qyayt2MENiN0NzSTFwYzlFR0k2QU9HUk5hWm41bWF1?=
 =?utf-8?B?TGF4QmlzZmswQnVZd1BnZ2k3YzBCYTJSNFNnSVpYUVVYK1dOYk14RDl6Qm4y?=
 =?utf-8?B?aWd5eDBsRlMwSXZUdHdJQ1VSNktjMmxEQnZEaE1GU25hdkRXNGdxNVVPOTRG?=
 =?utf-8?B?M0RFYVJpcCtOVUN2ODBGNzNuZHlIUXhDdEM2K3dEczhiNXVsZHVib1ZZaW90?=
 =?utf-8?B?OTROOThLUmh6ZEF5SkxySkNtSEo3SUIvaDlPcVN5N042UTlJVUU3ZHVRY0l6?=
 =?utf-8?B?Vi9aWTRzQnhRZXNDdWR0bHZhY2JhUEVobUFDRXNiVkFNQXNnejR3Qkc0UjBH?=
 =?utf-8?B?YXJ3U3haUzFZZmhDWjczUHl4am9PWEtJMVZ6cDVKU1ZxV1VsNk1KS1ZjaUJx?=
 =?utf-8?B?bFpRb05GMXRNVm5lZTdYSzR1VThOLzd1UldTNFZKdC9zanNaaWd1K1RibHh0?=
 =?utf-8?B?cWQyZXNDenhDbHQxTHl2VmMrZkhld2tORk8yWWRJV1dwbnpCU3ZXSU5ZVWlo?=
 =?utf-8?B?SmNxREZNZ1ZXSlVKV29WeGYydGhZaVBQMEZXNDlkRGgvUGljU25BVklYTytZ?=
 =?utf-8?B?OUVEdFcva1hiZnhHR1JNNU1GMTBPLzNwMk1UUC9hdzJ5dzhjaUJkdlhQQ0RG?=
 =?utf-8?B?WmJkWTFVZUlTUFNGYXpYQStkdnVnS1M4MGhUU29BNS9zMUhPczVpbFZxMnE2?=
 =?utf-8?B?aGxJNTJnanM5SS9jSnc1RHBoV0RZTHJLMk1SQ2sxMk5Eb29PM1F5TTgxNS9u?=
 =?utf-8?B?K1AyOFRyYVRLYjcreE1XbnVyT1puR1BFWXB2Q0VxdTZKcmx6YlRnOUJoODFF?=
 =?utf-8?B?M21Rb3BSckNsbGFISnEvUjNOelJRdXNVTFVLME54TnNrNzE2UWQ4WitrWEt0?=
 =?utf-8?B?MXdXYkpRSVFpZm1HWEd4V3l3QUZCeDdJWlNYTmpxSWIrUUZKZnN1dGl3QUg3?=
 =?utf-8?Q?k/fgQSF7LcMwZctbar?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd34a22-c446-4a97-13ec-08df41988352
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 15:12:20.2987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pknSn/3tOE2lOMPSaCvXrWJv48Ld7Q5ZxpYr37i0OkuSDL1yP6f3pH8HewIicJFsRBTTN4tsqueW/dw/Gv6RKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDb3Ju
d2FsbCwgSmF5IDxKYXkuQ29ybndhbGxAYW1kLmNvbT4NCj4gU2VudDogTm92ZW1iZXIgMTMsIDIw
MjYgMTA6MDUgQU0NCj4gVG86IFJ1c3NlbGwsIEtlbnQgPEtlbnQuUnVzc2VsbEBhbWQuY29tPjsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IEJhLCBHYW5nIDxHYW5nLkJhQGFt
ZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBkcm0vYW1kZ3B1OiBSdW4gc2hhZGVy
IGNsZWFuZXIgb24gYWxsIFhDQ3Mgb24gZmF1bHRzDQo+DQo+IE9uIDExLzEyLzIwMjYgMDc6NDMs
IEtlbnQgUnVzc2VsbCB3cm90ZToNCj4NCj4gSnVzdCBtaW5vciBjb21tZW50cyBvbiB0aGVzZS4g
T3RoZXJ3aXNlIHRoZSBzZXJpZXMgaXM6DQo+DQo+IFJldmlld2VkLWJ5OiBKYXkgQ29ybndhbGwg
PGpheS5jb3Jud2FsbEBhbWQuY29tPg0KPg0KPiA+ICsgICAgICAgICAgICAgICAgICAgZGV2X2Vy
cihhZGV2LT5kZXYsICJmYWlsZWQgdG8gY2xlYXIgR1BSIG9uIHhjYyAlZFxuIiwNCj4geGNjX2lk
KTsNCj4gPiArICAgICAgICAgICAgICAgICAgIGdvdG8gcHJvX2VuZDsNCj4gPiArICAgICAgICAg
ICB9DQo+ID4gKw0KPiA+ICsgICAgICAgICAgIC8qIHdhaXQgZm9yIHRoZSBHUFUgdG8gZmluaXNo
IHByb2Nlc3NpbmcgdGhlIElCICovDQo+ID4gKyAgICAgICAgICAgciA9IGRtYV9mZW5jZV93YWl0
KGZlbmNlLCBmYWxzZSk7DQo+ID4gKyAgICAgICAgICAgaWYgKHIpDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICBkZXZfZXJyKGFkZXYtPmRldiwgInRpbWVvdXQgdG8gY2xlYXIgR1BSIG9uIHhjYyAl
ZFxuIiwNCj4geGNjX2lkKTsNCj4gPg0KPiA+ICAgcHJvX2VuZDoNCj4gPiAtICAgaWYgKGZlbmNl
KQ0KPiA+IC0gICAgICAgICAgIGRtYV9mZW5jZV9wdXQoZmVuY2UpOw0KPiA+IC0gICBhbWRncHVf
aWJfZnJlZSgmd2JfaWIsIE5VTEwpOw0KPiA+ICsgICAgICAgICAgIGlmIChmZW5jZSkgew0KPiA+
ICsgICAgICAgICAgICAgICAgICAgZG1hX2ZlbmNlX3B1dChmZW5jZSk7DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICBmZW5jZSA9IE5VTEw7DQo+ID4gKyAgICAgICAgICAgfQ0KPiA+ICsgICAgICAg
ICAgIGFtZGdwdV9pYl9mcmVlKCZ3Yl9pYiwgTlVMTCk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAg
IGlmIChyKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgIH0NCj4gPg0K
PiA+ICAgICBpZiAocikNCj4gPiAgICAgICAgICAgICBkZXZfZGJnKGFkZXYtPmRldiwgIkNsZWFu
IEdQUiBGYWlsZWRcbiIpOw0KPg0KPiBUaGlzIGxvZ2ljIGlzIG5vdCBjbGVhcmluZyBHUFJzLiBJ
dCdzIGNsZWFyaW5nIHJlc2lkdWFsIGZhdWx0IHN0YXRlIGxlZnQNCj4gZHVlIHRvIGEgZGVzaWdu
IGRlZmVjdC4gVGhlIGVycm9yIG1lc3NhZ2VzIGNvdWxkIGJlIGNsZWFyZXIuDQoNCkFncmVlZC4g
V2lsbCBhbHNvIGFkZCB0aGUgRml4ZXMgbGluZSBwb2ludGVkIG91dCBieSBTYXNoaWtvLWJvdA0K
DQogS2VudA0K
