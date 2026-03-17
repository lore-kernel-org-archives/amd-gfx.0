Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24CDF3380A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 07:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C2A310E49A;
	Tue, 17 Mar 2026 07:28:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nn9hKI/k";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3689410E49A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 07:28:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oq1636pWzYsDfbVXIC6idWZdn2qxxU3jValK6Zf+eYPy0Jh6S3qI450F/0wKJCOQWubx90lfkIL9nOQ3a2pP0sa34MnyU63bYkvAbMPVYMPOwGCmIppLEgFeZa039UzrOJnsENbbQI/p7RYynZToJixO4H/qgb3fHBLzK4qMpguWLFA1vy2ff2DjSKhzs+LRWZFgzm2AAdmC83AvzytGZ1cLQcwzYJdXR0PDkbBwMSfnYjSAASEuplUkJS/fT0f9qL2/WlPgWziHASuZgzCPq5inQhQG3prj9HbAbgFN2LzAXW5z8Np0j6TD8mk3CaFKW3J2Z6nd7onZbD8N4rgzBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VZeDdDpG3mJGJ+8mEmuxsioC/GErhL0xpuKXOnqpek=;
 b=XdQ4leSTnJ8J5QHC291DpPRgOW7jcYZWxvaZe2FBaI929K4qG9RKNL0TmkjrCou9WOLvSNGBjo1v5H0ZRw8vZ1n8Qg4YTjNZbQEeggyra+vGDfY7JWtVQulXKOhVD/lbEG1A+OBqQUaejFjk4amCv8pM0wd35h44XIi9Hy1OdaHDhDf8RpV2X7ovePkzwhy0VIDNH2pbzJky0Qs0PjFiSq+56ToZpmrnEyrYTDeR7uL7Hpxwnzs6jPZxvUnGLsPcy5DKpTgnuoBzG8UNoMEP/Jrr/AAjHKYw1HbMQz2ZjYlrUycSEtlLCnBWx6Wfe1dTFWwld4ftb4+uNZ+d0JMxoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VZeDdDpG3mJGJ+8mEmuxsioC/GErhL0xpuKXOnqpek=;
 b=Nn9hKI/kyj6D2W0WN6N5ZBZjG7ERx6fqn4y1P+396QuAOpG3cXWt40HXrh3FTMC8wbctIWMV18isDtwUmNdxwYlquzrHr6w0iEUF7fUZvySOs+33SWEvDtaJ7UsqS6upoSVrey4HJ5vmfqh/ze1XKJT25Otzacxdm5LkyikF7Tc=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 07:28:28 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 07:28:28 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Prosyak, Vitaly"
 <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation
Thread-Topic: [PATCH 3/3] drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation
Thread-Index: AQHctavbGQEDCjE06kSVRUDtHFudMrWyTh0AgAAFL1A=
Date: Tue, 17 Mar 2026 07:28:28 +0000
Message-ID: <DM4PR12MB51522BD08036B959C745DBE0E341A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260317011713.1812421-1-Jesse.Zhang@amd.com>
 <20260317011713.1812421-3-Jesse.Zhang@amd.com>
 <e83526a5-2ff0-48b7-9a42-6b297bf2de6b@amd.com>
