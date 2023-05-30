Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389FDC77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 18:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BADC610E3ED;
	Tue, 30 May 2023 18:53:22 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7862B10E3ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 18:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBLh9E+6X1fgkCuWI5t0dMTDl3O0g6J/cA9bcT5HgD887UAJfGNbU+qSyIPalK4zZkod5K67zpdZK62A1LLdjLbB8OVwjJvf+ut6OjJr5tH9mUi4KSj2OIw1mb+n/e5nmGacq3sc7KZqy00d7br7FvjwmBn/zR8efL+1d/aSqceHmGaYqsg+wQdwtZoulJyF2SPzwknuxe9H3oQjrlOGQ1NTYtu7ramGKDXgvzSVj8++b0PReUrru/3DvQY0SBPW1/dxaTtf8SG0l+EZJqwmj8dxSHxuqlbojGpnkVhEAo4D/ULMOOThHxFlecHZfE5IxPYFJGAgqes/DMR6HYcXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6X1wZs4ZzCC6cYNqnDiP2NxPbfMZfh9PQpXjT6Ythc=;
 b=PbXKFTmds9qt08UAeFifMXlj74ZWbzio2aT4yJLiX/x9VNQftcxExtmtiJqG2cu6k5lXioQ++UgKWCO9ucmY8pC52fSg/aYo5c20J5A0EjpVuU5UJx14FPThoVtiQSce+adZQotX2GJdJ+ftl/sBhWrHcKtMqZVxoq9/uVZ3II6q3NWZaWIc6h2Y8Y3NvXaLEOkzaLLVRVx60qAIs+rQ2StpbGNiSFWfIo10k5NJRh1tj98Ff3iDN8wPIFoQ0iMJP73Pn32t04M2DTL5/UQ7V65yWOrv0aiPrPQtoRoanddXxmuFC0Imbt6Aa0U2yZzDAmyk7KUC+YZ4WC+IkxobTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6X1wZs4ZzCC6cYNqnDiP2NxPbfMZfh9PQpXjT6Ythc=;
 b=hxW8CEISGdUk81fYb9HCusdFq7JUKL6E7QWcQh9okVkkwW+ea5h+bglCwtoSfRr8dahPbigVYasCIg/kVraHpd3TEgc37OzzzSkGu8mlaBoSsenuksEmoMCeX6WWZWgIynfr4gZQP41j262L3mouFvU4ySBw/H8mQu1nbZR56P8=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB6724.namprd12.prod.outlook.com (2603:10b6:510:1cf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Tue, 30 May
 2023 18:53:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 18:53:17 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: =?utf-8?B?UmFmYWVsIMOBdmlsYSBkZSBFc3DDrW5kb2xh?= <rafael@espindo.la>, Alex
 Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 1/2] drm/amd: Disallow s0ix without BIOS support again
Thread-Topic: [PATCH 1/2] drm/amd: Disallow s0ix without BIOS support again
Thread-Index: AQHZkx+fEuCfTGHpmkuMETcUQUBT869zH0GAgAAATXCAAAPzAIAAASeAgAAEc/A=
Date: Tue, 30 May 2023 18:53:17 +0000
Message-ID: <MN0PR12MB61011D936800A8CCD4E9E41BE24B9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230530175301.231070-1-mario.limonciello@amd.com>
 <CADnq5_M8XdDsyn0q-mM4CfFoMHH6g54VP_SG4cNztEYAwwB_hg@mail.gmail.com>
 <MN0PR12MB610183E9EC20D68FE3670D24E24B9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <87ilc9acyl.fsf@espindo.la>
 <MN0PR12MB61011F391B26F7AB87D30D99E24B9@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB61011F391B26F7AB87D30D99E24B9@MN0PR12MB6101.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1328bbe3-0c8c-4640-a93c-cff78d203354;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-30T18:35:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|PH8PR12MB6724:EE_
