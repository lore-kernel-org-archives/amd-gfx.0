Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7CBC6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 17:30:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E389310E3DC;
	Mon, 27 Mar 2023 17:30:36 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0655510E3DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 17:30:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5nkDFDAY3XUYBbXF4UaEQrWrAaTH93hlXQvy9P7/2thLkwsdQd79k8h9v4qWfcwESdJ5Xtntlw3Im4QTX/F9k892gHmQKIZKPuX0N5bz2kq0h2BnuRaIVuJcZAPNVJ+Hlea0MDsZ2T9koewKU8KPV17QKGw15nh7K9InTH0ZOi3spbWVRA9iPIkb55Lq/blModxPulAeCfxwdLXoUjozjuO82QhAohqGG24NOU6apxVkFbZWXnMpTqRhJNIdnH9sUwgjZZSJhe1Bj3e/V3o3td2RHNjgllTiT/iEkyQgANuhQaAyuoxYVjZQrycbvR+Qpfp/rxWX6YopVgF/nkoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYE+Qa4s05eBcvQbiBA+K7RM9BcFzCqtUpxWkv+Wuz0=;
 b=NBZ/rZc50bPxeM2Ad2WNn3vgeWbNOZMTusQk6yBshGoLcYihq0il1Aj68ASAXuDOwa6RTjK6deaYasxj/NKo9ha+LASQ+1AB9CEHHuCMFCf9jIHp8xbpsSfzFbK0xOMmmBhwYu3t+ls2ZavYM2aehSYBKJGItDegwysPUdESClNFSu3RNAQw7e/Q1B/USrDnjNNb8rJfuoadfZXF+/F5pAH2HCyrjOcyEr7ijrZnUXtIb9vDCKCHq+az+Vn41enP+Hmihbg7c1ltTQ2ChPuuy3EEJUkYc+Pz7rIrklOrf+agTByuzeCVmBEA+WIN5pFbSgyLkERTr6QVoxgwd7R7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYE+Qa4s05eBcvQbiBA+K7RM9BcFzCqtUpxWkv+Wuz0=;
 b=QS/xCua9CUysaBta4aFh9EddJwKngic2RxanOd9TlXUOnLyDGOOcFpFNqSqyqnB4ljTVWgJ2w4p45p9EWGJOoHDR9xMtEEBRVgR5D7bXZoOYfFEa2UQlzIQPu2Qm3qwFj9ClIJjnbwaXowgL0nxb7Hk1pEcGzpdRLDfC8qsv/94=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 17:30:31 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9365:edd0:6096:4ffc]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9365:edd0:6096:4ffc%6]) with mapi id 15.20.6222.030; Mon, 27 Mar 2023
 17:30:31 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix error do not initialise globals to 0
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix error do not initialise globals to 0
Thread-Index: AQHZYNBjkVwAOd/100ug6sNCIv03Y68O4b8AgAAAHwA=
Date: Mon, 27 Mar 2023 17:30:31 +0000
Message-ID: <MN2PR12MB4128D5F74FDFDAF467BD3B17908B9@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20230327171953.1910597-1-srinivasan.shanmugam@amd.com>
 <0311dded-20e1-7430-b3ce-41bb55e43ba7@amd.com>
