Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C856C77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 09:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA7FC10E350;
	Fri, 19 May 2023 09:47:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 545D210E350
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 09:47:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laoCqsocJ+ruzINhp5LwC7hxu1QvBy5IjdIx2QFpe6Xd6mEYKCGD2hGLU99OIOEcFnAghvmg0KdxLwQ1osQCjmrrD8ZuGLPpLphjbPcwWhXcCwBgPlN3YAY93FnQ938NoHpAkJQgp+iwrDpXu7zdAzAZv265evlwYvjjj0HeNY4pyoWXEq32vGnz2ez48Y/06XV7rWW9kJ00MTg3NXeKDElCTlav9XYWSFwHur0JvwbrNev26kIrlJuDu89dP/OBPsWCUkPWt2VvT5c0VfxNzErgrldB0oJBw454J1RqsiNv++edGLyuf+yJZ4xEwYPTi0oc8D+s/2OyOuVR+UMArg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuD7JWQQckstH3vvwyl1o3qvEvDDrh7njxCjgWRjWF0=;
 b=KbQnYjFx2x+qR3iotOkb29at17xeLZgU3V8iRlBoGOOW/UmuVXHyO6W+ss56eey0RFGtGWr+5NLvduc/Rkt+0yAavv1oKpAPvoAasmjrZBhHWAm366AFDWx2DKRrET1m23T6JW4CNqcTEsG0lMTcL9BUA9nL6FujnEZWKMmIFsN3RZEsl38AceQwyx2khCgoJUYec8252HWpIvLztje/bY6zY93xx6rj/eXFFYESB4QyhGtyXV6bjzUtNkV/JEqDRtleYBZBHAYHgvux6IGwEo7UAtC2BbxLAUILOTsMfZyonrlxRfS57RPwS5tw5J25JEvVkF3qvV/k7eVA4p+L1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuD7JWQQckstH3vvwyl1o3qvEvDDrh7njxCjgWRjWF0=;
 b=q7eHBiT59/7yJcxJDH6YgiAGk1xWXTRpGi05AirjUzWyoyZqcpTxrRYYP1IE9cWqwAazgbwAYX7iel7eKMffJ7bAKlKv0SLKbGJHac6Fw3lRoMGS7gXp593dxcUlv/B3dm7j1Y+pjxQXQ4CyDxD4qcVbxFHpU/j/ag/t70S9pA0=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 09:47:55 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 09:47:55 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix uninitialized variable in
 gfxhub_v1_2_xcp_resume
Thread-Topic: [PATCH] drm/amdgpu: Fix uninitialized variable in
 gfxhub_v1_2_xcp_resume