x-ms-office365-filtering-correlation-id: 9f55b62b-a577-41ec-ac5d-08db613f2173
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EhUdffbHoam7ziI+mo/H2sJeYtcqRm3/gdt4rq5X5zJtCUWW/Om+XniypvYFtVFElv74+0arACA5QNLuMRbe7L12om9wH2O2HIAQY6aoiHBGUsz2dFiJjjjsPUmPGLkUXQHM+X2vlOCUCCHzUWXvBQNOh4FFpgYwsW8oF9TK1+hfHjo8Gs+rTjB2c0UB01D+UgzhUnwobT2VD1q4UXDSS2pVexFggwrDqzlTH4ebfyIpHSsPADNiPExUhmzvOW7J4zZcpHcW17zQB+ANXMoLWGtb1XxJipwB7bhZffxth9ghwgZYL+hvpnV6wea4ycx9282VO9cKsvwG93NaRJH2bF6AsggIVGmVRsyWU0bjEo+Td0lreYPQkRShvvJ/D/pgf4YujECJpJHnqf3QQOzanR02gtqvtj7nkiWJ2I/NlAX261YJYn8RUei+QzzofyItI969bDVn0JXhCldLffZ8EcTuPIVwo+XCfwt3D8amU1v4qdbQa565Lf7mnLOom78InFfAEVANKJpCA1XyYJwQ0FCK+wg4Mxk5OZKrDKQ3UN/YpUPUgJE2Z+07RizwwBtHOKA8bAP9StoZ7MhLnScOgu26IZPNQOm1+sE2qZjpHrCWhCOpO18TX/HWH/LyeITY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(316002)(66899021)(71200400001)(966005)(38100700002)(38070700005)(55016003)(122000001)(41300700001)(7696005)(52536014)(53546011)(478600001)(86362001)(66946007)(186003)(83380400001)(26005)(6506007)(66574015)(110136005)(2906002)(5660300002)(2940100002)(4326008)(9686003)(64756008)(66556008)(76116006)(66446008)(66476007)(8676002)(33656002)(8936002)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVlmQkJ5WXlkNkQrR2pWWHpwRWM5RkhhTVRneUk5TjBIVFd2ckhyVDVVSUVp?=
 =?utf-8?B?V2t2UnVkSlRpUTZvR1Z4T3pOZTVtSzErTGtVMG91TEcxRUNQZDF0YlA0dkQ4?=
 =?utf-8?B?VkdMTmVEUmgvanE2WXpoUXdiQzRGT1M1ZUJMak1abUpXYVZvUVQ2NUUyNjJh?=
 =?utf-8?B?S0lwaGRqTUlJb1psN0xIcE9FU2xFcDhCTnd2NjFZWlRHNHJXTElhZS82clBz?=
 =?utf-8?B?eXpNTDQvZTN5aG5WVWNncU81bGhCbGpSOWwxUW1iTGZ6TzZqRFlGM2ZZVFBl?=
 =?utf-8?B?V2ZlN0VPSHkxQ3lwaEppWS9VdGdoTzliQXhsTElPbnNTdGxiOUxFUkN0NUpq?=
 =?utf-8?B?eTE1L2g2YXlEMVVIaUJoaVNKZ0tNVU9Fb1IvLy9PaXI5clR4THVNTFFIS0g4?=
 =?utf-8?B?dTNkK0NaazlwYlk3K3lvcFB0NXJWRjRhbE4wdFM3UVc0c0ZLMW0xL25VbXM2?=
 =?utf-8?B?dmJJckZsOHZDYU9neGpNYUFVU3psNEJWbGorUytnMUp1b1dUc0JXNmk1bDZE?=
 =?utf-8?B?NHB5UzdPRzYySFUwZGpjeHA5clQrem9VUlZ1MExpRWFlSkhlQ2plUXVvOU5B?=
 =?utf-8?B?bFRaYktUTGdDVjhTRDl4RXRjU0I3TkN1S2ZrZ2UvRVZDaXRCa2RhY1pRdkR4?=
 =?utf-8?B?djl2RmRUc25walNmelV1eW9za3U4ZUpiVU12R3VFaXc3OGUrZDdIdUN2SlF1?=
 =?utf-8?B?Tkh1aXJITHZVbWQ5U3VmaUJiZmtlVE5TWTlKR2UvbTc2K1ppVDFFVmdHMHBE?=
 =?utf-8?B?ZFhNL3J5UThFdVhPbXNqVGFEcVY2Y3puYTA0UWt3UGFMSW93RlFZMncrdFlq?=
 =?utf-8?B?TUZscHBPMjZFMGtlT21RMVlMVjZiNmZ5WGpEOENsemQ0OVhhL01UY2wvK0g5?=
 =?utf-8?B?ZVNJd0Z0eHFHa3kyRFNGNlFJU0pDVzVPbk8yczJsWG5ESHErdVNYenNRSVF2?=
 =?utf-8?B?bjBLSjU2NmdTQ0RGYTZoRmV0bUVZRTc3dFhNZ2MvcXkzc3FkUEFzNEVERzR5?=
 =?utf-8?B?WHk2bFBvWENIaGNwZEFDaEFJcHZRdkxYNzhRdHY5M0E4ZnhYaWM0TnkwazVJ?=
 =?utf-8?B?ak5sS2U0YVVid1dFOGQxeEFmZVdERHpqZU1tVExza1ozdEE0d1kwTjZPcFFV?=
 =?utf-8?B?YktQNjdTRVpndDJyUmM5UzlPVUJqWm50UVVqMWdkL2VaN1lvbG5NZWFGQ01V?=
 =?utf-8?B?Z1ZWTkRmZHQ4VENjS2l3R0UyZm1yYVQwU0VRLzF0a0hERWpoN2toQmxKWC95?=
 =?utf-8?B?VG1URmlrNVIwRnVLK3o4ODdXWUI2bW84RHBjMUh0SmVjbXpsMnIzb2xkNHNn?=
 =?utf-8?B?RmVmYU14Rkw0UEhCazF3VUF4dkRraUdNa2pZcEF5c0JIa3BXbTl1SEJvWWJW?=
 =?utf-8?B?WEFWZnkwclBwOXBzaTYyN1lsUTZrUTBBemprTXc0QnRsT1JPNnl6cm5iTlRL?=
 =?utf-8?B?cDA3QUpoTE1ISS9KTGdaSDVjeHp2bUJyTklzaXJ2STFmODl0R0FZQlBTaWor?=
 =?utf-8?B?b24vMytnYzNnMUZZN0x1d0VVbmc2emIrRWFvdWlkMVdpd2lLbUxoYm5KM2xy?=
 =?utf-8?B?TVZhamdHV0hOVmRiS29CcXhydDhQUXp0cElZcEpsSjZnQkJ5YmQ0WVJjVGxJ?=
 =?utf-8?B?MmZMWURVZSsvT1hOS0Z2WXFzOGkxdDJMYVMvVGJzNXZBMFhCcnc1VHhVTVBa?=
 =?utf-8?B?RlRUQU1HREJDZWxaYUlmVnV2SUczSUEyeTZmL2REWU9wMlN5S1YyYy8raGcv?=
 =?utf-8?B?UGNBMGtMVWNObndQWFZTcXM5MnkwZ2xjdVlvQ3V2Q1FUNzVuTVZCc25teld2?=
 =?utf-8?B?TGIvMEtnL0NXM3pNb1MvWi9qQXg4TEdmbjNCMFN5S25IeEFVa0VIZ0Y1YnBQ?=
 =?utf-8?B?dXZaSFFwZUlYMDVXOFNsTWt0NGJBY0wxTXlvQWFkZDgyM0lHZ3FDb2w3Y1RV?=
 =?utf-8?B?dXlaRThSbGFEVC80anM0ek8xVVZLMWxhQjVDYTEyVHNrNXFvUzEvVlhhVldq?=
 =?utf-8?B?VnB6M05WSy81NUg5WGJUMC9sSXlsV0lFK0tBNXhLYXVCSyt1dUo1VENlK3Jv?=
 =?utf-8?B?bWNZSnJCdXlDWldhcThFay9IT3ZZazA3TkEySmtNZml1UURVK21meGVhVi9R?=
 =?utf-8?Q?hoIE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f55b62b-a577-41ec-ac5d-08db613f2173
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 18:53:17.4711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a8uSlXBbZFKdx+Xo3bv1iqESZnvrcX5u4TTERNzKX5ppnB1mpGbL7Y/ImCi2WIckq/EK1YWoZGOeBxrRNq1njQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogTGltb25jaWVsbG8sIE1hcmlvDQo+IFNlbnQ6IFR1ZXNkYXksIE1h
eSAzMCwgMjAyMyAxOjM4IFBNDQo+IFRvOiBSYWZhZWwgw4F2aWxhIGRlIEVzcMOtbmRvbGEgPHJh
ZmFlbEBlc3BpbmRvLmxhPjsgQWxleCBEZXVjaGVyDQo+IDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+
DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BB
VENIIDEvMl0gZHJtL2FtZDogRGlzYWxsb3cgczBpeCB3aXRob3V0IEJJT1Mgc3VwcG9ydCBhZ2Fp
bg0KPg0KPiA+IEFzIGZhciBhcyBJIGtub3cgdGhlICJubyBTMyBpZiBTTVQgb2ZmIiBpcyBqdXN0
IGFuIG9kZGl0eSBvZiB0aGUNCj4gPiBwYXJ0aWN1bGFyIEJJT1MgSSBnb3Qgb24gdGhlICJCNTUw
SSBBT1JVUyBQUk8gQVgiLg0KPg0KPiBJbiB0aGF0IGNhc2UsIG1heWJlIHRoZSBtZXNzYWdlIHNo
b3VsZCBiZSBkb3duZ3JhZGVkIHRvIElORk8sIGFuZA0KPiBvbmx5IHNob3duIGluIHRoZSBjYXNl
IHRoYXQgczMgaXMgbm90IHN1cHBvcnRlZCBvbiBBUFVzLiAgVGhpcyB3aWxsDQo+IG5hcnJvdyBp
dCBxdWl0ZSBhIGJpdCB0aGVuLg0KDQpIZXJlJ3MgbXkgcHJvcG9zYWwgdG8gbmFycm93IGl0IGRv
d24gYmV0dGVyLg0KDQpib29sIGFtZGdwdV9hY3BpX2lzX3MzX2FjdGl2ZShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikNCnsNCiAgICAgICAgLyogZEdQVXMgYWx3YXlzIGdvIHRvIFMzICovDQog
ICAgICAgIGlmICghKGFkZXYtPmZsYWdzICYgQU1EX0lTX0FQVSkpDQogICAgICAgICAgICAgICAg
cmV0dXJuIHRydWU7DQogICAgICAgIC8qIHRoZSBrZXJuZWwgaGFzIGZvdW5kIHN1cHBvcnQgZm9y
IFMzIGFuZCB1c2VyIHNlbGVjdGVkIGl0ICovDQogICAgICAgIGlmIChwbV9zdXNwZW5kX3Rhcmdl
dF9zdGF0ZSA9PSBQTV9TVVNQRU5EX01FTSkNCiAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsN
CiNpZmRlZiBDT05GSUdfWDg2DQogICAgICAgIGlmIChib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVf
WkVOKSAmJiAhc2NoZWRfc210X2FjdGl2ZSgpKSB7DQogICAgICAgICAgICAgICAgZGV2X2luZm9f
b25jZShhZGV2LT5kZXYsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiU01UIGlzIGRp
c2FibGVkIChwb3NzaWJseSBieSB0aGUgQklPUykuXG4iDQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAiVG8gdXNlIHN1c3BlbmQtdG8tcmFtIGVuYWJsZSBTTVQgaW4gQklPUyBzZXR1cC5c
biIpOw0KICAgICAgICB9DQojZW5kaWYNCiAgICAgICAgcmV0dXJuIGZhbHNlOw0KfQ0KDQo+DQo+
ID4NCj4gPiBBbHNvLCB3aGF0IGhhcyBjaGFuZ2VkIHRoYXQgd291bGQgcHJldmVudCB0aGUgc2Ft
ZSBpc3N1ZSBJIHdhcyBoaXR0aW5nDQo+ID4gYmVmb3JlPzoNCj4gPg0KPiA+IGh0dHBzOi8vZ2l0
bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzIzNjQjbm90ZV8xNzM1NDIyDQo+
ID4NCj4NCj4gVGhpcyBjb21taXQgaW4gNi4zOg0KPiBjYTQ3NTE4NjYzOTcgKCJkcm0vYW1kOiBE
b24ndCBhbGxvdyBzMGl4IG9uIEFQVXMgb2xkZXIgdGhhbiBSYXZlbiIpDQo+DQo+ID4gQ2hlZXJz
LA0KPiA+IFJhZmFlbA0KPiA+DQo+ID4gIkxpbW9uY2llbGxvLCBNYXJpbyIgPE1hcmlvLkxpbW9u
Y2llbGxvQGFtZC5jb20+IHdyaXRlczoNCj4gPg0KPiA+ID4gW0FNRCBPZmZpY2lhbCBVc2UgT25s
eSAtIEdlbmVyYWxdDQo+ID4gPg0KPiA+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gPj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+ID4gPj4g
U2VudDogVHVlc2RheSwgTWF5IDMwLCAyMDIzIDE6MTYgUE0NCj4gPiA+PiBUbzogTGltb25jaWVs
bG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+ID4+IENjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgUmFmYWVsIMOBdmlsYSBkZSBFc3DDrW5kb2xhDQo+ID4g
Pj4gPHJhZmFlbEBlc3BpbmRvLmxhPg0KPiA+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBk
cm0vYW1kOiBEaXNhbGxvdyBzMGl4IHdpdGhvdXQgQklPUyBzdXBwb3J0DQo+ID4gYWdhaW4NCj4g
PiA+Pg0KPiA+ID4+IE9uIFR1ZSwgTWF5IDMwLCAyMDIzIGF0IDE6NTPigK9QTSBNYXJpbyBMaW1v
bmNpZWxsbw0KPiA+ID4+IDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPiB3cm90ZToNCj4gPiA+
PiA+DQo+ID4gPj4gPiBjb21taXQgY2Y0ODhkY2QwYWI3ICgiZHJtL2FtZDogQWxsb3cgczBpeCB3
aXRob3V0IEJJT1Mgc3VwcG9ydCIpDQo+ID4gPj4gc2hvd2VkDQo+ID4gPj4gPiBpbXByb3ZlbWVu
dHMgdG8gcG93ZXIgY29uc3VtcHRpb24gb3ZlciBzdXNwZW5kIHdoZW4gczBpeCB3YXNuJ3QNCj4g
PiA+PiBlbmFibGVkIGluDQo+ID4gPj4gPiBCSU9TIGFuZCB0aGUgc3lzdGVtIGRpZG4ndCBzdXBw
b3J0IFMzLg0KPiA+ID4+ID4NCj4gPiA+PiA+IFRoaXMgcGF0Y2ggaG93ZXZlciB3YXMgbWlzZ3Vp
ZGVkIGJlY2F1c2UgdGhlIHJlYXNvbiB0aGUgc3lzdGVtDQo+IGRpZG4ndA0KPiA+ID4+ID4gc3Vw
cG9ydCBTMyB3YXMgYmVjYXVzZSBTTVQgd2FzIGRpc2FibGVkIGluIE9FTSBCSU9TIHNldHVwLg0K
PiA+ID4+ID4gVGhpcyBwcmV2ZW50ZWQgdGhlIEJJT1MgZnJvbSBhbGxvd2luZyBTMy4NCj4gPiA+
PiA+DQo+ID4gPj4gPiBBbHNvIGFsbG93aW5nIEdQVXMgdG8gdXNlIHRoZSBzMmlkbGUgcGF0aCBh
Y3R1YWxseSBjYXVzZXMgcHJvYmxlbXMgaWYNCj4gPiA+PiA+IHRoZXkncmUgaW52b2tlZCBvbiBz
eXN0ZW1zIHRoYXQgbWF5IG5vdCBzdXBwb3J0IHMyaWRsZSBpbiB0aGUgcGxhdGZvcm0NCj4gPiA+
PiA+IGZpcm13YXJlLiBgc3lzdGVtZGAgaGFzIGEgdGVuZGVuY3kgdG8gdHJ5IHRvIHVzZSBgczJp
ZGxlYCBpZiBgZGVlcGAgZmFpbHMNCj4gPiA+PiA+IGZvciBhbnkgcmVhc29uLCB3aGljaCBjb3Vs
ZCBsZWFkIHRvIHVuZXhwZWN0ZWQgZmxvd3MuDQo+ID4gPj4gPg0KPiA+ID4+ID4gVG8gbWFrZSB0
aGlzIHRoZSBiZWhhdmlvciBkaXNjb3ZlcmFibGUgYW5kIGV4cGVjdGVkLCByZXZlcnQgY29tbWl0
DQo+ID4gPj4gPiBjZjQ4OGRjZDBhYjcgKCJkcm0vYW1kOiBBbGxvdyBzMGl4IHdpdGhvdXQgQklP
UyBzdXBwb3J0IikgYW5kIG9mZmVyDQo+ID4gPj4gPiBhIG1lc3NhZ2UgaWYgU01UIGFwcGVhcnMg
dG8gYmUgZGlzYWJsZWQuDQo+ID4gPj4gPg0KPiA+ID4+ID4gQ2M6IFJhZmFlbCDDgXZpbGEgZGUg
RXNww61uZG9sYSA8cmFmYWVsQGVzcGluZG8ubGE+DQo+ID4gPj4gPiBMaW5rOg0KPiA+ID4+DQo+
ID4NCj4gaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvdjYuMS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdQ0KPiA+ID4+IC9hbWRncHVfYWNwaS5jI0wxMDYwDQo+ID4gPj4g
PiBDbG9zZXM6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVz
LzI1OTkNCj4gPiA+PiA+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5s
aW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+ID4+ID4gLS0tDQo+ID4gPj4gPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYyB8IDE2DQo+ICsrKysrKysrKysrKysrLS0NCj4g
PiA+PiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gPiA+PiA+DQo+ID4gPj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FjcGkuYw0KPiA+ID4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FjcGkuYw0KPiA+ID4+ID4gaW5kZXggM2E2YjJlMjA4OWY2Li5hMzUyM2QwM2Q3NjkgMTAw
NjQ0DQo+ID4gPj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNw
aS5jDQo+ID4gPj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNw
aS5jDQo+ID4gPj4gPiBAQCAtMjgsNiArMjgsNyBAQA0KPiA+ID4+ID4gICNpbmNsdWRlIDxsaW51
eC94YXJyYXkuaD4NCj4gPiA+PiA+ICAjaW5jbHVkZSA8bGludXgvcG93ZXJfc3VwcGx5Lmg+DQo+
ID4gPj4gPiAgI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gPiA+PiA+ICsjaW5jbHVk
ZSA8bGludXgvc2NoZWQvc210Lmg+DQo+ID4gPj4gPiAgI2luY2x1ZGUgPGxpbnV4L3N1c3BlbmQu
aD4NCj4gPiA+PiA+ICAjaW5jbHVkZSA8YWNwaS92aWRlby5oPg0KPiA+ID4+ID4gICNpbmNsdWRl
IDxhY3BpL2FjdGJsLmg+DQo+ID4gPj4gPiBAQCAtMTQ3Myw2ICsxNDc0LDEzIEBAIHZvaWQgYW1k
Z3B1X2FjcGlfcmVsZWFzZSh2b2lkKQ0KPiA+ID4+ID4gICAqLw0KPiA+ID4+ID4gIGJvb2wgYW1k
Z3B1X2FjcGlfaXNfczNfYWN0aXZlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ID4+
ID4gIHsNCj4gPiA+PiA+ICsjaWZkZWYgQ09ORklHX1g4Ng0KPiA+ID4+ID4gKyAgICAgICBpZiAo
IXNjaGVkX3NtdF9hY3RpdmUoKSkgew0KPiA+ID4+ID4gKyAgICAgICAgICAgICAgIGRldl93YXJu
X29uY2UoYWRldi0+ZGV2LA0KPiA+ID4+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IlNNVCBpcyBkaXNhYmxlZCBieSB0aGUgQklPUy5cbiINCj4gPiA+PiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICJUbyB1c2Ugc3VzcGVuZC10by1yYW0gZW5hYmxlIFNNVCBpbiBCSU9T
IHNldHVwLlxuIik7DQo+ID4gPj4gPiArICAgICAgIH0NCj4gPiA+PiA+ICsjZW5kaWYNCj4gPiA+
Pg0KPiA+ID4+IFdpbGwgdGhpcyBnZW5lcmF0ZSBhIHNwdXJpb3VzIHdhcm5pbmcgb24gcGxhdGZv
cm1zIHRoYXQgYXJlIG5hdGl2ZWx5IG5vbi0NCj4gPiBTTVQ/DQo+ID4gPg0KPiA+ID4gWWVhaDsg
aXQgY291bGQuICBJJ20gbm90IHN1cmUgaG93IHdlIGNhbiByZWxpYWJseSBkZXRlY3QgdGhpcy4g
IEkgdGhvdWdodA0KPiBhYm91dA0KPiA+IGxvb2tpbmcgZm9yDQo+ID4gPiB0aGUgJ2h0JyBmbGFn
LCBidXQgdGhhdCBwcm9iYWJseSB3b3VsZG4ndCB3b3JrIGZvciB0aGlzIGNhc2UuDQo+ID4gPg0K
PiA+ID4gQXJlIHRoZXJlIEFNRCBaZW4gQ1BVcyBvciBBUFVzIHRoYXQgYXJlIG5vbi1TTVQ/ICBD
b3VsZCBnYXRlIHRoZQ0KPiA+IHNjaGVkX3NtdF9hY3RpdmUoKQ0KPiA+ID4gY2hlY2sgdG8gb25s
eSBydW4gd2hlbiBpdCdzIGFuIEFNRCB4ODYgWmVuIFNvQy4NCj4gPiA+DQo+ID4gPj4NCj4gPiA+
PiBBbGV4DQo+ID4gPj4NCj4gPiA+PiA+ICAgICAgICAgcmV0dXJuICEoYWRldi0+ZmxhZ3MgJiBB
TURfSVNfQVBVKSB8fA0KPiA+ID4+ID4gICAgICAgICAgICAgICAgIChwbV9zdXNwZW5kX3Rhcmdl
dF9zdGF0ZSA9PSBQTV9TVVNQRU5EX01FTSk7DQo+ID4gPj4gPiAgfQ0KPiA+ID4+ID4gQEAgLTE0
OTksMTYgKzE1MDcsMjAgQEAgYm9vbCBhbWRncHVfYWNwaV9pc19zMGl4X2FjdGl2ZShzdHJ1Y3QN
Cj4gPiA+PiBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ID4+ID4gICAgICAgICAgKiBTMGl4IGV2
ZW4gdGhvdWdoIHRoZSBzeXN0ZW0gaXMgc3VzcGVuZGluZyB0byBpZGxlLCBzbyByZXR1cm4gZmFs
c2UNCj4gPiA+PiA+ICAgICAgICAgICogaW4gdGhhdCBjYXNlLg0KPiA+ID4+ID4gICAgICAgICAg
Ki8NCj4gPiA+PiA+IC0gICAgICAgaWYgKCEoYWNwaV9nYmxfRkFEVC5mbGFncyAmIEFDUElfRkFE
VF9MT1dfUE9XRVJfUzApKQ0KPiA+ID4+ID4gKyAgICAgICBpZiAoIShhY3BpX2dibF9GQURULmZs
YWdzICYgQUNQSV9GQURUX0xPV19QT1dFUl9TMCkpIHsNCj4gPiA+PiA+ICAgICAgICAgICAgICAg
ICBkZXZfd2Fybl9vbmNlKGFkZXYtPmRldiwNCj4gPiA+PiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICJQb3dlciBjb25zdW1wdGlvbiB3aWxsIGJlIGhpZ2hlciBhcyBCSU9TIGhhcyBu
b3QgYmVlbg0KPiA+ID4+IGNvbmZpZ3VyZWQgZm9yIHN1c3BlbmQtdG8taWRsZS5cbiINCj4gPiA+
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJUbyB1c2Ugc3VzcGVuZC10by1pZGxl
IGNoYW5nZSB0aGUgc2xlZXAgbW9kZSBpbiBCSU9TDQo+ID4gPj4gc2V0dXAuXG4iKTsNCj4gPiA+
PiA+ICsgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gPj4gPiArICAgICAgIH0NCj4g
PiA+PiA+DQo+ID4gPj4gPiAgI2lmICFJU19FTkFCTEVEKENPTkZJR19BTURfUE1DKQ0KPiA+ID4+
ID4gICAgICAgICBkZXZfd2Fybl9vbmNlKGFkZXYtPmRldiwNCj4gPiA+PiA+ICAgICAgICAgICAg
ICAgICAgICAgICAiUG93ZXIgY29uc3VtcHRpb24gd2lsbCBiZSBoaWdoZXIgYXMgdGhlIGtlcm5l
bCBoYXMgbm90DQo+IGJlZW4NCj4gPiA+PiBjb21waWxlZCB3aXRoIENPTkZJR19BTURfUE1DLlxu
Iik7DQo+ID4gPj4gPiAtI2VuZGlmIC8qIENPTkZJR19BTURfUE1DICovDQo+ID4gPj4gPiArICAg
ICAgIHJldHVybiBmYWxzZTsNCj4gPiA+PiA+ICsjZWxzZQ0KPiA+ID4+ID4gICAgICAgICByZXR1
cm4gdHJ1ZTsNCj4gPiA+PiA+ICsjZW5kaWYgLyogQ09ORklHX0FNRF9QTUMgKi8NCj4gPiA+PiA+
ICB9DQo+ID4gPj4gPg0KPiA+ID4+ID4gICNlbmRpZiAvKiBDT05GSUdfU1VTUEVORCAqLw0KPiA+
ID4+ID4gLS0NCj4gPiA+PiA+IDIuMzQuMQ0KPiA+ID4+ID4NCg==
