Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F046C48297
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 21:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFFCE10FC1E;
	Tue,  6 Feb 2024 21:29:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QsysqE5Z";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A1110FC1E
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 21:29:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9VL6W0+iuEuN4+ycXGmKZe+sD9hGkhfI2ZLt8WsqmC7AN5SPWgynk04iovzQhVyRJEt2wJtvij30Mm7Fv9DqbD403zr/b/+QuPYddwR1fH7G824JXXq8KZWRyENSjJ1rKUIVRN582hr09OwVwqv+GcLRxM8RMAH2IQSsBarLbWW0+ljgU9wFgD3KbO2ePq0fRGOJnshFQUIlAoIFNPn5AEUCR/+qveVTSNL0gj3TrmiNWZSUtV5Sf+jZPRc8NOkp8to/+C/M876BoVNXoOV+L5MqOv4g6bWCGQq4aUGtzDX8CVxEcs7N1JdUHE8QeT4MqOIe5px/jQdapF6XBkznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIzpmEjI3s8T+LET+NX0YqkjHmpePkMN4GH3RcuyJis=;
 b=XXm+LaULifheaurwboL0oGhWNRyyGW0zcHPfGW3L92HHfmS1xTO/yFVX1M+raz1O43MlfE25MPIqSeaxVtFFu8OVBr8So7Lp0OQjseN+6VufJ/EqUen2kTNHiH89yoEjKcd1OZbXqATMo79oq0MSx50eLk7/oQcoxVoZ6NHbCSEYrNHlH6PBFuTzskejh+7lMo3BGPjNFynVIA/PamdH72xfn+Lua22i6yYrNaClxOhL9QYAtsN7x117Lw7dpGVA5OPnmlpk+lyRwJFiU3EzCtKrdw6uwZtshz9+sQqwdO5THw94bmmqmH1F0MX1esTMBfhhesfp/s/vmOSnCxG+xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIzpmEjI3s8T+LET+NX0YqkjHmpePkMN4GH3RcuyJis=;
 b=QsysqE5Z3Un+nQFZzV/r+IQyTX9g2Zry71jJtwT81mSgG0LcrsATOrGqTanksxHpGzCaWJzbDLC9Y4XpGxSZqA+winC0j6ZwPU1VJb+najG1PNcGFijxRLdKgexH2qteCQDTWq6/EOlkgkkHzVlZPInyiGbAaT3X//17Gj9myU8=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by IA0PR12MB8982.namprd12.prod.outlook.com (2603:10b6:208:481::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 21:29:29 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::b465:8bc6:1fd7:9951]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::b465:8bc6:1fd7:9951%7]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 21:29:29 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Don't divide L2 cache by partition mode
Thread-Topic: [PATCH] drm/amdkfd: Don't divide L2 cache by partition mode
Thread-Index: AQHaWULe8HyK7g3SwkOm1Ds66v/NS7D91GyAgAAAF0A=
Date: Tue, 6 Feb 2024 21:29:29 +0000
Message-ID: <BL1PR12MB58981CB2BA9BD123FF55F45485462@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20240206212418.629528-1-kent.russell@amd.com>
 <63edb1b7-06bf-4051-ab4a-d9cf205f19c0@amd.com>
