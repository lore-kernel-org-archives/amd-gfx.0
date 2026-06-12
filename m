Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762BBCD98CF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 08:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EB7710E9A4;
	Fri, 12 Jun 2026 08:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K44QVAxF";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A492810E9A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 08:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tolSHV1jNTsud4IlieJQtXBHUDMsLOPii9ygDWFFVst+dDI0GooKKweUBwhycH5a3OtboYaCQZ4dP9YjIbX91kNOI7IUnEte+27jgLQ9l4ltMsFyBPZzQ5Yu51cko5YiUGoFumoDWvwFsyjUUBFL8cGH6H5kMg/SEJz+gNzoevMkBRtPUtKaOAucKyPnEDFiVH7eTfPpwDFMUnFvwMsni1AGo/lMN44KfxjdZPek75U28+NmFT+zSfr/1kOx7cxb9jH6zzwHEBrm3ypKFQp1j9yQyKiDqeyBDsX8zV5V4cwduix5SsCRZuqXSUMlixkmgOILYcvgYie3ZsSK7oZRVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nr40cQXCtzstR96afquXMqYZxlWS9FUbLpdOd9vpku0=;
 b=wZ/2cqulnGNj7Oh9JsBf8b+tU4Y6V5O+knFwHZ4GyFtD+8JGLj7J28my6B6dEMYwGqyzAhaz2UT5Bxg5kQQQQTrqHlciCq6lx0RWIBdBDX5Chvz+6JlbZyNHiraRVdRUyAdmnN5AQdJkisRp2lqTATgBvnIoGhjCunjbY3B533OBwqErsewzoDlFeUyTjeeNKdH3GOmQSJIRYy1Y8+6SqnC+4+2FE8DMIytu0RFqaIxX4ffpXnzVRcbPtjZIB52xZhcyP26s7oezgjfkt2krOHdMnaE4awwd3JsxQ+CjcliyWqUctLhskw/k5XNVYHWSmIdRKb31LZ/DDXQjgjR9DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nr40cQXCtzstR96afquXMqYZxlWS9FUbLpdOd9vpku0=;
 b=K44QVAxFl4m4KH0z4khkbyAYQm+v8n2V4CeOu8LHETosY6z9K6AOHp4Xnob0mZTzGqwwFvl0clz35ArQHRw4xv3lvktXXfPq5KoHbzYplsAiTDeawy9AGZTFFk8/4QnXclPuDLpg0U3MJCimK+TGllsVYg4f0AjFIk+hueXGUoE=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 08:22:30 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::53da:e77e:261e:5a29]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::53da:e77e:261e:5a29%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 08:22:30 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Samuel
 Pitoiset <samuel.pitoiset@gmail.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Huang,
 Trigger" <Trigger.Huang@amd.com>
