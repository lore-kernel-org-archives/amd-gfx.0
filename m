Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C353606A31E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 03:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iGdKIpTw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DACB10E012;
	Thu, 26 Nov 2026 03:38:10 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012064.outbound.protection.outlook.com
 [40.93.195.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 058F110E232
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 03:38:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSvlwV84G2jRm7oabyoWjppVdIbBcfrusrTH/tdWLALIxSbG441p9UPVoZCLx9xkO5DCXR4g2aqvyou2PcdV1sZuGv6nT4GmbP6g6ZohTlWUbsW8Qv6QtLa6vHVfFq6040Kys5ukWUUpdkfFIHB1ejHQlsLj/RPAWPqHAtPKpjzH+BiOepoCmhGsvAMprf3ps8yH6kshoeV3uUYeymgXT6eIZjNZRZHG6MhILHGNGLvBbnvfuyTaSkSkDADeacb5FfuDkj3p6vHgRBc9f0r9hNPqMit75RC5gz+9shl/DQbfncI3404Ur2rwflAEeu8kOupH0+bqffzO9kISVke41w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OIPApvKnhAJd1pN388sYFNP23eTcVs9o/uQFivTpvs=;
 b=qZWPmFDwCV7tqJcgyLA3ug6pEui0S9EiFnhGmCezlzAKodXjnGvHyu8WE/rbtiXgzXD0+/wr+4UVrIlJHve1A/DyWvimsoBzwietP8dZAcL78nNLUdcOhb13WPGs9+hYFINlLxDOoR6tpSStsDVADz+5jMymlsLGFOENKm0+ladrdVvz0tborNgC01MZkYFFwUe3XjljrEpRkAfFJT17J+OTvicnCUkzN/KPF/eEGrP93WQOyVvtJFBk1n79D6QFYfb4kM8Bv0KM4aIDaauJ8hISOYJB4bT+7P+Xv/DdSRTy8Tz3cR4HRrlkDDCPDx9OVHbGt7XCMkrvPCpM6FFzwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OIPApvKnhAJd1pN388sYFNP23eTcVs9o/uQFivTpvs=;
 b=iGdKIpTwoGFodW144suq8RroKDGWauuIhfP8DhzbpQcVgz6Y9IdJ36J5kWwHXSdkm0IrSkO6Q8DYty8YIHzpCbMEPT71izc7HSVzw4fvRwJv6DrzVAmRx+9blxF7SQbTN02is7AALrj2X8DjP4B9Eq+Xn43JA9V179zG3ST/b0o=
Received: from MW4SPRMB0025.namprd12.prod.outlook.com (2603:10b6:303:18f::13)
 by SJ1PR12MB6290.namprd12.prod.outlook.com (2603:10b6:a03:457::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 03:37:59 +0000
Received: from MW4SPRMB0025.namprd12.prod.outlook.com
 ([fe80::8743:fbd4:589c:9ed3]) by MW4SPRMB0025.namprd12.prod.outlook.com
 ([fe80::8743:fbd4:589c:9ed3%6]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 03:37:59 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?utf-8?B?SmFrdWIgT2tvxYRza2k=?= <jakub@okonski.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: allow dispatch tunneling on GFX12.1
Thread-Topic: [PATCH 2/2] drm/amdgpu: allow dispatch tunneling on GFX12.1
Thread-Index: AQHdcgKaS3CyEIvxIkS76mWgjlJN1bc/yXkQ
Date: Thu, 26 Nov 2026 03:37:59 +0000
Message-ID: <MW4SPRMB002512C807FB91C614F27E62FB422@MW4SPRMB0025.namprd12.prod.outlook.com>
References: <20261111173146.3157865-1-alexander.deucher@amd.com>
 <20261111173146.3157865-2-alexander.deucher@amd.com>
In-Reply-To: <20261111173146.3157865-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-26T03:32:21.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4SPRMB0025:EE_|SJ1PR12MB6290:EE_
x-ms-office365-filtering-correlation-id: b4a0a16d-c816-4176-6d5a-08df4b6eaad9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|10067099003|11063799006|56012099006|4143699003|261009223027099003|261021121427099003|261021123027099003|261102123227099003|18002099003|22082099003;
x-microsoft-antispam-message-info: mi8GSwZ6IWG5ZA8mf0BKlMjjKaonhhm7zgQPLIt6f9cMI4rQPxtr7YDn2PO0876o7bIK+tGZoU4HO3Y53e2MRuzLOHrDOG1YmYmdeW7ad/gppqYVtpSrCBpr5dBaqdpcczg9MAZMgXWDOjBbu8C/EQswd6PEnQ0SUMzmVYeUYSD+BXJayLg54Y77iIfGwdj1ugzMLlpHBkTP3c2vRJYXqXRgXbOkZmi9Kuj6A8X93eSX0Ofgw3w83+MZonV1Xj0KjQG/4kZiqcngJs7C+MrMkfI90TV6Zbi9//KlU9Gg6LeKnGihJKktRwReEnQaS4T6K4oE+wGn7jmXGKznw04wHRrz7xE2NlgnmtN78WTII8Oc51Jd5mb+d/tHWrecLCCAf930CjtEB5ezBCVX+Nvs5fQJjG+hQMc1ZVkrPPChzHJlynL94DNwl6s4/JNtamLRIYcwwzkyW47h1eqmfFElzrS9W80748hq+4smyXgM2nRBT3MXJ+EAYcnKVx//aViruvMb4xNijSdz4wsFu8nJOeuYJugJJl06XVWLWVJQ+FcttZFZgvAx7ciMaVqoE45uVjnfK91DvPL5JsVFNuyxrIbl6HEmDjgdcPntKRmcjYOJ9Utyzm0dmsNtShD4DNXi+klnJChOYraeCrHznZiykz/Dsl1JRHBzHtiUfLotJgkz9RKs7peRlEJ6aLL5BgdOeB4ZQIN74Bnbh+bYIUFytA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4SPRMB0025.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(261009223027099003)(261021121427099003)(261021123027099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWMvaFRPdDRMQmIxRzZjL2duamQ3T2djb05XWUpLRUJoTStRZEI4bGpwSUZx?=
 =?utf-8?B?YmU4bUhsRFZheGo1MzlXKzJZV3JXaGtnUzY4UXE0ZzF1SzhuaytHT1hJUUJp?=
 =?utf-8?B?TGd3V0hiZWhISEtQcDREaWk1YzdYUXB1QVVXelk0WFhOYjlaS1VQVit2dkJh?=
 =?utf-8?B?WWZyTGpUcThZU0g1N0dneTdZZVRMcEdwVUcxMWp4eTR6UFVCTXY3R3RFM01N?=
 =?utf-8?B?WmwzckdMR0xnWnkwb0J2OEpnTzEzQ1VBUE56ZlBCbGdNRnVYNkNQeEVSUUpm?=
 =?utf-8?B?NFd4OXBvdEZVUDVSaW1LMERjaXlnbG1GcUtXSkVFaEs0SXp1bWp3azBneGNi?=
 =?utf-8?B?MXg5TVNNVmN4WTRoUk1mZnd6eFdCck9tYTIyeng4ZDNBTXl1aG0xenlyNVJo?=
 =?utf-8?B?Rll2bnoxMHAwanRQL20rdE56aXZGcGVhQkNKOFdJNDhZeU5YTlB2ZXo5ejZr?=
 =?utf-8?B?Ym9kYmtTVE9FQWdvNDh3VUpRbHNqR0ZZVnhOd3l5dC9QbUFEVzB6VTN6K0Vy?=
 =?utf-8?B?Z29qWnNEcHU1S2toS2M4ZzFSYWE0aFZ3YVh6bVZlM1N1RnlOQk9GVW9tWUF2?=
 =?utf-8?B?c0xDWExhZnkxdGdvcXRKNEovTVZFSllrdkNMdDJMU1QwcUFubmlhcWVINFI5?=
 =?utf-8?B?Nld3ZEVXWkVBV2FGUWIwUURMNzVpd1lVNmpyaUQ4VXRsQzErNHBvYXpxdmJz?=
 =?utf-8?B?Y09TTEt3d0xaV05XdkFVaDgyWU8ramxrZVdvUUNtRmxPekwwb2pNQVoraVJD?=
 =?utf-8?B?ZEtDcmtnd0YyM2ZDUEJYTlpZNWlpWElTekx1Q0tqNEVBMW5zT29ZL2IxMUk3?=
 =?utf-8?B?V0dxYWZjcDZEUmZ6ZGpNQi9pdEZwakhDd1BDdWhjQmhTeDlmTW4wTDUrNjdZ?=
 =?utf-8?B?Z2tZaVdDRkJqQ210d2REOVl1MC9DdkN2Unozc0ZOTTNWVlJwUnN6UFl0dEZq?=
 =?utf-8?B?Z2xxdjhXZEdLczR6cnB0MWozejdhWjhuNDFNKzJlei81bWxnMDVySTk4WkF2?=
 =?utf-8?B?VFl2anZSWmFNaW1LeW45empBYXBZV3hVRXQrYmE0bStObkpweXF4N3l4dlZM?=
 =?utf-8?B?Vk1CcHRvci9HWmRQYUhmcXRVNjYvUVRDODlvZnFTdk56a2hXd0hXQXFWM0Jx?=
 =?utf-8?B?UzI5eUhJaEs3QVdWZkJNUzNFTFI3MGVRQnJPdW4wbzdEeU1XSm9aWkRlR2N2?=
 =?utf-8?B?dWc1dGxFa0U0a1hHUkJCUHNsVmtJVEJ5dXNZYmJhd3JpK2ZBQVVLdDRGM29w?=
 =?utf-8?B?a0cySVZibUMzQkdwYUdtMWcrMENWTGpYR3gzVWhGUG9BdnowSFZHdjROa0dt?=
 =?utf-8?B?SUhxTW9pVkV3WjdhNjVYSXBQL1NUV3hHY0FrcXV2SlhtZXJSUjZQZnpIQnlq?=
 =?utf-8?B?aWlDR0RsZGZtV1BOTGY4VlJCSGRuTFRxaktXYXVQWERGSXFJdnA4U0htMGdO?=
 =?utf-8?B?ZWlWSEpORkpQUHRiaUhVdisvQm9NYlNXeWUvbldwMk9WSXRVcmRmbUJTQVhL?=
 =?utf-8?B?OHZHZ1lsbGE5a2lXYldtc0xDekpROTA4ME1oa0RWYndXM29zOWdFTG9yM1lV?=
 =?utf-8?B?UnBNSmMwS0pqUUtJN1c2WS93akZxUU1SQ1g1VWVrWHBjT05YVGx0Y2NRZnhu?=
 =?utf-8?B?RTFkOGIwdUJkOUVkOFJ2Z2xLMmZ3QUFIZmpkUDJtNkx4Ry92dHo5dzZSR2Uz?=
 =?utf-8?B?N1R2Zm5TRWxUOWJHZjZ2STVQSmk0enlvWVd2Qko3V0JWWm96NE1Tdi9hSTN5?=
 =?utf-8?B?UlMySU05dGhwbWJnUUQ3RGtib0x1MGJqcE53ZzN1bHJoc3FMbTA4WHd5ajZQ?=
 =?utf-8?B?QjFDSGhBL25IQmZPTk1udG44c2ZaWENESUk5cDJYdy9OWWpNSWtOeUhBL25o?=
 =?utf-8?B?ZmMyOEFUREFRNUFGVEM1RWpTSUFIdUhUNStHVDBySWhKL05UVG04SUFYK01T?=
 =?utf-8?B?TjZCNFNML2tqS0dPbUl2c25YcWpYM1lHVUlQSHVQVVBxUGhyRnJ2N0NKL25E?=
 =?utf-8?B?VmY2YmEvdVFsa0R4cVAwYkQxTkdJUVN3dG1MNll1aXFraDJGcFJ0ZDVvbFdZ?=
 =?utf-8?B?bVp3K0toZjJMK0h2VXF0TFZxTzkvWnBHaDdMNllkVkwyWnhaZUx6L2RydTl5?=
 =?utf-8?B?dkI3cHhiNStDbTJlNTZ6eEJrZERiaGU4OWZhWm9RMmRmaVdYcEwyUm14ZUQ1?=
 =?utf-8?B?Y294dks5cmhqU3hCYzUyMzFOa2M0R2pWRmZLOEVwVkI3UWtXc0VJalhtcVRn?=
 =?utf-8?B?Tkc3eHBPdjFqMWozMHgwZVNhVWVwSW9KeE1pdnRrRUlZSDlrWERoYWt5UDE5?=
 =?utf-8?Q?pAhPOoIk4kZGtezxfZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4SPRMB0025.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a0a16d-c816-4176-6d5a-08df4b6eaad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 03:37:59.4059 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8/pAAPVIu71NfiCbJu39ySjppeSqHPdqI8F7wWz6Ln+9bzrCIRQAkDmI3j35BTv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6290
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

QU1EIEdlbmVyYWwNCg0KVGhlIHNlcmllcyBpcyBSZXZpZXdlZC1ieTogUHJpa2UgTGlhbmcgPFBy
aWtlLkxpYW5nQGFtZC5jb20+DQoNCkp1c3QgY3VyaW91cywgd2FzIHRoaXMgbWlzc2luZyBzZXQg
Y2F1Z2h0IHdoaWxlIGludmVzdGlnYXRpbmcgYSBwZXJmb3JtYW5jZSByZWdyZXNzaW9uPw0KDQpS
ZWdhcmRzLA0KICAgICAgUHJpa2UNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBC
ZWhhbGYgT2YgQWxleA0KPiBEZXVjaGVyDQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAxMiwg
MjAyNiAxOjMyIEFNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzog
RGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSmFrdWIgT2tv
xYRza2kNCj4gPGpha3ViQG9rb25za2kub3JnPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMi8yXSBkcm0v
YW1kZ3B1OiBhbGxvdyBkaXNwYXRjaCB0dW5uZWxpbmcgb24gR0ZYMTIuMQ0KPg0KPiBXYXMgaW1w
bGVtZW50ZWQgZm9yIG9sZGVyIGdmeCBnZW5lcmF0aW9ucywgYnV0IGdvdCBtaXNzZWQgb24gZ2Z4
MTIuMS4NCj4NCj4gU3VnZ2VzdGVkLWJ5OiBKYWt1YiBPa2/FhHNraSA8amFrdWJAb2tvbnNraS5v
cmc+DQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1k
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEyXzEuYyB8
IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEyXzEu
Yw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTJfMS5jDQo+IGluZGV4IDFm
NTdkMGZhMmMwNDQuLmVmNThhMTAxNDZlZTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92MTJfMS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92MTJfMS5jDQo+IEBAIC0yMzA5LDcgKzIzMDksOCBAQCBzdGF0aWMgaW50IGdmeF92
MTJfMV9jb21wdXRlX21xZF9pbml0KHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2LCB2b2lk
ICptLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgIChvcmRlcl9iYXNlXzIoQU1ER1BVX0dQ
VV9QQUdFX1NJWkUgLyA0KSAtIDEpKTsNCj4gICAgICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAs
IENQX0hRRF9QUV9DT05UUk9MLA0KPiBVTk9SRF9ESVNQQVRDSCwgMCk7DQo+ICAgICAgIHRtcCA9
IFJFR19TRVRfRklFTEQodG1wLCBDUF9IUURfUFFfQ09OVFJPTCwgU0NPUEUsIDMpOw0KPiAtICAg
ICB0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgQ1BfSFFEX1BRX0NPTlRST0wsDQo+IFRVTk5FTF9E
SVNQQVRDSCwgMCk7DQo+ICsgICAgIHRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBDUF9IUURfUFFf
Q09OVFJPTCwNCj4gVFVOTkVMX0RJU1BBVENILA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
IHByb3AtPmFsbG93X3R1bm5lbGluZyk7DQo+ICAgICAgIHRtcCA9IFJFR19TRVRfRklFTEQodG1w
LCBDUF9IUURfUFFfQ09OVFJPTCwgUFJJVl9TVEFURSwgMSk7DQo+ICAgICAgIHRtcCA9IFJFR19T
RVRfRklFTEQodG1wLCBDUF9IUURfUFFfQ09OVFJPTCwgS01EX1FVRVVFLCAxKTsNCj4gICAgICAg
bXFkLT5jcF9ocWRfcHFfY29udHJvbCA9IHRtcDsNCj4gLS0NCj4gMi41Ni4wDQoNCg==
