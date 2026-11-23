Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE674606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 06:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OgCHIUQx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80D8C10E177;
	Mon, 23 Nov 2026 06:39:50 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013024.outbound.protection.outlook.com
 [40.107.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A0AF10E177
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 06:39:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8jXHROyf453o7Gnjl580HVZuGCFSEINK7KKSYOMzL8jaVIkVSYou+nt1HH0S9uHqQEWuSYz1s/aiD9yFeioK4J69efVY47Es4II5Hn2qziD8RJvorNMcXT48ecPlP6vPUJK+WPZUKKetS0ARa8snKYxP3nyhx0b5ylMc4Qah2QBDFOfuwT6e0PJ1KuuCdcGy2TvC98fzlFPnkxBkTLW5MHjjIm/n6+hyaMBP8lviam8xj1wEY+nh1qaSl7QwesfIbbQZd+tSWlmB2bKG1aSHzEOIJRC5suLQrgc/5dRjAsvzuYSIdz6hk6aBS7bqQ/hFqeA6raAzSlicpGHX+FOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUdk+c8zsxgNz/1Op/5sEZFcPVb8Pnmuhv/uJUawT0U=;
 b=fV5YR727obWEYVxqXbCCqHiqFhFk5j8RUTi7qzQKHFPYZdc/LWkyXYMln4Ng3aixN5vt/YxSdsq/CjwlWGv5Wu93KhffkRCCJHyZOc3oRfxZe3JRHZyTexwzO9kQOELeWpgme6JeLb9Hkei+OAoU3wgFTrvfAKPWaprwRS6G/EMXhWZ4VvE2wYa5ppe6X6sCiX5kUEq3KLEbmw7JP30Ct0Ojg26WYyvZWzjeZPQcFThMYMyxkySvvf2tbZ7OioAQ/Uig0rVU1ngqACtvKK6va1hVjNSJ5tbNCoUmOEC6S6muc5klElUSeDlwqsUZ4ZGPUGBb3Eyi5h/NrhWFYncORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUdk+c8zsxgNz/1Op/5sEZFcPVb8Pnmuhv/uJUawT0U=;
 b=OgCHIUQxFEwfVDJ115do60K3YRAC4n6VmS3tlD6AunkerjIm8apCpWvN/kLh662b3XBgytoua9MojBRSjvmfS6PVTFV/A4f1OdvQ9J0Q+9d1mKROTfQyvjp2W56hqr6czBRLAzUNdeLKdKlBd42CJN4ClB0kCrjmw69KQl1NOKg=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 06:39:40 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 06:39:40 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lin, Amber" <Amber.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Russell,
 Kent" <Kent.Russell@amd.com>, "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Move gpu_recovery location
Thread-Topic: [PATCH v2] drm/amdkfd: Move gpu_recovery location
Thread-Index: AQHddZ9BwGi+MNPw1U2EdBpbFgtqPbc3nzAAgAOgObA=
Date: Mon, 23 Nov 2026 06:39:40 +0000
Message-ID: <DM4PR12MB5152ABE38AADB11B59A03838E3452@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261116075047.35150-1-amber.lin@amd.com>
 <18eaf274-988a-4a52-befb-0797bf0b482c@amd.com>
In-Reply-To: <18eaf274-988a-4a52-befb-0797bf0b482c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-23T06:39:02.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MN6PR12MB8471:EE_
x-ms-office365-filtering-correlation-id: 86e0f4e3-1a56-4513-b1fb-08df492c8d0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|261009223027099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|261102123227099003|261022105027099003|261028144727099003|56012099006|10067099003|38070700021|4143699003|11063799006;
x-microsoft-antispam-message-info: kMJ7ODpnW2QmUCVZeBZ/7hAfzGrmSWJWHxiU99I2avuDuCYnQdmkmLn2kKk8DckTzA03hJunSLPo2L0KLDk6i/U9ElLxvl6ByijHcGvKtUg4RTecX4eIqpdt8RQyPbuLN1P0JS/02NglbHn7/+gXkgs1ni66jLE4W5OmYycXInF1A3H9b2FGVO37/dubXG108Bs+ej812zM1X0YiFjunQkd8w84xnv2DQtzbz+El8RiXQAU8Zc+RdH5R7WSEJ9csDl9mObh7pwCYAw0eJwD+VpLBD0VOPQ8eK/RQq2muaBldazNvjIIryG4IqoIeTphzv9REk+LLUrEoMMkGDo32n11RmS9sr14FzFfI+77G+htmn6A5qPmd530isgnc7NF09fKGz5QFdqTqVGtAqTRVpTKuo20K4GOr+p1LlKDcC8171UXTkmvemwW/7gRFvOflojDe10smGK8iTM3mg1wyI4d7T6NqXbOUhwQinVnUibkFOHOGZofmrRU8jDF73T+ScxbqwoHpldTaCBJDx381g1vPdO7iDpSBFBYNjuxs+v7fqJcIpuBlIje5i0JelovrpIYXHl+pW31nk1BfnfHy7CrJFUc7/wju/KtGcRyjwLTnqO7zhmYvZ+7Rc1TS1UfHiJAIHjW2GrWN9Mk1Ih57Lz4cnyB8ceunb8HHedLjsBAVFcs+3vRaKXPYs1VTg52rHfV2qERCDvIJ5Is4fXBGYu5rsh+LZ5xhsDldvojiIhQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(261009223027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(261102123227099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(38070700021)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFlHV2kvamQyelh6NXh4YUtVQTJmRnFad25xenNnNW9xdWxtZ2ZzdGgzVlc1?=
 =?utf-8?B?ekY0QUNnc3lybThnK2FOWnFCNnBjU0pIMGU3T05BakphSmxEVFlxRUdwSkla?=
 =?utf-8?B?eVdXV2hZVGlqU3RpSEdEVTBYUHBFVjhucWhSRE4vdi84RmM4WFVGenVGRGxo?=
 =?utf-8?B?bVFUazFiSXdUdjhxeG9wcnNIcUo2OUV1KzZEaGJhZllnU0VocXUxelRPbVVu?=
 =?utf-8?B?enBGZWpQL3JGdGdZTzVFTVR1SXQ0VUVHSjl1NFBEZ00zbXBBeXYyZmtHai9B?=
 =?utf-8?B?RjViMGRNQ1ZuMUdOTEVCS3EzbEJqSUFvWDVKditUUXZydHU4M2NLclNiR3BE?=
 =?utf-8?B?RU40VnA0UGMxajZBTVdCVnFvT3Bpb2JWaVMrdDFXSkVWbnF6aTVhQWdSV0RK?=
 =?utf-8?B?b1orVHk0OXZ0UE9ZOThYcVJuV0ZPbWp2SzY3NUxMcGIvd1M4dng5WlhSbVY5?=
 =?utf-8?B?UFhNOUZselc1M0dQZHFUQTA1Mm93SitSdjFabHR0U2JWeTRmU0lwK2twNkx1?=
 =?utf-8?B?dzhEM3pGTVI3ektZMjM0Wnh5WWFtTTEvUlRuVGJpcW93M3NuQnU3LzBnMG9U?=
 =?utf-8?B?aVEyWEt4cXRKNzI2NWNpd2VzRDdVcVVhUUFsNTBYWFdWV0UvbjJlZHFXM2pP?=
 =?utf-8?B?b2xBQTRDN2NYMUN3VG5xalpMSnlKYngvV3dDZGZ4eVBHTDMzKy9nakVQMXl4?=
 =?utf-8?B?N3loNjB1ZXIvcW1JcVlZVWRKNVJLODBnWlJ1NlU5UVBGOHhKd0JHaVN4K3o0?=
 =?utf-8?B?SkJydWdmYWRqWk9JUTlJU2orUWpPMVp2KzEzNGFwZGNyZVg0d21oSy9kWWRX?=
 =?utf-8?B?ak1lMGh5cjA1QVh5UWMzdWhmTU9MQ0ZSQjJMZ2hoUUorUmNUampLbFd2bCtH?=
 =?utf-8?B?Y1B6VHN0b3YvcDIycklOY3hPNXV1NEhFdlAwcXJ3WUdFcXBldXdTT25ZaGlB?=
 =?utf-8?B?Q3dHdHc3ZHRvcnZsUm85MEpuQnhWWWFPaXpNT25meWxvMkVMODlhZGYvTjE2?=
 =?utf-8?B?VkIyMGtkd0dubU13WG1RM0FEcGQxakZqQ3diZERaS3pHWloxQzhybGlFeVV2?=
 =?utf-8?B?RG9VVGFPSDNiSldrSmt1QkpLOUhPeFpGL3pubWZIc2h1bnVKNDVraUEreUdT?=
 =?utf-8?B?QVlYZjh2RlVLWGxhQnM0U1NlQ0lzTWs2YmI1U1JXNWk1eS92TEVvVHVYUGRQ?=
 =?utf-8?B?WkxGMXNQTnBYYUNjNVBaY3BhUE9tTlhkSmZhdmFRci9HaURNR0JaalZrcGVr?=
 =?utf-8?B?dFdrdmRBeHRUNTNDYnB5MEFJY0lFM3Y0QjBaY1NFaUlPaTl4YzRMNithcis3?=
 =?utf-8?B?M2hWSm1LNWNjK29kVmhIODNOUVJXdTk0WWlBanZLWDVmTm4vZkZ2Y1BIcEFw?=
 =?utf-8?B?MU5JaFNXNGhyOVVHZWdxd1JYaWRwa0NMZHN1WTJtaE42OUVjdC9sMjh4dFpR?=
 =?utf-8?B?Z0dxTnJtYWxEMW5tMXllY2RxLzA5VmphMTRyTDBVSDF3UFhabXFWRFJyd3BX?=
 =?utf-8?B?OUxtOHdDSmdGTHA2VXBDbXJTRFIwSVZDM2VqNTMzeWRDa3dtdUo2VmdtREg5?=
 =?utf-8?B?NmdiRlFBMEtKTUtjVHR0YVNaRmdGdGtjaDJXMUpZcWh6MWFNTmwyNXlnTzlk?=
 =?utf-8?B?UWhjT0pwcEwxUXVKeUhZSkxtU0JMVldFNzNHdzZxWlVna2UxTzJyaW5yUTBJ?=
 =?utf-8?B?QXVnOURXZXRVZzRWOVBEWE8yS1lnUTl5WHR6YkdYd3N4WGVpdk1NUE9RbmZv?=
 =?utf-8?B?Z1RJRzBUS1Q2V3Q3UDNsMmlwMnBiV3JYUU45Nmxlak9lV0VKZTNnUnI4V01H?=
 =?utf-8?B?aWRCbWNlNTFkbkYxamd4UzlGNTJXbFlGTzRzeGpvYjhtY3BYZnVycEsxcEtu?=
 =?utf-8?B?dlV2Q09kY3RjM2FLYnFPYlpNYzBhVjZJYS9XK3lVaTBheTdWbDdBbGk5SGRp?=
 =?utf-8?B?TDdsR2F1T3ppd1pnMDFHMkpRQVpBZlpKaXpjSkVGQ2RKcFlWNVJQWkRKdHEx?=
 =?utf-8?B?dzMrNTlqdlBFemdBVE91OWt5UERGZGN5Z0hRS3R0Q3N6V1ZvQzdhL2Framc1?=
 =?utf-8?B?ek1HenBXazI0ejhjeCtHZWE1VUFpZ0FmOWVUTi9SVWw0L3BwUGFzNnFrbDFp?=
 =?utf-8?B?cEVtQlFia3d5RXVTK09vaFBMOGhxQmFCVlZiY29iclMrTmY4aEN1UlhlR3RO?=
 =?utf-8?B?dHMxN1BCVnp3T0ZSNy9xb3d3WkNhRGdLV2IzVC91ZldQa1JtdGszcjYvV2pG?=
 =?utf-8?B?ZWEyMHRBYmFvQ3lZcnhMZGRZbm5ETlJtTTJYT0MzeVBNb2lMbHR5RVR4blkw?=
 =?utf-8?Q?C61Btqozj2qrecuyiP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e0f4e3-1a56-4513-b1fb-08df492c8d0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 06:39:40.3636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DobGHpXSHtkvyplvI5dP4XZpvHBTMETAtxwNFec3IVSbfnApzbMNQcqqcc1Gq6faOQzC5QmXGYw2RVlbZHLAeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KUmV2aWV3ZWQtYnk6IEplc3NlIFpoYW5nIDxKZXNzZS5aaGFuZ0BhbWQu
Y29tPg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW4sIEFtYmVyIDxB
bWJlci5MaW5AYW1kLmNvbT4NCj4gU2VudDogU2F0dXJkYXksIE5vdmVtYmVyIDIxLCAyMDI2IDc6
MTcgQU0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4
YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBaaGFuZywgSmVzc2Uo
SmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT47IEthc2l2aXN3YW5hdGhhbiwgSGFyaXNoDQo+IDxI
YXJpc2guS2FzaXZpc3dhbmF0aGFuQGFtZC5jb20+OyBSdXNzZWxsLCBLZW50DQo+IDxLZW50LlJ1
c3NlbGxAYW1kLmNvbT47IEpvc2hpLCBNdWt1bCA8TXVrdWwuSm9zaGlAYW1kLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2Ml0gZHJtL2FtZGtmZDogTW92ZSBncHVfcmVjb3ZlcnkgbG9jYXRp
b24NCj4NCj4gUGluZw0KPg0KPiBPbiAxMS8xNi8yMDI2IDM6NTAgUE0sIEFtYmVyIExpbiB3cm90
ZToNCj4gPiBhbWRncHVfZ2Z4X3Jlc2V0X21lc19jb21wdXRlIGNvbWJpbmVzIHR3byBmZWF0dXJl
cyBpbnRvIG9uZToNCj4gPiAxKSBodW5nIHF1ZXVlL3BpcGUgcmVzZXQgLSBzdXNwZW5kIGFsbC9x
dWV1ZSByZXNldC9yZXN1bWUgYWxsDQo+ID4gMikgYmFkIHF1ZXVlIHJlbW92YWwgLSBzdXNwZW5k
X2FsbC9yZW1vdmVfcXVldWUvcmVzdW1lX2FsbA0KPiA+IEdQVSByZWNvdmVyeSBhaW1zIG9uIDEp
cmVzZXR0aW5nIGh1bmcgcXVldWVzL3BpcGVzLiBXaGVuIGdwdV9yZWNvdmVyeQ0KPiA+IGlzIGRp
c2FibGVkLCB3ZSBuZWVkIHRvIGtlZXAgMikgZ29pbmcuIFRoZXJlZm9yZSBtb3ZlIHRoZSBncHVf
cmVjb3ZlcnkNCj4gPiBjaGVjayBmcm9tIEtGRCdzIHJlc2V0X3F1ZXVlc19tZXMgaW50byBhbWRn
cHVfZ2Z4X3Jlc2V0X21lc19jb21wdXRlDQo+ID4gd2hlcmUgcXVldWUgcmVzZXQgaXMgZG9uZS4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFtYmVyIExpbiA8YW1iZXIubGluQGFtZC5jb20+DQo+
ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMgICAg
ICAgICAgICAgICB8IDEwICsrKysrKystLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jIHwgIDkgKysrLS0tLS0tDQo+ID4gICAyIGZp
bGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jDQo+ID4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMNCj4gPiBpbmRleCBjNWEy
ZGNmZjUwNTguLmMzMGZlY2M2NTNiNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZ2Z4LmMNCj4gPiBAQCAtMjU5NCwxNCArMjU5NCwxNyBAQCBpbnQgYW1kZ3B1
X2dmeF9yZXNldF9tZXNfY29tcHV0ZShzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4g
PiAgICAgICogcmVzZXQgZGV0ZWN0IHdpbGwgcmV0dXJuIHRoZSBhcnJheSBvZiBiYWQgcXVldWUg
ZG9vcmJlbGxzDQo+ID4gICAgICAqLw0KPiA+ICAgICByID0gYW1kZ3B1X21lc19zdXNwZW5kKGFk
ZXYsIHhjY19pZCk7DQo+ID4gKyAgIGRldl9kYmcoYWRldi0+ZGV2LCAiU3VzcGVuZCBhbGwgcmV0
dXJucyAlZC4geGNjX2lkICVkXG4iLCByLA0KPiA+ICt4Y2NfaWQpOw0KPiA+ICsNCj4gPiArICAg
aWYgKCFhbWRncHVfZ3B1X3JlY292ZXJ5KQ0KPiA+ICsgICAgICAgICAgIGdvdG8gYWZ0ZXJfcmVz
ZXQ7DQo+ID4gKw0KPiA+ICAgICAvKiBpZiBzdXNwZW5kIGFsbCBzdWNjZXNzLCBpdCBzaG91bGQg
bm8gaGFuZyBxdWV1ZSAqLw0KPiA+IC0gICBpZiAoIXIpIHsNCj4gPiAtICAgICAgICAgICBkZXZf
ZGJnKGFkZXYtPmRldiwgIlN1c3BlbmQgYWxsIHN1Y2NlZWRzLiB4Y2NfaWQgJWRcbiIsDQo+IHhj
Y19pZCk7DQo+ID4gKyAgIGlmICghcikNCj4gPiAgICAgICAgICAgICAvKiBhbHdheXMgcmVzZXQg
dGhlIEtDUS91c2VycSBzaW5jZSB3ZSBuZWVkIHRvIHNpZ25hbCB0aGUNCj4gZmVuY2UNCj4gPiAg
ICAgICAgICAgICAgKiBhbmQgd2UgY291bGQgYmUgc3R1Y2sgaW4gYSBsb29wIHdoaWNoIGlzIHBy
ZWVtcHRhYmxlLg0KPiA+ICAgICAgICAgICAgICAqLw0KPiA+ICAgICAgICAgICAgIGdvdG8gZmVu
Y2VfcmVzZXQ7DQo+ID4gLSAgIH0NCj4gPiAgICAgciA9IGFtZGdwdV9tZXNfZGV0ZWN0X2FuZF9y
ZXNldF9odW5nX3F1ZXVlcyhhZGV2LA0KPiBBTURHUFVfUklOR19UWVBFX0NPTVBVVEUsDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHJ1ZSwgJm51
bV9odW5nLCBhZGV2LQ0KPiA+Z2Z4Lm1lYy5tZXNfaHVuZ19kYl9hcnJheSwgeGNjX2lkKTsNCj4g
PiAgICAgaWYgKHIpIHsNCj4gPiBAQCAtMjY2Miw2ICsyNjY1LDcgQEAgaW50IGFtZGdwdV9nZnhf
cmVzZXRfbWVzX2NvbXB1dGUoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4gICAg
ICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gPiAgICAgfQ0KPiA+DQo+ID4gK2FmdGVyX3Jl
c2V0Og0KPiA+ICAgICAvKiBNRVMgZG9lc24ndCBkZXRlY3QgYW55IGh1bmcgcXVldWUgYnV0IHdl
IGhhdmUgYSBrbm93biBiYWQNCj4gcXVldWUNCj4gPiAgICAgICogYW5kIGl0IGlzIG5vdCBLQ1EN
Cj4gPiAgICAgICovDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYw0KPiA+IGluZGV4IDg2YjcwNzQ4NjE3Yi4u
Yjc3Y2ZkOGJhOTA3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMNCj4gPiBAQCAtNDcxLDExICs0NzEs
NiBAQCBzdGF0aWMgaW50IHJlc2V0X3F1ZXVlc19tZXMoc3RydWN0DQo+IGRldmljZV9xdWV1ZV9t
YW5hZ2VyICpkcW0sIHN0cnVjdCBxdWV1ZSAqcSkNCj4gPiAgICAgaWYgKFdBUk5fT04oZHFtLT5k
ZXRlY3RfaGFuZ19jb3VudCA+IDApKQ0KPiA+ICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+DQo+
ID4gLSAgIGlmICghYW1kZ3B1X2dwdV9yZWNvdmVyeSkgew0KPiA+IC0gICAgICAgICAgIHIgPSAt
RU5PVFJFQ09WRVJBQkxFOw0KPiA+IC0gICAgICAgICAgIGdvdG8gZmFpbDsNCj4gPiAtICAgfQ0K
PiA+IC0NCj4gPiAgICAgbWVtc2V0KCZxdWV1ZV9pbnB1dCwgMHgwLCBzaXplb2Yoc3RydWN0DQo+
IG1lc19yZW1vdmVfcXVldWVfaW5wdXQpKTsNCj4gPiAgICAgcXVldWVfaW5wdXQuZG9vcmJlbGxf
b2Zmc2V0ID0gcS0+cHJvcGVydGllcy5kb29yYmVsbF9vZmY7DQo+ID4gICAgIHF1ZXVlX2lucHV0
LmdhbmdfY29udGV4dF9hZGRyID0gcS0+Z2FuZ19jdHhfZ3B1X2FkZHI7IEBAIC0NCj4gMzYwOSw3
DQo+ID4gKzM2MDQsOSBAQCBpbnQga2ZkX2RxbV9zdXNwZW5kX2JhZF9xdWV1ZV9tZXMoc3RydWN0
IGtmZF9ub2RlDQo+ICprbm9kZSwNCj4gPiB1MzIgcGFzaWQsIHUzMiBkb29yYmVsDQo+ID4NCj4g
PiAgICAgICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHEsICZxcGQtPnF1ZXVlc19saXN0LCBs
aXN0KSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICBpZiAocS0+ZG9vcmJlbGxfaWQgPT0gZG9v
cmJlbGxfaWQgJiYgcS0NCj4gPnByb3BlcnRpZXMuaXNfYWN0aXZlKSB7DQo+ID4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJlc2V0X3F1ZXVlc19tZXMoZHFtLCBxKTsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKHJlc2V0X3F1ZXVlc19tZXMoZHFtLCBxKSkNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfZGJnKGtub2RlLT5hZGV2LT5k
ZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkZhaWwgdG8gcmVt
b3ZlIGJhZCBxdWV1ZS4NCj4gZG9vcmJlbGxfaWQgMHgleFxuIiwgcS0+ZG9vcmJlbGxfaWQpOw0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBxLT5wcm9wZXJ0aWVzLmlzX2V2aWN0ZWQg
PSB0cnVlOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBxLT5wcm9wZXJ0aWVzLmlz
X2FjdGl2ZSA9IGZhbHNlOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZWNyZW1l
bnRfcXVldWVfY291bnQoZHFtLCBxcGQsIHEpOw0K
