Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9C8ED7B82
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 08:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CCF210E1E8;
	Tue, 14 Apr 2026 08:25:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fkGZ6udW";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9303710E1E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 08:25:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxovXmECycOyrlpYXFOV0E2LKDmJ2HJdx15Fa38VtBQ5pVlHI54Or0+JR1B3r3BUIO1G4Qb9piZNNpB7dKwSWPXFu7B+Rbcj252LLSSroq873/3yk/pT5iWLoUZk3Sqkbkyi8FhH82Jz1rg8+ed5K+rNHmGkRfGqcuViLcS3x8hHIi7WMZQua0kkuIDFYSQlHMY4lqrUgqychUVwF8sTbZoeMgzJTx+k5BPvgdnPLPI2SlWGp9OGnUj5o68hcZVajDlFv93stO/uJrfMqkcv8QTPIF2IwLgFCpaOeO+JWtvugpAztJeKvgJz2YKeaVb7H7rct6s1zAlMsS6uqV/U2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOyQPkaSZ/q+Ls78FSqTDSnT4vDT4RTmkPh8ftXohhM=;
 b=oo3PY9YB9v8sWLCjG1LPVjeTCTbVjdmn2QeZyyPhp7OGzZqobix4MmbstNfZztcxe0374pOFAuJrJ47QFD4BQ+njLM84Spj1VpHQj143hBeDgUgTQu2oswd+tSABJit5+YpcOppBU+hqgPDOvhcvP+Q+8bZKBX6A3MJ3o0vrqcjF9idlLZTkZuJ9451YB4M8/uYlNCAdmCra1trI/g0MWtIUcGaZUzoTdEqvhw2tgiCUJrPfqgvx2YMbTWGOoD4FPQ6N/WpMmaYr4YQtdYQD+P093uiPpwHbeCdnv9jsVglTFgjiKuiPW2fdhGktq0TV3jYCgnwhNm8SAd9ZiJZXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOyQPkaSZ/q+Ls78FSqTDSnT4vDT4RTmkPh8ftXohhM=;
 b=fkGZ6udWgdhGgLorjlhuAZG23fC8UCnk+IELZYrZO91a8YyRXyvAg1QFEMxRA/6RpBrKxJ7rvyjRq1vhrHOYCIuk5VTk+Gsx8649IkWMYXQEp8SkZcLkIhu3pbsXR9EiHJHfv78lQkoN8Cgwx4sYVvGoFqYgsthuZepujJYjrm8=