In-Reply-To: <63edb1b7-06bf-4051-ab4a-d9cf205f19c0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2e64949a-f21a-4179-b19b-c68a1612667b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-06T21:29:08Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|IA0PR12MB8982:EE_
x-ms-office365-filtering-correlation-id: cd08a5ea-ea1c-455b-1e18-08dc275ab373
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CP/bM7hpaYAmFZwxYyYVLB0AleE6RRf0VUDgmgHTSlS4sUxyQAfoUsGFOL0fmL7GwxdGpArIw3fIo2V9tQFnrcPhzXxOqKJNxNUlx0uyx0rAWlzZu8XW0FL8JTSIkLGQBNumN9tK2XE3A9+OzDVdsUvjSQfMOBDTyYJH4oJa12xinSVaiPHK6l4yrz6wWYZxqoy9kGwEaOxixItdPfZ0QQj/Ji2qIS7K/cSI89tm7zDoRjSR1boZwMzfj8Sxb8Et9YEkfGk+84RkDrxW4J0bPiYWAfrmg2mAXonxltJwLuuhfIteqkHArQSgf9yRFS8camCxjlvTqi5EYuuveJpFu8Hwd1B5YvuArfc1l0Md4to/s8w0TzCsaS33P0g3J627R8PeODsCqLWby0nMvnigVQfYdhrKCNpUEIbpc1iixFAQFxesDRymwkNbhPXWdv5CxVU5XJBmU4feoQPzGEglPQdJcuP4UEBVTFOVrHyQJfWYxeZTsy1B1AuQ1I0wPcSJmTowG/BSUaE85r0ACcK+8mvl5G18Q/VrKjPRG/ZRSxIoJ19m1anigh9jndzUL7sBtfoUkjaZS1KcN4T4iNQrs0jVkfc3wt9iF5jaqLanfI6Nf6W9ZbeD0DXo0xqQGN+C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(9686003)(26005)(6506007)(7696005)(86362001)(64756008)(55016003)(5660300002)(66946007)(8676002)(4326008)(8936002)(33656002)(66476007)(53546011)(66446008)(316002)(110136005)(122000001)(52536014)(478600001)(71200400001)(38100700002)(76116006)(83380400001)(2906002)(38070700009)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTEwVXBvdm1vUzhxT295V1k5Z3Z0dDNrS2ZVSXRCSXZldFc3b2paM1FsZCtl?=
 =?utf-8?B?TUdldVFWekF5MXRzakVhY0VaUHJoSjF0T3pkaXRDbEFVQzg4QlRIMFVpL2NG?=
 =?utf-8?B?d1JpV2tmN3VyQmtVdWF4ZkZKaUUwYmVSWWtGc3NEYXVERDZ1OWV5UldoaVYy?=
 =?utf-8?B?S0MrSlh1N0x3NWF1emR6UVNUdFFwSWJLVmxTd2g0ek0reDlwVzRDdEFENkVE?=
 =?utf-8?B?LzI3Q2NYNDg4ZUxtZDI4dU9YUm13SktIS05YeXMwM2JRRHBvbW12MzQ5RnlE?=
 =?utf-8?B?WmVLL1hFRC9PYjZBalVzb2c0SUtkTmxJZVFPZnM1MlpRbGJKTlJIMHJyUEV5?=
 =?utf-8?B?eWxEYW1PWEN1a3MyeWEzcTBTRmkxNFlnZW11VHBXajNhc3ZlclBmSml1MllY?=
 =?utf-8?B?WEN5bVhGZ1o1RzdWZ1hWaXNuQ3JWZHBUV0Zta3doL1c3d2F3eDdZdGVML1E4?=
 =?utf-8?B?TjVzSUczZndSQXYrb0NmblIxbHFiYk04Y1duZ2dNUGNwRzFNZ21LL0NrL3M5?=
 =?utf-8?B?QzhCbVo2NlNYaXRWcDNONVNxSHlmUWFBVjZ2VzZzL1RySDgyTk9pQ2xjVUlV?=
 =?utf-8?B?dFI4NGdWTHRhQU1JcGluM1ZKTTV1V1hXQVljSEdoZDc5ZElibS9mZjRJODdY?=
 =?utf-8?B?QSs0b1BHUWVGSWhyN3dtODlIdWt4TjBVSUVvY2FIbnAyeEtJdklGbnlTSlVp?=
 =?utf-8?B?Zk16RExiejFrbVdFdG9lSTJQdDUrcGtrNklvWXFYT2dxeHM1ckQ0TVpkWGpK?=
 =?utf-8?B?dEJ0YnpQY0w4U0FqS3N5SUExRkFLRWh4TmlNMjZDcUkwNXJteXNONzBOd0tn?=
 =?utf-8?B?aC9OS09UdHdnMm9zd0tJeDFBMkRlTWVSWVkrV0NkTmsyb2s1Rzd2d0lILzRk?=
 =?utf-8?B?OGtheUFzL0prRlRZbE9uUC9NV1lGUDhjdlVxcGhOSERmT2lscG1Ma1V1R2Y3?=
 =?utf-8?B?VXdlZ3c1ZTk5V3B3M0hueStOZW1xbGZ1V2JTUmtVeFZxMXd3a1czZmpEeHRI?=
 =?utf-8?B?Z1MvS0p2bFFtekVZdG1pQit3VndQeFBIaGVyWjIwZjlzM3dQUzB2VzZxSndV?=
 =?utf-8?B?YlU3TG94RnFIWVRkL3AxMnJnVGhPTEJ1MWs4QUtnTTJsNnBJaGdPbzl6ckJB?=
 =?utf-8?B?UlR2YU9aTWJDajV1TlZzZ3F0RkhGSndLeWt0Yk9mQXBTQW90U0RWNmF5ME0w?=
 =?utf-8?B?aXVRZ01WTUkzbjlnL2kwSEZlTnJpVlg2RnV6T3ZjdWtQWithUnI4VkJlb0tt?=
 =?utf-8?B?ZjBhWVhzNDlRb1hNbkVxdUVsUzVrekJzYndodmNQMEFndFUzdGtOTlVRRVkr?=
 =?utf-8?B?RzFvZnVjakc5ejcwK29zYTJreTFzODVpQk1XSzNFcys5OGNtRkVHRnhzd1BN?=
 =?utf-8?B?TFBrS09JV1VSZHhMQTY5Z1VpZHpWVHJjaHZHQzBzaW0xOE9uVFQwdzJVL3dr?=
 =?utf-8?B?Q2lsUVZ2S3U5b0grS2JuZlkzOXNFVitEMURKajlmL3ZuRmY4UjYrRTRDdVh4?=
 =?utf-8?B?YlZmZ0RnR25BWHFoanR3ZTVSNGNYb1hWRVphOXlhTDR6eXMzclpQTDdYZUhm?=
 =?utf-8?B?cDdadUkvY3dtMHRmQUhiQmo3QlZabEplYTljSTI3NGZQSmU4ekpyKzB3YStG?=
 =?utf-8?B?bCtmQ3pCdkVxdHRmc0hZV3BXZ0hPVjVlUlU1V05HTzJKbWh0MENveE9yVVIy?=
 =?utf-8?B?bEFPZHJtc0l1REtXRm9nRTVDTUpNTGduay9Zd2dvVXJEb2lkNmdPSTRSak5r?=
 =?utf-8?B?QXl5ckZBWktBZndITXExYURRQjN0VEwwN1YvMW1HQ1N0eHJlMVNVT3FGTTd6?=
 =?utf-8?B?dFRGQUFuYkJYYzRxNU43b2R4bkxoYkR6dFlEMXJiSFRiZU83eWRmZUpYN3l3?=
 =?utf-8?B?MWNtYVJtWXdVWnFody9VNE9ZYjRDWkZ5Vlh5UXdaaEsvUGhMdkx2U0ZCODRx?=
 =?utf-8?B?emgrWkVpSTNicDlWdVJ3YzA0dTNUWDdoQ2pwbTdOOUloTjNiTW5OR3J3MkQy?=
 =?utf-8?B?WHpQOEJVWDJCcjFGdGNNSkliNFk3ZVpZYkxSUm85aXNUZFlDSEdMdVRQMm1I?=
 =?utf-8?B?TnpYY0NHVVlkRnpMdVduWXlXalQyb3JheUFFY0V3SXREL1cvQ3ltVTUvMkFt?=
 =?utf-8?Q?h0nQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd08a5ea-ea1c-455b-1e18-08dc275ab373
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 21:29:29.0716 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3/uuU+B88DQ+uJIHzRKzvXEqT/WXp0zYd4Mq2mDlKhB6Y2Q6mlBeCWnGD2el4Q8tHjGT1G3TWlZOjtHff97pGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8982
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCk9oIGV4Y2VsbGVudCwgaXQgZGlk
bid0IGdldCBtZXJnZWQgaW4geWV0LiBUaW1lIHRvIHNxdWFzaCENCg0KIEtlbnQNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1
ZWhsaW5nQGFtZC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDYsIDIwMjQgNDoyOSBQ
TQ0KPiBUbzogUnVzc2VsbCwgS2VudCA8S2VudC5SdXNzZWxsQGFtZC5jb20+OyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogSm9zaGksIE11a3VsIDxNdWt1bC5Kb3NoaUBhbWQu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1ka2ZkOiBEb24ndCBkaXZpZGUgTDIg
Y2FjaGUgYnkgcGFydGl0aW9uIG1vZGUNCj4NCj4NCj4gT24gMjAyNC0wMi0wNiAxNjoyNCwgS2Vu
dCBSdXNzZWxsIHdyb3RlOg0KPiA+IFBhcnRpdGlvbiBtb2RlIG9ubHkgYWZmZWN0cyBMMyBjYWNo
ZSBzaXplLiBBZnRlciByZW1vdmluZyB0aGUgTDIgY2hlY2sgaW4NCj4gPiB0aGUgcHJldmlvdXMg
cGF0Y2gsIG1ha2Ugc3VyZSB3ZSBhcmVuJ3QgZGl2aWRpbmcgYWxsIGNhY2hlIHNpemVzIGJ5DQo+
ID4gcGFydGl0aW9uIG1vZGUsIGp1c3QgTDMuDQo+ID4NCj4gPiBGaXhlczogYTc1YmZiM2M0MDQ1
ICgiZHJtL2FtZGtmZDogRml4IEwyIGNhY2hlIHNpemUgcmVwb3J0aW5nIGluIEdGWDkuNC4zIikN
Cj4gVGhlIGZpeGVzIHRhZyBsb29rcyB3cm9uZy4gSSBjYW4ndCBmaW5kIHRoZSBjb21taXQgYTc1
YmZiM2M0MDQ1DQo+IGFueXdoZXJlLiBEaWQgeW91ciBwcmV2aW91cyBwYXRjaCBhY3R1YWxseSBt
YWtlIGl0IGludG8gdGhlIGJyYW5jaCB5ZXQ/DQo+IE1heWJlIHlvdSBjYW4gc3RpbGwgYWJhbmRv
biBpdCBpbiBHZXJyaXQuDQo+DQo+IFJlZ2FyZHMsDQo+ICAgIEZlbGl4DQo+DQo+DQo+DQo+ID4g
U2lnbmVkLW9mZi1ieTogS2VudCBSdXNzZWxsIDxrZW50LnJ1c3NlbGxAYW1kLmNvbT4NCj4gPiAt
LS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jIHwgOCAr
KysrLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfdG9wb2xvZ3kuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9n
eS5jDQo+ID4gaW5kZXggNjRiZjJhNTZmMDEwLi41MzNiODI5MmIxMzYgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMNCj4gPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYw0KPiA+IEBAIC0xNjQwLDEw
ICsxNjQwLDEwIEBAIHN0YXRpYyBpbnQgZmlsbF9pbl9sMl9sM19wY2FjaGUoc3RydWN0DQo+IGtm
ZF9jYWNoZV9wcm9wZXJ0aWVzICoqcHJvcHNfZXh0LA0KPiA+ICAgICAgICAgICAgIGVsc2UNCj4g
PiAgICAgICAgICAgICAgICAgICAgIG1vZGUgPSBVTktOT1dOX01FTU9SWV9QQVJUSVRJT05fTU9E
RTsNCj4gPg0KPiA+IC0gICAgICAgICAgIGlmIChtb2RlKQ0KPiA+IC0gICAgICAgICAgICAgICAg
ICAgcGNhY2hlLT5jYWNoZV9zaXplID0NCj4gcGNhY2hlX2luZm9bY2FjaGVfdHlwZV0uY2FjaGVf
c2l6ZSAvIG1vZGU7DQo+ID4gLSAgICAgICAgICAgZWxzZQ0KPiA+IC0gICAgICAgICAgICAgICAg
ICAgcGNhY2hlLT5jYWNoZV9zaXplID0NCj4gcGNhY2hlX2luZm9bY2FjaGVfdHlwZV0uY2FjaGVf
c2l6ZTsNCj4gPiArICAgICAgICAgICBwY2FjaGUtPmNhY2hlX3NpemUgPSBwY2FjaGVfaW5mb1tj
YWNoZV90eXBlXS5jYWNoZV9zaXplOw0KPiA+ICsgICAgICAgICAgIC8qIFBhcnRpdGlvbiBtb2Rl
IG9ubHkgYWZmZWN0cyBMMyBjYWNoZSBzaXplICovDQo+ID4gKyAgICAgICAgICAgaWYgKG1vZGUg
JiYgcGNhY2hlLT5jYWNoZV9sZXZlbCA9PSAzKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgcGNh
Y2hlLT5jYWNoZV9zaXplIC89IG1vZGU7DQo+ID4NCj4gPiAgICAgICAgICAgICBpZiAocGNhY2hl
X2luZm9bY2FjaGVfdHlwZV0uZmxhZ3MgJg0KPiBDUkFUX0NBQ0hFX0ZMQUdTX0RBVEFfQ0FDSEUp
DQo+ID4gICAgICAgICAgICAgICAgICAgICBwY2FjaGUtPmNhY2hlX3R5cGUgfD0gSFNBX0NBQ0hF
X1RZUEVfREFUQTsNCg==
