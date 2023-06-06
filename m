Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD66C7EE24
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 15:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6B7410E370;
	Tue,  6 Jun 2023 15:07:08 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E6A310E370
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 15:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldTdwbZmT779DYwh4F5pEotG6gX31cx6gvX0U+wBGaWwEI8sQ2/7gIRp8og0dBf+K4dMcIwBgC2tW7KRXllBQBGwSFgu+5U28BhaPWroRoA37AdenbEYEw/p5CDw1w8kWC2PWQxpV6D3LrOv6o0QE34QisteWRsN+XVzD31Ks3P4hGB32d8m/kCFWaDTRobg9L4KtxmjOdLXxxRR3c5uoURw52iAVZ4LpYQfv5yXCUTywRyBrJolhgNwNkLY3tZEbXD0DtMuDl7GLiyi1SHVEkrIBt2VWmsG+Jw0ZA4MzfJsBaIULtu3jVNvRGCOZ3Fh3ZiDTyqFmHaqrylR4BT5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxOoqZeR4SAVDJSvEp6eOszv7KDODyyMJt+oa8CkAJM=;
 b=UFnjYXvOYWIdfJU69BSNo9cepf2/pHQnPbOxer5l6xUSrIdy7RIQFr76G93dGpmF7iCam3h4kFJyt0HkRe3wqUcY6ijkNtORNOObnrUJ5PLDPcQLXHeJCtZXXHbNcQB5c5MFE6fd6U7ViI51VkIk1awpWcL25V+4p2SL4TnwvzzbzxvESXTUX6svtw/yEPk4s59AYBwaKrZpQbSP2H4W6IJj157/3jtykKI98RGYQcjbrtLvHL9xBug4/HlW9+aL5akwtxIeEzlcKB2chQiKX7Ux/u2V2AYrd99PXV74c8k7K1C2efKZ1kiQJ+X2FtRqx8u/mmlqkisy5MI6TqHJew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxOoqZeR4SAVDJSvEp6eOszv7KDODyyMJt+oa8CkAJM=;
 b=YqHrZD5QQ4oj3Tjog19m6MsQ+SeDQphJ1FcEhukPFtpl517bLZRfHEyeIwcbR0sC2DMqD8A/AOv36y01whxQ4Tg3BRBi4YYQ2VjqQ3MGinCMoSJ4Y5xf17U6PqQXcY5ZlVDo7FY5QGqOfK/VtRN8msbE33tSL3/o2CCXeAR9VzA=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Tue, 6 Jun
 2023 15:07:03 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::e2fb:5834:f348:467f]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::e2fb:5834:f348:467f%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 15:07:02 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Wang, Chao-kai (Stylon)"
 <Stylon.Wang@amd.com>, "Lee, Alvin" <Alvin.Lee2@amd.com>, "Lei, Jun"
 <Jun.Lei@amd.com>
Subject: RE: [PATCH] drm/amd/display: Fix guarding of 'if
 (dc->debug.visual_confirm)'
Thread-Topic: [PATCH] drm/amd/display: Fix guarding of 'if
 (dc->debug.visual_confirm)'
Thread-Index: AQHZmHNryFq0SYZMwEWzdfy9S9rFuK993j6AgAABrsA=
Date: Tue, 6 Jun 2023 15:07:02 +0000
Message-ID: <MN2PR12MB41284779B0A0B965F8B142E09052A@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20230606123518.2636457-1-srinivasan.shanmugam@amd.com>
 <74ab4d77-9bcd-603d-67bf-5920611c3b35@amd.com>