Thread-Index: AQHZig6KdNb6ohxxPUKgM2nIw3sPYa9hWb0g
Date: Fri, 19 May 2023 09:47:55 +0000
Message-ID: <BYAPR12MB4614435B7E8C005A841935C8977C9@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20230519045751.4189311-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230519045751.4189311-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-19T09:47:49Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c363f23e-91f0-4a7e-9e95-d424950835aa;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-19T09:47:49Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 48e4fedc-d176-4ac5-89a3-ced796fee9b7
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|DM4PR12MB5311:EE_
x-ms-office365-filtering-correlation-id: d7251afa-251f-4e92-2a91-08db584e1ece
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dbVcukdwtS35bXiLURjfJiwX9D7moyJu1+kvMD9s8BWWq68ha3aOmVo4EUfw8wTR/FIfNhvEZ8IIFLvel3fniM9jkhOTvqg1RtEjSX/D6cUyblQYqcJxMjWhuLGMXMYku2SjN4fQp7N+lOaNoOG4jvmYLtAWzUOx54gJDOA7l+557CcTVvgFlh5eqaBG5v1QLFPUqXB/4ASdTpqZeP4eI+wDgtiCw1GoBVnbqh2NKn9aNINx8BJTEoW1PR9+jsfPVLnPB3cM+J6LDLcpLDFTkbMyexS2MOubff+/rbzIv9E1KlhYCH8+tisygTtKRptB9vh/OLeAkycQGzJCaYUh1RaXKgH8WbpjTaDorVoFb/MJ8x9fgVTvbhOc5iwOaPX+F1gbgzxtQ5MpC9hD4GQA+Wadcs81xfthYDl/1iKCjMuxOUznqAMKb+VtHpRnd0AV5Zp/5b1M3rgUnHiUyzbr/HZUMN/KH01P1Eje3f8HXCjeJEQQNkp1BM1wCXQs8qbNkIdLwH7cinx4ixhtLukK9r6MZ7X2qRcKhD7DKc8dU1yyy+1vBkRkbaMJfepVa7RKvas2wXsKzFQB806A6sLovvXZ1x9jOJm4UNoppxQR6TCHOPNzP3Tg+UQDMyhtFE2P8ru0k7uov4rSJ8rbuKdXuA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199021)(6636002)(86362001)(2906002)(33656002)(55016003)(8676002)(26005)(8936002)(6506007)(9686003)(53546011)(5660300002)(186003)(7696005)(52536014)(66946007)(110136005)(316002)(76116006)(41300700001)(66446008)(66556008)(64756008)(66476007)(478600001)(38070700005)(71200400001)(921005)(38100700002)(122000001)(4326008)(66574015)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUJXcnEzVnJoVnpaSnhjUjNoUSs5eWFjQXk4cWd2Y2ZBbDhXbndXZjdxYkE2?=
 =?utf-8?B?cklIYlRYNnNoZ1FreHM1TGJZMG4zblE0bjVURDhwbjJRRHlaWGVNaENqVkJn?=
 =?utf-8?B?bHZpNGVpMVdLY0JQNkdrV0JKenNJMDFicVFaRFl1bG5JRVU1NU9KeGRZUkts?=
 =?utf-8?B?UEJ4dVMyWTRhYTVsT1VvOW1sb2x6ZW56YXF2SVFPWFpkbk9YTEZ5NDJNOFF4?=
 =?utf-8?B?MEJxVmVOazgvMndkVE94VDNJdVNKRWs5cUl4anhVQWRyZ0ZNb2VzbmNFZUQv?=
 =?utf-8?B?ZlFsYktqZ1hoVVgvQlVlNTNjZG53QjZFcmNEYnpYTE96K0dINFlxS1BFZCtq?=
 =?utf-8?B?ZjVUZkFXclBmNnNXQTYvYWg0cUsveU45a29tc0wxT3FOd0pQZUxSYURiNzhN?=
 =?utf-8?B?VEFuQWFPbi9SZmdmS3F6blBOdjU5QTRQVFpCVnMyUWlFUEtuVGN0MnpWd1Rj?=
 =?utf-8?B?U3hxMy85RGVXYTlzTlYzS2RJbWJETjFnM29DeHpTbjZudm05SitzdGM4N3Ro?=
 =?utf-8?B?a0ZKYko3S0UvWmR2dUdBdk9oSWZ5bzhRd3JmdVF6OG1CZ0c1ejNxV0RyQ1lI?=
 =?utf-8?B?eGZOd0tUZm4zU2F6RW9sbXNFaFpaeUlUd1RURU8rc2tyUWVhelpKM281eWFj?=
 =?utf-8?B?RUY1TmFodi9yMVlpM0tuOHNYZ1dyZ28rSXhLMk9FY21Oc0UvQXZ2NzVkOTIw?=
 =?utf-8?B?c0tJZ3lRVFZ6NkVmUzlkdU9JSE5QZEt3M2FmZ0RBZXdhaHhOOHJBME5YNVZJ?=
 =?utf-8?B?cU9zdzlKSWpLRk8yV3g1VmdOU29wYktLLzNaZFFPUkt1RlpZd2U4L3BabERz?=
 =?utf-8?B?MHJDTFZXN2FxYlhPVFBuRm1qVnNNaXZjbXNqdTg4Yld0R2FydjBzZkxIRWJ5?=
 =?utf-8?B?TjFFME9KQ2d4QmtEb1Vzd3EzT1ZPVlFILzRqUkZsUVc0MktweGJpbGJMNzdD?=
 =?utf-8?B?ZnE0UzJqbm42SjJoZHB3MTNUUmRWQlhYMURDNC94L1B5aWNBS3dUR2tqNHhN?=
 =?utf-8?B?ajVjVnpMUHFkdy9SbnorWjBVcnlDSHh3dm5kWlRRbjE0YWphZDA0UzdhQ0pV?=
 =?utf-8?B?SmZxSGFKZ0JtcHk5UDh5dEZOQ2drT0hJSWF1K2d3SW1jNG9HTEc4NCtxaG1n?=
 =?utf-8?B?R0NLNnpaYTQ5ZmRIdTNyUkptMjFzemlRVjdpQmNLeTB4dE1tODdMNWs5QTY3?=
 =?utf-8?B?R2RIOWIxZCtSUjhCNHlyb0VxTWQrL3pDZGI0dktRd3AzcnhZMjQ5OGFBTm1D?=
 =?utf-8?B?eXd4K0FFV1pjWjdNbXlzZEluZ2lPWmc2b0JldlAyMDVjUFpFOUVrNDJlQzhU?=
 =?utf-8?B?Qko1b1hSVjZUcG9BcDk0VEZTZkk5N1ZaYkhtV2pGMXpqaFRBMDN4SEZmWDZO?=
 =?utf-8?B?L1VyYzRMS0tWL2tLQjlnVCtwcEFvSlpibXFBYmQ1dDgvcGN0RGZJYW1pSWFZ?=
 =?utf-8?B?YmhVanlPTjlBR0Zxalc1Y1QxcmRVZ1dwVmh6K2NYQTcvU1VKaFhGZi93a0Fo?=
 =?utf-8?B?OURsa3EydUxYeVFWdUtWbU1jdld3ckV6TnF2VzBJNDdvZTNVUmtCSEV2Lzli?=
 =?utf-8?B?NThFNjdwNEpXeVhzbDNxcWJxMlFyaVZxTW9BcFhadEpUTDZNSFk4K3BXOXFZ?=
 =?utf-8?B?cmhVdGxlZjkybjV3VDY4SjhEcW80RDBlUkZUemtGSU4xVk5wd3A1SFJXQUR3?=
 =?utf-8?B?dHQ0OFRsdXNxVGFjYmVhTjdhK0lpSzFmTkJqS0htSFNoMCswRWJmNmpSak9v?=
 =?utf-8?B?Sm4wQk1oeE1ha2J0ZVdZbzBycUJaUmJ4MlN3c2l5VzZ6MVNQcWgzVGxBVm43?=
 =?utf-8?B?aXBXZHBVdXhSNFl3dE02Y1pyektrOCtHVjZueXNmdGNCZ1ZKVDFGNzdxaE1J?=
 =?utf-8?B?dHlTblg0Y3oyZ1BCK0hvbldWQTNNMGNQU21zWW44cG9aZjUweWdHTnNwS1Q1?=
 =?utf-8?B?Sy8yN2dyb3VuenpJZ0NlRGRaeER3SUlFQzZvQTAreVhvZWhBcmE4bHNBUFRT?=
 =?utf-8?B?SWtWQ3dWOS9odTJCcVpvOUttemU1dC9MMHF0Sk5rT2l6cHVVbnAwNmxreXcw?=
 =?utf-8?B?aUxYakxyWDdSdmo4QVVVSTY4Ujh6MHBCT0pSKzlmZnFEUncvYTVsWUV5WVND?=
 =?utf-8?Q?v1yI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7251afa-251f-4e92-2a91-08db584e1ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 09:47:55.0533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RVNCWqem8Mqxd1ldrUeWL7N9xIKExr9zDDY6+l1JLbEz0rSd4AnBb4lzqxLaLvsg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5311
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBMaWpvIExh
emFyIDxsaWpvLmxhemFyQGFtZC5jb20+DQoNClRoYW5rcywNCkxpam8NCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5T
SEFOTVVHQU1AYW1kLmNvbT4gDQpTZW50OiBGcmlkYXksIE1heSAxOSwgMjAyMyAxMDoyOCBBTQ0K
VG86IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVy
LCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBUdWlrb3YsIEx1YmVuIDxM
dWJlbi5UdWlrb3ZAYW1kLmNvbT47IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+OyBa
aGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1V
R0FNQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCB1bmluaXRpYWxp
emVkIHZhcmlhYmxlIGluIGdmeGh1Yl92MV8yX3hjcF9yZXN1bWUNCg0KZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4aHViX3YxXzIuYzo2NTc6NjogZXJyb3I6IHZhcmlhYmxlICdyZXQnIGlz
IHVzZWQgdW5pbml0aWFsaXplZCB3aGVuZXZlciAnaWYnIGNvbmRpdGlvbiBpcyBmYWxzZSBbLVdl
cnJvciwtV3NvbWV0aW1lcy11bmluaXRpYWxpemVkXQ0KICAgICAgICBpZiAoIWFtZGdwdV9zcmlv
dl92ZihhZGV2KSkNCiAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCmRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeGh1Yl92MV8yLmM6NjYwOjk6IG5vdGU6IHVuaW5pdGlhbGl6
ZWQgdXNlIG9jY3VycyBoZXJlDQogICAgICAgIHJldHVybiByZXQ7DQogICAgICAgICAgICAgICBe
fn4NCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeGh1Yl92MV8yLmM6NjU3OjI6IG5vdGU6
IHJlbW92ZSB0aGUgJ2lmJyBpZiBpdHMgY29uZGl0aW9uIGlzIGFsd2F5cyB0cnVlDQogICAgICAg
IGlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn4NCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeGh1Yl92MV8yLmM6NjQ4Ojk6
IG5vdGU6IGluaXRpYWxpemUgdGhlIHZhcmlhYmxlICdyZXQnIHRvIHNpbGVuY2UgdGhpcyB3YXJu
aW5nDQogICAgICAgIGludCByZXQ7DQogICAgICAgICAgICAgICBeDQogICAgICAgICAgICAgICAg
PSAwDQoxIGVycm9yIGdlbmVyYXRlZC4NCg0KQ2M6IEx1YmVuIFR1aWtvdiA8bHViZW4udHVpa292
QGFtZC5jb20+DQpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0K
Q2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCkNjOiBMaWpv
IExhemFyIDxsaWpvLmxhemFyQGFtZC5jb20+DQpDYzogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5a
aGFuZ0BhbWQuY29tPg0KU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBTaGFubXVnYW0gPHNyaW5p
dmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhodWJfdjFfMi5jIHwgNSArKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhodWJfdjFfMi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3Yx
XzIuYw0KaW5kZXggODkwMWU3M2ZkNzAwLi40ZGFiZjkxMDMzNGIgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjFfMi5jDQorKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhodWJfdjFfMi5jDQpAQCAtNjQ1LDcgKzY0NSw2IEBAIHN0YXRpYyBp
bnQgZ2Z4aHViX3YxXzJfeGNwX3Jlc3VtZSh2b2lkICpoYW5kbGUsIHVpbnQzMl90IGluc3RfbWFz
aykgIHsNCiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKiloYW5kbGU7DQogCWJvb2wgdmFsdWU7DQotCWludCByZXQ7DQogDQogCWlmIChhbWRncHVf
dm1fZmF1bHRfc3RvcCA9PSBBTURHUFVfVk1fRkFVTFRfU1RPUF9BTFdBWVMpDQogCQl2YWx1ZSA9
IGZhbHNlOw0KQEAgLTY1NSw5ICs2NTQsOSBAQCBzdGF0aWMgaW50IGdmeGh1Yl92MV8yX3hjcF9y
ZXN1bWUodm9pZCAqaGFuZGxlLCB1aW50MzJfdCBpbnN0X21hc2spDQogCWdmeGh1Yl92MV8yX3hj
Y19zZXRfZmF1bHRfZW5hYmxlX2RlZmF1bHQoYWRldiwgdmFsdWUsIGluc3RfbWFzayk7DQogDQog
CWlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KLQkJcmV0ID0gZ2Z4aHViX3YxXzJfeGNjX2dh
cnRfZW5hYmxlKGFkZXYsIGluc3RfbWFzayk7DQorCQlyZXR1cm4gZ2Z4aHViX3YxXzJfeGNjX2dh
cnRfZW5hYmxlKGFkZXYsIGluc3RfbWFzayk7DQogDQotCXJldHVybiByZXQ7DQorCXJldHVybiAw
Ow0KIH0NCiANCiBzdGF0aWMgaW50IGdmeGh1Yl92MV8yX3hjcF9zdXNwZW5kKHZvaWQgKmhhbmRs
ZSwgdWludDMyX3QgaW5zdF9tYXNrKQ0KLS0NCjIuMjUuMQ0K