In-Reply-To: <e83526a5-2ff0-48b7-9a42-6b297bf2de6b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-17T07:26:07.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS7PR12MB8371:EE_
x-ms-office365-filtering-correlation-id: ad09a7c6-5ca7-49f9-98e8-08de83f6c876
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003|7053199007;
x-microsoft-antispam-message-info: bycXO0ltXD5fO/NhxYJdrdB8Xt4i2ij/WC73YtLH0bcjj234dv4X27EIWhAyPVDje4h+HeKgbkfqzz8EpRnTTwrJnvjw3xSWGPfjZrR1XXMq19DU1T/MOIujvIh9NEAAsrxYW23ZmDQ0EL1PVXKkyuW1N6GC7vwXFwJR6LyiB3zeRvLnsSzZ0l7+W+MfK6SeW40PQgQ0xKqLWyg9hEziwkDIYk9631dtWOFCarjsJKmE2cz+QSrlcBcHsXmcYkJeWAYnxEgo+ng8UDw2L44ZwGy+c24s23I0pLp+LSx0ZXzRYJW0u3Je5oRwtCp18ouLiGLs9qGPPzCOUqXOnb9UPfaBj3rlSSXsYyN2E7XVfqxG4ZSdB2x8oo6pmuCTySikqibvKSUKbZztnRtIXSxutNGxWG1CoX7IHXbekiSoE+FvD0aoBgQMZC9ChbI1GWNhnU1iBkwVxp6TmOgjy/fp/CejJcEe7MCchZKi4gu6AxVa6u9HxmM14TiB+SU+VMEq+GAzFEkuttANkLiYgsbg8untlKGe+3/mTnbH/lUw+ClLheSat3cIpZBkK0IehbMTTjyWe7KskHw3AJIq31hWwiSMYwGk5TxaEwcmkCuuqRrm0CUbvA0gx6Z4lstq0q48Dzcck6uy/VsaKBjz7l04GLbRsMRZzEGv9w+xp2tzRF8QtVwI2tfpdl52FvRIyfjVsOhWzTYlGAOuVVCdwe2MPCVtfTHpQnC/CV6QY650NaV6FDAhx1jI2eGVRvwrhjR+jBJwBsumbw3yf3dbO2V9dZ5EpCh2lM7t9j2lYIhoRWM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3owQVM4cisyWTIwRjIzM0tnaXdNYndPS25tZGtQRndiTnJxdGVGSjNnd1po?=
 =?utf-8?B?clVlMWg1ZkQyMlBjemE4dENXVFNBSCttTWw5c2hGdnZxaSs5bjlnTEwvblN1?=
 =?utf-8?B?c2toZ01Ob3BJa1hpcGlTWXZtQWxpd3I0M0kwSEJCaFNKRVNBeGRnbUp5cVNa?=
 =?utf-8?B?dkthUWZkSmxvbU4wNEV2RWpwdnkyc3V2eEZpVnArSU9PZWRnQk5zdWIwd1hn?=
 =?utf-8?B?Tk1xQ0l6Q3VoTDY5UGwxa3RaSDB6bG5ESU5Fb0F6c3I1UEJnU2ladUt3RTN1?=
 =?utf-8?B?amVwa2E3YUQwYjFvVTFGcmFVbEJDUUdmNEJQdE1JRi9td3NhSzRZSnNuM1Bn?=
 =?utf-8?B?ellNSzJVQk93VUJ1MmxCZXhIeElYcHVEeVA1ZnJ2NUpWRTExSjJhV1JVdTJp?=
 =?utf-8?B?UStjVGo1cWdsOXJUMS9aTEJFMlpJQmdleTFqTFFmeUtPWTM0alBJc096bWJp?=
 =?utf-8?B?bmNwT3d5b2FjMmRhMmVxT3VIV1FRbFdyOU9VSnM1blVIMEpaSi8rcGErQlFt?=
 =?utf-8?B?VWh3MlY5SVpMd0lyaGszWFpVdDdneVVkRHNWdVZSQmMrUG9Hc1lVUkhMQ2ZZ?=
 =?utf-8?B?aWF0SHFkbWIrSW8wdjE1MVNOcU1YdnNYN2QrNDR6WEF2Mjhja2h4eXozcHRn?=
 =?utf-8?B?KzJEQ3BVVTJ0c1Y5VjVSd2lyZWJ2ZGs5dE5ZaXplNHJmNC9LUDRaSGpkZ2xS?=
 =?utf-8?B?YzIzaWlnTHgwWXRoSkowWXZ4TnE5bTh6b0NCQld5dm4rcW13R1NDay9ZQmNy?=
 =?utf-8?B?dGQvR1dPSnhRMDRVOHhrTDNrUDBkUEs3MHZQUkQ5OFVGeTdKYW5zYlpHY2Zj?=
 =?utf-8?B?cmUvZzBza1JEU2traVpsWHAxWWxmUXRyQzdiLzdieUxaeXVrU1E4ckpDblZx?=
 =?utf-8?B?cjhNRUIwZVdpRXJ6QWNoTTBGVUtzYW9vYlBSWnlKVDNHSUprd05scDlaN1po?=
 =?utf-8?B?d1lxc0VNcTR3bFlBMzlkazJsZG8raFNrcm42MGM5MXVTRFBIWk53VzVNY0ds?=
 =?utf-8?B?c0p1VEFXeDNnZnkrSm1WekNJSVVHS1JNTWdFY2tUZW14TWhYTDllbjd5VnVl?=
 =?utf-8?B?dEZKQUNnYjZOVldtYzlVN3ZIMVdORTNQQlVrQXY0aGdhMDUrWC9janU2SVlT?=
 =?utf-8?B?UTRhL3RRZ3JyRis4Q3lpdjBEREY1U1hLQXltZGVKQlQzQjFqb21OMHJHbDdp?=
 =?utf-8?B?bWdwTmIvRnFiQlF3SG1NTFpLbUpLWGlxT0YzMWg5WXV0dXkzSFdJSFEyTEI3?=
 =?utf-8?B?c2RqTGRMdlJMWjhLWk9abDQ4YlIwenNBdzZSTUxpQ3Z3YkVMejJvT3ducCtN?=
 =?utf-8?B?Mmh6V3EvV1ZzSGxhYTdmK29palNxRHVQY0dSdUpuWXNSeER0aFFGVGxGZHZi?=
 =?utf-8?B?ZG5uNi8xd1ladDB5UDQ1WDgwd05ZbzQzNnpSdDd2TjFZcE0xNGdmOWI0b2xY?=
 =?utf-8?B?bFFZQ1BQVXBxZ1l2QXRvNEhDSlJraXNoSHBCK3d2eDRQUEdIcXZxVkVITVpw?=
 =?utf-8?B?QVVMeDNaYXdyOFZjNm00c01OeVNsZ3laYmwzWHJRdGxVcHNad2k0RmhZYVFp?=
 =?utf-8?B?Vkd2L3dEai85YjdqMFBTWnhvR3ZUMGhiMzRraXFncWVXNFZoaEYxMTc0bDRh?=
 =?utf-8?B?M1lyNzRvSE0xTnJ5aFhZVExiTlpJejZnejZDeVFKYW9XS21xS1JDeVlnT3dr?=
 =?utf-8?B?VHdwdnM5T0d0TWpVYUtxSlo3c1g4ZFphVnlHYklPWWVJZk81WGJKWXhlT1hL?=
 =?utf-8?B?bW5rUm84U2NPSEpwTXdjb2Jsbkpxc2ZiVmltOW1XK1pmbnJleHV3akIxbkFY?=
 =?utf-8?B?bWdZTVpMWExnL3dpZVNzVHZzR1ltNHlZS3ZrQ2VkYW51Q2E4ekFRQUhRMHc0?=
 =?utf-8?B?Y25hRXZjSjY3MUYxajAzKzFlR2MxODYrcTNqTjFjeTJVMmtudkFOdmNvU1Zk?=
 =?utf-8?B?bW5MaXh6L04ydHdTSTd6RnJZMzg1RlpQZVhWcC9nSHh6dSsyVFlucldzNHJs?=
 =?utf-8?B?aDFUbVpOTU5FdkVUMFFBZlBJU3JRY05iakZkRmRQR05LQUU5dVlqU3FaekxS?=
 =?utf-8?B?bHFYV2ZLWm4yM1FJTUhKTm50QjhLa2RvNHN2cHgvY3ZHUko5dWNCd1RBUHZh?=
 =?utf-8?B?cEpnVUdjTEQ5T3FrNHphUG5wbk02MldUcEJVWVk5OHZCZW00UDBEWGRHN0JE?=
 =?utf-8?B?c0ZtcjhuVmRWNzdiSUoxOGx4bEF3VkN2bzB2RmRzemxSdTFUL0pnYmgrc1d6?=
 =?utf-8?B?MFYwNDU5RmdzeFZUd25GcFFqbGg1dk90WFFLWWpHUmNuc09uN1VvT3IwK1Vp?=
 =?utf-8?Q?V+/jVtytMFhUxuH2PV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad09a7c6-5ca7-49f9-98e8-08de83f6c876
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 07:28:28.1444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UhlidDAZs4GfiGxK2a57Cr+Z6GyEvJHaeRai7u3w+aKVLjNyfP9Hpd26+KTazYHb9DvcMaKKrFqevbpIRzN8rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8371
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlh
biA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAxNywg
MjAyNiAzOjA4IFBNDQo+IFRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBQcm9zeWFrLCBWaXRhbHkNCj4gPFZpdGFs
eS5Qcm9zeWFrQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBkcm0vYW1kZ3B1
OiBoYXJkZW4gU0lHTkFML1dBSVQgaW9jdGwgYXJndW1lbnQNCj4gdmFsaWRhdGlvbg0KPg0KPiBP
biAzLzE3LzI2IDAyOjE3LCBKZXNzZS5aaGFuZyB3cm90ZToNCj4gPiBUaWdodGVuIHRoZSBlYXJs
eSBwYXJhbWV0ZXIgY2hlY2tzIGluIHRoZSBVU0VSUSBTSUdOQUwgYW5kIFdBSVQgaW9jdGxzOg0K
PiA+DQo+ID4gMS4gVmFsaWRhdGUgbnVtX3N5bmNvYmpfaGFuZGxlcyBhZ2FpbnN0IEFNREdQVV9V
U0VSUV9NQVhfSEFORExFUw0KPiBpbg0KPiA+ICAgIGFkZGl0aW9uIHRvIHRoZSBCTyBoYW5kbGUg
Y291bnRzIHRoYXQgYXJlIGFscmVhZHkgY2hlY2tlZC4gVGhlIFVBUEkNCj4gPiAgICBmaWVsZCBp
cyBfX3U2NCBidXQgdGhlIGRyaXZlciBzdG9yZXMgaXQgaW4gYSB1MzIsIHNvIHRoZSBjb21wYXJp
c29uDQo+ID4gICAgbXVzdCBoYXBwZW4gYmVmb3JlIHRoZSBuYXJyb3dpbmcgYXNzaWdubWVudCB0
byBwcmV2ZW50IHVuaW50ZW5kZWQNCj4gPiAgICB0cnVuY2F0aW9uIChlLmcuIDB4MV8wMDAwXzAw
MDAgd291bGQgc2lsZW50bHkgYmVjb21lIDApLg0KPiA+DQo+ID4gMi4gUmVqZWN0IGluY29uc2lz
dGVudCBwb2ludGVyL2NvdW50IHBhaXJzIHdoZXJlIGEgbm9uLU5VTEwgdXNlcnNwYWNlDQo+ID4g
ICAgcG9pbnRlciBpcyBwcm92aWRlZCB3aXRoIGEgemVybyBlbGVtZW50IGNvdW50LiBUaGlzIGlz
IGNsZWFybHkNCj4gPiAgICBtYWxmb3JtZWQgaW5wdXQgYW5kIHJldHVybmluZyAtRUlOVkFMIGVh
cmx5IGdpdmVzIHVzZXJzcGFjZSBhDQo+ID4gICAgZGV0ZXJtaW5pc3RpYyBlcnJvciByYXRoZXIg
dGhhbiBzaWxlbnRseSBwcm9jZWVkaW5nIHdpdGggZW1wdHkgZGF0YS4NCj4gPg0KPiA+IE5vIGZ1
bmN0aW9uYWwgY2hhbmdlIGZvciB3ZWxsLWZvcm1lZCB1c2Vyc3BhY2UgY2FsbGVycy4NCj4gPg0K
PiA+IHYyOg0KPiA+IC0gUmV3b3JrZWQgY29tbWl0IG1lc3NhZ2UgdG8gZm9jdXMgb24gcGFyYW1l
dGVyIHZhbGlkYXRpb24gY29ycmVjdG5lc3MNCj4gPiAtIFVwZGF0ZWQgY29kZSBjb21tZW50cyBm
b3IgY2xhcml0eTogZGVzY3JpYmUgdGhlIHR5cGUgd2lkdGggbWlzbWF0Y2gNCj4gPiAgIGFuZCB3
aHkgdGhlIGVhcmx5IGNoZWNrIGlzIG5lZWRlZA0KPiA+IC0gTm8gZnVuY3Rpb25hbCBjaGFuZ2Vz
IHRvIHRoZSBjb2RlIGl0c2VsZg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmVzc2UgWmhhbmcg
PGplc3NlLnpoYW5nQGFtZC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFZpdGFseSBQcm9zeWFrIDx2
aXRhbHkucHJvc3lha0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV91c2VycV9mZW5jZS5jICAgfCAzNyArKysrKysrKysrKysrKysrKystDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9m
ZW5jZS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnFfZmVu
Y2UuYw0KPiA+IGluZGV4IGZhZDU5NTQwMWE3Ny4uNTc1ZGQ1OGVkMTUyIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jDQo+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMNCj4g
PiBAQCAtNDgwLDggKzQ4MCwyNSBAQCBpbnQgYW1kZ3B1X3VzZXJxX3NpZ25hbF9pb2N0bChzdHJ1
Y3QgZHJtX2RldmljZSAqZGV2LA0KPiB2b2lkICpkYXRhLA0KPiA+ICAgICBpZiAoIWFtZGdwdV91
c2VycV9lbmFibGVkKGRldikpDQo+ID4gICAgICAgICAgICAgcmV0dXJuIC1FTk9UU1VQUDsNCj4g
Pg0KPiA+ICsgICAvKg0KPiA+ICsgICAgKiBudW1fc3luY29ial9oYW5kbGVzIGlzIF9fdTY0IGlu
IHRoZSBVQVBJIGJ1dCBzdG9yZWQgaW4gYSB1MzINCj4gPiArICAgICogaW4gdGhlIGRyaXZlci4g
IENoZWNrIGFsbCB0aHJlZSBoYW5kbGUgY291bnRzIGFnYWluc3QgdGhlDQo+ID4gKyAgICAqIG1h
eGltdW0gKmJlZm9yZSogdGhlIG5hcnJvd2luZyBhc3NpZ25tZW50IHNvIHRoYXQgdmFsdWVzDQo+
ID4gKyAgICAqIGFib3ZlIDJeMzIgYXJlIGNvcnJlY3RseSByZWplY3RlZCBpbnN0ZWFkIG9mIGJl
aW5nIHNpbGVudGx5DQo+ID4gKyAgICAqIHRydW5jYXRlZCB0byBhIHNtYWxsZXIgKHBvc3NpYmx5
IHplcm8pIHZhbHVlLg0KPiA+ICsgICAgKi8NCj4NCj4gVGhhdCBpcyBjb21wbGV0ZWx5IHVubmVj
ZXNzYXJ5LCBqdXN0IHJlZHVjZSB0aGUgdmFyaWFibGVzIHNpemUgaW4gdGhlIFVBUEkgYXMgd2UN
Cj4gYWxyZWFkeSBkaWQgZm9yIG51bV9zeW5jb2JqX2hhbmRsZXMuDQo+DQo+DQo+DQo+ID4gICAg
IGlmIChhcmdzLT5udW1fYm9fd3JpdGVfaGFuZGxlcyA+IEFNREdQVV9VU0VSUV9NQVhfSEFORExF
UyB8fA0KPiA+IC0gICAgICAgYXJncy0+bnVtX2JvX3JlYWRfaGFuZGxlcyA+IEFNREdQVV9VU0VS
UV9NQVhfSEFORExFUykNCj4gPiArICAgICAgIGFyZ3MtPm51bV9ib19yZWFkX2hhbmRsZXMgID4g
QU1ER1BVX1VTRVJRX01BWF9IQU5ETEVTIHx8DQo+ID4gKyAgICAgICBhcmdzLT5udW1fc3luY29i
al9oYW5kbGVzICA+IEFNREdQVV9VU0VSUV9NQVhfSEFORExFUykgew0KPg0KPiBZb3UgZG9uJ3Qg
bmVlZCB0byBjaGVjayBudW1fc3luY29ial9oYW5kbGVzIGhlcmUuDQpUaGFua3MgQ2hyaXN0aWFu
Lg0KSSB3aWxsIGRyb3AgdGhlIG51bV9zeW5jb2JqX2hhbmRsZXMgPiBBTURHUFVfVVNFUlFfTUFY
X0hBTkRMRVMNCmNoZWNrcyBmcm9tIGJvdGggU0lHTkFMIGFuZCBXQUlUIHBhdGhzLg0KDQpPbmx5
IGtlZXAgdGhlIHBvaW50ZXIvY291bnQgY29uc2lzdGVuY3kgY2hlY2tzIChub24tTlVMTCBwb2lu
dGVyIHdpdGggemVybw0KY291bnQgLT4gLUVJTlZBTCksIHNpbmNlIHRob3NlIGFyZSBzdGlsbCB1
c2VmdWwgZm9yIGRldGVybWluaXN0aWMgZWFybHkgaW5wdXQNCnZhbGlkYXRpb24gYW5kIGRvIG5v
dCBjaGFuZ2UgYmVoYXZpb3IgZm9yIHZhbGlkIHVzZXJzcGFjZS4NCg0KVGhhbmtzDQpKZXNzZQ0K
Pg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+ID4gKyAgICAgICAgICAgcmV0dXJuIC1F
SU5WQUw7DQo+ID4gKyAgIH0NCj4gPiArDQo+ID4gKyAgIC8qIFJlamVjdCBub24tTlVMTCBwb2lu
dGVycyBwYWlyZWQgd2l0aCBhIHplcm8gY291bnQuICovDQo+ID4gKyAgIGlmICghYXJncy0+bnVt
X3N5bmNvYmpfaGFuZGxlcyAmJiBhcmdzLT5zeW5jb2JqX2hhbmRsZXMpDQo+ID4gKyAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gKyAgIGlmICghYXJncy0+bnVtX2JvX3JlYWRfaGFuZGxl
cyAmJiBhcmdzLT5ib19yZWFkX2hhbmRsZXMpDQo+ID4gKyAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7DQo+ID4gKyAgIGlmICghYXJncy0+bnVtX2JvX3dyaXRlX2hhbmRsZXMgJiYgYXJncy0+Ym9f
d3JpdGVfaGFuZGxlcykNCj4gPiAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPg0KPiA+
ICAgICBudW1fc3luY29ial9oYW5kbGVzID0gYXJncy0+bnVtX3N5bmNvYmpfaGFuZGxlczsgQEAg
LTYzOSw3ICs2NTYsMjMNCj4gPiBAQCBpbnQgYW1kZ3B1X3VzZXJxX3dhaXRfaW9jdGwoc3RydWN0
IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwNCj4gPiAgICAgICAgICAgICByZXR1cm4gLUVO
T1RTVVBQOw0KPiA+DQo+ID4gICAgIGlmICh3YWl0X2luZm8tPm51bV9ib193cml0ZV9oYW5kbGVz
ID4NCj4gQU1ER1BVX1VTRVJRX01BWF9IQU5ETEVTIHx8DQo+ID4gLSAgICAgICB3YWl0X2luZm8t
Pm51bV9ib19yZWFkX2hhbmRsZXMgPg0KPiBBTURHUFVfVVNFUlFfTUFYX0hBTkRMRVMpDQo+ID4g
KyAgICAgICB3YWl0X2luZm8tPm51bV9ib19yZWFkX2hhbmRsZXMgID4NCj4gQU1ER1BVX1VTRVJR
X01BWF9IQU5ETEVTIHx8DQo+ID4gKyAgICAgICB3YWl0X2luZm8tPm51bV9zeW5jb2JqX2hhbmRs
ZXMgID4NCj4gQU1ER1BVX1VTRVJRX01BWF9IQU5ETEVTKQ0KPiA+ICsgICAgICAgICAgIHJldHVy
biAtRUlOVkFMOw0KPiA+ICsNCj4gPiArICAgLyogUmVqZWN0IG5vbi1OVUxMIHBvaW50ZXJzIHBh
aXJlZCB3aXRoIGEgemVybyBjb3VudDogdGhlIHBvaW50ZXINCj4gPiArICAgICogaXMgbWVhbmlu
Z2xlc3MgYW5kIGluZGljYXRlcyBpbmNvbnNpc3RlbnQgaW5wdXQgZnJvbSB1c2Vyc3BhY2UuDQo+
ID4gKyAgICAqLw0KPiA+ICsgICBpZiAoIXdhaXRfaW5mby0+bnVtX3N5bmNvYmpfaGFuZGxlcyAm
JiB3YWl0X2luZm8tPnN5bmNvYmpfaGFuZGxlcykNCj4gPiArICAgICAgICAgICByZXR1cm4gLUVJ
TlZBTDsNCj4gPiArICAgaWYgKCF3YWl0X2luZm8tPm51bV9zeW5jb2JqX3RpbWVsaW5lX2hhbmRs
ZXMgJiYNCj4gPiArICAgICAgICh3YWl0X2luZm8tPnN5bmNvYmpfdGltZWxpbmVfaGFuZGxlcyB8
fCB3YWl0X2luZm8tDQo+ID5zeW5jb2JqX3RpbWVsaW5lX3BvaW50cykpDQo+ID4gKyAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gKyAgIGlmICghd2FpdF9pbmZvLT5udW1fYm9fcmVhZF9o
YW5kbGVzICYmIHdhaXRfaW5mby0+Ym9fcmVhZF9oYW5kbGVzKQ0KPiA+ICsgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPiA+ICsgICBpZiAoIXdhaXRfaW5mby0+bnVtX2JvX3dyaXRlX2hhbmRs
ZXMgJiYgd2FpdF9pbmZvLT5ib193cml0ZV9oYW5kbGVzKQ0KPiA+ICsgICAgICAgICAgIHJldHVy
biAtRUlOVkFMOw0KPiA+ICsgICBpZiAoIXdhaXRfaW5mby0+bnVtX2ZlbmNlcyAmJiB3YWl0X2lu
Zm8tPm91dF9mZW5jZXMpDQo+ID4gICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4NCj4g
PiAgICAgbnVtX3N5bmNvYmogPSB3YWl0X2luZm8tPm51bV9zeW5jb2JqX2hhbmRsZXM7DQoNCg==
