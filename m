Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB58DC47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 04:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3413F10F7F9;
	Wed, 27 Mar 2024 04:52:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kEoBR0HJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4231710F7F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 04:52:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+XVoNcywpAX1vMFB/jot9Ax3kU58w3D8/WVmwat6cWxnnFQg/k/YEIrE7UotfvzU+egZWo9csoRLC3n81Y3zuXuMsizTzqMFiRYi6CSBZPVWTXGBQckJ1XXdMdR430QOgrHfqGf9ntiL81BoHPOu2rgQ+16NmKiU0EMcFudhcSlZf5U3EEaTQ57pDNH+kxwJ9Nh3/SqoJr42DLxS9MK8kMy+LQDL1NjgHC11/nbt/EvmORM3/DU/tD8jGWVg3ZDEQaPxNkFAi8+Eds1SBdSB2yDz/kYQVZsqHNU9C+8Adl1SZFa7AAs8Dd/ds319Bq9o/UIKaNeF6//pBf5mqMxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKp6nlZQ6ei+bAIaHnlFrQ4el15wn+c2fSeBN5oj6xk=;
 b=RYSKNXW8qbP9JteNV198vWn1hTnp9HNemSf1AONYKIpOa4qJGF52mlo2IAUGRARzfKAYNzFnDI3AEyiTCwvzfQV3uBGMC/79gXwN3sZvRNBUZBg6RBazlyyUHDj31vglvV2hmrpin9dKcALM66/WQeNmRwlMk1MncNQ7jlmc/8xp7Y1TLCRYalqQympDT5sGGsUVVUXpVTUZGlyS384bD58nRX3uQpArO/WaEtPqpDz6+g9bVDMPls2hJMnolkyPaO9GY5F1wWP2nIblAVK34Vhuo/3Jf9XxVjgKqbBR4vKW62KB6B+q06y6Sj8FNr78VcsHJyk4a2WD4dvWFNcmaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKp6nlZQ6ei+bAIaHnlFrQ4el15wn+c2fSeBN5oj6xk=;
 b=kEoBR0HJ4efzP9BWEqS0RHIaI8mfr8aXwGf9awnGIGDwSZwn0PKSNdkFAg2Ez/cFmGXgA8fKBTp1owWy+Pcpy95spUSN8xIM6ZivD4Az62/L9CZsGg1Hf7oF0e6I9VoAQnSBdPRIlGE8QvpbjgYkMkMX96ENXOOdukye0nJEq6M=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 04:52:00 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::640a:8c9:386d:ecaf]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::640a:8c9:386d:ecaf%4]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 04:52:00 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Documentation: add a page on amdgpu debugging
Thread-Topic: [PATCH] Documentation: add a page on amdgpu debugging
Thread-Index: AQHadvIORey8WZ9yzkKsqvZ7qGdfYrE5AjmAgBIUs/A=
Date: Wed, 27 Mar 2024 04:52:00 +0000
Message-ID: <CH2PR12MB41523CCC330437FBFBE229ABFE342@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20240315160108.2595995-1-alexander.deucher@amd.com>
 <CADnq5_PMfhTQ+=aSJ5DqCj3p5hjbQUHZsx=3xXc0FEqL_9WDiQ@mail.gmail.com>