In-Reply-To: <74ab4d77-9bcd-603d-67bf-5920611c3b35@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=941fe671-f348-4c6f-94e0-6788e5e5f8f5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-06T15:06:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|MN0PR12MB6054:EE_
x-ms-office365-filtering-correlation-id: bc9d860e-bde1-40e9-5f03-08db669faf34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KoEd8SSXwP9+hXeryLRrAXiAHNWBapNaHQuJoTHw1GvOXeGY6SXRtIlWwJlEcZ5tPszPI8MY0WnmwGIGtWWGIGgtoy20o8eunQ6maGR3+7MlqFRFVVqqyrK2kXL5s+oYjBhq+TNWX60SOYh+tRtXD0gKqU/NUD4B08/L0OXkxOcl+L+1BpZ6UGVW+8HdumMOUps+Id4cCwgPb7z2nLaI83pQnXoDegCmf2lrkaafa11uV8p5lu9kaFpWoJOAz3BhwVyMIOWnwf58uyVFMawEfXDxloFNOIB2o/sLP/jze27WfAyOYEeMyzJUdf/yWsvGgPCr4zXMulJpp8E9/muAcZDzu43okTd+4JhUt/82OEwzzMcJhp7La5LIxuArRk42+hsjfY9UOtqqAereyrudArAzo9a3YEuPCuye3cwOwLTl55E+RxAoB8SOHcFClGaO1S8o33oolgrsvCvWcuxxp5eR4gCCprvoRt5d2TggRMVn7qery8QOa5qZrMgWoMZPfbmL38ATzhhjgOWrXE7CbkydmhEPUM3jJIGtrU6neboBZekM2VX6A9za5TH03vayA/z6BTpRfqviQK9Phg9zsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199021)(478600001)(5660300002)(38070700005)(52536014)(110136005)(71200400001)(8936002)(8676002)(316002)(6636002)(4326008)(66946007)(122000001)(66556008)(66446008)(64756008)(66476007)(76116006)(41300700001)(38100700002)(2906002)(921005)(55016003)(33656002)(26005)(6506007)(9686003)(53546011)(86362001)(186003)(83380400001)(966005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDAyK09vT0F6MlFnL3pnS2hsNGpkYk0zTUhsNEUraUcxYzBUa01TdDJYNjMr?=
 =?utf-8?B?ZGIrc3M0T3FQWWVESU9iUm9NbUhsWDJCZ3VOQTJBeFJDaVUzV056VkVXMDNr?=
 =?utf-8?B?Sm9HdE1hS2pubXk1N25pL3FBMjBmWndVWVYvMWt3LzBKTGFqSmNzQUJHVEsy?=
 =?utf-8?B?cWFOdlFIdlVBQ1htYWEzR1RGSEhMdE0zdmN1ZzIxL04zbFRGKy9UVEgrc2tv?=
 =?utf-8?B?TXJLakM0djFLMWhXeHlJaTlDYlNuemR6WEd4VFV6QTJ5bGIzRkhLOEpRL1pK?=
 =?utf-8?B?YXZmdjlvZUZRdmFZblkxWGFqcS9iWllSNXpSZ081d2tzYkRtOWpKd1Q3Tm5O?=
 =?utf-8?B?aTRTZGdVSVovV3VhbXNaL2xnQTNQU0VWVm4wS1FHN3VGSW1ldVE3MkswOW94?=
 =?utf-8?B?TjB2RzM0VEphWDVvSWVHMENQd3B1ck82TmxXcDgrdisvZmlDVlNFQXBrVzhJ?=
 =?utf-8?B?bVZiN2cxcFJwY2xWNC90OFlKYmJHS0l2WHMwNnpmZjl6V0cxTVBrQVpEbmlC?=
 =?utf-8?B?dTJmYlBmODdxbGNjaDQvNEJJSi9hYkV1RWN6M0FKbmYwM2xwU0J3MWo4c1Vo?=
 =?utf-8?B?ZHJxN0R1OEVzMDlpNDlaOEo1VW0zZElTM2kwYlhxQTNSaUM5VXNmSytDVnNE?=
 =?utf-8?B?RlM1dFdPZkQwWkcrcWdVQ0FCRmkwWGlKRk84cjhPVHVqL2hsenpzaStEUFRl?=
 =?utf-8?B?aDJ5ZjFSV2xta1FSUkVoQnE2S0ZydGxhYTR3NW5kLzBmcTRKdmtrdG9HUlRi?=
 =?utf-8?B?R004dlFCTWlaNW8rQVdUalhKbGQ4Rm9UdDhCMExucjRraUhzZGlDUkc0aG5L?=
 =?utf-8?B?SlVKZG4wcGMrYnREaXlPYVQ0bTNwWnNwL0k3K2k4a0Z0enNQRDZoUGJBZDlG?=
 =?utf-8?B?bmpzemlYSXBsbWE5OEVGSzVDWFJiMmpnYW94a1U2YVd1ZFBvRGh6MHVQVTBa?=
 =?utf-8?B?VHJFbHNEOTRSSUsyYmdlL2toMUsxVnZqazQ5L0g2MG9rUzFNUkc2cDk1ZEMr?=
 =?utf-8?B?dHhWcHZBWEtmaVhEUzNMVm5Ma3FnZTducTV6SFFXTjV4MDRya3ZJdStKSWVY?=
 =?utf-8?B?b3NMbEgxd256bWdwcWgvWXZzZW8vMXVEaGV5YTFzWGhEMWY2V1hYZktvUVpK?=
 =?utf-8?B?eXNUUDZxeGJ1bDZrVWo5Z1hCSEI1czg5YU5yQy9zT09nYXg2eHZBVFJCb29t?=
 =?utf-8?B?eG5XQlhNOC9nVDBaNGdjdjFwM1A0M3d0VXMrbHNWVnB5VW1wZHRqQmxaR2JF?=
 =?utf-8?B?aU9IdUhySEhLUW5NcW1XaXpBTm5rU2NNVzZBaE80anR3NmFHcGs3eE1qTy81?=
 =?utf-8?B?ZTBVeHdKYkQ4MXRGeUVmcGRJNmZ0UTJlSVZtd3dpSzRaMVR3cEFyVUJVS1dS?=
 =?utf-8?B?RzZuWmtlRklwcjBQamFFbGtuSU40RFJoM0VpSGo0elFNbC9FTVhzMEg0MGpW?=
 =?utf-8?B?VzRsU1JwMmo5eTRNYU1penp6U0JRSFhMQ05sS1Z3STN2bEtIcHZKYnlOdFdL?=
 =?utf-8?B?MU5qU2toZ21VVjZzNExHWTZZM0llWTVqQzhTMm5SaFhqdTRKVnBiMGFKczQw?=
 =?utf-8?B?TTFzeExVU2ZBWStqRzZjMDdrdm1USE1uemlRc0RYRkNYRjIrTlBybTBCZU5q?=
 =?utf-8?B?MHI5bGc0WlMySzhpaW43cFFSa2hNamJSbDJOUDJGd241UDV5c1djTjRoS040?=
 =?utf-8?B?NkpsOW9qYkFhVzZ0amJlemdaNDcxOEZhMVlpN05UaGxzeTlyTElFdS9QNXhF?=
 =?utf-8?B?d01xdGRZMFdhSndtc3VuWjY3cjg2WkhFdVFybDl1cDYyb3VnK3o3bk1SRTRa?=
 =?utf-8?B?OGZUQ1luNGRkOHBxWUp1M0xXMnlza2JuY1JuNVJCUVJXeEpHNmM3RHlpeTNE?=
 =?utf-8?B?VkFUd2FYa0dnQkFmS2FDODFVZm9LT3UvUEJNbEJHUEVpNkNrbnpnQ1V1OUVN?=
 =?utf-8?B?cUlmSEhGS2tHNThBUGdTMHVzc2hhdTZvVFNSaFNmUzlEamJ6a21pc1hFS0FV?=
 =?utf-8?B?WmNEeE56YlZJbHkwMzNUSXQ0L3JVblVsZzJML2xiUHo5bjErR1QvRndzdXE4?=
 =?utf-8?B?S2hTbEM1TVQ1QnpnRUhXUTFlZUZ1aGRVdjZlNmhrZVE0RzdBcW91WEdCdmpZ?=
 =?utf-8?Q?ywGg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9d860e-bde1-40e9-5f03-08db669faf34
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 15:07:02.8188 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8DJRmIequT1J0BtYae+GaacR3ZZoLQZO5LdBJ31ngJSgIymZf7nkV7kEG6qC5kCm1vj2D5R0dHLiJyF3X5EBeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBNYWhmb296LCBIYW16YSA8SGFtemEuTWFoZm9vekBhbWQuY29tPg0KU2Vu
dDogVHVlc2RheSwgSnVuZSA2LCAyMDIzIDg6MzAgUE0NClRvOiBTSEFOTVVHQU0sIFNSSU5JVkFT
QU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBQaWxsYWksIEF1cmFiaW5kbyA8QXVyYWJpbmRvLlBp
bGxhaUBhbWQuY29tPjsgU2lxdWVpcmEsIFJvZHJpZ28gPFJvZHJpZ28uU2lxdWVpcmFAYW1kLmNv
bT47IFdhbmcsIENoYW8ta2FpIChTdHlsb24pIDxTdHlsb24uV2FuZ0BhbWQuY29tPjsgTGVlLCBB
bHZpbiA8QWx2aW4uTGVlMkBhbWQuY29tPjsgTGVpLCBKdW4gPEp1bi5MZWlAYW1kLmNvbT4NCkNj
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJt
L2FtZC9kaXNwbGF5OiBGaXggZ3VhcmRpbmcgb2YgJ2lmIChkYy0+ZGVidWcudmlzdWFsX2NvbmZp
cm0pJw0KDQpPbiA2LzYvMjMgMDg6MzUsIFNyaW5pdmFzYW4gU2hhbm11Z2FtIHdyb3RlOg0KPiBQ
cmVzdW1hYmx5IHRoZSBhdXRob3IgaW50ZW5kZWQgdG8gZ3VhcmQgYm90aCB0aGUgZm9yIGxvb3Bz
IHdpdGgNCj4gY29uZGl0aW9uICdkYy0+cmVzX3Bvb2wtPnBpcGVfY291bnQnICYgJ3N1cmZhY2Vf
Y291bnQnIHVuZGVyICdpZg0KPiAoZGMtPmRlYnVnLnZpc3VhbF9jb25maXJtKScgc28gdGhhdCdz
IHdoYXQgSSdtIGNoYW5naW5nIHRoZSBjb2RlIHRvLg0KPiBIb3BlZnVsbHkgdG8gZG8gdGhlIHJp
Z2h0IHRoaW5nLg0KPg0KPiBGaXhlcyB0aGUgYmVsb3cgY29tcGlsYXRpb24gZXJyb3I6DQo+DQo+
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvY29yZS9kYy5jOjM1NDY6
MzogZXJyb3I6IG1pc2xlYWRpbmcgaW5kZW50YXRpb247IHN0YXRlbWVudCBpcyBub3QgcGFydCBv
ZiB0aGUgcHJldmlvdXMgJ2lmJyBbLVdlcnJvciwtV21pc2xlYWRpbmctaW5kZW50YXRpb25dDQo+
ICAgICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IHN1cmZhY2VfY291bnQ7IGkrKykgew0K
PiAgICAgICAgICAgICAgICAgIF4NCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlz
cGxheS9kYy9jb3JlL2RjLmM6MzUzODoyOiBub3RlOiBwcmV2aW91cyBzdGF0ZW1lbnQgaXMgaGVy
ZQ0KPiAgICAgICAgICBpZiAoZGMtPmRlYnVnLnZpc3VhbF9jb25maXJtKQ0KPiAgICAgICAgICBe
DQo+DQo+ICdGaXhlczogMjVlMWE2MTE1ZmMyZSAoImRybS9hbWQvZGlzcGxheTogUmVmYWN0b3Ig
ZmFzdCB1cGRhdGUgdG8gdXNlDQo+IG5ldyBIV1NTIGJ1aWxkIHNlcXVlbmNlIiknDQo+IENjOiBT
dHlsb24gV2FuZyA8c3R5bG9uLndhbmdAYW1kLmNvbT4NCj4gQ2M6IEFsdmluIExlZSA8YWx2aW4u
bGVlMkBhbWQuY29tPg0KPiBDYzogSnVuIExlaSA8anVuLmxlaUBhbWQuY29tPg0KPiBDYzogUm9k
cmlnbyBTaXF1ZWlyYSA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPg0KPiBDYzogQXVyYWJpbmRv
IFBpbGxhaSA8YXVyYWJpbmRvLnBpbGxhaUBhbWQuY29tPg0KPiBDYzogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNo
YW5tdWdhbSA8c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1kLmNvbT4NCg0KTkFDSywgb25seSB0aGUg
Zm9yIGxvb3AgdG93YXJkcyB0aGUgdG9wIG9mIHBhdGNoIHNob3VsZCBiZSBjb250YWluZWQgd2l0
aGluIHRoZSBpZiBzdGF0ZW1lbnQuIFRoZSByZXN0IG9mIHRoZSBsaW5lcyBzaG91bGQgaGF2ZSB0
aGVpciBpbmRlbnRhdGlvbiBmaXhlZCwgc2VlIGNvbW1pdCBkMTE4YjI4YWVmY2IgKCJkcm0vYW1k
L2Rpc3BsYXk6IENsZWFuIEZQR0EgY29kZSBpbiBkYyIpIGZvciBjb250ZXh0Lg0KDQpUaGFua3Mg
YSBsb3QgZm9yIHlvdXIgZmVlZGJhY2tzLCBJIGhhZCBzdWJtaXR0ZWQgdjI6IGh0dHBzOi8vcGF0
Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9wYXRjaC81NDEzMTIvDQoNCj4gLS0tDQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYyB8IDQgKysrLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMNCj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jDQo+IGluZGV4IDVlMThmYzBjNzlkNi4uYWJh
YjlhZTVlMDdjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Y29yZS9kYy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2Rj
LmMNCj4gQEAgLTM1MzQsNyArMzUzNCw3IEBAIHN0YXRpYyB2b2lkIGNvbW1pdF9wbGFuZXNfZm9y
X3N0cmVhbV9mYXN0KHN0cnVjdCBkYyAqZGMsDQo+ICAgICAgICAgICAgICAgfQ0KPiAgICAgICB9
DQo+DQo+IC0gICAgIGlmIChkYy0+ZGVidWcudmlzdWFsX2NvbmZpcm0pDQo+ICsgICAgIGlmIChk
Yy0+ZGVidWcudmlzdWFsX2NvbmZpcm0pIHsNCj4gICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBp
IDwgZGMtPnJlc19wb29sLT5waXBlX2NvdW50OyBpKyspIHsNCj4gICAgICAgICAgICAgICAgICAg
ICAgIHN0cnVjdCBwaXBlX2N0eCAqcGlwZSA9ICZjb250ZXh0LT5yZXNfY3R4LnBpcGVfY3R4W2ld
Ow0KPg0KPiBAQCAtMzU2MCw2ICszNTYwLDggQEAgc3RhdGljIHZvaWQgY29tbWl0X3BsYW5lc19m
b3Jfc3RyZWFtX2Zhc3Qoc3RydWN0IGRjICpkYywNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfQ0KPiAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgICAgIH0NCj4g
KyAgICAgfQ0KPiArDQo+ICAgICAgIGJ1aWxkX2RtdWJfY21kX2xpc3QoZGMsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICBzcmZfdXBkYXRlcywNCj4gICAgICAgICAgICAgICAgICAgICAgIHN1cmZh
Y2VfY291bnQsDQotLQ0KSGFtemENCg0K