Subject: Re: [PATCH v2 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after
 mode2
Thread-Topic: [PATCH v2 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after
 mode2
Thread-Index: AQHc+Wc2ieOsyoZuG0KEIImc6nAmKbY5znMAgAEt5ID//5ClgIAAiTcA
Date: Fri, 12 Jun 2026 08:22:30 +0000
Message-ID: <BL1PR12MB584907E9C1F69772EA27AE91E7182@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20260611055715.1142135-1-Jiqian.Chen@amd.com>
 <3694190.dWV9SEqChM@timur-hyperion>
 <BL1PR12MB5849F914400E06407D2C9451E7182@BL1PR12MB5849.namprd12.prod.outlook.com>
 <2014755.b9uPGUboIS@timur-max>
In-Reply-To: <2014755.b9uPGUboIS@timur-max>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.21.0113.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|IA1PR12MB8078:EE_
x-ms-office365-filtering-correlation-id: dad4bd2b-c797-43f6-a2a4-08dec85bbec9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|38070700021|22082099003|18002099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: KW9C2aL9+xYQ7soGshHsDKeXbHd6wwlb8h+hE7OBr31+VEOd2kgLOd1ryu5BY85WOZmjfD9+xvYTMxrx/IwqO9vFmeyq6csn0aIUgxZ5JX1BUR6bqSDhNbKMeVFZuQ1vuM/ULkgX3JsywKqEerPIb2t8rfwovgcvp/nsGt/Lig1CYbACbvrTbWEV7xkpQigwYz5YqpENT+hRfEKG9y3rco1kdtkVUfiw5a60JKyO2TeGmHN5Rpwbiqqzqms8CFGgQ3mMRKJk/sqSkvuoyeKkdsa5cEP2W42+vSoCMiaMJW5AlxHSfKD9nx36/hUpCCTlRseMIuhbC54dCYUiKvg/8VoK554Wu0QZRoHu95dJFqE8K/HDA3bbblAHcpin6cgsW5dA24QV/lVvJQ63azWZiZRZEcugdCCz1DN0uzdJSVUcDeSLgUslucdx3S9NqFRP4tDJ3SdSyxroeMwJbLjXr96YeLBVoCuv6axJWTcxSUfom3dZNECxFJx0uhrXwVVhiDd/NcHt5H84YUM/LkdrtOPdC6kMq1jIHlqVvYVnMvTBKc/30aclHPf0RP/0GtxWS6tuQ5iHMVEJ6g9GnyljHa6XHoVI07mcG/W0yEQVxDzwrKF6dCgbhrs9tJWQARuef5pUMxcfZ1rnxOBx/mJdls5yMWgV5sA8uaRcRudOPWfDdYUHpH/FT7T7e3zFDOqkYxlSt+xd8z5BFZ1emhDYjDxiJ75z8iRH+hR3Y4TmES0pnxao3+2YnspO4eZcxh8i
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEx6NEpIdHFFRWc5OWZ3SDJVMTVnLzU2MGs0V1k3YUhORWhSMnA3NkdHMi9X?=
 =?utf-8?B?VjhMU0E4N3BhR2Q0UVY5STdKZFFtOGRvRnlhVkJ2bDVpM0cwV1dTYm9kTnh5?=
 =?utf-8?B?UWNtdjFsSmNHeDFnbldQcmxleHRBSXRaUTFLNG5EMmlTQXN5RitQZ1dUeXE2?=
 =?utf-8?B?V1F5UEZBZEpJakh0K3h3enVSMUh6enFpQXJ6cVBFTnlDbHg0WG1FSC9CQ2p5?=
 =?utf-8?B?QjN1cGl6YTJvNzZReGQwR1QwcERlOG5jZ0RQTVVGak1TRmEvNnhzejFXdTFZ?=
 =?utf-8?B?QStiY3hmd1E3R2dDMjdjNWU5bllFb1EzMzlESVdFQzcyYWNsN0lTTHlHTHV3?=
 =?utf-8?B?Z09xNGFuRmI3TXp2U1FaL2p6L09wNU43Z3k3R1h2NTJlKy81a0hBRm1mOUZS?=
 =?utf-8?B?SFhzclY4VUtqREpwc0tKNlRSaFV3cDAyU1VrQzZ6eG9nbzFmVjZKYjFsNURj?=
 =?utf-8?B?TUxoSWx3QWNXaXYzZGdSL1ppTkZNVy9GSC9SQk1vZWVHYVJmMkozNkxCcTlk?=
 =?utf-8?B?UjgxYzNHR0VDUThYQzVKaVlCbHVlVHpFaU5KNWFnZms5K2hxbkhKb0luNzk3?=
 =?utf-8?B?NHJ2OWltL1V6cXl4bFlvWUJ1dTBrS24ybU5ONldHdjEybnZ1VFhLV25Idmlr?=
 =?utf-8?B?OUZHYXFHUzJLQTdTOThvd1U0UTRDci9ZY2RuZXpmcFV6TGNTeXZkWWV6dlhr?=
 =?utf-8?B?U3ptelROVVFkc3N6bnIwNXZGRlNUQi9kZzNYcU1oMk5YbTR3MkpsRFJNT0FN?=
 =?utf-8?B?aG16K3c4eWxzZHFQQ3FHaXZYZk5LVFNnUXRWMDN6VmVER2FlZTlFQzRJcTVU?=
 =?utf-8?B?NHYwRWp1d1Z0clZIZFhKMENBRUpDM3Vyd2NPeVNQTVlOemRCTmlLNlV3dkw2?=
 =?utf-8?B?YmY1S3p0c0hRNXR6MEthaHJWYWxPTlJ3Qmx5dVVOYUVRS05lb0pTdVdVSXN1?=
 =?utf-8?B?azhmL0ZPZUYzQ0tPaFVJeGdzeEYxTFVBMVB3TUViMzY3QklSZFFIYlFPbzRN?=
 =?utf-8?B?Zk11SW9VNCs3SUN3Zk5YdWhod29uWW5hVGUzMlFWUFhBdW1uazBMQUxXQ081?=
 =?utf-8?B?TzYwekNzTWF1WTV1dW5nemhJelFRRGovekNKUnFEUlh3QyszUXR2N1pKRlpW?=
 =?utf-8?B?OGJyVnR2KzloeHJlOUQzZjhWa0tRZ0JiR2hkZk9zZFB5ak80QmxHaG5DOWRO?=
 =?utf-8?B?NUJ2eDFzUmdRRmgxWldEdnhnaWZVYU9BelpPZHlrUlVtcEVDUUFCTmpZTE9p?=
 =?utf-8?B?RUxFY0xLeHhyWmdBT3UyTUtYTkZZSEFDVzUrYlpIUmEzdFFLaEp1U3E3TUJa?=
 =?utf-8?B?M1ZUVXM2NHV3QnlzdVQ4c3U1RlJUN0cvRElvK2syRVJrTElGNDZ1T2tiYWY3?=
 =?utf-8?B?aWNEMmZtRWcyaWtPa0lWcDZOK1dkb0dLVkZDT3drRXlQY09ESUcvQmlrMkRi?=
 =?utf-8?B?M1dEM3dYOWoybHpDQXRtQmtjV0RQVVA2SUlES0R2MmlXYmE2eDgwenJZdkJB?=
 =?utf-8?B?YkdtZ2EzUzRmM0RFSDltenlHbmNQMFcxcnZiVUR6cmVUa2tBeUxGR0xBSTVl?=
 =?utf-8?B?OTBiV1prUEtISzBLeS9DdXI2NzNOQStjc3cyZTNscldZMll5TTZ1VHhJSmgy?=
 =?utf-8?B?MEw4ekF5WUI2QnR1K0Y1ZkgwVEp2THRzeUZuNkxnMEduYjlheGd4emFOY2ps?=
 =?utf-8?B?QWpCZ2hXZ2xVbjkwUXZJS2puaXlnQzZ4S2piYjFxQWNnSWdEVHZrYmFKbGs4?=
 =?utf-8?B?Vjd6bTRBUXdma2VqT3hpSm5ldFZvVnFuMlNXWHJhMklqNDZTbkVhWXlNKzFF?=
 =?utf-8?B?MDBhd1Z2MmFJeGZLekk5S1VncGh3YUllODVEMmNGS1VqRWdHL2k3aXZNUDM2?=
 =?utf-8?B?MVVoQVVkcTRuT2NKSUZCUk9SVzNNLzdMNi9yb29qZFBWS3ovUXI5N1FRM1Ey?=
 =?utf-8?B?R1ZIM0t5UHRtbXc0WVBqTWpRNVh6NFE4bzFleVV4ZTI2WTdmL1BMSWVzbng3?=
 =?utf-8?B?UkdGbXY5eDdZTGlwVmJ1Vys1c3lsbW1qQjVlM2xaWEtibXJVVG9ZTDRmbHBw?=
 =?utf-8?B?K2VuL2FWNHU1VUUyZUcrcUFJSzFzZ1dFSkRYaWpsb09aZjFpNTdtdVJIYWtX?=
 =?utf-8?B?cU90eGRTNjhuRzRkVTBVSVR4Mkt5OXdGZUl4YnVmbWthY0tkRVpTWFFtS1ht?=
 =?utf-8?B?TlRQRXNrWitpNHo4RVY2dnZjaWpOdGJjOUN0OHpjbTN6N3N5S3BwOGo5MTRa?=
 =?utf-8?B?YVZya2YxZDkwMjdYbkVaU1NxaTJJL1kwbC82UW1DUTlESXZPTUg5T01vMG9X?=
 =?utf-8?Q?XoiwI0FrnMm/Pi447w?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96BD23CE3F11F94494ED5394742967D4@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad4bd2b-c797-43f6-a2a4-08dec85bbec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 08:22:30.1462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6k73Bk487TvNSDqX+a5vQ6dbuMdzlI18bzBEDfQzwADpreF6e4x7pVwNWavgM+zyYKKOuNJslyUtBQg48qzADg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078
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

T24gNi8xMi8yNiAxNTo0OCwgVGltdXIgS3Jpc3TDs2Ygd3JvdGU6DQo+IEhpIEppcWlhbiwNCj4g
DQo+Pj4gSW5kZWVkIEkndmUgc2VlbiBzaW1pbGFyIGlzc3VlcyBvbiBvdGhlciBHUFVzLCBhcyBJ
J3ZlIGJlZW4gbG9va2luZyBpbnRvIA0KPj4+IGltcHJvdmluZyBHUFUgcmVjb3ZlcnkuDQo+Pj4N
Cj4+PiBJbnN0ZWFkIG9mIGZvcmNpbmcgdGhlIEhRRF9BQ1RJVkUgdG8gemVybywgSSBzdWdnZXN0
IHRvIGRlYWN0aXZhdGUgdGhlIEhRRA0KPj4+ICBiZWZvcmUgcmVzZXQuIFdlIHNob3VsZCBpbnRy
b2R1Y2UgYSBnZnhfdjlfMF9kZWFjdGl2YXRlX2hxZCgpIGZ1bmN0aW9uDQo+Pj4gc2ltaWxhciB0
byB3aGF0IGdmeF92OF8wX2RlYWN0aXZhdGVfaHFkKCkgaXMgZG9pbmcsIGFuZCBjYWxsIHRoYXQg
ZnJvbQ0KPj4+IHNvbWV3aGVyZSBpbiBnZnhfdjlfMF9od19maW5pKCkgd2hlbiBkaXNhYmxpbmcg
dGhlIGNvbXB1dGUgcXVldWVzLg0KPj4NCj4+IE1ha2Ugc2Vuc2UsIHRoYXQgbG9vayBsaWtlIGEg
bW9yZSBzdWl0YWJsZSBwbGFjZSwgSSB3aWxsIHRyeSB0byBtb3ZlIG15DQo+PiBzZXF1ZW5jZXMg
aW50byBnZnhfdjlfMF9od19maW5pKCkgaW4gbmV4dCB2ZXJzaW9uLg0KPiAgDQo+IFNvdW5kcyBn
b29kLg0KPiANCj4+PiBJbiBmYWN0LCBpdCBsb29rcyBsaWtlIGl0IGFscmVhZHkgZGVhY3RpdmF0
ZXMgSFFELCBidXQgb25seSBmb3IgdGhlIEtJUQ0KPj4+IGFuZCAgb25seSB3aGVuIGl0IGlzbid0
IGluIHJlc2V0IG9yIHN1c3BlbmQuIFRoYXQgbG9va3Mgd3JvbmcgdG8gbWUgYW5kDQo+Pj4gSSB0
aGluayBpdCBzaG91bGQgZG8gdGhhdCBmb3IgYWxsIGNvbXB1dGUgcXVldWVzIChpbiBhZGRpdGlv
biB0byB0aGUgS0lRKQ0KPj4+IGVpdGhlciB1bmNvbmRpdGlvbmFsbHkgb3IgYmVmb3JlIGEgbW9k
ZTIgcmVzZXQuDQo+Pg0KPj4gU28sIHlvdSB0aGluayB0aGUgaWYgY29uZGl0aW9uIGNoZWNrcyBh
cmUgbm90IG5lZWRlZD8NCj4+IAlpZiAoKGFkZXYtPmZsYWdzICYgQU1EX0lTX0FQVSkgJiYgYW1k
Z3B1X2luX3Jlc2V0KGFkZXYpICYmDQo+PiAJCQlhbWRncHVfYXNpY19yZXNldF9tZXRob2QoYWRl
dikgPT0gDQo+IEFNRF9SRVNFVF9NRVRIT0RfTU9ERTIpDQo+PiBTaW5jZSBJIG9ubHkgcmVwcm9k
dWNlZCBhbmQgdmVyaWZpZWQgd2hlbiBtb2RlMiBvbiBBUFUsIEkgdGhpbmsga2VlcGluZyB0aGlz
DQo+PiBjaGVjayB3b3VsZCBiZSBiZXR0ZXIuDQo+IA0KPiBZZXMsIEkgdGhpbmsgdGhlIGNoZWNr
cyBtYXkgbm90IGJlIG5lZWRlZCBvciBuZWVkIHRvIGJlIGFkanVzdGVkLg0KSSBhbSBub3Qgc3Vy
ZSBpZiByZW1vdmluZyB0aGUgY2hlY2tzIGNhbiBjYXVzZSBuZXcgaXNzdWVzIGluIG90aGVyIEFQ
VXMgb3IgZEdQVXMgdGhhdCBkb24ndCBoYXZlIHRoaXMgaXNzdWUuDQpQZXIgb3VyIHRlc3RzLCBH
UFVzIHRoYXQgdXNlIE1vZGUxIGRvbid0IGhhdmUgdGhpcyBpc3N1ZS4NCklzIGRpc2FibGluZyBI
UUQgaGFybWxlc3MgZXZlbiBmb3IgR1BVcyB0aGF0IGFyZSBub3QgZXhwZXJpZW5jaW5nIHRoaXMg
aXNzdWU/DQoNCj4gQWRkaXRpb25hbGx5LCB0aGUgc2FtZSBzZXF1ZW5jZSBuZWVkcyB0byBiZSBy
ZXBlYXRlZCBmb3IgZXZlcnkgY29tcHV0ZSByaW5nLg0KWWVzLCBJIGhhZCBkb25lIHRoZXNlIGZv
ciBldmVyeSBjb21wdXRlIHJpbmcuDQoNCj4gDQo+Pj4gSSBkb24ndCBoYXZlIGEgUmVub2lyIEFQ
VSB5ZXQgYnV0IGlmIHlvdSBuZWVkIGhlbHAsIEkgY2FuIHRyeSB0byBzZWUgaWYgSQ0KPj4+IGNh
biAgcmVwcm9kdWNlIHNvbWV0aGluZyBsaWtlIHRoaXMgb24gYSBWZWdhIDEwIGRHUFUuDQo+Pg0K
Pj4gSXQgc2VlbXMgVmVnYSAxMCBkR1BVIHVzZXMgTW9lZDEgb3IgQkFDTyByZXNldC4gSSBhbSBu
b3Qgc3VyZSBpZiBpdCBoYXMgdGhlDQo+PiBzYW1lIGlzc3VlLiBXaGVuIHlvdSAic2VlIHNpbWls
YXIgaXNzdWVzIG9uIG90aGVyIEdQVXMiLCBhcmUgdGhleSBhbGwgQVBVcz8NCj4+IFdoYXQncyB0
aGUgZ2Z4IHZlcnNpb24/IEFuZCB3aGF0IHJlc2V0IG1ldGhvZCB0aGV5IHVzZS4gSWYgdGhleSBh
cmUgbm90LCBJDQo+PiBtYXkgZmluZCBhIHNhbWUgaGFyZHdhcmUgYXMgeW91ciB0byB2ZXJpZnkg
bXkgY2hhbmdlcy4gSSB0cmllZCBvdGhlciBBUFUNCj4+IHdpdGggZ2Z4MTAsIHRoZXJlIGlzIG5v
IHRoaXMgaXNzdWUuDQo+IA0KPiBZb3UgYXJlIGNvcnJlY3QgdGhhdCBkR1BVcyBkb24ndCB1c2Ug
bW9kZTIgcmVzZXQuIEkgc2F3IGEgc2ltaWxhciBpc3N1ZSB3aGlsZSANCj4gd29ya2luZyBvbiBh
IHBhdGNoIHNlcmllcyB0byBpbXByb3ZlIEdGWCBJUCBibG9jayBzb2Z0IHJlc2V0IG9uIEdGWDgu
IEkgYW0gDQo+IHRlc3RpbmcgdGhhdCBvbiBhIENhcnJpem8gQVBVIGFzIHdlbGwgYXMgRmlqaSBh
bmQgUG9sYXJpcyAxMCBkR1BVcy4NCj4gDQo+IFRoZSBwcm9ibGVtIEkgc2F3IGlzIHZlcnkgc2lt
aWxhciB0byB5b3VyczogY29tcHV0ZSByaW5ncyBmYWlsIHRvIHJlc3VtZSBhZnRlciANCj4gdGhl
IHJlc2V0IGFuZCBhcmUgInN0dWNrIi4gSSBtYW5hZ2VkIHRvIHNvbHZlIHRoYXQgYnkgbWFraW5n
IHN1cmUgdGhlIEhRRCBpcyANCj4gZGVhY3RpdmF0ZWQgYmVmb3JlIHRoZSByZXNldCBhbmQgZW5z
dXJpbmcgdGhhdCB0aGUgTVFEIGlzIGNsZWFuZWQgdXAgYWZ0ZXIgdGhlIA0KPiByZXNldC4NClRo
YXQncyBncmVhdCwgeW91IGFscmVhZHkgaGF2ZSBzb2x2ZWQgdGhlIGdmeDggaXNzdWUuDQoNCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gVGltdXINCj4gDQo+IA0KPiANCj4gDQo+IA0KPiANCj4gDQo+
IA0KDQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVuLg0KDQo=
