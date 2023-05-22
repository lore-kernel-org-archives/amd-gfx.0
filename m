Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8258C77B75
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 03:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0028810E12C;
	Mon, 22 May 2023 03:22:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62F7910E12C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 03:22:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibB7znpitDaet3lxP48rMiWSXFEim6MC6ROy87IPg4Zgrp2JMWIYUGytyv7K397x8cJtEknL0FHKju/7IXW3zgdbJFpEntPIHG8sasQLpEtydNzIJZHIHE0FhSp8rStzufvKZpuK86J6gXGZ/t099elIHZcDOg0pUs0SlJ+mgr5HCWwneuh7g95ZM5Jd8w7e38y0ar8xvCG7V6lfNryDEFy465uucIcPKFJyAJageEEYLw+2sj8hGS6t6di4XB+no9TsfysF+JovA48mwzPY+fRkAWQ6zYp2e/lE+BT/E3x3ywDgFaSTzY91tMNU9h4YThPgEfh8fhjN70EZ7WVycQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nb5yb/Ay+knKzEK53X0WiAFE8m4k8SoaWLdKdbO6gK0=;
 b=DRQlMXe+IPZD5oAq/jVi8FVIQxCmNqwVOh31l6VLEdRbJyxkn34VFuUSa5IE6MpPbJwqPquaaqsuFdkDWrtIHh+WDsLzECnGo4Odmc81M+nkE2a9KfJz+FQPy3bI6D5hmCwDj1Psl1l1ReL8ZYZHyJdgpcHFdVu3O3uDaVqTOqxF5UTj4OJWpd6rr6D/BoC3aIKK/2bnysAAc/weyonYVvNbZSzhef37lrVynjtoRk76nFBP48TVgXsPcEp5TVtY9iT2alwT91eh1DjgCwk2DV2FwjnZuXlpVp2sPhrsOh5wSkburbPBtyL7vjPDK02wK5tcLvfsRoTcAMlZmNqrHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nb5yb/Ay+knKzEK53X0WiAFE8m4k8SoaWLdKdbO6gK0=;
 b=WK8s0aMxx7Xn5Cr/QexQR4+JSVIXrVRwKsZNwCAPt1mzJzIIxKghvsWNgdJdIgqfZ8W3RJTRSoYJmRdTqWSsYDEfiGBr4sH3QxSa4UKFvmXryLkg1iwNSjy1tA5OpP5O0MYA6ksIesy0UIQs20QqnlERtGYEWM+wFlzAHDMYziI=
Received: from DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Mon, 22 May
 2023 03:22:37 +0000
Received: from DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::5cad:78df:6b83:6127]) by DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::5cad:78df:6b83:6127%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 03:22:37 +0000
From: "Xiao, Shane" <shane.xiao@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Paneer Selvam, Arunpravin"
 <Arunpravin.PaneerSelvam@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: remove TOPDOWN flags when allocating
 VRAM in large bar system"
Thread-Topic: [PATCH] Revert "drm/amdgpu: remove TOPDOWN flags when allocating
 VRAM in large bar system"
Thread-Index: AQHZiv0QBXBJ6jL41ES+BKP5kfwQCq9jfsYAgAIHoSA=
Date: Mon, 22 May 2023 03:22:36 +0000
Message-ID: <DM4PR12MB5261EDA410B001ACCF0CDC289D439@DM4PR12MB5261.namprd12.prod.outlook.com>
References: <20230520092518.1993-1-Arunpravin.PaneerSelvam@amd.com>
 <f03a448f-1ba3-5d4a-a2a5-baba97b3ec1f@amd.com>