In-Reply-To: <0311dded-20e1-7430-b3ce-41bb55e43ba7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-27T17:30:28Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ae14f7c9-173c-469b-ad1b-9c21e8a1930d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|PH8PR12MB6721:EE_
x-ms-office365-filtering-correlation-id: 66c008d9-fa31-4575-ec6d-08db2ee8f6ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gr08y5Q87zs5DF4Ao2XAdO72XYfAmT1ZIIFYgzwQj6R+KBYWuqnO1kjQyHBEyNOil674ysYFyfClLxqjaDx2eavLTeCBiO90UzKJwBH5bFrz8MDLQzNXzMlRa45CTHZvTnZT6Cg9lb5cQNn67BTjFR95TCbDrbdV9/8e/Dt4k4ahHagpJBtsjLvveH5c9O+rHJeCAwrjWVCeL3j2XrvcOEPSdslzhwop/1g0Z8AUS569SI84xyYIxS9UvwLeaqj8w7kfG3ifFJJOOMUZUNXlg1SAkKg4qH51cBvzdd5ZwN0iLcLGB6CoCg3BPfB1KewDAdJveCmhU33hQrNyQYhG+lUg8lQGFjc+QkwcF4rNqWjFi6DeTX63MCtVgLXol49p1rjvhbOUmhZs65qDJfvv6gFqtLO34U8CTD0FwFs90MhBBVYOr7nczvu1nUwd6VMiEJeH7GBK2geuZ12c6BN2qIyfC1aV1rahEcuhxFhdHQtv9QBbiFhjzFUzMQYGBzEBqd5da1Bhampq7Ix5srBoiUUgC+/7TCMWXbP3GGMCBnpwjJaYSSy36ftv6KSX2y3V081OSW69s3SjsNYJlLpBWZOOf2gw1E2X5YE9sLdVLdcs2gemjqjzEY9YclzaQrwZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199021)(122000001)(7696005)(71200400001)(8936002)(52536014)(5660300002)(9686003)(186003)(6506007)(26005)(55016003)(53546011)(2906002)(66574015)(86362001)(33656002)(83380400001)(38070700005)(4326008)(6636002)(64756008)(8676002)(66446008)(66476007)(66556008)(66946007)(41300700001)(76116006)(478600001)(38100700002)(110136005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDZHZ2ZKZ2x2TXdNZGVhVDltcHlyS2Z4SU5wTDMzS3dUdUlHd1EvMEJBS056?=
 =?utf-8?B?YTJIVkFkbDFQL3RZMFZ6bnhDc1ExOERhek1DRFhKeFVUMkJtckI5dXgxaDU0?=
 =?utf-8?B?MjllM3FzOVJYeUFPZ2FSSlNqQ3liWHI4RktIVTk2bjFlSVlwOHY1aHFGUDNm?=
 =?utf-8?B?TEdINEYrTEI1KysxYytKU25EaDNJMVNDcnZ0UjB2M2dRQUFOeFRwelFwaTlH?=
 =?utf-8?B?bzk2aEQvTlZJN01YS1ZrVGUyWDdlS3V2OG4vOFRzYVZIVytKbTBBazZxTER0?=
 =?utf-8?B?dFYwQ0FWR3k2dWJWWm0vUjV1bThRVS9nRzc1NHlYbWxZbC8vWWZ6YzZpOE9r?=
 =?utf-8?B?WDZHZG0wUm1QUFoxZUgxQWxxMlNMbDVYRHBYSkQ0VUVpa2hOUVFrZ2k1SlNJ?=
 =?utf-8?B?QVZsUit4SzFKNXAvM2tlbyt1T09pWGFjZ09JR3k5MnRhTHRVYURCZWs1T0pL?=
 =?utf-8?B?NW9DUEdIdW5rUS9NL3g3cnRoNW4xVys0bkxMSG43OU5NVk8rV0czOW9hOXlR?=
 =?utf-8?B?OHZoM2NCbzBTMnRrY2FnOVE5T1p6U0lKTTh3QndvK2RSSU9hRUltdk9va29E?=
 =?utf-8?B?V0V5eXFYaHdZSFBQOWVSSEhZckFkVUhtTGVobEQ4amRqNzNPOG9PdnlwOVpV?=
 =?utf-8?B?TFlXNkU1Mml1SlUwanF6ODdiMSs1Y204TDVpcDBJblFPUENHMDk5RHVNUEhl?=
 =?utf-8?B?bTBmVHJrb0tldm51S1RBS3FlN1RIUzRPMytMSnIvdFdGRDdVT1BNdEk2MzZL?=
 =?utf-8?B?MXU3bzdwb3BiQjBZaTVzRnRkem5kVldqcUdOb0RRU1h2RWJKUEp0RmYwMk5j?=
 =?utf-8?B?czc2eXE5ZVp0Q1lMVlpIdGRQa2NpUmlMVVJTWCtyVkQwVGxrYzFhWW45SzJV?=
 =?utf-8?B?cHFvWlQ4K1RTR1JQaVhIY2hsTFVFUU90aktCaWliYURSWUoxRXFvQ0x4UzlH?=
 =?utf-8?B?Q0ZPQkFHT1ZJRnVNODlDMjRycnplblY1TE8rR2h0eC85em1oMzI3WjdpQ0pI?=
 =?utf-8?B?Z0NXNmZTNlo4Um1WRWsxd0prUUNwSi9SalNJRUpxcVdWUmlqNGxqaVIxN1pL?=
 =?utf-8?B?VW9sY2lod0FacUo2cWZzc2xIMkdRQXVnMCs1TzdBbE9wM1ZWWWxzK1U0ZVUw?=
 =?utf-8?B?aGxUNzI2MEpKcFM0dlNDOGpOdkFWM3ljOSthSXk4MlhVSHJlSlRqV0JIaXhj?=
 =?utf-8?B?K0xHeFZkWitJSDVIYjVWWGhZWmgvMnlTZlVId3ZBWWp2RmhxdlkwbTVYczFs?=
 =?utf-8?B?NDE3d1k2QXpZRVFnWHozUU8wd3FQanpBWWRISVVnNUpnMUs3ZTFRTG1CYnli?=
 =?utf-8?B?NW5hdUY0V3BIUC80MjdWT3ViMGV5bXp5VTB0SXpxajVDL0pHL1lBcmxTMy9U?=
 =?utf-8?B?dENFZUNObU5qRm5KaGduenJzWW5rcEw5YkpQaUY1Q1NuYndJRmVuemJ3UzhM?=
 =?utf-8?B?c3VJN2hDSytmMXQ0WnpTc1oxc2plKzZnSlJHdFJpQXN2dlBUZXh3VS9QZzdF?=
 =?utf-8?B?SzlUeXNpeHpFcCtOVUdxMFhCdVZkNnQvS0s3RDF0bDlleFp2WGlNbTQ1WS83?=
 =?utf-8?B?bGFiVUxKWGViZXE5OFVUM2V0QUVTdERmamQ1cUh6dzBPMENsWkRKQmFzZisv?=
 =?utf-8?B?ODJxRWRlemRSVktVaHQ2Vk5adlZzSmIwbloxRzk5SVE0ZFhhdGpyL21xOUhM?=
 =?utf-8?B?UHRGWXNIVVdaVW1VRlFuek9Pc0xRWHNPV01WbzVUaXhUZDRyeHNkeTRUbTJI?=
 =?utf-8?B?S0ZiYTl4NndsQ0hRVG15Y2xZbVc0QWxZaERkZWdLSUhUNFdJMFM4VEtxYVVj?=
 =?utf-8?B?RGxUTStSaHVncFE0aXdxZ080WDYwTUdJUEFvNElER2ZUZ3lsczQxZTBCRDl0?=
 =?utf-8?B?QlcwLzJvWTUwM0Q1VVczbXVEMUVGUFRRKzhTOVVkZGVhMUN0VDJqUG10em9p?=
 =?utf-8?B?T3RpSmZHSzJxRUNKMzg5TC9HZW9QZVdraXJwNGxYM3VsTUhEcUxRVnhTSk1G?=
 =?utf-8?B?M2p5ZVo3c2N6eTVSVisyVXpzbW9qVUtlZHgvOURIU1ZlaVJwWTVCcG83U3Q3?=
 =?utf-8?B?TFBrWU1KZzJ4RXVVZWh5alRyZGt5a1ZRZkhJeFpPUlU0b09Sc2xiNzRQOTJv?=
 =?utf-8?Q?j1+g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c008d9-fa31-4575-ec6d-08db2ee8f6ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 17:30:31.2922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I3/j4KK4yHoYZ9eniZerLEANDocdm/Krs4u0t6/wGiJGaiHsS6CmRtPogd1h3q9ulv86DHaEWsvv5/ZlqZrPWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcyBhIGxvdCEgSGFtemEg
TWFoZm9veiBmb3IgcmV2aWV3aW5nIQ0KDQpCZXN0IFdpc2hlcywNClNyaW5pDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNYWhmb296LCBIYW16YSA8SGFtemEuTWFoZm9vekBh
bWQuY29tPiANClNlbnQ6IE1vbmRheSwgTWFyY2ggMjcsIDIwMjMgMTE6MDAgUE0NClRvOiBTSEFO
TVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+OyBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVy
IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5M
aW1vbmNpZWxsb0BhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpT
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL2FtZGdwdTogRml4IGVycm9yIGRvIG5vdCBpbml0
aWFsaXNlIGdsb2JhbHMgdG8gMA0KDQpPbiAzLzI3LzIzIDEzOjE5LCBTcmluaXZhc2FuIFNoYW5t
dWdhbSB3cm90ZToNCj4gR2xvYmFsIHZhcmlhYmxlcyBkbyBub3QgbmVlZCB0byBiZSBpbml0aWFs
aXplZCB0byAwIGFuZCBjaGVja3BhdGNoIA0KPiBmbGFncyB0aGlzIGVycm9yIGluIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYzoNCj4gDQo+IEVSUk9SOiBkbyBub3QgaW5p
dGlhbGlzZSBnbG9iYWxzIHRvIDANCj4gK2ludCBhbWRncHVfbm9fcXVldWVfZXZpY3Rpb25fb25f
dm1fZmF1bHQgPSAwOw0KPiANCj4gRml4IHRoaXMgY2hlY2twYXRjaCBlcnJvci4NCj4gDQo+IENj
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IENjOiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IENjOiBNYXJpbyBMaW1vbmNp
ZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2
YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQoNClJldmlld2Vk
LWJ5OiBIYW16YSBNYWhmb296IDxIYW16YS5NYWhmb296QGFtZC5jb20+DQoNCj4gLS0tDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgMiArLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyANCj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gaW5kZXggOTE3OTI2YzhkYzVmNS4u
NjdkYmFjODcyMDJlNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
cnYuYw0KPiBAQCAtODIzLDcgKzgyMyw3IEBAIE1PRFVMRV9QQVJNX0RFU0Mobm9fc3lzdGVtX21l
bV9saW1pdCwgImRpc2FibGUgc3lzdGVtIG1lbW9yeSBsaW1pdCAoZmFsc2UgPSBkZWZhDQo+ICAg
ICogRE9DOiBub19xdWV1ZV9ldmljdGlvbl9vbl92bV9mYXVsdCAoaW50KQ0KPiAgICAqIElmIHNl
dCwgcHJvY2VzcyBxdWV1ZXMgd2lsbCBub3QgYmUgZXZpY3RlZCBvbiBncHV2bSBmYXVsdC4gVGhp
cyBpcyB0byBrZWVwIHRoZSB3YXZlZnJvbnQgY29udGV4dCBmb3IgZGVidWdnaW5nICgwID0gcXVl
dWUgZXZpY3Rpb24sIDEgPSBubyBxdWV1ZSBldmljdGlvbikuIFRoZSBkZWZhdWx0IGlzIDAgKHF1
ZXVlIGV2aWN0aW9uKS4NCj4gICAgKi8NCj4gLWludCBhbWRncHVfbm9fcXVldWVfZXZpY3Rpb25f
b25fdm1fZmF1bHQgPSAwOw0KPiAraW50IGFtZGdwdV9ub19xdWV1ZV9ldmljdGlvbl9vbl92bV9m
YXVsdDsNCj4gICBNT0RVTEVfUEFSTV9ERVNDKG5vX3F1ZXVlX2V2aWN0aW9uX29uX3ZtX2ZhdWx0
LCAiTm8gcXVldWUgZXZpY3Rpb24gb24gVk0gZmF1bHQgKDAgPSBxdWV1ZSBldmljdGlvbiwgMSA9
IG5vIHF1ZXVlIGV2aWN0aW9uKSIpOw0KPiAgIG1vZHVsZV9wYXJhbV9uYW1lZChub19xdWV1ZV9l
dmljdGlvbl9vbl92bV9mYXVsdCwgYW1kZ3B1X25vX3F1ZXVlX2V2aWN0aW9uX29uX3ZtX2ZhdWx0
LCBpbnQsIDA0NDQpOw0KPiAgICNlbmRpZg0KDQotLQ0KSGFtemENCg==