In-Reply-To: <CADnq5_PMfhTQ+=aSJ5DqCj3p5hjbQUHZsx=3xXc0FEqL_9WDiQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=365ae79e-73b5-4290-b93e-48bbd75ec92c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-27T04:51:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|MN2PR12MB4110:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vcVpcLzYcujewNIR0WbwMr9Nqcy5yHYKXrwlhDTOCPCqPDOAXGE9cO7+aZwjx7S3fAKAUtycKc0CClz8RlcboUVCv9/JjjT4VuTeu6Ld4eADF0Nh5rpCT2/f2ys+KabI9itm0V5g3hbEOKnbTilgcKUKmELIjY187981jML3JStdvomaFZ4B7gCrCvaXY4ZPOPsaQkI4hyJLmXx6u8BX34RYaPvdqa4lkiMt3Nkof3wo87Xcgz9bURLs8NRYiRfWNkoxUval3lCVyaS5Uge0hV8Xg9SvaQDefc/bC5jazsIRsrAeY4KadAZ7JeRNzJ7J3BCeO2Eib1wRMLvo7leGJs5pVg+py/scAg7VDW4To2B4drhueWx2JXAsABrcxyPxXlTcRyywypHyStTZg0qzry9PpCGmZaswLp2Ybb4LJjdPxnxVY3GLnEKfAFTLODoM+XGSkxKk0z3lr5fruIRNI1KOkAALLaMTaqiZXv3ztCj7zvSCz7tbDqGkN7z+8T99+IrE1Bq3xS+fz/OjoMH94Mo614X93vGJSJANcUcyGILtoEYzkE9hUTkJv75MYh7M/xb8snYe8GXNWUmIlRPOZfbDptbFIs0RO4p0uR5T5c4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUw2dTducHVoNHdSZHM0NWhhQitsU2tUZS9LU0JpdjJIRnE2WFdLNDZtaVd5?=
 =?utf-8?B?N0ltRHlsaVY1VEJpOGNtdVlWMk5MS09pc21sRFFoTzNNTENWV2Zkd0NKbWJV?=
 =?utf-8?B?bjN6K2hEaFRqTUNKSkppeTV4dDVNRmZtY0pkMCtoQ0dVa09TSlhFSTRHYllF?=
 =?utf-8?B?cEVnclB4RTBTbUIzZGxrYXVNN3RjTHBEdEhCYnh1RjY2Rk02eEowa3FXT1Y4?=
 =?utf-8?B?VGxnV2dMbGxWbWFHM29ib1BMOFNMdlZrUVdUUmcrcmZPSzIzTkRoSDNyckR3?=
 =?utf-8?B?eER4UjFLbWtYMzhnQ3RhZFBCWkxwTlNGOE5OQm5QOEE2OXFsNEI3NEQ5dFVO?=
 =?utf-8?B?K2xReVlZWFpLb1RBK2tvVllaL2lwcEZNMGFmakl1YWlpS0U2enBLL0pOcENv?=
 =?utf-8?B?bzVWVU1ySTNIbE9ub0dMelBXQlI3OHNDTkYrdG1STUNoc2xaVWh1Ynh2akVG?=
 =?utf-8?B?WGRWcFM5a1pidTQrVVVIQ2l5Z3NPc3Fuc3R2YWxEd1NJSG5RekZKdGdjZ1JJ?=
 =?utf-8?B?QWN4eUZMYllKcVVwenU0NjVVeVliRFgveFFPMXphSmtjUVhUclphelBnSGhK?=
 =?utf-8?B?T0F5dk5xRFpMR0ppVzg3N3BFWGd6SW51YWJTa1BSbzdGMmxNbFhiMzZZMkJ0?=
 =?utf-8?B?WXQrck40TlBHL2l4S2xHL3FPNU8ycVh3UzFSMWkrQ2lpTExib2REdVJ6TkNx?=
 =?utf-8?B?S2RwWUluWXNadUd4KzI4a3hJMk1mNDlkdUdEV0Q2TkpraU5BdHM3Y0EzdTJt?=
 =?utf-8?B?djdqZFZlbkVZaDZadW5kK1pUQVRYL1RCeWFxMU1DOHhQUTJmTDRHN2s1Y1JH?=
 =?utf-8?B?TEdKalI2Wm1MOXFycW9mQkpabHFRSmFrSlgyRkkwOFlYWDgxdUhFVnZzQXQz?=
 =?utf-8?B?K3ZZOE4wZlJycXFlckl5V0N3UVpGSEZsaTFpUmpMbkptWjlyWUlvVDJIYVlv?=
 =?utf-8?B?aFZvbGc3WGNOd051eTBoTVlEcGp2WWdjMm0xL05IbDV2NStVeFVuaHRtVStE?=
 =?utf-8?B?UDdyZzJ4TElQR1Q3dElEMmVFdmhYWXYyc1UreXlVMGd2UTlTVHZ1bUMvdlpz?=
 =?utf-8?B?M0JmS21Kc29SNGxRSW5NKzZRV05JRXQzRkN5RUt2SFI2eHVYUERlVXk0YkRS?=
 =?utf-8?B?cWVrMkllSXd5emFJVWpoQUZ1eFpQYi91MGQrSmo0ZlZoMVZXbmNKYkN3S3Zy?=
 =?utf-8?B?OUNxbVBzZENOUk4yWWJtKzZVSDJkMmxxYlRNaUtSL3RNUHB5YWRxRkdndFA3?=
 =?utf-8?B?bE5hbDdlUGNTeWRBOFgrZWkvdERCUno4V2p0NEwrM0svYTRFS3BTMGtvSG1J?=
 =?utf-8?B?djY3MTJYNGp1Z2N1K2paWXhMV013bE8wUVpGT01PeGZGWTRoOHdObmJJeFQ4?=
 =?utf-8?B?cVcyY1JtS21Eam81aFMrdkRWTEZnM0QzcVVmZjZta3VOSjkxU2RRaXJGcmEw?=
 =?utf-8?B?cDNmdXYzMXhEdVdKMWNFeDk5UUtjOCswczZiVlBZMHM1NlVRWnFua2Z4aDRB?=
 =?utf-8?B?UnZhL1d6S0k1MnpVTTBMdVFsM0JlNE93cWJKOFlmWWt6WWtOREVPVjJZbjJi?=
 =?utf-8?B?TTVQWEh5b3FPU0M3UWIyVDQ2ODQ3YlBIMnkyNzNzVmxrWkhxZzZ4YWxlTHB3?=
 =?utf-8?B?Q1NYWHh6ZWs0OWVyUmMyZ1RSYmRLSHQva1RoZEJoRHRQNS92Wi9nbEQxTjI2?=
 =?utf-8?B?aXJzcTJEZkI3RnduNWtwNUdhbEhjS3hwRnVHNWtQZXFQOHFzQVo0TDJ5V3FB?=
 =?utf-8?B?TGp0dFZ1Rithb2VINVNxbHFKendoWUFCc2F4YlhHaG5leDUyTmQ4dncvK1M2?=
 =?utf-8?B?bSszK2xvOE84R0JNVm13cUhsR3VKWFlEZVJDRjRVVjduRmZRRlAyNnVZZndq?=
 =?utf-8?B?cWQvWnhxSTZWbVBGbzhLcy9ycEFQNkJ3MmZDQW1yeCs2WVFBRUdXcjlPanBL?=
 =?utf-8?B?UUVqYnJkRHplRldCSjVTMXd3Rk1DZUlmU3QxemM4Vis2U1Y3VTRJM0RBUmk0?=
 =?utf-8?B?WEFFb1dTZlp3cDEzZnkxTW5lYnhBZ0c3bTY4SllXanBlUDA3U1BZMVBJRE1H?=
 =?utf-8?B?TjFlRVVFckUxbVZOdTRKK3RSaFhvZ2gyS1pSd29nVFNIZzFiZ1ljVWpDc2lt?=
 =?utf-8?Q?VFcA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eefed446-b408-4d20-8724-08dc4e19a35c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 04:52:00.1208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qj/fKeuU/8q9QA7e7ZSYb5NM41pcjke4AueGmkmIWm10ISaMyQpyBObbPIZoBf4w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBGZWlmZWkg
WHUgPEZlaWZlaS5YdUBhbWQuY29tPg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVo
YWxmIE9mIEFsZXggRGV1Y2hlcg0KU2VudDogU2F0dXJkYXksIE1hcmNoIDE2LCAyMDI0IDEyOjQ1
IEFNDQpUbzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0K
Q2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBE
b2N1bWVudGF0aW9uOiBhZGQgYSBwYWdlIG9uIGFtZGdwdSBkZWJ1Z2dpbmcNCg0KT24gRnJpLCBN
YXIgMTUsIDIwMjQgYXQgMTI6MDfigK9QTSBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+IHdyb3RlOg0KPg0KPiBDb3ZlcnMgR1BVIHBhZ2UgZmF1bHQgZGVidWdnaW5nIGFu
ZCBhZGRzIGEgcmVmZXJlbmNlIHRvIHVtci4NCj4NCj4gdjI6IHVwZGF0ZSBjbGllbnQgaWRzIHRv
IGluY2x1ZGUgU1FDL0cNCj4NCj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vZ3B1L2FtZGdwdS9k
ZWJ1Z2dpbmcucnN0IHwgNzkgKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIERvY3VtZW50
YXRpb24vZ3B1L2FtZGdwdS9pbmRleC5yc3QgICAgIHwgIDEgKw0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCA4MCBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9n
cHUvYW1kZ3B1L2RlYnVnZ2luZy5yc3QNCj4NCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
Z3B1L2FtZGdwdS9kZWJ1Z2dpbmcucnN0DQo+IGIvRG9jdW1lbnRhdGlvbi9ncHUvYW1kZ3B1L2Rl
YnVnZ2luZy5yc3QNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAw
Li44YjdmZGNkZjExNTgNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2dw
dS9hbWRncHUvZGVidWdnaW5nLnJzdA0KPiBAQCAtMCwwICsxLDc5IEBADQo+ICs9PT09PT09PT09
PT09PT0NCj4gKyBHUFUgRGVidWdnaW5nDQo+ICs9PT09PT09PT09PT09PT0NCj4gKw0KPiArR1BV
Vk0gRGVidWdnaW5nDQo+ICs9PT09PT09PT09PT09PT0NCj4gKw0KPiArVG8gYWlkIGluIGRlYnVn
Z2luZyBHUFUgdmlydHVhbCBtZW1vcnkgcmVsYXRlZCBwcm9ibGVtcywgdGhlIGRyaXZlcg0KPiAr
c3VwcG9ydHMgYSBudW1iZXIgb2Ygb3B0aW9ucyBtb2R1bGUgcGFyYW10ZXJzOg0KPiArDQo+ICtg
dm1fZmF1bHRfc3RvcGAgLSBJZiBub24tMCwgaGFsdCB0aGUgR1BVIG1lbW9yeSBjb250cm9sbGVy
IG9uIGEgR1BVIHBhZ2UgZmF1bHQuDQo+ICsNCj4gK2B2bV91cGRhdGVfbW9kZWAgLSBJZiBub24t
MCwgdXNlIHRoZSBDUFUgdG8gdXBkYXRlIEdQVSBwYWdlIHRhYmxlcw0KPiArcmF0aGVyIHRoYW4g
dGhlIEdQVS4NCj4gKw0KPiArDQo+ICtEZWNvZGluZyBhIEdQVVZNIFBhZ2UgRmF1bHQNCj4gKz09
PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiArDQo+ICtJZiB5b3Ugc2VlIGEgR1BVIHBhZ2Ug
ZmF1bHQgaW4gdGhlIGtlcm5lbCBsb2csIHlvdSBjYW4gZGVjb2RlIGl0IHRvDQo+ICtmaWd1cmUg
b3V0IHdoYXQgaXMgZ29pbmcgd3JvbmcgaW4geW91ciBhcHBsaWNhdGlvbi4gIEEgcGFnZSBmYXVs
dCBpbg0KPiAreW91ciBrZXJuZWwgbG9nIG1heSBsb29rIHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+
ICsNCj4gKzo6DQo+ICsNCj4gKyBbZ2Z4aHViMF0gbm8tcmV0cnkgcGFnZSBmYXVsdCAoc3JjX2lk
OjAgcmluZzoyNCB2bWlkOjMgcGFzaWQ6MzI3NzcsIGZvciBwcm9jZXNzIGdseGluZm8gcGlkIDI0
MjQgdGhyZWFkIGdseGluZm86Y3MwIHBpZCAyNDI1KQ0KPiArICAgaW4gcGFnZSBzdGFydGluZyBh
dCBhZGRyZXNzIDB4MDAwMDgwMDEwMjgwMDAwMCBmcm9tIElIIGNsaWVudCAweDFiDQo+ICsgKFVU
Q0wyKQ0KPiArIFZNX0wyX1BST1RFQ1RJT05fRkFVTFRfU1RBVFVTOjB4MDAzMDEwMzANCj4gKyAg
ICAgICBGYXVsdHkgVVRDTDIgY2xpZW50IElEOiBUQ1AgKDB4OCkNCj4gKyAgICAgICBNT1JFX0ZB
VUxUUzogMHgwDQo+ICsgICAgICAgV0FMS0VSX0VSUk9SOiAweDANCj4gKyAgICAgICBQRVJNSVNT
SU9OX0ZBVUxUUzogMHgzDQo+ICsgICAgICAgTUFQUElOR19FUlJPUjogMHgwDQo+ICsgICAgICAg
Ulc6IDB4MA0KPiArDQo+ICtGaXJzdCB5b3UgaGF2ZSB0aGUgbWVtb3J5IGh1YiwgZ2Z4aHViIGFu
ZCBtbWh1Yi4gIGdmeGh1YiBpcyB0aGUNCj4gK21lbW9yeSBodWIgdXNlZCBmb3IgZ3JhcGhpY3Ms
IGNvbXB1dGUsIGFuZCBzZG1hIG9uIHNvbWUgY2hpcHMuICBtbWh1Yg0KPiAraXMgdGhlIG1lbW9y
eSBodWIgdXNlZCBmb3IgbXVsdGktbWVkaWEgYW5kIHNkbWEgb24gc29tZSBjaGlwcy4NCj4gKw0K
PiArTmV4dCB5b3UgaGF2ZSB0aGUgdm1pZCBhbmQgcGFzaWQuICBJZiB0aGUgdm1pZCBpcyAwLCB0
aGlzIGZhdWx0IHdhcw0KPiArbGlrZWx5IGNhdXNlZCBieSB0aGUga2VybmVsIGRyaXZlciBvciBm
aXJtd2FyZS4gIElmIHRoZSB2bWlkIGlzDQo+ICtub24tMCwgaXQgaXMgZ2VuZXJhbGx5IGEgZmF1
bHQgaW4gYSB1c2VyIGFwcGxpY2F0aW9uLiAgVGhlIHBhc2lkIGlzDQo+ICt1c2VkIHRvIGxpbmsg
YSB2bWlkIHRvIGEgc3lzdGVtIHByb2Nlc3MgaWQuICBJZiB0aGUgcHJvY2VzcyBpcyBhY3RpdmUN
Cj4gK3doZW4gdGhlIGZhdWx0IGhhcHBlbnMsIHRoZSBwcm9jZXNzIGluZm9ybWF0aW9uIHdpbGwg
YmUgcHJpbnRlZC4NCj4gKw0KPiArVGhlIEdQVSB2aXJ0dWFsIGFkZHJlc3MgdGhhdCBjYXVzZWQg
dGhlIGZhdWx0IGNvbWVzIG5leHQuDQo+ICsNCj4gK1RoZSBjbGllbnQgSUQgaW5kaWNhdGVzIHRo
ZSBHUFUgYmxvY2sgdGhhdCBjYXVzZWQgdGhlIGZhdWx0Lg0KPiArU29tZSBjb21tb24gY2xpZW50
IElEczoNCj4gKw0KPiArLSBDQi9EQjogVGhlIGNvbG9yL2RlcHRoIGJhY2tlbmQgb2YgdGhlIGdy
YXBoaWNzIHBpcGUNCj4gKy0gQ1BGOiBDb21tYW5kIFByb2Nlc3NvciBGcm9udGVuZA0KPiArLSBD
UEM6IENvbW1hbmQgUHJvY2Vzc29yIENvbXB1dGUNCj4gKy0gQ1BHOiBDb21tYW5kIFByb2Nlc3Nv
ciBHcmFwaGljcw0KPiArLSBUQ1AvU1FDL1NRRzogU2hhZGVycw0KPiArLSBTRE1BOiBTRE1BIGVu
Z2luZXMNCj4gKy0gVkNOOiBWaWRlbyBlbmNvZGUvZGVjb2RlIGVuZ2luZXMNCj4gKy0gSlBFRzog
SlBFRyBlbmdpbmVzDQo+ICsNCj4gK1BFUk1JU1NJT05fRkFVTFRTIGRlc2NyaWJlIHdoYXQgZmF1
bHRzIHdlcmUgZW5jb3VudGVyZWQ6DQo+ICsNCj4gKy0gYml0IDA6IHRoZSBQVEUgd2FzIG5vdCB2
YWxpZA0KPiArLSBiaXQgMTogdGhlIFBURSByZWFkIGJpdCB3YXMgbm90IHNldA0KPiArLSBiaXQg
MjogdGhlIFBURSB3cml0ZSBiaXQgd2FzIG5vdCBzZXQNCj4gKy0gYml0IDM6IHRoZSBQVEUgZXhl
Y3V0ZSBiaXQgd2FzIG5vdCBzZXQNCj4gKw0KPiArRmluYWxseSwgUlcsIGluZGljYXRlcyB3aGV0
aGVyIHRoZSBhY2Nlc3Mgd2FzIGEgcmVhZCAoMCkgb3IgYSB3cml0ZSAoMSkuDQo+ICsNCj4gK0lu
IHRoZSBleGFtcGxlIGFib3ZlLCBhIHNoYWRlciAoY2xpZW5kIGlkID0gVENQKSBnZW5lcmF0ZWQg
YSByZWFkIChSVw0KPiArPSAweDApIHRvIGFuIGludmFsaWQgcGFnZSAoUEVSTUlTU0lPTl9GQVVM
VFMgPSAweDMpIGF0IEdQVSB2aXJ0dWFsDQo+ICthZGRyZXNzIDB4MDAwMDgwMDEwMjgwMDAwMC4g
IFRoZSB1c2VyIGNhbiB0aGVuIGluc3BlY3QgY2FuIHRoZW4NCj4gK2luc3BlY3QgdGhlaXIgc2hh
ZGVyDQoNCnJlbW92ZWQgdGhlIGR1cGxpY2F0ZWQgdGV4dCBhYm92ZSBsb2NhbGx5Lg0KDQpBbGV4
DQoNCj4gK2NvZGUgYW5kIHJlc291cmNlIGRlc2NyaXB0b3Igc3RhdGUgdG8gZGV0ZXJtaW5lIHdo
YXQgY2F1c2VkIHRoZSBHUFUgcGFnZSBmYXVsdC4NCj4gKw0KPiArVU1SDQo+ICs9PT0NCj4gKw0K
PiArYHVtciA8aHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL3RvbXN0ZGVuaXMvdW1yPmBf
IGlzIGEgZ2VuZXJhbA0KPiArcHVycG9zZSBHUFUgZGVidWdnaW5nIGFuZCBkaWFnbm9zdGljcyB0
b29sLiAgUGxlYXNlIHNlZSB0aGUgdW1yDQo+ICtkb2N1bWVudGF0aW9uIGZvciBtb3JlIGluZm9y
bWF0aW9uIGFib3V0IGl0cyBjYXBhYmlsaXRpZXMuDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2dwdS9hbWRncHUvaW5kZXgucnN0DQo+IGIvRG9jdW1lbnRhdGlvbi9ncHUvYW1kZ3B1L2lu
ZGV4LnJzdA0KPiBpbmRleCA5MTJlNjk5ZmQzNzMuLjg0N2UwNDkyNDAzMCAxMDA2NDQNCj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9ncHUvYW1kZ3B1L2luZGV4LnJzdA0KPiArKysgYi9Eb2N1bWVudGF0
aW9uL2dwdS9hbWRncHUvaW5kZXgucnN0DQo+IEBAIC0xNSw0ICsxNSw1IEBAIE5leHQgKEdDTiks
IFJhZGVvbiBETkEgKFJETkEpLCBhbmQgQ29tcHV0ZSBETkEgKENETkEpIGFyY2hpdGVjdHVyZXMu
DQo+ICAgICByYXMNCj4gICAgIHRoZXJtYWwNCj4gICAgIGRyaXZlci1taXNjDQo+ICsgICBkZWJ1
Z2dpbmcNCj4gICAgIGFtZGdwdS1nbG9zc2FyeQ0KPiAtLQ0KPiAyLjQ0LjANCj4NCg==