In-Reply-To: <f03a448f-1ba3-5d4a-a2a5-baba97b3ec1f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=aefde487-9fdf-4326-9588-dd0fa3bc6152;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-22T01:39:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5261:EE_|IA1PR12MB7520:EE_
x-ms-office365-filtering-correlation-id: cda9cf6e-b9a2-4018-9abf-08db5a73ca91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: utmJh8BwWKB5eGZDZAqEYamuDJUFxlR2VhYJKNaIwBYJRfEMJjJBFZYxpugBOjv1Uhprofw5OngNcI8Raa5tTWXaPRS96rRmBeLEgvAhCZSjoA4/H8UNK+z0AFiAgApImcvkmUcsSZJw2Mfgzbq2OsGT7WnfQ3UymhCYh0SshlgS1YE/XthPhJtDkvtbAUFeGVPj32q1egBUfAeOiLXNUGJ4uv0A+rGSvAvu1y2iXAV1hktcBX5T2htQ6/9UD/a43xjtdS0ptRRR4kfTLxQXGXM3lV4ltFGmg7HFa7Xe/LrSJNHfkBpH7bL5kjoT0ciqL07sJVFDi4PQraUQQkpL47Hx4Rk26KSUqaUvQnD+oMhfmjrugt+aOPxfvjGqw9GFoxbPlFF3vIC7uUbv2ipWXAwDncOiWkEiy3J/x0QWAnBMxfPWOaU/WRICWeltjmWJBK24T1Esnq407B9vTADEG767rERVDzUXr17Oicr4V6c7fLTWFbu4jVIzKVZUjT7N1dOk7hmIA/VACVrSErHUAqHfbKOcLDxSHVMLKxpuaACz0z7llNKqgEMnESQwJB7N
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5261.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199021)(83380400001)(186003)(2906002)(4326008)(66446008)(66476007)(66946007)(66556008)(64756008)(76116006)(41300700001)(7696005)(316002)(71200400001)(110136005)(54906003)(478600001)(53546011)(5660300002)(26005)(6506007)(9686003)(52536014)(966005)(8676002)(8936002)(38070700005)(38100700002)(122000001)(86362001)(33656002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1NNYVhYUUZkTWFUUEpIM0VtQWxDVHh5RHlkcWtNRS9TM0l3TUJwMUc0WU5L?=
 =?utf-8?B?eVA4TDl1Z3NMUEkzZUh3ZkVJNHJ5YnRrZ2tkbFprL0lzcmxLcDNVRURxMGRD?=
 =?utf-8?B?NTlXK2x0RnJJME5iNnFlWDJRUEZtclNNQU9VZVdrZExad0xuTWY4K0Q5Qjd5?=
 =?utf-8?B?UE12RkI3V0FWWmZJTklwWUFyMGtrL1YyVGYrakNIcGU1QzhUblI4RXBmRmZN?=
 =?utf-8?B?VXhmNlRtSzNWUVZ3Q21sb0hDcGpPRXpEWDA1TndJZWk2Nmd4T2VuM0NrdnlX?=
 =?utf-8?B?NTFSV0FQU0dOV1crbi9wbllBUVdYRzZha1JSdFd4NFlQWmhRblJKYlpxN0pU?=
 =?utf-8?B?TVQrcmZJVUZTeUt1bjdKK3dvZXFzd1kwY3FUQVFmd1RGY1gwZ1N2dEdLeEtZ?=
 =?utf-8?B?ejRGSWRmUVMrRmxhOGhFOGhRa3dobmRGaGNpdUU4MHRJYXlXNUVnR2pQeEpQ?=
 =?utf-8?B?VzVQbk41aUtZZDZFR1lJazlBNVNsTjBMTS9NeURuVHpKbm9LQjFFTDFhc21y?=
 =?utf-8?B?UEZGUVZBaDg0dUlQV2F5QmY0ZTdCSWg3bnRUSFl6RVJTYm9PR3c2Vm1EY0lo?=
 =?utf-8?B?d2M3VVgyc1Fwa2RqbW9SM1ZGYnMvankvcVI3UnpVNmhoM0JVNk1tN254eG9z?=
 =?utf-8?B?enY0WlkraUl6by9hRE1qT1cyUURiR1YzbkJSVjhxSEdBK1R2OERERW5jSkpv?=
 =?utf-8?B?Mk4xMGExU0NhdXg2L2UrZ0lKbC9rQk9JV2s4eHNZOTRtU01JZzRGWlE3Qmpz?=
 =?utf-8?B?TkhDVlAxSW14RWd6YWsxS1lydUhLNjdSNEE1eW9SMnZ0OWExYjJWSU1RQk1z?=
 =?utf-8?B?a054M3E4clhZYkpWUWN5QWoraHhoNEVRN2VEZW0zcHNvRjVXLzA1L2R6Uy9t?=
 =?utf-8?B?M3hYalE3SmRnUXZudnlXOGlHVVphamMyS3VEMktyN2R6Rkw4UTV3QnRkN05n?=
 =?utf-8?B?MlJqQzNpOFc4WEczQTFYM3NCdnhJKzhKREFvbFRZcXlaL1h4YkFXUmptbnNz?=
 =?utf-8?B?aVhuak52SThKbGdMWGlMRFBzT1g2YWl6R3Q2bzRrRmFoaHU4dXA0b09FeE83?=
 =?utf-8?B?V2pWb2dhdVpwWXlHUXJEazA1aTBWMnI2Q1ltZHJ1alpENU5iZkNaU25XTGIr?=
 =?utf-8?B?WXRBeHdEOEprZmgyaE9mS3dFby9LbmkzYm9ITjc4aS9yT25NOHpGMUl5cWFG?=
 =?utf-8?B?cnZITzlEZmpZdjM0bk9ZME5HdW85RHRxOUZmZG1ZbTBpVTgySXEvMjloVUs4?=
 =?utf-8?B?VWxFQU4zdXFxVjFmOXVBWlNleU15Q3N0U2dXVDZaZm9xV2V2RlpscVV4dUt2?=
 =?utf-8?B?VTh3aUc3RGZCSWovNEI2SFZlQ284Q3FYMDNaemtUYjg5Tko1NjIrdUhneVd6?=
 =?utf-8?B?UGRnVWJ3Y1l1TGwySU5hcWFYelAvWE1kUEozSHBqZEZoV1pZM2Z3LzROR3dT?=
 =?utf-8?B?OHY1d0w4dEdOakNYaEVBWG1NcGVobGFmaDMyQ0pnN0xCSmdNdUY1Mk9ncUlJ?=
 =?utf-8?B?SFhnd2Q5aEJ6alN5a0NQSElOQ256Vkg3VU1tVzRWQU5VK2FLT2lDNENqUGp6?=
 =?utf-8?B?Mms1cjgwdWhMdjgxbzBoY01aWnNIckx5c25hdWg0dHQxSk9KSGlpNVlYOSt5?=
 =?utf-8?B?L1ZUd21keHk3U28wa2pZeFR3T29PWVl2RVE0eEk2aHhZS0p1a3RrTEZIZ3g0?=
 =?utf-8?B?RGZ2bGNZRUNBeEUrYWxMaDdMc2lGeWc4ZmpJY09DbnVqdU5Fd0hKZ0cxUkpn?=
 =?utf-8?B?c3owd1hqRXJLQVV1Z25PNVo3WklNODJyMWM5Vmw3UmlWMjhTbkJORzJ5VkN4?=
 =?utf-8?B?dkttVDJDeGR6alRNVitJQ2R4dCtENWJRaHBpYTB3MFQzS2tmZTlaZkdLU3po?=
 =?utf-8?B?YmFUUUExcUw4NHhWNDVsM1lOQnFCSHRxcnhPbkRXazI0WkY5Q2toNldIY3V2?=
 =?utf-8?B?SnEwMzd6WXNMN2N2MkxmTjgzbHFJVCtxWHkzbkFQVFZBajh5L2RGeWdNcUlC?=
 =?utf-8?B?cXQ2TXNyMk9CZVVJNVBQVXFPNnIwMktRKzd5VDI3enhhV0tyQ0l3WkRjcnND?=
 =?utf-8?B?QW00ejV3T3BJUUFUV1BZeUZ0MjEwdHFsYlJacHMwMTVpWkVMT254NkRXOWZo?=
 =?utf-8?Q?hSlc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda9cf6e-b9a2-4018-9abf-08db5a73ca91
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 03:22:36.9096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 50JFGxHFDSpiwpXYC4l5cT60NSqxnTBIP/g9MBoaz/rZ/PgvuSlRoYX6m60XuuGQWDt2fKMmdB4HRPcwHLdAzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29t
Pg0KPiBTZW50OiBTdW5kYXksIE1heSAyMSwgMjAyMyAyOjM5IEFNDQo+IFRvOiBQYW5lZXIgU2Vs
dmFtLCBBcnVucHJhdmluIDxBcnVucHJhdmluLlBhbmVlclNlbHZhbUBhbWQuY29tPjsgYW1kLQ0K
PiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hyaXN0aWFu
LktvZW5pZ0BhbWQuY29tPjsgWGlhbywgU2hhbmUgPHNoYW5lLnhpYW9AYW1kLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSF0gUmV2ZXJ0ICJkcm0vYW1kZ3B1OiByZW1vdmUgVE9QRE9XTiBmbGFn
cyB3aGVuDQo+IGFsbG9jYXRpbmcgVlJBTSBpbiBsYXJnZSBiYXIgc3lzdGVtIg0KPg0KPiBBbSAy
MDIzLTA1LTIwIHVtIDA1OjI1IHNjaHJpZWIgQXJ1bnByYXZpbiBQYW5lZXIgU2VsdmFtOg0KPiA+
IFRoaXMgcmV2ZXJ0cyBjb21taXQgYzEwNTUxODY3OWI2ZTg3MjMyODc0ZmZjOTg5ZWM0MDNiZWU1
OTY2NC4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggZGlzYWJsZXMgdGhlIFRPUERPV04gZmxhZyBmb3Ig
QVBVIGFuZCBmZXcgZEdQVSBjYXJkcyB3aGljaA0KPiA+IGhhcyB0aGUgVlJBTSBzaXplIGVxdWFs
IHRvIHRoZSBCQVIgc2l6ZS4NCj4NCj4gV2l0aCByZXNpemFibGUgQkFScyBpdCdzIG5vdCB0aGF0
IHJhcmUuDQo+DQo+DQo+ID4NCj4gPiBXaGVuIHdlIGVuYWJsZSB0aGUgVE9QRE9XTiBmbGFnLCB3
ZSBnZXQgdGhlIGZyZWUgYmxvY2tzIGF0IHRoZSBoaWdoZXN0DQo+ID4gYXZhaWxhYmxlIG1lbW9y
eSByZWdpb24gYW5kIHdlIGRvbid0IHNwbGl0IHRoZSBsb3dlciBvcmRlciBibG9ja3MuDQo+ID4g
VGhpcyBjaGFuZ2UgaXMgcmVxdWlyZWQgdG8ga2VlcCBvZmYgdGhlIGZyYWdtZW50YXRpb24gcmVs
YXRlZCBpc3N1ZXMNCj4gPiBwYXJ0aWN1bGFybHkgaW4gQVNJQyB3aGljaCBoYXMgVlJBTSBzcGFj
ZSA8PSA1MDBNaUINCg0KQXMgZmFyIGFzIEkgY2FuIHVuZGVyc3RhbmQgdGhhdCwgYm90aCB3YXlz
IG1heSBjYXVzZSBmcmFnbWVudGF0aW9uIGlzc3Vlcy4NCg0KQXMgSSBjYW4gdW5kZXJzdGFuZCB0
aGF0IHJlbW92ZSBUT1BET1dOIGZsYWdzIG1heSBnZXQgdHdvIHByb3M6DQoxKSBJdCBjYW4gcmVk
dWNlIHRoZSByZXNlYXJjaCB0aW1lIHRvIE8oMSk7DQoyKSBSZWR1Y2UgdGhlIHJpc2sgb2Ygc3Bs
aXR0aW5nIGhpZ2hlciBvcmRlciBpbnRvIGxvd2VyIG9yZGVycyB3aGVuIGFsbG9jYXRpbmcgYmxv
Y2tzLg0KDQpCdXQgYXMgZm9yIHRoZSBzZWNvbmQgcG9pbnQsIFJlbW92aW5nIFRPUERPV04gZmxh
Z3Mgc3RpbGwgY2FycmllcyB0aGUgcmlzayBvZiBjYXVzaW5nDQpmcmFnbWVudGF0aW9uIGlzc3Vl
IG9uIHNvbWUgc2NlbmFyaW9zLg0KRm9yIGV4YW1wbGUsIHRoZSBhcHBzIG5lZWQgYWxsb2NhdGUg
KDFNICsgNEspIFZSQU0gc2l6ZSwgd2hpY2ggaXMgbm90IGEgcG93ZXIgb2YgdHdvLg0KDQpDYXNl
IDE6IElmIG5vdCB1c2luZyBUT1BET1dOIGZsYWcsIHdlIHdpbGwgYWxsb2NhdGUgMU0gb3JkZXIg
c2l6ZSBhbmQgNEsgb3JkZXIgc2l6ZSBmcm9tIGRpZmZlcmVudCBvcmRlci4NCi0tQW5kIHRoZW4g
aWYgdGhpcyA0SyBidWRkeSBhbmQgMU0gYnVkZHkgYXJlIGZyZWVkLCBpdCBtYXkgcHJldmVudCB0
aGUgc3lzdGVtIGZyb20gbWVyZ2luZyA0SyhvciAxTSkgdG8gOEsoMk0pIG9yZGVyLg0KLS1JZiB0
aGUgYXBwIGhhcyBtYW55IHN1Y2ggYWxsb2NhdGlvbiByZXF1aXJlbWVudHMsIGl0IG1heSBjYXVz
ZSBmcmFnbWVudGF0aW9uIGlzc3VlIHVuZGVyIG1lbW9yeSBzdHJlc3MuDQoNCkNhc2UgMjogSWYg
dXNpbmcgVE9QRE9XTiBmbGFnLCB3ZSB3aWxsIGZpbmQgdGhlIGhpZ2hlc3Qgb3JkZXIgd2hpY2gg
aXMgc3VpdGFibGUgZm9yIDRLIGFuZCAxTSBuZWVkcy4NCi0tQXNzdW1pbmcgdGhlIGhpZ2hlc3Qg
b3JkZXIgc2l6ZSBpcyA4TSwgdGhlbiB3ZSB3aWxsIHNwbGl0IHRoaXMgOE0gdG8gbG93ZXIgb3Jk
ZXIgdG8gbWVldCB0aGUgbmVlZHMgb2YgMU0gYW5kIDRLIHNpemVzLCByZXNwZWN0aXZlbHkuDQot
LUluIHN1Y2ggY2FzZSB0aGUgOE0gc2l6ZSB3aWxsIHNwbGl0IGludG8gZGlmZmVyZW50IGxvd2Vy
IG9yZGVycy4NCi0tSWYgYW55IG90aGVyIHRocmVhZCBvciBwcm9jZXNzIG5lZWQgYWxsb2NhdGUg
NEsgb3IgMU0gVlJBTSwgYW5kIHRoZXJlIGlzIGFsc28gYSBjaGFuY2UgdG8gcHJldmVudCB0aGUg
c3lzdGVtIGZyb20gbWVyZ2luZyA0SyhvciAxTSkgdG8gOEsob3IgMk0pIG9yZGVyLg0KDQpJZiB0
aGVyZSBhcmUgc28gbWFueSBuZWVkcyB0byBhbGxvY2F0ZSBub3QgcG93ZXIgb2YgdHdvIHBhZ2Vz
IGZyb20gYXBwcywgICBvbmUgb2YgdGhlIGNob29zZSBpcyB0byB1c2Ugc3ViYWxsb2NhdG9yIGZy
b20gVU1EIHN1Y2ggYXMgd2hhdCBST0NyIGRvZXMuDQpUaGF0IG1lYW5zIHN1YmFsbG9jYXRvciBj
YW4gYWxsb2NhdGUgcG93ZXIgb2YgdHdvIHBhZ2VzKGZvciBleGFtcGxlIDJNIGJ5dGVzKSBmcm9t
IGRyaXZlciwgYW5kIHRoZSBhcHAgY2FuIGFsbG9jYXRlIG1lbW9yeSBmcm9tIHN1YmFsbG9jYXRv
ci4NCkluIHN1Y2ggd2F5LCBpdCBtYXkgcmVkdWNlIHRoZSByaXNrIG9mIGNhdXNpbmcgZnJhZ21l
bnRhdGlvbiBpc3N1ZXMuICBCdXQgSSBhbSBub3Qgc3VyZSB0aGF0IHN1Y2ggYW4gb3B0aW9uIGlz
IGZlYXNpYmxlLg0KDQpNYXliZSBjYXNlIDIgb2NjdXJzIGxlc3MgZnJlcXVlbnRseSB0aGFuIGNh
c2Ugb25lLCB0aGVuIHdlIHNob3VsZCB1c2UgVE9QRE9XTiBmbGFncyB3aGV0aGVyIHRoZSBzeXN0
ZW0gaXMgbGFyLWJhciBvciBub3QuDQoNCkJlc3QgUmVnYXJkcywNClNoYW5lDQoNCj4NCj4gSWYg
VE9QRE9XTiBoYXMgdGhlc2UgZ2VuZXJhbCBiZW5lZml0cywgdGhlbiB3b3VsZCBpdCBtYWtlIHNl
bnNlIHRvIGFsbG9jYXRlDQo+IHZpc2libGUgbWVtb3J5IFRPUERPV04gYXMgd2VsbCwgb24gbGFy
Z2UtQkFSIEdQVXM/IFdpdGhvdXQga25vd2luZyB0b28NCj4gbXVjaCBhYm91dCB0aGUgaW50ZXJu
YWxzIG9mIHRoZSBhbGxvY2F0b3IsIG15IGludHVpdGlvbiB0ZWxscyBtZSB0aGF0IHVzaW5nIG9u
bHkNCj4gb25lIGFsbG9jYXRpb24gc3RyYXRlZ3kgaGFzIGEgYmV0dGVyIGNoYW5jZSBvZiBtaW5p
bWl6aW5nIGZyYWdtZW50YXRpb24gdGhhbg0KPiBtaXhpbmcgdHdvIGFsbG9jYXRpb24gc3RyYXRl
Z2llcyBmb3Igbm8gZ29vZCByZWFzb24uDQo+DQo+IFJlZ2FyZHMsDQo+ICAgIEZlbGl4DQo+DQo+
DQo+ID4NCj4gPiBIZW5jZSwgd2UgYXJlIHJldmVydGluZyB0aGlzIHBhdGNoLg0KPiA+DQo+ID4g
R2l0bGFiIGlzc3VlIGxpbmsgLQ0KPiA+IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9k
cm0vYW1kLy0vaXNzdWVzLzIyNzANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFydW5wcmF2aW4g
UGFuZWVyIFNlbHZhbQ0KPiA+IDxBcnVucHJhdmluLlBhbmVlclNlbHZhbUBhbWQuY29tPg0KPiA+
IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIHwg
MiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X29iamVjdC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0
LmMNCj4gPiBpbmRleCAyYmQxYTU0ZWU4NjYuLmNhNWZjMDdmYWY2YyAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMNCj4gPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMNCj4gPiBAQCAtMTM5LDcg
KzEzOSw3IEBAIHZvaWQgYW1kZ3B1X2JvX3BsYWNlbWVudF9mcm9tX2RvbWFpbihzdHJ1Y3QNCj4g
PiBhbWRncHVfYm8gKmFibywgdTMyIGRvbWFpbikNCj4gPg0KPiA+ICAgICAgICAgICAgIGlmIChm
bGFncyAmIEFNREdQVV9HRU1fQ1JFQVRFX0NQVV9BQ0NFU1NfUkVRVUlSRUQpDQo+ID4gICAgICAg
ICAgICAgICAgICAgICBwbGFjZXNbY10ubHBmbiA9IHZpc2libGVfcGZuOw0KPiA+IC0gICAgICAg
ICAgIGVsc2UgaWYgKGFkZXYtPmdtYy5yZWFsX3ZyYW1fc2l6ZSAhPSBhZGV2LQ0KPiA+Z21jLnZp
c2libGVfdnJhbV9zaXplKQ0KPiA+ICsgICAgICAgICAgIGVsc2UNCj4gPiAgICAgICAgICAgICAg
ICAgICAgIHBsYWNlc1tjXS5mbGFncyB8PSBUVE1fUExfRkxBR19UT1BET1dOOw0KPiA+DQo+ID4g
ICAgICAgICAgICAgaWYgKGZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9DT05USUdVT1VT
KQ0K