Received: from CH0PR12MB5106.namprd12.prod.outlook.com (2603:10b6:610:bd::10)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 08:24:56 +0000
Received: from CH0PR12MB5106.namprd12.prod.outlook.com
 ([fe80::d6a5:45a1:c314:cfd1]) by CH0PR12MB5106.namprd12.prod.outlook.com
 ([fe80::d6a5:45a1:c314:cfd1%6]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 08:24:55 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Dan
 Carpenter <error27@gmail.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix mode2 reset ACK wait and error handling
 on aldebaran
Thread-Topic: [PATCH] drm/amd/pm: Fix mode2 reset ACK wait and error handling
 on aldebaran
Thread-Index: AQHcyyf6IKf0fU21UkGFe/k9OwUrubXeN+TA
Date: Tue, 14 Apr 2026 08:24:55 +0000
Message-ID: <CH0PR12MB51067AF2AB8F8EF02E46F128FE252@CH0PR12MB5106.namprd12.prod.outlook.com>
References: <20260413092847.2324099-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260413092847.2324099-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-14T08:17:15.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5106:EE_|BY5PR12MB4164:EE_
x-ms-office365-filtering-correlation-id: 70472772-463a-4621-5e0f-08de99ff4f09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: O1hlAknQso0D43uaDAaR/0wxLI5U4OF6KtcFt93+nQRfQDOoDp4wXLXHDzkCWvSCG+gjOu7z7zdqpnWiUi1vSGvT8ZyZ0EYly48yHJLxZHp9yn7p1AR0B0yie/IZjRBzaEKXEQORoOID+RLTLF0nhMcoScp907JPihKPZpchSWHV8BBB8EZUT9/l+b4kaoDpj2cAJJvYyn/bVaWvXIW8S/bsXn0Ov5abYJ2MU4jwgQeClnqPCjSPoUqg/ovaatP3qFjMXXenaXmBSyqP9HVHT1fvYtjkPiNfQ/djiGsBMNvzThREoll7/OXYl87EVjHxdxihWVS1OeQjKp55q/soUrRMFNJBk3pgoti88ohpB7Yj+qtS0Mt6Es7E1iSSin6DPLmlqOkDaSAEqWJQd9ne84CTKTaNhBkZMiV43Pxd/FVJ12lcxByoDLxjX2SFLWv1vMeehBFp1TFJWgCsvuacwlNxTQyxWK00YbSx+XGUwDw1BLgGUKxsl+l5/iKYL1kwkAmjOVyg55Ynzcqg+Sldj7jHqCtEfr/ynDgYVQvBHV++HjY+Luaj2ajJW5XVc9z8xAO1vLgv9F8jFaldmBMcTZJxXIJucOj6f6HEWBJs/pj4DcihAK3drp52S0pvv+Wkll1EzbptDKcZBUO10UtI3XCRHBHlYQvb4TboWMta9bdX5KJOSlBhBbYDSH1pSx/U/US7DvOGez+Sj3uoXnTdeddwkHNRI23f52lGRWeRK/dlbU+OcSEgDajn+ksm74g2dCXo+8cRlVix+Q1JCjnN/kdThO0JUA/Y7zL5HeIxAP0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5106.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L01lS1NSNGV2R3ROLytwVmRuZXdjQW1URzZ6TjVxcG40UnpvYkJrUlVWR1Ev?=
 =?utf-8?B?RHV0ZE5QWkxLb0FZZithOXVPTytqaUtjcThrNWQvdEh6VWFyODRjU2FSRzVw?=
 =?utf-8?B?dk45bDEydHp3UjBMNWtERTlPOXJROFpuT1Nub2FnYmpiVHh6Nm5NTFE1SWpZ?=
 =?utf-8?B?eExaUzZmK1ZlVWRYeFhieXZtSDBTaURjUHFBa2cyempDTTlVS3N0U2VWSHhV?=
 =?utf-8?B?OS9haldxWUpmMnVUMy9uYkpIRTk0UzF5clVBd0hra1lIdy9SYTFrU2MydDhs?=
 =?utf-8?B?U2g1M2xMZC9xYnl4bkgwQnM0SkJkaHpnQmxGQ1k4RnJ1d3p2Sm52WCs5VUNu?=
 =?utf-8?B?dVhUdE9SS1kxZy9RU2ROQi9NQkUzRkw5eWpqckVlNUY4dk9LcjNqNHdqWlNG?=
 =?utf-8?B?M0t3N1NsZlZnTWVOUEtidWRRdjhnWENscXY5VDNCWm5jTTVpL0p4ZkMwOHFu?=
 =?utf-8?B?ZDJEb1dDMHE5MXp0b0F4RDRNczlMZHNsRGd3RDl4NkFSZ3p6bUVoaUhuVnNC?=
 =?utf-8?B?cVFHNjN4STMwbzhZOXdSb3JFNHAvaUc1RVZZSGxTYy9iZUVzS2tNWldiZHZW?=
 =?utf-8?B?cHc4RlBKdXphWlRUL0Rna1cxRWsvNjkxOWFRcllGOWFzRTNRZWtPaTBTK3lX?=
 =?utf-8?B?TTNidmJDN1VtcHhmS3lmOXR6ZmY0USt0QjZsZHk3V3pocW43NWE3cjJwWHhp?=
 =?utf-8?B?N0FMK2hUZk9sbjVBSHE2VWhETjFqZDdVa0Vua3A2VkJzTUhGMzNlS0Q5NW1w?=
 =?utf-8?B?aE5rdGNVMGR1TUxESkFhYlFQOGQ5S1pyd1cyV1ZqT2RlSlJiTU9nSkRJbi8v?=
 =?utf-8?B?ZkRMeVJqSmxnTU1BcW96YkduVk1aQzNvSlpoOUVQUGNlL210ZUw5bUZmc3Qr?=
 =?utf-8?B?UmhiNE9iSDMrUUFqNzdXK0FMNnlxejhva1E0bTA3VGVIRWdtV3FkTXc5NUd2?=
 =?utf-8?B?VUtLQjhrWnFMTGUrMXdqbGpIQjdyM0x5d2xCYmNHNFA5SE1ZaEtrMXQrOTJ4?=
 =?utf-8?B?RTI3aUZ5dktpV1RDQU9rNTE5a3F6MjlRUUY1VXBCU0hiVCtVV0xsNkVHVEgv?=
 =?utf-8?B?Q2VqQzRPODVGY3R2eGxJZ3NuT2NoT3RsT3dGN1p3QlE2allyb0o0K0NteW5X?=
 =?utf-8?B?UXZqTzNkT2I0MEJ5MktOVFVkZ25ZZndZV0dmeDRyc3d2cDhPbUliV1JTYkMv?=
 =?utf-8?B?N2V1VTZIRW1xZmZRT01DSmduZnVMNG5WSDFmQXpQZlgwaWFwelh0alJ0Nm0w?=
 =?utf-8?B?eW84TVRGRjRZSUZtdk9FYVFJaWRYNUcyekdVUUtrZ1BKdlZXWkZNTGJsUklo?=
 =?utf-8?B?dEUvSkZqYjR3U0c3ZDhvV21mUlRqY3J4eDN2eXZDMkNCVTdQSFZBcmdMVmZ4?=
 =?utf-8?B?enlBWG1Hb3V2QnpLZVViZzYrQmxJV28wQ0NqT2phNFpwQXFpeEJ3UWZmR2Vi?=
 =?utf-8?B?OXZ3YnFFZFZ1R1Q0QnRSTjd0UmdWTjM3b1FHYnpVeHRiaVFyZFJ2NnJNQVFF?=
 =?utf-8?B?WnZGbS9QdTNQTU5pTFFqTGluRWs4SkRQVEptNk1lRHY0eEJNQnpCTytQTW01?=
 =?utf-8?B?dUM0bHM2MXBLT2JZUENPK3NJOWVBOWRHeTdaSlZDYlk0T09neGhjcXVpOGc4?=
 =?utf-8?B?TFFvZzNacWZuZDdUL0NvNTBiMVpaeDBheU1KVlJuUmVIYURFRG9GeUZQUXhi?=
 =?utf-8?B?UHJqNHF0dTRENjdLQ1VNNTM4TWRLM1NLdW9iUW5abVdOVzR5MjBET05kRFZk?=
 =?utf-8?B?YTljTDFhRTVMWTJqK0tBdzhQTTJoM3FQZXh0eE4vZ2pnK0FPbEdkanpvVHhB?=
 =?utf-8?B?bmVqeERaMEo2eGlSTjJKMzNQTnVKblVKaHRXRS82WVhvYVJwTzd0SVdHL2Uv?=
 =?utf-8?B?MENwNnJieDBPejdGNGFtay9FQWhiRVpiczY3QXh2Z3Yxa0x1U1ZianJJdVRx?=
 =?utf-8?B?dWlVQkFnVDRxOHZ6R04rdnQ0cG9NYi91NWgxdW5pYTBxeEpHQUloUDBQc0ow?=
 =?utf-8?B?YWZ5clZVcFRZTU5ocHVybFdmZ0pRR21BTkVxejQ3NnR6L2pMdCsxN2Y3NTVq?=
 =?utf-8?B?V3pqcTB2OEtEOGVXMjRjTGFGRUt3aktZQ2Z2cW0rUytvbHZ6SmRqQ21kZlov?=
 =?utf-8?B?azZ5NTlTZXdoM0x2T0lKbUw3aTVYS2VwZk5MNElaUVcyeGw0SEVqdStoNTgx?=
 =?utf-8?B?NFN4ZjZyMEJQbWZVdE1GV0lDWXEvakZVRGF6NGpMNnNLd3hMdmgva1pCbFpF?=
 =?utf-8?B?U2xjM1JsU2JkZlNFbVpLSE94NVVCaTN3N2ZzYnFuNkY2aW1SY1FyelJPbWJp?=
 =?utf-8?Q?33AVy/M1Fro0RJyFzO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5106.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70472772-463a-4621-5e0f-08de99ff4f09
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:24:55.4728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQb58OOw8P30xas5FeqQZ86iuU5OFetU5cWFPd4lrrmwelrIQBkQ/HoidMz4QMhr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
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
Cg0KSGksIGxvb2tzIGxpa2Ugd2Ugc2hvdWxkIGNoYW5nZSB0aGUgY2hlY2s6ICBpZiAocmV0ICE9
IDEpIGludG8gaWYgKHJldCAhPTApLiBUaGUgcmV0IHNob3VsZCBuZXZlciByZXR1cm4gMSwgcmln
aHQ/DQoNCiAgICAgICAgICAgICAgICBpZiAocmV0ICE9IDEpIHsNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZGV2X2VycihhZGV2LT5kZXYsICJmYWlsZWQgdG8gc2VuZCBtb2RlMiBt
ZXNzYWdlIFx0cGFyYW06IDB4JTA4eCByZXNwb25zZSAlI3hcbiIsDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTTVVfUkVTRVRfTU9ERV8yLCByZXQpOw0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCiAgICAgICAgICAgICAg
ICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICB9DQpPdGhlcnMgbG9va3MgZ29vZCB0byBtZS4N
Cg0KVGhhbmtzLA0KRmVpZmVpDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBT
SEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQpTZW50
OiBNb25kYXksIEFwcmlsIDEzLCAyMDI2IDU6MjkgUE0NClRvOiBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFO
TVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+OyBEYW4gQ2Fy
cGVudGVyIDxlcnJvcjI3QGdtYWlsLmNvbT47IFh1LCBGZWlmZWkgPEZlaWZlaS5YdUBhbWQuY29t
PjsgTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdr
aW5nLlpoYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvcG06IEZpeCBtb2Rl
MiByZXNldCBBQ0sgd2FpdCBhbmQgZXJyb3IgaGFuZGxpbmcgb24gYWxkZWJhcmFuDQoNCmFsZGVi
YXJhbl9tb2RlMl9yZXNldCgpIHNlbmRzIGEgbW9kZTIgcmVzZXQgbWVzc2FnZSBhbmQgd2FpdHMg
Zm9yIHRoZSBTTVUgdG8gYWNrbm93bGVkZ2UgaXQuDQoNCkJ1dCB0aGUgY3VycmVudCBjb2RlIGhh
cyB0d28gcHJvYmxlbXMuDQoNCkZpcnN0LCB0aGUgd2FpdCBsb29wIGNoZWNrcyBmb3IgcmV0ID09
IC1FVElNRSwgYnV0IHJldCBpcyAwIGFmdGVyIGEgc3VjY2Vzc2Z1bCBhc3luYyBzZW5kLiBCZWNh
dXNlIG9mIHRoYXQsIHRoZSBsb29wIGlzIHNraXBwZWQgYW5kIHRoZSBjb2RlIGRvZXMgbm90IGFj
dHVhbGx5IHdhaXQgZm9yIHRoZSByZXNldCBhY2tub3dsZWRnbWVudC4NCg0KU2Vjb25kLCB3aGVu
IGFuIHVuZXhwZWN0ZWQgcmVzcG9uc2UgaXMgcmVjZWl2ZWQsIHRoZSBjb2RlIHByaW50cyBhbiBl
cnJvciBidXQgZG9lcyBub3QgYWx3YXlzIHNldCBhbiBlcnJvciBjb2RlLiBUaGlzIGNhbiBtYWtl
IHRoZSBmdW5jdGlvbiByZXR1cm4gc3VjY2VzcyBldmVuIGFmdGVyIGEgZmFpbHVyZS4NCg0KRml4
IHRoaXMgYnkgaW5pdGlhbGl6aW5nIHJldCB0byAtRVRJTUUgYmVmb3JlIGVudGVyaW5nIHRoZSB3
YWl0IGxvb3Agc28gdGhlIHBvbGxpbmcgcnVucyBjb3JyZWN0bHkuIEFsc28gc2V0IHByb3BlciBl
cnJvciBjb2RlcyBmb3IgZmFpbHVyZSBjYXNlcy4NCg0KVGhpcyBtYWtlcyB0aGUgZnVuY3Rpb24g
Y29ycmVjdGx5IHdhaXQgZm9yIEFDSyBhbmQgcmV0dXJuIHByb3BlciBlcnJvciB2YWx1ZXMuDQoN
CkZpeGVzOiBlNDI1NjlkMDJhY2IgKCJkcm0vYW1kL3BtOiBNb2RpZnkgbW9kZTIgbXNnIHNlcXVl
bmNlIG9uIGFsZGViYXJhbiIpDQpSZXBvcnRlZC1ieTogRGFuIENhcnBlbnRlciA8ZXJyb3IyN0Bn
bWFpbC5jb20+DQpDYzogRmVpZmVpIFh1IDxGZWlmZWkuWHVAYW1kLmNvbT4NCkNjOiBMaWpvIExh
emFyIDxsaWpvLmxhemFyQGFtZC5jb20+DQpDYzogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFu
Z0BhbWQuY29tPg0KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4N
CkNjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQpTaWduZWQt
b2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1kLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3Bw
dC5jIHwgNCArKysrDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0LmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL2FsZGViYXJhbl9wcHQuYw0KaW5k
ZXggMjU5ZTVhMTNjMWJkLi5jOWUwNjQ4MzkwYzkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3N3c211L3NtdTEzL2FsZGViYXJhbl9wcHQuYw0KKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0LmMNCkBAIC0xODQ3LDYgKzE4NDcs
NyBAQCBzdGF0aWMgaW50IGFsZGViYXJhbl9tb2RlMl9yZXNldChzdHJ1Y3Qgc211X2NvbnRleHQg
KnNtdSkNCiAgICAgICAgICAgICAgICBhbWRncHVfZGV2aWNlX2xvYWRfcGNpX3N0YXRlKGFkZXYt
PnBkZXYpOw0KDQogICAgICAgICAgICAgICAgZGV2X2RiZyhhZGV2LT5kZXYsICJ3YWl0IGZvciBy
ZXNldCBhY2tcbiIpOw0KKyAgICAgICAgICAgICAgIHJldCA9IC1FVElNRTsNCiAgICAgICAgICAg
ICAgICB3aGlsZSAocmV0ID09IC1FVElNRSAmJiB0aW1lb3V0KSAgew0KICAgICAgICAgICAgICAg
ICAgICAgICAgcmV0ID0gc211X21zZ193YWl0X3Jlc3BvbnNlKGN0bCwgMCk7DQogICAgICAgICAg
ICAgICAgICAgICAgICAvKiBXYWl0IGEgYml0IG1vcmUgdGltZSBmb3IgZ2V0dGluZyBBQ0sgKi8g
QEAgLTE4NTksNiArMTg2MCw4IEBAIHN0YXRpYyBpbnQgYWxkZWJhcmFuX21vZGUyX3Jlc2V0KHN0
cnVjdCBzbXVfY29udGV4dCAqc211KQ0KICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJldCAh
PSAxKSB7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoYWRldi0+ZGV2
LCAiZmFpbGVkIHRvIHNlbmQgbW9kZTIgbWVzc2FnZSBcdHBhcmFtOiAweCUwOHggcmVzcG9uc2Ug
JSN4XG4iLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
U01VX1JFU0VUX01PREVfMiwgcmV0KTsNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aWYgKCFyZXQpDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0g
LUVJTzsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQogICAgICAg
ICAgICAgICAgICAgICAgICB9DQogICAgICAgICAgICAgICAgfQ0KQEAgLTE4NjYsNiArMTg2OSw3
IEBAIHN0YXRpYyBpbnQgYWxkZWJhcmFuX21vZGUyX3Jlc2V0KHN0cnVjdCBzbXVfY29udGV4dCAq
c211KQ0KICAgICAgICB9IGVsc2Ugew0KICAgICAgICAgICAgICAgIGRldl9lcnIoYWRldi0+ZGV2
LCAic211IGZ3IDB4JXggZG9lcyBub3Qgc3VwcG9ydCBNU0dfR2Z4RGV2aWNlRHJpdmVyUmVzZXQg
TVNHXG4iLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzbXUtPnNtY19md192ZXJz
aW9uKTsNCisgICAgICAgICAgICAgICByZXQgPSAtRU9QTk9UU1VQUDsNCiAgICAgICAgfQ0KDQog
ICAgICAgIGlmIChyZXQgPT0gMSkNCi0tDQoyLjM0LjENCg0K
